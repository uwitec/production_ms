<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<link href="js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>

<table  id="fCountCheckList" title="成品计数质检	" class="easyui-datagrid"
       data-options="singleSelect:false,collapsible:true,pagination:true,rownumbers:true,url:'f_count_check/list',method:'get',fitColumns:true,pageSize:10,toolbar:toolbar_fCountCheck">
    <thead>
        <tr>
            <th data-options="field:'ck',checkbox:true"></th>
        	<th data-options="field:'fCountCheckId',align:'center',width:100">成品计数质检编号</th>
            <th data-options="field:'orderId',align:'center',width:100,formatter:formatOrder">订单编号</th>
            <th data-options="field:'checkItem',align:'center',width:100">检验项目</th>
            <th data-options="field:'sample',align:'center',width:100">样本总数</th>
            <th data-options="field:'checkNumber',align:'center',width:100">抽检数</th>
            <th data-options="field:'unqualify',align:'center',width:100">不合格数</th>
            <th data-options="field:'qualify',align:'center',width:100">合格率</th>
            <th data-options="field:'cdate',align:'center',width:130,formatter:TAOTAO.formatDateTime">检验时间</th>
            <th data-options="field:'measureData',align:'center',width:100">实际测量数据</th>
            <th data-options="field:'empId',align:'center',width:100">检验人员编号</th>
            <th data-options="field:'result',align:'center',width:100">检验结果</th>
            <th data-options="field:'note',align:'center',width:100,formatter:formatNote">备注</th>
            
            
        </tr>
    </thead>
</table>




<!-- 111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 -->

<div  id="toolbar_fCountCheck" style=" height: 22px; padding: 3px 11px; background: #fafafa;">  
	
	<c:forEach items="${sessionScope.sysPermissionList}" var="per" >
		<c:if test="${per=='fCountCheck:add' }" >
		    <div style="float: left;">  
		        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="fCountCheck_add()">新增</a>  
		    </div>  
		</c:if>
		<c:if test="${per=='fCountCheck:edit' }" >
		    <div style="float: left;">  
		        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-edit" onclick="fCountCheck_edit()">编辑</a>  
		    </div>  
		</c:if>
		<c:if test="${per=='fCountCheck:delete' }" >
		    <div style="float: left;">  
		        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-cancel" onclick="fCountCheck_delete()">删除</a>  
		    </div>  
		</c:if>
	</c:forEach>
	
	<div class="datagrid-btn-separator"></div>  
	
	<div style="float: left;">  
		<a href="#" class="easyui-linkbutton" plain="true" icon="icon-reload" onclick="fCountCheck_reload()">刷新</a>  
	</div>  
	
    <div id="search_fCountCheck" style="float: right;">
        <input id="search_text_fCountCheck" class="easyui-searchbox"  
            data-options="searcher:doSearch_fCountCheck,prompt:'请输入...',menu:'#menu_fCountCheck'"  
            style="width:250px;vertical-align: middle;">
        </input>
        <div id="menu_fCountCheck" style="width:120px"> 
			<div data-options="name:'fCountCheckId'">成品计数质检编号</div> 
			<div data-options="name:'orderId'">订单编号</div>
		</div>     
    </div>  

</div>  
<!-- 111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 -->







