class Axorc < Formula
  desc "Inspect and automate macOS Accessibility from the shell"
  homepage "https://github.com/openclaw/AXorcist"
  url "https://github.com/openclaw/AXorcist/releases/download/v0.1.7/axorc-0.1.7-macos-universal.zip"
  sha256 "f17188ac64bd6bc4daaa4694eff26d556a29adfecfd08ab2a5f3133a8f4fe0e3"
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
