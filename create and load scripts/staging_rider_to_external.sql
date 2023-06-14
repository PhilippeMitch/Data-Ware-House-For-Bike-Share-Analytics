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

CREATE EXTERNAL TABLE [staging].[rider] (
	[rider_id] bigint,
	[first] nvarchar(50),
	[last] nvarchar(50),
	[address] nvarchar(100),
	[birthday] date,
	[account_start_date] date,
	[account_end_date] date,
	[is_member] bit
	)
	WITH (
	LOCATION = 'public.rider.txt',
	DATA_SOURCE = [udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO

SELECT TOP 100 * FROM [staging].[rider]
GO