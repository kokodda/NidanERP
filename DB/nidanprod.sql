USE [master]
GO
/****** Object:  Database [NidanERP]    Script Date: 29-04-2017 19:59:40 ******/
CREATE DATABASE [NidanERP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NidanERP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NidanERP.mdf' , SIZE = 5312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NidanERP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NidanERP_log.ldf' , SIZE = 1344KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NidanERP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NidanERP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NidanERP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NidanERP] SET ARITHABORT OFF 
GO
ALTER DATABASE [NidanERP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NidanERP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NidanERP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NidanERP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NidanERP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NidanERP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NidanERP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NidanERP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NidanERP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NidanERP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NidanERP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NidanERP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NidanERP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NidanERP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NidanERP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NidanERP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NidanERP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NidanERP] SET RECOVERY FULL 
GO
ALTER DATABASE [NidanERP] SET  MULTI_USER 
GO
ALTER DATABASE [NidanERP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NidanERP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NidanERP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NidanERP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [NidanERP] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NidanERP', N'ON'
GO
USE [NidanERP]
GO
/****** Object:  Table [dbo].[Absence]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Absence](
	[AbsenceId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelAbsenceEntitlementId] [int] NOT NULL,
	[AbsenceTypeId] [int] NOT NULL,
	[AbsenceStatusId] [int] NOT NULL,
	[AbsenceStatusByUser] [nvarchar](128) NULL,
	[AbsenceStatusDateTimeUtc] [datetime2](7) NULL,
	[Description] [nvarchar](max) NULL,
	[ReturnToWorkCompleted] [bit] NULL,
	[DoctorsNoteSupplied] [bit] NULL,
 CONSTRAINT [PK_Absence] PRIMARY KEY CLUSTERED 
(
	[AbsenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsenceDay]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsenceDay](
	[AbsenceDayId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsenceId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[AM] [bit] NOT NULL CONSTRAINT [DF_AbsenceDay_AM]  DEFAULT ((0)),
	[PM] [bit] NOT NULL CONSTRAINT [DF_AbsenceDay_PM]  DEFAULT ((0)),
	[Duration] [float] NOT NULL,
 CONSTRAINT [PK_AbsenceDay] PRIMARY KEY CLUSTERED 
(
	[AbsenceDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePeriod]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePeriod](
	[AbsencePeriodId] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_AbsencePeriod] PRIMARY KEY CLUSTERED 
(
	[AbsencePeriodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicy]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicy](
	[AbsencePolicyId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[WorkingPatternId] [int] NULL,
 CONSTRAINT [PK_AbsencePolicy] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicyEntitlement]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicyEntitlement](
	[AbsencePolicyEntitlementId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsenceTypeId] [int] NOT NULL,
	[FrequencyId] [int] NOT NULL,
	[Entitlement] [float] NOT NULL,
	[MaximumCarryForward] [float] NOT NULL,
	[IsUnplanned] [bit] NOT NULL,
	[IsPaid] [bit] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[HasEntitlement] [bit] NOT NULL,
 CONSTRAINT [PK_AbsencePolicyEntitlement] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyEntitlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicyPeriod]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicyPeriod](
	[AbsencePolicyPeriodId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[AbsencePeriodId] [int] NOT NULL,
 CONSTRAINT [PK_AbsencePolicyPeriod] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyPeriodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsenceStatus]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AbsenceStatus](
	[AbsenceStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AbsenceStatus] PRIMARY KEY CLUSTERED 
(
	[AbsenceStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AbsenceType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsenceType](
	[AbsenceTypeId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_AbsenceType] PRIMARY KEY CLUSTERED 
(
	[AbsenceTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Admission]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admission](
	[AdmissionId] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationPaymentReceiptId] [int] NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Fee] [int] NULL,
	[DownPayment] [int] NULL,
	[Lumpsum] [int] NULL,
	[Discount] [int] NULL,
	[DiscountFee] [int] NULL,
	[Particulars] [varchar](500) NULL,
	[PaymentType] [varchar](100) NOT NULL,
	[PaymentModeId] [int] NOT NULL,
	[ChequeNo] [varchar](100) NOT NULL,
	[ChequeDate] [date] NOT NULL,
	[BankName] [varchar](1000) NOT NULL,
	[FinancialYear] [varchar](50) NULL,
	[AdmissionDate] [date] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[FeeByStudent] [int] NULL,
 CONSTRAINT [PK_Admission] PRIMARY KEY CLUSTERED 
(
	[AdmissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Alert]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alert](
	[AlertId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Alert] PRIMARY KEY CLUSTERED 
(
	[AlertId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AreaOfInterest]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AreaOfInterest](
	[AreaOfInterestId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_AreaOfInterest] PRIMARY KEY CLUSTERED 
(
	[AreaOfInterestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[OrganisationId] [int] NULL,
	[PersonnelId] [int] NULL,
	[CentreId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsersAlertSchedule]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsersAlertSchedule](
	[AspnetUsersAlertScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[AspNetUsersId] [nvarchar](128) NOT NULL,
	[AlertId] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsersAlertSchedule] PRIMARY KEY CLUSTERED 
(
	[AspnetUsersAlertScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Batch]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Batch](
	[BatchId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Intake] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[BatchStartDate] [date] NOT NULL,
	[BatchEndDate] [date] NOT NULL,
	[NoOfHolidays] [int] NOT NULL,
	[NoOfHoursDaily] [int] NOT NULL,
	[BatchStartTimeHours] [int] NOT NULL,
	[BatchStartTimeMinutes] [int] NOT NULL,
	[BatchStartTimeSpan] [varchar](10) NOT NULL,
	[BatchEndTimeHours] [int] NOT NULL,
	[BatchEndTimeMinutes] [int] NOT NULL,
	[BatchEndTimeSpan] [varchar](10) NOT NULL,
	[AssesmentDate] [date] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[Remarks] [varchar](1000) NULL,
	[Month] [int] NOT NULL,
	[NoOfInstallment] [int] NOT NULL,
	[FirstInstallment] [int] NULL,
	[SecondInstallment] [int] NULL,
	[ThirdInstallment] [int] NULL,
	[FourthInstallment] [int] NULL,
	[FifthInstallment] [int] NULL,
	[SixthInstallment] [int] NULL,
	[SeventhInstallment] [int] NULL,
	[EighthInstallment] [int] NULL,
	[NinethInstallment] [int] NULL,
	[TenthInstallment] [int] NULL,
	[EleventhInstallment] [int] NULL,
	[TwelvethInstallment] [int] NULL,
	[RoomId] [int] NULL,
 CONSTRAINT [PK_Batch] PRIMARY KEY CLUSTERED 
(
	[BatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchDay]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchDay](
	[BatchDayId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[IsMonday] [bit] NOT NULL,
	[IsTuesday] [bit] NOT NULL,
	[IsWednesday] [bit] NOT NULL,
	[IsThursday] [bit] NOT NULL,
	[IsFriday] [bit] NOT NULL,
	[IsSaturday] [bit] NOT NULL,
	[IsSunday] [bit] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_BatchDay] PRIMARY KEY CLUSTERED 
(
	[BatchDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BatchTimePrefer]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchTimePrefer](
	[BatchTimePreferId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_BatchTimePrefer] PRIMARY KEY CLUSTERED 
(
	[BatchTimePreferId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchTrainer]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchTrainer](
	[BatchTrainerId] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_BatchTrainer] PRIMARY KEY CLUSTERED 
(
	[BatchTrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Brainstorming]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Brainstorming](
	[BrainstormingId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Brainstorming] PRIMARY KEY CLUSTERED 
(
	[BrainstormingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Budget]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Budget](
	[BudgetId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Building]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building](
	[BuildingId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[OrganisationId] [int] NOT NULL,
	[SiteId] [int] NOT NULL,
	[Address1] [nvarchar](100) NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[BuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CandidateFee]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CandidateFee](
	[CandidateFeeId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[CandidateInstallmentId] [int] NULL,
	[PaidAmount] [decimal](18, 2) NULL,
	[PaymentModeId] [int] NOT NULL,
	[FeeTypeId] [int] NOT NULL,
	[ChequeNumber] [varchar](50) NULL,
	[ChequeDate] [datetime] NULL,
	[BankName] [varchar](1000) NULL,
	[Penalty] [decimal](18, 2) NULL,
	[InstallmentDate] [datetime] NOT NULL,
	[StudentCode] [varchar](50) NULL,
	[InstallmentAmount] [decimal](18, 2) NULL,
	[BalanceInstallmentAmount] [decimal](18, 2) NULL,
	[FiscalYear] [varchar](50) NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Particulars] [varchar](max) NULL,
 CONSTRAINT [PK_CandidateFee] PRIMARY KEY CLUSTERED 
(
	[CandidateFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CandidateFeeDetail]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateFeeDetail](
	[CandidateFeeDetailId] [int] IDENTITY(1,1) NOT NULL,
	[CandidateInstallmentId] [int] NOT NULL,
	[AdmissionId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[TotalFee] [int] NOT NULL,
	[InstallmentNumber] [int] NOT NULL,
 CONSTRAINT [PK_CandidateFeeDetail] PRIMARY KEY CLUSTERED 
(
	[CandidateFeeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CandidateInstallment]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateInstallment](
	[CandidateInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[AdmissionId] [int] NOT NULL,
	[BatchCourseFee] [int] NOT NULL,
	[CandidateCourseFee] [int] NOT NULL,
	[DownPayment] [int] NOT NULL,
	[DiscountPercentage] [int] NOT NULL,
	[DiscountAmount] [int] NOT NULL,
	[NumberOfInstallment] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CandidateInstallment] PRIMARY KEY CLUSTERED 
(
	[CandidateInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CasteCategory]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CasteCategory](
	[CasteCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Caste] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CasteCategory] PRIMARY KEY CLUSTERED 
(
	[CasteCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Centre]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Centre](
	[CentreId] [int] IDENTITY(1,1) NOT NULL,
	[CentreCode] [varchar](100) NULL,
	[Name] [varchar](500) NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Centre] PRIMARY KEY CLUSTERED 
(
	[CentreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CentreCourse]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreCourse](
	[CentreCourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreCourse] PRIMARY KEY CLUSTERED 
(
	[CentreCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreCourseInstallment]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreCourseInstallment](
	[CentreCourseInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreCourseInstallment] PRIMARY KEY CLUSTERED 
(
	[CentreCourseInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreScheme]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreScheme](
	[CentreSchemeId] [int] IDENTITY(1,1) NOT NULL,
	[SchemeId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreScheme] PRIMARY KEY CLUSTERED 
(
	[CentreSchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreSector]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreSector](
	[CentreSectorId] [int] IDENTITY(1,1) NOT NULL,
	[SectorId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreSector] PRIMARY KEY CLUSTERED 
(
	[CentreSectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Colour]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Colour](
	[ColourId] [int] NOT NULL,
	[Hex] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColourId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyBuilding]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyBuilding](
	[CompanyBuildingId] [int] IDENTITY(1,1) NOT NULL,
	[BuildingId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CompanyBuilding] PRIMARY KEY CLUSTERED 
(
	[CompanyBuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Counselling]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Counselling](
	[CounsellingId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[FirstName] [varchar](100) NULL,
	[MiddleName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[CourseOfferedId] [int] NOT NULL,
	[PreferTiming] [varchar](500) NULL,
	[Remarks] [varchar](max) NULL,
	[FollowUpDate] [date] NULL,
	[RemarkByBranchManager] [varchar](max) NULL,
	[SectorId] [int] NULL,
	[PsychomatricTest] [varchar](100) NULL,
	[ConversionProspect] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[RemarkByBm] [varchar](max) NULL,
	[Registered] [bit] NULL,
 CONSTRAINT [PK_Counselling] PRIMARY KEY CLUSTERED 
(
	[CounsellingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Course]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[SectorId] [int] NOT NULL,
	[SchemeId] [int] NULL,
	[CourseTypeId] [int] NULL,
	[Description] [varchar](1000) NULL,
	[Duration] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseInstallment]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseInstallment](
	[CourseInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[CourseId] [int] NOT NULL,
	[Fee] [int] NOT NULL,
	[DownPayment] [int] NOT NULL,
	[LumpsumAmt] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK_CourseInstallment] PRIMARY KEY CLUSTERED 
(
	[CourseInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseSubject]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseSubject](
	[CourseSubjectId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CourseSubject] PRIMARY KEY CLUSTERED 
(
	[CourseSubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CourseType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseType](
	[CourseTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[CourseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[District]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[District](
	[DistrictId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Document]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Document](
	[DocumentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [varchar](100) NOT NULL,
	[StudentName] [varchar](500) NULL,
	[FileName] [varchar](4000) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Location] [varchar](max) NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DownloadedDateTime] [datetime] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentType](
	[DocumentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[BasePath] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED 
(
	[DocumentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmergencyContact]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmergencyContact](
	[EmergencyContactId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[Relationship] [varchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Forenames] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[CountryId] [int] NULL,
	[Address1] [nvarchar](100) NULL,
	[Address2] [nvarchar](100) NULL,
	[Address3] [nvarchar](100) NULL,
	[Address4] [nvarchar](100) NULL,
	[Postcode] [nvarchar](12) NULL,
	[Telephone] [varchar](15) NOT NULL,
	[Mobile] [varchar](15) NULL,
 CONSTRAINT [PK_EmergencyContact] PRIMARY KEY CLUSTERED 
(
	[EmergencyContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employment]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employment](
	[EmploymentId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NULL,
	[TerminationDate] [datetime2](7) NULL,
	[BuildingId] [int] NOT NULL,
	[ReportsToPersonnelId] [int] NULL,
	[JobTitle] [nvarchar](100) NULL,
	[JobDescription] [nvarchar](max) NULL,
	[EndEmploymentReasonId] [int] NULL,
	[WorkingPatternId] [int] NULL,
	[PublicHolidayPolicyId] [int] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
 CONSTRAINT [PK_Employment] PRIMARY KEY CLUSTERED 
(
	[EmploymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmploymentDepartment]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentDepartment](
	[EmploymentDepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EmploymentDepartment] PRIMARY KEY CLUSTERED 
(
	[EmploymentDepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmploymentTeam]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentTeam](
	[EmploymentTeamId] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EmploymentTeam] PRIMARY KEY CLUSTERED 
(
	[EmploymentTeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EnquiryId] [int] IDENTITY(100,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[AlternateMobile] [bigint] NULL,
	[EmailId] [varchar](500) NULL,
	[DateOfBirth] [date] NULL,
	[Age] [int] NOT NULL,
	[Address1] [varchar](500) NOT NULL,
	[Address2] [varchar](500) NULL,
	[Address3] [varchar](500) NULL,
	[Address4] [varchar](500) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [int] NOT NULL,
	[GuardianName] [varchar](500) NULL,
	[GuardianContactNo] [bigint] NULL,
	[OccupationId] [int] NOT NULL,
	[ReligionId] [int] NOT NULL,
	[CasteCategoryId] [int] NOT NULL,
	[Gender] [varchar](100) NOT NULL,
	[EducationalQualificationId] [int] NOT NULL,
	[YearOfPassOut] [varchar](100) NULL,
	[Marks] [varchar](100) NULL,
	[IntrestedCourseId] [int] NOT NULL,
	[HowDidYouKnowAboutId] [int] NOT NULL,
	[PreTrainingStatus] [varchar](100) NULL,
	[EmploymentStatus] [varchar](100) NULL,
	[Promotional] [varchar](100) NULL,
	[EnquiryDate] [date] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[StudentCode] [varchar](100) NULL,
	[EnquiryStatus] [varchar](100) NULL,
	[EmployerName] [varchar](500) NULL,
	[EmployerContactNo] [varchar](50) NULL,
	[EmployerAddress] [varchar](max) NULL,
	[AnnualIncome] [int] NULL,
	[SchemeId] [int] NULL,
	[EnquiryTypeId] [int] NOT NULL,
	[StudentTypeId] [int] NOT NULL,
	[SectorId] [int] NOT NULL,
	[BatchTimePreferId] [int] NOT NULL,
	[AppearingQualification] [varchar](500) NULL,
	[YearOfExperience] [int] NULL,
	[PlacementNeeded] [varchar](100) NULL,
	[Remarks] [varchar](max) NULL,
	[FollowUpDate] [datetime] NULL,
	[PreferredMonthForJoining] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[ConversionProspect] [int] NULL,
	[OtherInterestedCourse] [varchar](500) NULL,
	[RemarkByBm] [varchar](max) NULL,
	[Registered] [bit] NULL,
 CONSTRAINT [PK_Enquiry] PRIMARY KEY CLUSTERED 
(
	[EnquiryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnquiryCourse]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryCourse](
	[EnquiryCourseId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EnquiryCourse] PRIMARY KEY CLUSTERED 
(
	[EnquiryCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EnquiryType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnquiryType](
	[EnquiryTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EnquiryType] PRIMARY KEY CLUSTERED 
(
	[EnquiryTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Event]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[CreatedBy] [varchar](200) NULL,
	[CreatedDateTime] [datetime] NULL,
	[ApprovedBy] [int] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Event1] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Eventday]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Eventday](
	[EventdayId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Eventday] PRIMARY KEY CLUSTERED 
(
	[EventdayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventFunctionType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventFunctionType](
	[EventFunctionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EventFunctionType] PRIMARY KEY CLUSTERED 
(
	[EventFunctionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FeeType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FeeType](
	[FeeTypeId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FeeType] PRIMARY KEY CLUSTERED 
(
	[FeeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FollowUp]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FollowUp](
	[FollowUpId] [int] IDENTITY(1,1) NOT NULL,
	[FollowUpDateTime] [datetime] NULL CONSTRAINT [DF_FollowUp_FollowUpDateTime]  DEFAULT (((1900)-(1))-(1)),
	[MobilizationId] [int] NULL,
	[EnquiryId] [int] NULL,
	[Title] [varchar](50) NULL,
	[FirstName] [varchar](100) NULL,
	[MiddleName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Remark] [varchar](max) NULL,
	[Closed] [bit] NULL,
	[ReadDateTime] [datetime] NOT NULL CONSTRAINT [DF_FollowUp_ReadDateTime]  DEFAULT (((1900)-(1))-(1)),
	[CreatedDateTime] [datetime] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Mobile] [bigint] NULL,
	[IntrestedCourseId] [int] NOT NULL,
	[FollowUpType] [varchar](200) NULL,
	[AlternateMobile] [bigint] NULL,
	[FollowUpURL] [varchar](2000) NULL,
	[CounsellingId] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[RegistrationPaymentReceiptId] [int] NULL,
 CONSTRAINT [PK_FollowUp] PRIMARY KEY CLUSTERED 
(
	[FollowUpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Frequency]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Frequency](
	[FrequencyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Periods] [int] NOT NULL,
 CONSTRAINT [PK_Frequency] PRIMARY KEY CLUSTERED 
(
	[FrequencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Holiday]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Holiday](
	[HolidayId] [int] IDENTITY(1,1) NOT NULL,
	[HolidayDate] [date] NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[WeekDay] [varchar](100) NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Holiday] PRIMARY KEY CLUSTERED 
(
	[HolidayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Host]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Host](
	[HostId] [smallint] IDENTITY(1,1) NOT NULL,
	[HostName] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Host] PRIMARY KEY CLUSTERED 
(
	[HostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HowDidYouKnowAbout]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HowDidYouKnowAbout](
	[HowDidYouKnowAboutId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_HowDidYouKnowAboutUs] PRIMARY KEY CLUSTERED 
(
	[HowDidYouKnowAboutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Mobilization]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mobilization](
	[MobilizationId] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[CentreId] [int] NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[AlternateMobile] [bigint] NULL,
	[InterestedCourseId] [int] NOT NULL,
	[QualificationId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[FollowUpDate] [date] NULL,
	[Remark] [varchar](max) NULL,
	[MobilizerStatus] [varchar](100) NULL,
	[StudentLocation] [varchar](500) NULL,
	[OtherInterestedCourse] [varchar](1000) NULL,
	[GeneratedDate] [date] NOT NULL,
	[MobilizationTypeId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
 CONSTRAINT [PK_Mobilization] PRIMARY KEY CLUSTERED 
(
	[MobilizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MobilizationType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MobilizationType](
	[MobilizationTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_MobilizationType] PRIMARY KEY CLUSTERED 
(
	[MobilizationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Occupation]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Occupation](
	[OccupationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Occupation] PRIMARY KEY CLUSTERED 
(
	[OccupationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Organisation]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organisation](
	[OrganisationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Organisation_1] PRIMARY KEY CLUSTERED 
(
	[OrganisationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentMode]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentMode](
	[PaymentModeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_PaymentMode] PRIMARY KEY CLUSTERED 
(
	[PaymentModeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Personnel]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Personnel](
	[PersonnelId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Forenames] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[DOB] [datetime2](7) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Address1] [nvarchar](100) NOT NULL,
	[Address2] [nvarchar](100) NULL,
	[Address3] [nvarchar](100) NULL,
	[Address4] [nvarchar](100) NULL,
	[Postcode] [nvarchar](12) NOT NULL,
	[Telephone] [varchar](15) NOT NULL,
	[Mobile] [varchar](15) NULL,
	[NINumber] [varchar](10) NOT NULL,
	[BankAccountNumber] [varchar](10) NULL,
	[BankSortCode] [varchar](6) NULL,
	[BankAccountName] [nvarchar](100) NULL,
	[BankAddress1] [nvarchar](100) NULL,
	[BankAddress2] [nvarchar](100) NULL,
	[BankAddress3] [nvarchar](100) NULL,
	[BankAddress4] [nvarchar](100) NULL,
	[BankPostcode] [nvarchar](12) NULL,
	[BankTelephone] [varchar](15) NULL,
	[Email] [varchar](256) NOT NULL,
	[CurrentEmploymentId] [int] NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Personnel] PRIMARY KEY CLUSTERED 
(
	[PersonnelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonnelAbsenceEntitlement]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonnelAbsenceEntitlement](
	[PersonnelAbsenceEntitlementId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[AbsencePolicyPeriodId] [int] NOT NULL,
	[AbsenceTypeId] [int] NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[Entitlement] [float] NULL,
	[CarriedOver] [float] NULL,
	[Used] [float] NULL,
	[Remaining] [float] NULL,
	[MaximumCarryForward] [float] NULL,
	[FrequencyId] [int] NOT NULL,
	[EmploymentId] [int] NOT NULL,
 CONSTRAINT [PK_PersonnelAbsenceEntitlement] PRIMARY KEY CLUSTERED 
(
	[PersonnelAbsenceEntitlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Planning]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Planning](
	[PlanningId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Planning] PRIMARY KEY CLUSTERED 
(
	[PlanningId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Postevent]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Postevent](
	[PosteventId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Postevent] PRIMARY KEY CLUSTERED 
(
	[PosteventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PublicHoliday]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicHoliday](
	[PublicHolidayId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PublicHolidayPolicyId] [int] NOT NULL,
 CONSTRAINT [PK_PublicHoliday] PRIMARY KEY CLUSTERED 
(
	[PublicHolidayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PublicHolidayPolicy]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicHolidayPolicy](
	[PublicHolidayPolicyId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_PublicHolidayPolicy] PRIMARY KEY CLUSTERED 
(
	[PublicHolidayPolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Qualification]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Qualification](
	[QualificationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Qualification] PRIMARY KEY CLUSTERED 
(
	[QualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Question]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[EventFunctionTypeId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Registration](
	[RegistrationId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [int] NULL,
	[EnquiryId] [int] NOT NULL,
	[CandidateFeeId] [int] NOT NULL,
	[Remarks] [varchar](max) NULL,
	[FollowupDate] [datetime] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[RegistrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RegistrationPaymentReceipt]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegistrationPaymentReceipt](
	[RegistrationPaymentReceiptId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[CounsellingId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Fees] [int] NOT NULL,
	[ChequeNo] [varchar](100) NOT NULL,
	[ChequeDate] [date] NOT NULL,
	[BankName] [varchar](500) NOT NULL,
	[Particulars] [varchar](500) NOT NULL,
	[PaymentModeId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[RegistrationDate] [date] NOT NULL,
	[FollowUpDate] [date] NULL,
	[Remarks] [varchar](max) NULL,
	[FinancialYear] [varchar](100) NOT NULL,
 CONSTRAINT [PK_RegistrationPaymentReceipt] PRIMARY KEY CLUSTERED 
(
	[RegistrationPaymentReceiptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Religion]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Religion](
	[ReligionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Religion] PRIMARY KEY CLUSTERED 
(
	[ReligionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Room]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NULL,
	[Number] [int] NOT NULL,
	[Floor] [int] NOT NULL,
	[OccupiedStartDate] [date] NULL,
	[OccupiedEndDate] [date] NULL,
	[OccupiedStartTime] [varchar](50) NULL,
	[OccupiedEndTime] [varchar](50) NULL,
	[RoomTypeId] [int] NOT NULL,
	[Capacity] [int] NOT NULL,
	[SquareFeet] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoomType](
	[RoomTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED 
(
	[RoomTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Scheme]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Scheme](
	[SchemeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Scheme] PRIMARY KEY CLUSTERED 
(
	[SchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sector]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sector](
	[SectorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[SchemeId] [int] NOT NULL,
 CONSTRAINT [PK_Sector] PRIMARY KEY CLUSTERED 
(
	[SectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Session]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Session](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Duration] [varchar](500) NOT NULL,
	[CourseTypeId] [int] NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Site](
	[SiteId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CountryId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Site] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[State]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentType]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentType](
	[StudentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_StudentType] PRIMARY KEY CLUSTERED 
(
	[StudentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[CourseId] [int] NULL,
	[TrainerId] [int] NULL,
	[CourseTypeId] [int] NOT NULL,
	[TotalMarks] [int] NOT NULL,
	[PassingMarks] [int] NOT NULL,
	[NoOfAttemptsAllowed] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubjectCourse]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectCourse](
	[SubjectCourseId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_SubjectCourse] PRIMARY KEY CLUSTERED 
(
	[SubjectCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubjectTrainer]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectTrainer](
	[SubjectTrainerId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_SubjectTrainer] PRIMARY KEY CLUSTERED 
(
	[SubjectTrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Taluka]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Taluka](
	[TalukaId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[DistrictId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Taluka] PRIMARY KEY CLUSTERED 
(
	[TalukaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Team]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Template]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[TemplateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FileName] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Template] PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trainer]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trainer](
	[TrainerId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Address1] [varchar](100) NOT NULL,
	[Address2] [varchar](100) NULL,
	[Address3] [varchar](100) NULL,
	[Address4] [varchar](100) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [nvarchar](12) NOT NULL,
	[Gender] [varchar](100) NULL,
	[AadharNo] [bigint] NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[EmailId] [varchar](500) NOT NULL,
	[Certified] [varchar](100) NULL,
	[CertificationNo] [varchar](500) NULL,
	[SectorId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK_Trainer] PRIMARY KEY CLUSTERED 
(
	[TrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainerDocument]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainerDocument](
	[TrainerDocumentId] [int] IDENTITY(1,1) NOT NULL,
	[TrainerId] [int] NOT NULL,
	[TrainerName] [varchar](500) NULL,
	[FileName] [varchar](4000) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Location] [varchar](max) NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DownloadedDateTime] [datetime] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_TrainerDocument] PRIMARY KEY CLUSTERED 
(
	[TrainerDocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WorkingPattern]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingPattern](
	[WorkingPatternId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_WorkingPattern] PRIMARY KEY CLUSTERED 
(
	[WorkingPatternId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkingPatternDay]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingPatternDay](
	[WorkingPatternDayId] [int] IDENTITY(1,1) NOT NULL,
	[WorkingPatternId] [int] NOT NULL,
	[DayOfWeek] [smallint] NOT NULL,
	[AM] [bit] NOT NULL,
	[PM] [bit] NOT NULL,
 CONSTRAINT [PK_WorkingPatternDay] PRIMARY KEY CLUSTERED 
(
	[WorkingPatternDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[CounsellingSearchField]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[CounsellingSearchField]
AS 
SELECT 

	  C.CounsellingId,
      C.EnquiryId,
      C.CentreId,
      C.OrganisationId,
      C.PersonnelId,
      C.CourseOfferedId,
      C.PreferTiming,
      C.Remarks,
      C.FollowUpDate,
      C.RemarkByBranchManager,
      C.Title,
	  C.FirstName,
	  C.MiddleName,
	  C.LastName,
      C.SectorId,
      C.PsychomatricTest,
      C.ConversionProspect,
	  ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  +ISNULL(Co.Name, '')
	  +ISNULL(CONVERT(varchar,C.FollowUpDate, 101), '') + ISNULL(CONVERT(varchar,C.FollowUpDate, 103), '') 
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 105), '') + ISNULL(CONVERT(varchar,C.FollowUpDate, 126), '')
	  +ISNULL(S.Name, '')+ISNULL(C.PsychomatricTest, '')+ CONVERT(varchar, C.ConversionProspect )
	  as SearchField
	  

	  from

	  Counselling C WITH (NOLOCK) left join Course CO WITH (NOLOCK)
	on C.CourseOfferedId=CO.CourseId join Enquiry E WITH (NOLOCK)
	on E.EnquiryId=C.EnquiryId join Sector S WITH (NOLOCK)
	on S.SectorId=C.SectorId








GO
/****** Object:  View [dbo].[CourseSearchField]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[CourseSearchField]
AS 
SELECT 

		C.CourseId,
		C.Name,
		C.OrganisationId,
		C.SectorId,
		C.SchemeId,
		C.CourseTypeId,
		C.Description,
		C.Duration,

ISNULL(C.Name, '')+ISNULL(S.Name, '')+ISNULL(SC.Name, '') AS SearchField
FROM 
	Course C  WITH (NOLOCK) left join Sector S WITH (NOLOCK)
	on C.SectorId = S.SectorId join Scheme SC WITH (NOLOCK)
	on C.SchemeId=SC.SchemeId





GO
/****** Object:  View [dbo].[EnquirySearchField]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[EnquirySearchField]
AS 
SELECT 
	  E.EnquiryId,
      E.Title,
	  E.FirstName,
	  E.MiddleName,
	  E.LastName,
      E.Mobile,
      E.EmailId,
      E.Age,
	  E.DateOfBirth,
      E.Address1,
	  E.Address2,
	  E.Address3,
	  E.Address4,
	  E.PinCode,
	  E.TalukaId,
	  E.DistrictId,
	  E.StateId,
      E.GuardianName,
      E.GuardianContactNo,
      E.OccupationId,
      E.ReligionId,
      E.CasteCategoryId,
      E.Gender,
      E.EducationalQualificationId,
      E.YearOfPassOut,
      E.Marks,
      E.IntrestedCourseId,
      E.HowDidYouKnowAboutId,
      E.PreTrainingStatus,
      E.EmploymentStatus,
      E.Promotional,
      E.EnquiryDate,
      E.CentreId,
      E.OrganisationId,
      E.StudentCode,
      E.EnquiryStatus,
      E.EmployerName,
      E.EmployerContactNo,
      E.EmployerAddress,
      E.AnnualIncome,
      E.SchemeId,
      E.EnquiryTypeId,
      E.StudentTypeId,
      E.SectorId,
      E.BatchTimePreferId,
      E.AppearingQualification,
      E.YearOfExperience,
      E.PlacementNeeded,
      E.Remarks,
      E.FollowUpDate,
      E.PreferredMonthForJoining,
	  E.[Close],
	  E.ClosingRemark,
	  E.ConversionProspect,
	  E.OtherInterestedCourse,
	  E.RemarkByBm,
	  E.Registered,

	  ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')+ CONVERT(varchar, E.Mobile )+ISNULL(R.Name, '')
	  +ISNULL(CC.Caste, '')+ISNULL(Q.Name, '')+ISNULL(C.Name, '')+ISNULL(H.Name, '')+ISNULL(T.Name, '')+ISNULL(ST.Name, '')+ISNULL(D.Name, '')
	  + ISNULL(CONVERT(varchar,E.EnquiryDate, 101), '') + ISNULL(CONVERT(varchar,EnquiryDate, 103), '') 
	  + ISNULL(CONVERT(varchar,EnquiryDate, 105), '') + ISNULL(CONVERT(varchar,EnquiryDate, 126), '')+ISNULL(SC.Name, '')
	  +ISNULL(ET.Name, '')+ISNULL(S.Name, '')
	  + ISNULL(CONVERT(varchar,E.FollowUpDate, 101), '') 
	  + ISNULL(CONVERT(varchar,FollowUpDate, 103), '') 
	  + ISNULL(CONVERT(varchar,FollowUpDate, 105), '') 
	  + ISNULL(CONVERT(varchar,FollowUpDate, 126), '')
	  + ISNULL(CONVERT(varchar,E.DateOfBirth, 101), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 103), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 105), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 126), '')as SearchField
		
FROM 
	Enquiry E WITH (NOLOCK) left join Course C WITH (NOLOCK)
	on E.IntrestedCourseId=C.CourseId join Religion R WITH (NOLOCK)
	on E.ReligionId=R.ReligionId join CasteCategory CC WITH (NOLOCK)
	ON E.CasteCategoryId=CC.CasteCategoryId join Qualification Q WITH (NOLOCK) 
	on E.EducationalQualificationId=Q.QualificationId join Scheme SC WITH (NOLOCK)
	on E.SchemeId=SC.SchemeId join EnquiryType ET WITh(NOLOCK)
	on E.EnquiryTypeId=ET.EnquiryTypeId join Sector S WITH(NOLOCK)
	on E.SectorId=S.SectorId join HowDidYouKnowAbout H WITH(NOLOCk)
	on E.HowDidYouKnowAboutId=H.HowDidYouKnowAboutId join Taluka T WITH(NOLOCk)
	on E.TalukaId=T.TalukaId join District D WITH(NOLOCk)
	on E.DistrictId=D.DistrictId join State ST WITH(NOLOCk)
	on E.StateId=ST.StateId
	where E.EnquiryStatus != 'Registration'









GO
/****** Object:  View [dbo].[MobilizationSearchField]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[MobilizationSearchField]
AS 
SELECT 
		M.MobilizationId,
		M.EventId,
		M.OrganisationId,
		M.CentreId,
		M.Title,
		M.FirstName,
		M.MiddleName,
		M.LastName,
		M.Mobile,
		M.InterestedCourseId,
		M.QualificationId,
		M.CreatedDate,
		M.FollowUpDate,
		M.Remark,
		M.MobilizerStatus,
		p.Forenames[Mobilized By],
		M.StudentLocation,
		M.OtherInterestedCourse,
		M.GeneratedDate,
		ISNULL(M.Title, '')+ISNULL(M.FirstName, '')+ISNULL(M.MiddleName, '')+ISNULL(M.LastName, '')+ISNULL(E.Name, '')+ISNULL(C.Name, '')+ISNULL(p.Forenames, '')+ISNULL(M.StudentLocation, '') + ISNULL(CONVERT(varchar,M.GeneratedDate, 101), '') + ISNULL(CONVERT(varchar,GeneratedDate, 103), '') + ISNULL(CONVERT(varchar,GeneratedDate, 105), '') + ISNULL(CONVERT(varchar,GeneratedDate, 126), '') + ISNULL(StudentLocation, '') + ISNULL(Q.Name, '') + CONVERT(varchar, m.Mobile ) AS SearchField
FROM 
	Mobilization M  WITH (NOLOCK) left join Event E WITH (NOLOCK)
	on M.Eventid = E.EventId join Course C WITH (NOLOCK)
	ON C.CourseId = m.InterestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = M.QualificationId join Personnel P WITH (NOLOCK)
	on m.PersonnelId=p.PersonnelId











GO
/****** Object:  View [dbo].[PersonnelSearchField]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[PersonnelSearchField]
AS 
SELECT 
		PersonnelId,
		OrganisationId,
		Title,
		Forenames,
		Surname,
		DOB,
		CountryId,
		Address1,
		Address2,
		Address3,
		Address4,
		Postcode,
		Telephone,
		Mobile,
		NINumber,
		BankAccountNumber,
		BankSortCode,
		BankAccountName,
		BankAddress1,
		BankAddress2,
		BankAddress3,
		BankAddress4,
		BankPostcode,
		BankTelephone,
		Email,
	
		ISNULL(Surname, '') + ISNULL(Forenames, '') + ISNULL(Surname, '') + ISNULL(CONVERT(varchar,DOB, 101), '') + ISNULL(CONVERT(varchar,DOB, 103), '') + ISNULL(CONVERT(varchar,DOB, 105), '') + ISNULL(CONVERT(varchar,DOB, 126), '') + ISNULL(EMail, '') + ISNULL(Postcode, '') + ISNULL(Mobile, '') AS SearchField
FROM 
	Personnel  WITH (NOLOCK)








GO
/****** Object:  View [dbo].[TrainerSearchField]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[TrainerSearchField]
AS 
SELECT 
		T.TrainerId,
		T.Title,
		T.FirstName,
		T.MiddleName,
		T.LastName,
		T.DateOfBirth,
		T.Address1,
		T.Address2,
		T.Address3,
		T.Address4,
		T.PinCode,
		T.TalukaId,
		T.DistrictId,
		T.StateId,
		T.Gender,
		T.AadharNo,
		T.Mobile,
		T.EmailId,
		T.CertificationNo,
		T.SectorId,
		T.CourseId,
		T.CentreId,
		T.OrganisationId,
		T.PersonnelId,
		T.CreatedDate,
		
		ISNULL(T.Title, '')+ISNULL(T.FirstName, '')+ISNULL(T.MiddleName, '')+ISNULL(T.LastName, '')
		+CONVERT(varchar, T.Mobile )+ISNULL(S.Name, '')+ISNULL(C.Name, '')
		+ ISNULL(CONVERT(varchar,T.DateOfBirth, 101), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 103), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 105), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 126), '')
	  +ISNULL(TL.Name, '')+ISNULL(ST.Name, '')+ISNULL(D.Name, '') AS SearchField
FROM 
	Trainer T  WITH (NOLOCK) left join Sector S WITH (NOLOCK)
	on T.SectorId = S.SectorId join Course C WITH (NOLOCK)
	on T.CourseId=C.CourseId join Taluka TL WITH(NOLOCk)
	on T.TalukaId=TL.TalukaId join District D WITH(NOLOCk)
	on T.DistrictId=D.DistrictId join State ST WITH(NOLOCk)
	on T.StateId=ST.StateId





GO
/****** Object:  View [dbo].[UserAuthorisationFilter]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserAuthorisationFilter]
AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY p.PersonnelId, ur.RoleId) AS Id,
	p.PersonnelId,
	u.Id AS AspNetUsersId, 
	u.OrganisationId,
	ur.RoleId,
	r.Name AS RoleName
FROM
	AspNetUsers u
INNER JOIN
	AspNetUserRoles ur
		ON u.Id = ur.UserId
INNER JOIN
	AspNetRoles r 
		on ur.RoleId = r.Id
LEFT JOIN
	Personnel p 
		ON u.PersonnelId = p.PersonnelId







GO
SET IDENTITY_INSERT [dbo].[Absence] ON 

GO
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (65, 4, 1, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-04 14:49:09.9854584' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (69, 4, 47, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:29:42.0016821' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (71, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:39:14.5242644' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (72, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:41:31.5815424' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (73, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:48:45.7573640' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (75, 4, 45, 2, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 12:00:05.8472758' AS DateTime2), NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Absence] OFF
GO
SET IDENTITY_INSERT [dbo].[AbsenceDay] ON 

GO
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (85, 4, 65, CAST(N'2017-01-04' AS Date), 1, 1, 1)
GO
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (89, 4, 69, CAST(N'2017-04-11' AS Date), 1, 1, 1)
GO
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (91, 4, 71, CAST(N'2017-01-16' AS Date), 1, 1, 1)
GO
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (92, 4, 72, CAST(N'2017-01-09' AS Date), 1, 1, 1)
GO
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (93, 4, 73, CAST(N'2017-01-10' AS Date), 1, 1, 1)
GO
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (95, 4, 75, CAST(N'2017-01-11' AS Date), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[AbsenceDay] OFF
GO
SET IDENTITY_INSERT [dbo].[AbsencePeriod] ON 

GO
INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (18, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (19, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (20, CAST(N'2016-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4)
GO
SET IDENTITY_INSERT [dbo].[AbsencePeriod] OFF
GO
SET IDENTITY_INSERT [dbo].[AbsencePolicy] ON 

GO
INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (11, 4, N'Permanent', 39)
GO
INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (36, 4, N'General', 57)
GO
INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (38, 4, N'Test General', 56)
GO
SET IDENTITY_INSERT [dbo].[AbsencePolicy] OFF
GO
SET IDENTITY_INSERT [dbo].[AbsencePolicyEntitlement] ON 

GO
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (16, 4, 3, 1, 10, 4, 1, 1, 11, 1)
GO
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (33, 4, 2, 2, 10, 5, 0, 0, 11, 1)
GO
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (40, 4, 3, 1, 15, 7, 0, 1, 38, 1)
GO
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (46, 4, 3, 1, 12, 8, 1, 1, 36, 1)
GO
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (50, 4, 2, 2, 3, 2, 1, 1, 36, 1)
GO
SET IDENTITY_INSERT [dbo].[AbsencePolicyEntitlement] OFF
GO
SET IDENTITY_INSERT [dbo].[AbsencePolicyPeriod] ON 

GO
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (15, 4, 11, 20)
GO
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (29, 4, 38, 18)
GO
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (44, 4, 36, 18)
GO
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (45, 4, 36, 19)
GO
SET IDENTITY_INSERT [dbo].[AbsencePolicyPeriod] OFF
GO
SET IDENTITY_INSERT [dbo].[AbsenceStatus] ON 

GO
INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (1, N'Unapproved')
GO
INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (2, N'Approved')
GO
INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (3, N'Declined')
GO
SET IDENTITY_INSERT [dbo].[AbsenceStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[AbsenceType] ON 

GO
INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (2, 4, N'Casual', 9)
GO
INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (3, 4, N'Earned', 27)
GO
INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (4, 4, N'Doctor''s Appointment', 27)
GO
SET IDENTITY_INSERT [dbo].[AbsenceType] OFF
GO
SET IDENTITY_INSERT [dbo].[Admission] ON 

GO
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationPaymentReceiptId], [EnquiryId], [BatchId], [CentreId], [Fee], [DownPayment], [Lumpsum], [Discount], [DiscountFee], [Particulars], [PaymentType], [PaymentModeId], [ChequeNo], [ChequeDate], [BankName], [FinancialYear], [AdmissionDate], [OrganisationId], [FeeByStudent]) VALUES (9, 3, 101, 8, 1, 15000, 1000, 14000, 5, 750, NULL, N'Lumpsum', 1, N'abc', CAST(N'2017-04-27' AS Date), N'abc', NULL, CAST(N'0001-01-01' AS Date), 4, NULL)
GO
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationPaymentReceiptId], [EnquiryId], [BatchId], [CentreId], [Fee], [DownPayment], [Lumpsum], [Discount], [DiscountFee], [Particulars], [PaymentType], [PaymentModeId], [ChequeNo], [ChequeDate], [BankName], [FinancialYear], [AdmissionDate], [OrganisationId], [FeeByStudent]) VALUES (10, 4, 104, 8, 1, 15000, 1000, 14000, NULL, NULL, NULL, N'Installment', 1, N'Test', CAST(N'2017-04-28' AS Date), N'Test', NULL, CAST(N'2017-04-28' AS Date), 4, 1000)
GO
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationPaymentReceiptId], [EnquiryId], [BatchId], [CentreId], [Fee], [DownPayment], [Lumpsum], [Discount], [DiscountFee], [Particulars], [PaymentType], [PaymentModeId], [ChequeNo], [ChequeDate], [BankName], [FinancialYear], [AdmissionDate], [OrganisationId], [FeeByStudent]) VALUES (11, 4, 104, 8, 1, 15000, 1000, 14000, NULL, NULL, NULL, N'Installment', 1, N'Test', CAST(N'2017-04-28' AS Date), N'Test', NULL, CAST(N'2017-04-28' AS Date), 4, 1000)
GO
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationPaymentReceiptId], [EnquiryId], [BatchId], [CentreId], [Fee], [DownPayment], [Lumpsum], [Discount], [DiscountFee], [Particulars], [PaymentType], [PaymentModeId], [ChequeNo], [ChequeDate], [BankName], [FinancialYear], [AdmissionDate], [OrganisationId], [FeeByStudent]) VALUES (12, 4, 104, 8, 1, 15000, 1000, 14000, NULL, NULL, NULL, N'Installment', 1, N'Test', CAST(N'2017-04-28' AS Date), N'Test', NULL, CAST(N'2017-04-28' AS Date), 4, 1000)
GO
SET IDENTITY_INSERT [dbo].[Admission] OFF
GO
SET IDENTITY_INSERT [dbo].[AreaOfInterest] ON 

GO
INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (0, N'IT', 4)
GO
INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (1, N'ITEs', 4)
GO
SET IDENTITY_INSERT [dbo].[AreaOfInterest] OFF
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'1', N'SuperAdmin', N'ApplicationRole')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'2', N'Admin', N'ApplicationRole')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'3', N'User', N'ApplicationRole')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'01b40bcf-c599-473c-854c-4effa911ec1e', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'032c1e43-fba7-47f8-a477-9a09dcf82daa', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'04ee5f8b-e018-4a17-aac9-b6019cfce276', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'06586b59-4429-436d-9b26-800d880483df', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0a6b1e2b-4ac3-414e-8738-9e5a4d9b6e36', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0b23dc04-f364-45ba-b98e-fb0a49f94656', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0f13e616-a95a-47a5-9995-60cbc592c3d1', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0f7a08f6-1a5a-4319-a5fd-1f2fa719634d', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10f5e02b-c762-4565-8b2d-0f43aa081319', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'116fc575-4a86-4f13-b997-fe9f32d305ff', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'117e07b7-d696-43cf-ba26-1b2b9fa59702', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1700c28e-d342-4959-bb7d-641d66f6719f', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1b4ec15b-abff-46c0-a029-df405b2d4ffb', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1ca4f2bf-dd06-44a4-aa09-2b4dcf5b4a79', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1f2db86c-81fb-4eec-9d5f-0c780eafb590', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'209a9149-18d6-47e5-b880-53cc8aeb856f', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'246e2f76-68bd-486a-8468-c54851c87541', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'269ee34f-44b5-4374-9d16-ee31c8de0974', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2992313b-87d5-4229-8c3a-6578d222e293', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2ac20a85-a6dc-4429-92e1-15b00f08adb8', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2b9a1443-fa62-4cb0-aec7-b7b5770436ac', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2c4ebd78-f541-440c-b9de-fad81a0f5a98', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2d921f72-b892-4cca-b294-210592790854', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2f4ebcc1-5ff9-4f9f-a31d-66c47aee5894', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2fd4cd69-4a25-46e0-af8c-2ed5d28f610f', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'307f8dc0-3b67-4602-8813-46b2c2d5e8c4', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'30ee0b23-785a-4d06-a95d-0f7b6d9ce31f', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'316f648b-6ca2-4d98-9f93-c7afdd943789', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'320ac667-ee90-48a2-9b53-fb9c10ec0d61', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'33bb0ae7-2832-4072-8622-fec97b97b71b', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'34ab16e8-1e47-4561-8998-aa9bda9451cd', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'368eb845-84c0-4b41-a3fe-4b8e17566012', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'38279ad7-91c8-4968-932c-0a5a05ab495c', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3deed64b-69ec-49fc-905f-a73cd5582f3c', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'40ee8af2-4d7c-4a93-af2b-118d78db6b81', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'431aa089-ac08-48d6-b671-e1087f85bcb8', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4741b301-d9dc-4c8e-b029-a8688a0a0308', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'475e52f8-bb3b-4834-ae84-17842b12b0c8', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'491e3deb-c570-47f1-aec9-b649ac239db2', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4cdce9f5-89a3-4680-a211-1c0913bf58bf', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'50b3a684-5599-4a40-9f0f-47a5c37e8e15', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'52abb99d-d48a-4d32-ba55-bbb89bece8de', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'52f41cd9-bc88-42d4-8d34-90b259d6fd46', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'552b29ce-8872-4f8c-b8dd-747ae4333e4e', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'55a1f00f-cd0b-491f-b04b-57803b0db161', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'58bfb3ef-4949-4d43-8c89-a1409d16a08a', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'594e3477-339d-4749-8b89-58d75936a640', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5f4dd0b1-b3e8-4203-bc10-1df868bf5963', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'634bc7d0-dca0-42be-9321-d854d5d3ec69', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'648b8178-35bf-4223-8ebf-7649977683c7', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6cabb6dd-2875-4589-8ab7-923610c62349', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6cf75ade-561f-4fdc-a1e5-fa57cd9ef8ce', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6ef120ae-6041-4314-86ee-884093da1a68', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'777e2ec6-d74a-4707-a1ef-16c96f73248d', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'77ec2e78-ed30-4b70-8fdf-7498a3f85492', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7d585050-8a4a-4d9a-960b-2228875ddc46', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8157d325-2c95-4811-82b3-b215fd49afa4', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'817cad52-7b2e-4bf3-994d-2c9c91e03cd2', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'81c6963a-e6b6-40f2-8ff7-ab17a033d95f', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'87731cf8-8a27-4efe-8f6a-7ed3b2b5f255', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'87856032-423b-4815-aeb8-69b7e4683a22', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'88450232-24c3-4cba-919b-7c1c4c64f4f2', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8acf06ba-e517-4b6e-abcb-359024cc2ad9', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9126ad61-924c-4ec3-8eaf-05386fb9a999', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'995a714c-8876-41ab-8e48-1c79b01d459f', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9b923fee-8028-493a-b54d-666fb6397a75', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9bb0610e-788e-4dfc-93b6-82af4c016765', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4110fcf-efe0-4055-986e-02e1d2affbc4', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a79cb6fc-1cba-4f32-96f9-e1e4e9890ee5', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aab6fc24-4f57-4de7-9979-3b790eef72c9', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ae397432-e4aa-44a6-80a6-dc9bea2a251e', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afdca75e-d51d-410b-abfc-a3fb0b61a198', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b38dc1bf-0691-4edf-9428-7b205a07f80d', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b7ca56c6-e0b1-4d0c-8657-01ee818a377f', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'baa66088-ea1b-43ab-b8b0-ee75523e613a', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bb141879-1336-4a91-8640-506a9d1f71bf', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bbe75a61-9216-4c97-8e5c-2a85ec3b6885', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c1a636b0-4939-4da5-8e76-bbb2c876d82b', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c2971d39-34ae-4165-89dc-78fedde57f81', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c42d62c2-1c0b-4f32-8c0f-c13ab60e3073', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c7ef57ec-c373-49bc-bbcb-f677b6dea483', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ca1a33e0-4455-484c-a494-2d6ee9921359', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ccd7d6ea-f514-40a8-9530-dd7744c5706c', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cd588053-3088-4ad2-b26d-22b0822fe855', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cded29f3-f32f-4143-86b9-30cce601d2db', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ceddcad2-e6ab-4046-a109-11c1c8b5ffa3', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd9ceb6d0-4ade-4d87-ae3c-c829206620d5', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e2ae65fc-51f3-4d01-8c0c-063c4abd0da2', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e3482627-f15f-4d8d-b347-572e78e41dae', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ea78e966-60fc-42d3-8fd2-68e826d1c56d', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f1e97402-9a85-4dbc-8919-fcaf4318f7c7', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f68428ff-8dd1-49fb-8a1a-8655f3bf076d', N'2')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f72d0864-d72f-468b-940c-1a3deb3b3250', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fa4c3ca7-d0d6-4c09-9dd7-22af3c5d6abe', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fbe3dde3-c2da-4337-9667-0d363bfac5c5', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fdd6d9a2-1d33-4e76-a4e5-7988effb6d81', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'1')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'superadmin@nidantech.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'dac1f363-20c6-4593-a998-f35725ba23c9', NULL, 0, 0, NULL, 0, 0, N'superadmin@nidantech.com', 4, NULL, -1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'admin1@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'62873593-517e-4f95-9f64-0490e940528a', NULL, 0, 0, NULL, 0, 0, N'admin1@itsupportlimited.com', 1, NULL, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'admin2@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'e34fdba4-6bec-417f-923f-8d95dda829b2', NULL, 0, 0, NULL, 0, 0, N'admin2@itsupportlimited.com', 2, NULL, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'employee@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'cf421afd-9c38-457c-a6af-c521e1d602d9', NULL, 0, 0, NULL, 0, 0, N'employee@itsupportlimited.com', NULL, NULL, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'81c6963a-e6b6-40f2-8ff7-ab17a033d95f', N'admindevuk@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'87edef0d-7230-4a5e-81a5-00e45867c9b7', NULL, 0, 0, NULL, 0, 0, N'admindevuk@itsupportlimited.com', 3, NULL, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'baa66088-ea1b-43ab-b8b0-ee75523e613a', N'admindevmumbai@nidantech.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2638a07d-1d70-4d9d-aea8-9fa592ebd519', NULL, 0, 0, NULL, 0, 0, N'admindevmumbai@nidantech.com', 4, 20, 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'cded29f3-f32f-4143-86b9-30cce601d2db', N'boss@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'88943326-3aac-4de3-9952-aef532cb151b', NULL, 0, 0, NULL, 1, 0, N'boss@hr.com', 1, 3, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'cbfb458c-0f8d-4bf8-883d-0e46c5c4426b', NULL, 0, 0, NULL, 1, 0, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 4, NULL, 2)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'd9ceb6d0-4ade-4d87-ae3c-c829206620d5', N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'f0d27bfc-9683-4dfc-8bb4-9a8353c3ebe9', NULL, 0, 0, NULL, 1, 0, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 4, 21, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'88450232-24c3-4cba-919b-7c1c4c64f4f2', N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'd29730e8-04fe-4e86-be51-b6de06e173db', NULL, 0, 0, NULL, 1, 0, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 4, 22, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'1b4ec15b-abff-46c0-a029-df405b2d4ffb', N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'6bdbe6e5-2109-4d58-b54c-e4212315465d', NULL, 0, 0, NULL, 1, 0, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 4, 23, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'19e19041-015f-45d4-a2dd-5c486e2b3736', NULL, 0, 0, NULL, 1, 0, N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 4, 24, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'sunjayp88456@gmail.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'47e90459-e1cf-41b2-a0b4-e88cc4f5266b', NULL, 0, 0, NULL, 1, 0, N'sunjayp88456@gmail.com', 4, 13, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'panontonganm@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'1108f492-9cba-4934-b5fb-652b97e11f90', NULL, 0, 0, NULL, 1, 0, N'panontonganm@andersongroup.uk.com', 1, 13, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'johhpaulc@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'904bfac7-a8bc-48a3-a551-7fa0e779b464', NULL, 0, 0, NULL, 1, 0, N'johhpaulc@andersongroup.uk.com', 1, 14, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'117e07b7-d696-43cf-ba26-1b2b9fa59702', N'sh@gmail.com', 0, N'ANdNTY5FQgWJT0zv2UWIjXwNIsqijXsKBLObTtoCLzEQ0AnEpxdTHRo+ws9jQ9/3DQ==', N'3ee7f1a5-ced5-4a85-8806-cc664ac6434a', NULL, 0, 0, NULL, 1, 0, N'sh@gmail.com', 4, 49, 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'kristineg@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'4fbc5e0a-e3d2-4622-bd35-04a8502f5268', NULL, 0, 0, NULL, 1, 0, N'kristineg@andersongroup.uk.com', 1, 15, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'06586b59-4429-436d-9b26-800d880483df', N'dev@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'e56d3f92-2be7-4ecf-8a0f-f6118507987a', NULL, 0, 0, NULL, 1, 0, N'christophers@andersongroup.uk.com', 1, 16, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'ccd7d6ea-f514-40a8-9530-dd7744c5706c', N'dikshas@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2ddce434-0ca5-4fa4-ae56-e49b62937034', NULL, 0, 0, NULL, 1, 0, N'dikshas@andersongroup.uk.com', 4, 16, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'77ec2e78-ed30-4b70-8fdf-7498a3f85492', N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'c5549f22-06e2-4870-9cb8-65b062d5b575', NULL, 0, 0, NULL, 1, 0, N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 4, 14, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'817cad52-7b2e-4bf3-994d-2c9c91e03cd2', N'pankajc1@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'7a1cdaa8-6e74-431e-ba28-63ee84ab43a7', NULL, 0, 0, NULL, 1, 0, N'pankajc1@andersongroup.uk.com', 4, 15, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'3d770f21-d1c7-44a7-a221-11e5cbcfa887', NULL, 0, 0, NULL, 1, 0, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 4, 25, NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'f68428ff-8dd1-49fb-8a1a-8655f3bf076d', N'bmthane@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'21f0007e-2cc7-4f38-8449-94e44f47ec9c', NULL, 0, 0, NULL, 1, 0, N'bmthane@nidantech.com', 4, 26, 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'634bc7d0-dca0-42be-9321-d854d5d3ec69', N'ci_jbp@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'08ff6cf4-678c-4140-8959-6fe39bb0ae04', NULL, 0, 0, NULL, 1, 0, N'ci_jbp@nidantech.com', 4, 28, 4)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'52f41cd9-bc88-42d4-8d34-90b259d6fd46', N'ci_ngp@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'746807cd-ed15-42b6-96c2-6557b0963800', NULL, 0, 0, NULL, 1, 0, N'ci_ngp@nidantech.com', 4, 29, 3)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'6cabb6dd-2875-4589-8ab7-923610c62349', N'bmvaishali@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'0096d556-9a7a-4330-aaaf-868b50d53a1f', NULL, 0, 0, NULL, 1, 0, N'bmvaishali@nidantech.com', 4, 30, 5)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'307f8dc0-3b67-4602-8813-46b2c2d5e8c4', N'paradkarsh24@gmail.com', 0, N'ACiekhovdYP6tP8uSHjX4h8udHdK73YOSUGw1OTfNLPs+RQqfvJWIkA+gOTj6G/0Vg==', N'eb3882c7-7db1-4c8f-81e5-0891f8de3d7e', NULL, 0, 0, NULL, 1, 0, N'paradkarsh24@gmail.com', 4, 50, 1)
GO
SET IDENTITY_INSERT [dbo].[Batch] ON 

GO
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NoOfHolidays], [NoOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssesmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NoOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (8, N'.net morning batch', 10, 1, 2, 0, CAST(N'2017-04-22' AS Date), CAST(N'2017-04-22' AS Date), 5, 2, 11, 20, N'AM', 1, 20, N'PM', CAST(N'2017-04-22' AS Date), 1, 4, CAST(N'2017-04-22' AS Date), NULL, 6, 4, 3500, 3500, 3500, 3500, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
GO
SET IDENTITY_INSERT [dbo].[Batch] OFF
GO
SET IDENTITY_INSERT [dbo].[BatchDay] ON 

GO
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (7, 4, 8, 0, 0, 1, 1, 1, 0, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[BatchDay] OFF
GO
SET IDENTITY_INSERT [dbo].[BatchTimePrefer] ON 

GO
INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (1, N'8 am To 12 pm', 4)
GO
INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (2, N'12 pm To 4 pm', 4)
GO
INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (3, N'4 pm To 8 pm', 4)
GO
SET IDENTITY_INSERT [dbo].[BatchTimePrefer] OFF
GO
SET IDENTITY_INSERT [dbo].[Building] ON 

GO
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (1, N'PankajBuilding', 4, 12, N'Mumbai')
GO
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (2, N'PankajBuilding2', 4, 13, N'Mumbai2')
GO
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (3, N'PankajBuilding3', 4, 12, N'Mumbai3')
GO
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (4, N'PankajBuilding4', 4, 14, N'TestBuilding')
GO
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (5, N'test1building', 4, 12, NULL)
GO
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (7, N't2building', 4, 12, NULL)
GO
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (8, N'test new', 4, 16, NULL)
GO
SET IDENTITY_INSERT [dbo].[Building] OFF
GO
SET IDENTITY_INSERT [dbo].[CasteCategory] ON 

GO
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (1, N'SC', 4)
GO
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (2, N'ST', 4)
GO
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (3, N'OBC', 4)
GO
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (4, N'MBC', 4)
GO
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (5, N'GEN', 4)
GO
SET IDENTITY_INSERT [dbo].[CasteCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Centre] ON 

GO
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [OrganisationId]) VALUES (1, N'thane', N'NEST Thane', 4)
GO
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [OrganisationId]) VALUES (2, NULL, N'test', 4)
GO
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [OrganisationId]) VALUES (3, NULL, N'NEST Nagpur', 4)
GO
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [OrganisationId]) VALUES (4, NULL, N'NEST Jabalpur', 4)
GO
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [OrganisationId]) VALUES (5, NULL, N'NEST Delhi', 4)
GO
SET IDENTITY_INSERT [dbo].[Centre] OFF
GO
SET IDENTITY_INSERT [dbo].[CentreCourse] ON 

GO
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (1, 22, 1, 4)
GO
SET IDENTITY_INSERT [dbo].[CentreCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[CentreCourseInstallment] ON 

GO
INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (1, 1, 1, 4)
GO
INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (2, 1, 3, 4)
GO
SET IDENTITY_INSERT [dbo].[CentreCourseInstallment] OFF
GO
SET IDENTITY_INSERT [dbo].[CentreScheme] ON 

GO
INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (1, 1, 1, 4)
GO
INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (2, 1, 5, 4)
GO
SET IDENTITY_INSERT [dbo].[CentreScheme] OFF
GO
SET IDENTITY_INSERT [dbo].[CentreSector] ON 

GO
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (1, 1, 1, 4)
GO
SET IDENTITY_INSERT [dbo].[CentreSector] OFF
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (1, N'ff8000')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (2, N'FF0000')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (3, N'808080')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (4, N'708090')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (5, N'000000')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (6, N'FFFFE0')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (7, N'FFD700')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (8, N'FFC0CB')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (9, N'FF69B4')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (10, N'FFA07A')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (11, N'FA8072')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (12, N'DC143C')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (13, N'B22222')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (14, N'FF0000')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (15, N'FF4500')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (16, N'FF8C00')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (17, N'FFA500')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (18, N'DEB887')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (19, N'F4A460')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (20, N'B8860B')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (21, N'CD853F')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (22, N'8B4513')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (23, N'A52A2A')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (24, N'800000')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (25, N'556B2F')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (26, N'6B8E23')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (27, N'32CD32')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (28, N'00FF00')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (29, N'00FF7F')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (30, N'008000')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (31, N'006400')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (32, N'00FFFF')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (33, N'E0FFFF')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (34, N'AFEEEE')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (35, N'40E0D0')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (36, N'20B2AA')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (37, N'008080')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (38, N'B0C4DE')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (39, N'87CEEB')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (40, N'00BFFF')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (41, N'1E90FF')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (42, N'0000FF')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (43, N'000080')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (44, N'DDA0DD')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (45, N'EE82EE')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (46, N'FF00FF')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (47, N'9400D3')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (48, N'800080')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (49, N'4B0082')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (50, N'6A5ACD')
GO
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (51, N'6699CC')
GO
SET IDENTITY_INSERT [dbo].[Company] ON 

GO
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (7, N'ITSK DS', 4, 1)
GO
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (8, N'PankajCompany', 4, 45)
GO
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (11, N'Test1', 4, 41)
GO
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (13, N'test12345', 4, 17)
GO
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (14, N'Test123454', 4, 48)
GO
SET IDENTITY_INSERT [dbo].[Company] OFF
GO
SET IDENTITY_INSERT [dbo].[CompanyBuilding] ON 

GO
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (3, 2, 8, 4)
GO
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (4, 3, 8, 4)
GO
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (10, 5, 8, 4)
GO
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (12, 1, 7, 4)
GO
SET IDENTITY_INSERT [dbo].[CompanyBuilding] OFF
GO
SET IDENTITY_INSERT [dbo].[Counselling] ON 

GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (2, 101, NULL, NULL, NULL, NULL, 1, 4, 20, 23, N'9 am', NULL, CAST(N'2017-04-28' AS Date), NULL, 11, N'No', 80, N'No', NULL, NULL, 0)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (3, 102, NULL, NULL, NULL, NULL, 1, 4, 20, 3, N'10 am', NULL, CAST(N'2017-04-28' AS Date), NULL, 2, N'Yes', 60, N'No', NULL, NULL, 1)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (4, 103, NULL, NULL, NULL, NULL, 1, 4, 20, 24, N'10 am', NULL, CAST(N'2017-04-28' AS Date), NULL, 7, N'No', 50, N'No', NULL, NULL, 0)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (5, 104, NULL, NULL, NULL, NULL, 1, 4, 20, 21, N'10 am', NULL, CAST(N'2017-04-28' AS Date), NULL, 8, N'No', 70, N'Yes', N'Admission Done', NULL, 1)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (6, 104, N'Ms.', N'Divya', N'Pradeep', N'Patil', 1, 4, 20, 24, NULL, NULL, CAST(N'2017-04-28' AS Date), NULL, 8, N'No', 70, N'No', NULL, NULL, 0)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (7, 105, NULL, NULL, NULL, NULL, 1, 4, 20, 18, NULL, NULL, CAST(N'2017-04-28' AS Date), NULL, 2, N'No', 50, N'No', NULL, NULL, 0)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (8, 106, NULL, NULL, NULL, NULL, 1, 4, 20, 19, N'4 pm', NULL, CAST(N'2017-04-28' AS Date), NULL, 3, N'No', 80, N'No', NULL, NULL, 0)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (9, 107, NULL, NULL, NULL, NULL, 1, 4, 20, 6, N'10 am', NULL, CAST(N'2017-04-28' AS Date), NULL, 1, N'No', 80, N'No', NULL, NULL, 0)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (10, 108, NULL, NULL, NULL, NULL, 1, 4, 20, 25, NULL, NULL, CAST(N'2017-04-28' AS Date), NULL, 7, N'No', 90, N'No', NULL, NULL, 0)
GO
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [Registered]) VALUES (11, 109, NULL, NULL, NULL, NULL, 1, 4, 20, 16, NULL, NULL, CAST(N'2017-04-28' AS Date), NULL, 3, N'No', 90, N'No', NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Counselling] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

GO
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (24, N'PankajCountry', 4)
GO
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (25, N'PankajCountry2', 4)
GO
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (29, N'Test', 4)
GO
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (1, N'NSDC-LSC-CILT - DIPLOMA IN LOGISTICS OPERATIONS
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (2, N'NEST-IT-NIDAN CERTIFIED - .NET Software Development Program', 4, 2, 1, NULL, NULL, 144)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (3, N'NEST-IT-NIDAN CERTIFIED - Accounting Professional
', 4, 2, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (4, N'NSDC-ESSCI-NIDAN CERTIFIED - Computer Hardware & Networking
', 4, 3, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (5, N'NEST-IT-NIDAN CERTIFIED - Java Software Development Program
', 4, 2, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (6, N'NEST-IT-NIDAN CERTIFIED - Open Source Application Development Program
', 4, 2, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (7, N'NSDC-LSC-Transport Coordinator
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (8, N'NSDC-LSC-Consignment Booking Assistant
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (9, N'NSDC-LSC-Consignment Tracking Executive
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (10, N'NSDC-LSC-Warehouse Supervisor
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (11, N'NSDC-LSC-Warehouse Picker
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (12, N'NSDC-LSC-Warehouse Binner
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (13, N'NSDC-LSC-Inventory Clerk
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (14, N'NSDC-LSC-Warehouse Packer
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (15, N'NSDC-LSC-Transport Consolidator
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (16, N'NSDC-ESSCI-Field Technician Computing & Peripherals
', 4, 3, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (17, N'NSDC-ESSCI-Field Technician Network & Storage
', 4, 3, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (18, N'NSDC-Apparel-Sewing Machine Operator
', 4, 4, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (19, N'NSDC-Retail-Sales Associate
', 4, 5, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (20, N'NSDC-Telecom-Customer Care Executive
', 4, 6, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (21, N'NSDC-LSC-Transport Operation Assistant
', 4, 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (22, N'NEST-IT-MIS
', 4, 2, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (23, N'PMKVY2.0-LSC-Consignment Booking Assistant', 4, 11, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (24, N'PMKVY2.0-LSC-Documentation Assistant', 4, 11, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (25, N'PMKVY2.0-NASSCOM-Domestic Data Entry Operator', 4, 7, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (26, N'PMKVY2.0-Apparel-Sewing  Machine Operator ', 4, 13, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (27, N'PMKVY2.0-Apparel-Hand Embroiderer', 4, 13, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (28, N'PMKVY2.0-Apparel-Self Employed Tailor ', 4, 13, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (29, N'PMKVY2.0-ESSCI-Field Technician Computing and Peripherals', 4, 14, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (30, N'PMKVY2.0-ESSCI-Field Technician Networking and Storage', 4, 14, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (31, N'PMKVY2.0-ESSCI-Mobile Phone Hardware Repair Technician', 4, 14, 2, NULL, NULL, 144)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (32, N'PMKVY2.0-ESSCI-Field Engineer RACW', 4, 14, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (33, N'PMKVY2.0-ESSCI-LED Light Repair Technician', 4, 14, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (34, N'PMKVY2.0-BEAUTY & WELLNEES-Assistant Beauty Therapist', 4, 8, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (35, N'PMKVY2.0-BEAUTY & WELLNEES-Assistant Hair Stylist
', 4, 8, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (36, N'PMKVY2.0-BEAUTY & WELLNEES-Pedicurist & Manicurist
', 4, 8, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (37, N'PMKVY2.0-Life Sciences-Medical Sales Representative
', 4, 9, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (39, N'Others', 4, 10, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (42, N'Others', 4, 15, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (44, N'test', 4, 1, 1, 1, N'test', NULL)
GO
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (45, N'test duration', 4, 2, 1, 1, N'test duration', 144)
GO
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseInstallment] ON 

GO
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmt], [OrganisationId], [CentreId], [CreatedDate]) VALUES (1, N'.Net Regular Fee Break Up', 2, 15000, 1000, 14000, 4, 1, CAST(N'0001-01-01' AS Date))
GO
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmt], [OrganisationId], [CentreId], [CreatedDate]) VALUES (2, N'test mobile', 31, 500, 10, 10, 4, 1, CAST(N'2017-04-13' AS Date))
GO
SET IDENTITY_INSERT [dbo].[CourseInstallment] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseType] ON 

GO
INSERT [dbo].[CourseType] ([CourseTypeId], [Name], [OrganisationId]) VALUES (1, N'Technical', 4)
GO
INSERT [dbo].[CourseType] ([CourseTypeId], [Name], [OrganisationId]) VALUES (2, N'Non-Technical', 4)
GO
SET IDENTITY_INSERT [dbo].[CourseType] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

GO
INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (24, N'IT', 4, 19)
GO
INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (25, N'Testing', 4, 32)
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[District] ON 

GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (1, N'Anantapur', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (2, N'Chittoor', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (3, N'East Godavari', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (4, N'Guntur', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (5, N'Kadapa', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (6, N'Krishna', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (7, N'Kurnool', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (8, N'Nellore', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (9, N'Prakasam', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (10, N'Srikakulam', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (11, N'Visakhapatnam', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (12, N'Vizianagaram', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (13, N'West Godavari', 4, 1)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (14, N'Tawang', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (15, N'West Kameng', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (16, N'East Kameng', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (17, N'Papum Pare', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (18, N'Kurung Kumey', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (19, N'Kra Daadi', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (20, N'Lower Subansiri', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (21, N'Upper Subansiri', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (22, N'West Siang', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (23, N'East Siang', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (24, N'Central Siang', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (25, N'Upper Siang', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (26, N'Lower Dibang Valley', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (27, N'Upper Dibang Valley', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (28, N'Anjaw', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (29, N'Lohit', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (30, N'Namsai', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (31, N'Changlang', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (32, N'Tirap', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (33, N'Longding', 4, 2)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (34, N'Baksa', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (35, N'Barpeta', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (36, N'Biswanath', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (37, N'Bongaigaon', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (38, N'Cachar', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (39, N'Charaideo', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (40, N'Chirang', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (41, N'Darrang', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (42, N'Dhemaji', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (43, N'Dhubri', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (44, N'Dibrugarh', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (45, N'Goalpara', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (46, N'Golaghat', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (47, N'Hailakandi', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (48, N'Hojai', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (49, N'Jorhat', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (50, N'Kamrup Metropolitan', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (51, N'Kamrup', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (52, N'Karbi Anglong', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (53, N'Karimganj', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (54, N'Kokrajhar', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (55, N'Lakhimpur', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (56, N'Majuli', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (57, N'Morigaon', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (58, N'Nagaon', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (59, N'Nalbari', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (60, N'Dima Hasao', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (61, N'Sivasagar', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (62, N'Sonitpur', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (63, N'South Salmara-Mankachar', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (64, N'Tinsukia', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (65, N'Udalguri', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (66, N'West Karbi Anglong', 4, 3)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (67, N'Araria', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (68, N'Arwal', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (69, N'Aurangabad', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (70, N'Banka', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (71, N'Begusarai', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (72, N'Bhagalpur', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (73, N'Bhojpur', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (74, N'Buxar', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (75, N'Darbhanga', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (76, N'East Champaran', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (77, N'Gaya', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (78, N'Gopalganj', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (79, N'Jamui', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (81, N'Jehanabad', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (83, N'Khagaria', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (84, N'Kishanganj', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (85, N'Kaimur', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (86, N'Katihar', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (87, N'Lakhisarai', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (88, N'Madhubani', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (89, N'Munger', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (90, N'Madhepura', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (91, N'Muzaffarpur', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (92, N'Nalanda', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (93, N'Nawada', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (94, N'Patna', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (95, N'Purnia', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (96, N'Rohtas', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (97, N'Saharsa', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (98, N'Samastipur', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (99, N'Sheohar', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (100, N'Sheikhpura', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (101, N'Saran', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (102, N'Sitamarhi', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (103, N'Supaul', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (104, N'Siwan', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (105, N'Vaishali', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (106, N'West Champaran', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (107, N'Balod', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (108, N'Baloda Bazar', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (109, N'Balrampur', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (110, N'Bemetara', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (111, N'	Bijapur', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (112, N'Bilaspur', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (113, N'Dantewada', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (114, N'Dhamtari', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (115, N'Durg', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (116, N'Gariaband', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (117, N'Jagdalpur (Madhya Bastar)', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (118, N'Janjgir-Champa', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (119, N'Jashpur', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (120, N'Kabirdham', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (121, N'Kanker', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (122, N'Kondagaon', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (123, N'Korba', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (124, N'Koriya', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (125, N'Mahasamund', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (126, N'Mungeli', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (127, N'Narayanpur', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (128, N'Raigarh', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (129, N'Raipur', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (130, N'Rajnandgaon', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (131, N'Sukma', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (132, N'Surajpur', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (133, N'Surguja', 4, 5)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (134, N'North Goa(Panaji)', 4, 6)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (135, N'South Goa(Margao)', 4, 6)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (136, N'Ahmedabad', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (137, N'Amreli', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (138, N'Anand', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (139, N'Aravalli', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (140, N'Banaskantha', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (141, N'Bharuch', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (142, N'Bhavnagar', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (143, N'Botad', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (144, N'Chhota Udaipur', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (145, N'Dahod', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (146, N'Dang', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (147, N'Devbhoomi Dwarka', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (148, N'Gandhinagar', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (149, N'Gir Somnath', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (150, N'Jamnagar', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (151, N'Junagadh', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (152, N'Kutch', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (153, N'Kheda', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (154, N'Mahisagar', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (155, N'Mehsana', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (156, N'Morbi', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (157, N'Narmada', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (158, N'Navsari', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (159, N'Panchmahal', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (160, N'Patan', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (161, N'Porbandar', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (162, N'Rajkot', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (163, N'Sabarkantha', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (164, N'Surat', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (165, N'Surendranagar', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (166, N'Tapi', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (167, N'Vadodara', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (168, N'Valsad', 4, 7)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (169, N'Ambala', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (170, N'Bhiwani', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (171, N'Faridabad', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (172, N'Fatehabad', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (173, N'Gurugram', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (174, N'Hisar', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (175, N'Jhajjar', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (176, N'Jind', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (177, N'Karnal', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (178, N'Kaithal', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (179, N'Kurukshetra', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (180, N'Mahendragarh', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (181, N'Mewat', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (182, N'Panchkula', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (183, N'Palwal', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (184, N'Panipat', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (185, N'Rewari', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (186, N'Rohtak', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (187, N'Sirsa', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (188, N'Sonipat', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (189, N'Yamuna Nagar', 4, 8)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (190, N'Bilaspur', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (191, N'Chamba', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (192, N'Hamirpur', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (193, N'Kangra', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (194, N'Kinnaur', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (195, N'Kullu', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (196, N'Lahaul and Spiti', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (197, N'Mandi', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (198, N'Shimla', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (199, N'Sirmaur', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (200, N'Solan', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (201, N'Una', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (202, N'Doda', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (203, N'Jammu', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (204, N'Kathua', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (205, N'Kishtwar', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (206, N'Poonch', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (207, N'Rajouri', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (208, N'Ramban', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (209, N'Reasi', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (210, N'Samba', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (211, N'Udhampur', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (212, N'Anantnag', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (213, N'Bandipora', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (214, N'Baramulla', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (215, N'Budgam', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (216, N'Ganderbal', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (217, N'Kulgam', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (218, N'Kupwara', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (219, N'Pulwama', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (220, N'Shopian', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (221, N'Srinagar', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (222, N'Kargil', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (223, N'Leh', 4, 10)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (224, N'Garhwa', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (225, N'Palamu', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (226, N'Latehar', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (227, N'Chatra', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (228, N'Hazaribagh', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (229, N'Koderma', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (230, N'Giridih', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (231, N'Ramgarh', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (232, N'Bokaro', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (233, N'Dhanbad', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (234, N'Lohardaga', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (235, N'Gumla', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (236, N'Simdega', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (237, N'Ranchi', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (238, N'Khunti', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (239, N'West Singhbhum', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (240, N'Saraikela Kharsawan', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (241, N'East Singhbhum', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (242, N'Jamtara', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (243, N'Deoghar', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (244, N'Dumka', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (245, N'Pakur', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (246, N'Godda', 4, 11)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (247, N'Sahebganj', 4, 11)
GO
SET IDENTITY_INSERT [dbo].[District] OFF
GO
SET IDENTITY_INSERT [dbo].[Document] ON 

GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1, N'100', N'Testing', N'108upanishads.pdf', N'Counselling Document', N'G:\Documents\Testing_100\psychometric\psychometric_79bf1437-0e34-4bbe-b463-e8d5ecab1390_108upanishads.pdf', 2, N'79bf1437-0e34-4bbe-b463-e8d5ecab1390', CAST(N'2017-02-27 00:37:03.940' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (2, N'100', N'Testing', N'68338The_Upanishads.pdf', N'Counselling Document', N'G:\Documents\Testing_100\psychometric\psychometric_ae764db6-458a-4016-a867-2d4dc63db5b9_68338The_Upanishads.pdf', 2, N'ae764db6-458a-4016-a867-2d4dc63db5b9', CAST(N'2017-02-27 01:02:30.717' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (3, N'100', N'Testing', N'68338The_Upanishads.pdf', N'Counselling Document', N'G:\Documents\Testing_100\psychometric\psychometric_1c00ed6c-051e-4dff-b949-e10291699e53_68338The_Upanishads.pdf', 2, N'1c00ed6c-051e-4dff-b949-e10291699e53', CAST(N'2017-02-27 01:03:13.160' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (4, N'Nes102', N'Testing', N'Pay Slip(Shraddha).pdf', N'Counselling Document', N'E:\NidanDoc\Nest thane\Testing_Nes102\psychometric\psychometric_ecb3d6ae-256f-4296-a20b-53be6e1d854c_Pay Slip(Shraddha).pdf', 2, N'ecb3d6ae-256f-4296-a20b-53be6e1d854c', CAST(N'2017-02-28 11:19:45.667' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (5, N'Nes102', N'Testing', N'Pay Slip(Shraddha).pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Testing_Nes102\psychometric\psychometric_1e6eae45-2734-4c6b-a74d-f37e48fd88f1_Pay Slip(Shraddha).pdf', 2, N'1e6eae45-2734-4c6b-a74d-f37e48fd88f1', CAST(N'2017-02-28 06:36:49.620' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (6, N'104', N'Vijay Raut', N'Closure_Letter.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Vijay_Raut_104\psychometric\psychometric_080efeb7-dd69-41dc-a787-cc8de55c0daa_Closure_Letter.pdf', 2, N'080efeb7-dd69-41dc-a787-cc8de55c0daa', CAST(N'2017-03-01 02:50:16.970' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (7, N'104', N'Vijay Raut', N'Closure_Letter.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Vijay_Raut_104\psychometric\psychometric_86c0e96a-cd70-41ac-8b8c-98d6b913cd7d_Closure_Letter.pdf', 2, N'86c0e96a-cd70-41ac-8b8c-98d6b913cd7d', CAST(N'2017-03-01 03:34:41.623' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (8, N'100', N'Ramesh', N'SBS_Guide.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Ramesh_100\psychometric\psychometric_22df5bba-606e-4e4f-878e-dd85279c8c22_SBS_Guide.pdf', 2, N'22df5bba-606e-4e4f-878e-dd85279c8c22', CAST(N'2017-03-03 03:37:04.410' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (9, N'107', N'Test Enquiry', N'nirmala resume.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Test_Enquiry_107\Counselling History\Counselling History_a62ae184-10ab-45f3-938f-04aca39eee29_nirmala resume.pdf', 6, N'a62ae184-10ab-45f3-938f-04aca39eee29', CAST(N'2017-03-03 22:39:36.540' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (10, N'106', N'Ramesh', N'nirmala resume.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Ramesh_106\psychometric\psychometric_0e2d7f83-0472-46c2-ab78-48a9ba94023a_nirmala resume.pdf', 2, N'0e2d7f83-0472-46c2-ab78-48a9ba94023a', CAST(N'2017-03-04 00:16:20.080' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (11, N'106', N'Ramesh', N'nirmala resume.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Ramesh_106\Counselling History\Counselling History_a1745002-de6c-4877-a732-d2f959605701_nirmala resume.pdf', 6, N'a1745002-de6c-4877-a732-d2f959605701', CAST(N'2017-03-04 00:17:10.237' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (12, N'106', N'Ramesh', N'nirmala resume.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Ramesh_106\Counselling History\Counselling History_f617441a-4208-4844-aafd-6a6e8070632a_nirmala resume.pdf', 6, N'f617441a-4208-4844-aafd-6a6e8070632a', CAST(N'2017-03-04 00:18:01.597' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (13, N'119', N'Test', N'https___www.irctc.co.in_eticketing_printTicket.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Test_119\psychometric\psychometric_176c98da-0c12-4e8f-b070-c6ca38480cb1_https___www.irctc.co.in_eticketing_printTicket.pdf', 2, N'176c98da-0c12-4e8f-b070-c6ca38480cb1', CAST(N'2017-03-06 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (14, N'119', N'Test', N'qms_prov.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Test_119\Counselling History\Counselling History_e108413e-8153-40a2-b8fa-f59a76d5d3fd_qms_prov.pdf', 6, N'e108413e-8153-40a2-b8fa-f59a76d5d3fd', CAST(N'2017-03-06 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (15, N'119', N'Test', N'5 Steps for Inbound Marketing of Institute.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\Nest thane\Test_119\psychometric\psychometric_8f364c78-f29b-4a72-ae5b-325b9c2c57bb_5 Steps for Inbound Marketing of Institute.pdf', 2, N'8f364c78-f29b-4a72-ae5b-325b9c2c57bb', CAST(N'2017-03-06 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (16, N'2153', N'Test', N'nirmala resume.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Test_2153\psychometric\psychometric_3ecfe5ac-a49b-4773-9898-ba24eccde361_nirmala resume.pdf', 2, N'3ecfe5ac-a49b-4773-9898-ba24eccde361', CAST(N'2017-03-30 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1016, N'1', N'Test', N'tv.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\test_Email_1\Trainer Document\Trainer Document_819e1e79-36a3-4513-b3ab-98f26d636d3a_tv.pdf', 9, N'819e1e79-36a3-4513-b3ab-98f26d636d3a', CAST(N'2017-03-31 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1017, N'1', N'Test', N'tv.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\test_Email_1\Trainer Document\Trainer Document_ee1acf4b-ef9f-4ec2-bea2-de5c44012c9b_tv.pdf', 9, N'ee1acf4b-ef9f-4ec2-bea2-de5c44012c9b', CAST(N'2017-03-31 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1018, N'2153', N'Test', N'Programming in C#.xlsx', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Test_2153\psychometric\psychometric_b552abeb-97bb-47fa-96ee-8fb32a172c0c_Programming in C#.xlsx', 2, N'b552abeb-97bb-47fa-96ee-8fb32a172c0c', CAST(N'2017-03-31 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1019, N'2153', N'Test', N'Test C#.xlsx', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Test_2153\psychometric\psychometric_3ea701fe-6f10-43ae-b925-5ce6e5d2a5a7_Test C#.xlsx', 2, N'3ea701fe-6f10-43ae-b925-5ce6e5d2a5a7', CAST(N'2017-03-31 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1020, N'2153', N'Test', N'tv.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Test_2153\psychometric\psychometric_a494c8d1-b467-4661-b8c9-956df81deeda_tv.pdf', 2, N'a494c8d1-b467-4661-b8c9-956df81deeda', CAST(N'2017-04-01 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1021, N'102', N'Keshav', N'MIT_C2Fact.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Keshav_102\Counselling History\Counselling History_21e49d87-e68e-456f-99d5-a89f50355c4b_MIT_C2Fact.pdf', 6, N'21e49d87-e68e-456f-99d5-a89f50355c4b', CAST(N'2017-04-26 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
SET IDENTITY_INSERT [dbo].[Document] OFF
GO
SET IDENTITY_INSERT [dbo].[DocumentType] ON 

GO
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (2, N'psychometric', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
GO
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (6, N'Counselling History', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
GO
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (9, N'Trainer Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
GO
SET IDENTITY_INSERT [dbo].[DocumentType] OFF
GO
SET IDENTITY_INSERT [dbo].[EmergencyContact] ON 

GO
INSERT [dbo].[EmergencyContact] ([EmergencyContactId], [OrganisationId], [PersonnelId], [Relationship], [Title], [Forenames], [Surname], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile]) VALUES (2, 4, 20, N'Friend', N'mr', N'sanjay', N'prajapati', 25, N'krishna Paradise1', NULL, NULL, NULL, NULL, N'98213113344', NULL)
GO
SET IDENTITY_INSERT [dbo].[EmergencyContact] OFF
GO
SET IDENTITY_INSERT [dbo].[Employment] ON 

GO
INSERT [dbo].[Employment] ([EmploymentId], [OrganisationId], [PersonnelId], [StartDate], [EndDate], [TerminationDate], [BuildingId], [ReportsToPersonnelId], [JobTitle], [JobDescription], [EndEmploymentReasonId], [WorkingPatternId], [PublicHolidayPolicyId], [AbsencePolicyId], [CompanyId]) VALUES (2, 4, 20, CAST(N'2016-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-01-06 00:00:00.0000000' AS DateTime2), NULL, 5, NULL, N'Test', N'Test', NULL, 56, 30, 38, 8)
GO
INSERT [dbo].[Employment] ([EmploymentId], [OrganisationId], [PersonnelId], [StartDate], [EndDate], [TerminationDate], [BuildingId], [ReportsToPersonnelId], [JobTitle], [JobDescription], [EndEmploymentReasonId], [WorkingPatternId], [PublicHolidayPolicyId], [AbsencePolicyId], [CompanyId]) VALUES (6, 4, 21, CAST(N'2016-10-10 00:00:00.0000000' AS DateTime2), NULL, NULL, 5, NULL, N'Test', N'Test', NULL, 57, 30, 36, 8)
GO
SET IDENTITY_INSERT [dbo].[Employment] OFF
GO
SET IDENTITY_INSERT [dbo].[EmploymentDepartment] ON 

GO
INSERT [dbo].[EmploymentDepartment] ([EmploymentDepartmentId], [EmploymentId], [DepartmentId], [OrganisationId]) VALUES (1, 2, 24, 4)
GO
INSERT [dbo].[EmploymentDepartment] ([EmploymentDepartmentId], [EmploymentId], [DepartmentId], [OrganisationId]) VALUES (2, 2, 25, 4)
GO
SET IDENTITY_INSERT [dbo].[EmploymentDepartment] OFF
GO
SET IDENTITY_INSERT [dbo].[EmploymentTeam] ON 

GO
INSERT [dbo].[EmploymentTeam] ([EmploymentTeamId], [EmploymentId], [TeamId], [OrganisationId]) VALUES (1, 2, 1, 4)
GO
SET IDENTITY_INSERT [dbo].[EmploymentTeam] OFF
GO
SET IDENTITY_INSERT [dbo].[Enquiry] ON 

GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (101, N'Mr.', N'Shekhar', N'Bhagat', N'Sonawane', 8888888888, NULL, NULL, CAST(N'2017-04-25' AS Date), 29, N'ddddddddddd', NULL, NULL, NULL, 1, 17, 15, 55555555, NULL, NULL, 1, 2, 2, N'Male', 2, NULL, NULL, 0, 1, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-25' AS Date), 1, 4, N'101', N'Counselling', NULL, NULL, NULL, 0, 1, 2, 2, 1, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:44:28.910' AS DateTime), 9, N'No', NULL, 80, NULL, NULL, 1)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (102, N'Mr.', N'Keshav', N'Madhav', N'Pande', 7777777777, 8888888888, N'swapnil@gmail.com', CAST(N'2017-04-26' AS Date), 29, N'ddddddddddd', NULL, NULL, NULL, 1, 17, 18, 400709, N'sfsadfds f', 7777777777, 1, 1, 5, N'Male', 3, N'2015', NULL, 0, 2, N'Experience', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'102', N'Registration', NULL, NULL, NULL, 0, 2, 2, 1, 1, 2, NULL, 2, N'Yes', N'test', CAST(N'2017-04-28 10:45:02.460' AS DateTime), 10, N'No', NULL, 70, NULL, NULL, 1)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (103, N'Mrs.', N'Pooja', N'Ganpat', N'Mhatre', 4444444444, 444444444, N'vijay@gmail.com', CAST(N'1993-11-24' AS Date), 24, N'ddddddddddd', NULL, NULL, NULL, 1, 19, 19, 400709, N'dfsadf sf', 77777777777777, 3, 3, 2, N'Male', 1, NULL, NULL, 0, 7, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'103', N'Counselling', NULL, NULL, NULL, 0, 2, 3, 2, 7, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:45:38.530' AS DateTime), 4, N'No', NULL, 50, NULL, NULL, 0)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (104, N'Ms.', N'Divya', N'Pradeep', N'Patil', 5454544444, 444444444, N'dsfsfd', CAST(N'2017-03-29' AS Date), 21, N'ddddddddddd', NULL, NULL, NULL, 1, 17, 17, 400709, N'dfsadf sf', 4444444444444, 4, 2, 1, N'Female', 1, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'104', N'Admission', NULL, NULL, NULL, 0, 2, 1, 2, 8, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:44:52.020' AS DateTime), 3, N'Yes', N'Admission Done', 70, NULL, NULL, 1)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (105, N'Mrs.', N'Swati', N'Manoj', N'Bhosale', 7878787878, 8787878787, N'878787', CAST(N'2017-04-06' AS Date), 21, N'ddddddddddd', NULL, NULL, NULL, 1, 17, 12, 400709, NULL, 45343434343, 1, 1, 1, N'Female', 1, NULL, NULL, 0, 2, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'105', N'Counselling', NULL, NULL, NULL, 0, 1, 2, 3, 2, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:45:11.677' AS DateTime), 2, N'No', NULL, 50, NULL, NULL, 0)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (106, N'Mrs.', N'Samridhi', N'Amar', N'Potdukhe', 4574575757, 75758785, N'dsfsfd', CAST(N'2017-04-06' AS Date), 22, N'ddddddddddd', NULL, NULL, NULL, 1, 17, 14, 400709, NULL, 524524524, 2, 3, 2, N'Female', 3, NULL, NULL, 0, 3, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'106', N'Counselling', NULL, NULL, NULL, 0, 1, 3, 2, 3, 3, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:44:38.470' AS DateTime), 3, N'No', NULL, 80, NULL, NULL, 0)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (107, N'Mr.', N'parth', N'soham', N'aaglawe', 5555555555, 5555555555, N'dsfsfd', NULL, 29, N'ddddddddddd', NULL, NULL, NULL, 1, 14, 11, 400709, NULL, 55555555555555, 3, 1, 1, N'Male', 2, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'107', N'Counselling', NULL, NULL, NULL, 0, 1, 2, 2, 1, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:42:36.300' AS DateTime), 2, N'No', NULL, 80, NULL, NULL, 0)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (108, N'Mr.', N'Atharva', N'Dinesh', N'Doiphode', 8888888888, 9999999999, N'vijay@gmail.com', CAST(N'2017-03-29' AS Date), 24, N'ddddddddddd', NULL, NULL, NULL, 1, 2, 5, 400709, NULL, 45343434343, 3, 3, 3, N'Male', 3, NULL, NULL, 0, 1, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'108', N'Counselling', NULL, NULL, NULL, 0, 1, 3, 2, 1, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:44:03.957' AS DateTime), 1, N'No', NULL, 90, NULL, NULL, 0)
GO
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [CentreId], [OrganisationId], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBm], [Registered]) VALUES (109, N'Mr.', N'Swagat', N'Nhushan', N'Kadu', 7777777777, 9595959519, N'sadf sfd', CAST(N'2017-04-14' AS Date), 24, N'ddddddddddd', NULL, NULL, NULL, 1, 2, 6, 400709, NULL, 77777777777777, 2, 1, 2, N'Male', 1, NULL, NULL, 0, 1, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-04-26' AS Date), 1, 4, N'109', N'Counselling', NULL, NULL, NULL, 0, 1, 2, 2, 2, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-04-28 10:44:14.627' AS DateTime), 2, N'No', NULL, 90, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Enquiry] OFF
GO
SET IDENTITY_INSERT [dbo].[EnquiryCourse] ON 

GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (9, 101, 23, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (10, 101, 23, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (15, 102, 24, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (16, 102, 25, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (17, 102, 33, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (18, 102, 30, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (19, 103, 24, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (20, 104, 24, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (21, 105, 25, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (22, 106, 25, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (23, 107, 23, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (24, 108, 44, 1, 4)
GO
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (25, 109, 25, 1, 4)
GO
SET IDENTITY_INSERT [dbo].[EnquiryCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[EnquiryType] ON 

GO
INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (1, N'Walk-In', 4)
GO
INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (2, N'Tele-In', 4)
GO
INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (3, N'Event', 4)
GO
SET IDENTITY_INSERT [dbo].[EnquiryType] OFF
GO
SET IDENTITY_INSERT [dbo].[Event] ON 

GO
INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (3, N'Seminar', N'Amit Sir', CAST(N'2016-11-05 00:00:00.000' AS DateTime), 1, 4, 1)
GO
INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (12, N'Test', NULL, CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (14, N'Job Fair Mumbai', NULL, NULL, NULL, 4, 1)
GO
SET IDENTITY_INSERT [dbo].[Event] OFF
GO
SET IDENTITY_INSERT [dbo].[EventFunctionType] ON 

GO
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (1, N'Brain Storming', 4)
GO
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (2, N'Planning', 4)
GO
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (3, N'Budget', 4)
GO
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (4, N'Event Day', 4)
GO
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (5, N'Post Event', 4)
GO
SET IDENTITY_INSERT [dbo].[EventFunctionType] OFF
GO
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (1, N'Registration')
GO
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (2, N'Admission')
GO
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (3, N'Installment')
GO
SET IDENTITY_INSERT [dbo].[FollowUp] ON 

GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (8, CAST(N'2017-04-27 00:00:00.000' AS DateTime), 7, NULL, N'Mr.', N'Vijay', N'Nanasaheb', N'Raut', N'looking Interested in course', NULL, CAST(N'1917-04-25 00:00:00.000' AS DateTime), CAST(N'2017-04-25 00:00:00.000' AS DateTime), 4, 1, 9773606038, 2, N'Mobilization', NULL, N'/Mobilization/Edit/7', NULL, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (9, CAST(N'2017-04-28 00:00:00.000' AS DateTime), 8, NULL, N'Mrs.', N'A', N'B', N'C', NULL, NULL, CAST(N'1917-04-25 00:00:00.000' AS DateTime), CAST(N'2017-04-25 00:00:00.000' AS DateTime), 4, 1, 9870245680, 39, N'Mobilization', NULL, N'/Mobilization/Edit/8', NULL, N'Yes', N'close', NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (10, CAST(N'2017-04-27 00:00:00.000' AS DateTime), 9, NULL, N'Mrs.', N'B', N'S', N'A', NULL, NULL, CAST(N'1917-04-25 00:00:00.000' AS DateTime), CAST(N'2017-04-25 00:00:00.000' AS DateTime), 4, 1, 8702458790, 39, N'Mobilization', NULL, N'/Mobilization/Edit/9', NULL, N'Yes', N'close', NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (11, CAST(N'2017-04-27 00:00:00.000' AS DateTime), 10, NULL, N'Mrs.', N'C', N'W', N'T', NULL, NULL, CAST(N'1917-04-25 00:00:00.000' AS DateTime), CAST(N'2017-04-25 00:00:00.000' AS DateTime), 4, 1, 7895425481, 39, N'Mobilization', NULL, N'/Mobilization/Edit/10', NULL, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (12, CAST(N'2017-04-29 00:00:00.000' AS DateTime), 11, NULL, N'Mrs.', N'D', N'C', N'Y', NULL, NULL, CAST(N'1917-04-25 00:00:00.000' AS DateTime), CAST(N'2017-04-25 00:00:00.000' AS DateTime), 4, 1, 8715724520, 39, N'Mobilization', NULL, N'/Mobilization/Edit/11', NULL, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (13, CAST(N'2017-04-27 00:00:00.000' AS DateTime), 12, NULL, N'Mrs.', N'E', N'A', N'G', NULL, NULL, CAST(N'1917-04-25 00:00:00.000' AS DateTime), CAST(N'2017-04-25 00:00:00.000' AS DateTime), 4, 1, 9714725415, 39, N'Mobilization', NULL, N'/Mobilization/Edit/12', NULL, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (14, CAST(N'2017-04-28 10:44:28.910' AS DateTime), NULL, 101, N'Mr.', N'Shekhar', N'Bhagat', N'Sonawane', NULL, NULL, CAST(N'1917-04-25 00:00:00.000' AS DateTime), CAST(N'2017-04-25 00:00:00.000' AS DateTime), 4, 1, 8888888888, 23, N'Counselling', NULL, N'/RegistrationPaymentReceipt/Edit/101', 2, N'No', NULL, 3)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (15, CAST(N'2017-04-28 00:00:00.000' AS DateTime), 13, NULL, N'Ms.', N'Radha', N'ram', N'Mane', N'test', NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 7412589632, 2, N'Mobilization', NULL, N'/Mobilization/Edit/13', NULL, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (16, CAST(N'2017-04-29 00:00:00.000' AS DateTime), NULL, 102, N'Mr.', N'Keshav', N'Madhav', N'Pande', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 7777777777, 3, N'Registered', NULL, N'/RegistrationPaymentReceipt/Edit/102', 3, N'No', NULL, 5)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (17, CAST(N'2017-04-28 10:45:38.530' AS DateTime), NULL, 103, N'Mrs.', N'Pooja', N'Ganpat', N'Mhatre', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 4444444444, 24, N'Counselling', 444444444, N'/Enquiry/Edit/103', 4, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (18, CAST(N'2017-04-28 00:00:00.000' AS DateTime), NULL, 104, N'Ms.', N'Divya', N'Pradeep', N'Patil', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 5454544444, 21, N'Admission', 444444444, N'/RegistrationPaymentReceipt/Edit/104', 5, N'Yes', N'Admission Done', 4)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (19, CAST(N'2017-04-28 10:45:11.677' AS DateTime), NULL, 105, N'Mrs.', N'Swati', N'Manoj', N'Bhosale', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 7878787878, 18, N'Counselling', 8787878787, N'/Enquiry/Edit/105', 7, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (20, CAST(N'2017-04-28 10:44:38.470' AS DateTime), NULL, 106, N'Mrs.', N'Samridhi', N'Amar', N'Potdukhe', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 4574575757, 19, N'Counselling', 75758785, N'/Enquiry/Edit/106', 8, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (21, CAST(N'2017-04-28 10:42:36.300' AS DateTime), NULL, 107, N'Mr.', N'parth', N'soham', N'aaglawe', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 5555555555, 6, N'Counselling', 5555555555, N'/Enquiry/Edit/107', 9, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (22, CAST(N'2017-04-28 10:44:03.957' AS DateTime), NULL, 108, N'Mr.', N'Atharva', N'Dinesh', N'Doiphode', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 8888888888, 25, N'Counselling', 9999999999, N'/Enquiry/Edit/108', 10, N'No', NULL, NULL)
GO
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [CounsellingId], [Close], [ClosingRemark], [RegistrationPaymentReceiptId]) VALUES (23, CAST(N'2017-04-28 10:44:14.627' AS DateTime), NULL, 109, N'Mr.', N'Swagat', N'Nhushan', N'Kadu', NULL, NULL, CAST(N'1917-04-26 00:00:00.000' AS DateTime), CAST(N'2017-04-26 00:00:00.000' AS DateTime), 4, 1, 7777777777, 16, N'Counselling', 9595959519, N'/Enquiry/Edit/109', 11, N'No', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[FollowUp] OFF
GO
SET IDENTITY_INSERT [dbo].[Frequency] ON 

GO
INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (1, N'Yearly', 1)
GO
INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (2, N'Quarterly', 2)
GO
SET IDENTITY_INSERT [dbo].[Frequency] OFF
GO
SET IDENTITY_INSERT [dbo].[Holiday] ON 

GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (1, CAST(N'2017-01-14' AS Date), N'Makar Sankranti / Pongal', 4, N'Saturday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (2, CAST(N'2017-01-26' AS Date), N'Republic Day', 4, N'Thursday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (3, CAST(N'2017-02-24' AS Date), N'Maha Shivaratri/Shivaratri', 4, N'Friday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (4, CAST(N'2017-03-13' AS Date), N'Holi', 4, N'Monday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (5, CAST(N'2017-04-04' AS Date), N'Rama Navami', 4, N'Tuesday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (6, CAST(N'2017-04-09' AS Date), N'Mahavir Jayanti', 4, N'Sunday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (7, CAST(N'2017-04-14' AS Date), N'Good Friday/Ambedkar Jayanti', 4, N'Friday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (8, CAST(N'2017-05-10' AS Date), N'Buddha Purnima/Vesak', 4, N'Wednesday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (9, CAST(N'2017-08-07' AS Date), N'Raksha Bandhan (Rakhi)', 4, N'Monday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (10, CAST(N'2017-08-15' AS Date), N'Independence Day/Janmashtami', 4, N'Tuesday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (11, CAST(N'2017-08-25' AS Date), N'Ganesh Chaturthi/Vinayaka Chaturthi', 4, N'Friday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (12, CAST(N'2017-09-02' AS Date), N'Bakr Id/Eid ul-Adha', 4, N'Saturday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (13, CAST(N'2017-09-30' AS Date), N'Dussehra (Maha Navami)', 4, N'Saturday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (14, CAST(N'2017-10-01' AS Date), N'Muharram/Ashura', 4, N'Sunday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (15, CAST(N'2017-10-02' AS Date), N'Mahatma Gandhi Jayanti', 4, N'Monday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (16, CAST(N'2017-10-19' AS Date), N'Diwali/Deepavali', 4, N'Thursday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (17, CAST(N'2017-11-04' AS Date), N'Guru Nanak Jayanti', 4, N'Saturday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (18, CAST(N'2017-12-02' AS Date), N'Milad un-Nabi/Id-e-Milad', 4, N'Saturday', 1)
GO
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (19, CAST(N'2017-12-25' AS Date), N'Christmas', 4, N'Monday', 1)
GO
SET IDENTITY_INSERT [dbo].[Holiday] OFF
GO
SET IDENTITY_INSERT [dbo].[Host] ON 

GO
INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (7, N'nidanserver', 4)
GO
SET IDENTITY_INSERT [dbo].[Host] OFF
GO
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] ON 

GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (1, N'Web Site', 4)
GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (2, N'SMS', 4)
GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (3, N'Banner', 4)
GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (4, N'News Paper', 4)
GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (5, N'Reference', 4)
GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (6, N'Internet', 4)
GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (7, N'Pamphlet', 4)
GO
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (8, N'Event', 4)
GO
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] OFF
GO
SET IDENTITY_INSERT [dbo].[Mobilization] ON 

GO
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (7, 14, 4, N'Mr.', N'Vijay', N'Nanasaheb', N'Raut', 1, 9773606038, NULL, 5, 7, CAST(N'2017-04-25' AS Date), CAST(N'2017-04-27' AS Date), N'looking Interested in course', NULL, N'Sion', NULL, CAST(N'2017-04-25' AS Date), 2, 20, N'No', NULL)
GO
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (8, 3, 4, N'Mrs.', N'A', N'B', N'C', 1, 9870245680, NULL, 39, 1, CAST(N'2017-04-25' AS Date), CAST(N'2017-04-27' AS Date), NULL, NULL, N'thane', NULL, CAST(N'2017-04-25' AS Date), 1, 20, N'No', NULL)
GO
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (9, 3, 4, N'Mrs.', N'B', N'S', N'A', 1, 8702458790, NULL, 39, 2, CAST(N'2017-04-25' AS Date), CAST(N'2017-04-27' AS Date), NULL, NULL, N'sion', NULL, CAST(N'2017-04-25' AS Date), 1, 20, N'Yes', N'close')
GO
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (10, 3, 4, N'Mrs.', N'C', N'W', N'T', 1, 7895425481, NULL, 39, 3, CAST(N'2017-04-25' AS Date), CAST(N'2017-04-27' AS Date), NULL, NULL, N'belapur', NULL, CAST(N'2017-04-25' AS Date), 1, 20, N'No', NULL)
GO
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (11, 3, 4, N'Mrs.', N'D', N'C', N'Y', 1, 8715724520, NULL, 39, 5, CAST(N'2017-04-25' AS Date), CAST(N'2017-04-29' AS Date), NULL, NULL, N'vashi', NULL, CAST(N'2017-04-25' AS Date), 1, 20, N'No', NULL)
GO
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (12, 3, 4, N'Mrs.', N'E', N'A', N'G', 1, 9714725415, NULL, 2, 6, CAST(N'2017-04-25' AS Date), CAST(N'2017-04-27' AS Date), NULL, NULL, N'mulund', NULL, CAST(N'2017-04-25' AS Date), 1, 20, N'No', NULL)
GO
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (13, 14, 4, N'Ms.', N'Radha', N'ram', N'Mane', 1, 7412589632, NULL, 2, 3, CAST(N'2017-04-26' AS Date), CAST(N'2017-04-28' AS Date), N'test', NULL, N'nerul', NULL, CAST(N'2017-04-26' AS Date), 1, 20, N'No', NULL)
GO
SET IDENTITY_INSERT [dbo].[Mobilization] OFF
GO
SET IDENTITY_INSERT [dbo].[MobilizationType] ON 

GO
INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (1, N'Walk-In', 4)
GO
INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (2, N'Telephonic', 4)
GO
INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (3, N'Event', 4)
GO
SET IDENTITY_INSERT [dbo].[MobilizationType] OFF
GO
SET IDENTITY_INSERT [dbo].[Occupation] ON 

GO
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (1, N'Business', 4)
GO
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (2, N'Govt-Employee', 4)
GO
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (3, N'Farmer', 4)
GO
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (4, N'Doctor', 4)
GO
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (5, N'Other', 4)
GO
SET IDENTITY_INSERT [dbo].[Occupation] OFF
GO
SET IDENTITY_INSERT [dbo].[Organisation] ON 

GO
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (1, N'Fynn Holdings')
GO
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (2, N'Test Org 2')
GO
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (3, N'Dev UK Organisation')
GO
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (4, N'NEST')
GO
SET IDENTITY_INSERT [dbo].[Organisation] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentMode] ON 

GO
INSERT [dbo].[PaymentMode] ([PaymentModeId], [Name], [OrganisationId]) VALUES (1, N'Cash', 4)
GO
INSERT [dbo].[PaymentMode] ([PaymentModeId], [Name], [OrganisationId]) VALUES (2, N'Cheque', 4)
GO
SET IDENTITY_INSERT [dbo].[PaymentMode] OFF
GO
SET IDENTITY_INSERT [dbo].[Personnel] ON 

GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (20, 4, N'Mr', N'TEst', N'Test', CAST(N'2017-01-04 00:00:00.0000000' AS DateTime2), 24, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 2, NULL)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (21, 4, N'Mr', N'Abc', N'B', CAST(N'2017-01-05 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', NULL, NULL)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (22, 4, N'Mr', N'x', N'z', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', NULL, NULL)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (23, 4, N'Mr', N'test1', N'B', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', NULL, NULL)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (24, 4, N'Mr', N'Vijay', N'Raut', CAST(N'1993-01-27 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', NULL, NULL)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (25, 4, N'Mr', N'Nidan', N'B', CAST(N'2017-02-04 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', NULL, NULL)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (26, 4, N'Mr', N'ThaneUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'bmthane@nidantech.com', NULL, 1)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (28, 4, N'Mr', N'JabalpurUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ci_jbp@nidantech.com', NULL, 4)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (29, 4, N'Mr', N'NagpurUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ci_ngp@nidantech.com', NULL, 3)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (30, 4, N'Mr', N'DelhiUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'bmvaishali@nidantech.com', NULL, 5)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (49, 4, N'Mr', N'test Email', N'Surname', CAST(N'2017-03-24 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'sh@gmail.com', NULL, 1)
GO
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (50, 4, N'Mr.', N'Shraddha', N'Paradkar', CAST(N'2017-04-24 00:00:00.0000000' AS DateTime2), 0, N'Koparkhairane', NULL, NULL, NULL, N'400709', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'paradkarsh24@gmail.com', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Personnel] OFF
GO
SET IDENTITY_INSERT [dbo].[PersonnelAbsenceEntitlement] ON 

GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (1, 4, 20, 29, 3, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 15, 0, 1, 14, 7, 1, 2)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (43, 4, 21, 44, 3, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 5.5, 0, 3, 2.5, 8, 1, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (44, 4, 21, 44, 2, CAST(N'2016-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 2.5, 0, 0, 2.5, 2, 2, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (45, 4, 21, 44, 2, CAST(N'2017-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 3, 0, 1, 2, 2, 2, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (46, 4, 21, 44, NULL, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, 0, 1, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (47, 4, 21, 45, 3, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 12, 0, 1, 11, 8, 1, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (48, 4, 21, 45, 2, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-06-30 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (49, 4, 21, 45, 2, CAST(N'2017-07-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-09-30 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (50, 4, 21, 45, 2, CAST(N'2017-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-12-31 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (51, 4, 21, 45, 2, CAST(N'2018-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
GO
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (52, 4, 21, 45, NULL, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, 0, 1, 6)
GO
SET IDENTITY_INSERT [dbo].[PersonnelAbsenceEntitlement] OFF
GO
SET IDENTITY_INSERT [dbo].[PublicHoliday] ON 

GO
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (18, N'Guru', CAST(N'2017-02-23 00:00:00.0000000' AS DateTime2), 4, 4)
GO
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (25, N'Test', CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4, 4)
GO
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (42, N'Test1', CAST(N'2016-12-30 00:00:00.0000000' AS DateTime2), 4, 4)
GO
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (51, N'Guru', CAST(N'2017-02-23 00:00:00.0000000' AS DateTime2), 4, 30)
GO
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (52, N'Test', CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4, 30)
GO
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (53, N'Test1', CAST(N'2016-12-30 00:00:00.0000000' AS DateTime2), 4, 30)
GO
SET IDENTITY_INSERT [dbo].[PublicHoliday] OFF
GO
SET IDENTITY_INSERT [dbo].[PublicHolidayPolicy] ON 

GO
INSERT [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId], [OrganisationId], [Name]) VALUES (4, 4, N'Test Policy')
GO
INSERT [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId], [OrganisationId], [Name]) VALUES (30, 4, N'Test Policy 10:51:30')
GO
SET IDENTITY_INSERT [dbo].[PublicHolidayPolicy] OFF
GO
SET IDENTITY_INSERT [dbo].[Qualification] ON 

GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (1, N'SSC', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (2, N'HSC', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (3, N'Under Graduate', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (4, N'Graduate', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (5, N'Post Graduate', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (6, N'Masters', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (7, N'Diploma', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (9, N'BE', 4)
GO
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (11, N'Others', 4)
GO
SET IDENTITY_INSERT [dbo].[Qualification] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

GO
INSERT [dbo].[Question] ([QuestionId], [Description], [EventFunctionTypeId], [OrganisationId]) VALUES (7, N'test edit', 1, 4)
GO
INSERT [dbo].[Question] ([QuestionId], [Description], [EventFunctionTypeId], [OrganisationId]) VALUES (8, N'What is your name ?', 2, 4)
GO
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
INSERT [dbo].[RegistrationPaymentReceipt] ([RegistrationPaymentReceiptId], [CentreId], [EnquiryId], [CounsellingId], [CourseId], [Fees], [ChequeNo], [ChequeDate], [BankName], [Particulars], [PaymentModeId], [OrganisationId], [RegistrationDate], [FollowUpDate], [Remarks], [FinancialYear]) VALUES (3, 1, 101, 2, 23, 1000, N'Paid By Cash', CAST(N'2017-04-25' AS Date), N'Paid By Cash', N'1000 Rupees Paid Against PMKVY2.0-LSC-Consignment Booking Assistant', 1, 4, CAST(N'2017-04-25' AS Date), CAST(N'2017-04-25' AS Date), NULL, N'2016-2017')
GO
INSERT [dbo].[RegistrationPaymentReceipt] ([RegistrationPaymentReceiptId], [CentreId], [EnquiryId], [CounsellingId], [CourseId], [Fees], [ChequeNo], [ChequeDate], [BankName], [Particulars], [PaymentModeId], [OrganisationId], [RegistrationDate], [FollowUpDate], [Remarks], [FinancialYear]) VALUES (4, 1, 104, 5, 21, 1500, N'Paid By Cash', CAST(N'2017-04-27' AS Date), N'Paid By Cash', N'1500 Rupees Paid Against NSDC-LSC-Transport Operation Assistant
', 1, 4, CAST(N'2017-04-27' AS Date), CAST(N'2017-04-27' AS Date), NULL, N'2016-2017')
GO
INSERT [dbo].[RegistrationPaymentReceipt] ([RegistrationPaymentReceiptId], [CentreId], [EnquiryId], [CounsellingId], [CourseId], [Fees], [ChequeNo], [ChequeDate], [BankName], [Particulars], [PaymentModeId], [OrganisationId], [RegistrationDate], [FollowUpDate], [Remarks], [FinancialYear]) VALUES (5, 1, 102, 3, 3, 1000, N'Paid By Cash', CAST(N'2017-04-29' AS Date), N'Paid By Cash', N'1000 Rupees Paid Against NEST-IT-NIDAN CERTIFIED - Accounting Professional
', 1, 4, CAST(N'2017-04-29' AS Date), CAST(N'2017-04-29' AS Date), NULL, N'2016-2017')
GO
SET IDENTITY_INSERT [dbo].[Religion] ON 

GO
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (1, N'Hindu', 4)
GO
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (2, N'Muslim', 4)
GO
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (3, N'Christen', 4)
GO
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (4, N'Sikh', 4)
GO
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (5, N'Jain', 4)
GO
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (6, N'Buddha', 4)
GO
SET IDENTITY_INSERT [dbo].[Religion] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

GO
INSERT [dbo].[Room] ([RoomId], [Description], [Number], [Floor], [OccupiedStartDate], [OccupiedEndDate], [OccupiedStartTime], [OccupiedEndTime], [RoomTypeId], [Capacity], [SquareFeet], [OrganisationId], [CentreId]) VALUES (1, N'Room - 1', 1, 1, NULL, NULL, NULL, NULL, 2, 20, 150, 4, 3)
GO
INSERT [dbo].[Room] ([RoomId], [Description], [Number], [Floor], [OccupiedStartDate], [OccupiedEndDate], [OccupiedStartTime], [OccupiedEndTime], [RoomTypeId], [Capacity], [SquareFeet], [OrganisationId], [CentreId]) VALUES (2, N'Room - 2', 2, 1, NULL, NULL, NULL, NULL, 1, 15, 200, 4, 3)
GO
INSERT [dbo].[Room] ([RoomId], [Description], [Number], [Floor], [OccupiedStartDate], [OccupiedEndDate], [OccupiedStartTime], [OccupiedEndTime], [RoomTypeId], [Capacity], [SquareFeet], [OrganisationId], [CentreId]) VALUES (3, N'Room - 1', 1, 0, NULL, NULL, NULL, NULL, 2, 25, 300, 4, 1)
GO
INSERT [dbo].[Room] ([RoomId], [Description], [Number], [Floor], [OccupiedStartDate], [OccupiedEndDate], [OccupiedStartTime], [OccupiedEndTime], [RoomTypeId], [Capacity], [SquareFeet], [OrganisationId], [CentreId]) VALUES (4, N'Room - 2', 2, 0, NULL, NULL, NULL, NULL, 1, 20, 300, 4, 1)
GO
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomType] ON 

GO
INSERT [dbo].[RoomType] ([RoomTypeId], [Name], [OrganisationId]) VALUES (1, N'Lab', 4)
GO
INSERT [dbo].[RoomType] ([RoomTypeId], [Name], [OrganisationId]) VALUES (2, N'Theory', 4)
GO
SET IDENTITY_INSERT [dbo].[RoomType] OFF
GO
SET IDENTITY_INSERT [dbo].[Scheme] ON 

GO
INSERT [dbo].[Scheme] ([SchemeId], [Name], [OrganisationId]) VALUES (1, N'Commercial', 4)
GO
INSERT [dbo].[Scheme] ([SchemeId], [Name], [OrganisationId]) VALUES (2, N'Government', 4)
GO
SET IDENTITY_INSERT [dbo].[Scheme] OFF
GO
SET IDENTITY_INSERT [dbo].[Sector] ON 

GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (1, N'Logistics Sector Skill Council', 4, 1)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (2, N'IT', 4, 1)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (3, N'Electronics Sector Skills Council of India', 4, 1)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (4, N'Apparel Made-Ups Home Furnishing Sector Skill Council', 4, 1)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (5, N'Retailers Association''s Skill Council of India', 4, 1)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (6, N'Telecom Sector Skill Council', 4, 1)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (7, N'IT-ITeS Sector Skill Council | NASSCOM', 4, 2)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (8, N'Beauty & Wellness Sector Skill Council', 4, 2)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (9, N'Life Sciences Sector Skill Development Council', 4, 2)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (10, N'Others', 4, 1)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (11, N'Logistics Sector Skill Council', 4, 2)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (13, N'Apparel Made-Ups Home Furnishing Sector Skill Council', 4, 2)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (14, N'Electronics Sector Skills Council of India', 4, 2)
GO
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (15, N'Others', 4, 2)
GO
SET IDENTITY_INSERT [dbo].[Sector] OFF
GO
SET IDENTITY_INSERT [dbo].[Session] ON 

GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (54, N'Introduction to C#', N'2 hrs', 1, N'Understanding C#', 2, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (55, N'Framework', N'2 hrs', 1, N'Understanding Framework', 2, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (56, N'Datatypes', N'2 hrs', 1, N'Understanding Datatypes', 2, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (57, N'OOPS', N'2 hrs', 2, N'Understanding OOPS', 2, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (58, N'Test Introduction to C#', N'2 hrs', 1, N'Understanding C#', 3, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (59, N'Test Framework', N'2 hrs', 1, N'Understanding Framework', 3, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (60, N'Test Datatypes', N'2 hrs', 1, N'Understanding Datatypes', 3, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (61, N'Test OOPS', N'2 hrs', 2, N'Understanding OOPS', 3, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (72, N'Introduction to SQL', N'2 hrs', 1, N'Understanding SQL', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (73, N'Normalization', N'2 hrs', 1, N'Understanding Normalization', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (74, N'DML', N'2 hrs', 1, N'Understanding DML', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (75, N'DML', N'2 hrs', 2, N'Understanding DML', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (76, N'DDL', N'2 hrs', 1, N'Understanding DDL', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (77, N'DDL', N'2 hrs', 2, N'Understanding DDL', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (78, N'DCL', N'2 hrs', 1, N'Understanding DCL', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (79, N'DCL', N'2 hrs', 2, N'Understanding DCL', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (80, N'DQL', N'1 hr', 1, N'Understanding DQL', 1, 4)
GO
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (81, N'DQL', N'1 hr', 2, N'Understanding DQL', 1, 4)
GO
SET IDENTITY_INSERT [dbo].[Session] OFF
GO
SET IDENTITY_INSERT [dbo].[Site] ON 

GO
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (12, N'PankajSite', 24, 4)
GO
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (13, N'PankajSite2', 25, 4)
GO
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (14, N'TestSite', 29, 4)
GO
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (16, N'test', 29, 4)
GO
SET IDENTITY_INSERT [dbo].[Site] OFF
GO
SET IDENTITY_INSERT [dbo].[State] ON 

GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (1, N'Andhra Pradesh', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (2, N'Arunachal Pradesh', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (3, N'Assam', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (4, N'Bihar', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (5, N'Chhattisgarh', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (6, N'Goa', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (7, N'Gujarat', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (8, N'Haryana', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (9, N'Himachal Pradesh', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (10, N'Jammu and Kashmir', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (11, N'Jharkhand', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (12, N'Karnataka', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (13, N'Kerala', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (14, N'Madhya Pradesh', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (15, N'Maharashtra', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (16, N'Manipur', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (17, N'Meghalaya', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (18, N'Mizoram', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (19, N'Nagaland', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (20, N'Odisha', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (21, N'Punjab', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (22, N'Rajasthan', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (23, N'Sikkim', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (24, N'Tamil Nadu', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (25, N'Tripura', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (26, N'Uttar Pradesh', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (27, N'Uttarakhand', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (28, N'West Bengal', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (29, N'Telangana', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (30, N'Andaman and Nicobar', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (31, N'Chandigarh', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (32, N'Dadra and Nagar Haveli', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (33, N'Daman and Diu', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (34, N'Lakshadweep', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (35, N'NCT Delhi', 4)
GO
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (36, N'Puducherry', 4)
GO
SET IDENTITY_INSERT [dbo].[State] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentType] ON 

GO
INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (1, N'Student', 4)
GO
INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (2, N'Working Professional', 4)
GO
INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (3, N'Searching For Job', 4)
GO
SET IDENTITY_INSERT [dbo].[StudentType] OFF
GO
SET IDENTITY_INSERT [dbo].[Subject] ON 

GO
INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (1, N'SQL', 2, 1, 1, 100, 40, 2, 4)
GO
INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (2, N'Programming in C#', 2, 1, 2, 100, 40, 2, 4)
GO
INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (3, N'Test C#', 5, 1, 2, 100, 40, 2, 4)
GO
INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (4, N'Tally', NULL, NULL, 1, 100, 40, 2, 4)
GO
INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (5, N'test', NULL, NULL, 1, 100, 40, 2, 4)
GO
SET IDENTITY_INSERT [dbo].[Subject] OFF
GO
SET IDENTITY_INSERT [dbo].[SubjectCourse] ON 

GO
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (5, 5, 25, 4)
GO
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (6, 5, 24, 4)
GO
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (7, 5, 23, 4)
GO
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (30, 4, 25, 4)
GO
SET IDENTITY_INSERT [dbo].[SubjectCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[Taluka] ON 

GO
INSERT [dbo].[Taluka] ([TalukaId], [Name], [DistrictId], [StateId], [OrganisationId]) VALUES (1, N'Test', 1, 1, 4)
GO
SET IDENTITY_INSERT [dbo].[Taluka] OFF
GO
SET IDENTITY_INSERT [dbo].[Team] ON 

GO
INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (1, N'IT Team', 4, 36)
GO
INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (3, N'Testing Team', 4, 20)
GO
SET IDENTITY_INSERT [dbo].[Team] OFF
GO
SET IDENTITY_INSERT [dbo].[Trainer] ON 

GO
INSERT [dbo].[Trainer] ([TrainerId], [Title], [FirstName], [MiddleName], [LastName], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [Gender], [AadharNo], [Mobile], [DateOfBirth], [EmailId], [Certified], [CertificationNo], [SectorId], [CourseId], [CentreId], [OrganisationId], [PersonnelId], [CreatedDate]) VALUES (1, N'Mr.', N'Shraddha', N'Vijay', N'Paradkar', N'Koparkhairane', NULL, NULL, NULL, 1, 15, 115, N'400709', N'Female', 8888888888888888, 7777777777, CAST(N'0001-01-01' AS Date), N'paradkarsh24@gmail.com', N'No', NULL, 1, 14, 1, 4, 50, CAST(N'2017-04-24' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Trainer] OFF
GO
SET IDENTITY_INSERT [dbo].[TrainerDocument] ON 

GO
INSERT [dbo].[TrainerDocument] ([TrainerDocumentId], [TrainerId], [TrainerName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1, 1, N'test Email', N'tv.pdf', N'Trainer Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\test_Email_1\Trainer Document\Trainer Document_c2418933-bd6a-4419-bdb4-4156ad406734_tv.pdf', 9, N'c2418933-bd6a-4419-bdb4-4156ad406734', CAST(N'2017-03-30 00:00:00.000' AS DateTime), NULL, 4, 1)
GO
SET IDENTITY_INSERT [dbo].[TrainerDocument] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkingPattern] ON 

GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (28, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (29, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (30, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (31, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (32, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (33, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (34, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (35, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (36, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (37, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (38, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (39, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (40, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (41, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (42, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (43, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (44, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (45, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (46, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (47, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (48, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (49, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (50, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (51, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (52, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (53, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (54, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (55, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (56, 4)
GO
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (57, 4)
GO
SET IDENTITY_INSERT [dbo].[WorkingPattern] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkingPatternDay] ON 

GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (274, 33, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (275, 33, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (276, 33, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (277, 33, 4, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (278, 33, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (279, 33, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (280, 33, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (281, 34, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (282, 34, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (283, 34, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (284, 34, 4, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (285, 34, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (286, 34, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (287, 34, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (288, 35, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (289, 35, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (290, 35, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (291, 35, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (292, 35, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (293, 35, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (294, 35, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (295, 36, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (296, 36, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (297, 36, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (298, 36, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (299, 36, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (300, 36, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (301, 36, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (316, 37, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (317, 37, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (318, 37, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (319, 37, 4, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (320, 37, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (321, 37, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (322, 37, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (323, 38, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (324, 38, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (325, 38, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (326, 38, 4, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (327, 38, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (328, 38, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (329, 38, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (337, 39, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (338, 39, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (339, 39, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (340, 39, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (341, 39, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (342, 39, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (343, 39, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (344, 40, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (345, 40, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (346, 40, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (347, 40, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (348, 40, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (349, 40, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (350, 40, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (351, 41, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (352, 41, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (353, 41, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (354, 41, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (355, 41, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (356, 41, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (357, 41, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (358, 42, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (359, 42, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (360, 42, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (361, 42, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (362, 42, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (363, 42, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (364, 42, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (365, 43, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (366, 43, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (367, 43, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (368, 43, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (369, 43, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (370, 43, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (371, 43, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (372, 44, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (373, 44, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (374, 44, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (375, 44, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (376, 44, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (377, 44, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (378, 44, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (379, 45, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (380, 45, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (381, 45, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (382, 45, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (383, 45, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (384, 45, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (385, 45, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (386, 46, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (387, 46, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (388, 46, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (389, 46, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (390, 46, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (391, 46, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (392, 46, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (393, 47, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (394, 47, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (395, 47, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (396, 47, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (397, 47, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (398, 47, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (399, 47, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (400, 49, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (401, 48, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (402, 49, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (403, 48, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (404, 48, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (405, 49, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (406, 49, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (407, 48, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (408, 48, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (409, 49, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (410, 48, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (411, 49, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (412, 48, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (413, 49, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (414, 50, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (415, 50, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (416, 50, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (417, 50, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (418, 50, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (419, 50, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (420, 50, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (421, 51, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (422, 51, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (423, 51, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (424, 51, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (425, 51, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (426, 51, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (427, 51, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (428, 52, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (429, 52, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (430, 52, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (431, 52, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (432, 52, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (433, 52, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (434, 52, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (442, 53, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (443, 53, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (444, 53, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (445, 53, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (446, 53, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (447, 53, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (448, 53, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (449, 54, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (450, 54, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (451, 54, 3, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (452, 54, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (453, 54, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (454, 54, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (455, 54, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (456, 55, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (457, 55, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (458, 55, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (459, 55, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (460, 55, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (461, 55, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (462, 55, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (463, 56, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (464, 56, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (465, 56, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (466, 56, 4, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (467, 56, 5, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (468, 56, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (469, 56, 0, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (470, 57, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (471, 57, 2, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (472, 57, 3, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (473, 57, 4, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (474, 57, 5, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (475, 57, 6, 0, 0)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (476, 57, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[WorkingPatternDay] OFF
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_AbsenceStatus] FOREIGN KEY([AbsenceStatusId])
REFERENCES [dbo].[AbsenceStatus] ([AbsenceStatusId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_AbsenceStatus]
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_Organisation]
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_PersonnelAbsenceEntitlement] FOREIGN KEY([PersonnelAbsenceEntitlementId])
REFERENCES [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_PersonnelAbsenceEntitlement]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceDay_Absence] FOREIGN KEY([AbsenceId])
REFERENCES [dbo].[Absence] ([AbsenceId])
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [FK_AbsenceDay_Absence]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceDay_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [FK_AbsenceDay_Organisation]
GO
ALTER TABLE [dbo].[AbsencePeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePeriod_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePeriod] CHECK CONSTRAINT [FK_AbsencePeriod_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicy]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicy_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicy] CHECK CONSTRAINT [FK_AbsencePolicy_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicy]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicy_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[AbsencePolicy] CHECK CONSTRAINT [FK_AbsencePolicy_WorkingPattern]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_AbsencePolicy]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_AbsenceType] FOREIGN KEY([AbsenceTypeId])
REFERENCES [dbo].[AbsenceType] ([AbsenceTypeId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_AbsenceType]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_Frequency] FOREIGN KEY([FrequencyId])
REFERENCES [dbo].[Frequency] ([FrequencyId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_Frequency]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePeriod] FOREIGN KEY([AbsencePeriodId])
REFERENCES [dbo].[AbsencePeriod] ([AbsencePeriodId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePeriod]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePolicy]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_Organisation]
GO
ALTER TABLE [dbo].[AbsenceType]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceType_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[AbsenceType] CHECK CONSTRAINT [FK_AbsenceType_Colour]
GO
ALTER TABLE [dbo].[AbsenceType]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsenceType] CHECK CONSTRAINT [FK_AbsenceType_Organisation]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Batch]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Centre]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Enquiry]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Organisation]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_PaymentMode] FOREIGN KEY([PaymentModeId])
REFERENCES [dbo].[PaymentMode] ([PaymentModeId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_PaymentMode]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_RegistrationPaymentReceipt] FOREIGN KEY([RegistrationPaymentReceiptId])
REFERENCES [dbo].[RegistrationPaymentReceipt] ([RegistrationPaymentReceiptId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_RegistrationPaymentReceipt]
GO
ALTER TABLE [dbo].[AreaOfInterest]  WITH CHECK ADD  CONSTRAINT [FK_AreaOfInterest_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AreaOfInterest] CHECK CONSTRAINT [FK_AreaOfInterest_Organisation]
GO
ALTER TABLE [dbo].[AspNetUsersAlertSchedule]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsersAlertSchedule_Alert1] FOREIGN KEY([AlertId])
REFERENCES [dbo].[Alert] ([AlertId])
GO
ALTER TABLE [dbo].[AspNetUsersAlertSchedule] CHECK CONSTRAINT [FK_AspNetUsersAlertSchedule_Alert1]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Centre]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Course]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_CourseInstallment]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Organisation]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Room]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Batch]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Centre]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Organisation]
GO
ALTER TABLE [dbo].[BatchTimePrefer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTimePrefer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchTimePrefer] CHECK CONSTRAINT [FK_BatchTimePrefer_Organisation]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Batch]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Centre]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Organisation]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Trainer] FOREIGN KEY([TrainerId])
REFERENCES [dbo].[Trainer] ([TrainerId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Trainer]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Centre]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Event]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Organisation]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Question]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Centre]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Event]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Organisation]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Question]
GO
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Organisation]
GO
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Site] FOREIGN KEY([SiteId])
REFERENCES [dbo].[Site] ([SiteId])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Site]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_CandidateInstallment] FOREIGN KEY([CandidateInstallmentId])
REFERENCES [dbo].[CandidateInstallment] ([CandidateInstallmentId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_CandidateInstallment]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Centre]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_FeeType] FOREIGN KEY([FeeTypeId])
REFERENCES [dbo].[FeeType] ([FeeTypeId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_FeeType]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Organisation]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_PaymentMode] FOREIGN KEY([PaymentModeId])
REFERENCES [dbo].[PaymentMode] ([PaymentModeId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_PaymentMode]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_Admission] FOREIGN KEY([AdmissionId])
REFERENCES [dbo].[Admission] ([AdmissionId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_Admission]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_Centre]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_Organisation]
GO
ALTER TABLE [dbo].[CasteCategory]  WITH CHECK ADD  CONSTRAINT [FK_CasteCategory_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CasteCategory] CHECK CONSTRAINT [FK_CasteCategory_Organisation]
GO
ALTER TABLE [dbo].[Centre]  WITH CHECK ADD  CONSTRAINT [FK_Centre_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Centre] CHECK CONSTRAINT [FK_Centre_Organisation]
GO
ALTER TABLE [dbo].[CentreCourse]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourse_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreCourse] CHECK CONSTRAINT [FK_CentreCourse_Centre]
GO
ALTER TABLE [dbo].[CentreCourse]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourse_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreCourse] CHECK CONSTRAINT [FK_CentreCourse_Organisation]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_Centre]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_Organisation]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Centre]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Organisation]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Scheme]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Centre]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Organisation]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Sector]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Colour]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Organisation]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Building] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Building] ([BuildingId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Building]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Company]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Organisation]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Centre]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Course] FOREIGN KEY([CourseOfferedId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Course]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Enquiry]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Organisation]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Personnel]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_CourseType] FOREIGN KEY([CourseTypeId])
REFERENCES [dbo].[CourseType] ([CourseTypeId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_CourseType]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Scheme]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Sector]
GO
ALTER TABLE [dbo].[CourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstallment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CourseInstallment] CHECK CONSTRAINT [FK_CourseInstallment_Course]
GO
ALTER TABLE [dbo].[CourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstallment_CourseInstallment] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseInstallment] CHECK CONSTRAINT [FK_CourseInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Course]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Organisation]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Subject]
GO
ALTER TABLE [dbo].[CourseType]  WITH CHECK ADD  CONSTRAINT [FK_CourseType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseType] CHECK CONSTRAINT [FK_CourseType_Organisation]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK__Departmen__Colou__4F9CCB9E] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK__Departmen__Colou__4F9CCB9E]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Organisation]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_Organisation]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_State]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_DocumentType] FOREIGN KEY([DocumentTypeId])
REFERENCES [dbo].[DocumentType] ([DocumentTypeId])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_DocumentType]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Organisation]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Country]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Organisation]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Personnel]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_AbsencePolicy]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Building1] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Building] ([BuildingId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Building1]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Company]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Organisation]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Personnel]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_PublicHolidayPolicy] FOREIGN KEY([PublicHolidayPolicyId])
REFERENCES [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_PublicHolidayPolicy]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_WorkingPattern]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([DepartmentId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Department]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Employment]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Organisation]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Employment]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Organisation]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([TeamId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Team]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_District] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[District] ([DistrictId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_District]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Enquiry]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_EnquiryType] FOREIGN KEY([EnquiryTypeId])
REFERENCES [dbo].[EnquiryType] ([EnquiryTypeId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_EnquiryType]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_HowDidYouKnowAbout] FOREIGN KEY([HowDidYouKnowAboutId])
REFERENCES [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_HowDidYouKnowAbout]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Occupation] FOREIGN KEY([OccupationId])
REFERENCES [dbo].[Occupation] ([OccupationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Occupation]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Organisation]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Qualification] FOREIGN KEY([EducationalQualificationId])
REFERENCES [dbo].[Qualification] ([QualificationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Qualification]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Religion] FOREIGN KEY([ReligionId])
REFERENCES [dbo].[Religion] ([ReligionId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Religion]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Scheme]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Sector]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_State]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_StudentType] FOREIGN KEY([StudentTypeId])
REFERENCES [dbo].[StudentType] ([StudentTypeId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_StudentType]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Taluka] FOREIGN KEY([TalukaId])
REFERENCES [dbo].[Taluka] ([TalukaId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Taluka]
GO
ALTER TABLE [dbo].[EnquiryCourse]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryCourse_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[EnquiryCourse] CHECK CONSTRAINT [FK_EnquiryCourse_Centre]
GO
ALTER TABLE [dbo].[EnquiryCourse]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryCourse_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[EnquiryCourse] CHECK CONSTRAINT [FK_EnquiryCourse_Course]
GO
ALTER TABLE [dbo].[EnquiryCourse]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryCourse_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[EnquiryCourse] CHECK CONSTRAINT [FK_EnquiryCourse_Enquiry]
GO
ALTER TABLE [dbo].[EnquiryCourse]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryCourse_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EnquiryCourse] CHECK CONSTRAINT [FK_EnquiryCourse_Organisation]
GO
ALTER TABLE [dbo].[EnquiryType]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EnquiryType] CHECK CONSTRAINT [FK_EnquiryType_Organisation]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Centre]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Organisation]
GO
ALTER TABLE [dbo].[Eventday]  WITH CHECK ADD  CONSTRAINT [FK_Eventday_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Eventday] CHECK CONSTRAINT [FK_Eventday_Centre]
GO
ALTER TABLE [dbo].[Eventday]  WITH CHECK ADD  CONSTRAINT [FK_Eventday_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Eventday] CHECK CONSTRAINT [FK_Eventday_Event]
GO
ALTER TABLE [dbo].[Eventday]  WITH CHECK ADD  CONSTRAINT [FK_Eventday_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Eventday] CHECK CONSTRAINT [FK_Eventday_Organisation]
GO
ALTER TABLE [dbo].[Eventday]  WITH CHECK ADD  CONSTRAINT [FK_Eventday_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Eventday] CHECK CONSTRAINT [FK_Eventday_Question]
GO
ALTER TABLE [dbo].[EventFunctionType]  WITH CHECK ADD  CONSTRAINT [FK_EventFunctionType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EventFunctionType] CHECK CONSTRAINT [FK_EventFunctionType_Organisation]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_FollowUp] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_FollowUp]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_FollowUp1] FOREIGN KEY([FollowUpId])
REFERENCES [dbo].[FollowUp] ([FollowUpId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_FollowUp1]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_RegistrationPaymentReceipt] FOREIGN KEY([RegistrationPaymentReceiptId])
REFERENCES [dbo].[RegistrationPaymentReceipt] ([RegistrationPaymentReceiptId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_RegistrationPaymentReceipt]
GO
ALTER TABLE [dbo].[Holiday]  WITH CHECK ADD  CONSTRAINT [FK_Holiday_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Holiday] CHECK CONSTRAINT [FK_Holiday_Centre]
GO
ALTER TABLE [dbo].[Holiday]  WITH CHECK ADD  CONSTRAINT [FK_Holiday_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Holiday] CHECK CONSTRAINT [FK_Holiday_Organisation]
GO
ALTER TABLE [dbo].[Host]  WITH CHECK ADD  CONSTRAINT [FK_Host_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Host] CHECK CONSTRAINT [FK_Host_Organisation]
GO
ALTER TABLE [dbo].[HowDidYouKnowAbout]  WITH CHECK ADD  CONSTRAINT [FK_HowDidYouKnowAboutUs_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[HowDidYouKnowAbout] CHECK CONSTRAINT [FK_HowDidYouKnowAboutUs_Organisation]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Event]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Mobilization] FOREIGN KEY([MobilizationId])
REFERENCES [dbo].[Mobilization] ([MobilizationId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Mobilization]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_MobilizationType] FOREIGN KEY([MobilizationTypeId])
REFERENCES [dbo].[MobilizationType] ([MobilizationTypeId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_MobilizationType]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Organisation]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Personnel]
GO
ALTER TABLE [dbo].[MobilizationType]  WITH CHECK ADD  CONSTRAINT [FK_MobilizationType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[MobilizationType] CHECK CONSTRAINT [FK_MobilizationType_Organisation]
GO
ALTER TABLE [dbo].[Occupation]  WITH CHECK ADD  CONSTRAINT [FK_Occupation_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Occupation] CHECK CONSTRAINT [FK_Occupation_Organisation]
GO
ALTER TABLE [dbo].[PaymentMode]  WITH CHECK ADD  CONSTRAINT [FK_PaymentMode_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PaymentMode] CHECK CONSTRAINT [FK_PaymentMode_Organisation]
GO
ALTER TABLE [dbo].[Personnel]  WITH CHECK ADD  CONSTRAINT [FK_Personnel_Employment] FOREIGN KEY([CurrentEmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[Personnel] CHECK CONSTRAINT [FK_Personnel_Employment]
GO
ALTER TABLE [dbo].[Personnel]  WITH CHECK ADD  CONSTRAINT [FK_Personnel_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Personnel] CHECK CONSTRAINT [FK_Personnel_Organisation]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsencePolicyPeriod] FOREIGN KEY([AbsencePolicyPeriodId])
REFERENCES [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsencePolicyPeriod]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsenceType] FOREIGN KEY([AbsenceTypeId])
REFERENCES [dbo].[AbsenceType] ([AbsenceTypeId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsenceType]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Employment]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Frequency] FOREIGN KEY([FrequencyId])
REFERENCES [dbo].[Frequency] ([FrequencyId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Frequency]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Organisation]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Personnel]
GO
ALTER TABLE [dbo].[Planning]  WITH CHECK ADD  CONSTRAINT [FK_Planning_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Planning] CHECK CONSTRAINT [FK_Planning_Centre]
GO
ALTER TABLE [dbo].[Planning]  WITH CHECK ADD  CONSTRAINT [FK_Planning_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Planning] CHECK CONSTRAINT [FK_Planning_Event]
GO
ALTER TABLE [dbo].[Planning]  WITH CHECK ADD  CONSTRAINT [FK_Planning_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Planning] CHECK CONSTRAINT [FK_Planning_Organisation]
GO
ALTER TABLE [dbo].[Planning]  WITH CHECK ADD  CONSTRAINT [FK_Planning_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Planning] CHECK CONSTRAINT [FK_Planning_Question]
GO
ALTER TABLE [dbo].[Postevent]  WITH CHECK ADD  CONSTRAINT [FK_Postevent_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Postevent] CHECK CONSTRAINT [FK_Postevent_Centre]
GO
ALTER TABLE [dbo].[Postevent]  WITH CHECK ADD  CONSTRAINT [FK_Postevent_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Postevent] CHECK CONSTRAINT [FK_Postevent_Event]
GO
ALTER TABLE [dbo].[Postevent]  WITH CHECK ADD  CONSTRAINT [FK_Postevent_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Postevent] CHECK CONSTRAINT [FK_Postevent_Organisation]
GO
ALTER TABLE [dbo].[Postevent]  WITH CHECK ADD  CONSTRAINT [FK_Postevent_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Postevent] CHECK CONSTRAINT [FK_Postevent_Question]
GO
ALTER TABLE [dbo].[PublicHoliday]  WITH CHECK ADD  CONSTRAINT [FK_PublicHoliday_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PublicHoliday] CHECK CONSTRAINT [FK_PublicHoliday_Organisation]
GO
ALTER TABLE [dbo].[PublicHoliday]  WITH CHECK ADD  CONSTRAINT [FK_PublicHoliday_PublicHolidayPolicy] FOREIGN KEY([PublicHolidayPolicyId])
REFERENCES [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId])
GO
ALTER TABLE [dbo].[PublicHoliday] CHECK CONSTRAINT [FK_PublicHoliday_PublicHolidayPolicy]
GO
ALTER TABLE [dbo].[PublicHolidayPolicy]  WITH CHECK ADD  CONSTRAINT [FK_PublicHolidayPolicy_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PublicHolidayPolicy] CHECK CONSTRAINT [FK_PublicHolidayPolicy_Organisation]
GO
ALTER TABLE [dbo].[Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Qualification_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Qualification] CHECK CONSTRAINT [FK_Qualification_Organisation]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_EventFunctionType] FOREIGN KEY([EventFunctionTypeId])
REFERENCES [dbo].[EventFunctionType] ([EventFunctionTypeId])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_EventFunctionType]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Organisation]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_CandidateFee] FOREIGN KEY([CandidateFeeId])
REFERENCES [dbo].[CandidateFee] ([CandidateFeeId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_CandidateFee]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Centre]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Course]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_CourseInstallment]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Enquiry]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Organisation] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Organisation]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Registration] FOREIGN KEY([RegistrationId])
REFERENCES [dbo].[Registration] ([RegistrationId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Registration]
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt]  WITH CHECK ADD  CONSTRAINT [FK_RegistrationPaymentReceipt_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt] CHECK CONSTRAINT [FK_RegistrationPaymentReceipt_Centre]
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt]  WITH CHECK ADD  CONSTRAINT [FK_RegistrationPaymentReceipt_Counselling] FOREIGN KEY([CounsellingId])
REFERENCES [dbo].[Counselling] ([CounsellingId])
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt] CHECK CONSTRAINT [FK_RegistrationPaymentReceipt_Counselling]
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt]  WITH CHECK ADD  CONSTRAINT [FK_RegistrationPaymentReceipt_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt] CHECK CONSTRAINT [FK_RegistrationPaymentReceipt_Enquiry]
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt]  WITH CHECK ADD  CONSTRAINT [FK_RegistrationPaymentReceipt_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt] CHECK CONSTRAINT [FK_RegistrationPaymentReceipt_Organisation]
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt]  WITH CHECK ADD  CONSTRAINT [FK_RegistrationPaymentReceipt_PaymentMode] FOREIGN KEY([PaymentModeId])
REFERENCES [dbo].[PaymentMode] ([PaymentModeId])
GO
ALTER TABLE [dbo].[RegistrationPaymentReceipt] CHECK CONSTRAINT [FK_RegistrationPaymentReceipt_PaymentMode]
GO
ALTER TABLE [dbo].[Religion]  WITH CHECK ADD  CONSTRAINT [FK_Religion_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Religion] CHECK CONSTRAINT [FK_Religion_Organisation]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Centre]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Organisation]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_RoomType] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[RoomType] ([RoomTypeId])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_RoomType]
GO
ALTER TABLE [dbo].[RoomType]  WITH CHECK ADD  CONSTRAINT [FK_RoomType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[RoomType] CHECK CONSTRAINT [FK_RoomType_Organisation]
GO
ALTER TABLE [dbo].[Scheme]  WITH CHECK ADD  CONSTRAINT [FK_Scheme_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Scheme] CHECK CONSTRAINT [FK_Scheme_Organisation]
GO
ALTER TABLE [dbo].[Sector]  WITH CHECK ADD  CONSTRAINT [FK_Sector_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Sector] CHECK CONSTRAINT [FK_Sector_Organisation]
GO
ALTER TABLE [dbo].[Sector]  WITH CHECK ADD  CONSTRAINT [FK_Sector_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[Sector] CHECK CONSTRAINT [FK_Sector_Scheme]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_CourseType] FOREIGN KEY([CourseTypeId])
REFERENCES [dbo].[CourseType] ([CourseTypeId])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_CourseType]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Organisation]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Subject]
GO
ALTER TABLE [dbo].[Site]  WITH CHECK ADD  CONSTRAINT [FK_Site_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Country]
GO
ALTER TABLE [dbo].[Site]  WITH CHECK ADD  CONSTRAINT [FK_Site_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Organisation]
GO
ALTER TABLE [dbo].[State]  WITH CHECK ADD  CONSTRAINT [FK_State_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [FK_State_Organisation]
GO
ALTER TABLE [dbo].[StudentType]  WITH CHECK ADD  CONSTRAINT [FK_StudentType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[StudentType] CHECK CONSTRAINT [FK_StudentType_Organisation]
GO
ALTER TABLE [dbo].[Subject]  WITH CHECK ADD  CONSTRAINT [FK_Subject_CourseType] FOREIGN KEY([CourseTypeId])
REFERENCES [dbo].[CourseType] ([CourseTypeId])
GO
ALTER TABLE [dbo].[Subject] CHECK CONSTRAINT [FK_Subject_CourseType]
GO
ALTER TABLE [dbo].[Subject]  WITH CHECK ADD  CONSTRAINT [FK_Subject_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Subject] CHECK CONSTRAINT [FK_Subject_Organisation]
GO
ALTER TABLE [dbo].[SubjectCourse]  WITH CHECK ADD  CONSTRAINT [FK_SubjectCourse_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[SubjectCourse] CHECK CONSTRAINT [FK_SubjectCourse_Course]
GO
ALTER TABLE [dbo].[SubjectCourse]  WITH CHECK ADD  CONSTRAINT [FK_SubjectCourse_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[SubjectCourse] CHECK CONSTRAINT [FK_SubjectCourse_Organisation]
GO
ALTER TABLE [dbo].[SubjectCourse]  WITH CHECK ADD  CONSTRAINT [FK_SubjectCourse_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[SubjectCourse] CHECK CONSTRAINT [FK_SubjectCourse_Subject]
GO
ALTER TABLE [dbo].[SubjectTrainer]  WITH CHECK ADD  CONSTRAINT [FK_SubjectTrainer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[SubjectTrainer] CHECK CONSTRAINT [FK_SubjectTrainer_Organisation]
GO
ALTER TABLE [dbo].[SubjectTrainer]  WITH CHECK ADD  CONSTRAINT [FK_SubjectTrainer_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[SubjectTrainer] CHECK CONSTRAINT [FK_SubjectTrainer_Subject]
GO
ALTER TABLE [dbo].[SubjectTrainer]  WITH CHECK ADD  CONSTRAINT [FK_SubjectTrainer_Trainer] FOREIGN KEY([TrainerId])
REFERENCES [dbo].[Trainer] ([TrainerId])
GO
ALTER TABLE [dbo].[SubjectTrainer] CHECK CONSTRAINT [FK_SubjectTrainer_Trainer]
GO
ALTER TABLE [dbo].[Taluka]  WITH CHECK ADD  CONSTRAINT [FK_Taluka_District] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[District] ([DistrictId])
GO
ALTER TABLE [dbo].[Taluka] CHECK CONSTRAINT [FK_Taluka_District]
GO
ALTER TABLE [dbo].[Taluka]  WITH CHECK ADD  CONSTRAINT [FK_Taluka_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Taluka] CHECK CONSTRAINT [FK_Taluka_Organisation]
GO
ALTER TABLE [dbo].[Taluka]  WITH CHECK ADD  CONSTRAINT [FK_Taluka_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[Taluka] CHECK CONSTRAINT [FK_Taluka_State]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Colour]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Organisation]
GO
ALTER TABLE [dbo].[Template]  WITH CHECK ADD  CONSTRAINT [FK_Template_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Template] CHECK CONSTRAINT [FK_Template_Organisation]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_Centre]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_Course]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_District] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[District] ([DistrictId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_District]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_Organisation]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_Personnel]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_Sector]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_State]
GO
ALTER TABLE [dbo].[Trainer]  WITH CHECK ADD  CONSTRAINT [FK_Trainer_Taluka] FOREIGN KEY([TalukaId])
REFERENCES [dbo].[Taluka] ([TalukaId])
GO
ALTER TABLE [dbo].[Trainer] CHECK CONSTRAINT [FK_Trainer_Taluka]
GO
ALTER TABLE [dbo].[TrainerDocument]  WITH CHECK ADD  CONSTRAINT [FK_TrainerDocument_DocumentType] FOREIGN KEY([DocumentTypeId])
REFERENCES [dbo].[DocumentType] ([DocumentTypeId])
GO
ALTER TABLE [dbo].[TrainerDocument] CHECK CONSTRAINT [FK_TrainerDocument_DocumentType]
GO
ALTER TABLE [dbo].[TrainerDocument]  WITH CHECK ADD  CONSTRAINT [FK_TrainerDocument_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[TrainerDocument] CHECK CONSTRAINT [FK_TrainerDocument_Organisation]
GO
ALTER TABLE [dbo].[WorkingPattern]  WITH CHECK ADD  CONSTRAINT [FK_WorkingPattern_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[WorkingPattern] CHECK CONSTRAINT [FK_WorkingPattern_Organisation]
GO
ALTER TABLE [dbo].[WorkingPatternDay]  WITH CHECK ADD  CONSTRAINT [FK_WorkingPatternDay_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[WorkingPatternDay] CHECK CONSTRAINT [FK_WorkingPatternDay_WorkingPattern]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [CK_AbsenceDay_AMPMDuration] CHECK  ((([AM]=(1) OR [PM]=(1)) AND ([Duration]=(0.5) OR [Duration]=(1))))
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [CK_AbsenceDay_AMPMDuration]
GO
/****** Object:  StoredProcedure [dbo].[SearchCounselling]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SearchCounselling]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
		CounsellingId,
      EnquiryId,
      CentreId,
      OrganisationId,
      PersonnelId,
      CourseOfferedId,
      PreferTiming,
      Remarks,
      FollowUpDate,
      RemarkByBranchManager,
      Title,
	  FirstName,
	  MiddleName,
	  LastName,
      SectorId,
      PsychomatricTest,
      ConversionProspect,
		SearchField
	FROM 
		[CounsellingSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END











GO
/****** Object:  StoredProcedure [dbo].[SearchCourse]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SearchCourse]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

		CourseId,
		Name,
		OrganisationId,
		SectorId,
		SchemeId,
		CourseTypeId,
		Description,
		Duration,
		SearchField

	FROM 
		[CourseSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchEnquiry]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[SearchEnquiry]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
	  EnquiryId,
      Title,
	  FirstName,
	  MiddleName,
	  LastName,
      Mobile,
      EmailId,
      Age,
      DateOfBirth,
      Address1,
	  Address2,
	  Address3,
	  Address4,
	  PinCode,
	  TalukaId,
	  DistrictId,
	  StateId,
      GuardianName,
      GuardianContactNo,
      OccupationId,
      ReligionId,
      CasteCategoryId,
      Gender,
      EducationalQualificationId,
      YearOfPassOut,
      Marks,
      IntrestedCourseId,
      HowDidYouKnowAboutId,
      PreTrainingStatus,
      EmploymentStatus,
      Promotional,
      EnquiryDate,
      CentreId,
      OrganisationId,
      StudentCode,
      EnquiryStatus,
      EmployerName,
      EmployerContactNo,
      EmployerAddress,
      AnnualIncome,
      SchemeId,
      EnquiryTypeId,
      StudentTypeId,
      SectorId,
      BatchTimePreferId,
      AppearingQualification,
      YearOfExperience,
      PlacementNeeded,
      Remarks,
      FollowUpDate,
      PreferredMonthForJoining,
	  [Close],
	  ClosingRemark,
	  ConversionProspect,
	  OtherInterestedCourse,
	  RemarkByBm,
	  Registered,
		SearchField
	FROM 
		[EnquirySearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END














GO
/****** Object:  StoredProcedure [dbo].[SearchMobilization]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SearchMobilization]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
		MobilizationId,
		EventId,
		OrganisationId,
		CentreId,
		Title,
		FirstName,
		MiddleName,
		LastName,
		Mobile,
		InterestedCourseId,
		QualificationId,
		CreatedDate,
		FollowUpDate,
		Remark,
		MobilizerStatus,
		[Mobilized By],
		StudentLocation,
		OtherInterestedCourse,
		GeneratedDate,
		SearchField
	FROM 
		[MobilizationSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END










GO
/****** Object:  StoredProcedure [dbo].[SearchPersonnel]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchPersonnel]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
		PersonnelId,
		OrganisationId,
		Title,
		Forenames,
		Surname,
		DOB,
		CountryId,
		Address1,
		Address2,
		Address3,
		Address4,
		Postcode,
		Telephone,
		Mobile,
		NINumber,
		BankAccountNumber,
		BankSortCode,
		BankAccountName,
		BankAddress1,
		BankAddress2,
		BankAddress3,
		BankAddress4,
		BankPostcode,
		BankTelephone,
		Email,
		SearchField
	FROM 
		[PersonnelSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END











GO
/****** Object:  StoredProcedure [dbo].[SearchTrainer]    Script Date: 29-04-2017 19:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SearchTrainer]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
		TrainerId,
      Title,
	  FirstName,
	  MiddleName,
	  LastName,
	   DateOfBirth,
      Address1,
	  Address2,
	  Address3,
	  Address4,
	  PinCode,
	  TalukaId,
	  DistrictId,
	  StateId,
      Gender,
      AadharNo,
      Mobile,
      EmailId,
      CertificationNo,
      SectorId,
      CourseId,
      CentreId,
      OrganisationId,
      PersonnelId,
      CreatedDate,
		SearchField
	FROM 
		[TrainerSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
USE [master]
GO
ALTER DATABASE [NidanERP] SET  READ_WRITE 
GO
