'use strict'

ms            = require 'pretty-ms'
DEFAULT       = require './Bumped.default'
MSG           = require './Bumped.messages'
chalk         = require 'acho/node_modules/chalk'

module.exports = class Animation

  constructor: (params = {}) ->
    @[param] = value for param, value of params

  start: (cb) ->
    @start = new Date()
    @running = true
    @logger.keyword = @plugin
    @logger.success "Starting '#{chalk.cyan(@text)}'..."
    cb()

  stop: (err, cb) ->
    @running = false

    if err
      @logger.error err.message
      process.stdout.write '\n'
    else
      end = ms(new Date() - @start)
      @logger.success "Finished '#{chalk.cyan(@text)}' after #{chalk.magenta(end)}."

    @logger.keyword = DEFAULT.logger.keyword
    cb err

  @end: (opts) ->
    if opts.outputMessage
      diff = ms(new Date() - opts.start)
      message = "#{MSG.CREATED_VERSION(opts.version)} after #{chalk.magenta(diff)}."
      process.stdout.write '\n'
      opts.logger.success message
