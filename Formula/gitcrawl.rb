class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive with gh-compatible caching"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.9.0"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.0/gitcrawl_0.9.0_darwin_arm64.tar.gz"
      sha256 "fa8085c37dc593ffd855cb3a38e6ee3a461e524c85008d04e5c4d1907245a71e"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.0/gitcrawl_0.9.0_darwin_amd64.tar.gz"
      sha256 "3a3e6c77f78c3eedda67c406e39081910a99ae443e6eb0ebbe8b1e7e022a6738"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.0/gitcrawl_0.9.0_linux_arm64.tar.gz"
      sha256 "89ea29b172d8773c19c7a0e5a856665980efe3904453b6cc1a468a1beb5390cd"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.0/gitcrawl_0.9.0_linux_amd64.tar.gz"
      sha256 "bddf00cbb1f543b64a23f4e34bb8c8b26ca8856c6e5355d9ac9f53ae26518701"
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
      gitcrawl stores local state under:
        ~/.config/gitcrawl/
        ~/.cache/gitcrawl/

      To use the GitHub CLI shim, symlink the same binary as gitcrawl-gh or gh
      and set GITCRAWL_GH_PATH to the real GitHub CLI.
    EOS
  end

  test do
    assert_match build.head? ? "HEAD" : version.to_s, shell_output("#{bin}/gitcrawl --version")
  end
end
