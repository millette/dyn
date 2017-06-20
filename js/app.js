/* global DatArchive, riot, route, Remarkable */

'use strict'

Boolean((async (w) => {
  if (typeof DatArchive === 'undefined') { return riot.mount('dat-http') }

  let www
  try {
    www = await DatArchive.resolveName(w.location.hostname)
  } catch (e) { console.error('OUPS:', e) }

  if (!www) { www = String(w.location) }

  const selfArchive = new DatArchive(www)
  const archiveInfo = await selfArchive.getInfo()
  archiveInfo.selfArchive = selfArchive
  archiveInfo.networkEvents = selfArchive.createNetworkActivityStream()
  archiveInfo.fileEvents = selfArchive.createFileActivityStream()
  archiveInfo.md = new Remarkable('full', {
    html: true,         // Enable HTML tags in source
    xhtmlOut: false,        // Use '/' to close single tags (<br />)
    breaks: true,         // Convert '\n' in paragraphs into <br>
    langPrefix: 'language-',  // CSS language prefix for fenced blocks
    linkify: true,         // Autoconvert URL-like text to links

    // Enable some language-neutral replacement + quotes beautification
    typographer: true,

    // Double + single quotes replacement pairs, when typographer enabled,
    // and smartquotes on. Set doubles to '«»' for Russian, '„“' for German.
    quotes: '“”‘’',

    // Highlighter function. Should return escaped HTML,
    // or '' if the source string is not changed
    highlight: function (/* str, lang */) { return '' }
  })

  riot.mount('page-title', archiveInfo)
  riot.mount('dat-meta', archiveInfo)
  riot.mount('dat-changes', archiveInfo)
  riot.mount('wanna-fork', archiveInfo)
  riot.mount('dat-mutate', archiveInfo)
  riot.mount('md-note', archiveInfo)
  w.bla = riot.observable()

  route.start()
})(window))
