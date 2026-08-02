class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive with gh-compatible caching"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.8.8"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.8.8/gitcrawl_0.8.8_darwin_arm64.tar.gz"
      sha256 "638dc7a533a7cffafa1b714fc597c71e226e1ea62bb19ac0f4492c5d68d238c5"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.8.8/gitcrawl_0.8.8_darwin_amd64.tar.gz"
      sha256 "d5a66b5bffb6e0668c4c418906ed005a927d859f6293cde11926a28dccd01c4a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.8.8/gitcrawl_0.8.8_linux_arm64.tar.gz"
      sha256 "f9c53b6fedcfef250f5d7ebb80788928b9882c0f1fab2281ec68dfcd68bca964"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.8.8/gitcrawl_0.8.8_linux_amd64.tar.gz"
      sha256 "f8b4b5ccbceafef771d1d3fe29259f99dea29ab5e4fddcc0b4589cbc2728566a"
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
