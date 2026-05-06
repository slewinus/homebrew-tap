class Klef < Formula
  desc "Local-first vault for API keys, backed by the OS keychain"
  homepage "https://github.com/slewinus/klef"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f1c02862a66346ad0af99f73b694677d080699fadb8d0220987ec54a67409805"
    else
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "a620ac5e74c5ea5f8d4c6d1082016ac5a72071591671c31a67c12c7cc1d4c85c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d6550593fc256f58a9872ead8e8ab79e33c6700bebd2af7a8ad0da853b19171"
    else
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a87783fa1394ed0861eafe2993d86d75c2d085623f21525223706e2116e02bc"
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
