# PRISM Break

Welcome to the PRISM Break project. Here's a quick overview of the code. JSON containing all of the project data is filtered through [LiveScript](http://livescript.net/) and then compiled to plain HTML with [Jade](http://jade-lang.com/) templates. Stylesheets are managed with [Stylus](http://learnboost.github.io/stylus/), a CSS preprocessor.

The prism-break build process relies on several npm packages. Make sure to have [io.js](http://iojs.org) or [node.js](http://nodejs.org/) installed on your system if you want to contribute to the code.

If you'd like to translate the project to your favorite language, there's no need to install io.js or even download the code. Just edit the appropriate JSON files on GitHub and submit a pull request.

More information for translators can be found in [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Project Inclusion Guidelines

 - **Only F/OSS software is allowed to be featured on PRISM Break.**

PRISM Break follows [the GNU/FSF definition of Free Software](https://www.gnu.org/philosophy/free-sw.html) and prefers software licensed under [a compatible license](https://www.gnu.org/licenses/license-list.html) but may allow other [OSI reviewed licenses](http://opensource.org/licenses). The only exception is when free software offers no viable alternative to proprietary software. "Web Search" is the only category with this exception currently.

 - **Quality over quantity.**

PRISM Break strives to promote the best open source applications. Ease of use, stability, and performance matter. This is the first time many people are looking to leave their proprietary walled gardens. Let's make it a good experience for them. If you're writing a privacy-minded FOSS app, please finish it before asking PRISM Break to promote it.

 - **Before suggesting software, please first search this repository to see if your request has already been made.**

If it has been rejected, you'll learn why. If the issue hasn't been addressed, add a comment as to why it deserves inclusion. If the software has been improved significantly since the initial rejection, feel free to suggest it again.

 - **Pull requests are prioritized over issues.**

I will respond to them quicker and they will get an answer faster.


## Project Submission (quick version)

### 1. Edit

Add the project you wish to get listed.

    vi ./source/db/en-projects.json                  # edit or add a project

    cp project.png ./source/assets/images/logos/medium/    # put 60x60 PNG here

### 2. Test

Make sure your edits do not break the site by building the English version of PRISM Break. Open the pages to make sure it all works.

    npm install
    make test      # builds ./public/en for preview purposes

### 3. Translate

You edited the `en-projects.json` file earlier. This only creates a project description for the English version of PRISM Break. Please copy the project description to all the other language files, so translators work on it more easily.

    # Copying your edits to *-projects.json
    ./source/db/*-projects.json

At this point, feel free to commit the changes and submit a pull request. Steps #4 and #5 are only necessary if you want to build your own copy of the site.

### 4. Build

    make           # get a drink, it'll take a while build all 27 languages

    make reset     # making a drastic change? run this instead of `make`
                   # this will vaporize /public before running `make`

### 5. Serve

Serve the folder [`./public`](./public/) on your web server.

### Need more details on how to submit a project or a translation?

Read [`CONTRIBUTING.md`](CONTRIBUTING.md) for more detail into the process.

### Want to help contribute to pending work?

Search for open issues with the ["pull requested accepted"](https://github.com/nylira/prism-break/labels/pull%20request%20accepted) label.

## License

GPLv3.

See [`LICENSE.md`](LICENSE.md).
