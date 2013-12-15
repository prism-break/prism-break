# COMMANDS (more in README.md)
# make all					build the entire /public directory
# make clean				destroy the /public directory
# make uber					destroy /public and rebuild it
# make watch_css		run "stylus --watch" for css edits

# BINARIES
BIN = ./node_modules/.bin/
LIVESCRIPT_BIN = $(BIN)lsc
LIVESCRIPT_PARAMS = -cob
STYLUS_BIN = $(BIN)stylus
STYLUS_PARAMS = -c -u ./node_modules/nib/
STYLUS_WATCH_PARAMS = -c -w source/stylesheets/screen.styl -u ./node_modules/nib/ -o public/assets/css/

# INPUTS
VIEWS = ./source/functions/build.ls
STYL = ./source/stylesheets/screen.styl

# OUTPUTS
CSS = ./public/assets/css/screen.css

mkdirs:
	mkdir -p public/assets/css public/assets/js

copy_assets:
	cp -r source/assets/fonts public/assets/fonts
	cp -r source/assets/icons public/assets/ico
	cp -r source/assets/images public/assets/img
	cp -r source/dotfiles/.htaccess public

watch_css:
	$(STYLUS_BIN) $(STYLUS_WATCH_PARAMS)

build_css:
	$(STYLUS_BIN) $(STYLUS_PARAMS) <$(STYL) >$(CSS)

build_html:
	$(LIVESCRIPT_BIN) $(VIEWS)

clean:
	rm -rf public/

build_all: build_css build_html

all: mkdirs copy_assets build_all

uber: clean all

.PHONY: watch_css render_html clean
