# http://prism-break.org

Feel free to contribute to or use the code as you like.

## Translations

For anyone who's interested in working on translating this site, please look into the /lang/ directory of this repository. There are some sample translation JSON files there. To start, just make a copy of the en.json file and start filling it out.

Bear in mind that the site is being constantly updated, so you may want to check back every so often.

## CSS editing

Please do not edit the `screen.css` file directly, but instead edit the `.stylus` files found in `assets/styl/`. To compile the Stylus code into CSS, you'll need to run this terminal command from the project root:

    stylus -w styl/screen.styl -o css -u ~/local/node/lib/node_modules/nib

If you don't have the [Stylus](http://learnboost.github.io/stylus/) package, either learn about it [here](http://learnboost.github.io/stylus/) or just install it with `npm`:

    npm install stylus

## License

No Copyright

http://creativecommons.org/publicdomain/zero/1.0/
