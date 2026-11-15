class HerdrCustom < Formula
  desc "HERDR with an explicit external read-only agent Skill"
  homepage "https://github.com/Eric7xu/herdr"
  version "0.9.5"
  revision 1
  license "Apache-2.0"

  depends_on :macos
  keg_only "This custom build keeps the official herdr command available for rollback"

  on_macos do
    on_arm do
      url "https://github.com/Eric7xu/herdr/releases/download/custom-v0.9.5-1/herdr-custom-0.9.5-1-macos-arm64.tar.gz"
      sha256 "d3154f1f6999c6540724d16ca1708147a391a531724479111805acaa9aa62427"
    end
    on_intel do
      url "https://github.com/Eric7xu/herdr/releases/download/custom-v0.9.5-1/herdr-custom-0.9.5-1-macos-x86_64.tar.gz"
      sha256 "e6f951a0326cf3fc2abca3cc58277815cbc5a13f34e6c46420e0ba2e785d77cf"
    end
  end

  def install
    bin.install "herdr"
    prefix.install "LICENSE"
    pkgshare.install "BUILD_INFO.txt"
    generate_completions_from_executable(bin/"herdr", "completion")
  end

  def caveats
    <<~EOS
      This package does not change your active HERDR server or command path.
      Use the full path to inspect the custom build:
        #{opt_bin}/herdr --version
        #{opt_bin}/herdr --skill
      Switch commands from a terminal outside the HERDR session that you intend to replace.
      Use this Homebrew tap for custom updates. The upstream self-updater can replace the custom patch.
    EOS
  end

  test do
    assert_match "herdr 0.9.5", shell_output("#{bin}/herdr --version")
    assert_match "Authorized external read-only access", shell_output("#{bin}/herdr --skill")
  end
end
