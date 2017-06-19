<dat-mutate>

  <dat-can-mutate archive={opts.selfArchive} if={isOwner}></dat-can-mutate>
  <dat-cant-mutate if={!isOwner}></dat-cant-mutate>

  <script>
    this.isOwner = opts.isOwner

  </script>
</dat-mutate>

<dat-cant-mutate>
  <h3>You can't add something, you're not the owner</h3>
</dat-cant-mutate>

<dat-can-mutate>
  <h3>Let's add something</h3>
  <p>
    You'll find your notes in the <a href="notes/">notes directory</a>.
  </p>

  <h3 onclick={noteFiles}>Notes</h3>
  <ol if={topFiles && topFiles.length}>
    <li each={topFiles}>
      <a href={fn}>{title}</a> -
      <a href={fn} onclick={view}>view</a> -
      <a href={fn} onclick={edit}>edit</a> -
      <a href={fn} onclick={del}>delete</a>
    </li>
  </ol>

  <pre if={resp}>{JSON.stringify(resp, null, '  ')}</pre>
  <h3>Add a note</h3>
  <form onsubmit={submit}>
    <label>
      Title
      <input type="text" ref="title" />
    </label>

    <label>
      Note
      <textarea rows="8" ref="comment"></textarea>
    </label>
    <br>
    <input type="submit" />
    <input onclick={reset} type="reset" />
    <br>
  </form>

  <script>
    this.resp = false

    reset (e) { this.resp = false }

    async write (resp) {
      await opts.archive.writeFile(
        `/notes/note-${Date.now()}.json`,
        JSON.stringify(resp),
        'utf-8'
      )
      this.update({ resp })
      return this.noteFiles()
    }

    async submit (e) {
      e.preventDefault()
      const obj = {
        createdAt: new Date().toISOString(),
        title: this.refs.title.value,
        comment: this.refs.comment.value
      }

      try {
        await opts.archive.mkdir('/notes')
      } catch (e) {
        // probably because /notes/ already exists...
        // console.error('mkdir...', e)
      }
      return this.write(obj)
    }

    this.topFiles = false

    view (e) {
      e.preventDefault()
      bla.trigger('view', e.target.href)
    }

    async del (e) {
      e.preventDefault()
      const fn = e.target.pathname
      await opts.archive.unlink(fn)
      return this.noteFiles()
    }

    async edit (e) {
      e.preventDefault()
      const fn = e.target.pathname
      const fc = await opts.archive.readFile(fn)
      const obj = JSON.parse(fc)
      this.refs.title.value = obj.title
      this.refs.comment.value = obj.comment
    }

    async noteFiles () {
      const topFilesP = await opts.archive.readdir('/notes/')
      return Promise.all(topFilesP
        .sort()
        .reverse()
        .slice(0, 10)
        .map(async (topFile) => {
          const fn = `/notes/${topFile}`
          const fc = await opts.archive.readFile(fn)
          const obj = JSON.parse(fc)
          obj.fn = fn
          return obj
        })
      )
        .then((topFiles) => this.update({ topFiles }))
    }
    this.noteFiles()
  </script>
</dat-can-mutate>
