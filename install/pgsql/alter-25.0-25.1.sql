
alter table poisson add column lot_id integer;
ALTER TABLE poisson ADD CONSTRAINT lot_fk FOREIGN KEY (lot_id)
REFERENCES lot (lot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
alter table devenir_type add column evenement_type_id integer;
ALTER TABLE devenir_type ADD CONSTRAINT evenement_type_fk FOREIGN KEY (evenement_type_id)
REFERENCES evenement_type (evenement_type_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
insert into dbversion (dbversion_number, dbversion_date) values ('25.1','2025-06-02');
