<?php
namespace App\Controllers;
use App\Controllers\BaseController;
use App\Libraries\Defaultpage as LibrariesDefaultPage;

class Defaultpage extends BaseController
{
    public function display()
    {
        $lib = new LibrariesDefaultpage;
        return ($lib->display());
    }
}