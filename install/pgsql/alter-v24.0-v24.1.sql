insert into dbparam (dbparam_name, dbparam_value)
values 
('CSAddress','https://collec-science.mysociety.com'),
('CSLogin', 'account'),
('CSToken', 'token'),
('CSCollectionId','1'),
('CSCollectionName','collection'),
('CSApiConsultUrl','index.php?module=apiv1sampleList'),
('CSApiCreateUrl', 'index.php?module=apiv1sampleWrite'),
('CSSampleTypeName', 'Visotube'),
('CSCertificatePath', ''),
('CSDebugMode', '0')
;
alter table sperme_mesure add column concentration double precision;
COMMENT ON COLUMN sperme_mesure.concentration IS E'Concentration, en milliard/mL';
insert into dbversion(dbversion_number, dbversion_date) values ('24.1', '2024-03-25');


