class Axorc < Formula
  desc "Inspect and automate macOS Accessibility from the shell"
  homepage "https://github.com/openclaw/AXorcist"
  url "https://github.com/openclaw/AXorcist/releases/download/v0.1.9/axorc-0.1.9-macos-universal.zip"
  sha256 "80f6d6faf5b753e54282abc6158a3c2f52a13dcb72b8f055e917b85d2a918852"
  license "MIT"

  depends_on macos: :sonoma

  skip_clean "bin/axorc"

  def install
    bin.install "axorc"
  end

  def caveats
    <<~EOS
      axorc requires Accessibility permission:
        System Settings > Privacy & Security > Accessibility
    EOS
  end

  test do
    assert_match "axorc #{version}", shell_output("#{bin}/axorc --version")
    assert_match "USAGE:", shell_output("#{bin}/axorc --help")
    system "/usr/bin/codesign", "--verify", "--strict", bin/"axorc"
    assert_match "anchor apple generic", shell_output("/usr/bin/codesign -d -r- #{bin}/axorc 2>&1")
  end
end
