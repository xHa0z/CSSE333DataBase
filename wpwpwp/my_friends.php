<!DOCTYPE html>
<html>
<body>
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
$sql='exec [my_friends] @Username=?,@Password=? ';
$stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password));
if (!$stmt) {
    die(print_r(sqlsrv_errors(), true));
}

if (sqlsrv_execute($stmt)) {
if($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)){
?>
<table style="width:50%" border="1px solid black">
    <tr><th colspan="3">My Friend List</th></tr>
    <tr>
        <td>Username</td>
        <td>Contact</td>
        <td>NickName</td>
    </tr>

    <tr>
        <td><?=$row[0]?></td>
        <td><?=$row[1]?></td>
        <td><?=$row[2]?></td>

    </tr>
    <?php
    }
    while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)) {
        ?>
        <tr>
            <td><?=$row[0]?></td>
            <td><?=$row[1]?></td>
            <td><?=$row[2]?></td>

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