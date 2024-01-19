USE [master]
GO
/****** Object:  Database [ClienteAsistencia]    Script Date: 19/01/2024 15:25:24 ******/
CREATE DATABASE [ClienteAsistencia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClienteAsistencia', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ClienteAsistencia.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ClienteAsistencia_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ClienteAsistencia_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ClienteAsistencia] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClienteAsistencia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClienteAsistencia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClienteAsistencia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClienteAsistencia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ClienteAsistencia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClienteAsistencia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET RECOVERY FULL 
GO
ALTER DATABASE [ClienteAsistencia] SET  MULTI_USER 
GO
ALTER DATABASE [ClienteAsistencia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClienteAsistencia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClienteAsistencia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClienteAsistencia] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClienteAsistencia] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ClienteAsistencia] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ClienteAsistencia', N'ON'
GO
ALTER DATABASE [ClienteAsistencia] SET QUERY_STORE = ON
GO
ALTER DATABASE [ClienteAsistencia] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ClienteAsistencia]
GO
/****** Object:  User [admin]    Script Date: 19/01/2024 15:25:25 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [admin]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [admin]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [admin]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [admin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [admin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [admin]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [admin]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 19/01/2024 15:25:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[primerNombre] [nvarchar](max) NULL,
	[segundoNombre] [nvarchar](max) NULL,
	[apellidos] [nvarchar](max) NULL,
	[identificacion] [nvarchar](max) NULL,
	[mail] [nvarchar](max) NULL,
	[estado] [int] NULL,
	[estadoDesc] [nvarchar](max) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spAnularClientes]    Script Date: 19/01/2024 15:25:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAnularClientes]
    @clienteId INT
AS
BEGIN
    DECLARE @rowCount INT;

    -- Verificar si existe un registro con el ID proporcionado
    SELECT @rowCount = COUNT(*)
    FROM Clientes
    WHERE id = @clienteId;

    -- Si no se encuentra ningún registro, devolver un conjunto de resultados con valores predeterminados
    IF @rowCount = 0
    BEGIN
        SELECT id = -1, primerNombre = '', segundoNombre = '', apellidos = '', identificacion = '', mail = '', estado=-1, estadoDesc = ''
        RETURN;
    END

    -- Verificar si el cliente ya está inactivo
    IF EXISTS (SELECT 1 FROM Clientes WHERE id = @clienteId AND estado = 0)
    BEGIN
        SELECT id = -2, primerNombre = '', segundoNombre = '', apellidos = '', identificacion = '', mail = '', estado=-1, estadoDesc = ''
        RETURN;
    END

    -- Actualizar el estado y estadoDesc del cliente
    UPDATE Clientes
    SET estado = 0,
        estadoDesc = 'Inactivo'
    WHERE id = @clienteId;

    -- Devolver el estado actualizado
    SELECT *
    FROM Clientes
    WHERE id = @clienteId;
END;
GO
/****** Object:  StoredProcedure [dbo].[spConsultarClientes]    Script Date: 19/01/2024 15:25:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarClientes]
    @identificacion NVARCHAR(MAX) = NULL
AS
BEGIN
    -- Si se proporciona un valor para @identificacion, realizar un SELECT con filtro
    IF (@identificacion IS NOT NULL OR @identificacion != '')
    BEGIN
        SELECT *
        FROM Clientes
        WHERE identificacion LIKE @identificacion;
    END
    ELSE
    -- Si no se proporciona un valor para @identificacion, realizar un SELECT de todos los registros
    BEGIN
        SELECT *
        FROM Clientes;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[spCrearClientes]    Script Date: 19/01/2024 15:25:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCrearClientes]
    @primerNombre NVARCHAR(MAX),
    @segundoNombre NVARCHAR(MAX),
    @apellidos NVARCHAR(MAX),
    @identificacion NVARCHAR(MAX),
    @mail NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO clientes (primerNombre, segundoNombre, apellidos, identificacion, mail, estado, estadoDesc)
    VALUES (@primerNombre, @segundoNombre, @apellidos, @identificacion, @mail, 1, 'Activo');

    --SELECT SCOPE_IDENTITY() AS Id; -- Devolver el ID del cliente recién insertado
	DECLARE @id INT
	SELECT @id = SCOPE_IDENTITY()
	SELECT 
	id = @id,
	primerNombre,
	segundoNombre,
	Apellidos,
	identificacion,
	mail,
	estado,
	estadoDesc
	FROM CLIENTES
	WHERE id = @id
END;
GO
USE [master]
GO
ALTER DATABASE [ClienteAsistencia] SET  READ_WRITE 
GO
