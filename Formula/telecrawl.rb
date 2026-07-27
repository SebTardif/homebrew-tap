class Telecrawl < Formula
  desc "Telegram Desktop archive CLI with encrypted Git backups"
  homepage "https://github.com/openclaw/telecrawl"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.5/telecrawl_0.3.5_darwin_arm64.tar.gz"
      sha256 "9df8e6f2c114e8a8322affc6552d9385e1ed64db74573cc82d40cb21ac06fec3"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.5/telecrawl_0.3.5_darwin_amd64.tar.gz"
      sha256 "3b2660c495d46ceab6eefcace8d62b7bbf4825bfa5a766e41544691a150242c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.5/telecrawl_0.3.5_linux_arm64.tar.gz"
      sha256 "0557ef71514f0eb46af0a607e7915d92e3655b893c1a2f1ce4f69a1844940567"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.5/telecrawl_0.3.5_linux_amd64.tar.gz"
      sha256 "0dbb4315b4a39ad9a54f81ef7c367823eb7de06c93fc0bbf0d2777e030a46b09"
    end
  end

  def install
    bin.install "telecrawl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/telecrawl --version")
  end
end
