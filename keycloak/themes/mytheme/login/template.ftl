<#macro registrationLayout displayInfo=false displayWide=false displayMessage=true>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập MyApp</title>
    <#-- Thêm CSS từ file theme.properties nếu có -->
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
</head>
<body style="background:#0f0f0f; margin:0; font-family: system-ui; color: white;">
    <div style="max-width:420px; margin:40px auto; padding:20px; background: #1a1a1a; border-radius: 8px;">
        <h2 style="text-align: center;"><#nested "header"></h2>
        
        <#-- Hiển thị thông báo động -->
        <#if displayMessage && message?has_content>
            <div style="padding:12px; border-radius:4px; margin-bottom:16px; background: ${(message.type == 'error')?string('#cf6679', '#03dac6')}; color: #000;">
                <#if message.summary == "You should receive an email shortly with further instructions.">
            Một email hướng dẫn đã được gửi đến bạn!
        <#else>
            ${message.summary}
        </#if>
            </div>
        </#if>

        <#nested "form">
        
        <#if displayInfo>
            <div style="margin-top: 20px; font-size: 14px; color: #bbb;">
                <#nested "info">
            </div>
        </#if>
    </div>
</body>
</html>
</#macro>