IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 FIRST_ROW = 2,
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacityworkspacefile@udacityprojectstorage.dfs.core.windows.net' 
	)
GO

IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[dim_rider]
END

CREATE EXTERNAL TABLE [dbo].[dim_rider]
WITH (
	LOCATION = 'dim_rider',
	DATA_SOURCE = [udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
	[rider_id], 
	[first] as [first_name],
	[last] as [last_name],
	[address], 
	CAST(birthday AS DATE) as birthday,
	CAST(account_start_date AS DATE) as account_start_date,
	CAST(account_end_date AS DATE) as account_end_date,
	[is_member]
FROM [staging].[rider];
GO

SELECT TOP 100 * FROM dbo.dim_rider
GO