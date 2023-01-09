build/bita_repo:
	@git clone https://github.com/oll3/bita.git $@
	@git -C $@ am ../../bita-appimagetool.patch

build/output/bita: build/bita_repo
	@mkdir -p build/output
	@cd $< && cargo appimage --features=zstd-compression && mv *.AppImage ../../$@

build/output/jq:
	@mkdir -p build/output
	@wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O $@
	@chmod +x $@

APPDIR_BASE_FILES = $(wildcard appdir_base/*)
APPDIR_BUILD_FILES = $(patsubst appdir_base/%,build/AppDir/%, $(APPDIR_BASE_FILES))

VERSION = 0.1

build/AppDir/%: appdir_base/%
	@mkdir -p build/AppDir
	@cp $< $@

build/AppDir/usr/bin/bita: build/output/bita
	@mkdir -p build/AppDir/usr/bin
	@cp $< $@

build/AppDir/usr/bin/jq: build/output/jq
	@mkdir -p build/AppDir/usr/bin
	@cp $< $@

build/AppDir/usr/bin/swamp_rose_updater: swamp_rose_updater
	@mkdir -p build/AppDir/usr/bin
	@cp $< $@

build/output/swamp_rose_updater-$(VERSION)-x86_64.AppImage: $(APPDIR_BUILD_FILES) build/AppDir/usr/bin/bita build/AppDir/usr/bin/jq build/AppDir/usr/bin/swamp_rose_updater
	@export VERSION=$(VERSION) && cd build/output && linuxdeploy --appdir ../AppDir --output appimage

build/output/swamp_rose_updater: build/output/swamp_rose_updater-$(VERSION)-x86_64.AppImage
	@cp $< $@

clean:
	@echo CLEAN
	@rm -rf build
