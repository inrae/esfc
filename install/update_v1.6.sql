alter table repartition add column repartition_name varchar;
comment on column repartition.repartition_name is 'Libellé permettant de nommer la répartition';

alter table sperme add column sperme_ph float;
comment on column sperme.sperme_ph is 'Valeur mesurée du pH du sperme';