<div id="fCountCheckEditWindow" class="easyui-window" title="编辑订单" data-options="modal:true,closed:true,resizable:true,iconCls:'icon-save',href:'f_count_check/edit'" style="width:80%;height:95%;padding:10px;">
</div>
<div id="fCountCheckAddWindow" class="easyui-window" title="添加订单" data-options="modal:true,closed:true,resizable:true,iconCls:'icon-save',href:'f_count_check/add'" style="width:80%;height:95%;padding:10px;">
</div>
<!-- ********************************************************************* -->
<div id="fCountOrderInfo" class="easyui-dialog" title="订单信息" data-options="modal:true,closed:true,resizable:true,iconCls:'icon-save'" style="width:65%;height:80%;padding:10px;">
	<form id="fCountOrderEditForm" method="post">
			<input type="hidden" name="orderId"/>
	    <table cellpadding="5">
	         <tr>
	            <td>订购客户:</td>
	            <td>
	            	<input id="custom" class="easyui-combobox" name="customId"   
    					data-options="required:true,valueField:'customId',textField:'customName',url:'custom/get_data'" />  
	            </td>
	        </tr>
	        <tr>
	            <td>订购产品:</td>
	            <td>
	            	<input id="product" class="easyui-combobox" name="productId"   
    					data-options="valueField:'productId',textField:'productName',url:'product/get_data'" />
    			</td>  
	        </tr>
	        <tr>
	            <td>订购数量:</td>
	            <td><input class="easyui-numberbox" type="text" name="quantity" data-options="min:1,max:99999999,precision:0,required:true" /></td>
	        </tr>
	        <tr>
	            <td>税前单价:</td>
	            <td><input class="easyui-numberbox" type="text" name="unitPrice" data-options="min:1,max:99999999,precision:2,required:true" />
	            	<input type="hidden" name="price"/>
	            </td>
	        </tr>
	        <tr>
	            <td>单位:</td>
	            <td><input  class="easyui-textbox" type="text" name="unit"></input></td>
	        </tr>
	        <tr>
	            <td>订单状态:</td>
	            <td>
		            <select id="cc" class="easyui-combobox" name="status" data-options="required:true,width:150">
						<option value="1">未开始</option>
						<option value="2">已开始</option>
						<option value="3">已完成</option>
						<option value="4">订单取消</option>
					</select>
				</td>
	        </tr>
	        <tr>
	            <td>订购日期:</td>
	            <td><input class="easyui-datetimebox" name="orderDate"     
        			data-options="required:true,showSeconds:true" value="5/5/2016 00:00:00" style="width:150px"> </td>
	        </tr>
	        <tr>
	            <td>要求日期:</td>
	            <td><input class="easyui-datetimebox" name="requestDate"     
        			data-options="required:true,showSeconds:true" value="5/5/2016 00:00:00" style="width:150px"> </td>
	        </tr>
	        <tr>
	            <td>合同扫描件:</td>
	            <td>
	            	 <a href="javascript:void(0)" class="easyui-linkbutton picFileUpload">上传图片</a>
	                 <input type="hidden" id="image" name="image"/>
	            </td>
	        </tr>
	        <tr>
	            <td>附件:</td>
	            <td>
	            	 <div id="fileuploader"><span id="fCountCheckFileSpan"></span></div>
	                 <input id="fCountCheckFile" type="hidden" name="file"/>
	            </td>
	        </tr>
	        <tr>
	            <td>商品描述:</td>
	            <td>
	                <textarea style="width:800px;height:300px;visibility:visible;" name="note"></textarea>
	            </td>
	        </tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitfCountOrderEditForm()">提交</a>
	</div>
</div>

<!-- ********************************************************************* -->

<div id="noteDialog" class="easyui-dialog" title="备注" data-options="modal:true,closed:true,resizable:true,iconCls:'icon-save'" style="width:55%;height:80%;padding:10px">
	<form id="noteForm" class="itemForm" method="post">
		<input type="hidden" name="fCountCheckId"/>
	    <table cellpadding="5" >
	        <tr>
	            <td>备注:</td>
	            <td>
	                <textarea style="width:800px;height:300px;visibility:hidden;" name="note"></textarea>
	            </td>
	        </tr>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateNote()">保存</a>
	</div>
