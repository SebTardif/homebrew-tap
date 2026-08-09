class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/openclaw/wacrawl"
  version "0.3.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.7/wacrawl_0.3.7_darwin_arm64.tar.gz"
      sha256 "607bc00f1889115eb100be5fa9772fbce5a0fa9bb5a4708066075f60f1fea3b8"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.7/wacrawl_0.3.7_darwin_amd64.tar.gz"
      sha256 "d562651b16841cb8862f5b35ac5ea3f66c9be54842c8dcc9b4f525d24aad2ffd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.7/wacrawl_0.3.7_linux_arm64.tar.gz"
      sha256 "a9a5e308b808318bbbeb0886cb19e7345b54e177bc9c0431e2e88572660d231f"
    else
      url "https://github.com/openclaw/wacrawl/releases/download/v0.3.7/wacrawl_0.3.7_linux_amd64.tar.gz"
      sha256 "9ffed7632c1e7cbb62baefe09d5a056bdd4790502849382d5b6d409eb97658a2"
    end
  end

  def install
    bin.install "wacrawl"
  end

  def caveats
    <<~EOS
      wacrawl reads WhatsApp Desktop data from:
        ~/Library/Group Containers/group.net.whatsapp.WhatsApp.shared

      It writes its archive to:
        ~/.wacrawl/wacrawl.db

      Quick start:
        wacrawl doctor
        wacrawl import
        wacrawl status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wacrawl --version")
  end
end
