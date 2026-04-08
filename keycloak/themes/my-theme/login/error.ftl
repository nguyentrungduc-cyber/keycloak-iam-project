<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#-- Để trống vì dùng Header inside card -->
    <#elseif section = "form">
        <div class="kc-card">
            <div class="kc-header-inside">
                <div class="kc-logo">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="30" height="30">
                        <circle cx="12" cy="12" r="7" stroke="#ffffff" stroke-width="2" fill="none" />
                        <circle cx="12" cy="12" r="2.5" fill="#ffffff" />
                    </svg>
                </div>
                <h1 class="kc-title" style="color: #ef4444;">Đã có lỗi xảy ra</h1>
                <div class="kc-subtitle">Keycloak — Security System</div>
            </div>

            <div class="kc-error-message" style="text-align: center; margin-bottom: 24px;">
                <p style="font-size: 14px; color: var(--text-secondary); line-height: 1.6;">
                    ${message.summary}
                </p>
            </div>

            <#if client?? && client.baseUrl??>
                <a href="${client.baseUrl}" class="kc-btn-primary" style="text-decoration: none; text-align: center; display: block;">
                    Quay lại ứng dụng
                </a>
            <#else>
                <a href="${url.loginUrl}" class="kc-btn-primary" style="text-decoration: none; text-align: center; display: block;">
                    Quay lại trang đăng nhập
                </a>
            </#if>
            
            <div class="kc-footer" style="margin-top: 20px;">
                Cần hỗ trợ? <a href="mailto:admin@myapp.com">Liên hệ quản trị viên</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>