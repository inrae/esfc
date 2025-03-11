<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Echographie as LibrariesEchographie;
use App\Libraries\PoissonCampagne;

class Echographie extends PpciController
{
    protected $lib;
    protected $poissonCampagne;
    function __construct()
    {
        $this->lib = new LibrariesEchographie();
        $this->poissonCampagne = new PoissonCampagne;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->poissonCampagne->display();
        } else {
            return $this->poissonCampagne->display();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->poissonCampagne->display(); 
        } else {
            return $this->lib->change();
        }
    }
}
