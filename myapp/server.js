require('dotenv').config({ path: '../.env' });
const express = require('express');
const session = require('express-session');
const { memoryStore, initOidcClient } = require('./config/keycloak');
const expressLayouts = require('express-ejs-layouts');

const app = express();
const PORT = process.env.APP_PORT || 3000;

// ── Session middleware ─────────────────────────────────────────────
app.use(session({
  store: memoryStore,
  secret: process.env.SESSION_SECRET || 'change-this-in-production',
  resave: false,
  saveUninitialized: false,
  cookie: { secure: false } // Đổi thành true nếu dùng HTTPS
}));

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Đạt thêm
// THÊM 2 DÒNG NÀY ĐỂ RENDER UI:
app.set('view engine', 'ejs'); // Báo cho Node.js biết là dùng EJS
app.use(expressLayouts);
app.use(express.static('public')); // Mở thư mục 'public' để đọc file style.css

// ── Routes ──────────────────────────────────────────────────────────

async function startServer() {
  try {
    const oidc = await initOidcClient(PORT);
    app.locals.oidcClient = oidc.client;
    app.locals.oidcRedirectUri = oidc.redirectUri;
    app.locals.postLogoutRedirectUri = oidc.postLogoutRedirectUri;

    app.use('/', require('./routes/index'));
    app.use('/auth', require('./routes/auth'));
    app.use('/dashboard', require('./routes/dashboard'));

    app.listen(PORT, () => {
      console.log(`Client App đang chạy tại: http://localhost:${PORT}`);
      console.log(`KeyCloak server: ${process.env.KC_SERVER_URL}`);
    });
  } catch (err) {
    console.error('Không thể khởi tạo OIDC client:', err.message);
    process.exit(1);
  }
}

startServer();
