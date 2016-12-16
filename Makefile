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

# Figure out the absolute path to the directory where this Makefile is
BASE := $(shell cd "$(shell dirname $(lastword $(MAKEFILE_LIST)))/../" && pwd)

# Prepend the local NPM bin dir to the path for the scope of this Makefile
export PATH := $(BASE)/node_modules/.bin:$(PATH)

# Use yarn if the system has it, otherwise npm
NPM_HANDLER = $(shell hash yarn && echo yarn || echo npm)

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
	stylus -c -w source/stylesheets/screen.styl -u nib -o public/assets/css/

build_css:
	stylus -c -u ./node_modules/nib/ < ./source/stylesheets/screen.styl > ./tmp/assets/css/screen.css

build_%:
	lsc /source/functions/build/site-$*.ls

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
