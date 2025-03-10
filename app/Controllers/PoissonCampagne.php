<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\PoissonCampagne as LibrariesPoissonCampagne;

class PoissonCampagne extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesPoissonCampagne();
}
function list() {
return $this->lib->list();
}
function display() {
return $this->lib->display();
}
function change() {
return $this->lib->change();
}
function write() {
if ($this->lib->write()) {
return $this->display();
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
function changeStatut() {
return $this->lib->changeStatut();
}
function init() {
return $this->lib->init();
}
function recalcul() {
return $this->lib->recalcul();
}
}
