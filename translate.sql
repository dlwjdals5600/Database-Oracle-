select concat('a','bbb')
,'a'||'bbb'||'cc'
from dual;

select lpad('0',5,'@')
from dual
connect by level <=5;


select replace('dfadfa','df','#')
		,translate('dfadfa','df','#')
from dual;


select var_phone
		,translate(var_phone,' 4310256789',' ')
from(
select '안9녕8하7세6요5 4H3 2입1니0다' as var_phone
from dual);




select translate('안9녕8하7세6요5 4H3 2입 1니 0다','안4398765210 ','안  ')
from dual;



select var_phone
	,translate(var_phone,' 0123456789',' ')
	,translate(var_phone,'0123456789'||var_phone,'0123456789')
from(
select '안9fwef8하9123 입니23다' as var_phone
from dual)