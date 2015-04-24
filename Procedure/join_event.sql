create procedure dbo.[join_event](@UID int, @EID int)
as
insert into Join values (@UID,@EID)