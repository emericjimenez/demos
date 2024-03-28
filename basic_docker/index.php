<?php
function show()
{
if (isset($_POST["txtTest"]))
{
        $txtSend = $_POST["txtTest"];
            $txtSend = str_replace("\"", "", $txtSend);

        if (!empty($txtSend)) {                 
                $file_ip = fopen("ip.txt", 'r');
                $ip_local = fread($file_ip, filesize("ip.txt"));
                fclose($file_ip);
                
                echo $ip_local;

                $url = "http://".$ip_local.":9000/";
        $data = array(
                "send1" => $txtSend,
        );
        $options = array(
                'http' => array(
                        'header' => "Content-type: application/json\r\n",
                        'method' => 'POST',
                        'content' => json_encode($data),
                ),
        );

        $context = stream_context_create($options);
        $result = file_get_contents($url, false, $context);
        if ($result === FALSE) {
                die('Error!!!');
        }
        $data = json_decode($result, true);
            $reply = $data['message'];
                return "<h2><strong>REPLY: ".$reply."</strong></h2>";
        }
        else
{
        return "<h2><strong>NO VALID</h2></strong>";
}
}
}
?>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Docker Fast Api</title>
</head>

<body>
<p>
        <form action="index.php" method="post">
  <label for="txtTest">Insert text:</label>
  <input type="text" name="txtTest" id="txtTest">
  <br>
  <input type="submit" name="submit" id="submit" value="Send">
        </form>
</p>
<p><?php if ( $_SERVER['REQUEST_METHOD'] == 'POST' ) { echo show();} ?></p>
</body>
</html>