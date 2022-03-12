CREATE TABLE ttx1 AS
SELECT rownum NO
	  ,chr(rownum+64)str 
FROM dual
CONNECT BY LEVEL <=5;


CREATE TABLE ttx2 AS
SELECT rownum NO
	  ,chr(rownum+64)str
FROM dual
CONNECT BY LEVEL <=3;


/* INNER JOIN 결과 - 동일 */

SELECT *
FROM ttx1 A, ttx2 b
WHERE a.NO = b.NO
AND b.str = 'C';

SELECT *
FROM ttx1 a INNER JOIN ttx2 b on(a.NO = b.no)
WHERE b.str = 'C';

SELECT *
FROM ttx1 a INNER JOIN ttx2 b ON(a.NO = b.NO AND b.str = 'C');



/* Outer JOIN 결과 - 동일 */

SELECT *
FROM ttx1 a, ttx2 b
WHERE a.NO = b.no(+)
AND b.str(+) = 'C';

SELECT *
FROM ttx1 a LEFT OUTER JOIN ttx2 b on(a.NO = b.NO AND b.str = 'C');


/* Outer JOIN 결과 - 오류 */

SELECT *
FROM ttx1 a LEFT OUTER JOIN ttx2 b on(a.NO = b.no)
WHERE b.str = 'C';




SELECT * FROM ttx1;

SELECT * FROM ttx2;