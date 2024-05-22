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
 CREATE OR REPLACE VIEW public.v_vie_modele
AS SELECT vm.vie_modele_id,
    vm.annee,
    vm.couleur,
    vm.vie_implantation_id,
    vm.vie_implantation_id2,
    i.vie_implantation_libelle,
    i2.vie_implantation_libelle AS vie_implantation_libelle2
   FROM vie_modele vm
     JOIN vie_implantation i ON vm.vie_implantation_id = i.vie_implantation_id
     LEFT OUTER JOIN vie_implantation i2 ON vm.vie_implantation_id2 = i2.vie_implantation_id;
insert into dbversion(dbversion_number, dbversion_date) values ('24.2', '2024-04-17');