# Hướng dẫn tích hợp Social Login (Google + GitHub) - Thành viên 3

## Thông tin chung
- Realm: `myapp-realm`
- Thời gian: 03/04/2026 – 10/04/2026

## 1. Google OAuth

**Đã tạo tại Google Cloud Console:**
- Application type: Web application
- Client ID: `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com`
- Client Secret: `GOCSPX-xxxxxxxxxxxxxxxxxxxxxxxx`

**Authorized Redirect URIs:**
- `http://localhost:8080/realms/myapp-realm/broker/google/endpoint`

## 2. GitHub OAuth

**Đã tạo tại GitHub:**
- Application name: MyApp Login
- Client ID: `Iv1.xxxxxxxxxxxxxxxxxxxxxxxx`
- Client Secret: `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

**Authorization callback URL:**
- `http://localhost:8080/realms/myapp-realm/broker/github/endpoint`

## 3. Cấu hình trong Keycloak

### Google Identity Provider
- Alias: `google`
- Client ID & Secret: Đã điền
- Mappers: email, firstName, lastName, username
- Sync Mode: Force

### GitHub Identity Provider
- Alias: `github`
- Client ID & Secret: Đã điền
- Scope: `user:email`
- Mappers: email, name

## Kết quả test
- Login bằng Google: OK
- Login bằng GitHub: OK
- Account linking khi email trùng: Đã test

**Ngày hoàn thành:** 10/04/2026
