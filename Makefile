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
JADE = source/templates/index.ls
#LS_DIR = source/ls/
#JS_DIR = source/js/
#JS_ALL = source/js/*.js
STYLUS = source/stylesheets/screen.styl

# Outputs
CSS = public/assets/css/screen.css
#JS_CAT = public/js/main.js
HTML = public/**/*.html
JSON = public/**/*.json

$(CSS): $(STYLUS)
	$(STYLUS_BIN) $(STYLUS_PARAMS) <$< >$@

#$(JS_DIR): $(LS_DIR)
#	$(LS_BIN) $(LS_PARAMS) $@ $<

#$(JS_CAT): $(JS_ALL)
#	cat $^ > $@

render_html: 
	$(LS_BIN) $(JADE)

clean:
	rm -rf $(CSS) $(HTML) $(JSON)

all: $(CSS) render_html

uber: clean all

.PHONY: clean render_html
