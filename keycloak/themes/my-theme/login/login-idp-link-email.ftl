<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>

    <#if section = "header">
        Xác thực Email liên kết

    <#elseif section = "form">
    <div class="kc-card">

        <#-- Header với Logo hình Email -->
        <div class="kc-header-inside">
            <div class="kc-logo" style="background: #0ea5e9;"> <#-- Màu nền logo xanh lam cho hợp với ngữ cảnh Gửi Mail -->
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                    <polyline points="22,6 12,13 2,6"></polyline>
                </svg>
            </div>
            <div class="kc-title">Kiểm tra hộp thư</div>
            <div class="kc-subtitle">Xác thực liên kết với ${idpAlias!'mạng xã hội'}</div>
        </div>

        <#-- Hộp thông báo nổi bật (Màu xanh lam trong suốt) -->
        <div style="background: rgba(56, 189, 248, 0.1); border: 0.5px solid rgba(56, 189, 248, 0.2); border-radius: 8px; padding: 14px; margin-bottom: 20px;">
            <p style="font-size: 13px; color: #38bdf8; margin: 0; text-align: center; font-weight: 500;">
                Bạn cần xác thực email để hoàn tất quá trình liên kết.
            </p>
        </div>

        <#-- Nội dung hướng dẫn chi tiết -->
        <div style="font-size: 13px; color: #bbbbbb; line-height: 1.6; text-align: center; margin-bottom: 30px;">
            <p style="margin-bottom: 16px;">
                Một email hướng dẫn liên kết tài khoản <b>${idpAlias!}</b> của <b>${(brokerContext.username)!(realm.displayName)!''}</b> đã được gửi đến bạn.
            </p>
            
            <p style="margin-bottom: 12px; font-size: 12.5px;">
                Chưa nhận được email xác thực? <br/>
                <a href="${url.loginAction}" style="color: #60a5fa; text-decoration: none; font-weight: 500;">Bấm vào đây</a> để hệ thống gửi lại.
            </p>
            
            <p style="margin-bottom: 0; font-size: 12.5px;">
                Nếu bạn đã xác thực trên một trình duyệt khác, <br/>
                <a href="${url.loginAction}" style="color: #60a5fa; text-decoration: none; font-weight: 500;">bấm vào đây</a> để tiếp tục đăng nhập.
            </p>
        </div>

        <#-- Footer quay lại -->
        <div class="kc-footer" style="margin-top: 10px;">
            <a href="${url.loginUrl}">← Hủy và quay lại đăng nhập</a>
        </div>

    </div>
    </#if>

</@layout.registrationLayout>