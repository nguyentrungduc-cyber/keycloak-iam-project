<#import "template.ftl" as layout>
<#-- Sửa chữ displayMessage thành false để tắt thông báo mặc định của Keycloak -->
<@layout.registrationLayout displayMessage=false; section>

    <#if section = "header">
        <#-- XÓA CHỮ Ở ĐÂY: Để trống hoàn toàn phần này để xóa luôn cái tiêu đề phía trên -->

    <#elseif section = "form">
        <#-- (Giữ nguyên toàn bộ code phần khung giao diện kc-card ở dưới của bạn) -->
        <div class="kc-card">

        <#-- Header với Icon Cập nhật -->
        <div class="kc-header-inside">
            <div class="kc-logo">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 20h9"/>
                    <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/>
                </svg>
            </div>
            <div class="kc-title">Hoàn thiện hồ sơ</div>
            <div class="kc-subtitle">Vui lòng cập nhật thông tin để kích hoạt tài khoản</div>
        </div>

        <#-- Alert thông báo (Thay thế cái hộp màu xanh lơ chói lọi) -->
        <#if message?has_content>
            <div class="kc-alert kc-alert-${message.type!"info"}" style="background: rgba(56, 189, 248, 0.1); border: 0.5px solid rgba(56, 189, 248, 0.2); margin-bottom: 24px; text-align: center; border-radius: 8px; padding: 12px;">
                <p style="margin: 0; font-size: 13px; color: #38bdf8;">${message.summary}</p>
            </div>
        </#if>

        <form id="kc-update-profile-form" action="${url.loginAction}" method="post">

            <#-- TRÍCH XUẤT DỮ LIỆU AN TOÀN -->
            <#assign usernameVal = (user.username)!'' >
            <#assign emailVal = (user.email)!'' >
            <#assign firstNameVal = (user.firstName)!'' >
            <#assign lastNameVal = (user.lastName)!'' >

            <#-- Username (Sẽ tự động ẩn nếu Admin bật tính năng Email as username) -->
            <#if !realm.registrationEmailAsUsername>
                <div class="kc-form-group">
                    <label for="username">Tên đăng nhập <span style="color:#ef4444">*</span></label>
                    <input type="text" id="username" name="username" value="${usernameVal}" placeholder="Nhập tên đăng nhập" autocomplete="username" <#if !user.editUsernameAllowed>readonly</#if> />
                    <#if messagesPerField.existsError('username')>
                        <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('username')}</div>
                    </#if>
                </div>
            </#if>

            <#-- Email -->
            <div class="kc-form-group">
                <label for="email">Địa chỉ Email <span style="color:#ef4444">*</span></label>
                <input type="email" id="email" name="email" value="${emailVal}" placeholder="Nhập email của bạn" autocomplete="email" />
                <#if messagesPerField.existsError('email')>
                    <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('email')}</div>
                </#if>
            </div>

            <#-- First Name -->
            <div class="kc-form-group">
                <label for="firstName">Họ <span style="color:#ef4444">*</span></label>
                <input type="text" id="firstName" name="firstName" value="${firstNameVal}" placeholder="Nhập họ của bạn" />
                <#if messagesPerField.existsError('firstName')>
                    <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('firstName')}</div>
                </#if>
            </div>

            <#-- Last Name -->
            <div class="kc-form-group">
                <label for="lastName">Tên <span style="color:#ef4444">*</span></label>
                <input type="text" id="lastName" name="lastName" value="${lastNameVal}" placeholder="Nhập tên của bạn" />
                <#if messagesPerField.existsError('lastName')>
                    <div style="font-size:12px; color:#ef4444; margin-top:4px;">${messagesPerField.getFirstError('lastName')}</div>
                </#if>
            </div>

            <#-- Nút Submit bóng bẩy -->
            <button type="submit" class="kc-btn-primary" style="margin-top: 12px;">
                Lưu thông tin
            </button>

        </form>

    </div>
    </#if>

</@layout.registrationLayout>