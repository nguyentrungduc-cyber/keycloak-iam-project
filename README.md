<div align="center">

# 🔐 Keycloak IAM Project

### Hệ thống Identity & Access Management (IAM) sử dụng Keycloak

![Keycloak](https://img.shields.io/badge/Keycloak-IAM-4D4D4D?style=for-the-badge&logo=keycloak&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Load%20Balancer-009639?style=for-the-badge&logo=nginx&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-v18+-339933?style=for-the-badge&logo=node.js&logoColor=white)
![License](https://img.shields.io/badge/License-Education-blue?style=for-the-badge)

*Đồ án môn học — Xây dựng hệ thống xác thực & phân quyền tập trung với Keycloak, chạy High Availability (HA) kết hợp Load Balancer (Nginx).*

</div>

---

## 📌 Giới thiệu

Dự án triển khai một hệ thống **IAM (Identity & Access Management)** hoàn chỉnh, lấy **Keycloak** làm nền tảng Identity Provider trung tâm. Hệ thống cho phép:

- Xác thực tập trung (SSO) cho nhiều ứng dụng client thông qua **OIDC**.
- Phân quyền chi tiết theo vai trò với **RBAC** (Realm roles & Client roles).
- Tăng cường bảo mật đăng nhập với **MFA** (TOTP — Google Authenticator, và WebAuthn/Passkey).
- Liên kết định danh liên tổ chức qua **SAML 2.0**.
- Đăng nhập nhanh bằng tài khoản **Google / GitHub** (Social Login).
- Vận hành ổn định, sẵn sàng cao (**HA**) nhờ cụm Keycloak phía sau **Nginx Load Balancer**.

---

## 👥 Thành viên nhóm & Phân công nhiệm vụ

| Thành viên | Giai đoạn | Thời gian | Nhiệm vụ chính |
| :--- | :---: | :---: | :--- |
| 🟦 **Đạt** | Giai đoạn 1 | 23/03 – 30/03 | Dựng hạ tầng Docker (Keycloak + DB + Nginx), tạo Realm, Users, Roles cơ bản |
| 🟩 **Danh** | Giai đoạn 2 | 31/03 – 09/04 | Xây dựng OIDC Client App (Node.js), luồng Registration, tùy biến Theme đăng nhập |
| 🟨 **Sử** | Giai đoạn 3 | 10/04 – 19/04 | Triển khai RBAC, cấu hình MFA (TOTP + WebAuthn) |
| 🟧 **Đạt** | Giai đoạn 4 | 20/04 – 28/04 | Tích hợp SAML 2.0, Social Login (Google/GitHub), tổng hợp tài liệu |

> 💡 Chi tiết công việc từng giai đoạn được ghi trong các file tài liệu ở thư mục [`docs/`](docs/).

---

## 🏗️ Kiến trúc hệ thống

```
                         ┌───────────────────────────┐
   Browser ───────────▶  │   Client App (Node.js)    │
                         └────────────┬──────────────┘
                                      │  OIDC / SAML
                                      ▼
                         ┌───────────────────────────┐
                         │   Nginx Load Balancer      │
                         └────────────┬──────────────┘
                                      │
                                      ▼
                         ┌───────────────────────────┐
                         │   Keycloak Cluster (HA)    │
                         └──────┬───────────────┬─────┘
                                │               │
                     Social Login│               │SAML 2.0
                                ▼               ▼
                      Google / GitHub     SAML Service Provider
```

**Thành phần chính:**

| Thành phần | Vai trò | Công nghệ |
| :--- | :--- | :--- |
| Client App | Ứng dụng minh họa, đăng nhập qua Keycloak | Node.js / Express |
| Load Balancer | Phân tải & định tuyến request đến cụm Keycloak | Nginx |
| Keycloak Cluster | Identity Provider trung tâm (Auth, RBAC, MFA, SAML) | Keycloak (HA mode) |
| Database | Lưu trữ dữ liệu Realm, Users, Sessions | PostgreSQL / MySQL |

---

## ⚙️ Yêu cầu môi trường

- 🐳 **Docker Desktop** (Windows/Mac) hoặc **Docker Engine** (Linux)
- 🟢 **Node.js** v18 trở lên
- 🔧 **Git**
- (Tùy chọn) **Git Bash** nếu chạy trên Windows để thực thi các script `.sh`

---

## 🚀 Cài đặt và chạy dự án

### 1️⃣ Clone repository

```bash
git clone https://github.com/nguyentrungduc-cyber/keycloak-iam-project.git
cd keycloak-iam-project
```

### 2️⃣ Tạo file cấu hình môi trường

```bash
cp .env.example .env
```

Sau đó mở file `.env` và điền các giá trị thực tế: mật khẩu DB, admin Keycloak, client secret của Google/GitHub OAuth (xem thêm tại [`myapp/keycloak-config/`](myapp/keycloak-config/)).

### 3️⃣ Khởi động Keycloak (+ DB, Nginx) bằng Docker Compose

```bash
docker-compose up -d
```

| Dịch vụ | Địa chỉ |
| :--- | :--- |
| Keycloak | http://localhost:8080 |
| Admin Console | http://localhost:8080/admin |
| Đăng nhập admin | theo `KEYCLOAK_ADMIN` / `KEYCLOAK_ADMIN_PASSWORD` trong `.env` |

### 4️⃣ Import Realm có sẵn

Vào **Admin Console → Create realm → Import file** và chọn `keycloak/realm-export.json`. File này đã chứa sẵn cấu hình Realm, Roles, và Clients mẫu.

### 5️⃣ Chạy Client App

```bash
cd myapp
npm install
npm start
```

Ứng dụng chạy tại: **http://localhost:3000**

### 6️⃣ (Tùy chọn) Tạo nhanh users mẫu

```bash
bash scripts/seed-users.sh
```

> ⚠️ Script này dùng Bash — trên Windows cần chạy bằng **Git Bash**.

---

## ✅ Tính năng đã triển khai

| Nhóm chức năng | Tính năng | Trạng thái |
| :--- | :--- | :---: |
| Hạ tầng | Keycloak server chạy bằng Docker, HA + Load Balancer | ✅ |
| Quản trị | Realm, Users, Roles cơ bản | ✅ |
| Xác thực | OIDC Client App kết nối Keycloak | ✅ |
| Xác thực | User registration + email verification | ✅ |
| Bảo mật | Password policy | ✅ |
| Giao diện | Custom login theme | ✅ |
| Phân quyền | RBAC (Realm roles + Client roles) | ✅ |
| MFA | TOTP (Google Authenticator) | ✅ |
| MFA | WebAuthn / Passkey | ✅ |
| Liên kết định danh | SAML 2.0 Identity Provider | ✅ |
| Social Login | Đăng nhập bằng Google | ✅ |
| Social Login | Đăng nhập bằng GitHub | ✅ |

---

## 📚 Tài liệu chi tiết

| Tài liệu | Nội dung |
| :--- | :--- |
| 📖 [Hướng dẫn cài đặt](docs/setup.md) | Cài đặt môi trường và khởi chạy toàn bộ hệ thống từ đầu |
| 🛠️ [Hướng dẫn cấu hình Keycloak](docs/keycloak-configuration.md) | Tạo Realm, Client, cấu hình chi tiết trên Keycloak |
| 🔑 [Phân quyền RBAC](docs/rbac.md) | Cấu hình Realm roles / Client roles và gán quyền |
| 📲 [Xác thực MFA](docs/mfa.md) | Bật và cấu hình TOTP, WebAuthn |
| 🤝 [Tích hợp SAML 2.0](docs/saml.md) | Cấu hình Identity Provider Broker qua SAML |
| 🌐 [Social Login](docs/social-login.md) | Đăng nhập qua Google / GitHub |
| 📂 [Cấu trúc dự án](myapp/PROJECT_STRUCTURE.md) | Sơ đồ thư mục và chức năng từng thành phần trong `myapp/` |

---

<div align="center">

*Đồ án học phần — nhóm phát triển: Đạt · Danh · Sử*

</div>
