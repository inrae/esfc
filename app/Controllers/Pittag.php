<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Pittag as LibrariesPittag;
use App\Libraries\Poisson;

class Pittag extends PpciController
{
    protected $lib;
    protected $poisson;
    function __construct()
    {
        $this->lib = new LibrariesPittag();
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
}
