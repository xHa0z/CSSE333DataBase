<!DOCTYPE html>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
if($_REQUEST['submit_type']=='logout'){
    setcookie('username', null, time() - (86400 * 30), "/");
    setcookie('password', null, time() - (86400 * 30), "/");
    die("<script> window.location.assign('http://localhost/wpwpwp/wp.php');</script>");
}
}
?>

<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
if($_REQUEST['submit_type']=='login'){
if(empty($_REQUEST['username']) || empty($_REQUEST['password']) ){
}else{
    $username=$_POST["username"];
    $password=$_POST["password"];

    $serverName = "titan.csse.rose­hulman.edu";
    $connectionInfo = array( "Database"=>"wp3", "UID"=>"hua", "PWD"=>"daohaode");
    $conn = sqlsrv_connect( $serverName, $connectionInfo);
    if( $conn === false) {
        die( print_r( sqlsrv_errors(), true));
    }
    $sql="
DECLARE @Status SMALLINT
EXEC @Status = [Login] @Username=?, @Password=?
SELECT Status = @Status
";
    $stmt = sqlsrv_prepare($conn, $sql, array(&$username,&$password));
    if( !$stmt ) {
        die( print_r( sqlsrv_errors(), true));
    }
    if(sqlsrv_execute($stmt)) {
        $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);
        if(!$row['Status']){
            setcookie('username', $username, time() + (86400 * 30), "/");
            setcookie('password', $password, time() + (86400 * 30), "/");
            die("<script> window.location.assign('http://localhost/wpwpwp/wp.php');</script>");
        }else{
        }
    }
}
}
}
?>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>WpWpWp</title>
    <link  href="wp.css" type="text/css" rel="stylesheet"/>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" type="text/css" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js" type="text/javascript"></script>
    <script src="wp.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <div>
        <span id="login">Log In</span>
        <span id="register">Register</span>
        <span id="userinfo" hidden></span>
        <span id="logout" hidden>Log Out</span>
    </div>
    <div class="row" style="margin-top:20px">
        <div class="col-md-2" >
            <div class="btn btn-success" id="greenbut">Create Event</div>
        </div>
        <div class="col-md-2" >
            <div class="btn btn-info" id="bluebut">Edit Event</div>
        </div>
        <div class="col-md-2" >
            <div class="btn btn-danger" id="redbut">Delete Event</div>
        </div>
        <div class="col-md-2" >
            <div class="btn btn-warning" id="orangebut">Search Event</div>
        </div>
        <div class="col-md-2" >
            <div class="btn btn-success" id="join_but">Join Event</div>
        </div>
        <div class="col-md-2" >
            <div class="btn btn-info" id="invitation">Invitation</div>
        </div>

    </div>
</div>
<div class="container" style="width: 100%">
    <div class="row" style="margin-top:20px">
        <div class="col-md-1" >
            <form  method="post" action="my_event.php"  >
                <button class="btn btn-success" type="submit" name="commit">My Events</button>
            </form>
        </div>
        <div class="col-md-1" >
            <form  method="post" action="my_friends.php"  >
                <button class="btn btn-info" type="submit" name="commit">My Friends</button>
            </form>
        </div>
        <div class="col-md-1" >
            <form  method="post" action="friends_and_event.php"  >
                <button class="btn btn-danger" type="submit" name="commit">Friends & Events</button>
            </form>
        </div>
        <div class="col-md-1" >
            <form  method="post" action="check_joined_event.php"  >
                <button class="btn btn-warning" type="submit" name="commit">My joined Events</button>
            </form>
        </div>
        <div class="col-md-1" >
            <form  method="post" action="current_event.php"  >
                <button class="btn btn-success" type="submit" name="commit">My Current Events</button>
            </form>
        </div>
        <div class="col-md-1" >
            <form  method="post" action="chech_my_org.php"  >
                <button class="btn btn-info" type="submit" name="commit">My Organizations</button>
            </form>
        </div>
        <div class="col-md-1" >
            <form  method="post" action="my_joined_org.php"  >
                <button class="btn btn-danger" type="submit" name="commit">My Joined Orgs</button>
            </<input type="text" name="tar" value="">
            <form>
        </div>
        <div class="col-md-1" >
            <form  method="post" action="friend%20requests.php"  >
                <button class="btn btn-warning" type="submit" name="commit">Friend Requests</button>
            </form>
        </div>
        <div class="col-md-1" style="background-color: #5cb85c">
            <form  method="post" action="send_request.php"  >
                <button class="btn btn-success" type="submit" name="commit">Send a Request</button>
                Target's Username: <input type="text" name="tar" value="" style="width:120px" maxlength="25">
            </form>
        </div>
        <div class="col-md-1" style="background-color: #5bc0de">
            <form  method="post" action="people_in_event.php"  >
                <button class="btn btn-info" type="submit" name="commit">Check attendants</button>
                Event Name: <select name="event">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [show_all_event] ';
                        $stmt = sqlsrv_prepare($conn, $sql);
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                print"   <option value=".'"'.$row['EventName'].'"'.">$row[EventName]</option>";
                            }
                        }
                    }

                    ?>
                </select>
            </form>
        </div>
        <div class="col-md-1" style="background-color: #d9534f">
            <form  method="post" action="addtag.php"  >
                <button class="btn btn-danger" type="submit" name="commit">Add a target</button>
                Event Name: <select name="event">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [event_can_invite] @inUsername=?,@inPassword=?';
                        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                print"   <option value=".'"'.$row['EventName'].'"'.">$row[EventName]</option>";
                            }
                        }
                    }
                    ?>
                </select>
                TagName: <input type="text" name="tag" value="" style="width:120px" maxlength="25">
            </form>
        </div>
    </div>
