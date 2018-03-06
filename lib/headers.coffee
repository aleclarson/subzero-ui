atom.packages.activatePackage('tree-view').then (tree) ->
  treeView = tree.mainModule.treeView
  projectRoots = treeView.roots
  stickyHeader = null
  stickyRoot = null

  scrollY = 0
  updating = null
  treeView.element.addEventListener 'scroll', ->
    scrollY = treeView.element.scrollTop
    updating ?= requestAnimationFrame updateStickyHeader

  updateStickyHeader = ->
    updating = null
    prevRoot = stickyRoot
    prevHeader = stickyHeader

    for root in projectRoots
      startY = root.offsetTop
      endY   = startY + root.offsetHeight
      if scrollY < endY - root.header.offsetHeight
        stickyRoot = if scrollY >= startY then root else null
        if prevRoot is stickyRoot then return else break

    if prevRoot

      # Remove the previous header if it's under the next header.
      if prevRoot.offsetTop > scrollY
        prevHeader.parentNode.removeChild prevHeader

      # Otherwise, preserve the previous header,
      # but stick it to the bottom of its parent.
      else prevHeader.classList.add 'bottom'

    if stickyRoot
      # Look for an existing sticky header.
      stickyHeader = stickyRoot.querySelector '.header.is--sticky'
      if stickyHeader
        # The existing header was stuck to the bottom of its parent.
        stickyHeader.classList.remove 'bottom'
      else
        # Clone the normal header and make it sticky.
        stickyHeader = stickyRoot.header.cloneNode true
        stickyHeader.classList.add 'is--sticky'
        stickyRoot.insertBefore stickyHeader, stickyRoot.firstChild

  atom.project.onDidChangePaths ->
    projectRoots = treeView.roots
    updateStickyHeader()

  # TODO something other than setTimeout? it's a hack to trigger the update
  # after the CSS changes have occurred. a gamble, probably inaccurate
  atom.config.onDidChange 'subzero-ui', ->
    setTimeout updateStickyHeader
  setTimeout updateStickyHeader
