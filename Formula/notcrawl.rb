class Notcrawl < Formula
  desc "Local-first Notion crawler into SQLite and normalized Markdown"
  homepage "https://github.com/openclaw/notcrawl"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.7/notcrawl_0.5.7_darwin_arm64.tar.gz"
      sha256 "9deb79ccaf2ea6b59a7596b3061d014423f5835b5b191d56dceeaa9c63b9e78c"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.7/notcrawl_0.5.7_darwin_amd64.tar.gz"
      sha256 "9271b5f740d140662031e3c9c48077c62141413fa55ec836fa8f2a784d89d7a3"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.7/notcrawl_0.5.7_linux_arm64.tar.gz"
      sha256 "2185085961cd516c8e3673baa4ccc74eda77814f9fd8cf13d4bc7bd19aab7c5b"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.7/notcrawl_0.5.7_linux_amd64.tar.gz"
      sha256 "97291d91f1135c3768d94909c5c696e95ffe3fdf46681eecadd8d4d5319fc2be"
    end
  end

  def install
    bin.install "notcrawl"
  end

  test do
    assert_match "Usage of notcrawl:", shell_output("#{bin}/notcrawl --help")
  end
end
