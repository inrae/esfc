<form method="post" action="index.php">
<input type="hidden" name="id" value="{$data.id}">
<input type="hidden" name="module" value="loginChangePasswordExec">
<table class="tablesaisie">
	<tr>
		<td>{$LANG.login.23} :</td>
		<td><input type="password" name="oldPassword" size="20" autofocus></td>
	</tr>
	<tr>
		<td>{$LANG.login.24} :</td>
		<td><input type="password" id="pass1" name="pass1" size="20" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
	<tr>
		<td>{$LANG.login.12} :</td>
		<td><input type="password" id="pass2" name="pass2" size="20" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
	<tr>
		<td colspan="2">
			<div align="center">
			<input type="submit">
			</div>
		</td>
	</tr>
</table>
</form>