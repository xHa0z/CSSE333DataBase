Create procedure dbo.[get_event_of_orgnization](@OrgID int)
as
select *
From Event 
Where HostID = @OrgID
