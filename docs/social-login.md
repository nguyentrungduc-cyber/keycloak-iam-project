# 🌐 Social Login — Google & GitHub

![Stage](https://img.shields.io/badge/Giai%20đoạn-4-orange?style=flat-square) ![Owner](https://img.shields.io/badge/Phụ%20trách-Đạt-blue?style=flat-square) ![Status](https://img.shields.io/badge/Trạng%20thái-Hoàn%20thành-brightgreen?style=flat-square)

> Tài liệu hướng dẫn cấu hình đăng nhập bằng tài khoản mạng xã hội (Google, GitHub) thông qua tính năng **Identity Brokering** của Keycloak, hoàn thành trong Giai đoạn 4 (20/04 – 28/04).

---

## 🔵 Google

### Bước 1 — Tạo OAuth App trên Google Cloud Console

1. Truy cập **[Google Cloud Console](https://console.cloud.google.com)**.
2. Tạo project mới (hoặc chọn project có sẵn).
3. Vào **APIs & Services → Credentials → Create Credentials → OAuth client ID**.
4. **Application type**: chọn **Web application**.
5. **Authorized redirect URIs**, điền đúng endpoint broker của Keycloak:
   ```
   http://localhost:8080/realms/myrealm/broker/google/endpoint
   ```
6. Lưu lại **Client ID** và **Client Secret**, dán vào file `.env` (xem mẫu tại [`myapp/keycloak-config/google-oauth-credentials.md`](../myapp/keycloak-config/google-oauth-credentials.md)).

### Bước 2 — Cấu hình trong Keycloak

1. Vào **Realm `myrealm` → Identity Providers → Add provider → Google**.
2. Dán **Client ID** và **Client Secret** vừa lấy từ Google Console.
3. Nhấn **Save**.
4. Kiểm tra: trang đăng nhập của realm sẽ xuất hiện nút **"Sign in with Google"**.

> 🖼️ *(Bổ sung ảnh chụp màn hình cấu hình Identity Provider Google tại đây)*

---

## ⚫ GitHub

### Bước 1 — Tạo OAuth App trên GitHub

1. Vào **GitHub → Settings → Developer settings → OAuth Apps → New OAuth App**.
2. **Homepage URL**: `http://localhost:3000`
3. **Authorization callback URL**, điền đúng endpoint broker của Keycloak:
   ```
   http://localhost:8080/realms/myrealm/broker/github/endpoint
   ```
4. Lưu lại **Client ID** và **Client Secret** (xem mẫu tại [`myapp/keycloak-config/github-oauth-credentials.md`](../myapp/keycloak-config/github-oauth-credentials.md)).

### Bước 2 — Cấu hình trong Keycloak

1. Vào **Identity Providers → Add provider → GitHub**.
2. Điền **Client ID** và **Client Secret**.
3. Nhấn **Save**.
4. Kiểm tra: trang đăng nhập sẽ xuất hiện thêm nút **"Sign in with GitHub"**.

> 🖼️ *(Bổ sung ảnh chụp màn hình cấu hình Identity Provider GitHub tại đây)*

---

## ✅ Kiểm thử

| Kịch bản | Kết quả mong đợi |
| :--- | :--- |
| Nhấn "Sign in with Google" | Redirect sang trang đăng nhập Google, sau khi xác thực quay lại app đã login |
| Nhấn "Sign in with GitHub" | Redirect sang trang đăng nhập GitHub, sau khi xác thực quay lại app đã login |
| Tài khoản Google/GitHub trùng email với user đã tồn tại | Keycloak hỏi liên kết (link) tài khoản thay vì tạo trùng |

---

## 🔗 Tham khảo thêm

- [Tích hợp SAML 2.0](saml.md)
- [Hướng dẫn cấu hình Keycloak](keycloak-configuration.md)
