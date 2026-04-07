<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm') ; section>

<#if section = "header">
    ${msg("updatePasswordTitle")}

<#elseif section = "form">
<link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>

<div class="kc-header">
    <div class="kc-logo">
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none">
            <rect x="5" y="11" width="14" height="10" rx="2" stroke="white" stroke-width="2"/>
            <path d="M8 11V7a4 4 0 0 1 8 0v4" stroke="white" stroke-width="2" stroke-linecap="round"/>
        </svg>
    </div>
    <div class="kc-title">Đặt mật khẩu mới</div>
    <div class="kc-subtitle">Nhập mật khẩu mới cho tài khoản của bạn</div>
</div>

<#-- Step indicator: bước 3 / 3 -->
<div class="kc-steps">
    <div class="kc-step-dot active"></div>
    <div class="kc-step-dot active"></div>
    <div class="kc-step-dot active"></div>
</div>

<#-- Lỗi chung -->
<#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
    <div class="kc-alert kc-alert-${message.type}">
        ${kcSanitize(message.summary)?no_esc}
    </div>
</#if>

<form id="kc-passwd-update-form" action="${url.loginAction}" method="post">

    <input type="text" id="username" name="username"
           value="${username}"
           autocomplete="username"
           style="display:none;" readonly/>

    <div class="kc-form-group">
        <label for="password-new">Mật khẩu mới</label>
        <input type="password" id="password-new" name="password-new"
               placeholder="••••••••"
               autofocus
               autocomplete="new-password"
               oninput="checkStrength(this.value)"
               aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"/>
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
        <label for="password-confirm">Xác nhận mật khẩu mới</label>
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

    <#-- Gợi ý yêu cầu mật khẩu -->
    <div style="background:#1a1a1a;border:0.5px solid #333;border-radius:8px;padding:12px 14px;margin-bottom:14px;font-size:12px;color:#666;">
        <div style="color:#888;margin-bottom:6px;font-weight:500;">Yêu cầu mật khẩu:</div>
        <div id="req-length"  style="margin-bottom:3px;">○ Ít nhất 8 ký tự</div>
        <div id="req-upper"   style="margin-bottom:3px;">○ Có chữ hoa (A–Z)</div>
        <div id="req-number"  style="margin-bottom:3px;">○ Có chữ số (0–9)</div>
        <div id="req-special">○ Có ký tự đặc biệt (!@#...)</div>
    </div>

    <#if isAppInitiatedAction??>
    <div style="display:flex;gap:10px;margin-top:4px;">
        <button type="submit" class="kc-btn-primary" name="login-actions-main-button" id="do-submit" value="${action}">
            Xác nhận đặt lại
        </button>
        <button type="submit" class="kc-btn-primary"
                style="background:transparent;border:0.5px solid #444;color:#888;font-weight:400;"
                name="login-actions-main-button" value="cancel">
            Hủy
        </button>
    </div>
    <#else>
    <button type="submit" class="kc-btn-primary">Xác nhận đặt lại</button>
    </#if>

</form>

<div class="kc-powered">Powered by Keycloak · Bảo mật cấp doanh nghiệp</div>

<script>
function checkStrength(val) {
    const fill  = document.getElementById('strength-fill');
    const text  = document.getElementById('strength-text');
    const reqs  = {
        length:  { el: document.getElementById('req-length'),  ok: val.length >= 8 },
        upper:   { el: document.getElementById('req-upper'),   ok: /[A-Z]/.test(val) },
        number:  { el: document.getElementById('req-number'),  ok: /[0-9]/.test(val) },
        special: { el: document.getElementById('req-special'), ok: /[^A-Za-z0-9]/.test(val) },
    };
    let score = 0;
    for (const key in reqs) {
        const r = reqs[key];
        if (r.ok) { score++; r.el.textContent = '✓ ' + r.el.textContent.slice(2); r.el.style.color = '#4ade80'; }
        else       { r.el.textContent = '○ ' + r.el.textContent.slice(2); r.el.style.color = '#666'; }
    }
    const levels = [
        { w:'0%',   c:'#333',    t:'' },
        { w:'25%',  c:'#ef4444', t:'Yếu' },
        { w:'50%',  c:'#f97316', t:'Trung bình' },
        { w:'75%',  c:'#eab308', t:'Khá' },
        { w:'100%', c:'#4ade80', t:'Mạnh' },
    ];
    const lv = levels[score];
    if (fill) { fill.style.width = lv.w; fill.style.background = lv.c; }
    if (text) { text.textContent = lv.t; text.style.color = lv.c; }
}
</script>

</#if>
</@layout.registrationLayout>
