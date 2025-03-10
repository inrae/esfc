<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Submenu as LibrariesSubmenu;

class Submenu extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesSubmenu();
}
function parametres() {
return $this->lib->parametres();
}
function index() {
return $this->lib->index();
}
}
