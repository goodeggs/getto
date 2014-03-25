expect = require 'expect.js'
require 'coffee-errors'
express = require 'express'
getto = require '..'

describe 'getto', ->
  describe 'mixin behavior', ->
    obj = null

    describe 'on a bare object', ->
      beforeEach ->
        obj = {foo: 1}

      it "returns newly getto'd object", ->
        returnVal = getto(obj)
        expect(returnVal).to.be obj
        expect(obj.get).to.be.ok

    describe "on a getto'd object", ->
      beforeEach ->
        obj = {foo: 1}
        getto(obj)

      it "returns the object", ->
        expect(getto(obj)).to.be obj

  describe 'get', ->
    obj = null
    beforeEach ->
      obj = {
        foo: 'one'
        bar: {
          two: 3
        }
        baz: [{a: 1}, {b: 2}]
      }
      getto(obj)

    it 'gets shallow path', ->
      expect(obj.get 'foo').to.be 'one'

    it 'gets deep path', ->
      expect(obj.get 'bar.two').to.be 3

    it 'gets array path', ->
      expect(obj.get 'baz.0.a').to.be 1

    it 'returns undefined for non-existant path', ->
      expect(obj.get 'bar.three.1').to.be undefined

    it 'mixes getto into objects returned by get', ->
      expect(obj.get('bar').get('two')).to.be 3

    it 'mixes getto into objects in arrays returned by get', ->
      expect(obj.get('baz')[0].get('a')).to.be 1

    it 'wont clobber get', ->
      expect(-> getto({get: true})).to.throwError()

    it 'wont mix in twice', ->
      expect(-> getto(obj)).to.not.throwError()
