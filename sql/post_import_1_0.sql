select setval('evenement_evenement_id_seq',(select max(evenement_id)  from evenement));
select setval('morphologie_morphologie_id_seq',(select max(morphologie_id)  from morphologie));
select setval('pathologie_pathologie_id_seq',(select max(pathologie_id)  from pathologie));
select setval('poisson_poisson_id_seq',(select max(poisson_id)  from poisson));
select setval('pittag_pittag_id_seq',(select max(pittag_id)  from pittag));
select setval('gender_selection_gender_selection_id_seq',(select max(gender_selection_id)  from gender_selection));

select setval('gender_methode_gender_methode_id_seq',(select max(gender_methode_id)  from gender_methode));
select setval('poisson_statut_poisson_statut_id_seq',(select max(poisson_statut_id)  from poisson_statut));
select setval('sexe_sexe_id_seq',(select max(sexe_id)  from sexe));
select setval('pathologie_type_pathologie_type_id_seq',(select max(pathologie_type_id)  from pathologie_type));
select setval('evenement_type_evenement_type_id_seq',(select max(evenement_type_id)  from evenement_type));

