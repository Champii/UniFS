class ExplorerDirective extends Nodulator.Directive 'explorer', 'serverService'

  FetchNode: (node) ->
    for item in node.children
      @serverService.FetchTree item

  FetchFile: (node) ->
    console.log 'FetchFile (ExplorerDirective)', node
    @serverService.FetchFile node

ExplorerDirective.Init()
