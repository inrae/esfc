
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
