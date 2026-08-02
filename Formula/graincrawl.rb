class Graincrawl < Formula
  desc "Local-first Granola crawler into SQLite and Markdown"
  homepage "https://github.com/openclaw/graincrawl"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.6/graincrawl_0.3.6_darwin_arm64.tar.gz"
      sha256 "53cf602478242bae8840de994d57166df5c2ca830688e6df76e8e094b0efc72c"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.6/graincrawl_0.3.6_darwin_amd64.tar.gz"
      sha256 "e929ab664d7700c07b0160735092625c90ed3fc7ca0fe971cdd009bc2002e67c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.6/graincrawl_0.3.6_linux_arm64.tar.gz"
      sha256 "255e93e0d8f2f8f41cc1fa7f84b6143f600739dcae2cf3a7278e69943aa2d0be"
    else
      url "https://github.com/openclaw/graincrawl/releases/download/v0.3.6/graincrawl_0.3.6_linux_amd64.tar.gz"
      sha256 "5d1cc9dfbca9f18887978b11578e2b8af2ec5bf339699a4d2bc278af88a7f24c"
    end
  end

  def install
    bin.install "graincrawl"
  end

  test do
    assert_match "\"version\"", shell_output("#{bin}/graincrawl --json version")
  end
end
