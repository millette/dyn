<wanna-fork>
  <h3>Want to fork? <button onclick={forkMe}>Fork me!</button></h3>
  <p>{forkingText}</p>
  <p if={ownerText}>
    <strong>Note:</strong>
    {ownerText}
  </p>

  <script>
    const ranks = ['the first', 'the second', 'the third', 'the fourth', 'late']
    const forkerRank = ranks[
      Math.min(
        ranks.length - 1,
        this.opts.forkOf && this.opts.forkOf.length || 0
      )
    ]
    this.forkingText = `Want to fork me? You'd be ${forkerRank} generation to do so.`

    this.ownerText = this.opts.isOwner
      ? 'You are already the owner. You can edit me.'
      : 'Fork me to become the owner and be able to edit me.'

    async forkMe () {
      // prompt user
      const title = `Fork (gen. ${1 + (this.opts.forkOf && this.opts.forkOf.length || 0)}) of ${this.opts.title}`
      const $but = document.querySelector('wanna-fork > h3 > button')
      $but.disabled = true
      if (!this.opts.isOwner) {
        $but.innerText = 'Downloading, please wait...'
        await this.opts.selfArchive.download('/')
      }

      $but.innerText = 'Forking, please wait...'
      try {
        const selfForkArchive = await DatArchive.fork(this.opts.selfArchive, { title })
        $but.innerText = 'Forking done, redirecting...'
        window.location = selfForkArchive.url
      } catch (e) {
        $but.disabled = false
        $but.innerText = 'Forking aborted by user'
        setTimeout(($b) => { $b.innerText = 'Fork me!' }, 3000, $but)
      }
    }
  </script>
</wanna-fork>
