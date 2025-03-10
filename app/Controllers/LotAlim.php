<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\LotAlim as LibrariesLotAlim;

class LotAlim extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesLotAlim();
    }
    function index()
    {
        return $this->lib->generate();
    }
    function generate()
    {
        return $this->lib->generate();
    }
}
