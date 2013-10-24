<?php /* Smarty version Smarty-3.1.8, created on 2012-05-16 10:57:50
         compiled from "smarty/templates/main.htm" */ ?>
<?php /*%%SmartyHeaderCode:18165566764fb36c0ebf98b4-79408831%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a2c5a104f72afbb25fbbc20253cf5638c2ca6ac9' => 
    array (
      0 => 'smarty/templates/main.htm',
      1 => 1337157691,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '18165566764fb36c0ebf98b4-79408831',
  'function' => 
  array (
  ),
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
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_4fb36c0eca7712_19817483',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_4fb36c0eca7712_19817483')) {function content_4fb36c0eca7712_19817483($_smarty_tpl) {?><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
<title><?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][1];?>
</title>
<link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['fds']->value;?>
" type="text/css">
</head>
<?php if (strlen($_smarty_tpl->tpl_vars['idFocus']->value)){?>
<body onload='document.getElementById("<?php echo $_smarty_tpl->tpl_vars['idFocus']->value;?>
").focus()'>
<?php }else{ ?>
<body>
<?php }?>
<script language="javascript" SRC="smarty/javascript/fonctions.js"></script>
<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['entete']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['corps']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['enpied']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

</body>
</html><?php }} ?>