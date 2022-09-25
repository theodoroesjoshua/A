require('dotenv').config()
require('module-alias/register')
const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 3100

// Enabler cross-origin resource sharing for API only backend
// TODO: Cors should be limited to the frontend's domain
var cors = require('cors');
app.use(cors());

// Configure the app to use bodyParser()
app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

// Configure passport middleware
const passport = require("passport");
app.use(passport.initialize());
require("@helpers/passport")(passport);

// Mount all app's routes
const mountRoutes = require('@routes')
mountRoutes(app)

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})