</div>
<script>
function doSearch_fCountCheck(value,name){ //用户输入用户名,点击搜素,触发此函数  
	if(value == null || value == ''){
		$("#fCountCheckList").datagrid({
	        title:'订单列表', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get', nowrap:true,  
	        toolbar:"toolbar_fCountCheck", url:'f_count_check/list', method:'get', loadMsg:'数据加载中......',  fitColumns:true,//允许表格自动缩放,以适应父容器  
	        columns : [ [ 
	             	{field : 'ck', checkbox:true }, 
	             	{field : 'fCountCheckId', width : 100, title : '成品计数质检编号', align:'center'},
	             	{field : 'orderId', width : 100, align : 'center', title : '订单编号',formatter:formatOrder},
	             	{field : 'checkItem', width : 100, align : 'center', title : '检验项目'}, 
	             	{field : 'sample', width : 100, title : '样本总数', align:'center'}, 
	             	{field : 'checkNumber', width : 100, title : '抽检数', align:'center'}, 
	            	{field : 'unqualify', width : 100, title : '不合格数', align:'center'}, 
	             	{field : 'qualify', width : 100, title : '合格率', align:'center'}, 
	             	{field : 'cdate', width : 130, title : '检验时间', align:'center',formatter:TAOTAO.formatDateTime} ,
	             	{field : 'measureData', width : 100, title : '实际测量数据', align:'center'}, 
	            	{field : 'empId', width : 100, title : '检验人员编号', align:'center'}, 
	             	{field : 'result', width : 100, title : '检验结果', align:'center'}, 
	             	{field : 'note', width : 100, title : '备注', align:'center', formatter:formatNote} 
	        ] ],  
	    });
	}else{
		$("#fCountCheckList").datagrid({  
	        title:'订单列表', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get', nowrap:true,  
	        toolbar:"toolbar_fCountCheck", url:'f_count_check/search_fCountCheck_by_'+name+'?searchValue='+value, loadMsg:'数据加载中......',  fitColumns:true,//允许表格自动缩放,以适应父容器  
	        columns : [ [ 
					{field : 'ck', checkbox:true }, 
					{field : 'fCountCheckId', width : 100, title : '成品计数质检编号', align:'center'},
					{field : 'orderId', width : 100, align : 'center', title : '订单编号',formatter:formatOrder},
					{field : 'checkItem', width : 100, align : 'center', title : '检验项目'}, 
					{field : 'sample', width : 100, title : '样本总数', align:'center'}, 
					{field : 'checkNumber', width : 100, title : '抽检数', align:'center'}, 
					{field : 'unqualify', width : 100, title : '不合格数', align:'center'}, 
					{field : 'qualify', width : 100, title : '合格率', align:'center'}, 
					{field : 'cdate', width : 130, title : '检验时间', align:'center',formatter:TAOTAO.formatDateTime} ,
					{field : 'measureData', width : 100, title : '实际测量数据', align:'center'}, 
					{field : 'empId', width : 100, title : '检验人员编号', align:'center'}, 
					{field : 'result', width : 100, title : '检验结果', align:'center'}, 
					{field : 'note', width : 100, title : '备注', align:'center', formatter:formatNote} 
	        ] ],  
	    });
	}
}

	var noteEditor ;
	
	var fCountCheckOrderEditor;
	
	
	
	//格式化订单信息
	function formatOrder(value, row, index){
		if(value !=null && value != ''){
			return "<a href=javascript:openFCountOrder("+index+")>"+value+"</a>";
		}else{
			return "无";
		}
	};  

	//根据index拿到该行值
	function onFCountClickRow(index) {
		var rows = $('#fCountCheckList').datagrid('getRows');
		return rows[index];
		
	}
	
	//8989898989898989898989898989898989898989898989898989898989898989898989898989898989
	function  openFCountOrder(index){ 
		var row = onFCountClickRow(index);
		$("#fCountOrderInfo").dialog({
    		onOpen :function(){
    			$.get("order/get/"+row.orderId,'',function(data){
    				fCountCheckOrderEditor = TAOTAO.createEditor("#fCountOrderEditForm [name=note]");	
 		    		//回显数据
 	        		data.customId = data.custom.customId; 
 	        		data.productId = data.product.productId; 
 	        		data.orderDate = TAOTAO.formatDateTime(data.orderDate);
 	        		data.requestDate = TAOTAO.formatDateTime(data.requestDate);
 	        		$("#fCountOrderEditForm").form("load", data);
 	        		fCountCheckOrderEditor.html(data.note);
 	        			
 	        		TAOTAO.init({
 	        			"pics" : data.image,
 	        		});
 	        			
 	        		//加载上传过的文件
 	        		initFCountCheckUploadedFile();
    	    	});
    			
    		},
			onBeforeClose: function (event, ui) {
				// 关闭Dialog前移除编辑器
			   	KindEditor.remove("#fCountOrderEditForm [name=note]");
			   	clearFCountCheckUploadedFile();
			}
    	}).dialog("open");
	};
	
	//加载上传过的文件
	function initFCountCheckUploadedFile(){
		var files = $('#fCountCheckFile').val().split(","); 
		var k = false;
		for(var i in files){
			if(files[i] !=null && files[i] != ''){
				$("#fCountCheckFileSpan").append("<tr><td><a href='file/download?fileName="+files[i]+"'>" +
						"<span style='font-size: 12px;font-family: Microsoft YaHei;'>"
						+ files[i].substring(files[i].lastIndexOf("/")+1) + "</span></td><td></a> ");
				k = true;
			}
		}
		if(!k){
			$("#fCountCheckFileSpan").html("<span style='font-size: 16px;font-family: Microsoft YaHei;'>无</span>");
		}
	}
	function clearFCountCheckUploadedFile(){
		$("#fCountCheckFileSpan").html('');
	}
	
	//8989898989898989898989898989898989898989898989898989898989898989898989898989898989
	
	
	//打开产品信息对话框
	function  openFCountOrder1(index){ 
		var row = onFCountClickRow(index);
		$("#fCountOrderInfo").dialog({
    		onOpen :function(){
    			$.get("order/get/"+row.orderId,'',function(data){
    				fCountCheckOrderEditor = TAOTAO.createEditor("#fCountOrderEditForm [name=note]");	
		    		//回显数据
		    		$("#fCountOrderEditForm").form("load", data);
		    		fCountCheckOrderEditor.html(data.note);
		    		
		    		TAOTAO.init({
        				"pics" : data.image,
        			});
    	    	});
    		},
			onBeforeClose: function (event, ui) {
				// 关闭Dialog前移除编辑器
			   	KindEditor.remove("#fCountOrderEditForm [name=note]");
			}
    	}).dialog("open");
	};
	
	function submitfCountOrderEditForm(){
		$.get("order/edit_judge",'',function(data){
    		if(data.msg != null){
    			$.messager.alert('提示', data.msg);
    		}else{
    			if(!$('#fCountOrderEditForm').form('validate')){
    				$.messager.alert('提示','表单还未填写完成!');
    				return ;
    			}
    			fCountCheckOrderEditor.sync();
    			
    			$.post("order/update_all",$("#fCountOrderEditForm").serialize(), function(data){
    				if(data.status == 200){
    					$.messager.alert('提示','修改产品成功!','info',function(){
    						$("#fCountOrderInfo").dialog("close");
    					});
    				}else{
    					$.messager.alert('错误','修改产品失败!');
    				}
    			});
    		}
    	});
	}
	
	//打开订单要求富文本编辑器对话框
	function  openFCountNote(index){ 
		var row = onFCountClickRow(index);
		$("#fCountNoteDialog").dialog({
    		onOpen :function(){
    			$("#fCountNoteForm [name=orderId]").val(row.orderId);
    			fCountNoteEditor = TAOTAO.createEditor("#fCountNoteForm [name=note]");
    			fCountNoteEditor.html(row.note);
    		},
		
			onBeforeClose: function (event, ui) {
				// 关闭Dialog前移除编辑器
			   	KindEditor.remove("#fCountNoteForm [name=note]");
			}
    	}).dialog("open");
		
	};
	
	//更新订单要求
	function updateFCountNote(){
		$.get("order/edit_judge",'',function(data){
    		if(data.msg != null){
    			$.messager.alert('提示', data.msg);
    		}else{
    			fCountNoteEditor.sync();
    			$.post("order/update_note",$("#fCountNoteForm").serialize(), function(data){
    				if(data.status == 200){
    					$("#fCountNoteDialog").dialog("close");
    					$("#fCountCheckList").datagrid("reload");
    					$.messager.alert("操作提示", "更新订单要求成功！");
    				}else{
    					$.messager.alert("操作提示", "更新订单要求失败！");
    				}
    			});
    		}
    	});
	}
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////
	
	//格式化客户信息
	function formatCus(value){ 
//console.log(value);
	    return value.customName;
	};  
	
	//格式化产品信息
	function  formatPro(value){ 
/* console.log(value); */
	    return value.productName;
	};
	
	//格式化订单要求
	function formatNote(value, row, index){ 
		if(value !=null && value != ''){
			return "<a href=javascript:openNote("+index+")>"+"订单要求"+"</a>";
		}else{
			return "无";
		}
	}

	//根据index拿到该行值
	function onClickRow(index) {
		var rows = $('#fCountCheckList').datagrid('getRows');
		return rows[index];
		
	}
	
	//打开订单要求富文本编辑器对话框
	function  openNote(index){ 
		var row = onClickRow(index);
		$("#noteDialog").dialog({
    		onOpen :function(){
    			$("#noteForm [name=fCountCheckId]").val(row.fCountCheckId);
    			noteEditor = TAOTAO.createEditor("#noteForm [name=note]");
    			noteEditor.html(row.note);
    		},
		
			onBeforeClose: function (event, ui) {
				// 关闭Dialog前移除编辑器
			   	KindEditor.remove("#noteForm [name=note]");
			}
    	}).dialog("open");
		
	};
	/*
	//更新订单要求
	function updateNote(){
		noteEditor.sync();
		$.post("f_count_check/update_note",$("#noteForm").serialize(), function(data){
			if(data.status == 200){
				$("#noteDialog").dialog("close");
				$("#fCountCheckList").datagrid("reload");
				$.messager.alert("操作提示", "更新订单要求成功！");
			}else{
				$.messager.alert("操作提示", "更新订单要求失败！");
			}
		});
	}
	
	*/
	
	
	
	//更新订单要求
	function updateNote(){
		$.get("f_count_check/edit_judge",'',function(data){
    		if(data.msg != null){
    			$.messager.alert('提示', data.msg);
    		}else{
    			noteEditor.sync();
    			$.post("f_count_check/update_note",$("#noteForm").serialize(), function(data){
    				if(data.status == 200){
    					$("#noteDialog").dialog("close");
    					$("#fCountCheckList").datagrid("reload");
    					$.messager.alert("操作提示", "更新订单要求成功！");
    				}else{
    					$.messager.alert("操作提示", "更新订单要求失败！");
    				}
    			});
    		}
    	});
	}
	
