# https://prism-break.org

Contributors are welcome.

## Translations

For anyone who's interested in working on translating this site, please look into the /lang/ directory of this repository. There are some sample translation JSON files there. To start, just make a copy of the en.json file and start filling it out.

**Please note:** The canonical version of the site text is contained in index.html. The strings contained in the `xx.json` files may be out of date, as they need to be updated manually (and I don't have unlimited amounts of free time). Please refer to the text contained in index.html when developing your translations to ensure your translation file is up-to-date.

Bear in mind that the site is being constantly updated, so you may want to check back every so often.

### Adding your own JSON stubs

You may find that a particular string of text, e.g. `"i18n-whonix-desc"`, does not exist in your preferred language's JSON file. Feel free to add it to your file, just like this:

    "i18n-whonix-desc": "Your fantastic translation here.",

## CSS editing

Please do not edit the `screen.css` file directly, but instead edit the `.stylus` files found in `assets/styl/`. To compile the Stylus code into CSS, you'll need to run this terminal command from the project root:

    stylus -w -c assets/styl/screen.styl -o assets/css -u ~/local/node/lib/node_modules/nib

If you don't have the [Stylus](http://learnboost.github.io/stylus/) package just install it (along with the [nib](http://visionmedia.github.io/nib/)) extension `npm`:

    npm install -g stylus nib

## GNU General Public License v3

All the code and content in this project is licensed under the GNU GPLv3 except for the trademarked images and logos.

Normalize.css is copyright (c) Nicolas Gallagher and Jonathan Neal.
