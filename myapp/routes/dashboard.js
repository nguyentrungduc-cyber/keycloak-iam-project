const express = require('express');
const { protect } = require('../middleware/auth');
const router = express.Router();

router.get('/', protect, (req, res) => {
  const user = req.session.user || {};
  const accessTokenPayload = req.session.accessTokenPayload || {};
  const roles = accessTokenPayload?.realm_access?.roles || req.session.roles || [];
  const tokenSet = req.session.tokenSet || {};

  const expiresAt = Number(tokenSet.expires_at || 0);
  const now = Math.floor(Date.now() / 1000);
  const remainingSeconds = Math.max(0, expiresAt - now);
  const remainingMinutes = Math.floor(remainingSeconds / 60);
  const remainingDisplay = `${remainingMinutes}:${String(remainingSeconds % 60).padStart(2, '0')}`;

  const payload = Object.keys(accessTokenPayload).length > 0
    ? accessTokenPayload
    : {
        sub: user.sub,
        name: user.name || user.preferred_username,
        email: user.email,
        realm_access: {
          roles
        },
        exp: user.exp,
        iss: user.iss
      };

  const rbacItems = [
    { label: 'Xem danh sách user', allow: roles.includes('admin') || roles.includes('editor') },
    { label: 'Tạo user mới', allow: roles.includes('admin') || roles.includes('editor') },
    { label: 'Xóa user', allow: roles.includes('admin') },
    { label: 'Xem báo cáo', allow: roles.includes('admin') || roles.includes('editor') },
    { label: 'Cài đặt hệ thống', allow: roles.includes('admin') },
    { label: 'Export database', allow: roles.includes('admin') }
  ];

  res.render('dashboard', {
    user,
    roles,
    payloadJson: JSON.stringify(payload, null, 2),
    remainingDisplay,
    expiresAt,
    rbacItems
  });
});

module.exports = router;
