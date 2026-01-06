# Morphe Magisk Module
[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/DM008SU)
[![CI](https://github.com/kmdtaufik/morphe-magisk-module/actions/workflows/ci.yml/badge.svg?event=schedule)](https://github.com/kmdtaufik/morphe-magisk-module/actions/workflows/ci.yml)

Extensive Morphe builder.

Get the [latest CI release](https://github.com/kmdtaufik/morphe-magisk-module/releases).

Use [**zygisk-detach**](https://github.com/j-hc/zygisk-detach) to detach YouTube and YT Music from Play Store if you are using magisk modules.

<details><summary><big>Features</big></summary>
<ul>
 <li>Support MorpheApp for YouTube and YouTube Music</li>
 <li>Can build Magisk modules and non-root APKs</li>
 <li>Updated daily with the latest versions of apps and patches</li>
 <li>Optimize APKs and modules for size</li>
 <li>Modules</li>
    <ul>
     <li>recompile invalidated odex for faster usage</li>
     <li>receive updates from Magisk app</li>
     <li>do not break SafetyNet or trigger root detections</li>
     <li>handle installation of the correct version of the stock app automatically</li>
     <li>support Magisk and KernelSU</li>
    </ul>
</ul>
Note that the <a href=".github/workflows/ci.yml">CI workflow</a> is scheduled to build the modules and APKs everyday using GitHub Actions if there is a change in MorpheApp patches. You may want to disable it if you have forked this repository.
</details>

## To include/exclude patches or patch other apps

 * Star the repo :eyes:
 * Use the repo as a [template](https://github.com/new?template_name=morphe-magisk-module&template_owner=kmdtaufik)
 * Customize [`config.toml`](./config.toml) using [rvmm-config-gen](https://j-hc.github.io/rvmm-config-gen/)
 * Run the build [workflow](.github/workflows/build.yml)
 * Grab your modules and APKs from [releases](../../releases)

Also see [`CONFIG.md`](./CONFIG.md) for more configuration details.

## Building Locally
### On Termux
```console
bash <(curl -sSf https://raw.githubusercontent.com/kmdtaufik/morphe-magisk-module/main/build-termux.sh)
```

### On Desktop
```console
$ git clone https://github.com/kmdtaufik/morphe-magisk-module
$ cd morphe-magisk-module
$ ./build.sh
```

## Credits
* [j-hc/morphe-magisk-module](https://github.com/j-hc/morphe-magisk-module) - The original repository this project is based on.
* [MorpheApp](https://github.com/MorpheApp) - For the underlying patches and CLI tools.
