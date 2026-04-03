const { keycloak } = require('../config/keycloak');

const protect = keycloak.protect();

const hasRole = (role) => (req, res, next) => {
  if (req.kauth.grant.access_token.hasRole(role)) return next();
  return res.status(403).render('error', { message: 'Bạn không có quyền truy cập' });
};

module.exports = { protect, hasRole };
