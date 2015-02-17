Nodulator = require 'nodulator'
client = new (require('node-rest-client').Client)()

# config =
# 	schema:
# 		name: 'string'
# 		ip: 'string'
# 		port: 'integer'
# 		root: 'string'

class ServerRoute extends Nodulator.Route.DefaultRoute
	Config: ->
		super()

		@Post '/:id/list', (req, res) =>
			return res.status(500).send {err: 'No path given'} if not req.body.path?

			r = req.resources[@resource.lname]

			args =
				headers:{"Content-Type": "application/json"}
				data: path: req.body.path

			servAnswer = client.post 'http://' + r.ip + ':' + r.port + '/api/1/filesystems/list', args, (data, response) =>
				data = JSON.parse data

				res.status(200).send data

			servAnswer.on 'error', (err) =>
				res.status(500).send err

		@Post '/:id/get', (req, res) =>
			return res.status(500).send {err: 'No path given'} if not req.body.path?

			r = req.resources[@resource.lname]

			args =
				headers:{"Content-Type": "application/json"}
				data: path: req.body.path

			servAnswer = client.post 'http://' + r.ip + ':' + r.port + '/api/1/filesystems/get', args, (data, response) =>
				res.status(200).send data

			servAnswer.on 'error', (err) =>
				res.status(500).send err

class ServerResource extends Nodulator.Resource 'server', ServerRoute

ServerResource.Init()

module.exports = ServerResource

ServerResource.Create
	name: 'server1'
	ip: '127.0.0.1'
	port: '3001'
	root: '/home/champii'
, (err, serv) ->
	return console.error err if err?

# ServerResource.Create
# 	name: 'server2'
# 	ip: '127.0.0.1'
# 	port: '3001'
# 	root: '/'
# , (err, serv) ->
# 	return console.error err if err?

# ServerResource.Create
# 	name: 'server3'
# 	ip: '127.0.0.1'
# 	port: '3001'
# 	root: '/'
# , (err, serv) ->
# 	return console.error err if err?
