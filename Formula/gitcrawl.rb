class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive, search, and clustering"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.9.4"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.4/gitcrawl_0.9.4_darwin_arm64.tar.gz"
      sha256 "bb7f08e4f68bc6a806e575e0caffff0baaa673306aa8e5c322068a693c316a00"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.4/gitcrawl_0.9.4_darwin_amd64.tar.gz"
      sha256 "bbdfa4d7d6b881ff1866d622f20b83afa82c28a9e34b09c2ebf6cdbb841451f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.4/gitcrawl_0.9.4_linux_arm64.tar.gz"
      sha256 "242ab8e06836d0a9ed541fec4e24b30276b9ff3a3824b6482b3a0b83f3bcf08b"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.4/gitcrawl_0.9.4_linux_amd64.tar.gz"
      sha256 "4e5b8593ef95b2f2d2e7d3998dd7308e8768c730f1faa8cf37833964b3a356c2"
    end
  end

  depends_on "go" => :build if build.head?

  def install
    if build.head?
      ldflags = "-s -w -X github.com/openclaw/gitcrawl/internal/cli.version=#{version}"
      system "go", "build", *std_go_args(output: bin/"gitcrawl", ldflags: ldflags), "./cmd/gitcrawl"
    else
      bin.install "gitcrawl"
    end
  end

  def caveats
    <<~EOS
      gitcrawl fresh defaults:
      macOS:
        ~/Library/Application Support/gitcrawl/ (config, database, vectors, logs)
        ~/Library/Caches/gitcrawl/ (cache)
      Linux:
        ${XDG_CONFIG_HOME:-~/.config}/gitcrawl/ (config)
        ${XDG_DATA_HOME:-~/.local/share}/gitcrawl/ (database, vectors)
        ${XDG_CACHE_HOME:-~/.cache}/gitcrawl/ (cache)
        ${XDG_STATE_HOME:-~/.local/state}/gitcrawl/ (logs)

      Absolute XDG overrides are honored on macOS too. Existing legacy paths
      may still be reused; explicit or configured paths can differ.
      See https://gitcrawl.sh/configuration/ for details.
      Run gitcrawl doctor --json for active config and database paths.

      Gitcrawl's gh compatibility shim has moved to Octopool.
      Keep your existing gh/Octopool setup; do not symlink Gitcrawl as gh.
      See https://gitcrawl.sh/gh-shim/ for migration details.
    EOS
  end

  test do
    assert_match build.head? ? "HEAD" : version.to_s, shell_output("#{bin}/gitcrawl --version")
  end
end
