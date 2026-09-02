from __future__ import annotations

import contextlib
import importlib.util
import io
import os
import pathlib
import sys
import tempfile
import unittest
from unittest import mock


ROOT = pathlib.Path(__file__).resolve().parents[1]
SCRIPT = ROOT / ".github" / "scripts" / "reconcile_formulae.py"
SPEC = importlib.util.spec_from_file_location("reconcile_formulae", SCRIPT)
assert SPEC and SPEC.loader
reconcile_formulae = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = reconcile_formulae
SPEC.loader.exec_module(reconcile_formulae)


def formula_text(version: str = "1.2.3") -> str:
    return f'''class Example < Formula
  desc "Example"
  homepage "https://github.com/openclaw/example"
  version "{version}"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/example/releases/download/v{version}/example_v{version}_darwin_arm64.tar.gz"
      sha256 "{'a' * 64}"
    else
      url "https://github.com/openclaw/example/releases/download/v{version}/example_v{version}_darwin_amd64.tar.gz"
      sha256 "{'b' * 64}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/example/releases/download/v{version}/example_v{version}_linux_arm64.tar.gz"
      sha256 "{'c' * 64}"
    else
      url "https://github.com/openclaw/example/releases/download/v{version}/example_v{version}_linux_amd64.tar.gz"
      sha256 "{'d' * 64}"
    end
  end
end
'''


