# swamp-rose-updater

Custom updater for ROSE Online that works on Linux & MacOS.

## Installing ROSE on Linux with Lutris.

Install [Lutris](https://lutris.net/downloads), then simply [click here](lutris:rose-online-swamp-rose-installer).
This will launch the installer, install ROSE and update it.
When new patches arrive: Open Lutris > Right-click ROSE Online > execute script.
This will start updating your ROSE in the background, please wait a minute before launching the game.

If you are wondering how this works: Lutris can follow installation procedures defined in YAML files.
The link above will execute the procedure defined [here](https://github.com/snyke7/swamp-rose-updater/blob/main/swamp-rose-online.yaml).
This will simply fetch the installer, run it, and download a packaged version of [this shell script](https://github.com/snyke7/swamp-rose-updater/blob/main/swamp_rose_updater), which will update your ROSE installation.

## Updating ROSE on MacOS.

Copy and run the following command into the Terminal:
```
brew tap snyke7/swamp-rose-brew https://github.com/snyke7/swamp-rose-updater && brew install --cask --no-quarantine swamp_rose_updater
```
This installs the updater as an application. The `--no-quarantine` part instructs your Mac to trust this app, and is necessary for the updater to function.

Now, look for swamp_rose_updater in your applications. Either run it, and navigate to your ROSE folder in the folder picker, or drop your ROSE folder onto the application. This should open a Terminal which prints a bunch of text about how it is trying to update your ROSE. The final line should be 'ROSE Online is up to date'.

## Requirements

You need access to the [bita](https://github.com/oll3/bita) library to use ROSE's update archives, and [jq](https://stedolan.github.io/jq/) for parsing the updates.
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

## Usage
If you are in a hurry and fully trust me (really, people can do [nasty](https://www.bleepingcomputer.com/news/security/dont-copy-paste-commands-from-webpages-you-can-get-hacked/) things with `curl | bash`).

**Navigate to your ROSE source folder** and run:
```
curl -s 'https://raw.githubusercontent.com/snyke7/swamp-rose-updater/main/swamp_rose_updater' | bash
```
Alternatively, download the [shell script](https://raw.githubusercontent.com/snyke7/swamp-rose-updater/main/swamp_rose_updater). 
Inspect it, and if you agree that it will not break your system, run it in your ROSE source folder.
