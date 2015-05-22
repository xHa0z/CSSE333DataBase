--[addtag](@inUsername varchar(25),@inPassword varchar(25),@EventName varchar(25),@Tagname varchar(25))
--DECLARE @result smallint
--EXEC @result = [addtag] @inUsername = 'test6', @inPassword = '666', @Eventname = 'testEvn1', @Tagname = 'Ride'; --NoSuchUser checked
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '666', @Eventname = 'testEvn1', @Tagname = 'Ride'; --Username and password does not match checked
--EXEC @result = [addtag] @inUsername = 'test6', @inPassword = '111', @Eventname = 'testEvn1', @Tagname = 'Ride'; --User name and password does not match checked
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @Eventname = 'testEvn1', @Tagname = 'Book'; --NoSuchTag checked
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @Eventname = 'testEvn8', @Tagname = 'Ride'; --NoSuchEvent
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @Eventname = 'testEvn1', @Tagname = 'Ride'; --Add tag checked
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @Eventname = 'testEvn1', @Tagname = 'Ride'; --Tad already assigned checked
--EXEC @result = [addtag] @inUsername = 'test3', @inPassword = '333', @Eventname = 'testEvn2', @Tagname = 'Ride'; --User's level is not high enough checked
--EXEC @result = [addtag] @inUsername = 'test4', @inPassword = '444', @Eventname = 'testEvn1', @Tagname = 'Ride'; --User's level is not high enough checked
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @Eventname = 'testEvn1', @Tagname = NULL; --Test NULL checked
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @Eventname = NULL, @Tagname = 'Ride'; --Test NULL checked
--EXEC @result = [addtag] @inUsername = NULL, @inPassword = '666', @Eventname = 'testEvn1', @Tagname = 'Ride'; --Test NULL checked
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = NULL, @Eventname = 'testEvn1', @Tagname = 'Ride'; --Test NULL checked
--EXEC @result = [addtag] @inUsername = 'test2', @inPassword = '222', @Eventname = 'testEvn8', @Tagname = 'Sale'; --Test user level checked

--PRINT @result





--[check_event](@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_event] @inUsername = 'test6', @inPassword = '666'; --NoSuchUser checked
--EXEC @result = [check_event] @inUsername = 'test2', @inPassword = '666'; --username and password does not match checked
--EXEC @result = [check_event] @inUsername = 'test1', @inPassword = NULL;  --Test NULL checked
--EXEC @result = [check_event] @inUsername = NULL, @inPassword = '333'; --Test NULL checked
--EXEC @result = [check_event] @inUsername = 'test1', @inPassword = '111'; --Test passed
--EXEC @result = [check_event] @inUsername = 'test2', @inPassword = '222'; --Test passed
--EXEC @result = [check_event] @inUsername = 'test4', @inPassword = '444'; --Test passed

--PRINT @result



--[check_invitation](@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_invitation] @inUsername = 'test6', @inPassword = '666'; --NoSuchUser checked 
--EXEC @result = [check_invitation] @inUsername = 'test1', @inPassword = '666'; --User name and password does not match checked
--EXEC @result = [check_invitation] @inUsername = 'test4', @inPassword = '444'; --User exist but no invitation checked
--EXEC @result = [check_invitation] @inUsername = 'test2', @inPassword = '222'; --Passed
--EXEC @result = [check_invitation] @inUsername = 'test1', @inPassword = '111'; Passed
--EXEC @result = [check_invitation] @inUsername =NULL, @inPassword = 222; --Test NULL checked
--EXEC @result = [check_invitation] @inUsername = 'test2', @inPassword = NULL; --Test NULL checked

--PRINT @result




--[check_invitation](@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_invitation] @inUsername = 'test6', @inPassword = '666'; --NoSuchUser checked 
--EXEC @result = [check_invitation] @inUsername = 'test1', @inPassword = '666'; --User name and password does not match checked
--EXEC @result = [check_invitation] @inUsername = 'test4', @inPassword = '444'; --User exist but no invitation checked
--EXEC @result = [check_invitation] @inUsername = 'test2', @inPassword = '222'; --Passed
--EXEC @result = [check_invitation] @inUsername = 'test1', @inPassword = '111'; Passed
--EXEC @result = [check_invitation] @inUsername =NULL, @inPassword = 222; --Test NULL checked
--EXEC @result = [check_invitation] @inUsername = 'test2', @inPassword = NULL; --Test NULL checked

--PRINT @result


