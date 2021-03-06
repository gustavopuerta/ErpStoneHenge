USE [erp]
GO
/****** Object:  Table [dbo].[contest_status]    Script Date: 04/18/2014 13:17:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contest_status](
	[id] [numeric](5, 0) NOT NULL,
	[description] [varchar](20) NULL,
	[value] [nvarchar](2) NULL,
	[color] [varchar](10) NULL,
 CONSTRAINT [PK_Contest_Status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[contest_status] ([id], [description], [value], [color]) VALUES (CAST(1 AS Numeric(5, 0)), N'New', N'N', N'default')
INSERT [dbo].[contest_status] ([id], [description], [value], [color]) VALUES (CAST(2 AS Numeric(5, 0)), N'Taken', N'T', N'yellow')
INSERT [dbo].[contest_status] ([id], [description], [value], [color]) VALUES (CAST(3 AS Numeric(5, 0)), N'Uploaded', N'U', N'green')
INSERT [dbo].[contest_status] ([id], [description], [value], [color]) VALUES (CAST(4 AS Numeric(5, 0)), N'Cancel', N'C', N'red')
/****** Object:  Table [dbo].[contest]    Script Date: 04/18/2014 13:17:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contest](
	[id_order] [numeric](18, 0) NOT NULL,
	[cstatus] [varchar](2) NULL,
	[taken_by] [varchar](100) NULL,
	[notes] [varchar](200) NULL,
	[reason_cancel] [varchar](200) NULL,
 CONSTRAINT [PK_contest] PRIMARY KEY CLUSTERED 
(
	[id_order] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
