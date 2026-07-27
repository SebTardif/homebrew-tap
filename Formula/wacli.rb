class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.15.0"
  license "MIT"
  version_scheme 1
  head "https://github.com/openclaw/wacli.git", branch: "main"

  depends_on "go" => :build if build.head?

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.0/wacli_0.15.0_darwin_arm64.tar.gz"
      sha256 "2b54f33d246e913a5c33525b4fc895a345363c2dcc673c70fa5f19cffb15d17d"
    end

    if Hardware::CPU.intel?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.0/wacli_0.15.0_darwin_amd64.tar.gz"
      sha256 "f778377aa1ef317335284166d5832b492e2a99aae107ae475aaf54c0940ce1a7"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.0/wacli_0.15.0_linux_arm64.tar.gz"
      sha256 "6f6e523b6c14f7e413af436f8066a1370573d29a858be06670c12350fa27c7ec"
    end

    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.0/wacli_0.15.0_linux_amd64.tar.gz"
      sha256 "e01903177e3e4c93dc962e70dcc07bc3dee3a4b282a5e3096f8a5228516e7bb7"
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
