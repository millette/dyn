<dat-changes>
  <h3 if={changes && changes.length}>
    Changes
    <button onclick={clear}>
      clear
    </button>
  </h3>
  <ol if={changes && changes.length}>
    <li each={changes}>{change}</li>
  </ol>

  <script>
    this.nChanges = opts.nChanges || 20
    this.changes = [ ]

    clear () { this.update({ changes: [ ] }) }

    addChange (change) {
      // FIXME: should a push automatically trigger an update or what?
      this.changes.unshift({ change })
      this.changes = this.changes.slice(0, this.nChanges)
      this.update()
    }

    const evFn = (e) => this.addChange(`${e.path} ${e.type} at ${new Date().toISOString()}`)

    opts.fileEvents.addEventListener('invalidated', evFn)
    opts.fileEvents.addEventListener('changed', evFn)

    const fn1 = ({feed, block, bytes}) => this.addChange(`Downloaded ${feed} block ${block} (${bytes}) at ${new Date().toISOString()}`)
    const fn2 = ({feed, block, bytes}) => this.addChange(`Uploaded ${feed} block ${block} (${bytes}) at ${new Date().toISOString()}`)
    const fn3 = ({feed}) => this.addChange(`${feed} synced at ${new Date().toISOString()}`)

    opts.networkEvents.addEventListener('download', fn1)
    opts.networkEvents.addEventListener('upload', fn2)
    opts.networkEvents.addEventListener('sync', fn3)

    this.on('unmount', () => {
      removeEventListener('invalidated', evFn)
      removeEventListener('changed', evFn)
      removeEventListener('download', fn1)
      removeEventListener('upload', fn2)
      removeEventListener('sync', fn3)
    })
  </script>
</dat-changes>
