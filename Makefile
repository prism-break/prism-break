# make	 					build the entire site (all languages)
# make test					run internal tests such as linting the source
# make all 					test and build the entire site (all languages)
# make init					just install NPM dependencies
# make en					build just the English edition (replace 'en' with 'fr' for French, etc.)
# make clean				destroy built files
# make reset				destroy built files and build all languages from scratch
# make watch [...]			watch for any source changes and rebuild everything
# make watch_css			watch for stylus changes and rebuild just CSS

#----------------------------------------------------------------------
# CONFIGURATION
#----------------------------------------------------------------------

# Collect list of languages based on available locale files
LANGUAGES := $(notdir $(basename $(wildcard source/locales/*.json)))

# Collect list of static assets that get copied over
ASSETS := $(notdir $(wildcard source/assets/*))

# Turn on expansion so we can reference target patterns in our dependencies list
.SECONDEXPANSION:

# Don’t delete intermediary targets after building
.SECONDARY:

# Figure out the absolute path to the directory where this Makefile is
BASE := $(shell cd "$(shell dirname $(lastword $(MAKEFILE_LIST)))" && pwd)

# This is a hack for the ‘watch’ targets later on. It has to be
# early to nullify any targets that might otherwise run, but in
# the end allows extra parameters to be passed on to the next make
ifeq (watch,$(firstword $(MAKECMDGOALS)))
  WATCH_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(WATCH_ARGS):;@:)
endif

#----------------------------------------------------------------------
# COMMANDS
#----------------------------------------------------------------------

# Explicitly set the default target that does the minimum possible
.PHONY: default
default: assets full

# This is the kitchen-sink build that does everything
.PHONY: all
all: lint assets full

# Run anything that needs doing post-checkout to make this buildable
.PHONY: init
init: node_modules

# Use building English language as a check to see if everything works
.PHONY: test
test: lint en

.PHONY: lint
lint: $(foreach SOURCE,$(shell find source -type f -name '*.json'),$(SOURCE).lint)

%.lint: %
	npx jsonlint -q $<
	touch $@

# Start fresh and rebuild everything
.PHONY: reset
reset: clean default

# Targets to build all the dynamically generated stuff for all languages
.PHONY: full
full: css html public/index.html

# Targets for rebuilding only single language and only what isn’t already done
.PHONY: $(LANGUAGES)
$(LANGUAGES): assets css html_$$@

#----------------------------------------------------------------------
# CONVENIENCE ALIASES
#----------------------------------------------------------------------

.PHONY: assets
assets: init $(foreach ASSET,$(ASSETS),public/assets/$(ASSET))

.PHONY: css
css: init public/assets/css/screen.css

.PHONY: html
html: init $(foreach LANGUAGE,$(LANGUAGES),html_$(LANGUAGE))

HTMLLANGS = $(foreach LANGUAGE,$(LANGUAGES),html_$(LANGUAGE))
.PHONY: $(HTMLLANGS)
$(HTMLLANGS): html_%: public/%/index.html

#----------------------------------------------------------------------
# FUNCTIONS
#----------------------------------------------------------------------

node_modules package-lock.json: package.json
	npm install

# Copy fixed assets from the source tree (if newer files exist)
public/assets/%: source/assets/% $$(shell find source/assets/$$* -type f)
	mkdir -p $(dir $@)
	rsync -r $</ $@/

# Rebuild stylesheet if any of the input templates change
public/assets/css/%.css: source/stylesheets/%.styl $(shell git ls-files *.styl)
	mkdir -p $(dir $@)
	npx stylus -c -u nib $< -o $@

public/index.html: source/index.html
	cp $< $@

# Use script to rebuild index if index is older than any files with this locale in the name
public/%/index.html: source/functions/build/site-%.ls $$(shell git ls-files | grep '\b$$*\b')
	npx lsc $<

.PHONY: clean
clean:
	rm -rf public/*
	find -type f -name '*.json.lint' -delete

# Localizations
LOCALLANGS = $(foreach LANGUAGE,$(LANGUAGES),localize_$(LANGUAGE))
.PHONY: $(LOCALLANGS)
$(LOCALLANGS): localize_%:
	npx lsc ./source/functions/find-missing-localizations.ls $*

#----------------------------------------------------------------------
# CONVENIENCE FUNCTIONS
#----------------------------------------------------------------------

.PHONY: watch
watch:
	git ls-files | entr -p make $(WATCH_ARGS)

.PHONY: serve
serve:
	npx http-server

# Rebuild CSS live on input changes
.PHONY: watch_css
watch_css:
	npx stylus -c -u nib -w source/stylesheets/screen.styl -o public/assets/css/
