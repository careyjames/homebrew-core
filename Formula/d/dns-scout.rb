class DnsScout < Formula
  desc "Pulls and display DNS records"
  homepage "https://github.com/careyjames/DNS-Scout"
  url "https://github.com/careyjames/DNS-Scout/archive/refs/tags/v5.8.tar.gz"
  sha256 "2ac687dfdd7f218a86ae5235c05f63c785af00786366e26f90d600972a5b282a"
  license "MIT"

  depends_on "go" => :build

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "37579b620342b22887aa48247414233a8caf7d7e81935e3fb1aef3a751926ca3"
  end
  
  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end
end
