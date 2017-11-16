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


_.mixin compactObject: (obj) ->
  _.each obj, (value, key) ->
    if _.isArray value
      value = value.map (e) -> e unless e is "N/A" # removes some extra values
      obj[key] = (_.compact value)
      delete obj[key] if obj[key].length is 0
    delete obj[key] unless value
  return obj


_.mixin buildDateTime: (date, time) ->
  if not date then return null
  # not sure if instance of is helpful
  if date instanceof Date
    # we do this instead of trimming getISOString because timezones can lead to the date be wrong ("2017-01-12T00:00:00+01" -> "2017-01-11T23:00:00Z")
    date = "#{date.getFullYear()}-#{date.getMonth() + 1}-#{date.getDate()}"

  if date.length > 0 then datum = date.slice(0, 10) else return null
  if time then "#{datum}T#{time}" else "#{datum}T00:00:00"


module.exports = _

