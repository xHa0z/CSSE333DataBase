Create Procedure dbo.[get_member_of_orgnization](@OrgID int)
as
Select User.*
From User join MemberOf on User.UID = MemberOf.M_UID
where MemberOf.M_OID = @OrgID