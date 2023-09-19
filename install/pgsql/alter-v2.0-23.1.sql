alter table lot add COLUMN parent_lot_id integer;

COMMENT ON COLUMN public.lot.parent_lot_id IS E'Lot issued from an other';

ALTER TABLE public.lot ADD CONSTRAINT lot_parent_lot_id_fk FOREIGN KEY (parent_lot_id)
REFERENCES public.lot (lot_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;

select * from devenir_type;

insert into devenir_type (devenir_type_id, devenir_type_libelle)
values
(6, 'Création d''un lot dérivé');

insert into dbversion(dbversion_number, dbversion_date) values ('23.1', '2023-09-19');


/*
 * Pour Ruthenus
 */
update ruthenus.pittag set pittag_valeur = replace(pittag_valeur, '95500000', '955.00000')
where pittag_valeur like '95500000%';
