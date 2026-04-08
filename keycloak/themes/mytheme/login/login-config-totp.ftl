<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

    <#if section = "header">
        Thiết lập Google Authenticator

    <#elseif section = "form">
    <style>
        .totp-setup { text-align: center; padding: 10px 0; }
        .totp-icon-wrap {
            display: inline-flex; align-items: center; justify-content: center;
            width: 56px; height: 56px;
            background: rgba(99,102,241,0.12);
            border-radius: 16px; margin-bottom: 16px;
        }
        .totp-title { font-size: 20px; font-weight: 600; color: #f1f5f9; margin-bottom: 6px; }
        .totp-sub { font-size: 13px; color: #888; margin-bottom: 24px; line-height: 1.5; }

        .totp-steps { text-align: left; margin-bottom: 24px; }
        .step-item {
            display: flex; align-items: flex-start; gap: 12px;
            background: #1e1e2e; border: 1px solid #2d3148;
            border-radius: 10px; padding: 12px 14px; margin-bottom: 10px;
        }
        .step-num {
            width: 24px; height: 24px; border-radius: 50%;
            background: #6366f1; color: white;
            font-size: 12px; font-weight: 700;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0; margin-top: 1px;
        }
        .step-text { font-size: 13px; color: #cbd5e1; line-height: 1.5; }
        .step-text strong { color: #f1f5f9; }
        .step-text a { color: #6366f1; text-decoration: none; }

        .qr-wrap {
            background: white; border-radius: 12px;
            padding: 14px; display: inline-block; margin: 12px 0 20px;
        }

        .secret-key {
            background: #1e1e2e; border: 1px solid #2d3148;
            border-radius: 8px; padding: 10px 14px;
            font-family: monospace; font-size: 14px;
            color: #a5b4fc; letter-spacing: 2px;
            text-align: center; margin-bottom: 20px;
            word-break: break-all;
        }

        .totp-input-group { display: flex; gap: 8px; justify-content: center; margin-bottom: 16px; }
        .otp-field {
            width: 45px; height: 55px;
            background: #262626; border: 1px solid #444;
            border-radius: 8px; color: #fff;
            font-size: 24px; font-weight: bold;
            text-align: center; outline: none;
            transition: border-color 0.2s;
        }
        .otp-field:focus { border-color: #6366f1; box-shadow: 0 0 0 2px rgba(99,102,241,0.2); }
        input[type="hidden"]#totp { display: none; }

        .label-input { font-size: 13px; color: #94a3b8; margin-bottom: 6px; text-align: left; }
        .device-input {
            width: 100%; height: 40px;
            background: #1a1a2e; border: 1px solid #2d3148;
            border-radius: 8px; padding: 0 12px;
            color: #e2e8f0; font-size: 13px; outline: none;
            margin-bottom: 16px;
        }
        .device-input:focus { border-color: #6366f1; }

        .btn-submit {
            width: 100%; height: 42px;
            background: #6366f1; border: none;
            border-radius: 8px; color: white;
            font-size: 14px; font-weight: 500;
            cursor: pointer; transition: background 0.2s;
        }
        .btn-submit:hover { background: #5558e3; }

        .error-msg { color: #f87171; font-size: 12px; margin-top: 4px; text-align: left; }
    </style>

    <div class="totp-setup">
        <div class="totp-icon-wrap">
            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24"
                 fill="none" stroke="#6366f1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
            </svg>
        </div>
        <div class="totp-title">Thiết lập xác thực 2 bước</div>
        <div class="totp-sub">Quét mã QR bằng Google Authenticator để bảo vệ tài khoản của bạn.</div>
    </div>

    <div class="totp-steps">
        <div class="step-item">
            <div class="step-num">1</div>
            <div class="step-text">
                Tải <strong>Google Authenticator</strong> trên
                <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2" target="_blank">Android</a>
                hoặc
                <a href="https://apps.apple.com/app/google-authenticator/id388497605" target="_blank">iPhone</a>
            </div>
        </div>
        <div class="step-item">
            <div class="step-num">2</div>
            <div class="step-text">Mở app → bấm dấu <strong>+</strong> → chọn <strong>Quét mã QR</strong></div>
        </div>
        <div class="step-item">
            <div class="step-num">3</div>
            <div class="step-text">Quét mã QR bên dưới, sau đó nhập mã 6 chữ số vào ô xác nhận</div>
        </div>
    </div>

    <#-- QR Code -->
    <div style="text-align:center;">
        <div class="qr-wrap">
            <img src="data:image/png;base64, ${totp.totpSecretQrCode}" width="160" height="160" alt="QR Code"/>
        </div>
    </div>

    <#-- Hoặc nhập thủ công -->
    <div style="text-align:center; margin-bottom:6px;">
        <span style="font-size:12px; color:#666;">Không quét được? Nhập mã thủ công:</span>
    </div>
    <div class="secret-key">${totp.totpSecretEncoded}</div>

    <form id="kc-totp-settings-form" action="${url.loginAction}" method="post">

        <#-- Mã xác nhận OTP -->
        <div class="totp-input-group">
            <input type="text" class="otp-field" maxlength="1" pattern="\d*" autocomplete="off">
            <input type="text" class="otp-field" maxlength="1" pattern="\d*" autocomplete="off">
            <input type="text" class="otp-field" maxlength="1" pattern="\d*" autocomplete="off">
            <input type="text" class="otp-field" maxlength="1" pattern="\d*" autocomplete="off">
            <input type="text" class="otp-field" maxlength="1" pattern="\d*" autocomplete="off">
            <input type="text" class="otp-field" maxlength="1" pattern="\d*" autocomplete="off">
        </div>
        <input type="hidden" id="totp" name="totp"/>

        <#if messagesPerField.existsError('totp')>
            <div class="error-msg">${messagesPerField.get('totp')}</div>
        </#if>

        <#-- Tên thiết bị (tùy chọn) -->
        <div class="label-input">Tên thiết bị (tùy chọn)</div>
        <input type="text" id="userLabel" name="userLabel"
               class="device-input"
               value="${(totp.userLabel!'')}"
               placeholder="Ví dụ: Điện thoại cá nhân"/>

        <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}"/>
        <#if mode??>
            <input type="hidden" id="mode" name="mode" value="${mode}"/>
        </#if>

        <button type="submit" class="btn-submit">Xác nhận và hoàn tất</button>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const inputs = document.querySelectorAll('.otp-field');
            const hidden = document.getElementById('totp');

            inputs.forEach((inp, i) => {
                inp.addEventListener('input', e => {
                    e.target.value = e.target.value.replace(/[^0-9]/g, '');
                    if (e.target.value && i < inputs.length - 1) inputs[i+1].focus();
                    hidden.value = Array.from(inputs).map(x => x.value).join('');
                });
                inp.addEventListener('keydown', e => {
                    if (e.key === 'Backspace' && !e.target.value && i > 0) inputs[i-1].focus();
                });
            });
        });
    </script>
    </#if>

</@layout.registrationLayout>
