class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/openclaw/wacrawl"
  version "0.3.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.9/wacrawl_0.3.9_darwin_arm64.tar.gz"
      sha256 "ccfb9bfce7a889e35dc1ba78aa16ddaf6e3e40c080242fa92e0fc7ece59698b8"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.9/wacrawl_0.3.9_darwin_amd64.tar.gz"
      sha256 "581a59e689e03c2348525125816100f1eefe60d8e35ca3cc23e4b5ae77d7ea76"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.9/wacrawl_0.3.9_linux_arm64.tar.gz"
      sha256 "b8bd593de615e6c159dda67a42d1cda4733e9467351287c013c28bd0327763e7"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.9/wacrawl_0.3.9_linux_amd64.tar.gz"
      sha256 "e792883e768383ee4c7a89415221cc44bba821539a51961bee653fc3dbdfce3a"
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
