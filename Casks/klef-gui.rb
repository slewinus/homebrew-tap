cask "klef-gui" do
  version "0.4.0"
  sha256 "17b6da553e367fe5643948e7b28379722bd7adcc5420c945f53b8193c42ec33f"

  url "https://github.com/slewinus/klef/releases/download/v#{version}/klef-gui-v#{version}-aarch64-apple-darwin.dmg"
  name "klef GUI"
  desc "Local-first vault for API keys — macOS menu bar app"
  homepage "https://github.com/slewinus/klef"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  app "klef.app"

  # The DMG is not yet code-signed with a Developer ID (tracked in
  # https://github.com/slewinus/klef/issues/123). Until that ships, macOS
  # Gatekeeper will quarantine the .app and refuse to launch it. Workaround:
  # `xattr -dr com.apple.quarantine /Applications/klef.app`
  caveats <<~EOS
    klef GUI is not yet codesigned with an Apple Developer ID.

    On first launch, macOS may say the app is "damaged" or refuse to open it.
    Clear the quarantine flag once and you're done:

      xattr -dr com.apple.quarantine /Applications/klef.app

    Then launch from Spotlight or `/Applications/klef.app`. The icon appears
    in the menu bar (top-right), not in the Dock.

    Tracking signing/notarization in:
      https://github.com/slewinus/klef/issues/123
  EOS

  zap trash: [
    "~/Library/Application Support/klef",
    "~/Library/Preferences/com.slewinus.klef-gui.plist",
    "~/Library/Saved Application State/com.slewinus.klef-gui.savedState",
  ]
end
