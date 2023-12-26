SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;
select * from Product_Info1;

create or replace trigger TRIGDelete
after DELETE  
on Product_Info1
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('Delete SUCCESSFUL. Trigger.');

END TRIG;
/

--Input
ACCEPT name_ PROMPT "Enter Product Name:";

Declare
name VARCHAR2(30) := '&name_';
deleteName Product_Info1.p_Name%TYPE;

--Main
Begin

Select p_Name into deleteName from Product_Info1
	WHERE p_Name = name;
	
	
IF deleteName IS NOT NULL then
	DELETE FROM Product_Info1
		WHERE p_name = deleteName;
		
End if;
commit;
	EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Data not found.');
End;
/


select * from Product_Info1;


