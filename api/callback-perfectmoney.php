<?php

define("IN_SITE", true);
require_once __DIR__ . "/../libs/db.php";
require_once __DIR__ . "/../libs/lang.php";
require_once __DIR__ . "/../libs/helper.php";
require_once __DIR__ . "/../libs/database/users.php";
$CMSNT = new DB();
$Mobile_Detect = new Mobile_Detect();
if($_SERVER["REQUEST_METHOD"] == "POST") {
    $perfectmoney_pass = $CMSNT->site("perfectmoney_pass");
    $string = $_POST["PAYMENT_ID"] . ":" . $_POST["PAYEE_ACCOUNT"] . ":" . $_POST["PAYMENT_AMOUNT"] . ":" . $_POST["PAYMENT_UNITS"] . ":" . $_POST["PAYMENT_BATCH_NUM"] . ":" . $_POST["PAYER_ACCOUNT"] . ":" . strtoupper(md5($perfectmoney_pass)) . ":" . $_POST["TIMESTAMPGMT"];
    $hash = strtoupper(md5($string));
    if($hash == $_POST["V2_HASH"]) {
        $invoice_id = check_string($_POST["PAYMENT_ID"]);
        $amount = check_string($_POST["PAYMENT_AMOUNT"]);
        if($row = $CMSNT->get_row("SELECT * FROM `payment_pm` WHERE `payment_id` = '" . $invoice_id . "' AND `status` = 0 ")) {
            $total_money = $CMSNT->site("perfectmoney_rate") * $amount;
            $isUpdate = $CMSNT->update("payment_pm", ["amount" => $amount, "price" => $total_money, "update_date" => gettime(), "update_time" => time(), "status" => 1], " `id` = '" . $row["id"] . "' ");
            if($isUpdate) {
                $getUser = $CMSNT->get_row(" SELECT * FROM `users` WHERE `id` = '" . $row["user_id"] . "' ");
                $total_money = $CMSNT->site("rate_pm") * $amount;
                $isCong = $User->AddCredits($row["user_id"], $total_money, __("Nạp tiền tự động qua Perfect Money") . " #" . $invoice_id, "TOPUP_PM_" . $invoice_id);
                if($isCong) {
                    $my_text = $CMSNT->site("noti_recharge");
                    $my_text = str_replace("{domain}", $_SERVER["SERVER_NAME"], $my_text);
                    $my_text = str_replace("{username}", getRowRealtime("users", $row["user_id"], "username"), $my_text);
                    $my_text = str_replace("{method}", "Perfect Money", $my_text);
                    $my_text = str_replace("{amount}", $amount, $my_text);
                    $my_text = str_replace("{price}", $total_money, $my_text);
                    $my_text = str_replace("{time}", gettime(), $my_text);
                    sendMessAdmin($my_text);
                    $CMSNT->insert("deposit_log", ["user_id" => $row["user_id"], "method" => "Perfect Money", "amount" => $total_money, "received" => $total_money, "create_time" => time(), "is_virtual" => 0]);
                    exit("cộng tiền thành công");
                }
                exit("đã cộng tiền rồi");
            }
            exit("không thể cập nhật hóa đơn");
        }
    }
}

?>