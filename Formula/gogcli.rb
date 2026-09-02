class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.38.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.2/gogcli_0.38.2_darwin_arm64.tar.gz"
      sha256 "1796617ad3c5ed5290c89d33bbb399d1b9dd5993f0aa5abbaf0be0aeab9d029d"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.2/gogcli_0.38.2_darwin_amd64.tar.gz"
      sha256 "52558a2139c6c125f9a96b833b04c9952edc25af69073dac9a0c80876a7e47be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.2/gogcli_0.38.2_linux_arm64.tar.gz"
      sha256 "cc9c18fcd441c5396dbbcd45e96cd16e1f4d1cb768b948e6b9e08b82e6ea4f81"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.2/gogcli_0.38.2_linux_amd64.tar.gz"
      sha256 "d82724b177b4aff8a2fa0b0ab18ab2bd00d26e0e5741fa331a17b66c5e1f64fe"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
