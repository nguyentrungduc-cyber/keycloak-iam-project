<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>

    <#if section = "header">
        Thông báo hệ thống

    <#elseif section = "form">
        <div style="text-align:center; padding: 8px 0;">

            <#-- 1. TÌM TỪ KHÓA ĐỂ PHÂN LOẠI -->
            <#assign msgType = "info">
            <#assign iconColor = "#2563eb">
            <#assign iconBg = "rgba(37,99,235,0.12)">
            
            <#if message?has_content>
                <#if message.summary?lower_case?contains("email")
                  || message.summary?lower_case?contains("verify")
                  || message.summary?lower_case?contains("sent")
                  || message.summary == "You should receive an email shortly with further instructions.">
                    <#assign msgType = "email">
                </#if>
                
                <#-- ĐÃ BỔ SUNG "updated" VÀO NHÓM SUCCESS -->
                <#if message.summary?lower_case?contains("success")
                  || message.summary?lower_case?contains("thành công")
                  || message.summary?lower_case?contains("already logged in")
                  || message.summary?lower_case?contains("updated")>
                    <#assign msgType = "success">
                    <#assign iconColor = "#4ade80">
                    <#assign iconBg = "rgba(74,222,128,0.12)">
                </#if>
                
                <#if message.summary?lower_case?contains("error")
                  || message.summary?lower_case?contains("lỗi")
                  || message.summary?lower_case?contains("expired")
                  || message.summary?lower_case?contains("invalid")>
                    <#assign msgType = "error">
                    <#assign iconColor = "#ef4444">
                    <#assign iconBg = "rgba(239,68,68,0.12)">
                </#if>
            </#if>

            <#-- 2. ICON -->
            <div style="display:inline-flex; align-items:center; justify-content:center;
                        width:60px; height:60px; border-radius:16px;
                        background:${iconBg}; margin-bottom:18px;">
                <#if msgType == "email">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="${iconColor}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="2" y="4" width="20" height="16" rx="2"/><path d="M2 7l10 7 10-7"/>
                    </svg>
                <#elseif msgType == "success">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="${iconColor}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"/><path d="M8 12l3 3 5-5"/>
                    </svg>
                <#elseif msgType == "error">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="${iconColor}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
                    </svg>
                <#else>
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="${iconColor}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
                    </svg>
                </#if>
            </div>

            <#-- 3. TIÊU ĐỀ -->
            <h2 style="font-size:20px; font-weight:700; color:#f0f0f0; margin:0 0 6px;">
                <#if msgType == "email">
                    Kiểm tra email của bạn
                <#elseif msgType == "success">
                    <#if message.summary?lower_case?contains("already logged in")>
                        Đã đăng nhập
                    <#elseif message.summary?lower_case?contains("updated")>
                        Cập nhật thành công
                    <#else>
                        Thành công
                    </#if>
                <#elseif msgType == "error">
                    Có lỗi xảy ra
                <#else>
                    Thông báo hệ thống
                </#if>
            </h2>
            
            <p style="font-size:13px; color:#555; margin:0 0 22px;">
                MyApp — Powered by Keycloak
            </p>

            <#-- 4. NỘI DUNG -->
            <div style="background:#1a1a1a; border:0.5px solid #333;
                        border-radius:10px; padding:16px 18px;
                        margin-bottom:22px; text-align:left;">
                <p style="font-size:14px; color:#cccccc; line-height:1.7; margin:0;">
                    <#if message?has_content>
                        <#if message.summary == "You should receive an email shortly with further instructions.">
                            Một email hướng dẫn đã được gửi đến địa chỉ của bạn.<br/>
                            Vui lòng kiểm tra <strong style="color:#f0f0f0;">hộp thư đến</strong> và cả thư mục <strong style="color:#f0f0f0;">Spam</strong>.
                        <#elseif message.summary?lower_case?contains("verify")>
                            Email xác minh đã được gửi.<br/>Vui lòng kiểm tra hộp thư và click vào link xác nhận.
                        <#elseif message.summary?lower_case?contains("already logged in")>
                            Bạn đã đăng nhập vào hệ thống. Không cần thực hiện thêm thao tác nào.
                        <#elseif message.summary?lower_case?contains("updated")>
                            Tài khoản của bạn đã được cập nhật thông tin thành công.
                        <#elseif message.summary?lower_case?contains("expired")>
                            Đường dẫn bạn sử dụng đã hết hạn. Vui lòng yêu cầu cấp lại link mới.
                        <#else>
                            ${message.summary}
                        </#if>
                    </#if>
                </p>

                <#if msgType == "email">
                    <div style="margin-top:12px; padding-top:12px; border-top:0.5px solid #2a2a2a; font-size:12px; color:#555; line-height:1.6;">
                        Link có hiệu lực trong <span style="color:#aaa;">15 phút</span>. Nếu không nhận được, kiểm tra lại địa chỉ email hoặc thử lại.
                    </div>
                </#if>
            </div>

            <#-- 5. NÚT TIẾP TỤC (ACTION URI) -->
            <#if actionUri??>
                <a href="${actionUri}"
                   style="display:block; width:100%; height:44px; line-height:44px;
                          background:#2563eb; border-radius:10px;
                          color:white; font-size:14px; font-weight:600;
                          text-decoration:none; text-align:center;
                          margin-bottom:14px; transition:background 0.2s;">
                    Tiếp tục
                </a>
            </#if>

            <#-- 6. NÚT QUAY LẠI CÓ FALLBACK CHỐNG MẤT SESSION -->
            <div style="font-size:12px; color:#555;">
                <#if url.loginUrl?? && url.loginUrl?length gt 0>
                    <a href="${url.loginUrl}" style="color:#60a5fa; text-decoration:none;">
                        ← Quay lại đăng nhập
                    </a>
                <#elseif client?? && client.baseUrl??>
                    <a href="${client.baseUrl}" style="color:#60a5fa; text-decoration:none;">
                        ← Quay lại trang chủ ứng dụng
                    </a>
                <#else>
                    <#-- Fallback cứng về trang account của realm nếu mở trên browser khác và mất toàn bộ context -->
                    <a href="/realms/uit-keycloak-realm/account" style="color:#60a5fa; text-decoration:none;">
                        ← Về trang quản lý tài khoản
                    </a>
                </#if>
            </div>

        </div>
    </#if>

</@layout.registrationLayout>