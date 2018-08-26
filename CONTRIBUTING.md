If you want to contribute and have any questions whatsoever, join us
[at #prism-break on Freenode][#freenode]. It's a great place to get help. Don't
ask to ask, just send your question and someone will get back to you soon.

[#freenode]: https://webchat.freenode.net/?channels=prism-break

## Help wanted

If you just want to help, consider checking out issues that have [help wanted][]
label. Pull requests that resolve this issues will be merged without additional
discussion.

[help wanted]: https://gitlab.com/prism-break/prism-break/issues?label_name%5B%5D=help+wanted

## Projects

### Which Files to Edit

If you want to edit or add a project to PRISM Break, see
`source/db/en-projects.json`.

If you want to add a project logo, see `source/assets/logos`. SVG is highly
preferred. Make sure that there is no inappropriate white background or
margins, and that logo's aspect ratio is 1:1. In Inkscape, go to File ->
Document Properties -> Page Size -> Custom size and make sure that Width and
Height are identical.

To remove white margins, go to File -> Document Properties -> Page Size ->
Custom size -> Resize page to connect... -> Resize page to drawing or
selection. Then set Width/Height to the highest value of the two to get back to
1:1 aspect ratio. Particular value is not important.

To re-center the logo, press Ctrl+A to select all objects, press Ctrl+Shift+A
to open "Align and Distribute" menu, choose to align relative to page, tick
"treat selection as group", and then press "Center on horizontal axis" and
"Center on vertical axis" buttons.

If possible, please also run [svgcleaner][] on SVG logos and [zopflipng][] on
PNG logos. If you haven't done that, make sure to say that in merge request so
that reviewer can do that for you.

[svgcleaner]: https://github.com/RazrFalcon/svgcleaner
[zopflipng]: https://github.com/google/zopfli

### Add the Project Data

Append the sample project to the file `source/db/en-projects.json`. Edit the values to fit your project.

**Sample Project:**

    {
      "development_stage": "released",
      "description": "Encrypted, anonymous web browsing powered by the Tor network.",
      "license_url": "https://gitweb.torproject.org/tor.git?a=blob_plain;hb=HEAD;f=LICENSE",
      "logo": "tor-browser.png",
      "notes": "Using Tor Browser to sign into websites that contain your real ID is counterproductive, and may trip the site's fraud protection. Make sure to check for HTTPS before signing in to a website through Tor.\n\nSigning into HTTP websites can result in your ID being captured by a Tor exit node.",
      "privacy_url": "https://www.torproject.org/about/overview.html.en",
      "source_url": "https://gitweb.torproject.org/tor.git",
      "name": "Tor Browser",
      "tos_url": "",
      "url": "https://www.torproject.org/projects/torbrowser.html.en",
      "wikipedia_url": "https://en.wikipedia.org/wiki/Tor_Browser",
      "protocols": [
        "SSL/TLS",
        "Tor"
      ],
      "categories": [
        {
          "name": "BSD",
          "subcategories": [
            "Web Browsers"
          ]
        },
        {
          "name": "GNU/Linux",
          "subcategories": [
            "Web Browsers"
          ]
        },
        {
          "name": "OS X",
          "subcategories": [
            "Web Browsers"
          ]
        },
        {
          "name": "Windows",
          "subcategories": [
            "Web Browsers"
          ]
        }
      ],
      "slug": "tor-browser"
    },

Only the fields `name`, `description`, `logo`, `url`, `categories`, and `development_stage` are required. The other fields can be left empty with a value of `""` (`[]` for `protocols`).

### Add the Project Thumbnail
**Project thumbnails should be in the SVG or PNG format.** Get a SVG version or a 1024px x 1024px (or better) PNG version of the logo for `./source/assets/logos`.

### Testing Your Edits/Additions
When you're done with your edits, you should build the site to see if it compiles properly. To do so, run:

    make test

Which will generate:

    ./public/en/

It might take a little while (~minutes) if you're on a slower computer.

### Publishing Your Changes
Visit `./public/en/` in your browser and check out your work. If it looks good, commit the changes and issue a pull request. Thanks for your contribution!

# Contribute: Localizations

### Which Files to Edit
If you want to translate project descriptions, URLs, or notes into your favorite language, this data resides in:

    ./source/db/*-projects.json

**Warning:** When doing a complete site translation, do not translate the `"protocols"`, `"categories"`, or `"slug"` values to your language. Translating the `"slug"` will break URLs when switching between languages. Translating `"protocols"` and `"categories"` should be done in the `./source/locales/*.json` file instead.

If you want to translate protocol descriptions, names, or URLs, this data resides in:

    ./source/db/protocols/*.json

If you're interested in translating the site itself (all the nouns, verbs, and sentences that make up the static portion of the site), look here:

    ./source/locales/*.json

If your language file doesn't exist yet, you can copy the en.json file and start translating from there.

### JSON Validation
**Make sure your JSON validates.** You can use either use [JSONLint](http://jsonlint.com/) online or install it locally with `npm install jsonlint -g`.

A common mistake is putting unescaped quotation marks in a sentence. Make sure to use Unicode typographic marks (curly quotes) or escape regular (straight) quotes with a backslash.

    "description": "Use curly quotes “like this”.",

    "description": "Escape straight quotes \"like this\".",

    "description": "Not escaping quotes will cause "an error".",

### Testing Your Translation
When you're done with your translation, you should build the site in your language to see if it works. If want to test out your French translations for example, run `make fr`. Traditional Chinese translations? Run `make zh-TW`. It might take a little while (~minutes) if you're on a slower computer.

### Publishing Your Changes
Your newly translated site is available at './public/**language-code**/'. Visit it in your browser and check out your work. Looking good!

Remember to revert the `Makefile` change and then commit the changes and issue a pull request.

## Mirrors

If you wish to mirror this site, [nylira/prism-break-static](https://github.com/nylira/prism-break-static) is probably of interest to you. This is a completely static (but constantly updated) version of the site you can save to browse locally or serve over HTTP.

There are no known mirrors yet. If you make one, please tell us and we'll link it here.
