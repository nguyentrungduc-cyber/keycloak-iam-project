<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>

    <#if section = "header">
        Lỗi hệ thống

    <#elseif section = "form">

        <#-- Phát hiện loại lỗi cụ thể -->
        <#assign isCookieError = false>
        <#assign isExpiredError = false>

        <#if message?has_content>
            <#if message.summary?lower_case?contains("cookie")>
                <#assign isCookieError = true>
            </#if>
            <#if message.summary?lower_case?contains("expired")
              || message.summary?lower_case?contains("hết hạn")>
                <#assign isExpiredError = true>
            </#if>
        </#if>

        <#assign realmName = realm.name!"uit-keycloak-realm">

        <div style="text-align:center; padding: 8px 0;">

            <#-- Icon -->
            <div style="display:inline-flex; align-items:center; justify-content:center;
                        width:60px; height:60px; border-radius:16px;
                        background:rgba(239,68,68,0.12); margin-bottom:18px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28"
                     viewBox="0 0 24 24" fill="none" stroke="#ef4444"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="12" y1="8" x2="12" y2="12"/>
                    <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
            </div>

            <#-- Tiêu đề -->
            <h2 style="font-size:20px; font-weight:700; color:#f0f0f0; margin:0 0 6px;">
                <#if isCookieError>
                    Cần mở link đúng cách
                <#elseif isExpiredError>
                    Link đã hết hạn
                <#else>
                    Đã xảy ra lỗi
                </#if>
            </h2>
            <p style="font-size:13px; color:#555; margin:0 0 22px;">
                MyApp — Powered by Keycloak
            </p>

            <#-- Nội dung lỗi -->
            <div style="background:#1a1a1a; border:0.5px solid #3a1a1a;
                        border-radius:10px; padding:16px 18px;
                        margin-bottom:20px; text-align:left;">

                <#if isCookieError>
                    <p style="font-size:14px; color:#cccccc; line-height:1.7; margin:0 0 12px;">
                        Link đặt lại mật khẩu cần được mở trong <strong style="color:#f0f0f0;">cùng trình duyệt</strong>
                        đã gửi yêu cầu, hoặc trình duyệt chặn cookie.
                    </p>
                    <div style="background:#111; border-radius:8px; padding:12px 14px; font-size:12px; color:#888; line-height:1.8;">
                        <strong style="color:#aaa; display:block; margin-bottom:6px;">Cách khắc phục:</strong>
                        1. Copy link từ email → dán vào <strong style="color:#ccc;">trình duyệt đang dùng bình thường</strong><br/>
                        2. Hoặc chuyển tiếp email sang thiết bị bạn muốn dùng<br/>
                        3. Đảm bảo trình duyệt <strong style="color:#ccc;">bật cookie</strong> (không dùng chế độ ẩn danh)
                    </div>
                <#elseif isExpiredError>
                    <p style="font-size:14px; color:#cccccc; line-height:1.7; margin:0;">
                        Link đặt lại mật khẩu đã hết hiệu lực (quá 15 phút).<br/>
                        Vui lòng yêu cầu gửi lại email mới.
                    </p>
                <#else>
                    <p style="font-size:14px; color:#cccccc; line-height:1.7; margin:0;">
                        <#if message?has_content>
                            ${message.summary}
                        <#else>
                            Đã xảy ra lỗi không xác định. Vui lòng thử lại.
                        </#if>
                    </p>
                </#if>

            </div>

            <#-- Nút hành động tuỳ loại lỗi -->
            <#if isCookieError || isExpiredError>
                <#-- Yêu cầu reset lại -->
                <a href="/realms/${realmName}/login-actions/reset-credentials?client_id=myapp"
                   style="display:block; width:100%; height:44px; line-height:44px;
                          background:#2563eb; border-radius:10px;
                          color:white; font-size:14px; font-weight:600;
                          text-decoration:none; text-align:center; margin-bottom:12px;">
                    Gửi lại email đặt lại mật khẩu
                </a>
            </#if>

            <#-- Nút về trang chủ ứng dụng -->
            <#if client?? && client.baseUrl?? && client.baseUrl?length gt 0>
                <a href="${client.baseUrl}"
                   style="display:block; width:100%; height:44px; line-height:44px;
                          background:transparent; border:0.5px solid #333;
                          border-radius:10px; color:#aaa; font-size:14px; font-weight:500;
                          text-decoration:none; text-align:center; margin-bottom:14px;">
                    Về trang chủ ứng dụng
                </a>
            </#if>

            <div style="font-size:12px; color:#555;">
                <a id="login-link" href="/realms/${realmName}/account"
                   style="color:#60a5fa; text-decoration:none;">
                    ← Quay lại đăng nhập
                </a>
            </div>

        </div>

        <script>
        (function() {
            var origin = window.location.origin;
            var pathParts = window.location.pathname.split('/');
            var realmIdx = pathParts.indexOf('realms');
            var realmSlug = realmIdx !== -1 ? pathParts[realmIdx + 1] : '${realmName}';
            var loginUrl = origin + '/realms/' + realmSlug + '/account';
            var link = document.getElementById('login-link');
            if (link) link.href = loginUrl;
        })();
        </script>

    </#if>

</@layout.registrationLayout>
