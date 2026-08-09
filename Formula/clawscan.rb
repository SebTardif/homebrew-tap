class Clawscan < Formula
  desc "Agent-skill security scanner harness for ClawHub"
  homepage "https://github.com/openclaw/clawscan"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.6/clawscan_v0.1.6_darwin_arm64.tar.gz"
      sha256 "fe3490da4cc3ebadc60972fa6a986be5d16280bbf281893458c7022044db6175"
    else
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.6/clawscan_v0.1.6_darwin_amd64.tar.gz"
      sha256 "115be8dc8bf12191ae117bc76ace6e399b6c840a9732c4b41b4191ccb19094ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.6/clawscan_v0.1.6_linux_arm64.tar.gz"
      sha256 "2aec5286db54162b35eaf9d1f09f3b595e02769f5563c94c8186255550a56a50"
    else
      url "https://github.com/openclaw/clawscan/releases/download/v0.1.6/clawscan_v0.1.6_linux_amd64.tar.gz"
      sha256 "f477e6462f45ff021cc27b1baf2a85b0ad39aff88416af33910e2bec6655468a"
    end
  end

  def install
    bin.install "clawscan"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clawscan --version")
  end
end
