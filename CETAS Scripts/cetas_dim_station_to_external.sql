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

IF OBJECT_ID('dbo.dim_station') IS NOT NULL 
BEGIN 
	DROP EXTERNAL TABLE [dbo].[dim_station]; 
END

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
	LOCATION = 'dim_station',
	DATA_SOURCE = [udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT [station_id], [name], [latitude], [longitude]
FROM [staging].[station];
GO


SELECT TOP 100 * FROM dbo.dim_station
GO