SELECT AREA_CD AREACD
,REGION_AREA REGIONAREA
,PROD_ID PRODID
,SUM(SALE_CNT) SALECNT
FROM SALE_TBL
WHERE AREA_CD = :areaCd
AND ROWNUM = 1
GROUP BY AREA_CD
,REGION_AREA
,PROD_ID;


SELECT PRODID
 		,PRODNM
 		,SALECNT
 FROM MSALES;
 

SELECT PRODID
 		,PRODNM
 		,SALECNT
 FROM MSALES
 WHERE PRODID like :argProdId || '%'
 AND PRODNM like :argProdNM || '%';
 




SELECT COUNT(*) CNT
 FROM EXAM_RSLT;
 
SELECT CNT
FROM EXAM_RSLT;


SELECT SYSDATE UTILCURRENTDATE
,SYSDATE SQLCURRENTDATE
,SYSDATE  SQLCURRENTTIMESTAMP
,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') CURRENTSTRDATE
,CURRENT_TIMESTAMP SQLDBCURRENTTIMESTAMP
FROM DUAL



SELECT * FROM album;

SELECT * FROM song;

SELECT * FROM ARTIST;



SELECT ALBUM_ID
		,SONG_NAME
		,PLAY_TIME
FROM SONG
WHERE ALBUM_ID = :album_id;


SELECT MST_ID
		,MST_NAME
		,DEBUT_DATE
FROM ARTIST
WHERE MST_ID = :mst_id;


SELECT ALBUM_ID
		,MST_ID
		,ALBUM_SEQ
		,ALBUM_TITLE
		,OPEN_DATE
FROM ALBUM
WHERE ALBUM_ID = :album_id;