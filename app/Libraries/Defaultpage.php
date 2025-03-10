<?php

namespace App\Libraries;

use App\Models\Mortalite;
use Ppci\Libraries\PpciLibrary;

class Defaultpage extends PpciLibrary
{

    function display()
    {
        /**
         * Generate the graph of mortality
         */

        if ($_SESSION["userRights"]["manage"] == 1) {

            $mortalite = new Mortalite;
            $type = $_COOKIE["mortalityType"];
            if (empty($type)) {
                $type = 1;
            }
            $nbyears = $_COOKIE["nbyears"];
            if (empty($nbyears) || !is_numeric($nbyears) || $nbyears < 1) {
                $nbyears = 1;
            }
            if ($nbyears == 1) {
                $years = "1 year";
            } else {
                $years = $nbyears . " years";
            }
            $data = $mortalite->getCumulativeMortality($type, date('Y-m-d'), $years);
            $di = array();
            $max = 0;
            foreach ($data as $row) {
                $di[$row["typology"]][] = array(
                    "date" => $row["mortalite_date"],
                    "nombre" => $row["nombre_cumule"]
                );
                if ($row["nombre_cumule"] > $max) {
                    $max = $row["nombre_cumule"];
                }
            }
            if ($_SESSION["locale"] == "fr" || $_SESSION["locale"] == "en") {
                $dateFormat = "%d/%m/%Y";
            } else  if ($_SESSION["locale"] == "us") {
                $dateFormat = "%m/%d/%Y";
            }
            $dc = array("xFormat" => $dateFormat);
            $i = 1;
            foreach ($di as $k => $v) {
                if (empty($k)) {
                    $k = _("Inconnu");
                }
                $dc["xs"][$k] = "x" . $i;
                $vdate = array("x" . $i);
                $vval = array($k);
                foreach ($v as $line) {
                    $vdate[] = $line["date"];
                    $vval[] = $line["nombre"];
                }
                $dc["columns"][] = $vdate;
                $dc["columns"][] = $vval;
                $i++;
            }
            $this->vue = service("smarty");
            $this->vue->set(json_encode($dc), "data");
            $this->vue->htmlVars[] = "data";
            $this->vue->set($dateFormat, "dateFormat");
            $this->vue->set($max, "max");
            $this->vue->set($type, "type");
            $this->vue->set(1, "displayMortality");
            $this->vue->set($nbyears, "nbyears");
        } else {
            $this->vue->set(0, "displayMortality");
        }
        return $this->vue->send();
    }
}
