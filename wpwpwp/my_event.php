<!DOCTYPE html>
<html>
<body>
<table style="width:70%" border="1px solid black">
    <tr>
        <td>EventName</td>
        <td>Starting Date</td>
        <td>Ending Date</td>
        <td>Location</td>
        <td>Type</td>
    </tr>
<?php
if(empty($_COOKIE['username'])||empty($_COOKIE['password'])){
    header('Location:login_required.php');
}else{
$serverName = "titan.csse.rose­hulman.edu";
$connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
$conn = sqlsrv_connect($serverName, $connectionInfo);
if ($conn === false) {
    die(print_r(sqlsrv_errors(), true));
}
$username=$_COOKIE['username'];
$password=$_COOKIE['password'];
$sql='exec [my_event] @inUsername=?,@inPassword=? ';
$stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password));
if (!$stmt) {
    die(print_r(sqlsrv_errors(), true));
}

if (sqlsrv_execute($stmt)) {
if($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)){
?>

    <tr>
        <td><?=$row[0]?></td>
        <td><?=$row[1]->format('m/d/Y')?></td>
        <td><?=$row[2]->format('m/d/Y')?></td>
        <td><?=$row[3]?></td>
        <td><?=$row[5]?></td>
    </tr>
    <?php
    }
    while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)) {
        ?>
        <tr>
            <td><?=$row[0]?></td>
            <td><?=$row[1]->format('m/d/Y')?></td>
            <td><?=$row[2]->format('m/d/Y')?></td>
            <td><?=$row[3]?></td>
            <td><?=$row[5]?></td>
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