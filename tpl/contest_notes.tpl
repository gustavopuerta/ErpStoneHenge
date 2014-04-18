{include file="header_no_user.tpl"}
<script type="text/javascript" src="js/design.js"></script>
{literal}
<script type="text/javascript" language="javascript">
	//AJAX FUNCTION
    function freq(){
        req = false;
        if(window.XMLHttpRequest) {
            try{req = new XMLHttpRequest();}
            catch(e){req = false;}}
        else if(window.ActiveXObject){try{req = new ActiveXObject("Msxml2.XMLHTTP");}
        catch(e){try{req = new ActiveXObject("Microsoft.XMLHTTP");}
        catch(e){req = false;}}}}
       //
	
	
	function GetClose(){
		this.close();
	}
	
	function LoadData(){
		freq();
		if(req){
			req.onreadystatechange = load_data_text;
			url = './contest_response.php?type=4&id_order='+document.getElementById('id_order').value;
			req.open('GET', url, true);
			req.send(null);
		}
	}
	
	function load_data_text(){
        if (req.readyState == 4) {
            if (req.status == 200){
                resp = req.responseText;
				document.getElementById('notes').value=resp;
            }
            else {
                return false;
            }
        }
    }
	
	function save(){
		freq();
		if(req){
			req.onreadystatechange = save_cancellation;
			url = './contest_response.php?type=5&id_order='+document.getElementById('id_order').value+'&text='+document.getElementById('notes').value;
			req.open('GET', url, true);
			req.send(null);
		}
    }

    function save_cancellation(){
        if (req.readyState == 4) {
            if (req.status == 200){
                resp = req.responseText;
                if(resp==1)
					GetClose();
					
            }
            else {
                return false;
            }
        }
    }
	
	
</script>
{/literal}
{if $error<>''}<br><b><font color="red">{$error}</font></b>{/if}
<br>
<form id="form_contest_note" method="post">
{assign var="table_width" value="350"}
{assign var="table_headertitle" value="Add Notes:"}
{include file="table_header.tpl"}
<tr>
    <td align="center">
        <textarea id="notes" rows="3" cols="40" maxlength="200"></textarea>
    </td>
</tr>
<tr>
    <td align="right"><input type="button" value="Save" onclick="save();" class="BUTTON_OK">&nbsp;<input type="button" value="Cancel" class="BUTTON_OK" onclick="GetClose();">&nbsp;</td>
</tr>
<tr>
    <td><input id="id_order" type="hidden" value="{php}echo $_GET['id_order'];{/php}" /></td>
</tr>
{include file="table_footer.tpl"}
</form>
{literal}
<script type="text/javascript" language="javascript">
LoadData();
</script>
{/literal}