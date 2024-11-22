Select * From DimTime
DROP TABLE IF EXISTS DimTime;
DECLARE @StartDate date = '20110112';
DECLARE @Year int = 4;
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, @Year, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    DateKey         	= CONVERT(datetime, d),
    TheDay         		= DATEPART(DAY,       d),
    TheDayName      	= DATENAME(WEEKDAY,   d),
    TheWeek         	= DATEPART(WEEK,      d),
    TheISOWeek      	= DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    	= DATEPART(WEEKDAY,   d),
    TheMonth        	= DATEPART(MONTH,     d),
    TheMonthName    	= DATENAME(MONTH,     d),
    TheQuarter      	= DATEPART(Quarter,   d),
    TheYear         	= DATEPART(YEAR,      d),
    TheFirstOfMonth 	= DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   	= DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    	= DATEPART(DAYOFYEAR, d)
  FROM d
)


SELECT * 
INTO DimTime 
FROM src
ORDER BY DateKey
OPTION (MAXRECURSION 0)