alter table distribution add column distribution_jour_soir varchar;
comment on column distribution.distribution_jour_soir is 'Distribution exclusivement le soir d''une demi-ration';
