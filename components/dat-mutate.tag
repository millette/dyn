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
  <pre if={resp}>{JSON.stringify(resp, null, '  ')}</pre>
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
