expect = require 'expect.js'
require 'coffee-errors'
express = require 'express'
getit = require '..'

describe 'getit', ->
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
      getit(obj)

    it 'gets shallow path', ->
      expect(obj.get 'foo').to.be 'one'

    it 'gets deep path', ->
      expect(obj.get 'bar.two').to.be 3

    it 'gets array path', ->
      expect(obj.get 'baz.0.a').to.be 1

    it 'returns undefined for non-existant path', ->
      expect(obj.get 'bar.three.1').to.be undefined

    it 'mixes getit into objects returned by get', ->
      expect(obj.get('bar').get('two')).to.be 3

    it 'mixes getit into objects in arrays returned by get', ->
      expect(obj.get('baz')[0].get('a')).to.be 1



