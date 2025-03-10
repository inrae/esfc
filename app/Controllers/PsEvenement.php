<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\PsEvenement as LibrariesPsEvenement;

class PsEvenement extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesPsEvenement();
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
