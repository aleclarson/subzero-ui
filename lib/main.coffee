module.exports =
  activate: (state) ->
    require( atom.packages.getLoadedPackage('subzero-ui').path + '/lib/settings').init()