class ReconcileFormulaeTest(unittest.TestCase):
    def make_tap(self, text: str = formula_text()) -> tuple[tempfile.TemporaryDirectory[str], pathlib.Path]:
        directory = tempfile.TemporaryDirectory()
        root = pathlib.Path(directory.name)
        (root / "Formula").mkdir()
        (root / "Formula" / "example.rb").write_text(text)
        return directory, root

    def test_semver_orders_prereleases_and_ignores_build_metadata(self) -> None:
        stable = reconcile_formulae.parse_semver("v1.2.3")
        prerelease = reconcile_formulae.parse_semver("1.2.3-rc.1")
        newer = reconcile_formulae.parse_semver("1.2.4+build.7")
        self.assertGreater(stable.compare(prerelease), 0)
        self.assertLess(stable.compare(newer), 0)
        self.assertEqual(stable.compare(reconcile_formulae.parse_semver("1.2.3+other")), 0)

    def test_parses_homepage_version_and_custom_artifact_template(self) -> None:
        directory, root = self.make_tap()
        self.addCleanup(directory.cleanup)
        info = reconcile_formulae.parse_formula(root / "Formula" / "example.rb")
        self.assertEqual(info.repository, "openclaw/example")
        self.assertEqual(info.current_tag, "v1.2.3")
        self.assertEqual(
            info.update_options,
            ("--artifact-template", "example_v{version}_{target}.tar.gz"),
        )

    def test_every_checked_in_formula_has_a_reconcilable_release_shape(self) -> None:
        formulae = sorted((ROOT / "Formula").glob("*.rb"))
        self.assertTrue(formulae)
        for path in formulae:
            with self.subTest(formula=path.stem):
                info = reconcile_formulae.parse_formula(path)
                self.assertEqual(info.name, path.stem)
                self.assertTrue(info.update_options)

    def test_crabbox_skips_before_parsing_or_lookup_in_all_scan_modes(self) -> None:
        for selected in (None, "crabbox"):
            for dry_run in (False, True):
                with self.subTest(selected=selected, dry_run=dry_run), tempfile.TemporaryDirectory() as directory:
                    root = pathlib.Path(directory)
                    (root / "Formula").mkdir()
                    path = root / "Formula" / "crabbox.rb"
                    path.write_text("not a parseable formula\n")
                    before = path.read_bytes()
                    output = io.StringIO()
                    with (
                        mock.patch.object(reconcile_formulae, "parse_formula") as parse,
                        mock.patch.object(reconcile_formulae.update_formula, "sha256") as download,
                        contextlib.redirect_stdout(output),
                    ):
                        lookup = mock.Mock()
                        updater = mock.Mock()
                        summary = reconcile_formulae.reconcile(root, selected, dry_run, lookup, updater)
                    self.assertEqual(summary, reconcile_formulae.Summary(scanned=1, skipped=1))
                    self.assertIn("SKIP crabbox:", output.getvalue())
                    self.assertIn("release-managed", output.getvalue())
                    self.assertIn("https://github.com/openclaw/crabbox/blob/main/docs/RELEASING.md", output.getvalue())
                    for operation in (parse, lookup, updater, download):
                        operation.assert_not_called()
                    self.assertEqual(path.read_bytes(), before)

    def test_crabbox_skip_still_updates_another_stale_formula(self) -> None:
        directory, root = self.make_tap()
        self.addCleanup(directory.cleanup)
        crabbox = root / "Formula" / "crabbox.rb"
        crabbox.write_bytes((ROOT / "Formula" / "crabbox.rb").read_bytes())
        before = crabbox.read_bytes()
        lookup = mock.Mock(return_value=reconcile_formulae.Release("v1.2.4", False, False))

        def updater(root: pathlib.Path, info: reconcile_formulae.FormulaInfo, tag: str, dry_run: bool) -> None:
            self.assertFalse(dry_run)
            previous_directory = pathlib.Path.cwd()
            os.chdir(root)
            try:
                reconcile_formulae.update_formula.main([
                    "--formula", info.name, "--tag", tag, "--repository", info.repository, *info.update_options,
                ])
            finally:
                os.chdir(previous_directory)

        with mock.patch.object(reconcile_formulae.update_formula, "sha256", return_value="e" * 64) as download:
            summary = reconcile_formulae.reconcile(root, None, False, lookup, updater)
        self.assertEqual(summary, reconcile_formulae.Summary(scanned=2, skipped=1, drift=1, updated=1))
        lookup.assert_called_once_with("openclaw/example")
        self.assertEqual(download.call_count, 4)
        updated = (root / "Formula" / "example.rb").read_text()
        self.assertIn('version "1.2.4"', updated)
        self.assertEqual(updated.count('sha256 "' + "e" * 64 + '"'), 4)
        self.assertEqual(crabbox.read_bytes(), before)

    def test_crabbox_symlink_alias_is_skipped_before_parsing(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            (root / "Formula").mkdir()
            (root / "Formula" / "crabbox.rb").write_text("not a parseable formula\n")
            (root / "Formula" / "example.rb").symlink_to("crabbox.rb")
            with mock.patch.object(reconcile_formulae, "parse_formula") as parse:
                lookup = mock.Mock()
                updater = mock.Mock()
                summary = reconcile_formulae.reconcile(root, "example", True, lookup, updater)
            self.assertEqual(summary, reconcile_formulae.Summary(scanned=1, skipped=1))
            for operation in (parse, lookup, updater):
                operation.assert_not_called()

    def test_no_drift_does_not_run_updater_or_change_formula(self) -> None:
        directory, root = self.make_tap()
        self.addCleanup(directory.cleanup)
        path = root / "Formula" / "example.rb"
        before = path.read_text()
        updates: list[str] = []
        summary = reconcile_formulae.reconcile(
            root,
            None,
            False,
            release_lookup=lambda _: reconcile_formulae.Release("v1.2.3", False, False),
            updater=lambda _root, _info, tag, _dry_run: updates.append(tag),
        )
        self.assertEqual(summary.current, 1)
        self.assertEqual(summary.drift, 0)
        self.assertEqual(updates, [])
        self.assertEqual(path.read_text(), before)

    def test_dry_run_detects_exactly_one_stale_formula(self) -> None:
        directory, root = self.make_tap()
        self.addCleanup(directory.cleanup)
        second = formula_text().replace("Example", "Current").replace(
            "openclaw/example", "openclaw/current"
        ).replace("example", "current")
        (root / "Formula" / "current.rb").write_text(second)
        updates: list[tuple[str, str, bool]] = []

        def latest(repository: str) -> reconcile_formulae.Release:
            tag = "v1.2.4" if repository == "openclaw/example" else "v1.2.3"
            return reconcile_formulae.Release(tag, False, False)

        summary = reconcile_formulae.reconcile(
            root,
            None,
            True,
            release_lookup=latest,
            updater=lambda _root, info, tag, dry_run: updates.append((info.name, tag, dry_run)),
        )
        self.assertEqual(summary.scanned, 2)
        self.assertEqual(summary.drift, 1)
        self.assertEqual(summary.updated, 1)
        self.assertEqual(updates, [("example", "v1.2.4", True)])

    def test_refuses_downgrade(self) -> None:
        directory, root = self.make_tap()
        self.addCleanup(directory.cleanup)
        updates: list[str] = []
        summary = reconcile_formulae.reconcile(
            root,
            None,
            False,
            release_lookup=lambda _: reconcile_formulae.Release("v1.2.2", False, False),
            updater=lambda _root, _info, tag, _dry_run: updates.append(tag),
        )
        self.assertEqual(summary.refused, 1)
        self.assertEqual(summary.drift, 0)
        self.assertEqual(updates, [])

    def test_skips_prerelease_even_if_release_flag_is_wrong(self) -> None:
        directory, root = self.make_tap()
        self.addCleanup(directory.cleanup)
        updates: list[str] = []
        summary = reconcile_formulae.reconcile(
            root,
            None,
            False,
            release_lookup=lambda _: reconcile_formulae.Release("v1.2.4-rc.1", False, False),
            updater=lambda _root, _info, tag, _dry_run: updates.append(tag),
        )
        self.assertEqual(summary.skipped, 1)
        self.assertEqual(updates, [])

    def test_unparseable_formula_does_not_block_later_formulae(self) -> None:
        directory, root = self.make_tap("class Broken < Formula\nend\n")
        self.addCleanup(directory.cleanup)
        (root / "Formula" / "working.rb").write_text(
            formula_text().replace("Example", "Working").replace(
                "openclaw/example", "openclaw/working"
            ).replace("example", "working")
        )
        summary = reconcile_formulae.reconcile(
            root,
            None,
            False,
            release_lookup=lambda _: reconcile_formulae.Release("v1.2.3", False, False),
        )
        self.assertEqual(summary.scanned, 2)
        self.assertEqual(summary.skipped, 1)
        self.assertEqual(summary.current, 1)


if __name__ == "__main__":
    unittest.main()
