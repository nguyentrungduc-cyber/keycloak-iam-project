# Đồ án: Keycloak IAM Project

Hệ thống Identity & Access Management (IAM) sử dụng Keycloak — Đồ án môn học. Hệ thống được cấu hình chạy High Availability (HA) kết hợp Load Balancer (Nginx) để đảm bảo tính sẵn sàng cao.

---

## 👥 Thành viên nhóm & Nhiệm vụ

| Thành viên | Giai đoạn | Nhiệm vụ chính |
| :--- | :--- | :--- |
| **Đạt** | GĐ 1 (23/03–30/03) | Hạ tầng Docker, Realm, Users, Roles |
| **Danh** | GĐ 2 (31/03–09/04) | OIDC Client App, Registration, Theme |
| **Sử** | GĐ 3 (10/04–19/04) | RBAC, MFA (TOTP + WebAuthn) |
| **Đạt** | GĐ 4 (20/04–28/04) | SAML 2.0, Social Login, Tài liệu tổng hợp |

---

## 🏗️ Kiến trúc hệ thống

```mermaid
Browser ──> Client App (Node.js) ──> Load Balancer (Nginx) ──> Keycloak Cluster (HA)
                                                                       ↕
                                                          Google / GitHub (Social Login)
                                                                       ↕
                                                             SAML Service Provider
(Hệ thống sử dụng Nginx làm Load Balancer phía trước cụm Keycloak để điều hướng dữ liệu).  🚀 Hướng dẫn cài đặt chi tiết🛠️ Yêu cầu phần mềm hệ thốngPhần mềmPhiên bản tối thiểuLệnh kiểm tra  MDDocker24.0+  docker --version  Docker Compose2.0+  docker compose version  Node.jsv18.0+  node --version  GitBất kỳ  git --version  📝 Các bước triển khaiBước 1: Clone mã nguồn về máyBashgit clone [https://github.com/nguyentrungduc-cyber/keycloak-iam-project.git](https://github.com/nguyentrungduc-cyber/keycloak-iam-project.git)
cd keycloak-iam-project
Bước 2: Cấu hình file môi trườngTạo file .env từ file mẫu:  Bashcp .env.example .env
Mở file .env và điền/chỉnh sửa các thông số quan trọng:  Đoạn mãKC_REALM=uit-keycloak-realm
KC_CLIENT_ID=myapp
Bước 3: Cấu hình tên miền ảo (BẮT BUỘC) ⚠️Lưu ý quan trọng: Do hệ thống sử dụng Load Balancer (Nginx) phía trước Keycloak trong mạng nội bộ Docker, bạn bắt buộc phải ánh xạ tên miền nginx về localhost. Nếu thiếu bước này, trình duyệt sẽ không thể redirect chính xác khi đăng nhập.  Trên Windows:Mở ứng dụng Notepad bằng quyền Administrator.  Mở file theo đường dẫn: C:\Windows\System32\drivers\etc\hosts.  Thêm dòng sau vào cuối file và lưu lại:  Plaintext       127.0.0.1 nginx
       ```
*   **Trên Linux / macOS:**
1. Chạy lệnh mở file hosts:
```bash
       sudo nano /etc/hosts
       ```
2. Thêm dòng sau vào cuối file và lưu lại:
```text
       127.0.0.1 nginx
       ```

