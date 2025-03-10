<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\SpermeCongelation as LibrariesSpermeCongelation;

class SpermeCongelation extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesSpermeCongelation();
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
function list() {
return $this->lib->list();
}
function generateVisotube() {
return $this->lib->generateVisotube();
}
}
