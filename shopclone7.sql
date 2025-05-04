-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th3 02, 2025 lúc 04:10 PM
-- Phiên bản máy phục vụ: 10.4.21-MariaDB
-- Phiên bản PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `test`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin_request_logs`
--

CREATE TABLE `admin_request_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `request_url` text COLLATE utf8_unicode_ci NOT NULL,
  `request_method` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `request_params` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `user_agent` text COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin_role`
--

CREATE TABLE `admin_role` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`role`)),
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `admin_role`
--

INSERT INTO `admin_role` (`id`, `name`, `role`, `create_gettime`, `update_gettime`) VALUES
(1, 'Super Admin', '[\"view_license\",\"view_statistical\",\"view_recent_transactions\",\"view_logs\",\"view_transactions\",\"view_block_ip\",\"edit_block_ip\",\"view_automations\",\"edit_automations\",\"view_user\",\"edit_user\",\"login_user\",\"view_role\",\"edit_role\",\"view_recharge\",\"edit_recharge\",\"view_affiliate\",\"view_withdraw_affiliate\",\"edit_withdraw_affiliate\",\"edit_affiliate\",\"view_email_campaigns\",\"edit_email_campaigns\",\"view_coupon\",\"edit_coupon\",\"view_promotion\",\"edit_promotion\",\"view_blog\",\"edit_blog\",\"view_product\",\"edit_product\",\"edit_stock_product\",\"view_orders_product\",\"refund_orders_product\",\"view_order_product\",\"delete_order_product\",\"manager_suppliers\",\"view_sold_product\",\"view_menu\",\"edit_menu\",\"view_lang\",\"edit_lang\",\"view_currency\",\"edit_currency\",\"edit_theme\",\"edit_setting\"]', '2023-11-16 20:28:54', '2024-08-10 12:57:40'),
(2, 'Sales', '[\"view_logs\",\"view_transactions\",\"view_user\",\"view_affiliate\",\"view_withdraw_affiliate\",\"view_coupon\"]', '2023-11-16 20:41:10', '2023-11-16 20:53:56');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `aff_log`
--

CREATE TABLE `aff_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `reason` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `sotientruoc` float NOT NULL DEFAULT 0,
  `sotienthaydoi` float NOT NULL DEFAULT 0,
  `sotienhientai` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `aff_withdraw`
--

