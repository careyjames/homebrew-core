class DnsScout < Formula
  desc "Pulls and display DNS records"
  homepage "https://github.com/careyjames/DNS-Scout"
  url "https://github.com/careyjames/DNS-Scout/archive/refs/tags/v5.8.tar.gz"
  sha256 "2ac687dfdd7f218a86ae5235c05f63c785af00786366e26f90d600972a5b282a"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end
end
