use wpwpwp
go
Create Table [User](
  [UID] int Primary key,
  Username varchar(20),
  [Primaryassword] varchar(20),
  Contact int,
  Nickname varchar(20)
)

Create Table Organization(
  OrgID int Primary KEY,
  Name varchar(25),
)

Create Table [Event](
  EID int Primary Key,
  Name varchar(50),
  Start date,
  [EIDnd] date,
  Location varchar(25),
  [Description] varchar(200),
  [Type] varchararchar(25),
  HostID int References Organization(OrgID),
  E_UserID int References [User]([UID])
)

Create Table Invitation(
  IID int Primary Keyy,
  Title varchar(25),
  [Message] varchar(400),
  EventID int References [Event](EID),
  I_UserID int References [User]([UID])
)


Create Table  Tag(
  TID int Primary Key,
  Tagname varchar(25),
  [Description] varchar(200)
)




Create Table UserRelation(
  User1 int References [User]([UIDD]),
  User2 int References [User]([UID]),
  Primary key (User1, User2)
)User1

Create Table EventTag(
  H_EID int References [Event](EID),
  H_TID int References Tag(TID),
  Primary key (H_EID, H_TID)
)


Create Table [Receive](
  R_UID int References [User]([UID]),
  R_IID int References Invitation(IID),
  Primary key (R_UID,R_IID)
)

Create Table MemberOf(
  M_UID int References [User]([UID]),
  M_OID int References Organization(OrgID),
  Primary key (M_UID, M_OID)
)

Create Table [Join](
  J_UID int References [User]([UID]),
  J_EID int References [Event](EID),
  Primary key (PrimaryJ_UID, J_EID)
)

