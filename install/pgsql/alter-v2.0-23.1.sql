alter table lot add COLUMN parent_lot_id integer;

COMMENT ON COLUMN public.lot.parent_lot_id IS E'Lot issued from an other';

ALTER TABLE public.lot ADD CONSTRAINT lot_parent_lot_id_fk FOREIGN KEY (parent_lot_id)
REFERENCES public.lot (lot_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;

select * from devenir_type;

insert into devenir_type (devenir_type_id, devenir_type_libelle)
values
(6, 'Création d''un lot dérivé');