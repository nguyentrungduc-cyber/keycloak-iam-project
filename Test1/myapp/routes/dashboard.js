const express = require('express');
const { protect } = require('../middleware/auth');
const router = express.Router();

router.get('/', protect, (req, res) => {
  const token = req.kauth.grant.access_token;
  res.render('dashboard', {
    user: token.content,
    roles: token.content.realm_access?.roles || []
  });
});

module.exports = router;
