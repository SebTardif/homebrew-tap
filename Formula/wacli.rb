class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.17.0"
  license "MIT"
  version_scheme 1
  head "https://github.com/openclaw/wacli.git", branch: "main"

  depends_on "go" => :build if build.head?

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.0/wacli_0.17.0_darwin_arm64.tar.gz"
      sha256 "dda4dfa4618211f3b10c491f7a389de87b9a3f6ca2f8e4f1a743069d0886c970"
    end

    if Hardware::CPU.intel?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.0/wacli_0.17.0_darwin_amd64.tar.gz"
      sha256 "05094d9d14a19cc2cb80cb5736e4a34e05a93712cf82449e41d996af00a2b731"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.0/wacli_0.17.0_linux_arm64.tar.gz"
      sha256 "aef73e9bffc3f2bdffcdcc6f69ab107935cd170ae6fb62ed4636bed9adbe654b"
    end

    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.17.0/wacli_0.17.0_linux_amd64.tar.gz"
      sha256 "5d87ec0e2c1a063454d9673128ed9f5cadeb5a19432e8d0e1cb4cc7c9629c8ba"
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
