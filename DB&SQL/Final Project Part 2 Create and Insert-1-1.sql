/* CREATE STATEMENT FOR 20 TABLES  */

CREATE TABLE EEOCCODE (
    EEOCCODE INT NOT NULL,
    EEOCDESCRIPTION VARCHAR(60) NOT NULL,
    CONSTRAINT EEOC_PK PRIMARY KEY(EEOCCODE)
);

CREATE TABLE EMPLOYEE(
    EmployeeID INT NOT NULL,
    SSN CHAR(10) NOT NULL,
    LastName CHAR(25) NOT NULL,
    MiddleInitial CHAR(1)  NULL,
    FirstName CHAR(25) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Age SMALLINT NOT NULL,
    Gender CHAR(10) NOT NULL,
    MaritalStatus CHAR(10) NOT NULL,
    EeocCode INT,
    Contact CHAR(12) NULL,
    IsUnionTrade CHAR(3) NULL,
    Designation CHAR(10) NOT NULL,
    Minority CHAR(10) NOT NULL,
    Address1 VARCHAR(20) NOT NULL,
    Address2 VARCHAR(20) NOT NULL,
    City VARCHAR(20) NOT NULL,
    State VARCHAR(20) NOT NULL,
    ZipCode CHAR(10) NOT NULL,
    CONSTRAINT EMPLOYEE_PK PRIMARY KEY(EmployeeID),
    CONSTRAINT EEOC_FK FOREIGN KEY(EeocCode)
                    REFERENCES EEOCCODE(EeocCode)
);
   
CREATE TABLE CLIENT(
    ClientID INT NOT NULL,
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(25) NOT NULL,
    ClientLocation VARCHAR(50) NOT NULL,
    Contact CHAR(12) NULL,
    CONSTRAINT Client_PK PRIMARY KEY(ClientID)
);


CREATE TABLE THEBOOK(
    ProjectBookID INT NOT NULL,
    BookYear INT NOT NULL,
    BookMonth VARCHAR(15) NOT NULL,
    ProjectName VARCHAR(20) NOT NULL,
    ExpectedStartDate DATE NOT NULL,
    ExpectedEndDate DATE NOT NULL,
    BookLocation VARCHAR(20),
    CONSTRAINT PK_BOOK PRIMARY KEY(ProjectBookID)
);   
 
                           
CREATE TABLE CONSTRUCTIONPLAN(
    PlanID INT NOT NULL,
    Description VARCHAR(50) NOT NULL,
    ProjectBooKID INT NOT NULL,
    CONSTRAINT Plan_PK PRIMARY KEY(PlanID),
    CONSTRAINT ProjectBook_FK FOREIGN KEY(ProjectBooKID)
                                REFERENCES THEBOOK(ProjectBookID)
);

CREATE TABLE SITE (
    SiteID INT NOT NULL,
    Address1 VARCHAR(50) NOT NULL,
    Address2 VARCHAR (50) NULL,
    City VARCHAR(20) NOT NULL,
    State VARCHAR(20) NOT NULL,
    ZipCode CHAR(10) NOT NULL,
    County VARCHAR(20) NOT NULL,
    CONSTRAINT SITE_PK PRIMARY KEY(SiteID)
);

CREATE TABLE BID (
    BidId INT NOT NULL,
    Review_Bob VARCHAR(3),
    Review_Patrick VARCHAR(3),
    Review_Frank VARCHAR(3),
    Site_Visitor VARCHAR(30),
    Proposed_Budget VARCHAR(30),
    Proposed_Start_Date DATE,
    Proposed_End_Date Date,
    Status VARCHAR(30),
    PlanID INT NOT NULL,
    CONSTRAINT BidID_PK PRIMARY KEY(BidID),
    CONSTRAINT PlanID_FK FOREIGN KEY(PlanID)
                        REFERENCES CONSTRUCTIONPLAN(PlanID)
);


