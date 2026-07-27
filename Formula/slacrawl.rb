class Slacrawl < Formula
  desc "Go-based CLI for mirroring Slack workspace data into local SQLite"
  homepage "https://github.com/openclaw/slacrawl"
  version "0.7.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.7.11/slacrawl_0.7.11_darwin_arm64.tar.gz"
      sha256 "f5fb7a78a5e521f79039ede436227914c237d867ebd4b752dd9fef518b98d597"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.7.11/slacrawl_0.7.11_darwin_amd64.tar.gz"
      sha256 "8bc49a5e3402fdc4b24b53459d4b5cea5ff773c7879170be0b8f47fbf263f3f7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.7.11/slacrawl_0.7.11_linux_arm64.tar.gz"
      sha256 "f54bdb6bd391e41ebaab30d48d5796d4a0d7d4a6f000be959851ab1be84bf5a6"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.7.11/slacrawl_0.7.11_linux_amd64.tar.gz"
      sha256 "a83de7d59ae7ec5775612d7a1cbd89dac6a47fd03051b33fd5018009fc190061"
    end
  end

  def install
    bin.install "slacrawl"
  end

  test do
    assert_match "Usage of slacrawl:", shell_output("#{bin}/slacrawl --help")
  end
end
