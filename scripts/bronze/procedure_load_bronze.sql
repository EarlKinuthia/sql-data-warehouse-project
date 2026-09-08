/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
    This stored procedure loads data into the 'bronze' schema tables from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Usage:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @starttime DATETIME, @endtime DATETIME, @batchstarttime DATETIME, @batchendtime DATETIME;
	BEGIN TRY
		SET @batchstarttime = GETDATE();
		PRINT 'Load Bronze Layer'
		PRINT '-----------------'
		
		SET @starttime = GETDATE();
		PRINT 'Truncate & Insert into: crm_cust_info'
		PRINT '-------------------------------------'
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\SQL\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT'crm_cust_info Load Duration:' + CAST(DATEDIFF(second, @starttime ,@endtime) AS NVARCHAR) + ' seconds'; 
		PRINT '-------------------------------------'

		SET @starttime = GETDATE();
		PRINT 'Truncate & Insert into: crm_prd_info'
		PRINT '-------------------------------------'
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\SQL\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT'crm_prd_info Load Duration:' + CAST(DATEDIFF(second, @starttime ,@endtime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------'

		SET @starttime = GETDATE();
		PRINT 'Truncate & Insert into: crm_sales_details'
		PRINT '-------------------------------------'
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\SQL\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT'crm_sales_details Load Duration:' + CAST(DATEDIFF(second, @starttime ,@endtime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------'

		SET @starttime = GETDATE();
		PRINT 'Truncate & Insert into: erp_cust_az12'
		PRINT '-------------------------------------'
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\SQL\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT'erp_cust_az12 Load Duration:' + CAST(DATEDIFF(second, @starttime ,@endtime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------'

		SET @starttime = GETDATE();
		PRINT 'Truncate & Insert into: erp_loc_a101'
		PRINT '-------------------------------------'
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\SQL\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT'erp_loc_a101 Load Duration:' + CAST(DATEDIFF(second, @starttime ,@endtime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------'

		SET @starttime = GETDATE();
		PRINT 'Truncate & Insert into: erp_px_cat_g1v2'
		PRINT '-------------------------------------'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\SQL\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT'erp_px_cat_g1v2 Load Duration:' + CAST(DATEDIFF(second, @starttime ,@endtime) AS NVARCHAR) + ' seconds';

		PRINT '-------------------------------------'
		SET @batchendtime = GETDATE();
		PRINT'Bronze Layer Load Duration:' + CAST(DATEDIFF(second, @batchstarttime ,@batchendtime) AS NVARCHAR) + ' seconds';
	END TRY

	BEGIN CATCH
		PRINT'FAILURE LOADING BRONZE LAYER TABLES'
		PRINT'ERROR MESSAGE:' + ERROR_MESSAGE();
		PRINT'ERROR MESSAGE:' + CAST(ERROR_NUMBER() AS NVARCHAR);
	END CATCH
END
