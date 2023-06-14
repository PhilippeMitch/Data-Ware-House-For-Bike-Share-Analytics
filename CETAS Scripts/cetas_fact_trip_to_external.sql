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

IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[fact_trip]
END

CREATE EXTERNAL TABLE dbo.fact_trip 
WITH (
	LOCATION = 'fact_trip',
	DATA_SOURCE = [udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT
	t.trip_id,
	t.rideable_type,
	t.start_at,
	t.ended_at,
	DATEDIFF(MINUTE, t.start_at, t.ended_at) AS Duration,
	DATEDIFF(YEAR, r.birthday, t.ended_at) AS rider_age,
	t.start_station_id,
	t.end_station_id,
	t.rider_id,
    CONVERT(VARCHAR, p.date, 112) AS date_id
FROM [staging].[trip] t
JOIN [staging].[rider] r ON (t.rider_id=r.rider_id)
JOIN [staging].[payment] p ON (t.rider_id=p.rider_id)
GO

SELECT TOP 100 * FROM dbo.fact_trip
GO