# prism-break

Welcome to the PRISM Break project. Here's a quick overview of the code. Raw JSON data is filtered through [LiveScript](http://livescript.net/) and then compiled to plain HTML with [Jade](http://jade-lang.com/) templates. CSS is managed with [Stylus](http://learnboost.github.io/stylus/), a powerful CSS preprocessor.

The prism-break build process relies on several Node.js packages. Make sure to have [Node.js](http://nodejs.org/) installed on your system if you want to contribute to the code.

If you'd like to translate the project to your favorite language, there's no need to install Node.js. Just edit the appropriate JSON files and submit a pull request. More info in the 'Contribute: Localizations' section.

# 30-Second Quick Start

### 1. Edit

    vi ./source/db/en-projects.json                  # edit or add a project

    cp project.png ./source/assets/images/logos/medium/    # put 60x60 PNG here

### 2. Test

    npm install
    make test      # builds ./public/en for preview purposes

### 3. Translate

    # set up stubs by copying your edits to *-projects.json
    ./source/db/*-projects.json

At this point, feel free to commit the changes and submit a pull request. Steps #4 and #5 are only necessary if you want to build your own copy of the site.

### 4. Build

    make           # get a drink, it'll take a while build all 27 languages

    make reset     # making a drastic change? run this instead of `make`
                   # this will vaporize /public before running `make`

### 5. Serve

Serve the folder `./public` on your web server.

# Project Inclusion Guidelines

**Only F/OSS software is allowed to be featured on PRISM Break.** PRISM Break follows [the GNU/FSF definition of Free Software](https://www.gnu.org/philosophy/free-sw.html) and prefers software licensed under [a compatible license](https://www.gnu.org/licenses/license-list.html) but may allow other [OSI reviewed licenses](http://opensource.org/licenses). The only exception is when free software offers no viable alternative to proprietary software. "Web Search" is the only category with this exception currently.

**Quality over quantity.** PRISM Break strives to promote the best open source applications. Ease of use, stability, and performance matter. This is the first time many people are looking to leave their proprietary walled gardens. Let's make it a good experience for them. If you're writing a privacy-minded FOSS app, please finish it before asking PRISM Break to promote it.

**Before suggesting software, please first search this repository to see if your request has already been made.** If it has been rejected, you'll learn why. If the issue hasn't been addressed, add a comment as to why it deserves inclusion. If the software has been improved significantly since the initial rejection, feel free to suggest it again.

**Pull requests are prioritized over issues.** I will respond to them quicker and they will get an answer faster.

# Contribute: Projects

### Which Files to Edit
If you want to edit or add a project to PRISM Break, this data resides here:

    ./source/db/*-projects.json

If you want to edit or add to the project logos on this site, look here:

    ./source/assets/images/logos/medium/          # for images currently used
    ./source/assets/images/original/        # for high res/svg versions

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
**Project thumbnails should be in the PNG format.** Try to get a 1024px x 1024px (or better) version of the logo for `./source/assets/images/original` and rescale it to 60x60 and 120x120 for `./source/assets/images/logos/medium` and `./source/assets/images/logos/medium@2x`

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

# License
See `LICENSE.md`.
