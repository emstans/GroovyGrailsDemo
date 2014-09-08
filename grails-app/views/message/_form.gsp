<%@ page import="board.Message" %>



<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'author', 'error')} required">
	<label for="author">
		<g:message code="message.author.label" default="Author" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="author" name="author.id" from="${board.User.list()}" optionKey="id" required="" value="${messageInstance?.author?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'messageBody', 'error')} required">
	<label for="messageBody">
		<g:message code="message.messageBody.label" default="Message Body" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="messageBody" cols="40" rows="5" maxlength="10000" required="" value="${messageInstance?.messageBody}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'messageDate', 'error')} required">
	<label for="messageDate">
		<g:message code="message.messageDate.label" default="Message Date" />
		<span class="required-indicator">*</span>
	</label>
	<div id="messageDate"> ${messageInstance?.messageDate} </div>

</div>

