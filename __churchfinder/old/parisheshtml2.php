<?
$dbhost = "localhost";
$dblogi = "fngroup";
$dbpass = "500400590";
$dbbase = "fngroup_diopa";
$db = @mysql_connect("$dbhost", "$dblogi", "$dbpass") OR DIE("Database is down !");
@mysql_select_db("$dbbase",$db) OR DIE;

//Set up the vars for sorting and page counter
/* $pagesize = ($_GET['pagesize']) ? $_GET['pagesize'] : 10;
$offset = ($_GET['offset']) ? $_GET['offset'] : 0;
$sort_col = ($_GET['sort_col']) ? $_GET['sort_col'] : 'org_name'; */

// Setup sorting columns
switch($sort_col){
	case("name"):
		$sort_col="org_name";
		break;
	case("address_city"):
		$sort_col="org_address_city";
		break;
	case("deanery"):
		$sort_col="org_deanery";
		break;
	default : $sort_col="org_name";
}
//Setup the sorting direction
$sort_dir = ($_GET['sort_dir']) ? $_GET['sort_dir'] : 'ASC';
$nameSearch =  ($_GET['nameSearch']) ? $_GET['nameSearch'] : '';

//Request to fill the live grid
$lp_sql="SELECT * FROM directory_orgs WHERE org_name LIKE '%%" . $nameSearch . "%%' OR org_address_city LIKE '%%" . $nameSearch . "%%' ORDER BY " . $sort_col . " " . $sort_dir;
$result = mysql_query($lp_sql) or die("Error: ".mysql_error());
$nb_msg = mysql_num_rows($result);

// HTML Output Begins
/* header("Content-Type: text/html"); */

$html = '<table id="parishes">';

while ($msg_data = mysql_fetch_array($result))
	{		
		$id = $msg_data['org_id'];
		$name = $msg_data['org_name'];
		$address_line1 = $msg_data['org_address_line1'];
		$address_line2 = $msg_data['org_address_line2'];
		$address_state = $msg_data['org_address_state'];
		$address_city = $msg_data['org_address_city'];
		$address_zip = substr($msg_data['org_address_zip'],0,5);
		$phone = $msg_data['org_phone'];
		$fax = $msg_data['org_fax'];
		$website = ($msg_data['org_website_url'] <> '') ? ('<a href="http://' . $msg_data['org_website_url'] . '">Website</a>') : '' ;
		$deanery = $msg_data['org_deanery'];
		$lat = is_numeric($msg_data['lat']) ? $msg_data['lat'] : 0 ;
		$lng = is_numeric($msg_data['lng']) ? $msg_data['lng'] : 0 ;
		$html .= <<<EOT
	<tr id="$id">
		<td style="width:0px;display:none;">$id</td>
		<td style="width:0px;display:none;"><strong>$name</strong><br />$address_line1<br />$address_city, $address_state $address_zip<br />$phone<br />$website</td>
		<td style="width:0px;display:none;">$lat</td>
		<td style="width:0px;display:none;">$lng</td>
		<td style="width:200px;">$name</td>
		<td style="width:200px;">$address_line1<br />$address_city, $address_state $address_zip</td>
		<td style="width:100px;">$phone<br/>$fax</td>
		<td style="width:60px;">$website</td>
		<td style="width:100px;">$deanery
		</td> 
	</tr>
EOT;
	}
mysql_close();
$html .='</table>';
echo $html;
?>