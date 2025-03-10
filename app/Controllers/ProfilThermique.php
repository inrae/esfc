<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\ProfilThermique as LibrariesProfilThermique;

class ProfilThermique extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesProfilThermique();
    }
    function change()
    {
        return $this->lib->change();
    }
    function new()
    {
        return $this->lib->new();
    }
    function write()
    {
        $this->lib->write();
        return $this->lib->new();
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->lib->new();
        } else {
            return $this->lib->change();
        }
    }
}
