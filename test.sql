/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/*==============================================================*/


/*==============================================================*/
/* Table: ADMIN                                                 */
/*==============================================================*/
create table ADMIN (
   Ssn                  int                  not null,
   Fname                char(20)             not null,
   Lname                char(20)             not null,
   Bdate                datetime             not null,
   Address              char(50)             not null,
   Gender               bit                  not null,
   Nationality          char(20)             not null,
   Salary               money                not null,
   constraint PK_ADMIN primary key (Ssn)
)
go
/* Queries */
/* Add */
INSERT INTO ADMIN (Ssn, Fname, Lname, Bdate, Address, Gender, Nationality, Salary) 
VALUES (123456789, 'John', 'Doe', '1990-05-20', '123 Main St, Anytown, USA', 1, 'American', 50000.00);
/* Delete */
DELETE FROM ADMIN WHERE Ssn = 123456789;
/* Update */
UPDATE ADMIN 
SET Salary = 60000.00 
WHERE Ssn = 123456789;
/* Select */
SELECT * FROM ADMIN WHERE Ssn = 123456789;

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create table CUSTOMER (
   Ssn                  int                  not null,
   Fname                char(20)             not null,
   Lname                char(20)             not null,
   Bdate                datetime             not null,
   Address              char(50)             not null,
   Gender               bit                  not null,
   Nationality          char(20)             not null,
   constraint PK_CUSTOMER primary key (Ssn)
)
go
/* Queries */
/* Add */
INSERT INTO CUSTOMER (Ssn, Fname, Lname, Bdate, Address, Gender, Nationality)
VALUES(123456789, 'Alice', 'Johnson', '1995-03-10', '789 Oak St, Cityville, USA', 0, 'American');
/*Delete */
DELETE FROM CUSTOMER WHERE Ssn = 123456789;
/* Update */
UPDATE CUSTOMER 
SET Address = '456 Elm St, Othertown, USA' 
WHERE Ssn = 123456789;
/* Select */
SELECT * FROM CUSTOMER WHERE Ssn = 123456789;

/*==============================================================*/
/* Table: DEPENDENT                                             */
/*==============================================================*/
create table DEPENDENT (
   Ssn                  int                  not null,
   Name                 varchar(20)          not null,
   Gender               bit                  not null,
   Bdate                datetime             not null,
   Relationship         varchar(20)          not null,
   constraint PK_DEPENDENT primary key (Ssn, Name)
)
go
ALTER TABLE DEPENDENT
	ADD CONSTRAINT FK_DEPENDENT_CUSTOMER FOREIGN KEY (Ssn) 
		REFERENCES CUSTOMER (Ssn)ON DELETE CASCADE;
/* Queries */
/* Add */
INSERT INTO DEPENDENT (Ssn, Name, Gender, Bdate, Relationship)
VALUES (123456789, 'Emma', 0, '2010-05-15', 'Daughter');
/* Delete */
DELETE FROM DEPENDENT WHERE Ssn = 123456789 AND Name = 'Emma';
/* Update */
UPDATE DEPENDENT 
SET Name = 'Sophia'
WHERE Ssn = 123456789 AND Name = 'Emma';
/* Select */
SELECT * FROM DEPENDENT WHERE Ssn = 123456789;

/*==============================================================*/
/* Table: CREW_MEMBER                                           */
/*==============================================================*/
create table CREW_MEMBER (
   Ssn                  int                  not null,
   Fname                char(20)             not null,
   Lname                char(20)             not null,
   Bdate                datetime             not null,
   Address              char(50)             not null,
   Gender               bit                  not null,
   Nationality          char(20)             not null,
   Salary               money                not null,
   Role                 varchar(20)          not null,
   constraint PK_CREW_MEMBER primary key (Ssn)
)
go
/* Queries */
/* Add */
INSERT INTO CREW_MEMBER (Ssn, Fname, Lname, Bdate, Address, Gender, Nationality, Salary, Role)
VALUES(987654321, 'Jane', 'Smith', '1985-10-15', '456 Elm St, Othertown, USA', 0, 'American', 55000.00, 'Flight Attendant');
/* Delete */
DELETE FROM CREW_MEMBER WHERE Ssn = 987654321;
/* Update */
UPDATE CREW_MEMBER 
SET Salary = 60000.00 
WHERE Ssn = 987654321;
/* Select */
SELECT * FROM CREW_MEMBER WHERE Ssn = 987654321;

/*==============================================================*/
/* Table: AIRPLANE                                              */
/*==============================================================*/
create table AIRPLANE (
   Serial               int                  not null,
   Model                varchar(20)          not null,
   Capacity             int                  not null,
   constraint PK_AIRPLANE primary key (Serial)
)
go
/* Queries */
/* Add */
INSERT INTO AIRPLANE (Serial, Model, Capacity)
VALUES(123456, 'Boeing 737', 150);
/* Delete */
DELETE FROM AIRPLANE WHERE Serial = 123456;
/* Update */
UPDATE AIRPLANE 
SET Capacity = 200 
WHERE Serial = 123456;
/* Select */
SELECT * FROM AIRPLANE WHERE Serial = 123456;

