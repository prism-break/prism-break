# INSTRUCTIONS:
# npm install
# make 					# to compile targets
# make clean 		# to delete compiled files
# watch make 		# to periodically compile

# Binaries
BIN = ./node_modules/.bin/
LIVESCRIPT_BIN = $(BIN)lsc
LIVESCRIPT_PARAMS = -cob
STYLUS_BIN = $(BIN)stylus
STYLUS_PARAMS = -c -u ./node_modules/nib/
STYLUS_WATCH_PARAMS = -c -w source/stylesheets/screen.styl -u ./node_modules/nib/ -o public/assets/css/

# Inputs
VIEWS = ./source/functions/build.ls
STYL = ./source/stylesheets/screen.styl

# Outputs
CSS = ./public/assets/css/screen.css

mkdirs:
	mkdir -p public/assets/css public/assets/js

copy_assets:
	cp -r source/assets/images public/assets/img
	cp -r source/assets/fonts public/assets/fonts

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
