Dom = require('./dom')
Utility = require('./utility')
Headers = require('./headers')

module.exports =
  init: (state) ->

    self = @

    # TAB SIZE
    self.tabSize atom.config.get('subzero-ui.compactView')
    # TITLE BAR
    self.hideTitleBar atom.config.get('subzero-ui.hideTitleBar')
    # SHOW DOCUMENT TITLE
    self.hideDocumentTitle atom.config.get('subzero-ui.hideDocumentTitle')
    # PROJECT TAB
    self.hideProjectTab atom.config.get('subzero-ui.hideProjectTab')
    # DISPLAY IGNORED FILES
    self.ignoredFiles atom.config.get('subzero-ui.displayIgnored')
    # DISPLAY FILE ICONS
    self.fileIcons atom.config.get('subzero-ui.fileIcons')
    # HIDE TABS
    self.hideTabs atom.config.get('subzero-ui.hideTabs')
    # SET THEME
    self.setTheme atom.config.get('subzero-ui.themeColor'), false, false
    # ANIMATIONS
    self.animate atom.config.get('subzero-ui.disableAnimations')

    atom.config.onDidChange 'subzero-ui.themeColor', (value) ->
      self.setTheme value.newValue, value.oldValue, true

  package: atom.packages.getLoadedPackage('subzero-ui'),

  # RELOAD WHEN SETTINGS CHANGE
  refresh: ->
    self = @
    self.package.deactivate()
    setImmediate ->
      return self.package.activate()

  # SET THEME COLOR
  setTheme: (theme, previous, reload) ->
    self = this
    el = Dom.query('atom-workspace')
    fs = require('fs')
    path = require('path')

    # GET OUR PACKAGE INFO
    pkg = atom.packages.getLoadedPackage('subzero-ui')

    # SAVE TO ATOM CONFIG
    atom.config.set 'subzero-ui.themeColor', theme

  # SET TAB SIZE
  animate: (val) ->
    Utility.applySetting
      action: 'addWhenFalse'
      config: 'subzero-ui.disableAnimations'
      el: [
        'atom-workspace'
      ]
      className: 'seti-animate'
      val: val
      cb: @animate

  # SET TAB SIZE
  tabSize: (val) ->
    Utility.applySetting
      action: 'addWhenTrue'
      config: 'subzero-ui.compactView'
      el: [
        'atom-workspace'
      ]
      className: 'seti-compact'
      val: val
      cb: @tabSize

  # HIDE TITLE BAR
  hideTitleBar: (val) ->
    Utility.applySetting
      action: 'addWhenTrue'
      config: 'subzero-ui.hideTitleBar'
      el: [
        'atom-workspace'
      ]
      className: 'hide-title-bar'
      val: val
      cb: @hideTitleBar

  # HIDE DOCUMENT TITLE
  hideDocumentTitle: (val) ->
    Utility.applySetting
      action: 'addWhenTrue'
      config: 'subzero-ui.hideDocumentTitle'
      el: [
        'atom-workspace'
      ]
      className: 'hide-document-title'
      val: val
      cb: @hideDocumentTitle

  # HIDE DOCUMENT TITLE
  hideProjectTab: (val) ->
    Utility.applySetting
      action: 'addWhenTrue'
      config: 'subzero-ui.hideProjectTab'
      el: [
        'atom-workspace'
      ]
      className: 'hide-project-tab'
      val: val
      cb: @hideProjectTab


  # SET WHETHER WE SHOW TABS
  hideTabs: (val) ->
    Utility.applySetting
      action: 'addWhenTrue'
      config: 'subzero-ui.hideTabs'
      el: [
        'atom-workspace'
      ]
      className: 'seti-hide-tabs'
      val: val
      cb: @hideTabs
    return

  # SET WHETHER WE SHOW FILE ICONS
  fileIcons: (val) ->
    Utility.applySetting
      action: 'addWhenTrue'
      config: 'subzero-ui.fileIcons'
      el: [ 'atom-workspace' ]
      className: 'seti-icons'
      val: val
      cb: @fileIcons
    return

  # SET IF WE SHOW IGNORED FILES
  ignoredFiles: (val) ->
    Utility.applySetting
      action: 'addWhenFalse'
      config: 'subzero-ui.displayIgnored'
      el: [
        '.file.entry.list-item.status-ignored'
        '.directory.entry.list-nested-item.status-ignored'
      ]
      className: 'seti-hide'
      val: val
      cb: @ignoredFiles
