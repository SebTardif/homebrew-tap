class Gitcrawl < Formula
  desc "Local GitHub issue and PR archive, search, and clustering"
  homepage "https://github.com/openclaw/gitcrawl"
  version "0.9.3"
  license "MIT"

  head "https://github.com/openclaw/gitcrawl.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_darwin_arm64.tar.gz"
      sha256 "dbb42bd49e87a421072fd70fc13835f53b1b8c5d966b7df538372a15557ad872"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_darwin_amd64.tar.gz"
      sha256 "34e47adb998497b55d1f6b4d22af64fc681ca562c6844ac1bc761029ca52d79b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_linux_arm64.tar.gz"
      sha256 "880fc9d9c3bda0b2927ed989a3b6184018de54bf9dd1bfce1d6f27a801f9b0af"
    else
      url "https://github.com/openclaw/gitcrawl/releases/download/v0.9.3/gitcrawl_0.9.3_linux_amd64.tar.gz"
      sha256 "0c015ecce56c5a31fb1aa39ffa9e99650954d1492e55c65daf4d87f59524c0d5"
    end
  end

  depends_on "go" => :build if build.head?

  def install
    if build.head?
      ldflags = "-s -w -X github.com/openclaw/gitcrawl/internal/cli.version=#{version}"
      system "go", "build", *std_go_args(output: bin/"gitcrawl", ldflags: ldflags), "./cmd/gitcrawl"
    else
      bin.install "gitcrawl"
    end
  end

  def caveats
    <<~EOS
      gitcrawl fresh defaults:
      macOS:
        ~/Library/Application Support/gitcrawl/ (config, database, vectors, logs)
        ~/Library/Caches/gitcrawl/ (cache)
      Linux:
        ${XDG_CONFIG_HOME:-~/.config}/gitcrawl/ (config)
        ${XDG_DATA_HOME:-~/.local/share}/gitcrawl/ (database, vectors)
        ${XDG_CACHE_HOME:-~/.cache}/gitcrawl/ (cache)
        ${XDG_STATE_HOME:-~/.local/state}/gitcrawl/ (logs)

      Absolute XDG overrides are honored on macOS too. Existing legacy paths
      may still be reused; explicit or configured paths can differ.
      See https://gitcrawl.sh/configuration/ for details.
      Run gitcrawl doctor --json for active config and database paths.

      Gitcrawl's gh compatibility shim has moved to Octopool.
      Keep your existing gh/Octopool setup; do not symlink Gitcrawl as gh.
      See https://gitcrawl.sh/gh-shim/ for migration details.
    EOS
  end

  test do
    assert_match build.head? ? "HEAD" : version.to_s, shell_output("#{bin}/gitcrawl --version")
  end
end
