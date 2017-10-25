b) Find top 5 job titles who are having highest avg growth in applications.[ALL]
Technology Used: Pig
PigScript:h1b_q1b.pig.

data1 = LOAD '/user/hive/warehouse/h1b_final' USING PigStorage('\t') as (s_no:double,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:chararray,worksite:chararray,longitude,latitude);
data2 = foreach data1 generate job_title,year; 
 
year1= filter data2 by year=='2011';
year2= filter data2 by year=='2012';
year3= filter data2 by year=='2013';
year4= filter data2 by year=='2014';
year5= filter data2 by year=='2015';
year6= filter data2 by year=='2016';

total1= group year1 by(job_title);
total2= group year2 by(job_title);
total3= group year3 by(job_title);
total4= group year4 by(job_title);
total5= group year5 by(job_title);
total6= group year6 by(job_title);

count1= foreach total1 generate group,COUNT(year1.job_title);
count2= foreach total2 generate group,COUNT(year2.job_title);
count3= foreach total3 generate group,COUNT(year3.job_title);
count4= foreach total4 generate group,COUNT(year4.job_title);
count5= foreach total5 generate group,COUNT(year5.job_title);
count6= foreach total6 generate group,COUNT(year6.job_title);

JOIN1= join count1 by $0,count2 by $0,count3 by $0,count4 by $0,count5 by $0,count6 by $0;


output1= foreach JOIN1 generate $0,$1,$3,$5,$7,$9,$11;
finaloutput1= foreach output1 generate $0,(DOUBLE)((($2-$1)*100)/$1+(($3-$2)*100)/$2+(($4-$3)*100)/$3+(($5-$4)*100)/$4+(($6-$5)*100)/$5);
finaloutput2= foreach finaloutput1 generate $0,(DOUBLE)($1/5);
finalavg= limit (order finaloutput2 by $1 desc) 5;
dump finalavg;
STORE finalavg INTO 'pig_out/output_1b' USING PigStorage();




