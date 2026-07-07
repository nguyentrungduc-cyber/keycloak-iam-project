# 📂 Cấu trúc dự án MyApp

![Stage](https://img.shields.io/badge/Giai%20đoạn-2-lightgrey?style=flat-square) ![Tech](https://img.shields.io/badge/Stack-Node.js%20%2B%20Express%20%2B%20EJS-339933?style=flat-square)

**Dự án:** MyApp (Node.js + Express + Keycloak Integration)
**Giai đoạn:** 2 — Keycloak Custom Theme & Config
**Công nghệ:** Node.js, Express, EJS, `keycloak-connect`

Bảng dưới đây mô tả chi tiết từng file/folder: người phụ trách, mục đích, và công việc cụ thể.

## 📋 Bảng tổng quan File / Folder

| File / Folder | Phụ trách | Mục đích chính | Mô tả chi tiết |
| :--- | :--- | :--- | :--- |
| `.env.example` | Thành viên 4 | Biến môi trường mẫu | File mẫu để copy thành `.env`. Chứa thông tin Keycloak (URL, realm, client_id, secret, redirect_uri...). File `.env` thật **không được commit**. |
| `README.md` | Thành viên 4 | Hướng dẫn sử dụng dự án | Hướng dẫn cài đặt, chạy app, cấu trúc dự án. |
| `package.json` | Thành viên 4 | Quản lý dependencies | Script chạy app (`npm start`, `npm run dev`) và danh sách package (express, keycloak-connect, ejs, dotenv...). |
| `server.js` | Thành viên 4 | Khởi động server chính | Khởi tạo Express, kết nối Keycloak, thiết lập session, routes và views. |
| `config/keycloak.js` | Thành viên 4 | Cấu hình Keycloak instance | Đọc `.env` và tạo đối tượng Keycloak dùng chung toàn app. |
| `middleware/auth.js` | Thành viên 4 | Middleware bảo vệ route + RBAC | Kiểm tra đăng nhập, decode JWT, kiểm tra role (`hasRole`). |
| `routes/index.js` | Thành viên 4 | Route công khai (Landing Page) | Xử lý trang chủ `/`. |
| `routes/auth.js` | Thành viên 4 | Luồng xác thực (Authentication flow) | Login, callback từ Keycloak, logout. |
| `routes/dashboard.js` | Thành viên 4 | Route Dashboard (được bảo vệ) | Trang hiển thị sau khi đăng nhập thành công. |
| `views/layout.ejs` | Thành viên 1 + 4 | Layout dùng chung | Header, body, CSS chung, dark mode. |
| `views/landing.ejs` | Thành viên 1 | Landing Page | Trang chủ trước khi redirect sang Keycloak. |
| `views/dashboard.ejs` | Thành viên 4 | Dashboard | Hiển thị thông tin user, email, roles, JWT và nút logout. |
| `views/error.ejs` | Thành viên 4 | Trang lỗi | Hiển thị khi có lỗi (403, 500...). |
| `public/` | Thành viên 1 + 4 | Tài nguyên tĩnh | CSS, JS, logo, hình ảnh (đồng bộ với Keycloak theme). |
| `public/css/style.css` | Thành viên 1 | CSS chung + dark mode | Style cho Landing Page và Dashboard. |
| `public/js/main.js` | Thành viên 1 | JavaScript phía client | Xử lý tương tác UI. |
| `public/assets/` | Thành viên 1 | Hình ảnh, logo | Logo MyApp, background, icon (dùng chung với Keycloak theme). |
| `keycloak-config/` | Thành viên 4 | Tài liệu cấu hình Keycloak | Hướng dẫn Social Login, mẫu OAuth credentials cho Google/GitHub. |

## 📝 Ghi chú quan trọng

- **Thành viên 1** phụ trách giao diện (Landing Page + Keycloak Custom Theme).
- **Thành viên 4** phụ trách chính phần backend integration + Dashboard.
- Các file giao diện (`landing.ejs`, `style.css`, `assets/`) do Thành viên 1 cập nhật khi hoàn thiện theme.
- File `.env` **không được commit** lên GitHub (đã thêm vào `.gitignore`).

---

**Cập nhật lần cuối:** 04/04/2026
**Người phụ trách tài liệu:** Thành viên 4 (Backend)
