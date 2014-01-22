# make all					build the entire site (all languages)
# make en						build the English edition (replace 'en' with 'fr' for French)
# make clean				destroy built files
# make reset				destroy built files and build the entire site
# make watch_css		watches for stylus (CSS) edits and compiles it

#---------------------------------------------------------------------- 
# ALIASES 
#---------------------------------------------------------------------- 

# Binaries
BIN = ./node_modules/.bin/
LIVESCRIPT_BIN = $(BIN)lsc
LIVESCRIPT_PARAMS = -cob
STYLUS_BIN = $(BIN)stylus
STYLUS_PARAMS = -c -u ./node_modules/nib/
STYLUS_WATCH_PARAMS = -c -w source/stylesheets/screen.styl -u ./node_modules/nib/ -o public/assets/css/

# Inputs
BUILD_DIR = ./source/functions/build/site-
STYL = ./source/stylesheets/screen.styl

# Outputs
CSS = ./tmp/assets/css/screen.css

#---------------------------------------------------------------------- 
# FUNCTIONS 
#---------------------------------------------------------------------- 

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

build_ar:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ar.ls
build_ca:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ca.ls
build_de:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)de.ls
build_el:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)el.ls
build_en:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)en.ls
build_eo:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)eo.ls
build_es:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)es.ls
build_fa:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)fa.ls
build_fi:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)fi.ls
build_fr:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)fr.ls
build_he:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)he.ls
build_hi:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)hi.ls
build_io:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)io.ls
build_it:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)it.ls
build_ja:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ja.ls
build_nl:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)nl.ls
build_no:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)no.ls
build_pl:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)pl.ls
build_pt:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)pt.ls
build_ru:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)ru.ls
build_sr-Cyrl:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)sr-Cyrl.ls
build_sr:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)sr.ls
build_sv:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)sv.ls
build_tr:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)tr.ls
build_zh-CN:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)zh-CN.ls
build_zh-TW:
	$(LIVESCRIPT_BIN) $(BUILD_DIR)zh-TW.ls

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

# PHONY
.PHONY: watch_css render_html clean_tmp clean_public

#---------------------------------------------------------------------- 
# COMMANDS
#---------------------------------------------------------------------- 

# General

all: clean_tmp mkdirs copy_assets build_all finalize
test: clean_tmp mkdirs copy_assets build_en finalize
clean: clean_tmp clean_public
reset: clean_public all

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
