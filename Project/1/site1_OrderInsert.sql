SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;
select * from Product_Info1;
select * from Inventory_Info1;
select * from Customer_Info;
create or replace trigger TRIGOrder
after INSERT or UPDATE  
on Order_Info1
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('New Order Added. Trigger.');
  DBMS_OUTPUT.PUT_LINE('Updated Table. Trigger.');
END TRIG;
/

--Package
CREATE OR REPLACE PACKAGE OrderInfo 
AS
PROCEDURE AddOrder(
product_name IN Product_Info1.p_Name%TYPE,
customer_name IN Customer_Info.c_Name%TYPE,
order_date IN Order_Info1.o_DATE%TYPE,
order_amount IN Order_Info1.o_Quan%TYPE,
delivery_location IN Order_Info1.o_DelivLoc%TYPE
);
END OrderInfo;
/

--Package body
CREATE OR REPLACE PACKAGE BODY OrderInfo 
AS
PROCEDURE AddOrder(
product_name IN Product_Info1.p_Name%TYPE,
customer_name IN Customer_Info.c_Name%TYPE,
order_date IN Order_Info1.o_DATE%TYPE,
order_amount IN Order_Info1.o_Quan%TYPE,
delivery_location IN Order_Info1.o_DelivLoc%TYPE
)
AS
product_id Product_Info1.p_ID%TYPE;
inventory_id Inventory_Info1.i_ID%TYPE;
customer_id Customer_Info.c_ID%TYPE;
total_order_id Number;
p_price Product_Info1.p_Price%TYPE;
i_quantity Inventory_Info1.i_Quan%TYPE;
total_inventory Inventory_Info1.i_Quan%TYPE;

BEGIN
--product id from product name
SELECT p_ID,p_Price INTO product_id,p_price 
FROM Product_Info1 WHERE p_name = product_name ;

--customer iD from customer name
SELECT c_ID INTO customer_id 
FROM Customer_Info where c_Name = customer_name;

-- Check if there is enough amount in inventory to fulfill the order
SELECT i_Quan,i_id INTO total_inventory,inventory_id
FROM Inventory_Info1 WHERE p_ID = product_id;

IF total_inventory < order_amount THEN
  RAISE_APPLICATION_ERROR(-20003, 'Not enough inventory to fulfill the order');
END IF;

-- Generate a new order ID
Select count(o_ID) into total_order_id from Order_Info1;

-- Insert the new order into the OrderInfo table
INSERT INTO Order_Info1 VALUES (
  (total_order_id+1),inventory_id,customer_id,
  order_date,order_amount,(p_Price*order_amount),delivery_location
);

--Update the inventory quantity
SELECT i_ID,i_Quan INTO inventory_id,i_quantity 
FROM Inventory_Info1 
WHERE p_ID = product_id AND i_Quan >= order_amount;
UPDATE Inventory_Info1 
SET i_Quan = i_Quan - order_amount
WHERE i_ID = inventory_id;

--Commit
COMMIT;

EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE_APPLICATION_ERROR(-20004, 'Invalid product name or customer name');
WHEN OTHERS THEN

-- Roll back the transaction
ROLLBACK;

--Raise an application error with the error message
RAISE_APPLICATION_ERROR(-20006, 'Error at adding order: ' || SQLERRM);

END AddOrder;
END OrderInfo;
/

--Input
ACCEPT product PROMPT "Enter Product Name:";
ACCEPT customer PROMPT "Enter Customer Name:";
ACCEPT quantity_ Number PROMPT "Enter Quantity:";
ACCEPT deli_location PROMPT "Enter Location:";

Declare
product_n Product_Info1.p_Name%TYPE:= '&product';
customer_n Customer_Info.c_Name%TYPE:='&customer';
order_q Number:=&quantity_;
delivery_loc Order_Info1.o_DelivLoc%TYPE:='&deli_location';
today_date DATE := SYSDATE;

--Main
BEGIN
  OrderInfo.AddOrder(product_n,customer_n,today_date,order_q,delivery_loc);
END;
/
select * from Order_Info1;
