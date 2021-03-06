/*
参数:
$dbpath 数据库存储路径
*/

/*=========================================================================================*/
CREATE DATABASE [PayDB] 
ON  PRIMARY ( NAME = N'PayDB', FILENAME = N'$(dbpath)/PayDB.mdf' , SIZE = 3072KB , FILEGROWTH = 1024KB )
 LOG ON ( NAME = N'PayDB_log', FILENAME = N'$(dbpath)/PayDB_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO

use PayDB
GO
--权限
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'game_user')
	CREATE USER game_user FOR LOGIN game_user WITH DEFAULT_SCHEMA=[dbo]
GO
EXEC sp_addrolemember N'db_datareader', N'game_user'
EXEC sp_addrolemember N'db_datawriter', N'game_user'
EXEC sp_addrolemember N'db_ddladmin', N'game_user'
GO



--创建表
/*=========================================================================================*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GameInfo](
	[GameID] [int] NOT NULL,
	[GameName] [varchar](20) NOT NULL,
	[Currency] [varchar](20) NULL,
	[Multiple] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[GameWord] [varchar](100) NULL,
	[AgentsID] [varchar](20) NOT NULL DEFAULT ('0000'),
	[IsRelease] [bit] NOT NULL DEFAULT ((1)),
	[ReleaseDate] [datetime] NULL,
	[PayStyle] [varchar](500) NULL,
	[SocketServer] [varchar](100) NULL,
	[SocketPort] [int] NULL CONSTRAINT [DF_GameInfo_SocketPort]  DEFAULT ((0)),
 CONSTRAINT [PK_GameInfo] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SensitiveWord](
	[Code] [int] NOT NULL,
	[Word] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ConfigRetailerInfo](
	[RetailerId] [varchar](20) NOT NULL,
	[RetailerName] [varchar](50) NOT NULL,
	[Percentage] [decimal](8, 4) NULL,
	[DeveloperID] [int] NULL CONSTRAINT [DF__ConfigRet__Devel__33D4B598]  DEFAULT ((0)),
	[DeveloperName] [varchar](50) NULL,
	[DeveloperDate] [datetime] NULL,
	[MerchandiserID] [int] NULL CONSTRAINT [DF__ConfigRet__Merch__34C8D9D1]  DEFAULT ((0)),
	[MerchandiserName] [varchar](50) NULL,
	[MerchandiserDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[TaxRate] [decimal](8, 4) NULL DEFAULT ((0)),
	[PayPercentage] [decimal](8, 4) NULL,
 CONSTRAINT [PK__ConfigRetailerIn__32E0915F] PRIMARY KEY CLUSTERED 
(
	[RetailerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PayInfo](
	[PayId] [varchar](20) NOT NULL,
	[PayName] [varchar](50) NOT NULL,
	[Percentage] [decimal](8, 4) NOT NULL,
	[ParentID] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK__PayInfo__29572725] PRIMARY KEY CLUSTERED 
(
	[PayId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Settlement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RetailID] [varchar](50) NULL,
	[Amount] [decimal](16, 4) NULL,
	[GameID] [int] NULL,
	[CreatYear] [int] NULL,
	[CreatMouth] [int] NULL,
	[SettlementState] [int] NULL,
	[SettlementTime] [datetime] NULL,
	[Settlementer] [int] NULL,
 CONSTRAINT [PK__Settlement__5BE2A6F2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ServerInfo](
	[ID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[ServerName] [varchar](20) NOT NULL,
	[BaseUrl] [varchar](200) NOT NULL,
	[ActiveNum] [int] NULL,
	[Weight] [int] NULL,
	[IsEnable] [bit] NOT NULL DEFAULT ((1)),
	[TargetServer] [nchar](10) NULL,
	[EnableDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OrderInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderNO] [varchar](100) NOT NULL,
	[MerchandiseName] [varchar](100) NULL,
	[PayType] [varchar](20) NOT NULL,
	[Amount] [decimal](16, 4) NOT NULL,
	[Currency] [varchar](10) NOT NULL,
	[Expand] [varchar](200) NULL,
	[SerialNumber] [varchar](200) NULL,
	[PassportID] [varchar](100) NOT NULL,
	[ServerID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[gameName] [varchar](100) NULL,
	[ServerName] [varchar](100) NULL,
	[PayStatus] [int] NOT NULL,
	[Signature] [varchar](100) NOT NULL,
	[Remarks] [text] NULL,
	[GameCoins] [int] NOT NULL,
	[SendState] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[SendDate] [datetime] NULL,
	[RetailID] [varchar](50) NULL CONSTRAINT [DF__OrderInfo__Retai__60A75C0F]  DEFAULT ((0)),
	[DeviceID] [varchar](50) NULL,
 CONSTRAINT [PK_OrderInfo_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [un_OrderNO] UNIQUE NONCLUSTERED 
(
	[OrderNO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


alter table dbo.ServerInfo add IntranetAddress varchar(100);
go