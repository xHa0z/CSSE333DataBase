var main = function() {
    $('#closeRegForm').click(function() {
        $("#registerform").hide();
    });
    $('#closeLogForm').click(function() {
        $("#loginform").hide();

    });
    $('#close2').click(function() {
        $("#msgr").hide();
    });
    $('#close3').click(function() {
        $("#msgl").hide();
    });
    $('#closeGreenForm').click(function() {
        $("#green").hide();
    });

    $('#closeBlueForm').click(function() {
        $("#prep").hide();
    });
    $('#closeRedForm').click(function() {
        $("#red").hide();
    });
    $('#close_event_added').click(function() {
        $("#event_added").hide();
    });
    $('#close_edit_success').click(function() {
        $("#edit_success").hide();
    });
    $('#invitation').click(function() {
        $("#invi").show();
        $("#join_event").hide();
        $("#registerform").hide();
        $("#loginform").hide();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").hide();
        $("#perp").hide();
        $("#red").hide();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").hide();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
    });
    $('#close_event_deleted').click(function() {
        $("#event_deleted").hide();
    });

    $('#closeOrangeForm').click(function() {
        $("#orange").hide();
    });
    $('#closeresult_table').click(function() {
        $("#result_table").hide();
    });

    $('#logout').click(function() {
        $("#logoutform").show();
    });
    $('#login').click(function(){
        $("#invi").hide();
        $("#join_event").hide();
        $("#registerform").hide();
        $("#loginform").show();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").hide();
        $("#prep").hide();
        $("#blue").hide();
        $("#red").hide();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").hide();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
    });
    $('#close_reg_msg').click(function(){
        $("#reg_msg").hide();
    });
    $('#close_login_succeed').click(function(){
        $("#login_succeed").hide();
    });
    $('#register').click(function(){
        $("#invi").hide();
        $("#join_event").hide();
        $("#registerform").show();
        $("#loginform").hide();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").hide();
        $("#prep").hide();
        $("#blue").hide();
        $("#red").hide();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").hide();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
        $('[name="name"]').val("");
        $('[name="username"]').val("");
        $('[name="phone"]').val("");
    });
    $('#greenbut').click(function(){
        $("#invi").hide();
        $("#join_event").hide();
        $("#registerform").hide();
        $("#loginform").hide();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").show();
        $("#prep").hide();
        $("#blue").hide();
        $("#red").hide();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").hide();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
        $("#blue").hide();
    });
    $('#bluebut').click(function(){
        $("#invi").hide();
        $("#join_event").hide();
        $("#registerform").hide();
        $("#loginform").hide();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").hide();
        $("#prep").show();
        $("#blue").hide();
        $("#red").hide();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").hide();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
    });
    $('#join_but').click(function(){
        $("#invi").hide();
        $("#join_event").show();
        $("#registerform").hide();
        $("#loginform").hide();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").hide();
        $("#prep").hide();
        $("#blue").hide();
        $("#red").hide();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").hide();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
    });

    $('#redbut').click(function(){
        $("#invi").hide();
        $("#registerform").hide();
        $("#join_event").hide();
        $("#loginform").hide();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").hide();
        $("#prep").hide();
        $("#blue").hide();
        $("#red").show();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").hide();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
    });
    $('#orangebut').click(function(){
        $("#invi").hide();
        $("#join_event").hide();
        $("#registerform").hide();
        $("#loginform").hide();
        $("#msgr").hide();
        $("#msgl").hide();
        $("#green").hide();
        $("#prep").hide();
        $("#blue").hide();
        $("#red").hide();
        $("#event_added").hide();
        $("#edit_success").hide();
        $("#event_deleted").hide();
        $("#orange").show();
        $("#result_table").hide();
        $("#reg_msg").hide();
        $("#login_succeed").hide();
    });
};

$(document).ready(main);

