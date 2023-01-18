build/bita_repo:
	@git clone https://github.com/oll3/bita.git $@
	@git -C $@ am ../../bita-appimagetool.patch

build/output/bita_linux: build/bita_repo
	@mkdir -p build/output
	@cd $< && cargo appimage --features=zstd-compression && mv *.AppImage ../../$@

build/output/bita_macos_amd64: build/bita_repo
	@mkdir -p build/output
	@cd $< && cargo build --release --features=zstd-compression && mv target/release/bita ../../$@

build/output/jq_linux:
	@mkdir -p build/output
	@wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O $@
	@chmod +x $@

build/output/jq_macos_amd64:
	@mkdir -p build/output
	@wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-osx-amd64 -O $@
	@chmod +x $@

APPDIR_BASE_FILES = $(wildcard appdir_base/*)
APPDIR_BUILD_FILES = $(patsubst appdir_base/%,build/AppDir/%, $(APPDIR_BASE_FILES))

VERSION = 0.1

build/AppDir/%: appdir_base/%
	@mkdir -p build/AppDir
	@cp $< $@

build/AppDir/usr/bin/bita: build/output/bita_linux
	@mkdir -p build/AppDir/usr/bin
	@cp $< $@

build/AppDir/usr/bin/jq: build/output/jq_linux
	@mkdir -p build/AppDir/usr/bin
	@cp $< $@

build/AppDir/usr/bin/swamp_rose_updater: swamp_rose_updater
	@mkdir -p build/AppDir/usr/bin
	@cp $< $@

build/output/linux/swamp_rose_updater-$(VERSION)-x86_64.AppImage: $(APPDIR_BUILD_FILES) build/AppDir/usr/bin/bita build/AppDir/usr/bin/jq build/AppDir/usr/bin/swamp_rose_updater
	@mkdir -p build/output/linux
	@export VERSION=$(VERSION) && cd build/output/linux && linuxdeploy --appdir ../../AppDir --output appimage

build/output/linux/swamp_rose_updater: build/output/linux/swamp_rose_updater-$(VERSION)-x86_64.AppImage
	@cp $< $@

build/output/macos/swamp_rose_updater.app/Contents/Info.plist: macapp_base/swamp_rose_dnd.appscript
	@mkdir -p build/output/macos/
	@osacompile -o build/output/macos/swamp_rose_updater.app $<

build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/swamp_rose_updater: swamp_rose_updater
	@mkdir -p build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin
	@cp $< $@

build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/swamp_rose_bootstrap: macapp_base/swamp_rose_bootstrap
	@mkdir -p build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin
	@cp $< $@

build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/bita: build/output/bita_macos_amd64
	@mkdir -p build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin
	@cp $< $@

build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/jq: build/output/jq_macos_amd64
	@mkdir -p build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin
	@cp $< $@

linux_updater: build/output/linux/swamp_rose_updater

macos_updater: build/output/macos/swamp_rose_updater.app/Contents/Info.plist build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/swamp_rose_bootstrap build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/swamp_rose_updater build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/jq build/output/macos/swamp_rose_updater.app/Contents/MacOS/bin/bita

clean:
	@echo CLEAN
	@rm -rf build
