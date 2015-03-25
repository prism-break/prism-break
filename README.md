# prism-break

Welcome to the PRISM Break project. Here's a quick overview of the code. Raw JSON data is filtered through [LiveScript](http://livescript.net/) and then compiled to plain HTML with [Jade](http://jade-lang.com/) templates. CSS is managed with [Stylus](http://learnboost.github.io/stylus/), a powerful CSS preprocessor.

The prism-break build process relies on several Node.js packages. Make sure to have [Node.js](http://nodejs.org/) installed on your system if you want to contribute to the code.

If you'd like to translate the project to your favorite language, there's no need to install Node.js. Just edit the appropriate JSON files and submit a pull request.

More info in `CONTRIBUTING.md`

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

# License
See `LICENSE.md`.
