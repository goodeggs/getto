pathFn = (obj, path, def) ->
  for part in path.split '.'
    return def if not obj or typeof obj isnt 'object'
    obj = obj[part]
  return def if obj is undefined
  return obj

get = (path) ->
  pathFn @, path

module.exports = modelit = (obj) ->
  return obj unless obj?
  throw 'Not an Object' unless obj.constructor?.name is 'Object'

  Object.defineProperty obj, 'get', value: get, enumerable: false
  obj
