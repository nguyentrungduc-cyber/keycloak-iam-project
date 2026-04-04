# Keycloak IAM Project

Hệ thống Identity & Access Management (IAM) sử dụng KeyCloak — đồ án môn học.

## Thành viên nhóm

| Thành viên | Giai đoạn | Nhiệm vụ |
|---|---|---|
| Người 1 | GĐ 1 (23/03–30/03) | Hạ tầng Docker, Realm, Users, Roles |
| Người 2 | GĐ 2 (31/03–09/04) | OIDC Client App, Registration, Theme |
| Người 3 | GĐ 3 (10/04–19/04) | RBAC, MFA (TOTP + WebAuthn) |
| Người 4 | GĐ 4 (20/04–28/04) | SAML 2.0, Social Login, Tài liệu tổng hợp |

## Kiến trúc hệ thống

```
Browser → Client App (Node.js) → KeyCloak (Docker)
                                       ↕
                              Google / GitHub (Social Login)
                                       ↕
                              SAML Service Provider
```

## Yêu cầu

- Docker Desktop (Windows/Mac) hoặc Docker Engine (Linux)
- Node.js v18 trở lên
- Git

## Cài đặt và chạy

### 1. Clone repo

```bash
git clone https://github.com/your-team/keycloak-iam-project.git
cd keycloak-iam-project
```

### 2. Tạo file .env

```bash
cp .env.example .env
# Mở .env và điền giá trị thật vào
```

### 3. Khởi động KeyCloak

```bash
docker-compose up -d
```

KeyCloak chạy tại: http://localhost:8080  
Admin console: http://localhost:8080/admin  
Username/Password: theo giá trị trong file `.env`

### 4. Import Realm

Vào Admin Console → Create realm → Import file `keycloak/realm-export.json`

### 5. Chạy Client App

```bash
cd client-app
npm install
npm start
```

Client App chạy tại: http://localhost:3000

### 6. Tạo users mẫu (tùy chọn)

```bash
bash scripts/seed-users.sh
```

## Tính năng đã triển khai

- [x] KeyCloak server chạy bằng Docker
- [x] Realm, Users, Roles cơ bản
- [x] OIDC Client App kết nối KeyCloak
- [x] User registration + email verification
- [x] Password policy
- [x] Custom login theme
- [x] RBAC (Realm roles + Client roles)
- [x] MFA — TOTP (Google Authenticator)
- [x] MFA — WebAuthn / Passkey
- [x] SAML 2.0 Identity Provider
- [x] Social Login — Google
- [x] Social Login — GitHub

## Tài liệu chi tiết

- [Hướng dẫn cài đặt](docs/setup.md)
- [Hướng dẫn cấu hình keycloak](docs/keycloak-configuration.md)
- [Phân quyền RBAC](docs/rbac.md)
- [Xác thực MFA](docs/mfa.md)
- [Tích hợp SAML 2.0](docs/saml.md)
- [Social Login](docs/social-login.md)
