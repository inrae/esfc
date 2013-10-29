<?php /* Smarty version Smarty-3.1.13, created on 2013-10-29 11:28:06
         compiled from "display/templates/ident/login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2053856794514aeb846787e9-69043894%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'bb4a7671ac1151d71e9d87cee795126bafd13d0e' => 
    array (
      0 => 'display/templates/ident/login.tpl',
      1 => 1383042479,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2053856794514aeb846787e9-69043894',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_514aeb846a7992_36634229',
  'variables' => 
  array (
    'module' => 0,
    'LANG' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_514aeb846a7992_36634229')) {function content_514aeb846a7992_36634229($_smarty_tpl) {?>	<form method="POST" action="index.php">
	<table class="tablesaisie">
	<tr>
	<input type="hidden" name="module" value=<?php echo $_smarty_tpl->tpl_vars['module']->value;?>
>
	<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][0];?>
 :</td><td> <input name="login" maxlength="32" autofocus></td>
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