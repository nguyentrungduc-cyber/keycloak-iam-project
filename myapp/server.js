require('dotenv').config({ path: '../.env' });
const express = require('express');
const session = require('express-session');
const { Issuer } = require('openid-client');

const app = express();
const PORT = process.env.APP_PORT || 3000;

// ── Session middleware ─────────────────────────────────────────────
app.use(session({
  secret: process.env.SESSION_SECRET || 'change-this-in-production',
  resave: false,
  saveUninitialized: false,
  cookie: { secure: false } // Đổi thành true nếu dùng HTTPS
}));

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// ── Khởi động: kết nối với KeyCloak và lấy config OIDC ────────────
async function startServer() {
  try {
    // KeyCloak tự publish file config tại URL này (discovery endpoint)
    const keycloakIssuer = await Issuer.discover(
      `${process.env.KC_SERVER_URL}/realms/${process.env.KC_REALM}`
    );

    // Tạo OIDC client với thông tin từ .env
    const client = new keycloakIssuer.Client({
      client_id: process.env.KC_CLIENT_ID,
      client_secret: process.env.KC_CLIENT_SECRET,
      redirect_uris: [`http://localhost:${PORT}/callback`],
      response_types: ['code'],
    });

    // Gắn client vào app để các route dùng được
    app.locals.oidcClient = client;

    // ── Routes ──────────────────────────────────────────────────────
    app.use('/', require('./routes/auth'));
    app.use('/', require('./routes/protected'));

    app.listen(PORT, () => {
      console.log(`Client App đang chạy tại: http://localhost:${PORT}`);
      console.log(`KeyCloak server: ${process.env.KC_SERVER_URL}`);
    });

  } catch (err) {
    console.error('Không thể kết nối đến KeyCloak:', err.message);
    console.error('Đảm bảo KeyCloak đang chạy tại', process.env.KC_SERVER_URL);
    process.exit(1);
  }
}

startServer();
