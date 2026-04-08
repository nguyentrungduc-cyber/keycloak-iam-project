<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#-- Để trống để tự custom header bên dưới -->
    <#elseif section = "form">
        <link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>
        
        <style>
            .kc-totp-container { text-align: center; padding: 10px 0; }
            
            /* Icon bảo mật */
            .kc-totp-icon-wrap {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 56px;
                height: 56px;
                background: rgba(79, 70, 229, 0.1);
                border-radius: 16px;
                margin-bottom: 20px;
            }
            
            .kc-title { font-size: 22px; font-weight: 600; color: #fff; margin-bottom: 8px; }
            .kc-subtitle { font-size: 14px; color: #888; margin-bottom: 24px; line-height: 1.5; }

            /* Ô nhập OTP */
            .otp-input-group { display: flex; gap: 8px; justify-content: center; margin-bottom: 24px; }
            .otp-field {
                width: 45px;
                height: 55px;
                background: #262626;
                border: 1px solid #444;
                border-radius: 8px;
                color: #fff;
                font-size: 24px;
                font-weight: bold;
                text-align: center;
                outline: none;
                transition: border-color 0.2s;
            }
            .otp-field:focus { border-color: #6366f1; box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.2); }

            .kc-btn-primary { 
                width: 100%; padding: 12px; background: #262626; border: 1px solid #444; 
                border-radius: 8px; color: #fff; font-weight: 500; cursor: pointer; margin-bottom: 16px;
            }
            .kc-btn-primary:hover { background: #333; }

            .otp-timer { font-size: 13px; color: #666; }
            #timer-count { color: #6366f1; font-weight: 600; }
        </style>

        <div class="kc-totp-container">
            <div class="kc-totp-icon-wrap">
                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#6366f1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                </svg>
            </div>

            <h1 class="kc-title">Xác thực 2 bước</h1>
            <p class="kc-subtitle">Vui lòng nhập mã xác thực từ ứng dụng <strong>Google Authenticator</strong> của bạn.</p>

            <form id="kc-totp-login-form" action="${url.loginAction}" method="post">
                <#-- Các ô nhập giả lập để người dùng gõ cho đẹp -->
                <div class="otp-input-group">
                    <input type="text" class="otp-field" maxlength="1" pattern="\d*">
                    <input type="text" class="otp-field" maxlength="1" pattern="\d*">
                    <input type="text" class="otp-field" maxlength="1" pattern="\d*">
                    <input type="text" class="otp-field" maxlength="1" pattern="\d*">
                    <input type="text" class="otp-field" maxlength="1" pattern="\d*">
                    <input type="text" class="otp-field" maxlength="1" pattern="\d*">
                </div>

                <#-- Input ẩn thực tế để gửi lên Keycloak -->
                <input type="hidden" id="totp" name="totp" />

                <button type="submit" class="kc-btn-primary">Xác nhận</button>
                
                <div class="otp-timer">
                    Mã mới sẽ hiển thị sau: <span id="timer-count">00:30</span>
                </div>
            </form>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const inputs = document.querySelectorAll('.otp-field');
                const hiddenInput = document.getElementById('totp');

                inputs.forEach((input, index) => {
                    input.addEventListener('input', (e) => {
                        e.target.value = e.target.value.replace(/[^0-9]/g, '');
                        if (e.target.value && index < inputs.length - 1) {
                            inputs[index + 1].focus();
                        }
                        updateHiddenValue();
                    });

                    input.addEventListener('keydown', (e) => {
                        if (e.key === 'Backspace' && !e.target.value && index > 0) {
                            inputs[index - 1].focus();
                        }
                    });
                });

                function updateHiddenValue() {
                    hiddenInput.value = Array.from(inputs).map(i => i.value).join('');
                }

                // Bộ đếm ngược trang trí
                let timeLeft = 30;
                setInterval(() => {
                    timeLeft--;
                    if (timeLeft < 0) timeLeft = 30;
                    document.getElementById('timer-count').textContent = "00:" + (timeLeft < 10 ? "0" + timeLeft : timeLeft);
                }, 1000);
            });
        </script>
    </#if>
</@layout.registrationLayout>