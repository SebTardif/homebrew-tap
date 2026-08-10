class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive with gh-compatible caching"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.9.1"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.1/gitcrawl_0.9.1_darwin_arm64.tar.gz"
      sha256 "c38722dc766cfb9decb9444fc0e3870e5384553b687aa8f6025aab0e9d76ac6b"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.1/gitcrawl_0.9.1_darwin_amd64.tar.gz"
      sha256 "cb6b9e8cbf97553e7e6a633d8bc3cb42b7f3bad468e2f82fc34ba36ecae0e127"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.1/gitcrawl_0.9.1_linux_arm64.tar.gz"
      sha256 "46749f4e7bfe310f2acd81a82f93828dc392f2b71ff5e7e4d63368125cec6767"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.1/gitcrawl_0.9.1_linux_amd64.tar.gz"
      sha256 "827b5a662fc342da594010ec6a2afb743d5d0a1c486769499b68d64cef6a875d"
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
