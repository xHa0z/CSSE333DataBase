USE [wp3]
GO

/****** Object:  StoredProcedure [dbo].[addtag]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[addtag]
(
@inUsername varchar(25),
@inPassword varchar(25),
@EventName varchar(25),
@Tagname varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End
Declare @TID int
set @TID = (select TID from Tag where Tagname = @Tagname)
if @TID IS NULL
	begin
		return 2 /*No tag? */
	end

Declare @EID int
set @EID = (select EID from [Event] where EventName = @EventName)

if @EID is null
	begin
		return 3 
	end

if (select E_UserID from [Event] where EID = @EID) <> @userID
	begin
		return 4
	end

if (select count(*) from Has where EID= @EID and TID = @TID) > 0
	begin
		return 5
	end

insert into Has values (@EID,@TID)
GO

/****** Object:  StoredProcedure [dbo].[check_event]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[check_event]
(
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End



select EventName,Start,[End],Location,E.[Description],[Type]
from [Event] as E join [Join] as J on E.EID = J.J_EID
where @userID = J_UID 


GO

/****** Object:  StoredProcedure [dbo].[check_event_tag]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[check_event_tag]

(
@EventName varchar(25)
)

as

Declare @EID int
set @EID = (select EID from [Event] where @EventName = EventName)

if @EID is null
	begin
		return 1
	end
select Tagname
From Tag as T join Has as H on T.TID = H.TID
where @EID = H.EID
GO

/****** Object:  StoredProcedure [dbo].[check_invitation]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[check_invitation]
(
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End


select R_IID, Title, [Message], EventName,Start,[End],Location, [Description]
from [Receive] as R join Invitation as I on R.R_IID = I.IID join [Event] as E on I.EventID = E.EID 
join [User] on [User].UID=R_UID
WHERE [User].Username = @inUsername AND [User].[Password] = @hashed_password
GO

/****** Object:  StoredProcedure [dbo].[check_joined_organization]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[check_joined_organization]

(


@inUsername varchar(25),
@inPassword varchar(25)

)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT




set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 


Begin
       	return 1; /*No such user */
End


select OrgName
from Organization as O join MemberOF as M on O.OrgID = M.M_OID 
where M_UID = @userID




GO

/****** Object:  StoredProcedure [dbo].[check_my_current_event]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[check_my_current_event]
(
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

select EventName,Start,[End],Location,[Description],[Type]
from [Event] as E join [Join] as J on E.EID = J.J_EID
where @userID = J_UID and Start <= getDate() and [End] >= getDate()
GO

/****** Object:  StoredProcedure [dbo].[check_my_organization]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[check_my_organization]

(

@inUsername varchar(25),
@inPassword varchar(25)

)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End


select OrgName
from Organization
where C_ID = @userID
GO

/****** Object:  StoredProcedure [dbo].[check_people_in_event]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[check_people_in_event]

(@eventName varchar(25)

)


as

select Username
from [Event] as E join [User] as U on E.E_UserID = U.[UID]
where @eventName = EventName
GO

/****** Object:  StoredProcedure [dbo].[check_request]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[check_request]
(
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

select Sender, Username From FriendRequest as F join [User] as U on F.Sender = U.[UID] where Receiver = @userID
GO

/****** Object:  StoredProcedure [dbo].[check_tags]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[check_tags]
as
select TID,TagName, [Description] from Tag
GO

/****** Object:  StoredProcedure [dbo].[confirm_invitation]    Script Date: 5/22/2015 4:19:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[confirm_invitation]
(@IID int,
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

if @IID is null
	begin
		return 2; /*No IID? */
	end

Declare @level smallint
	set @level = (select [level] from [Receive] where R_UID = @userID and R_IID = @IID)

if @level is null
	begin
		return 3; /* no such receive? */
	end


Declare @EventID int
	set @EventID = (select EventID from [Invitation] where IID = @IID)


if @EventID is null
	begin
		return 4 /* no such invitation? */
	end




insert into [Join] values (@userID,@EventID,@level)
delete from [Receive] where R_UID = @userID and R_IID = @IID

return 0
GO

