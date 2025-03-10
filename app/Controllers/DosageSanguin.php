<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\DosageSanguin as LibrariesDosageSanguin;
use App\Libraries\PoissonCampagne;

class DosageSanguin extends PpciController
{
    protected $lib;
    protected $poissonCampagne;
    function __construct()
    {
        $this->lib = new LibrariesDosageSanguin();
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
            return $this->lib->change();
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
