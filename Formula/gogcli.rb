class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.38.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.1/gogcli_0.38.1_darwin_arm64.tar.gz"
      sha256 "bad68687094d2ba034d3b2c369ef2e608ce233f5b6d3752cb05508b0c49bd502"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.1/gogcli_0.38.1_darwin_amd64.tar.gz"
      sha256 "43b98b982c4573f2db17f7dd901f12596a2a8bc50727cad1014d1f3c791ed0f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.1/gogcli_0.38.1_linux_arm64.tar.gz"
      sha256 "462342542472dcf361744cfe5e15a3540364b4c5120577e4519fffbd1afc6596"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.1/gogcli_0.38.1_linux_amd64.tar.gz"
      sha256 "6576828ed6852949ba424b967c3ff4268b3d9c90e201f90fe3d539fe3a151ebb"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
