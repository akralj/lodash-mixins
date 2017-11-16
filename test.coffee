# unit tests

tap = require('tap')
_ = require("./index.coffee")

#console.log Object.keys(_)
#


dates = [
  { date: "2017-01-12T00:00:00",  time: "14:00", res: "2017-01-12T14:00" }
  { date: "2017-01-12",           time: "14:00", res: "2017-01-12T14:00" }
  { date: new Date("2017-01-12"), time: "14:00", res: "2017-01-12T14:00" }
  { date: "", res: null }
]


tap.test "buildDateTime", (t) ->
  t.plan dates.length
  for item in dates
    t.equal(_.buildDateTime(item.date, item.time), item.res )
