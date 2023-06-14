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

IF OBJECT_ID('dbo.dim_dates') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[dim_dates]
END

CREATE EXTERNAL TABLE dbo.dim_dates
WITH (
	LOCATION = 'dim_dates',
	DATA_SOURCE = [udacityworkspacefile_udacityprojectstorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT
    DISTINCT CONVERT(VARCHAR, p.date, 112) AS date_id,
    CONVERT(VARCHAR, p.date, 31) as date,
    DATEPART(WEEKDAY, p.date) as day,
    (DATEPART(week, p.date) - DATEPART(week, DATEADD(day, 1, EOMONTH(p.date, -1)))) + 1 as week,
    MONTH(p.date) as month,
    DATEPART(QUARTER, p.date) as quarter,
    DATEPART(YEAR, p.date) as year,
    CASE 
        WHEN DATEPART(WEEKDAY, p.date) IN (6, 7) THEN 'TRUE' ELSE 'FALSE' END AS is_weekend
FROM [staging].[payment] p
GO


SELECT TOP 100 * FROM dbo.dim_dates
GO