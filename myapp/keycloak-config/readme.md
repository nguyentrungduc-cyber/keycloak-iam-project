1. Thành viên 2 — Keycloak Config & Client Setup
Người này chủ yếu làm việc trên Keycloak Admin Console, không viết nhiều code React.
Các file họ cần chuẩn bị trong thư mục myapp/ (thường để trong thư mục docs/ hoặc keycloak-config/):

realm-export.json
→ File quan trọng nhất. Export toàn bộ realm sau khi cấu hình xong (Realm Settings → Export).
README_Keycloak_Config.md (hoặc .txt)
→ Tài liệu hướng dẫn chi tiết cách setup realm, client, password policy, registration flow.
Các file hỗ trợ (nên có):
password-policy-settings.txt hoặc đưa vào README (danh sách policy đã áp dụng)
Folder screenshots/ chứa ảnh chụp các bước cấu hình (realm, client, password policy, registration, required actions…)


Tóm tắt file cần tạo cho Thành viên 2:

keycloak-config/realm-export.json
keycloak-config/README_Keycloak_Config.md
keycloak-config/screenshots/ (thư mục chứa ảnh)

2. Thành viên 3 — Social Login / OAuth Broker
Người này cấu hình Google và GitHub Identity Provider.
Các file họ cần chuẩn bị:

README_Social_Login.md
→ Tài liệu quan trọng nhất, hướng dẫn cách tạo OAuth App và cấu hình IDP trong Keycloak.
google-oauth-credentials.md (hoặc .txt)
→ Chứa: Google Client ID, Client Secret, Authorized Redirect URIs
github-oauth-credentials.md (hoặc .txt)
→ Chứa: GitHub Client ID, Client Secret, Callback URL
Folder screenshots/ (có thể chung với Thành viên 2) chứa ảnh:
Google Cloud Console (tạo OAuth Client)
GitHub Developer Settings (tạo OAuth App)
Keycloak Identity Providers (Google & GitHub đã config)

(Tùy chọn nhưng rất tốt) Một bản realm-export.json sau khi đã thêm 2 Identity Providers (có thể merge với file của Thành viên 2)

Tóm tắt file cần tạo cho Thành viên 3:

keycloak-config/README_Social_Login.md
keycloak-config/google-oauth-credentials.md
keycloak-config/github-oauth-credentials.md
keycloak-config/screenshots/ (ảnh Google, GitHub, Keycloak IDP)