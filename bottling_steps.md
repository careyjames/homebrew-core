As far as I understand, the reason why the PR failed steps in Homebrew CI was because of not having a `bottle do` section. 

As we create bottles of the program in different architectures, we might see success in the PR. For now, I have added `linux_x86_64` sha hash to the `bottle do` section. Let us try to add this commit and see if this improves the checks in the PR. If this is the right direction, we can create hashes for the various macOS architectures as well.


Steps to create a bottle:

1. Create a new repo on Github named `homebrew-formula-name`. In this case `careyjames/homebrew-dns-scout`.

2. Clone the empty repo locally and add a basic formula file to it. It should look like:

```
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

```

3. Commit and push the file to the `main` branch of `careyjames/homebrew-dns-scout`

```
git add .
git commit -m "new formula"
git push -u origin main
```

4. In a terminal session, remove any existing installation of `dns-scout` command using `brew uninstall dns-scout`

5. Create a tap of the new formula using command. This will look for the formula in the new github repo and create a tap.

`brew tap careyjames/dns-scout`

6. Use the command `brew install --build-bottle dns-scout` to install command, as well as prepare for bottling

7. Finally run `brew bottle dns-scout`. This should create a bottle against the host OS and Architecture and return a bottle section such as:

```
bottle do
  rebuild 1
  sha256 cellar: :any_skip_relocation, x86_64_linux: "ebc886585ceb518527045dafb6f8029591ac260c174b94cd7e6f83f57d08875f"
end
```

8. Make sure the `Formula/d/dns-scout.rb` file in `careyjames/homebrew-core` repo looks similar to this:

```
class DnsScout < Formula
  desc "Pulls and display DNS records"
  homepage "https://github.com/careyjames/DNS-Scout"
  url "https://github.com/careyjames/DNS-Scout/archive/refs/tags/v5.8.tar.gz"
  sha256 "2ac687dfdd7f218a86ae5235c05f63c785af00786366e26f90d600972a5b282a"
  license "MIT"

  depends_on "go" => :build
  
  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ebc886585ceb518527045dafb6f8029591ac260c174b94cd7e6f83f57d08875f"
  end

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end
end
```

9. If you have more bottles created against other OSes and architectures (in different physical or virtual machines), you can add them to the `bottle do` section.

## Issues

1. One issue I noticed is that the sha sum changes dynamically for each `brew bottle` run. In that case it might create issues with CI checks failing with mismatch. If that comes up, we need to dig deeper and find out how others solve this.