--[check_joined_organization](@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_joined_organization] @inUsername = 'test6', @inPassword = '666'; --NoSuchUser passed
--EXEC @result = [check_joined_organization] @inUsername = 'test1', @inPassword = '333'; --passed
--EXEC @result = [check_joined_organization] @inUsername = 'test63', @inPassword = '111'; --Passed
--EXEC @result = [check_joined_organization] @inUsername = 'test1', @inPassword = '111'; --Passed
--EXEC @result = [check_joined_organization] @inUsername = 'test2', @inPassword = '222'; --Passed


--PRINT @result






--[check_my_current_event](@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_my_current_event] @inUsername = 'test6', @inPassword = '666'; --NoSuchUser passed
--EXEC @result = [check_my_current_event] @inUsername = 'test1', @inPassword = '333'; --passed
--EXEC @result = [check_my_current_event] @inUsername = 'test63', @inPassword = '111'; --Passed
--EXEC @result = [check_my_current_event] @inUsername = 'test1', @inPassword = '111'; --Passed
--EXEC @result = [check_my_current_event] @inUsername = 'test2', @inPassword = '222'; --Passed
--No Event will be held at 4.00 am.
--PRINT @result


--[check_my_organization](@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_my_organization] @inUsername = 'test6', @inPassword = '666'; --NoSuchUser checked 
--EXEC @result = [check_my_organization] @inUsername = 'test1', @inPassword = '666'; --User name and password does not match checked
--EXEC @result = [check_my_organization] @inUsername = 'test4', @inPassword = '444'; --Passed
--EXEC @result = [check_my_organization] @inUsername = 'test2', @inPassword = '222'; --Passed
--EXEC @result = [check_my_organization] @inUsername = 'test1', @inPassword = '111'; --Passed
--EXEC @result = [check_my_organization] @inUsername =NULL, @inPassword = 222; --Test NULL checked
--EXEC @result = [check_my_organization] @inUsername = 'test2', @inPassword = NULL; --Test NULL checked

--PRINT @result

