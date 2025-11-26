# Cartridges-AppImage 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/Cartridges-AppImage/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/Cartridges-AppImage/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/Cartridges-AppImage/actions/workflows/appimage.yml/badge.svg)](https://github.com/pkgforge-dev/Cartridges-AppImage/releases/latest)

<p align="center">
  <img src="https://raw.githubusercontent.com/kra-mo/cartridges/refs/heads/main/data/icons/hicolor/scalable/apps/page.kramo.Cartridges.svg" width="128" />
</p>

* [Latest Stable Release](https://github.com/pkgforge-dev/Cartridges-AppImage/releases/latest)

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun), which makes it extremely easy to turn any binary into a portable package without using containers or similar tricks. 

**This AppImage bundles everything and should work on any linux distro, even on musl based ones.**

It is possible that this appimage may fail to work with appimagelauncher, I recommend these alternatives instead: 

* [AM](https://github.com/ivan-hc/AM) `am -i cartridges` or `appman -i cartridges`

* [dbin](https://github.com/xplshn/dbin) `dbin install cartridges.appimage`

* [soar](https://github.com/pkgforge/soar) `soar install cartridges`

This appimage works without fuse2 as it can use fuse3 instead, it can also work without fuse at all thanks to the [uruntime](https://github.com/VHSgunzo/uruntime)

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/29576c50-b39c-46c3-8c16-a54999438646" alt="Inspiration Image">
  </a>
</details>

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)

---

## Known quirks

- Usage of portable folders except cache breaks the searching directories for games, even if you select it in file-picker afterwards.
- Search-provider integration works only on Gnome (same as upstream) & it depends on:
  - the desktop file being present (which AppImage managers like `soar` & `am` already take care of).  
    Desktop file needs to be named `page.kramo.Cartridges.desktop` for it to work.  
    The only exception is the detection for desktop file `cartridges-AM.desktop` in local directories, which is added as a support for `am` AppImage manager.
  - the `XDG_DATA_DIRS` variable having the `XDG_DATA_HOME` in path, which the AppImage will detect if not present + warn about & suggest the solution.
  - This operation won't be performed if search integration files already exist in `/usr/share/` or `/usr/local/share/`, as it's assumed that the packager and/or system-administrator already handled that integration to the system. Modifying `XDG_DATA_DIRS` in that case is not needed.
  - If you use the AppImage portable folders feature, you only need to use portable `appimage-filename.config` and `appimage-filename.cache` folder to make the search-provider functionality work.
    - Those are the files that need to be in host's `${XDG_DATA_HOME}` for search-provider functionality to work, which you can delete after the app uninstallation, along with other app dotfiles:
      - `${XDG_DATA_HOME}/gnome-shell/search-providers/page.kramo.Cartridges.SearchProvider.ini`
      - `${XDG_DATA_HOME}/dbus-1/services/page.kramo.Cartridges.SearchProvider.service`
