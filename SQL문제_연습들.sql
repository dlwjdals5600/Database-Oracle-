-- 문제 1 : 평균을 구해서 일의 자리수 만큼 문자 샵을 그리기

SELECT name
	  ,(kor+eng+mat)/3 avg1
	  ,lpad('#',substr(floor((kor+eng+mat)/3),1,1),'#')
FROM exam_rslt;




-- 문제 2 : 평균을 구해서 일의 자리수 만큼 문자 샵을 그리고 바로 뒤에 십의 자리수 만큼 점을 찍기

SELECT name
	  ,(kor+eng+mat)/3 avg1
	  ,lpad('#',substr(floor((kor+eng+mat)/3),1,1),'#')||lpad('.',substr(floor((kor+eng+mat)/3),2),'.') munja
FROM exam_rslt;





-- 문제 3 : 오라클 분석함수를 이용해서 각각의 사람의 가장 큰 점수를 행에 나열하고 이름을 붙이기  

-- 테이블 형태 예시

--	 	NAME |	col_1	|	col_2	|	col_3
--			 |			|			|
--		김진우 | KOR : 90	| MAT : 90	| ENG : 80

SELECT name
	  ,max(decode(r1,1,decode(NO,1,'kor : '|| col1, 2,'eng : '|| col1, 3,'mat : ' || col1))) col_1
	  ,max(decode(r1,2,decode(NO,1,'kor : '|| col1, 2,'eng : '|| col1, 3,'mat : ' || col1))) col_2
	  ,max(decode(r1,3,decode(NO,1,'kor : '|| col1, 2,'eng : '|| col1, 3,'mat : ' || col1))) col_3
from(
SELECT no
	  ,name
	  ,decode(NO,1,kor,2,eng,3,mat) col1
	  ,rank() over(PARTITION BY name ORDER BY decode(NO,1,kor,2,eng,3,mat) DESC,NO) r1
FROM exam_rslt a,
(SELECT rownum NO
FROM dual
CONNECT BY LEVEL <=3) b
ORDER BY name,col1 DESC)
GROUP BY name


SELECT name
	  ,class
	  ,mat
	  ,kor
	  ,rank() over(PARTITION BY name,class ORDER BY mat,kor)
FROM exam_rslt;



-- 문제 4 :	(이름,과목,점수)테이블과 (학점,시작범위,끝범위)테이블을 조건조인 시킨다. 그 사람의 점수에 맞게 성적과 시작범위, 끝범위를 찾기

SELECT *
FROM std_score join
(SELECT *
FROM course_credits) ON score = CASE WHEN score BETWEEN st_rng AND et_rng THEN score END
ORDER BY nm,score DESC;




-- 문제 5 :	(이름,과목,점수)테이블과 (학점,시작범위,끝범위)테이블을 무조건조인 시킨다. 그 사람의 점수에 맞게 성적과 시작범위, 끝범위를 찾기
--	조건 조인보다 비효율적이지만 무조건조인이 필요할 때가 있기 때문에 연습차원애서 사용

SELECT s.NM
	  ,s.SUBJECT
	  ,max(s.SCORE)
	  ,CASE WHEN s.score BETWEEN 91 AND 100 THEN 'A' WHEN s.score BETWEEN 81 AND 90 THEN 'B' WHEN s.score BETWEEN 71 AND 80 THEN 'C' WHEN s.score BETWEEN 61 AND 70 THEN 'D' WHEN s.score BETWEEN 0 AND 60 THEN 'F' END Score
	  ,max(CASE WHEN s.score BETWEEN 91 AND 100 THEN 91 WHEN s.score BETWEEN 81 AND 90 THEN 81 WHEN s.score BETWEEN 71 AND 80 THEN 71 WHEN s.score BETWEEN 61 AND 70 THEN 61 WHEN s.score BETWEEN 0 AND 60 THEN 0 END) ST_ENG
	  ,max(CASE WHEN s.score BETWEEN 91 AND 100 THEN 100 WHEN s.score BETWEEN 81 AND 90 THEN 90 WHEN s.score BETWEEN 71 AND 80 THEN 80 WHEN s.score BETWEEN 61 AND 70 THEN 70 WHEN s.score BETWEEN 0 AND 60 THEN 60 END) ET_RNG
