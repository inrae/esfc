<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Repartition as LibrariesRepartition;

class Repartition extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesRepartition();
}
function list() {
return $this->lib->list();
}
function change() {
return $this->lib->change();
}
function create() {
return $this->lib->create();
}
function duplicate() {
return $this->lib->duplicate();
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
function print() {
return $this->lib->print();
}
function resteChange() {
return $this->lib->resteChange();
}
function resteWrite() {
return $this->lib->resteWrite();
}
}
