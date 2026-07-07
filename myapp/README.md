<div align="center">

# 🖥️ MyApp — Keycloak Client Demo

![Node.js](https://img.shields.io/badge/Node.js-Express-339933?style=flat-square&logo=node.js&logoColor=white)
![EJS](https://img.shields.io/badge/View-EJS-B4CA65?style=flat-square)
![Keycloak](https://img.shields.io/badge/Auth-Keycloak%20OIDC-4D4D4D?style=flat-square&logo=keycloak&logoColor=white)

*Ứng dụng Client mẫu minh họa việc tích hợp đăng nhập tập trung (SSO) qua Keycloak bằng giao thức OIDC.*

</div>

---

## 📖 Giới thiệu

`myapp` là một ứng dụng web viết bằng **Node.js + Express**, sử dụng thư viện `keycloak-connect` để xác thực người dùng thông qua Keycloak (OIDC). Ứng dụng minh họa toàn bộ luồng: đăng nhập → nhận JWT → phân quyền theo role → hiển thị thông tin người dùng → đăng xuất.

---

## ⚙️ Yêu cầu

- Node.js v18 trở lên
- Một Keycloak Realm & Client đã được cấu hình (xem [hướng dẫn cấu hình Keycloak](../docs/keycloak-configuration.md))

---

## 🚀 Cài đặt & chạy

### 1. Cài dependencies

```bash
cd myapp
npm install
```

### 2. Cấu hình biến môi trường

```bash
cp .env.example .env
```

Điền các giá trị Keycloak thực tế vào `.env` (URL realm, client ID, client secret, redirect URI...).

### 3. Chạy ứng dụng

```bash
npm start
```

Hoặc chạy chế độ dev (tự reload khi sửa code):

```bash
npm run dev
```

Ứng dụng chạy tại: **http://localhost:3000**

> 💡 Nếu chạy cả hệ thống bằng `docker-compose up -d` ở thư mục gốc, `myapp` đã được build và chạy sẵn trong container — **không cần** chạy `npm start` thủ công.

---

## 📂 Cấu trúc thư mục

Xem chi tiết đầy đủ tại **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)**. Tóm tắt nhanh:

| Thư mục / File | Vai trò |
| :--- | :--- |
| `server.js` | Khởi động Express server, kết nối Keycloak, thiết lập session |
| `config/keycloak.js` | Cấu hình đối tượng Keycloak từ biến môi trường |
| `middleware/auth.js` | Middleware kiểm tra đăng nhập & phân quyền (RBAC) |
| `routes/` | Định nghĩa các route: trang chủ, auth flow, dashboard |
| `views/` | Giao diện EJS: landing page, dashboard, trang lỗi |
| `public/` | Tài nguyên tĩnh: CSS, JS, hình ảnh |
| `keycloak-config/` | Tài liệu & mẫu cấu hình liên quan đến Keycloak (Social Login, OAuth credentials...) |

---

## 🔗 Tài liệu liên quan

- [Hướng dẫn cài đặt toàn hệ thống](../docs/setup.md)
- [Hướng dẫn cấu hình Keycloak](../docs/keycloak-configuration.md)
- [Phân quyền RBAC](../docs/rbac.md)
- [Cấu hình Social Login](keycloak-config/README_Social_Login.md)
