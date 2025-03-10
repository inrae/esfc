<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Croisement as LibrariesCroisement;

class Croisement extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesCroisement();
    }
    function change()
    {
        return $this->lib->change();
    }
    function display()
    {
        return $this->lib->display();
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
    function list()
    {
        return $this->lib->list();
    }
}