--procedure [dbo].[CreateAccount](@Username varchar(25), @Password varchar(25),@Contact bigint = null, @Nickname varchar(25) = null)
--procedure [dbo].[Login](@Username varchar(25), @Password varchar(25))
--procedure [dbo].[create_event](@name varchar(25),@Start date,@End date,@Location varchar(40),@Description text,@type varchar(25), @HostID int,@inUsername varchar(25),@inPassword varchar(25))
--procedure [dbo].[edit_event](@Username varchar(25) ,@Password varchar(25) ,@EventName varchar(50) ,@newEventName varchar(50) = null,@Start date = null,@End date = null,@Location varchar(25) = null,@Type varchar(20) = null,@Description text = null,@Hostname varchar(25) = null
--procedure [dbo].[delete_event](@Username varchar(25), @Password varchar(25),@Eventname varchar(25))
--procedure [dbo].[search_event](@Name varchar(50)=null,@Date date=null,@Location varchar(25) = null,@Type varchar(20)=null





EXEC CreateAccount @Username = 'test1', @Password = '123123', @Contact = 123124, @Nickname = 'nm1';--all given success
EXEC CreateAccount 'test2', 'qweqweqwe', 5678, 'nm2'; --test all given and in order seccuess
EXEC CreateAccount @Username = 'test3', @Password = '6789sdkfhj', @Nickname = 'nm4'; --miss some paramenter, success null availabe
EXEC CreateAccount 'test3', 'rtyjasd','nm5'; -- test paramenter missed failed

EXEC CreateAccount @Username = 'test1', @Password = '123124124', @Contact = 123124, @Nickname = 'nm5';--all given success
EXEC CreateAccount @Password = 'asfadsf', @Contact = 5678342, @Nichnmame = 'nm6'; --miss nonnull parameter,execution failed, means query is correct
EXEC CreateAccount @Username = 'test4', @Contact = 7967653, @Nickname = 'nm7'; --miss nonnull parameter, execution failed, means query is correct












NEW!!!!!!
--ALTER procedure [dbo].[join_event](@EventName varchar(25),@inUsername varchar(25),@inPassword varchar(25))
DECLARE @result int
--EXEC @result = join_event @EventName = 'testEvn8', @inUsername = 'test1', @inPassword = '111'; --NoSuchEvent checked
--EXEC @result = join_event @EventName = 'testEvn1', @inUsername = 'test6', @inPassword = '111'; --NoSuchUser checked
--EXEC @result = join_event @EventName = 'testEvn1', @inUsername = 'test1', @inPassword = '222'; --Username and passwore not match checked
--EXEC @result = join_event @EventName = 'testEvn2', @inUsername = 'test2', @inPassword = '222'; --Join private event checked
--EXEC @result = join_event @EventName = 'testEvn8', @inUsername = 'test6', @inPassword = '111'; --NoSuchEvent and NoSuchUser checked
EXEC @result = join_event @EventName = 'testEvn3', @inUsername = 'test3', @inPassword = '333'; --all valid checked

print @result





--[create_invitation](@EventName varchar(25),@inUsername varchar(25),@inPassword varchar(25),@Title varchar(25),@Message text = null)
DECLARE @result int

--EXEC @result = create_invitation @EventName = 'testEvn8', @inUsername = 'test1', @inPassword = '111', @Title = 'title1', @Message = 'This is a message1'; -- NoSuchEvent  chekced
--EXEC @result = create_invitation @EventName = 'testEvn3', @inUsername = 'test6', @inPassword = '666', @Title = 'title2', @Message = 'This is a message2'; --NoSuchUser  checked
--EXEC @result = create_invitation @EventName = 'testEvn3', @inUsername = 'test4', @inPassword = '555', @Title = 'title3', @Message = 'This is a message3'; --Username and password don't match  checked
--EXEC @result = create_invitation @EventName = 'testEvn3', @inUsername = 'test4', @inPassword = '444', @Title = NULL, @Message = 'This is a message4'; --Title is NULL checked
--EXEC @result = create_invitation @EventName = 'testEvn3', @inUsername = 'test3', @inPassword = '333', @Title = 'title4', @Message = 'This is a messag5'; --NotEnoughLevel To Invitation checked
--EXEC @result = create_invitation @EventName = 'testEvn1', @inUsername = 'test1', @inPassword = '111', @Title = 'title5', @Message = NULL; --Message is NULL checked
--EXEC @result = create_invitation @EventName = 'testEvn2', @inUsername = 'test1', @inPassword = '111', @Title = 'title6', @Message = 'This is a message6'; --Invitate private event with level checked
--EXEC @result = create_invitation @EventName = 'testEvn3', @inUsername = 'test1', @inPassword = '111', @Title = 'title5', @Message = 'This is a message7'; --Duplicated title checked
--EXEC @result = create_invitation @EventName = 'testEvn8', @inUsername = 'test8', @inPassword = '123', @Title = 'title7', @Message = 'This is a message8';--No Event and No users checked
--EXEC @result = create_invitation @EventName = 'testEvn3', @inUsername = 'test4', @inPassword = '444', @Title = 'title8', @Message = 'This is a message9';--User be invited and given level to invite other checked


print @result








--[send](@IID varchar(25),@inUsername varchar(25),@inPassword varchar(25),@ReUsername varchar(25),@Relevel smallint)
DECLARE @result int

--EXEC @result = [send] @IID = 1, @inUsername = 'test1', @inPassword = '111', @ReUsername = 'test2', @Relevel = 0; 
--EXEC @result = [send] @IID = 1, @inUsername = 'test1', @inPassword = '111', @ReUsername = 'test3', @Relevel = 1;
--EXEC @result = [send] @IID = 1, @inUsername = 'test1', @inPassword = '111', @ReUsername = 'test5', @Relevel = 1;
--EXEC @result = [send] @IID = 2, @inUsername = 'test1', @inPassword = '111', @ReUsername = 'test3', @Relevel = 1;
--EXEC @result = [send] @IID = 2, @inUsername = 'test1', @inPassword = '111', @ReUsername = 'test2', @Relevel = 3;


print @result








--[confirm_invitation](@IID int,@inUsername varchar(25),@inPassword varchar(25))

DECLARE @result int

--EXEC @result = [confirm_invitation] @IID = 1, @inUsername = 'test2', @inPassword = '222'; --valid checked
--EXEC @result = [confirm_invitation] @IID = 5, @inUsername = 'test2', @inPassword = '222'; --NoSuchIID checked
--EXEC @result = [confirm_invitation] @IID = 2, @inUsername = 'test6' , @inPassword = '123'; --NoSuchUser checked
--EXEC @result = [confirm_invitation] @IID = 2, @inUsername = 'test5', @inPassword = '555'; --IID and User don't match checked

print @result









--[check_event](@inUsername varchar(25),@inPassword varchar(25))
DECLARE @result int

--EXEC @result = [check_event] @inUsername = 'test6', @inPassword = '123'; --NoSuchUser checked
--EXEC @result = [check_event] @inUsername = 'test5', @InPassword = '444'; --Username and password does not match checked
--EXEC @result = [check_event] @inusername = 'test5', @inPassword = '555' ; --User does not join any event checked
EXEC @result = [check_event] @inUsername = 'test1', @inPassword = '111'; --User joins events checked

print @result

--[check_invitation](@inUsername varchar(25),@inPassword varchar(25))
DECLARE @result int

--EXEC @result = [check_invitation] @inUsername = 'test6', @inPassword = '123'; --NoSuchUser checked
--EXEC @result = [check_invitation] @inUsername = 'test5', @InPassword = '444'; --Username and password does not match checked
--EXEC @result = [check_invitation] @inusername = 'test5', @inPassword = '555' ; --User has invitation
--EXEC @result = [check_invitation] @inUsername = 'test3', @inPassword = '333'; --User has invitation

print @result






--[my_invitation](@inUsername varchar(25),@inPassword varchar(25))
DECLARE @result int

--EXEC @result = [my_invitation] @inUsername = 'test6', @inPassword = '123'; --NoSuchUser checked
--EXEC @result = [my_invitation] @inUsername = 'test5', @InPassword = '444'; --Username and password does not match checked
--EXEC @result = [my_invitation] @inusername = 'test5', @inPassword = '555' ; --User not has invitation
EXEC @result = [my_invitation] @inUsername = 'test1', @inPassword = '111'; --User has invitation

print @result







--[addtag](@inUsername varchar(25),@inPassword varchar(25),@EventName varchar(25),@Tagname varchar(25))
DECLARE @result smallint
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @EventName = 'TestEvn1', @Tagname = 'Greek Life'; --Add tag
--EXEC @result = [addtag] @inUsername = 'test1', @inPassword = '111', @EventName = 'TestEvn1', @Tagname = 'Sale'; --Add tag
--EXEC @result = [addtag] @inUsername = 'test2', @inPassword = '222', @EventName = 'TestEvn1', @Tagname = 'Greek Life'
PRINT @result




--[my_event](@inUsername varchar(25),@inPassword varchar(25))
DECLARE @result int

--EXEC @result = [my_event] @inUsername = 'test6', @inPassword = '123'; --NoSuchUser checked
--EXEC @result = [my_event] @inUsername = 'test5', @InPassword = '444'; --Username and password does not match checked
--EXEC @result = [my_event] @inusername = 'test5', @inPassword = '555' ; --User not has invitation
--EXEC @result = [my_event] @inUsername = 'test1', @inPassword = '111'; --User has event

print @result





--[check_people_in_event]@eventName varchar(25)
--EXEC check_people_in_event @eventName = '123'; --NoSuchEvent
--EXEC check_people_in_event @eventName = 'testEvn1'; --Event is there checked



--[send_request](@inUsername varchar(25),@inPassword varchar(25),@Username varchar(25))
DECLARE @result smallint
--EXEC @result = [send_request] @inUsername = 'test6', @inPassword = '666', @Username = 'test5'; --NoSuchSender checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = '222', @Username = 'test5'; --Sender user name and password are not match checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = '111', @Username = 'test6'; --NoSuchReceiver checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = '111', @Username = 'test1'; --Add himself checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = '111', @Username = 'test2'; --Already friends  checked
--EXEC @result = [send_request] @inUsername = 'test2', @inPassword = '222', @Username = 'test1' --Already been friend checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = '111', @Username = 'test5'; --It should word checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = '111', @Username = 'test5'; --Duplicated request checked
--EXEC @result = [send_request] @inUsername = NULL, @inPassword = '111', @Username = 'test3'; --NULL Test checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = NULL, @Username = 'test3'; --NULL Test checked
--EXEC @result = [send_request] @inUsername = 'test1', @inPassword = '111', @Username = NULL; --NULL Test checked

print @result




--[confirm_request](@inUsername varchar(25),@inPassword varchar(25),@SenderName varchar(25))
--DECLARE @result smallint
--EXEC @result = [confirm_request] @inUsername = 'test6', @inPassword = '666', @SenderName = 'test1'; --NoSuchUser passed
--EXEC @result = [confirm_request] @inUsername = 'test1', @inPassword = '666', @SenderName = 'test2'; --User name and password does not match passed
--EXEC @result = [confirm_request] @inUsername = 'test1', @inPassword = '111', @SenderName = 'test6'; --Sender does not exist passed
--EXEC @result = [confirm_request] @inUsername = 'test1', @inPassword = '111', @SenderName = 'test1'; --Not in request table passed
--EXEC @result = [confirm_request] @inUsername = 'test2', @inPassword = '222', @SenderName = 'test1'; --NoSuchRequest pass
--EXEC @result = [confirm_request] @inUsername = NULL, @inPassword = '666', @SenderName = 'test1'; --Null test passed
--EXEC @result = [confirm_request] @inUsername = 'test1',@inPassword = NULL, @SenderName = 'test1'; --Null test passed
--EXEC @result = [confirm_request] @inUsername = 'test2',@inPassword = '222', @SenderName = NULL; --Null test5 passed
--EXEC @result = [confirm_request] @inUsername = 'test1',@inPassword = '111', @SenderName = 'test5'; --Revised Order passed
--EXEC @result = [confirm_request] @inUsername = 'test5',@inPassword = '555', @SenderName = 'test1'; --It should word passed
--EXEC @result = [confirm_request] @inUsername = 'test5',@inPassword = '555', @SenderName = 'test1'; --Relationship already existed passed

--print @result 




--[create_orgnization](@OrgName varchar(25),@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [create_orgnization] @Orgname = 'testOrg1', @inUsername = 'test6', @inPassword = '666'; --NoSuchUser passed
--EXEC @result = [create_orgnization] @Orgname = 'testOrg1', @inUsername = 'test1', @inPassword = '666'; --Username and password does not match passed
--EXEC @result = [create_orgnization] @Orgname = 'testOrg1', @inUsername = 'test1', @inPassword = '111'; --valid operation
--EXEC @result = [create_orgnization] @Orgname = 'testOrg2', @inUsername = 'test2', @inPassword = '222'; --valid opeartion
--EXEC @result = [create_orgnization] @Orgname = 'testOrg3', @inUsername = 'test3', @inPassword = '333'; --valid operation
--EXEC @result = [create_orgnization] @Orgname = 'testOrg4', @inUsername = 'test4', @inPassword = '444'; --valid operation
--EXEC @result = [create_orgnization] @Orgname = 'testOrg5', @inUsername = 'test5', @inPassword = '555'; --valid operation
--EXEC @result = [create_orgnization] @Orgname = 'testOrg1', @inUsername = 'test2', @inPassword = '222'; --Org already existed passed
--EXEC @result = [create_orgnization] @Orgname = 'testOrg6', @inUsername = 'test1', @inPassword = '111'; --Over max limit passed
--EXEC @result = [create_orgnization] @Orgname = NULL, @inUsername = 'test3', @inPassword = '333'; --NULL test passed
--EXEC @result = [create_orgnization] @Orgname = 'testOrg7', @inUsername = NULL, @inPassword = '666'; --NULL test passed
--EXEC @result = [create_orgnization] @Orgname = 'testOrg7', @inUsername = 'test4', @inPassword = NULL; --NULL test passed
--EXEC @result = [create_orgnization] @Orgname = 'testOrg1', @inUsername = '1', @inPassword = '1'; --Org already exited passed


--print @result











--[join_orgnization](@OrgName varchar(25),@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [join_orgnization] @OrgName = 'testOrg1', @inUsername = 'test6', @inPassword = '666'; --NoSuchUser passed
--EXEC @result = [join_orgnization] @OrgName = 'testOrg1', @inUsername = 'test1', @inPassword = '666'; --User name and password does not match passed
--EXEC @result = [join_orgnization] @OrgName = 'testOrg1', @inUsername = 'test1', @inPassword = '111'; --Join a org created by himself  FAILED!!!!!
--EXEC @result = [join_orgnization] @OrgName = 'testOrg1', @inUsername = 'test2', @inPassword = '222'; --valid
--EXEC @result = [join_orgnization] @OrgName = 'testOrg1', @inUsername = 'test2', @inPassword = '222'; --Already in this Org passed (system call)
--EXEC @result = [join_orgnization] @OrgName = NULL, @inUsername = 'test1', @inPassword = '111'; --Test NULL passed
--EXEC @result = [join_orgnization] @OrgName = 'testOrg1', @inUsername = NULL, @inPassword = '111'; --Test NULL passed
--EXEC @result = [join_orgnization] @OrgName = 'testOrg1', @inUsername = 'test1', @inPassword = NULL; --Test NULL passed
--EXEC @result = [join_orgnization] @OrgName = 'testOrg6', @inUsername = 'test1', @inPassword = '111';--Org does not exist passed


--print @result




--[check_my_organization](@inUsername varchar(25),@inPassword varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_my_organization] @inUsername = 'test6', @inPassword = '666'; --NoSuchUser passed
--EXEC @result = [check_my_organization] @inUsername = 'test1', @inPassword = '666';--Not match
--EXEC @result = [check_my_organization] @inUsername = 'test1', @inPassword = '111'; --valied passed (Only join, not created)
--EXEC @result = [check_my_organization] @inUsername = 'test3', @inPassword = '333'; --Not join passed
--EXEC @result = [check_my_organization] @inUsername = 'test2', @inPassword = '222'; --valid passed


--PRINT @result



