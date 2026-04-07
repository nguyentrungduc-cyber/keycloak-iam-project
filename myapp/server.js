require('dotenv').config({ path: '../.env' });
const express = require('express');
const session = require('express-session');
const expressLayouts = require('express-ejs-layouts');
const { Issuer, generators } = require('openid-client');

const app = express();
const PORT = process.env.APP_PORT || 3000;

// ── Session ────────────────────────────────────────────────────────
app.use(session({
  secret: process.env.SESSION_SECRET || 'change-this-in-production',
  resave: false,
  saveUninitialized: false,
  cookie: { secure: false },
}));

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// ── View engine ────────────────────────────────────────────────────
app.set('view engine', 'ejs');
app.use(expressLayouts);
app.set('layout', 'layout');
app.use(express.static('public'));

// ── Truyền user xuống tất cả views ────────────────────────────────
app.use((req, res, next) => {
  res.locals.user = req.session.user || null;
  next();
});

// ── Middleware bảo vệ route cần login ─────────────────────────────
function requireLogin(req, res, next) {
  if (!req.session.user) return res.redirect('/auth/login');
  next();
}

// ── Khởi động ─────────────────────────────────────────────────────
async function startServer() {
  try {
    const keycloakIssuer = await Issuer.discover(
      `${process.env.KC_SERVER_URL}/realms/${process.env.KC_REALM}`
    );

    const client = new keycloakIssuer.Client({
      client_id:      process.env.KC_CLIENT_ID,
      client_secret:  process.env.KC_CLIENT_SECRET,
      redirect_uris:  [`http://localhost:${PORT}/auth/callback`],
      response_types: ['code'],
    });

    app.locals.oidcClient = client;

    // ── GET / → Landing Page ────────────────────────────────────────
    app.get('/', (req, res) => {
      if (req.session.user) return res.redirect('/dashboard');
      res.render('landing');
    });

    // ── GET /auth/login → Redirect sang Keycloak login ──────────────
    app.get('/auth/login', (req, res) => {
      const codeVerifier  = generators.codeVerifier();
      const codeChallenge = generators.codeChallenge(codeVerifier);
      const state         = generators.state();

      req.session.codeVerifier = codeVerifier;
      req.session.state        = state;

      const authUrl = client.authorizationUrl({
        scope: 'openid profile email',
        code_challenge:        codeChallenge,
        code_challenge_method: 'S256',
        state,
      });

      res.redirect(authUrl);
    });

    // ── GET /auth/callback → Nhận token từ Keycloak ─────────────────
    app.get('/auth/callback', async (req, res) => {
      try {
        const params = client.callbackParams(req);

        const tokenSet = await client.callback(
          `http://localhost:${PORT}/auth/callback`,
          params,
          {
            code_verifier: req.session.codeVerifier,
            state:         req.session.state,
          }
        );

        const userInfo = await client.userinfo(tokenSet.access_token);

        req.session.user     = userInfo;
        req.session.tokenSet = tokenSet;
        req.session.roles    = tokenSet.claims().realm_access?.roles || [];

        delete req.session.codeVerifier;
        delete req.session.state;

        res.redirect('/dashboard');
      } catch (err) {
        console.error('Callback lỗi:', err.message);
        res.redirect('/?error=auth_failed');
      }
    });

    // ── GET /auth/logout → Đăng xuất khỏi Keycloak SSO ─────────────
    app.get('/auth/logout', (req, res) => {
      const idToken = req.session.tokenSet?.id_token;
      req.session.destroy(() => {
        const logoutUrl = client.endSessionUrl({
          id_token_hint:            idToken,
          post_logout_redirect_uri: `http://localhost:${PORT}/`,
        });
        res.redirect(logoutUrl);
      });
    });

    // ── GET /dashboard → Dashboard (cần login) ──────────────────────
    app.get('/dashboard', requireLogin, (req, res) => {
      res.render('dashboard', {
        user:     req.session.user,
        roles:    req.session.roles,
        tokenSet: req.session.tokenSet,
      });
    });

    // ── 404 ─────────────────────────────────────────────────────────
    app.use((req, res) => {
      res.status(404).render('error', { message: 'Trang không tồn tại' });
    });

    app.listen(PORT, () => {
      console.log(`✅ MyApp: http://localhost:${PORT}`);
      console.log(`🔑 Keycloak: ${process.env.KC_SERVER_URL}`);
      console.log(`\n📋 Routes:`);
      console.log(`   /                → Landing Page`);
      console.log(`   /auth/login      → Redirect sang Keycloak`);
      console.log(`   /auth/callback   → Nhận token`);
      console.log(`   /auth/logout     → Đăng xuất`);
      console.log(`   /dashboard       → Dashboard (cần login)`);
    });

  } catch (err) {
    console.error('❌ Không kết nối được Keycloak:', err.message);
    process.exit(1);
  }
}

startServer();
