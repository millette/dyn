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
      const selfForkArchive = await DatArchive.fork(this.opts.selfArchive)
      window.location = selfForkArchive.url
    }
  </script>

</wanna-fork>
