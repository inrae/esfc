<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\SpermeUtilise as LibrariesSpermeUtilise;

class SpermeUtilise extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesSpermeUtilise();
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
