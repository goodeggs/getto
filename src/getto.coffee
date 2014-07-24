pathFn = (obj, path) ->
  for part in path.split '.'
    return obj if not obj? or typeof obj isnt 'object'
    obj = obj[part]
  return obj

isObject = (value) ->
  return false if not value?
  return false if typeof value isnt 'object'
  value.constructor is Object

wrapFunction = (func) ->
  (options) ->
    for key of options
      value = options[key]
      if typeof value is 'object' and not value.get
        options[key] = getto value

    func options

get = (path) ->
  value = pathFn @, path
  getto(value) if isObject(value)
  if Array.isArray(value)
    getto(item) for item in value when isObject(item)
  value

get.getto = true # Identify this getter as ours

module.exports = getto = (obj) ->
  return wrapFunction obj if typeof obj is 'function'
  return obj if not obj?
  throw new Error('Not an Object') unless isObject(obj)
  return obj if obj.get?.getto # Don't mix in twice
  throw new Error("'get' is already defined") if obj.get?

  Object.defineProperty obj, 'get', value: get, enumerable: false
  obj
