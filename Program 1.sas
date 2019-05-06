C:\SASUniversityEdition\Myfolders


                /*MAking the permanent library*/
LIBNAME lib '/folders/myshortcuts/Myfolders';

               /*IMPORTING THE CAR_SALES FILES*/
PROC IMPORT DATAFILE ='/folders/myshortcuts/Myfolders/Car_sales.csv'
            DBMS =  csv 
            OUT=Car_Sales1;
            GETNAMES = YES;
            GUESSINGROWS = 100;
RUN;

               /* OBSERVING MISSING SPACES*/

DATA MISSING_OBS;
SET CAR_SALES1;
IF _4_year_resale_value = .;
Run;


                   /*DELETING MISSING SPACES*/
DATA MISSING_VALUES;
SET Car_sales1;
If N(_4_year_resale_value)=0 then delete;
Run;

 					/*ADDING A NUMERIC VALUE TO MISSING SPACES*/
DATA MISSING_RE;
SET CAR_SALES1;
If _4_year_resale_value = . then _4_year_resale_value = 0;
Run;
                    /*SORTING DATA IN DESCENDING ORDER FOR BETTER VISUALIZATION */
Proc sort data = MISSING_VALUES
OUT = SORT_CAR2;
by descending Manufacturer descending Price_in_thousands descending Model descending Sales_in_thousands  ;
Run;
                    /*CROSS CHECKING WITH PROC PRINT*/
Proc Print data = SORT_CAR2;
RUN;
                    /*SELECTING FOUR TABLES REQUIRED FOR ANALYSIS */
DATA SELECT_VARIABLES;
SET SORT_CAR2 ;
Keep Manufacturer Sales_in_thousands Model Price_in_thousands;
RUN;
					 /*PRINT FUNCTION TO CHECK THE OUTCOME */
PROC PRINT DATA = SORT_CAR2;
VAR Manufacturer Sales_in_thousands Model Price_in_thousands;
Run;

					/*FORMATTING ACCORDING TO RANGES*/
DATA RANGE_1;
SET CAR_SALES1;
WHERE Price_in_thousands <= 15;
Run;
DATA RANGE_2;
SET CAR_SALES1;
WHERE Price_in_thousands between 15 and 20;
Run;
DATA RANGE_3;
SET CAR_SALES1;
WHERE Price_in_thousands between 20 and 30;
Run;
DATA RANGE_4;
SET CAR_SALES1;
WHERE Price_in_thousands between 30 and 40;
Run;
DATA RANGE_5;
SET CAR_SALES1;
Where Price_in_thousands >= 40;
RUN;

 					/*FINDING THE NUMBER THAT CORRESPONTS TO THE DATE */

DATA ID_DATE;
X = '1oct14'D;
RUN;
					/*EXTRACTING THE DATA INTERMS OF VEHICLES LAUCNHED AFTER 1stOCTOBER2014 WITH RESPECT TO VEHICLE TYPE*/
DATA DATEAFTER23;
SET CAR_SALES1;
Launch_Date = input(Latest_Launch,informat.);
If Launch_Date > 19997;
where Vehicle_type = 'Passenger';
RUN;

proc copy in = work out = LIB; 
Run;











