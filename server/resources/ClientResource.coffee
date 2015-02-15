Nodulator = require 'nodulator'

class ClientResource extends Nodulator.AccountResource 'client', Nodulator.Route.DefaultRoute

ClientResource.Init()

module.exports = ClientResource
