SELECT a.customer_id
,a.name
,NVL(b.CNT,0)cnt
FROM customers a,
(SELECT customer_id,count(order_id) cnt
FROM  ORDERS
GROUP BY customer_id ) b
WHERE a.customer_id = b.customer_id(+)
ORDER BY NVL(cnt,0) DESC;

/*고객들이 몇개를 구매했나??*/



SELECT *
FROM ORDERS
WHERE customer_id = 44;

/*고객이 주문한 내역 */



SELECT product_name, quantity,a.unit_price
FROM ORDER_items a, products b
WHERE a.PRODUCT_ID = b.product_id
AND a.order_id = 29;



SELECT a.customer_id
,a.name
,NVL(B.CNT,0)cnt
FROM customers a,
(SELECT customer_id,count(*) cnt
FROM  ORDERS
GROUP BY customer_id)b
WHERE a.customer_id = b.customer_id(+)
ORDER BY NVL(cnt,0) DESC;












