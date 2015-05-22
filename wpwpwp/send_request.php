<!DOCTYPE html>
<html>
<body>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])&&!empty($_POST['tar'])) {
        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $username=$_COOKIE['username'];
        $password=$_COOKIE['password'];
        $tar=$_POST['tar'];
        $sql='DECLARE @Status SMALLINT
exec @Status=[send_request] @inUsername=?,@inPassword=?, @Username=?
SELECT Status = @Status';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password,&$tar));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }

        if (sqlsrv_execute($stmt)) {
            $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
            if($row['Status']==2){
                print "The target username is not correct";
            }else if($row['Status']==3){
                print "You cannot be a friend with yourself";
            }else if($row['Status']==4){
                print "You are already friends";
            }else{
                print "Your Request is Successfully Sent";
            }
        }else{
            print "You've already sent the request";
        }
    }else if(empty($_COOKIE['username'])||empty($_COOKIE['password'])){
        header('Location:login_required.php');
    }else if(empty($_POST['tar'])){
        print "Please enter the target's username";
    }

}else{
    header('Location:wp.php');
}
    ?>
</table>
<a href="wp.php">Return to HomePage</a>
</body>
</html>