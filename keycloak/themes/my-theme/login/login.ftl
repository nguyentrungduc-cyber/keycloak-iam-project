<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && social.providers??); section>

    <#if section = "header">
        ${msg("loginAccountTitle")}

    <#elseif section = "form">

        <div id="kc-form">
            <div style="text-align:center; margin-bottom: 24px;">
                <div style="width:48px;height:48px;background:#1F3B6E;border-radius:12px;display:inline-flex;align-items:center;justify-content:center;">
                    <div style="width:24px;height:24px;border:3px solid #fff;border-radius:50%;"></div>
                </div>
                <h2 style="margin:12px 0 4px; font-size:20px;">Đăng nhập MyApp</h2>
                <p style="color:#888; font-size:13px; margin:0;">Nhập thông tin tài khoản của bạn</p>
            </div>

            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;"
                          action="${url.loginAction}" method="post">

                        <div style="margin-bottom:14px;">
                            <label for="username" style="display:block;font-size:13px;color:#555;margin-bottom:5px;">
                                <#if !realm.loginWithEmailAllowed>
                                    ${msg("username")}
                                <#elseif !realm.registrationEmailAsUsername>
                                    ${msg("usernameOrEmail")}
                                <#else>
                                    ${msg("email")}
                                </#if>
                            </label>
                            <input id="username" name="username" type="text"
                                   value="${(login.username!'')}"
                                   style="width:100%;height:38px;border:1px solid #ddd;border-radius:6px;padding:0 10px;font-size:14px;box-sizing:border-box;"
                                   autofocus autocomplete="username" />
                        </div>

                        <div style="margin-bottom:20px;">
                            <label for="password" style="display:block;font-size:13px;color:#555;margin-bottom:5px;">
                                ${msg("password")}
                            </label>
                            <input id="password" name="password" type="password"
                                   style="width:100%;height:38px;border:1px solid #ddd;border-radius:6px;padding:0 10px;font-size:14px;box-sizing:border-box;"
                                   autocomplete="current-password" />
                        </div>

                        <input type="hidden" id="id-hidden-input" name="credentialId"
                               <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

                        <button type="submit" id="kc-login"
                                style="width:100%;height:40px;background:#1F3B6E;color:#fff;border:none;border-radius:6px;font-size:14px;font-weight:500;cursor:pointer;">
                            ${msg("doLogIn")}
                        </button>

                        <#if realm.resetPasswordAllowed>
                            <div style="text-align:center;margin-top:12px;">
                                <a href="${url.loginResetCredentialsUrl}"
                                   style="font-size:12px;color:#888;">
                                    ${msg("doForgotPassword")}
                                </a>
                            </div>
                        </#if>
                    </form>
                </#if>
            </div>

            <#if social.providers??>
                <div style="display:flex;align-items:center;gap:10px;margin:20px 0;">
                    <div style="flex:1;height:1px;background:#eee;"></div>
                    <span style="font-size:12px;color:#aaa;">hoặc tiếp tục với</span>
                    <div style="flex:1;height:1px;background:#eee;"></div>
                </div>

                <div>
                    <#list social.providers as p>
                        <a href="${p.loginUrl}"
                           style="display:flex;align-items:center;justify-content:center;gap:8px;width:100%;height:38px;border:1px solid #ddd;border-radius:6px;text-decoration:none;color:#333;font-size:13px;margin-bottom:10px;box-sizing:border-box;">
                            ${p.displayName}
                        </a>
                    </#list>
                </div>
            </#if>

            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div style="text-align:center;margin-top:16px;font-size:12px;color:#888;">
                    Chưa có tài khoản?
                    <a href="${url.registrationUrl}" style="color:#1F3B6E;">Đăng ký ngay</a>
                </div>
            </#if>
        </div>

    </#if>

</@layout.registrationLayout>
