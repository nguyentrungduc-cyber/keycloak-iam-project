# Tích hợp SAML 2.0

> Tài liệu này do Người 4 viết — cập nhật sau khi hoàn thành giai đoạn 4

## Khái niệm

- **IdP (Identity Provider)**: KeyCloak — nơi xác thực người dùng
- **SP (Service Provider)**: App bên ngoài muốn dùng KeyCloak để đăng nhập

## Cấu hình KeyCloak làm SAML IdP

### Lấy Metadata của IdP

URL metadata của KeyCloak:
```
http://localhost:8080/realms/myrealm/protocol/saml/descriptor
```

Tải file XML này về → cung cấp cho SP để cài đặt.

### Tạo SAML Client trong KeyCloak

1. Clients → Create client
2. Client type: **SAML**
3. Client ID: Entity ID của SP (lấy từ metadata của SP)
4. Valid redirect URIs: URL callback của SP
5. Save

*(Thêm ảnh chụp màn hình vào đây)*

## SP Demo

Nhóm dùng [samltool.com](https://samltool.com) hoặc dựng một SP demo đơn giản để test.

*(Thêm hướng dẫn SP demo vào đây)*
