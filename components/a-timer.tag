<a-timer>

  <p>Seconds Elapsed: { time }</p>

  <script>
    this.time = opts.start || 0
    tick() { this.update({ time: ++this.time }) }
    const timer = setInterval(this.tick, 1000)
    const done = () => clearInterval(timer)
    this.on('unmount', done)
  </script>

</a-timer>
