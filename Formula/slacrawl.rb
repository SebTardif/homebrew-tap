class Slacrawl < Formula
  desc "Go-based CLI for mirroring Slack workspace data into local SQLite"
  homepage "https://github.com/openclaw/slacrawl"
  version "0.8.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.4/slacrawl_0.8.4_darwin_arm64.tar.gz"
      sha256 "ebdd1dcc46e125a915477f616657c08a5fd091bd884692c2f70fae6a0bdfdb07"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.4/slacrawl_0.8.4_darwin_amd64.tar.gz"
      sha256 "289ca73402a025716c2fb502791b1dabbc9312843325eca07a14e27476930f55"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.4/slacrawl_0.8.4_linux_arm64.tar.gz"
      sha256 "8531f6672e329da2cbbd04f0519137a82be7d8d1cbfb4086f87376572e9667c6"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.4/slacrawl_0.8.4_linux_amd64.tar.gz"
      sha256 "8b1f6375d338b6ac7f237a2fd0927572a5e63c0e7070ae4b9ba05b30e46bcceb"
    end
  end

  def install
    bin.install "slacrawl"
  end

  test do
    assert_match "Usage of slacrawl:", shell_output("#{bin}/slacrawl --help")
  end
end
