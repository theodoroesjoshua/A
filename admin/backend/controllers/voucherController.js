const db = require('@db')

exports.voucher_list = async (req, res) => {
  const all_vouchers_query = `
  SELECT code, start_date, end_date, claimed_date, status, branch, customer_id,
  issue_receipt_id, issuer.price AS issuer_price, issuer.admin_id AS issuer_admin_id, issuer.created_at AS issue_date,
  claim_receipt_id, claimer.price AS claimer_price, claimer.admin_id AS claimer_admin_id, claimer.created_at AS claim_date
  FROM vouchers
  LEFT JOIN receipts As issuer ON issue_receipt_id=issuer.id
  LEFT JOIN receipts As claimer ON claim_receipt_id=claimer.id
  ORDER BY start_date DESC;`

  const { rows } = await db.query(all_vouchers_query)

  res.status(200).json(rows)
}
