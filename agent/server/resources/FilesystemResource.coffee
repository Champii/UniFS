fs = require 'fs'
Nodulator = require 'nodulator'

class FilesystemRoute extends Nodulator.Route.DefaultRoute
	Config: ->
		super()

		@Post (req, res) =>
			return res.status(500).send {err: 'No path given'} if not req.body.path?

			fs.stat req.body.path, (err, stat) =>
				return res.status(500).send err if err?

				cmd = null
				# 200 for directory
				# 201 for file
				code = 200
				if stat.isDirectory()
					cmd = fs.readdir
				else if stat.isFile()
					cmd = fs.readFile
					code = 201


				if not cmd?
					return res.status(500).send {err: 'Unknown file'}

				cmd req.body.path, (err, result) =>
					return res.status(500).send err if err?

					res.status(code).send result


class FilesystemResource extends Nodulator.Resource 'Filesystem', FilesystemRoute

FilesystemResource.Init()

module.exports = FilesystemResource
