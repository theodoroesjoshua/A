const router = require('express-promise-router')()
const controller = require('../controllers/voucherController')
const passport = require("passport");

function ensureActiveAccount(req, res, next) {
  if (req.user.role !== role.deactivated)
      return next();

  res.sendStatus(401);
}

router.get('/vouchers', passport.authenticate('jwt', { session: false }),
    ensureActiveAccount, controller.voucher_list)

module.exports = router;
