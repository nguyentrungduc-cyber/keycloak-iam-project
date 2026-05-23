<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>

<#if section = "header">
<#elseif section = "form">
<link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>

<style>
    body { background-color: #1a1a1a; font-family: 'Inter', system-ui, sans-serif; }
    .kc-card { background-color: #242424; color: #ffffff; padding: 40px 32px; border-radius: 12px; border: 1px solid #333; max-width: 400px; margin: 40px auto; }
    .kc-steps { display: flex; justify-content: center; gap: 8px; margin-bottom: 24px; }
    .kc-step-dot { width: 8px; height: 8px; border-radius: 50%; background: #6366f1; box-shadow: 0 0 8px #6366f1; }

    .kc-input { width: 100%; box-sizing: border-box; padding: 12px 14px; background-color: #1f1f1f; border: 1px solid #444; border-radius: 8px; color: white; margin-top: 8px; outline: none; }
    .kc-strength-bar { height: 4px; background: #333; border-radius: 2px; margin: 12px 0 6px; overflow: hidden; }
    .kc-strength-fill { height: 100%; width: 0%; transition: all 0.3s; }
    
    .kc-requirement-box { background: #1a1a1a; border: 0.5px solid #333; border-radius: 8px; padding: 12px; margin-bottom: 20px; font-size: 12px; color: #666; }
    .req-item { margin-bottom: 4px; display: flex; align-items: center; gap: 6px; }

    /* CSS cho con mắt mật khẩu */
    .pwd-wrapper { position: relative; display: flex; align-items: center; width: 100%; }
    .pwd-wrapper input { padding-right: 40px !important; }
    .pwd-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(20%); cursor: pointer; color: #888; display: flex; }
    .pwd-toggle:hover { color: #ccc; }
</style>

<div class="kc-card">
    <div style="text-align: center; margin-bottom: 24px;">
        <h1 style="font-size: 22px; margin: 0 0 8px 0;">Đặt mật khẩu mới </h1>
        <p style="color: #888; font-size: 14px;">Nhập mật khẩu mới cho tài khoản của bạn </p>
    </div>

    <div class="kc-steps">
        <div class="kc-step-dot"></div>
        <div class="kc-step-dot"></div>
        <div class="kc-step-dot"></div>
    </div>

    <form action="${url.loginAction}" method="post">
        <input type="text" name="username" value="${username}" style="display:none;" readonly/> 

        <div style="margin-bottom: 16px;">
            <label style="font-size: 14px; color: #ccc;">Mật khẩu mới</label>
            <div class="pwd-wrapper">
                <input type="password" id="password-new" name="password-new" class="kc-input" placeholder="••••••••" autofocus oninput="checkStrength(this.value)" />
                <span class="pwd-toggle" onclick="togglePassword('password-new', 'eye-icon-upd1')">
                    <svg id="eye-icon-upd1" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" /></svg>
                </span>
            </div>
            <div class="kc-strength-bar"><div id="strength-fill" class="kc-strength-fill"></div></div>
            <div id="strength-text" style="font-size: 11px; text-align: right; height: 14px;"></div>
        </div>

        <div style="margin-bottom: 16px;">
            <label style="font-size: 14px; color: #ccc;">Xác nhận mật khẩu</label>
            <div class="pwd-wrapper">
                <input type="password" id="password-confirm" name="password-confirm" class="kc-input" placeholder="••••••••" />
                <span class="pwd-toggle" onclick="togglePassword('password-confirm', 'eye-icon-upd2')">
                    <svg id="eye-icon-upd2" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" /></svg>
                </span>
            </div>
        </div>

        <div class="kc-requirement-box">
            <div style="color: #888; margin-bottom: 8px; font-weight: 500;">Yêu cầu mật khẩu: </div>
            <div id="req-length" class="req-item">○ Ít nhất 8 ký tự </div>
            <div id="req-upper" class="req-item">○ Có chữ hoa (A–Z) </div>
            <div id="req-number" class="req-item">○ Có chữ số (0–9) </div>
            <div id="req-special" class="req-item">○ Có ký tự đặc biệt (!@#...) </div>
        </div>

        <button type="submit" style="width: 100%; padding: 12px; background: #6366f1; color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;">
            Xác nhận đặt lại
        </button>
    </form>
</div>

<script>
function checkStrength(val) {
    const fill = document.getElementById('strength-fill');
    const text = document.getElementById('strength-text'); 
    const reqs = {
        length: { el: document.getElementById('req-length'), ok: val.length >= 8 },
        upper: { el: document.getElementById('req-upper'), ok: /[A-Z]/.test(val) },
        number: { el: document.getElementById('req-number'), ok: /[0-9]/.test(val) },
        special: { el: document.getElementById('req-special'), ok: /[^A-Za-z0-9]/.test(val) }
    };
    
    let score = 0;
    for (const key in reqs) {
        const r = reqs[key]; 
        if (r.ok) { 
            score++; 
            r.el.innerHTML = '<span style="color:#4ade80">✓</span> ' + r.el.textContent.slice(2);
            r.el.style.color = '#4ade80'; 
        } else {
            r.el.innerHTML = '○ ' + r.el.textContent.slice(2);
            r.el.style.color = '#666';
        }
    }
    
    const levels = [
        { w:'0%', c:'#333', t:'' },
        { w:'25%', c:'#ef4444', t:'Yếu' },
        { w:'50%', c:'#f97316', t:'Trung bình' },
        { w:'75%', c:'#eab308', t:'Khá' },
        { w:'100%', c:'#4ade80', t:'Mạnh' }
    ];
    const lv = levels[score]; 
    fill.style.width = lv.w; fill.style.background = lv.c; 
    text.textContent = lv.t; text.style.color = lv.c;
}

function togglePassword(inputId, iconId) {
    var input = document.getElementById(inputId);
    var icon = document.getElementById(iconId);
    if (input.type === "password") {
        input.type = "text";
        icon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />';
    } else {
        input.type = "password";
        icon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />';
    }
}
</script>
</#if>
</@layout.registrationLayout>