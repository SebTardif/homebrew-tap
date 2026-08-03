class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/openclaw/wacrawl"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.6/wacrawl_0.3.6_darwin_arm64.tar.gz"
      sha256 "18a4fae19002d0f3010949f5937dbb90bfe3dcd6455f8ca67cc37d499d1f55bc"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.6/wacrawl_0.3.6_darwin_amd64.tar.gz"
      sha256 "206487a95e42e472cd08c04a59fce8bc7d6d0c2c94547c822879e52b6ef7f26a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.6/wacrawl_0.3.6_linux_arm64.tar.gz"
      sha256 "e052a4d860359530b5dcd705c89b397bfbe55b758218648bd75021470ca965c8"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.6/wacrawl_0.3.6_linux_amd64.tar.gz"
      sha256 "eaefc3e2dce77609d83e351ab1d6af3644c516b992e51e8fa479b5b4230a6def"
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
