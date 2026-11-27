# Neuro / Evil Neuro Desktop Pets

Windows files for the original Neuro and Evil Neuro Shimeji packages, with Simplified Chinese menus and more legible menus.

## Requirements

- Windows 10 or later with Windows PowerShell 5.1 and desktop (AWT system-tray) support.
- The launcher uses Windows PowerShell; it does not require Git Bash.

Matching 32-bit and 64-bit Eclipse Temurin Java 8 distributions are bundled in `runtime/` as their original vendor archives. On first launch, the selected runtime is extracted to the user's Local AppData cache; no Java installation or network access is needed. The launcher then searches `JAVA_HOME`, standard Java installation folders, and `PATH` for a matching Java 8 fallback if the bundled runtime is unavailable. It does not silently use Java 11, 17, or 21.

## Launch

- Double-click `启动Neuro.cmd` for Neuro.
- Double-click `启动Evil.cmd` for Evil Neuro.
- Extract the repository first; do not launch from a ZIP preview.
- Quit from the mascot's tray menu with `Dismiss All`.

The launcher sets `Language=zh-CN` and starts the selected mascot from its own directory. Each mascot folder contains its original JAR, images, configuration, libraries, and license.

## Fixes

- The Neuro package's original archive used a top-level directory name ending with a space. The repository uses a normal `Neuro` directory.
- Launchers explicitly select a Java 8 runtime with the same 32/64-bit architecture as Windows.
- Both packages default to Simplified Chinese and use an opaque, high-contrast menu theme with 15-point Microsoft YaHei.
- Matching Java 8 runtimes for 32-bit and 64-bit Windows are included (about 79 MB compressed total); first launch extracts only the matching architecture. No separate Java installation is needed.
- Logs from previous runs are not included.

The original Java application and JNA desktop integration are old software. The launchers improve runtime selection but cannot guarantee compatibility with every Windows build, security policy, display scaling mode, or multi-monitor setup. No Windows-version matrix or automated GUI test has been run; verify on the intended PCs before distributing broadly.