CREATE TABLE PROJECT(
    ProjectID INT NOT NULL,
    ProjectType CHAR(10) NOT NULL,
    Classification CHAR(10) NOT NULL,
    Supervisor VARCHAR(25) NOT NULL,
    Inspector VARCHAR(25) NULL,
    ClientID INT NOT NULL, --ADDED
    Status CHAR(20) NULL,
    Description VARCHAR(200) NULL,
    ProjectName VARCHAR(20) NOT NULL,
    TotalBudget INT NOT NULL,
    BidID INT NULL,
    SiteID INT NOT NULL,    
    CONSTRAINT PROJECT_PK PRIMARY KEY(ProjectID),
    CONSTRAINT PROJECT_CLIENT_FK  FOREIGN KEY (ClientID)
REFERENCES CLIENT(ClientID),
    CONSTRAINT PROJECT_BID_FK  FOREIGN KEY (BidID)
REFERENCES BID(BidID),
    CONSTRAINT PROJECT_SITE_FK  FOREIGN KEY (SiteID)
REFERENCES SITE(SiteID)
);   

   
CREATE TABLE SKILLS(
    SkillID INT NOT NULL,
    SkillCode CHAR(5) NOT NULL,
    JobType CHAR(20) NOT NULL,
    SkillName CHAR(20) NOT NULL,
    Rate INT NOT NULL,
    PlanID INT NULL,
    CONSTRAINT SKILL_PK PRIMARY KEY(SkillID),
    CONSTRAINT SKILL_PLAN_FK  FOREIGN KEY (PlanID)
REFERENCES CONSTRUCTIONPLAN(PlanID)
);


CREATE TABLE EMPLOYEE_ENROLLMENT(
    EnrollmentID INT NOT NULL,
    EmployeeID INT NOT NULL,
    ProjectType CHAR(10) NOT NULL,
    EnrollmentDate DATE NOT NULL,
    RegularHours INT NOT NULL,
    OvertimeHours INT NOT NULL,
    ProjectID INT NOT NULL,
    SkillID INT NOT NULL,
    CONSTRAINT ENROLLMENT_PK PRIMARY KEY(EnrollmentID),
    CONSTRAINT EMPLOYEE_FK FOREIGN KEY(EmployeeID)
REFERENCES EMPLOYEE(EmployeeID),
    CONSTRAINT PROJECT_FK FOREIGN KEY(ProjectID)
REFERENCES PROJECT(ProjectID),
    CONSTRAINT SKILL_FK FOREIGN KEY(SkillID)
REFERENCES SKILLS(SkillID)
);
      

CREATE TABLE SUPPLIER (
    SupplierID INT NOT NULL,
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(25) NOT NULL,
    Contact CHAR(12) NOT NULL,
    Address1 VARCHAR(20) NOT NULL,
    Address2 VARCHAR(20) NOT NULL,
    City VARCHAR(20) NOT NULL,
    SupplierState VARCHAR(20) NOT NULL,
    ZipCode CHAR(10) NOT NULL,
    CONSTRAINT PK_SUPPLIER PRIMARY KEY(SupplierID)
);

CREATE TABLE SUPPLIES (
    ItemID INT NOT NULL,
    LineItem CHAR(20) NOT NULL,
    Quantity INT NOT NULL,
    UnitCost INT NOT NULL,
    SupplierID INT NOT NULL,
    BidID INT NULL,
    CONSTRAINT PK_SUPPLIES PRIMARY KEY(ItemID),
    CONSTRAINT FK_SUPPLIER FOREIGN KEY(SupplierID)
                           REFERENCES SUPPLIER(SupplierID),
    CONSTRAINT FK_BID      FOREIGN KEY(BidID)
                           REFERENCES BID(BidID)
);
                           

CREATE TABLE SUPPLIER_QUOTATION (
    QuotationID INT NOT NULL,
    QuotationAmount INT NOT NULL,
    BidID INT NOT NULL,
    SupplierID INT NOT NULL,
    Dt DATE NOT NULL,
    LineItem CHAR(20) NOT NULL,
    CONSTRAINT PK_QUOTATION PRIMARY KEY(QuotationID),
    CONSTRAINT FK_QBID      FOREIGN KEY(BidID)
                            REFERENCES BID(BidID),
    CONSTRAINT FK_QSUPPLIER FOREIGN KEY(SupplierID)
                            REFERENCES SUPPLIER(SupplierID)
);

CREATE TABLE PROJECT_PAYMENT(
    PaymentID INT NOT NULL,
    Stage VARCHAR(25) NOT NULL,
    AmountReceived INT NOT NULL,
    ProjectDate DATE NOT NULL,
    ProjectID INT NOT NULL,
    CONSTRAINT Payment_PK PRIMARY KEY(PaymentID),
    CONSTRAINT FK_PROJECT_PAYMENT FOREIGN KEY(ProjectID)
                            REFERENCES PROJECT(ProjectID)
);


CREATE TABLE INVENTORY(
    ObjectID INT NOT NULL,
    ObjectType VARCHAR(10) NOT NULL,
    Status VARCHAR(5) NOT NULL,
    Quantity INT NULL,
    ObjectInspectionDate DATE NOT NULL,
    MaintenanceDate DATE NULL,
    ObjectInspector VARCHAR(50) NULL,
    CONSTRAINT Object_PK PRIMARY KEY(ObjectID)
);

