# Keycloak IAM Project

Hệ thống **Identity & Access Management (IAM)** sử dụng **Keycloak** cho đồ án môn học tại UIT.

Dự án tập trung vào việc xây dựng hệ thống xác thực tập trung (SSO), cho phép nhiều ứng dụng web sử dụng chung một hệ thống đăng nhập, đăng ký và quản lý người dùng.

## Thành viên nhóm & Phân công

### Thành viên 2 — Keycloak Config & Client Setup
- Cấu hình Realm, Client, Password Policy, Registration Flow, Required Actions.
- **File chịu trách nhiệm**:
  - `keycloak/realm-export.json` ← File export toàn bộ realm (quan trọng nhất)
  - `docs/keycloak-configuration.md` hoặc `keycloak/README_Keycloak_Config.md`
  - `keycloak/screenshots/` — chứa ảnh chụp các bước cấu hình (Realm, Client, Password Policy, Registration Flow...)

### Thành viên 3 — Social Login / OAuth Broker
- Cấu hình Identity Provider: **Google** và **GitHub**.
- **File chịu trách nhiệm**:
  - `docs/social-login.md` hoặc `keycloak/README_Social_Login.md`
  - `keycloak/google-oauth-credentials.md` — chứa Client ID, Client Secret, Redirect URI của Google
  - `keycloak/github-oauth-credentials.md` — chứa Client ID, Client Secret, Callback URL của GitHub
  - Ảnh chụp trong `keycloak/screenshots/` (Google Cloud Console, GitHub Developer Settings, Keycloak Identity Providers)


