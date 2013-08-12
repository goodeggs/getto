pathFn = (obj, path, def) ->
  for part in path.split '.'
    return def if not obj or typeof obj isnt 'object'
    obj = obj[part]
  return def if obj is undefined
  return obj

isObject = (value) ->
  return false if not value?
  return false if typeof value isnt 'object'
  value.constructor?.name is 'Object'

get = (path) ->
  value = pathFn @, path
  getit(value) if isObject(value)
  value

module.exports = getit = (obj) ->
  return obj if not obj?
  throw 'Not an Object' unless isObject(obj)

  Object.defineProperty obj, 'get', value: get, enumerable: false
  obj
