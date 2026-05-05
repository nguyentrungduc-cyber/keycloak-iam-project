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

Mở file `.env` và điền giá trị (như file mẫu, lưu ý các thông số quan trọng):

```
KC_REALM=uit-keycloak-realm
KC_CLIENT_ID=myapp
KC_SERVER_URL=http://nginx:8080
```

---

## Bước 3 — Cấu hình tên miền ảo (BẮT BUỘC) ⚠️

Do hệ thống sử dụng Load Balancer (Nginx) phía trước Keycloak trong mạng nội bộ Docker, bạn cần ánh xạ tên `nginx` về `localhost`.

Nếu không cấu hình bước này, trình duyệt sẽ không redirect đúng khi đăng nhập.

### Windows

1. Mở Notepad bằng quyền Administrator  
2. Mở file:
```
C:\Windows\System32\drivers\etc\hosts
```
3. Thêm dòng:
```
127.0.0.1 nginx
```

### Linux / macOS

```bash
sudo nano /etc/hosts
```

Thêm:
```
127.0.0.1 nginx
```

---

## Bước 4 — Khởi động toàn bộ hệ thống (Keycloak HA + DB + Nginx + MyApp)

```bash
docker compose up -d --build
```

Ghi chú:

- Lần đầu chạy cần `--build`
- Những lần sau chỉ cần:
```bash
docker compose up -d
```
- Khi thay đổi code hoặc cài thêm thư viện → nên chạy lại `--build`

MyApp đã được chạy sẵn trong Docker → không cần `npm start`.

---

## Kiểm tra log

```bash
docker compose logs keycloak-1 --tail=20
docker compose logs keycloak-2 --tail=20
```

---

## Truy cập hệ thống

- Keycloak Admin: http://localhost:8080/admin  
- App: http://localhost:3000  

---

## Bước 5 — Import Realm & cấu hình Client

1. Vào Admin Console  
2. Create realm  
3. Upload `keycloak/realm-export.json`  
4. Vào realm → Clients → `myapp`  
5. Tab Credentials → copy Client Secret  
6. Dán vào `.env`  
7. Restart app:

```bash
docker compose restart myapp
```

---

## Bước 6 — Kiểm tra hệ thống

1. Vào http://localhost:3000  
2. Click đăng nhập  
3. Login thành công → vào dashboard  

---

## Test High Availability (HA)

1. Login vào hệ thống  
2. Tắt 1 node:

```bash
docker stop keycloak-node-1
```

3. Reload trang  

Kết quả mong đợi:
- Không bị logout  
- Trang vẫn hoạt động  

→ chứng minh hệ thống có failover

---

## Tắt hệ thống

```bash
docker compose down
```

Reset toàn bộ dữ liệu:

```bash
docker compose down -v
```

---

## (Tùy chọn) Chạy MyApp riêng

```bash
cd myapp
npm install
npm start
```

⚠️ Không cần bước này nếu đã chạy bằng Docker Compose