function getSelectionsIds(){
    	
    	var sels = $("#fCountCheckList").datagrid("getSelections");
    	var ids = [];
    	for(var i in sels){
    		ids.push(sels[i].fCountCheckId);
console.log(sels[i].fCountCheckId);   		
    	}
    	ids = ids.join(","); 
    	return ids;
    }
    
    
    
    
    
    
    
    
//////////////////////////////////////////////////////////////////////////




function fCountCheck_add(){
	$.get("f_count_check/add_judge",'',function(data){
   		if(data.msg != null){
   			$.messager.alert('提示', data.msg);
   		}else{
   			$("#fCountCheckAddWindow").window("open");
   		}
   	});
}

function fCountCheck_edit(){
	$.get("f_count_check/edit_judge",'',function(data){
   		if(data.msg != null){
   			$.messager.alert('提示', data.msg);
   		}else{
   			var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','必须选择一个产品才能编辑!');
        		return ;
        	}
        	if(ids.indexOf(',') > 0){
        		$.messager.alert('提示','只能选择一个产品!');
        		return ;
        	}
        	
        	$("#fCountCheckEditWindow").window({
        		onLoad :function(){
        			//回显数据
        			var data = $("#fCountCheckList").datagrid("getSelections")[0];
        			data.cdate = TAOTAO.formatDateTime(data.cdate);
        			$("#fCountCheckEditForm").form("load", data);
        			fCountCheckEditEditor.html(data.note);
        			
        		}
        	}).window("open");
   		}
   	});
}

