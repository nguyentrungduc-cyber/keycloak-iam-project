<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=false; section>

<#if section = "header">
    <#-- Bỏ trống để ẩn tiêu đề mặc định của Keycloak -->
<#elseif section = "form">
<link rel="stylesheet" href="${url.resourcesPath}/css/theme.css"/>

<style>
    /* Canh giữa toàn bộ khối xác thực */
    .kc-verify-container {
        text-align: center;
        padding: 10px 0 20px 0;
    }

    /* Style cho khối icon màu xanh ngọc */
    .kc-verify-icon-wrap {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 56px;
        height: 56px;
        background: rgba(6, 182, 212, 0.1); /* Nền xanh ngọc nhạt */
        border-radius: 16px;
        margin-bottom: 24px;
    }
    .kc-verify-icon-wrap svg {
        color: #06b6d4; /* Màu xanh ngọc (Cyan) */
    }

    /* Tiêu đề & Nội dung */
    .kc-title {
        font-size: 22px;
        font-weight: 600;
        color: #ffffff;
        margin-bottom: 12px;
    }
    .kc-description {
        font-size: 14px;
        color: #a3a3a3;
        line-height: 1.6;
        margin-bottom: 32px;
    }
    .kc-description strong {
        color: #e5e5e5;
    }

    /* Phần gửi lại email */
    .kc-resend-wrap {
        font-size: 14px;
        color: #737373;
        padding-top: 24px;
        border-top: 1px solid #333;
    }
    .kc-resend-link {
        color: #60a5fa; /* Màu xanh dương đồng bộ với các link đăng nhập/đăng ký */
        text-decoration: none;
        font-weight: 500;
        margin-left: 4px;
        transition: color 0.2s;
    }
    .kc-resend-link:hover {
        color: #93c5fd;
        text-decoration: underline;
    }
</style>

<div class="kc-verify-container">
    <#-- Icon Email Xanh ngọc -->
    <div class="kc-verify-icon-wrap">
        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="2" y="4" width="20" height="16" rx="2"></rect>
            <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
        </svg>
    </div>
    
    <div class="kc-title">Xác minh địa chỉ Email</div>
    
    <div class="kc-description">
        Chúng tôi vừa gửi một email chứa liên kết xác minh đến địa chỉ của bạn.<br>
        Vui lòng kiểm tra hộp thư đến (và thư mục Spam) để hoàn tất.
    </div>

    <#-- Nút gửi lại email do Keycloak cung cấp action -->
    <div class="kc-resend-wrap">
        Bạn chưa nhận được email? 
        <a href="${url.loginAction}" class="kc-resend-link">Gửi lại liên kết</a>
    </div>
</div>

<#elseif section = "info">
    <#-- Bỏ trống phần info vì Keycloak có thể tự chèn text xấu vào đây, mình đã custom nó ở phần form rồi -->
</#if>

</@layout.registrationLayout>