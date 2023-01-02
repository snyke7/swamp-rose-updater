# swamp-rose-updater

Custom updater for ROSE Online that works on Linux.

## Requirements

You need access to the [bita](https://github.com/oll3/bita) library to use ROSE's update archives.
[bita](https://github.com/oll3/bita) is a Rust library, so you need access to Rust's `cargo` command for package management.
On apt-based systems, you can install `cargo` with
```
sudo apt install cargo
```
Once you have access to cargo, use the following command to get access to the `bita` command.
```
cargo install bita --features zstd-compression
```
Now make sure that you have access to the `bita` command in your current shell.
```
bita --version
```
which should display something like `bita 0.10.0`. In my case, the `bita` executable is found in `/home/username/.cargo/bin`, 
and I need to run 
```
export PATH=$PATH:/home/username/.cargo/bin
```
before proceeding.

## Usage
If you are in a hurry and fully trust me (really, people can do [nasty](https://www.bleepingcomputer.com/news/security/dont-copy-paste-commands-from-webpages-you-can-get-hacked/) things with `curl | bash`).

**Navigate to your ROSE source folder** and run:
```
curl -s 'https://raw.githubusercontent.com/snyke7/swamp-rose-updater/main/swamp_rose_updater' | bash
```
Alternatively, download the [shell script](https://raw.githubusercontent.com/snyke7/swamp-rose-updater/main/swamp_rose_updater). 
Inspect it, and if you agree that it will not break your system, run it in your ROSE source folder.
