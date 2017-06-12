<wanna-fork>
  <h3>Want to fork? <button>Fork me!</button></h3>
  <p>{forkingText}</p>

  <script>
    const ranks = [
      'the first',
      'the second',
      'the third',
      'the fourth',
      'late'
    ]

    const forkerRank = ranks[
      Math.min(
        ranks.length - 1,
        this.opts.forkOf && this.opts.forkOf.length || 0
      )
    ]
    this.forkingText = `Want to fork me? You'd be ${forkerRank} to do so.`
  </script>

</wanna-fork>
