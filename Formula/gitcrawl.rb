class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive with gh-compatible caching"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.8.5"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "992e0d3a110353654deb7589b6602433f585018dfbc6eca23f81d66450ae41f4"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "55ae4f877bb69ec915adbbd46f9399c2ce695a709fabaa6a1468c772c29161f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_linux_arm64.tar.gz"
      sha256 "f229ce34bb7fec5f73f3ce12f1415380792b0626c9329bb3d3721b41e2698df1"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v#{version}/gitcrawl_#{version}_linux_amd64.tar.gz"
      sha256 "8c3ee8c0585c48b140ba300701667746966b46ebfcf9e8ada3b5b8713869db53"
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
