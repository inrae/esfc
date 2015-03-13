create view v_bassin_poisson_last
as (select poisson_id, max(bassin_date_arrivee) as "last_date_arrivee"
from bassin_poisson
join poisson using (poisson_id)
where bassin_date_arrivee is not null
and poisson_statut_id not in (3, 4)
group by poisson_id);

create view v_pittag_by_poisson
as (
select poisson_id, array_to_string(array_agg(pittag_valeur),' ') as pittag_valeur
from pittag
group by poisson_id);

create view v_transfert_last_bassin_for_poisson as (
select poisson_id, max(transfert_date) as "transfert_date_last"
from transfert
group by poisson_id)
;
