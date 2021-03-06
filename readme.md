# Readme, please please readme

```sh
git clone https://github.com/millette/dyn.git
cd dyn
yarn # or npm install
```

Of course, you're going to need node to get this working, although it's only used to provide a linter (standardjs) and bower to download front-end js dependencies.

If you clone instead using dat, you'll have the front-end js dependencies automatically:

```sh
dat f7201391b91d8c16964ae8d23cf819fc6ec379d95f0fd8a4e6e7936c91d2b78e
```

At this point, you've downloaded the source for <dat://f7201391b91d8c16964ae8d23cf819fc6ec379d95f0fd8a4e6e7936c91d2b78e/> from GitHub, installed the npm dev dependencies:

* bower
* standard, the js linter

and installed the front-end dependencies with bower, in our case:

* riot
* riot-route # not used yet

**NOTE** Bower? Isn't that so *2016*? It will do for now, I'm trying to keep things simple. A vendor directory might seem simpler, but this at least makes it easier to update.

In other words, you should have this directory structure:

```
dyn
|-- bower_components
|   |-- riot
|   `-- riot-route
|       |-- dist
|       |-- doc
|       |-- lib
|       `-- src
|           `-- tags
|-- components
|-- css
`-- js
```

The preceding tree is generated with

```
tree dyn -d -I node_modules -n --charset="windows-1252"
```

instead of using the utf-8 charset, until [a bug in Beaker](https://github.com/beakerbrowser/beaker/issues/499) is fixed.

## Helpers

Use either of the following to update your .datignore file according to your changes to index.html, bower.json, etc.

### Bower

```sh
yarn postinstall # will also download bower components
```

If you prefer npm:

```sh
npm run postinstall # will also download bower components
```

### Datignore
To only update your .datignore file:

```sh
yarn ignore
```

If you prefer npm:

```sh
npm run ignore
```
