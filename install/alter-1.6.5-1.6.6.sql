/*
 * ajout de la saturation en oxygene dans les analyses d'eau
 */
 alter table analyse_eau add column o2_pc float;
 comment on column analyse_eau.o2_pc is 'Oxyg?ne dissous, en pourcentage de saturation';
 
