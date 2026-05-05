<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        Xác nhận liên kết tài khoản
    <#elseif section = "form">
    <div class="kc-card">
        
        <#-- Header đồng bộ giao diện -->
        <div class="kc-header-inside">
            <div class="kc-logo">
                <#-- Icon 2 người tượng trưng cho việc Gộp tài khoản -->
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
                    <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
            </div>
            <div class="kc-title">Tài khoản đã tồn tại</div>
            <div class="kc-subtitle">Hệ thống phát hiện email trùng lặp</div>
        </div>

        <#-- Khung cảnh báo (Alert) đã được fix cứng Tiếng Việt -->
        <div class="kc-alert kc-alert-error" style="background: rgba(239, 68, 68, 0.1); border: 0.5px solid rgba(239, 68, 68, 0.2); color: #f87171; text-align: center; margin-bottom: 24px;">
            <p style="margin: 0; font-size: 13px;">
                Người dùng với email <b>${(brokerContext.email)!(profile.email)!''}</b> đã tồn tại trong hệ thống. Bạn muốn tiếp tục như thế nào?
            </p>
        </div>

        <#-- Hai nút hành động chia đôi màn hình -->
        <form id="kc-register-form" action="${url.loginAction}" method="post">
            <div style="display: flex; gap: 12px; margin-top: 10px;">
                
                <#-- Nút Hủy / Xem lại (Tận dụng class btn-social để có viền trong suốt giống nút Cancel) -->
                <button type="submit" class="kc-btn-social" name="submitAction" id="updateProfile" value="updateProfile" style="flex: 1; margin: 0; padding: 12px; justify-content: center;">
                    Xem lại hồ sơ
                </button>
                
                <#-- Nút Xác nhận gộp nick (Dùng class btn-primary, phối với màu xanh Accent của bạn) -->
                <button type="submit" class="kc-btn-primary" name="submitAction" id="linkAccount" value="linkAccount" style="flex: 1; margin: 0; padding: 12px; background-color: var(--accent); border-color: var(--accent);">
                    Gộp tài khoản
                </button>
                
            </div>
        </form>

        <#-- Footer quay lại -->
        <div class="kc-footer" style="margin-top: 24px;">
            <a href="${url.loginUrl}">← Hủy và quay lại đăng nhập</a>
        </div>

    </div>
    </#if>
</@layout.registrationLayout>