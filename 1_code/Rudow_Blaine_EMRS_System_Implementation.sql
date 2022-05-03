/*
Blaine Rudow 
Final Project: EMRS database
System Implementation
4/18/22
*/
/*
DROP TABLE MEDICAL_HISTORY;
DROP TABLE TREATMENTS;
DROP TABLE LABS_CHARTS;
DROP TABLE PROVIDER;
DROP TABLE PRACTICE;
DROP TABLE PATIENT;
DROP TABLE ADMINISTRATOR;
DROP TABLE MEDICATIONS;
DROP TABLE INSURANCE;
DROP TABLE BILLING_SPECIALIST;
*/

CREATE TABLE PRACTICE(
	PracticeID Number(10) PRIMARY KEY,
	PracticeName Varchar2(50),
	PracticeAddress Varchar2(100),
	PracticePhone Varchar2(15),
	PracticeEmail Varchar2(100),
	AdminID Number(10) --FK FROM ADMINISTRATOR (AdministratorID) DONE
);   

CREATE TABLE PATIENT(
	PatientID Number(10) PRIMARY KEY,
	PatientFirstName VarChar2(25),
	PatientLastName VarChar2(25),
	PatientDOB Date ,
    PatientAddress VarChar2(250),
	PatientGender VarChar2(1),
	PatientRace VarChar2(25),
	PatientPhoneNumber VarChar2(25),
	PatientEmail Varchar2(100),
	PatientInsurance NUMBER(10) --FK from INSURANCE(InsurID) DONE
);

CREATE TABLE PROVIDER(
	ProviderID Number(10) PRIMARY KEY,
	ProviderTitle Varchar2(50),
	ProviderFirstName Varchar2(50),
	ProviderLastName Varchar2(50),
	ProviderSpecialty Varchar2(100),
	ProviderAddress Varchar(100),
	ProviderPhoneNumber Varchar(15),
	ProviderEmail Varchar(100),
	ProviderSalary Number(10),
	ProviderDegree Varchar(100),
	ProviderLicenseNum NUMBER(15),
	ProviderPractice NUMBER(10) --FK from PRACTICE DONE
);

CREATE TABLE ADMINISTRATOR(
	AdministratorID Number(10) PRIMARY KEY,
	AdministratorTitle Varchar2(50),
	AdministratorFirstName Varchar2(50),
	AdministratorLastName Varchar2(50),
	AdministratorAddress Varchar2(100),
	AdministratorPhoneNumber Varchar2(15),
	AdministratorEmail Varchar2(100),
	AdministratorSalary Number(10),
	AdministratorDegree Varchar2(100)
);

CREATE TABLE MEDICATIONS(
	MedID Number(10) PRIMARY KEY,
	MedName Varchar2(50),
	MedRate Varchar2(100),
	MedPurpose  Varchar2(3500),
	MedDose Varchar2(50),
	MedManufacturer Varchar2(50),
	MedInteractionProblem Varchar2(3500)
);

CREATE TABLE TREATMENTS(
	TreatID Number(10) PRIMARY KEY,
	TreatName Varchar2(100),
	TreatReason Varchar2(1000),
	TreatNotes Varchar2(1000),
	TreatPhysician Number(10) --FK from PROVIDER DONE
); 

CREATE TABLE INSURANCE(
	InsurID Number(10) PRIMARY KEY,
	InsurName Varchar2(50),
	InsurAddress Varchar2(100),
	InsurPhone Varchar2(15),
	InsurPlanName Varchar2(50),
	InsurNotes Varchar2(1000),
	BillingSpecID Number(10) --FK FROM BILLING_SPECIALIST(BillSpecID)
);

CREATE TABLE LABS_CHARTS(
LabChartID Number(12) PRIMARY KEY,
LabName Varchar2(50),
LabDate Date,
LabReturnDate Date,
LabReason Varchar2(1000),
LabByProv Number(10), --FK from PROVIDER DONE
Patient Number(10) --FK from PATIENT DONE 
);

CREATE TABLE BILLING_SPECIALIST(
BillSpecID Number(10) PRIMARY KEY, 
BillSpecFirstName Varchar2(25),
BillSpecLastName Varchar2(25),
BillSpecAddress Varchar2(100),
BillSpecPhoneNumber Varchar2(15),
BillSpecEmail Varchar2(50),
BillSpecSalary Number(8)
);

