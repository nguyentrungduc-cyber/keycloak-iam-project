<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm') ; section>

<#if section = "header">
    ${msg("registerTitle")}

<#elseif section = "form">
<link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>

<div class="kc-header">
    <div class="kc-logo">
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none">
            <circle cx="12" cy="12" r="8" stroke="white" stroke-width="2"/>
            <circle cx="12" cy="12" r="2.5" fill="white"/>
        </svg>
    </div>
    <div class="kc-title">Tạo tài khoản</div>
    <div class="kc-subtitle">${realm.displayName} — Powered by KeyCloak</div>
</div>

<#-- Hiển thị lỗi chung nếu có -->
<#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
    <div class="kc-alert kc-alert-${message.type}">
        ${kcSanitize(message.summary)?no_esc}
    </div>
</#if>

<form id="kc-register-form" action="${url.registrationAction}" method="post">

    <#-- Họ & Tên -->
    <div class="kc-form-group">
        <div class="input-row">
            <div>
                <label for="firstName">Họ</label>
                <input type="text" id="firstName" name="firstName"
                       value="${(register.formData.firstName!'')}"
                       placeholder="Nguyễn"
                       autocomplete="given-name"
                       aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"/>
                <#if messagesPerField.existsError('firstName')>
                    <div class="kc-alert kc-alert-error" style="margin-top:6px;padding:6px 10px;">
                        ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                    </div>
                </#if>
            </div>
            <div>
                <label for="lastName">Tên</label>
                <input type="text" id="lastName" name="lastName"
                       value="${(register.formData.lastName!'')}"
                       placeholder="Văn A"
                       autocomplete="family-name"
                       aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"/>
                <#if messagesPerField.existsError('lastName')>
                    <div class="kc-alert kc-alert-error" style="margin-top:6px;padding:6px 10px;">
                        ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                    </div>
                </#if>
            </div>
        </div>
    </div>

    <#-- Email -->
    <div class="kc-form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email"
               value="${(register.formData.email!'')}"
               placeholder="nguyenvana@example.com"
               autocomplete="email"
               aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"/>
        <#if messagesPerField.existsError('email')>
            <div class="kc-alert kc-alert-error" style="margin-top:6px;">
                ${kcSanitize(messagesPerField.get('email'))?no_esc}
            </div>
        </#if>
    </div>

    <#-- Username (ẩn nếu dùng email làm username) -->
    <#if !realm.registrationEmailAsUsername>
    <div class="kc-form-group">
        <label for="username">${msg("username")}</label>
        <input type="text" id="username" name="username"
               value="${(register.formData.username!'')}"
               autocomplete="username"
               aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
        <#if messagesPerField.existsError('username')>
            <div class="kc-alert kc-alert-error" style="margin-top:6px;">
                ${kcSanitize(messagesPerField.get('username'))?no_esc}
            </div>
        </#if>
    </div>
    </#if>

    <#-- Mật khẩu -->
    <#if passwordRequired??>
    <div class="kc-form-group">
        <label for="password">Mật khẩu</label>
        <input type="password" id="password" name="password"
               placeholder="••••••••"
               autocomplete="new-password"
               oninput="checkStrength(this.value)"
               aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"/>
        <div class="kc-strength-wrap">
            <div class="kc-strength-bar">
                <div class="kc-strength-fill" id="strength-fill"></div>
            </div>
            <span class="kc-strength-text" id="strength-text"></span>
        </div>
        <#if messagesPerField.existsError('password')>
            <div class="kc-alert kc-alert-error" style="margin-top:6px;">
                ${kcSanitize(messagesPerField.get('password'))?no_esc}
            </div>
        </#if>
    </div>

    <div class="kc-form-group">
        <label for="password-confirm">Xác nhận mật khẩu</label>
        <input type="password" id="password-confirm" name="password-confirm"
               placeholder="••••••••"
               autocomplete="new-password"
               aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"/>
        <#if messagesPerField.existsError('password-confirm')>
            <div class="kc-alert kc-alert-error" style="margin-top:6px;">
                ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
            </div>
        </#if>
    </div>
    </#if>

    <#-- reCAPTCHA nếu được bật -->
    <#if recaptchaRequired??>
    <div class="kc-form-group" style="margin-top:4px;">
        <div class="g-recaptcha" data-size="normal" data-sitekey="${recaptchaSiteKey}"></div>
    </div>
    </#if>

    <input type="hidden" id="id-hidden-input" name="credentialId" />

    <button type="submit" class="kc-btn-primary">Đăng ký</button>

</form>

<#-- Social login (Identity Providers) -->
<#if social.providers??>
<div class="kc-divider"><span>hoặc tiếp tục với</span></div>
<div style="display:flex;flex-direction:column;gap:8px;">
    <#list social.providers as p>
        <a href="${p.loginUrl}" class="kc-btn-social">
            <#if p.alias == "google">
                <svg width="16" height="16" viewBox="0 0 24 24">
                    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"/>
                    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                </svg>
            <#elseif p.alias == "github">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="#aaa">
                    <path d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                </svg>
            <#else>
                <span style="width:16px;height:16px;background:#555;border-radius:50%;display:inline-block;"></span>
            </#if>
            Đăng ký bằng ${p.displayName}
        </a>
    </#list>
</div>
</#if>

<div class="kc-footer">
    Đã có tài khoản? <a href="${url.loginUrl}">Đăng nhập</a>
</div>

<div class="kc-powered">Powered by Keycloak · Bảo mật cấp doanh nghiệp</div>

<script>
function checkStrength(val) {
    const fill = document.getElementById('strength-fill');
    const text = document.getElementById('strength-text');
    if (!fill || !text) return;
    let score = 0;
    if (val.length >= 8)  score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;
    const levels = [
        { w: '0%',   c: '#ef4444', t: '' },
        { w: '25%',  c: '#ef4444', t: 'Yếu' },
        { w: '50%',  c: '#f97316', t: 'Trung bình' },
        { w: '75%',  c: '#eab308', t: 'Khá' },
        { w: '100%', c: '#4ade80', t: 'Mạnh' },
    ];
    const lv = levels[score] || levels[0];
    fill.style.width = lv.w;
    fill.style.background = lv.c;
    text.textContent = lv.t;
    text.style.color = lv.c;
}
</script>

</#if>
</@layout.registrationLayout>
