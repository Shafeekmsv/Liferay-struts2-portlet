<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<%@ page import="com.winenergy.bookmark.model.Bookmark"%>
<%@ page import="com.winenergy.bookmark.service.BookmarkLocalServiceUtil"%>

<sj:head jqueryui="true" jquerytheme="flick" />
<script type="text/javascript">
	var context_path = '<%=request.getContextPath()%>';
</script>

<s:debug />
	
<h2>Manage bookmarks</h2>

<s:if test="hasActionMessages()">
   <div class="message">
      <s:actionmessage/>
   </div>
</s:if>

<s:url id="remoteurl" value="/edit/ajax/bookmarkTable.action"/>
<s:url action="editBookmark!input" id="editUrl" />
<sjg:grid id="gridtable"
    	caption="Bookmarks"
    	dataType="json"
    	href="%{remoteurl}"
    	pager="true"
    	gridModel="gridModel"
    	rowList="5,10,15,20"
    	rowNum="5"
    	multiselect="true"
    	navigator="true"
    	navigatorView="false"
    	navigatorDelete="false"
    	navigatorAdd="false"
    	navigatorRefresh="false"
    	navigatorSearch="false"
		navigatorEditOptions="{height:180,reloadAfterSubmit:false}"
    	navigatorEdit="true"
    	editurl="%{editurl}"
    >
	<sjg:gridColumn name="bookmarkId" title="ID" formatter="integer" sortable="false"/>
    <sjg:gridColumn name="name" index="name" title="Name" editable="true" edittype="text" sortable="true"/>
    <sjg:gridColumn name="url" index="url" title="Url" editable="true" edittype="text" sortable="false"/>
    
    <sjg:gridColumn name="name" 
    				title="Actions" 
    				editable="false" 
    				sortable="false"
    				align="center"
    				formatter="formatImage"
    				onclick="$.publish('edit_bookmark');"
    />
</sjg:grid>

<p>
	<a href="javascript:newBookmark();">Add Bookmarks</a>
</p>

<p>
	<a href="javascript:editBookmark('Google');">Test Edeit Bookmarks</a>
</p>

<br />
<br />
<br />

<table>
   <s:iterator value="%{bookmarks}" var="bookmark">
      <s:url action="editBookmark!input" id="editUrl">
         <s:param name="oldName" value="%{name}"/>
      </s:url>
      <s:url action="deleteBookmark" portletUrlType="action" id="deleteUrl">
         <s:param name="bookmarkName" value="%{name}"/>
      </s:url>
      <tr>
         <td width = "30%"><s:property value="%{name}"/></td>
         <td width = "50%"><a href="<s:property value="%{url}"/>" target="_blank"><s:property value="%{url}"/></a></td>
         <td width = "10%"><a href="<s:property value="%{editUrl}"/>">Edit</a></td>
         <td width = "10%"><a href="<s:property value="%{deleteUrl}"/>">Delete</a></td>
      </tr>
   </s:iterator>
</table>