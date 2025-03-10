<?php

namespace App\Controllers;

use App\Libraries\PoissonSequence;
use \Ppci\Controllers\PpciController;
use App\Libraries\PsEvenement as LibrariesPsEvenement;

class PsEvenement extends PpciController
{
    protected $lib;
    protected $poissonSequence;
    function __construct()
    {
        $this->lib = new LibrariesPsEvenement();
        $this->poissonSequence = new PoissonSequence;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->poissonSequence->change();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->poissonSequence->change();
        } else {
            return $this->lib->change();
        }
    }
}
