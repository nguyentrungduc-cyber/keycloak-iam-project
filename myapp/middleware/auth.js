const protect = (req, res, next) => {
  const tokenSet = req.session?.tokenSet;

  if (!tokenSet?.access_token) {
    return res.redirect('/auth/login');
  }

  const expiresAt = Number(tokenSet.expires_at || 0);
  const now = Math.floor(Date.now() / 1000);

  if (!expiresAt || expiresAt <= now) {
    return req.session.destroy(() => res.redirect('/auth/login'));
  }

  return next();
};

const hasRole = (role) => (req, res, next) => {
  const roles = req.session?.roles || [];
  if (roles.includes(role)) return next();
  return res.status(403).render('error', { message: 'Bạn không có quyền truy cập' });
};

module.exports = { protect, hasRole };
