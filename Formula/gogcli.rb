class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.39.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.39.0/gogcli_0.39.0_darwin_arm64.tar.gz"
      sha256 "32d77c6e35f00be48e9663c19618b4947b1398ee87ff1a3af1ebc54eab6c6bff"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.39.0/gogcli_0.39.0_darwin_amd64.tar.gz"
      sha256 "8fc3774b561f5fc71f8209af3e3873a8e70ab57c1a5424f757db4197f6b6df08"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.39.0/gogcli_0.39.0_linux_arm64.tar.gz"
      sha256 "040984e38291da2f23ddeefbd67371c5bf32de6be3177d4f5a816f7fe51bacb7"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.39.0/gogcli_0.39.0_linux_amd64.tar.gz"
      sha256 "76100bce13c976b0acf3c7172a0e52d4c06da95ade42f620ad57707cd532f3e8"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
