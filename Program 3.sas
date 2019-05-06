LIBNAME SALESCAR '/folders/myshortcuts/Myfolders';

PROC IMPORT DATAFILE ='/folders/myshortcuts/Myfolders/Car_sales.xlsx'
            DBMS =  xlsx 
            OUT=CAR_SALES_DATA3;
            GETNAMES = YES;
            MIXED=YES;
            
            
            
            
            
RUN;

DATA MISSING_VALUES_DELETED;
SET CAR_SALES_DATA;
If _4_year_resale_value = . then delete;
Run;

DATA SELECTING_VARIABLES;
SET CAR_SALES_DATA;
KEEP Manufacturer Sales_in_thousands Model Price_in_thousands;
RUN;

DATA LESS_THAN_EQUAL_FIFTEEN;
SET MISSING_VALUES_DELETED;
IF Price_in_thousands <= 15;
RUN;
DATA BETWEEN_FIFTEEN_TWENTY;
SET MISSING_VALUES_DELETED;
IF Price_in_thousands >=15 and Price_in_thousands <=20;
RUN;
DATA BETWEEN_TWENTY_THRITY;
SET MISSING_VALUES_DELETED;
IF Price_in_thousands >=20 and Price_in_thousands <=30;
RUN;
DATA BETWEEN_THIRTY_FORTY;
SET MISSING_VALUES_DELETED;
IF Price_in_thousands >= 30 and Price_in_thousands <=40;
RUN;
DATA GREATER_THAN_FORTY;
SET MISSING_VALUES_DELETED;
IF Price_in_thousands >40;
RUN;

DATA ID_DATE_TEST;
X = '1oct14'D;
RUN;

DATA DATE_FORMAT1;
SET MISSING_VALUES_DELETED;
LATEST_LAUNCH_DATE = Latest_Launch-21916;
format LATEST_LAUNCH_DATE date9.;
run;

DATA DATE_FORMAT2;
SET MISSING_VALUES_DELETED;
LATEST_DATE = (Latest_Launch )




