class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive with gh-compatible caching"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.8.6"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "c83fb9735430491a7a2d88ee655bbfb548e9fdb89e9d3801910bd857c42c21ae"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "a246d30b2a197a757b49af42e9acbc7b30863d622941581e9c88324538eef9ad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_linux_arm64.tar.gz"
      sha256 "ea9c49e624b4e0978f115ee0446f7e758c20073ae6e941336caf42f40a8d5bef"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_linux_amd64.tar.gz"
      sha256 "8c07f721c54fd7a4a45d902ef534cd70fb3b92d345341737db8d6a31c52d9d7a"
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
