
ALTER TABLE sturio.public.distribution ADD COLUMN distribution_consigne VARCHAR;

ALTER TABLE sturio.public.repart_aliment DROP COLUMN distribution;

ALTER TABLE sturio.public.repart_aliment DROP COLUMN distribution_semaine;

ALTER TABLE sturio.public.repart_aliment ADD COLUMN matin REAL;

ALTER TABLE sturio.public.repart_aliment ADD COLUMN midi REAL;

ALTER TABLE sturio.public.repart_aliment ADD COLUMN nuit REAL;

ALTER TABLE sturio.public.repart_aliment ADD COLUMN soir REAL;

ALTER TABLE sturio.public.distribution ADD COLUMN repart_template_id INTEGER NOT NULL;
ALTER TABLE sturio.public.distribution ADD CONSTRAINT repart_template_distribution_fk
FOREIGN KEY (repart_template_id)
REFERENCES sturio.public.repart_template (repart_template_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.repartition ADD COLUMN dimanche SMALLINT;

ALTER TABLE sturio.public.repartition ADD COLUMN jeudi SMALLINT;

ALTER TABLE sturio.public.repartition ADD COLUMN lundi SMALLINT;

ALTER TABLE sturio.public.repartition ADD COLUMN mardi SMALLINT;

ALTER TABLE sturio.public.repartition ADD COLUMN mercredi SMALLINT;

ALTER TABLE sturio.public.repartition ADD COLUMN samedi SMALLINT;

ALTER TABLE sturio.public.repartition ADD COLUMN vendredi SMALLINT;

alter table distribution add column distribution_masse real;

comment on column distribution.distribution_masse is 'Masse (poids) des poissons dans le bassin';

alter table aliment add column aliment_libelle_court varchar(8);
comment on column aliment.aliment_libelle_court is 'Nom de l''aliment - 8 caractères';
