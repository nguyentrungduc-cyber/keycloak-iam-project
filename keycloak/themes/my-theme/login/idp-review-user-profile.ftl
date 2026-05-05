<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global'); section>

    <#if section = "header">
        Thông báo

    <#elseif section = "form">

    <#-- BƯỚC 1: TRÍCH XUẤT DỮ LIỆU (Bao trọn gói mọi phiên bản Keycloak) -->
    <#assign usernameVal = (profile.username)!''>
    <#assign emailVal = (profile.email)!''>
    <#assign firstNameVal = (profile.firstName)!''>
    <#assign lastNameVal = (profile.lastName)!''>

    <#if profile.attributes??>
        <#list profile.attributes as attr>
            <#if attr.name == 'username' && usernameVal == ''><#assign usernameVal = attr.value!''></#if>
            <#if attr.name == 'email' && emailVal == ''><#assign emailVal = attr.value!''></#if>
            <#if attr.name == 'firstName' && firstNameVal == ''><#assign firstNameVal = attr.value!''></#if>
            <#if attr.name == 'lastName' && lastNameVal == ''><#assign lastNameVal = attr.value!''></#if>
        </#list>
    </#if>

    <#-- BƯỚC 2: HIỂN THỊ GIAO DIỆN -->
    <div class="kc-card">

        <#-- Header -->
        <div class="kc-header-inside">
            <div class="kc-logo">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                    <circle cx="12" cy="7" r="4"/>
                </svg>
            </div>
            <div class="kc-title">Cập nhật tài khoản</div>
            <div class="kc-subtitle">Vui lòng xác nhận thông tin trước khi tiếp tục</div>
        </div>

        <#-- Alert lỗi -->
        <#if messagesPerField.exists('global')>
            <div class="kc-alert kc-alert-error">
                ${messagesPerField.getFirstError('global')}
            </div>
        </#if>

        <form id="kc-idp-review-profile-form" action="${url.loginAction}" method="post">

            <#-- CHỈ HIỆN Ô USERNAME NẾU ADMIN ĐANG TẮT TÍNH NĂNG "EMAIL AS USERNAME" -->
            <#if !realm.registrationEmailAsUsername>
                <div class="kc-form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" value="${usernameVal}" placeholder="Nhập tên đăng nhập" autofocus autocomplete="username" />
                    <#if messagesPerField.existsError('username')>
                        <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('username')}</div>
                    </#if>
                </div>
            </#if>

            <#-- Email -->
            <div class="kc-form-group">
                <label for="email">Địa chỉ Email</label>
                <input type="email" id="email" name="email" value="${emailVal}" placeholder="Nhập email của bạn" autocomplete="email" />
                <#if messagesPerField.existsError('email')>
                    <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('email')}</div>
                </#if>
            </div>

            <#-- First Name (Lần này đảm bảo luôn hiện ra) -->
            <div class="kc-form-group">
                <label for="firstName">Họ</label>
                <input type="text" id="firstName" name="firstName" value="${firstNameVal}" placeholder="Nhập họ của bạn" />
                <#if messagesPerField.existsError('firstName')>
                    <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('firstName')}</div>
                </#if>
            </div>

            <#-- Last Name (Lần này đảm bảo luôn hiện ra) -->
            <div class="kc-form-group">
                <label for="lastName">Tên</label>
                <input type="text" id="lastName" name="lastName" value="${lastNameVal}" placeholder="Nhập tên của bạn" />
                <#if messagesPerField.existsError('lastName')>
                    <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('lastName')}</div>
                </#if>
            </div>

            <div style="background:#1a1a2e; border:0.5px solid #333; border-radius:8px; padding:10px 14px; margin-bottom:16px; margin-top:4px;">
                <p style="font-size:12px; color:#888; margin:0;">
                    Thông tin được lấy từ tài khoản mạng xã hội của bạn. Bạn có thể chỉnh sửa trước khi xác nhận.
                </p>
            </div>

            <button type="submit" class="kc-btn-primary">Xác nhận và tiếp tục</button>

        </form>

        <div class="kc-footer">
            <a href="${url.loginUrl}">← Quay lại đăng nhập</a>
        </div>

    </div>
    </#if>

</@layout.registrationLayout>