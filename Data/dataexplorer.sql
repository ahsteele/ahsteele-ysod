USE [master]
GO
/****** Object:  Database [DataExplorer]    Script Date: 06/21/2010 15:54:15 ******/
CREATE DATABASE [DataExplorer] ON  PRIMARY 
GO
ALTER DATABASE [DataExplorer] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataExplorer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataExplorer] SET ANSI_NULL_DEFAULT ON
GO
ALTER DATABASE [DataExplorer] SET ANSI_NULLS ON
GO
ALTER DATABASE [DataExplorer] SET ANSI_PADDING ON
GO
ALTER DATABASE [DataExplorer] SET ANSI_WARNINGS ON
GO
ALTER DATABASE [DataExplorer] SET ARITHABORT ON
GO
ALTER DATABASE [DataExplorer] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [DataExplorer] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [DataExplorer] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [DataExplorer] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [DataExplorer] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [DataExplorer] SET CURSOR_DEFAULT  LOCAL
GO
ALTER DATABASE [DataExplorer] SET CONCAT_NULL_YIELDS_NULL ON
GO
ALTER DATABASE [DataExplorer] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [DataExplorer] SET QUOTED_IDENTIFIER ON
GO
ALTER DATABASE [DataExplorer] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [DataExplorer] SET  DISABLE_BROKER
GO
ALTER DATABASE [DataExplorer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [DataExplorer] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [DataExplorer] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [DataExplorer] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [DataExplorer] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [DataExplorer] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [DataExplorer] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [DataExplorer] SET  READ_WRITE
GO
ALTER DATABASE [DataExplorer] SET RECOVERY FULL
GO
ALTER DATABASE [DataExplorer] SET  MULTI_USER
GO
ALTER DATABASE [DataExplorer] SET PAGE_VERIFY NONE
GO
ALTER DATABASE [DataExplorer] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'DataExplorer', N'ON'
GO
USE [DataExplorer]
GO
/****** Object:  Table [dbo].[Sites]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sites](
	[Id] [int] NOT NULL,
	[TinyName] [nvarchar](12) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[LongName] [nvarchar](64) NOT NULL,
	[Url] [nvarchar](max) NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[IconUrl] [nvarchar](max) NOT NULL,
	[DatabaseName] [nvarchar](max) NOT NULL,
	[Tagline] [nvarchar](max) NOT NULL,
	[TagCss] [nvarchar](max) NOT NULL,
	[TotalQuestions] [int] NULL,
	[TotalAnswers] [int] NULL,
	[TotalUsers] [int] NULL,
	[TotalComments] [int] NULL,
	[TotalTags] [int] NULL,
	[LastPost] [datetime] NULL,
	[ODataEndpoint] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[SavedQueries]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavedQueries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QueryId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[SiteId] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[CreationDate] [datetime] NULL,
	[LastEditDate] [datetime] NULL,
	[FavoriteCount] [int] NOT NULL,
	[IsFeatured] [bit] NULL,
	[IsSkipped] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[IsFirst] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [queryid_idx] ON [dbo].[SavedQueries] 
(
	[QueryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [userid_idx] ON [dbo].[SavedQueries] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QueryNameHistory]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QueryNameHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RevisionId] [int] NOT NULL,
	[QueryId] [int] NOT NULL,
	[UserId] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QueryExecutions]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QueryExecutions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QueryId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[SiteId] [int] NOT NULL,
	[FirstRun] [datetime] NOT NULL,
	[LastRun] [datetime] NOT NULL,
	[ExecutionCount] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [idxUniqueQE] ON [dbo].[QueryExecutions] 
(
	[UserId] ASC,
	[QueryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idxIdQE] ON [dbo].[QueryExecutions] 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Queries]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Queries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QueryHash] [uniqueidentifier] NULL,
	[QueryBody] [nvarchar](max) NULL,
	[CreatorId] [int] NULL,
	[CreatorIP] [varchar](15) NULL,
	[FirstRun] [datetime] NULL,
	[Views] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_qh] ON [dbo].[Queries] 
(
	[QueryHash] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CachedResults]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CachedResults](
	[QueryHash] [uniqueidentifier] NULL,
	[SiteId] [int] NULL,
	[Results] [nvarchar](max) NULL,
	[CreationDate] [datetime] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [idx_results] ON [dbo].[CachedResults] 
(
	[QueryHash] ASC,
	[SiteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Votes]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Votes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SavedQueryId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[VoteTypeId] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [queryIdx] ON [dbo].[Votes] 
(
	[SavedQueryId] ASC,
	[UserId] ASC,
	[VoteTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [queryIdx2] ON [dbo].[Votes] 
(
	[SavedQueryId] ASC,
	[VoteTypeId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](40) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[LastLogin] [datetime] NULL,
	[IsAdmin] [bit] NOT NULL,
	[IPAddress] [varchar](15) NULL,
	[IsModerator] [bit] NOT NULL,
	[CreationDate] [datetime] NULL,
	[AboutMe] [nvarchar](max) NULL,
	[Website] [varchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[DOB] [datetime] NULL,
	[LastActivityDate] [datetime] NULL,
	[LastSeenDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IdIdx] ON [dbo].[Users] 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserOpenId]    Script Date: 06/21/2010 15:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserOpenId](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[OpenIdClaim] [nvarchar](450) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [OpenIdClaimIdx] ON [dbo].[UserOpenId] 
(
	[OpenIdClaim] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spMergeUserBasedOnEmail]    Script Date: 06/21/2010 15:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spMergeUserBasedOnEmail]
	@email nvarchar(255) 
as 
--set nocount on 
begin tran 

declare @merge_to int

create table #merge (Id int)

insert #merge
select Id
from Users
where Email = @email 

if @@ROWCOUNT < 2 
begin
	rollback tran 
	return 
end

select @merge_to = min(Id) from #merge

create table #votes (
	SavedQueryId int, 
	VoteTypeId int,
	CreationDate datetime
)

-- votes are hard to merge 
insert #votes
select SavedQueryId, VoteTypeId, MIN(CreationDate) as CreationDate
from Votes where UserId in (select Id from #merge) 
group by SavedQueryId, VoteTypeId

delete from Votes where UserId in (select Id from #merge)

insert Votes (SavedQueryId,UserId,VoteTypeId,CreationDate)
select SavedQueryId, @merge_to, VoteTypeId, CreationDate
from #votes

delete from #merge where Id = @merge_to

delete from Users 
where Id in (select Id from #merge) 

update Queries
set CreatorId = @merge_to 
where CreatorId in (select Id from #merge) 

update QueryExecutions
set UserId = @merge_to 
where UserId in (select Id from #merge) 

update SavedQueries
set UserId = @merge_to 
where UserId in (select Id from #merge) 


update UserOpenId
set UserId = @merge_to 
where UserId in (select Id from #merge) 


commit tran
GO
/****** Object:  Default [DF__tmp_ms_xx__Favor__68487DD7]    Script Date: 06/21/2010 15:54:16 ******/
ALTER TABLE [dbo].[SavedQueries] ADD  DEFAULT ((0)) FOR [FavoriteCount]
GO
/****** Object:  Default [DF__SavedQuer__IsFir__778AC167]    Script Date: 06/21/2010 15:54:16 ******/
ALTER TABLE [dbo].[SavedQueries] ADD  DEFAULT ((0)) FOR [IsFirst]
GO
/****** Object:  Default [DF__tmp_ms_xx__IsAdm__4AB81AF0]    Script Date: 06/21/2010 15:54:16 ******/
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsAdmin]
GO
/****** Object:  Default [DF__tmp_ms_xx__IsMod__4BAC3F29]    Script Date: 06/21/2010 15:54:16 ******/
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsModerator]
GO
/****** Object:  Default [DF__tmp_ms_xx__Creat__4CA06362]    Script Date: 06/21/2010 15:54:16 ******/
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO


