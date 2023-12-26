SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;
select * from Customer_Info2@site2;
select * from Order_Info2@site2;


--Input
ACCEPT phone_ PROMPT "Enter Phone Number:";

Declare
phone Customer_Info1.c_phone%TYPE := '&phone_';
deletePhone Customer_Info1.c_phone%TYPE;
customer_ID Customer_Info1.c_ID%TYPE;

--Main
Begin

Select c_phone,c_ID into deletePhone,customer_ID from Customer_Info2@site2
	WHERE c_phone = phone;
	
IF deletePhone IS NOT NULL then
	DELETE FROM Order_Info2@site2
		WHERE c_ID = customer_ID;
		DBMS_OUTPUT.PUT_LINE('Deleted SUCCESSFUL.');
End if;
commit;

	EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Data not found.');
End;
/

select * from Order_Info2@site2;

