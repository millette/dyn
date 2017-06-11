!(async (w) => {
  const selfArchive = new DatArchive(String(w.location))
  const archiveInfo = await selfArchive.getInfo()
  archiveInfo.networkEvents = selfArchive.createNetworkActivityStream()
  archiveInfo.fileEvents = selfArchive.createFileActivityStream()

  riot.mount('page-title', archiveInfo)
  riot.mount('dat-meta', archiveInfo)
  riot.mount('dat-changes', archiveInfo)
})(window)
