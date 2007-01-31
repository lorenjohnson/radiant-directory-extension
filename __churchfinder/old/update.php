<?
$id = $_GET['org_id'];
$update_record = $modx->db->select("*", "directory_orgs", "org_id =".$id);
$name = $update_record['org_name'];
?>

<form method=post>
	<fieldset>
		<legend>Update Parish Record</legend>
		<p>
			<label type="text" id="name" value="<?= $name ?>" /><br />
 			<input type="text" id="name" name="name" tabindex="1" />
		</p>
		<p>
			<label type="text" id="address_line1" value="<?= $address_line1 ?>"/><br />
 			<input type="text" id="address_line1"  name="address_line1" tabindex="2" />
		</p>
		<p>
			<label type="text" id="address_line2" /><br />
 			<input type="text" id="address_line2" name="address_line2" />
		</p>
		<p>
			<label type="text" id="address_city" /><br />
			<input type="text" id="address_city" name="address_city" tabindex="3" />
 		</p>
		<p>
			<label type="text" id="address_state" /><br />
			<input type="text" id="address_state" name="address_state" tabindex="4" />
 		</p>
		<p>
			<label type="text" id="address_zip" /><br />
			<input type="text" id="address_zip" name="address_zip" tabindex="5" />
 		</p>
		<p>
			<label type="text" id="phone" /><br />
			<input type="text" id="phone" name="phone" tabindex="6" />
 		</p>
		<p>
			<label type="text" id="fax" /><br />
			<input type="text" id="fax" name="fax" tabindex="7" />
 		</p>
		<p>
			<label type="text" id="website_url" /><br />
			<input type="text" id="website_url" name="website_url" tabindex="8" />
 		</p>
		<p>
			<label type="text" id="deanery" /><br />
			<input type="text" id="deanery" name="deanery" tabindex="9" />
 		</p>
		<p>
			<input type="submit" value="Update" tabindex="10" />
		</p>
	</fieldset>
</form>