</div>

<div class="sample" id="invi" hidden>
    <div id="greenform" method="post" action=""  >
        <div id="greeninput">
            <img id="closeRedForm" class="close" src="icon/close.png"/>
            <div class="col-md-4" >
                <div class="btn btn-danger" id="greenbut">View invitations</div>
                <?php
                print"<br/><br/>";
                if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                    $serverName = "titan.csse.rose­hulman.edu";
                    $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                    $conn = sqlsrv_connect($serverName, $connectionInfo);
                    if ($conn === false) {
                        die(print_r(sqlsrv_errors(), true));
                    }
                    $sql='exec [check_invitation]@inUsername=?,@inPassword=? ';
                    $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                    if (!$stmt) {
                        die(print_r(sqlsrv_errors(), true));
                    }
                    if (sqlsrv_execute($stmt)) {
                        while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){

                            ?>

                <form  method="post" action=""  >
                    <br/>
                    Title: <?=$row['Title']?>  Message:<?=$row['Message']?> EventName:<?=$row['EventName']?>
                    <input type="text" name="submit_type" value="confirm" hidden>
                    <input type="text" name="iid" value="<?=$row['R_IID']?>" hidden>
                    <input id="delete" type="submit" name="commit" value="confirm">
                </form>
                        <?php
                        }
                    }
                }

                ?>
            </div>
            <div class="col-md-4" >
                <div class="btn btn-warning" id="bluebut">Create invitation</div>
                <form id="greenform" method="post" action=""  >
                    <div id="greeninput">
                        <div id="event" style="width:400px" >Event Name: <select name="event">
                                <?php
                                if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                                    $serverName = "titan.csse.rose­hulman.edu";
                                    $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                                    $conn = sqlsrv_connect($serverName, $connectionInfo);
                                    if ($conn === false) {
                                        die(print_r(sqlsrv_errors(), true));
                                    }
                                    $sql='exec [event_can_invite] @inUsername=?,@inPassword=?';
                                    $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                                    if (!$stmt) {
                                        die(print_r(sqlsrv_errors(), true));
                                    }
                                    if (sqlsrv_execute($stmt)) {
                                        while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                            print"   <option value=".'"'.$row['EventName'].'"'.">$row[EventName]</option>";
                                        }
                                    }
                                }

                                ?>
                            </select><br /><br /></div>
                        <div  style="width:400px">Title: <input type="text" name="title" value="" maxlength="25"><br /><br /></div>
                        <div  style="width:250px">Message: <input  type="text" name="message" value="" maxlength="1000"><br /><br /></div>
                        <input type="text" name="submit_type" value="create_invitation" hidden>
                        <input id="delete" type="submit" name="commit" value="create">
                    </div>
                </form>
            </div>
            <div class="col-md-3" >
                <div class="btn btn-success" id="send">Send Invitation</div>
                <form id="greenform" method="post" action=""  >
                    <div id="greeninput">
                        <div id="event" style="width:400px" >Invitation ID: <select name="iid">

                                <?php
                                if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){

                                    $serverName = "titan.csse.rose­hulman.edu";
                                    $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                                    $conn = sqlsrv_connect($serverName, $connectionInfo);
                                    if ($conn === false) {
                                        die(print_r(sqlsrv_errors(), true));
                                    }
                                    $sql='exec [my_invitation] @inUsername=?,@inPassword=? ';
                                    $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                                    if (!$stmt) {
                                        die(print_r(sqlsrv_errors(), true));
                                    }

                                    if (sqlsrv_execute($stmt)) {
                                        while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                           ?>
                                            <option value="<?=$row['IID']?>"><?=$row['IID']?></option>
                                        <?php
                                        }
                                    }
                                }
                                ?>
                            </select><br /><br /></div>
                        <div  style="width:400px">Tar Username: <input type="text" name="Rusername" value="" maxlength="25"><br /><br /></div>
                        <div  style="width:250px">Level:
                        <select name="level">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                            <br /><br /></div>
                        <input type="text" name="submit_type" value="send" hidden>
                        <input id="delete" type="submit" name="commit" value="Send">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='send'){
        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        print_r(array(&$_POST['iid'],&$_COOKIE['username'],&$_COOKIE['password'],&$_POST['Rusername'],&$_POST['level']));
        $sql='exec [send] @IID=?,@inUsername=?,@inPassword=?,@ReUsername=?,@Relevel=?';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$_POST['iid'],&$_COOKIE['username'],&$_COOKIE['password'],&$_POST['Rusername'],&$_POST['level']));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }
        sqlsrv_execute($stmt);
    }
}
?>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='create_invitation'){
        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $sql='exec [create_invitation] @EventName=?,@inUsername=?,@inPassword=?,@Title=?,@Message=?';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$_POST['event'],&$_COOKIE['username'],&$_COOKIE['password'],&$_POST['title'],&$_POST['message']));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }
        sqlsrv_execute($stmt);
    }
}
?>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='confirm'){
        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $sql='exec [confirm_invitation] @inUsername=?,@inPassword=?, @IID=?';
        print_r(array(&$_COOKIE['username'],&$_COOKIE['password'],&$_POST['iid']));
        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password'],&$_POST['iid']));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }
        sqlsrv_execute($stmt);
    }
}
?>
<div class="sample" id="join_event" hidden>
    <form id="greenform" method="post" action=""  >
        <div id="greeninput">
            <img id="closeRedForm" class="close" src="icon/close.png"/>
            <div id="event" style="width:400px" >Event Name: <select name="event">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [show_event] ';
                        $stmt = sqlsrv_prepare($conn, $sql);
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                print"   <option value=".'"'.$row['EventName'].'"'.">$row[EventName]</option>";
                            }
                        }
                    }

                    ?>
                </select><br /><br /></div>
            <div id="begin"   style="width:400px">Username: <input type="text" name="user" value="" maxlength="25"><br /><br /></div>
            <div id="end"  style="width:250px">Password: <input  type="password" name="password" value="" maxlength="25"><br /><br /></div>
            <input type="text" name="submit_type" value="join_event" hidden>
            <input id="delete" type="submit" name="commit" value="join">
