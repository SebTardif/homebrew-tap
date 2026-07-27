class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.11.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.9/discrawl_0.11.9_darwin_arm64.tar.gz"
      sha256 "8845f5b58bc60c074f76758193668b4de531f373f61c0deebfa7bbdf3d1d86c6"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.9/discrawl_0.11.9_darwin_amd64.tar.gz"
      sha256 "fa78e9d91cf942c88954e9996886b4af324a4415f216047c09a56df446b99152"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.9/discrawl_0.11.9_linux_arm64.tar.gz"
      sha256 "30a5ffd2cde470db74d17c0d43686a0a155a2d818ac86a61404620d5dbc0dee6"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.9/discrawl_0.11.9_linux_amd64.tar.gz"
      sha256 "e88ec667d5114ecfb2fbfc58c11e70835b5460718bd1593fc4147e6ee4ff2615"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
