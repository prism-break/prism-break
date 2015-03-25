# Contribute: Projects

### Which Files to Edit
If you want to edit or add a project to PRISM Break, this data resides here:

    ./source/db/*-projects.json

If you want to edit or add to the project logos on this site, look here:

    ./source/assets/images/logos/medium/          # for images currently used
    ./source/assets/images/logos/original/        # for high res/svg versions

### Add the Project Data
Append the sample project to the file `./source/db/en-projects.json`. Edit the values to fit your project. Repeat the process for the other languages (e.g. `./source/db/de-projects.json`).

**Sample Project:**

    {
      "development_stage": "released",
      "description": "Encrypted, anonymous web browsing powered by the Tor network.",
      "license_url": "https://gitweb.torproject.org/tor.git?a=blob_plain;hb=HEAD;f=LICENSE",
      "logo": "tor-browser-bundle.png",
      "notes": "Using the TBB to sign into websites that contain your real ID is counterproductive, and may trip the site's fraud protection. Make sure to check for HTTPS before signing in to a website through Tor.\n\nSigning into HTTP websites can result in your ID being captured by a Tor exit node.",
      "privacy_url": "https://www.torproject.org/about/overview.html.en",
      "source_url": "https://gitweb.torproject.org/tor.git",
      "name": "Tor Browser Bundle",
      "tos_url": "",
      "url": "https://www.torproject.org/projects/torbrowser.html.en",
      "wikipedia_url": "https://en.wikipedia.org/wiki/Tor_Browser_Bundle",
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
      "slug": "tor-browser-bundle"
    },

Only the fields `name`, `description`, `logo`, `url`, `categories`, and `development_stage` are required. The other fields can be left empty with a value of `""` (`[]` for `protocols`).

### Add the Project Thumbnail
**Project thumbnails should be in the PNG format.** Try to get a 1024px x 1024px (or better) version of the logo for `./source/assets/images/logos/original` and rescale it to 60x60 and 120x120 for `./source/assets/images/logos/medium` and `./source/assets/images/logos/medium@2x`

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

A common mistake is putting unescaped quotation marks in a sentence. Make sure to escape them with either HTML entities (curly quotes) or a backslash (straight quotes).

    "description": "Use curly quotes &ldquo;like this&rdquo;.",

    "description": "Escape straight quotes \"like this\".",

    "description": "Not escaping quotes will cause "an error".",

### Testing Your Translation
When you're done with your translation, you should build the site in your language to see if it works. If want to test out your French translations for example, run `make fr`. Traditional Chinese translations? Run `make zh-TW`. It might take a little while (~minutes) if you're on a slower computer.

### Publishing Your Changes
Your newly translated site is available at './public/**language-code**/'. Visit it in your browser and check out your work. Looking good! 

Remember to revert the `Makefile` change and then commit the changes and issue a pull request.

# Contribute: Mirror
If you wish to mirror this site, [nylira/prism-break-static](https://github.com/nylira/prism-break-static) is probably of interest to you. This is a completely static (but constantly updated) version of the site you can save to browse locally or serve over HTTP.

### Mirrors

[http://hrk2gpercx3p6apf.onion/](http://hrk2gpercx3p6apf.onion/)
(credit: etheralghost)

[https://prism-break.ca](https://prism-break.ca)
(credit: wiserweb)
