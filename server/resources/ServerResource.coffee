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

		@Post '/:id/get', (req, res) =>
			return res.status(500).send {err: 'No path given'} if not req.body.path?

			r = req[@resource.lname]

			args = 
				headers:{"Content-Type": "application/json"} 
				data: path: req.body.path

			servAnswer = client.post 'http://' + r.ip + ':' + r.port + '/api/1/filesystems', args, (data, response) =>
				if response.statusCode is 200
					data = JSON.parse data

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
	root: '/'
, (err, serv) ->
	return console.error err if err?
