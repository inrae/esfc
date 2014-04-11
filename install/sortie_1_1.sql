ALTER TABLE sturio.public.poisson ADD COLUMN categorie_id INTEGER DEFAULT 2 NOT NULL;
update poisson set categorie_id = poisson_categorie_id;

ALTER TABLE sturio.public.poisson ADD CONSTRAINT categorie_poisson_fk
FOREIGN KEY (categorie_id)
REFERENCES sturio.public.categorie (categorie_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.public.poisson DROP CONSTRAINT poisson_categorie_poisson_fk;
ALTER TABLE sturio.public.poisson DROP COLUMN poisson_categorie_id;
DROP TABLE sturio.public.poisson_categorie;
