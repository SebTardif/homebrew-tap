class Graincrawl < Formula
  desc "Local-first Granola crawler into SQLite and Markdown"
  homepage "https://github.com/openclaw/graincrawl"
  version "0.3.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.4/graincrawl_0.3.4_darwin_arm64.tar.gz"
      sha256 "e20c7712b2c1fcb2bc44ae7bcd2d2fe98bcca7cb12c178d98685008a36ab6efb"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.4/graincrawl_0.3.4_darwin_amd64.tar.gz"
      sha256 "e50801600a82f2a6601dc7c0b3add7f1992bf5a5ecad0dbae6f23138c8e7e191"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.4/graincrawl_0.3.4_linux_arm64.tar.gz"
      sha256 "a3633f9b221c598f1c7e629a3914298edb948ef1b66503ed80c34cc495252778"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.4/graincrawl_0.3.4_linux_amd64.tar.gz"
      sha256 "c5b8a653f95b881d59e3b817784f3d09f1d0451d359440b76dd8bfdb54e07d0c"
    end
  end

  def install
    bin.install "graincrawl"
  end

  test do
    assert_match "\"version\"", shell_output("#{bin}/graincrawl --json version")
  end
end
