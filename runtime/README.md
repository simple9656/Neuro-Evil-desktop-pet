# Bundled Java Runtime

These vendor archives contain Eclipse Temurin JRE 8 builds for Windows:

- `OpenJDK8U-jre_x64_windows_hotspot_8u512b09.zip`: Temurin 8u512-b09, x64.
- `OpenJDK8U-jre_x86-32_windows_hotspot_8u472b08.zip`: Temurin 8u472-b08, x86/32-bit.

The launcher extracts the selected archive to `%LOCALAPPDATA%\Neuro-Evil-Desktop-Pet\runtime` on first run. The archives retain each runtime's upstream `LICENSE`, `NOTICE`, `ASSEMBLY_EXCEPTION`, and `THIRD_PARTY_README` files. The source packages and SHA-256 values are:

- `OpenJDK8U-jre_x64_windows_hotspot_8u512b09.zip` - `AE1AE12F817D7735477C6555107EECE73854DA0654DA69077309EF9BFF0B78BF`
- `OpenJDK8U-jre_x86-32_windows_hotspot_8u472b08.zip` - `21A2C5AF684A658F1484DAA85EABF4961AB9DE28C0EFBF31DA2381D77FCE3B5F`

Both are from the Eclipse Adoptium Temurin 8 binaries project. The x86 Windows build is older because the x86 release line is not updated in lockstep with x64.
