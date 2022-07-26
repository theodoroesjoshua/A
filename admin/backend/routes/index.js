const express = require('express');
const router = express.Router();

// Test endpoint
router.get("/", function(req, res) {
  response.json({ info: 'Node.js, Express, and Postgres API' })
});

module.exports = router;
