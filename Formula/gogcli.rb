class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.38.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.0/gogcli_0.38.0_darwin_arm64.tar.gz"
      sha256 "1bff410db24377d7e0a92904c5898c0d7e1d6d94875abff2d843535bc2180a38"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.0/gogcli_0.38.0_darwin_amd64.tar.gz"
      sha256 "5ecafdc1e90e215ae60b35fccc4c0ee0c78007691d175ea2b27315f037716a46"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.0/gogcli_0.38.0_linux_arm64.tar.gz"
      sha256 "6ca983eef5a2ffd10fc39763d6306b6320481b95a76c758627ad3a9e6b2edfcc"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.0/gogcli_0.38.0_linux_amd64.tar.gz"
      sha256 "19a67ea56769510fd04fe1c66fcb42b3ad7cf9cc1d22328d1f4562fcf04083b2"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
