<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=(social.displayInfo)!false displayWide=(realm.password && social.providers??); section>

    <#if section = "header">
        <#-- Phần này để trống vì chúng ta đã có header tùy chỉnh bên dưới -->
    <#elseif section = "form">

        <div id="kc-form" class="form-content">
            <div class="header">
                <div style="width:48px;height:48px;background:#1F3B6E;border-radius:12px;display:inline-flex;align-items:center;justify-content:center;margin-bottom: 12px;">
                    <div style="width:24px;height:24px;border:3px solid #fff;border-radius:50%;"></div>
                </div>
                <h2 style="margin-bottom: 4px; font-size:20px; font-weight: 600;">Đăng nhập</h2>
                <p style="color:#888; font-size:13px; font-weight: 400;">MyApp — Powered by KeyCloak</p>
            </div>

            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">

                        <div style="margin-bottom:14px;">
                            <label for="username">
                                <#if !realm.loginWithEmailAllowed>
                                    ${msg("username")}
                                <#elseif !realm.registrationEmailAsUsername>
                                    ${msg("usernameOrEmail")}
                                <#else>
                                    Email
                                </#if>
                            </label>
                            <input id="username" name="username" type="text" value="${(login.username!'')}" autofocus autocomplete="username" placeholder="nguyenvana@example.com" />
                        </div>

                        <div style="margin-bottom:20px;">
                            <label for="password">Mật khẩu</label>
                            <input id="password" name="password" type="password" autocomplete="current-password" placeholder="••••••••••" />
                        </div>

                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

                        <button type="submit" id="kc-login">Đăng nhập</button>

                        <#if realm.resetPasswordAllowed>
                            <div style="text-align:center;margin-top:16px;">
                                <a href="${url.loginResetCredentialsUrl}" style="font-size:12px;">
                                    Quên mật khẩu?
                                </a>
                            </div>
                        </#if>
                    </form>
                </#if>
            </div>

            <#if social.providers??>
                <div class="kc-divider" style="display:flex;align-items:center;gap:10px;margin:24px 0;">
                    <div style="flex:1;height:0.5px;background:#333333;"></div>
                    <span style="font-size:12px;color:#555555;">hoặc tiếp tục với</span>
                    <div style="flex:1;height:0.5px;background:#333333;"></div>
                </div>

                <div id="kc-social-providers">
                    <#list social.providers as p>
                        <a href="${p.loginUrl}" class="zocial">
                            <span style="width:12px;height:12px;background:${(p.alias == 'google')?string('#ea4335','#333')};border-radius:50%;display:inline-block;margin-right:8px;"></span>
                            Đăng nhập bằng ${p.displayName}
                        </a>
                    </#list>
                </div>
            </#if>

            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div class="footer-info" style="border-top: none; margin-top: 8px;">
                    Chưa có tài khoản? <a href="${url.registrationUrl}">Đăng ký ngay</a>
                </div>
            </#if>
        </div>

    </#if>
</@layout.registrationLayout>