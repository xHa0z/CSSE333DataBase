<!DOCTYPE html>
<html>
<body>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])&&!empty($_POST['tag'])&&!empty($_POST['event'])) {
        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $username=$_COOKIE['username'];
        $password=$_COOKIE['password'];
        $tag=$_POST['tag'];
        $event=$_POST['event'];
        $sql='DECLARE @Status SMALLINT
exec @Status=[addTag] @inUsername=?,@inPassword=?, @EventName=?,@Tagname=?
SELECT Status = @Status';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password,&$event,&$tag));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }

        if (sqlsrv_execute($stmt)) {
            $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
            if($row['Status']==2){
                print "No such tag";
            }else if($row['Status']==3){
                print "No such event";
            }else if($row['Status']==4){
                print "You can only modify your own event";
            }else if($row['Status']==5){
                print "Tag already exsit";
            }else{
                print "Tag successfully added";
            }
        }else{
            print "unknown error";
        }
    }else if(empty($_COOKIE['username'])||empty($_COOKIE['password'])){
        header('Location:login_required.php');
    }else if(empty($_POST['tag'])){
        print "Please enter tagname";
    }else{
        print "Please select an event";
    }

}else{
    header('Location:wp.php');
}
?>
</table>
<a href="wp.php">Return to HomePage</a>
</body>
</html>