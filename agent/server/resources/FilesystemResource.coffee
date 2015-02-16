fs = require 'fs'
async = require 'async'
Nodulator = require 'nodulator'

class FilesystemRoute extends Nodulator.Route.DefaultRoute
	Config: ->
		super()

		@Post '/list', (req, res) =>
			return res.status(500).send {err: 'No path given'} if not req.body.path?

			fs.stat req.body.path, (err, stat) =>
				return res.status(500).send err if err?

				if not stat.isDirectory()
					return res.status(500).send {err: "Not a directory"}

				fs.readdir req.body.path, (err, result) =>
					return res.status(500).send err if err?

					newRes = []
					async.map result, (item, done) -> 
						fs.stat req.body.path + '/' + item, (err, stat) ->
							return done err if err?

							done null, 
								name: item
								isDirectory: stat.isDirectory()
					, (err, results) ->
						return res.status(500).send err if err?

						res.status(200).json results

		@Post '/get', (req, res) =>
			return res.status(500).send {err: 'No path given'} if not req.body.path?

			fs.stat req.body.path, (err, stat) =>
				return res.status(500).send err if err?

				if not stat.isFile()
					return res.status(500).send {err: "Not a directory"}

				fs.readFile req.body.path, (err, result) =>
					return res.status(500).send err if err?

					res.status(200).send result

class FilesystemResource extends Nodulator.Resource 'Filesystem', FilesystemRoute

FilesystemResource.Init()

module.exports = FilesystemResource
