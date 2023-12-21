# Psych Engine Mobile Build Instructions

* [Dependencies](#dependencies)
* [Building](#building)

---

# Dependencies

- `git`
- Android NDK (r21e or greater), Android SDK, JDK (11 or greater)
- Haxe (4.2.5 or greater)

---

## Getting Dependencies

<details>
  <summary>Windows</summary>

* [JDK 11](https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.21%2B9/OpenJDK11U-jdk_x64_windows_hotspot_11.0.21_9.msi)
* [Android SDK](https://www.mediafire.com/file/nmk5g9bg58rmnpt/Sdk.7z/file)
* [Android NDK r26b](https://dl.google.com/android/repository/android-ndk-r26b-windows.zip)
</details>

<details>
  <summary>Linux</summary>

* [JDK 11](https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.21%2B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.21_9.tar.gz)
* [Android NDK r26b](https://dl.google.com/android/repository/android-ndk-r26b-linux.zip)
</details>

<details>
  <summary>Mac</summary>

* [JDK 11](https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.21%2B9/OpenJDK11U-jdk_x64_mac_hotspot_11.0.21_9.tar.gz)
* [Android NDK r26b](https://dl.google.com/android/repository/android-ndk-r26b-darwin.dmg)
</details>

# Setuping

TODO

# Building

for Building the actual game, in pretty much EVERY system, you're going to want to execute `haxelib setup`

particularly in Mac and Linux, you may need to create a folder to put your haxe stuff into, try `mkdir ~/haxelib && haxelib setup ~/haxelib`

after run `haxelib run lime build android` to build

### "It's taking a while, should I be worried?"

No, that is normal, when you compile flixel games for the first time, it usually takes around 10 to 20 minutes,
It really depends on how powerful your hardware is
---
