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
        baz: ['a', 'b']
      }
      getit(obj)

    it 'gets shallow path', ->
      expect(obj.get 'foo').to.be 'one'

    it 'gets deep path', ->
      expect(obj.get 'bar.two').to.be 3

    it 'gets array path', ->
      expect(obj.get 'baz.1').to.be 'b'

    it 'returns undefined for non-existant path', ->
      expect(obj.get 'bar.three.1').to.be undefined



