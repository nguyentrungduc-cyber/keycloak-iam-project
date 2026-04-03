const express = require('express');
const { keycloak } = require('../config/keycloak');
const router = express.Router();

router.get('/login', keycloak.protect(), (req, res) => res.redirect('/dashboard'));
router.get('/callback', keycloak.checkSso(), (req, res) => res.redirect('/dashboard'));
router.get('/logout', (req, res) => {
  keycloak.logoutUrl = `${process.env.KEYCLOAK_URL}/realms/${process.env.KEYCLOAK_REALM}/protocol/openid-connect/logout`;
  keycloak.logout(req, res);
});

module.exports = router;
