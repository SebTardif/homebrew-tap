class Notcrawl < Formula
  desc "Local-first Notion crawler into SQLite and normalized Markdown"
  homepage "https://github.com/openclaw/notcrawl"
  version "0.5.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.5/notcrawl_0.5.5_darwin_arm64.tar.gz"
      sha256 "1e4ab9c824d40d09ef0768520144dc4a8256eb13666f857055408d74d44bcb1d"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.5/notcrawl_0.5.5_darwin_amd64.tar.gz"
      sha256 "d5bc2b8245b572b81ac9d3beecd1fc2718ae15e7eb5946965f57719b58a7ae20"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.5/notcrawl_0.5.5_linux_arm64.tar.gz"
      sha256 "70b9ff0e19b7600f7c78283f69544ab21f630f0561728b4aa27c699936da450b"
    else
      url "https://github.com/openclaw/notcrawl/releases/download/v0.5.5/notcrawl_0.5.5_linux_amd64.tar.gz"
      sha256 "70d2b7f07b4ac00383e5251502b6400b50a3def93842bfdaf795a05bf4855955"
    end
  end

  def install
    bin.install "notcrawl"
  end

  test do
    assert_match "Usage of notcrawl:", shell_output("#{bin}/notcrawl --help")
  end
end
