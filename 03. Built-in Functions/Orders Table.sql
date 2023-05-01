SELECT `product_name`, `order_date`, 
ADDDATE(`order_date`, INTERVAL 3 DAY) AS pay_due,
ADDDATE(`order_date`, INTERVAL 1 month) AS deliver_due
FROM `orders`;
