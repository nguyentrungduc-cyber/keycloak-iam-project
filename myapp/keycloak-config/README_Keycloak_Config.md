# Hướng dẫn cấu hình Keycloak - Thành viên 2

## Thông tin chung
- **Realm**: `myapp-realm`
- **Client ID**: `myapp-frontend`
- **Thời gian**: 03/04/2026 – 10/04/2026

## Các bước đã thực hiện

### 1. Tạo Realm
- Tạo realm mới tên: `myapp-realm`

### 2. Tạo Client OIDC
- Client Type: OpenID Connect
- Client ID: `myapp-frontend`
- Client Authentication: **Off** (Public Client)
- Valid Redirect URIs: 
  - `http://localhost:3000/*`
  - `http://localhost:8080/*`
- Web Origins: `+`
- Enabled: On
- Authorization Code Flow + PKCE: Enabled

### 3. Password Policy
- Minimum length: 8
- Require uppercase, lowercase, digit, special character
- Not username, Not email
- Brute force protection enabled

### 4. User Registration & Email Verification
- Registration allowed: On
- Required Actions: Verify Email, Update Profile
- Email verification: Enabled

## File export
- realm-export.json đã được export sau khi cấu hình xong.

**Ngày hoàn thành:** 10/04/2026
