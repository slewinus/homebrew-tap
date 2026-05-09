cask "klef" do
  version "0.4.0"
  sha256 "4eae7f2da15362ca5db19d5ed11c4a1a87d6454b14041d1607ce986a6e13d4af"

  url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-gui-v#{version}-aarch64-apple-darwin.dmg"
  name "klef"
  desc "Local-first vault for API keys (CLI + macOS menu bar app)"
  homepage "https://github.com/slewinus/klef"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  app "klef.app"

  # The CLI binary lives inside the .app bundle so a single `brew install
  # slewinus/tap/klef` ships both the menu bar GUI and the `klef` command
  # on $PATH. Path inside the bundle: Resources/cli-bundle/klef.
  binary "#{appdir}/klef.app/Contents/Resources/cli-bundle/klef"

  # The DMG is not yet code-signed with a Developer ID (tracked in
  # https://github.com/slewinus/klef/issues/123). Until that ships, macOS
  # Gatekeeper will quarantine the .app and refuse to launch it. Workaround:
  # `xattr -dr com.apple.quarantine /Applications/klef.app`
  caveats <<~EOS
    klef is not yet codesigned with an Apple Developer ID.

    On first launch, macOS may say the app is "damaged" or refuse to open it.
    Clear the quarantine flag once and you're done:

      xattr -dr com.apple.quarantine /Applications/klef.app

    Then launch the GUI from Spotlight or `/Applications/klef.app` (icon
    appears in the menu bar, top-right). The CLI is on $PATH as `klef`.

    Tracking signing/notarization in:
      https://github.com/slewinus/klef/issues/123
  EOS

  zap trash: [
    "~/Library/Application Support/klef",
    "~/Library/Preferences/com.slewinus.klef-gui.plist",
    "~/Library/Saved Application State/com.slewinus.klef-gui.savedState",
  ]
end
