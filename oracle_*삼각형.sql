select LPAD('*', DECODE(SIGN(:CNT/2-ROWNUM),-1,:CNT-ROWNUM,ROWNUM),'*') NO
from(
	select case when 10 < :CNT
			THEN TRUNC(DECODE(MOD(:CNT,2),0,:CNT,:CNT+1),-1)
			ELSE 10 END CNT
from dual
connect by level < case when 10 < :CNT
						THEN TRUNC(DECODE(MOD(:CNT,2),0,:CNT,:CNT+1),-1)
					ELSE 10 END
);

