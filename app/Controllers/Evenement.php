<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Evenement as LibrariesEvenement;
use App\Libraries\Poisson;

class Evenement extends PpciController
{
    protected $lib;
    protected $poisson;
    function __construct()
    {
        $this->lib = new LibrariesEvenement();
        $this->poisson = new Poisson;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->poisson->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->poisson->display();
        } else {
            return $this->lib->change();
        }
    }
    function getAllCSV()
    {
        return $this->lib->getAllCSV();
    }
}
