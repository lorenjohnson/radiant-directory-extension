<?
function clean_phone($phone)
{
  $p = strtolower($phone);
  for ($i=0;$i<strlen($p);$i++)
  {
    $a = ord(substr($p, $i, 1));
    // If ( Not Numeric ) or ( Not 'x' )
    if ((($a >= 48) && ($a <= 57)) || ($a == 120)) $r .= substr($p, $i, 1);
  }
  return $r;
}

function format_phone($phone)
{
  $phone = clean_phone($phone);
  $ret = "";
  $ext = "";
  $i = strpos($phone,'x');
  if (!($i === false))
  {
    // Contains extension
    $ext = "x".substr($phone,$i);
    $phone = substr($phone,0,$i);
  }
  // Phones with no extension
  switch(strlen($phone))
  {
    case 7:
      $ret = substr($phone, 0, 3)."-".substr($phone, 3);
      break;
    case 8:
      $ret = substr($phone, 0, 4)."-".substr($phone, 4);
      break;
    case 10:
      $ret = "(".substr($phone, 0, 3).") ".substr($phone, 3, 3)."-".substr($phone, 6, 4);
      break;
    default:
      $ret = $phone;
  }
  return $ret.$ext;
}    
?>