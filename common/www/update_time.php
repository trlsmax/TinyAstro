<?php
passthru("sudo date -s " . "\"" . $_GET['date'] . " " . $_GET['time'] . "\"");
?>

