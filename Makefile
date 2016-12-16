# make	 					build the entire site (all languages)
# make init					install NPM dependencies
# make en					build the English edition (replace 'en' with 'fr' for French)
# make clean				destroy built files
# make reset				destroy built files and build the entire site
# make watch_css			watches for stylus (CSS) edits and compiles it

#----------------------------------------------------------------------
# CONFIGURATION
#----------------------------------------------------------------------

# Collect list of languages based on available locale files
LANGUAGES = $(shell find ./source/locales/ -name '*.json' -execdir basename -s .json {} \;)

# Mark all rules that don’t actually check whether they need building
.PHONY: default init assets watch_css css html_% html clean_tmp clean_public sync all test clean reset $(LANGUAGES)

# Turn on expansion so we can reference target patterns in our dependencies list
.SECONDEXPANSION:

# Don’t delete intermediary targets after building
.SECONDARY:

# Figure out the absolute path to the directory where this Makefile is
BASE := $(shell cd "$(shell dirname $(lastword $(MAKEFILE_LIST)))" && pwd)

# Prepend the local NPM bin dir to the path for the scope of this Makefile
export PATH := $(BASE)/node_modules/.bin:$(PATH)

# Use yarn if the system has it, otherwise npm
NPM_HANDLER = $(shell hash yarn && echo yarn || echo npm)

ASSETS = fonts icons images

#----------------------------------------------------------------------
# COMMANDS
#----------------------------------------------------------------------

# Explicitly set the default make target
default: clean_tmp init all public ;

# Use building one language as a check to see if everything works
test: en ;

clean: clean_tmp clean_public ;

reset: clean default ;

init: node_modules assets ;

# Targets to build all languages
all: css html ;

html: $(foreach LANGUAGE,$(LANGUAGES),html_$(LANGUAGE)) ;

# Targets for rebuilding a single language
$(LANGUAGES): clean_tmp init css html_$$@ public ;

#----------------------------------------------------------------------
# CONVENIENCE ALIASES
#----------------------------------------------------------------------

assets: $(foreach ASSET,$(ASSETS),tmp/assets/$(ASSET)) ;

css: tmp/assets/css/screen.css ;

html_%: tmp/%/index.html ;

#----------------------------------------------------------------------
# FUNCTIONS
#----------------------------------------------------------------------

node_modules: package.json
	$(NPM_HANDLER) install
	touch node_modules

# Copy fixed assets from the source tree (if newer files exist)
tmp/assets/%: source/assets/% | $$(shell find source/assets/$$* -type f)
	mkdir -p $(dir $@)
	rsync -r $</ $@/

# Rebuild stylesheet if any of the input templates change
tmp/assets/css/%.css: source/stylesheets/%.styl | $(shell git ls-files *.styl)
	mkdir -p $(dir $@)
	stylus -c -u nib < $< > $@

# Use script to rebuild index if index is older than any files with this locale in the name
tmp/%/index.html: source/functions/build/site-%.ls | $$(shell git ls-files | grep '\b$$*\b')
	lsc $<

clean_tmp:
	rm -rf tmp/*

clean_public:
	rm -rf public/*

# Copy the scratch workspace into the final output directory if anything files in there are new
public: tmp public/.htaccess | $(shell find tmp -type f)
	rsync -r $</ $@/

public/.htacces: source/dotfiles/.htaccess
	mkdir -p $(dir $@)
	cp $< $@

#----------------------------------------------------------------------
# CONVENIENCE FUNCTIONS
#----------------------------------------------------------------------

# Rebuild CSS live on input changes
watch_css:
	stylus -c -w source/stylesheets/screen.styl -u nib -o public/assets/css/

# copy ./public to another repository and commit changes
sync:
	rsync -azru --delete --stats public/ ../prism-break-static/public/
	(cd ../prism-break-static; git add -A; git commit -m 'regenerate'; git push)
