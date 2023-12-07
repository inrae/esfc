alter table evenement_type add column poisson_statut_id int;
ALTER TABLE evenement_type ADD CONSTRAINT poisson_statut_fk FOREIGN KEY (poisson_statut_id)
REFERENCES poisson_statut (poisson_statut_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
update evenement_type set poisson_statut_id = 2 where evenement_type_id = 16;

insert into dbversion(dbversion_number, dbversion_date) values ('23.2', '2023-12-07');
