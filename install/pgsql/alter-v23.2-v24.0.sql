alter table sperme_congelation rename column nb_visiotube to nb_visotube;
alter table sperme_freezing_place rename column nb_visiotube to nb_visotube;
COMMENT ON COLUMN sperme_freezing_place.nb_visotube IS E'Nombre de visotubes utilisés';
COMMENT ON COLUMN sperme_congelation.nb_visotube IS E'Nombre de visotubes utilisés';