FROM LJM_score s,
(SELECT *
FROM LJM_course) c
GROUP BY nm, subject, CASE WHEN s.score BETWEEN 91 AND 100 THEN 'A' WHEN s.score BETWEEN 81 AND 90 THEN 'B' WHEN s.score BETWEEN 71 AND 80 THEN 'C' WHEN s.score BETWEEN 61 AND 70 THEN 'D' WHEN s.score BETWEEN 0 AND 60 THEN 'F' END
ORDER BY nm, Score;





-- 문제 6 :	오라클의 분석함수를 이용하지 말고 사람들을 MAT점수 내림차순으로 정렬을 한 다음 밑에 사람과 몇점 차이가 나는지 출력

SELECT max(decode(NO,1,name)) name
	  ,seq
	  ,max(decode(NO,1,kor)) kor
	  ,max(decode(NO,1,mat)) mat
	  ,(min(decode(NO,2,mat)) - min(decode(NO,1,mat))) cha2
from(
SELECT name
	  ,NO
	  ,decode(NO,1,seq,seq +1) SEQ
	  ,kor kor
	  ,mat mat
	  ,decode(NO,1,mat) n1
	  ,decode(NO,2,mat) n2
FROM (
SELECT rownum seq, a.*
FROM (
SELECT name
	  ,kor
	  ,mat 
FROM exam_RSLT
ORDER BY mat DESC,name) A
),copy_t B
WHERE NO <=2
)
GROUP BY seq
HAVING max(decode(NO,1,kor)) IS NOT null
ORDER BY seq





-- 문제 7 : 별산 만들기

SELECT lpad('*',rownum,'*') 별_개수
	  ,lpad('*',decode(rownum,1,1,2,2,3,3,4,2,5,1),'*') 수동_별만들기
	  ,lpad('*',decode(sign(num/2+0.5-rownum),-1,num+1-rownum,rownum),'*') 자동_별만들기
FROM
(SELECT CASE WHEN :num>=3 THEN decode(MOD(:num,2),0,:num-1,:num)
		ELSE 3 END num
FROM dual)
CONNECT BY LEVEL <= num;




-- 문제 8 : 날짜 사이 기간동안 특정 요일 뺀 날짜 총 합 구하기

SELECT LENGTH(REPLACE(TRANSLATE(RPAD(substr('1234567',to_char(to_date(:SYMD,'YYYYMMDD'),'D'))
	  ,to_date(:EYMD,'YYYYMMDD') - to_date(:SYMD,'YYYYMMDD') +1
	  ,'1234567'),:PTN,' '),' ','')) STR_LEN
FROM dual;




-- 문제 9 : 밑의 첫번째 형태의 테이블에서 달림반, 별림반, 총계 행에 계산한 값을 넣어서 만들기


-- 홍길동	 달림반	10	30	50	2
-- 이정우	 달림반	80	90	80	3
-- 김진우	 별림반	90	80	90	4
-- 송해	 별림반	80	100	70	1
-- 신성남	 별림반	80	100	90	2




-- 홍길동	 10	  30	50	 90
-- 이정우	 80	  90	80	 250
-- 송해	 80	  100	70	 250
-- 김진우	 90	  80	90	 260
-- 신성남	 80	  100	90	 270
-- 달림반	 90	  120	130	 340
-- 별림반	 250  280	250	 780
-- 총계	 340  400	380	 1120

SELECT decode(B.NO,1,name,2,CLASS,'총계') name
,sum(kor) kor
,sum(eng) eng
,sum(mat) mat
,sum(kor+eng+mat) tot
FROM exam_rslt a,
(SELECT rownum NO
FROM dual
CONNECT BY LEVEL <=3) B
GROUP BY decode(B.NO,1,name,2,CLASS,'총계')
ORDER BY tot;




