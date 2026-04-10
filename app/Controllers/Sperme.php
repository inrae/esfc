<?php

namespace App\Controllers;

use App\Libraries\PoissonCampagne;
use \Ppci\Controllers\PpciController;
use App\Libraries\Sperme as LibrariesSperme;

class Sperme extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesSperme();
    }
    function display()
    {
        return $this->lib->display();
    }
    function change()
    {
        if ( ! $this->lib->change()) {
            $poissonCampagne = new PoissonCampagne;
            return $poissonCampagne->display();
        }
    }
    function write()
    {
        $this->lib->write();
        return $this->lib->change();
    }
    function delete()
    {
        if ($this->lib->delete()) {
            $poissonCampagne = new PoissonCampagne;
            return $poissonCampagne->display();
        } else {
            return $this->lib->change();
        }
    }
}