CREATE TABLE MEDICAL_HISTORY(
MedHistID Number(10) PRIMARY KEY, 
PatientID Number(10), --FK from PATIENT DONE
TreatmentID Number(10), --FK from TREATMENTS DONE
MedicationID Number(10), --FK from MEDICATIONS DONE
DiagnosingProvider Number(10), --FK from PROVIDER DONE
LabChartID Number(12)
);  

--ALTER TABLE FOREIGN KEY STATEMENTS
ALTER TABLE PRACTICE 
ADD FOREIGN KEY (AdminID) REFERENCES ADMINISTRATOR (AdministratorID);

ALTER TABLE PATIENT 
ADD FOREIGN KEY (PatientInsurance) REFERENCES INSURANCE (InsurID);

ALTER TABLE PROVIDER 
ADD FOREIGN KEY (ProviderPractice) REFERENCES PRACTICE (PracticeID);

ALTER TABLE TREATMENTS 
ADD FOREIGN KEY (TreatPhysician) REFERENCES PROVIDER (ProviderID);

ALTER TABLE LABS_CHARTS 
ADD FOREIGN KEY (LabByProv) REFERENCES PROVIDER (ProviderID);
ALTER TABLE LABS_CHARTS 
ADD FOREIGN KEY (Patient) REFERENCES PATIENT (PatientID);

ALTER TABLE MEDICAL_HISTORY 
ADD FOREIGN KEY (DiagnosingProvider) REFERENCES PROVIDER (ProviderID);
ALTER TABLE MEDICAL_HISTORY 
ADD FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID);
ALTER TABLE MEDICAL_HISTORY 
ADD FOREIGN KEY (TreatmentID) REFERENCES TREATMENTS (TreatID);
ALTER TABLE MEDICAL_HISTORY 
ADD FOREIGN KEY (MedicationID) REFERENCES MEDICATIONS (MedID);
ALTER TABLE MEDICAL_HISTORY 
ADD FOREIGN KEY (LabChartID) REFERENCES LABS_CHARTS (LabChartID);

ALTER TABLE INSURANCE 
ADD FOREIGN KEY (BillingSpecID) REFERENCES BILLING_SPECIALIST (BillSpecID);
-- END FOREIGN KEY ADDITIONS

-- INSERT DATA INTO EACH TABLE 
--BILLING_SPECIALIST
INSERT INTO BILLING_SPECIALIST VALUES (3154694265, 'WILLIAM',
     'VEGA','334 EASY ST','555-846-6645','VEGA@GMAIL.COM',25000);
INSERT INTO BILLING_SPECIALIST VALUES (1789456542, 'LOUISE',
     'MILLER','854 HARGROVE WAY','555-365-7789','MILLER@GMAIL.COM',23550);
INSERT INTO BILLING_SPECIALIST VALUES (3155489113, 'DAISY',
     'FARGO','774 SUNDANCE CT','555-971-7798','FARGO@GMAIL.COM',27985);
INSERT INTO BILLING_SPECIALIST VALUES (8945661231, 'ALICE',
     'LAMONT','003 E MAIN ST','555-333-5514','LAMONT@GMAIL.COM',30000);
INSERT INTO BILLING_SPECIALIST VALUES (3157123654, 'LATRICIA',
     'JONES','469 LAKESHORE DR','555-521-4478','JONES@GMAIL.COM',25878);

--INSURANCE
INSERT INTO INSURANCE VALUES (3145513698, 'BLUE CROSS BLUE SHIELD',
     'PO BOX 55, GREEN ST, SUNDANCE CALIFORNIA','555-445-8899','FULL COVERAGE',
     'PRIVATE INSURER, FULL PROCEDURES',1789456542);
INSERT INTO INSURANCE VALUES (1451236984, 'MEDICARE',
     'PO BOX 1,4471 HILL AVE, DENVER, CO','555-112-6545','SPECIAL COVERAGE',
     'GOVERNMENT COVERED',8945661231);
INSERT INTO INSURANCE VALUES (5516987456, 'MEDICAID',
     '8896 LUCKY CT, CHICAGO, IL','555-888-4411','SPECIAL COVERAGE',
     'GOVERNMENT COVERED',3155489113);
