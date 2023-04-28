<h2>Modification d'un site</h2>

<a href="index.php?module=siteList">Retour à la liste des sites</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="site" method="post" action="index.php?module=siteWrite">
<input type="hidden" name="site_id" value="{$data.site_id}">
<dl>
<dt>
Nom du site <span class="red">*</span> :
</dt>
<dd>
<input name="site_name" type="text" value="{$data.site_name}" required autofocus/>
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.site_id > 0 &&($droits["paramAdmin"] == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="site_id" value="{$data.site_id}">
<input type="hidden" name="module" value="siteDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>