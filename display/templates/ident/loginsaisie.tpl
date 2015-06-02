<form method="post" action="index.php">
<input type="hidden" name="id" value="{$data.id}">
	<input type="hidden" name="module" value="loginwrite">
	<input type="hidden" name="password" value="{$data.password}">

<table class="tablesaisie">
	<tr>
		<td>{$LANG.login.0} :</td>
		<td><input id="login" name="login" value="{$data.login}" autofocus></td>
	</tr>
	<tr>
		<td>{$LANG.login.9} :</td>
		<td><input id="nom" name="nom" value="{$data.nom}"></td>
	</tr>
	<tr>
		<td>{$LANG.login.10} :</td>
		<td><input id="prenom" name="prenom" value="{$data.prenom}"></td>
	</tr>
	<tr>
		<td>{$LANG.login.8} :</td>
		<td><input id="mail" name="mail" value="{$data.mail}"></td>
	</tr>
		<tr>
		<td>{$LANG.login.11} :</td>
		<td><input id="datemodif" name="datemodif" value="{$data.datemodif}" readonly></td>
	</tr>
	
	<tr>
		<td>{$LANG.login.1} :</td>
		<td><input type="password" autocomplete="off" id="pass1" name="pass1" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
	<tr>
		<td>{$LANG.login.12} :</td>
		<td><input type="password" id="pass2" autocomplete="off" name="pass2" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
	<tr>
	<td>{$LANG.login.21} :</td>
	<td><input type="button" name="generate" value="{$LANG.login.22}" onclick="getPassword('pass1', 'pass2', 'motdepasse')">
	<br>
	<input name="motdepasse" id="motdepasse" size="20">
	<tr>
		<td>{$LANG.login.13} :</td>
		<td><input type="radio" name="actif" value="1" {if $data.actif == 1}checked{/if}>{$LANG.message.yes}<br>
		<input type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if}>{$LANG.message.no}
		</td>
	</tr>
	<tr>
	<td colspan=2>
	<div align="center">
<input type="submit" name="valid" value="{$LANG.message.19}"/>
</form>
{if $data.id>0}
<form action="index.php" method="post" onSubmit='return confirmSuppression()'>
<input type="hidden" name="id" value="{$data.id}">
<input type="hidden" name="module" value="logindelete">
<input type="submit" value="Supprimer">
</form>
{/if}
 </div>
 </td>
 </tr>
</table>

</form>
