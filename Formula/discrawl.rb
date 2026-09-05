class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.13.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.4/discrawl_0.13.4_darwin_arm64.tar.gz"
      sha256 "abe076e1e48c899ea5ca8d5aac4c856fcc4f5425b0ca2479fb93522c44d55854"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.4/discrawl_0.13.4_darwin_amd64.tar.gz"
      sha256 "2b5a1563dbf572e2fdbce086a9f2d511108ad30c2838fa9ee402f61202d3c747"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.4/discrawl_0.13.4_linux_arm64.tar.gz"
      sha256 "635a80904fbb305bda4d7102cbbb5fafb9d3f1ef3abcb131d051b532f0d89cb8"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.4/discrawl_0.13.4_linux_amd64.tar.gz"
      sha256 "4fab2d6c4e014f09ebd09ad205359326b4b072e64b1924f8c32baff47ec35609"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
