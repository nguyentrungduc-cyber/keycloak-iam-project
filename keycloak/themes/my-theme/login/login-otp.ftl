<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        <#-- Ẩn header mặc định -->
    <#elseif section="form">
        <link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>

        <style>
            body { background-color: #1a1a1a; font-family: 'Inter', system-ui, sans-serif; }
            .kc-card {
                background-color: #242424; color: #ffffff; padding: 40px 32px; 
                border-radius: 12px; border: 1px solid #333; max-width: 400px; margin: 40px auto;
                text-align: center;
            }
            .kc-logo-icon {
                background: #2563eb; padding: 12px; border-radius: 50%; 
                display: inline-flex; align-items: center; justify-content: center; 
                margin-bottom: 20px; width: 48px; height: 48px;
            }
            .kc-title { font-size: 22px; font-weight: 600; color: #fff; margin-bottom: 8px; margin-top: 0; }
            .kc-subtitle { font-size: 14px; color: #888; margin-bottom: 24px; line-height: 1.5; }
            
            .kc-input-otp {
                width: 100%; box-sizing: border-box; padding: 16px; 
                background-color: #1f1f1f; border: 1px solid #444; 
                border-radius: 8px; color: white; margin-top: 8px; 
                outline: none; font-size: 28px; text-align: center;
                letter-spacing: 12px; font-weight: bold; font-family: monospace;
                transition: border-color 0.2s;
            }
            .kc-input-otp:focus { border-color: #60a5fa; box-shadow: 0 0 0 2px rgba(96, 165, 250, 0.2); }
            .kc-input-otp::placeholder { color: #555; letter-spacing: 12px; }
            
            .kc-btn-primary {
                width: 100%; padding: 14px; background: #2563eb; color: white; 
                border: none; border-radius: 8px; font-weight: 600; cursor: pointer; 
                margin-top: 24px; font-size: 15px; transition: background 0.2s;
            }
            .kc-btn-primary:hover { background: #1d4ed8; }
            
            .kc-error-message { color: #ef4444; font-size: 13px; margin-top: 12px; text-align: center; display: block; }
            
            .kc-credential-list { text-align: left; background: #1f1f1f; border: 1px solid #333; border-radius: 8px; padding: 12px; margin-bottom: 20px; }
            .kc-radio-item { display: flex; align-items: center; gap: 10px; margin-bottom: 10px; color: #ccc; cursor: pointer; font-size: 14px; }
            .kc-radio-item:last-child { margin-bottom: 0; }
            .kc-radio-item input[type="radio"] { accent-color: #2563eb; transform: scale(1.2); }
        </style>

        <div class="kc-card">
            <div class="kc-logo-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect>
                    <line x1="12" y1="18" x2="12.01" y2="18"></line>
                </svg>
            </div>
            
            <h1 class="kc-title">Xác thực 2 bước</h1>
            <p class="kc-subtitle">Vui lòng nhập mã 6 số từ ứng dụng xác thực trên điện thoại của bạn.</p>

            <form id="kc-otp-login-form" action="${url.loginAction}" method="post" onsubmit="login.disabled = true; return true;">
                
                <#-- Danh sách thiết bị nếu user có cài nhiều app auth -->
                <#if otpLogin.userOtpCredentials?size gt 1>
                    <div class="kc-credential-list">
                        <div style="font-size: 12px; color: #888; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 0.5px;">Thiết bị khả dụng:</div>
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <label class="kc-radio-item" for="kc-otp-credential-${otpCredential?index}">
                                <input id="kc-otp-credential-${otpCredential?index}" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                                <span>${otpCredential.userLabel}</span>
                            </label>
                        </#list>
                    </div>
                </#if>

                <div style="text-align: left;">
                    <input id="otp" name="otp" autocomplete="one-time-code" type="text" class="kc-input-otp"
                           autofocus placeholder="••••••" inputmode="numeric" pattern="[0-9]*" maxlength="6"
                           aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>" />
                    
                    <#if messagesPerField.existsError('totp')>
                        <span id="input-error-otp-code" class="kc-error-message" aria-live="polite">
                            Mã xác thực không chính xác. Vui lòng thử lại!
                        </span>
                    </#if>
                </div>

                <button class="kc-btn-primary" name="login" id="kc-login" type="submit">Xác nhận</button>
            </form>
            
            <div style="margin-top: 24px;">
                <a href="${url.loginUrl}" style="color: #666; text-decoration: none; font-size: 13px;">← Trở về trang đăng nhập</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>