# 📲 Xác thực đa yếu tố (MFA)

![Stage](https://img.shields.io/badge/Giai%20đoạn-3-yellow?style=flat-square) ![Owner](https://img.shields.io/badge/Phụ%20trách-Sử-orange?style=flat-square) ![Status](https://img.shields.io/badge/Trạng%20thái-Hoàn%20thành-brightgreen?style=flat-square)

> Tài liệu mô tả cách bật và cấu hình MFA (Multi-Factor Authentication) trên Keycloak, hoàn thành trong Giai đoạn 3 (10/04 – 19/04). Hệ thống hỗ trợ 2 phương thức: **TOTP** (mã OTP theo thời gian) và **WebAuthn/Passkey** (khóa bảo mật vật lý hoặc sinh trắc học).

---

## 1️⃣ TOTP (Time-based One-Time Password) — Google Authenticator

TOTP sinh mã 6 chữ số thay đổi mỗi 30 giây, dựa trên secret key được chia sẻ giữa Keycloak và ứng dụng Authenticator trên điện thoại.

### Cách bật trong Keycloak

1. Vào **Realm Settings → Authentication → Required Actions**.
2. Bật **"Configure OTP"** và tick **Set as Default Action** để bắt buộc mọi user thiết lập OTP khi đăng nhập lần đầu.
3. (Tùy chọn) Vào **Authentication → Policies → OTP Policy** để tùy chỉnh thuật toán (SHA1/SHA256), số chữ số, và khoảng thời gian hiệu lực.

### Trải nghiệm người dùng khi enroll

1. Người dùng đăng nhập lần đầu → Keycloak tự động yêu cầu cấu hình OTP.
2. Mở ứng dụng **Google Authenticator** (hoặc Authy, Microsoft Authenticator) → quét QR code hiển thị trên màn hình.
3. Nhập mã 6 số hiện tại từ app để xác nhận liên kết thành công.
4. Từ lần đăng nhập sau, hệ thống sẽ yêu cầu nhập thêm mã OTP sau bước nhập mật khẩu.

> 🖼️ *(Bổ sung ảnh chụp màn hình QR code enroll OTP tại đây)*

---

## 2️⃣ WebAuthn / Passkey

WebAuthn cho phép đăng nhập bằng khóa bảo mật vật lý (YubiKey), vân tay, Face ID, hoặc Windows Hello — không cần nhập mật khẩu.

### Cách bật trong Keycloak

1. Vào **Authentication → Flows → Browser** (hoặc tạo bản sao flow riêng để tùy biến).
2. Thêm bước **WebAuthn Authenticator** vào flow, đặt là **Alternative** hoặc **Required** tùy chính sách bảo mật.
3. Vào **Authentication → Policies → WebAuthn Policy** để cấu hình:
   - **Relying Party ID**: domain của ứng dụng.
   - **Signature Algorithms**: mặc định ES256.
   - **Attestation Conveyance Preference**: `none` cho môi trường demo/dev.

### Trải nghiệm người dùng khi enroll

1. Trong tài khoản, người dùng chọn **Set up Security Key**.
2. Trình duyệt yêu cầu xác thực bằng vân tay/khóa bảo mật.
3. Từ lần sau, có thể đăng nhập chỉ bằng thao tác sinh trắc học, không cần gõ mật khẩu.

> 🖼️ *(Bổ sung ảnh chụp màn hình đăng ký WebAuthn tại đây)*

---

## ✅ Checklist kiểm thử

| Kịch bản | Kết quả mong đợi |
| :--- | :--- |
| Đăng nhập lần đầu chưa có OTP | Bị bắt buộc cấu hình TOTP trước khi vào hệ thống |
| Nhập sai mã OTP | Từ chối đăng nhập, hiển thị lỗi |
| Đăng nhập bằng WebAuthn đã enroll | Đăng nhập thành công không cần mật khẩu |
| Thiết bị WebAuthn bị mất | Có thể dùng phương thức MFA dự phòng (TOTP) để khôi phục |

---

## 🔗 Tham khảo thêm

- [Phân quyền RBAC](rbac.md)
- [Hướng dẫn cấu hình Keycloak](keycloak-configuration.md)
