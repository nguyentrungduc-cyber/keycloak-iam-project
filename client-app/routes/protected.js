const express = require('express');
const router = express.Router();

// ── Middleware kiểm tra đã đăng nhập chưa ─────────────────────────
function requireLogin(req, res, next) {
  if (!req.session.user) {
    // Chưa login → redirect sang trang login
    return res.redirect('/login');
  }
  next(); // Đã login → cho qua
}

// ── Middleware kiểm tra role ───────────────────────────────────────
function requireRole(role) {
  return (req, res, next) => {
    const userRoles = req.session.user?.roles || [];
    if (!userRoles.includes(role)) {
      return res.status(403).send(`
        <html><body style="font-family:sans-serif;text-align:center;padding:60px">
          <h2>403 — Không có quyền truy cập</h2>
          <p>Bạn cần role <strong>${role}</strong> để vào trang này.</p>
          <a href="/dashboard">Quay lại Dashboard</a>
        </body></html>
      `);
    }
    next();
  };
}

// ── GET /dashboard ────────────────────────────────────────────────
// Trang chính sau khi đăng nhập — mọi user đều vào được
router.get('/dashboard', requireLogin, (req, res) => {
  const user = req.session.user;
  const rolesHtml = user.roles
    .map(r => `<span style="background:#EEEDFE;color:#534AB7;padding:2px 8px;border-radius:10px;font-size:12px;margin-right:4px">${r}</span>`)
    .join('');

  res.send(`
    <html><body style="font-family:sans-serif;max-width:700px;margin:40px auto;padding:0 20px">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px">
        <h2 style="margin:0">Dashboard — MyApp</h2>
        <a href="/logout" style="font-size:13px;color:#888">Đăng xuất</a>
      </div>

      <div style="background:#f5f5f5;border-radius:8px;padding:16px;margin-bottom:16px">
        <p style="margin:0 0 6px"><strong>Xin chào, ${user.name}</strong></p>
        <p style="margin:0 0 6px;font-size:13px;color:#666">Email: ${user.email}</p>
        <p style="margin:0 0 6px;font-size:13px;color:#666">User ID: ${user.id}</p>
        <div style="margin-top:8px">Roles: ${rolesHtml || 'Chưa có role'}</div>
      </div>

      <h3>Trang theo role</h3>
      <ul>
        <li><a href="/admin">Trang Admin</a> (cần role: admin)</li>
        <li><a href="/editor">Trang Editor</a> (cần role: editor)</li>
        <li><a href="/profile">Trang Profile</a> (ai cũng vào được)</li>
      </ul>
    </body></html>
  `);
});

// ── GET /admin ────────────────────────────────────────────────────
// Chỉ role "admin" mới vào được — RBAC demo
router.get('/admin', requireLogin, requireRole('admin'), (req, res) => {
  res.send(`
    <html><body style="font-family:sans-serif;max-width:700px;margin:40px auto;padding:0 20px">
      <h2>Trang quản trị Admin</h2>
      <p style="color:green">Bạn có quyền admin. RBAC hoạt động đúng!</p>
      <a href="/dashboard">Quay lại</a>
    </body></html>
  `);
});

// ── GET /editor ───────────────────────────────────────────────────
// Chỉ role "editor" mới vào được
router.get('/editor', requireLogin, requireRole('editor'), (req, res) => {
  res.send(`
    <html><body style="font-family:sans-serif;max-width:700px;margin:40px auto;padding:0 20px">
      <h2>Trang biên tập Editor</h2>
      <p style="color:green">Bạn có quyền editor. RBAC hoạt động đúng!</p>
      <a href="/dashboard">Quay lại</a>
    </body></html>
  `);
});

// ── GET /profile ──────────────────────────────────────────────────
// Ai đăng nhập cũng vào được
router.get('/profile', requireLogin, (req, res) => {
  const user = req.session.user;
  res.send(`
    <html><body style="font-family:sans-serif;max-width:700px;margin:40px auto;padding:0 20px">
      <h2>Profile của ${user.name}</h2>
      <p>Email: ${user.email}</p>
      <a href="/dashboard">Quay lại</a>
    </body></html>
  `);
});

module.exports = router;
