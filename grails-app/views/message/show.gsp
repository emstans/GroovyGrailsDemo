
<%@ page import="board.Message" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="show-message" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list message">
			

				 
				<g:if test="${messageInstance?.messageBody}">
				<li class="fieldcontain">
					<span id="messageBody-label" class="property-label"><g:message code="message.messageBody.label" default="Message Body" /></span>
					
						<span class="property-value" aria-labelledby="messageBody-label"><g:fieldValue bean="${messageInstance}" field="messageBody"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${messageInstance?.messageDate}">
				<li class="fieldcontain">
					<span id="messageDate-label" class="property-label"><g:message code="message.messageDate.label" default="Message Date" /></span>
					
						<span class="property-value" aria-labelledby="messageDate-label"><g:formatDate date="${messageInstance?.messageDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<sec:ifAllGranted roles="ROLE_ADMIN">
				<g:form url="[resource:messageInstance, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="edit" action="edit" resource="${messageInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</sec:ifAllGranted>
		</div>
	</body>
</html>
