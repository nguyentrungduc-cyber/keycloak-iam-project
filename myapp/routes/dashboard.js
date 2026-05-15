const express = require('express');
const { protect } = require('../middleware/auth');
const router = express.Router();

router.get('/', protect, (req, res) => {
  const user = req.session.user || {};
  const accessTokenPayload = req.session.accessTokenPayload || {};
  const roles = req.session.roles || [];
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

  const isAdmin = roles.includes('Super Admin') || roles.includes('admin');

  const rbacItems = [
    { label: 'Xem danh sách user', allow: isAdmin || roles.includes('editor') },
    { label: 'Tạo user mới', allow: isAdmin || roles.includes('editor') },
    { label: 'Xóa user', allow: isAdmin },
    { label: 'Xem báo cáo', allow: isAdmin || roles.includes('editor') },
    { label: 'Cài đặt hệ thống', allow: isAdmin },
    { label: 'Export database', allow: isAdmin }
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

router.get('/profile', protect, async (req, res) => {
  try {
    const tokenSet = req.session.tokenSet;

    const response = await fetch(
      `${process.env.KC_SERVER_URL}/realms/${process.env.KC_REALM}/protocol/openid-connect/userinfo`,
      {
        headers: {
          Authorization: `Bearer ${tokenSet.access_token}`
        }
      }
    );

    // Nếu Keycloak trả lỗi → forward luôn
    if (!response.ok) {
      return res.status(response.status).send(await response.text());
    }

    const data = await response.json();

    // Lấy node xử lý request từ Nginx header
    const servedBy = response.headers.get('x-served-by');

    res.json({
      ...data,
      served_by: servedBy || 'unknown'
    });

  } catch (err) {
    console.error('Userinfo error:', err.message);
    res.status(500).send('Keycloak request failed');
  }
});

module.exports = router;