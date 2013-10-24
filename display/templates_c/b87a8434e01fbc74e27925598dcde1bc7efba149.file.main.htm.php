<?php /* Smarty version Smarty-3.1.13, created on 2013-09-23 16:35:37
         compiled from "display/templates/main.htm" */ ?>
<?php /*%%SmartyHeaderCode:73218200514aeb8452aae1-92847895%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'b87a8434e01fbc74e27925598dcde1bc7efba149' => 
    array (
      0 => 'display/templates/main.htm',
      1 => 1362751876,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '73218200514aeb8452aae1-92847895',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_514aeb84652512_50488288',
  'variables' => 
  array (
    'LANG' => 0,
    'fds' => 0,
    'idFocus' => 0,
    'entete' => 0,
    'corps' => 0,
    'enpied' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_514aeb84652512_50488288')) {function content_514aeb84652512_50488288($_smarty_tpl) {?><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][1];?>
</title>
<link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['fds']->value;?>
" type="text/css">
<link rel="icon" type="image/png" href="/favicon.png" />
</head>
<?php if (strlen($_smarty_tpl->tpl_vars['idFocus']->value)){?>
<body onload='document.getElementById("<?php echo $_smarty_tpl->tpl_vars['idFocus']->value;?>
").focus()'>
<?php }else{ ?>
<body>
<?php }?>
<script language="javascript" SRC="display/javascript/fonctions.js"></script>
<?php echo $_smarty_tpl->getSubTemplate ("dataTables.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['entete']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['corps']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['enpied']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

</body>
</html><?php }} ?>