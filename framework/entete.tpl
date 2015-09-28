<h1><img src="favicon.png" width="40">{$LANG.message.1}

<div style="position:absolute;top:15px;right:5px";width="100">
<a href='index.php?module=setlanguage&langue=fr'>
<img src='display/images/drapeau_francais.png' height='20' border='0'>
</a>
<a href='index.php?module=setlanguage&langue=en'>
<img src='display/images/drapeau_anglais.png' height='20' border='0'>
</a>
&nbsp;
{if $ident_type == "BDD" || $ident_type == "LDAP-BDD"}
<a href='index.php?module=loginChangePassword'>
<img src='display/images/key.png' height='20' border='0'>
</a>
&nbsp;
{/if}
</div>
</h1>
<div class="menu">{$menu}</div>
<div class="titre2">{$message}</div>
