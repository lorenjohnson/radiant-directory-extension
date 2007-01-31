<?
$dbhost = "localhost";
$dblogi = "fngroup";
$dbpass = "500400590";
$dbbase = "fngroup_diopa";
$db = @mysql_connect("$dbhost", "$dblogi", "$dbpass") OR DIE("Database is down !");
@mysql_select_db("$dbbase",$db) OR DIE;

$lp_sql="SELECT * FROM directory_deaneries ORDER BY deanery";
$result = mysql_query($lp_sql) or die("Error: ".mysql_error());
$nb_msg = mysql_num_rows($result);

$html = '<select name="deaneries">';

while ($msg_data = mysql_fetch_array($result))
	{		
		$id = $msg_data['deanery_id'];
		$deanery = $msg_data['deanery'];
		$html .= <<<EOT
	
		<option value="$deanery">$deanery</option>

EOT;
	}
mysql_close();
$html .='</select>';
echo $html;
?>
