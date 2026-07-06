# 🔑 Phân quyền RBAC (Role-Based Access Control)

![Stage](https://img.shields.io/badge/Giai%20đoạn-3-yellow?style=flat-square) ![Owner](https://img.shields.io/badge/Phụ%20trách-Sử-orange?style=flat-square) ![Status](https://img.shields.io/badge/Trạng%20thái-Hoàn%20thành-brightgreen?style=flat-square)

> Tài liệu mô tả cách hệ thống phân quyền người dùng bằng Keycloak, hoàn thành trong Giai đoạn 3 (10/04 – 19/04).

---

## 📖 Khái niệm

Keycloak hỗ trợ 2 cấp độ role:

- **Realm Roles**: áp dụng ở phạm vi toàn Realm, dùng cho những quyền chung (VD: `admin`, `user`).
- **Client Roles**: gắn với một Client cụ thể (VD: `myapp`), dùng khi cần phân quyền chi tiết trong phạm vi một ứng dụng.

Client app đọc claim `roles` trong JWT access token để quyết định cho phép hay chặn truy cập từng route.

---

## 🧩 Danh sách Roles

### Realm Roles

| Role | Mô tả | Gán cho |
| :--- | :--- | :--- |
| `admin` | Toàn quyền quản trị hệ thống | `admin_user` |
| `editor` | Quyền chỉnh sửa nội dung | `editor_user` |
| `user` | Quyền cơ bản, chỉ xem | Tất cả user thường |

### Client Roles (`myapp`)

| Role | Mô tả |
| :--- | :--- |
| `myapp-admin` | Toàn quyền quản trị trong phạm vi app `myapp` |
| `myapp-viewer` | Chỉ được xem, không có quyền chỉnh sửa |

---

## ⚙️ Cấu hình trong Keycloak

1. Vào **Admin Console → Realm roles → Create role** để tạo các Realm Role ở trên.
2. Vào **Clients → myapp → Roles → Create role** để tạo Client Role.
3. Vào **Users → chọn user → Role mapping → Assign role** để gán role tương ứng cho từng user.
4. Kiểm tra token: **Clients → myapp → Client scopes → Evaluate** để xem trước nội dung claim `roles` sẽ xuất hiện trong access token.

> 🖼️ *(Bổ sung ảnh chụp màn hình Admin Console khi gán role tại đây)*

---

## 🧪 Test Cases

| # | User | Route | Kết quả mong đợi |
| :---: | :--- | :--- | :--- |
| 1 | `admin_user` | `/admin` | ✅ 200 OK |
| 2 | `editor_user` | `/admin` | ⛔ 403 Forbidden |
| 3 | `normal_user` | `/editor` | ⛔ 403 Forbidden |
| 4 | `editor_user` | `/editor` | ✅ 200 OK |
| 5 | Chưa đăng nhập | `/dashboard` | 🔁 Redirect về `/login` |

---

## 🔗 Tham khảo thêm

- [Xác thực MFA](mfa.md)
- [Hướng dẫn cấu hình Keycloak](keycloak-configuration.md)
