### Prince of Persia: Warrior Within ~ Widescreen Launcher v2

This *PoP WW* launcher is based on **[UniGame Launcher v1.1.0](https://github.com/alex47exe/UniGame-Launcher/releases/tag/v1.1.0)** and **nemesis2000**'s **widescreen fix** at [http://ps2wide.net](http://ps2wide.net/pc.html#popww), already included

------

***Features:***

- includes *[RunFirst.exe](https://www.activeplus.com/products/runfirst)*, which is unpacked at first launch in *C:\Program Data\SalFisher47* - game will run on the first cpu core, to avoid extreme gameplay speed on multi-core cpus
- automatically detects resolution and modifies it to *pop2.ini*
- when *POP2.exe* runs the first time, *Hardware.ini* gets reset to some default values, causing some graphical issues when fog is enabled; to avoid this, launcher uses *blank.exe* instead of *POP2.exe* at first run, then it automatically corrects those values and launches the game
- launcher runs as administrator only at first launch, if `run_admin = 1` in *ini* file

------

***Requirements:***

1. Prince of Persia: Warrior Within - any version

------