function fCountCheck_delete(){
	$.get("f_count_check/delete_judge",'',function(data){
   		if(data.msg != null){
   			$.messager.alert('提示', data.msg);
   		}else{
   			var ids = getSelectionsIds();
           	if(ids.length == 0){
           		$.messager.alert('提示','未选中订单!');
           		return ;
           	}
           	$.messager.confirm('确认','确定删除ID为 '+ids+' 的订单吗？',function(r){
           	    if (r){
           	    	var params = {"ids":ids};
                   	$.post("f_count_check/delete_batch",params, function(data){
               			if(data.status == 200){
               				$.messager.alert('提示','删除订单成功!',undefined,function(){
               					$("#fCountCheckList").datagrid("reload");
               				});
               			}
               		});
           	    }
           	});
   		}
   	});
}

function fCountCheck_reload(){
	$("#fCountCheckList").datagrid("reload");
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    var toolbar = [{
        text:'新增',
        iconCls:'icon-add',
        handler:function(){
        	$("#fCountCheckAddWindow").window("open");
        }
    },{
        text:'编辑',
        iconCls:'icon-edit',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','必须选择一个产品才能编辑!');
        		return ;
        	}
        	if(ids.indexOf(',') > 0){
        		$.messager.alert('提示','只能选择一个产品!');
        		return ;
        	}
        	
        	$("#fCountCheckEditWindow").window({
        		onLoad :function(){
        			//回显数据
        			var data = $("#fCountCheckList").datagrid("getSelections")[0];
        			data.cdate = TAOTAO.formatDateTime(data.cdate);
        			$("#fCountCheckEditForm").form("load", data);
        			fCountCheckEditEditor.html(data.note);
        			
        		}
        	}).window("open");
        }
    },{
        text:'删除',
        iconCls:'icon-cancel',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中订单!');
        		return ;
        	}
        	$.messager.confirm('确认','确定删除ID为 '+ids+' 的订单吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("f_count_check/delete_batch",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','删除订单成功!',undefined,function(){
            					$("#fCountCheckList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    },'-',{
        text:'刷新',
        iconCls:'icon-reload',
        handler:function(){
        	$("#fCountCheckList").datagrid("reload");
        }
    }];*/
</script>


<%------------------------------------- JQuery Easy UI Filter -------------------------------------%>
<!-- 
<style>
.icon-filter {
	background: url('image/filter.png') no-repeat center center;
}
</style>

<script>
	$(function() {
		var dg = $('#fCountCheckList').datagrid({
			filterBtnIconCls : 'icon-filter'
		});

		dg.datagrid('enableFilter');

	});
</script>
 -->
<%------------------------------------- JQuery Easy UI Filter -------------------------------------%>