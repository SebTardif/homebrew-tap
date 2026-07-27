class Discrawl < Formula
  desc "Mirror Discord into SQLite and search server history locally"
  homepage "https://github.com/openclaw/discrawl"
  version "0.11.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.10/discrawl_0.11.10_darwin_arm64.tar.gz"
      sha256 "ca8c8a1e71df4755bcba625a2331ba13e8055f373c8dcae737680911abcced0c"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.10/discrawl_0.11.10_darwin_amd64.tar.gz"
      sha256 "19e6e8b599329da9ac57288f2f7929c881b014fc2658cb702df20db4c702bdf0"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.10/discrawl_0.11.10_linux_arm64.tar.gz"
      sha256 "ab0a13394c8b36a6757987bda39d184ed1786c48472fc016e5912bd287d9ceb1"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v0.11.10/discrawl_0.11.10_linux_amd64.tar.gz"
      sha256 "3fb8f1dbd24248850c325a2a54b1fa9af74be633c1c6e5e0fef30b9fdca215ad"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/discrawl --version").strip
  end
end
