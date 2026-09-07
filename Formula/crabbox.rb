# typed: false
# frozen_string_literal: true

# Maintained in this tap; the ordinary updater preserves install behavior.
class Crabbox < Formula
  desc "Remote software testing and execution"
  homepage "https://github.com/openclaw/crabbox"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/openclaw/crabbox/releases/download/v0.51.0/crabbox_0.51.0_darwin_amd64.tar.gz"
      sha256 "130ea4110e8d7f3b2cbc7d09dbb58db13d8da8cd1c1f598b448fac407c865f82"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/crabbox/releases/download/v0.51.0/crabbox_0.51.0_darwin_arm64.tar.gz"
      sha256 "402ee669e721c98d1c6b11ceda21bc7e5058fdbd9a863c03da1784a4332eccab"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.51.0/crabbox_0.51.0_linux_amd64.tar.gz"
      sha256 "ac9b31010395e27e13b5e5b768dd03aef8918fb69e722be6afd38cd8afbad6bd"
      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.51.0/crabbox_0.51.0_linux_arm64.tar.gz"
      sha256 "0f2a8caed90a1d4ec084183276699cbde395640e6106a10391e00dea4ba65751"
      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
  end

  test do
    system bin/"crabbox", "--version"
  end
end
