# typed: false
# frozen_string_literal: true

# Maintained in this tap; the ordinary updater preserves install behavior.
class Crabbox < Formula
  desc "Remote software testing and execution"
  homepage "https://github.com/openclaw/crabbox"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.1/crabbox_0.48.1_darwin_amd64.tar.gz"
      sha256 "bf489e893e697fd8ada7f7b4a344e383491369877f9fcf0461551e8af7ee8c9c"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.1/crabbox_0.48.1_darwin_arm64.tar.gz"
      sha256 "8640bebb8d5afb646d68ae87b889e27e352c165bf6b36eac27beb1c22ae65605"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.1/crabbox_0.48.1_linux_amd64.tar.gz"
      sha256 "c223e51c6bbda5ec2c8464f722661451f7fdd0aa0098a652dd9e6d1ed13e207d"
      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.1/crabbox_0.48.1_linux_arm64.tar.gz"
      sha256 "fa4479d91a5c8bbcfe9ea9f2ed38dbf5ced85cd06308786baa6a396110cb6a23"
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
