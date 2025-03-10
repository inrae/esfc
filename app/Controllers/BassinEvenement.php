<?php

namespace App\Controllers;

use App\Libraries\Bassin;
use \Ppci\Controllers\PpciController;
use App\Libraries\BassinEvenement as LibrariesBassinEvenement;

class BassinEvenement extends PpciController
{
    protected $lib;
    protected $bassin;
    function __construct()
    {
        $this->lib = new LibrariesBassinEvenement();
        $this->bassin = new Bassin;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->bassin->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->bassin->display();
        } else {
            return $this->lib->change();
        }
    }
}
