USE [master]
GO
/****** Object:  Database [WaterMango]    Script Date: 2019-10-04 1:06:40 PM ******/
CREATE DATABASE [WaterMango]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WaterMango', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\WaterMango.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WaterMango_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\WaterMango_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [WaterMango] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WaterMango].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WaterMango] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WaterMango] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WaterMango] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WaterMango] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WaterMango] SET ARITHABORT OFF 
GO
ALTER DATABASE [WaterMango] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WaterMango] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WaterMango] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WaterMango] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WaterMango] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WaterMango] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WaterMango] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WaterMango] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WaterMango] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WaterMango] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WaterMango] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WaterMango] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WaterMango] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WaterMango] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WaterMango] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WaterMango] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WaterMango] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WaterMango] SET RECOVERY FULL 
GO
ALTER DATABASE [WaterMango] SET  MULTI_USER 
GO
ALTER DATABASE [WaterMango] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WaterMango] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WaterMango] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WaterMango] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WaterMango] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WaterMango', N'ON'
GO
ALTER DATABASE [WaterMango] SET QUERY_STORE = OFF
GO
USE [WaterMango]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [WaterMango]
GO
/****** Object:  Table [dbo].[WateringDetails]    Script Date: 2019-10-04 1:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WateringDetails](
	[plantID] [int] NOT NULL,
	[waterStartTime] [datetime] NOT NULL,
	[waterEndTime] [datetime] NOT NULL,
	[IsWateredFlag] [bit] NOT NULL,
 CONSTRAINT [PK_WateringDetails] PRIMARY KEY CLUSTERED 
(
	[plantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WateringDetails] ADD  CONSTRAINT [DF_WateringDetails_waterStartTime]  DEFAULT ('1900-01-01 00:00:00') FOR [waterStartTime]
GO
ALTER TABLE [dbo].[WateringDetails] ADD  CONSTRAINT [DF_WateringDetails_waterEndTime]  DEFAULT ('1900-01-01 00:00:00') FOR [waterEndTime]
GO
/****** Object:  StoredProcedure [dbo].[deleteWaterDetails]    Script Date: 2019-10-04 1:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[deleteWaterDetails]
	-- Add the parameters for the stored procedure here
	@plantID int 
AS
BEGIN
	delete from WateringDetails where plantID = @plantID
END
GO
/****** Object:  StoredProcedure [dbo].[getWaterDetails]    Script Date: 2019-10-04 1:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getWaterDetails]

@plantID int = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @plantID > 0

	select * from WateringDetails where plantID = @plantID
	
	else

    -- Insert statements for procedure here
	SELECT * from WateringDetails
END
GO
/****** Object:  StoredProcedure [dbo].[insertWaterDetails]    Script Date: 2019-10-04 1:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertWaterDetails]
	-- Add the parameters for the stored procedure here
	@plantID int = null,
	@waterStartTime datetime = null,
	@waterEndTime datetime = null,
	@IsWateredFlag	bit = null
AS
BEGIN
	insert into WateringDetails ([plantID],[waterStartTime],[waterEndTime],[IsWateredFlag])
	values(@plantID,@waterStartTime,@waterEndTime,@IsWateredFlag)
END
GO
/****** Object:  StoredProcedure [dbo].[updateWaterDetails]    Script Date: 2019-10-04 1:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateWaterDetails]
	-- Add the parameters for the stored procedure here
	@plantID int,
	@waterStartTime datetime,
	@waterEndTime datetime,
	@IsWateredFlag	bit
AS
BEGIN
	update WateringDetails set [plantID] = @plantID,[waterStartTime] = @waterStartTime,[waterEndTime] = @waterEndTime,[IsWateredFlag] = @IsWateredFlag
	 where plantID = @plantID
END
GO
USE [master]
GO
ALTER DATABASE [WaterMango] SET  READ_WRITE 
GO
