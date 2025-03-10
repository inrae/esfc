<?php

namespace App\Controllers;

use App\Libraries\Lot;
use \Ppci\Controllers\PpciController;
use App\Libraries\LotMesure as LibrariesLotMesure;

class LotMesure extends PpciController
{
    protected $lib;
    protected $lot;
    function __construct()
    {
        $this->lib = new LibrariesLotMesure();
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
