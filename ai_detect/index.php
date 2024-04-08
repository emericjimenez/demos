<?php

function examine_text()
{
        if (isset($_POST["txtText"]))
        {
			$txtText = $_POST['txtText'];
			$file_ip = fopen("ip.txt", 'r');
                $ip_local = trim(fread($file_ip, filesize("ip.txt")));
                fclose($file_ip);                

            $url = "http://".trim($ip_local).":9000/";			
			$data = array(
				'key1' => $txtText,    
			);
			$options = array(
				'http' => array(
				'header' => "Content-type: application/json\r\n",
				'method' => 'POST',
				'content' => json_encode($data, JSON_UNESCAPED_UNICODE),
				),
			);
			$context = stream_context_create($options);
			$result = file_get_contents($url, false, $context);
			if ($result === FALSE) {
				die('Error.');
			}
			echo $result;
        }
        else{
                return "";
        }
}

?>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>AI DETECTOR</title>
</head>

<body>
<form id="form1" name="form1" action="index.php" method="post">
	<textarea rows = "15" cols = "60" name = "txtText" id="txtText"></textarea><br>
	<input type="submit"><br>
	<?php if ( $_SERVER['REQUEST_METHOD'] == 'POST' ) {echo examine_text();}?>
</form>
</body>
</html>