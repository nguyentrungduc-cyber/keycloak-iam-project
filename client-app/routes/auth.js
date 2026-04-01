const express = require('express');
const { generators } = require('openid-client');
const router = express.Router();

// ── GET /login ─────────────────────────────────────────────────────
// Tạo URL redirect sang trang đăng nhập của KeyCloak
router.get('/login', (req, res) => {
  const client = req.app.locals.oidcClient;

  // Tạo code_verifier và state để bảo mật (chống CSRF)
  const codeVerifier = generators.codeVerifier();
  const codeChallenge = generators.codeChallenge(codeVerifier);
  const state = generators.state();

  // Lưu vào session để dùng lại ở bước /callback
  req.session.codeVerifier = codeVerifier;
  req.session.state = state;

  // Tạo URL đến trang login của KeyCloak
  const authUrl = client.authorizationUrl({
    scope: 'openid profile email',
    code_challenge: codeChallenge,
    code_challenge_method: 'S256',
    state,
  });

  // Redirect trình duyệt sang KeyCloak
  res.redirect(authUrl);
});

// ── GET /callback ──────────────────────────────────────────────────
// KeyCloak gọi URL này sau khi người dùng đăng nhập xong
// Kèm theo ?code=XYZ — dùng code này để lấy token
router.get('/callback', async (req, res) => {
  const client = req.app.locals.oidcClient;

  try {
    // Đổi authorization code lấy tokens
    const params = client.callbackParams(req);
    const tokenSet = await client.callback(
      `http://localhost:${process.env.APP_PORT || 3000}/callback`,
      params,
      {
        code_verifier: req.session.codeVerifier,
        state: req.session.state,
      }
    );

    // Lấy thông tin người dùng từ ID Token
    const userinfo = tokenSet.claims();

    // Lưu vào session
    req.session.user = {
      id: userinfo.sub,
      name: userinfo.name,
      email: userinfo.email,
      roles: userinfo.realm_access?.roles || [],
    };
    req.session.accessToken = tokenSet.access_token;

    // Xóa code_verifier và state khỏi session (không cần nữa)
    delete req.session.codeVerifier;
    delete req.session.state;

    // Vào dashboard
    res.redirect('/dashboard');

  } catch (err) {
    console.error('Lỗi callback:', err.message);
    res.redirect('/login');
  }
});

// ── GET /logout ────────────────────────────────────────────────────
// Xóa session và redirect sang KeyCloak logout
router.get('/logout', (req, res) => {
  const client = req.app.locals.oidcClient;

  req.session.destroy(() => {
    // Redirect sang trang logout của KeyCloak
    const logoutUrl = client.endSessionUrl({
      post_logout_redirect_uri: `http://localhost:${process.env.APP_PORT || 3000}/`,
    });
    res.redirect(logoutUrl);
  });
});

// ── GET / ──────────────────────────────────────────────────────────
// Trang chủ — nếu đã login thì vào dashboard, chưa thì hiện nút login
router.get('/', (req, res) => {
  if (req.session.user) {
    return res.redirect('/dashboard');
  }
  res.send(`
    <html><body style="font-family:sans-serif;text-align:center;padding:60px">
      <h2>Chào mừng đến MyApp</h2>
      <a href="/login" style="padding:10px 24px;background:#1F3B6E;color:#fff;text-decoration:none;border-radius:6px">
        Đăng nhập
      </a>
    </body></html>
  `);
});

module.exports = router;
