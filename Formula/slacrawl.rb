class Slacrawl < Formula
  desc "Go-based CLI for mirroring Slack workspace data into local SQLite"
  homepage "https://github.com/openclaw/slacrawl"
  version "0.8.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.3/slacrawl_0.8.3_darwin_arm64.tar.gz"
      sha256 "2cd99ab6a1a45ec10ba46806f39c670b04fbbb3854fd736d89a367cbbaccc89f"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.3/slacrawl_0.8.3_darwin_amd64.tar.gz"
      sha256 "1adecc13d92190a674820195f19a4a3fb539f412dee1ad35f802f2dc4162f3ab"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.3/slacrawl_0.8.3_linux_arm64.tar.gz"
      sha256 "80b50232947c8f4f5034e247e751d0058fe81a4ed9570b1d5a3d16b70c973cf8"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.3/slacrawl_0.8.3_linux_amd64.tar.gz"
      sha256 "358c2cc53104232f518dd73ea96209e4d181cd3cb203f14003f53ecee312d7c1"
    end
  end

  def install
    bin.install "slacrawl"
  end

  test do
    assert_match "Usage of slacrawl:", shell_output("#{bin}/slacrawl --help")
  end
end
