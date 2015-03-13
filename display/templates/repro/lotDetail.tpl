{if $droits.reproGestion == 1}
<a href="index.php?module=lotChange&lot_id={$dataLot.lot_id}">Modifier le lot</a>
{/if}
<table class="tableaffichage">
<tr>
<td>
Lot : {$dataLot.lot_nom}
&nbsp;-&nbsp;
Séquence de reproduction : {$dataLot.annee}/
{$dataLot.sequence_nom}

<br>
Reproducteurs : {$dataLot.parents}
<br>
Nbre de larves initial : {$dataLot.nb_larve_initial}
</td>
</tr>
</table>
