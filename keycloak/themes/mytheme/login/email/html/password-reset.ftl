<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<title>Đặt lại mật khẩu — MyApp</title>
<style>
  body { margin:0; padding:0; background:#f4f4f4; font-family:'Inter',system-ui,sans-serif; }
  .wrap { max-width:520px; margin:40px auto; background:#1e1e1e; border-radius:12px; overflow:hidden; }
  .header { background:#2563eb; padding:28px 32px; text-align:center; }
  .logo { display:inline-flex; align-items:center; justify-content:center;
          width:48px; height:48px; background:rgba(255,255,255,.15);
          border-radius:12px; margin-bottom:12px; }
  .app-name { color:#ffffff; font-size:20px; font-weight:700; margin:0; }
  .body { padding:32px; }
  .greeting { color:#f0f0f0; font-size:15px; margin-bottom:12px; }
  .desc { color:#aaaaaa; font-size:14px; line-height:1.7; margin-bottom:24px; }
  .btn-wrap { text-align:center; margin-bottom:24px; }
  .btn {
    display:inline-block; background:#2563eb; color:#ffffff !important;
    text-decoration:none; border-radius:10px; padding:14px 36px;
    font-size:15px; font-weight:600;
  }
  .divider { border:none; border-top:0.5px solid #333333; margin:24px 0; }
  .link-box {
    background:#161616; border:0.5px solid #333;
    border-radius:8px; padding:12px 14px;
    font-size:12px; color:#666666;
    word-break:break-all; margin-bottom:16px;
  }
  .link-box a { color:#60a5fa; text-decoration:none; }
  .warning { color:#888888; font-size:12px; line-height:1.6; }
  .warning strong { color:#aaaaaa; }
  .footer { background:#161616; padding:18px 32px; text-align:center; }
  .footer p { color:#555555; font-size:11px; margin:0; line-height:1.7; }
  .footer a { color:#60a5fa; text-decoration:none; }
</style>
</head>
<body>
<div class="wrap">

  <!-- Header -->
  <div class="header">
    <div class="logo">
      <svg width="26" height="26" viewBox="0 0 24 24" fill="none">
        <circle cx="12" cy="12" r="8" stroke="white" stroke-width="2"/>
        <circle cx="12" cy="12" r="2.5" fill="white"/>
      </svg>
    </div>
    <p class="app-name">MyApp</p>
  </div>

  <!-- Body -->
  <div class="body">

    <p class="greeting">Xin chào <strong style="color:#f0f0f0;">${user.firstName!''} ${user.lastName!''}</strong>,</p>

    <p class="desc">
      Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản
      <strong style="color:#f0f0f0;">${user.email}</strong>.
      Nhấn vào nút bên dưới để tiếp tục.
    </p>

    <div class="btn-wrap">
      <a href="${link}" class="btn">Đặt lại mật khẩu</a>
    </div>

    <hr class="divider"/>

    <p style="color:#666;font-size:12px;margin-bottom:8px;">
      Hoặc copy link sau vào trình duyệt:
    </p>
    <div class="link-box">
      <a href="${link}">${link}</a>
    </div>

    <div class="warning">
      <strong>Lưu ý:</strong> Link này chỉ có hiệu lực trong
      <strong>${linkExpirationFormatter(linkExpiration)}</strong>.
      Sau khi hết hạn bạn cần yêu cầu lại từ đầu.<br/><br/>
      Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này.
      Tài khoản của bạn vẫn an toàn.
    </div>

  </div>

  <!-- Footer -->
  <div class="footer">
    <p>
      Email này được gửi tự động từ <strong style="color:#888;">MyApp</strong>.<br/>
      Vui lòng không trả lời email này.<br/>
      <a href="${realmUrl}">Truy cập MyApp</a> · <a href="${realmUrl}/account">Quản lý tài khoản</a>
    </p>
  </div>

</div>
</body>
</html>
