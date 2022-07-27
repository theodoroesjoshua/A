const JwtStrategy = require("passport-jwt").Strategy
const ExtractJwt = require("passport-jwt").ExtractJwt
const db = require('../db')
const opts = {}

opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken()
opts.secretOrKey = process.env.SECRET_OR_KEY

module.exports = passport => {
  passport.use(
    new JwtStrategy(opts, (jwt_payload, done) => {
      const query = {
        name: 'get-user',
        text: 'SELECT username, branch, role FROM admins WHERE username = $1',
        values: [jwt_payload.username],
      }

      db.query(query)
        .then(results => {
          if (results.rows.length != 1) {
            return done(null, false)
          }
          user = results.rows[0]
          return done(null, user)
        })
        .catch(err => {
          console.log(err)
          return done(null, false)
        })
      }
    )
  )
}
