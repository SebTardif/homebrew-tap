class Graincrawl < Formula
  desc "Local-first Granola crawler into SQLite and Markdown"
  homepage "https://github.com/openclaw/graincrawl"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.0/graincrawl_0.4.0_darwin_arm64.tar.gz"
      sha256 "9e687dfeee2fc09b0588ef2e356f4df72c512099d2c02051d86088f7595be192"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.0/graincrawl_0.4.0_darwin_amd64.tar.gz"
      sha256 "49d64c721e099fd49a8463804a149fdfb77f8130d54bb6d16d00b132a548ac77"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.0/graincrawl_0.4.0_linux_arm64.tar.gz"
      sha256 "d78ed4a363b3cef918051eb813ace07862bb92e4673a7a0ce19217d2919c4969"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.0/graincrawl_0.4.0_linux_amd64.tar.gz"
      sha256 "e7f0d469684dd2d60de0bab9a07827e6885aa92c8e5db0724d11067676394e9f"
    end
  end

  def install
    bin.install "graincrawl"
  end

  test do
    assert_match "\"version\"", shell_output("#{bin}/graincrawl --json version")
  end
end
