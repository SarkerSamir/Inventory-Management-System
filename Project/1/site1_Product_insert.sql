SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;

--TRIGGER
create or replace trigger TRIG
after INSERT 
on Product_Info1
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('New Product Added. Triggerred');
END TRIG;
/
--Package
create or replace package insertion 
IS 
procedure insertnewprod(name IN VARCHAR2, taka IN NUMBER, category IN VARCHAR2);
END insertion;
/
--Package body
CREATE OR REPLACE PACKAGE BODY insertion 
IS 
PROCEDURE insertnewprod(name IN VARCHAR2, taka IN NUMBER, category IN VARCHAR2)
  IS
    totalProd NUMBER;
BEGIN
	IF category = 'non chemical' Then
		select count(p_ID) into totalProd from Product_Info1;
			--DBMS_OUTPUT.PUT_LINE(totalProd);
			insert into Product_Info1 
			values (totalProd+1,name,taka,category);
	ELSIF category = 'chemical' Then
		select count(p_ID) into totalProd from Product_Info2@site2;
			insert into Product_Info2@site2
			values (totalProd+1,name,taka,category);
		--write code for insert in site 2
    ELSE
		RAISE_APPLICATION_ERROR(-20001, 'Only category non chemical and chemical can be added.');
	END IF;
	
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20002, 'An error occurred while inserting new product.');
	
	End insertnewprod;
END insertion;
/

--Input
ACCEPT name_ PROMPT "Enter Product Name:";
ACCEPT price_ NUMBER PROMPT "Enter Price:";
ACCEPT category_ PROMPT "Enter Category:"

Declare
name VARCHAR2(30) := '&name_';
taka number:=&price_;
category VARCHAR2(30) := '&category_';

--Main
Begin
--IF category = 'non chemical' THEN
insertion.insertnewprod(name,taka,category);
--ELSE
--RAISE_APPLICATION_ERROR(-20001, 'Only category non chemical can be added.');
--End IF;
End;
/

select * from Product_Info1;
select * from Product_Info2@site2;

commit;
