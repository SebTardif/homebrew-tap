# typed: false
# frozen_string_literal: true

# Maintained in this tap; the ordinary updater preserves install behavior.
class Crabbox < Formula
  desc "Remote software testing and execution"
  homepage "https://github.com/openclaw/crabbox"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.0/crabbox_0.48.0_darwin_amd64.tar.gz"
      sha256 "506da27cd230f89c75615f22fef6bb7cb7805d6bc9c3325b360ea4706c8a0573"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.0/crabbox_0.48.0_darwin_arm64.tar.gz"
      sha256 "d32f8eca889893e7b0c1a9ce7340baa9cfd6b34f115480e4cbfbdcbc1fc4b1cd"

      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.0/crabbox_0.48.0_linux_amd64.tar.gz"
      sha256 "73aaa82918b2bffdfdb75e2e82a3886fb53186c1b33335490bd88692efb14f94"
      define_method(:install) do
        bin.install "crabbox"
        bin.install "crabbox-apple-vm-helper" if OS.mac? && Hardware::CPU.arm?
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.48.0/crabbox_0.48.0_linux_arm64.tar.gz"
      sha256 "9f21faccd3a964c871b65434ca35df53e2ec144b6cc59c91e0ef737051f2dc1c"
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
