# https://prism-break.org

Contributors are welcome.

## Localizations

For anyone who's interested in working on localizing this site, please look into the /lang/ directory of this repository. There are some sample translation JSON files there. To start, just make a copy of the en.json file and start filling it out.

**Please note:** The canonical version of the site text is contained in index.html. The strings contained in the `xx.json` files may be out of date, as they need to be updated manually (and I don't have unlimited amounts of free time). Please refer to the text contained in index.html when developing your translations to ensure your translation file is up-to-date.

Bear in mind that the site is being constantly updated, so you may want to check back every so often.

### Adding your own JSON stubs

You may find that a particular string of text, e.g. `"i18n-whonix-desc"`, does not exist in your preferred language's JSON file. Feel free to add it to your file, just like this:

    "i18n-whonix-desc": "Your fantastic translation here.",

## CSS & JS editing

Please edit the files in the `src` directory, not `lib`. This project relies on Grunt for CSS and JS concatenation and minification. 

    # Install Grunt

    npm install -g grunt-cli

    # Watch for changes

    grunt watch

## License

See `LICENSE.md`