<!--            if($_SERVER['REQUEST_METHOD'] == 'POST'){-->
<!--            if($_REQUEST['submit_type']=='confirm'){-->
<!--            $serverName = "titan.csse.rose­hulman.edu";-->
<!--            $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");-->
<!--            $conn = sqlsrv_connect($serverName, $connectionInfo);-->
<!--            if ($conn === false) {-->
<!--            die(print_r(sqlsrv_errors(), true));-->
<!--            }-->
<!--            $sql='exec [confirm_invitation] @inUsername=?,@inPassword=? @IID=?';-->
<!--            $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password'],&$_POST['iid']));-->
<!--            if (!$stmt) {-->
<!--            die(print_r(sqlsrv_errors(), true));-->
<!--            }-->
<!--            sqlsrv_execute($stmt);-->
<!--            }-->
<!--            }-->
        </div>
    </form>
</div>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='join_event'){
        if(empty($_REQUEST['user']) || empty($_REQUEST['password']) || empty($_REQUEST['event'])){            ?>
            <script>
                $("#join_event").show();
            </script>
        <?php
        }else{

        $event = $_POST['event'];
        $username = $_POST["user"];
        $password = $_POST["password"];

        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $sql = '
    DECLARE @Status SMALLINT
EXEC @Status = [join_event] @inUsername=?,@inPassword=?,@Eventname=?
SELECT Status = @Status
    ';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password,&$event));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }
        if (sqlsrv_execute($stmt)) {
        $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
        if(!$row['Status']){
        ?>
            <script>
                $("#event_joined").show();
            </script>
        <?php
        }
        }else{
        ?>
            <script>
                $("#event_joined").show();
            </script>
        <?php
        }
        }
    }
}
?>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='logout'){
        print $_COOKIE['username'];
        ?>
        <script>
            $("#userinfo").hide();
            $("#logout").hide();
            $("#login").show();
            $("#register").show();
        </script>
    <?php
    }
}
?>
<?php
function show_login(){
    if(isset($_COOKIE["username"])){
        ?>
    <script>
        $("#register").hide();
        $("#login").hide();
        $("#userinfo").text("Hi, <?=$_COOKIE["username"]?>");
        $("#userinfo").show();
        $("#logout").show();
    </script>
    <?php
    }else{
    ?>
        <script>
            $("#register").show();
            $("#login").show();
            $("#userinfo").hide();
            $("#logout").hide();
        </script>
    <?php
    }
}
function show_username_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='register'&&empty($_REQUEST['username'])){
        echo "<span> Enter your Username</span>";
    }
}
function show_password_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='register'&&empty($_REQUEST['password'])){
        echo "<span> Enter your Password</span>";
    }
}
function show_name_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='register'&&empty($_REQUEST['name'])){
        echo "<span> Enter your Nick Name</span>";
    }
}
function show_contact_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='register'&&empty($_REQUEST['phone'])){
        echo "<span> Enter your Phone number</span>";
    }
}
function show_password_re_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='register'&&empty($_REQUEST['password2'])&&!empty($_REQUEST['password'])){
        echo "<span> Re-type your Password</span>";
    }
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='register'&&(!empty($_REQUEST['password'])&&!empty($_REQUEST['password2'])&&($_REQUEST['password']!=$_REQUEST['password2']))){
        echo "<span> Your password does not match each other</span>";
    }
}

