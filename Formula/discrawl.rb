class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.13.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.2/discrawl_0.13.2_darwin_arm64.tar.gz"
      sha256 "6d4036071c033b720f4f179305c1206ef71f02558dcaf3f143ebb0930dcd92f1"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.2/discrawl_0.13.2_darwin_amd64.tar.gz"
      sha256 "dda708e8346aefeaf7a12433ed840a314c279d9cd96f2ec14bf27e37bd36423b"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.2/discrawl_0.13.2_linux_arm64.tar.gz"
      sha256 "2edeb66edd9672b9789d7228b5b3a313a10bdcffdd9f8ce4c128f2a28116f062"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.2/discrawl_0.13.2_linux_amd64.tar.gz"
      sha256 "f1b2d896c7c45dd694b8d8e3ff348d57e6586c4029332c782fa63e98846c4149"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
