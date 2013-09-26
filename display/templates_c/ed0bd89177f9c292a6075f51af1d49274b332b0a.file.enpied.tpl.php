<?php /* Smarty version Smarty-3.1.13, created on 2013-09-23 16:35:37
         compiled from "display/templates/enpied.tpl" */ ?>
<?php /*%%SmartyHeaderCode:905065314514aeb846aa514-56032233%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ed0bd89177f9c292a6075f51af1d49274b332b0a' => 
    array (
      0 => 'display/templates/enpied.tpl',
      1 => 1358779396,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '905065314514aeb846aa514-56032233',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_514aeb846f19d8_16372852',
  'variables' => 
  array (
    'LANG' => 0,
    'melappli' => 0,
    'developpementMode' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_514aeb846f19d8_16372852')) {function content_514aeb846f19d8_16372852($_smarty_tpl) {?><div id="footer">
<?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][23];?>

<br>
<?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][24];?>

<br>
<?php echo $_smarty_tpl->tpl_vars['LANG']->value['message'][25];?>

<a href="<?php echo $_smarty_tpl->tpl_vars['melappli']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['melappli']->value;?>
</a>
<?php if (strlen($_smarty_tpl->tpl_vars['developpementMode']->value)>1){?>
<br>
<div class="red"><?php echo $_smarty_tpl->tpl_vars['developpementMode']->value;?>
</div>
<?php }?>
</div>
<?php }} ?>