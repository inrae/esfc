create group sturio_appli_g ;
create group sturio_gacl_g;
create role sturio_appli login inherit unencrypted password 'cha2ahLo' valid until '31-12-2050' in group sturio_modif_g;
create role sturio_gacl login inherit unencrypted password 'Ahs9eeDi' valid until '31-12-2050' in group sturio_gacl_g;
\c sturio;
create schema gacl;
alter schema gacl owner to sturio_gacl_g;

grant select, insert, update, delete on all tables in schema public to group sturio_appli_g;
grant all on all sequences in schema public to group sturio_appli_g;
grant execute on all functions in schema public to group sturio_appli_g;
grant usage on schema public to group sturio_appli_g;
alter default privileges in schema public grant select, insert, update, delete on tables to group sturio_appli_g;

alter role sturio_gacl in database sturio set search_path = gacl;
grant all on all tables in schema gacl to group sturio_gacl_g;
grant all on all sequences in schema gacl to group sturio_gacl_g;
grant usage on schema gacl to group sturio_gacl_g;

