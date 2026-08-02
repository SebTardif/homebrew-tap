class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/openclaw/wacrawl"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.5/wacrawl_0.3.5_darwin_arm64.tar.gz"
      sha256 "d251d92e86a0ce1b42620b82f940dad9f6aa8eac0a7ce00da17963705a3f4554"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.5/wacrawl_0.3.5_darwin_amd64.tar.gz"
      sha256 "3460431c6d4d34ab9c413e2c6177f12ad3ff5bd3f33249f215093f16516053af"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.5/wacrawl_0.3.5_linux_arm64.tar.gz"
      sha256 "f53204d8322c525d0a07bacb1b450b1cbe8899a0f05da969a8399667fbb89484"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.5/wacrawl_0.3.5_linux_amd64.tar.gz"
      sha256 "4ca8823c40497029ac57c69d81291948fdcc72ba44e41576c7f35870f206c7ac"
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
