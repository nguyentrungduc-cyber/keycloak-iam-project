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
KC_ADMIN_USER=admin
KC_ADMIN_PASSWORD=Admin@1234       # Đặt mật khẩu mạnh hơn
DB_USER=keycloak
DB_PASSWORD=keycloak123
KC_REALM=myrealm
KC_CLIENT_ID=myapp
KC_CLIENT_SECRET=                  # Điền sau khi tạo client trong KC
APP_PORT=3000
SESSION_SECRET=random-string-here
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
