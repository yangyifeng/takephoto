

<?php

$data = file_get_contents('php://input');
file_put_contents('test.jpg', $data);


exit;
if(isset($_FILES["Filedata"]["tmp_name"]) && $_FILES["Filedata"]["tmp_name"] != '')
{
	move_uploaded_file($_FILES["Filedata"]["tmp_name"], "upload/" . $_FILES["Filedata"]["name"]);	
	echo "success";
}
?>