<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Sequence as LibrariesSequence;

class Sequence extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesSequence();
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
}
