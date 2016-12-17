# make	 					build the entire site (all languages)
# make init					just install NPM dependencies
# make en					build just the English edition (replace 'en' with 'fr' for French, etc.)
# make clean				destroy built files
# make reset				destroy built files and build all languages from scratch
# make watch_css			watches for stylus (CSS) edits and compiles it

#----------------------------------------------------------------------
# CONFIGURATION
#----------------------------------------------------------------------

# Collect list of languages based on available locale files
LANGUAGES := $(notdir $(basename $(wildcard source/locales/*.json)))

# Collect list of static assets that get copied over
ASSETS := $(notdir $(wildcard source/assets/*))

# Mark all rules that don’t actually check whether they need building
.PHONY: default test init reset all $(LANGUAGES) assets css html html_% clean watch watch_css sync

# Turn on expansion so we can reference target patterns in our dependencies list
.SECONDEXPANSION:

# Don’t delete intermediary targets after building
.SECONDARY:

# Figure out the absolute path to the directory where this Makefile is
BASE := $(shell cd "$(shell dirname $(lastword $(MAKEFILE_LIST)))" && pwd)

# Prepend the local NPM bin dir to the path for the scope of this Makefile
export PATH := $(BASE)/node_modules/.bin:$(PATH)

# Use yarn if the system has it, otherwise npm
NPM_HANDLER ?= $(shell hash yarn && echo yarn || echo npm)

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

# Explicitly set the default target to do everything that isn’t already done
default: init assets all public ;

# Run anything that needs doing post-checkout to make this buildable
init: node_modules ;

# Use building English language as a check to see if everything works
test: en ;

# Start fresh and rebuild everything
reset: clean default ;

# Targets to build all the dynamically generated stuff for all languages
all: css html ;

# Targets for rebuilding only single language and only what isn’t already done
$(LANGUAGES): init assets css html_$$@ public ;

#----------------------------------------------------------------------
# CONVENIENCE ALIASES
#----------------------------------------------------------------------

assets: $(foreach ASSET,$(ASSETS),public/assets/$(ASSET)) ;

css: public/assets/css/screen.css ;

html: $(foreach LANGUAGE,$(LANGUAGES),html_$(LANGUAGE)) ;

html_%: public/%/index.html ;

public: public/.htaccess ;

#----------------------------------------------------------------------
# FUNCTIONS
#----------------------------------------------------------------------

node_modules: package.json
	$(NPM_HANDLER) install
	touch node_modules

# Copy fixed assets from the source tree (if newer files exist)
public/assets/%: source/assets/% $$(shell find source/assets/$$* -type f)
	mkdir -p $(dir $@)
	rsync -r $</ $@/

# Rebuild stylesheet if any of the input templates change
public/assets/css/%.css: source/stylesheets/%.styl $(shell git ls-files *.styl)
	mkdir -p $(dir $@)
	stylus -c -u nib < $< > $@

# Use script to rebuild index if index is older than any files with this locale in the name
public/%/index.html: source/functions/build/site-%.ls $$(shell git ls-files | grep '\b$$*\b')
	lsc $<

clean:
	rm -rf public/*

public/.htaccess: source/dotfiles/.htaccess
	mkdir -p $(dir $@)
	cp $< $@

#----------------------------------------------------------------------
# CONVENIENCE FUNCTIONS
#----------------------------------------------------------------------

watch:
	git ls-files | entr -p make $(WATCH_ARGS)

# Rebuild CSS live on input changes
watch_css:
	stylus -c -w source/stylesheets/screen.styl -u nib -o public/assets/css/

# copy ./public to another repository and commit changes
sync:
	rsync -azru --delete --stats public/ ../prism-break-static/public/
	(cd ../prism-break-static; git add -A; git commit -m 'regenerate'; git push)
