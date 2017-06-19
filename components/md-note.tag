<md-note>
  <div style="float: right; width: 30rem">
    <h3 if={title}>{title}</h4>
    <h4 if={createdat}>{createdat}</h4>
    <raw-content if={html} html={html}></raw-content>
  </div>
  <script>

  this.createdat = ''
  this.title = ''
  this.html = ''

  bla.on('view', async (pathname) => {
    const res = await fetch(pathname)
    const json = await res.json()
    this.createdat = json.createdAt
    this.title = json.title
    this.html = this.opts.md.render(json.comment)
    this.update()
  })
  </script>
</md-note>

<raw-content>
  const updateHTML = () => { this.root.innerHTML = opts.html || '' }
  updateHTML()
  this.on('updated', updateHTML)
</raw-content>
