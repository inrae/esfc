<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Devenir as LibrariesDevenir;
use App\Libraries\Lot;

class Devenir extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesDevenir();
    }
    function list()
    {
        return $this->lib->list();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->goBack();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->goBack();
        } else {
            return $this->lib->change();
        }
    }
    function goBack() {
        if ($_REQUEST["devenirOrigine"] == "lot") {
            $lot = new Lot;
            return $lot->display();
        } else {
            return $this->lib->list();
        }
    }
}
