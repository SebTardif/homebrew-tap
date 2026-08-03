class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.15.2"
  license "MIT"
  version_scheme 1
  head "https://github.com/openclaw/wacli.git", branch: "main"

  depends_on "go" => :build if build.head?

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.2/wacli_0.15.2_darwin_arm64.tar.gz"
      sha256 "f4d162c8a31fb6cdd9ead595e54e80aa53d41708b9c57521717ecbb7ac6e30f7"
    end

    if Hardware::CPU.intel?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.2/wacli_0.15.2_darwin_amd64.tar.gz"
      sha256 "722007db444fce7f4c16ca792fc2253e59ee7915383f502b454c3d9771a6d29b"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.2/wacli_0.15.2_linux_arm64.tar.gz"
      sha256 "5b88785aa2c5d9a86d6b6679d4822a4c49011003ad8af3958089797d7a0b8207"
    end

    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.2/wacli_0.15.2_linux_amd64.tar.gz"
      sha256 "6ba88ececb34a8bc62955bc0ac2d41480bd55cc297fc61b685135e1fb216baf6"
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
