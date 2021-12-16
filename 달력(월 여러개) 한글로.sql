select min(decode(일,1,년도)) 년_월
	  ,min(decode(요일,1,일)) 일
	  ,min(decode(요일,2,일)) 월
	  ,min(decode(요일,3,일)) 화
	  ,min(decode(요일,4,일)) 수
	  ,min(decode(요일,5,일)) 목
	  ,min(decode(요일,6,일)) 금
	  ,min(decode(요일,7,일)) 토
from (
select to_char(to_date(:v_st, 'yyyymm') + rownum-1, 'yyyy-mm') 년도
	,trunc(to_date(:v_st,'yyyymm')+rownum-1,'d') 주 /*(일요일로 초기화)*/
	,to_char(to_date(:v_st, 'yyyymm') + rownum-1, 'd') 요일 /*(요일을 1~7로 표현)*/
	,extract(day from to_date(:v_st, 'yyyymm')+rownum-1) 일
from dual
connect by level <= last_day(to_date(:v_et,'yyyymm')) - to_date(:v_st,'yyyymm') + 1)
group by 년도,주
order by 년도,주;


