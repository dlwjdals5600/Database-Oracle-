
SELECT
	nm
	,substr(max(score||subject),3) subject
	,max(score)
FROM STD_SCORE
GROUP BY nm;


SELECT 
nm
,max(score||subject) subject
,max(score)
FROM STD_SCORE
GROUP BY nm;


SELECT
	nm
	,substr(max(score||subject||score),4,2) subject
	,max(score)
FROM STD_SCORE
GROUP BY nm;

SELECT nm, max(score||subject||score) subject
FROM std_score
GROUP BY nm;


--substr -> ("문자열","시작위치","길이") 문자단위로 시작위치와 자를 길이를 지정하여 문자열을 자른다.