create view v_bassin_poisson_last
as (select poisson_id, max(bassin_date_arrivee) as "last_date_arrivee"
from bassin_poisson
join poisson using (poisson_id)
where bassin_date_arrivee is not null
and poisson_statut_id not in (3, 4)
group by poisson_id);

