# Kill some developers
#
# Make sure you setup the HUBOT_RETALIATION_URL environment variable with a URL to
# the retaliation port.
#
# kill <person> - Shoots that person
module.exports = (robot) ->
  robot.respond /kill (.*)/i, (message) ->
    HOST = "#{process.env.HUBOT_RETALIATION_HOST}"
    PORT = "#{process.env.HUBOT_RETALIATION_PORT}"
    dgram = require('dgram')
    util = require('util')
    victim = { "victim": message[1] || "" }
    buffer = new Buffer(JSON.stringify(victim))
    client = dgram.createSocket("udp4")
    client.send(buffer, 0, buffer.length, PORT, HOST, (err, bytes) ->
      client.close()
    )
    msg.send "Target annihilated"
