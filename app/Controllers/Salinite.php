<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Salinite as LibrariesSalinite;

class Salinite extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesSalinite();
}
function change() {
return $this->lib->change();
}
function new() {
return $this->lib->new();
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
