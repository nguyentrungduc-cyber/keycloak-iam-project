# Keycloak Configuration — MyApp

Hướng dẫn cấu hình Keycloak cho ứng dụng MyApp trên realm `uit-keycloak-realm`.

> ⚠️ **Lưu ý:** Tất cả các bước dưới đây thực hiện trên realm **`uit-keycloak-realm`**, KHÔNG phải realm `master`. Realm `master` chỉ dùng để quản trị hệ thống Keycloak.

---

## Mục lục

1. [Tạo Client OIDC cho MyApp](#bước-1--tạo-client-oidc-cho-myapp)
2. [Bật PKCE](#bước-2--bật-pkce)
3. [Cấu hình Password Policy](#bước-3--cấu-hình-password-policy)
4. [Bật Brute Force Protection](#bước-4--bật-brute-force-protection)
5. [Bật User Registration](#bước-5--bật-user-registration)
6. [Cấu hình Email Verification](#bước-6--cấu-hình-email-verification)
7. [Export Realm](#bước-7--export-realm)
8. [Viết tài liệu](#bước-8--viết-tài-liệu)

---

## Bước 1 — Tạo Client OIDC cho MyApp

Vào **Admin Console → Clients → Create client**

**Tab General Settings:**

| Trường | Giá trị |
|--------|---------|
| Client type | OpenID Connect |
| Client ID | `myapp` |
| Name | `MyApp` |

Bấm **Next**.

**Tab Capability config:**

| Trường | Giá trị |
|--------|---------|
| Client authentication | On (để có client secret) |
| Authentication flow | Chỉ giữ **Standard flow** (Authorization Code Flow) |

Bấm **Next**.

**Tab Login settings:**

| Trường | Giá trị |
|--------|---------|
| Valid redirect URIs | `http://localhost:3000/*` |
| Valid post logout redirect URIs | `http://localhost:3000/*` |
| Web origins | `http://localhost:3000` |

Bấm **Save**.

**Lấy Client Secret:**

Sau khi Save → vào tab **Credentials** → copy giá trị **Client secret** → điền vào file `.env`:

```env
KC_CLIENT_SECRET=paste_vào_đây
```

---

## Bước 2 — Bật PKCE

Trong client `myapp` → tab **Advanced** → tìm mục **Proof Key for Code Exchange Code Challenge Method** → chọn **S256** → **Save**.

> PKCE là lớp bảo mật bổ sung cho Authorization Code Flow, giúp ngăn chặn tấn công đánh cắp authorization code.

---

## Bước 3 — Cấu hình Password Policy

Vào **Authentication → tab Policies → Password policy → Add policy**

Thêm lần lượt các policy sau:

| Policy | Giá trị | Ý nghĩa |
|--------|---------|---------|
| Minimum length | `8` | Tối thiểu 8 ký tự |
| Uppercase characters | `1` | Ít nhất 1 chữ hoa |
| Lowercase characters | `1` | Ít nhất 1 chữ thường |
| Digits | `1` | Ít nhất 1 chữ số |
| Special characters | `1` | Ít nhất 1 ký tự đặc biệt |
| Not username | On | Không được trùng username |

> ⚠️ Bấm **Save** sau mỗi policy thêm vào.

---

## Bước 4 — Bật Brute Force Protection

> **Khuyến nghị:** Chọn **Lockout temporarily** cho đồ án.

Giải thích các tùy chọn:

| Tùy chọn | Ý nghĩa | Phù hợp? |
|----------|---------|----------|
| Disabled | Tắt hoàn toàn, nhập sai bao nhiêu lần cũng được | ❌ Không có bảo mật |
| Lockout permanently | Sai quá số lần → khóa vĩnh viễn, phải admin mở | ❌ Quá mạnh, demo dễ bị kẹt |
| **Lockout temporarily** | Sai quá số lần → khóa tạm thời, tự mở sau vài phút | ✅ **Chọn cái này** |
| Lockout permanently (escalated) | Lockout tạm thời nhiều lần → khóa vĩnh viễn | ❌ Quá phức tạp cho đồ án |

Bấm **Save**, sau đó điền các thông số:

| Trường | Giá trị | Ý nghĩa |
|--------|---------|---------|
| Max login failures | `5` | Sai 5 lần thì khóa |
| Wait increment | `30 Seconds` | Mỗi lần sai thêm chờ thêm 30 giây |
| Max wait | `15 Minutes` | Tối đa khóa 15 phút |

---

## Bước 5 — Bật User Registration

Vào **Realm settings → tab Login**, bật các toggle:

| Toggle | Giá trị |
|--------|---------|
| User registration | ✅ On — cho phép tự đăng ký |
| Forgot password | ✅ On — cho phép reset mật khẩu |
| Remember me | ✅ On |
| Email as username | Tùy nhóm chọn |

Bấm **Save**.

---

## Bước 6 — Cấu hình Email Verification

Keycloak cần được cấu hình email để gửi xác nhận đăng ký, reset mật khẩu, v.v.

### Tạo App Password của Gmail

> Không dùng mật khẩu Gmail thật — phải tạo App Password riêng.

1. Vào **Google Account → Security → 2-Step Verification** (phải bật trước)
2. Tìm **App passwords** → tạo mới → chọn **Mail**
3. Copy mật khẩu **16 ký tự** được tạo ra

### Điền thông tin Email

**Phần thông tin người gửi:**

| Ô | Điền gì |
|---|---------|
| From | Email Gmail của nhóm |
| From display name | `MyApp` |
| Reply to | *(để trống)* |
| Reply to display name | *(để trống)* |
| Envelope from | *(để trống)* |

**Phần Connection & Authentication:**

| Ô | Giá trị |
|---|---------|
| Host | `smtp.gmail.com` |
| Port | `587` |
| Encryption | `STARTTLS` |
| Authentication | ✅ On |
| Username | Email Gmail của nhóm |
| Password | App Password 16 ký tự vừa tạo |

### Bật Verify Email

Vào **Authentication → tab Required actions** → bật **Verify Email** → set **Default action**.

---

## Bước 7 — Export Realm

Vào **Realm settings → Action** (góc trên phải) → **Partial export**

Bật cả hai tùy chọn:
- ✅ Include groups and roles
- ✅ Include clients

Bấm **Export**.

---

## Bước 8 — Viết tài liệu

Tạo file `myapp/keycloak-config/README_Keycloak_Config.md` ghi lại:

- Tên realm, Client ID
- Các password policy đã cài
- Redirect URIs
- Hướng dẫn import realm cho thành viên khác
- Chụp màn hình các bước quan trọng