if not exists(select * from Sites where Sites.Name = 'StackOverflow')
   insert into Sites(
	Id, 
	TinyName,Name,LongName,
	Url,ImageUrl,IconUrl,
	DatabaseName,
	Tagline,
	TagCss,
	ODataEndpoint) values
	(1, 
	'so', 'StackOverflow', 'Stack Overflow',
	'http://stackoverflow.com', 'http://sstatic.net/so/img/logo.png', 'http://sstatic.net/so/favicon.ico',
	'StackOverflow',
	'Q&A for programmers', 
	'.post-tag{
background-color:#E0EAF1;
border-bottom:1px solid #3E6D8E;
border-right:1px solid #7F9FB6;
color:#3E6D8E;
font-size:90%;
line-height:2.4;
margin:2px 2px 2px 0;
padding:3px 4px;
text-decoration:none;
white-space:nowrap;
}
.post-tag:hover {
background-color:#3E6D8E;
border-bottom:1px solid #37607D;
border-right:1px solid #37607D;
color:#E0EAF1;
text-decoration:none;}',
'https://odata.sqlazurelabs.com/OData.svc/v0.1/rp1uiewita/StackOverflow')
GO
if not exists(select * from Sites where Sites.Name = 'SuperUser')
  insert into Sites(
	Id, 
	TinyName,Name,LongName,
	Url,ImageUrl,IconUrl,
	DatabaseName,
	Tagline,
	TagCss,
	ODataEndpoint) values 
	(2, 
	'su','SuperUser', 'Super User', 
	'http://superuser.com', 'http://sstatic.net/su/img/logo.png', 'http://sstatic.net/su/favicon.ico',
	'SuperUser',
	'Q&A for computer enthusiasts and power users',
	'.post-tag {
-moz-border-radius:7px 7px 7px 7px;
background-color:#FFFFFF;
border:2px solid #14A7C6;
color:#1087A4;
font-size:90%;
line-height:2.4;
margin:2px 2px 2px 0;
padding:3px 5px;
text-decoration:none;
white-space:nowrap;
}
.post-tag:visited {
color:#1087A4;
}
.post-tag:hover {
background-color:#14A7C6;
border:2px solid #14A7C6;
color:#F3F1D9;
text-decoration:none;
}',
'https://odata.sqlazurelabs.com/OData.svc/v0.1/rp1uiewita/SuperUser'
)

