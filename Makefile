build/bita:
	@git clone https://github.com/oll3/bita.git $@
	@git -C $@ am ../../bita-appimagetool.patch

build/output/portable_bita: build/bita
	@mkdir -p build/output
	@cd $< && cargo appimage --features=zstd-compression && mv *.AppImage ../../$@

build/output/jq:
	@wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O $@
	@chmod +x $@

clean:
	@echo CLEAN
	@rm -rf build
