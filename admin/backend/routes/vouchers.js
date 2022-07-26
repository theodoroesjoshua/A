const router = require('express-promise-router')()
const controller = require('../controllers/voucherController')

router.get('/vouchers', controller.voucher_list)

module.exports = router;
