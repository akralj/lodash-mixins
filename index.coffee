_ = require("lodash")

# https://github.com/epeli/underscore.string
#_.mixin(require('underscore.string').exports())


_.mixin sanatizeQuery: (query) ->
  query?.trim().toLowerCase().replace(/\s+/gi,' ')


_.mixin capitalize: (phrase) ->
  res = phrase.split(' ').map (string) ->
    string.charAt(0).toUpperCase() + string.substring(1).toLowerCase()
  res.join(' ')


_.mixin capitalizeName: (str) ->
  str.toLowerCase().replace /(?:^|\s|-)\S/g, (a) -> a.toUpperCase()


_.mixin padWithZeros: (num, length=7) ->
  # only pads numbers
  if /^\d+$/.test(num) or _.isNumber num
    ("000000000000000000000000000" + num).slice(-length)
  else false


module.exports = _


###
_.mixin compactObject: (obj) ->
  _.each obj, (value, key) ->
    if _.isArray value
      value = value.map (e) -> e unless e is "N/A" # removes some extra values
      obj[key] = (_.compact value)
      delete obj[key] if obj[key].length is 0
    delete obj[key]  unless value
  return obj


#https://github.com/nrf110/deepmerge
_.mixin deepMerge: (target, src) ->
  array = Array.isArray(src)
  dst = array and [] or {}
  if array
    target = target or []
    dst = dst.concat(target)
    src.forEach (e, i) ->
      if typeof target[i] is "undefined"
        dst[i] = e
      else if typeof e is "object"
        dst[i] = _.deepMerge(target[i], e)
      else
        dst.push e  if target.indexOf(e) is -1

  else
    if target and typeof target is "object"
      Object.keys(target).forEach (key) ->
        dst[key] = target[key]

    Object.keys(src).forEach (key) ->
      if typeof src[key] isnt "object" or not src[key]
        dst[key] = src[key]
      else
        unless target[key]
          dst[key] = src[key]
        else
          dst[key] = _.deepMerge(target[key], src[key])

  return dst

###
