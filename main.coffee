Nodulator = require 'nodulator'
Server = require './server'

Socket = require 'nodulator-socket'
Assets = require 'nodulator-assets'
Angular = require 'nodulator-angular'
Account = require 'nodulator-account'


Nodulator.Use Socket
Nodulator.Use Assets
Nodulator.Use Angular
Nodulator.Use Account

Nodulator.Config
	port: 3000

Server.Init()
Nodulator.Run()
