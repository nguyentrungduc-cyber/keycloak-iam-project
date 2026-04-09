<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>

<#if section = "header">
    <#-- Để trống để dùng header custom bên dưới -->
<#elseif section = "form">
<link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>

<style>
    body { background-color: #1a1a1a; font-family: 'Inter', system-ui, sans-serif; }
    .kc-card {
        background-color: #242424; color: #ffffff; padding: 40px 32px; 
        border-radius: 12px; border: 1px solid #333; 
        max-width: 400px; margin: 40px auto;
    }
    .kc-logo-wrapper {
        width: 48px; height: 48px; background-color: #1e3a8a; 
        border-radius: 12px; display: inline-flex; align-items: center; 
        justify-content: center; margin-bottom: 20px;
    }
    .kc-steps { display: flex; justify-content: center; gap: 8px; margin-bottom: 24px; }
    .kc-step-dot { width: 8px; height: 8px; border-radius: 50%; background: #444; }
    .kc-step-dot.active { background: #6366f1; box-shadow: 0 0 8px #6366f1; }
    
    .kc-input {
        width: 100%; box-sizing: border-box; padding: 12px 14px; 
        background-color: #1f1f1f; border: 1px solid #444; 
        border-radius: 8px; color: white; margin-top: 8px; outline: none;
    }
    .kc-input:focus { border-color: #6366f1; }
    
    .kc-btn-primary {
        width: 100%; padding: 12px; background-color: #6366f1; color: white; 
        border: none; border-radius: 8px; font-weight: 600; cursor: pointer; margin-top: 10px;
    }
    .kc-alert-info {
        background: rgba(99, 102, 241, 0.1); border: 0.5px solid #6366f1;
        color: #a5b4fc; padding: 12px; border-radius: 8px; font-size: 13px; margin-bottom: 20px;
    }
</style>

<div class="kc-card">
    <div style="text-align: center;">
        <div class="kc-logo-wrapper">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                <circle cx="12" cy="12" r="8" stroke="white" stroke-width="2"/>
                <circle cx="12" cy="12" r="2.5" fill="white"/>
            </svg>
        </div>
        <h1 style="font-size: 22px; margin: 0 0 8px 0;">Quên mật khẩu? </h1>
        <p style="color: #888; font-size: 14px; margin-bottom: 24px;">Nhập email để nhận link đặt lại </p>
    </div>

    <div class="kc-steps">
        <div class="kc-step-dot active"></div>
        <div class="kc-step-dot"></div>
        <div class="kc-step-dot"></div>
    </div>

    <#if message?has_content && message.type = 'error'>
        <div style="color: #ef4444; font-size: 13px; margin-bottom: 16px; text-align: center;">
            ${kcSanitize(message.summary)?no_esc}
        </div>
    </#if>

    <form action="${url.loginAction}" method="post">
        <div style="margin-bottom: 20px;">
            <label style="font-size: 14px; color: #ccc;">Email tài khoản </label>
            <input type="text" id="username" name="username" class="kc-input" 
                   [cite_start]autofocus placeholder="nguyenvana@example.com" value="${(auth.attemptedUsername!'')}"/>
            <#if messagesPerField.existsError('username')>
                <div style="color: #ef4444; font-size: 12px; margin-top: 6px;">
                    ${kcSanitize(messagesPerField.get('username'))?no_esc} 
                </div>
            </#if>
        </div>

        <div class="kc-alert-info">
            Chúng tôi sẽ gửi email chứa link đặt lại. Link có hiệu lực trong <strong>15 phút</strong>. 
        </div>

        <button type="submit" class="kc-btn-primary">Gửi link đặt lại</button>
    </form>

    <div style="text-align: center; margin-top: 24px;">
        <a href="${url.loginUrl}" style="color: #888; text-decoration: none; font-size: 14px;">← Quay lại đăng nhập</a>
    </div>
</div>

<#elseif section = "info">
    <#if message?has_content>
        <div style="background: rgba(74, 222, 128, 0.1); border: 0.5px solid #4ade80; color: #4ade80; padding: 16px; border-radius: 8px; text-align: center; max-width: 400px; margin: 20px auto;">
            ${kcSanitize(message.summary)?no_esc}
        </div>
    </#if>
</#if>
</@layout.registrationLayout>