-- 문제 10 : 밑의 첫번째 테이블을 밑의형식으로 바꾸는데 점수를 내림차순으로 바꾼 후 1,2,3행을 4번째 행마다 더해서 밑의 테이블 형태로 만들기 


-- 이정민	100
-- 티모	50
-- 가렌	70
-- 이렐리아	88
-- 갈리오	77
-- 럭스	90
-- 모르가나	76
-- 베인	44
-- 뽀삐	55
-- 소나	95
-- 쉬바나	32



-- 0 번째의 합 216
-- 1 번째의 합	 302
-- 2 번째의 합	 259





-- 문제 11 :	달력 만들기 (한달)


SELECT 
MIN(DECODE(W_ID,1,D_ID))일
,MIN(DECODE(W_ID,2,D_ID))월
,MIN(DECODE(W_ID,3,D_ID))화
,MIN(DECODE(W_ID,4,D_ID))수
,MIN(DECODE(W_ID,5,D_ID))목
,MIN(DECODE(W_ID,6,D_ID))금
,MIN(DECODE(W_ID,7,D_ID))토
FROM
(SELECT
TRUNC(TO_DATE(:V_ST,'YYYYMM')+ROWNUM-1,'D') WK_ID			/* '주'의 첫번째 일요일을 찾아낸다. 최대 7개의 row가 생성된다. */
,TO_CHAR(TO_DATE(:V_ST,'YYYYMM')+ROWNUM-1,'D') W_ID			/* 일요일을 1로 반환 dy= 일 day=일요일 */
,EXTRACT(DAY FROM TO_DATE(:V_ST,'YYYYMM')+ROWNUM-1) D_ID	/* 1일 부터 반환 (숫자로) */
FROM DUAL
CONNECT BY LEVEL <=EXTRACT(DAY FROM LAST_DAY(TO_DATE(:V_ST,'YYYYMM')))
)GROUP BY WK_ID
ORDER BY WK_ID;





-- 문제 12 : 몇월 부터 몇월 기간을 정해주면 그 기간동안의 달의 달력을 출력


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



-- 문제 13 : 각 지역에서 외국으로 00001~00009물품들을 몇개씩 팔았고 많이 판 순서를 몇에다가 출력하기

SELECT cd_nm
	  ,region_area
	  ,product_1 ||' * ' || decode(ping,'00',substr(r_1,1,1),'01',substr(r_1,2,1),'11',substr(r_1,3,1))
	  ,product_2 ||' * ' || decode(ping,'00',substr(r_2,1,1),'01',substr(r_2,2,1),'11',substr(r_2,3,1))
	  ,product_3 ||' * ' || decode(ping,'00',substr(r_3,1,1),'01',substr(r_3,2,1),'11',substr(r_3,3,1))
	  ,product_4 ||' * ' || decode(ping,'00',substr(r_4,1,1),'01',substr(r_4,2,1),'11',substr(r_4,3,1))
	  ,product_5 ||' * ' || decode(ping,'00',substr(r_5,1,1),'01',substr(r_5,2,1),'11',substr(r_5,3,1))
	  ,product_6 ||' * ' || decode(ping,'00',substr(r_6,1,1),'01',substr(r_6,2,1),'11',substr(r_6,3,1))
	  ,product_7 ||' * ' || decode(ping,'00',substr(r_7,1,1),'01',substr(r_7,2,1),'11',substr(r_7,3,1))
	  ,product_8 ||' * ' || decode(ping,'00',substr(r_8,1,1),'01',substr(r_8,2,1),'11',substr(r_8,3,1))
	  ,product_9 ||' * ' || decode(ping,'00',substr(r_9,1,1),'01',substr(r_9,2,1),'11',substr(r_9,3,1))
	  ,r_1
	  ,r_2
	  ,r_3
	  ,r_4
	  ,r_5
	  ,r_6
	  ,r_7
	  ,r_8
	  ,r_9
	  ,ping
