# make	 					build the entire site (all languages)
# make deps					install NPM dependencies
# make en					build the English edition (replace 'en' with 'fr' for French)
# make clean				destroy built files
# make reset				destroy built files and build the entire site
# make watch_css			watches for stylus (CSS) edits and compiles it

#----------------------------------------------------------------------
# CONFIGURATION
#----------------------------------------------------------------------

# Explicitly set the default make target
default: clean_tmp mkdirs deps copy_assets build_all finalize

# Mark all rules that don’t actually check whether they need building
.PHONY: default deps mkdirs copy_assets watch_css build_css build_% build_html clean_tmp clean_public finalize sync build_all test clean reset

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

build_html:	build_ar build_ca build_de build_el build_en build_eo build_es build_fa build_fi build_fr build_he build_hi build_io build_it build_ja build_nl build_no build_pl build_pt build_ru build_sr-Cyrl build_sr build_sv build_tr build_zh-CN build_zh-TW

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

# Language Specific

ar: clean_tmp mkdirs copy_assets build_ar finalize
ca: clean_tmp mkdirs copy_assets build_ca finalize
de: clean_tmp mkdirs copy_assets build_de finalize
el: clean_tmp mkdirs copy_assets build_el finalize
en: clean_tmp mkdirs copy_assets build_en finalize
eo: clean_tmp mkdirs copy_assets build_eo finalize
es: clean_tmp mkdirs copy_assets build_es finalize
fa: clean_tmp mkdirs copy_assets build_fa finalize
fi: clean_tmp mkdirs copy_assets build_fi finalize
fr: clean_tmp mkdirs copy_assets build_fr finalize
he: clean_tmp mkdirs copy_assets build_he finalize
hi: clean_tmp mkdirs copy_assets build_hi finalize
io: clean_tmp mkdirs copy_assets build_io finalize
it: clean_tmp mkdirs copy_assets build_it finalize
ja: clean_tmp mkdirs copy_assets build_ja finalize
nl: clean_tmp mkdirs copy_assets build_nl finalize
no: clean_tmp mkdirs copy_assets build_no finalize
pl: clean_tmp mkdirs copy_assets build_pl finalize
pt: clean_tmp mkdirs copy_assets build_pt finalize
ru: clean_tmp mkdirs copy_assets build_ru finalize
sr-Cyrl: clean_tmp mkdirs copy_assets build_sr-Cyrl finalize
sr: clean_tmp mkdirs copy_assets build_sr finalize
sv: clean_tmp mkdirs copy_assets build_sv finalize
tr: clean_tmp mkdirs copy_assets build_tr finalize
zh-CN: clean_tmp mkdirs copy_assets build_zh-CN finalize
zh-TW: clean_tmp mkdirs copy_assets build_zh-TW finalize
