class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive with gh-compatible caching"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.9.3"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_darwin_arm64.tar.gz"
      sha256 "dbb42bd49e87a421072fd70fc13835f53b1b8c5d966b7df538372a15557ad872"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_darwin_amd64.tar.gz"
      sha256 "34e47adb998497b55d1f6b4d22af64fc681ca562c6844ac1bc761029ca52d79b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_linux_arm64.tar.gz"
      sha256 "880fc9d9c3bda0b2927ed989a3b6184018de54bf9dd1bfce1d6f27a801f9b0af"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_linux_amd64.tar.gz"
      sha256 "0c015ecce56c5a31fb1aa39ffa9e99650954d1492e55c65daf4d87f59524c0d5"
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
