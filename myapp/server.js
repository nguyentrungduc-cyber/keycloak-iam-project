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

// THÊM 2 DÒNG NÀY ĐỂ RENDER UI:
app.set('view engine', 'ejs'); // Báo cho Node.js biết là dùng EJS

const expressLayouts = require('express-ejs-layouts');
app.use(expressLayouts);

app.use(express.static('public')); // Mở thư mục 'public' để đọc file style.css

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
    // 1. Dùng dấu // để "phong ấn" (tắt) 2 cái dòng gây lỗi này đi:
    // app.use('/', require('./routes/auth'));
    // app.use('/', require('./routes/protected'));

    // 2. Thêm 3 dòng này để bật thẳng cái Landing Page của Đạt lên:
    app.get('/', (req, res) => {
      res.render('landing'); 
    });

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
