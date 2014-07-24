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

  describe 'wrapping a function', ->
    describe "that takes a product as an option", ->
      getName = getto ({person}) ->
        person.get('name')

      it "gettos the option", ->
        expect(getName person: {name: 'Erik'}).to.be 'Erik'

      it "works with already getto'd options", ->
        expect(getName getto person: {name: 'Erik'}).to.be 'Erik'

    it "works with non-object options", ->
      up = getto ({word}) -> word.toUpperCase()
      expect(up word: 'Hamlet').to.be 'HAMLET'

    it "throws an error if you have more than one argument" ,->
      hello = getto -> 'hi'
      expect(-> hello 'one', 'two').to.throwError()

    it "throws an error if you pass a non-object to the wrapped function", ->
      hello = getto -> 'hi'
      expect(-> hello 'one').to.throwError()

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
