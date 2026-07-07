# ⚙️ Keycloak Config — Tổng quan

![Realm](https://img.shields.io/badge/Realm-uit--keycloak--realm-4D4D4D?style=flat-square)

> Thư mục này chứa tài liệu & cấu hình liên quan đến Keycloak cho ứng dụng **MyApp**, được chia theo từng thành viên phụ trách trong đồ án IAM.

Hệ thống tập trung vào xây dựng **SSO (Single Sign-On)** — cho phép nhiều ứng dụng dùng chung một hệ thống đăng nhập, đăng ký và quản lý người dùng qua Keycloak.

---

## 👥 Thành viên nhóm & Phân công

### 🟩 Thành viên 2 — Keycloak Config & Client Setup

Cấu hình Realm, Client, Password Policy, Registration Flow, Required Actions.

**File chịu trách nhiệm:**
- [`README_Keycloak_Config.md`](README_Keycloak_Config.md) — hướng dẫn cấu hình chi tiết từng bước
- `../../keycloak/realm-export.json` — file export toàn bộ realm (quan trọng nhất)
- `screenshots/` — ảnh chụp các bước cấu hình (Realm, Client, Password Policy, Registration Flow...)

### 🟨 Thành viên 3 — Social Login / OAuth Broker

Cấu hình Identity Provider: **Google** và **GitHub**.

**File chịu trách nhiệm:**
- [`README_Social_Login.md`](README_Social_Login.md) — hướng dẫn tích hợp Social Login
- [`google-oauth-credentials.md`](google-oauth-credentials.md) — mẫu Client ID / Secret / Redirect URI của Google
- [`github-oauth-credentials.md`](github-oauth-credentials.md) — mẫu Client ID / Secret / Callback URL của GitHub
- `screenshots/` — ảnh chụp Google Cloud Console, GitHub Developer Settings, Keycloak Identity Providers

---

> ⚠️ **Lưu ý bảo mật:** Các file `*-oauth-credentials.md` chỉ chứa giá trị **mẫu/placeholder**. Client Secret thật phải được lưu trong file `.env` (không commit lên Git).
