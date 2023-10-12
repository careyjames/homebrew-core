class DnsScout < Formula
  desc "Pulls and display DNS records"
  homepage "https://github.com/careyjames/DNS-Scout"
  url "https://github.com/careyjames/DNS-Scout/archive/refs/tags/v5.8.tar.gz"
  sha256 "32de5bd081bb7f4956867be43fc2f887e073de948a96378040d54a89074a681d"
  sha256 "22a387feb0966f0e9db51be808358cd88d5bc241a3b3ce8dd02903ca501a94e3"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end
end
