<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>

    <#if section = "header">
        Lỗi hệ thống

    <#elseif section = "form">
        <div style="text-align:center; padding: 8px 0;">

            <#-- Icon Lỗi (Mặc định là màu đỏ) -->
            <div style="display:inline-flex; align-items:center; justify-content:center;
                        width:60px; height:60px; border-radius:16px;
                        background:rgba(239,68,68,0.12); margin-bottom:18px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
            </div>

            <#-- Tiêu đề cảnh báo -->
            <h2 style="font-size:20px; font-weight:700; color:#f0f0f0; margin:0 0 6px;">
                Đã xảy ra lỗi nghiêm trọng
            </h2>
            
            <p style="font-size:13px; color:#555; margin:0 0 22px;">
                MyApp — Powered by Keycloak
            </p>

            <#-- Nội dung lỗi chi tiết -->
            <div style="background:#1a1a1a; border:0.5px solid #ef4444; 
                        border-radius:10px; padding:16px 18px;
                        margin-bottom:22px; text-align:left;">
                <p style="font-size:14px; color:#cccccc; line-height:1.7; margin:0;">
                    <#if message?has_content && message.summary?has_content>
                        <#-- Xử lý dịch một số lỗi hệ thống phổ biến của Keycloak -->
                        <#if message.summary?lower_case?contains("invalid parameter")>
                            Tham số yêu cầu không hợp lệ. Vui lòng kiểm tra lại đường dẫn.
                        <#elseif message.summary?lower_case?contains("client not found")>
                            Không tìm thấy ứng dụng (Client) yêu cầu trong hệ thống.
                        <#else>
                            ${message.summary}
                        </#if>
                    <#else>
                        Hệ thống đang gặp sự cố gián đoạn. Vui lòng thử lại sau hoặc liên hệ với quản trị viên.
                    </#if>
                </p>
            </div>

            <#-- Nút quay lại (Rất quan trọng ở trang error vì session thường đã hỏng) -->
            <div style="font-size:12px; color:#555;">
                <#if client?? && client.baseUrl??>
                    <a href="${client.baseUrl}" style="display:block; width:100%; height:44px; line-height:44px;
                          background:#ef4444; border-radius:10px;
                          color:white; font-size:14px; font-weight:600;
                          text-decoration:none; text-align:center;
                          margin-bottom:14px; transition:background 0.2s;">
                        Về trang chủ ứng dụng
                    </a>
                <#else>
                    <a href="/realms/uit-keycloak-realm/account" style="display:block; width:100%; height:44px; line-height:44px;
                          background:#333333; border-radius:10px;
                          color:white; font-size:14px; font-weight:600;
                          text-decoration:none; text-align:center;
                          margin-bottom:14px; transition:background 0.2s;">
                        Về trang quản lý tài khoản
                    </a>
                </#if>
            </div>

        </div>
    </#if>

</@layout.registrationLayout>