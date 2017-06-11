<dat-changes>
  <h3 if={changes && changes.length}>Changes</h3>
  <ol if={changes && changes.length}>
    <li each={changes}>{change}</li>
  </ol>

  <script>
    this.changes = [ ]

    evFn (e) {
      // FIXME: should a push automatically trigger an update or what?
      this.changes.push({ change: `${e.path} ${e.type} at ${new Date().toISOString()}` })
      this.update()
    }

    opts.fileEvents.addEventListener('invalidated', this.evFn)
    opts.fileEvents.addEventListener('changed', this.evFn)

    const fn1 = ({feed, block, bytes}) => {
      this.changes.push({ change: `Downloaded ${feed} block ${block} (${bytes}) at ${new Date().toISOString()}` })
      this.update()
    }

    const fn2 = ({feed, block, bytes}) => {
      this.changes.push({ change: `Uploaded ${feed} block ${block} (${bytes}) at ${new Date().toISOString()}` })
      this.update()
    }

    const fn3 = ({feed}) => {
      this.changes.push({ change: `${feed} synced at ${new Date().toISOString()}` })
      this.update()
    }

    opts.networkEvents.addEventListener('download', fn1)
    opts.networkEvents.addEventListener('upload', fn2)
    opts.networkEvents.addEventListener('sync', fn3)

    this.on('unmount', () => {
      removeEventListener('invalidated', this.evFn)
      removeEventListener('changed', this.evFn)
      removeEventListener('download', fn1)
      removeEventListener('upload', fn2)
      removeEventListener('sync', fn3)
    })
  </script>
</dat-changes>
