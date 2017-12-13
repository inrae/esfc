<?php
/**
 * Created : 13 déc. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
if (strlen($t_module["param"]) > 0) {
    $filename = "doc/" . $t_module["param"];
    if (file_exists($filename)) {
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $content_type = finfo_file($finfo, $filename);
        finfo_close($finfo);
    }
    header('Content-Type: ' . $content_type);
    header('Content-Transfer-Encoding: binary');
    header('Content-Length: ' . filesize($filename));
    /*
     * Ajout des entetes de cache
     */
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: no-cache');
    
    /*
     * Envoi au navigateur
     */
    ob_clean();
    flush();
    readfile($filename);
}
?>