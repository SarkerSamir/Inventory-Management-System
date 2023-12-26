SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;

DROP TABLE Product_Info1 CASCADE CONSTRAINTS;
DROP TABLE Product_Info1;

DROP TABLE Inventory_Info1 CASCADE CONSTRAINTS;
DROP TABLE Inventory_Info1;

DROP TABLE Customer_Info CASCADE CONSTRAINTS;
DROP TABLE Customer_Info;

DROP TABLE Order_Info1 CASCADE CONSTRAINTS;
DROP TABLE Order_Info1;

CREATE TABLE Product_Info1
(
p_ID NUMBER,
p_Name VARCHAR2(15),
p_Price NUMBER,
p_Category VARCHAR2(15),
PRIMARY KEY (p_ID)
);


INSERT INTO Product_Info1 VALUES(1,'Laptop',1200,'non chemical');
INSERT INTO Product_Info1 VALUES(2,'T Shirt',20,'non chemical');
INSERT INTO Product_Info1 VALUES(3,'Headphones',100,'non chemical');
INSERT INTO Product_Info1 VALUES(4,'Jeans',40,'non chemical');
INSERT INTO Product_Info1 VALUES(5,'Smartphone',800,'non chemical');

select * from Product_Info1;

CREATE TABLE Inventory_Info1
(
i_ID NUMBER,
p_ID NUMBER,
i_Loc VARCHAR2(15),
i_Quan NUMBER,
PRIMARY KEY (i_ID),
Foreign Key(p_ID) REFERENCES Product_Info1(p_ID)
);

INSERT INTO Inventory_Info1 VALUES(1, 1, 'Dhaka',10);
INSERT INTO Inventory_Info1 VALUES(2, 2, 'Dhaka',20);
INSERT INTO Inventory_Info1 VALUES(3, 3, 'Dhaka',30);
select * from Inventory_Info1;

CREATE TABLE Customer_Info1
(
c_ID NUMBER,
c_Name VARCHAR2(15),
c_phone VARCHAR2(15),
PRIMARY KEY (c_ID),
CONSTRAINT phone UNIQUE (c_phone)
);

INSERT INTO Customer_Info1 VALUES(1,'X Rahman','01234567894');
INSERT INTO Customer_Info1 VALUES(2,'1 Khan','98745612301');
select * from Customer_Info1;

CREATE TABLE Order_Info1
(
o_ID NUMBER,
i_ID NUMBER,
c_ID NUMBER,
o_DATE DATE,
o_Quan NUMBER,
o_Total NUMBER,
o_DelivLoc VARCHAR2(15),
PRIMARY KEY (o_ID),
Foreign Key(i_ID) REFERENCES Inventory_Info1(i_ID),
Foreign Key(c_ID) REFERENCES Customer_Info1(c_ID)
);

INSERT INTO Order_Info1 VALUES(1,1,1,'08-Jun-2022',1,100,'Dhaka');
INSERT INTO Order_Info1 VALUES(2,2,2,'09-Jun-2022',2,200,'Dhaka');
INSERT INTO Order_Info1 VALUES(3,3,1,'10-Jun-2022',3,300,'Dhaka');
select * from Order_Info1;

commit;


	
show errors;