SELECT ft.transaction_id, ft.date, ft.branch_id,
       kc.branch_name, kc.kota, kc.provinsi, kc.rating AS rating_cabang,
       ft.customer_name, ft.product_id,
       pr.product_name, pr.price AS actual_price,
       ft.discount_percentage,
       CASE
        WHEN pr.price <= 50000 THEN 0.1
        WHEN pr.price BETWEEN 50001 AND 100000 THEN 0.15
        WHEN pr.price BETWEEN 100001 AND 300000 THEN 0.2
        WHEN pr.price BETWEEN 300001 AND 500000 THEN 0.25
        WHEN pr.price > 500000 THEN 0.3
        END AS persentase_gross_laba,
       (ft.price * (1 - ft.discount_percentage)) AS nett_sales,
       (ft.price * (1 - ft.discount_percentage)) * CASE
        WHEN pr.price <= 50000 THEN 0.1
        WHEN pr.price BETWEEN 50001 AND 100000 THEN 0.15
        WHEN pr.price BETWEEN 100001 AND 300000 THEN 0.2
        WHEN pr.price BETWEEN 300001 AND 500000 THEN 0.25
        WHEN pr.price > 500000 THEN 0.3
        END AS nett_profit,
       ft.rating AS rating_transaksi

FROM `kimia_farma.kf_final_transaction` AS ft
  LEFT JOIN `kimia_farma.kf_kantor_cabang` AS kc
    ON (ft.branch_id = kc.branch_id)
  LEFT JOIN `kimia_farma.kf_product`AS pr
    ON (ft.product_id = pr.product_id)

WHERE ft.date BETWEEN '2020-01-01' AND '2023-12-31'

;

