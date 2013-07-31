noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  Parse = require '../components/Parse.coffee'
else
  Parse = require 'noflo-adapters/components/Parse.js'

describe 'Parse component', ->
  c = null
  ins = null
  out = null
  encoding = null

  beforeEach ->
    c = Parse.getComponent()
    ins = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    encoding = noflo.internalSocket.createSocket()
    c.inPorts.in.attach ins
    c.inPorts.encoding.attach encoding
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have an input port', ->
      chai.expect(c.inPorts.in).to.be.an 'object'
      chai.expect(c.inPorts.encoding).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'

  describe 'given a string', ->
    input = 'I am so excited to be encoded'

    it 'is encoded into CryptoJS object', (done) ->
      out.on 'data', (data) ->
        chai.expect(data.words).is.not.null
      out.on 'disconnect', ->
        done()

      ins.connect()
      ins.send input
      ins.disconnect()
