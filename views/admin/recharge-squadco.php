<?php

if(!defined("IN_SITE")) {
    exit("The Request Not Found");
}
$body = ["title" => __("Recharge Squadco"), "desc" => "CMSNT Panel", "keyword" => "cmsnt, CMSNT, cmsnt.co,"];
$body["header"] = "\n<script src=\"https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.6/clipboard.min.js\"></script>\n\n";
$body["footer"] = "\n<!-- ckeditor -->\n<script src=\"" . BASE_URL("public/ckeditor/ckeditor.js") . "\"></script>\n";
require_once __DIR__ . "/../../models/is_admin.php";
require_once __DIR__ . "/header.php";
require_once __DIR__ . "/sidebar.php";
require_once __DIR__ . "/nav.php";
if(!checkPermission($getUser["admin"], "view_recharge")) {
    exit("<script type=\"text/javascript\">if(!alert(\"Bạn không có quyền sử dụng tính năng này\")){window.history.back();}</script>");
}
if(isset($_POST["SaveSettings"])) {
    if($CMSNT->site("status_demo") != 0) {
        exit("<script type=\"text/javascript\">if(!alert(\"" . __("This function cannot be used because this is a demo site") . "\")){window.history.back().location.reload();}</script>");
    }
    if(!checkPermission($getUser["admin"], "edit_recharge")) {
        exit("<script type=\"text/javascript\">if(!alert(\"Bạn không có quyền sử dụng tính năng này\")){window.history.back();}</script>");
    }
    $Mobile_Detect = new Mobile_Detect();
    $CMSNT->insert("logs", ["user_id" => $getUser["id"], "ip" => myip(), "device" => $Mobile_Detect->getUserAgent(), "createdate" => gettime(), "action" => __("Cấu hình nạp tiền Squadco")]);
    foreach ($_POST as $key => $value) {
        $CMSNT->update("settings", ["value" => $value], " `name` = '" . $key . "' ");
    }
    $my_text = $CMSNT->site("noti_action");
    $my_text = str_replace("{domain}", $_SERVER["SERVER_NAME"], $my_text);
    $my_text = str_replace("{username}", $getUser["username"], $my_text);
    $my_text = str_replace("{action}", __("Cấu hình nạp tiền Squadco"), $my_text);
    $my_text = str_replace("{ip}", myip(), $my_text);
    $my_text = str_replace("{time}", gettime(), $my_text);
    sendMessAdmin($my_text);
    exit("<script type=\"text/javascript\">if(!alert(\"" . __("Save successfully!") . "\")){window.history.back().location.reload();}</script>");
} else {
    if(isset($_GET["limit"])) {
        $limit = (int) check_string($_GET["limit"]);
    } else {
        $limit = 10;
    }
    if(isset($_GET["page"])) {
        $page = check_string((int) $_GET["page"]);
    } else {
        $page = 1;
    }
    $from = ($page - 1) * $limit;
    $where = " `id` > 0  ";
    $shortByDate = "";
    $transaction_ref = "";
    $createdate = "";
    $amount = "";
    $user_id = "";
    $username = "";
    if(!empty($_GET["username"])) {
        $username = check_string($_GET["username"]);
        if($idUser = $CMSNT->get_row(" SELECT * FROM `users` WHERE `username` = '" . $username . "' ")) {
            $where .= " AND `user_id` =  \"" . $idUser["id"] . "\" ";
        } else {
            $where .= " AND `user_id` =  \"\" ";
        }
    }
    if(!empty($_GET["user_id"])) {
        $user_id = check_string($_GET["user_id"]);
        $where .= " AND `user_id` = " . $user_id . " ";
    }
    if(!empty($_GET["transaction_ref"])) {
        $transaction_ref = check_string($_GET["transaction_ref"]);
        $where .= " AND `transaction_ref` LIKE \"%" . $transaction_ref . "%\" ";
    }
    if(!empty($_GET["amount"])) {
        $amount = check_string($_GET["amount"]);
        $where .= " AND `amount` = " . $amount . " ";
    }
    if(!empty($_GET["create_gettime"])) {
        $create_gettime = check_string($_GET["create_gettime"]);
        $createdate = $create_gettime;
        $create_gettime_1 = str_replace("-", "/", $create_gettime);
        $create_gettime_1 = explode(" to ", $create_gettime_1);
        if($create_gettime_1[0] != $create_gettime_1[1]) {
            $create_gettime_1 = [$create_gettime_1[0] . " 00:00:00", $create_gettime_1[1] . " 23:59:59"];
            $where .= " AND `create_gettime` >= '" . $create_gettime_1[0] . "' AND `create_gettime` <= '" . $create_gettime_1[1] . "' ";
        }
    }
    if(isset($_GET["shortByDate"])) {
        $shortByDate = check_string($_GET["shortByDate"]);
        $yesterday = date("Y-m-d", strtotime("-1 day"));
        $currentWeek = date("W");
        $currentMonth = date("m");
        $currentYear = date("Y");
        $currentDate = date("Y-m-d");
        if($shortByDate == 1) {
            $where .= " AND `create_gettime` LIKE '%" . $currentDate . "%' ";
        }
        if($shortByDate == 2) {
            $where .= " AND YEAR(create_gettime) = " . $currentYear . " AND WEEK(create_gettime, 1) = " . $currentWeek . " ";
        }
        if($shortByDate == 3) {
            $where .= " AND MONTH(create_gettime) = '" . $currentMonth . "' AND YEAR(create_gettime) = '" . $currentYear . "' ";
        }
    }
    $listDatatable = $CMSNT->get_list(" SELECT * FROM `payment_squadco` WHERE " . $where . " ORDER BY `id` DESC LIMIT " . $from . "," . $limit . " ");
    $totalDatatable = $CMSNT->num_rows(" SELECT * FROM `payment_squadco` WHERE " . $where . " ORDER BY id DESC ");
    $urlDatatable = pagination(base_url_admin("recharge-squadco&limit=" . $limit . "&shortByDate=" . $shortByDate . "&create_gettime=" . $createdate . "&transaction_ref=" . $transaction_ref . "&amount=" . $amount . "&user_id=" . $user_id . "&username=" . $username . "&"), $from, $totalDatatable, $limit);
    $yesterday = date("Y-m-d", strtotime("-1 day"));
    $currentWeek = date("W");
    $currentMonth = date("m");
    $currentYear = date("Y");
    $currentDate = date("Y-m-d");
    $total_yesterday = (int) $CMSNT->get_row("SELECT SUM(amount) FROM payment_squadco WHERE  `create_gettime` LIKE '%" . $yesterday . "%' ")["SUM(amount)"];
    $total_today = $CMSNT->get_row("SELECT SUM(amount) FROM payment_squadco WHERE  `create_gettime` LIKE '%" . $currentDate . "%' ")["SUM(amount)"];
    $total_all_time = $CMSNT->get_row("SELECT SUM(amount) FROM payment_squadco ")["SUM(amount)"];
    echo "\n<div class=\"main-content app-content\">\n    <div class=\"container-fluid\">\n        <div class=\"d-md-flex d-block align-items-center justify-content-between my-4 page-header-breadcrumb\">\n            <h1 class=\"page-title fw-semibold fs-18 mb-0\">Phương thức thanh toán Squadco Nigeria</h1>\n        </div>\n        <div class=\"row\">\n            <div class=\"col-xl-12\">\n                <div class=\"text-right\">\n                    <button type=\"button\" id=\"open-card-config\" class=\"btn btn-primary label-btn mb-3\">\n                        <i class=\"ri-settings-4-line label-btn-icon me-2\"></i> CẤU HÌNH\n                    </button>\n                </div>\n            </div>\n            <div class=\"col-xl-12\" id=\"card-config\" style=\"display: none;\">\n                <div class=\"card custom-card\">\n                    <div class=\"card-body\">\n                        <form action=\"\" method=\"POST\" enctype=\"multipart/form-data\">\n                            <div class=\"row\">\n                                <div class=\"col-lg-12 col-xl-6\">\n                                    <div class=\"row mb-4\">\n                                        <label class=\"col-sm-7 col-form-label\"\n                                            for=\"example-hf-email\">";
    echo __("Trạng thái");
    echo "</label>\n                                        <div class=\"col-sm-5\">\n                                            <select class=\"form-control\" name=\"squadco_status\">\n                                                <option ";
    echo $CMSNT->site("squadco_status") == 1 ? "selected" : "";
    echo "                                                    value=\"1\">ON\n                                                </option>\n                                                <option ";
    echo $CMSNT->site("squadco_status") == 0 ? "selected" : "";
    echo "                                                    value=\"0\">\n                                                    OFF\n                                                </option>\n                                            </select>\n                                        </div>\n                                    </div>\n                                    <div class=\"row mb-4\">\n                                        <label class=\"col-sm-4 col-form-label\" for=\"example-hf-email\">Currency</label>\n                                        <div class=\"col-sm-8\">\n                                            <input type=\"text\" class=\"form-control\"\n                                                value=\"";
    echo $CMSNT->site("squadco_currency_code");
    echo "\"\n                                                name=\"squadco_currency_code\">\n                                        </div>\n                                    </div>\n                                    <div class=\"row mb-4\">\n                                        <label class=\"col-sm-7 col-form-label\"\n                                            for=\"example-hf-email\">";
    echo __("1 " . $CMSNT->site("squadco_currency_code") . " is equal to how many VNĐ");
    echo "</label>\n                                        <div class=\"col-sm-5\">\n                                            <div class=\"input-group\">\n                                                <input type=\"text\" class=\"form-control\"\n                                                    value=\"";
    echo $CMSNT->site("squadco_rate");
    echo "\" name=\"squadco_rate\"\n                                                    placeholder=\"\">\n                                                <span class=\"input-group-text\">\n                                                    ";
    echo $CMSNT->get_row(" SELECT `code` FROM `currencies` WHERE `display` = 1 AND `default_currency` = 1")["code"];
    echo "                                                </span>\n                                            </div>\n                                        </div>\n                                    </div>\n                                </div>\n                                <div class=\"col-lg-12 col-xl-6\">\n                                    <div class=\"row mb-4\">\n                                        <label class=\"col-sm-4 col-form-label\" for=\"example-hf-email\">Secret\n                                            Key</label>\n                                        <div class=\"col-sm-8\">\n                                            <input type=\"text\" class=\"form-control\"\n                                                value=\"";
    echo $CMSNT->site("squadco_Secret_Key");
    echo "\"\n                                                name=\"squadco_Secret_Key\">\n                                        </div>\n                                    </div>\n                                    <div class=\"row mb-4\">\n                                        <label class=\"col-sm-4 col-form-label\" for=\"example-hf-email\">Public\n                                            key</label>\n                                        <div class=\"col-sm-8\">\n                                            <input type=\"text\" class=\"form-control\"\n                                                value=\"";
    echo $CMSNT->site("squadco_Public_Key");
    echo "\"\n                                                name=\"squadco_Public_Key\">\n                                        </div>\n                                    </div>\n                                </div>\n                                <div class=\"col-lg-12 col-xl-12\">\n                                    <div class=\"row mb-4\">\n                                        <label class=\"col-sm-6 col-form-label\"\n                                            for=\"example-hf-email\">";
    echo __("Note");
    echo "</label>\n                                        <div class=\"col-sm-12\">\n                                            <textarea id=\"squadco_notice\"\n                                                name=\"squadco_notice\">";
    echo $CMSNT->site("squadco_notice");
    echo "</textarea>\n                                        </div>\n                                    </div>\n                                </div>\n                            </div>\n                            <div class=\"d-grid gap-2 mb-4\">\n                                <button type=\"submit\" name=\"SaveSettings\" class=\"btn btn-primary btn-block\"><i\n                                        class=\"fa fa-fw fa-save me-1\"></i>\n                                    ";
    echo __("Save");
    echo "</button>\n                            </div>\n                        </form>\n                    </div>\n                </div>\n            </div>\n            <div class=\"col-xl-5\">\n                <div class=\"row\">\n                    <div class=\"col-xl-6\">\n                        <div class=\"card custom-card\">\n                            <div class=\"card-body\">\n                                <div class=\"d-flex align-items-center\">\n                                    <div class=\"flex-fill\">\n                                        <p class=\"mb-1 fs-5 fw-semibold text-default\">\n                                            ";
    echo format_currency($total_all_time);
    echo "</p>\n                                        <p class=\"mb-0 text-muted\">Toàn thời gian</p>\n                                    </div>\n                                    <div class=\"ms-2\">\n                                        <span class=\"avatar text-bg-danger rounded-circle fs-20\"><i\n                                                class='bx bxs-wallet-alt'></i></span>\n                                    </div>\n                                </div>\n                            </div>\n                        </div>\n                    </div>\n                    <div class=\"col-xl-6\">\n                        <div class=\"card custom-card\">\n                            <div class=\"card-body\">\n                                <div class=\"d-flex align-items-center\">\n                                    <div class=\"flex-fill\">\n                                        <p class=\"mb-1 fs-5 fw-semibold text-default\">\n                                            ";
    echo format_currency($CMSNT->get_row("SELECT SUM(amount) FROM payment_squadco WHERE  MONTH(create_gettime) = '" . $currentMonth . "' AND YEAR(create_gettime) = '" . $currentYear . "' ")["SUM(amount)"]);
    echo "                                        </p>\n                                        <p class=\"mb-0 text-muted\">Tháng ";
    echo date("m");
    echo "</p>\n                                    </div>\n                                    <div class=\"ms-2\">\n                                        <span class=\"avatar text-bg-info rounded-circle fs-20\"><i\n                                                class='bx bxs-wallet-alt'></i></span>\n                                    </div>\n                                </div>\n                            </div>\n                        </div>\n                    </div>\n                    <div class=\"col-xl-6\">\n                        <div class=\"card custom-card\">\n                            <div class=\"card-body\">\n                                <div class=\"d-flex align-items-center\">\n                                    <div class=\"flex-fill\">\n                                        <p class=\"mb-1 fs-5 fw-semibold text-default\">\n                                            ";
    echo format_currency($CMSNT->get_row("SELECT SUM(amount) FROM payment_squadco WHERE  YEAR(create_gettime) = " . $currentYear . " AND WEEK(create_gettime, 1) = " . $currentWeek . " ")["SUM(amount)"]);
    echo "                                        </p>\n                                        <p class=\"mb-0 text-muted\">Trong tuần</p>\n                                    </div>\n                                    <div class=\"ms-2\">\n                                        <span class=\"avatar text-bg-warning rounded-circle fs-20\"><i\n                                                class='bx bxs-wallet-alt'></i></span>\n                                    </div>\n                                </div>\n                            </div>\n                        </div>\n                    </div>\n                    <div class=\"col-xl-6\">\n                        <div class=\"card custom-card\">\n                            <div class=\"card-body\">\n                                <div class=\"d-flex align-items-center\">\n                                    <div class=\"flex-fill\">\n                                        <p class=\"mb-1 fs-5 fw-semibold text-default\">\n                                            ";
    echo format_currency($total_today);
    echo "</p>\n                                        <p class=\"mb-0 text-muted\">Hôm nay\n                                            ";
    if($total_yesterday != 0) {
        $revenueGrowth = ($total_today - $total_yesterday) / $total_yesterday * 100;
        if(0 < $revenueGrowth) {
            echo "<span class=\"fs-12 text-success ms-2\"><i class=\"ti ti-trending-up me-1 d-inline-block\"></i>" . round($revenueGrowth, 2) . "% </span>";
        } elseif($revenueGrowth < 0) {
            echo "<span class=\"fs-12 text-danger ms-2\"><i class=\"ti ti-trending-down me-1 d-inline-block\"></i>" . round(abs($revenueGrowth), 2) . "% </span>";
        }
    }
    echo "\n                                        </p>\n                                    </div>\n                                    <div class=\"ms-2\">\n                                        <span class=\"avatar text-bg-primary rounded-circle fs-20\"><i\n                                                class='bx bxs-wallet-alt'></i></span>\n                                    </div>\n                                </div>\n                            </div>\n                        </div>\n                    </div>\n                </div>\n            </div>\n            <div class=\"col-xl-7\">\n                <div class=\"card custom-card\">\n                    <div class=\"card-header\">\n                        <div class=\"card-title\">THỐNG KÊ NẠP TIỀN THÁNG ";
    echo date("m");
    echo "</div>\n                    </div>\n                    <div class=\"card-body\">\n                        <canvas id=\"chartjs-line\" class=\"chartjs-chart\"></canvas>\n                        <script>\n                        (function() {\n                            /* line chart  */\n                            Chart.defaults.borderColor = \"rgba(142, 156, 173,0.1)\", Chart.defaults.color =\n                                \"#8c9097\";\n                            const labels = [\n                                ";
    $month = date("m");
    $year = date("Y");
    $numOfDays = cal_days_in_month(CAL_GREGORIAN, $month, $year);
    for ($day = 1; $day <= $numOfDays; $day++) {
        echo "\"" . $day . "/" . $month . "/" . $year . "\",";
    }
    echo "                            ];\n                            const data = {\n                                labels: labels,\n                                datasets: [{\n                                    label: 'Paid',\n                                    backgroundColor: 'rgb(132, 90, 223)',\n                                    borderColor: 'rgb(132, 90, 223)',\n                                    data: [\n                                        ";
    $data = [];
    for ($day = 1; $day <= $numOfDays; $day++) {
        $date = $year . "-" . $month . "-" . $day;
        $row = $CMSNT->get_row("SELECT SUM(price) FROM payment_squadco WHERE DATE(create_gettime) = '" . $date . "' ");
        $data[$day - 1] = $row["SUM(price)"];
    }
    for ($i = 0; $i < $numOfDays; $i++) {
        echo $data[$i] . ",";
    }
    echo "                                    ],\n                                }]\n                            };\n                            const config = {\n                                type: 'bar',\n                                data: data,\n                                options: {}\n                            };\n                            const myChart = new Chart(\n                                document.getElementById('chartjs-line'),\n                                config\n                            );\n\n\n\n                        })();\n                        </script>\n                    </div>\n                </div>\n            </div>\n            <div class=\"col-xl-12\">\n                <div class=\"card custom-card\">\n                    <div class=\"card-header justify-content-between\">\n                        <div class=\"card-title\">\n                            LỊCH SỬ NẠP TIỀN SQUADCO TỰ ĐỘNG\n                        </div>\n                    </div>\n                    <div class=\"card-body\">\n                        <form action=\"\" class=\"align-items-center mb-3\" name=\"formSearch\" method=\"GET\">\n                            <div class=\"row row-cols-lg-auto g-3 mb-3\">\n                                <input type=\"hidden\" name=\"module\" value=\"admin\">\n                                <input type=\"hidden\" name=\"action\" value=\"recharge-squadco\">\n                                <div class=\"col-md-3 col-6\">\n                                    <input class=\"form-control form-control-sm\" value=\"";
    echo $user_id;
    echo "\" name=\"user_id\"\n                                        placeholder=\"";
    echo __("Search ID User");
    echo "\">\n                                </div>\n                                <div class=\"col-md-3 col-6\">\n                                    <input class=\"form-control form-control-sm\" value=\"";
    echo $username;
    echo "\" name=\"username\"\n                                        placeholder=\"";
    echo __("Search Username");
    echo "\">\n                                </div>\n                                <div class=\"col-md-3 col-6\">\n                                    <input class=\"form-control form-control-sm\" value=\"";
    echo $transaction_ref;
    echo "\"\n                                        name=\"transaction_ref\" placeholder=\"";
    echo __("Transaction");
    echo "\">\n                                </div>\n                                <div class=\"col-md-3 col-6\">\n                                    <input class=\"form-control form-control-sm\" value=\"";
    echo $amount;
    echo "\" name=\"amount\"\n                                        placeholder=\"";
    echo __("Amount");
    echo "\">\n                                </div>\n                                <div class=\"col-lg col-md-4 col-6\">\n                                    <input type=\"text\" name=\"create_gettime\" class=\"form-control form-control-sm\"\n                                        id=\"daterange\" value=\"";
    echo $createdate;
    echo "\" placeholder=\"Chọn thời gian\">\n                                </div>\n                                <div class=\"col-12\">\n                                    <button class=\"btn btn-sm btn-primary\"><i class=\"fa fa-search\"></i>\n                                        ";
    echo __("Search");
    echo "                                    </button>\n                                    <a class=\"btn btn-sm btn-danger\" href=\"";
    echo base_url_admin("recharge-squadco");
    echo "\"><i\n                                            class=\"fa fa-trash\"></i>\n                                        ";
    echo __("Clear filter");
    echo "                                    </a>\n                                </div>\n                            </div>\n                            <div class=\"top-filter\">\n                                <div class=\"filter-show\">\n                                    <label class=\"filter-label\">Show :</label>\n                                    <select name=\"limit\" onchange=\"this.form.submit()\"\n                                        class=\"form-select filter-select\">\n                                        <option ";
    echo $limit == 5 ? "selected" : "";
    echo " value=\"5\">5</option>\n                                        <option ";
    echo $limit == 10 ? "selected" : "";
    echo " value=\"10\">10</option>\n                                        <option ";
    echo $limit == 20 ? "selected" : "";
    echo " value=\"20\">20</option>\n                                        <option ";
    echo $limit == 50 ? "selected" : "";
    echo " value=\"50\">50</option>\n                                        <option ";
    echo $limit == 100 ? "selected" : "";
    echo " value=\"100\">100</option>\n                                        <option ";
    echo $limit == 500 ? "selected" : "";
    echo " value=\"500\">500</option>\n                                        <option ";
    echo $limit == 1000 ? "selected" : "";
    echo " value=\"1000\">1000\n                                        </option>\n                                    </select>\n                                </div>\n                                <div class=\"filter-short\">\n                                    <label class=\"filter-label\">";
    echo __("Short by Date:");
    echo "</label>\n                                    <select name=\"shortByDate\" onchange=\"this.form.submit()\"\n                                        class=\"form-select filter-select\">\n                                        <option value=\"\">";
    echo __("Tất cả");
    echo "</option>\n                                        <option ";
    echo $shortByDate == 1 ? "selected" : "";
    echo " value=\"1\">\n                                            ";
    echo __("Hôm nay");
    echo "                                        </option>\n                                        <option ";
    echo $shortByDate == 2 ? "selected" : "";
    echo " value=\"2\">\n                                            ";
    echo __("Tuần này");
    echo "                                        </option>\n                                        <option ";
    echo $shortByDate == 3 ? "selected" : "";
    echo " value=\"3\">\n                                            ";
    echo __("Tháng này");
    echo "                                        </option>\n                                    </select>\n                                </div>\n                            </div>\n                        </form>\n                        <div class=\"table-responsive mb-3\">\n                            <table class=\"table text-nowrap table-striped table-hover table-bordered\">\n                                <thead>\n                                    <tr class=\"text-center\">\n                                        <th class=\"text-center\">";
    echo __("Username");
    echo "</th>\n                                        <th class=\"text-center\">";
    echo __("TransID");
    echo "</th>\n                                        <th class=\"text-center\">";
    echo __("Amount");
    echo "</th>\n                                        <th class=\"text-center\">";
    echo __("Price");
    echo "</th>\n                                        <th class=\"text-center\">";
    echo __("Create date");
    echo "</th>\n                                    </tr>\n                                </thead>\n                                <tbody>\n                                    ";
    foreach ($listDatatable as $row) {
        echo "                                    <tr>\n                                        <td class=\"text-center\"><a class=\"text-primary\"\n                                                href=\"";
        echo base_url_admin("user-edit&id=" . $row["user_id"]);
        echo "\">";
        echo getRowRealtime("users", $row["user_id"], "username");
        echo "                                                [ID ";
        echo $row["user_id"];
        echo "]</a>\n                                        </td>\n                                        <td class=\"text-center\"><b>";
        echo $row["transaction_ref"];
        echo "</b></td>\n                                        <td class=\"text-center\"><span\n                                                class=\"badge bg-success-gradient\">";
        echo $row["amount"];
        echo " NGN</span></td>\n                                        <td class=\"text-center\"><span\n                                                class=\"badge bg-danger-gradient\">";
        echo format_currency($row["price"]);
        echo "</span>\n                                        </td>\n                                        <td class=\"text-center\"><span\n                                                class=\"badge bg-light text-dark\">";
        echo $row["create_gettime"];
        echo "</span>\n                                        </td>\n                                    </tr>\n                                    ";
    }
    echo "                                </tbody>\n                                <tfoot>\n                                    <tr>\n                                        <td colspan=\"7\">\n                                            <div class=\"float-right\">\n                                                ";
    echo __("Paid:");
    echo "                                                <strong\n                                                    style=\"color:red;\">";
    echo format_currency($CMSNT->get_row(" SELECT SUM(`price`) FROM `payment_squadco` WHERE " . $where . " ")["SUM(`price`)"]);
    echo "</strong>\n\n                                            </div>\n                                        </td>\n                                    </tr>\n                                </tfoot>\n                            </table>\n                        </div>\n                        <div class=\"row\">\n                            <div class=\"col-sm-12 col-md-5\">\n                                <p class=\"dataTables_info\">Showing ";
    echo $limit;
    echo " of\n                                    ";
    echo format_cash($totalDatatable);
    echo "                                    Results</p>\n                            </div>\n                            <div class=\"col-sm-12 col-md-7 mb-3\">\n                                ";
    echo $limit < $totalDatatable ? $urlDatatable : "";
    echo "                            </div>\n                        </div>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n</div>\n\n\n\n\n\n";
    require_once __DIR__ . "/footer.php";
    echo "\n\n<script>\ndocument.addEventListener('DOMContentLoaded', function() {\n    var button = document.getElementById('open-card-config');\n    var card = document.getElementById('card-config');\n\n    // Thêm sự kiện click cho nút button\n    button.addEventListener('click', function() {\n        // Kiểm tra nếu card đang hiển thị thì ẩn đi, ngược lại hiển thị\n        if (card.style.display === 'none' || card.style.display === '') {\n            card.style.display = 'block';\n        } else {\n            card.style.display = 'none';\n        }\n    });\n});\n</script>\n<script>\nCKEDITOR.replace(\"squadco_notice\");\n</script>";
}

?>