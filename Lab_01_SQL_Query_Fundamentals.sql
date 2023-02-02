-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table?
-- ------------------------------------------------------------------
SELECT count('id') as Num_products FROM northwind.products;

-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
SELECT product_name
	, quantity_per_unit 
FROM northwind.products;

-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
SELECT id as product_id
	, product_name
FROM northwind.products
WHERE discontinued <> 1;

-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
SELECT id as product_id
	, product_name 
FROM northwind.products
WHERE discontinued <> 0;

-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
SELECT product_name
	 , list_price
FROM northwind.products
WHERE list_price > (select min(list_price) from northwind.products) or list_price > (select max(list_price) from northwind.products);


    

-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
select  id as product_id
	, product_name
	, list_price
from northwind.products
where list_price < 20.00
Order by list_price desc 

-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------
select id as product_id
	, product_name
	, list_price
from northwind.products
where list_price between 15.00 and 20.00;



-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
select product_name
	, list_price
from northwind.products
where list_price > (select avg(list_price) from northwind.products);
order list_price by desc


-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
SELECT product_name
	, list_price
FROM northwind.products
ORDER BY list_price DESC
LIMIT 10


-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------
update northwind.products SET discontinued = 1 where id = 95;

select case discontinued
			when 1 then 'yes'
            else 'no'
		end as is_discontinued
	, count(*) as product_count
from northwind.products
group by discontintued;

update northwind.products  SET discontinued = 0 where id = 95;





-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
SELECT product_name,
	 reorder_level as units_in_stock
	, target_level as units_on_order
FROM northwind.products
WHERE reorder_level < target_level;


-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------
SELECT p.product_name
	, p.list_price as product_list_price
    , p.category as product_category
    , s.company as supplier_company
    , s.address as supplier_address
    , s.city as supplier_city
    , s.state_province as supplier_state_province
    , s.zip_postal_code as supplier_zip_postal_code
FROM northwind.suppliers s
INNER JOIN northwind.products p
ON s.id = p.supplier_ids;
    


-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------
SELECT category
	, count(*) as units_in_stock
FROM northwind.products
GROUP BY category
HAVING units_in_stock < 5;


-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
SELECT category
	, count(*) as product_count
FROM northwind.products
WHERE list_price < 20.00
GROUP BY category
