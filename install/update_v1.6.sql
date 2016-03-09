alter table repartition add column repartition_name varchar;
comment on column repartition.repartition_name is 'Libellé permettant de nommer la répartition';
