# COMMANDS (more in README.md)
# make all					build /tmp and copy to /public
# make clean				destroy built files
# make reset				destroy built files and rebuild everything
# make watch_css		run "stylus --watch" for css edits

# BINARIES
BIN = ./node_modules/.bin/
LIVESCRIPT_BIN = $(BIN)lsc
LIVESCRIPT_PARAMS = -cob
STYLUS_BIN = $(BIN)stylus
STYLUS_PARAMS = -c -u ./node_modules/nib/
STYLUS_WATCH_PARAMS = -c -w source/stylesheets/screen.styl -u ./node_modules/nib/ -o public/assets/css/

# INPUTS
BUILD_DIR = ./source/functions/build/site-
STYL = ./source/stylesheets/screen.styl

# OUTPUTS
CSS = ./tmp/assets/css/screen.css

mkdirs:
	mkdir -p tmp/assets/css tmp/assets/js

copy_assets:
	cp -r source/assets/fonts tmp/assets/fonts
	cp -r source/assets/icons tmp/assets/ico
	cp -r source/assets/images tmp/assets/img

watch_css:
	$(STYLUS_BIN) $(STYLUS_WATCH_PARAMS)

build_css:
	$(STYLUS_BIN) $(STYLUS_PARAMS) <$(STYL) >$(CSS)

build_de:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)de.ls

build_en:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)en.ls

build_fr:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)fr.ls

build_it:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)it.ls
	
build_html:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ar.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ca.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)de.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)el.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)en.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)eo.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)es.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)fa.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)fi.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)fr.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)he.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)hi.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)io.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)it.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ja.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)nl.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)no.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)pl.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)pt.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ru.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)sr-Cyrl.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)sr.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)sv.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)tr.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)zh-CN.ls
	$(LIVESCRIPT_BIN) $(BUILD_DIR)zh-TW.ls

clean_tmp:
	rm -rf tmp/*

clean_public:
	rm -rf public/*

finalize:
	mkdir -p public
	cp -r source/dotfiles/.htaccess public
	cp -r tmp/* public/
	rm -rf tmp

# copy ./public to another repository and commit changes
sync:
	rsync -azru --delete --stats public/ ../prism-break-static/public/
	(cd ../prism-break-static; git add -A; git commit -m 'regenerate'; git push)

# ORGANIZE
build_all: build_css build_html

# MAIN COMMANDS
all: clean_tmp mkdirs copy_assets build_all finalize
test: clean_tmp mkdirs copy_assets build_en finalize
clean: clean_tmp clean_public
reset: clean_public all

# LANGUAGE SPEIFIC
de: clean_tmp mkdirs copy_assets build_de finalize
en: clean_tmp mkdirs copy_assets build_en finalize
it: clean_tmp mkdirs copy_assets build_it finalize

# PHONY
.PHONY: watch_css render_html clean_tmp clean_public
