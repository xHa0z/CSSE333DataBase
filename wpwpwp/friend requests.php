<!DOCTYPE html>
<html>
<body>
<?php
if(empty($_COOKIE['username'])||empty($_COOKIE['password'])){
    header('Location:login_required.php');
}else{?>
<table style="width:50%" border="1px solid black">
    <tr><th colspan="4">Friend Request Received</th></tr>
    <tr>
        <td>Sender's Username</td>
        <td>Action</td>
    </tr>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['commit']=='confirm'){
        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $username=$_COOKIE['username'];
        $password=$_COOKIE['password'];
        $tar=$_POST["tar"];
        $sql='exec [confirm_request] @inUsername=?,@inPassword=?,@SenderName=? ';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password,&$tar));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }

        sqlsrv_execute($stmt);
    }
}
$serverName = "titan.csse.rose­hulman.edu";
$connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
$conn = sqlsrv_connect($serverName, $connectionInfo);
if ($conn === false) {
    die(print_r(sqlsrv_errors(), true));
}
$username=$_COOKIE['username'];
$password=$_COOKIE['password'];
$sql='exec [check_request] @inUsername=?,@inPassword=? ';
$stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password));
if (!$stmt) {
    die(print_r(sqlsrv_errors(), true));
}

if (sqlsrv_execute($stmt)) {
if($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)){
?>
    <tr>
        <td><?=$row[1]?></td>
        <td><form  method="post" action=""  >
                <input type="text" name="tar" value="<?=$row[1]?>" hidden>
                <input id="delete" type="submit" name="commit" value="confirm">
                <input id="delete" type="submit" name="commit" value="delete">
            </form></td>

    </tr>
    <?php
    }
    while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)) {
        ?>
        <tr>
            <td><?=$row[1]?></td>
            <td><?=$row[1]?></td>
        </tr>
    <?php
    }
    }
}
    ?>
</table>
<a href="wp.php">Return to HomePage</a>
</body>
</html>