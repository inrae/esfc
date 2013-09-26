<?php /* Smarty version Smarty-3.1.8, created on 2012-05-16 11:01:10
         compiled from "smarty/templates/ident/login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:14691574284fb36cd63b8697-49711557%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c17ccda40531ba8cb3dd1aed53e3a0f70e0163a5' => 
    array (
      0 => 'smarty/templates/ident/login.tpl',
      1 => 1337091999,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '14691574284fb36cd63b8697-49711557',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'module' => 0,
    'LANG' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_4fb36cd6447dd0_64439611',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_4fb36cd6447dd0_64439611')) {function content_4fb36cd6447dd0_64439611($_smarty_tpl) {?>	<form method="POST" action="index.php">
	<table class="tablesaisie">
	<tr>
	<input type="hidden" name="module" value=<?php echo $_smarty_tpl->tpl_vars['module']->value;?>
>
	<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][0];?>
 :</td><td> <input name="login" maxlength="32"></td>
	</tr>
	<tr><td>
	<?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][1];?>
 :</td><td><input name="password" type="password" maxlength="32"></td>
	</tr>
	<tr>
	<td><input type="submit"></td><td> <input type="reset"></td>
	</tr>
	</table>
<?php }} ?>