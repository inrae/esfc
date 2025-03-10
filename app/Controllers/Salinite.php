<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Salinite as LibrariesSalinite;

class Salinite extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesSalinite();
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
