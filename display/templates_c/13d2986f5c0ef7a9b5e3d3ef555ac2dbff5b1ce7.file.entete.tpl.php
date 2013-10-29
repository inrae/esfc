<?php /* Smarty version Smarty-3.1.13, created on 2013-10-29 11:05:29
         compiled from "display/templates/entete.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1104711688514aeb846587b7-72497464%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '13d2986f5c0ef7a9b5e3d3ef555ac2dbff5b1ce7' => 
    array (
      0 => 'display/templates/entete.tpl',
      1 => 1380125076,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1104711688514aeb846587b7-72497464',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_514aeb84675b81_47076255',
  'variables' => 
  array (
    'LANG' => 0,
    'menu' => 0,
    'message' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_514aeb84675b81_47076255')) {function content_514aeb84675b81_47076255($_smarty_tpl) {?><h1><img src="display/images/tux-lamp.jpg" width="40"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][1];?>

<span style="text-align:right;display:inline">
<a href='index.php?module=setlanguage&langue=fr'>
<img src='display/images/drapeau_francais.png' height='20' border='0'>
</a>
<a href='index.php?module=setlanguage&langue=en'>
<img src='display/images/drapeau_anglais.png' height='20' border='0'>
</a>
</span>
</h1>
<div class="menu"><?php echo $_smarty_tpl->tpl_vars['menu']->value;?>
</div>
<div class="titre2"><?php echo $_smarty_tpl->tpl_vars['message']->value;?>
</div>
<?php }} ?>