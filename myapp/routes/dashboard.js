const express = require('express');
const { protect } = require('../middleware/auth');
const router = express.Router();

router.get('/', protect, (req, res) => {
  // Lấy toàn bộ Access Token
  const token = req.kauth.grant.access_token;
  
  // Dữ liệu payload giải mã (email, name, sub...)
  const userData = token.content; 
  
  // Lấy mảng các Roles từ Keycloak
  const userRoles = userData.realm_access?.roles || [];

  res.render('dashboard', {
    user: userData,
    roles: userRoles
  });
});

module.exports = router;