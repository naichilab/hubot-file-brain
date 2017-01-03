# Description
#   A hubot script that does the things
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   naichilab <naichilab@live.jp>

Fs = require 'fs'

config =
  path: process.env.HUBOT_FILE_BRAIN_PATH

module.exports = (robot) ->
  unless config.path?
    robot.logger.error 'process.env.HUBOT_FILE_BRAIN_PATH is not defined'
    return

  robot.brain.setAutoSave false

  load = ->
    if Fs.existsSync config.path
      data = JSON.parse Fs.readFileSync config.path, encoding: 'utf-8'
      robot.brain.setAutoSave true

  save = (data) ->
    Fs.writeFileSync config.path, JSON.stringify data

  robot.brain.on 'save', save

  load()

  robot.respond /(\S+)$/, (msg) ->
    message = msg.match[1]
    robot.brain.set 'example', message
    msg.send message
