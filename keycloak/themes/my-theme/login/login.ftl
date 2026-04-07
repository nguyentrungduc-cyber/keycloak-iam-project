<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true displayInfo=false; section>
    <#if section = "header">
        <#elseif section = "form">
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
                    <input id="password" name="password" type="password" placeholder="••••••••••" />
                </div>

                <button class="kc-btn-primary" name="login" id="kc-login" type="submit">Đăng nhập</button>
            </form>

            <div class="kc-divider"><span>hoặc tiếp tục với</span></div>
            <div class="kc-social-providers">
                <a href="#" class="kc-btn-social">
                    <span style="color: #ef4444; font-size: 16px; margin-right: 6px;">●</span> Đăng nhập bằng Google
                </a>
                <a href="#" class="kc-btn-social">
                    <span style="color: #334155; font-size: 16px; margin-right: 6px;">●</span> Đăng nhập bằng GitHub
                </a>
            </div>

            <div class="kc-footer">
                Chưa có tài khoản? <a href="${url.registrationUrl}">Đăng ký ngay</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>