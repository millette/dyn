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

  <dat-notes archive={opts.archive}></dat-notes>

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

    write (resp) {
      opts.archive.writeFile(
        `/notes/note-${Date.now()}.json`,
        JSON.stringify(resp),
        'utf-8'
      )
      this.update({ resp })
    }

    submit (e) {
      e.preventDefault()

      const obj = {
        createdAt: new Date().toISOString(),
        title: this.refs.title.value,
        comment: this.refs.comment.value
      }

      // FIXME: mkdir throws if /notes/ already exists
      opts.archive.mkdir('/notes')
        .then(() => this.write(obj))
        .catch((e) => this.write(obj))
    }

  </script>
</dat-can-mutate>

<dat-notes>
  <h3 onclick={noteFiles}>Notes</h3>
  <ol if={topFiles && topFiles.length}>
    <li each={topFiles}>
      <a href={fn}>{title}</a>  - <a href={fn} onclick={edit}>edit</a>
    </li>
  </ol>

  <script>
    this.topFiles = false

    async edit (e) {
      e.preventDefault()
      // console.log(e.target, e.target.pathname)

      const fn = e.target.pathname
      const fc = await opts.archive.readFile(fn)
      const obj = JSON.parse(fc)
      console.log(fn, obj)
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
    // for now, we trigger noteFiles by clicking on the Notes h3
    // FIXME: call on form submit
    this.noteFiles()
  </script>

</dat-notes>
