class Graincrawl < Formula
  desc "Local-first Granola crawler into SQLite and Markdown"
  homepage "https://github.com/openclaw/graincrawl"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.5/graincrawl_0.3.5_darwin_arm64.tar.gz"
      sha256 "01e72bc7b133a79f7c455beebed3778ec996bd43ba93e37327f7134f3a660f99"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.5/graincrawl_0.3.5_darwin_amd64.tar.gz"
      sha256 "8181cfd2382ec62672a9533a3d5fe6e587e817cdc0f7b2b5ef38e38c97b8b96e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.5/graincrawl_0.3.5_linux_arm64.tar.gz"
      sha256 "7324861b20ba77530953959556eb35af722e3bb5c317a5a11eefed4c516357cc"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.5/graincrawl_0.3.5_linux_amd64.tar.gz"
      sha256 "4167047be5aef88ba1cd4fd6ccf7dcfdca10d3cb7ec8a510aa7936ed8499c2a4"
    end
  end

  def install
    bin.install "graincrawl"
  end

  test do
    assert_match "\"version\"", shell_output("#{bin}/graincrawl --json version")
  end
end
