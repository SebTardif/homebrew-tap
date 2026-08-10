class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.13.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.1/discrawl_0.13.1_darwin_arm64.tar.gz"
      sha256 "48e3f25e8466918d9772aef001989337a9d66859270ebe8bae28c25f59805e90"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.1/discrawl_0.13.1_darwin_amd64.tar.gz"
      sha256 "ba392a5cca09e1447c521ba5c8fb040debd6f429b07a6cafa3e24e95f0259989"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.1/discrawl_0.13.1_linux_arm64.tar.gz"
      sha256 "8f83655b21ff99a94a22e5c2a06affa18fe290fc733a2fa2c8e5348e77ad2c0f"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.1/discrawl_0.13.1_linux_amd64.tar.gz"
      sha256 "003d89bb29c99019bb9efe4380dbc3e0e67a2d7faa7f81a32964a3a4c337d9fd"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
