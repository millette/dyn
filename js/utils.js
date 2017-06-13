'use strict'

Boolean(((w, d) => {
  const relativeUrl = (o) => {
    if (!o) { return w.location.href }
    if (typeof o === 'string') { o = { pathname: o } }
    if (typeof o !== 'object') { throw new Error('Argument must be a string or an object') }
    if (!Object.keys(o).length) { return w.location.href }
    const $a = d.createElement('a')
    $a.href = w.location.href
    return Object.assign($a, o).href
  }

/*
 * Example usage:

  const u1 = utils.relativeUrl()
  const u2 = utils.relativeUrl({pathname: 'dyn-app.json'})
  const u3 = utils.relativeUrl({pathname: '/dyn-app.json'})
  const u4 = utils.relativeUrl('dyn-app.json')

  console.log('u1', u1)
  console.log('u2', u2) // these last 3 have the same output
  console.log('u3', u3)
  console.log('u4', u4)
*/

  w.utils = { relativeUrl }
})(window, document))
