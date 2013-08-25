# https://prism-break.org

Contributors are welcome.

## App inclusion guidelines

* **In almost all cases, only free software is allowed to be featured on PRISM Break.** The only exception is when free software offers no viable alternative to proprietary software. "Web search" is the only category with this exception currently.
* **Quality over quantity.** PRISM Break strives to promote the best open source applications. Ease of use, stability, and performance matter. This is the first time many people are looking to leave their proprietary walled gardens. Let's make it a good experience for them. If you're writing a privacy-minded FOSS app, please finish it before asking PRISM Break to promote it.
* **Before suggesting software, please first search this repository to see if your request has already been made.** If it has been rejected, you'll learn why. If the issue hasn't been addressed, add a comment as to why it deserves inclusion. If the software has been improved significantly since the initial rejection, feel free to suggest it again.
* **Pull requests are heavily prioritized over issues.** I will respond to them quicker and they will get an answer faster.
* **Software thumbnails should be 256-color, non-transparent PNGs.** A 50x50 png in the `lib/img/free` directory is good.
* **If you have the time, please include translation stubs in all of the language JSON files.** You'll save us a lot of time, and make translators happy. If you're adding the project Whonix for example, add the following line to every single JSON file in `lang/`:

    `"i18n-whonix-desc": "Tor-enforcing OS focused on anonymity, privacy and security. Offers ready-to-use VM images.",`

## Localizations

For anyone who's interested in working on localizing this site, please look into the `lang/` directory of this repository. There are some sample translation JSON files there. To start, just make a copy of the en.json file and start filling it out.

**Please note:** The canonical version of the site text is contained in `./index.html` and `./lang/en.json`. The strings contained in the `xx.json` files may be out of date, as they need to be updated manually by volunteer translators. Please refer to the text contained in `./lang/en.json` when developing your translations to ensure your translation file is 100% up-to-date.

**Test to make sure your [JSON validates](http://jsonformatter.curiousconcept.com/).** A common mistake when editing JSON is putting unescaped quotation marks in a string. Make sure to escape them with either a backslash or HTML entities

    "i18n-web-browser-note": "If you want to have quotes in this note, make sure to add them \"like this\" or you will break JSON.",

    "i18n-web-browser-note": "If you want to have pretty curly quotes in this note, make sure to add them &ldquo;like this&rdquo; or you will break JSON.",

    "i18n-web-browser-note": "You should never do anything "like this" or you will break the entire JSON file.",

Bear in mind that the site is being constantly updated, so you may want to check back every so often.

### Adding your own JSON stubs

You may find that a particular string of text, e.g. `"i18n-whonix-desc"`, does not exist in your preferred language's JSON file. Feel free to add it to your file, just like this:

    "i18n-whonix-desc": "Your fantastic translation here.",

## HTML edits

Just edit the HTML.
    
## CSS & JS edits

Please edit the files in the `src` directory, not `lib`. This project relies on Grunt for CSS and JS concatenation and minification. 

    # Install Grunt

    npm install -g grunt-cli

    # Watch for changes

    grunt watch

## License

See `LICENSE.md`
