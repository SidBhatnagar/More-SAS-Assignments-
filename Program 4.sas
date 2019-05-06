libname libQ3 '/folders/myshortcuts/Myfolders';

PROC IMPORT DATAFILE ='/folders/myshortcuts/Myfolders/Car_sales.csv'
            DBMS =  csv 
            OUT=Car_Sales2;
            GETNAMES = YES;
            GUESSINGROWS = 100;
RUN;

Data P1;
Set Car_sales2 ;
Run;

proc sort data = P1
out = libq3.Psort;
by manufacturer;
run;

data P2;
Set P1;
if N(_4_year_resale_value )=0 then delete;
Run;

data P3;
Set P1;
if N(Price_in_thousands )=0 then delete;
Run;

proc freq data=p1 NLEVELS;
tables manufacturer;
run;
Data Q10 ;
set work.p1;
length Origin $20;
select (manufacturer);
when ("Buick","Cadillac","Chevrolet","Chrysler","Dodge","Ford","Jeep","Lincoln","Mercury","Oldsmobile","Pymouth","Pontiac","Saturn")  Origin = "USA";
When ("Audi","BMW","Mercedes-Benz","Porsche","Volkswagen") Origin = "Germany";
When ("Honda","Toyota","NISSAN","Mitsubishi","Subaru") Origin = "Japan";
When ("Saab","Volvo") Origin = "Sweden";
When ("Jaguar") Origin = "United Kingdom";
When ("Acura","Infiniti","Lexus") Origin = "Japan/USA";
When ("Hyundai") Origin = "South Korea";
otherwise origin = "other";

End;

Data Q20;
set Q10;
UniqueID = Manufacturer ||Model;
UniqueID =trim(Manufacturer)||Model;
run;

Data Hyundai;
Length Manufacturer$  13 Model$  14 Sales_in_thousands  8 _4_year_resale_value  8; 
INPUT Manufacturer$ Model$ Sales_in_thousands _4_year_resale_value Latest_Launch;
Format Latest_launch DDMMYY10.;
Datalines;
Hyundai Tuscon 16.919 16.36 20212
Hyundai i45 39.384 19.875 30611
Hyundai Verna 14.114 18.225 40112
Hyundai Terracan 8.588 29.725 100311
;
run;

Data HyundaiID;
set hyundai;
Length UniqueID$ 27;
UniqueID = Manufacturer || Model;
UniqueID=trim(Manufacturer)||Model;
Run;

data Total_sales;
  set HyundaiID
      Q31;
run;

Proc sort data = Total_sales out = Q61;

by UniqueID;

Run;

Proc sort data = Q32 out = Q616;
by UniqueID;
run;


data q611;
   merge  Q61 q616;
   by UniqueID;
run;

Proc sort data = Q611 out = Q71;
by UniqueID;
Run;

Data Q70;
merge Q61(IN=manu) Q616(in=MANU1); 
 
By Uniqueid;
If manu=1 and manu1=1;
Run;










Data P6;
set p1;
length uniqueID $20; /* To be adjusted */
uniqueID = catx("-", "Model", "Manufacturer");
run;



Proc sort Data=P1
Out = Sorted;
By Manufacturer Model;
Run;

data Q31;
set Q20;

Keep Manufacturer Model Latest_launch Sales_in_thousands _4_year_resale_value Price_in_thousands UniqueID;
run;

data Q32;
set Q20;
drop Manufacturer Model Latest_launch Sales_in_thousands _4_year_resale_value Price_in_thousands;
Run;





Data UniqueID;
set p1;
by Manufacturer Model;
Do Nobs = 1-157;
UniqueID="    ";
do i =1 to 5;
rannum = int(uniform(0)*36);
if (0<=rannum <=9) then ranch = byte(rannum+48);
if (10<=rannum<=36) then ranch = byte(rannum+55);
substr(UniqueID,i,1)=ranch;
end;
ranord = uniform(0);
output;
end;
keep UniqueId ranord;
run;

