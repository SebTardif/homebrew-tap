class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.16.0"
  license "MIT"
  version_scheme 1
  head "https://github.com/openclaw/wacli.git", branch: "main"

  depends_on "go" => :build if build.head?

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacli/releases/download/v0.16.0/wacli_0.16.0_darwin_arm64.tar.gz"
      sha256 "dc0af5df9cf2fd11105d1bcc787587abfc768b5a461fca3cc768b2a7fbd2351d"
    end

    if Hardware::CPU.intel?
      url "https://github.com/openclaw/wacli/releases/download/v0.16.0/wacli_0.16.0_darwin_amd64.tar.gz"
      sha256 "5ac66e9b417a2fea3dcfd9d33c2d8d320f69259e1c7d83652fbdd09b0a8cb297"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.16.0/wacli_0.16.0_linux_arm64.tar.gz"
      sha256 "4a893e2ba6a44645faacceeb1cc15476c96e0fc46763723f533bd1d2f6c9d59b"
    end

    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.16.0/wacli_0.16.0_linux_amd64.tar.gz"
      sha256 "65087d5fb398e5a20d21162e60f3ac56aed3dea36610bc5cec57f03d58344680"
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
