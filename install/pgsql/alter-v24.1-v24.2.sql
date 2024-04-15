 create or REPLACE VIEW public.v_prenom_parents as (
 select p.poisson_id,
 array_to_string (array_agg(
 case when length(ppp.prenom) > 0 then
 ppp.matricule || ' ('|| ppp.prenom || ')'  else  ppp.matricule end
 order by ppp.sexe_id desc, ppp.matricule
 ),', ') as parents
 from poisson p
 join parent_poisson pp on (p.poisson_id = pp.poisson_id)
 join poisson ppp on (pp.parent_id = ppp.poisson_id)
 where p.poisson_statut_id = 1
 group by p.poisson_id, p.matricule, p.prenom
 )
 ;