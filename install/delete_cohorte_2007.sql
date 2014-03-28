/*select count(*)
 from poisson where cohorte = '2007';
 */
 
delete from morphologie supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';

delete from mortalite supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';

delete from pittag supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';

delete from cohorte supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';

delete from pathologie supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';

delete from gender_selection supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';

delete from transfert supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';

delete from evenement supp
using poisson p
where p.poisson_id = supp.poisson_id
and cohorte = '2007';




delete from poisson where cohorte = '2007';

select count(*) from poisson;
