class Slacrawl < Formula
  desc "Go-based CLI for mirroring Slack workspace data into local SQLite"
  homepage "https://github.com/openclaw/slacrawl"
  version "0.8.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.6/slacrawl_0.8.6_darwin_arm64.tar.gz"
      sha256 "ea7259edb4e6bac8c38df379a4525d84ba3a4eab9d681c9efed4d5a103427de9"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.6/slacrawl_0.8.6_darwin_amd64.tar.gz"
      sha256 "71f446a9c58dab78bd4f528adb6db099c9c7fe1c06b3b944d9cdb18cb4644fa0"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.6/slacrawl_0.8.6_linux_arm64.tar.gz"
      sha256 "c8f4fefc4954a6309e5ec41f8942fd1f1f65aa999677ffc1165729add4894ca9"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.6/slacrawl_0.8.6_linux_amd64.tar.gz"
      sha256 "b03c1cdd80644c77e207400e8f755aeb0cbc153a3903b6a0451ee19725824d91"
    end
  end

  def install
    bin.install "slacrawl"
  end

  test do
    assert_match "Usage of slacrawl:", shell_output("#{bin}/slacrawl --help")
  end
end