#### **Bước 4: Khởi động toàn bộ hệ thống**
Khởi chạy cụm dịch vụ bao gồm Keycloak HA, Database, Nginx và cả MyApp (đã được đóng gói sẵn trong Docker):
```bash
docker compose up -d --build
Lưu ý: Nên sử dụng --build cho lần đầu chạy hoặc khi có thay đổi mã nguồn/thư viện. Những lần sau chỉ cần chạy docker compose up -d.  Bước 5: Import Realm và cấu hình Client SecretTruy cập vào trang quản trị: Keycloak Admin Console (http://localhost:8080/admin).  Chọn Create realm ➔ Upload file cấu hình mẫu tại keycloak/realm-export.json.  Sau khi import thành công, vào mục Clients ➔ Chọn client myapp[cite: 2].Di chuyển qua tab Credentials ➔ Tiến hành Copy Client Secret[cite: 2].Dán giá trị bí mật này vào file .env của bạn và khởi động lại app để áp dụng cấu hình[cite: 2]:Bash   docker compose restart myapp[cite: 2]
🔍 Kiểm tra & Vận hành hệ thống📍 Các địa chỉ truy cậpKeycloak Admin Console: http://localhost:8080/admin  Client Application (MyApp): http://localhost:3000[cite: 1, 2]📜 Lệnh kiểm tra Logs (Khi gặp sự cố)Để theo dõi log hoạt động của các Node Keycloak, sử dụng lệnh[cite: 2]:Bashdocker compose logs keycloak-1 --tail=20[cite: 2]
docker compose logs keycloak-2 --tail=20[cite: 2]
🧪 Bài test tính năng High Availability (HA)Để chứng minh hệ thống có khả năng chịu lỗi (Failover)[cite: 2]:Truy cập ứng dụng tại http://localhost:3000 và tiến hành đăng nhập[cite: 2].Giả lập sự cố bằng cách tắt đi 1 node Keycloak[cite: 2]:Bash   docker stop keycloak-node-1[cite: 2]
Quay lại trình duyệt và tải lại (Reload) trang[cite: 2].Kết quả mong đợi: Bạn không bị logout, mọi tính năng trên trang vẫn hoạt động bình thường nhờ Node còn lại gánh tải[cite: 2].🛑 Tắt hệ thốngDừng các dịch vụ thông thường[cite: 2]:Bash    docker compose down[cite: 2]
    ```
*   Dừng và **xoá sạch** toàn bộ dữ liệu (Reset hoàn toàn)[cite: 2]:
```bash
    docker compose down -v[cite: 2]
    ```

---

## 🛠️ Tính năng nâng cao & Tùy chọn khác

### 🧩 Chạy Client App riêng lẻ ở Local (Tùy chọn)
Nếu bạn muốn phát triển hoặc chỉnh sửa trực tiếp mã nguồn ứng dụng `myapp` ở máy local mà không thông qua Docker của ứng dụng đó[cite: 2]:
```bash
cd myapp[cite: 1, 2]
npm install[cite: 1, 2]
npm start[cite: 1, 2]
⚠️ Lưu ý: Bỏ qua bước này nếu bạn đã chạy ứng dụng này trực tiếp thông qua Docker Compose ở Bước 4[cite: 2].👥 Tạo dữ liệu Users mẫu hàng loạtĐể nhanh chóng có dữ liệu test hệ thống (Chạy trên môi trường Git Bash hoặc Linux):  Bashbash scripts/seed-users.sh
💎 Danh sách tính năng đã triển khai hoàn thiện[x] Hạ tầng Keycloak server vận hành trên Docker  [x] Cấu hình hoàn chỉnh Realm, Users, và Roles cơ bản  [x] Ứng dụng OIDC Client App kết nối mượt mà với Keycloak  [x] Tính năng đăng ký User (User registration) + Xác thực Email  [x] Áp dụng Password policy bảo mật  [x] Tuỳ biến giao diện đăng nhập (Custom login theme)  [x] Phân quyền nâng cao RBAC (Realm roles + Client roles)  [x] Xác thực hai lớp MFA — TOTP (Google Authenticator)  [x] Xác thực sinh trắc học MFA — WebAuthn / Passkey  [x] Đóng vai trò làm SAML 2.0 Identity Provider[cite: 1][x] Tích hợp Social Login qua mạng xã hội — Google & GitHub[cite: 1]📚 Thư mục tài liệu chi tiết đi kèmĐể xem cấu hình sâu hơn cho từng module, vui lòng tham khảo các file tài liệu chuyên sâu[cite: 1]:📄 Hướng dẫn cài đặt chi tiết gốc[cite: 1]📄 Hướng dẫn cấu hình keycloak hệ thống[cite: 1]📄 Cơ chế phân quyền RBAC[cite: 1]📄 Thiết lập xác thực nâng cao MFA[cite: 1]📄 Tích hợp giao thức SAML 2.0[cite: 1]📄 Cấu hình Social Login mạng xã hội[cite: 1]
