class DnsScout < Formula
  desc "Pulls and display DNS records"
  homepage "https://github.com/careyjames/DNS-Scout"
  url "https://github.com/careyjames/dns-scout/releases/download/v6.20/dns-scout-macos-arm64-silicon-v6.20.tar.gz"
  sha256 "4a139c9bb63e146ec523358b765632a80dc1344a4b352778d7995839ebff1638"
  license "MIT"

  depends_on "go" => :build

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4a139c9bb63e146ec523358b765632a80dc1344a4b352778d7995839ebff1638"
  end
  
  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end
end
