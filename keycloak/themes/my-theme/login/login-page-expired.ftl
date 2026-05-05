<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("pageExpiredTitle")}
    <#elseif section = "form">
        <p id="instruction1" class="instruction">
            ${msg("pageExpiredMsg1")} <a id="loginRestartLink" href="${url.loginRestartFlowUrl}" style="color: #66b2ff;">${msg("doClickHere")}</a>.
        </p>
        <p id="instruction2" class="instruction">
            ${msg("pageExpiredMsg2")} <a id="loginContinueLink" href="${url.loginAction}" style="color: #66b2ff;">${msg("doClickHere")}</a>.
        </p>
    </#if>
</@layout.registrationLayout>