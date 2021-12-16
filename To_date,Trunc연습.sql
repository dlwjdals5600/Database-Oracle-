SELECT
TRUNC(TO_DATE('20211210','YYYYMMdd'),'year') year
,TRUNC(TO_DATE('20211210','YYYYMMdd'),'y') year
,TRUNC(TO_DATE('20211210','YYYYMMdd'),'month') month
,TRUNC(TO_DATE('20211210','YYYYMMdd'),'mm') month
,TRUNC(TO_DATE('20211210','YYYYMMdd'),'day') day
,TRUNC(TO_DATE('20211210','YYYYMMdd'),'d') day
from dual;