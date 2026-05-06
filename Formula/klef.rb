class Klef < Formula
  desc "Local-first vault for API keys, backed by the OS keychain"
  homepage "https://github.com/slewinus/klef"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "62f802d5495acfd28741e2d11ad94f6290c834143f1abf2a023787500b10a7a3"
    else
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "1bb1526f5b7bc4c878c8b453f99881ee9783253e391c781749ede87a6afcb359"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1dc573775ddbf208dfd7fe12e08fb75155b6dfd10217b99b4bb812666bf218c3"
    else
      url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f5188e42b9ed69f652727bb81927ccfbeb2aa7d12845411cf735b84b4bd5264f"
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
