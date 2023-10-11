class DnsScout < Formula
  desc "Pulls and display DNS records"
  homepage "https://github.com/careyjames/DNS-Scout"
  url "https://github.com/careyjames/DNS-Scout/archive/refs/tags/v5.8.tar.gz"
  sha256 "f8e2c2f68c2e402b8aeef0225ebf04aedb6c6852b102e2c7f3dbe6f6f1e60ec9"
  sha256 "45b5fe937a570319da3b2957681010adcf4b077cc8bad59e5a1f445e18a951ab"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end
end
