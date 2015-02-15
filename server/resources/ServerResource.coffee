Nodulator = require 'nodulator'

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
			console.log req.body
			res.sendStatus(200)


class ServerResource extends Nodulator.Resource 'server', ServerRoute

ServerResource.Init()

module.exports = ServerResource
