{include file="header_no_user.tpl"}
<script type="text/javascript" src="js/design.js"></script>
{literal}
<script type="text/javascript" language="JavaScript">

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

    function ChangeStatus(pValue){
            document.getElementById(pValue).style.display = 'none';
            document.getElementById('tr_combo_'+pValue).style.display = 'inline';
            document.getElementById('tr_button_'+pValue).style.display = 'inline';
            LoadComboStatus(pValue);
    }

    function LoadComboStatus(pValue){
        freq();
        if(req){
            req.onreadystatechange = load_combo_status;
            url = 'contest_response.php?type=1&control_id='+pValue;
            req.open('GET', url, true);
            req.send(null);
        }
    }

    function load_combo_status(){
        if (req.readyState == 4) {
            if (req.status == 200){
                resp = req.responseText.split("&");
                document.getElementById('combo_status_'+resp[1]).innerHTML = resp[0];
            }
            else {
                return false;
            }
        }
    }

    function Change(pValue){
        if(document.getElementById('cbx_status_'+pValue).value !='-1'){
			freq();
			if(req){
				req.onreadystatechange = save_status;
				url = 'contest_response.php?type=0&id_order='+pValue+'&status='+document.getElementById('cbx_status_'+pValue).value;
				req.open('GET', url, true);
				req.send(null);
			}
		}
    }

    function save_status(){
        if (req.readyState == 4) {
            if (req.status == 200){
                resp = req.responseText;
				if(resp!=0){
					document.getElementById(resp).style.display = 'inline';
					document.getElementById('tr_combo_'+resp).style.display = 'none';
					document.getElementById('tr_button_'+resp).style.display = 'none';
				}
					document.getElementById('contest_form').submit();
            }
            else {
                return false;
            }
        }
    }

    function LoadNotes(pOrder){
        window.open('contest_notes.php?id_order='+pOrder,'name','height=200,width=500,left=700,top=400');
    }
	
	function LoadCancellation(pOrder){
		window.open('contest_cancellation.php?id_order='+pOrder,'name','height=200,width=500,left=700,top=400');
    }

</script>
<style>
    body {
    overflow-x: hidden;
    }
 </style>
{/literal}
{assign var="module_name" value="Pickup Contest Checklist"}
{include file="module_header.tpl"}
{if $error<>''}<br><b><font color="red">{$error}</font></b>{/if}
<br>
<form id="contest_form" method="post">
{assign var="table_width" value="650"}
{assign var="table_headertitle" value="Contest Work Orders</a>"}
{include file="table_header.tpl"}
<tr class="cell_reccolor_neutral_01">
    <td width="40px">WO</td>
    <td width="150px">Status</td>
    <td width="200px">Salesman</td>
    <td width="50px">Contest Date</td>
    <td width="70px">Reason for Cancellation</td>
    <td width="70px">Notes</td>
</tr>
{assign var="columns" value="0,1,2,3,4,5"}
{section name=idx loop=$data}
{assign var="_i_" value=$smarty.section.idx.index}
    {if $_i_ is even}{assign var="_j_" value="1"}{else}{assign var="_j_" value="0"}{/if}
    <tr align="center" valign="top" onMouseOver="RowOver({$_i_})" onMouseOut="RowOut({$_i_})" height="20">
        <td class="row{$_j_}{cycle name="parity" values="0,1"}" id="{$_i_}{cycle name="col_cycle" values="$columns"}"><a name="{$data[idx].id}"></a>{$data[idx].id}</td>
        <td width="100px" class="row{$_j_}{cycle name="parity" values="0,1"}" id="{$_i_}{cycle name="col_cycle" values="$columns"}">
            <table  width="90px" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td>
                        {if $data[idx].cstatus eq 'N'}<input type="button" id="{$data[idx].id}" value="New" style="background-color:#FF0000;font-weight:bold; text-align: center; width:100px" onclick="ChangeStatus({$data[idx].id});"/>
                        {elseif $data[idx].cstatus eq 'T'}<input type="button" id="{$data[idx].id}" value="Taken" style="background-color:#FFFF00;font-weight:bold; text-align: center; width:100px" onclick="ChangeStatus({$data[idx].id});"/>
                        {elseif $data[idx].cstatus eq 'U'}<input type="button" id="{$data[idx].id}" value="Uploaded" style="background-color:#66FF00;font-weight:bold; text-align: center; width:100px" onclick="ChangeStatus({$data[idx].id});"/>
                        {elseif $data[idx].cstatus eq 'C'}<input type="button" id="{$data[idx].id}" value="Cancel" style="background-color:#000000;font-weight:bold;color:#FFFFFF; text-align: center;  width:100px" onclick="ChangeStatus({$data[idx].id});"/>
                        {/if}
                    </td>
                </tr>
                <tr>
                    <td id="tr_combo_{$data[idx].id}" style="display:none;"><a id="combo_status_{$data[idx].id}"></a></td>
                    <td id="tr_button_{$data[idx].id}" style="display:none;"><img id="save_button_{$data[idx].id}" src="./cennik/dhtmlx/imgs/icons/Add.png" onclick="Change({$data[idx].id})"/></td>
                </tr>
            </table>
        </td>
        <td class="row{$_j_}{cycle name="parity" values="0,1"}" id="{$_i_}{cycle name="col_cycle" values="$columns"}"><a name="#">{$data[idx].cr_name}</a></td>
        <td class="row{$_j_}{cycle name="parity" values="0,1"}" id="{$_i_}{cycle name="col_cycle" values="$columns"}"><a name="#">{$data[idx].pickup_dates}</a></td>
        <td class="row{$_j_}{cycle name="parity" values="0,1"}" id="{$_i_}{cycle name="col_cycle" values="$columns"}"><center>
        {if $data[idx].cstatus eq 'C'}<img id="cancellation_button_{$data[idx].id}" src="./pic/images/failed.png" width="20" height="20" 
        onclick="LoadCancellation({$data[idx].id});" alt="Click here for show Cancellation Details"/>
        {else}--
        {/if}
        </center>
        </td>
        <td class="row{$_j_}{cycle name="parity" values="0,1"}" id="{$_i_}{cycle name="col_cycle" values="$columns"}">
        	<a href="javascript:LoadNotes({$data[idx].id});" id="add_notes">Add Notes</a>
         </td>
    </tr>
{/section}
{include file="table_footer.tpl"}
</form>