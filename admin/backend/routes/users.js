const router = require('express-promise-router')()
const controller = require('../controllers/userController')

router.post('/user/authenticate', controller.user_authenticate)

module.exports = router
