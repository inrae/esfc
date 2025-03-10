<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\AnalyseEau as LibrariesAnalyseEau;

class AnalyseEau extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesAnalyseEau();
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
function graph() {
return $this->lib->graph();
}
}
