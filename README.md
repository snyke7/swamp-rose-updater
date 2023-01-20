# swamp-rose-updater

Custom updater for ROSE Online that works on Linux & MacOS.

## Installing ROSE on Linux with Lutris

Install [Lutris](https://lutris.net/downloads), then run
```
lutris lutris:rose-online-swamp-rose-installer
```
This will launch the installer, install ROSE and update it.

Whenever new patches arrive, you can: Open Lutris > Right-click ROSE Online > execute script.<br/>
This will start updating your ROSE in the background, so please wait a minute before launching the game.

If you are wondering how this works: Lutris can follow installation procedures defined in YAML files.
The command above will execute the procedure defined [here](https://github.com/snyke7/swamp-rose-updater/blob/main/swamp-rose-online.yaml).
This will simply fetch the installer, run it, and download a packaged version of [this shell script](https://github.com/snyke7/swamp-rose-updater/blob/main/swamp_rose_updater), which will update your ROSE installation.

## Updating ROSE on MacOS

Copy and run the following command into the Terminal:
```
brew tap snyke7/swamp-rose-brew https://github.com/snyke7/swamp-rose-updater && brew install --cask --no-quarantine swamp_rose_updater
```
This installs the updater as an application. The `--no-quarantine` part instructs your Mac to trust this app, and is necessary for the updater to function.

Now, look for swamp_rose_updater in your applications. Either run it, and navigate to your ROSE folder in the folder picker, or drop your ROSE folder onto the application. This should open a Terminal which prints a bunch of text about how it is trying to update your ROSE. The final line should be 'ROSE Online is up to date'.

## Further information

### Requirements for the [shell script](https://github.com/snyke7/swamp-rose-updater/blob/main/swamp_rose_updater)
You need access to the [bita](https://github.com/oll3/bita) library to use ROSE's update archives, and [jq](https://stedolan.github.io/jq/) for parsing the updates. Furthermore, you need [b2sum](https://www.blake2.net/#su) to quickly calculate hashes (think signatures) of files.
[bita](https://github.com/oll3/bita) is a Rust library, so you need access to Rust's `cargo` command for package management.
On apt-based systems, you can install `cargo` and `jq` with
```
sudo apt install cargo jq
```
Once you have access to cargo, use the following command to get access to the `bita` command.
```
cargo install bita --features zstd-compression
```
Now make sure that you have access to the `bita` command in your current shell.
```
bita --version
```
which should display something like `bita 0.10.0`. 
If this fails, `bita` is not accessible in your `PATH` variable. In my case, the `bita` executable is found in `/home/username/.cargo/bin`, 
and I need to run 
```
export PATH=$PATH:/home/username/.cargo/bin
```
to make `bita --version` work correctly.

`b2sum` is installed natively on Linux systems. For MacOS users, you can 
```
brew install coreutils
```
to get `b2sum`. (You do _not_ want the `b2sum` brew package, that command is missing the `-c` option that the script uses.)

### Releases

To avoid these dependencies, this repository automatically builds packaged versions of the script. These can be found [here](https://github.com/snyke7/swamp-rose-updater/releases). `swamp_rose_updater` is a Linux [AppImage](https://appimage.org/) which should be quite portable. `swamp_rose_updater.dmg` is a packaged Mac application.

### Usage of the script

If you **navigate to your ROSE source folder**, then run `swamp_rose_updater`, it will update your ROSE folder.<br/>
There is currently a single configuration option, obtained by placing a file called `no_update_list.txt` inside your ROSE folder.
By putting (relative) paths of files (separated by new lines) in that file, the updater will skip these files.
This can be useful for not losing UI modifications on updates. For example, the contents of my `no_update_list.txt` are:
```
3ddata/control/xml/dlginfo.xml
3ddata/control/xml/dlgminimap.xml
```
which are therefore not checked for updates.
