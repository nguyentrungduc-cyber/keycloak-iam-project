#!/bin/bash
# Script tạo users mẫu qua KeyCloak Admin API
# Chạy sau khi đã import realm và KC đang chạy

set -e

KC_URL="http://localhost:8080"
REALM="myrealm"
ADMIN_USER="${KC_ADMIN_USER:-admin}"
ADMIN_PASS="${KC_ADMIN_PASSWORD:-admin}"

echo ">>> Đang lấy admin token..."
TOKEN=$(curl -s -X POST "$KC_URL/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$ADMIN_USER&password=$ADMIN_PASS&grant_type=password&client_id=admin-cli" \
  | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
  echo "Lỗi: Không lấy được token. Kiểm tra KC đang chạy và thông tin admin."
  exit 1
fi

echo ">>> Tạo user: admin_user (role: admin)"
curl -s -X POST "$KC_URL/admin/realms/$REALM/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin_user",
    "email": "admin@example.com",
    "firstName": "Admin",
    "lastName": "User",
    "enabled": true,
    "credentials": [{"type":"password","value":"Admin@1234","temporary":false}]
  }'

echo ">>> Tạo user: editor_user (role: editor)"
curl -s -X POST "$KC_URL/admin/realms/$REALM/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "editor_user",
    "email": "editor@example.com",
    "firstName": "Editor",
    "lastName": "User",
    "enabled": true,
    "credentials": [{"type":"password","value":"Editor@1234","temporary":false}]
  }'

echo ">>> Tạo user: normal_user (không có role đặc biệt)"
curl -s -X POST "$KC_URL/admin/realms/$REALM/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "normal_user",
    "email": "user@example.com",
    "firstName": "Normal",
    "lastName": "User",
    "enabled": true,
    "credentials": [{"type":"password","value":"User@1234","temporary":false}]
  }'

echo ""
echo "=== Tạo users xong ==="
echo "admin_user  / Admin@1234  → có role admin"
echo "editor_user / Editor@1234 → có role editor"
echo "normal_user / User@1234   → không có role đặc biệt"
echo ""
echo "Nhớ gán roles cho users trong Admin Console!"
