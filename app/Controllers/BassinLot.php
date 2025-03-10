<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\BassinLot as LibrariesBassinLot;
use App\Libraries\Lot;

class BassinLot extends PpciController
{
    protected $lib;
    protected $lot;
    function __construct()
    {
        $this->lib = new LibrariesBassinLot();
        $this->lot = new Lot;
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->lot->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->lot->display();
        } else {
            return $this->lib->change();
        }
    }
}
