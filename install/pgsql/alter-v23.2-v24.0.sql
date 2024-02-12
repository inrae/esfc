alter table sperme_congelation rename column nb_visiotube to nb_visotube;
alter table sperme_freezing_place rename column nb_visiotube to nb_visotube;
COMMENT ON COLUMN sperme_freezing_place.nb_visotube IS E'Nombre de visotubes utilisés';
COMMENT ON COLUMN sperme_congelation.nb_visotube IS E'Nombre de visotubes utilisés';
alter table sperme_congelation add column paillette_volume float4;
COMMENT ON COLUMN public.sperme_congelation.paillette_volume IS E'Volume par paillette, en ml (0,5 ou 5 ml)';
alter table sperme_congelation add column operateur varchar;
COMMENT ON COLUMN public.sperme_congelation.operateur IS E'Personne ayant réalisé la congélation';
