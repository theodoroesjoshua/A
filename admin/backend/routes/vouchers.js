const router = require('express-promise-router')()
const controller = require('../controllers/voucherController')
const passport = require("passport");

router.get('/vouchers', passport.authenticate('jwt', { session: false }), controller.voucher_list)

module.exports = router;
