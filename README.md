# Neuro / Evil Neuro 桌宠

这是 Neuro 和 Evil Neuro 原版 Shimeji 桌宠的 Windows 整理版，包含简体中文菜单、更加清晰易读的菜单样式，以及开箱即用的 Java 8 运行环境。

## 系统要求

- Windows 10 或更高版本。
- 系统需要支持 Windows PowerShell 5.1 和桌面系统托盘（AWT）。
- 不需要提前安装 Java，也不需要使用 Git Bash 启动。

仓库的 `runtime` 目录中包含 Eclipse Temurin Java 8 的 64 位和 32 位 Windows 运行时。首次启动时，启动器会根据 Windows 位数选择对应版本，并将其解压到当前用户的 `%LOCALAPPDATA%\Neuro-Evil-Desktop-Pet\runtime` 缓存目录。整个过程不需要联网，也不会修改系统安装的 Java。

如果内置运行时不可用，启动器才会依次检查 `JAVA_HOME`、常见 Java 安装目录和 `PATH`，并且只使用位数匹配的 Java 8，不会误用 Java 11、17 或 21。

## 启动方法

1. 下载或克隆完整仓库，不要只下载其中几个文件。
2. 如果下载的是源码压缩包，请先完整解压，不要直接在压缩包预览窗口中运行。
3. 双击 `启动Neuro.cmd` 启动 Neuro。
4. 双击 `启动Evil.cmd` 启动 Evil Neuro。
5. 如需退出，在桌宠的系统托盘菜单中选择“全部退出”。

两个启动入口可以分别运行，也可以同时运行。首次启动需要解压 Java 8，速度可能比之后启动稍慢。

## 本版本的修改

- 保留 Neuro 和 Evil Neuro 原版 JAR、图片、配置文件、依赖库及许可证文件。
- 修复原始 Neuro 压缩包顶层目录名末尾带空格，导致部分 Windows 环境无法正常定位文件的问题。
- 启动器会根据 Windows 位数明确选择 64 位或 32 位 Java 8。
- Neuro 和 Evil Neuro 默认使用简体中文菜单。
- 菜单采用不透明、高对比度配色，并使用 15 磅微软雅黑，提高文字清晰度。
- 桌宠使用程序内置的 HQ2x 滤镜以 2 倍尺寸显示（由 128×128 放大至 256×256）。
- 内置 64 位和 32 位 Eclipse Temurin Java 8，无需用户另外安装 Java。
- 不包含以前运行产生的日志文件。

## 文件说明

- `Neuro/`：Neuro 桌宠的程序、图片和配置。
- `Evil/`：Evil Neuro 桌宠的程序、图片和配置。
- `runtime/`：官方 Eclipse Temurin Java 8 运行时发行包。
- `Start-Original-Shimeji.ps1`：负责选择和解压 Java 8、设置中文并启动桌宠。
- `启动Neuro.cmd`：Neuro 的双击启动入口。
- `启动Evil.cmd`：Evil Neuro 的双击启动入口。
- `使用说明.txt`：简短的本地使用说明。

## 兼容性说明

本版本主要面向 Windows 10 和 Windows 11，并同时提供 64 位及 32 位 Java 8。原始 Shimeji 程序及其 JNA 桌面集成已经比较老旧，因此无法保证兼容所有 Windows 版本、企业安全策略、显示缩放设置或多显示器环境。准备分发给大量用户前，建议先在目标电脑上测试。

Java 8 运行时来自 Eclipse Adoptium Temurin 项目，其版本、许可证和 SHA-256 校验值可在 [`runtime/README.md`](runtime/README.md) 中查看。
