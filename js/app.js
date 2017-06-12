/* global DatArchive, riot */

'use strict'

Boolean((async (w) => {
  const selfArchive = new DatArchive(String(w.location))
  const archiveInfo = await selfArchive.getInfo()
  archiveInfo.selfArchive = selfArchive
  archiveInfo.networkEvents = selfArchive.createNetworkActivityStream()
  archiveInfo.fileEvents = selfArchive.createFileActivityStream()

  riot.mount('page-title', archiveInfo)
  riot.mount('dat-meta', archiveInfo)
  riot.mount('dat-changes', archiveInfo)
  riot.mount('wanna-fork', archiveInfo)

  try {
    const www = await DatArchive.resolveName(String(w.location))
    console.log('WWW:', www)
  } catch (e) { console.error('OUPS:', e) }
})(window))
