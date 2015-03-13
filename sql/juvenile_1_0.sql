alter table poisson add column date_naissance date;
comment on column poisson.date_naissance is 'Date de naissance du poisson';

alter table pittag add column pittag_commentaire varchar;
comment on column pittag.pittag_commentaire is 'Commentaire sur la pose du pittag';
