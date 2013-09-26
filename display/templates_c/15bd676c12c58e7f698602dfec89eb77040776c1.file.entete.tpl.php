<?php /* Smarty version Smarty-3.1.8, created on 2012-05-16 10:57:50
         compiled from "smarty/templates/entete.tpl" */ ?>
<?php /*%%SmartyHeaderCode:20033464934fb36c0ecacd17-15453908%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '15bd676c12c58e7f698602dfec89eb77040776c1' => 
    array (
      0 => 'smarty/templates/entete.tpl',
      1 => 1337157943,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '20033464934fb36c0ecacd17-15453908',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'LANG' => 0,
    'menu' => 0,
    'message' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_4fb36c0ecc2c40_91498055',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_4fb36c0ecc2c40_91498055')) {function content_4fb36c0ecc2c40_91498055($_smarty_tpl) {?><h1><img src="smarty/images/tux-lamp.jpg" width="40"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][1];?>
</h1>
<div class="menu"><?php echo $_smarty_tpl->tpl_vars['menu']->value;?>
</div>
<div class="titre2"><?php echo $_smarty_tpl->tpl_vars['message']->value;?>
</div>
<?php }} ?>