INSERT INTO INSURANCE VALUES (8975641231, 'HUMANA',
     '741 VARSITY DR, INDIANAPOLIS, IN','555-656-7133','MIN COVERAGE',
     'PARTIAL PACKAGE, LIMITED PROCEDURES',3157123654);
INSERT INTO INSURANCE VALUES (5466121131, 'ANTHEM',
     '112 MAIN ST, NEW YORK, NY','555-445-8891','FULL COVERAGE',
     'TOTALLY COVERED, ANY MEDICALLY NECESSARY',3154694265);

--MEDICATIONS
INSERT INTO MEDICATIONS VALUES (4117256418, 'Vicodin', '2 pills per day'
     , 'treating acute or chronic moderate to moderately severe pain','1000mg','JohnsonJohnson'
     ,'can reduce breathing, impair thinking, reduce physical abilities, and is habit-forming');
INSERT INTO MEDICATIONS VALUES (1788511354, 'Albuterol'
     ,'1 puff as needed','dilates the airways of the lung'
     ,'100mg','Pfizer','migraine headaches non-migraine headaches nausea stomach upset
        flu-like symptoms cold symptoms ear infections (otitis media) bronchitis cough');
INSERT INTO MEDICATIONS VALUES (8004566897, 'Lisinopril',
     '1 pill daily','angiotensin-converting enzyme (ACE) inhibitor','25mg','Moderna'
     ,'may cause a dry cough that resolves when the drug is discontinued');
INSERT INTO MEDICATIONS VALUES (6011287433, 'Levothyroxine',
     '1 pill weekly','man-made version of thyroid hormone','50mg','JohnsonJohnson'
     ,'chest pain, increased heart rate, excessive sweating
        , heat intolerance, nervousness, headache, and weight loss.');
INSERT INTO MEDICATIONS VALUES (5014233689, 'Gabapentin',
     '2 pills daily','anti-seizure (anti-convulsant) drug','1500mg','Pfizer'
     ,'Dizziness Sleepiness Ataxia Fatigue Drowsiness Fluid retention (edema) Hostility Nausea
        Vomiting Difficulty speaking Jerky movements Unusual eye movements');
INSERT INTO MEDICATIONS VALUES (2044889012, 'Metformin',
     '1 shot daily','treating type 2 diabetes','4000mg','Pfizer'
     ,'nausea, vomiting, gas, bloating, diarrhea, and loss of appetite');
INSERT INTO MEDICATIONS VALUES (3365955014, 'Lipitor',
     '2 pills daily','treating high cholesterol','65mg','Moderna'
     ,' constipation, diarrhea, fatigue, gas, heartburn, and headache');
INSERT INTO MEDICATIONS VALUES (4405895466, 'Amlodipine',
     '1 pill weekly','calcium channel blocker','500mg','JohnsonJohnson'
     ,' headaches and swelling of the lower extremities  dizziness, 
        flushing, fatigue, nausea, and palpitations');

--ADMINISTRATOR
INSERT INTO ADMINISTRATOR VALUES (8899755123, 'IT MANAGER','MICHAEL','GONZALEZ'
    ,'7784 LOW LN, INDIANAPOLIS, IN','555-789-8874','GONZALEZ@MEDREC.COM'
    ,90000,'MASTERS OF COMPUTER SCIENCE');
INSERT INTO ADMINISTRATOR VALUES (1154756418, 'NETWORK SUPPORT','VINCENT','GROVE'
    ,'1509 LEAF RD, INDIANAPOLIS, IN','555-331-7715','GROVE@MEDREC.COM'
    ,70000,'MASTERS OF COMPUTER SCIENCE');
INSERT INTO ADMINISTRATOR VALUES (3665487912, 'JR TECH','ELIZABETH','SMITH'
    ,'116 CIRCLE AVE, INDIANAPOLIS, IN','555-645-1132','SMITH@MEDREC.COM'
    ,50000,'BACHELORS OF INFORMATICS');

--PATIENT
ALTER SESSION SET nls_date_format='mm-dd-yyyy';
INSERT INTO PATIENT VALUES (4412655980,'VALORIE','DOLCE','12-02-1977'
    ,'5549 34TH ST, INDIANAPOLIS, IN','F','WHITE'
    ,'555-741-6632','VDOLCE@GMAIL.COM',3145513698);
INSERT INTO PATIENT VALUES (6481235548,'GARRET','RUCKER','01-22-1995'
    ,'4471 E 68TH ST, INDIANAPOLIS, IN','M','WHITE'
    ,'555-317-7461','GRUCKER@GMAIL.COM',8975641231);
INSERT INTO PATIENT VALUES (4477845612,'BRIAN','MCGAVEN','07-30-1987'
    ,'9956 W 97TH ST, INDIANAPOLIS, IN','F','WHITE'
    ,'555-741-7713','BMCGAVEN@GMAIL.COM',1451236984);
INSERT INTO PATIENT VALUES (9945100125,'LUCIE','JONES','08-11-1979'
    ,'1152 N MERIDIAN ST, INDIANAPOLIS, IN','F','BLACK'
    ,'555-317-5564','LJONES@GMAIL.COM',3145513698);
INSERT INTO PATIENT VALUES (4041165789,'HARRY','ELHART','12-23-1965'
    ,'6632 MICHIGAN BLVD, INDIANAPOLIS, IN','M','WHITE'
    ,'555-317-7721','HELHART@GMAIL.COM',5466121131);
INSERT INTO PATIENT VALUES (1054122344,'TROY','OBRIEN','03-15-1960'
    ,'9941 W 86TH ST, INDIANAPOLIS, IN','M','WHITE'
    ,'555-317-9932','TOBRIEN@GMAIL.COM',3145513698);
INSERT INTO PATIENT VALUES (4788904412,'KATHY','KITCHENS','02-20-1981'
    ,'7712 E PALMETTO AVE, INDIANAPOLIS, IN','F','WHITE'
    ,'555-317-1977','KKITHCENS@GMAIL.COM',1451236984);
INSERT INTO PATIENT VALUES (5661001253,'COURTNEY','HARRIS','09-09-1978'
    ,'4488 W 19TH ST, INDIANAPOLIS, IN','F','WHITE'
    ,'555-981-7325','CHARRIS@GMAIL.COM',5516987456);
INSERT INTO PATIENT VALUES (8841201223,'ROLANDA','JEFFERSON','05-11-1964'
    ,'3488 E 32ND ST, INDIANAPOLIS, IN','F','BLACK'
    ,'555-317-6332','RJEFFERSON@GMAIL.COM',5516987456);
INSERT INTO PATIENT VALUES (9974123446,'MARCOS','LOPEZ','04-01-1959'
    ,'7788 W TOWER LN, INDIANAPOLIS, IN','M','HISPANIC'
    ,'555-317-3911','MLOPEZ@GMAIL.COM',5516987456);

--PRACTICE
INSERT INTO PRACTICE VALUES (1005456123,'COMMUNITY HEALTH'
    ,'110 S MAIN ST, INDIANAPOLIS, IN'
    ,'555-999-8814','COMHEALTH@COMMUNITYHEALTH.COM',8899755123);
INSERT INTO PRACTICE VALUES (1004800814,'COMMUNITY HEALTH WALK IN CLINIC'
    ,'3415 E 96TH ST, INDIANAPOLIS, IN'
    ,'555-999-7445','COMHEALTH96@COMMUNITYHEALTH.COM',1154756418);
	
--PROVIDER
INSERT INTO PROVIDER VALUES (5514566231,'PHYSICIAN','ALEX','LOUDEN','PRIMARY'
    ,'774 E BROWN AVE, INDIANAPOLIS, IN','555-454-6652','ALOUDEN@COMMUNITYHEALTH.COM'
    ,381000,'PHD MEDICAL SCIENCE',447125514566231,  1005456123);
INSERT INTO PROVIDER VALUES (8879511450,'PHYSICIAN','KAITLYN','FOSTER','PEDIATRICS'
    ,'2246 N MERIDIAN AVE, INDIANAPOLIS, IN','555-531-1564','KFLIDER@COMMUNITYHEALTH.COM'
    ,245000,'PHD PEDIATRIC SCIENCE',184578879511450,  1004800814);
INSERT INTO PROVIDER VALUES (6614891287,'PHYSICIAN','ALLISON','COPPLE','PRIMARY'
    ,'8812 W MOORE LN, INDIANAPOLIS, IN','555-987-5512','ACOPPLE@COMMUNITYHEALTH.COM'
    ,350000,'PHD MEDICAL SCIENCE',66216614891287,  1005456123);
INSERT INTO PROVIDER VALUES (3314722568,'NURSE PRACTITIONER','DARREN','LIGHTFOOT','PRIMARY'
    ,'5512 W GEIST AVE, INDIANAPOLIS, IN','555-454-6625','DLIGHTFOOT@COMMUNITYHEALTH.COM'
    ,110000,'MASTERS MEDICAL SCIENCE',810023314722568,  1004800814);
INSERT INTO PROVIDER VALUES (4400568113,'NURSE PRACTITIONER','SAM','BROWNING','SURGICAL'
    ,'1331 W 36TH ST, INDIANAPOLIS, IN','555-317-1845','SBROWNING@COMMUNITYHEALTH.COM'
    ,145000,'MASTERS SURGICAL MEDICAL SCIENCE',420124400568113,  1005456123);
INSERT INTO PROVIDER VALUES (7701564490,'SURGEON','JUSTIN','FORNEAR','CARDIOLOGY'
    ,'4405 E 45TH ST, INDIANAPOLIS, IN','555-317-9812','JFORNEAR@COMMUNITYHEALTH.COM'
    ,512000,'PHD SURGICAL MEDICAL SCIENCE',663217701564490,  1005456123);
INSERT INTO PROVIDER VALUES (9804566187,'PHYSICIAN','LESLIE','CORDEN','CARDIOLOGY'
    ,'9918 N MICHIGAN AVE, INDIANAPOLIS, IN','555-317-2218','LCORDEN@COMMUNITYHEALTH.COM'
    ,360000,'PHD CARDIOLOGICAL MEDICAL SCIENCE',554689804566187,  1005456123);

--LABS_CHARTS
INSERT INTO LABS_CHARTS VALUES (994510012501,'EKG','07-15-2020','07-30-2020'
    ,'HEART PALPITATIONS DETECTED',5514566231, 9945100125 );
INSERT INTO LABS_CHARTS VALUES (648123554801,'BLOOD WORK','06-15-2020','07-03-2020'
    ,'POSSIBLE INFECTION',5514566231, 6481235548 );
INSERT INTO LABS_CHARTS VALUES (441265598001,'EKG','01-10-2021','01-14-2021'
    ,'PRE SURGERY BLOOD WORK',7701564490, 4412655980 );
INSERT INTO LABS_CHARTS VALUES (994510012502,'BLOOD WORK','01-25-2021','02-02-2021'
    ,'POSSIBLE INFECTION',3314722568, 9945100125 );

--TREATMENTS
INSERT INTO TREATMENTS VALUES (5514500178,'STANDARD EXAM','YEARLY CHECKUP'
    ,'STANDARD PATIENT CHECKUP',5514566231);
INSERT INTO TREATMENTS VALUES (1002345689,'STANDARD EXAM','YEARLY CHECKUP'
    ,'STANDARD PATIENT CHECKUP',8879511450);
INSERT INTO TREATMENTS VALUES (8794500145,'STANDARD EXAM','YEARLY CHECKUP'
    ,'STANDARD PATIENT CHECKUP',6614891287);
INSERT INTO TREATMENTS VALUES (1244562310,'SURGERY','AORTIC BLOCK'
    ,'SURGERY OF THE HEART',7701564490);
	
--MEDICAL_HISTORY
INSERT INTO MEDICAL_HISTORY VALUES (7789011023,4412655980,5514500178
    ,2044889012,5514566231,994510012501);
INSERT INTO MEDICAL_HISTORY VALUES (6623154891,6481235548,1002345689
    ,NULL,8879511450,NULL);
INSERT INTO MEDICAL_HISTORY VALUES (4477845612,8841201223,NULL
    ,NULL,3314722568,NULL);
INSERT INTO MEDICAL_HISTORY VALUES (9945108885,9945100125,NULL
    ,NULL,5514566231,NULL);
INSERT INTO MEDICAL_HISTORY VALUES (4564510005,4041165789,NULL
    ,NULL,9804566187,NULL);