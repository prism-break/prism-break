# INSTRUCTIONS:
# npm install
# make 					# to compile targets
# make clean 		# to delete compiled files
# watch make 		# to periodically compile

# Binaries
BIN = ./node_modules/.bin/
LS_BIN = $(BIN)lsc
LS_PARAMS = -cob
STYLUS_BIN = $(BIN)stylus
STYLUS_PARAMS = -c -u ./node_modules/nib/

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
	mkdir -p public public/assets/css public/assets/js

render_html: 
	$(LS_BIN) $(JADE)

clean:
	rm -rf public/

all: mkdir_public $(CSS) render_html

uber: clean all

.PHONY: clean render_html
