# Hướng dẫn cài đặt

## Yêu cầu phần mềm

| Phần mềm | Version tối thiểu | Kiểm tra |
|---|---|---|
| Docker | 24.0+ | `docker --version` |
| Docker Compose | 2.0+ | `docker compose version` |
| Node.js | 18.0+ | `node --version` |
| Git | bất kỳ | `git --version` |

## Bước 1 — Clone repo

```bash
git clone https://github.com/your-team/keycloak-iam-project.git
cd keycloak-iam-project
```

## Bước 2 — Tạo file .env

```bash
cp .env.example .env
```

Mở file `.env` và điền giá trị:

```
# ⚠️ HƯỚNG DẪN: Sao chép file này thành .env và điền giá trị thật.
# ⚠️ QUAN TRỌNG: KHÔNG ĐƯỢC commit file .env lên GitHub để tránh lộ mật khẩu.

# ── KeyCloak Admin (Tài khoản quản trị tối cao của Keycloak) ──
# Dùng để đăng nhập vào trang quản trị (Admin Console)
KC_ADMIN_USER=admin
KC_ADMIN_PASSWORD=Admin@1234       # Nên đổi thành mật khẩu mạnh hơn khi triển khai thực tế

# ── Database (Thông số kết nối cơ sở dữ liệu) ────────────────
# Keycloak sẽ dùng thông tin này để tạo và quản lý bảng trong DB
DB_USER=keycloak
DB_PASSWORD=keycloak123            # Mật khẩu dùng cho Database trong Docker

# ── Keycloak Server ──────────────────────────────────────────
KEYCLOAK_PORT=8080                 # Cổng chạy dịch vụ Keycloak (mặc định là 8080)

# ── Client App (Thông tin kết nối giữa App và Keycloak) ──────
KC_REALM=uit-keycloak-realm        # Tên Realm bạn đã tạo trong Keycloak
KC_CLIENT_ID=myapp-client          # ID của Client đã tạo trong mục Clients
KC_CLIENT_SECRET=                  # Lấy tại tab 'Credentials' của Client trong Keycloak
KC_SERVER_URL=http://localhost:8080 # Đường dẫn gốc để App gọi đến Server Keycloak

# Thông số của ứng dụng phía Client (Node.js/React/ASP.NET)
APP_PORT=3000                      # Cổng chạy ứng dụng của nhóm
SESSION_SECRET=random-string-here  # Chuỗi ký tự ngẫu nhiên để mã hóa phiên làm việc

# ── Social Login (Điền sau khi tạo OAuth App trên Google/GitHub) ──
# Thông tin xác thực từ các nền tảng bên thứ ba
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

GITHUB_CLIENT_ID=
GITHUB_CLIENT_SECRET=
```

## Bước 3 — Khởi động KeyCloak

```bash
docker-compose up -d
```

Chờ khoảng 30-60 giây. Kiểm tra:

```bash
docker-compose logs keycloak | tail -20
# Tìm dòng: "Keycloak X.X.X on JVM started"
```

Truy cập: http://localhost:8080/admin  
Đăng nhập bằng `KC_ADMIN_USER` và `KC_ADMIN_PASSWORD` trong file `.env`

## Bước 4 — Import Realm

1. Vào Admin Console → Chọn "Create realm" (góc trên trái)
2. Click "Browse..." → Chọn file `keycloak/realm-export.json`
3. Click "Create"

## Bước 5 — Lấy Client Secret

1. Vào Realm `myrealm` → Clients → `myapp`
2. Tab "Credentials" → Copy "Client secret"
3. Dán vào `KC_CLIENT_SECRET` trong file `.env`

## Bước 6 — Chạy Client App

```bash
cd client-app
npm install
npm start
```

Truy cập: http://localhost:3000

## Kiểm tra hệ thống chạy đúng

1. Vào http://localhost:3000 → thấy trang chủ
2. Click "Đăng nhập" → chuyển sang trang login KeyCloak
3. Đăng nhập bằng user mẫu → vào được dashboard
4. Vào http://localhost:3000/admin → thấy 403 nếu không có role admin

## Tắt hệ thống

```bash
docker-compose down
```

Tắt và xóa data (reset hoàn toàn):

```bash
docker-compose down -v
```