/****** Object:  StoredProcedure [dbo].[confirm_request]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[confirm_request]
(
@inUsername varchar(25),
@inPassword varchar(25),
@SenderName varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

Declare @SenderID int
set @SenderID = (select [UID] From [User] where Username = @SenderName)


if @SenderID is null
	begin
		return 2 /* No such sender*/
	end


if (select count(*) from FriendRequest where Sender = @SenderID and Receiver = @userID) <> 1
	begin
		return 3 /* No such request or more than 1? */
	end

if (select count(*) from UserRelation where (User1 = @SenderID and User2 = @userID) or (User1 = @userID and User2 = @SenderID)  ) > 0
	begin
		return 4 /* relation already exist */
	end

insert into UserRelation values (@SenderID,@userID,0,0)
delete from FriendRequest where sender =@senderID and Receiver = @userID

return 0
GO

/****** Object:  StoredProcedure [dbo].[create_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[create_event]
(@name varchar(25),
@Start varchar(25),
@End varchar(25),
@Location varchar(40),
@Description text,
@type varchar(25), 
@HostName varchar(25),
@inUsername varchar(25),
@inPassword varchar(25),
@TagName varchar(25) = null
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End



ELSE
        begin
            Declare @startDate date
			Declare @EndDate date
			Declare @HostID int
			set @HostID = (select OrgID from Organization where @HostName = OrgName)

			
			set @startDate = Convert (Datetime, @start,120)
			set @EndDate = Convert (Datetime, @End, 120)
			
			if @startDate > @EndDate
				begin
					return 2; /*Invalid Date*/
				end
				
            INSERT into Event (EventName,Start,[End],Location,[Description],[Type],HostID,E_UserID)

            values (@name,@StartDate,@EndDate,@Location,@Description, @type , @HostID, @userID)

			Declare @EID int
			set @EID = (select EID from [Event] where EventName = @name)
			insert into [Join] values (@userID,@EID,0)
			
			Declare @TID int
			set @TID = (select TID from Tag where @Tagname = Tagname)

			if @TID is not null
				begin
					insert into Has values (@EID,@TID)
				end

            return 0
       end
GO

/****** Object:  StoredProcedure [dbo].[create_invitation]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[create_invitation]
(@EventName varchar(25),
@inUsername varchar(25),
@inPassword varchar(25),
@Title varchar(25),
@Message text = null

)

as



if @Title is null
	begin 
		return 3 /* Title cannot be null*/
	end

Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End



Declare @EID int
set @EID = (select EID from [Event] where EventName = @EventName)

if @EID is null
	begin
		return 2 /* No such event */
	end

Declare @level smallint
set @level = (select [level] from [Join] where J_UID = @userID and J_EID = @EID)

if @level is null
	begin
		return 4; /*This user has not joined this event himself*/
	end

if @level > 2
	begin
		return 5 /*The user has no right to send invitation of this event*/
	end


if (select count(*) from Invitation where Title = @Title and @EID = EventID) > 0
	begin
		return 6 /*duplicate invitation */
	end

insert into Invitation (Title,[Message],EventID,I_UserID,[level]) values (@Title,@Message,@EID,@userID,@level)

return 0

GO

/****** Object:  StoredProcedure [dbo].[create_orgnization]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[create_orgnization]
(@OrgName varchar(25),
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

if @OrgName is null
	begin
		return 2; /*No name? */
	end

if (select count(*) from Organization where OrgName = @OrgName) > 0

	begin
		return 3 /* already exist */
	end

if (select count(*) from Organization where C_ID = @userID) > 0
	
	begin
		return 4 /* this user already created a organization*/
	end

insert into Organization(OrgName,C_ID) values (@OrgName,@userID)
Declare @OID int
set @OID = (select OrgID from Organization where @OrgName = OrgName)

insert into MemberOf values(@userID,@OID,'creater')


GO

/****** Object:  StoredProcedure [dbo].[CreateAccount]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[CreateAccount]
(@Username varchar(25), 
@Password varchar(25), 
@Contact bigint = null, 
@Nickname varchar(25) = null)
as

if (@Username is null or @Password is null)
Begin
	/* 'Invalid username or password' */
	return 1	
End


if (select Count(Username) from [User] where Username = @Username) > 0

Begin
	/* 'Username already exist' */
	return 2
End

ELSE

