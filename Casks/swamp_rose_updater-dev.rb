cask "swamp_rose_updater-dev" do
  version "continuous"
  sha256 ""

  url "https://github.com/snyke7/swamp-rose-updater/releases/download/continuous/swamp_rose_updater.dmg"
  name "swamp_rose_updater"
  desc "Update your ROSE Online installation on MacOS"
  homepage "https://github.com/snyke7/swamp-rose-updater"

  conflicts_with cask: "swamp_rose_updater"

  app "swamp_rose_updater.app"
end
