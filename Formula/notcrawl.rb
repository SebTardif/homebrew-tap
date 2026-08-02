class Notcrawl < Formula
  desc "Local-first Notion crawler into SQLite and normalized Markdown"
  homepage "https://github.com/openclaw/notcrawl"
  version "0.5.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.6/notcrawl_0.5.6_darwin_arm64.tar.gz"
      sha256 "2cb8961ac5e3824eb51bfe431adc34d3239b8f8f0b566bf948362721819e871d"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.6/notcrawl_0.5.6_darwin_amd64.tar.gz"
      sha256 "667903001676f6ab80a634496a0b438ccde9a46a265eae115d3bb0263dc48075"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.6/notcrawl_0.5.6_linux_arm64.tar.gz"
      sha256 "d0fa035aa8c3cdfc9dfff8d4c6223a252e219886fa88f81399f426472005fac7"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.6/notcrawl_0.5.6_linux_amd64.tar.gz"
      sha256 "7604cd4a494091c2567651c7e3c0a0b1915840ed583af33ccd7b919c0e372995"
    end
  end

  def install
    bin.install "notcrawl"
  end

  test do
    assert_match "Usage of notcrawl:", shell_output("#{bin}/notcrawl --help")
  end
end
