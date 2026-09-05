class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/openclaw/wacrawl"
  version "0.3.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.10/wacrawl_0.3.10_darwin_arm64.tar.gz"
      sha256 "ae42f62c957efce5a1e0648c796824ee3830df6116a96c3fe6913cfa56616cf5"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.10/wacrawl_0.3.10_darwin_amd64.tar.gz"
      sha256 "f8e6f2c55bbcf1fd7bb46c82b55c52bcb2cc7d4b7c53b0ad25174b2258be0c94"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.10/wacrawl_0.3.10_linux_arm64.tar.gz"
      sha256 "28586a943f59ebbcf6eead4bfb64cd5492ccb89f6c0a9af40a93335d19dc5255"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.10/wacrawl_0.3.10_linux_amd64.tar.gz"
      sha256 "6edc38856276404cc8dcc47def5a3c2950b25d1ef9267eaf5903714ec07b75cd"
    end
  end

  def install
    bin.install "wacrawl"
  end

  def caveats
    <<~EOS
      wacrawl reads WhatsApp Desktop data from:
        ~/Library/Group Containers/group.net.whatsapp.WhatsApp.shared

      It writes its archive to:
        ~/.wacrawl/wacrawl.db

      Quick start:
        wacrawl doctor
        wacrawl import
        wacrawl status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wacrawl --version")
  end
end
