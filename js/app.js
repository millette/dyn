/* global DatArchive, riot */

'use strict'

Boolean((async (w) => {
  let www
  try {
    www = await DatArchive.resolveName(String(w.location.hostname))
    console.log('WWW:', www)
  } catch (e) { console.error('OUPS:', e) }

  if (!www) { www = String(w.location) }

  const selfArchive = new DatArchive(www)
  const archiveInfo = await selfArchive.getInfo()
  archiveInfo.selfArchive = selfArchive
  archiveInfo.networkEvents = selfArchive.createNetworkActivityStream()
  archiveInfo.fileEvents = selfArchive.createFileActivityStream()

  riot.mount('page-title', archiveInfo)
  riot.mount('dat-meta', archiveInfo)
  riot.mount('dat-changes', archiveInfo)
  riot.mount('wanna-fork', archiveInfo)
  riot.mount('dat-mutate', archiveInfo)
})(window))
