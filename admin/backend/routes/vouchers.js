const express = require('express');
const router = express.Router();
const controller = require('../controllers/voucherController');

router.get('/vouchers', controller.voucher_list);

module.exports = router;