begin
Declare @hashed_password varbinary(8000)

execute saltedHash @Username,@Password,@hashed_password OUTPUT

insert into [User] (Username, [Password], Contact, Nickname)
values (@Username , @hashed_password, @Contact, @Nickname)

return 0

end
GO

/****** Object:  StoredProcedure [dbo].[delete_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[delete_event]
(@Username varchar(25), 
@Password varchar(25),
@Eventname varchar(25))

as
DECLARE @userID int;

DECLARE @eventID int;

Declare @hashed_password varbinary(8000)
execute saltedHash @Username,@Password,@hashed_password OUTPUT


set @userID =
		(select UID
		FROM [User]
		WHERE Username = @Username
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

ELSE

Begin
		set @eventID = (Select EID from Event where E_UserID = @userID and EventName = @Eventname)
		
		if @eventID is NULL
			begin

				return 2 /*No such event*/
			end
		else
			begin
				Delete From Event where EID = @eventID
			
				return 0 /*succeed */
			end
End

GO

/****** Object:  StoredProcedure [dbo].[delete_invitation]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[delete_invitation]
(
@inUsername varchar(25),
@inPassword varchar(25),
@Title varchar(25),
@EventName varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

declare @EID int
set @EID = (select EID from [Event] where EventName = @EventName)
if @EID is null
	begin
		return 2 /*no such event?*/
	end


declare @IID int
set @IID = (select IID from Invitation where @Title = Title and I_UserID = @userID and EventID = @EID)
if @IID is null
	begin
		return 3 /*No such invitation? */
	end


delete from Invitation Where @IID = IID
GO

/****** Object:  StoredProcedure [dbo].[delete_organization]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[delete_organization]
(
@inUsername varchar(25),
@inPassword varchar(25),
@OrgName varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

Declare @OID int
set @OID = (select [OrgID] from [Organization] where OrgName = @OrgName)

if @OID is null
	begin
		return 2 /*No such orgnization */
	end

if (select C_ID from Organization where @OID = OrgID) <> @userID
	begin
		return 3 /*No right to delete*/
	end

delete from organization where @OID = OrgID
GO

/****** Object:  StoredProcedure [dbo].[delete_request]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[delete_request]
(
@inUsername varchar(25),
@inPassword varchar(25),
@ReceiverName varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

Declare @RID int
set @RID = (select [UID] from [User] where Username = @ReceiverName)

if @RID is null
	begin
		return 2 /*No such receiver */
	end

delete from request where Sender= @userID and Receiver = @RID
GO

/****** Object:  StoredProcedure [dbo].[edit_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[edit_event]

(
@Username varchar(25) ,
@Password varchar(25) ,
@EventName varchar(50) ,

@newEventName varchar(50) = null,
@Start varchar(25) = null,
@End varchar(25) = null,
@Location varchar(25) = null,
@Type varchar(20) = null,
@Description text = null,
@Hostname varchar(25) = null


)

as


DECLARE @userID varchar(25);
Declare @EID int 
set @EID = (select EID from [Event] where EID = @EID)

Declare @hashed_password varbinary(8000)
execute saltedHash @Username,@Password,@hashed_password OUTPUT



SET @userID =
		(Select UID
        FROM [User]
        WHERE Username = @Username
        AND [Password] = @hashed_password)


if (select count(*) from [Event] where E_userID = @userID and EventName = @EventName) > 0
	
	begin
		if @newEventName is not null
			begin
				update [Event]
				set EventName = @newEventName
				where E_userID = @userID and EventName = @EventName
			end

		if @Start is not null
			Declare @startDate date
			set @startDate = convert(datetime,@Start,120)
			begin
				update [Event]
				set Start = @startDate
				where E_userID = @userID and EventName = @EventName
			end

		if @End is not null
			Declare @EndDate date
			set @EndDate =convert(datetime,@End,120)
			begin
				update [Event]
				set [End] = @EndDate
				where E_userID = @userID and EventName = @EventName
			end

		if @Location is not null
			begin
				update [Event]
				set [Location] = @Location
				where E_userID = @userID and EventName = @EventName
			end

		if @Type is not null
			begin
				update [Event]
				set [Type] = @Type
				where E_userID = @userID and EventName = @EventName
			end

		if @Description is not null
			begin
				update [Event]
				set [Description] = @Description
				where E_userID = @userID and EventName = @EventName
			end

		if @Hostname is not null
			begin
				Declare @hostID int
				set @hostID = (select OrgID from Organization where OrgName = @Hostname)
				if @hostID is not null
					begin
						update [Event]
						set HostID = @hostID
						where E_userID = @userID and EventName = @EventName and HostID = @hostID
					end
			end
		
	

		return 0 /* succeed*/
	end
