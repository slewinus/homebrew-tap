class Klef < Formula
  desc "Local-first vault for API keys, backed by the OS keychain"
  homepage "https://github.com/slewinus/klef"
  version "0.4.0"
  license "MIT"

  # On macOS, also pull in the GUI menu-bar app from the sibling cask,
  # so `brew install klef` lands the CLI on $PATH AND klef.app in
  # /Applications in one shot. Linux users get just the CLI.
  on_macos do
    depends_on cask: "slewinus/tap/klef-gui"

    if Hardware::CPU.arm?
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "c423cf052b3fa076425aee46c3afcac03ce861732a2b884fe5247ab35769ae1c"
    else
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "bbc932679fcc19ca1d2b157a71265285b06b6c0e8fe52d5d77aa0d3f7a4d5c48"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f17b1ac2ebe8b4d5ab99daf8e082791702aa6ca0c103096de9e829e61a5b2084"
    else
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "28aba5997581c67d8fe8d0dcc2cb56e37db8ecd5332620bf68cffd42398a080f"
    end
  end

  def install
    bin.install "klef"
    # Generate and install shell completions while we have a runnable binary.
    generate_completions_from_executable(bin/"klef", "completions")
  end

  test do
    assert_match "klef", shell_output("#{bin}/klef --version")
    assert_match "Local-first vault", shell_output("#{bin}/klef --help")
  end
end