from
(SELECT DECODE(GROUPING(cd_nm)||GROUPING(REGION_AREA),
           '00',MIN(CD_NM),'01',MIN(CD_NM)||'합계','총계') CD_NM
	  ,region_area
	  ,sum(cnt)
	  ,sum(decode(prod_id,'00001',cnt)) product_1
	  ,sum(decode(prod_id,'00002',cnt)) product_2
	  ,sum(decode(prod_id,'00003',cnt)) product_3
	  ,sum(decode(prod_id,'00004',cnt)) product_4
	  ,sum(decode(prod_id,'00005',cnt)) product_5
	  ,sum(decode(prod_id,'00006',cnt)) product_6
	  ,sum(decode(prod_id,'00007',cnt)) product_7
	  ,sum(decode(prod_id,'00008',cnt)) product_8
	  ,sum(decode(prod_id,'00009',cnt)) product_9
	  ,min(decode(prod_id,'00001',start_rk||middle_rk||last_rk)) r_1
	  ,min(decode(prod_id,'00002',start_rk||middle_rk||last_rk)) r_2
	  ,min(decode(prod_id,'00003',start_rk||middle_rk||last_rk)) r_3
	  ,min(decode(prod_id,'00004',start_rk||middle_rk||last_rk)) r_4
	  ,min(decode(prod_id,'00005',start_rk||middle_rk||last_rk)) r_5
	  ,min(decode(prod_id,'00006',start_rk||middle_rk||last_rk)) r_6
	  ,min(decode(prod_id,'00007',start_rk||middle_rk||last_rk)) r_7
	  ,min(decode(prod_id,'00008',start_rk||middle_rk||last_rk)) r_8
	  ,min(decode(prod_id,'00009',start_rk||middle_rk||last_rk)) r_9
	  ,GROUPING(cd_nm)||GROUPING(REGION_AREA) ping
from
(
	SELECT area_cd
		  ,cd_nm
		  ,region_area
		  ,prod_id
		  ,cnt
		  ,DENSE_RANK() over(PARTITION BY area_cd,region_area ORDER BY cnt desc) start_rk
		  ,DENSE_RANK() over(PARTITION BY cd_nm ORDER BY city_cnt desc) middle_rk
		  ,DENSE_RANK() OVER(ORDER BY result_cnt desc) Last_rk
	from(
		SELECT area_cd
			  ,cd_nm
			  ,REGION_AREA
			  ,PROD_ID
			  ,sum(sale_cnt) cnt
			  ,sum(sum(sale_cnt)) over(PARTITION BY area_cd, prod_id) city_cnt
			  ,sum(sum(sale_cnt)) over(PARTITION BY prod_id) result_cnt
		FROM sale_tbl a, cd_tbl b
		WHERE area_cd = cd_id
		GROUP BY area_cd
				,cd_nm
				,REGION_AREA
				,PROD_ID
		ORDER BY area_cd
	)
	ORDER BY cd_nm,prod_id
)
GROUP BY ROLLUP(cd_nm,region_area)
);



-- 문제 14 : 각 지역에서 외국으로 00001~00009물품들을 몇개씩 팔았고 많이 판 순서를 몇에다가 출력하기 (추가 및 개선)

