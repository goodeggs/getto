pathFn = (obj, path) ->
  for part in path.split '.'
    return obj if not obj? or typeof obj isnt 'object'
    obj = obj[part]
  return obj

isObject = (value) ->
  return false if not value?
  return false if typeof value isnt 'object'
  value.constructor is Object

get = (path) ->
  value = pathFn @, path
  getit(value) if isObject(value)
  if Array.isArray(value)
    getit(item) for item in value when isObject(item)
  value

get.getit = true # Identify this getter as ours

module.exports = getit = (obj) ->
  return obj if not obj?
  throw new Error('Not an Object') unless isObject(obj)
  return if obj.get?.getit # Don't mix in twice
  throw new Error("'get' is already defined") if obj.get?

  Object.defineProperty obj, 'get', value: get, enumerable: false
  obj
