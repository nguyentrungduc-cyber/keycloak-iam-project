# Phân quyền RBAC

> Tài liệu này do Người 3 viết — cập nhật sau khi hoàn thành giai đoạn 3 (10/04–19/04)

## Danh sách Roles

### Realm Roles

| Role | Mô tả | Gán cho |
|---|---|---|
| `admin` | Toàn quyền quản trị | admin_user |
| `editor` | Quyền chỉnh sửa nội dung | editor_user |
| `user` | Quyền cơ bản | Tất cả user thường |

### Client Roles (myapp)

| Role | Mô tả |
|---|---|
| `myapp-admin` | Admin trong phạm vi app myapp |
| `myapp-viewer` | Chỉ xem, không sửa |

## Cấu hình trong KeyCloak

*(Thêm ảnh chụp màn hình admin console vào đây)*

## Test Cases

| Test | User | Route | Kết quả mong đợi |
|---|---|---|---|
| 1 | admin_user | /admin | 200 OK |
| 2 | editor_user | /admin | 403 Forbidden |
| 3 | normal_user | /editor | 403 Forbidden |
| 4 | editor_user | /editor | 200 OK |
| 5 | Chưa login | /dashboard | Redirect về /login |
