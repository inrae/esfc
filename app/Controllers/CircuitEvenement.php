<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\CircuitEvenement as LibrariesCircuitEvenement;

class CircuitEvenement extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesCircuitEvenement();
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
