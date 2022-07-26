const db = require('../db')

exports.voucher_list = async (req, res) => {
  const { rows } = await db.query('SELECT * FROM vouchers')
  res.status(200).json(rows)
}
