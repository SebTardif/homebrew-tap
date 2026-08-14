class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.17.1"
  license "MIT"
  version_scheme 1
  head "https://github.com/openclaw/wacli.git", branch: "main"

  depends_on "go" => :build if build.head?

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.1/wacli_0.17.1_darwin_arm64.tar.gz"
      sha256 "6ef08cfa6c8f07ce0b4be4d498178848712bccf6fc49bbd10a2af8ab65fccd6d"
    end

    if Hardware::CPU.intel?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.1/wacli_0.17.1_darwin_amd64.tar.gz"
      sha256 "c3cf0e89e80f8177c86b0e3b38157e5fe4986b750ebc00f8a4f836062bf47ea3"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.1/wacli_0.17.1_linux_arm64.tar.gz"
      sha256 "8e5d21f8d5f097e5d3a883cdb42848a9e50a7383e4de049c807cc44e6e7c81b6"
    end

    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.1/wacli_0.17.1_linux_amd64.tar.gz"
      sha256 "cbd5e74d5b805550cc36c7479aca552970cc1b314c5c08e02367e08b785714fd"
    end
  end

  def install
    if File.exist?("wacli")
      bin.install "wacli"
    else
      ldflags = "-s -w -X main.version=#{version}"
      # GCC 15+ with glibc 2.42+ treats missing-braces in Go's runtime/cgo as errors.
      # See: https://github.com/steipete/wacli/pull/8
      ENV["CGO_ENABLED"] = "1"
      ENV.append "CGO_CFLAGS", "-Wno-error=missing-braces"
      system "go", "build", "-tags", "sqlite_fts5", *std_go_args(ldflags: ldflags), "./cmd/wacli"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wacli --version")
    assert_match "FTS5", shell_output("#{bin}/wacli doctor")
  end
end
