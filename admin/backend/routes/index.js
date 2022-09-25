const testRouter = require('express-promise-router')()

// Test endpoint
testRouter.get("/", function(req, res) {
  res.json({ info: 'Node.js, Express, and Postgres API' })
})

const vouchers = require('./vouchers')
const users = require('./users')

const prefix = "/api/v1"
module.exports = app => {
  app.use(prefix, testRouter)
  app.use(prefix, vouchers)
  app.use(prefix, users)
}
