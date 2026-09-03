class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.38.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.3/gogcli_0.38.3_darwin_arm64.tar.gz"
      sha256 "1b40ae9f8dba45bed3a59b55a70f943fab210e248e9b4b1d4c363efe744a103f"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.3/gogcli_0.38.3_darwin_amd64.tar.gz"
      sha256 "fbc36dfdc53c201d24717e67c19102e0d4d633ebb5fbdb1016ddcce8fc941154"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.3/gogcli_0.38.3_linux_arm64.tar.gz"
      sha256 "e67194dde45718c977aff33870b7d8fcac697c5efe8b2e0e370ff1c4c349ab27"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.38.3/gogcli_0.38.3_linux_amd64.tar.gz"
      sha256 "51a291629b1af611fd6608bd3b549787b12519ae6e425e6352fa105b74d0422d"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
