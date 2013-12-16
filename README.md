# prism-break

Contributors are welcome.

# 30-Second Quick Start

## Build

    npm install
    make all

## Edit

Only edit files in the `./source/` directory.

## Rebuild

    make uber

## Serve

Serve the folder `./public` on your web server. Awesome!

# Guidelines for Project Inclusion

**Only F/OSS software is allowed to be featured on PRISM Break.** The only exception is when free software offers no viable alternative to proprietary software. "Web Search" is the only category with this exception currently.

**Quality over quantity.** PRISM Break strives to promote the best open source applications. Ease of use, stability, and performance matter. This is the first time many people are looking to leave their proprietary walled gardens. Let's make it a good experience for them. If you're writing a privacy-minded FOSS app, please finish it before asking PRISM Break to promote it.

**Before suggesting software, please first search this repository to see if your request has already been made.** If it has been rejected, you'll learn why. If the issue hasn't been addressed, add a comment as to why it deserves inclusion. If the software has been improved significantly since the initial rejection, feel free to suggest it again.

**Pull requests are prioritized over issues.** I will respond to them quicker and they will get an answer faster.

# Contributing

## Editing Projects
  
Project data is stored in `./source/db/*-projects.ls`, where `*` is the two letter language code (ISO-639). Edit normally with your favorite text editor, and make sure the site still compiles correctly with `make uber`.

## Adding A New Project

### Project Details

Append the following text to the file `./source/db/en-projects.ls`. Repeat the process for the other languages (e.g. `./source/db/de-projects.ls`).

    * status: 'recommended'
      description: "Tor Browser Bundle is a web browser based on Firefox ESR, pre-configured to protect users' privacy and anonymity on the web. is a free repackaged version of the bundled Tor Software. The program allows the end user to connect to the Tor anonymity network. "
      license_url: "https://gitweb.torproject.org/tor.git?a=blob_plain;hb=HEAD;f=LICENSE"
      logo: "tor-browser-bundle.png"
      notes: "Using the TBB to sign into websites that contain your real ID is counterproductive, and may trip the site's fraud protection. Make sure to check for HTTPS before signing in to a website through Tor.\n\nSigning into HTTP websites can result in your ID being captured by a Tor exit node."
      privacy_url: "https://www.torproject.org/about/overview.html.en"
      source_url: "https://gitweb.torproject.org/tor.git"
      name: "Tor Browser Bundle"
      tos_url: ""
      url: "https://www.torproject.org/projects/torbrowser.html.en"
      wikipedia_url: "https://en.wikipedia.org/wiki/Tor_Browser_Bundle"
      protocols: ["SSL/TLS", "Tor"]
      categories: [
        * name: "BSD"
          subcategories: ["Web Browsers"]
        * name: "Linux"
          subcategories: ["Web Browsers"]
        * name: "Mac OS X"
          subcategories: ["Web Browsers"]
        * name: "Windows"
          subcategories: ["Web Browsers"]
      ]

### Project Thumbnail

**Project thumbnails should be in the PNG format.** Try to get a 1024px x 1024px (or better) version of the logo for `./source/images/original` and rescale it to 60x60 and 120x120 for `./source/images/medium` and `./source/images/medium@2x`

## Localizations

For anyone who's interested in working on localizing this site, please look into the `./source/i18n` directory of this repository. There are some sample LiveScript files there. To start, just make a copy of the en.ls file and start filling it out.

**Run `make uber` to make sure your translations compile properly.** A common mistake is putting unescaped quotation marks in a sentence. Make sure to escape them with either HTML entities (curly quotes) or a backslash (straight quotes).

    description: "Add curly quotes &ldquo;like this&rdquo;."

    description: "Add straight quotes \"like this\"."

    description: "This will create "an error"."

Bear in mind that the site is being constantly updated, so you may want to check back every so often.

# License

GPL.

See `LICENSE.md` for more details.
