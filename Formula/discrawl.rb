class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.13.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.3/discrawl_0.13.3_darwin_arm64.tar.gz"
      sha256 "664028f5f3489fe70186fdc1d99d2956df69ea754d4a1f14acc4057c04c165a1"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.3/discrawl_0.13.3_darwin_amd64.tar.gz"
      sha256 "da2c0e68fd2df4bf07c7e496be9984ed2ff651faa966e2a94fe421517c90bf94"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.3/discrawl_0.13.3_linux_arm64.tar.gz"
      sha256 "5985937f6b31b95ec4bd06b9e81d9d5dbda21707273b5016a6be89783418647f"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.3/discrawl_0.13.3_linux_amd64.tar.gz"
      sha256 "d9ba53c3137b0247d221519708bc70f23c64f74b2512665b27ab0c3e714642c1"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
