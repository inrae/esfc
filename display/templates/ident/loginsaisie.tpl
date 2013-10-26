<form method="post" action="index.php">
<input type="hidden" name="action" value="M"> 
<input type="hidden" name="id" value="{$list.id}">
	<input type="hidden" name="module" value="loginmodif">
	<input type="hidden" name="password" value="{$list.password}">

<table class="tablesaisie">
	<tr>
		<td>{$LANG.login.0} :</td>
		<td><input name="login" value="{$list.login}" autofocus></td>
	</tr>
	<tr>
		<td>{$LANG.login.9} :</td>
		<td><input name="nom" value="{$list.nom}"></td>
	</tr>
	<tr>
		<td>{$LANG.login.10} :</td>
		<td><input name="prenom" value="{$list.prenom}"></td>
	</tr>
	<tr>
		<td>{$LANG.login.8} :</td>
		<td><input name="mail" value="{$list.mail}"></td>
	</tr>
		<tr>
		<td>{$LANG.login.11} :</td>
		<td><input name="datemodif" value="{$list.datemodif}"></td>
	</tr>
	
	<tr>
		<td>{$LANG.login.1} :</td>
		<td><input type="password" name="pass1" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
	<tr>
		<td>{$LANG.login.12} :</td>
		<td><input type="password" name="pass2" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
</table>
<div align="center">
<input type="submit" name="valid" value="{$LANG.message.19}"/>
 <input type="submit" name="suppr" value="{$LANG.message.20}" onClick="javascript:setAction(this.form, this.form.action,'S')"/>
 </div>
</form>
