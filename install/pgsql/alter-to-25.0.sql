set search_path = esfc,gacl;
alter table dbparam add column dbparam_description varchar;
alter table dbparam add column dbparam_description_en varchar;
create unique index if not exists dbparamname_idx on dbparam (dbparam_name);
insert into dbparam (dbparam_name, dbparam_value, dbparam_description, dbparam_description_en)
values (
'APPLI_code', 
'code_of_instance',
'Code de l''instance, pour les exportations',
'Code of the instance, to export data'
) 
on conflict do nothing;
alter table acllogin add column email varchar;
alter table logingestion add column if not exists is_expired boolean;
alter table logingestion add column if not exists nbattempts integer;
alter table logingestion add column if not exists lastattempt datetime;

update aclgroup set groupe = 'manage' where groupe = 'gestion';
update aclaco set aco = 'manage' where aco = 'gestion';
insert into dbparam(dbparam_name, dbparam_value, dbparam_description, dbparam_description_en)
values 
('code_type_evenement_pour_echographie', '28', 'Code du type d''évenement lors de la création directe d''une échographie', 'Event type code when creating an ultrasound scan directly')
;
insert into dbparam(dbparam_name, dbparam_value, dbparam_description, dbparam_description_en)
values 
('code_usage_bassin_pour_reproduction', '7', 'Code du type d''usage du bassin utilisé pour la reproduction', 'Code for the type of use of the pool used for reproduction')
;
insert into dbversion (dbversion_number, dbversion_date) values ('25.0','2025-03-24');