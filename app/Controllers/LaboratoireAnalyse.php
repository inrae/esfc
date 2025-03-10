<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\LaboratoireAnalyse as LibrariesLaboratoireAnalyse;

class LaboratoireAnalyse extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesLaboratoireAnalyse();
}
function list() {
return $this->lib->list();
}
function change() {
return $this->lib->change();
}
function write() {
if ($this->lib->write()) {
return $this->list();
} else {
return $this->change();
}
}
function delete() {
if ($this->lib->delete()) {
return $this->list();
} else {
return $this->change();
}
}
}
