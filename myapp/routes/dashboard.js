const express = require('express');
const { protect } = require('../middleware/auth');
const router = express.Router();

router.get('/', protect, (req, res) => {
  const user = req.session.user || {};
  const roles = req.session.roles || [];
  res.render('dashboard', {
    user,
    roles
  });
});

module.exports = router;
