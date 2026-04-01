# Xác thực MFA

> Tài liệu này do Người 3 viết — cập nhật sau khi hoàn thành giai đoạn 3

## TOTP (Google Authenticator)

### Cách bật trong KeyCloak
1. Vào Realm Settings → Authentication → Required Actions
2. Bật "Configure OTP" → Set as Default Action

### Cách người dùng enroll
1. Đăng nhập lần đầu → KC yêu cầu cài TOTP
2. Mở Google Authenticator → Quét QR code
3. Nhập mã 6 số để xác nhận

*(Thêm ảnh chụp màn hình vào đây)*

## WebAuthn / Passkey

### Cách bật trong KeyCloak
1. Vào Authentication → Flows → Browser
2. Thêm WebAuthn Authenticator vào flow

*(Thêm ảnh chụp màn hình vào đây)*
