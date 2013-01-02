# West House ALIS Front-End

[![Build Status](https://travis-ci.org/West-House-Project/west-house-front-end.png?branch=development)](https://travis-ci.org/West-House-Project/west-house-front-end)

This is the front-end code of West House's ALIS.

### Technologies Used

* <a href="http://nodejs.org/" target="_blank">Node.js</a>
* <a href="http://coffeescript.org/" target="_blank">CoffeeScript</a>
* <a href="http://expressjs.com/" target="_blank">Express</a>
* <a href="http://lesscss.org/" target="_blank">LESS</a>
* <a href="http://jquery.com/" target="_blank">jQuery</a>
* <a href="http://backbonejs.org/" target="_blank">Backbone.js</a>
* <a href="http://underscorejs.org" target="_blank">Underscore.js</a>
* a plethora of front-end libraries and plugins. Just take a look at `public/index.html`, and look at the second script tag. You'll see the plugins and libraries used in the `require.config` call.
* a plethora of middleware for the Express framework. Just take a look at `package.json`'s `"dependencies"` property, and you'll see the list.

## Usage

First, install the latest version of <a href="http://nodejs.org/" target="_blank">Node.js</a>, and <a href="http://git-scm.com/" target="_blank">Git</a>.

Next, download the source code, and then `cd` to the project's folder.

```shell
# This is assuming that there aren't any other `west-house-front-end` folders in
# your current working directory
$ git clone git://github.com/shovon/west-house-front-end.git
$ cd west-house-front-end
```

Install all of the dependencies that are used by the project.

```shell
# Might require sudo
$ npm install
```

Then, install CoffeeScript.

```shell
# Might require sudo
$ npm install -g coffee-script
```

And then, you should be able to run the front-end.

```shell
$ coffee server.coffee
# -> Server listening on port 3000
```

However, if you get a <a href="https://gist.github.com/4333329" target="_blank">`listen EADDRINUSE`</a> error, then you can run the following command.

```shell
$ coffee server.coffee 4000
# -> Server listening on port 4000
```

You can replace the number `4000` with just about any number between `1000` and `9999`, inclusively.

Optionally, you can install nodemon, so, when developing, you don't need to keep restarting the server every time you make a change.

```shell
# Might require sudo
$ npm install -g nodemon
```

And then run it like so.

```shell
$ nodemon server.coffee
```

## Development

### Things to install

* <a href="http://jashkenas.github.com/docco/" target="_blank">Docco</a>, for documenting CoffeeScript source code.
    * To add syntax highlighting to the documentation, you'll want to isntall <a href="http://pygments.org/" target="_blank">Pygments</a> (you can find the installation instructions on <a href="https://github.com/jashkenas/docco/blob/master/resources/README.md" target="_blank">Docco's readme file</a>).
        * This also means that you'll want to install <a href="http://pypi.python.org/pypi/setuptools" target="_blank">setuptools</a> to help you set up Pygments (setuptools installs easy_install, which will allow you to install Pygments in only one command).

### Things to Look Into

* JavaScript
  * <a href="http://backbonetutorials.com/" target="_blank">Model-View-&lt;anything&gt;</a> (MV* using Backbone.js)
  * <a href="http://requirejs.org/docs/whyamd.html" target="_blank">Asynchronous Module Definition (AMD)</a> (a.k.a. how RequireJS loads dependencies)
  * <a href="https://gist.github.com/357981/" target="_blank">Comma-first variable and property declaration</a> (JavaScript coding style used in this project)
  * <a href="http://pkp.sfu.ca/wiki/index.php/JavaScript_coding_conventions" target="_blank">Some JavaScript coding conventions</a>
* <a href="https://github.com/polarmobile/coffeescript-style-guide#coffeescript-style-guide" target="_blank">CoffeeScript style guide</a>
* <a href="http://daringfireball.net/projects/markdown/" target="_blank">Markdown</a>. Someone wrote a <a href="http://www.simplecode.me/2011/12/11/getting-started-with-markdown/" target="_blank">tutorial</a> to help you get started. There's also a live <a href="http://dillinger.io/" target="_blank">Markdown editor</a>. You can use that to practice using the language. But the original author's website has all the low-level details.

### Check List

* be sure that no build files are in the repository. Update the [.gitignore file](http://gitready.com/beginner/2009/01/19/ignoring-files.html), when necessary.

### Some Really Minor Details

If you are a new contributor to the West House Project's ALIS front-end, you are free to (and if, you're not shy, you are more than encouraged to) include yourself in the `package.json` file.

## Contact

Feel free to contact Salehen at [salehen.rahman@gmail.com](mailto:salehen.rahman@gmail.com), if you have any question.

## TODO

* refactor the code to allow for a compiled version of the front-end.