CREATE TABLE TRANSFER(
    TransferID INT NOT NULL,
    TransferDate DATE NOT NULL,
    DepatureTime DATE NOT NULL,
    ArrivalTime DATE NOT NULL,
    DepatureLocation VARCHAR(20) NOT NULL,
    Damage CHAR(5) NOT NULL,
    DamageDescription VARCHAR(50) NULL,
    ObjectType VARCHAR(10) NOT NULL,
    ObjectID INT NOT NULL,
    CONSTRAINT Transfer_PK PRIMARY KEY(TransferID),
    CONSTRAINT Object_FK FOREIGN KEY(ObjectID)
                        REFERENCES INVENTORY(ObjectID)
);


CREATE TABLE PROJECT_EQUIPMENT (
    EquipmentID INT NOT NULL,
    ProjectID INT NULL,
    EquipmentType VARCHAR(30),
    IsRented VARCHAR(3),
    EquipmentOwner VARCHAR(30),
    EquipmentDate DATE,
    ObjectID INT NOT NULL,
    SiteID INT NULL,
    CONSTRAINT EquipmenID_PK PRIMARY KEY(EquipmentID),
    CONSTRAINT ProjectID_FK FOREIGN KEY(ProjectID)
                            REFERENCES PROJECT(ProjectID),
    CONSTRAINT ObjectID_FK FOREIGN KEY(ObjectID)
                            REFERENCES INVENTORY(ObjectID),
    CONSTRAINT SiteID_FK FOREIGN KEY(SiteID)
                            REFERENCES SITE(SiteID)
);

CREATE TABLE RENTALS (
    RentalID INT NOT NULL,
    RentalName varchar(30),
    Contact VARCHAR(12),
    Address1 VARCHAR(20),
    Address2 VARCHAR(20),
    City VARCHAR(20),
    State VARCHAR(20),
    ZipCode VARCHAR(10),
    CONSTRAINT RentalID_PK PRIMARY KEY(RentalID)
);


CREATE TABLE RENTAL_EQUIPMENT (
    EquipmentID INT NOT NULL,
    RentalID INT NOT NULL,
    DailyRate INT NOT NULL,
    PickupDate DATE,
    ReturnDate DATE,
    CONSTRAINT EquipmentID_FK FOREIGN KEY (EquipmentID)
                            REFERENCES PROJECT_EQUIPMENT (EquipmentID),
    CONSTRAINT RentalID_FK FOREIGN KEY (RentalID)
                            REFERENCES RENTALS(RentalID),
    CONSTRAINT EquipmentID_PK PRIMARY KEY (EquipmentID, RentalID)
);

CREATE TABLE EQUIPMENT_TRANSFER (
    TransferID INT NOT NULL,
    EquipmentID INT NOT NULL,
    DepartureTime TIMESTAMP,
    ArrivalTime TIMESTAMP,
    DepartureLocation VARCHAR(20),
    ArrivalLocation VARCHAR(20),
    CONSTRAINT EqTransferID_FK FOREIGN KEY(TransferID)
                             REFERENCES TRANSFER(TransferID),
    CONSTRAINT TransEquipmentID_FK FOREIGN KEY(EquipmentID)
                             REFERENCES PROJECT_EQUIPMENT(EquipmentID),
    CONSTRAINT EqTransfer_PK PRIMARY KEY (TransferID, EquipmentID)
);



/* INSEERT STATEMENTS */

-- THEBOOK
INSERT INTO THEBOOK VALUES(1,2018,'MARCH','Project1','25-DEC-2018','25-DEC-2019','EDINA');
INSERT INTO THEBOOK VALUES(2,2018,'MARCH','Project2','25-DEC-2018','25-DEC-2019','EDINA');

-- CONSTRUCTION PLAN
INSERT INTO CONSTRUCTIONPLAN VALUES(1,'Construction plan for PLAN ID 1',1);
INSERT INTO CONSTRUCTIONPLAN VALUES(2,'Construction plan for PLAN ID 2',2);

--BID
INSERT INTO BID VALUES(1,'Yes','Yes','Yes','Jack','100,000,000','25-DEC-2018','25-DEC-2019','Completed',1);
INSERT INTO BID VALUES(2,'Yes','Yes','Yes','Jack','100,000,000','25-DEC-2018','25-DEC-2019','Completed',2);

 --CREATE PLAN TABLE FIRST AND INSERT DATA FOR PLAN ID AS 1
