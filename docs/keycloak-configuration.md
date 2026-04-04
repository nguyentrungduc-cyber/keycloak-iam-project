# Hướng dẫn Cấu hình Nghiệp vụ Keycloak

Tài liệu này hướng dẫn cơ bản cách thiết lập Realm, Token, Session và phân quyền User để đảm bảo hệ thống đạt được sự cân bằng giữa bảo mật và trải nghiệm người dùng.

---

## Yêu cầu Hệ thống

| Thành phần | Version tối thiểu | Kiểm tra |
| :--- | :--- | :--- |
| Docker Desktop | 4.x+ | Xem trong Settings > Software Updates |
| Docker Engine | 20.10.x+ | `docker version` |
| Docker Compose | 2.0+ | `docker compose version` |

---

## Bước 1 — Khởi tạo Realm (Vùng quản trị)

Realm là không gian độc lập để quản lý Users và Clients, giúp tách biệt cấu hình đồ án khỏi hệ thống quản trị `master`.

1. **Vị trí:** Nhấn vào tên Realm hiện tại ở góc trái trên cùng (mặc định là `master`) ➔ **Create Realm**.
2. **Thực hiện:** Nhập `tên-realm-của-bạn` ➔ **Create**.

 **Giải thích:** Việc tách biệt Realm giúp dễ dàng đóng gói (Export) và tái sử dụng (Import) cấu hình dự án mà không làm ảnh hưởng đến các tài khoản quản trị tối cao của hệ thống.

---

## Bước 2 — Cấu hình Token & Session

Thiết lập thời gian sống của phiên đăng nhập và cơ chế thu hồi quyền truy cập tại mục **Realm Settings**.

### 2.1. Cấu hình Refresh Tokens (Tab Tokens)
* **Revoke Refresh Token:** Chuyển sang `Enabled`.
* **Refresh Token Max Reuse:** Thiết lập giá trị `30`.
* **Giải thích:** Buộc Token phải thay mới sau mỗi lần sử dụng (Rotation). Giới hạn `30` lần gia hạn tối đa nhằm ngăn chặn việc chiếm quyền điều khiển phiên làm việc từ xa nếu token bị rò rỉ.

### 2.2. Cấu hình Sessions (Tab Sessions)
* **SSO Session Idle:** `30 Minutes`
* **SSO Session Max:** `10 Hours`
* **Client Session Idle/Max:** Thiết lập tương tự (`30m` / `10h`)
* **Giải thích:** 
    * **Idle (Thời gian chờ):** Tự động **reset** mỗi khi bạn thao tác. Nếu bạn "treo máy" quá 30 phút, hệ thống sẽ tự logout để bảo vệ tài khoản. 
    * **Max (Hạn dùng):** **Không bao giờ reset**. Dù bạn đang làm việc liên tục thì sau 10 tiếng hệ thống vẫn bắt đăng nhập lại để đảm bảo bảo mật định kỳ.

---

## Bước 3 — Quản lý Realm Roles

Thiết lập các vai trò định danh để thực hiện mô hình kiểm soát truy cập dựa trên vai trò (RBAC).

1. **Vị trí:** Menu bên trái ➔ **Realm roles** ➔ **Create role**.
2. **Thực hiện:** Nhập tên vai trò (ví dụ: `admin`, `user`) ➔ **Save**.

* **Giải thích:** Thay vì gán quyền cho từng cá nhân, ta gán vào Role để dễ dàng quản trị và thay đổi quyền hạn của hàng loạt người dùng cùng lúc.

---

## Bước 4 — Quản lý Người dùng (Users)

Tạo tài khoản mẫu và thiết lập các thuộc tính định danh để thực hiện xác thực ứng dụng.

### 4.1. Tạo User mẫu
1. **Vị trí:** Menu bên trái ➔ **Users** ➔ **Create user**.
2. **Thực hiện:** Nhập Username ➔ **Create**.
3. **Thiết lập mật khẩu:** Tab **Credentials** ➔ **Set password** ➔ Tắt **Temporary** (chuyển sang OFF) ➔ **Save**.

### 4.2. Gán quyền (Role Mapping)
1. Tại giao diện chi tiết User ➔ Tab **Role mapping**.
2. Click **Assign role** ➔ Tích chọn role phù hợp (`admin` hoặc `user`) ➔ **Assign**.

**Giải thích:** Việc tắt mật khẩu tạm thời (`Temporary`) giúp tài khoản sử dụng được ngay lập tức mà không bắt buộc người dùng phải thực hiện bước đổi mật khẩu ở lần đăng nhập đầu tiên, tối ưu thời gian kiểm thử.

---

## Bước 5 — Kiểm tra cấu hình (Verification)

Sử dụng tài khoản vừa tạo để kiểm tra khả năng truy cập thực tế qua giao diện quản lý tài khoản cá nhân.

👉 **URL:** `http://localhost:8080/realms/tên-realm-của-bạn/account`

---

## Bước 6 — Đồng bộ hóa cấu hình (Export/Import)

Sử dụng file JSON để đảm bảo môi trường làm việc nhất quán cho tất cả thành viên trong nhóm.

### 6.1. Xuất cấu hình (Export)
1. Truy cập **Realm Settings** ➔ Nút **Action** (góc trên bên phải) ➔ **Partial export**.
2. Bật **On** cho cả hai mục: `Include groups and roles` và `Include clients`.
3. Click **Export**.

### 6.2. Nhập cấu hình (Import)
1. Tại giao diện **Bước 1 (Create Realm)** ➔ Click **Browse...** tại mục **Resource file**.
2. Chọn file cấu hình JSON từ thư mục dự án ➔ **Create**.

> **⚠️ Lưu ý quan trọng:** Để đảm bảo tính bảo mật, Keycloak mặc định không đính kèm danh sách người dùng (Users) trong file Export. Do đó, sau khi Import cấu hình hệ thống, phải thực hiện lại quy trình tại **Bước 4** để khởi tạo các tài khoản test cá nhân.