?>
<form class="common" id="logoutform" method="post" action="" hidden>
    <div class="common_text" id="logouttext">
        You will Log Out!
        <input type="text" name="submit_type" value="logout"  hidden>
        <input type="submit" name="commit" value="Log Out" style="position: relative;left:200px;">
    </div>
</form>

    <form class="common" id="registerform" method="post" action="" hidden>
        <div class="common_text" id="registertext">
            <img id="closeRegForm" class="close" src="icon/close.png"/>
            Nick Name: <input type="text" name="name" value="" maxlength="25"><br /><?php show_name_err();?><br />
            Username: <input type="text" name="username" value="" maxlength="25"><br /><?php show_username_err();?><br />
            Password: <input type="password" name="password" value="" maxlength="25" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"><br /><?php show_password_err();?><br />
            Re-type Password: <input type="password" name="password2" value="" maxlength="25"><br /><?php show_password_re_err();?><br />
            Phone Number: <input type="number" name="phone"  min="1000000000" max="9999999999" /><br /><?php show_contact_err();?><br />
            <input type="text" name="submit_type" value="register" hidden>
            <input type="submit" name="commit" value="register">
        </div>
    </form>
<div class="common" id="reg_msg" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >Registration Successful</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_reg_msg">OK</button>
    </div>
</div>
<div class="common" id="user_exist" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >The Username is already registered</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_user_msg">OK</button>
    </div>
</div>
<div class="common" id="login_fail" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >The Username and Password do not Match</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_login_fail">OK</button>
    </div>
</div>
<div class="common" id="login_succeed" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >Login succeed</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_login_succeed">OK</button>
    </div>
</div>
<div class="common" id="event_added" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >You successfully add a new event</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_event_added">OK</button>
    </div>
</div>
<div class="common" id="edit_success" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >You successfully edit a event</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_edit_success">OK</button>
    </div>
</div>
<div class="common" id="event_deleted" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >You successfully delete an event</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_event_deleted">OK</button>
    </div>
</div>
<div class="common" id="event_joined" hidden>
    <div class="common_text">
        <p style="display:inline-block;width:300px" >You successfully join an event</p><button style="display:inline-block" type="button" class="btn btn-danger" id="close_event_joined">OK</button>
    </div>
</div>
    <?php

        if($_SERVER['REQUEST_METHOD'] == 'POST'){
            if($_REQUEST['submit_type']=='register'){
                if (empty($_REQUEST['username']) || empty($_REQUEST['password']) || empty($_REQUEST['name']) || empty($_REQUEST['phone']) || empty($_REQUEST['password2'])) {
                    ?>
                    <script>
                        $("#registerform").show();
                        $('[name="name"]').val("<?=$_REQUEST['name']?>");
                        $('[name="username"]').val("<?=$_REQUEST['username']?>");
                        $('[name="phone"]').val("<?=$_REQUEST['phone']?>");
                    </script>
                <?php
                }else{
                    $name = $_POST['name'];
                    $username = $_POST["username"];
                    $password = $_POST["password"];
                    $phone = $_POST["phone"];

                    $serverName = "titan.csse.rose­hulman.edu";
                    $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                    $conn = sqlsrv_connect($serverName, $connectionInfo);
                    if ($conn === false) {
                        die(print_r(sqlsrv_errors(), true));
                    }
                    $sql = "
        DECLARE @Status SMALLINT
EXEC @Status = [CreateAccount] @Username=?,
@Password=?,
@Contact=?,
@Nickname=?
SELECT Status = @Status
    ";
                    $stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password,&$phone,&$name));
                    if (!$stmt) {
                        die(print_r(sqlsrv_errors(), true));
                    }
                    if (sqlsrv_execute($stmt)) {
                        $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
                        if(!$row['Status']){
                            ?>
                    <script>
                        $("#reg_msg").show();
                    </script>
                        <?php
                        }else{
                        ?>
                    <script>
                        $("#user_exist").show();
                        $('#close_user_msg').click(function(){
                            $("#user_exist").hide();
                            $("#registerform").show();
                            $('[name="name"]').val("<?=$_REQUEST['name']?>");
                            $('[name="username"]').val("<?=$_REQUEST['username']?>");
                            $('[name="phone"]').val("<?=$_REQUEST['phone']?>");
                        });
                    </script>
                <?php
                        }
                    }
                }
            }
        }

    ?>

