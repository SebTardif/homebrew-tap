# typed: false
# frozen_string_literal: true

# Maintained in this tap; the ordinary updater preserves install behavior.
class Crabbox < Formula
  desc "Remote software testing and execution"
  homepage "https://github.com/openclaw/crabbox"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/openclaw/crabbox/releases/download/v0.49.1/crabbox_0.49.1_darwin_amd64.tar.gz"
      sha256 "c8b568dc230b161f3b7f071aa501fdb1b50b7659e3b370e2c846bc3037c45d72"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/crabbox/releases/download/v0.49.1/crabbox_0.49.1_darwin_arm64.tar.gz"
      sha256 "f898155483a46d3a3241b14a64d70f94f5edde6818b0c5c04a287970f1bf6fe0"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.49.1/crabbox_0.49.1_linux_amd64.tar.gz"
      sha256 "773f25f1a33a7466ffc6cc21b3ef006874479d3d685e8876e1bf08a7830e9c86"
      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.49.1/crabbox_0.49.1_linux_arm64.tar.gz"
      sha256 "baf2a6f5151d438ef9b3c50f03419d5447747ea1d8e5f0941ad9a0f1c2da642f"
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
