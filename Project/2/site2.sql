SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;

DROP TABLE Product_Info2 CASCADE CONSTRAINTS;
DROP TABLE Product_Info2;

DROP TABLE Inventory_Info2 CASCADE CONSTRAINTS;
DROP TABLE Inventory_Info2;

--DROP TABLE Order_Info2 CASCADE CONSTRAINTS;
--DROP TABLE Order_Info2;

CREATE TABLE Product_Info2
(
p_ID NUMBER,
p_Name VARCHAR2(15),
p_Price NUMBER,
p_Category VARCHAR2(15),
PRIMARY KEY (p_ID)
);

INSERT INTO Product_Info2 VALUES(1, 'Television', 2000, 'non-chemical');
INSERT INTO Product_Info2 VALUES(2, 'Shirt', 1000, 'non-chemical');



select * from Product_Info2;

CREATE TABLE Inventory_Info2
(
i_ID NUMBER,
p_ID NUMBER,
i_Loc VARCHAR2(15),
i_Quan NUMBER,
PRIMARY KEY (i_ID),
Foreign Key(p_ID) REFERENCES Product_Info2(p_ID)
);

INSERT INTO Inventory_Info2 VALUES(1, 1, 'Dhaka',2);
select * from Inventory_Info2;

commit;


Declare
totalPrd number;
name VARCHAR2(15);
taka number;
category VARCHAR2(15);
Begin
select count(p_ID) into totalPrd from Product_Info1@site1;
DBMS_OUTPUT.PUT_LINE(totalPrd);
insert into Product_Info1@site1 
values (totalPrd+1,'Bags',500,'no-chemical');
DBMS_OUTPUT.PUT_LINE('Inserted in Site1');

End;
/

commit;

/*
CREATE TABLE Order_Info2
(
o_ID NUMBER,
i_ID NUMBER,
c_ID NUMBER,
o_DATE DATE,
o_Quan NUMBER,
o_Total NUMBER,
o_DelivLoc VARCHAR2(15),
PRIMARY KEY (o_ID),
Foreign Key(i_ID) REFERENCES Inventory_Info2(i_ID),
Foreign Key(c_ID) REFERENCES Customer_Info1@site1(c_ID)
);

INSERT INTO Order_Info2 VALUES(1,1,1,'08-jun-2022',1,2000,'Dhaka');
select * from Order_Info2;
*/


