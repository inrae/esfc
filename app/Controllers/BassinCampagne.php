<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\BassinCampagne as LibrariesBassinCampagne;
use App\Libraries\Sequence;

class BassinCampagne extends PpciController
{
    protected $lib;
    protected $sequence;
    function __construct()
    {
        $this->lib = new LibrariesBassinCampagne();
        $this->sequence = new Sequence;
    }
    function display()
    {
        return $this->lib->display();
    }
    function delete()
    {
        if ($this->lib->delete()) {
            return $this->sequence->list();
        } else {
            return $this->sequence->list();
        }
    }
    function write()
    {
        if ($this->lib->write()) {
            return $this->lib->display();
        } else {
            return $this->lib->display();
        }
    }
    function init()
    {
         $this->lib->init();
         return $this->sequence->display();
    }
}
