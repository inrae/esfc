	<form method="POST" action="index.php">
	<table class="tablesaisie">
	<tr>
	<input type="hidden" name="module" value={$module}>
<<<<<<< HEAD
	<td>{$LANG.login.0} :</td><td> <input name="login" maxlength="32" autofocus></td>
=======
	<td>{$LANG.login.0} :</td><td> <input name="login" maxlength="32"></td>
>>>>>>> sourceforge/master
	</tr>
	<tr><td>
	{$LANG.login.1} :</td><td><input name="password" type="password" maxlength="32"></td>
	</tr>
	<tr>
	<td><input type="submit"></td><td> <input type="reset"></td>
	</tr>
	</table>
