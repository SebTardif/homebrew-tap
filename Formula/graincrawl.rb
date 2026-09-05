class Graincrawl < Formula
  desc "Local-first Granola crawler into SQLite and Markdown"
  homepage "https://github.com/openclaw/graincrawl"
  version "0.4.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.2/graincrawl_0.4.2_darwin_arm64.tar.gz"
      sha256 "8d8c9f27bb858c5b7dff6282f5eb7991b0eaad8ed3546598782dd71a6ab37bbe"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.2/graincrawl_0.4.2_darwin_amd64.tar.gz"
      sha256 "e3dd09da346362d37893654f2d6f8a9d3615854ac210fc7c144d87b8b515290e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.2/graincrawl_0.4.2_linux_arm64.tar.gz"
      sha256 "caee9b6e54d3fd36cbf90007653ddec8d29ba34ee57b25e632f87d02c428db2c"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.4.2/graincrawl_0.4.2_linux_amd64.tar.gz"
      sha256 "79a81ddaaa282ca68e51a22d78a7b5e59fbbe5ec42d92dd7e80c03bc52784be9"
    end
  end

  def install
    bin.install "graincrawl"
  end

  test do
    assert_match "\"version\"", shell_output("#{bin}/graincrawl --json version")
  end
end
