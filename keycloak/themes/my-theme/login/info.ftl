<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#-- Để trống -->
    <#elseif section = "form">
        <div class="kc-card">
            <div class="kc-header-inside">
                <div class="kc-logo">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="30" height="30">
                        <circle cx="12" cy="12" r="7" stroke="#ffffff" stroke-width="2" fill="none" />
                        <circle cx="12" cy="12" r="2.5" fill="#ffffff" />
                    </svg>
                </div>
                <h1 class="kc-title">Thông báo hệ thống</h1>
                <div class="kc-subtitle">MyApp — Security Update</div>
            </div>

            <div class="kc-info-message" style="text-align: center; margin-bottom: 24px;">
                <p style="font-size: 14px; color: var(--text-primary); line-height: 1.6;">
                    <#-- Đây là nơi Keycloak nhét dòng chữ "Click here to continue" vào -->
                    ${message.summary}
                </p>
            </div>

            <#if actionUri??>
                <a href="${actionUri}" class="kc-btn-primary" style="text-decoration: none; text-align: center; display: block;">
                    Tiếp tục
                </a>
            </#if>
            
            <div class="kc-footer" style="margin-top: 20px;">
                Quay lại <a href="${url.loginUrl}">Đăng nhập</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>