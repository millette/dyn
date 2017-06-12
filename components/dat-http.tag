<dat-http>
  <h1>Oh, hello!</h1>
  <h2>Not using the Beaker Browser yet?</h2>
  <p>
    Without beaker and dat support, I'm afraid this website will seem quite pointless.
    See {loc} perhaps...
  </p>

  <script>
    this.loc = String(window.location).replace(/https{0,1}:\/\//, 'dat://')
  </script>
</dat-http>
