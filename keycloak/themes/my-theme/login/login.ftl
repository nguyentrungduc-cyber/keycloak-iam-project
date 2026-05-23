<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true displayInfo=false; section>
    <#if section = "header">
    <#elseif section = "form">
        <style>
            .pwd-wrapper { position: relative; display: flex; align-items: center; width: 100%; }
            .pwd-wrapper input { padding-right: 40px !important; }
            .pwd-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #888; display: flex; }
            .pwd-toggle:hover { color: #ccc; }
        </style>

        <div class="kc-card">
            
            <div class="kc-header-inside">
                <div class="kc-logo">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="10" stroke="white" stroke-width="2"/>
                    </svg>
                </div>
                <div class="kc-title">Đăng nhập</div>
                <div class="kc-subtitle">MyApp — Powered by KeyCloak</div>
            </div>

            <form id="kc-form-login" action="${url.loginAction}" method="post">
                <div class="kc-form-group">
                    <label for="username">Email</label>
                    <input id="username" name="username" value="${(login.username!'')}" type="text" autofocus placeholder="nguyenvana@example.com" />
                </div>

                <div class="kc-form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="pwd-wrapper">
                        <input id="password" name="password" type="password" placeholder="••••••••••" />
                        <span class="pwd-toggle" onclick="togglePassword('password', 'eye-icon-login')">
                            <svg id="eye-icon-login" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
                            </svg>
                        </span>
                    </div>
                    
                    <#if realm.resetPasswordAllowed>
                        <div class="kc-forgot-password-wrapper">
                            <a href="${url.loginResetCredentialsUrl}">Quên mật khẩu?</a>
                        </div>
                    </#if>
                </div>

                <button class="kc-btn-primary" name="login" id="kc-login" type="submit">Đăng nhập</button>
            </form>

            <#-- Đường kẻ ngang phân cách -->
            <div class="kc-divider" style="text-align: center; margin: 20px 0;">
                <span style="color: #666; font-size: 14px;">hoặc tiếp tục với</span>
            </div>
            
            <#-- Khu vực hiện nút mạng xã hội -->
            <#if realm.password && social.providers??>
                <div class="kc-social-providers" style="display: flex; flex-direction: column; gap: 10px;">
                    <#list social.providers as p>
                        <a href="${p.loginUrl}" id="social-${p.alias}" class="kc-btn-social" style="display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #555; border-radius: 5px; text-decoration: none; color: #ffffff; font-weight: bold; background-color: transparent;">
                            <#if p.alias == "google">
                                <svg height="20" width="20" viewBox="0 0 48 48" style="margin-right: 8px; flex-shrink: 0;" aria-hidden="true">
                                    <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
                                    <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
                                    <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
                                    <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
                                </svg>
                                Đăng nhập bằng Google
                            <#elseif p.alias == "github">
                                <svg height="20" width="20" viewBox="0 0 16 16" style="fill: #ffffff; margin-right: 8px; flex-shrink: 0;" version="1.1" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path>
                                </svg>
                                Đăng nhập bằng GitHub
                            <#else>
                                ${p.displayName!}
                            </#if>
                        </a>
                    </#list>
                </div>
            </#if>

            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div class="kc-footer" style="text-align: center; margin-top: 20px; font-size: 14px;">
                    Chưa có tài khoản? <a href="${url.registrationUrl}" style="color: #2563eb; text-decoration: none; font-weight: bold;">Đăng ký ngay</a>
                </div>
            </#if>
        </div>

        <script>
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