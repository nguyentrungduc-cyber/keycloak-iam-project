# PROJECT_STRUCTURE.md
**Cấu trúc dự án MyApp – Giải thích chi tiết từng file/folder**

**Dự án:** MyApp (Node.js + Express + Keycloak Integration)  
**Giai đoạn:** 2 (Keycloak Custom Theme + Config)  
**Công nghệ:** Node.js, Express, EJS, keycloak-connect  

Dưới đây là bảng mô tả **từng file/folder** trong dự án:  
- **Thành viên chịu trách nhiệm**  
- **Mục đích**  
- **Công việc cụ thể**

## Bảng Tổng Quan Các File/Folder

| File / Folder                  | Thành viên       | Mục đích chính                              | Mô tả chi tiết |
|--------------------------------|------------------|---------------------------------------------|----------------|
| **.env.example**               | Thành viên 4     | Lưu biến môi trường mẫu                    | File mẫu để copy thành `.env`. Chứa tất cả thông tin Keycloak (URL, realm, client_id, secret, redirect_uri...). Không commit file `.env` thật. |
| **README.md**                  | Thành viên 4     | Hướng dẫn sử dụng dự án                    | Hướng dẫn cài đặt, chạy app, cấu trúc dự án và thông tin team. |
| **package.json**               | Thành viên 4     | Quản lý dependencies                       | Chứa script chạy app (`npm start`) và danh sách package (express, keycloak-connect, ejs, dotenv...). |
| **server.js**                  | Thành viên 4     | File khởi động server chính                | Khởi tạo Express, kết nối Keycloak, thiết lập session, routes và views. |
| **config/keycloak.js**         | Thành viên 4     | Cấu hình Keycloak instance                 | Đọc `.env` và tạo đối tượng Keycloak để dùng trong toàn app. |
| **middleware/auth.js**         | Thành viên 4     | Middleware bảo vệ route + RBAC             | Kiểm tra login, decode JWT, kiểm tra role (hasRole). |
| **routes/index.js**            | Thành viên 4     | Route công khai (Landing Page)             | Xử lý trang chủ `/` (Màn hình 0). |
| **routes/auth.js**             | Thành viên 4     | Xử lý Authentication flow                  | Login, callback từ Keycloak, logout. |
| **routes/dashboard.js**        | Thành viên 4     | Route Dashboard (bảo vệ)                   | Trang sau khi login thành công (Màn hình 3). |
| **views/layout.ejs**           | Thành viên 1 + 4 | Layout chung cho tất cả trang              | Header, body, CSS chung, dark mode. |
| **views/landing.ejs**          | Thành viên 1     | Màn hình 0 – MyApp Landing Page            | Trang chủ trước khi redirect sang Keycloak. Thành viên 1 sẽ thay nội dung đẹp hơn. |
| **views/dashboard.ejs**        | Thành viên 4     | Màn hình 3 – Dashboard                     | Hiển thị thông tin user, email, roles, JWT và nút logout. |
| **views/error.ejs**            | Thành viên 4     | Trang hiển thị lỗi                         | Trang lỗi khi có vấn đề (403, 500...). |
| **public/**                    | Thành viên 1 + 4 | Thư mục chứa tài nguyên tĩnh               | CSS, JS, logo, hình ảnh… (đồng bộ với Keycloak theme). |
| **public/css/style.css**       | Thành viên 1     | CSS chung + dark mode                      | Style cho Landing Page và Dashboard. |
| **public/js/main.js**          | Thành viên 1     | JavaScript client-side                     | Xử lý UI tương tác (nếu cần). |
| **public/assets/**             | Thành viên 1     | Chứa logo, hình ảnh                        | Logo MyApp, background, icon… (dùng chung với Keycloak theme). |

## Ghi chú quan trọng
- **Thành viên 1** tập trung vào giao diện (Landing Page + Keycloak Custom Theme).
- **Thành viên 4** chịu trách nhiệm chính phần backend integration + Dashboard.
- Các file liên quan đến giao diện (landing.ejs, style.css, assets) nên Thành viên 1 cập nhật sau khi hoàn thiện theme.
- File `.env` **không commit** lên GitHub (đã ignore).

**Cập nhật lần cuối:** 04/04/2026  
**Người tạo file này:** Thành viên 4 (Backend)

---

Bạn chỉ cần:
1. Tạo file `PROJECT_STRUCTURE.md` trong thư mục `myapp/`
2. Paste toàn bộ nội dung trên vào
3. Commit lên GitHub

```bash
cd myapp
git add PROJECT_STRUCTURE.md
git commit -m "docs: thêm file mô tả chi tiết cấu trúc dự án"
git push
