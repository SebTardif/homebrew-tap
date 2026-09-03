class Octopool < Formula
  desc "Org-authenticated GitHub read relay and gh-compatible cache shim"
  homepage "https://github.com/openclaw/octopool"
  version "0.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/octopool/releases/download/v0.6.1/octopool_0.6.1_darwin_arm64.tar.gz"
      sha256 "46a917de5c34b3e60031f5a030aa01a618664d1f3149c4e6ae4c2ad63bf0ccd8"
    else
      url "https://github.com/openclaw/octopool/releases/download/v0.6.1/octopool_0.6.1_darwin_amd64.tar.gz"
      sha256 "a64d6a6be98570c9de57654112e5613e48e39154a4b30e960d186f70e6229a7a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/octopool/releases/download/v0.6.1/octopool_0.6.1_linux_arm64.tar.gz"
      sha256 "815721484a3ddf1efa96d239d0e5eace219dcb7e9b82effa1093ce707f319363"
    else
      url "https://github.com/openclaw/octopool/releases/download/v0.6.1/octopool_0.6.1_linux_amd64.tar.gz"
      sha256 "64cefe4e4f622ed1bd8c6bf1b666a4cd53b674e0c8526898c00e2b556e8e754d"
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
