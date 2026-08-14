class Slacrawl < Formula
  desc "Go-based CLI for mirroring Slack workspace data into local SQLite"
  homepage "https://github.com/openclaw/slacrawl"
  version "0.8.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.5/slacrawl_0.8.5_darwin_arm64.tar.gz"
      sha256 "653f702dcc2a9ad8800a475f33925582385b393ca793857e5524850c83463440"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.5/slacrawl_0.8.5_darwin_amd64.tar.gz"
      sha256 "af089477a10f65673b1507e4b463b2e7c7d386c1faa0c05e125e8e65915f25f5"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.5/slacrawl_0.8.5_linux_arm64.tar.gz"
      sha256 "980400111ad223da25dd4eccb24e7181f77131650e5ad1e60bd4cee850834ace"
    else
      url "https://github.com/openclaw/slacrawl/releases/download/v0.8.5/slacrawl_0.8.5_linux_amd64.tar.gz"
      sha256 "3e2252842cd218af5d00993b67db9dcf38b7e94b8e110b821789b0e231c0d876"
    end
  end

  def install
    bin.install "slacrawl"
  end

  test do
    assert_match "Usage of slacrawl:", shell_output("#{bin}/slacrawl --help")
  end
end
