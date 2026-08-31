class Telecrawl < Formula
  desc "Telegram Desktop archive CLI with encrypted Git backups"
  homepage "https://github.com/openclaw/telecrawl"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.6/telecrawl_0.3.6_darwin_arm64.tar.gz"
      sha256 "8302baca930c1e61bcd00dc42e75f31ec555f780424ee8352bdc3a39f4aa9571"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.6/telecrawl_0.3.6_darwin_amd64.tar.gz"
      sha256 "353c735e6bdc4f65c94158a4b459e4de0d8f7dbc47a229740e43825ba1828c75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.6/telecrawl_0.3.6_linux_arm64.tar.gz"
      sha256 "459e3f250c4c7d7637e6d451c5fa229904929bc16b0cce44ce2baa55a4a5f8ab"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v0.3.6/telecrawl_0.3.6_linux_amd64.tar.gz"
      sha256 "80e418c093759e9c2a2b7c0bb2e68a83814b9cfe6c5780299d35e3ee0512e839"
    end
  end

  def install
    bin.install "telecrawl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/telecrawl --version")
  end
end
