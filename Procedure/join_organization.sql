create procedure dbo.[join_organization](@UID int, @MOID int)
as
insert into MemberOf values (@UID, @MOID)