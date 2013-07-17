noflo = require "noflo"
if typeof process is "object" and process.title is "node"
  chai = require "chai" unless chai
  Encoder = require "../components/Encoder.coffee"
else
  Encoder = require "crypto/components/Encoder.js"

describe "Encoder component", ->
  c = null
  ins = null
  out = null
  beforeEach ->
    c = Encoder.getComponent()
    ins = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.in.attach ins
    c.outPorts.out.attach out

  describe "when instantiated", ->
    it "should have an input port", ->
      chai.expect(c.inPorts.in).to.be.an "object"
    it "should have an output port", ->
      chai.expect(c.outPorts.out).to.be.an "object"
