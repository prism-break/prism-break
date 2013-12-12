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
STYLUS = ./source/stylesheets/screen.styl

# Outputs
CSS = ./public/assets/css/screen.css
HTML = ./public/**/*.html
JSON = ./public/**/*.json

$(CSS): $(STYLUS)
	$(STYLUS_BIN) $(STYLUS_PARAMS) <$< >$@

mkdir_public:
	mkdir -p public/assets/css public/assets/js

cp_images:
	mkdir -p public/assets/
	cp -r source/images public/assets/img

render_html: 
	$(LS_BIN) $(JADE)

clean:
	rm -rf public/

cssw:
	$(STYLUS_BIN) $(STYLUS_WATCH_PARAMS)

all: mkdir_public cp_images $(CSS) render_html

uber: clean all

.PHONY: clean render_html
