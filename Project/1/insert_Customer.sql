SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;

create or replace trigger TRIGCustomer
after INSERT 
on Customer_Info
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('New Customer Added. Trigger.');
END TRIG;
/
--Input
ACCEPT name PROMPT "Enter Customer Name:";
ACCEPT contactInfo PROMPT "Enter Contact Number:";

DECLARE
   name         Customer_Info.c_Name%TYPE:='&name';
   contactInfo  Customer_Info.c_Phone%TYPE:='&contactInfo';
   totalCustomer NUMBER;
BEGIN
    Select count(c_ID) into totalCustomer from Customer_Info;
			
    insert into Customer_Info 
	values (totalCustomer+1,name,contactInfo);
  
END;
/

select * from Customer_Info;

COMMIT;