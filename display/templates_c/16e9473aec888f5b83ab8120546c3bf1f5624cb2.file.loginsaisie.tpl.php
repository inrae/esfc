<?php /* Smarty version Smarty-3.1.8, created on 2012-05-16 11:01:30
         compiled from "smarty/templates/ident/loginsaisie.tpl" */ ?>
<?php /*%%SmartyHeaderCode:4059024494fb36ceab0bea6-82981549%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '16e9473aec888f5b83ab8120546c3bf1f5624cb2' => 
    array (
      0 => 'smarty/templates/ident/loginsaisie.tpl',
      1 => 1337157699,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '4059024494fb36ceab0bea6-82981549',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'list' => 0,
    'LANG' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_4fb36ceabebe14_82165932',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_4fb36ceabebe14_82165932')) {function content_4fb36ceabebe14_82165932($_smarty_tpl) {?><form method="post" action="index.php">
<input type="hidden" name="action" value="M"> 
<input type="hidden" name="id" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['id'];?>
">
	<input type="hidden" name="module" value="loginmodif">
	<input type="hidden" name="password" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['password'];?>
">

<table class="tablesaisie">
	<tr>
		<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][0];?>
 :</td>
		<td><input name="login" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['login'];?>
"></td>
	</tr>
	<tr>
		<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][9];?>
 :</td>
		<td><input name="nom" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['nom'];?>
"></td>
	</tr>
	<tr>
		<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][10];?>
 :</td>
		<td><input name="prenom" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['prenom'];?>
"></td>
	</tr>
	<tr>
		<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][8];?>
 :</td>
		<td><input name="mail" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['mail'];?>
"></td>
	</tr>
		<tr>
		<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][11];?>
 :</td>
		<td><input name="datemodif" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['datemodif'];?>
"></td>
	</tr>
	
	<tr>
		<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][1];?>
 :</td>
		<td><input type="password" name="pass1" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
	<tr>
		<td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['login'][12];?>
 :</td>
		<td><input type="password" name="pass2" onchange="verifieMdp(this.form.pass1, this.form.pass2)"></td>
	</tr>
</table>
<div align="center">
<input type="submit" name="valid" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][19];?>
"/>
 <input type="submit" name="suppr" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][20];?>
" onClick="javascript:setAction(this.form, this.form.action,'S')"/>
 </div>
</form>
<?php }} ?>