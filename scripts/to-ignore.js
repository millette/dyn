'use strict'

// core
const fs = require('fs')

// npm
const pify = require('pify')
const glob = pify(require('glob'))

const readFile = pify(fs.readFile)
const writeFileImp = pify(fs.writeFile)

const writeFile = (fn, x) => {
  const cnt = `${x.join('\n')}\n`
  return Promise.all([cnt.length, writeFileImp(fn, cnt, 'utf-8')])
}

const inUse = () => readFile('index.html', 'utf-8')
  .then((x) => {
    const re = /src="(bower_components\/.+)"/g
    const rep = /%2[bB]/g
    const ok = []
    let yo
    while ((yo = re.exec(x))) { ok.push(yo[1].replace(rep, '+')) }
    return ok.sort()
  })

// FIXME: instead of nodir=true, only exclude unused paths
const ignoreWhat = (ignore) => glob('bower_components/**', { ignore, dot: true, nodir: true })
const keepGit = ['', 'bower_components', '.datignore', 'notes']
const isGit = (x) => keepGit.indexOf(x) === -1

const gitIgnored = (i) => readFile('.gitignore', 'utf-8')
  .then((x) => x.split('\n').filter(isGit).concat(i))

const run = (fn) => inUse()
  .then(ignoreWhat)
  .then(gitIgnored)
  .then(writeFile.bind(null, fn))
  .then((x) => console.log(`Wrote ${fn} (${x[0]} bytes).`))

run('.datignore').catch(console.error)
