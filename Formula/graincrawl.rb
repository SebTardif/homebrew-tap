class Graincrawl < Formula
  desc "Local-first Granola crawler into SQLite and Markdown"
  homepage "https://github.com/openclaw/graincrawl"
  version "0.3.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.7/graincrawl_0.3.7_darwin_arm64.tar.gz"
      sha256 "885663cefaa656a61e14912f80b396315467ba20f006974c525ed8b3a8617321"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.7/graincrawl_0.3.7_darwin_amd64.tar.gz"
      sha256 "1cafd2baa81a9daa293dfab26e492ccae02fa00e1ced6d7bc7eddfd898fba6b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.7/graincrawl_0.3.7_linux_arm64.tar.gz"
      sha256 "d0e8409b1a200a16472df6f1263df8a97ffb9accd8ba281d4590845ac27434e0"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.7/graincrawl_0.3.7_linux_amd64.tar.gz"
      sha256 "63d490109583908839f9e4aa01f05e97c3895b0b2d37c08d14e9679bb2ff9445"
    end
  end

  def install
    bin.install "graincrawl"
  end

  test do
    assert_match "\"version\"", shell_output("#{bin}/graincrawl --json version")
  end
end
