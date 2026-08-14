class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.37.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.37.0/gogcli_0.37.0_darwin_arm64.tar.gz"
      sha256 "8a1c0c2c0264fdc602cce50b44431e10569269f98e054ab55033c652a96b7c61"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.37.0/gogcli_0.37.0_darwin_amd64.tar.gz"
      sha256 "b17151e7701404a0fa12d4af129b36950904df9532b1a989a9542f704616777e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.37.0/gogcli_0.37.0_linux_arm64.tar.gz"
      sha256 "4abde90c4e74ceb125f3fdd87676ff7958e89f7820978ffa11de26aee06e721c"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.37.0/gogcli_0.37.0_linux_amd64.tar.gz"
      sha256 "905fed0bfabafa5dde7189e50642b3fa31d7fc4aad50a8d27d2b92071d875962"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
