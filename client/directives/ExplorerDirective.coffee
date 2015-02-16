class ExplorerDirective extends Nodulator.Directive 'explorer', 'serverService'

	FetchNode: (node) ->
		# console.log 'ToFetch', node
		for item in node.children
			@serverService.FetchTree item

ExplorerDirective.Init()
