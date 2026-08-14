class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive with gh-compatible caching"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.9.2"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.2/gitcrawl_0.9.2_darwin_arm64.tar.gz"
      sha256 "87e96dc65f93fcdc79f6617a4cb044cc6882e41a72a2ba85031656bcaebfcd7a"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.2/gitcrawl_0.9.2_darwin_amd64.tar.gz"
      sha256 "9933d660ebd959818c0365fd5ef9fb107d32b9687f2b6eaf024fcfeaa7d7fcaa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.2/gitcrawl_0.9.2_linux_arm64.tar.gz"
      sha256 "48a3ca7f797097b1ff571317dc034c6c54cb78c795c9fd5d42e9e9d4673ef412"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.2/gitcrawl_0.9.2_linux_amd64.tar.gz"
      sha256 "afc39f657ccefe71966221d0c2ce1e82d07eabc7ec8b8f83c713a651a7b25bc0"
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
