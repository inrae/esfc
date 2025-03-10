<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\BassinCampagne as LibrariesBassinCampagne;

class BassinCampagne extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesBassinCampagne();
}
function display() {
return $this->lib->display();
}
function delete() {
if ($this->lib->delete()) {
return $this->list();
} else {
return $this->change();
}
}
function write() {
if ($this->lib->write()) {
return $this->display();
} else {
return $this->change();
}
}
function init() {
return $this->lib->init();
}
}
