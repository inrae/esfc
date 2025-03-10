<?php

namespace App\Controllers;

use App\Libraries\Croisement;
use \Ppci\Controllers\PpciController;
use App\Libraries\SpermeUtilise as LibrariesSpermeUtilise;

class SpermeUtilise extends PpciController
{
    protected $lib;
    protected $croisement;
    function __construct()
    {
        $this->lib = new LibrariesSpermeUtilise();
        $this->croisement = new Croisement;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->croisement->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->croisement->display();
        } else {
            return $this->lib->change();
        }
    }
}
