<dat-changes>
  <h3 if={changes}>Changes</h3>
  <ol if={changes}>
    <li each={changes}>{change}</li>
  </ol>

  <script>
    this.changes = [
      'ok'
    ].map((change) => { return { change } })

    const evFn = (e) => {
      /*
      const $li = d.createElement('li')
      $li.innerText = `${e.path} ${e.type} at ${new Date().toISOString()}`
      $ol.appendChild($li)
      */

      // this.update({ })
      this.changes.push({
        change: `${e.path} ${e.type} at ${new Date().toISOString()}`
      })
    }

    opts.fileEvents.addEventListener('invalidated', evFn)
    opts.fileEvents.addEventListener('changed', evFn)

    this.on('unmount', () => {
      removeEventListener('invalidated', evFn)
      removeEventListener('changed', evFn)
    })


    // this.time = opts.start || 0
    // tick() { this.update({ time: ++this.time }) }
    // const timer = setInterval(this.tick, 1000)
    // const done = () => clearInterval(timer)
    // this.on('unmount', done)
  </script>
</dat-changes>
