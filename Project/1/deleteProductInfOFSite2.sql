SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;
select * from Product_Info2@site2;

--Input
ACCEPT name_ PROMPT "Enter Product Name:";

Declare
name VARCHAR2(30) := '&name_';
deleteName VARCHAR2(30);

--Main
Begin

Select p_Name into deleteName from Product_Info2@site2
	WHERE p_Name = name;
	
	
IF deleteName IS NOT NULL then
	DELETE FROM Product_Info2@site2
		WHERE p_name = deleteName;
		
End if;
commit;
	EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Data not found.');
End;
/


select * from Product_Info2@site2;

