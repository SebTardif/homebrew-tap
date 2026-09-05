class Notcrawl < Formula
  desc "Local-first Notion crawler into SQLite and normalized Markdown"
  homepage "https://github.com/openclaw/notcrawl"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.9/notcrawl_0.5.9_darwin_arm64.tar.gz"
      sha256 "4e487b632745a7d81b4a1d95cc53395db5a6a4444cea0b23db5d306e09f9489d"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.9/notcrawl_0.5.9_darwin_amd64.tar.gz"
      sha256 "fd2f994a3a4c0e7b96d5a82f063d53b1cb30a9f21ac6e6e2eee8f4801542e03a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.9/notcrawl_0.5.9_linux_arm64.tar.gz"
      sha256 "f9b598e1e3d1e3f9c5dafd31503460b7be59c2d23263660cb2ddcf9f5d7dfc60"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.9/notcrawl_0.5.9_linux_amd64.tar.gz"
      sha256 "bde7dab248349e88b00f813cf886037ff013a79c2413d82eb5d8fb9f6300efa8"
    end
  end

  def install
    bin.install "notcrawl"
  end

  test do
    assert_match "Usage of notcrawl:", shell_output("#{bin}/notcrawl --help")
  end
end
