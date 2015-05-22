USE [wp3]
GO

/****** Object:  Table [dbo].[Event]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Event](
	[EID] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](50) NOT NULL,
	[Start] [date] NOT NULL,
	[End] [date] NOT NULL,
	[Location] [varchar](25) NULL,
	[Description] [text] NULL,
	[Type] [varchar](25) NULL,
	[HostID] [int] NULL,
	[E_UserID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[EventTag]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EventTag](
	[H_EID] [int] NOT NULL,
	[H_TID] [int] NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[FriendRequest]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FriendRequest](
	[Sender] [int] NOT NULL,
	[Receiver] [int] NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Has]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Has](
	[EID] [int] NOT NULL,
	[TID] [int] NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Invitation]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Invitation](
	[IID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](25) NOT NULL,
	[Message] [text] NULL,
	[EventID] [int] NULL,
	[I_UserID] [int] NULL,
	[level] [smallint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Join]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Join](
	[J_UID] [int] NOT NULL,
	[J_EID] [int] NOT NULL,
	[level] [smallint] NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[MemberOf]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[MemberOf](
	[M_UID] [int] NOT NULL,
	[M_OID] [int] NOT NULL,
	[description] [varchar](25) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Organization]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Organization](
	[OrgID] [int] IDENTITY(1,1) NOT NULL,
	[OrgName] [varchar](25) NOT NULL,
	[C_ID] [int] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Receive]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Receive](
	[R_UID] [int] NOT NULL,
	[R_IID] [int] NOT NULL,
	[Level] [smallint] NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Tag]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Tag](
	[TID] [int] IDENTITY(1,1) NOT NULL,
	[Tagname] [varchar](25) NOT NULL,
	[Description] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[User]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[User](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](20) NOT NULL,
	[Password] [varbinary](8000) NULL,
	[Contact] [varchar](25) NULL,
	[Nickname] [varchar](20) NULL,
	[share_level] [int] NOT NULL,
	[current_event] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[UserRelation]    Script Date: 5/22/2015 4:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserRelation](
	[User1] [int] NOT NULL,
	[User2] [int] NOT NULL,
	[level] [smallint] NOT NULL,
	[level2] [smallint] NOT NULL
) ON [PRIMARY]

GO