else
	begin
		return 1 /* no such EVENT*/
	end
GO

/****** Object:  StoredProcedure [dbo].[edit_user]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[edit_user]
(
@Username varchar(25),
@Password varchar(25),
@newPassword varchar(25) = null,
@Contact int = null,
@Nickname varchar(20)=null,
@share_level smallint = null )
as



DECLARE @userID varchar(25);


Declare @hashed_password varbinary(8000)
execute saltedHash @Username,@Password,@hashed_password OUTPUT



SET @userID =
		(Select UID
        FROM [User]
        WHERE Username = @Username
        AND [Password] = @hashed_password)



IF @userID is NULL 
    
    Begin
        return 1
    End




ELSE
        begin
           if @Password is not null
				begin
					Declare @new_password varbinary(8000)
					execute saltedHash @Username,@newPassword,@new_password OUTPUT
					update [User]
					set [Password] = @new_password
					where UID = @userID
				end 
           
		   if @Contact is not null
				Begin
					update [User]
					set Contact = @Contact
					where UID = @userID
				end
		   
		   if @Nickname is not null
				Begin
					update [User]
					set Nickname = @Nickname
					where UID = @userID
				end
		   if @share_level is not null
				begin
					update [User]
					set share_level = @share_level
					where UID = @userID
				end
			

            return 0
        End
GO

/****** Object:  StoredProcedure [dbo].[event_can_invite]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[event_can_invite]
(
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

select EID,EventName,Start,[End], Location, [Description],[Type]
from [Event] 
where EID in (select J_EID from [Join] where J_UID = @userID and [level] < 3)
GO

/****** Object:  StoredProcedure [dbo].[friends_and_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[friends_and_event]

(@Username varchar(25), 
@Password varchar(25))

as

DECLARE @userID int;
DECLARE @result smallint;


Declare @hashed_password varbinary(8000)
execute saltedHash @Username,@Password,@hashed_password OUTPUT


set @userID =
		(select UID
		FROM [User]
		WHERE Username = @Username
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1;
End



select Username,Contact,Nickname,EventName
from ((select user1 as u,[level] as l from UserRelation where user2 = @userID) union (select user2,level2 from UserRelation where user1 = @userID)) as R
join [User] as U on R.u = U.[UID] join [Event] on U.[current_event] = [Event].EID
where l > share_level

GO

/****** Object:  StoredProcedure [dbo].[get_all_organization]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[get_all_organization]


as

select OrgID, OrgName
From Organization
GO

/****** Object:  StoredProcedure [dbo].[join_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[join_event]
(@EventName varchar(25),
@inUsername varchar(25),
@inPassword varchar(25))

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

Declare @EID int

set @EID = (select EID from [Event] where EventName = @EventName)

IF @EID is null

begin
		return 2; /*No such event*/
end

Declare @Type varchar(25)
set @Type = (select [Type] from [Event] Where @EID = EID)

if @Type = 'private'
	begin
		return 3 /*Not public event*/
	end


insert into [Join] values (@userID,@EID,3)
return (0);
GO

/****** Object:  StoredProcedure [dbo].[join_orgnization]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[join_orgnization]
(@OrgName varchar(25),
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

if @OrgName is null
	begin
		return 2; /*No name? */
	end

Declare @OrgID int
set @OrgID = (select OrgID from Organization where @OrgName = OrgName)

if @OrgID is null
	begin
		return 3 /* no such organization */
	end

insert into MemberOf(M_UID,M_OID,[description]) values (@userID,@OrgID,'member')


GO

/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Login]
(@Username varchar(25), 
@Password varchar(25))
as
DECLARE @userID int;
DECLARE @result smallint;


