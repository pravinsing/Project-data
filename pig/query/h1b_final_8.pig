8) Find the average Prevailing Wage for each Job for each Year (take part time and full time separate). Arrange the output in descending order - [Certified and Certified Withdrawn.]
Technology  Used: Pig.
PigScript: h1b8.pig

data1 = LOAD '/user/hive/warehouse/h1b_final' USING PigStorage('\t') as (s_no:double,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:chararray,worksite:chararray,longitude,latitude);

data2 = FOREACH data1 GENERATE year,case_status,job_title,prevailing_wage,full_time_position;
--dump data2;

year11 = FILTER data2 BY (year == '2011') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED')) AND full_time_position =='Y';
GROUP11 = group year11 by (job_title,year,full_time_position);
AVG1 = foreach GROUP11 generate group, (double)AVG(year11.prevailing_wage) as count;
RESULT_11_Y = order AVG1 by $1 desc;


year12 = FILTER data2 BY (year == '2012') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='Y';
GROUP12 = group year12 by (job_title,year,full_time_position);
AVG2 = foreach GROUP12 generate group, (double)AVG(year12.prevailing_wage) as count ;
RESULT_12_Y = order AVG2 by $1 desc;

year13 = FILTER data2 BY (year == '2013') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='Y';
GROUP13 = group year13 by (job_title,year,full_time_position);
AVG3 = foreach GROUP13 generate group, (double)AVG(year13.prevailing_wage) ;
RESULT_13_Y = order AVG3 by $1 desc;

year14 = FILTER data2 BY (year == '2014') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='Y';
GROUP14 = group year14 by (job_title,year,full_time_position);
AVG4 = foreach GROUP14 generate group, (double)AVG(year14.prevailing_wage) ;
RESULT_14_Y= order AVG4 by $1 desc;

year15 = FILTER data2 BY (year == '2015') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='Y';
GROUP15 = group year15 by (job_title,year,full_time_position);
AVG5 = foreach GROUP15 generate group, (double)AVG(year15.prevailing_wage) ;
RESULT_15_Y= order AVG5 by $1 desc;

year16 = FILTER data2 BY (year == '2016') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='Y';
GROUP16 = group year16 by (job_title,year,full_time_position);
AVG6 = foreach GROUP16 generate group, (double)AVG(year16.prevailing_wage) ;
RESULT_16_Y= order AVG6 by $1 desc;

FINAL_Y = UNION RESULT_11_Y,RESULT_12_Y,RESULT_13_Y,RESULT_14_Y,RESULT_15_Y,RESULT_16_Y;
STORE FINAL_Y INTO 'pig_out/prob_8_Y' USING PigStorage();

--FOR PART_TIME

year11 = FILTER data2 BY (year == '2011') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED')) AND full_time_position =='N';
GROUP11 = group year11 by (job_title,year,full_time_position);
AVG1 = foreach GROUP11 generate group, (double)AVG(year11.prevailing_wage) as count;
RESULT_11_N = order AVG1 by $1 desc;

year12 = FILTER data2 BY (year == '2012') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='N';
GROUP12 = group year12 by (job_title,year,full_time_position);
AVG2 = foreach GROUP12 generate group, (double)AVG(year12.prevailing_wage) ;
RESULT_12_N = order AVG2 by $1 desc;

year13 = FILTER data2 BY (year == '2013') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='N';
GROUP13 = group year13 by (job_title,year,full_time_position);
AVG3 = foreach GROUP13 generate group, (double)AVG(year13.prevailing_wage) ;
RESULT_13_N = order AVG3 by $1 desc;

year14 = FILTER data2 BY (year == '2014') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='N';
GROUP14 = group year14 by (job_title,year,full_time_position);
AVG4 = foreach GROUP14 generate group, (double)AVG(year14.prevailing_wage) ;
RESULT_14_N= order AVG4 by $1 desc;

year15 = FILTER data2 BY (year == '2015') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='N';
GROUP15 = group year15 by (job_title,year,full_time_position);
AVG5 = foreach GROUP15 generate group, (double)AVG(year15.prevailing_wage) ;
RESULT_15_N= order AVG5 by $1 desc;

year16 = FILTER data2 BY (year == '2016') AND ((case_status =='CERTIFIED-WITHDRAWN') OR( case_status == 'CERTIFIED'))AND full_time_position =='N';
GROUP16 = group year16 by (job_title,year,full_time_position);
AVG6 = foreach GROUP16 generate group, (double)AVG(year16.prevailing_wage) ;
RESULT_16_N= order AVG6 by $1 desc;

FINAL_N = UNION RESULT_11_N,RESULT_12_N,RESULT_13_N,RESULT_14_N,RESULT_15_N,RESULT_16_N;
STORE FINAL_N INTO 'pig_out/prob_8_N' USING PigStorage();


