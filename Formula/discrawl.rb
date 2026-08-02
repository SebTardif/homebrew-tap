class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.12.0/discrawl_0.12.0_darwin_arm64.tar.gz"
      sha256 "8122dddf8753fb2be56561e37dd4b97376294e7280fc6e78d8146aaa42ba3ad5"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.12.0/discrawl_0.12.0_darwin_amd64.tar.gz"
      sha256 "b80d5affcf1cd8f13af610560814727213e14684878bf5a550e08013aeb85b9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.12.0/discrawl_0.12.0_linux_arm64.tar.gz"
      sha256 "dcf4e71675db5554441cbfeb4ca7d7974ad414ef74b90eca482e7fe0c4d9f7a8"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.12.0/discrawl_0.12.0_linux_amd64.tar.gz"
      sha256 "166416b982819b244861bab5ef31349073820ecda92eec78af5ad2f86a7ec0e0"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
