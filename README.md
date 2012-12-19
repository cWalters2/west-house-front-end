# West House ALIS Front-End

This is the front-end code of West House's ALIS.

### Technologies Used

* [Node.js](http://nodejs.org/)
* [CoffeeScript](http://coffeescript.org/)
* [Express](http://expressjs.com/)
* [LESS](http://lesscss.org/)
* [jQuery](http://jquery.com/)
* [Backbone.js](http://backbonejs.org/)
* [Underscore.js](http://underscorejs.org/)
* a plethora of front-end libraries and plugins. Just take a look at `public/index.html`, and look at the second script tag, with the 
* a plethora of middleware for the Express framework. Just take a look at `package.json`'s `"dependencies"` property, and you'll see the list.

## Usage

First, install the latest version of [Node.js](http://nodejs.org/).

Next, install all the dependencies.

```shell
# Might require sudo
$ npm install
```

Then, install CoffeeScript.

```shell
# Might require sudo
$ npm install -g CoffeeScript
```

And then, you should be able to run the front-end.

```shell
$ coffee server.coffee
# -> Server listening on port 3000
```

However, you get a [`listen EADDRINUSE`](https://gist.github.com/4333329) error, then you can run the following command.

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

### Things to Look Into

* JavaScript
  * <a href="http://backbonetutorials.com/" target="_blank">Model-View-<anything></a>
  * <a href="http://requirejs.org/docs/whyamd.html" target="_blank">Asynchronous Module Definition (AMD) (a.k.a. how RequireJS loads dependencies)</a>
  * <a href="https://gist.github.com/357981/" target="_blank">Comma-first variable and property declaration</a> (JavaScript coding style used in this project)
  * <a href="http://pkp.sfu.ca/wiki/index.php/JavaScript_coding_conventions" target="_blank">Some JavaScript coding conventions</a>

### Etiquets

* be sure that no build files are in the repository. Update the [.gitignore file](http://gitready.com/beginner/2009/01/19/ignoring-files.html), when necessary.

### Some Really Minor Details

If you are a new contributor to the West House Project's ALIS front-end, you are free to (and if, you're not shy, you are more than encouraged to) include yourself in the `package.json` file.

## Contact

Feel free to contact Salehen at [salehen.rahman@gmail.com](mailto:salehen.rahman@gmail.com), if you have any question.