<table class="tableaffichage">
<tr>
<td>
<label>Lot :</label> {$dataLot.lot_nom}
&nbsp;-&nbsp;
<label>Séquence de reproduction :</label> {$dataLot.annee}/
{$dataLot.sequence_nom} {$dataLot.croisement_nom}
{if $dataLot.vie_modele_id > 0}
<br><label>Marquage VIE le </label>{$dataLot.vie_date_marquage},
<label>modèle : </label> {$dataLot.couleur}, {$dataLot.vie_implantation_libelle}, {$dataLot.vie_implantation_libelle2}
{/if}
<br>
<label>Reproducteurs :</label> {$dataLot.parents}
<br><label>Date d'éclosion : </label>{$dataLot.eclosion_date}
<br>
<label>Nbre de larves estimé / compté :</label> {$dataLot.nb_larve_initial} / {$dataLot.nb_larve_compte}
</td>
</tr>
</table>
