# Homebrew tools

This tap supplies reviewed custom builds.
The `herdr-custom` formula installs prebuilt macOS binaries from `Eric7xu/herdr` releases.
It supports Apple Silicon and Intel Macs.
It does not compile Rust or Zig on the user's Mac.

## Install without switching the active command

The package uses a separate Homebrew name.
It is keg-only, which means that Homebrew does not add its command to the shared command path.
The official HERDR installation can remain in place.

```bash
brew tap Eric7xu/tools
brew install Eric7xu/tools/herdr-custom
"$(brew --prefix Eric7xu/tools/herdr-custom)/bin/herdr" --version
"$(brew --prefix Eric7xu/tools/herdr-custom)/bin/herdr" --skill
```

Do not replace or restart an active HERDR session as part of installation.
Use a terminal outside HERDR for the final command-path switch.
Keep the old command and binary available until the new build passes local acceptance tests.
An existing `~/.local/bin/herdr` wrapper can still take precedence over both installations.
Inspect that wrapper before changing it.

## Source and compatibility

The source is <https://github.com/Eric7xu/herdr/tree/custom>.
The custom patch permits explicitly authorized external read-only inspection through the embedded Agent Skill.
It does not change runtime authentication, socket permissions, the protocol, or the internal upstream version.
Official HERDR installations on other machines do not need this patch to communicate with a compatible custom client.
An Agent that reads the official Skill on another machine still receives the official rules.

The release notes record the exact source commit and completed CI runs.
The mixed-release test covers official 0.9.5 and the custom build on Unix CI runners.
It does not prove compatibility with every release, SSH forwarding, terminal UI attachment, or Windows.

## Update and rollback

The custom formula uses fixed release URLs and SHA-256 values.
The runtime version remains the upstream version.
The custom release tag and Homebrew revision identify the patch version.

```bash
brew update
brew upgrade Eric7xu/tools/herdr-custom
```

Use this tap to update the custom build.
Do not use the upstream `herdr update` command for a custom installation.
It can install an official binary without the patch.
To roll back the command-path switch, restore the previous command or wrapper.
Do not remove a binary that an active server still needs for recovery.