SELECT cd_nm
	  ,region_area
	  ,"0001"||'('||ROUND("0001"*100/total,1)||'%)'||'*'||decode("0001",0,ranks,decode(arp,'000',r_1,'010',r_1,'110',r_1)) a1
	  ,"0002"||'('||ROUND("0002"*100/total,1)||'%)'||'*'||decode("0002",0,ranks,decode(arp,'000',r_2,'010',r_2,'110',r_2)) a2
	  ,"0003"||'('||ROUND("0003"*100/total,1)||'%)'||'*'||decode("0003",0,ranks,decode(arp,'000',r_3,'010',r_3,'110',r_3)) a3
	  ,"0004"||'('||ROUND("0004"*100/total,1)||'%)'||'*'||decode("0004",0,ranks,decode(arp,'000',r_4,'010',r_4,'110',r_4)) a4
	  ,"0005"||'('||ROUND("0005"*100/total,1)||'%)'||'*'||decode("0005",0,ranks,decode(arp,'000',r_5,'010',r_5,'110',r_5)) a5
	  ,"0006"||'('||ROUND("0006"*100/total,1)||'%)'||'*'||decode("0006",0,ranks,decode(arp,'000',r_6,'010',r_6,'110',r_6)) a6
	  ,"0007"||'('||ROUND("0007"*100/total,1)||'%)'||'*'||decode("0007",0,ranks,decode(arp,'000',r_7,'010',r_7,'110',r_7)) a7
	  ,"0008"||'('||ROUND("0008"*100/total,1)||'%)'||'*'||decode("0008",0,ranks,decode(arp,'000',r_8,'010',r_8,'110',r_8)) a8
	  ,"0009"||'('||ROUND("0009"*100/total,1)||'%)'||'*'||decode("0009",0,ranks,decode(arp,'000',r_9,'010',r_9,'110',r_9)) a9
	  ,arp
FROM
(
SELECT decode(arp,'000',max(cd_nm),'010',max(cd_nm)||'의 총계','총계') cd_nm 
	  ,max(region_area) region_area
	  ,nvl(max(decode(prod_id,'00001',SALE_CNT)),0) "0001"
	  ,nvl(max(decode(prod_id,'00002',SALE_CNT)),0) "0002"
	  ,nvl(max(decode(prod_id,'00003',SALE_CNT)),0) "0003"
	  ,nvl(max(decode(prod_id,'00004',SALE_CNT)),0) "0004"
	  ,nvl(max(decode(prod_id,'00005',SALE_CNT)),0) "0005"
	  ,nvl(max(decode(prod_id,'00006',SALE_CNT)),0) "0006"
	  ,nvl(max(decode(prod_id,'00007',SALE_CNT)),0) "0007"
	  ,nvl(max(decode(prod_id,'00008',SALE_CNT)),0) "0008"
	  ,nvl(max(decode(prod_id,'00009',SALE_CNT)),0) "0009"
	  ,max(decode(prod_id,'00001',rk)) r_1
	  ,max(decode(prod_id,'00002',rk)) r_2
	  ,max(decode(prod_id,'00003',rk)) r_3
	  ,max(decode(prod_id,'00004',rk)) r_4
	  ,max(decode(prod_id,'00005',rk)) r_5
	  ,max(decode(prod_id,'00006',rk)) r_6
	  ,max(decode(prod_id,'00007',rk)) r_7
	  ,max(decode(prod_id,'00008',rk)) r_8
	  ,max(decode(prod_id,'00009',rk)) r_9
	  ,max(rk)+1 ranks
	  ,ARP
	  ,sum(sale_cnt) total
FROM
(
SELECT 	nvl(AREA_CD,999)AREA_CD
        ,REGION_AREA
        ,PROD_ID
        ,SUM(SALE_CNT) SALE_CNT
        ,RANK() OVER(PARTITION BY AREA_CD,REGION_AREA ORDER BY  SUM(SALE_CNT) DESC ) RK
        ,GROUPING(AREA_CD)||GROUPING(REGION_AREA)||GROUPING(PROD_ID) ARP
FROM SALE_TBL
WHERE area_cd = nvl(:area_cd,area_cd)
GROUP BY ROLLUP(PROD_ID,AREA_CD,REGION_AREA)
HAVING GROUPING(AREA_CD)||GROUPING(REGION_AREA)||GROUPING(PROD_ID) <> '111'
)a, CD_TBL b WHERE area_cd = cd_id(+)AND LENGTH(cd_id(+))=2
GROUP BY (AREA_CD,REGION_AREA,arp)
ORDER BY area_cd,DECODE(:RESULT,'D',-1,1)*TO_NUMBER(arp),region_area);