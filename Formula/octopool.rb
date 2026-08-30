class Octopool < Formula
  desc "Org-authenticated GitHub read relay and gh-compatible cache shim"
  homepage "https://github.com/openclaw/octopool"
  version "0.5.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_darwin_arm64.tar.gz"
      sha256 "325430f8aa8e2d487434f60f042b538339319babb95f530680ca611c403404ed"
    else
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_darwin_amd64.tar.gz"
      sha256 "fa08763f12a9974728b0e33865427200860c109e41a0514a887d22e2b5a5c774"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_linux_arm64.tar.gz"
      sha256 "976a73212d537f724b370d6f39134adcb53c24971abdadaabfbc475802f7392a"
    else
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_linux_amd64.tar.gz"
      sha256 "7086c9bd1a84f90dc0316efe11785e2e42cbd97c41ad5b54090bb672c2c4ea2e"
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
