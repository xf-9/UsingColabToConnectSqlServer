USE [master]
GO
/****** Object:  Database [ETL]    Script Date: 2025-05-04 11:34:03 ******/
CREATE DATABASE [ETL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ETL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\ETL.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ETL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\ETL_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ETL] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ETL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ETL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ETL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ETL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ETL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ETL] SET ARITHABORT OFF 
GO
ALTER DATABASE [ETL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ETL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ETL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ETL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ETL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ETL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ETL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ETL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ETL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ETL] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ETL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ETL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ETL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ETL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ETL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ETL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ETL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ETL] SET RECOVERY FULL 
GO
ALTER DATABASE [ETL] SET  MULTI_USER 
GO
ALTER DATABASE [ETL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ETL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ETL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ETL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ETL] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ETL] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ETL', N'ON'
GO
ALTER DATABASE [ETL] SET QUERY_STORE = ON
GO
ALTER DATABASE [ETL] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ETL]
GO
/****** Object:  User [app009]    Script Date: 2025-05-04 11:34:03 ******/
CREATE USER [app009] FOR LOGIN [app009] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [app009]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [app009]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 2025-05-04 11:32:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[CustomerID] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[customers] ([CustomerID], [FirstName], [LastName], [Email], [City], [Country]) VALUES
('1', 'Alice', 'Andersson', 'alice@example.com', 'Helsingborg', 'Sweden'),
('2', 'Bob', 'Bengtsson', 'bob@example.com', 'Helsingborg', 'Sweden'),
('3', 'Charlie', 'Carlsson', 'charlie@example.com', 'Gothenburg', 'Sweden'),
('4', 'David', 'Dahl', 'david@example.com', 'Linköping', 'Sweden'),
-- Invalid email (emma#example.com)
('5', 'Emma', 'Ekström', 'emma#example.com', 'Örebro', 'Sweden'),
('6', 'Fred', 'Forsberg', 'fred@example.com', 'Linköping', 'Sweden'),
-- NULL City
('7', 'George', 'Gustafsson', 'george@example.com', NULL, 'Sweden'),
('8', 'Hannah', 'Hedman', 'hannah@example.com', 'Helsingborg', 'Sweden'),
('9', 'Ivy', 'Ivarsson', 'ivy@example.com', 'Västerås', 'Sweden'),
-- Suspected typo in CustomerID (1O instead of 10)
('1O', 'Jack', 'Johansson', 'jack@example.com', 'Örebro', 'Sweden'),
-- NULL Email
('11', 'Karen', 'Karlsson', NULL, 'Linköping', 'Sweden'),
('12', 'Liam', 'Lindberg', 'liam@example.com', 'Gothenburg', 'Sweden'),
('13', 'Mona', 'Mårtensson', 'mona@example.com', 'Linköping', 'Sweden'),
('14', 'Nathan', 'Norberg', 'nathan@example.com', 'Örebro', 'Sweden'),
('15', 'Olivia', 'Olofsson', 'olivia@example.com', 'Uppsala', 'Sweden'),
-- Duplicate CustomerID (3)
('3', 'Peter', 'Persson', 'peter@example.com', 'Gothenburg', 'Sweden'),
('17', 'Quincy', 'Quist', 'quincy@example.com', 'Helsingborg', 'Sweden'),
('18', 'Rachel', 'Rosengren', 'rachel@example.com', 'Helsingborg', 'Sweden'),
('19', 'Steve', 'Sundberg', 'steve@example.com', 'Gothenburg', 'Sweden'),
('20', 'Tina', 'Törnqvist', 'tina@example.com', 'Helsingborg', 'Sweden');