<form method = "post" class="common" id="loginform" action="" hidden>
    <div class="common_text" id="logintext">
        <img id="closeLogForm" class="close" src="icon/close.png"/>
        Username: <input type="text" name="username" value="" maxlength="25"><br /><?php show_login_username_err()?><br />
        Password: <input type="password" name="password" value="" maxlength="25"><br/><?php show_login_password_err()?><br/>
        <input type="submit" name="commit" value="Login" >
        <input type="text" name="submit_type" value="login" hidden>
    </div>
</form>
<?php
function show_login_username_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='login'&&empty($_REQUEST['username'])){
        echo "<span> Enter your Username</span>";
    }
}
function show_login_password_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='login'&&empty($_REQUEST['password'])){
        echo "<span> Enter your Password</span>";
    }
}
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='login'){
        if(empty($_REQUEST['username']) || empty($_REQUEST['password']) ){
            ?>
            <script>
                $("#loginform").show();
            </script>
        <?php
        }else{
        $username=$_POST["username"];
        $password=$_POST["password"];

        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array( "Database"=>"wp3", "UID"=>"hua", "PWD"=>"daohaode");
        $conn = sqlsrv_connect( $serverName, $connectionInfo);
        if( $conn === false) {
            die( print_r( sqlsrv_errors(), true));
        }
        $sql="
DECLARE @Status SMALLINT
EXEC @Status = [Login] @Username=?, @Password=?
SELECT Status = @Status
";
        $stmt = sqlsrv_prepare($conn, $sql, array(&$username,&$password));
        if( !$stmt ) {
            die( print_r( sqlsrv_errors(), true));
        }
        if(sqlsrv_execute($stmt)) {
        $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);
        if(!$row['Status']){
        ?>
            <script>
                $("#login_succeed").show();
                $("#login").hide();
                $("#register").hide();

            </script>
        <?php
        }else{
        ?>
            <script>
                $("#login_fail").show();
                $('#close_login_fail').click(function(){
                    $("#login_fail").hide();
                    $("#loginform").show();
                });
            </script>
        <?php
        }
        }
        }
    }
}
?>
<?php
//function show_login_username_err(){
//    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='login'&&empty($_REQUEST['username'])){
//        echo "<span> Enter your Username</span>";
//    }
//}
//function show_login_password_err(){
//    if($_SERVER['REQUEST_METHOD'] == 'POST'&&$_REQUEST['submit_type']=='login'&&empty($_REQUEST['password'])){
//        echo "<span> Enter your Password</span>";
//    }
//}
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='login'){
        if(empty($_REQUEST['username']) || empty($_REQUEST['password']) ){
            ?>
            <script>
                $("#loginform").show();
            </script>
        <?php
        }else{
        $username=$_POST["username"];
        $password=$_POST["password"];

        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array( "Database"=>"wp3", "UID"=>"hua", "PWD"=>"daohaode");
        $conn = sqlsrv_connect( $serverName, $connectionInfo);
        if( $conn === false) {
            die( print_r( sqlsrv_errors(), true));
        }
        $sql="
DECLARE @Status SMALLINT
EXEC @Status = [Login] @Username=?, @Password=?
SELECT Status = @Status
";
        $stmt = sqlsrv_prepare($conn, $sql, array(&$username,&$password));
        if( !$stmt ) {
            die( print_r( sqlsrv_errors(), true));
        }
        if(sqlsrv_execute($stmt)) {
        $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);
        if(!$row['Status']){
        ?>
            <script>
                $("#login_succeed").show();
                $("#login").hide();
                $("#register").hide();

            </script>
        <?php
        }else{
        ?>
            <script>
                $("#login_fail").show();
                $('#close_login_fail').click(function(){
                    $("#login_fail").hide();
                    $("#loginform").show();
                });
            </script>
        <?php
        }
        }
        }
    }
}
?>

<div class="sample" id="green" hidden>
    <form id="greenform" method="post" action="">
        <div id="greeninput">
            <img id="closeGreenForm" class="close" src="icon/close.png"/>
            <div id="event" style="width:400px">Event Name: <input type="text" name="event" value="" maxlength="25"><br /><br /></div>
            <div id="begin" style="width:400px">Beginning Date: <input pattern="\d{1,2}/\d{1,2}/\d{4}" title="The date must match mm/dd/yyyy format" type="text" name="begin" value=""><br /><br /></div>
            <div id="end" style="width:250px">End Date: <input  pattern="\d{1,2}/\d{1,2}/\d{4}" title="The date must match mm/dd/yyyy format" type="text" name="end" value=""><br /><br /></div>
            <div id="location">Location: <input  type="text" name="location" value="" maxlength="25"><br /><br /></div>
            <div id="type">Type: <select name="type">
                    <option value="private">private</option>
                    <option value="public">public</option>
                </select><br /><br /></div>
            <div  id="host">HostName: <select name="host">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [check_my_organization] @inUsername=?,@inPassword=?';
                        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                print"   <option value=".'"'.$row['OrgName'].'"'.">".$row['OrgName']."</option>";
                            }
                        }
                    }

                    ?>
                </select><br /><br /></div>
            <div id="description" >Description:
                <textarea rows="18" cols="150" name="description" maxlength="4000"></textarea>
                <br /><br /><?php show_green_err() ?></div>
            <input type="text" name="submit_type" value="green" hidden>
            <input id="submit" type="submit" name="commit" value="Submit">
        </div>
    </form>
