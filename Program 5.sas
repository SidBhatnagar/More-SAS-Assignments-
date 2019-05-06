data work.Ass41;
   	do count=1 to 15;
      Capital+5000;
      capital+(capital*.10);
   end;
run;


data work.Ass411;
do gallons=1 to 20 while(distance<250) ;
Distance=gallons*mpg;
output;
end;
run;

data work.ass412;

   Amount=500000;
   Rate=.070/12;
   do month=1 to 12;
      Earned+(amount+earned)*rate;
   end;
run;
data work.ass4121;

   Amount=500000;
   Rate=.070/12;
   do year = 1 to 25;
      Earned+(amount+earned)*rate;
   end;
run;
