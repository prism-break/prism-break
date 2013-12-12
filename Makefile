# INSTRUCTIONS:
# npm install
# make 					# to compile targets
# make clean 		# to delete compiled files
# make cssw 		# to watch stylus for changes
# watch make 		# to periodically compile

# Binaries
BIN = ./node_modules/.bin/
LS_BIN = $(BIN)lsc
LS_PARAMS = -cob
STYLUS_BIN = $(BIN)stylus
STYLUS_PARAMS = -c -u ./node_modules/nib/
STYLUS_WATCH_PARAMS = -c -w source/stylesheets/screen.styl -u ./node_modules/nib/ -o public/assets/css/

# Inputs
JADE = ./source/templates/index.ls
STYL = ./source/stylesheets/screen.styl

# Outputs
CSS = ./public/assets/css/screen.css
HTML = ./public/**/*.html
JSON = ./public/**/*.json

mkdirs:
	mkdir -p public/assets/css public/assets/js

copy:
	cp -r source/images public/assets/img

render_css:
	$(STYLUS_BIN) $(STYLUS_PARAMS) <$(STYL) >$(CSS)

render_html: 
	$(LS_BIN) $(JADE)

clean:
	rm -rf public/

cssw:
	$(STYLUS_BIN) $(STYLUS_WATCH_PARAMS)

all: mkdirs copy render_css render_html

uber: clean all

.PHONY: clean render_html
