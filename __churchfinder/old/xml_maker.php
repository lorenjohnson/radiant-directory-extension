<?
$dbhost = "localhost";
$dblogi = "fngroup";
$dbpass = "500400590";
$dbbase = "fngroup_diopa";
$db = @mysql_connect("$dbhost", "$dblogi", "$dbpass") OR DIE("Database is down !");
@mysql_select_db("$dbbase",$db) OR DIE;
//Set up the vars for sorting and page counter
$pagesize = ($_GET['pagesize']) ? $_GET['pagesize'] : 10;
$offset = ($_GET['offset']) ? $_GET['offset'] : 0;
$sort_col = ($_GET['sort_col']) ? $_GET['sort_col'] : 'org_name';
// Setup the column to sort... This is how Chris made the sorting...I ll try the Rico/Ken way 
//later (using opts parameter)
switch($sort_col){
	case("Name"):
		$sort_col="org_name";
		break;
	case("Address"):
		$sort_col="org_address_line1";
		break;
	case("Phone"):
		$sort_col="org_phone";
		break;
	case("Deanery"):
		$sort_col="org_deanery";
		break;
	default : $sort_col="org_name";
}
//Setup the sorting direction
$sort_dir = ($_GET['sort_dir']) ? $_GET['sort_dir'] : 'ASC';
$nameSearch =  ($_GET['nameSearch']) ? $_GET['nameSearch'] : '';

//Request to fill the live grid
$lp_sql="SELECT * FROM directory_orgs WHERE org_name LIKE '%%" . $nameSearch . "%%' ORDER BY " . $sort_col . " " . $sort_dir ." LIMIT " .$offset. ", ".$pagesize;
$result = mysql_query($lp_sql) or die("Error: ".mysql_error());
$nb_msg = mysql_num_rows($result);

// XML Output Begins
header("Content-Type: text/xml");
$xml = '<'.'?xml version="1.0" encoding="ISO-8859-1"?'.'>';
$xml .= '<ajax-response><response type="object" id="data_grid_updater"><rows update_ui="true">';
$i = $nb_msg;
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
		$website_url = "http://" . $msg_data['org_website_url'];
		$deanery = $msg_data['org_deanery'];
		$lat = $msg_data['lat'];
		$lng = $msg_data['lng'];
$xml .= <<<EOT
		<tr>
			<td>$name</td>
			<td>$address_line1</td>
			<td>$address_city</td>
			<td>$address_state</td>
			<td>$address_zip</td>
			<td>$phone</td>
			<td>$fax</td>
			<td><a href="$website_url">Website</a></td>
			<td>$deanery</td> 
			<td>$address_line1, $address_city, $address_state $address_zip</td>
			<td>$lat</td>
			<td>$lng</td> 
		</tr>
EOT;
$i++;
	}
mysql_close();
$xml .='</rows></response></ajax-response>';
echo $xml;
?>
