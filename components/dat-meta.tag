<dat-meta>

  <dl>
    <dt>Last modified</dt>
    <dd>{ new Date(mtime).toISOString() }</dd>

    <dt>Canonical URL</dt>
    <dd><a href="{ url }">{ urlStr }</a></dd>

    <dt>Peers</dt>
    <dd>{ connections }</dd>

    <dt if={forkOf}>History</dt>
    <dd each={ forkOf }><a href="{ url }">{ urlStr }</a></dd>
  </dl>

  <script>
    const makeUrlStr = (u) => {
      return {
        url: u,
        urlStr: `${u.slice(0, 'dat://'.length + 6)}…${u.slice(-2)}`
      }
    }
    this.mtime = opts.mtime || 0
    this.connections = opts.connections || 0
    if (opts.forkOf && opts.forkOf.length) { this.forkOf = opts.forkOf.map(makeUrlStr) }
    if (opts.url) {
      Object.assign(this, makeUrlStr(opts.url))
    } else {
      this.url = '#'
      this.urlStr = 'url N/A'
    }
    opts.networkEvents.addEventListener('network-changed', this.update)
    this.on('unmount', () => removeEventListener('network-changed', this.update))
  </script>

</dat-meta>
