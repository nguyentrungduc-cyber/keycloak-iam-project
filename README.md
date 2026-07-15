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
| Database | Lưu trữ dữ liệu Realm, Users, Sessions | PostgreSQL (local/dev qua Docker) — MySQL/Aiven chỉ dùng khi deploy lên cloud |

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

### 3️⃣ Khởi động toàn bộ hệ thống bằng Docker Compose

```bash
docker-compose up -d
```

Lệnh này khởi động **toàn bộ** hệ thống cùng lúc — không cần chạy thêm bước nào khác:

| Dịch vụ | Container | Địa chỉ |
| :--- | :--- | :--- |
| PostgreSQL | `keycloak-db` | nội bộ, không expose port ra ngoài |
| Nginx (Load Balancer) | `keycloak-lb` | http://localhost:8080 |
| Keycloak Node 1 & 2 | `keycloak-node-1`, `keycloak-node-2` | truy cập qua Nginx ở port 8080 |
| MyApp (Client App) | `myapp-server` | http://localhost:3000 |
| SAML Test SP (demo) | `saml-test-sp` | http://localhost:8081 |

- **Admin Console:** http://localhost:8080/admin — đăng nhập bằng `KC_ADMIN_USER` / `KC_ADMIN_PASSWORD` trong `.env`.
- **Realm được tự động import** khi container khởi động lần đầu (nhờ cờ `--import-realm` trong `docker-compose.yml`), lấy dữ liệu từ `keycloak/realm/realm-export.json` — **không cần** vào Admin Console import tay.

> ⚠️ **Lưu ý cấu hình cần kiểm tra:** `docker-compose.yml` đang mount realm export từ đường dẫn `./realm-export.json` (thư mục gốc), nhưng file thật hiện nằm ở `keycloak/realm/realm-export.json`. Nếu sau khi `docker-compose up` mà Realm không tự import được, hãy copy file vào đúng đường dẫn gốc hoặc sửa lại path trong `docker-compose.yml` (mục `keycloak-1`/`keycloak-2` → `volumes`).

### 4️⃣ Kiểm tra ứng dụng Client (MyApp)

MyApp đã tự chạy sẵn cùng `docker-compose up -d` ở bước trên (container `myapp-server`), **không cần** cài/chạy `npm start` thủ công. Truy cập trực tiếp:

**http://localhost:3000**

Chỉ cần chạy `npm install && npm start` thủ công trong thư mục `myapp/` nếu bạn muốn code/debug bên ngoài Docker (dev mode không qua container).

### 5️⃣ (Tùy chọn) Tạo nhanh users mẫu

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
