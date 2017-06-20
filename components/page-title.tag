<page-title>
  <h1><a href="/">{ title }</a></h1>
  <h2>{ description }</h2>

  <script>
    this.title = opts.title || 'Title N/A'
    this.description = opts.description || 'Description N/A'
    const $head = document.querySelector('head')
    const $title = document.createElement('title')
    $title.innerText = this.title
    $head.appendChild($title)
  </script>
</page-title>