CREATE TABLE `aff_withdraw` (
  `id` int(11) NOT NULL,
  `trans_id` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `bank` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `stk` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `status` varchar(25) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `reason` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `automations`
--

CREATE TABLE `automations` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_id` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `schedule` int(11) NOT NULL DEFAULT 0,
  `other` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `banks`
--

CREATE TABLE `banks` (
  `id` int(11) NOT NULL,
  `short_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountName` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountNumber` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `block_ip`
--

CREATE TABLE `block_ip` (
  `id` int(11) NOT NULL,
  `ip` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `banned` int(11) NOT NULL DEFAULT 0,
  `reason` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cards`
--

CREATE TABLE `cards` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `trans_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telco` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `serial` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `pin` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `reason` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `id_api` int(11) NOT NULL DEFAULT 0,
  `supplier_id` int(11) NOT NULL DEFAULT 0,
  `stt` int(11) NOT NULL DEFAULT 0,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `keywords` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coupons`
--

CREATE TABLE `coupons` (
  `id` int(11) NOT NULL,
  `code` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `used` int(11) NOT NULL DEFAULT 0,
  `discount` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `min` int(11) NOT NULL DEFAULT 1000,
  `max` int(11) NOT NULL DEFAULT 10000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coupon_used`
--

CREATE TABLE `coupon_used` (
  `id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `trans_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `currencies`
--

CREATE TABLE `currencies` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate` float NOT NULL DEFAULT 0,
  `symbol_left` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol_right` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `seperator` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `display` int(11) NOT NULL DEFAULT 1,
  `default_currency` int(11) NOT NULL DEFAULT 0,
  `decimal_currency` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `rate`, `symbol_left`, `symbol_right`, `seperator`, `display`, `default_currency`, `decimal_currency`) VALUES
(3, 'Đồng', 'VND', 1, '', 'đ', 'dot', 1, 1, 0),
(4, 'Dollar', 'USD', 24000, '$', '', 'dot', 1, 0, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `deposit_log`
--

CREATE TABLE `deposit_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `received` float NOT NULL DEFAULT 0,
  `create_time` int(11) DEFAULT 0,
  `is_virtual` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dongtien`
--

CREATE TABLE `dongtien` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `sotientruoc` float NOT NULL DEFAULT 0,
  `sotienthaydoi` float NOT NULL DEFAULT 0,
  `sotiensau` float NOT NULL DEFAULT 0,
  `thoigian` datetime NOT NULL,
  `noidung` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `transid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `email_campaigns`
--

CREATE TABLE `email_campaigns` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `bcc` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longblob DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `email_sending`
--

CREATE TABLE `email_sending` (
  `id` int(11) NOT NULL,
  `camp_id` int(11) DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `response` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `failed_attempts`
--

CREATE TABLE `failed_attempts` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `type` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `lang` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icon` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang_default` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `languages`
--

INSERT INTO `languages` (`id`, `lang`, `code`, `icon`, `lang_default`, `status`) VALUES
(1, 'Vietnamese', 'vi', 'assets/storage/flags/flag_Vietnamese.png', 1, 1),
(2, 'English', 'en', 'assets/storage/flags/flag_English.png', 0, 1),
(19, 'Thailand', 'th', 'assets/storage/flags/flag_Thailand.png', 0, 1),
(20, 'Chinese', 'zh', 'assets/storage/flags/flag_Chinese.png', 0, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `action` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `log_bank_auto`
--

CREATE TABLE `log_bank_auto` (
  `id` int(11) NOT NULL,
  `tid` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `log_ref`
--

CREATE TABLE `log_ref` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `reason` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `sotientruoc` float NOT NULL DEFAULT 0,
  `sotienthaydoi` float NOT NULL DEFAULT 0,
  `sotienhientai` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `href` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `target` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 3,
  `content` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `momo`
--

CREATE TABLE `momo` (
  `id` int(11) NOT NULL,
  `request_id` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tranId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `partnerId` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `partnerName` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `received` int(11) NOT NULL DEFAULT 0,
  `comment` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT 0,
  `status` varchar(32) COLLATE utf8_unicode_ci DEFAULT 'xuly'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_log`
--

CREATE TABLE `order_log` (
  `id` int(11) NOT NULL,
  `buyer` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pay` float NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL,
  `is_virtual` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_bank`
--

CREATE TABLE `payment_bank` (
  `id` int(11) NOT NULL,
  `method` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT 0,
  `received` int(11) DEFAULT 0,
  `create_gettime` datetime DEFAULT NULL,
  `create_time` int(11) DEFAULT 0,
  `user_id` int(11) DEFAULT 0,
  `notication` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_crypto`
--

CREATE TABLE `payment_crypto` (
  `id` int(11) NOT NULL,
  `trans_id` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `request_id` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `received` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `status` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'waiting',
  `msg` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_payment` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_flutterwave`
--

CREATE TABLE `payment_flutterwave` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `tx_ref` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `price` float NOT NULL DEFAULT 0,
  `currency` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `status` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_manual`
--

CREATE TABLE `payment_manual` (
  `id` int(11) NOT NULL,
  `icon` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `display` int(11) NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_momo`
--

CREATE TABLE `payment_momo` (
  `id` int(11) NOT NULL,
  `method` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tid` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT 0,
  `received` int(11) DEFAULT 0,
  `create_gettime` datetime DEFAULT NULL,
  `create_time` int(11) DEFAULT 0,
  `user_id` int(11) DEFAULT 0,
  `notication` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_paypal`
--

CREATE TABLE `payment_paypal` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `trans_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `create_date` datetime NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_pm`
--

CREATE TABLE `payment_pm` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `payment_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `create_date` datetime NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_date` datetime NOT NULL,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_squadco`
--

CREATE TABLE `payment_squadco` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `transaction_ref` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_thesieure`
--

CREATE TABLE `payment_thesieure` (
  `id` int(11) NOT NULL,
  `method` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tid` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `received` int(11) NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `notication` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_toyyibpay`
--

CREATE TABLE `payment_toyyibpay` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `trans_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billName` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `BillCode` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `reason` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_xipay`
--

CREATE TABLE `payment_xipay` (
  `id` int(11) NOT NULL,
  `out_trade_no` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `transaction_id` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Mã giao dịch do Xipay trả về',
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Phương thức thanh toán (alipay, wxpay...)',
  `price` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền thực nhận',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền thanh toán',
  `param` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tham số mở rộng',
  `product_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tên sản phẩm/dịch vụ',
  `status` tinyint(4) DEFAULT 0 COMMENT 'Trạng thái giao dịch: 0=pending,1=success,2=fail...',
  `notify_data` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Lưu dữ liệu notify (nếu cần)',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) DEFAULT NULL COMMENT 'ID user trong hệ thống (nếu có)',
  `notication` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `stt` int(11) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `title` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `view` int(11) NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post_category`
--

CREATE TABLE `post_category` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` text COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `icon` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `stt` int(11) NOT NULL DEFAULT 0,
  `code` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_desc` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `images` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` float NOT NULL DEFAULT 0,
  `cost` float NOT NULL DEFAULT 0,
  `discount` float NOT NULL DEFAULT 0,
  `min` int(111) NOT NULL DEFAULT 1,
  `max` int(11) NOT NULL DEFAULT 1000000,
  `flag` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `sold` int(11) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `check_live` varchar(55) COLLATE utf8_unicode_ci DEFAULT 'None',
  `supplier_id` int(11) NOT NULL DEFAULT 0,
  `api_id` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_stock` int(11) NOT NULL DEFAULT 0,
  `api_time_update` int(11) NOT NULL DEFAULT 0,
  `text_txt` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_by` int(11) NOT NULL DEFAULT 1,
  `allow_api` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_die`
--

CREATE TABLE `product_die` (
  `id` int(11) NOT NULL,
  `product_code` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller` int(11) NOT NULL DEFAULT 0,
  `uid` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `type` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_discount`
--

CREATE TABLE `product_discount` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `discount` float NOT NULL DEFAULT 0,
  `min` int(11) NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_order`
--

CREATE TABLE `product_order` (
  `id` int(11) NOT NULL,
  `trans_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `supplier_id` int(11) NOT NULL DEFAULT 0,
  `product_name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `buyer` int(11) NOT NULL DEFAULT 0,
  `seller` int(11) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 0,
  `money` float NOT NULL DEFAULT 0,
  `pay` float NOT NULL DEFAULT 0,
  `cost` int(11) NOT NULL DEFAULT 0,
  `commission_fee` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `trash` int(11) NOT NULL DEFAULT 0,
  `refund` int(11) NOT NULL DEFAULT 0,
  `ip` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `device` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_view_order` int(11) NOT NULL DEFAULT 0,
  `api_transid` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_sold`
--

CREATE TABLE `product_sold` (
  `id` int(11) NOT NULL,
  `product_code` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trans_id` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_id` int(11) NOT NULL DEFAULT 0,
  `buyer` int(11) NOT NULL DEFAULT 0,
  `seller` int(11) NOT NULL DEFAULT 0,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `time_check_live` int(11) NOT NULL DEFAULT 0,
  `type` varchar(55) COLLATE utf8_unicode_ci DEFAULT 'WEB'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_stock`
--

CREATE TABLE `product_stock` (
  `id` int(11) NOT NULL,
  `product_code` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller` int(11) NOT NULL DEFAULT 0,
  `uid` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `type` varchar(55) COLLATE utf8_unicode_ci DEFAULT 'WEB',
  `time_check_live` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `promotions`
--

CREATE TABLE `promotions` (
  `id` int(11) NOT NULL,
  `min` float NOT NULL DEFAULT 0,
  `discount` float NOT NULL DEFAULT 0,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`) VALUES
(1, 'status_demo', '0'),
(2, 'type_password', 'bcrypt'),
(3, 'title', 'DEMO SHOPCLONE7'),
(4, 'description', 'Hệ thống bán nguyên liệu ADS tự động, uy tín, giá rẻ...'),
(5, 'keywords', ''),
(6, 'author', 'CMSNT.CO'),
(7, 'timezone', 'Asia/Ho_Chi_Minh'),
(8, 'email', 'admin@domain.com'),
(9, 'status', '1'),
(10, 'status_update', '1'),
(12, 'session_login', '10000000'),
(13, 'javascript_header', '<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">\r\n<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>\r\n<link href=\"https://fonts.googleapis.com/css2?family=Saira+Semi+Condensed:wght@100;200;300;400;500;600;700;800;900&display=swap\" rel=\"stylesheet\">\r\n\r\n'),
(14, 'javascript_footer', ''),
(16, 'logo_light', 'assets/storage/images/logo_light_5MP.png'),
(17, 'logo_dark', 'assets/storage/images/logo_dark_C0I.png'),
(18, 'favicon', 'assets/storage/images/favicon_06U.png'),
(19, 'image', 'assets/storage/images/image_IYA.png'),
(20, 'bg_login', 'assets/storage/images/bg_loginBYI.png'),
(21, 'bg_register', 'assets/storage/images/bg_registerMOU.png'),
(26, 'telegram_token', ''),
(27, 'telegram_chat_id', ''),
(30, 'prefix_autobank', 'NAPTIEN'),
(35, 'bank_status', '1'),
(36, 'bank_notice', '<ul>\r\n	<li>Nhập đ&uacute;ng nội dung chuyển tiền.</li>\r\n	<li>Cộng tiền trong v&agrave;i gi&acirc;y.</li>\r\n	<li>Li&ecirc;n hệ BQT nếu nhập sai nội dung chuyển.</li>\r\n</ul>\r\n'),
(43, 'notice_home', '<h4><span style=\"color:#e74c3c\"><strong>Lưu &yacute;:</strong></span> H&atilde;y đảm bảo t&agrave;i khoản đăng nhập v&agrave; mật khẩu của bạn kh&ocirc;ng khớp với th&ocirc;ng tin đăng nhập tr&ecirc;n c&aacute;c website kh&aacute;c để tr&aacute;nh trường hợp chủ website kh&aacute;c sử dụng th&ocirc;ng tin của bạn để đăng nhập v&agrave;o website n&agrave;y!</h4>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt=\"yes\" src=\"http://localhost/CMSNT.CO/SHOPCLONE7/public/ckeditor/plugins/smiley/images/thumbs_up.png\" title=\"yes\" />&nbsp;Thay đổi nội dung&nbsp;tại -&gt;&nbsp;<strong>Trang Quản Trị</strong>&nbsp;-&gt;&nbsp;<strong>C&agrave;i Đặt</strong>&nbsp;-&gt;&nbsp;<strong>Th&ocirc;ng b&aacute;o ngo&agrave;i trang chủ</strong></p>\r\n'),
(44, 'font_family', 'font-family: \'Saira Semi Condensed\', sans-serif;'),
(59, 'popup_status', '1'),
(60, 'popup_noti', '<p><span style=\"font-size:14px\"><img alt=\"yes\" src=\"http://localhost/CMSNT.CO/SHOPCLONE7/public/ckeditor/plugins/smiley/images/thumbs_up.png\" style=\"height:23px; width:23px\" title=\"yes\" />&nbsp;Thay đổi th&ocirc;ng b&aacute;o nổi tại -&gt; <strong>Trang Quản Trị</strong> -&gt; <strong>C&agrave;i Đặt</strong> -&gt;&nbsp;<strong>Th&ocirc;ng b&aacute;o nổi ngo&agrave;i trang chủ</strong></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><img alt=\"yes\" src=\"http://localhost/CMSNT.CO/SHOPCLONE7/public/ckeditor/plugins/smiley/images/thumbs_up.png\" style=\"height:23px; width:23px\" title=\"yes\" />&nbsp;Ẩn th&ocirc;ng b&aacute;o nổi tại -&gt; <strong>Trang Quản Trị</strong> -&gt; <strong>C&agrave;i Đặt</strong> -&gt;&nbsp;<strong>ON/OFF Th&ocirc;ng b&aacute;o nổi</strong></span></p>\r\n'),
(64, 'license_key', 'aeeb422ae3477fbbec7636cb7e20523d'),
(69, 'home_page', 'home'),
(70, 'smtp_host', 'smtp.gmail.com'),
(71, 'smtp_encryption', 'tls'),
(72, 'smtp_port', '587'),
(73, 'smtp_email', ''),
(74, 'smtp_password', ''),
(76, 'default_product_image', 'assets/storage/images/default_product_image3VL.png'),
(77, 'status_captcha', '0'),
(78, 'crypto_note', ''),
(79, 'crypto_address', ''),
(80, 'crypto_token', ''),
(81, 'crypto_min', '10'),
(82, 'crypto_max', '100000'),
(83, 'crypto_status', '1'),
(84, 'crypto_rate', '25000'),
(85, 'reCAPTCHA_site_key', ''),
(86, 'reCAPTCHA_secret_key', ''),
(87, 'reCAPTCHA_status', '0'),
(88, 'telegram_status', '0'),
(89, 'smtp_status', '0'),
(93, 'affiliate_ck', '5'),
(94, 'affiliate_status', '1'),
(95, 'affiliate_min', '10000'),
(96, 'affiliate_banks', 'Vietcombank\r\nMBBank\r\nTechcombank'),
(97, 'affiliate_note', '<p>Chia sẻ&nbsp;li&ecirc;n kết n&agrave;y l&ecirc;n mạng x&atilde; hội hoặc bạn b&egrave; của bạn.</p>\r\n'),
(98, 'affiliate_chat_id_telegram', '1048444403'),
(99, 'check_time_cron_cron2', '0'),
(100, 'bank_min', '1000'),
(101, 'bank_max', '1000000000'),
(102, 'paypal_clientId', ''),
(103, 'paypal_clientSecret', ''),
(104, 'paypal_status', '1'),
(105, 'paypal_rate', '23000'),
(108, 'paypal_note', ''),
(109, 'noti_recharge', '[{time}] <b>{username}</b> vừa nạp {amount} vào {method} thực nhận {price}.'),
(110, 'noti_action', '[{time}] \r\n- <b>Username</b>: <code>{username}</code>\r\n- <b>Action</b>:  <code>{action}</code>\r\n- <b>IP</b>: <code>{ip}</code>'),
(111, 'theme_color', '#007ea8'),
(112, 'hotline', '0988888XXX'),
(113, 'type_notification', 'telegram'),
(114, 'perfectmoney_status', '1'),
(115, 'perfectmoney_account', ''),
(116, 'perfectmoney_pass', ''),
(117, 'perfectmoney_rate', '23000'),
(118, 'perfectmoney_units', ''),
(119, 'perfectmoney_notice', ''),
(120, 'fanpage', 'https://www.facebook.com/cmsnt.co'),
(121, 'address', '1Hd- 50, 010 Avenue, NY 90001 United States'),
(122, 'toyyibpay_status', '1'),
(123, 'toyyibpay_userSecretKey', ''),
(124, 'toyyibpay_categoryCode', ''),
(125, 'toyyibpay_min', '1'),
(126, 'toyyibpay_billChargeToCustomer', '0'),
(127, 'toyyibpay_rate', '5258'),
(128, 'toyyibpay_notice', ''),
(129, 'noti_affiliate_withdraw', '[{time}] \r\n- <b>Username</b>: <code>{username}</code>\r\n- <b>Action</b>:  <code>Tạo lệnh rút {amount} về ngân hàng {bank} | {account_number} | {account_name}</code>\r\n- <b>IP</b>: <code>{ip}</code>'),
(130, 'check_time_cron_sending_email', '1715250984'),
(131, 'squadco_status', '1'),
(132, 'squadco_Secret_Key', ''),
(133, 'squadco_Public_Key', ''),
(134, 'squadco_rate', '51'),
(135, 'squadco_currency_code', 'NGN'),
(136, 'squadco_notice', ''),
(137, 'theme_color1', '#1a5e75'),
(138, 'product_photo_display', '1'),
(139, 'product_rating_display', '0'),
(140, 'product_sold_display', '1'),
(141, 'banner_singer', 'assets/storage/images/banner_singer08A.png'),
(142, 'image_empty_state', 'assets/storage/images/image_empty_stateNPV.png'),
(143, 'copyright_footer', 'Software By <a href=\"https://www.cmsnt.co/\">CMSNT.CO</a>'),
(144, 'menu_category_right', '1'),
(145, 'crypto_trial', '5'),
(146, 'type_show_product', 'LIST'),
(147, 'check_time_cron_bank', '0'),
(148, 'google_analytics_status', '0'),
(149, 'google_analytics_id', ''),
(150, 'card_status', '1'),
(151, 'card_partner_id', ''),
(152, 'card_partner_key', ''),
(153, 'card_ck', '20'),
(154, 'card_notice', ''),
(155, 'api_status', '1'),
(156, 'time_cron_suppliers_shopclone6', '1734798034'),
(157, 'time_cron_suppliers_api1', '1711653105'),
(158, 'language_type', 'manual'),
(159, 'gtranslate_script', '<div class=\"gtranslate_wrapper\"></div>\n<script>window.gtranslateSettings = {\"default_language\":\"vi\",\"languages\":[\"vi\",\"fr\",\"de\",\"it\",\"es\",\"zh-CN\",\"ar\",\"tr\",\"ru\",\"uk\",\"km\",\"th\",\"en\"],\"wrapper_selector\":\".gtranslate_wrapper\"}</script>\n<script src=\"https://cdn.gtranslate.net/widgets/latest/dropdown.js\" defer></script>'),
(160, 'notice_top_left', 'Chào mừng bạn đến với website SHOPCLONE7'),
(161, 'page_contact', ''),
(162, 'page_policy', '<p><strong>Ch&iacute;nh s&aacute;ch bảo mật</strong></p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i đặt rất nhiều gi&aacute; trị v&agrave;o việc bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn. Ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư n&agrave;y giải th&iacute;ch c&aacute;ch ch&uacute;ng t&ocirc;i thu thập, sử dụng v&agrave; bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn khi bạn sử dụng dịch vụ của ch&uacute;ng t&ocirc;i.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Thu thập v&agrave; sử dụng th&ocirc;ng tin</strong></p>\r\n\r\n<p>Khi bạn sử dụng trang web của ch&uacute;ng t&ocirc;i hoặc tương t&aacute;c với c&aacute;c dịch vụ của ch&uacute;ng t&ocirc;i, ch&uacute;ng t&ocirc;i c&oacute; thể thu thập một số th&ocirc;ng tin c&aacute; nh&acirc;n nhất định từ bạn. Điều n&agrave;y c&oacute; thể bao gồm t&ecirc;n, địa chỉ email, số điện thoại, địa chỉ v&agrave; th&ocirc;ng tin kh&aacute;c m&agrave; bạn cung cấp khi đăng k&yacute; hoặc sử dụng dịch vụ của ch&uacute;ng t&ocirc;i.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i c&oacute; thể sử dụng th&ocirc;ng tin c&aacute; nh&acirc;n của bạn để:</p>\r\n\r\n<ul>\r\n	<li>Cung cấp v&agrave; duy tr&igrave; dịch vụ</li>\r\n	<li>Th&ocirc;ng b&aacute;o về những thay đổi đối với dịch vụ của ch&uacute;ng t&ocirc;i</li>\r\n	<li>Giải quyết vấn đề hoặc tranh chấp</li>\r\n	<li>Theo d&otilde;i v&agrave; ph&acirc;n t&iacute;ch việc sử dụng dịch vụ của ch&uacute;ng t&ocirc;i</li>\r\n	<li>N&acirc;ng cao trải nghiệm người d&ugrave;ng</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Bảo vệ</strong></p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i cam kết bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn v&agrave; c&oacute; c&aacute;c biện ph&aacute;p bảo mật th&iacute;ch hợp để đảm bảo th&ocirc;ng tin của bạn được giữ an to&agrave;n khi bạn truy cập trang web của ch&uacute;ng t&ocirc;i.</p>\r\n\r\n<p>Tuy nhi&ecirc;n, h&atilde;y nhớ rằng kh&ocirc;ng c&oacute; phương thức truyền th&ocirc;ng tin n&agrave;o qua internet hoặc phương tiện điện tử l&agrave; an to&agrave;n hoặc đ&aacute;ng tin cậy 100%. Mặc d&ugrave; ch&uacute;ng t&ocirc;i cố gắng bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn nhưng ch&uacute;ng t&ocirc;i kh&ocirc;ng thể đảm bảo hoặc đảm bảo t&iacute;nh bảo mật của bất kỳ th&ocirc;ng tin n&agrave;o bạn gửi cho ch&uacute;ng t&ocirc;i hoặc từ c&aacute;c dịch vụ của ch&uacute;ng t&ocirc;i. v&agrave; bạn phải tự chịu rủi ro n&agrave;y.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Li&ecirc;n kết đến c&aacute;c trang web kh&aacute;c</strong></p>\r\n\r\n<p>Trang web của ch&uacute;ng t&ocirc;i c&oacute; thể chứa c&aacute;c li&ecirc;n kết đến c&aacute;c trang web kh&aacute;c kh&ocirc;ng do ch&uacute;ng t&ocirc;i điều h&agrave;nh. Nếu bạn nhấp v&agrave;o li&ecirc;n kết của b&ecirc;n thứ ba, bạn sẽ được chuyển hướng đến trang web của b&ecirc;n thứ ba đ&oacute;. Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n xem lại Ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư của mọi trang web bạn truy cập v&igrave; ch&uacute;ng t&ocirc;i kh&ocirc;ng c&oacute; quyền kiểm so&aacute;t hoặc chịu tr&aacute;ch nhiệm đối với c&aacute;c hoạt động hoặc nội dung về quyền ri&ecirc;ng tư của c&aacute;c trang web hoặc dịch vụ của b&ecirc;n thứ ba. .</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Thay đổi ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư</strong></p>\r\n\r\n<p>Đ&ocirc;i khi, ch&uacute;ng t&ocirc;i c&oacute; thể cập nhật Ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư n&agrave;y m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước. Mọi thay đổi sẽ được đăng l&ecirc;n trang n&agrave;y v&agrave; được &aacute;p dụng ngay sau khi ch&uacute;ng được đăng. Bằng việc tiếp tục sử dụng dịch vụ của ch&uacute;ng t&ocirc;i sau khi những thay đổi n&agrave;y được đăng, bạn đồng &yacute; với những thay đổi đ&oacute;.</p>\r\n'),
(163, 'page_faq', ''),
(164, 'page_block_ip', NULL),
(165, 'email_temp_content_warning_login', '<p>Ch&uacute;ng t&ocirc;i vừa ph&aacute;t hiện t&agrave;i khoản <strong>{username}</strong> của bạn đang được đăng nhập v&agrave;o hệ thống {domain}.<br />\r\nNếu kh&ocirc;ng phải bạn vui l&ograve;ng thay đổi th&ocirc;ng tin t&agrave;i khoản ngay hoặc li&ecirc;n hệ ngay cho ch&uacute;ng t&ocirc;i để hỗ trợ kiểm tra an to&agrave;n cho qu&yacute; kh&aacute;ch.</p>\r\n\r\n<ul>\r\n	<li>Thời gian: {time}</li>\r\n	<li>IP: {ip}</li>\r\n	<li>Thiết bị: {device}</li>\r\n</ul>\r\n'),
(166, 'email_temp_subject_warning_login', 'Cảnh báo đăng nhập tài khoản - {title}'),
(167, 'email_temp_content_otp_mail', '<p>OTP x&aacute;c minh đăng nhập v&agrave;o t&agrave;i khoản <strong>{username}</strong> của bạn l&agrave; <strong>{otp}</strong><br />\r\nNếu kh&ocirc;ng phải bạn vui l&ograve;ng thay đổi th&ocirc;ng tin t&agrave;i khoản ngay hoặc li&ecirc;n hệ ngay cho ch&uacute;ng t&ocirc;i để hỗ trợ kiểm tra an to&agrave;n cho qu&yacute; kh&aacute;ch.</p>\r\n\r\n<ul>\r\n	<li>Thời gian: {time}</li>\r\n	<li>IP: {ip}</li>\r\n	<li>Thiết bị: {device}</li>\r\n</ul>\r\n'),
(168, 'email_temp_subject_otp_mail', 'OTP xác minh đăng nhập website - {title}'),
(169, 'email_temp_content_forgot_password', '<p>Để x&aacute;c minh kh&ocirc;i phục mật khẩu t&agrave;i khoản <strong>{username}</strong> tại website <strong>{domain}</strong><br />\r\nVui l&ograve;ng nhấn v&agrave;o li&ecirc;n kết dưới đ&acirc;y để ho&agrave;n tất qu&aacute; tr&igrave;nh x&aacute;c minh: {link}<br />\r\nNếu kh&ocirc;ng phải bạn y&ecirc;u cầu kh&ocirc;i phục mật khẩu, vui l&ograve;ng bỏ qua mail n&agrave;y.</p>\r\n\r\n<ul>\r\n	<li>Thời gian: {time}</li>\r\n	<li>IP: {ip}</li>\r\n	<li>Thiết bị: {device}</li>\r\n</ul>\r\n'),
(170, 'email_temp_subject_forgot_password', 'Xác nhận khôi phục mật khẩu website - {title}'),
(171, 'time_cron_suppliers_api6', '1723709086'),
(172, 'time_cron_checklive_clone', '1740738217'),
(173, 'time_cron_checklive_hotmail', '1711615443'),
(174, 'product_hide_outstock', '0'),
(175, 'time_cron_suppliers_api14', '1710930652'),
(176, 'max_show_product_home', '6'),
(177, 'email_temp_content_buy_order', '<p><span style=\"font-size:16px\">Cảm ơn bạn đ&atilde; mua h&agrave;ng tại {title}, dưới đ&acirc;y l&agrave; th&ocirc;ng tin đơn h&agrave;ng của bạn. Nếu kh&ocirc;ng phải bạn vui l&ograve;ng thay đổi th&ocirc;ng tin t&agrave;i khoản ngay hoặc li&ecirc;n hệ ngay cho ch&uacute;ng t&ocirc;i để hỗ trợ kiểm tra an to&agrave;n cho qu&yacute; kh&aacute;ch.</span></p>\r\n\r\n<ul>\r\n	<li><span style=\"font-size:14px\">M&atilde; đơn h&agrave;ng: <strong>#{trans_id}</strong></span></li>\r\n	<li><span style=\"font-size:14px\">Sản phẩm:<strong> {product}</strong></span></li>\r\n	<li><span style=\"font-size:14px\">Số lượng: <span style=\"color:#3498db\"><strong>{amount}</strong></span></span></li>\r\n	<li><span style=\"font-size:14px\">Thanh to&aacute;n: <span style=\"color:#e74c3c\"><strong>{pay}</strong></span></span></li>\r\n</ul>\r\n\r\n<p><span style=\"font-size:14px\">Để đảm bảo an to&agrave;n, ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n x&oacute;a lịch sử đơn h&agrave;ng tr&ecirc;n hệ thống sau khi nhận được Email n&agrave;y.</span></p>\r\n\r\n<p><em>Thiết bị: {device} - IP: {ip}</em></p>\r\n'),
(178, 'email_temp_subject_buy_order', 'Chi tiết đơn hàng {product} - {title}'),
(179, 'time_cron_suppliers_shopclone7', '1736523184'),
(180, 'time_cron_suppliers_api18', '1711615441'),
(181, 'avatar', 'assets/storage/images/avatar4N0.png'),
(182, 'check_time_cron_momo', '1711213245'),
(183, 'momo_number', '0947838128'),
(184, 'momo_name', 'WEB DEMO VUI LÒNG KHÔNG NẠP'),
(185, 'momo_token', ''),
(186, 'momo_notice', ''),
(187, 'momo_status', '1'),
(188, 'script_footer_admin', ''),
(189, 'time_cron_suppliers_api19', '1711555019'),
(190, 'cot_so_du_ben_phai', '1'),
(191, 'time_cron_suppliers_api4', '1711863683'),
(192, 'status_giao_dich_gan_day', '1'),
(193, 'content_gd_mua_gan_day', '<b style=\"color: green;\">...{username}</b> mua <b style=\"color: red;\">{amount}</b> <b>{product_name}</b> với giá <b style=\"color:blue;\">{price}</b>'),
(194, 'content_gd_nap_tien_gan_day', '<b style=\"color: green;\">...{username}</b> thực hiện nạp <b style=\"color:blue;\">{amount}</b> bằng <b style=\"color:red;\">{method}</b> thực nhận <b style=\"color:blue;\">{received}</b>'),
(195, 'status_tao_gd_ao', '0'),
(196, 'sl_mua_toi_thieu_gd_ao', '1'),
(197, 'sl_mua_toi_da_gd_ao', '10'),
(198, 'toc_do_gd_mua_ao', '1'),
(199, 'menh_gia_nap_ao_ngau_nhien', '10000\r\n20000\r\n40000\r\n50000\r\n60000\r\n70000\r\n100000\r\n200000\r\n300000\r\n500000\r\n400000\r\n40000\r\n15000\r\n25000\r\n35000\r\n45000\r\n55000\r\n65000\r\n45000\r\n100000\r\n1500000\r\n200000'),
(200, 'toc_do_gd_nap_ao', '1'),
(201, 'method_nap_ao', 'ACB\r\nMB\r\nUSDT\r\nPayPal'),
(202, 'tao_gd_ao_sp_het_hang', '1'),
(203, 'check_time_cron_cron', '1715933184'),
(204, 'blog_status', '1'),
(205, 'cong_tien_nguoi_ban', '0'),
(206, 'noti_buy_product', '[{time}] <b>{username}</b> vừa mua {amount} tài khoản {product} với giá {pay} - #{trans_id}'),
(207, 'check_time_cron_task', '1726908868'),
(208, 'thoi_gian_mua_cach_nhau', '3'),
(209, 'max_register_ip', '5'),
(210, 'time_cron_suppliers_api20', '1715439606'),
(211, 'status_menu_tools', '1'),
(212, 'debug_auto_bank', '0'),
(213, 'time_cron_suppliers_api9', '1721537978'),
(214, 'debug_api_suppliers', '1'),
(215, 'order_by_product_home', '1'),
(216, 'token_webhook_web2m', ''),
(217, 'time_cron_suppliers_api21', '0'),
(218, 'time_cron_suppliers_api17', '1722102324'),
(219, 'api_check_live_gmail', ''),
(220, 'api_key_check_live_gmail', ''),
(221, 'time_cron_checklive_gmail', '1722164111'),
(222, 'time_limit_check_live_gmail', '1800'),
(223, 'widget_zalo1_status', '0'),
(224, 'widget_zalo1_sdt', ''),
(225, 'widget_phone1_status', '0'),
(226, 'widget_phone1_sdt', ''),
(227, 'flutterwave_status', '1'),
(228, 'flutterwave_rate', '16'),
(229, 'flutterwave_currency_code', 'NGN'),
(230, 'flutterwave_publicKey', NULL),
(231, 'flutterwave_secretKey', NULL),
(232, 'flutterwave_notice', ''),
(233, 'limit_block_ip_login', '5'),
(234, 'limit_block_client_login', '10'),
(235, 'limit_block_ip_api', '20'),
(236, 'limit_block_ip_admin_access', '5'),
(237, 'time_cron_suppliers_api22', '1724076154'),
(238, 'isPurchaseIpVerified', '0'),
(239, 'isPurchaseDeviceVerified', '0'),
(240, 'footer_card', ''),
(241, 'notice_orders', NULL),
(242, 'widget_fbzalo2_status', '0'),
(243, 'widget_fbzalo2_zalo', ''),
(244, 'widget_fbzalo2_fb', ''),
(245, 'time_cron_suppliers_api23', '0'),
(246, 'show_btn_category_home', '1'),
(247, 'time_cron_suppliers_api24', '0'),
(248, 'status_only_ip_login_admin', '1'),
(249, 'time_cron_checklive_instagram', '1735476466'),
(250, 'check_time_cron_thesieure', '0'),
(251, 'thesieure_status', '1'),
(252, 'thesieure_number', '0999999999'),
(253, 'thesieure_email', 'mail@mail.com'),
(254, 'thesieure_token', ''),
(255, 'thesieure_notice', ''),
(256, 'thesieure_name', 'NGUYEN TAN THANH'),
(257, 'crypto_type_api', 'fpayment.net'),
(258, 'crypto_merchant_id', ''),
(259, 'crypto_api_key', ''),
(260, 'time_cron_suppliers_api25', '1734801278'),
(261, 'api_check_live_instagram', ''),
(262, 'api_key_check_live_instagram', ''),
(263, 'time_limit_check_live_instagram', '10'),
(266, 'isLoginRequiredToViewProduct', '0'),
(267, 'telegram_assistant_status', '0'),
(268, 'telegram_assistant_token', ''),
(269, 'telegram_assistant_list_username', ''),
(271, 'telegram_assistant_LicenseKey', ''),
(272, 'status_only_device_client', '1'),
(273, 'status_only_device_admin', '1'),
(274, 'is_uid_visible', '1'),
(275, 'list_network_topup_card', 'VIETTEL|Viettel\r\nVINAPHONE|Vinaphone\r\nMOBIFONE|Mobifone\r\nVNMOBI|Vietnamobile\r\nZING|Zing\r\nVCOIN|Vcoin\r\nGARENA|Garena (chỉ nhận thẻ trên 10k)\r\n'),
(276, 'gateway_xipay_status', '1'),
(277, 'xipay_notice', ''),
(278, 'xipay_min', '1'),
(279, 'xipay_max', '1000000'),
(280, 'gateway_xipay_md5key', ''),
(281, 'gateway_xipay_pid', ''),
(282, 'gateway_xipay_rate', '3508'),
(283, 'gateway_xipay_license', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_key` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `coupon` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `discount` float NOT NULL DEFAULT 0,
  `update_name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `sync_category` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'OFF',
  `update_price` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `roundMoney` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ON',
  `status` int(11) NOT NULL DEFAULT 1,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `check_string_api` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ON'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `telegram_logs`
--

CREATE TABLE `telegram_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `command` varchar(100) DEFAULT NULL,
  `params` text DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `translate`
--

CREATE TABLE `translate` (
  `id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL DEFAULT 0,
  `name` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `translate`
--

INSERT INTO `translate` (`id`, `lang_id`, `name`, `value`) VALUES
(1, 1, 'Vui lòng nhập username', 'Vui lòng nhập username'),
(2, 2, 'Vui lòng nhập username', 'Please enter username'),
(3, 1, 'Vui lòng nhập mật khẩu', 'Vui lòng nhập mật khẩu'),
(4, 2, 'Vui lòng nhập mật khẩu', 'Please enter a password'),
(5, 1, 'Vui lòng xác minh Captcha', 'Vui lòng xác minh Captcha'),
(6, 2, 'Vui lòng xác minh Captcha', 'Please verify Captcha'),
(7, 1, 'Thông tin đăng nhập không chính xác', 'Thông tin đăng nhập không chính xác'),
(8, 2, 'Thông tin đăng nhập không chính xác', 'Login information is incorrect'),
(9, 1, 'Vui lòng nhập địa chỉ Email', 'Vui lòng nhập địa chỉ Email'),
(10, 2, 'Vui lòng nhập địa chỉ Email', 'Please enter your email address'),
(11, 1, 'Vui lòng nhập lại mật khẩu', 'Vui lòng nhập lại mật khẩu'),
(12, 2, 'Vui lòng nhập lại mật khẩu', 'Please re-enter your password'),
(13, 1, 'Xác minh mật khẩu không chính xác', 'Xác minh mật khẩu không chính xác'),
(14, 2, 'Xác minh mật khẩu không chính xác', 'Verify password is incorrect'),
(15, 1, 'Tên đăng nhập đã tồn tại trong hệ thống', 'Tên đăng nhập đã tồn tại trong hệ thống'),
(16, 2, 'Tên đăng nhập đã tồn tại trong hệ thống', 'Username already exists in the system'),
(17, 1, 'Địa chỉ email đã tồn tại trong hệ thống', 'Địa chỉ email đã tồn tại trong hệ thống'),
(18, 2, 'Địa chỉ email đã tồn tại trong hệ thống', 'Email address already exists in the system'),
(19, 1, 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép', 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép'),
(20, 2, 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép', 'Your IP has reached the allowable account creation limit'),
(21, 1, 'Đăng ký thành công!', 'Đăng ký thành công!'),
(22, 2, 'Đăng ký thành công!', 'Sign Up Success!'),
(23, 1, 'Tạo tài khoản không thành công, vui lòng thử lại', 'Tạo tài khoản không thành công, vui lòng thử lại'),
(24, 2, 'Tạo tài khoản không thành công, vui lòng thử lại', 'Account creation failed, please try again'),
(25, 1, 'Vui lòng đăng nhập', 'Vui lòng đăng nhập'),
(26, 2, 'Vui lòng đăng nhập', 'please log in'),
(27, 1, 'Lưu thành công', 'Lưu thành công'),
(28, 2, 'Lưu thành công', 'Save successfully'),
(29, 1, 'Lưu thất bại', 'Lưu thất bại'),
(30, 2, 'Lưu thất bại', 'Save failed'),
(31, 1, 'Vui lòng nhập mật khẩu hiện tại', 'Vui lòng nhập mật khẩu hiện tại'),
(32, 2, 'Vui lòng nhập mật khẩu hiện tại', 'Please enter your current password'),
(33, 1, 'Vui lòng nhập mật khẩu mới', 'Vui lòng nhập mật khẩu mới'),
(34, 2, 'Vui lòng nhập mật khẩu mới', 'Please enter a new password'),
(35, 1, 'Mật khẩu mới quá ngắn', 'Mật khẩu mới quá ngắn'),
(36, 2, 'Mật khẩu mới quá ngắn', 'New password is too short'),
(37, 1, 'Xác nhận mật khẩu không chính xác', 'Xác nhận mật khẩu không chính xác'),
(38, 2, 'Xác nhận mật khẩu không chính xác', 'Confirm password is incorrect'),
(39, 1, 'Mật khẩu hiện tại không đúng', 'Mật khẩu hiện tại không đúng'),
(40, 2, 'Mật khẩu hiện tại không đúng', 'Current password is incorrect'),
(41, 1, 'Địa chỉ Email này không tồn tại trong hệ thống', 'Địa chỉ Email này không tồn tại trong hệ thống'),
(42, 2, 'Địa chỉ Email này không tồn tại trong hệ thống', 'This email address does not exist in the system'),
(43, 1, 'Vui lòng thử lại trong ít phút', 'Vui lòng thử lại trong ít phút'),
(44, 2, 'Vui lòng thử lại trong ít phút', 'Please try again in a few minutes'),
(45, 1, 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.', 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.'),
(46, 2, 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.', 'If you require a password reset, please click the link below to verify.'),
(47, 1, 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.', 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.'),
(48, 2, 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.', 'If not you, please contact your Administrator immediately for security assistance.'),
(49, 1, 'Xác nhận tìm mật khẩu website', 'Xác nhận tìm mật khẩu website'),
(50, 2, 'Xác nhận tìm mật khẩu website', 'Confirm to find the website password'),
(51, 1, 'Xác nhận khôi phục mật khẩu', 'Xác nhận khôi phục mật khẩu'),
(52, 2, 'Xác nhận khôi phục mật khẩu', 'Confirm Password Recovery'),
(53, 1, 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu', 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu'),
(54, 2, 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu', 'Please check your Email to complete the password reset process'),
(55, 1, 'Có lỗi hệ thống, vui lòng liên hệ Developer', 'Có lỗi hệ thống, vui lòng liên hệ Developer'),
(56, 2, 'Có lỗi hệ thống, vui lòng liên hệ Developer', 'There is a system error, please contact Developer'),
(57, 1, 'Liên kết không tồn tại', 'Liên kết không tồn tại'),
(58, 2, 'Liên kết không tồn tại', 'Link does not exist'),
(59, 1, 'Thay đổi mật khẩu thành công', 'Thay đổi mật khẩu thành công'),
(60, 2, 'Thay đổi mật khẩu thành công', 'Change password successfully'),
(61, 1, 'Thay đổi mật khẩu thất bại', 'Thay đổi mật khẩu thất bại'),
(62, 2, 'Thay đổi mật khẩu thất bại', 'Password change failed'),
(63, 1, 'Hồ sơ của bạn', 'Hồ sơ của bạn'),
(64, 2, 'Hồ sơ của bạn', 'Your Profile'),
(65, 1, 'Tên đăng nhập', 'Tên đăng nhập'),
(66, 2, 'Tên đăng nhập', 'Username'),
(67, 1, 'Địa chỉ Email', 'Địa chỉ Email'),
(68, 2, 'Địa chỉ Email', 'Email address'),
(69, 1, 'Số điện thoại', 'Số điện thoại'),
(70, 2, 'Số điện thoại', 'Phone number'),
(71, 1, 'Họ và Tên', 'Họ và Tên'),
(72, 2, 'Họ và Tên', 'Full name'),
(73, 1, 'Địa chỉ IP', 'Địa chỉ IP'),
(74, 2, 'Địa chỉ IP', 'IP address'),
(75, 1, 'Thiết bị', 'Thiết bị'),
(76, 2, 'Thiết bị', 'Device'),
(77, 1, 'Đăng ký vào lúc', 'Đăng ký vào lúc'),
(78, 2, 'Đăng ký vào lúc', 'Sign up at'),
(79, 1, 'Đăng nhập gần nhất', 'Đăng nhập gần nhất'),
(80, 2, 'Đăng nhập gần nhất', 'Last login'),
(81, 1, 'Chỉnh sửa thông tin', 'Chỉnh sửa thông tin'),
(82, 2, 'Chỉnh sửa thông tin', 'Edit information'),
(83, 1, 'Thay đổi mật khẩu', 'Thay đổi mật khẩu'),
(84, 2, 'Thay đổi mật khẩu', 'Change password'),
(85, 1, 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.', 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.'),
(86, 2, 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.', 'Changing your login password is an easy way to keep your account secure.'),
(87, 1, 'Mật khẩu hiện tại', 'Mật khẩu hiện tại'),
(88, 2, 'Mật khẩu hiện tại', 'Current password'),
(89, 1, 'Mật khẩu mới', 'Mật khẩu mới'),
(90, 2, 'Mật khẩu mới', 'New password'),
(91, 1, 'Nhập lại mật khẩu mới', 'Nhập lại mật khẩu mới'),
(92, 2, 'Nhập lại mật khẩu mới', 'Re-verify new password'),
(93, 1, 'Cập Nhật', 'Cập Nhật'),
(94, 2, 'Cập Nhật', 'Update'),
(95, 1, 'Đăng Xuất', 'Đăng Xuất'),
(96, 2, 'Đăng Xuất', 'Logout'),
(97, 1, 'Bạn có chắc không?', 'Bạn có chắc không?'),
(98, 2, 'Bạn có chắc không?', 'Are you sure?'),
(99, 1, 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý', 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý'),
(100, 2, 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý', 'You will be posted from the account when click Okey'),
(101, 1, 'Đồng ý', 'Đồng ý'),
(102, 2, 'Đồng ý', 'Okey'),
(103, 1, 'Huỷ bỏ', 'Huỷ bỏ'),
(104, 2, 'Huỷ bỏ', 'Cancel'),
(105, 1, 'Đăng Nhập', 'Đăng Nhập'),
(106, 2, 'Đăng Nhập', 'Sign In'),
(107, 1, 'Vui Lòng Đăng Nhập Để Tiếp Tục', 'Vui Lòng Đăng Nhập Để Tiếp Tục'),
(108, 2, 'Vui Lòng Đăng Nhập Để Tiếp Tục', 'Please Login To Continue'),
(109, 1, 'Quên mật khẩu', 'Quên mật khẩu'),
(110, 2, 'Quên mật khẩu', 'Forgot password'),
(111, 1, 'Bạn quên mật khẩu?', 'Bạn quên mật khẩu?'),
(112, 2, 'Bạn quên mật khẩu?', 'Forgot your password?'),
(113, 1, 'Vui lòng nhập thông tin vào ô dưới đây để xác minh', 'Vui lòng nhập thông tin vào ô dưới đây để xác minh'),
(114, 2, 'Vui lòng nhập thông tin vào ô dưới đây để xác minh', 'Please enter information in the box below to verify'),
(115, 1, 'Xác minh', 'Xác minh'),
(116, 2, 'Xác minh', 'Verification'),
(117, 1, 'Bạn đã có tài khoản?', 'Bạn đã có tài khoản?'),
(118, 2, 'Bạn đã có tài khoản?', 'Do you already have an account?'),
(119, 1, 'Ghi nhớ tôi', 'Ghi nhớ tôi'),
(120, 2, 'Ghi nhớ tôi', 'Remember'),
(121, 1, 'Quên mật khẩu?', 'Quên mật khẩu?'),
(122, 2, 'Quên mật khẩu?', 'Forgot password?'),
(123, 1, 'Bạn chưa có tài khoản?', 'Bạn chưa có tài khoản?'),
(124, 2, 'Bạn chưa có tài khoản?', 'Do not have an account?'),
(125, 1, 'Đăng Ký Ngay', 'Đăng Ký Ngay'),
(126, 2, 'Đăng Ký Ngay', 'Register'),
(127, 1, 'Nạp tiền', 'Nạp tiền'),
(128, 2, 'Nạp tiền', 'Recharge'),
(129, 1, 'Ngân hàng', 'Ngân hàng'),
(130, 2, 'Ngân hàng', 'Bank'),
(131, 1, 'Ví của tôi', 'Ví của tôi'),
(132, 2, 'Ví của tôi', 'My Wallet'),
(133, 1, 'Số dư hiện tại', 'Số dư hiện tại'),
(134, 2, 'Số dư hiện tại', 'Current balance'),
(135, 1, 'Tổng tiền nạp', 'Tổng tiền nạp'),
(136, 2, 'Tổng tiền nạp', 'Total Deposit'),
(137, 1, 'Số dư đã sử dụng', 'Số dư đã sử dụng'),
(138, 2, 'Số dư đã sử dụng', 'Used Balance'),
(139, 1, 'THANH TOÁN', 'Thanh toán'),
(141, 1, 'Lưu ý nạp tiền', 'Lưu ý nạp tiền'),
(142, 2, 'Lưu ý nạp tiền', 'Recharge note'),
(143, 1, 'Lịch sử nạp tiền', 'Lịch sử nạp tiền'),
(144, 2, 'Lịch sử nạp tiền', 'Recharge History'),
(145, 1, 'Số tài khoản:', 'Số tài khoản:'),
(146, 2, 'Số tài khoản:', 'Account number:'),
(147, 1, 'Chủ tài khoản:', 'Chủ tài khoản:'),
(148, 2, 'Chủ tài khoản:', 'Account name:'),
(149, 1, 'Ngân hàng:', 'Ngân hàng:'),
(150, 2, 'Ngân hàng:', 'Bank:'),
(151, 1, 'Nội dung chuyển khoản:', 'Nội dung chuyển khoản:'),
(152, 2, 'Nội dung chuyển khoản:', 'Transfer content:'),
(153, 1, 'Mã giao dịch', 'Mã giao dịch'),
(154, 2, 'Mã giao dịch', 'Transaction'),
(155, 1, 'Nội dung', 'Nội dung'),
(156, 2, 'Nội dung', 'Content'),
(157, 1, 'Số tiền nạp', 'Số tiền nạp'),
(158, 2, 'Số tiền nạp', 'Amount'),
(159, 1, 'Thực nhận', 'Thực nhận'),
(160, 2, 'Thực nhận', 'Received'),
(161, 1, 'Thời gian', 'Thời gian'),
(162, 2, 'Thời gian', 'Time'),
(163, 1, 'Trạng thái', 'Trạng thái'),
(164, 2, 'Trạng thái', 'Status'),
(165, 1, 'Đã thanh toán', 'Đã thanh toán'),
(166, 2, 'Đã thanh toán', 'Paid'),
(167, 1, 'Tất cả', 'Tất cả'),
(168, 2, 'Tất cả', 'ALL'),
(169, 1, 'Hôm nay', 'Hôm nay'),
(170, 2, 'Hôm nay', 'Today'),
(171, 1, 'Tuần này', 'Tuần này'),
(172, 2, 'Tuần này', 'This week'),
(173, 1, 'Tháng này', 'Tháng này'),
(174, 2, 'Tháng này', 'This month'),
(175, 1, 'Đã thanh toán:', 'Đã thanh toán:'),
(176, 2, 'Đã thanh toán:', 'Paid:'),
(177, 1, 'Thực nhận:', 'Thực nhận:'),
(178, 2, 'Thực nhận:', 'Received:'),
(179, 1, 'Thao tác', 'Thao tác'),
(180, 2, 'Thao tác', 'Action'),
(181, 1, 'Nhật ký hoạt động', 'Nhật ký hoạt động'),
(182, 2, 'Nhật ký hoạt động', 'Activity Log'),
(183, 1, 'Tìm kiếm', 'Tìm kiếm'),
(184, 2, 'Tìm kiếm', 'Search'),
(185, 1, 'Bỏ lọc', 'Bỏ lọc'),
(186, 2, 'Bỏ lọc', 'Clear Filter'),
(187, 1, 'Hiển thị', 'Hiển thị'),
(188, 2, 'Hiển thị', 'Show'),
(189, 1, 'Ẩn', 'Ẩn'),
(190, 2, 'Ẩn', 'Hide'),
(191, 1, 'Biến động số dư', 'Biến động số dư'),
(192, 2, 'Biến động số dư', 'Transactions'),
(193, 1, 'Số dư ban đầu', 'Số dư ban đầu'),
(194, 2, 'Số dư ban đầu', 'Initial balance'),
(195, 1, 'Số dư thay đổi', 'Số dư thay đổi'),
(196, 2, 'Số dư thay đổi', 'Balance change'),
(197, 1, 'Lý do', 'Lý do'),
(198, 2, 'Lý do', 'Reason'),
(199, 1, 'Chọn thời gian cần tìm', 'Chọn thời gian cần tìm'),
(200, 2, 'Chọn thời gian cần tìm', 'Choose a time to search'),
(203, 2, 'Hiển thị thêm', 'Show more'),
(204, 1, 'Hiển thị thêm', 'Hiển thị thêm'),
(205, 1, 'Ẩn bớt', 'Ẩn bớt'),
(206, 2, 'Ẩn bớt', 'Hide'),
(207, 1, 'Nội dung chuyển khoản', 'Nội dung chuyển khoản'),
(208, 2, 'Nội dung chuyển khoản', 'Transfer contents'),
(209, 1, 'Đăng nhập bằng Google', 'Đăng nhập bằng Google'),
(210, 2, 'Đăng nhập bằng Google', 'Login with Google'),
(211, 1, 'Đăng nhập bằng Facebook', 'Đăng nhập bằng Facebook'),
(212, 2, 'Đăng nhập bằng Facebook', 'Login with Google'),
(213, 1, 'Đăng ký tài khoản', 'Đăng ký tài khoản'),
(214, 2, 'Đăng ký tài khoản', 'Sign up for an account'),
(215, 1, 'Tài khoản đăng nhập', 'Tài khoản đăng nhập'),
(216, 2, 'Tài khoản đăng nhập', 'Username'),
(217, 1, 'Mật khẩu', 'Mật khẩu'),
(218, 2, 'Mật khẩu', 'Password'),
(219, 1, 'Nhập lại mật khẩu', 'Nhập lại mật khẩu'),
(220, 2, 'Nhập lại mật khẩu', 'Confirm password'),
(221, 1, 'Đăng Ký', 'Đăng Ký'),
(222, 2, 'Đăng Ký', 'Register'),
(223, 1, 'Vui lòng nhập thông tin đăng ký', 'Vui lòng nhập thông tin đăng ký'),
(224, 2, 'Vui lòng nhập thông tin đăng ký', 'Please enter registration information'),
(225, 1, 'Vui lòng nhập thông tin đăng nhập', 'Vui lòng nhập thông tin đăng nhập'),
(226, 2, 'Vui lòng nhập thông tin đăng nhập', 'Please enter login information'),
(227, 1, 'Thông tin cá nhân', 'Thông tin cá nhân'),
(228, 2, 'Thông tin cá nhân', 'Personal information'),
(229, 1, 'Cấu hình nạp tiền Crypto', 'Cấu hình nạp tiền Crypto'),
(230, 2, 'Cấu hình nạp tiền Crypto', 'Configuration Recharge Crypto'),
(231, 1, 'All Time', 'All Time'),
(232, 2, 'All Time', 'Toàn thời gian'),
(235, 1, 'Thống kê thanh toán tháng', 'Thống kê thanh toán tháng'),
(236, 2, 'Thống kê thanh toán tháng', 'Payment Statistics Month'),
(237, 1, 'Lịch sử nạp tiền Crypto', 'Lịch sử nạp tiền Crypto'),
(238, 2, 'Lịch sử nạp tiền Crypto', 'Crypto Deposit History'),
(239, 1, 'Thống kê', 'Thống kê'),
(240, 2, 'Thống kê', 'Statistical'),
(241, 1, 'Cấu hình', 'Cấu hình'),
(242, 2, 'Cấu hình', 'Configuration'),
(243, 1, 'Nạp tối đa', 'Nạp tối đa'),
(244, 2, 'Nạp tối đa', 'Maximum deposit amount'),
(245, 1, 'Nạp tối thiểu', 'Nạp tối thiểu'),
(246, 2, 'Nạp tối thiểu', 'Minimum deposit amount'),
(247, 1, 'Nạp tiền bằng Crypto', 'Nạp tiền bằng Crypto'),
(248, 2, 'Nạp tiền bằng Crypto', 'Deposit with Crypto'),
(249, 1, 'Lưu ý', 'Lưu ý'),
(250, 2, 'Lưu ý', 'Note'),
(251, 1, 'Lịch sử nạp Crypto', 'Lịch sử nạp Crypto'),
(252, 2, 'Lịch sử nạp Crypto', 'Crypto Deposit History'),
(253, 1, 'Số lượng', 'Số lượng'),
(254, 2, 'Số lượng', 'Amount'),
(255, 1, 'Thời gian tạo', 'Thời gian tạo'),
(256, 2, 'Thời gian tạo', 'Create date'),
(257, 1, 'Xem thêm', 'Xem thêm'),
(258, 2, 'Xem thêm', 'See more'),
(259, 1, 'The minimum deposit amount is:', 'The minimum deposit amount is:'),
(261, 1, 'Số tiền gửi tối đa là:', 'Số tiền gửi tối đa là:'),
(262, 2, 'Số tiền gửi tối đa là:', 'The maximum deposit amount is:'),
(263, 1, 'Số tiền gửi tối thiểu là:', 'Số tiền gửi tối thiểu là:'),
(264, 2, 'Số tiền gửi tối thiểu là:', 'The minimum deposit amount is:'),
(265, 1, 'Chức năng này đang được bảo trì', 'Chức năng này đang được bảo trì'),
(266, 2, 'Chức năng này đang được bảo trì', 'This function is under maintenance'),
(267, 1, 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau', 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau'),
(268, 2, 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau', 'Invoice could not be generated due to API error, please try again later'),
(269, 1, 'Tạo hoá đơn nạp tiền thành công', 'Tạo hoá đơn nạp tiền thành công'),
(270, 2, 'Tạo hoá đơn nạp tiền thành công', 'Deposit request created successfully'),
(271, 1, 'Nạp tiền bằng PayPal', 'Nạp tiền bằng PayPal'),
(272, 2, 'Nạp tiền bằng PayPal', 'Pay with PayPal'),
(273, 1, 'Lịch sử nạp PayPal', 'Lịch sử nạp PayPal'),
(274, 2, 'Lịch sử nạp PayPal', 'PayPal Recharge History'),
(275, 1, 'Số tiền gửi', 'Số tiền gửi'),
(276, 2, 'Số tiền gửi', 'Amount'),
(277, 1, 'Vui lòng nhập số tiền cần nạp', 'Vui lòng nhập số tiền cần nạp'),
(278, 2, 'Vui lòng nhập số tiền cần nạp', 'Please enter the amount to deposit'),
(279, 1, 'Mặc định', 'Mặc định'),
(280, 2, 'Mặc định', 'Default'),
(281, 1, 'Phổ biến', 'Phổ biến'),
(282, 2, 'Phổ biến', 'Popular'),
(283, 1, 'Tìm kiếm bài viết', 'Tìm kiếm bài viết'),
(284, 2, 'Tìm kiếm bài viết', 'Find Blogs'),
(285, 1, 'Bài viết phổ biến', 'Bài viết phổ biến'),
(286, 2, 'Bài viết phổ biến', 'Popular Feeds'),
(287, 1, 'Liên kết giới thiệu của bạn', 'Liên kết giới thiệu của bạn'),
(288, 2, 'Liên kết giới thiệu của bạn', 'Your referral link'),
(289, 1, 'Đã sao chép vào bộ nhớ tạm', 'Đã sao chép vào bộ nhớ tạm'),
(290, 2, 'Đã sao chép vào bộ nhớ tạm', 'Copied to clipboard'),
(291, 1, 'Số tài khoản', 'Số tài khoản'),
(292, 2, 'Số tài khoản', 'Account number'),
(293, 1, 'Tên chủ tài khoản', 'Tên chủ tài khoản'),
(294, 2, 'Tên chủ tài khoản', 'Account name'),
(295, 1, 'Số tiền cần rút', 'Số tiền cần rút'),
(296, 2, 'Số tiền cần rút', 'Amount to withdraw'),
(297, 1, 'Rút số dư hoa hồng', 'Rút số dư hoa hồng'),
(298, 2, 'Rút số dư hoa hồng', 'Affiliate Withdraw'),
(299, 1, 'Lịch sử rút tiền', 'Lịch sử rút tiền'),
(300, 2, 'Lịch sử rút tiền', 'Withdraw history'),
(301, 1, 'Rút tiền', 'Rút tiền'),
(302, 2, 'Rút tiền', 'Withdraw'),
(303, 1, 'Lịch sử', 'Lịch sử'),
(304, 2, 'Lịch sử', 'History'),
(305, 1, 'Thao tác quá nhanh, vui lòng chờ', 'Thao tác quá nhanh, vui lòng chờ'),
(306, 2, 'Thao tác quá nhanh, vui lòng chờ', 'You are working too fast, please wait'),
(307, 1, 'Vui lòng chọn ngân hàng cần rút', 'Vui lòng chọn ngân hàng cần rút'),
(308, 2, 'Vui lòng chọn ngân hàng cần rút', 'Please select the bank to withdraw'),
(309, 1, 'Vui lòng nhập số tài khoản cần rút', 'Vui lòng nhập số tài khoản cần rút'),
(310, 2, 'Vui lòng nhập số tài khoản cần rút', 'Please enter the account number to withdraw'),
(311, 1, 'Vui lòng nhập tên chủ tài khoản', 'Vui lòng nhập tên chủ tài khoản'),
(312, 2, 'Vui lòng nhập tên chủ tài khoản', 'Please enter the account name'),
(313, 1, 'Vui lòng nhập số tiền cần rút', 'Vui lòng nhập số tiền cần rút'),
(314, 2, 'Vui lòng nhập số tiền cần rút', 'Please enter the amount to withdraw'),
(315, 1, 'Số tiền rút tối thiểu phải là', 'Số tiền rút tối thiểu phải là'),
(316, 2, 'Số tiền rút tối thiểu phải là', 'Minimum withdrawal amount should be'),
(317, 1, 'Số dư hoa hồng khả dụng của bạn không đủ', 'Số dư hoa hồng khả dụng của bạn không đủ'),
(318, 2, 'Số dư hoa hồng khả dụng của bạn không đủ', 'Your available commission balance is not enough'),
(319, 1, 'Gian lận khi rút số dư hoa hồng', 'Gian lận khi rút số dư hoa hồng'),
(320, 2, 'Gian lận khi rút số dư hoa hồng', 'Fraud when withdrawing commission balance'),
(321, 1, 'Tài khoản của bạn đã bị khóa vì gian lận', 'Tài khoản của bạn đã bị khóa vì gian lận'),
(322, 2, 'Tài khoản của bạn đã bị khóa vì gian lận', 'Your account has been blocked for cheating'),
(323, 1, 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý', 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý'),
(324, 2, 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý', 'Withdrawal request created successfully, please wait for ADMIN to process'),
(325, 1, 'Số tiền rút', 'Số tiền rút'),
(326, 2, 'Số tiền rút', 'Withdrawal amount'),
(327, 1, 'Thông kê của bạn', 'Thông kê của bạn'),
(328, 2, 'Thông kê của bạn', 'Your stats'),
(329, 1, 'Số tiền hoa hồng khả dụng', 'Số tiền hoa hồng khả dụng'),
(330, 2, 'Số tiền hoa hồng khả dụng', 'Amount of available commission'),
(331, 1, 'Tổng số tiền hoa hồng đã nhận', 'Tổng số tiền hoa hồng đã nhận'),
(332, 2, 'Tổng số tiền hoa hồng đã nhận', 'Total commission received'),
(333, 1, 'Số lần nhấp vào liên kết', 'Số lần nhấp vào liên kết'),
(334, 2, 'Số lần nhấp vào liên kết', 'Clicks'),
(335, 1, 'Lịch sử hoa hồng', 'Lịch sử hoa hồng'),
(336, 2, 'Lịch sử hoa hồng', 'History commission'),
(337, 1, 'Hoa hồng ban đầu', 'Hoa hồng ban đầu'),
(338, 2, 'Hoa hồng ban đầu', 'Initial commission balance'),
(339, 1, 'Hoa hồng thay đổi', 'Hoa hồng thay đổi'),
(340, 2, 'Hoa hồng thay đổi', 'Change commission balance'),
(341, 1, 'Hoa hồng hiện tại', 'Hoa hồng hiện tại'),
(342, 2, 'Hoa hồng hiện tại', 'Current commission balance'),
(343, 1, 'Vui lòng nhập số lượng cần mua', 'Vui lòng nhập số lượng cần mua'),
(344, 2, 'Vui lòng nhập số lượng cần mua', 'Please enter the quantity'),
(345, 1, 'Tổng tiền thanh toán:', 'Tổng tiền thanh toán:'),
(346, 2, 'Tổng tiền thanh toán:', 'Total payment:'),
(347, 1, 'Số tiền giảm:', 'Số tiền giảm:'),
(348, 2, 'Số tiền giảm:', 'Discount:'),
(349, 1, 'Thành tiền:', 'Thành tiền:'),
(350, 2, 'Thành tiền:', 'Price:'),
(351, 1, 'Mã giảm giá:', 'Mã giảm giá:'),
(352, 2, 'Mã giảm giá:', 'Coupon:'),
(353, 1, 'Nhập mã giảm giá nếu có', 'Nhập mã giảm giá nếu có'),
(354, 2, 'Nhập mã giảm giá nếu có', 'Enter discount code if available'),
(355, 1, 'THÔNG TIN MUA HÀNG', 'THÔNG TIN MUA HÀNG'),
(356, 2, 'THÔNG TIN MUA HÀNG', 'PURCHASE INFORMATION'),
(357, 1, 'Số lượng cần mua:', 'Số lượng cần mua:'),
(358, 2, 'Số lượng cần mua:', 'Amount:'),
(359, 1, 'Chia sẻ:', 'Chia sẻ:'),
(360, 2, 'Chia sẻ:', 'Share:'),
(361, 1, 'Mua Ngay', 'Mua Ngay'),
(362, 2, 'Mua Ngay', 'Buy Now'),
(363, 1, 'Kho hàng:', 'Kho hàng:'),
(364, 2, 'Kho hàng:', 'Stock:'),
(365, 1, 'Đã bán:', 'Đã bán:'),
(366, 2, 'Đã bán:', 'Sold:'),
(367, 1, 'Yêu Thích', 'Yêu Thích'),
(368, 2, 'Yêu Thích', 'Add Favourite'),
(369, 1, 'Bỏ Thích', 'Bỏ Thích'),
(370, 2, 'Bỏ Thích', 'Remove Favourite'),
(371, 1, 'Danh sách sản phẩm yêu thích', 'Danh sách sản phẩm yêu thích'),
(372, 2, 'Danh sách sản phẩm yêu thích', 'Favorites'),
(373, 1, 'Sản phẩm', 'Sản phẩm'),
(374, 2, 'Sản phẩm', 'Product'),
(375, 1, 'Kho hàng', 'Kho hàng'),
(376, 2, 'Kho hàng', 'Stock'),
(377, 1, 'Giá', 'Giá'),
(378, 2, 'Giá', 'Price'),
(379, 1, 'Mua', 'Mua'),
(380, 2, 'Mua', 'Buy'),
(381, 1, 'Xem', 'Xem'),
(382, 2, 'Xem', 'View'),
(383, 1, 'Xóa', 'Xóa'),
(384, 2, 'Xóa', 'Delete'),
(385, 1, 'Hết hàng', 'Hết hàng'),
(386, 2, 'Hết hàng', 'Out of Stock'),
(387, 1, 'Thêm vào mục yêu thích', 'Thêm vào mục yêu thích'),
(388, 2, 'Thêm vào mục yêu thích', 'Add to Favorites'),
(389, 1, 'Đã thêm vào mục yêu thích', 'Đã thêm vào mục yêu thích'),
(390, 2, 'Đã thêm vào mục yêu thích', 'Added to Favorites'),
(393, 2, 'Lịch sử đơn hàng', 'Order History'),
(394, 1, 'Xóa đơn hàng', 'Xóa đơn hàng'),
(395, 2, 'Xóa đơn hàng', 'Delete Order'),
(396, 1, 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn', 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn'),
(397, 2, 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn', 'Delete selected orders from your history'),
(398, 1, 'Mã đơn hàng', 'Mã đơn hàng'),
(399, 2, 'Mã đơn hàng', 'Transaction'),
(400, 2, 'Thanh toán', 'Pay'),
(401, 1, 'Xem chi tiết', 'Xem chi tiết'),
(402, 2, 'Xem chi tiết', 'See details'),
(403, 1, 'Tải về máy', 'Tải về máy'),
(404, 2, 'Tải về máy', 'Download'),
(405, 1, 'Xóa khỏi lịch sử', 'Xóa khỏi lịch sử'),
(406, 2, 'Xóa khỏi lịch sử', 'Delete from history'),
(407, 1, 'Liên hệ', 'Liên hệ'),
(408, 2, 'Liên hệ', 'Contact'),
(409, 1, 'Chính sách', 'Chính sách'),
(410, 2, 'Chính sách', 'Policy'),
(411, 1, 'Tài liệu API', 'Tài liệu API'),
(412, 2, 'Tài liệu API', 'API Document'),
(413, 1, 'Trang chủ', 'Trang chủ'),
(414, 2, 'Trang chủ', 'Home'),
(415, 1, 'Liên kết', 'Liên kết'),
(416, 2, 'Liên kết', 'Links'),
(417, 1, 'Câu hỏi thường gặp', 'Câu hỏi thường gặp'),
(418, 2, 'Câu hỏi thường gặp', 'FAQ'),
(419, 1, 'Liên hệ chúng tôi', 'Liên hệ chúng tôi'),
(420, 2, 'Liên hệ chúng tôi', 'Contact us'),
(421, 1, 'Sản phẩm:', 'Sản phẩm:'),
(422, 2, 'Sản phẩm:', 'Product:'),
(423, 1, 'Số lượng mua:', 'Số lượng mua:'),
(424, 2, 'Số lượng mua:', 'Quantity purchased:'),
(425, 1, 'Thanh toán:', 'Thanh toán:'),
(426, 2, 'Thanh toán:', 'Pay:'),
(427, 1, 'Mã đơn hàng:', 'Mã đơn hàng:'),
(428, 2, 'Mã đơn hàng:', 'Transaction:'),
(429, 1, 'Chi tiết đơn hàng', 'Chi tiết đơn hàng'),
(430, 2, 'Chi tiết đơn hàng', 'Order details'),
(431, 1, 'Tài khoản', 'Tài khoản'),
(432, 2, 'Tài khoản', 'Account'),
(433, 1, 'Lưu các tài khoản đã chọn vào tệp .txt', 'Lưu các tài khoản đã chọn vào tệp .txt'),
(434, 2, 'Lưu các tài khoản đã chọn vào tệp .txt', 'Save selected accounts to a .txt file'),
(435, 1, 'Sao chép các tài khoản đã chọn', 'Sao chép các tài khoản đã chọn'),
(436, 2, 'Sao chép các tài khoản đã chọn', 'Copy selected accounts'),
(437, 1, 'Chỉ sao chép UID các tài khoản đã chọn', 'Chỉ sao chép UID các tài khoản đã chọn'),
(438, 2, 'Chỉ sao chép UID các tài khoản đã chọn', 'Copy only the UID of the selected accounts'),
(439, 1, 'Số dư của tôi:', 'Số dư của tôi:'),
(440, 2, 'Số dư của tôi:', 'My balance:'),
(441, 1, 'Khuyến mãi', 'Khuyến mãi'),
(442, 2, 'Khuyến mãi', 'Promotion'),
(443, 1, 'Số tiền nạp lớn hơn hoặc bằng', 'Số tiền nạp lớn hơn hoặc bằng'),
(444, 2, 'Số tiền nạp lớn hơn hoặc bằng', 'The deposit amount is greater than or equal to'),
(445, 1, 'Khuyến mãi thêm', 'Khuyến mãi thêm'),
(446, 2, 'Khuyến mãi thêm', 'Extra'),
(447, 1, 'Thông tin chi tiết khách hàng', 'Thông tin chi tiết khách hàng'),
(448, 2, 'Thông tin chi tiết khách hàng', 'Customer details'),
(449, 1, 'Chia sẻ liên kết này lên mạng xã hội hoặc bạn bè của bạn.', 'Chia sẻ liên kết này lên mạng xã hội hoặc bạn bè của bạn.'),
(451, 1, 'Tài liệu tích hợp API', 'Tài liệu tích hợp API'),
(452, 2, 'Tài liệu tích hợp API', 'API integration documentation'),
(453, 1, 'Lấy thông tin tài khoản', 'Lấy thông tin tài khoản'),
(454, 2, 'Lấy thông tin tài khoản', 'Get account information'),
(455, 1, 'Lấy danh sách chuyên mục và sản phẩm', 'Lấy danh sách chuyên mục và sản phẩm'),
(456, 2, 'Lấy danh sách chuyên mục và sản phẩm', 'Get a list of categories and products'),
(457, 1, 'Mua hàng', 'Mua hàng'),
(458, 2, 'Mua hàng', 'Purchase'),
(459, 1, 'ID sản phẩm cần mua', 'ID sản phẩm cần mua'),
(460, 2, 'ID sản phẩm cần mua', 'Product ID to buy'),
(461, 1, 'Số lượng cần mua', 'Số lượng cần mua'),
(462, 2, 'Số lượng cần mua', 'Quantity to buy'),
(463, 1, 'Mã giảm giá nếu có', 'Mã giảm giá nếu có'),
(464, 2, 'Mã giảm giá nếu có', 'Discount code if available'),
(465, 1, 'Bảo mật', 'Bảo mật'),
(466, 2, 'Bảo mật', 'Security'),
(467, 1, 'Bảo mật tài khoản', 'Bảo mật tài khoản'),
(468, 2, 'Bảo mật tài khoản', 'Account security'),
(469, 1, 'Xác minh đăng nhập bằng', 'Xác minh đăng nhập bằng'),
(470, 2, 'Xác minh đăng nhập bằng', 'Verify login with'),
(471, 1, 'Gửi thông báo về mail khi đăng nhập thành công:', 'Gửi thông báo về mail khi đăng nhập thành công:'),
(472, 2, 'Gửi thông báo về mail khi đăng nhập thành công:', 'Send email notification upon successful login:'),
(473, 1, 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:', 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:'),
(474, 2, 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:', 'Only the correct browser and purchase IP can view orders:'),
(475, 1, '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.', '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.'),
(476, 2, '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.', '- Use your phone to download the Google Authenticator App then scan the QR code to receive the verification code.'),
(477, 1, '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.', '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.'),
(478, 2, '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.', '- The QR code will be changed when you turn off verification.'),
(479, 1, '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.', '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.'),
(480, 2, '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.', '- If you enable Login Verification using OTP Mail, do not enable Google Authenticator and vice versa.'),
(481, 1, 'Lưu', 'Lưu'),
(482, 2, 'Lưu', 'Save'),
(483, 1, 'Nhập mã xác minh để lưu', 'Nhập mã xác minh để lưu'),
(484, 2, 'Nhập mã xác minh để lưu', 'Enter the verification code to save'),
(485, 1, 'Sản phẩm liên quan đến từ khóa', 'Sản phẩm liên quan đến từ khóa'),
(486, 2, 'Sản phẩm liên quan đến từ khóa', 'Products related to keyword'),
(487, 1, 'trong số', 'trong số'),
(488, 2, 'trong số', 'of'),
(489, 1, 'Quay lại', 'Quay lại'),
(490, 2, 'Quay lại', 'Back'),
(491, 1, 'Tải về đơn hàng', 'Tải về đơn hàng'),
(492, 2, 'Tải về đơn hàng', 'Download Order'),
(493, 1, 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý', 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý'),
(494, 2, 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý', 'The system will download the order when you click Okey'),
(495, 1, 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý', 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý'),
(496, 2, 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý', 'The system will delete the order from your history when you click Okey'),
(497, 1, 'Đóng', 'Đóng'),
(498, 2, 'Đóng', 'Cancel'),
(499, 1, 'Xuất tất cả tài khoản ra tệp .txt', 'Xuất tất cả tài khoản ra tệp .txt'),
(500, 2, 'Xuất tất cả tài khoản ra tệp .txt', 'Export all accounts to a .txt file'),
(501, 1, 'Xóa đơn hàng này khỏi lịch sử của bạn', 'Xóa đơn hàng này khỏi lịch sử của bạn'),
(502, 2, 'Xóa đơn hàng này khỏi lịch sử của bạn', 'Delete this order from your history'),
(503, 1, 'Thành công !', 'Thành công !'),
(504, 2, 'Thành công !', 'Success !'),
(505, 1, 'Xem chi tiết đơn hàng', 'Xem chi tiết đơn hàng'),
(506, 2, 'Xem chi tiết đơn hàng', 'View order details'),
(507, 1, 'Mua thêm', 'Mua thêm'),
(508, 2, 'Mua thêm', 'Buy more'),
(509, 1, 'Tạo đơn hàng thành công !', 'Tạo đơn hàng thành công !'),
(510, 2, 'Tạo đơn hàng thành công !', 'Create order successfully!'),
(511, 1, 'Đang xử lý...', 'Đang xử lý...'),
(512, 2, 'Đang xử lý...', 'Processing...'),
(513, 1, 'tài khoản giảm', 'tài khoản giảm'),
(514, 2, 'tài khoản giảm', 'account discount'),
(515, 1, 'Chi tiết', 'Chi tiết'),
(516, 2, 'Chi tiết', 'Detail'),
(517, 1, 'Tích hợp API', 'Tích hợp API'),
(518, 2, 'Tích hợp API', 'API integration'),
(519, 1, 'Lấy chi tiết sản phẩm', 'Lấy chi tiết sản phẩm'),
(520, 2, 'Lấy chi tiết sản phẩm', 'Get product details'),
(521, 1, 'Ghi chú cá nhân', 'Ghi chú cá nhân'),
(522, 2, 'Ghi chú cá nhân', 'Personal note'),
(523, 1, 'ngày trước', 'ngày trước'),
(524, 2, 'ngày trước', 'days ago'),
(525, 1, 'tiếng trước', 'tiếng trước'),
(526, 2, 'tiếng trước', 'hours ago'),
(527, 1, 'phút trước', 'phút trước'),
(528, 2, 'phút trước', 'minutes ago'),
(529, 1, 'giây trước', 'giây trước'),
(530, 2, 'giây trước', 'seconds ago'),
(531, 1, 'Hôm qua', 'Hôm qua'),
(532, 2, 'Hôm qua', 'Yesterday'),
(533, 1, 'tuần trước', 'tuần trước'),
(534, 2, 'tuần trước', 'weeks ago'),
(535, 1, 'tháng trước', 'tháng trước'),
(536, 2, 'tháng trước', 'months ago'),
(537, 1, 'năm trước', 'năm trước'),
(538, 2, 'năm trước', 'last year'),
(539, 1, 'Đơn hàng đã bị xóa', 'Đơn hàng đã bị xóa'),
(540, 2, 'Đơn hàng đã bị xóa', 'Order has been deleted'),
(541, 1, 'Bạn có chắc không', 'Bạn có chắc không'),
(543, 1, 'Hệ thống sẽ xóa', 'Hệ thống sẽ xóa'),
(544, 2, 'Hệ thống sẽ xóa', 'The system will delete'),
(545, 1, 'đơn hàng bạn chọn khi nhấn Đồng Ý', 'đơn hàng bạn chọn khi nhấn Đồng Ý'),
(546, 2, 'đơn hàng bạn chọn khi nhấn Đồng Ý', 'order you select when you click Agree'),
(547, 1, 'Vui lòng chọn ít nhất một đơn hàng.', 'Vui lòng chọn ít nhất một đơn hàng.'),
(548, 2, 'Vui lòng chọn ít nhất một đơn hàng.', 'Please select at least one order.'),
(549, 1, 'Thất bại!', 'Thất bại!'),
(550, 2, 'Thất bại!', 'Failure!'),
(551, 1, 'Thành công!', 'Thành công!'),
(552, 2, 'Thành công!', 'Success!'),
(553, 1, 'Xóa đơn hàng thành công', 'Xóa đơn hàng thành công'),
(554, 2, 'Xóa đơn hàng thành công', 'Order deleted successfully'),
(555, 1, 'Miễn phí', 'Miễn phí'),
(556, 2, 'Miễn phí', 'Free'),
(557, 1, 'Lấy mã 2FA', 'Lấy mã 2FA'),
(558, 2, 'Lấy mã 2FA', 'Get 2FA code'),
(559, 1, 'Bạn đang xem', 'Bạn đang xem'),
(560, 2, 'Bạn đang xem', 'You are viewing'),
(561, 1, 'Nhập danh sách UID', 'Nhập danh sách UID'),
(562, 2, 'Nhập danh sách UID', 'Import UID list'),
(563, 1, 'Mỗi dòng 1 UID', 'Mỗi dòng 1 UID'),
(564, 2, 'Mỗi dòng 1 UID', '1 UID per line'),
(565, 1, 'Tài khoản Live', 'Tài khoản Live'),
(566, 2, 'Tài khoản Live', 'UID Live'),
(567, 1, 'Tài khoản Die', 'Tài khoản Die'),
(568, 2, 'Tài khoản Die', 'UID Die'),
(569, 1, 'Giảm giá', 'Giảm giá'),
(570, 2, 'Giảm giá', 'Discount'),
(571, 1, 'Tỷ lệ hoa hồng', 'Tỷ lệ hoa hồng'),
(572, 2, 'Tỷ lệ hoa hồng', 'Commission Rate'),
(573, 1, 'Thành viên đã giới thiệu', 'Thành viên đã giới thiệu'),
(574, 2, 'Thành viên đã giới thiệu', 'Referred Member'),
(575, 1, 'Không có dữ liệu', 'Không có dữ liệu'),
(576, 2, 'Không có dữ liệu', 'No data available'),
(577, 1, 'Khách hàng', 'Khách hàng'),
(578, 2, 'Khách hàng', 'Username'),
(579, 1, 'Ngày đăng ký', 'Ngày đăng ký'),
(580, 2, 'Ngày đăng ký', 'Registration date'),
(581, 1, 'Hoa hồng', 'Hoa hồng'),
(582, 2, 'Hoa hồng', 'Commission'),
(583, 1, 'Mật khẩu mạnh', 'Mật khẩu mạnh'),
(584, 2, 'Mật khẩu mạnh', 'Strong password'),
(585, 1, 'Mật khẩu trung bình', 'Mật khẩu trung bình'),
(586, 2, 'Mật khẩu trung bình', 'Average Password'),
(587, 1, 'Mật khẩu rất yếu', 'Mật khẩu rất yếu'),
(588, 2, 'Mật khẩu rất yếu', 'Password is very weak'),
(589, 1, 'Vui lòng nhập mã xác minh 2FA', 'Vui lòng nhập mã xác minh 2FA'),
(590, 2, 'Vui lòng nhập mã xác minh 2FA', 'Please enter 2FA verification code'),
(591, 1, 'Mã xác minh không chính xác', 'Mã xác minh không chính xác'),
(592, 2, 'Mã xác minh không chính xác', 'Verification code is incorrect'),
(593, 1, 'Bật xác thực Google Authenticator', 'Bật xác thực Google Authenticator'),
(594, 2, 'Bật xác thực Google Authenticator', 'Enable Google Authenticator'),
(595, 1, 'Tắt xác thực Google Authenticator', 'Tắt xác thực Google Authenticator'),
(596, 2, 'Tắt xác thực Google Authenticator', 'Disable Google Authenticator'),
(597, 1, 'Vui lòng đăng nhập để sử dụng tính năng này', 'Vui lòng đăng nhập để sử dụng tính năng này'),
(598, 2, 'Vui lòng đăng nhập để sử dụng tính năng này', 'Please login to use this feature'),
(599, 1, 'Chọn phương thức nạp tiền', 'Chọn phương thức nạp tiền'),
(600, 2, 'Chọn phương thức nạp tiền', 'Select deposit method'),
(601, 1, 'Không hiển thị lại trong 2 giờ', 'Không hiển thị lại trong 2 giờ'),
(602, 2, 'Không hiển thị lại trong 2 giờ', 'hide for 2 hours'),
(603, 1, 'Thông báo', 'Thông báo'),
(604, 2, 'Thông báo', 'Notification'),
(605, 1, 'Tìm kiếm sản phẩm...', 'Tìm kiếm sản phẩm...'),
(606, 2, 'Tìm kiếm sản phẩm...', 'Search for products...'),
(607, 1, 'Chat hỗ trợ', 'Chat hỗ trợ'),
(608, 2, 'Chat hỗ trợ', 'Chat support'),
(609, 1, 'Chat ngay', 'Chat ngay'),
(610, 2, 'Chat ngay', 'Chat now'),
(611, 1, 'ĐƠN HÀNG GẦN ĐÂY', 'ĐƠN HÀNG GẦN ĐÂY'),
(612, 2, 'ĐƠN HÀNG GẦN ĐÂY', 'RECENT ORDERS'),
(613, 1, 'NẠP TIỀN GẦN ĐÂY', 'NẠP TIỀN GẦN ĐÂY'),
(614, 2, 'NẠP TIỀN GẦN ĐÂY', 'RECENT DEPOSIT'),
(615, 1, 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin', 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin'),
(616, 2, 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin', 'This function is not configured yet, please contact Admin'),
(617, 1, 'Số dư không đủ, vui lòng nạp thêm', 'Số dư không đủ, vui lòng nạp thêm'),
(618, 2, 'Số dư không đủ, vui lòng nạp thêm', 'Insufficient balance, please top up'),
(619, 1, 'Công cụ Check Live UID Facebook', 'Công cụ Check Live UID Facebook'),
(620, 2, 'Công cụ Check Live UID Facebook', 'Facebook Live UID Check Tool'),
(621, 1, 'Tiếp thị liên kết', 'Tiếp thị liên kết'),
(622, 2, 'Tiếp thị liên kết', 'Affiliate Marketing'),
(623, 1, 'Liên kết sản phẩm', 'Liên kết sản phẩm'),
(624, 2, 'Liên kết sản phẩm', 'Product Links'),
(625, 1, 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.', 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.'),
(626, 2, 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.', 'Share the product link below to your friends, you will receive commission when your friends purchase through the link below.'),
(627, 1, 'Tất cả sản phẩm', 'Tất cả sản phẩm'),
(628, 2, 'Tất cả sản phẩm', 'All products'),
(629, 19, 'Vui lòng nhập username', 'กรุณากรอกชื่อผู้ใช้'),
(630, 19, 'Vui lòng nhập mật khẩu', 'กรุณากรอกรหัสผ่าน'),
(631, 19, 'Vui lòng xác minh Captcha', 'กรุณาตรวจสอบ Captcha'),
(632, 19, 'Thông tin đăng nhập không chính xác', 'ข้อมูลการเข้าสู่ระบบไม่ถูกต้อง'),
(633, 19, 'Vui lòng nhập địa chỉ Email', 'กรุณากรอกที่อยู่อีเมล์'),
(634, 19, 'Vui lòng nhập lại mật khẩu', 'กรุณากรอกรหัสผ่านอีกครั้ง'),
(635, 19, 'Xác minh mật khẩu không chính xác', 'ตรวจสอบรหัสผ่านไม่ถูกต้อง'),
(636, 19, 'Tên đăng nhập đã tồn tại trong hệ thống', 'ชื่อเข้าระบบมีอยู่แล้วในระบบ'),
(637, 19, 'Địa chỉ email đã tồn tại trong hệ thống', 'ที่อยู่อีเมลมีอยู่ในระบบแล้ว'),
(638, 19, 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép', 'IP ของคุณถึงขีดจำกัดการสร้างบัญชีที่อนุญาตแล้ว'),
(639, 19, 'Đăng ký thành công!', 'ลงทะเบียนสำเร็จ!'),
(640, 19, 'Tạo tài khoản không thành công, vui lòng thử lại', 'การสร้างบัญชีล้มเหลว กรุณาลองอีกครั้ง'),
(641, 19, 'Vui lòng đăng nhập', 'กรุณาเข้าสู่ระบบ'),
(642, 19, 'Lưu thành công', 'บันทึกสำเร็จแล้ว'),
(643, 19, 'Lưu thất bại', 'การบันทึกล้มเหลว'),
(644, 19, 'Vui lòng nhập mật khẩu hiện tại', 'กรุณากรอกรหัสผ่านปัจจุบัน'),
(645, 19, 'Vui lòng nhập mật khẩu mới', 'กรุณากรอกรหัสผ่านใหม่'),
(646, 19, 'Mật khẩu mới quá ngắn', 'รหัสผ่านใหม่สั้นเกินไป'),
(647, 19, 'Xác nhận mật khẩu không chính xác', 'ยืนยันรหัสผ่านไม่ถูกต้อง'),
(648, 19, 'Mật khẩu hiện tại không đúng', 'รหัสผ่านปัจจุบันไม่ถูกต้อง'),
(649, 19, 'Địa chỉ Email này không tồn tại trong hệ thống', 'ที่อยู่อีเมลนี้ไม่มีอยู่ในระบบ'),
(650, 19, 'Vui lòng thử lại trong ít phút', 'โปรดลองอีกครั้งในอีกไม่กี่นาที'),
(651, 19, 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.', 'หากคุณต้องการรีเซ็ตรหัสผ่าน โปรดคลิกลิงก์ด้านล่างเพื่อยืนยัน'),
(652, 19, 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.', 'หากคุณไม่ใช่ โปรดติดต่อผู้ดูแลระบบของคุณทันทีเพื่อขอความช่วยเหลือด้านความปลอดภัย'),
(653, 19, 'Xác nhận tìm mật khẩu website', 'ยืนยันการค้นหารหัสผ่านเว็บไซต์'),
(654, 19, 'Xác nhận khôi phục mật khẩu', 'ยืนยันการกู้คืนรหัสผ่าน'),
(655, 19, 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu', 'กรุณาตรวจสอบอีเมลของคุณเพื่อเสร็จสิ้นกระบวนการรีเซ็ตรหัสผ่าน'),
(656, 19, 'Có lỗi hệ thống, vui lòng liên hệ Developer', 'มีข้อผิดพลาดของระบบกรุณาติดต่อผู้พัฒนา'),
(657, 19, 'Liên kết không tồn tại', 'ลิงค์ไม่ได้อยู่'),
(658, 19, 'Thay đổi mật khẩu thành công', 'เปลี่ยนรหัสผ่านสำเร็จแล้ว'),
(659, 19, 'Thay đổi mật khẩu thất bại', 'การเปลี่ยนรหัสผ่านล้มเหลว'),
(660, 19, 'Hồ sơ của bạn', 'โปรไฟล์ของคุณ'),
(661, 19, 'Tên đăng nhập', 'ชื่อผู้ใช้'),
(662, 19, 'Địa chỉ Email', 'ที่อยู่อีเมล์'),
(663, 19, 'Số điện thoại', 'เบอร์โทรศัพท์'),
(664, 19, 'Họ và Tên', 'ชื่อ-นามสกุล'),
(665, 19, 'Địa chỉ IP', 'ที่อยู่ IP'),
(666, 19, 'Thiết bị', 'อุปกรณ์'),
(667, 19, 'Đăng ký vào lúc', 'สมัครสมาชิกได้ที่'),
(668, 19, 'Đăng nhập gần nhất', 'การเข้าสู่ระบบครั้งสุดท้าย'),
(669, 19, 'Chỉnh sửa thông tin', 'แก้ไขข้อมูล'),
(670, 19, 'Thay đổi mật khẩu', 'เปลี่ยนรหัสผ่าน'),
(671, 19, 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.', 'การเปลี่ยนรหัสผ่านการเข้าสู่ระบบเป็นวิธีง่ายๆ ในการรักษาบัญชีของคุณให้ปลอดภัย'),
(672, 19, 'Mật khẩu hiện tại', 'รหัสผ่านปัจจุบัน'),
(673, 19, 'Mật khẩu mới', 'รหัสผ่านใหม่'),
(674, 19, 'Nhập lại mật khẩu mới', 'กรอกรหัสผ่านใหม่อีกครั้ง'),
(675, 19, 'Cập Nhật', 'อัปเดต'),
(676, 19, 'Đăng Xuất', 'ออกจากระบบ'),
(677, 19, 'Bạn có chắc không?', 'คุณแน่ใจมั้ย?'),
(678, 19, 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý', 'คุณจะออกจากระบบบัญชีของคุณเมื่อคุณคลิกตกลง'),
(679, 19, 'Đồng ý', 'เห็นด้วย'),
(680, 19, 'Huỷ bỏ', 'ยกเลิก'),
(681, 19, 'Đăng Nhập', 'เข้าสู่ระบบ'),
(682, 19, 'Vui Lòng Đăng Nhập Để Tiếp Tục', 'กรุณาเข้าสู่ระบบเพื่อดำเนินการต่อ'),
(683, 19, 'Quên mật khẩu', 'ลืมรหัสผ่าน'),
(684, 19, 'Bạn quên mật khẩu?', 'ลืมรหัสผ่านใช่ไหม?'),
(685, 19, 'Vui lòng nhập thông tin vào ô dưới đây để xác minh', 'กรุณากรอกข้อมูลลงในช่องด้านล่างเพื่อยืนยัน'),
(686, 19, 'Xác minh', 'ตรวจสอบ'),
(687, 19, 'Bạn đã có tài khoản?', 'มีบัญชีอยู่แล้วใช่ไหม?'),
(688, 19, 'Ghi nhớ tôi', 'จำฉันไว้'),
(689, 19, 'Quên mật khẩu?', 'ลืมรหัสผ่าน?'),
(690, 19, 'Bạn chưa có tài khoản?', 'ยังไม่มีบัญชีใช่ไหม?'),
(691, 19, 'Đăng Ký Ngay', 'สมัครสมาชิกตอนนี้'),
(692, 19, 'Nạp tiền', 'เงินฝาก'),
(693, 19, 'Ngân hàng', 'ธนาคาร'),
(694, 19, 'Ví của tôi', 'กระเป๋าสตางค์ของฉัน'),
(695, 19, 'Số dư hiện tại', 'ยอดคงเหลือปัจจุบัน'),
(696, 19, 'Tổng tiền nạp', 'ยอดฝากรวม'),
(697, 19, 'Số dư đã sử dụng', 'ยอดคงเหลือที่ใช้แล้ว'),
(698, 19, 'THANH TOÁN', 'จ่าย'),
(699, 19, 'Lưu ý nạp tiền', 'หมายเหตุการฝากเงิน'),
(700, 19, 'Lịch sử nạp tiền', 'ประวัติการฝากเงิน'),
(701, 19, 'Số tài khoản:', 'หมายเลขบัญชี :'),
(702, 19, 'Chủ tài khoản:', 'ผู้ถือบัญชี:'),
(703, 19, 'Ngân hàng:', 'ธนาคาร:'),
(704, 19, 'Nội dung chuyển khoản:', 'โอนเนื้อหา:'),
(705, 19, 'Mã giao dịch', 'รหัสธุรกรรม'),
(706, 19, 'Nội dung', 'เนื้อหา'),
(707, 19, 'Số tiền nạp', 'จำนวนเงินมัดจำ'),
(708, 19, 'Thực nhận', 'การตระหนักรู้'),
(709, 19, 'Thời gian', 'เวลา'),
(710, 19, 'Trạng thái', 'สถานะ'),
(711, 19, 'Đã thanh toán', 'จ่าย'),
(712, 19, 'Tất cả', 'ทั้งหมด'),
(713, 19, 'Hôm nay', 'วันนี้'),
(714, 19, 'Tuần này', 'สัปดาห์นี้'),
(715, 19, 'Tháng này', 'เดือนนี้'),
(716, 19, 'Đã thanh toán:', 'จ่าย:'),
(717, 19, 'Thực nhận:', 'ใบเสร็จจริง:'),
(718, 19, 'Thao tác', 'การดำเนินการ'),
(719, 19, 'Nhật ký hoạt động', 'บันทึกกิจกรรม'),
(720, 19, 'Tìm kiếm', 'ค้นหา'),
(721, 19, 'Bỏ lọc', 'ยกเลิกตัวกรอง'),
(722, 19, 'Hiển thị', 'แสดง'),
(723, 19, 'Ẩn', 'ซ่อน'),
(724, 19, 'Biến động số dư', 'ความผันผวนของความสมดุล'),
(725, 19, 'Số dư ban đầu', 'ยอดคงเหลือเริ่มต้น'),
(726, 19, 'Số dư thay đổi', 'การเปลี่ยนแปลงสมดุล'),
(727, 19, 'Lý do', 'เหตุผล'),
(728, 19, 'Chọn thời gian cần tìm', 'เลือกเวลาที่ต้องการค้นหา'),
(729, 19, 'Hiển thị thêm', 'แสดงเพิ่มเติม'),
(730, 19, 'Ẩn bớt', 'ซ่อน'),
(731, 19, 'Nội dung chuyển khoản', 'ถ่ายโอนเนื้อหา'),
(732, 19, 'Đăng nhập bằng Google', 'ลงชื่อเข้าใช้ด้วย Google'),
(733, 19, 'Đăng nhập bằng Facebook', 'เข้าสู่ระบบด้วย Facebook'),
(734, 19, 'Đăng ký tài khoản', 'ลงทะเบียนบัญชีผู้ใช้'),
(735, 19, 'Tài khoản đăng nhập', 'เข้าสู่ระบบบัญชี'),
(736, 19, 'Mật khẩu', 'รหัสผ่าน'),
(737, 19, 'Nhập lại mật khẩu', 'กรอกรหัสผ่านอีกครั้ง'),
(738, 19, 'Đăng Ký', 'ลงทะเบียน'),
(739, 19, 'Vui lòng nhập thông tin đăng ký', 'กรุณากรอกข้อมูลลงทะเบียน'),
(740, 19, 'Vui lòng nhập thông tin đăng nhập', 'กรุณากรอกข้อมูลการเข้าสู่ระบบของคุณ'),
(741, 19, 'Thông tin cá nhân', 'ข้อมูลส่วนตัว'),
(742, 19, 'Cấu hình nạp tiền Crypto', 'การกำหนดค่าการฝากเงิน Crypto'),
(743, 19, 'All Time', 'ตลอดเวลา'),
(744, 19, 'Thống kê thanh toán tháng', 'สถิติการชำระเงินรายเดือน'),
(745, 19, 'Lịch sử nạp tiền Crypto', 'ประวัติการฝากเงินคริปโต'),
(746, 19, 'Thống kê', 'สถิติ'),
(747, 19, 'Cấu hình', 'การกำหนดค่า'),
(748, 19, 'Nạp tối đa', 'โหลดสูงสุด'),
(749, 19, 'Nạp tối thiểu', 'เงินฝากขั้นต่ำ'),
(750, 19, 'Nạp tiền bằng Crypto', 'ฝากเงินด้วยคริปโต'),
(751, 19, 'Lưu ý', 'บันทึก'),
(752, 19, 'Lịch sử nạp Crypto', 'ประวัติการฝากเงินคริปโต'),
(753, 19, 'Số lượng', 'ปริมาณ'),
(754, 19, 'Thời gian tạo', 'เวลาการสร้าง'),
(755, 19, 'Xem thêm', 'ดูเพิ่มเติม'),
(756, 19, 'The minimum deposit amount is:', 'จำนวนเงินฝากขั้นต่ำคือ:'),
(757, 19, 'Số tiền gửi tối đa là:', 'จำนวนเงินฝากสูงสุดคือ:'),
(758, 19, 'Số tiền gửi tối thiểu là:', 'จำนวนเงินฝากขั้นต่ำคือ:'),
(759, 19, 'Chức năng này đang được bảo trì', 'ฟังก์ชั่นนี้อยู่ระหว่างการบำรุงรักษา'),
(760, 19, 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau', 'ไม่สามารถสร้างใบแจ้งหนี้ได้เนื่องจากข้อผิดพลาดของ API โปรดลองอีกครั้งในภายหลัง'),
(761, 19, 'Tạo hoá đơn nạp tiền thành công', 'สร้างใบแจ้งหนี้เติมเงินสำเร็จแล้ว'),
(762, 19, 'Nạp tiền bằng PayPal', 'ฝากเงินด้วย PayPal'),
(763, 19, 'Lịch sử nạp PayPal', 'ประวัติการฝากเงิน PayPal'),
(764, 19, 'Số tiền gửi', 'จำนวนเงินมัดจำ'),
(765, 19, 'Vui lòng nhập số tiền cần nạp', 'กรุณากรอกจำนวนเงินที่ต้องการฝาก'),
(766, 19, 'Mặc định', 'ค่าเริ่มต้น'),
(767, 19, 'Phổ biến', 'เป็นที่นิยม'),
(768, 19, 'Tìm kiếm bài viết', 'ค้นหาบทความ'),
(769, 19, 'Bài viết phổ biến', 'กระทู้ยอดนิยม'),
(770, 19, 'Liên kết giới thiệu của bạn', 'ลิงค์อ้างอิงของคุณ'),
(771, 19, 'Đã sao chép vào bộ nhớ tạm', 'คัดลอกไปยังคลิปบอร์ดแล้ว'),
(772, 19, 'Số tài khoản', 'หมายเลขบัญชี'),
(773, 19, 'Tên chủ tài khoản', 'ชื่อเจ้าของบัญชี'),
(774, 19, 'Số tiền cần rút', 'จำนวนเงินที่ต้องการถอน'),
(775, 19, 'Rút số dư hoa hồng', 'ถอนเงินค่าคอมมิชชั่นคงเหลือ'),
(776, 19, 'Lịch sử rút tiền', 'ประวัติการถอนเงิน'),
(777, 19, 'Rút tiền', 'ถอนเงิน'),
(778, 19, 'Lịch sử', 'ประวัติศาสตร์'),
(779, 19, 'Thao tác quá nhanh, vui lòng chờ', 'การดำเนินการรวดเร็วเกินไป กรุณารอสักครู่'),
(780, 19, 'Vui lòng chọn ngân hàng cần rút', 'กรุณาเลือกธนาคารที่คุณต้องการถอนเงิน'),
(781, 19, 'Vui lòng nhập số tài khoản cần rút', 'กรุณากรอกหมายเลขบัญชีที่ต้องการถอน'),
(782, 19, 'Vui lòng nhập tên chủ tài khoản', 'กรุณากรอกชื่อเจ้าของบัญชี'),
(783, 19, 'Vui lòng nhập số tiền cần rút', 'กรุณากรอกจำนวนเงินที่ต้องการถอน'),
(784, 19, 'Số tiền rút tối thiểu phải là', 'จำนวนเงินถอนขั้นต่ำจะต้องเป็น'),
(785, 19, 'Số dư hoa hồng khả dụng của bạn không đủ', 'ยอดคอมมิชชั่นคงเหลือของคุณไม่เพียงพอ'),
(786, 19, 'Gian lận khi rút số dư hoa hồng', 'การฉ้อโกงในการถอนเงินค่าคอมมิชชั่นคงเหลือ'),
(787, 19, 'Tài khoản của bạn đã bị khóa vì gian lận', 'บัญชีของคุณถูกล็อคเนื่องจากการฉ้อโกง'),
(788, 19, 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý', 'สร้างคำขอถอนเงินสำเร็จแล้ว กรุณารอให้ผู้ดูแลระบบดำเนินการ'),
(789, 19, 'Số tiền rút', 'จำนวนเงินที่ถอนออก'),
(790, 19, 'Thông kê của bạn', 'สถิติของคุณ'),
(791, 19, 'Số tiền hoa hồng khả dụng', 'จำนวนคอมมิชชั่นที่สามารถใช้ได้'),
(792, 19, 'Tổng số tiền hoa hồng đã nhận', 'รวมค่าคอมมิชชั่นที่ได้รับ'),
(793, 19, 'Số lần nhấp vào liên kết', 'จำนวนการคลิกลิงก์'),
(794, 19, 'Lịch sử hoa hồng', 'ประวัติความเป็นมาของดอกกุหลาบ'),
(795, 19, 'Hoa hồng ban đầu', 'ค่าคอมมิชชั่นเบื้องต้น'),
(796, 19, 'Hoa hồng thay đổi', 'การเปลี่ยนแปลงค่าคอมมิชชั่น'),
(797, 19, 'Hoa hồng hiện tại', 'ค่าคอมมิชชั่นปัจจุบัน'),
(798, 19, 'Vui lòng nhập số lượng cần mua', 'กรุณากรอกจำนวนที่ต้องการซื้อ'),
(799, 19, 'Tổng tiền thanh toán:', 'รวมชำระเงิน:'),
(800, 19, 'Số tiền giảm:', 'จำนวนส่วนลด:'),
(801, 19, 'Thành tiền:', 'ยอดรวม :'),
(802, 19, 'Mã giảm giá:', 'โค้ดส่วนลด:'),
(803, 19, 'Nhập mã giảm giá nếu có', 'กรอกรหัสส่วนลดหากมี'),
(804, 19, 'THÔNG TIN MUA HÀNG', 'ข้อมูลการซื้อ'),
(805, 19, 'Số lượng cần mua:', 'จำนวนที่ต้องการซื้อ:'),
(806, 19, 'Chia sẻ:', 'แบ่งปัน:'),
(807, 19, 'Mua Ngay', 'ซื้อเลย'),
(808, 19, 'Kho hàng:', 'คลังสินค้า:'),
(809, 19, 'Đã bán:', 'ขายแล้ว:'),
(810, 19, 'Yêu Thích', 'ที่ชื่นชอบ'),
(811, 19, 'Bỏ Thích', 'ชอบ'),
(812, 19, 'Danh sách sản phẩm yêu thích', 'รายการสินค้าที่ชื่นชอบ'),
(813, 19, 'Sản phẩm', 'ผลิตภัณฑ์'),
(814, 19, 'Kho hàng', 'คลังสินค้า'),
(815, 19, 'Giá', 'ราคา'),
(816, 19, 'Mua', 'อันดับแรก'),
(817, 19, 'Xem', 'ดู'),
(818, 19, 'Xóa', 'ลบ'),
(819, 19, 'Hết hàng', 'สินค้าหมด'),
(820, 19, 'Thêm vào mục yêu thích', 'เพิ่มไปยังรายการโปรด'),
(821, 19, 'Đã thêm vào mục yêu thích', 'เพิ่มไปยังรายการโปรด'),
(822, 19, 'Xóa đơn hàng', 'ลบคำสั่งซื้อ'),
(823, 19, 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn', 'ลบคำสั่งซื้อที่เลือกจากประวัติของคุณ'),
(824, 19, 'Mã đơn hàng', 'รหัสการสั่งซื้อ'),
(825, 19, 'Xem chi tiết', 'ดูรายละเอียดเพิ่มเติม'),
(826, 19, 'Tải về máy', 'ดาวน์โหลด'),
(827, 19, 'Xóa khỏi lịch sử', 'ลบออกจากประวัติ'),
(828, 19, 'Liên hệ', 'ติดต่อ'),
(829, 19, 'Chính sách', 'นโยบาย'),
(830, 19, 'Tài liệu API', 'เอกสารประกอบ API'),
(831, 19, 'Trang chủ', 'บ้าน'),
(832, 19, 'Liên kết', 'ลิงค์'),
(833, 19, 'Câu hỏi thường gặp', 'คำถามที่พบบ่อย'),
(834, 19, 'Liên hệ chúng tôi', 'ติดต่อเรา'),
(835, 19, 'Sản phẩm:', 'ผลิตภัณฑ์:'),
(836, 19, 'Số lượng mua:', 'ปริมาณการซื้อ:'),
(837, 19, 'Thanh toán:', 'จ่าย:'),
(838, 19, 'Mã đơn hàng:', 'รหัสสั่งซื้อ :'),
(839, 19, 'Chi tiết đơn hàng', 'รายละเอียดการสั่งซื้อ'),
(840, 19, 'Tài khoản', 'บัญชี'),
(841, 19, 'Lưu các tài khoản đã chọn vào tệp .txt', 'บันทึกบัญชีที่เลือกลงในไฟล์ .txt'),
(842, 19, 'Sao chép các tài khoản đã chọn', 'คัดลอกบัญชีที่เลือก'),
(843, 19, 'Chỉ sao chép UID các tài khoản đã chọn', 'คัดลอกเฉพาะ UID ของบัญชีที่เลือก'),
(844, 19, 'Số dư của tôi:', 'ความสมดุลของฉัน:'),
(845, 19, 'Khuyến mãi', 'การส่งเสริม'),
(846, 19, 'Số tiền nạp lớn hơn hoặc bằng', 'จำนวนเงินฝากมากกว่าหรือเท่ากับ'),
(847, 19, 'Khuyến mãi thêm', 'โปรโมชั่นเพิ่มเติม'),
(848, 19, 'Thông tin chi tiết khách hàng', 'รายละเอียดลูกค้า'),
(849, 19, 'Chia sẻ liên kết này lên mạng xã hội hoặc bạn bè của bạn.', 'แบ่งปันลิงก์นี้บนเครือข่ายสังคมหรือกับเพื่อนของคุณ'),
(850, 19, 'Tài liệu tích hợp API', 'เอกสารประกอบการรวม API'),
(851, 19, 'Lấy thông tin tài khoản', 'รับข้อมูลบัญชี'),
(852, 19, 'Lấy danh sách chuyên mục và sản phẩm', 'รับรายการหมวดหมู่และสินค้า'),
(853, 19, 'Mua hàng', 'ซื้อ'),
(854, 19, 'ID sản phẩm cần mua', 'รหัสสินค้าที่ต้องการซื้อ'),
(855, 19, 'Số lượng cần mua', 'จำนวนที่ต้องการซื้อ'),
(856, 19, 'Mã giảm giá nếu có', 'โค้ดส่วนลดหากมี'),
(857, 19, 'Bảo mật', 'ความปลอดภัย'),
(858, 19, 'Bảo mật tài khoản', 'ความปลอดภัยของบัญชี'),
(859, 19, 'Xác minh đăng nhập bằng', 'ยืนยันการเข้าสู่ระบบด้วย'),
(860, 19, 'Gửi thông báo về mail khi đăng nhập thành công:', 'ส่งการแจ้งเตือนทางอีเมล์เมื่อเข้าสู่ระบบสำเร็จ:'),
(861, 19, 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:', 'ต้องใช้เบราว์เซอร์และที่อยู่ IP ที่ถูกต้องเพื่อดูคำสั่งซื้อ:'),
(862, 19, '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.', '- ใช้โทรศัพท์ของคุณดาวน์โหลดแอป Google Authenticator จากนั้นสแกนรหัส QR เพื่อรับรหัสยืนยัน'),
(863, 19, '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.', '- รหัส QR จะเปลี่ยนแปลงเมื่อคุณปิดการยืนยัน'),
(864, 19, '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.', '- หากคุณเปิดใช้งานการยืนยันการเข้าสู่ระบบด้วย OTP Mail อย่าเปิดใช้งาน Google Authenticator และในทางกลับกัน'),
(865, 19, 'Lưu', 'บันทึก'),
(866, 19, 'Nhập mã xác minh để lưu', 'กรอกรหัสยืนยันเพื่อบันทึก'),
(867, 19, 'Sản phẩm liên quan đến từ khóa', 'สินค้าที่เกี่ยวข้องกับคีย์เวิร์ด'),
(868, 19, 'trong số', 'ท่ามกลาง'),
(869, 19, 'Quay lại', 'กลับมาอีกครั้ง'),
(870, 19, 'Tải về đơn hàng', 'ดาวน์โหลดคำสั่ง'),
(871, 19, 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý', 'ระบบจะดาวน์โหลดคำสั่งซื้อเมื่อคุณกดยอมรับ'),
(872, 19, 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý', 'ระบบจะลบคำสั่งซื้อออกจากประวัติของคุณเมื่อคุณคลิกยอมรับ'),
(873, 19, 'Đóng', 'ปิด'),
(874, 19, 'Xuất tất cả tài khoản ra tệp .txt', 'ส่งออกบัญชีทั้งหมดไปยังไฟล์ .txt'),
(875, 19, 'Xóa đơn hàng này khỏi lịch sử của bạn', 'ลบคำสั่งนี้ออกจากประวัติของคุณ'),
(876, 19, 'Thành công !', 'ความสำเร็จ !'),
(877, 19, 'Xem chi tiết đơn hàng', 'ดูรายละเอียดการสั่งซื้อ'),
(878, 19, 'Mua thêm', 'ซื้อเพิ่ม'),
(879, 19, 'Tạo đơn hàng thành công !', 'สร้างคำสั่งซื้อสำเร็จแล้ว!'),
(880, 19, 'Đang xử lý...', 'กำลังประมวลผล...'),
(881, 19, 'tài khoản giảm', 'การลดบัญชี'),
(882, 19, 'Chi tiết', 'รายละเอียด'),
(883, 19, 'Tích hợp API', 'การรวม API'),
(884, 19, 'Lấy chi tiết sản phẩm', 'รับรายละเอียดผลิตภัณฑ์'),
(885, 19, 'Ghi chú cá nhân', 'บันทึกส่วนตัว'),
(886, 19, 'ngày trước', 'วันก่อน'),
(887, 19, 'tiếng trước', 'ก่อนหน้า'),
(888, 19, 'phút trước', 'นาทีที่แล้ว'),
(889, 19, 'giây trước', 'วินาทีที่แล้ว'),
(890, 19, 'Hôm qua', 'เมื่อวาน'),
(891, 19, 'tuần trước', 'สัปดาห์ที่แล้ว'),
(892, 19, 'tháng trước', 'เดือนที่แล้ว'),
(893, 19, 'năm trước', 'เมื่อปีที่แล้ว'),
(894, 19, 'Đơn hàng đã bị xóa', 'คำสั่งถูกลบแล้ว'),
(895, 19, 'Bạn có chắc không', 'คุณแน่ใจมั้ย?'),
(896, 19, 'Hệ thống sẽ xóa', 'ระบบจะทำการลบ');
INSERT INTO `translate` (`id`, `lang_id`, `name`, `value`) VALUES
(897, 19, 'đơn hàng bạn chọn khi nhấn Đồng Ý', 'ลำดับที่คุณเลือกเมื่อคุณคลิกตกลง'),
(898, 19, 'Vui lòng chọn ít nhất một đơn hàng.', 'กรุณาเลือกอย่างน้อยหนึ่งคำสั่งซื้อ'),
(899, 19, 'Thất bại!', 'ความล้มเหลว!'),
(900, 19, 'Thành công!', 'ความสำเร็จ!'),
(901, 19, 'Xóa đơn hàng thành công', 'ลบคำสั่งซื้อสำเร็จแล้ว'),
(902, 19, 'Miễn phí', 'ฟรีไม่มีค่าใช้จ่าย'),
(903, 19, 'Lấy mã 2FA', 'รับรหัส 2FA'),
(904, 19, 'Bạn đang xem', 'คุณกำลังดู'),
(905, 19, 'Nhập danh sách UID', 'นำเข้ารายการ UID'),
(906, 19, 'Mỗi dòng 1 UID', '1 UID ต่อบรรทัด'),
(907, 19, 'Tài khoản Live', 'บัญชีออนไลน์'),
(908, 19, 'Tài khoản Die', 'บัญชีของฉัน'),
(909, 19, 'Giảm giá', 'การลดราคา'),
(910, 19, 'Tỷ lệ hoa hồng', 'อัตราคอมมิชชั่น'),
(911, 19, 'Thành viên đã giới thiệu', 'สมาชิกที่ถูกอ้างถึง'),
(912, 19, 'Không có dữ liệu', 'ไม่มีข้อมูล'),
(913, 19, 'Khách hàng', 'ลูกค้า'),
(914, 19, 'Ngày đăng ký', 'วันที่ลงทะเบียน'),
(915, 19, 'Hoa hồng', 'ดอกกุหลาบ'),
(916, 19, 'Mật khẩu mạnh', 'รหัสผ่านที่แข็งแกร่ง'),
(917, 19, 'Mật khẩu trung bình', 'รหัสผ่านเฉลี่ย'),
(918, 19, 'Mật khẩu rất yếu', 'รหัสผ่านอ่อนแอมาก'),
(919, 19, 'Vui lòng nhập mã xác minh 2FA', 'กรุณากรอกรหัสยืนยัน 2FA'),
(920, 19, 'Mã xác minh không chính xác', 'รหัสตรวจสอบไม่ถูกต้อง'),
(921, 19, 'Bật xác thực Google Authenticator', 'เปิดใช้งาน Google Authenticator'),
(922, 19, 'Tắt xác thực Google Authenticator', 'ปิดใช้งานการตรวจสอบสิทธิ์ของ Google Authenticator'),
(923, 19, 'Vui lòng đăng nhập để sử dụng tính năng này', 'กรุณาเข้าสู่ระบบเพื่อใช้ฟีเจอร์นี้'),
(924, 19, 'Chọn phương thức nạp tiền', 'เลือกวิธีการฝากเงิน'),
(925, 19, 'Không hiển thị lại trong 2 giờ', 'ไม่แสดงผลอีกเป็นเวลา 2 ชั่วโมง'),
(926, 19, 'Thông báo', 'การแจ้งเตือน'),
(927, 19, 'Tìm kiếm sản phẩm...', 'ค้นหาผลิตภัณฑ์...'),
(928, 19, 'Chat hỗ trợ', 'การสนับสนุนการแชท'),
(929, 19, 'Chat ngay', 'แชทตอนนี้'),
(930, 19, 'ĐƠN HÀNG GẦN ĐÂY', 'คำสั่งซื้อล่าสุด'),
(931, 19, 'NẠP TIỀN GẦN ĐÂY', 'เงินฝากล่าสุด'),
(932, 19, 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin', 'ยังไม่ได้กำหนดค่าฟังก์ชันนี้ กรุณาติดต่อผู้ดูแลระบบ'),
(933, 19, 'Số dư không đủ, vui lòng nạp thêm', 'เงินคงเหลือไม่พอ กรุณาเติมเงิน'),
(934, 19, 'Công cụ Check Live UID Facebook', 'เครื่องมือตรวจสอบ UID ของ Facebook Live'),
(935, 19, 'Tiếp thị liên kết', 'การตลาดแบบพันธมิตร'),
(936, 19, 'Liên kết sản phẩm', 'ลิงค์ผลิตภัณฑ์'),
(937, 19, 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.', 'แชร์ลิงก์ผลิตภัณฑ์ด้านล่างนี้ให้เพื่อนของคุณ คุณจะได้รับคอมมิชชั่นเมื่อเพื่อนของคุณซื้อผ่านลิงก์ด้านล่าง'),
(938, 19, 'Tất cả sản phẩm', 'สินค้าทั้งหมด'),
(939, 1, 'Sản phẩm yêu thích', 'Sản phẩm yêu thích'),
(940, 19, 'Sản phẩm yêu thích', 'สินค้าที่ชื่นชอบ'),
(941, 2, 'Sản phẩm yêu thích', 'Favorites'),
(942, 20, 'Vui lòng nhập username', '请输入用户名'),
(943, 20, 'Vui lòng nhập mật khẩu', '请输入密码'),
(944, 20, 'Vui lòng xác minh Captcha', '请验证验证码'),
(945, 20, 'Thông tin đăng nhập không chính xác', '登录信息不正确'),
(946, 20, 'Vui lòng nhập địa chỉ Email', '请输入电子邮件地址'),
(947, 20, 'Vui lòng nhập lại mật khẩu', '请重新输入密码'),
(948, 20, 'Xác minh mật khẩu không chính xác', '确认密码不正确'),
(949, 20, 'Tên đăng nhập đã tồn tại trong hệ thống', '该登录名在系统中已经存在。'),
(950, 20, 'Địa chỉ email đã tồn tại trong hệ thống', '电子邮件地址已存在于系统中'),
(951, 20, 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép', '您的 IP 已达到允许的帐户创建限制。'),
(952, 20, 'Đăng ký thành công!', '注册成功！'),
(953, 20, 'Tạo tài khoản không thành công, vui lòng thử lại', '账户创建失败，请重试'),
(954, 20, 'Vui lòng đăng nhập', '请登录'),
(955, 20, 'Lưu thành công', '保存成功'),
(956, 20, 'Lưu thất bại', '保存失败'),
(957, 20, 'Vui lòng nhập mật khẩu hiện tại', '请输入当前密码'),
(958, 20, 'Vui lòng nhập mật khẩu mới', '请输入新密码'),
(959, 20, 'Mật khẩu mới quá ngắn', '新密码太短'),
(960, 20, 'Xác nhận mật khẩu không chính xác', '确认密码不正确'),
(961, 20, 'Mật khẩu hiện tại không đúng', '当前密码不正确'),
(962, 20, 'Địa chỉ Email này không tồn tại trong hệ thống', '系统中不存在该电子邮件地址'),
(963, 20, 'Vui lòng thử lại trong ít phút', '请几分钟后重试'),
(964, 20, 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.', '如果您需要重置密码，请点击下面的链接进行验证。'),
(965, 20, 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.', '如果不是，请立即联系您的管理员寻求安全帮助。'),
(966, 20, 'Xác nhận tìm mật khẩu website', '确认查找网站密码'),
(967, 20, 'Xác nhận khôi phục mật khẩu', '确认密码恢复'),
(968, 20, 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu', '请查看您的电子邮件以完成密码重置过程。'),
(969, 20, 'Có lỗi hệ thống, vui lòng liên hệ Developer', '系统错误，请联系开发者'),
(970, 20, 'Liên kết không tồn tại', '链接不存在'),
(971, 20, 'Thay đổi mật khẩu thành công', '密码修改成功'),
(972, 20, 'Thay đổi mật khẩu thất bại', '密码更改失败'),
(973, 20, 'Hồ sơ của bạn', '您的个人资料'),
(974, 20, 'Tên đăng nhập', '用户名'),
(975, 20, 'Địa chỉ Email', '电子邮件'),
(976, 20, 'Số điện thoại', '电话号码'),
(977, 20, 'Họ và Tên', '姓名'),
(978, 20, 'Địa chỉ IP', 'IP 地址'),
(979, 20, 'Thiết bị', '设备'),
(980, 20, 'Đăng ký vào lúc', '注册于'),
(981, 20, 'Đăng nhập gần nhất', '上次登录'),
(982, 20, 'Chỉnh sửa thông tin', '编辑信息'),
(983, 20, 'Thay đổi mật khẩu', '更改密码'),
(984, 20, 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.', '更改登录密码是保证帐户安全的简单方法。'),
(985, 20, 'Mật khẩu hiện tại', '当前密码'),
(986, 20, 'Mật khẩu mới', '新密码'),
(987, 20, 'Nhập lại mật khẩu mới', '重新输入新密码'),
(988, 20, 'Cập Nhật', '更新'),
(989, 20, 'Đăng Xuất', '登出'),
(990, 20, 'Bạn có chắc không?', '你确定吗？'),
(991, 20, 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý', '单击“同意”后，您将退出帐户。'),
(992, 20, 'Đồng ý', '同意'),
(993, 20, 'Huỷ bỏ', '取消'),
(994, 20, 'Đăng Nhập', '登录'),
(995, 20, 'Vui Lòng Đăng Nhập Để Tiếp Tục', '请登录后继续'),
(996, 20, 'Quên mật khẩu', '忘记密码'),
(997, 20, 'Bạn quên mật khẩu?', '忘记密码了吗？'),
(998, 20, 'Vui lòng nhập thông tin vào ô dưới đây để xác minh', '请在下面的框中输入信息以进行验证'),
(999, 20, 'Xác minh', '核实'),
(1000, 20, 'Bạn đã có tài khoản?', '已有账户？'),
(1001, 20, 'Ghi nhớ tôi', '记住账号'),
(1002, 20, 'Quên mật khẩu?', '忘记密码？'),
(1003, 20, 'Bạn chưa có tài khoản?', '沒有帳戶？'),
(1004, 20, 'Đăng Ký Ngay', '立即注册'),
(1005, 20, 'Nạp tiền', '订金'),
(1006, 20, 'Ngân hàng', '银行'),
(1007, 20, 'Ví của tôi', '我的钱包'),
(1008, 20, 'Số dư hiện tại', '当前余额'),
(1009, 20, 'Tổng tiền nạp', '总存款'),
(1010, 20, 'Số dư đã sử dụng', '已使用余额'),
(1011, 20, 'THANH TOÁN', '支付'),
(1012, 20, 'Lưu ý nạp tiền', '存款须知'),
(1013, 20, 'Lịch sử nạp tiền', '存款历史'),
(1014, 20, 'Số tài khoản:', '帐号：'),
(1015, 20, 'Chủ tài khoản:', '帐户持有人：'),
(1016, 20, 'Ngân hàng:', '银行：'),
(1017, 20, 'Nội dung chuyển khoản:', '转让内容：'),
(1018, 20, 'Mã giao dịch', '交易代码'),
(1019, 20, 'Nội dung', '内容'),
(1020, 20, 'Số tiền nạp', '存款金额'),
(1021, 20, 'Thực nhận', '实现'),
(1022, 20, 'Thời gian', '时间'),
(1023, 20, 'Trạng thái', '地位'),
(1024, 20, 'Đã thanh toán', '有薪酬的'),
(1025, 20, 'Tất cả', '全部'),
(1026, 20, 'Hôm nay', '今天'),
(1027, 20, 'Tuần này', '本星期'),
(1028, 20, 'Tháng này', '本月'),
(1029, 20, 'Đã thanh toán:', '有薪酬的：'),
(1030, 20, 'Thực nhận:', '实际收到：'),
(1031, 20, 'Thao tác', '手术'),
(1032, 20, 'Nhật ký hoạt động', '活动日志'),
(1033, 20, 'Tìm kiếm', '搜索'),
(1034, 20, 'Bỏ lọc', '取消过滤'),
(1035, 20, 'Hiển thị', '展示'),
(1036, 20, 'Ẩn', '隐藏'),
(1037, 20, 'Biến động số dư', '余额波动'),
(1038, 20, 'Số dư ban đầu', '期初余额'),
(1039, 20, 'Số dư thay đổi', '平衡调整'),
(1040, 20, 'Lý do', '原因'),
(1041, 20, 'Chọn thời gian cần tìm', '选择时间进行搜索'),
(1042, 20, 'Hiển thị thêm', '显示更多'),
(1043, 20, 'Ẩn bớt', '隐藏'),
(1044, 20, 'Nội dung chuyển khoản', '传输内容'),
(1045, 20, 'Đăng nhập bằng Google', '使用 Google 登录'),
(1046, 20, 'Đăng nhập bằng Facebook', '使用 Facebook 登录'),
(1047, 20, 'Đăng ký tài khoản', '注册账户'),
(1048, 20, 'Tài khoản đăng nhập', '登录账户'),
(1049, 20, 'Mật khẩu', '密码'),
(1050, 20, 'Nhập lại mật khẩu', '重新输入密码'),
(1051, 20, 'Đăng Ký', '登记'),
(1052, 20, 'Vui lòng nhập thông tin đăng ký', '请输入注册信息'),
(1053, 20, 'Vui lòng nhập thông tin đăng nhập', '请输入您的登录信息'),
(1054, 20, 'Thông tin cá nhân', '个人信息'),
(1055, 20, 'Cấu hình nạp tiền Crypto', '加密货币存款配置'),
(1056, 20, 'All Time', '所有时间'),
(1057, 20, 'Thống kê thanh toán tháng', '每月付款统计'),
(1058, 20, 'Lịch sử nạp tiền Crypto', '加密货币存款历史记录'),
(1059, 20, 'Thống kê', '统计'),
(1060, 20, 'Cấu hình', '配置'),
(1061, 20, 'Nạp tối đa', '最大负载'),
(1062, 20, 'Nạp tối thiểu', '最低存款'),
(1063, 20, 'Nạp tiền bằng Crypto', '使用加密货币存款'),
(1064, 20, 'Lưu ý', '笔记'),
(1065, 20, 'Lịch sử nạp Crypto', '加密货币存款历史记录'),
(1066, 20, 'Số lượng', '数量'),
(1067, 20, 'Thời gian tạo', '创建时间'),
(1068, 20, 'Xem thêm', '查看更多'),
(1069, 20, 'The minimum deposit amount is:', '最低存款金额为：'),
(1070, 20, 'Số tiền gửi tối đa là:', '最高存款额为：'),
(1071, 20, 'Số tiền gửi tối thiểu là:', '最低存款金额为：'),
(1072, 20, 'Chức năng này đang được bảo trì', '该功能正在维护中。'),
(1073, 20, 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau', '由于 API 错误，无法生成发票，请稍后重试'),
(1074, 20, 'Tạo hoá đơn nạp tiền thành công', '充值发票创建成功'),
(1075, 20, 'Nạp tiền bằng PayPal', '通过 PayPal 存款'),
(1076, 20, 'Lịch sử nạp PayPal', 'PayPal 存款历史记录'),
(1077, 20, 'Số tiền gửi', '存款金额'),
(1078, 20, 'Vui lòng nhập số tiền cần nạp', '请输入存款金额'),
(1079, 20, 'Mặc định', '默认'),
(1080, 20, 'Phổ biến', '受欢迎的'),
(1081, 20, 'Tìm kiếm bài viết', '搜索文章'),
(1082, 20, 'Bài viết phổ biến', '热门文章'),
(1083, 20, 'Liên kết giới thiệu của bạn', '您的推荐链接'),
(1084, 20, 'Đã sao chép vào bộ nhớ tạm', '已复制到剪贴板'),
(1085, 20, 'Số tài khoản', '帐号'),
(1086, 20, 'Tên chủ tài khoản', '帐户持有人姓名'),
(1087, 20, 'Số tiền cần rút', '提款金额'),
(1088, 20, 'Rút số dư hoa hồng', '提取佣金余额'),
(1089, 20, 'Lịch sử rút tiền', '提款记录'),
(1090, 20, 'Rút tiền', '提款'),
(1091, 20, 'Lịch sử', '历史'),
(1092, 20, 'Thao tác quá nhanh, vui lòng chờ', '操作太快，请等待。'),
(1093, 20, 'Vui lòng chọn ngân hàng cần rút', '请选择您要提款的银行。'),
(1094, 20, 'Vui lòng nhập số tài khoản cần rút', '请输入提款账号'),
(1095, 20, 'Vui lòng nhập tên chủ tài khoản', '请输入帐户持有人姓名'),
(1096, 20, 'Vui lòng nhập số tiền cần rút', '请输入提款金额'),
(1097, 20, 'Số tiền rút tối thiểu phải là', '最低提款金额必须为'),
(1098, 20, 'Số dư hoa hồng khả dụng của bạn không đủ', '您的可用佣金余额不足'),
(1099, 20, 'Gian lận khi rút số dư hoa hồng', '提取佣金余额存在欺诈行为'),
(1100, 20, 'Tài khoản của bạn đã bị khóa vì gian lận', '您的帐户因欺诈已被锁定'),
(1101, 20, 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý', '提款请求创建成功，请等待管理员处理'),
(1102, 20, 'Số tiền rút', '提款金额'),
(1103, 20, 'Thông kê của bạn', '您的统计数据'),
(1104, 20, 'Số tiền hoa hồng khả dụng', '可用佣金额'),
(1105, 20, 'Tổng số tiền hoa hồng đã nhận', '收到的佣金总额'),
(1106, 20, 'Số lần nhấp vào liên kết', '链接点击次数'),
(1107, 20, 'Lịch sử hoa hồng', '玫瑰的历史'),
(1108, 20, 'Hoa hồng ban đầu', '初始佣金'),
(1109, 20, 'Hoa hồng thay đổi', '佣金变动'),
(1110, 20, 'Hoa hồng hiện tại', '现任委员会'),
(1111, 20, 'Vui lòng nhập số lượng cần mua', '请输入购买数量'),
(1112, 20, 'Tổng tiền thanh toán:', '总付款：'),
(1113, 20, 'Số tiền giảm:', '折扣金额：'),
(1114, 20, 'Thành tiền:', '总金额：'),
(1115, 20, 'Mã giảm giá:', '折扣代码：'),
(1116, 20, 'Nhập mã giảm giá nếu có', '如果有折扣码请输入'),
(1117, 20, 'THÔNG TIN MUA HÀNG', '购买信息'),
(1118, 20, 'Số lượng cần mua:', '购买数量：'),
(1119, 20, 'Chia sẻ:', '分享：'),
(1120, 20, 'Mua Ngay', '立即购买'),
(1121, 20, 'Kho hàng:', '仓库：'),
(1122, 20, 'Đã bán:', '卖：'),
(1123, 20, 'Yêu Thích', '最喜欢的'),
(1124, 20, 'Bỏ Thích', '喜欢'),
(1125, 20, 'Danh sách sản phẩm yêu thích', '最喜爱产品列表'),
(1126, 20, 'Sản phẩm', '产品'),
(1127, 20, 'Kho hàng', '仓库'),
(1128, 20, 'Giá', '价格'),
(1129, 20, 'Mua', '第一的'),
(1130, 20, 'Xem', '看'),
(1131, 20, 'Xóa', '擦除'),
(1132, 20, 'Hết hàng', '缺货'),
(1133, 20, 'Thêm vào mục yêu thích', '添加到收藏夹'),
(1134, 20, 'Đã thêm vào mục yêu thích', '已添加到收藏夹'),
(1135, 20, 'Xóa đơn hàng', '删除订单'),
(1136, 20, 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn', '从历史记录中删除选定的订单'),
(1137, 20, 'Mã đơn hàng', '订购代码'),
(1138, 20, 'Xem chi tiết', '查看详细信息'),
(1139, 20, 'Tải về máy', '下载'),
(1140, 20, 'Xóa khỏi lịch sử', '从历史记录中删除'),
(1141, 20, 'Liên hệ', '接触'),
(1142, 20, 'Chính sách', '政策'),
(1143, 20, 'Tài liệu API', 'API 文档'),
(1144, 20, 'Trang chủ', '家'),
(1145, 20, 'Liên kết', '关联'),
(1146, 20, 'Câu hỏi thường gặp', '常见问题'),
(1147, 20, 'Liên hệ chúng tôi', '联系我们'),
(1148, 20, 'Sản phẩm:', '产品：'),
(1149, 20, 'Số lượng mua:', '购买数量：'),
(1150, 20, 'Thanh toán:', '支付：'),
(1151, 20, 'Mã đơn hàng:', '订单代码：'),
(1152, 20, 'Chi tiết đơn hàng', '订单详情'),
(1153, 20, 'Tài khoản', '帐户'),
(1154, 20, 'Lưu các tài khoản đã chọn vào tệp .txt', '将选定的帐户保存到 .txt 文件'),
(1155, 20, 'Sao chép các tài khoản đã chọn', '复制选定的帐户'),
(1156, 20, 'Chỉ sao chép UID các tài khoản đã chọn', '仅复制选定帐户的 UID'),
(1157, 20, 'Số dư của tôi:', '我的余额：'),
(1158, 20, 'Khuyến mãi', '晋升'),
(1159, 20, 'Số tiền nạp lớn hơn hoặc bằng', '存款金额大于或等于'),
(1160, 20, 'Khuyến mãi thêm', '更多促销活动'),
(1161, 20, 'Thông tin chi tiết khách hàng', '客户详细信息'),
(1162, 20, 'Chia sẻ liên kết này lên mạng xã hội hoặc bạn bè của bạn.', '在社交网络上或与您的朋友分享此链接。'),
(1163, 20, 'Tài liệu tích hợp API', 'API 集成文档'),
(1164, 20, 'Lấy thông tin tài khoản', '获取帐户信息'),
(1165, 20, 'Lấy danh sách chuyên mục và sản phẩm', '获取类别和产品列表'),
(1166, 20, 'Mua hàng', '购买'),
(1167, 20, 'ID sản phẩm cần mua', '要购买的产品ID'),
(1168, 20, 'Số lượng cần mua', '购买数量'),
(1169, 20, 'Mã giảm giá nếu có', 'Mã giảm giá nếu có'),
(1170, 20, 'Bảo mật', '安全'),
(1171, 20, 'Bảo mật tài khoản', '账户安全'),
(1172, 20, 'Xác minh đăng nhập bằng', '使用以下方式验证登录'),
(1173, 20, 'Gửi thông báo về mail khi đăng nhập thành công:', '登录成功时发送电子邮件通知：'),
(1174, 20, 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:', '必须使用正确的浏览器和 IP 地址才能查看订单：'),
(1175, 20, '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.', '- 使用您的手机下载 Google Authenticator App，然后扫描二维码以接收验证码。'),
(1176, 20, '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.', '- 关闭验证时，二维码将会改变。'),
(1177, 20, '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.', '- 如果您启用使用 OTP 邮件登录验证，请不要启用 Google Authenticator，反之亦然。'),
(1178, 20, 'Lưu', '节省'),
(1179, 20, 'Nhập mã xác minh để lưu', '输入验证码保存'),
(1180, 20, 'Sản phẩm liên quan đến từ khóa', '与关键词相关的产品'),
(1181, 20, 'trong số', '之中'),
(1182, 20, 'Quay lại', '回来'),
(1183, 20, 'Tải về đơn hàng', '下载订单'),
(1184, 20, 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý', '点击同意后系统将下载订单。'),
(1185, 20, 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý', '当您点击同意时，系统将从您的历史记录中删除该订单。'),
(1186, 20, 'Đóng', '关闭'),
(1187, 20, 'Xuất tất cả tài khoản ra tệp .txt', '将所有帐户导出到 .txt 文件'),
(1188, 20, 'Xóa đơn hàng này khỏi lịch sử của bạn', '从历史记录中删除此订单'),
(1189, 20, 'Thành công !', '成功 ！'),
(1190, 20, 'Xem chi tiết đơn hàng', '查看订单详情'),
(1191, 20, 'Mua thêm', '购买更多'),
(1192, 20, 'Tạo đơn hàng thành công !', '订单创建成功！'),
(1193, 20, 'Đang xử lý...', '加工...'),
(1194, 20, 'tài khoản giảm', '帐户减少'),
(1195, 20, 'Chi tiết', '细节'),
(1196, 20, 'Tích hợp API', 'API 集成'),
(1197, 20, 'Lấy chi tiết sản phẩm', '获取产品详细信息'),
(1198, 20, 'Ghi chú cá nhân', '个人笔记'),
(1199, 20, 'ngày trước', '前一天'),
(1200, 20, 'tiếng trước', '以前的'),
(1201, 20, 'phút trước', '分钟前'),
(1202, 20, 'giây trước', '几秒前'),
(1203, 20, 'Hôm qua', '昨天'),
(1204, 20, 'tuần trước', '上星期'),
(1205, 20, 'tháng trước', '上个月'),
(1206, 20, 'năm trước', '去年'),
(1207, 20, 'Đơn hàng đã bị xóa', '订单已删除'),
(1208, 20, 'Bạn có chắc không', '你确定吗？'),
(1209, 20, 'Hệ thống sẽ xóa', '系统将删除'),
(1210, 20, 'đơn hàng bạn chọn khi nhấn Đồng Ý', '单击“同意”时选择的顺序'),
(1211, 20, 'Vui lòng chọn ít nhất một đơn hàng.', 'Vui lòng chọn ít nhất một đơn hàng.'),
(1212, 20, 'Thất bại!', '失败！'),
(1213, 20, 'Thành công!', '成功！'),
(1214, 20, 'Xóa đơn hàng thành công', '订单删除成功'),
(1215, 20, 'Miễn phí', '免费'),
(1216, 20, 'Lấy mã 2FA', '获取 2FA 代码'),
(1217, 20, 'Bạn đang xem', '您正在查看'),
(1218, 20, 'Nhập danh sách UID', '导入UID列表'),
(1219, 20, 'Mỗi dòng 1 UID', '每行 1 个 UID'),
(1220, 20, 'Tài khoản Live', '真实账户'),
(1221, 20, 'Tài khoản Die', '死账户'),
(1222, 20, 'Giảm giá', '折扣'),
(1223, 20, 'Tỷ lệ hoa hồng', '佣金率'),
(1224, 20, 'Thành viên đã giới thiệu', '推荐会员'),
(1225, 20, 'Không có dữ liệu', '没有可用数据'),
(1226, 20, 'Khách hàng', '客户'),
(1227, 20, 'Ngày đăng ký', '注册日期'),
(1228, 20, 'Hoa hồng', '玫瑰'),
(1229, 20, 'Mật khẩu mạnh', '强密码'),
(1230, 20, 'Mật khẩu trung bình', '平均密码'),
(1231, 20, 'Mật khẩu rất yếu', '密码强度太弱'),
(1232, 20, 'Vui lòng nhập mã xác minh 2FA', '请输入2FA验证码'),
(1233, 20, 'Mã xác minh không chính xác', '验证码不正确'),
(1234, 20, 'Bật xác thực Google Authenticator', '启用 Google 身份验证器'),
(1235, 20, 'Tắt xác thực Google Authenticator', '关闭 Google Authenticator 身份验证'),
(1236, 20, 'Vui lòng đăng nhập để sử dụng tính năng này', '请登录以使用此功能'),
(1237, 20, 'Chọn phương thức nạp tiền', '选择存款方式'),
(1238, 20, 'Không hiển thị lại trong 2 giờ', '2小时后再无显示'),
(1239, 20, 'Thông báo', '通知'),
(1240, 20, 'Tìm kiếm sản phẩm...', '搜索产品...'),
(1241, 20, 'Chat hỗ trợ', '聊天支持'),
(1242, 20, 'Chat ngay', '立即聊天'),
(1243, 20, 'ĐƠN HÀNG GẦN ĐÂY', '近期订单'),
(1244, 20, 'NẠP TIỀN GẦN ĐÂY', '最近存款'),
(1245, 20, 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin', '该功能尚未配置，请联系管理员'),
(1246, 20, 'Số dư không đủ, vui lòng nạp thêm', '余额不足，请充值'),
(1247, 20, 'Công cụ Check Live UID Facebook', 'Facebook Live UID 检查工具'),
(1248, 20, 'Tiếp thị liên kết', '联盟营销'),
(1249, 20, 'Liên kết sản phẩm', '产品链接'),
(1250, 20, 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.', '分享以下产品链接给您的朋友，当您的朋友通过以下链接购买时，您将获得佣金。'),
(1251, 20, 'Tất cả sản phẩm', '所有产品'),
(1252, 20, 'Sản phẩm yêu thích', '最喜欢的产品');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fullname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` int(11) NOT NULL DEFAULT 0,
  `ctv` int(11) NOT NULL DEFAULT 0,
  `banned` int(11) NOT NULL DEFAULT 0,
  `reason_banned` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `time_session` int(11) DEFAULT 0,
  `time_request` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token_2fa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token_forgot_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time_forgot_password` int(11) NOT NULL DEFAULT 0,
  `money` float NOT NULL DEFAULT 0,
  `total_money` float NOT NULL DEFAULT 0,
  `debit` float NOT NULL DEFAULT 0,
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Male',
  `device` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_2fa` int(11) NOT NULL DEFAULT 0,
  `SecretKey_2fa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `limit_2fa` int(11) NOT NULL DEFAULT 0,
  `discount` float NOT NULL DEFAULT 0,
  `trial` int(11) NOT NULL DEFAULT 0,
  `ref_id` int(11) NOT NULL DEFAULT 0,
  `ref_ck` float NOT NULL DEFAULT 0,
  `ref_click` int(11) NOT NULL DEFAULT 0,
  `ref_amount` float NOT NULL DEFAULT 0,
  `ref_price` float NOT NULL DEFAULT 0,
  `ref_total_price` float NOT NULL DEFAULT 0,
  `telegram_chat_id` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_key` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_attempts` int(11) NOT NULL DEFAULT 0,
  `status_otp_mail` int(11) NOT NULL DEFAULT 0,
  `otp_mail` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token_otp_mail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `limit_otp_mail` int(11) NOT NULL DEFAULT 0,
  `status_noti_login_to_mail` int(11) NOT NULL DEFAULT 0,
  `status_view_order` int(11) NOT NULL DEFAULT 0,
  `utm_source` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'web'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admin_request_logs`
--
ALTER TABLE `admin_request_logs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `admin_role`
--
ALTER TABLE `admin_role`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `aff_log`
--
ALTER TABLE `aff_log`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `aff_withdraw`
--
ALTER TABLE `aff_withdraw`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `automations`
--
ALTER TABLE `automations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `block_ip`
--
ALTER TABLE `block_ip`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trans_id` (`trans_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `coupon_used`
--
ALTER TABLE `coupon_used`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `deposit_log`
--
ALTER TABLE `deposit_log`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `dongtien`
--
ALTER TABLE `dongtien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transid` (`transid`);

--
-- Chỉ mục cho bảng `email_campaigns`
--
ALTER TABLE `email_campaigns`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `email_sending`
--
ALTER TABLE `email_sending`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `failed_attempts`
--
ALTER TABLE `failed_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `log_bank_auto`
--
ALTER TABLE `log_bank_auto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Chỉ mục cho bảng `log_ref`
--
ALTER TABLE `log_ref`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `momo`
--
ALTER TABLE `momo`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `tranId` (`tranId`);

--
-- Chỉ mục cho bảng `order_log`
--
ALTER TABLE `order_log`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_bank`
--
ALTER TABLE `payment_bank`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Chỉ mục cho bảng `payment_crypto`
--
ALTER TABLE `payment_crypto`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_flutterwave`
--
ALTER TABLE `payment_flutterwave`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_manual`
--
ALTER TABLE `payment_manual`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_momo`
--
ALTER TABLE `payment_momo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Chỉ mục cho bảng `payment_paypal`
--
ALTER TABLE `payment_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_pm`
--
ALTER TABLE `payment_pm`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_squadco`
--
ALTER TABLE `payment_squadco`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_thesieure`
--
ALTER TABLE `payment_thesieure`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Chỉ mục cho bảng `payment_toyyibpay`
--
ALTER TABLE `payment_toyyibpay`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trans_id` (`trans_id`),
  ADD UNIQUE KEY `BillCode` (`BillCode`);

--
-- Chỉ mục cho bảng `payment_xipay`
--
ALTER TABLE `payment_xipay`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Chỉ mục cho bảng `post_category`
--
ALTER TABLE `post_category`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product_die`
--
ALTER TABLE `product_die`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`);

--
-- Chỉ mục cho bảng `product_discount`
--
ALTER TABLE `product_discount`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product_order`
--
ALTER TABLE `product_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trans_id` (`trans_id`);

--
-- Chỉ mục cho bảng `product_sold`
--
ALTER TABLE `product_sold`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product_stock`
--
ALTER TABLE `product_stock`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `telegram_logs`
--
ALTER TABLE `telegram_logs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `translate`
--
ALTER TABLE `translate`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admin_request_logs`
--
ALTER TABLE `admin_request_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `admin_role`
--
ALTER TABLE `admin_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `aff_log`
--
ALTER TABLE `aff_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `aff_withdraw`
--
ALTER TABLE `aff_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `automations`
--
ALTER TABLE `automations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `banks`
--
ALTER TABLE `banks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `block_ip`
--
ALTER TABLE `block_ip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `coupon_used`
--
ALTER TABLE `coupon_used`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `deposit_log`
--
ALTER TABLE `deposit_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `dongtien`
--
ALTER TABLE `dongtien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `email_campaigns`
--
ALTER TABLE `email_campaigns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `email_sending`
--
ALTER TABLE `email_sending`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `failed_attempts`
--
ALTER TABLE `failed_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `log_bank_auto`
--
ALTER TABLE `log_bank_auto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `log_ref`
--
ALTER TABLE `log_ref`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `momo`
--
ALTER TABLE `momo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_log`
--
ALTER TABLE `order_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_bank`
--
ALTER TABLE `payment_bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_crypto`
--
ALTER TABLE `payment_crypto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_flutterwave`
--
ALTER TABLE `payment_flutterwave`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_manual`
--
ALTER TABLE `payment_manual`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_momo`
--
ALTER TABLE `payment_momo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_paypal`
--
ALTER TABLE `payment_paypal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_pm`
--
ALTER TABLE `payment_pm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_squadco`
--
ALTER TABLE `payment_squadco`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_thesieure`
--
ALTER TABLE `payment_thesieure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_toyyibpay`
--
ALTER TABLE `payment_toyyibpay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_xipay`
--
ALTER TABLE `payment_xipay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `post_category`
--
ALTER TABLE `post_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_die`
--
ALTER TABLE `product_die`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_discount`
--
ALTER TABLE `product_discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_order`
--
ALTER TABLE `product_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_sold`
--
ALTER TABLE `product_sold`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_stock`
--
ALTER TABLE `product_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=284;

--
-- AUTO_INCREMENT cho bảng `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `telegram_logs`
--
ALTER TABLE `telegram_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `translate`
--
ALTER TABLE `translate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1253;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
