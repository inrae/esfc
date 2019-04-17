<h1><img src="display/images/sturio.png" height="30">{$LANG.message.1}
<div class="header_right">
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
{if $isConnected == 1}
<img src='display/images/key_green.png' height='20' border='0' title="{$LANG['message'].33}">
{else}
<img src='display/images/key_red.png' height='20' border='0' title="{$LANG['message'].8}">
{/if}
</div>
</h1>
<div class="menu">{$menu}</div>
<div class="titre2">{$message}</div>