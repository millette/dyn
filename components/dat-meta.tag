<dat-meta>
  <dl>
    <dt>Last modified</dt>
    <dd>{mtime}</dd>

    <dt>Canonical URL</dt>
    <dd><a href={url}>{urlStr}</a></dd>

    <dt if={connections}>Peers</dt>
    <dd if={connections}>{connections}</dd>

    <dt if={forkOf}>History</dt>
    <dd each={forkOf}><a href={url}>{urlStr}</a></dd>
  </dl>

  <script>
    const makeUrlStr = (url) => {
      const urlStr = `${url.slice(0, 'dat://'.length + 6)}…${url.slice(-2)}`
      return { url, urlStr }
    }
    this.mtime = opts.mtime && new Date(opts.mtime).toISOString() || 'N/A'
    this.connections = opts.connections || 0
    if (opts.forkOf && opts.forkOf.length) { this.forkOf = opts.forkOf.map(makeUrlStr) }
    Object.assign(this, opts.url ? makeUrlStr(opts.url) : { url: '#', urlStr: 'url N/A' })
    opts.networkEvents.addEventListener('network-changed', this.update)
    this.on('unmount', () => removeEventListener('network-changed', this.update))
  </script>
</dat-meta>
