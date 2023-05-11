const db = require('@db')

const DEFAULT_LIMIT = 20
const DEFAULT_OFFSET = 0

const ALL_VOUCHERS_QUERY = `
SELECT code, start_date, end_date, claimed_date, status, branch, customer_id,
issue_receipt_id, issuer.price AS issuer_price, issuer.admin_id AS issuer_admin_id, issuer.created_at AS issue_date,
claim_receipt_id, claimer.price AS claimer_price, claimer.admin_id AS claimer_admin_id, claimer.created_at AS claim_date
FROM vouchers
LEFT JOIN receipts As issuer ON issue_receipt_id=issuer.id
LEFT JOIN receipts As claimer ON claim_receipt_id=claimer.id
ORDER BY start_date DESC
OFFSET $1 LIMIT $2;`

exports.voucher_list = async (req, res) => {
  const limit = req.query.limit ?? DEFAULT_LIMIT
  const offset = req.query.offset ?? DEFAULT_OFFSET

  const query = {
    name: 'fetch-all-vouchers',
    text: ALL_VOUCHERS_QUERY,
    values: [offset, limit],
  }

  const { rows } = await db.query(query)

  res.status(200).json(rows)
}

exports.voucher_issue = async (req, res) => {
  // TODO: Parse request's phone number, create or find user from that
  // TODO: Parse request's receipt, create or find receipt from that
  // TODO: Create X amount of vouchers based on the receipt's value

  const success_message = 'Berhasil membuat 5 voucher baru untuk nomor 000011112222. ' +
      'Pengguna secara keseluruhan memiliki 5 voucher dari transaksi RECEIPTA';
  res.status(200).json({"message": success_message})
}
