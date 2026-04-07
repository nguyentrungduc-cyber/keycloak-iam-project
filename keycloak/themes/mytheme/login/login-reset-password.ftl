<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username') ; section>

<#if section = "header">
    ${msg("emailForgotTitle")}

<#elseif section = "form">
<link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>

<div class="kc-header">
    <div class="kc-logo">
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none">
            <circle cx="12" cy="12" r="8" stroke="white" stroke-width="2"/>
            <circle cx="12" cy="12" r="2.5" fill="white"/>
        </svg>
    </div>
    <div class="kc-title">Quên mật khẩu?</div>
    <div class="kc-subtitle">Nhập email để nhận link đặt lại</div>
</div>

<#-- Step indicator: bước 1 / 3 -->
<div class="kc-steps">
    <div class="kc-step-dot active"></div>
    <div class="kc-step-dot"></div>
    <div class="kc-step-dot"></div>
</div>

<#-- Thông báo lỗi -->
<#if message?has_content && message.type = 'error'>
    <div class="kc-alert kc-alert-error">
        ${kcSanitize(message.summary)?no_esc}
    </div>
</#if>

<form id="kc-reset-password-form" action="${url.loginAction}" method="post">

    <div class="kc-form-group">
        <label for="username">
            <#if !realm.loginWithEmailAllowed>
                ${msg("username")}
            <#elseif !realm.registrationEmailAsUsername>
                ${msg("usernameOrEmail")}
            <#else>
                Email tài khoản
            </#if>
        </label>
        <input type="text" id="username" name="username"
               autofocus
               value="${(auth.attemptedUsername!'')}"
               placeholder="nguyenvana@example.com"
               autocomplete="email"
               aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
        <#if messagesPerField.existsError('username')>
            <div class="kc-alert kc-alert-error" style="margin-top:6px;">
                ${kcSanitize(messagesPerField.get('username'))?no_esc}
            </div>
        </#if>
    </div>

    <div class="kc-alert kc-alert-info" style="margin-bottom:14px;">
        Chúng tôi sẽ gửi email chứa link đặt lại mật khẩu. Link có hiệu lực trong <strong>15 phút</strong>.
    </div>

    <button type="submit" class="kc-btn-primary">
        Gửi link đặt lại
    </button>

</form>

<div class="kc-footer">
    <a href="${url.loginUrl}">← Quay lại đăng nhập</a>
</div>

<div class="kc-powered">Powered by Keycloak · Bảo mật cấp doanh nghiệp</div>

<#elseif section = "info">
    <#-- Thông báo sau khi gửi email thành công (Keycloak tự hiện) -->
    <#if message?has_content>
        <div class="kc-alert kc-alert-success">
            ${kcSanitize(message.summary)?no_esc}
        </div>
    </#if>
</#if>

</@layout.registrationLayout>
