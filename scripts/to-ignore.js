'use strict'

// core
const fs = require('fs')

// npm
const pify = require('pify')
const glob = pify(require('glob'))

const readFile = pify(fs.readFile)

const ignoreWhat = (keep) => glob('bower_components/**', {
  ignore: keep,
  dot: true,
  nodir: true
})

const inUse = () => readFile('index.html', 'utf-8')
  .then((x) => {
    const re = /src="(bower_components\/.+)"/g
    const rep = /%2[bB]/g
    const ok = []
    let yo
    while ((yo = re.exec(x))) { ok.push(yo[1].replace(rep, '+')) }
    return ok.sort()
  })

const gitIgnored = (i) => readFile('.gitignore', 'utf-8')
  .then((x) => x.split('\n').filter((y) => y && y !== 'bower_components').concat(i))

inUse()
  .then(ignoreWhat)
  .then(gitIgnored)
  .then((x) => {
    console.log(x.join('\n'))
  })
  .catch(console.error)
