<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Morphologie as LibrariesMorphologie;

class Morphologie extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesMorphologie();
    }
    function import()
    {
        return $this->lib->import();
    }
    function matching()
    {
        return $this->lib->matching();
    }
    function control()
    {
        return $this->lib->control();
    }
    function exec()
    {
        return $this->lib->exec();
    }
}
