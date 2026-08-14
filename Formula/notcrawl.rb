class Notcrawl < Formula
  desc "Local-first Notion crawler into SQLite and normalized Markdown"
  homepage "https://github.com/openclaw/notcrawl"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.8/notcrawl_0.5.8_darwin_arm64.tar.gz"
      sha256 "8e30570c9d2f0bcb83222158486304cc51120d16b45d7aa4efc2e67f9d76e9e5"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.8/notcrawl_0.5.8_darwin_amd64.tar.gz"
      sha256 "b74dd2d61c8c7bdb2d670c4a5e8cdc0a9dbf8dbb8d98d34c63aa7c8c281603f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.8/notcrawl_0.5.8_linux_arm64.tar.gz"
      sha256 "a2b6a211eb7d93a656122fd341f45d85f32f739ce65681b43bbfdb4877eec142"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.8/notcrawl_0.5.8_linux_amd64.tar.gz"
      sha256 "1020ba0cd40e661a14bce1f299c753e27b8a6dfbd6eed8189b40c615b7cf61bd"
    end
  end

  def install
    bin.install "notcrawl"
  end

  test do
    assert_match "Usage of notcrawl:", shell_output("#{bin}/notcrawl --help")
  end
end
