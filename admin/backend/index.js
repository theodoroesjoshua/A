const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 3000

// Configure the app to use bodyParser()
app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

// Add routes
var indexRouter = require('./routes/index')
var vouchersRouter = require('./routes/vouchers')

const prefix = "/api/v1"
app.use(prefix, indexRouter)
app.use(prefix, vouchersRouter)

const db = require('./queries')
app.get('/vouchers', db.getVouchers)

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})