/*==============================================================*/
/* Table: FLIGHT                                                */
/*==============================================================*/
create table FLIGHT (
   Flight_number        int                  not null,
   Serial               int                  not null,
   Departure_date       datetime             not null,
   Arrival_date         datetime             not null,
   Source               varchar(20)          not null,
   Destination          varchar(20)          not null,
   Required_num_of_seats int                  not null,
   constraint PK_FLIGHT primary key (Flight_number)
)
go
ALTER TABLE FLIGHT
	ADD CONSTRAINT FK_DEPENDENT FOREIGN KEY (Serial) 
		REFERENCES AIRPLANE (Serial)ON DELETE CASCADE;
go
/* Queries */
/* Add */
INSERT INTO FLIGHT (Flight_number, Serial, Departure_date, Arrival_date, Source, Destination, Required_num_of_seats)
VALUES(1001, 123456, '2024-05-15 08:00:00', '2024-05-15 10:00:00', 'New York', 'Los Angeles', 120);
/* Delete */
DELETE FROM FLIGHT WHERE Flight_number = 1001;
/* Update */
UPDATE FLIGHT 
SET Required_num_of_seats = 150 
WHERE Flight_number = 1001;
/* Select */
SELECT * FROM FLIGHT WHERE Flight_number = 1001;

/*==============================================================*/
/* Table: MANAGE_A                                              */
/*==============================================================*/
create table MANAGE_A (
   Ssn                  int                  not null,
   Flight_number        int                  not null,
   constraint PK_MANAGE_A primary key (Ssn, Flight_number)
)
go

ALTER TABLE MANAGE_A
   ADD CONSTRAINT FK_MANAGE_A_MANAGE_A_CREW_MEM FOREIGN KEY (Ssn)
      REFERENCES CREW_MEMBER (Ssn)ON DELETE CASCADE
go
ALTER TABLE MANAGE_A
   ADD CONSTRAINT FK_MANAGE_A_MANAGE_A2_FLIGHT FOREIGN KEY (Flight_number)
      REFERENCES FLIGHT (Flight_number)ON DELETE CASCADE
go
/* Queries */
/* Add */
INSERT INTO MANAGE_A (Ssn, Flight_number)
VALUES(987654321, 1001);
/* Delete */
DELETE FROM MANAGE_A WHERE Ssn = 987654321 AND Flight_number = 1001;
/* Update */
UPDATE MANAGE_A 
SET Flight_number = 1002 
WHERE Ssn = 987654321 AND Flight_number = 1001;
/* Select */
SELECT * FROM MANAGE_A WHERE  Ssn = 987654321 AND Flight_number = 1001;

/*==============================================================*/
/* Table: RESERVE                                               */
/*==============================================================*/
create table RESERVE (
   Ssn                  int                  not null,
   Flight_number        int                  not null,
   Price                char(10)             not null,
   Num_of_seat          char(10)             not null,
   constraint PK_RESERVE primary key (Ssn, Flight_number)
)
go
ALTER TABLE RESERVE
   ADD CONSTRAINT FK_RESERVE_RESERVE_CUSTOMER FOREIGN KEY (Ssn)
      REFERENCES CUSTOMER (Ssn)ON DELETE CASCADE
go

ALTER TABLE RESERVE
   ADD CONSTRAINT FK_RESERVE_RESERVE2_FLIGHT FOREIGN KEY (Flight_number)
      REFERENCES FLIGHT (Flight_number)ON DELETE CASCADE
go
/* Queries */
/* Add */
INSERT INTO RESERVE (Ssn, Flight_number, Price, Num_of_seat)
VALUES(123456789, 1001, '200.00', '1');
/* Delete */
DELETE FROM RESERVE WHERE Ssn = 123456789 AND Flight_number = 1001;
/* Update */
UPDATE RESERVE 
SET Num_of_seat = '2' 
WHERE Ssn = 123456789 AND Flight_number = 1001;
/* Select */
SELECT * FROM RESERVE WHERE  Ssn = 123456789 AND Flight_number = 1001;

/*=======================Join=======================*/
SELECT CUSTOMER.Fname, DEPENDENT.Name
FROM CUSTOMER, DEPENDENT
WHERE CUSTOMER.Ssn = DEPENDENT.Ssn

SELECT CUSTOMER.Fname, DEPENDENT.Name
FROM CUSTOMER FULL OUTER JOIN DEPENDENT
ON CUSTOMER.Ssn = DEPENDENT.Ssn

SELECT FLIGHT.Flight_number, AIRPLANE.Serial
FROM FLIGHT, AIRPLANE
WHERE FLIGHT.Serial = AIRPLANE.Serial

SELECT FLIGHT.Flight_number, AIRPLANE.Serial
FROM FLIGHT FULL OUTER JOIN AIRPLANE
ON FLIGHT.Serial = AIRPLANE.Serial