</div>
<?php
function show_green_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'){
        if($_REQUEST['submit_type']=='green'){
            if(empty($_REQUEST['event']) || empty($_REQUEST['begin']) || empty($_REQUEST['end']) || empty($_REQUEST['location']) || empty($_REQUEST['type'])|| empty($_REQUEST['host'])|| empty($_REQUEST['description'])){
                print "Please fill out all information";
            }
        }
    }
}
function show_blue_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'){
        if($_REQUEST['submit_type']=='blue'){
            if(empty($_REQUEST['event']) || empty($_REQUEST['begin']) || empty($_REQUEST['end']) || empty($_REQUEST['location']) || empty($_REQUEST['type'])|| empty($_REQUEST['host'])|| empty($_REQUEST['description'])){
                print "Please fill out all information";
            }
        }
    }
}
function show_red_err(){
    if($_SERVER['REQUEST_METHOD'] == 'POST'){
        if($_REQUEST['submit_type']=='red'){
            if(empty($_REQUEST['user']) || empty($_REQUEST['password']) || empty($_REQUEST['event'])){
                print "<br/><br/>Please fill out all information";
            }
        }
    }
}
//function show_orange_err(){
//    if($_SERVER['REQUEST_METHOD'] == 'POST'){
//        if($_REQUEST['submit_type']=='orange'){
//            if(empty($_REQUEST['event']) || empty($_REQUEST['begin']) || empty($_REQUEST['end']) || empty($_REQUEST['location']) || empty($_REQUEST['type'])|| empty($_REQUEST['host'])|| empty($_REQUEST['description'])){
//                print "Please fill out all information";
//            }
//        }
//    }
//}
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='green'){
        if(empty($_REQUEST['event']) || empty($_REQUEST['begin']) || empty($_REQUEST['end']) || empty($_REQUEST['location']) || empty($_REQUEST['type'])|| empty($_REQUEST['host'])|| empty($_REQUEST['description'])){
            ?>
            <script>
                $("#green").show();
            </script>
        <?php
        }else{
            $event = $_POST['event'];
            $begin = $_POST["begin"].' 10:35:43 AM';
            $end = $_POST["end"].' 10:35:43 AM';
            $location = $_POST["location"].'';
            $type = $_POST["type"].'';
            $host = $_POST["host"];
            $description = $_POST["description"].'';

            $serverName = "titan.csse.rose­hulman.edu";
            $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
            $conn = sqlsrv_connect($serverName, $connectionInfo);
            if ($conn === false) {
                die(print_r(sqlsrv_errors(), true));
            }
            $sql = "
    DECLARE @Status SMALLINT
EXEC @Status = [create_event] @name=?,
@Start=?,
@End=?,
@Location=?,
@Description=?,
@type=?,
@HostName=?,
@inUsername=?,
@inPassword=?
SELECT Status = @Status
    ";
            $stmt = sqlsrv_prepare($conn, $sql,array(&$event,&$begin,&$end,&$location,&$description,&$type,&$host,&$_COOKIE['username'],&$_COOKIE['password']));
            if (!$stmt) {
                die(print_r(sqlsrv_errors(), true));
            }
            if (sqlsrv_execute($stmt)) {
                $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
                if(!$row['Status']){
        ?>
            <script>
                $("#event_added").show();
            </script>
        <?php
                }else{
            die("<script> window.location.assign('Duplicate_Event.php');</script>");
                }
            }else{
            die("<script> window.location.assign('Duplicate_Event.php');</script>");
            }
        }
    }
}

?>
<div class="sample" id="blue" hidden>
    <form id="greenform" method="post" action=""  >
        <div id="greeninput">
            <img id="closeBlueForm" class="close" src="icon/close.png"/>
            <div id="event" style="width:400px" >Event Name: <select name="event">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [my_event] @inUsername=?, @inPassword=?';
                        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                             print"   <option value=".'"'.$row['EventName'].'"'.">$row[EventName]</option>";
                    }
                    }
                    }

                    ?>
                </select><br /><br /></div>
            <div id="begin" style="width:400px">Beginning Date: <input type="text" name="begin" value="" pattern="\d{1,2}/\d{1,2}/\d{4}" title="The date must match mm/dd/yyyy format"><br /><br /></div>
            <div id="end" style="width:250px">End Date: <input  type="text" name="end" value="" pattern="\d{1,2}/\d{1,2}/\d{4}" title="The date must match mm/dd/yyyy format"><br /><br /></div>
            <div id="location">Location: <input  type="text" name="location" value="" maxlength="25"><br /><br /></div>
            <div id="type">Type: <select name="type">
                    <option value="private">private</option>
                    <option value="public">public</option>
                </select><br /><br /></div>
            <div  id="host">HostName: <select name="host">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [check_my_organization] @inUsername=?,@inPassword=?';
                        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                print"   <option value=".'"'.$row['OrgName'].'"'.">".$row['OrgName']."</option>";
                            }
                        }
                    }

                    ?>
                </select><br /><br /></div>
            <div id="description">Description: <textarea rows="18" cols="150" name="description" maxlength="4000"></textarea><br /><br /><?php show_blue_err() ?></div>
            <input type="text" name="submit_type" value="blue" hidden>
            <input id="submit" type="submit" name="commit" value="Submit">
        </div>
    </form>
