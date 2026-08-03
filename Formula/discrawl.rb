class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.0/discrawl_0.13.0_darwin_arm64.tar.gz"
      sha256 "8c41839fa08d5b0e268d245f10b809bfd95636bf892419d246e9fb89d5eceb28"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.0/discrawl_0.13.0_darwin_amd64.tar.gz"
      sha256 "0d2e335e9d4218a96b1535dfefa09987dd923ee1aa6b50a66c2767262eb8712d"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.0/discrawl_0.13.0_linux_arm64.tar.gz"
      sha256 "69dd21af1f08352ced68ff75e27b8a9f9ee6bca20285e0e939dbc95823a77488"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.13.0/discrawl_0.13.0_linux_amd64.tar.gz"
      sha256 "bf65005687d1f0b416f4911e31aa7c08d1a004b915469404dfff146381f51426"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
