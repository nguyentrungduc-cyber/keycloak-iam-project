#!/bin/bash
# seed-users.sh — Tạo users + gán roles tự động qua Keycloak Admin API
# Tương thích: Linux, macOS, Windows Git Bash (MINGW64)

set -e

KC_URL="${KC_URL:-http://localhost:8080}"
REALM="${KC_REALM:-uit-keycloak-realm}"
ADMIN_USER="${KC_ADMIN_USER:-admin}"
ADMIN_PASS="${KC_ADMIN_PASSWORD:-Admin@12345}"

echo ""
echo "================================================="
echo "  Keycloak Seed Script"
echo "  Realm : $REALM"
echo "  Server: $KC_URL"
echo "================================================="
echo ""

# ── Kiểm tra python3 ─────────────────────────────────────────────
if ! command -v python3 &>/dev/null; then
  echo "❌ Cần cài python3 để parse JSON. Vui lòng cài python3."
  exit 1
fi

# ── Hàm parse JSON bằng python3 (hoạt động trên mọi OS) ──────────
json_get() {
  # json_get <json_string> <key>
  echo "$1" | python3 -c "
import sys, json
try:
  data = json.load(sys.stdin)
  if isinstance(data, list):
    print(data[0].get('$2',''))
  else:
    print(data.get('$2',''))
except:
  print('')
"
}

# ── Bước 1: Lấy admin token ──────────────────────────────────────
echo ">>> [1/5] Lấy admin token..."
TOKEN_RESPONSE=$(curl -s -X POST "$KC_URL/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$ADMIN_USER&password=$ADMIN_PASS&grant_type=password&client_id=admin-cli")

TOKEN=$(json_get "$TOKEN_RESPONSE" "access_token")

if [ -z "$TOKEN" ]; then
  echo "❌ Không lấy được token. Kiểm tra Keycloak đang chạy và thông tin admin."
  echo "   Response: $TOKEN_RESPONSE"
  exit 1
fi
echo "   ✓ Token OK"

AUTH_HEADER="Authorization: Bearer $TOKEN"

# ── Hàm tạo user ─────────────────────────────────────────────────
create_user() {
  local USERNAME=$1 EMAIL=$2 FIRST=$3 LAST=$4 PASSWORD=$5
  echo ""
  echo ">>> Tạo user: $USERNAME ($EMAIL)..."

  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "$KC_URL/admin/realms/$REALM/users" \
    -H "$AUTH_HEADER" \
    -H "Content-Type: application/json" \
    -d "{
      \"username\": \"$USERNAME\",
      \"email\": \"$EMAIL\",
      \"firstName\": \"$FIRST\",
      \"lastName\": \"$LAST\",
      \"enabled\": true,
      \"emailVerified\": true,
      \"credentials\": [{\"type\":\"password\",\"value\":\"$PASSWORD\",\"temporary\":false}]
    }")

  case "$HTTP_CODE" in
    201) echo "   ✓ Tạo thành công" ;;
    409) echo "   ℹ User đã tồn tại, bỏ qua" ;;
    *)   echo "   ⚠ HTTP $HTTP_CODE" ;;
  esac
}

# ── Hàm lấy user ID ──────────────────────────────────────────────
get_user_id() {
  local USERNAME=$1
  local RESPONSE
  RESPONSE=$(curl -s \
    "$KC_URL/admin/realms/$REALM/users?username=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$USERNAME'))")&exact=true" \
    -H "$AUTH_HEADER")

  # Parse id từ array JSON: [{"id":"...","username":"..."}]
  echo "$RESPONSE" | python3 -c "
import sys, json
try:
  data = json.load(sys.stdin)
  for u in data:
    if u.get('username','').lower() == '$USERNAME'.lower():
      print(u['id'])
      break
except Exception as e:
  pass
"
}

# ── Hàm lấy role ID ──────────────────────────────────────────────
get_role_id() {
  local ROLE_NAME=$1
  local RESPONSE
  RESPONSE=$(curl -s "$KC_URL/admin/realms/$REALM/roles/$ROLE_NAME" \
    -H "$AUTH_HEADER")
  json_get "$RESPONSE" "id"
}

# ── Hàm gán role cho user ─────────────────────────────────────────
assign_role() {
  local USER_ID=$1 ROLE_NAME=$2
  local ROLE_ID
  ROLE_ID=$(get_role_id "$ROLE_NAME")

  if [ -z "$ROLE_ID" ]; then
    echo "   ⚠ Role '$ROLE_NAME' không tồn tại trong realm, bỏ qua"
    return
  fi

  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "$KC_URL/admin/realms/$REALM/users/$USER_ID/role-mappings/realm" \
    -H "$AUTH_HEADER" \
    -H "Content-Type: application/json" \
    -d "[{\"id\":\"$ROLE_ID\",\"name\":\"$ROLE_NAME\"}]")

  [ "$HTTP_CODE" = "204" ] && echo "   ✓ Gán role '$ROLE_NAME'" || echo "   ⚠ Gán role '$ROLE_NAME' HTTP $HTTP_CODE"
}

# ── Bước 2: Tạo users ────────────────────────────────────────────
echo ""
echo ">>> [2/5] Tạo users..."
create_user "admin_user"  "admin@example.com"  "Admin"  "User" "Admin@1234"
create_user "editor_user" "editor@example.com" "Editor" "User" "Editor@1234"
create_user "normal_user" "user@example.com"   "Normal" "User" "User@1234"

# ── Bước 3: Lấy user IDs ─────────────────────────────────────────
echo ""
echo ">>> [3/5] Lấy user IDs..."

ADMIN_ID=$(get_user_id "admin_user")
EDITOR_ID=$(get_user_id "editor_user")
NORMAL_ID=$(get_user_id "normal_user")

echo "   admin_user  ID: ${ADMIN_ID:-❌ không lấy được}"
echo "   editor_user ID: ${EDITOR_ID:-❌ không lấy được}"
echo "   normal_user ID: ${NORMAL_ID:-❌ không lấy được}"

if [ -z "$ADMIN_ID" ] || [ -z "$EDITOR_ID" ] || [ -z "$NORMAL_ID" ]; then
  echo ""
  echo "❌ Không lấy được ID. Gợi ý kiểm tra:"
  echo "   1. Vào http://localhost:8080/admin → realm '$REALM' → Users"
  echo "   2. Xem 3 user có tồn tại không"
  echo "   3. Thử chạy lại script"
  exit 1
fi

# ── Bước 4: Gán roles ────────────────────────────────────────────
echo ""
echo ">>> [4/5] Gán realm roles..."
echo "   admin_user  → admin, user"
assign_role "$ADMIN_ID"  "admin"
assign_role "$ADMIN_ID"  "user"

echo "   editor_user → editor (nếu có), user"
assign_role "$EDITOR_ID" "editor"
assign_role "$EDITOR_ID" "user"

echo "   normal_user → user"
assign_role "$NORMAL_ID" "user"

# ── Bước 5: Tóm tắt ──────────────────────────────────────────────
echo ""
echo "================================================="
echo "  ✅ Seed hoàn thành!"
echo "================================================="
echo ""
echo "  Username     | Password     | Roles"
echo "  -------------|--------------|------------------"
echo "  admin_user   | Admin@1234   | admin, user"
echo "  editor_user  | Editor@1234  | editor, user"
echo "  normal_user  | User@1234    | user"
echo ""
