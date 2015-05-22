use wp3
go

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


--[check_people_in_event](@eventName varchar(25))
--DECLARE @result smallint
--EXEC @result = [check_people_in_event] @eventName = 'testEvn10'; --NoSuchEvent
--EXEC @result = [check_people_in_event] @eventName = NULL; --Test NULL
--EXEC @result = [check_people_in_event] @eventName = 'testEvn3'; --

--PRINT @result