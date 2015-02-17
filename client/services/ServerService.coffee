class ServerService extends Nodulator.ResourceService 'server'

	shownFile: ''

	List: (done) ->
		super (err, list) =>
			return done err if err?

			@list = []
			for serv in list
				node =
					serverId: serv.id
					path: serv.root
					label: serv.name
					id: serv.id
					children: []
					isDirectory: true
					collapsed: true

				@FetchTree node
				@list.push node

			done null, @list if done?

	FetchTree: (node, done) ->
		if not node.isDirectory or node.children.length
			return

		@$http.post '/api/1/servers/' + node.serverId + '/list', {path: node.path}
			.success (data) =>
				for item, i in data
					node.children.push
						label: item.name
						id: node.id + '-' + i
						children: []
						isDirectory: item.isDirectory
						collapsed: true
						serverId: node.serverId
						path: (if node.path is '/' then '' else node.path) + '/' + item.name

			.error (data) =>

	FetchFile: (node, done) ->
		console.log 'FetchFile (ServerService)', node
		if node.isDirectory or node.children.length
			return

		console.log 'FetchFile (ServerService, after dir check)'

		@$http.post '/api/1/servers/' + node.serverId + '/get', {path: node.path}
			.success (data) =>
				console.log 'File got : ', data
				@shownFile = data
			.error (data) =>
				@shownFile = 'Error reading file'

ServerService.Init()
