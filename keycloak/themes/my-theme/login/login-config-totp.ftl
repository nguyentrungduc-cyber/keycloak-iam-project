<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

    <#if section = "header">
        Cài đặt Xác thực 2 lớp
    <#elseif section = "form">
        <style>
            .modern-setup-container { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; color: #e2e8f0; }
            .modern-step-box { background: #1e293b; border: 1px solid #334155; border-radius: 8px; padding: 16px 20px; margin-bottom: 1rem; }
            .modern-step-title { font-weight: 600; color: #fff; margin-top: 0; margin-bottom: 8px; font-size: 1.05rem; }
            .modern-step-desc { margin: 0; color: #cbd5e1; font-size: 0.95rem; line-height: 1.5; }
            .modern-qr-wrapper { background: #ffffff; padding: 12px; border-radius: 8px; display: inline-block; margin-top: 12px; }
            .modern-secret-code { font-family: 'Courier New', Courier, monospace; font-size: 1.1rem; font-weight: bold; color: #ef4444; background: #fee2e2; padding: 6px 12px; border-radius: 6px; letter-spacing: 2px; display: inline-block; margin-top: 8px; }
            .modern-link { color: #60a5fa; text-decoration: none; font-size: 0.9rem; margin-top: 12px; display: block; }
            .modern-link:hover { color: #93c5fd; text-decoration: underline; }
            .modern-input-group { margin-bottom: 1.2rem; }
            .modern-label { display: block; font-weight: 500; margin-bottom: 6px; color: #cbd5e1; font-size: 0.95rem; }
            .modern-input { width: 100%; padding: 10px 14px; background: #0f172a; border: 1px solid #334155; border-radius: 6px; color: #fff; font-size: 1rem; box-sizing: border-box; transition: border 0.2s; }
            .modern-input:focus { border-color: #3b82f6; outline: none; }
            .modern-btn { width: 100%; padding: 12px; background: #2563eb; color: #fff; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; margin-bottom: 8px; }
            .modern-btn-cancel { background: transparent; border: 1px solid #475569; color: #94a3b8; }
            .modern-btn-cancel:hover { background: #334155; color: #fff; }
        </style>

        <div class="modern-setup-container">
            
            <div class="modern-step-box">
                <h3 class="modern-step-title">Bước 1: Tải ứng dụng</h3>
                <p class="modern-step-desc">Tải <b>Google Authenticator</b> hoặc <b>Microsoft Authenticator</b> về điện thoại của bạn.</p>
            </div>

            <div class="modern-step-box" style="text-align: center;">
                <h3 class="modern-step-title" style="text-align: left;">Bước 2: Quét mã QR</h3>
                <p class="modern-step-desc" style="text-align: left;">Mở ứng dụng và quét mã QR dưới đây để liên kết tài khoản.</p>
                
                <#if mode?? && mode = "manual">
                    <p class="modern-step-desc" style="margin-top: 12px; text-align: left;">Nhập Khóa bí mật này vào ứng dụng:</p>
                    <div class="modern-secret-code" id="kc-totp-secret-key">${totp.totpSecretEncoded}</div>
                    <a href="${totp.qrUrl}" class="modern-link">&larr; Quay lại quét mã QR</a>
                <#else>
                    <div class="modern-qr-wrapper">
                        <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Mã QR Code" width="180">
                    </div>
                    <a href="${totp.manualUrl}" class="modern-link" id="mode-manual">Không quét được mã? (Thiết lập thủ công)</a>
                </#if>
            </div>

            <div class="modern-step-box">
                <h3 class="modern-step-title">Bước 3: Xác nhận mã</h3>
                
                <form action="${url.loginAction}" id="kc-totp-settings-form" method="post">
                    <div class="modern-input-group">
                        <label for="totp" class="modern-label">Mã xác thực (6 số từ ứng dụng) <span style="color:#ef4444">*</span></label>
                        <input type="text" id="totp" name="totp" autocomplete="one-time-code" class="modern-input" inputmode="numeric" placeholder="Ví dụ: 123456" />
                    </div>

                    <div class="modern-input-group">
                        <label for="userLabel" class="modern-label">Tên ghi nhớ thiết bị <span style="color:#ef4444">*</span></label>
                        <input type="text" id="userLabel" name="userLabel" autocomplete="off" class="modern-input" placeholder="Ví dụ: iPhone 14 Pro của tôi" />
                    </div>

                    <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                    <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>

                    <@passwordCommons.logoutOtherSessions/>

                    <div style="margin-top: 1.5rem;">
                        <input type="submit" class="modern-btn" id="saveTOTPBtn" value="Hoàn tất cài đặt" />
                        <#if isAppInitiatedAction??>
                            <button type="submit" class="modern-btn modern-btn-cancel" id="cancelTOTPBtn" name="cancel-aia" value="true">Hủy bỏ</button>
                        </#if>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>