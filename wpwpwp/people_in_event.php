<!DOCTYPE html>
<html>
<body>
<?php
if(empty($_COOKIE['username'])||empty($_COOKIE['password'])){
    header('Location:login_required.php');
}else{?>
<table style="width:20%" border="1px solid black">
    <tr>
        <td>Usernames</td>
    </tr>
    <?php
    $serverName = "titan.csse.rose­hulman.edu";
    $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
    $conn = sqlsrv_connect($serverName, $connectionInfo);
    if ($conn === false) {
        die(print_r(sqlsrv_errors(), true));
    }
    $event=$_POST['event'];
    $sql='exec [check_people_in_event] @eventName=?';
    $stmt = sqlsrv_prepare($conn, $sql,array(&$event));
    if (!$stmt) {
        die(print_r(sqlsrv_errors(), true));
    }

    if (sqlsrv_execute($stmt)) {
        if ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)) {
            ?>
            <tr>
                <td><?= $row[0] ?></td>
            </tr>
        <?php
        }
        while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_NUMERIC)) {
            ?>
            <tr>
                <td><?= $row[0] ?></td>
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