# Readme, please please readme

```sh
git clone https://github.com/millette/dyn.git
cd dyn
yarn # or npm install
```

At this point, you've downloaded the source for
<dat://f7201391b91d8c16964ae8d23cf819fc6ec379d95f0fd8a4e6e7936c91d2b78e/>
from GitHub, installed the npm dev dependencies:

* bower
* standard, the js linter

and installed the front-end dependencies with bower, in our case:

* riot
* riot-route # not used yet

In other words, you should have this directory structure:

```
dyn
├── bower_components
│   ├── riot
│   └── riot-route
│       ├── dist
│       ├── doc
│       ├── lib
│       └── src
│           └── tags
├── components
├── css
└── js
```
