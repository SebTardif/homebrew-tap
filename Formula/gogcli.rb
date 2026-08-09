class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.35.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "06818c50a1222c9b344690a58d6ba8d075f7be29aeed825bd17741bae2734833"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "e4f4138422f3fa2b7884e365ba1502a0bda5ffbb238f4ecb467ff0f3b1a40bed"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "6db242904741e280e5e62ff9249fe76c075bad5cc6c06d841e011622803dce34"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "c4e7e349c53d3e69e36729d4315a0e080a85a4b4767a84943f075067931bcbdf"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
