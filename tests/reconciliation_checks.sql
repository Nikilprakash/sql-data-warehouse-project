   /*
   Purpose: Reconcile Bronze vs Silver row counts across all 6 source tables.
   Result (28 Sep 2026): 116,292 rows in Bronze -> 116,283 in Silver.
   Only crm_cust_info differs (18,493 -> 18,484): 3 rows with NULL cst_id
   and 6 duplicate-ID rows removed, keeping the latest record per customer.
   */

SELECT 'crm_cust_info' AS tbl,
  (SELECT COUNT(*) FROM bronze.crm_cust_info) AS bronze_rows,
  (SELECT COUNT(*) FROM silver.crm_cust_info) AS silver_rows
UNION ALL SELECT 'crm_prd_info',
  (SELECT COUNT(*) FROM bronze.crm_prd_info),
  (SELECT COUNT(*) FROM silver.crm_prd_info)
UNION ALL SELECT 'crm_sales_details',
  (SELECT COUNT(*) FROM bronze.crm_sales_details),
  (SELECT COUNT(*) FROM silver.crm_sales_details)
UNION ALL SELECT 'erp_cust_az12',
  (SELECT COUNT(*) FROM bronze.erp_cust_az12),
  (SELECT COUNT(*) FROM silver.erp_cust_az12)
UNION ALL SELECT 'erp_loc_a101',
  (SELECT COUNT(*) FROM bronze.erp_loc_a101),
  (SELECT COUNT(*) FROM silver.erp_loc_a101)
UNION ALL SELECT 'erp_px_cat_g1v2',
  (SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2),
  (SELECT COUNT(*) FROM silver.erp_px_cat_g1v2);
