create procedure dbo.[create_event](@name varchar,@Start date,@End date,@Location varchar,@Description varchar,@type varchar, @HostID int,@UserID int)
as
insert into Event values (XXX,@name,@Start,@End,@Location,@Description, @type , @HostID, @UserID)