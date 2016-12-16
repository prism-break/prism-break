# make	 					build the entire site (all languages)
# make deps					install NPM dependencies
# make en					build the English edition (replace 'en' with 'fr' for French)
# make clean				destroy built files
# make reset				destroy built files and build the entire site
# make watch_css			watches for stylus (CSS) edits and compiles it

#----------------------------------------------------------------------
# CONFIGURATION
#----------------------------------------------------------------------

# Collect list of languages based on available locale files
LANGUAGES = $(shell find ./source/locales/ -name '*.json' -execdir basename -s .json {} \;)

# Explicitly set the default make target
default: clean_tmp mkdirs deps copy_assets build_all finalize

# Mark all rules that don’t actually check whether they need building
.PHONY: default deps mkdirs copy_assets watch_css build_css build_% build_html clean_tmp clean_public finalize sync build_all test clean reset $(LANGUAGES)

# Turn on expansion so we can reference target patterns in our dependencies list
.SECONDEXPANSION:

#----------------------------------------------------------------------
# ALIASES
#----------------------------------------------------------------------

# Binaries
BIN = ./node_modules/.bin/
LIVESCRIPT_BIN = $(BIN)lsc
LIVESCRIPT_PARAMS = -cob
STYLUS_BIN = $(BIN)stylus
STYLUS_PARAMS = -c -u ./node_modules/nib/
STYLUS_WATCH_PARAMS = -c -w source/stylesheets/screen.styl -u nib -o public/assets/css/
NPM_HANDLER = $(shell hash yarn && echo yarn || echo npm)

# Inputs
BUILD_DIR = ./source/functions/build/site-
STYL = ./source/stylesheets/screen.styl

# Outputs
CSS = ./tmp/assets/css/screen.css


#----------------------------------------------------------------------
# FUNCTIONS
#----------------------------------------------------------------------

deps:
	$(NPM_HANDLER) install

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

build_%:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)$*.ls

build_html: $(foreach LANGUAGE,$(LANGUAGES),build_$(LANGUAGE))

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

# Organize
build_all: build_css build_html

#----------------------------------------------------------------------
# COMMANDS
#----------------------------------------------------------------------

# General

test: clean_tmp mkdirs copy_assets build_css build_en finalize
clean: clean_tmp clean_public
reset: clean_public default

# Targets for rebuilding a single language
$(LANGUAGES): clean_tmp mkdirs copy_assets build_$$@ finalize
