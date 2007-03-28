<?
/**

* @desc<pre>Smarty plugin
* -------------------------------------------------------------
* File:     modifier.phone_format.php
* Type:     modifier
* Name:     format_phone
* Purpose:  format a US-style 10-digit phone number
* -------------------------------------------------------------
*</pre>
* @param string $number a phone number
* @param $format a printf style format string
* @return string $number, the number formatted if 10 digits, else original untouched.
* @author dmintz@davidmintz.org
*/


function smarty_modifier_phone_format($number, $format="(%s) %s-%s") {

   $original = $number;
   $number = preg_replace("/\D/","",$number);
   if (strlen($number) != 10) return $original;
   return  sprintf(
         $format,
         substr($number,0,3),
         substr($number,3,3),
         substr($number,6,4)
      );
}

$dbhost = "localhost";
$dblogi = "diopa_diopa";
$dbpass = "4242206482";
$dbbase = "diopa_modx";
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
$deanerySearch =  ($_GET['deanerySearch']) ? $_GET['deanerySearch'] : '';

if ($deanerySearch === '') {
	$whereClause = "org_name LIKE '%%" . $nameSearch . "%%' OR org_address_city LIKE '%%" . $nameSearch . "%%'";
} else { 
//	$whereClause = "org_deanery = '" . $deanerySearch . "'";
	$whereClause = "(org_name LIKE '%%" . $nameSearch . "%%' OR org_address_city LIKE '%%" . $nameSearch . "%%') AND org_deanery = '" . $deanerySearch . "'";
}

$lp_sql="SELECT * FROM directory_orgs WHERE " . $whereClause .  " ORDER BY " . $sort_col . " " . $sort_dir;
$result = mysql_query($lp_sql) or die("Error: " . mysql_error());
$nb_msg = mysql_num_rows($result);

// HTML Output Begins
$html = '<table id="churches">';
while ($msg_data = mysql_fetch_array($result))
	{		
		$id = $msg_data['org_id'];
		$name = $msg_data['org_name'];
		$address_line1 = $msg_data['org_address_line1'];
		$address_line2 = $msg_data['org_address_line2'];
		$address_state = $msg_data['org_address_state'];
		$address_city = $msg_data['org_address_city'];
		$address_zip = substr($msg_data['org_address_zip'],0,5);
		$phone = smarty_modifier_phone_format($msg_data['org_phone']);
		if ($msg_data['org_fax'] != "" ) {	
			$fax = smarty_modifier_phone_format($msg_data['org_fax']) . " F";
		}
		$website = ($msg_data['org_website_url'] <> '') ? ('<a href="http://' . $msg_data['org_website_url'] . '" target="_blank" class="external">Website</a>') : '' ;
		$deanery = $msg_data['org_deanery'];
		$lat = is_numeric($msg_data['lat']) ? $msg_data['lat'] : 0 ;
		$lng = is_numeric($msg_data['lng']) ? $msg_data['lng'] : 0 ;
		$directions_address =  $msg_data['org_address_line1'] . ', ' . $msg_data['org_address_city'] . ', ' . $msg_data['org_address_state'] . ' ' . $msg_data['org_address_zip'];
		$directions_link =  <<<EOT
<a href="http://maps.google.com/maps?f=d&amp;hl=en&amp;saddr=<script>$F('searchByAddress')</script>&amp;daddr=$address_line1,$address_city,%20$address_state%20$address_zip&amp;ie=UTF8&amp;om=1" target="_blank" class="external">Directions</a>
EOT;
		$html .= <<<EOT
	<tr>
		<td class="name">
			$name			
			<div id="content$id" style="display: none;">
				<strong>$name</strong><br />
				$address_line1<br />
				$address_city, $address_state $address_zip<br />
				$phone Phone<br />
				$website
			</div>
			<script language="javascript" type="text/javascript">
				if( !($lat== 0) && !($lng==0) ) {
					var content$id = $('content$id').innerHTML;
					var point = new GLatLng($lat,$lng);
					marker$id = new GMarker(point, redicon);
		        	map.addOverlay(marker$id);
				  	GEvent.addListener(
						marker$id,
						"click", 
						function() {
				    		marker$id.openInfoWindowHtml(content$id);
						}
					);
				}
			</script>
		</td>
		<td class="address">$address_line1<br />$address_city, $address_state $address_zip</td>
		<td class="phone">$phone<br/>$fax</td>
		<td class="deanery">$deanery</td>
		<td class="website">$directions_link<br />$website</td>
	</tr>
EOT;
	}
mysql_close();
$html .='</table>';
echo $html;
?>
