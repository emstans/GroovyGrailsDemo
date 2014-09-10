
<%@ page import="board.Message" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-message" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<%--<th><g:message code="message.author.username" default="Author" /></th>  --%>
					
						<g:sortableColumn property="messageBody" title="${message(code: 'message.messageBody.label', default: 'Message Body')}" />
					
						<g:sortableColumn property="messageDate" title="${message(code: 'message.messageDate.label', default: 'Message Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${messageInstanceList}" status="i" var="messageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<%--  <td><g:link action="show" id="${messageInstance.id}">${fieldValue(bean: messageInstance, field: "author")}</g:link></td> --%>
					
						<td><g:link action="show" id="${messageInstance.id}">${fieldValue(bean: messageInstance, field: "messageBody")}</g:link></td>
					
						<td><g:formatDate date="${messageInstance.messageDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${messageInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
