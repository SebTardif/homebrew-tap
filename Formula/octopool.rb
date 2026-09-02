class Octopool < Formula
  desc "Org-authenticated GitHub read relay and gh-compatible cache shim"
  homepage "https://github.com/openclaw/octopool"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/octopool/releases/download/v0.6.0/octopool_0.6.0_darwin_arm64.tar.gz"
      sha256 "864a38064279553754f6f47ba7da1b88a6d8e3da9116286963b0c1c3eaf92f75"
    else
      url "https://github.com/openclaw/octopool/releases/download/v0.6.0/octopool_0.6.0_darwin_amd64.tar.gz"
      sha256 "c4021c88b5df98b2c2e4c25a961e86763c534dfc73d12b33055377d70d3f1a85"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/octopool/releases/download/v0.6.0/octopool_0.6.0_linux_arm64.tar.gz"
      sha256 "c988cc92ecea38c5fb6a1f9d3a67a0b5ffd2b0223b985d3034a1f951e2be0568"
    else
      url "https://github.com/openclaw/octopool/releases/download/v0.6.0/octopool_0.6.0_linux_amd64.tar.gz"
      sha256 "e6f3b8d9aebb020f47963341c81510549c0e3107b6ffe013536b9dddf4f64c73"
    end
  end

  def install
    bin.install "octopool"
  end

  def caveats
    <<~EOS
      Run `octopool install-shim` to route gh through Octopool in every zsh.
    EOS
  end

  test do
    assert_match "octopool #{version}", shell_output("#{bin}/octopool version")
  end
end
