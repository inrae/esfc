alter table poisson add column commentaire varchar null ;
comment on column poisson.commentaire is 'Commentaire général concernant le poisson';
