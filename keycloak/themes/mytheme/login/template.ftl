<#macro registrationLayout displayInfo=false displayWide=false displayMessage=true; section>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập MyApp</title>
</head>
<body style="background:#0f0f0f; margin:0; font-family: system-ui;">
    <div style="max-width:420px; margin:40px auto; padding:20px;">
        <#nested "header">
        <#nested "form">
    </div>
</body>
</html>
</#macro>