INSERT INTO SKILLS VALUES(1,'LAB','Pike','Labor',15,1);
INSERT INTO SKILLS VALUES(2,'MAS','Pike','Masonry',17,1);
INSERT INTO SKILLS VALUES(3,'EQP','Ross','Equipment Operation',20,1);
INSERT INTO SKILLS VALUES(4,'CAR','Labor','Carpentry',16,1);
INSERT INTO SKILLS VALUES(5,'IRN','Labor','Iron Work',17,1);
INSERT INTO SKILLS VALUES(6,'LAB','Scioto','Labor',15,2);--
INSERT INTO SKILLS VALUES(7,'GEL','Lawerence','General Labor',15,2);--
INSERT INTO SKILLS VALUES(8,'LAB','Ross','Labor',15,2);--
INSERT INTO SKILLS VALUES(9,'EQP','Scioto','Equipment Operation',20,2);--

INSERT INTO EEOCCODE VALUES(1,'Black not of Hispanic Origin');
INSERT INTO EEOCCODE VALUES(2,'Hispanic');
INSERT INTO EEOCCODE VALUES(3,'Asian/Pacific Islander');
INSERT INTO EEOCCODE VALUES(4,'American Indian or Alaskan Native');
INSERT INTO EEOCCODE VALUES(5,'Non-Minority (White)');

/* EMPLOYEE TABLE */
INSERT INTO EMPLOYEE VALUES(390054489,'390054489', 'Worker','E', 'James', '16-NOV-83', 37, 'Male', 'Married', 2,'6528552321', 'Yes', 'Laborer', 'Yes', '1253',
 'Chopping Block Lane', 'Knockemstiff', 'Indiana', '80286');
--MARY HENDERSON DATA
INSERT INTO EMPLOYEE VALUES(313578689,'313578689', 'Henderson','I', 'Mary', '23-May-92', 28, 'Female', 'Married',5,'6145550386', 'No', 'Accountant', 'No', '4000 prk',
 'addr2', 'Edina', 'Minnesota', '55435');
 --Minority female-male
INSERT INTO EMPLOYEE VALUES(391054489,'391054489', 'Pawar','I', 'Jayashree', '20-May-92', 28, 'Female', 'Married',1, '6124537788', 'Yes', 'Laborer', 'Yes', '4110 parklawan Ave',
 'Apt102', 'Edina', 'Minnesota', '55435');
INSERT INTO EMPLOYEE VALUES(275506921,'275506921', 'Pawan','I', 'Kumar', '10-June-92', 28, 'Male', 'Married',2, '6120001122', 'Yes', 'Laborer', 'Yes', '4000 Cedars',
 'Apt 111', 'Edina', 'Minnesota', '55435');
  --Non Minority male-female
 INSERT INTO EMPLOYEE VALUES(450054489,'450054489', 'Mohan','I', 'Kapil', '11-Apr-80', 40, 'Male', 'Married', 5,'6124536688', 'Yes', 'Laborer', 'No', '5000 Garmen Ave',
 'Apt202', 'Edina', 'Minnesota', '55435');
INSERT INTO EMPLOYEE VALUES(372206925,'372206925', 'Mohan','I', 'Meenakshi', '21-Dec-80', 40, 'Female', 'Married',5, '6120002222', 'Yes', 'Laborer', 'No', '2000 Colony',
 'Apt 311', 'Edina', 'Minnesota', '55435');
  --Minority female-male
 INSERT INTO EMPLOYEE VALUES(990054489,'990054489', 'Shah','I', 'Priya', '21-May-92', 28, 'Female', 'Married',3, '6124531223', 'Yes', 'Laborer', 'Yes', '5110 Premium Ave',
 'Apt102', 'Edina', 'Minnesota', '55435');
INSERT INTO EMPLOYEE VALUES(675506921,'675506921', 'Shah','I', 'Vinit', '12-June-92', 28, 'Male', 'Married', 4,'6120006789', 'Yes', 'Laborer', 'Yes', '5000 oldCedars',
 'Apt 111', 'Edina', 'Minnesota', '55435');
   --Non Minority female-male
INSERT INTO EMPLOYEE VALUES(781154489,'781154489', 'Rochwani','I', 'Reshma', '24-May-92', 28, 'Female', 'Married', 5,'6124537799', 'Yes', 'Laborer', 'No', '2110 Colony',
 'Apt202', 'Edina', 'Minnesota', '55435');
INSERT INTO EMPLOYEE VALUES(123406921,'123406921', 'Rochwani','I', 'Amit', '23-June-92', 28, 'Male', 'Married',5, '6120001111', 'Yes', 'Laborer', 'No', '3000 Concerige',
 'Apt 411', 'Edina', 'Minnesota', '55435');

