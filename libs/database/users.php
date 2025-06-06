<?php

if(!defined("IN_SITE")) {
    exit("The Request Not Found");
}
class users extends DB
{
    protected $_table_name = "users";
    protected $_key = "id";
    public function __construct()
    {
        parent::connect();
    }
    public function __destruct()
    {
        parent::dis_connect();
    }
    public function add_new($data)
    {
        return parent::insert($this->_table_name, $data);
    }
    public function delete_by_id($id)
    {
        return $this->remove($this->_table_name, $this->_key . "=" . (int) $id);
    }
    public function update_by_id($data, $id)
    {
        return $this->update($this->_table_name, $data, $this->_key . "=" . (int) $id);
    }
    public function select_by_id($select, $id)
    {
        $sql = "SELECT " . $select . " FROM " . $this->_table_name . " WHERE " . $this->_key . " = " . (int) $id;
        return $this->get_row($sql);
    }
    public function get_row_by_id($where)
    {
        $sql = "SELECT * FROM " . $this->_table_name . " WHERE " . $where;
        return $this->get_row($sql);
    }
    public function get_list_by_id($where)
    {
        $sql = "SELECT * FROM " . $this->_table_name . " WHERE " . $where;
        return $this->get_list($sql);
    }
    public function num_rows_by_id($where)
    {
        $sql = "SELECT * FROM " . $this->_table_name . " WHERE " . $where;
        return $this->num_rows($sql);
    }
    public function AddCredits($user_id, $amount, $reason, $transid = NULL)
    {
        if($transid == NULL) {
            $transid = uniqid() . "_" . mt_rand(0, 9999999);
        }
        $isInsert = parent::insert("dongtien", ["sotientruoc" => getUser($user_id, "money"), "sotienthaydoi" => $amount, "sotiensau" => getUser($user_id, "money") + $amount, "thoigian" => gettime(), "noidung" => $reason, "user_id" => $user_id, "transid" => $transid]);
        if($isInsert) {
            $isUpdate = parent::cong("users", "money", $amount, " `id` = '" . $user_id . "' ");
            if($isUpdate) {
                parent::cong("users", "total_money", $amount, " `id` = '" . $user_id . "' ");
                return true;
            }
        }
        return false;
    }
    public function RefundCredits($user_id, $amount, $reason, $transid = NULL)
    {
        if($transid == NULL) {
            $transid = uniqid() . "_" . mt_rand(0, 9999999);
        }
        $isInsert = parent::insert("dongtien", ["sotientruoc" => getUser($user_id, "money"), "sotienthaydoi" => $amount, "sotiensau" => getUser($user_id, "money") + $amount, "thoigian" => gettime(), "noidung" => $reason, "user_id" => $user_id, "transid" => $transid]);
        if($isInsert) {
            $isUpdate = parent::cong("users", "money", $amount, " `id` = '" . $user_id . "' ");
            if($isUpdate) {
                return true;
            }
        }
        return false;
    }
    public function RemoveCredits($user_id, $amount, $reason, $transid = NULL)
    {
        if($transid == NULL) {
            $transid = uniqid() . "_" . mt_rand(0, 9999999);
        }
        $isInsert = parent::insert("dongtien", ["sotientruoc" => getUser($user_id, "money"), "sotienthaydoi" => $amount, "sotiensau" => getUser($user_id, "money") - $amount, "thoigian" => gettime(), "noidung" => $reason, "user_id" => $user_id, "transid" => $transid]);
        if($isInsert) {
            $isRemove = parent::tru("users", "money", $amount, " `id` = '" . $user_id . "' ");
            if($isRemove) {
                return true;
            }
        }
        return false;
    }
    public function Banned($user_id, $reason)
    {
        $Mobile_Detect = new Detection\MobileDetect();
        parent::insert("logs", ["user_id" => $user_id, "ip" => myip(), "device" => $Mobile_Detect->getUserAgent(), "createdate" => gettime(), "action" => "Tài khoản bị khoá lý do (" . $reason . ")"]);
        parent::update("users", ["banned" => 1], " `id` = '" . $user_id . "' ");
    }
    public function AddSpin($user_id, $amount, $reason)
    {
        $Mobile_Detect = new Detection\MobileDetect();
        parent::insert("logs", ["user_id" => $user_id, "ip" => myip(), "device" => $Mobile_Detect->getUserAgent(), "createdate" => gettime(), "action" => $reason]);
        $isUpdate = parent::cong("users", "spin", $amount, " `id` = '" . $user_id . "' ");
        if($isUpdate) {
            return true;
        }
        return false;
    }
    public function AddCommission($ref_id, $user_id, $amount, $reason)
    {
        parent::insert("aff_log", ["sotientruoc" => getUser($ref_id, "ref_price"), "sotienthaydoi" => $amount, "sotienhientai" => getUser($ref_id, "ref_price") + $amount, "create_gettime" => gettime(), "reason" => $reason, "user_id" => $ref_id]);
        $isUpdate = parent::cong("users", "ref_price", $amount, " `id` = '" . $ref_id . "' ");
        if($isUpdate) {
            parent::cong("users", "ref_total_price", $amount, " `id` = '" . $ref_id . "' ");
            parent::cong("users", "ref_amount", $amount, " `id` = '" . $user_id . "' ");
            return true;
        }
        return false;
    }
    public function RemoveCommission($user_id, $amount, $reason)
    {
        parent::insert("aff_log", ["sotientruoc" => getUser($user_id, "ref_price"), "sotienthaydoi" => $amount, "sotienhientai" => getUser($user_id, "ref_price") - $amount, "create_gettime" => gettime(), "reason" => $reason, "user_id" => $user_id]);
        $isRemove = parent::tru("users", "ref_price", $amount, " `id` = '" . $user_id . "' ");
        if($isRemove) {
            return true;
        }
        return false;
    }
    public function RefundCommission($user_id, $amount, $reason)
    {
        parent::insert("aff_log", ["sotientruoc" => getUser($user_id, "ref_price"), "sotienthaydoi" => $amount, "sotienhientai" => getUser($user_id, "ref_price") + $amount, "create_gettime" => gettime(), "reason" => $reason, "user_id" => $user_id]);
        $isUpdate = parent::cong("users", "ref_price", $amount, " `id` = '" . $user_id . "' ");
        if($isUpdate) {
            return true;
        }
        return false;
    }
}

?>