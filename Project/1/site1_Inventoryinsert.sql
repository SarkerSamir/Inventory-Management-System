SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;
select * from Product_Info1;
select * from Product_Info2@site2;
select * from Inventory_Info1;
select * from Inventory_Info2@site2;
--Trigger for Inventory_Info
CREATE OR REPLACE TRIGGER TRIGInv1
AFTER INSERT ON Inventory_Info
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('New Inventory Added. Trigger for Inventory_Info.');
END;
/
--Package
CREATE OR REPLACE PACKAGE InventoryInsert 
AS 
PROCEDURE insertInventoryInfo(product_name IN Product_Info1.p_Name%TYPE,
                              location IN Inventory_Info1.i_Loc%TYPE,
                              quantity IN Inventory_Info1.i_Quan%TYPE);
END InventoryInsert ; 
/

--Body
CREATE OR REPLACE PACKAGE BODY InventoryInsert  
AS
PROCEDURE insertInventoryInfo(product_name IN Product_Info1.p_Name%TYPE,
                              location IN Inventory_Info1.i_Loc%TYPE,
                              quantity IN Inventory_Info1.i_Quan%TYPE) 
IS
    product_id1 Product_Info1.p_ID%TYPE;
	product_id2 Product_Info1.p_ID%TYPE;
    totalinventory NUMBER;
BEGIN
	if location='Dhaka' then
	
		SELECT p_ID INTO product_id1  
		FROM Product_Info1
		WHERE p_Name = product_name;
		
		IF product_id1 !=0 then
			dbms_output.put_line('here1'); 
			SELECT COUNT(i_ID) INTO totalinventory
			FROM Inventory_Info1;
		
			INSERT INTO Inventory_Info1
			VALUES (totalinventory + 1,product_id1,location,quantity);
		End if;
	ELSIF location!='Dhaka' then
	SELECT p_ID INTO product_id2  
		FROM Product_Info2@site2
		WHERE p_Name = product_name;
		
		IF product_id2 !=0 then
			dbms_output.put_line('here2'); 
			SELECT COUNT(i_ID) INTO totalinventory
			FROM Inventory_Info2@site2;
		
			INSERT INTO Inventory_Info2@site2
			VALUES (totalinventory + 1,product_id2,location,quantity);
		End if;
	END IF;
	EXCEPTION 
    WHEN no_data_found THEN 
      dbms_output.put_line('No Data Found!'); 
	

END insertInventoryInfo;

END InventoryInsert;
/

--Input
ACCEPT product_ PROMPT "Enter Product Name:";
ACCEPT location_ PROMPT "Enter Location:";
ACCEPT quantity_ NUMBER PROMPT "Enter Quantity:"

Declare
product_ VARCHAR2(30) := '&product_';
location_ VARCHAR2(30):='&location_';
quantity number := &quantity_;

--Main
BEGIN
  InventoryInsert.insertInventoryInfo(product_,location_,quantity);
END;
/

select * from Inventory_Info1;
select * from Inventory_Info2@site2;

commit;

show errors;