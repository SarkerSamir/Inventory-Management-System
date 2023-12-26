--Input
ACCEPT loc_ PROMPT "Enter Location:";

DECLARE
  input_location VARCHAR2(50) := '&loc_';
  v_order_id Order_Info1.o_ID%TYPE;
  v_inventory_id number;
  v_customer_id Order_Info1.c_ID%TYPE;
  v_date Order_Info1.o_Date%TYPE;
  v_order_amount Order_Info1.o_Quan%TYPE;
  v_total_price Order_Info1.o_Total%TYPE;
  v_delivery_location Order_Info1.o_DelivLoc%TYPE; 
  cusname varchar(20);
  pname varchar(20);

BEGIN
  FOR order_rec IN (
    SELECT o_ID,oi1.i_ID as iid,c_ID,o_DATE,o_Quan,o_Total,o_DelivLoc  
	FROM Order_Info1 oi1
    INNER JOIN Inventory_Info1 ii1 ON oi1.i_ID = ii1.i_ID
    WHERE ii1.i_Loc = input_location
    UNION ALL
    SELECT o_ID,oi2.i_ID as iid,c_ID,o_DATE,o_Quan,o_Total,o_DelivLoc 
	FROM Order_Info2@site2 oi2
    INNER JOIN Inventory_Info2@site2 ii2 ON oi2.i_ID = ii2.i_ID
    WHERE ii2.i_Loc = input_location
  ) LOOP
    v_order_id := order_rec.o_ID;
    v_inventory_id := order_rec.iid;
    v_customer_id := order_rec.c_ID;
    v_date := order_rec.o_Date;
    v_order_amount := order_rec.o_Quan;
    v_total_price := order_rec.o_Total;
    v_delivery_location := order_rec.o_DelivLoc;
    	
	Select c_name into cusname from Customer_Info where c_id=v_customer_id;
    
	/*select p_name into pname from Product_Info1 where p_ID=(select p_ID from Inventory_Info1 where i_ID=v_inventory_id )
	union all
	select p_name into pname from Product_Info2@site2 where p_ID=
	(select p_ID from Inventory_Info2@site2 where i_ID=v_inventory_id );*/
	
	SELECT p_name INTO pname
	FROM Product_Info1
	WHERE p_ID = (SELECT p_ID FROM Inventory_Info1 WHERE i_ID = v_inventory_id);
  
    DBMS_OUTPUT.PUT_LINE(v_order_id || ' ' || pname || ' ' || cusname || ' ' || v_date || ' ' || v_order_amount || ' ' || v_total_price || ' ' || v_delivery_location);
  END LOOP;
END;
/
show errors;