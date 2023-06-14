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

CREATE EXTERNAL TABLE [staging].[trip] (
	[trip_id] nvarchar(50),
	[rideable_type] nvarchar(75),
	[start_at] date,
	[ended_at] date,
	[start_station_id] nvarchar(50),
	[end_station_id] nvarchar(50),
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'public.trip.txt',
	DATA_SOURCE = [udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM [staging].[trip]
GO