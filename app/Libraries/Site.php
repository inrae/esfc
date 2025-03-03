<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class  extends PpciLibrary { 
    /**
     * @var 
     */
    protected PpciModel $dataclass;
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
require_once 'modules/classes/site.class.php';
$this->dataclass = new Site;
$keyName = "site_id";
$this->id = $_REQUEST[$keyName];
	function list(){
$this->vue=service('Smarty');
		/**
		 * Display the list of all records of the table
		 */
		$this->vue->set($this->dataclass->getListe(2), "data");
		$this->vue->set("parametre/siteList.tpl", "corps");
		}
	function change(){
$this->vue=service('Smarty');
		$this->dataRead( $this->id, "parametre/siteChange.tpl");
		}
	    function write() {
    try {
                        $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST[$this->keyName] = $this->id;
            return true;
        } catch (PpciException $e) {
            return false;
        }
}
	   function delete() {
		/**
		 * delete record
		 */
		 try {
            $this->dataDelete($this->id);
            return true;
        } catch (PpciException $e) {
            return false;
        }
		}
}
