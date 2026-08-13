class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.36.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "5cb5b5210879769bc6a02bd9cf39ed1b0de3f0713b397ecbddefe95dd2be618b"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "7252cfc0a63d239912d0d57ca5f51e31ca58472b506834237e148704387902df"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "f68e3c35c9364dea5a4e515d13a23ab30ded46401c90d89e2953dca395d7fe42"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "b290fcfe907789a1efb685a9336e2a6c7f9598c3c00aada8d6c437eebc86c891"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
