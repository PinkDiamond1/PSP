-- Script generated by Aqua Data Studio Schema Synchronization for MS SQL Server 2016 on Wed Nov 17 13:25:55 PST 2021
-- Execute this script on:
-- 		PIMS_S15_01/<All Schemas> - This database/schema will be modified
-- to synchronize it with MS SQL Server 2016:
-- 		PIMS_S15_00/<All Schemas>

-- We recommend backing up the database prior to executing the script.

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop foreign key constraint PIM_PIDSRT_PIM_SRCTRC_FK
PRINT N'Drop foreign key constraint PIM_PIDSRT_PIM_SRCTRC_FK'
GO
ALTER TABLE [etl].[ETL_DATA_SOURCE_TRACE]
	DROP CONSTRAINT [PIM_PIDSRT_PIM_SRCTRC_FK]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop foreign key constraint PIM_PIDSRT_PIM_PRPRTY_FK
PRINT N'Drop foreign key constraint PIM_PIDSRT_PIM_PRPRTY_FK'
GO
ALTER TABLE IF EXISTS [dbo].[PIMS_PROPERTY]
	DROP CONSTRAINT [PIM_PIDSRT_PIM_PRPRTY_FK]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop unique index etl.SRCTRC_DATA_SOURCE_UK
PRINT N'Drop unique index etl.SRCTRC_DATA_SOURCE_UK'
GO
DROP INDEX [etl].[ETL_DATA_SOURCE_TRACE].[SRCTRC_DATA_SOURCE_UK]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop index etl.SRCTRC_DATA_SOURCE_TYPE_CODE_IDX
PRINT N'Drop index etl.SRCTRC_DATA_SOURCE_TYPE_CODE_IDX'
GO
DROP INDEX [etl].[ETL_DATA_SOURCE_TRACE].[SRCTRC_DATA_SOURCE_TYPE_CODE_IDX]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_PIDSRT_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_PIDSRT_I_S_I_TR'
GO
DROP TRIGGER [dbo].[PIMS_PIDSRT_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_LEASE_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_LEASE_I_S_I_TR'
GO
DROP TRIGGER [dbo].[PIMS_LEASE_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SECDEP_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_SECDEP_I_S_I_TR'
GO
DROP TRIGGER [dbo].[PIMS_SECDEP_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SECDEP_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_SECDEP_A_S_IUD_TR'
GO
DROP TRIGGER [dbo].[PIMS_SECDEP_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_LEASE_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_LEASE_I_S_U_TR'
GO
DROP TRIGGER [dbo].[PIMS_LEASE_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_LEASE_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_LEASE_A_S_IUD_TR'
GO
DROP TRIGGER [dbo].[PIMS_LEASE_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_PIDSRT_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_PIDSRT_I_S_U_TR'
GO
DROP TRIGGER [dbo].[PIMS_PIDSRT_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SDRTRN_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_SDRTRN_I_S_I_TR'
GO
DROP TRIGGER [dbo].[PIMS_SDRTRN_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SDRTRN_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_SDRTRN_I_S_U_TR'
GO
DROP TRIGGER [dbo].[PIMS_SDRTRN_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SDRTRN_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_SDRTRN_A_S_IUD_TR'
GO
DROP TRIGGER [dbo].[PIMS_SDRTRN_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_PROJCT_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_PROJCT_A_S_IUD_TR'
GO
DROP TRIGGER [dbo].[PIMS_PROJCT_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SECDEP_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_SECDEP_I_S_U_TR'
GO
DROP TRIGGER [dbo].[PIMS_SECDEP_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop primary key constraint PK__ETL_DATA__BD9DF3486EC62F1C
PRINT N'Drop primary key constraint PK__ETL_DATA__BD9DF3486EC62F1C'
GO
ALTER TABLE [etl].[ETL_DATA_SOURCE_TRACE]
	DROP CONSTRAINT [PK__ETL_DATA__BD9DF3486EC62F1C]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop primary key constraint PIDSRT_PK
PRINT N'Drop primary key constraint PIDSRT_PK'
GO
ALTER TABLE [dbo].[PIMS_DATA_SOURCE_TYPE]
	DROP CONSTRAINT [PIDSRT_PK]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop procedure dbo.pims_error_handling
PRINT N'Drop procedure dbo.pims_error_handling'
GO
DROP PROCEDURE [dbo].[pims_error_handling]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop view dbo.PIMS_CONTACT_MGR_VW
PRINT N'Drop view dbo.PIMS_CONTACT_MGR_VW'
GO
DROP VIEW [dbo].[PIMS_CONTACT_MGR_VW]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop function dbo.pims_ColumnExists
PRINT N'Drop function dbo.pims_ColumnExists'
GO
DROP FUNCTION [dbo].[pims_ColumnExists]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create function dbo.pims_ColumnExists
PRINT N'Create function dbo.pims_ColumnExists'
GO
-- --------------------------------------------------------------------------------------------
-- Create function [dbo].[pims_ColumnExists]
-- --------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[pims_ColumnExists](@TableName varchar(100), @ColumnName varchar(100))
RETURNS nvarchar(1)
AS
BEGIN
  DECLARE @Result nvarchar(1);

  IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.Columns WHERE TABLE_NAME = @TableName AND COLUMN_NAME = @ColumnName)
    SET @Result = 'Y'
  ELSE
    SET @Result = 'N'

  IF @TableName LIKE '%HIST'
    SET @Result = 'N'

 RETURN @Result;
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create procedure dbo.pims_error_handling
PRINT N'Create procedure dbo.pims_error_handling'
GO
/* ---------------------------------------------------------------------- */
/* Add procedures                                                         */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add procedures                                                         */
/* ---------------------------------------------------------------------- */

-- ............................................................................................


-- --------------------------------------------------------------------------------------------
-- Create procedure [dbo].[pims_error_handling]
-- --------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pims_error_handling] AS
  begin
    DECLARE @errmsg   nvarchar(2048),
      @severity tinyint,
      @state    tinyint,
      @errno    int,
      @proc     sysname,
      @lineno   int

    SELECT @errmsg = error_message(), @severity = error_severity(),
      @state  = error_state(), @errno = error_number(),
      @proc   = error_procedure(), @lineno = error_line()

    IF @errmsg NOT LIKE '***%'
      BEGIN
        SELECT @errmsg = '*** ' + coalesce(quotename(@proc), '<dynamic SQL>') +
          ', Line ' + ltrim(str(@lineno)) + '. Errno ' +
          ltrim(str(@errno)) + ': ' + @errmsg
      END

    RAISERROR('%s', @severity, @state, @errmsg)
  end
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_LEASE
PRINT N'Alter table dbo.PIMS_LEASE'
GO
ALTER TABLE [dbo].[PIMS_LEASE]
	DROP COLUMN [RETURN_NOTES]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_SECURITY_DEPOSIT
PRINT N'Alter table dbo.PIMS_SECURITY_DEPOSIT'
GO
EXEC dbo.sp_rename N'dbo.PIMS_SECURITY_DEPOSIT.OTHER_DEP_HOLDER_TYPE_DESC' , N'TOTAL_AMOUNT', 'COLUMN'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT] ALTER COLUMN [TOTAL_AMOUNT] money NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN
PRINT N'Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN'
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT_RETURN] ALTER COLUMN [PAYEE_ADDRESS] nvarchar(500) NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT_RETURN]
	ADD [TERMINATION_NOTE] nvarchar(4000) NULL
GO
EXEC sp_addextendedproperty 
	@name = N'MS_Description', @value = N'Notes regarding termination situation' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'PIMS_SECURITY_DEPOSIT_RETURN', 
	@level2type = N'Column', @level2name = N'TERMINATION_NOTE'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN_HIST
PRINT N'Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN_HIST'
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT_RETURN_HIST] ALTER COLUMN [PAYEE_ADDRESS] nvarchar(500) NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT_RETURN_HIST]
	ADD [TERMINATION_NOTE] nvarchar(4000) NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create table dbo.PIMS_PROPERTY_DATA_SOURCE_TYPE
PRINT N'Create table dbo.PIMS_PROPERTY_DATA_SOURCE_TYPE'
GO
CREATE TABLE [dbo].[PIMS_PROPERTY_DATA_SOURCE_TYPE]  ( 
	[PROPERTY_DATA_SOURCE_TYPE_CODE]	nvarchar(20) NOT NULL,
	[DESCRIPTION]                   	nvarchar(200) NOT NULL,
	[IS_DISABLED]                   	bit NOT NULL DEFAULT (CONVERT([bit],(0))),
	[DISPLAY_ORDER]                 	int NULL,
	[CONCURRENCY_CONTROL_NUMBER]    	bigint NOT NULL DEFAULT ((1)),
	[DB_CREATE_TIMESTAMP]           	datetime NOT NULL DEFAULT (getutcdate()),
	[DB_CREATE_USERID]              	nvarchar(30) NOT NULL DEFAULT (user_name()),
	[DB_LAST_UPDATE_TIMESTAMP]      	datetime NOT NULL DEFAULT (getutcdate()),
	[DB_LAST_UPDATE_USERID]         	nvarchar(30) NOT NULL DEFAULT (user_name()),
	PRIMARY KEY CLUSTERED([PROPERTY_DATA_SOURCE_TYPE_CODE])
 ON [PRIMARY])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_LEASE_HIST
PRINT N'Alter table dbo.PIMS_LEASE_HIST'
GO
ALTER TABLE [dbo].[PIMS_LEASE_HIST]
	DROP COLUMN [RETURN_NOTES]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_SECURITY_DEPOSIT_HIST
PRINT N'Alter table dbo.PIMS_SECURITY_DEPOSIT_HIST'
GO
EXEC dbo.sp_rename N'dbo.PIMS_SECURITY_DEPOSIT_HIST.OTHER_DEP_HOLDER_TYPE_DESC' , N'TOTAL_AMOUNT', 'COLUMN'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT_HIST] ALTER COLUMN [TOTAL_AMOUNT] money NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SECDEP_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_SECDEP_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SECDEP_I_S_U_TR] ON PIMS_SECURITY_DEPOSIT INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.SECURITY_DEPOSIT_ID = deleted.SECURITY_DEPOSIT_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_SECURITY_DEPOSIT
    set "SECURITY_DEPOSIT_ID" = inserted."SECURITY_DEPOSIT_ID",
      "LEASE_ID" = inserted."LEASE_ID",
      "SEC_DEP_HOLDER_TYPE_CODE" = inserted."SEC_DEP_HOLDER_TYPE_CODE",
      "SECURITY_DEPOSIT_TYPE_CODE" = inserted."SECURITY_DEPOSIT_TYPE_CODE",
      "DESCRIPTION" = inserted."DESCRIPTION",
      "AMOUNT_PAID" = inserted."AMOUNT_PAID",
      "TOTAL_AMOUNT" = inserted."TOTAL_AMOUNT",
      "DEPOSIT_DATE" = inserted."DEPOSIT_DATE",
      "ANNUAL_INTEREST_RATE" = inserted."ANNUAL_INTEREST_RATE",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_SECURITY_DEPOSIT
    inner join inserted
    on (PIMS_SECURITY_DEPOSIT.SECURITY_DEPOSIT_ID = inserted.SECURITY_DEPOSIT_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_PROJCT_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_PROJCT_A_S_IUD_TR'
GO
/* ---------------------------------------------------------------------- */
/* Add triggers                                                           */
/* ---------------------------------------------------------------------- */

CREATE TRIGGER [dbo].[PIMS_PROJCT_A_S_IUD_TR] ON PIMS_PROJECT FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_PROJECT_HIST set END_DATE_HIST = @curr_date where PROJECT_ID in (select PROJECT_ID from deleted) and END_DATE_HIST is null;

  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_PROJECT_HIST ([PROJECT_ID], [PROJECT_TYPE_CODE], [PROJECT_STATUS_TYPE_CODE], [PROJECT_RISK_TYPE_CODE], [PROJECT_TIER_TYPE_CODE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _PROJECT_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [PROJECT_ID], [PROJECT_TYPE_CODE], [PROJECT_STATUS_TYPE_CODE], [PROJECT_RISK_TYPE_CODE], [PROJECT_TIER_TYPE_CODE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_PROJECT_H_ID_SEQ]) as [_PROJECT_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SDRTRN_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_SDRTRN_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SDRTRN_A_S_IUD_TR] ON PIMS_SECURITY_DEPOSIT_RETURN FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_SECURITY_DEPOSIT_RETURN_HIST set END_DATE_HIST = @curr_date where SECURITY_DEPOSIT_RETURN_ID in (select SECURITY_DEPOSIT_RETURN_ID from deleted) and END_DATE_HIST is null;

  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_SECURITY_DEPOSIT_RETURN_HIST ([SECURITY_DEPOSIT_RETURN_ID], [LEASE_ID], [SECURITY_DEPOSIT_TYPE_CODE], [TERMINATION_DATE], [DEPOSIT_TOTAL], [CLAIMS_AGAINST], [RETURN_AMOUNT], [RETURN_DATE], [CHEQUE_NUMBER], [PAYEE_NAME], [PAYEE_ADDRESS], [TERMINATION_NOTE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _SECURITY_DEPOSIT_RETURN_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [SECURITY_DEPOSIT_RETURN_ID], [LEASE_ID], [SECURITY_DEPOSIT_TYPE_CODE], [TERMINATION_DATE], [DEPOSIT_TOTAL], [CLAIMS_AGAINST], [RETURN_AMOUNT], [RETURN_DATE], [CHEQUE_NUMBER], [PAYEE_NAME], [PAYEE_ADDRESS], [TERMINATION_NOTE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_SECURITY_DEPOSIT_RETURN_H_ID_SEQ]) as [_SECURITY_DEPOSIT_RETURN_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SDRTRN_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_SDRTRN_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SDRTRN_I_S_U_TR] ON PIMS_SECURITY_DEPOSIT_RETURN INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.SECURITY_DEPOSIT_RETURN_ID = deleted.SECURITY_DEPOSIT_RETURN_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_SECURITY_DEPOSIT_RETURN
    set "SECURITY_DEPOSIT_RETURN_ID" = inserted."SECURITY_DEPOSIT_RETURN_ID",
      "LEASE_ID" = inserted."LEASE_ID",
      "SECURITY_DEPOSIT_TYPE_CODE" = inserted."SECURITY_DEPOSIT_TYPE_CODE",
      "TERMINATION_DATE" = inserted."TERMINATION_DATE",
      "DEPOSIT_TOTAL" = inserted."DEPOSIT_TOTAL",
      "CLAIMS_AGAINST" = inserted."CLAIMS_AGAINST",
      "RETURN_AMOUNT" = inserted."RETURN_AMOUNT",
      "RETURN_DATE" = inserted."RETURN_DATE",
      "CHEQUE_NUMBER" = inserted."CHEQUE_NUMBER",
      "PAYEE_NAME" = inserted."PAYEE_NAME",
      "PAYEE_ADDRESS" = inserted."PAYEE_ADDRESS",
      "TERMINATION_NOTE" = inserted."TERMINATION_NOTE",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_SECURITY_DEPOSIT_RETURN
    inner join inserted
    on (PIMS_SECURITY_DEPOSIT_RETURN.SECURITY_DEPOSIT_RETURN_ID = inserted.SECURITY_DEPOSIT_RETURN_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SDRTRN_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_SDRTRN_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SDRTRN_I_S_I_TR] ON PIMS_SECURITY_DEPOSIT_RETURN INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted)
    RETURN;


  insert into PIMS_SECURITY_DEPOSIT_RETURN ("SECURITY_DEPOSIT_RETURN_ID",
      "LEASE_ID",
      "SECURITY_DEPOSIT_TYPE_CODE",
      "TERMINATION_DATE",
      "DEPOSIT_TOTAL",
      "CLAIMS_AGAINST",
      "RETURN_AMOUNT",
      "RETURN_DATE",
      "CHEQUE_NUMBER",
      "PAYEE_NAME",
      "PAYEE_ADDRESS",
      "TERMINATION_NOTE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "SECURITY_DEPOSIT_RETURN_ID",
      "LEASE_ID",
      "SECURITY_DEPOSIT_TYPE_CODE",
      "TERMINATION_DATE",
      "DEPOSIT_TOTAL",
      "CLAIMS_AGAINST",
      "RETURN_AMOUNT",
      "RETURN_DATE",
      "CHEQUE_NUMBER",
      "PAYEE_NAME",
      "PAYEE_ADDRESS",
      "TERMINATION_NOTE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY"
    from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_PIDSRT_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_PIDSRT_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_PIDSRT_I_S_U_TR] ON PIMS_PROPERTY_DATA_SOURCE_TYPE INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.PROPERTY_DATA_SOURCE_TYPE_CODE = deleted.PROPERTY_DATA_SOURCE_TYPE_CODE)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_PROPERTY_DATA_SOURCE_TYPE
    set "PROPERTY_DATA_SOURCE_TYPE_CODE" = inserted."PROPERTY_DATA_SOURCE_TYPE_CODE",
      "DESCRIPTION" = inserted."DESCRIPTION",
      "IS_DISABLED" = inserted."IS_DISABLED",
      "DISPLAY_ORDER" = inserted."DISPLAY_ORDER",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_PROPERTY_DATA_SOURCE_TYPE
    inner join inserted
    on (PIMS_PROPERTY_DATA_SOURCE_TYPE.PROPERTY_DATA_SOURCE_TYPE_CODE = inserted.PROPERTY_DATA_SOURCE_TYPE_CODE);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_LEASE_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_LEASE_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_LEASE_A_S_IUD_TR] ON PIMS_LEASE FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_LEASE_HIST set END_DATE_HIST = @curr_date where LEASE_ID in (select LEASE_ID from deleted) and END_DATE_HIST is null;

  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_LEASE_HIST ([LEASE_ID], [MOTI_NAME_ID], [LEASE_PAY_RVBL_TYPE_CODE], [LEASE_LICENSE_TYPE_CODE], [LEASE_CATEGORY_TYPE_CODE], [LEASE_PURPOSE_TYPE_CODE], [LEASE_PROGRAM_TYPE_CODE], [LEASE_INITIATOR_TYPE_CODE], [LEASE_RESPONSIBILITY_TYPE_CODE], [LEASE_PMT_FREQ_TYPE_CODE], [LEASE_PURPOSE_OTHER_DESC], [L_FILE_NO], [TFA_FILE_NO], [PS_FILE_NO], [LEASE_DESCRIPTION], [LEASE_NOTES], [ORIG_START_DATE], [ORIG_EXPIRY_DATE], [IS_ORIG_EXPIRY_REQUIRED], [INCLUDED_RENEWALS], [RENEWAL_COUNT], [RENEWAL_TERM_MONTHS], [LEASE_AMOUNT], [RESPONSIBILITY_EFFECTIVE_DATE], [INSPECTION_DATE], [INSPECTION_NOTES], [IS_SUBJECT_TO_RTA], [IS_COMM_BLDG], [IS_OTHER_IMPROVEMENT], [IS_EXPIRED], [HAS_PHYSICAL_FILE], [HAS_DIGITAL_FILE], [HAS_PHYSICIAL_LICENSE], [HAS_DIGITAL_LICENSE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _LEASE_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [LEASE_ID], [MOTI_NAME_ID], [LEASE_PAY_RVBL_TYPE_CODE], [LEASE_LICENSE_TYPE_CODE], [LEASE_CATEGORY_TYPE_CODE], [LEASE_PURPOSE_TYPE_CODE], [LEASE_PROGRAM_TYPE_CODE], [LEASE_INITIATOR_TYPE_CODE], [LEASE_RESPONSIBILITY_TYPE_CODE], [LEASE_PMT_FREQ_TYPE_CODE], [LEASE_PURPOSE_OTHER_DESC], [L_FILE_NO], [TFA_FILE_NO], [PS_FILE_NO], [LEASE_DESCRIPTION], [LEASE_NOTES], [ORIG_START_DATE], [ORIG_EXPIRY_DATE], [IS_ORIG_EXPIRY_REQUIRED], [INCLUDED_RENEWALS], [RENEWAL_COUNT], [RENEWAL_TERM_MONTHS], [LEASE_AMOUNT], [RESPONSIBILITY_EFFECTIVE_DATE], [INSPECTION_DATE], [INSPECTION_NOTES], [IS_SUBJECT_TO_RTA], [IS_COMM_BLDG], [IS_OTHER_IMPROVEMENT], [IS_EXPIRED], [HAS_PHYSICAL_FILE], [HAS_DIGITAL_FILE], [HAS_PHYSICIAL_LICENSE], [HAS_DIGITAL_LICENSE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_LEASE_H_ID_SEQ]) as [_LEASE_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_LEASE_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_LEASE_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_LEASE_I_S_U_TR] ON PIMS_LEASE INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted)
    RETURN;
                                      
  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.LEASE_ID = deleted.LEASE_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_LEASE
    set "LEASE_ID" = inserted."LEASE_ID",
      "MOTI_NAME_ID" = inserted."MOTI_NAME_ID",
      "LEASE_PAY_RVBL_TYPE_CODE" = inserted."LEASE_PAY_RVBL_TYPE_CODE",
      "LEASE_LICENSE_TYPE_CODE" = inserted."LEASE_LICENSE_TYPE_CODE",
      "LEASE_CATEGORY_TYPE_CODE" = inserted."LEASE_CATEGORY_TYPE_CODE",
      "LEASE_PURPOSE_TYPE_CODE" = inserted."LEASE_PURPOSE_TYPE_CODE",
      "LEASE_PROGRAM_TYPE_CODE" = inserted."LEASE_PROGRAM_TYPE_CODE",
      "LEASE_INITIATOR_TYPE_CODE" = inserted."LEASE_INITIATOR_TYPE_CODE",
      "LEASE_RESPONSIBILITY_TYPE_CODE" = inserted."LEASE_RESPONSIBILITY_TYPE_CODE",
      "LEASE_PMT_FREQ_TYPE_CODE" = inserted."LEASE_PMT_FREQ_TYPE_CODE",
      "LEASE_PURPOSE_OTHER_DESC" = inserted."LEASE_PURPOSE_OTHER_DESC",
      "L_FILE_NO" = inserted."L_FILE_NO",
      "TFA_FILE_NO" = inserted."TFA_FILE_NO",
      "PS_FILE_NO" = inserted."PS_FILE_NO",
      "LEASE_DESCRIPTION" = inserted."LEASE_DESCRIPTION",
      "LEASE_NOTES" = inserted."LEASE_NOTES",
      "ORIG_START_DATE" = inserted."ORIG_START_DATE",
      "ORIG_EXPIRY_DATE" = inserted."ORIG_EXPIRY_DATE",
      "IS_ORIG_EXPIRY_REQUIRED" = inserted."IS_ORIG_EXPIRY_REQUIRED",
      "INCLUDED_RENEWALS" = inserted."INCLUDED_RENEWALS",  
      "RENEWAL_COUNT" = inserted."RENEWAL_COUNT",
      "RENEWAL_TERM_MONTHS" = inserted."RENEWAL_TERM_MONTHS",
      "LEASE_AMOUNT" = inserted."LEASE_AMOUNT",
      "RESPONSIBILITY_EFFECTIVE_DATE" = inserted."RESPONSIBILITY_EFFECTIVE_DATE",
      "INSPECTION_DATE" = inserted."INSPECTION_DATE",
      "INSPECTION_NOTES" = inserted."INSPECTION_NOTES",
      "IS_SUBJECT_TO_RTA" = inserted."IS_SUBJECT_TO_RTA",
      "IS_COMM_BLDG" = inserted."IS_COMM_BLDG",
      "IS_OTHER_IMPROVEMENT" = inserted."IS_OTHER_IMPROVEMENT",
      "IS_EXPIRED" = inserted."IS_EXPIRED",
      "HAS_PHYSICAL_FILE" = inserted."HAS_PHYSICAL_FILE",
      "HAS_DIGITAL_FILE" = inserted."HAS_DIGITAL_FILE",
      "HAS_PHYSICIAL_LICENSE" = inserted."HAS_PHYSICIAL_LICENSE",
      "HAS_DIGITAL_LICENSE" = inserted."HAS_DIGITAL_LICENSE",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_LEASE
    inner join inserted
    on (PIMS_LEASE.LEASE_ID = inserted.LEASE_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SECDEP_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_SECDEP_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SECDEP_A_S_IUD_TR] ON PIMS_SECURITY_DEPOSIT FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_SECURITY_DEPOSIT_HIST set END_DATE_HIST = @curr_date where SECURITY_DEPOSIT_ID in (select SECURITY_DEPOSIT_ID from deleted) and END_DATE_HIST is null;

  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_SECURITY_DEPOSIT_HIST ([SECURITY_DEPOSIT_ID], [LEASE_ID], [SEC_DEP_HOLDER_TYPE_CODE], [SECURITY_DEPOSIT_TYPE_CODE], [DESCRIPTION], [AMOUNT_PAID], [TOTAL_AMOUNT], [DEPOSIT_DATE], [ANNUAL_INTEREST_RATE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _SECURITY_DEPOSIT_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [SECURITY_DEPOSIT_ID], [LEASE_ID], [SEC_DEP_HOLDER_TYPE_CODE], [SECURITY_DEPOSIT_TYPE_CODE], [DESCRIPTION], [AMOUNT_PAID], [TOTAL_AMOUNT], [DEPOSIT_DATE], [ANNUAL_INTEREST_RATE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_SECURITY_DEPOSIT_H_ID_SEQ]) as [_SECURITY_DEPOSIT_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SECDEP_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_SECDEP_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SECDEP_I_S_I_TR] ON PIMS_SECURITY_DEPOSIT INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted)
    RETURN;


  insert into PIMS_SECURITY_DEPOSIT ("SECURITY_DEPOSIT_ID",
      "LEASE_ID",
      "SEC_DEP_HOLDER_TYPE_CODE",
      "SECURITY_DEPOSIT_TYPE_CODE",
      "DESCRIPTION",
      "AMOUNT_PAID",
      "TOTAL_AMOUNT",
      "DEPOSIT_DATE",
      "ANNUAL_INTEREST_RATE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "SECURITY_DEPOSIT_ID",
      "LEASE_ID",
      "SEC_DEP_HOLDER_TYPE_CODE",
      "SECURITY_DEPOSIT_TYPE_CODE",
      "DESCRIPTION",
      "AMOUNT_PAID",
      "TOTAL_AMOUNT",
      "DEPOSIT_DATE",
      "ANNUAL_INTEREST_RATE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY"
    from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_LEASE_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_LEASE_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_LEASE_I_S_I_TR] ON PIMS_LEASE INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted)
    RETURN;


  insert into PIMS_LEASE ("LEASE_ID",
      "MOTI_NAME_ID",
      "LEASE_PAY_RVBL_TYPE_CODE",
      "LEASE_LICENSE_TYPE_CODE",
      "LEASE_CATEGORY_TYPE_CODE",
      "LEASE_PURPOSE_TYPE_CODE",
      "LEASE_PROGRAM_TYPE_CODE",
      "LEASE_INITIATOR_TYPE_CODE",
      "LEASE_RESPONSIBILITY_TYPE_CODE",
      "LEASE_PMT_FREQ_TYPE_CODE",
      "LEASE_PURPOSE_OTHER_DESC",
      "L_FILE_NO",
      "TFA_FILE_NO",
      "PS_FILE_NO",
      "LEASE_DESCRIPTION",
      "LEASE_NOTES",
      "ORIG_START_DATE",
      "ORIG_EXPIRY_DATE",
      "IS_ORIG_EXPIRY_REQUIRED",
      "INCLUDED_RENEWALS",
      "RENEWAL_COUNT",             
      "RENEWAL_TERM_MONTHS",      
      "LEASE_AMOUNT",
      "RESPONSIBILITY_EFFECTIVE_DATE",
      "INSPECTION_DATE",
      "INSPECTION_NOTES",
      "IS_SUBJECT_TO_RTA",
      "IS_COMM_BLDG",
      "IS_OTHER_IMPROVEMENT",
      "IS_EXPIRED",
      "HAS_PHYSICAL_FILE",
      "HAS_DIGITAL_FILE",
      "HAS_PHYSICIAL_LICENSE",
      "HAS_DIGITAL_LICENSE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "LEASE_ID",
      "MOTI_NAME_ID",
      "LEASE_PAY_RVBL_TYPE_CODE",
      "LEASE_LICENSE_TYPE_CODE",
      "LEASE_CATEGORY_TYPE_CODE",
      "LEASE_PURPOSE_TYPE_CODE",
      "LEASE_PROGRAM_TYPE_CODE",
      "LEASE_INITIATOR_TYPE_CODE",
      "LEASE_RESPONSIBILITY_TYPE_CODE",
      "LEASE_PMT_FREQ_TYPE_CODE",
      "LEASE_PURPOSE_OTHER_DESC",
      "L_FILE_NO",
      "TFA_FILE_NO",
      "PS_FILE_NO",
      "LEASE_DESCRIPTION",
      "LEASE_NOTES",
      "ORIG_START_DATE",
      "ORIG_EXPIRY_DATE",
      "IS_ORIG_EXPIRY_REQUIRED",
      "INCLUDED_RENEWALS",
      "RENEWAL_COUNT",   
      "RENEWAL_TERM_MONTHS",      
      "LEASE_AMOUNT",
      "RESPONSIBILITY_EFFECTIVE_DATE",
      "INSPECTION_DATE",
      "INSPECTION_NOTES",
      "IS_SUBJECT_TO_RTA",
      "IS_COMM_BLDG",
      "IS_OTHER_IMPROVEMENT",
      "IS_EXPIRED",
      "HAS_PHYSICAL_FILE",
      "HAS_DIGITAL_FILE",
      "HAS_PHYSICIAL_LICENSE",
      "HAS_DIGITAL_LICENSE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY"
    from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_PIDSRT_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_PIDSRT_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_PIDSRT_I_S_I_TR] ON PIMS_PROPERTY_DATA_SOURCE_TYPE INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted)
    RETURN;


  insert into PIMS_PROPERTY_DATA_SOURCE_TYPE ("PROPERTY_DATA_SOURCE_TYPE_CODE",
      "DESCRIPTION",
      "IS_DISABLED",
      "DISPLAY_ORDER",
      "CONCURRENCY_CONTROL_NUMBER")
    select "PROPERTY_DATA_SOURCE_TYPE_CODE",
      "DESCRIPTION",
      "IS_DISABLED",
      "DISPLAY_ORDER",
      "CONCURRENCY_CONTROL_NUMBER"
    from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create foreign key constraint PIM_PIDSRT_PIM_PRPRTY_FK
PRINT N'Create foreign key constraint PIM_PIDSRT_PIM_PRPRTY_FK'
GO
ALTER TABLE [dbo].[PIMS_PROPERTY]
	ADD FOREIGN KEY([PROPERTY_DATA_SOURCE_TYPE_CODE])
	REFERENCES [dbo].[PIMS_PROPERTY_DATA_SOURCE_TYPE]([PROPERTY_DATA_SOURCE_TYPE_CODE])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop table etl.ETL_DATA_SOURCE_TRACE
PRINT N'Drop table etl.ETL_DATA_SOURCE_TRACE'
GO
DROP TABLE [etl].[ETL_DATA_SOURCE_TRACE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop sequence dbo.ETL_DATA_SOURCE_TRACE_ID_SEQ
PRINT N'Drop sequence dbo.ETL_DATA_SOURCE_TRACE_ID_SEQ'
GO
DROP SEQUENCE [dbo].[ETL_DATA_SOURCE_TRACE_ID_SEQ]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop table dbo.PIMS_DATA_SOURCE_TYPE
PRINT N'Drop table dbo.PIMS_DATA_SOURCE_TYPE'
GO
DROP TABLE [dbo].[PIMS_DATA_SOURCE_TYPE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
   IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
   PRINT 'The database update failed'
END
GO