</div>
<div class="sample" id="prep" hidden>
    <form id="greenform" method="post" action=""  >
        <div id="greeninput">
            <img id="closeBlueForm" class="close" src="icon/close.png"/>
            <div id="event" style="width:400px" >Event Name: <select name="event">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [my_event] @inUsername=?, @inPassword=?';
                        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                print"   <option value=".'"'.$row['EventName'].'"'.">$row[EventName]</option>";
                            }
                        }
                    }
                    ?>
                </select><br /><br /></div>
            <input type="text" name="submit_type" value="prep" hidden>
            <input id="load" type="submit" name="commit" value="Load">
        </div>
    </form>
</div>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='prep'){
        if(!empty($_POST['event'])){
            $event = $_POST['event'];
            $type=null;
            $location=null;
            $date=null;

            $serverName = "titan.csse.rose­hulman.edu";
            $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
            $conn = sqlsrv_connect($serverName, $connectionInfo);
            if ($conn === false) {
                die(print_r(sqlsrv_errors(), true));
            }
            $sql = '
exec [search_event] @name=?,@type=?,@location=?,@date=?
    ';
            $stmt = sqlsrv_prepare($conn, $sql,array(&$event,&$type,&$location,&$date));
            if (!$stmt) {
                die(print_r(sqlsrv_errors(), true));
            }
            if (sqlsrv_execute($stmt)) {
                ?>
                <script>
                    $("#blue").show();
                </script>
            <?php
            while( $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC) ) {
            ?>
                <script>
                    $('[name="event"]').val("<?=$row[1]?>");
                    $('[name="begin"]').val("<?=$row[2]->format('m/d/Y')?>");
                    $('[name="end"]').val("<?=$row[3]->format('m/d/Y')?>");
                    $('[name="location"]').val("<?=$row[4]?>");
                    $('[name="type"]').val("<?=$row[6]?>");
                    $('[name="description"]').val("<?=$row[5]?>");
                    $('[name="host"]').val("<?=$row[7]?>");
                </script>
            <?php
            }

            }else{
                die(print_r(sqlsrv_errors(), true));
            }
        }

    }
}
?>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='blue'){
        if(empty($_REQUEST['type'])||empty($_REQUEST['event'])||empty($_REQUEST['begin']) || empty($_REQUEST['end']) || empty($_REQUEST['location']) ||  empty($_REQUEST['host'])|| empty($_REQUEST['description'])){
            ?>
            <script>
                $("#blue").show();
            </script>
        <?php
        }else{
        $event = $_POST['event'];
        $begin = $_POST["begin"].' 10:35:43 AM';
        $end = $_POST["end"].' 10:35:43 AM';
        $location = $_POST["location"].'';
        $type = $_POST["type"].'';
        $host = $_POST["host"];
        $description = $_POST["description"].'';

        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $sql = '
    DECLARE @Status SMALLINT
EXEC @Status = [edit_event]

@Username=? ,
@Password=? ,
@EventName=? ,

@newEventName=?,
@Start=?,
@End=?,
@Location=?,
@Type=?,
@Description=?,
@Hostname=?
SELECT Status = @Status
    ';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password'],&$event,null,&$begin, &$end ,&$location,&$type,&$description, &$host));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }
        if (sqlsrv_execute($stmt)) {
        $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
        if(!$row['Status']){
        ?>
            <script>
                $("#edit_success").show();
            </script>
        <?php
        }else{
            die( print_r( sqlsrv_errors(), true));
        }
        }else{
            die( print_r( sqlsrv_errors(), true));
        }
        }
    }
}
?>
<div class="sample" id="red" hidden>
    <form id="greenform" method="post" action=""  >
        <div id="greeninput">
            <img id="closeRedForm" class="close" src="icon/close.png"/>
            <div id="event" style="width:400px" >Event Name: <select name="event">
                    <?php
                    if(!empty($_COOKIE['username'])&&!empty($_COOKIE['password'])){
                        $serverName = "titan.csse.rose­hulman.edu";
                        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
                        $conn = sqlsrv_connect($serverName, $connectionInfo);
                        if ($conn === false) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        $sql='exec [my_event] @inUsername=?, @inPassword=?';
                        $stmt = sqlsrv_prepare($conn, $sql,array(&$_COOKIE['username'],&$_COOKIE['password']));
                        if (!$stmt) {
                            die(print_r(sqlsrv_errors(), true));
                        }
                        if (sqlsrv_execute($stmt)) {
                            while($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
                                print"   <option value=".'"'.$row['EventName'].'"'.">$row[EventName]</option>";
                            }
                        }
                    }

                    ?>
                </select><br /><br /></div>
            <div id="begin"   style="width:400px">Username: <input type="text" name="user" value="" maxlength="25"><br /><br /></div>
            <div id="end"  style="width:250px">Password: <input  type="password" name="password" value="" maxlength="25"><br /><br /></div>
            <input type="text" name="submit_type" value="red" hidden>
            <input id="delete" type="submit" name="commit" value="delete">
            <?php show_red_err()?>
        </div>
    </form>
