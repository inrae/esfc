<h2>Modification EXEMPLE</h2>

<a href="index.php?module=exampleList">Retour à la liste</a>
{if $data.idExample > 0}
<a href="index.php?module=exampleDisplay&idExample={$data.idExample}">Retour au détail</a>
{/if}
<table class="tablesaisie">
<script type="text/javascript" src="display/javascript/calendar/calendar.js"></script>
<script type="text/javascript" src="display/javascript/calendar/lang/calendar-fr.js"></script>
<script type="text/javascript" src="display/javascript/calendar/calendar-setup.js"></script>
<style type="text/css">@import url(display/javascript/calendar/aqua/theme.css);</style>
<form method="post" action="index.php?module=exampleWrite" onSubmit='return validerForm("dateExample:la date est obligatoire,comment:le commentaire est obligatoire")'>
<input type="hidden" name="action" value="M">
<input type="hidden" name="idExample" value="{$data.idExample}">
<input type="hidden" name="idParent" value="{$data.idParent}">
<tr>
<td class="libelleSaisie">Date <span class="red">*</span> :</td>
<td class="datamodif">
<input id="dateExample" name="dateExample" value="{$data.dateExample}" maxlengh="10" size="10">
<img id='button1' src='display/javascript/calendar/images/calendar.png' class='calendrier' alt='Calendrier' title='Calendrier'>
<script type='text/javascript'>calendarini("dateExample","button1")</script>
</td>
</tr>
<tr>
<td class="libelleSaisie">Commentaire <span class="red">*</span> :</td>
<td class="datamodif">
<input id="comment" name="comment" value="{$data.comment}" maxlengh="255" size="45"></td>
</tr>

<tr>
<td colspan="2"><div align="center">
<input type="submit" value="Enregistrer">
</form>
{if $data.idExample>0&&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression()'>
<input type="hidden" name="idExample" value="{$data.idExample}">
<input type="hidden" name="idParent" value="{$data.idParent}">
<input type="hidden" name="module" value="exampleDelete">
<input type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>