/*
 * esfc-SCIENCE - 2018-07-03
 * Script de creation des tables destinees a recevoir les donnees de l'application
 * database creation script
 * 
 * version minimale de Postgresql : 9.4. / Minimal release of postgresql: 9.4
 * 
 * Schemas par defaut : col pour les donnees, et gacl pour les droits. 
 * Default schemas : col for data, gacl for right management
 * Si vous voulez utiliser d'autres schemas, modifiez les scripts :
 * If you want use others schemas, change these scripts:
 * gacl_create_2.1.sql et col_create_2.1.sql 
 * Execution de ce script en ligne de commande, en etant connecte root :
 * at prompt, you cas execute this script as root:
 * su postgres -c "psql -f init_by_psql.sql"
 * 
 * dans la configuration de postgresql : / postgresql configuration:
 * /etc/postgresql/version/main/pg_hba.conf
 * inserez les lignes suivantes (connexion avec uniquement le compte esfc en local) :
 * insert theses lines (connection only with the account esfc on local server):
 * host    esfc             esfc             127.0.0.1/32            md5
 * host    all            esfc                  0.0.0.0/0               reject
 */
 
 /*
  * Creation du compte de connexion et de la base de donnees
  * creation of connection account
  */
CREATE USER esfc WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
 PASSWORD 'esfcPassword'  
;

/*
 * Database creation
 */
create database esfc owner esfc;
\c "dbname=esfc"
create extension pg_trgm schema pg_catalog;

/*
 * connexion a la base esfc, avec l'utilisateur esfc, en localhost,
 * depuis psql
 * Connection to esfc database with user esfc on localhost server
 */
\c "dbname=esfc user=esfc password=esfcPassword host=localhost"

/*
 * Creation des tables dans le schema gacl
 * Tables creation in schema gacl
 */
\ir pgsql/gacl_create.sql

/*
 * Creation des tables dans le schema col
 * Tables creation in schema col
 */
\ir pgsql/public_create.sql