</div>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if($_REQUEST['submit_type']=='red'){
        if(empty($_REQUEST['user']) || empty($_REQUEST['password']) || empty($_REQUEST['event'])){            ?>
            <script>
                $("#red").show();
            </script>
        <?php
        }else{
        $event = $_POST['event'];
        $username = $_POST["user"];
        $password = $_POST["password"];

        $serverName = "titan.csse.rose­hulman.edu";
        $connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        if ($conn === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        $sql = '
    DECLARE @Status SMALLINT
EXEC @Status = [delete_event] @Username=?,@Password=?,@Eventname=?
SELECT Status = @Status
    ';
        $stmt = sqlsrv_prepare($conn, $sql,array(&$username,&$password,&$event));
        if (!$stmt) {
            die(print_r(sqlsrv_errors(), true));
        }
        if (sqlsrv_execute($stmt)) {
        $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
        if(!$row['Status']){
        ?>
            <script>
                $("#event_deleted").show();
            </script>
        <?php
        }else{
            die( print_r( sqlsrv_errors(), true));
        }
        }else{
            die( print_r( sqlsrv_errors(), true));
        }
        }
    }
}
?>
<div class="sample" id="orange" hidden>
    <form id="greenform" method="post" action=""  >
        <div id="greeninput">
            <img id="closeOrangeForm" class="close" src="icon/close.png"/>
            <div id="event" style="width:400px">Event Name: <input type="text" name="name" value="" maxlength="25"><br /><br /></div>
            <div id="event">Date: <input type="text" name="date" value="" pattern="\d{1,2}/\d{1,2}/\d{4}" title="The date must match mm/dd/yyyy format" ><br /><br /></div>
            <div id="Location" >Location: <input type="text" name="location" value="" maxlength="25"><br /><br /></div>
            <div id="type">Type: <select name="type">
                    <option value="private">private</option>
                    <option value="public">public</option>
                </select><br /><br /></div>
            <input type="text" name="submit_type" value="orange" hidden>
            <input id="search" type="submit" name="commit" value="search">

        </div>
    </form>
</div>
<div class="sample" id="result_table" hidden >
    <img id="closeresult_table" class="close" src="icon/close.png"/>
    <ul id="event_list">
        <p>Your Searching Result is:</p>
    </ul>
</div>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
if($_REQUEST['submit_type']=='orange'){
if(!($event = $_POST['name'])){
    $event=null;
}
if(!($type = $_POST['type'])){
    $type=null;
}
if(!($location = $_POST['location'])){
    $location=null;
}
if(!($date = $_POST['date'])){
    $date=null;
}

$serverName = "titan.csse.rose­hulman.edu";
$connectionInfo = array("Database" => "wp3", "UID" => "hua", "PWD" => "daohaode");
$conn = sqlsrv_connect($serverName, $connectionInfo);
if ($conn === false) {
    die(print_r(sqlsrv_errors(), true));
}
$sql = '
exec [search_event] @name=?,@type=?,@location=?,@date=?
    ';
$stmt = sqlsrv_prepare($conn, $sql,array(&$event,&$type,&$location,&$date));
if (!$stmt) {
    die(print_r(sqlsrv_errors(), true));
}
    if (sqlsrv_execute($stmt)) {
        ?>
        <script>
            $("#result_table").show();
        </script>
    <?php
        while( $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC) ) {
            $event_detail= $row[1].", ".$row[2]->format('m/d/Y').", ".$row[3]->format('m/d/Y').", ".$row[4].", ".$row[5].", ".$row[6];
            ?>
        <script>
            var node = document.createElement("LI");                 // Create a <li> node
            var textnode = document.createTextNode("<?=$event_detail?>");         // Create a text node
            node.appendChild(textnode);                              // Append the text to <li>
            document.getElementById("event_list").appendChild(node)

        </script>
        <?php
        }

    }else{
        die(print_r(sqlsrv_errors(), true));
    }
}
}
?>


</body>
</html>

<?php

show_login();
//if($modify){
//    window.location.assign("http://localhost/wpwpwp/wp.php");
//}
?>