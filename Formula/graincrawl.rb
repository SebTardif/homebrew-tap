class Graincrawl < Formula
  desc "Local-first Granola crawler into SQLite and Markdown"
  homepage "https://github.com/openclaw/graincrawl"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.1/graincrawl_0.4.1_darwin_arm64.tar.gz"
      sha256 "919434076c227ca0713b63f03ed418b6b3d39fc9d061cdb53ab336ccaf058ce3"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.1/graincrawl_0.4.1_darwin_amd64.tar.gz"
      sha256 "a3d25b555d05c1001eb3ddc3dca0d204347ccbbc2f0d67d5d41f7d06b9274f3d"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.1/graincrawl_0.4.1_linux_arm64.tar.gz"
      sha256 "ff61604bedf779a5860a5ad9d69d14832c946420e04bf26361229f80a1986fc5"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.1/graincrawl_0.4.1_linux_amd64.tar.gz"
      sha256 "4eccb7a003e7486600051ab24dd5f561efa4fd11b518315c4aa52e6971512309"
    end
  end

  def install
    bin.install "graincrawl"
  end

  test do
    assert_match "\"version\"", shell_output("#{bin}/graincrawl --json version")
  end
end
