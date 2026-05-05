<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#-- Để trống vì đã có Header bên trong Card -->
    <#elseif section = "form">
        <div class="kc-card">
            
            <#-- Header với Icon Đồng hồ -->
            <div class="kc-header-inside">
                <div class="kc-logo" style="background: #f59e0b;"> <#-- Màu cam cảnh báo Timeout -->
                    <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 16 14"></polyline>
                    </svg>
                </div>
                <div class="kc-title" style="color: #fbd38d;">Phiên đã hết hạn</div>
                <div class="kc-subtitle">Keycloak — Security System</div>
            </div>

            <#-- Thông báo lỗi mượt mà -->
            <div class="kc-error-message" style="text-align: center; margin-bottom: 24px;">
                <p style="font-size: 14px; color: var(--text-secondary); line-height: 1.6;">
                    Phiên làm việc của bạn đã không hoạt động trong một khoảng thời gian dài.<br> Vui lòng thao tác lại để đảm bảo an toàn.
                </p>
            </div>

            <#-- Hai nút hành động dọc -->
            <div style="display: flex; flex-direction: column; gap: 12px; margin-top: 10px;">
                
                <#-- Nút Bắt đầu lại (Ưu tiên cao nhất) -->
                <a id="loginRestartLink" href="${url.loginRestartFlowUrl}" class="kc-btn-primary" style="text-decoration: none; text-align: center; padding: 12px; background-color: var(--accent); border-color: var(--accent);">
                    Bắt đầu lại đăng nhập
                </a>
                
                <#-- Nút Tiếp tục (Nút phụ có viền trong suốt) -->
                <a id="loginContinueLink" href="${url.loginAction}" class="kc-btn-social" style="text-decoration: none; text-align: center; padding: 12px;">
                    Tiếp tục phiên hiện tại
                </a>
                
            </div>
            
        </div>
    </#if>
</@layout.registrationLayout>