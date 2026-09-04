class Clawscan < Formula
  desc "Agent-skill security scanner harness for ClawHub"
  homepage "https://github.com/openclaw/clawscan"
  version "0.1.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.7/clawscan_v0.1.7_darwin_arm64.tar.gz"
      sha256 "1664805a61d7fa153895f6d14b70425163a59d79ad350698a802c186793901a0"
    else
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.7/clawscan_v0.1.7_darwin_amd64.tar.gz"
      sha256 "80e5ef071f8f0c5f349543f2358dd2168f18c7825e0785fe1f711e8ee99d60c5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.7/clawscan_v0.1.7_linux_arm64.tar.gz"
      sha256 "567fbbde2cf7caca2e32f53887f2ce63533dadbefb210a6eebd137acbe5355ff"
    else
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.7/clawscan_v0.1.7_linux_amd64.tar.gz"
      sha256 "e1b6f7a4004bc024054f59b53e426583bc75f35b78eda4137159fea9bc6cfb28"
    end
  end

  def install
    bin.install "clawscan"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clawscan --version")
  end
end
