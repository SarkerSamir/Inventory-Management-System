SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;
select * from Customer_Info;
select * from Order_Info1;

create or replace trigger TRIGDeleteOrder
after DELETE  
on Order_Info1
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('Delete SUCCESSFUL. Trigger.');

END TRIG;
/

--Input
ACCEPT phone_ PROMPT "Enter Phone Number:";

Declare
phone Customer_Info.c_phone%TYPE := '&phone_';
deletePhone Customer_Info.c_phone%TYPE;
customer_ID Customer_Info.c_ID%TYPE;

--Main
Begin

Select c_phone,c_ID into deletePhone,customer_ID from Customer_Info
	WHERE c_phone = phone;
	
IF deletePhone IS NOT NULL then
	DELETE FROM Order_Info1
		WHERE c_ID = customer_ID;	
End if;
commit;

	EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Data not found.');
End;
/

select * from Order_Info1;

