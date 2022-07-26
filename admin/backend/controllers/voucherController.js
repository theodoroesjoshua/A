// TODO: Find a better way to connect to postgres database
const Pool = require('pg').Pool
const pool = new Pool({
  user: 'me',
  host: 'localhost',
  database: 'sugoi',
  password: 'password',
  port: 5432,
})

// TODO: Make it asynchronous
exports.voucher_list = (req, res) => {
  pool.query('SELECT * FROM vouchers', (error, results) => {
    if (error) {
      throw error
    }

    response.status(200).json(results.rows)
  })
}

module.exports = {
  getVouchers,
}
