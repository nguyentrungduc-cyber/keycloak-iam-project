# Social Login — Google & GitHub

> Tài liệu này do Người 4 viết — cập nhật sau khi hoàn thành giai đoạn 4

## Google

### Bước 1 — Tạo OAuth App trên Google Cloud Console

1. Vào https://console.cloud.google.com
2. Tạo project mới (hoặc chọn project có sẵn)
3. APIs & Services → Credentials → Create Credentials → OAuth client ID
4. Application type: **Web application**
5. Authorized redirect URIs: `http://localhost:8080/realms/myrealm/broker/google/endpoint`
6. Lưu Client ID và Client Secret vào `.env`

### Bước 2 — Cấu hình trong KeyCloak

1. Vào Realm `myrealm` → Identity Providers → Add provider → Google
2. Client ID: dán từ Google Console
3. Client Secret: dán từ Google Console
4. Save

*(Thêm ảnh chụp màn hình vào đây)*

## GitHub

### Bước 1 — Tạo OAuth App trên GitHub

1. Vào GitHub → Settings → Developer settings → OAuth Apps → New OAuth App
2. Homepage URL: `http://localhost:3000`
3. Authorization callback URL: `http://localhost:8080/realms/myrealm/broker/github/endpoint`
4. Lưu Client ID và Client Secret

### Bước 2 — Cấu hình trong KeyCloak

1. Identity Providers → Add provider → GitHub
2. Điền Client ID và Client Secret
3. Save
