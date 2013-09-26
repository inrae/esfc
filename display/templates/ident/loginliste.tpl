<a href="index.php?module=loginmodif&id=0">{$LANG.login.5}</a>
<table>
	<tr>
		<th>{$LANG.login.6}</td>
		<th>{$LANG.login.7}</td>
		<th>{$LANG.login.8}</td>
		<tr>
	 {section name=lst loop=$liste}
	<tr>
		<td><a href="index.php?module=loginmodif&id={$liste[lst].id}">{$liste[lst].login}</a></td>
		<td>{$liste[lst].nom}&nbsp;{$liste[lst].prenom}</td>
		<td>{$liste[lst].mail}&nbsp;</td>
	</tr>
	{/section}
</table>

