# prism-break

Contributors are welcome.

# 30-Second Quick Start

## 1. Edit

    vi ./source/db/en-projects.json                  # edit or add a project

    cp project.png ./source/assets/images/medium/    # put 60x60 PNG here

## 2. Test

    npm install
    make test      # builds ./public/en for preview purposes

## 3. Translate

    # set up stubs by copying your edits to *-projects.json
    ./source/db/*-projects.json

At this point, feel free to commit the changes and submit a pull request. Steps #4 and #5 are only necessary if you want to build your own copy of the site.

## 4. Build

    make all       # get a drink, it'll take a while build all 27 languages

    make reset     # making a drastic change? run this instead of `make all`
                   # this will vaporize /public before running `make all`

## 5. Serve

Serve the folder `./public` on your web server.

# Project Inclusion Guidelines

**Only F/OSS software is allowed to be featured on PRISM Break.** The only exception is when free software offers no viable alternative to proprietary software. "Web Search" is the only category with this exception currently.

**Quality over quantity.** PRISM Break strives to promote the best open source applications. Ease of use, stability, and performance matter. This is the first time many people are looking to leave their proprietary walled gardens. Let's make it a good experience for them. If you're writing a privacy-minded FOSS app, please finish it before asking PRISM Break to promote it.

**Before suggesting software, please first search this repository to see if your request has already been made.** If it has been rejected, you'll learn why. If the issue hasn't been addressed, add a comment as to why it deserves inclusion. If the software has been improved significantly since the initial rejection, feel free to suggest it again.

**Pull requests are prioritized over issues.** I will respond to them quicker and they will get an answer faster.

# Contributing

## Editing Projects
  
Project data is stored in `./source/db/*-projects.json`, where `*` is the two letter language code (ISO-639). Edit normally with your favorite text editor, and make sure the site still compiles correctly with `make reset`.

## Adding A New Project

### Adding the Project Data

Append the sample project to the file `./source/db/en-projects.json`. Edit the values to fit your project. Repeat the process for the other languages (e.g. `./source/db/de-projects.json`).

**Sample Project:**

    * name: "Awesome Project"
      logo: "awesome-project.png"
      description: "A 3-4 sentence description of the project goes here."
      notes: "Note that the project is in beta, has not been audited, etc."
      url: "https://www.awesome-project.org"
      wikipedia_url: "https://en.wikipedia.org/wiki/Awesome_Project"
      privacy_url: ""
      tos_url: ""
      license_url: "https://git.awesome-project.org//master/LICENSE.txt"
      source_url: "https://git.awesome-project.org/master/"
      protocols: ["GPG", "OTR", "XMPP"]
      categories: [
        * name: "Web Services"
          subcategories: ["Email Accounts", "Social Networks"]
        * name: "Linux"
          subcategories: ["Operating Systems"]
        * name: "Mac OS X"
          subcategories: ["Instant Messaging", "IRC"]
        * name: "Windows"
          subcategories: ["Disk Encryption", "VPN Clients"]
      ]

Only the fields `name`, `description`, `logo`, `url`, and `categories` are required. The other fields can be left empty with a value of `""` (`[]` for `protocols`).

### Adding the Project Thumbnail

**Project thumbnails should be in the PNG format.** Try to get a 1024px x 1024px (or better) version of the logo for `./source/images/original` and rescale it to 60x60 and 120x120 for `./source/images/medium` and `./source/images/medium@2x`

## Localizations

For anyone who's interested in working on localizing the site, please look into the `./source/locales` directory of this repository. If your language doesn't exist, just make a copy of the en.json file and start translating!

If you want to edit project descriptions or notes for your language, this data resides in the `./source/db/` directory.

**Make sure your JSON validates by using either [JSONLint](http://jsonlint.com/) or your own validator.** A common mistake is putting unescaped quotation marks in a sentence. Make sure to escape them with either HTML entities (curly quotes) or a backslash (straight quotes).

    "description": "Use curly quotes &ldquo;like this&rdquo;.",

    "description": "Escape straight quotes \"like this\".",

    "description": "Not escaping quotes will cause "an error".",

When you're done with your translation, you can run `make reset` to make sure your translations compile properly into the site. Note that this can take a long time (30min+), especially if you're on a slower computer.

# License

See `LICENSE.md`.