GO
if not exists(select * from Sites where Sites.Name = 'ServerFault')
 insert into Sites(
	Id, 
	TinyName,Name,LongName,
	Url,ImageUrl,IconUrl,
	DatabaseName,
	Tagline,
	TagCss,
	ODataEndpoint) values 
	(3, 
	'sf', 'ServerFault', 'Server Fault',
	'http://serverfault.com', 'http://sstatic.net/sf/img/logo.png', 'http://sstatic.net/sf/favicon.ico',
	'ServerFault',
	'Q&A for system administrators and IT professionals',
	'.post-tag {
background-color:#F3F1D9;
border:1px solid #C5B849;
color:#444444;
font-size:90%;
line-height:2.4;
margin:2px 2px 2px 0;
padding:3px 4px;
text-decoration:none;
white-space:nowrap;
}
.post-tag:visited {
color:#444444;
}
.post-tag:hover {
background-color:#444444;
border:1px solid #444444;
color:#F3F1D9;
text-decoration:none
}',
'https://odata.sqlazurelabs.com/OData.svc/v0.1/rp1uiewita/ServerFault')

GO
if not exists(select * from Sites where Sites.Name = 'Meta')
  insert into Sites(
	Id, 
	TinyName,Name,LongName,
	Url,ImageUrl,IconUrl,
	DatabaseName,
	Tagline,
	TagCss,
	ODataEndpoint) values 
	(4, 
	'mso', 'Meta', 'Meta Stack Overflow',
	'http://meta.stackoverflow.com', 'http://sstatic.net/mso/img/logo.png','http://sstatic.net/mso/favicon.ico',
	'Meta',
	'Q&A about Stack Overflow, Server Fault and Super User',
	'.post-tag  {
background-color:#E7E7E7;
border-bottom:1px solid #626262;
border-right:1px solid #979797;
color:#6F6F6F;
font-size:90%;
line-height:2.4;
margin:2px 2px 2px 0;
padding:3px 4px;
text-decoration:none;
white-space:nowrap;
}
.post-tag:visited {
color:#6F6F6F;
}
.post-tag:hover {
background-color:#626262;
border-bottom:1px solid #565656;
border-right:1px solid #565656;
color:#E7E7E7;
text-decoration:none;}',
'https://odata.sqlazurelabs.com/OData.svc/v0.1/rp1uiewita/Meta'
	)