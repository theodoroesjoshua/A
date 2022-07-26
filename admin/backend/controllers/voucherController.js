// TODO: Find a better way to connect to postgres database
const Pool = require('pg').Pool
const pool = new Pool({
  user: 'me',
  host: 'localhost',
  database: 'sugoi',
  password: 'password',
  port: 5432,
})

exports.voucher_list = async (req, res) => {
  const { rows } = await pool.query('SELECT * FROM vouchers')
  res.status(200).json(rows)
}
