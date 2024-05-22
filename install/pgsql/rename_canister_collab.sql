update col.object o 
set identifier = split_part(identifier,'-',1)||'-'||
split_part(identifier,'-',2)||split_part(identifier,'-',3)||split_part(identifier,'-',4)
||'-0000-'||split_part(identifier,'-',5) 
from col.sample s
where o.uid = s.uid 
and collection_id = 20
and regexp_count(identifier, '-') = 4;