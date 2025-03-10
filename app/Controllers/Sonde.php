<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Sonde as LibrariesSonde;

class Sonde extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesSonde();
}
function import() {
return $this->lib->import();
}
function importExec() {
return $this->lib->importExec();
}
}
