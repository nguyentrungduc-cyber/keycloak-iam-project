const protect = (req, res, next) => {
  if (req.session?.tokenSet?.access_token) {
    return next();
  }
  return res.redirect('/auth/login');
};

const hasRole = (role) => (req, res, next) => {
  const roles = req.session?.roles || [];
  if (roles.includes(role)) return next();
  return res.status(403).render('error', { message: 'Bạn không có quyền truy cập' });
};

module.exports = { protect, hasRole };
