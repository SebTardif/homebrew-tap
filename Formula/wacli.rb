class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.15.1"
  license "MIT"
  version_scheme 1
  head "https://github.com/openclaw/wacli.git", branch: "main"

  depends_on "go" => :build if build.head?

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.1/wacli_0.15.1_darwin_arm64.tar.gz"
      sha256 "03757f45cb2628cd5bdeda6149bd2ab171394ad274ae29d400259241bd9eab19"
    end

    if Hardware::CPU.intel?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.1/wacli_0.15.1_darwin_amd64.tar.gz"
      sha256 "2f5a77ebe5f8e597bf6946dd1edee9152bd10a34de8f9ef7879ede6c564b2aa4"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.1/wacli_0.15.1_linux_arm64.tar.gz"
      sha256 "f307e5adada6ebaa82585c8e789ef1e2e60690925032a31cfb063e06618f7765"
    end

    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/wacli/releases/download/v0.15.1/wacli_0.15.1_linux_amd64.tar.gz"
      sha256 "6f3082834419174f7629727625b326b439a91521395fb0ea9bcd528471edddea"
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
