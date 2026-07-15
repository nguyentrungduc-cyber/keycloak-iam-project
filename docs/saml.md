# 🤝 Tích hợp SAML 2.0

![Stage](https://img.shields.io/badge/Giai%20đoạn-4-orange?style=flat-square) ![Owner](https://img.shields.io/badge/Phụ%20trách-Đạt-blue?style=flat-square) ![Status](https://img.shields.io/badge/Trạng%20thái-Hoàn%20thành-brightgreen?style=flat-square)

> Tài liệu mô tả cách cấu hình Keycloak đóng vai trò **SAML 2.0 Identity Provider (IdP)**, hoàn thành trong Giai đoạn 4 (20/04 – 28/04).

---

## 📖 Khái niệm cơ bản

| Thuật ngữ | Ý nghĩa |
| :--- | :--- |
| **IdP** (Identity Provider) | Keycloak — nơi xác thực danh tính người dùng |
| **SP** (Service Provider) | Ứng dụng bên ngoài muốn dùng Keycloak để đăng nhập (SSO) |
| **Metadata** | File XML mô tả cấu hình (endpoint, certificate) để IdP và SP "bắt tay" với nhau |
| **Assertion** | "Chứng thực" mà IdP gửi cho SP sau khi xác thực thành công, chứa thông tin người dùng |

Luồng hoạt động cơ bản: người dùng truy cập SP → SP redirect sang Keycloak (IdP) → người dùng đăng nhập tại Keycloak → Keycloak gửi SAML Assertion về SP → SP xác thực chữ ký và cho phép truy cập.

---

## ⚙️ Cấu hình Keycloak làm SAML IdP

### Bước 1 — Lấy Metadata của IdP

URL metadata công khai của Keycloak cho một realm cụ thể:

```
http://localhost:8080/realms/uit-keycloak-realm/protocol/saml/descriptor
```

Tải file XML này về và cung cấp cho phía SP để họ cấu hình tin cậy (trust) với Keycloak.

### Bước 2 — Tạo SAML Client trong Keycloak

1. Vào **Clients → Create client**.
2. Chọn **Client type: SAML**.
3. **Client ID**: điền đúng **Entity ID** của SP (lấy từ metadata do SP cung cấp).
4. **Valid redirect URIs / Assertion Consumer Service (ACS) URL**: URL callback mà SP dùng để nhận assertion.
5. Nhấn **Save**.
6. (Tùy chọn) Vào tab **Advanced** để bật ký số (Sign assertions), mã hóa assertion nếu SP yêu cầu.

> 🖼️ *(Bổ sung ảnh chụp màn hình cấu hình SAML Client tại đây)*

---

## 🧪 SP Demo để kiểm thử

Vì dựng một SP thật đòi hỏi hạ tầng riêng, nhóm sử dụng công cụ online **[samltool.com](https://samltool.com)** để giả lập một SP đơn giản, dùng để:

- Sinh cặp Entity ID / ACS URL giả lập.
- Decode và kiểm tra nội dung SAML Response mà Keycloak trả về.
- Xác minh chữ ký số trong Assertion có hợp lệ hay không.

Quy trình test:

1. Lấy Entity ID/ACS URL mẫu từ samltool.com.
2. Tạo SAML Client trong Keycloak với thông tin đó.
3. Truy cập Login URL của Client trong Keycloak → đăng nhập.
4. Dán SAML Response nhận được vào samltool.com để decode và kiểm tra assertion (username, email, roles...).

> 🖼️ *(Bổ sung ảnh chụp màn hình kết quả decode SAML Response tại đây)*

---

## 🔗 Tham khảo thêm

- [Social Login](social-login.md)
- [Hướng dẫn cấu hình Keycloak](keycloak-configuration.md)
