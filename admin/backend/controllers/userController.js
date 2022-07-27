const db = require('../db')
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// POST /user/authenticate
exports.user_authenticate = async function(req, res) {
  const { username, password } = req.body
  console.log(username)
  const query = {
    text: 'SELECT username, hash_password, branch, role FROM admins WHERE username = $1',
    values: [username],
  }

  const results = await db.query(query)
  if (results.rows.length != 1) {
    res.status(401).json({ msg: "Incorrect username or password" })
  }
  const user = results.rows[0]

  const isMatch = await bcrypt.compare(password, user.hash_password)
  if (!isMatch) {
    res.status(401).json({ msg: "Incorrect username or password" })
    return
  }

  let authenticatedUser = {
    username: user.username,
    branch: user.branch,
    role: user.role,
    token: ""
  }
  authenticatedUser.token = jwt.sign({ username: user.username }, process.env.SECRET_OR_KEY)
  res.json(authenticatedUser)
}
