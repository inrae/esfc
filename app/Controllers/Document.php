<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Document as LibrariesDocument;

class Document extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesDocument();
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
function get() {
return $this->lib->get();
}
function changeData() {
return $this->lib->changeData();
}
function writeData() {
return $this->lib->writeData();
}
}
