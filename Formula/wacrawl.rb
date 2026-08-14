class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/openclaw/wacrawl"
  version "0.3.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.8/wacrawl_0.3.8_darwin_arm64.tar.gz"
      sha256 "0cd683729da77778bbffd5fa47d6d1d1f7edf1fd6472e718eb264e69171f4c9a"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.8/wacrawl_0.3.8_darwin_amd64.tar.gz"
      sha256 "0aa7c6a1053322c0c4b8f81cf55ee4c36cb0ef01080eaff47080fe54e40fefd0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.8/wacrawl_0.3.8_linux_arm64.tar.gz"
      sha256 "208ac866b73fb8cae1f82670981bc43b893dcabd9847a7c1b85a2a597f1c3394"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.8/wacrawl_0.3.8_linux_amd64.tar.gz"
      sha256 "8000c305f6ec7c7fe1646057ed0ec6591f567ebc49f38a9246b3df4412dc9070"
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