--INDEPENDENT TABLE, DO INSERT THIS VALUES
INSERT INTO SITE VALUES (123, '5 miles south of Beaver', ' Indiana on SR 335', 'Petersburg', 'Indiana', '47567','Pike');
INSERT INTO SITE VALUES (456, 'Anderson road', ' Indiana on SR 440', 'Petersburg', 'Indiana', '47567','Pike');

--CLIENT TABLE
INSERT INTO CLIENT VALUES(1,'Amber','Jones','Rosewood','232-454-6677');
INSERT INTO CLIENT VALUES(2,'Amber','Richard','Bass','244-654-8698');

--CREATE CLIENT AND BID TABLE AS CLINET ID AS 1,2. BID ID AS 1,2
INSERT INTO PROJECT VALUES(335005,'State','Govt', 'Patrick', 'John Snow',1,'In Progess', 'Replacement of single-span two-lane bridge (pre-stressed beam type)', 'IN-PIK-335-005','50000000',1,123);
INSERT INTO PROJECT VALUES(213005,'State','Govt', 'Bob', 'John Snow',2, 'In Progess', 'New Bridge work', 'IN-PIK-123-005','2000000000',2,456);

--REGULAR HOURS
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(1,391054489,'State','1-Dec-19',5,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(2,391054489,'State','2-Dec-19',5,0,335005,2);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(3,391054489,'State','3-Dec-19',5,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(4,391054489,'State','4-Dec-19',5,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(5,391054489,'State','5-Dec-19',5,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(6,391054489,'State','6-Dec-19',5,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(7,391054489,'State','16-Dec-19',5,0,213005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(8,391054489,'State','15-Dec-19',5,0,335005,1);
/* OVERTIME */
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(9,275506921,'State','6-Dec-19',5,3,335005,3);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(10,275506921,'State','16-Dec-19',5,0,213005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(11,275506921,'State','15-Dec-19',5,0,213005,2);
/* MINORITY MALE */
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(13,275506921,'State','1-Nov-19',13,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(14,675506921,'State','12-Nov-19',10,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(15,275506921,'State','6-Nov-19',3,0,335005,4);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(16,675506921,'State','11-Nov-19',5,0,335005,2);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(17,275506921,'State','13-Nov-19',3,0,335005,5);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(18,675506921,'State','10-Nov-19',2,0,335005,3);
/* MINORITY FEMALE */
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(19,391054489,'State','1-Nov-19',6,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(20,990054489,'State','13-Nov-19',6,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(21,391054489,'State','6-Nov-19',5,0,335005,4);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(22,990054489,'State','11-Nov-19',2,0,335005,2);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(23,990054489,'State','11-Nov-19',2,0,335005,5);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(24,990054489,'State','11-Nov-19',2,0,335005,3);
/* NON MINORITY MALE */
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(25,450054489,'State','12-Nov-19',15,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(26,123406921,'State','12-Nov-19',18,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(27,450054489,'State','6-Nov-19',10,0,335005,4);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(28,123406921,'State','6-Nov-19',12,0,335005,4);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(29,450054489,'State','11-Nov-19',8,0,335005,2);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(30,123406921,'State','12-Nov-19',8,0,335005,2);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(31,450054489,'State','13-Nov-19',12,0,335005,5);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(32,123406921,'State','10-Nov-19',12,0,335005,5);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(33,450054489,'State','11-Nov-19',10,0,335005,3);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(34,123406921,'State','12-Nov-19',13,0,335005,3);

INSERT INTO EMPLOYEE_ENROLLMENT VALUES(40,390054489,'State','9-Oct-18',25,0,213005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(41,390054489,'State','10-Oct-18',5,0,213005,2);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(42,390054489,'State','11-Oct-18',5,0,213005,8);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(43,390054489,'State','12-Oct-18',3,0,213005,6);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(44,390054489,'State','13-Oct-18',2,0,213005,9);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(45,390054489,'State','12-Oct-18',0,1,213005,7);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(46,390054489,'State','12-Oct-18',0,1,213005,9);

/* NON MINORITY FEMALE */
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(35,372206925,'State','14-Nov-19',6,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(36,781154489,'State','11-Nov-19',6,0,335005,1);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(37,372206925,'State','6-Nov-19',5,0,335005,4);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(38,781154489,'State','13-Nov-19',2,0,335005,2);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(39,372206925,'State','11-Nov-19',2,0,335005,5);
INSERT INTO EMPLOYEE_ENROLLMENT VALUES(12,781154489,'State','10-Nov-19',2,0,335005,3);

