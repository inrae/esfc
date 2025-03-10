<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Bassin as LibrariesBassin;

class Bassin extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesBassin();
    }
    function list()
    {
        return $this->lib->list();
    }
    function display()
    {
        return $this->lib->display();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->lib->display();
        } else {
            return $this->lib->change();
        }
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->lib->list();
        } else {
            return $this->lib->change();
        }
    }
    function calculMasseAjax()
    {
        return $this->lib->calculMasseAjax();
    }
    function recapAlim()
    {
        return $this->lib->recapAlim();
    }
    function bassinPoissonTransfert()
    {
        return $this->lib->bassinPoissonTransfert();
    }
}
