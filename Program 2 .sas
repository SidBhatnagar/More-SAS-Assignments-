libname Grocery '/folders/myshortcuts/Myfolders';

PROC IMPORT DATAFILE='/folders/myshortcuts/Myfolders/grocery_coupons.xls'
DBMS = xls
OUT = lib.GROCERY_INFO;
GETNAMES=YES;
RUN;

DATA MISSING_VALUES_DELETED;
SET GROCERY_INFO;
if missing(coalesce(of _numeric_))  then delete;
run;

DATA MISSING_VALUES_AMTSPENT;
SET MISSING_VALUES_DELETED;
if amtspent = 0 then delete;
RUN;

PROC SORT DATA = MISSING_VALUES_AMTSPENT
OUT = VARIABLES_FOUR_SORT;
by coupval org amtspent size gender style;
run;

DATA INPUT_LABEL_FOR_VARIABLEs;
Set  VARIABLES_FOUR_SORT ;
Label storeid = Store ID hlthfood = Health food store size = Size of store org = Store organization custid = Customer ID gender = Gender Shopfor = Who shopping for veg = Vegetarian style = Shopping style  usecoup = Use coupons  week = Week seq = Sequence carry = carryover coupval = Value of coupon amtspent = Amount spent;
Run;

PROC FORMAT;
VALUE FMTHLTHFOOD  0 = " NO " 1 = " YES ";
VALUE FMTsize 1 = " Small " 2 = " Medium " 3 = " Large";
VALUE FMTorg 1 = " Emphasizes produce " 2 = " Emphasizes deli " 3 = " Emphasizes bakery " 4 = " No emphasis";
VALUE FMTgender 0 = " Male " 1 = " Female ";
VALUE FMTSHOPFOR 1 = " Self " 2 = " Self and spouse " 3 = " Self and family ";
VALUE FMTVEG 0 = " No " 1 = " Yes ";
VALUE FMTSTYLE 1 = " Biweekly (in bulk) " 2 = " Weekly (similar items) " 3 = " Often (whats on sale) ";
VALUE FMTUSECOUP 1 = " No " 2 = " From newspaper " 3 = " From mailings " 4 = " From both ";
VALUE FMTCARRY 0 = " First period " 1 = " No coupon " 2 = " 5 percent " 3 = " 15 percent " 4 = " 25 percent ";
VALUE FMTCOUPVAL 1 = " No value " 2 = " 5 percent " 3 = " 15 percent " 4 = " 25 percent ";
RUN;

DATA VALUE_VARIABLE_LABELS;
Set INPUT_LABEL_FOR_VARIABLES ;
Format hlthfood FMTHLTHFOOD. size FMTsize. org FMTorg. gender FMTgender. shopfor FMTSHOPFOR. veg FMTVEG. style FMTSTYLE. usecoup FMTUSECOUP.
carry FMTCARRY. coupval FMTCOUPVAL. ;
RUN;

Proc sort data = value_variable_labels
Out = Gender_SORT;
by gender;
Run;


Proc freq data = Gender_sort ;
tables coupval style;
by gender;
Run;

Proc freq data = VALUE_VARIABLE_LABELS;
Tables size*org / nocum nopercent;
Tables size*org/ nocum nofreq;
Run; 

Proc Means data = Value_variable_labels;
VAR amtspent;
output out= MEAN_CAL_PROC
MAX = max_amtspent
MIN = min_amtspent
MEAN = avg_amtspent
SUM = tot_amtspent;
CLASS size org;
RUN;

Proc copy in = work out = grocery;
Run;