Declare @hashed_password varbinary(8000)
execute saltedHash @Username,@Password,@hashed_password OUTPUT


set @userID =
		(select UID
		FROM [User]
		WHERE Username = @Username
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	SET @result = 1;
End

ELSE

Begin
		SET @result = 0;
End

return @result
GO

/****** Object:  StoredProcedure [dbo].[member_in_organization]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[member_in_organization]

(

@inUsername varchar(25),
@inPassword varchar(25),
@OrgName varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End


Declare @OrgID int
set @OrgID = (select OID from Organizatoin where OrgName = @OrgName)

if @OrgID is null
	begin
		return 2 /* No such Org */
	end

if (select count(*) from MemberOf where M_UID = @userID and M_OID = @OrgID) = 0
	begin
		return 3 /*Not a member */
	end

select Username,Contact,Nickname
from [User] as U  join MemberOf as O on U.UID = O.M_UID
where O.M_OID = @OrgID
GO

/****** Object:  StoredProcedure [dbo].[my_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[my_event]
(
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

select EventName,Start,[End], Location, [Description],[Type]
from [Event]
where @userID = E_UserID
GO

/****** Object:  StoredProcedure [dbo].[my_friends]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[my_friends]

(@Username varchar(25), 
@Password varchar(25))

as

DECLARE @userID int;
DECLARE @result smallint;


Declare @hashed_password varbinary(8000)
execute saltedHash @Username,@Password,@hashed_password OUTPUT


set @userID =
		(select UID
		FROM [User]
		WHERE Username = @Username
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1;
End



select Username,Contact,Nickname
from ((select user1 as u,[level] as l from UserRelation where user2 = @userID) union (select user2,level2 from UserRelation where user1 = @userID)) as R
join [User] as U on R.u = U.[UID]


GO

/****** Object:  StoredProcedure [dbo].[my_invitation]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[my_invitation]
(
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

select Title,[Message],EventName,[level],IID
from Invitation as I join [Event] as E on I.EventID = E.EID
where I_UserID = @userID
GO

/****** Object:  StoredProcedure [dbo].[saltedHash]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**CREATE FUNCTION saltedHash(username VARCHAR(255),

                           password VARCHAR(255))

RETURNS BINARY(20) DETERMINISTIC

RETURN UNHEX(SHA1(CONCAT(username, password)));
**/


CREATE procedure [dbo].[saltedHash]
@name varchar(25),
@password varchar(25),
@result varbinary(8000) OUTPUT

as
Declare @HashThis nvarchar(4000)

set @HashThis = Convert(nvarchar(4000),   CONCAT(@name, @password)   )
set @result = (select HASHBYTES ('SHA1', @HashThis))



GO

/****** Object:  StoredProcedure [dbo].[search_by_tag]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[search_by_tag]

(
@Tagname varchar(25)
)

as

Declare @TID int
set @TID = (select TID from Tag where Tagname = @Tagname)

if @TID is null
	begin
		return 1
	end

select EventName,Start,[End],Location,[Description],[Type]
from [Event] as E join Has as H on E.EID = H.EID
where @TID = H.TID
GO

/****** Object:  StoredProcedure [dbo].[search_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[search_event]

(

@Name varchar(50)=null,
@Date varchar(25)=null,
@Location varchar(25) = null,
@Type varchar(20)=null


)
as

DECLARE @name_condition varchar(100);
DECLARE @date_condition varchar(100);
DECLARE @location_condition varchar(100);
DECLARE @type_condition varchar(100);

set @name_condition='';
set @date_condition='';
set @location_condition='';
set @type_condition='';

DECLARE @execution_string nvarchar(2000);

if @Name is not null
begin
	set @name_condition='AND EventName=  ''' + @Name + ''' ';
end

if @date is not null
begin
	Declare @realDate date;
	set @realDate = convert(Datetime,@Date,120);
	set @date_condition='AND ( [Start] < ''' + @Date + ' ''or [End] > ''' + @Date + ''') ';
end

if @Location is not null
begin
	set @location_condition='AND Location= ''' + @Location+ ''' ';
end

if @Type is not null
begin
	set @type_condition='AND Type = ''' + @Type + ''' ';
end

set @execution_string='select * from event WHERE 1=1 '+@name_condition +@date_condition +@location_condition +@type_condition;
Execute sp_executesql @execution_string;




/**
select * into #current From [Event]


if @Name is NOT null
	begin
		delete 
		from #current
		where EventName <> @Name
		
	end

if @Date is NOT null
	Declare @realDate date
	set @realDate = convert(Datetime,@Date,120)
	begin
		delete 
		from #current
		where @Date < Start or @Date > [End]
	end

if @Location is NOT null
	begin
		delete 
		from #current
		where Location <> @Location
	end

if @Type is not null
	begin
		delete 
		from #current
		where [Type] <> @Type
	end

*/


GO

/****** Object:  StoredProcedure [dbo].[search_user]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[search_user]

(

@Name varchar(50)
)
as

if @Name is null
	Begin
		select [UID],Username,Contact, Nickname
		from [User]
	end

else

begin
select [UID],Username,Contact,Nickname
		from [User]
		where Username like '%'+@Name+'%'
end



GO

/****** Object:  StoredProcedure [dbo].[send]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[send]
(@IID int,
@inUsername varchar(25),
@inPassword varchar(25),
@ReUsername varchar(25),
@Relevel smallint
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

Declare @ReUID int
set @ReUID = (select [UID] from [User] where Username = @ReUsername)

if @ReUID is null

	begin
		return 2 /* no such receiver */
	end

if @Relevel is null
	begin
		return 3 /* level cannot be null */
	end

Declare @level smallint

set @level = (select [level] from [Invitation] where @IID = IID and I_UserID = @userID )

if @level is null
	begin
		return 4 /* no such invitation? */
	end
if @level > @Relevel 
	begin
		return 5 /* invalid level */
	end


insert into [Receive] values (@ReUID,@IID,@Relevel)

return 0
GO

/****** Object:  StoredProcedure [dbo].[send_request]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[send_request](
@inUsername varchar(25),
@inPassword varchar(25),
@Username varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

Declare @userID2 int
set @userID2 = (select [UID] from [User] where Username = @Username)

if @userID2 is null
	begin
		return 2 /*No such Receiver */
	end

if @userID = @userID2
	begin
		return 3 /* No please~ */
	end

if (select count(*) from UserRelation where (User1 = @userID and User2 = @userID2) or (User1 = @userID2 and User2 = @userID)) > 0
	begin
		return 4 /* already friend*/
	end

insert into FriendRequest values (@userID, @userID2)
GO

/****** Object:  StoredProcedure [dbo].[set_level]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[set_level]
(

@inUsername varchar(25),
@inPassword varchar(25),
@Username varchar(25),
@level smallint 
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
		
End

Declare @userID2 int
set @userID2 = (select [UID] from [User] where Username = @Username)

if @userID2 is null
	begin
		return 2 /*No such user2 */
	end

if (select count(*) from UserRelation where User1 = @userID and User2 = @userID2) > 0
	begin
		update UserRelation
		set [level] = @level
		where User1 = @userID and User2 = @userID2
	end

else
	begin
		if (select count(*) from UserRelation where User1 = @userID2 and User2 = @userID) > 0
			begin
				update UserRelation
				set level2 = @level
				where User1 = @userID2 and User2 = @userID
			end
		else
			begin
				return 3 /* No such relation */
			end
	end

GO

/****** Object:  StoredProcedure [dbo].[show_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[show_event]
as

select EventName from [Event] where type='public'

GO

/****** Object:  StoredProcedure [dbo].[update_current_event]    Script Date: 5/22/2015 4:19:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[update_current_event]
(
@EventName varchar(25),
@inUsername varchar(25),
@inPassword varchar(25)
)

as


Declare @userID varchar(25)
Declare @hashed_password varbinary(8000)
execute saltedHash @inUsername,@inPassword,@hashed_password OUTPUT



set @userID =
		(select UID
		FROM [User]
		WHERE Username = @inUsername
		AND [Password] = @hashed_password)



IF @userID is NULL 

Begin
       	return 1; /*No such user */
End

Declare @EID int
set @EID = (select EID from [Event] where EventName = @EventName)

if @EID is null
	begin
		return 2 /* no such event */
	end

update [User]
set current_event = @EID
where UID = @userID


GO

