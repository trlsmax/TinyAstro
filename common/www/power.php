<?php
if (isset($_POST['action'])) {
    switch ($_POST['action']) {
        case 'reboot':
            reboot();
            break;
        case 'halt':
            halt();
            break;
    }
}

function reboot() {
    passthru("sudo reboot");
    exit;
}

function halt() {
    passthru("sudo halt");
    exit;
}
?>
