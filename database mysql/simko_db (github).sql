-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 01, 2025 at 01:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simko_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `data_sewa`
--

CREATE TABLE `data_sewa` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_penghuni` int(10) UNSIGNED NOT NULL,
  `id_kost` int(10) UNSIGNED NOT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT curdate(),
  `status` enum('Aktif','Selesai') DEFAULT 'Aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_sewa`
--

INSERT INTO `data_sewa` (`id`, `id_penghuni`, `id_kost`, `tanggal_mulai`, `status`) VALUES
(44, 64, 2, '2025-06-29', 'Aktif'),
(53, 73, 1, '2025-07-05', 'Aktif'),
(56, 76, 3, '2025-07-07', 'Aktif'),
(57, 77, 4, '2025-07-07', 'Aktif'),
(58, 78, 1, '2025-07-07', 'Aktif'),
(59, 79, 3, '2025-07-07', 'Aktif'),
(60, 80, 4, '2025-07-07', 'Aktif'),
(61, 81, 1, '2025-07-07', 'Aktif'),
(64, 84, 3, '2025-07-07', 'Aktif'),
(65, 85, 1, '2025-07-08', 'Aktif'),
(66, 87, 3, '2025-07-08', 'Aktif'),
(68, 89, 3, '2025-07-10', 'Aktif'),
(70, 91, 3, '2025-07-11', 'Aktif'),
(72, 94, 1, '2025-07-11', 'Aktif'),
(73, 95, 8, '2025-07-12', 'Aktif'),
(74, 96, 3, '2025-07-15', 'Aktif'),
(75, 96, 3, '2025-07-15', 'Aktif'),
(76, 97, 2, '2025-07-30', 'Aktif'),
(77, 98, 9, '2025-07-30', 'Aktif');

-- --------------------------------------------------------

--
-- Table structure for table `informasi_umum`
--

CREATE TABLE `informasi_umum` (
  `id` int(11) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `isi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `informasi_umum`
--

INSERT INTO `informasi_umum` (`id`, `kategori`, `isi`) VALUES
(1, 'Panduan Aplikasi', '1. Masuk ke akun.\n2. Lihat informasi kost.\n3. Lakukan pembayaran tepat waktu.'),
(2, 'Hubungi Kami', 'WhatsApp: 081234567890\nInstagram: @simko_kost\ntiktok: simkos\nAlamat: Jl. Kost Damai No. 99\n'),
(3, 'Syarat dan Ketentuan', '1. Bayar tepat waktu.\n2. Jaga kebersihan.\n3. Tidak boleh membawa tamu menginap.\n4. Jangan melakukan kriminal dan kejahatan lain'),
(4, 'Identitas', 'Nama: Budi hari\nEmail: budi@mail.com\nNo. HP: 081234567890');

-- --------------------------------------------------------

--
-- Table structure for table `komplain`
--

CREATE TABLE `komplain` (
  `id` int(11) NOT NULL,
  `id_penghuni` int(10) UNSIGNED NOT NULL,
  `kamar` varchar(20) NOT NULL,
  `tentang` varchar(100) NOT NULL,
  `pesan` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `komplain`
--

INSERT INTO `komplain` (`id`, `id_penghuni`, `kamar`, `tentang`, `pesan`, `created_at`) VALUES
(3, 80, 'A2', 'qqwq', 'qwqwqw', '2025-07-07 11:44:54'),
(4, 82, 'a3', 'gerah', 'ac gak ada', '2025-07-07 12:33:04'),
(5, 83, 'A1', 'bau sampah', 'bau sampah dari pembuangan kost lain', '2025-07-07 13:43:58'),
(6, 94, 'A2', 'gak betah', 'gak betah', '2025-07-15 08:56:55'),
(7, 97, 'A1', 'rembes', 'rembes dinding', '2025-07-30 02:53:09'),
(8, 98, 'A1', 'lampu', 'lampu mati', '2025-07-30 04:33:03');

-- --------------------------------------------------------

--
-- Table structure for table `kost`
--

CREATE TABLE `kost` (
  `id` int(10) UNSIGNED NOT NULL,
  `kamar` varchar(10) NOT NULL,
  `ukuran` varchar(20) NOT NULL,
  `fasilitas` text NOT NULL,
  `harga` int(10) UNSIGNED NOT NULL,
  `status` enum('Kosong','Terisi') DEFAULT 'Kosong',
  `gambar` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kost`
--

INSERT INTO `kost` (`id`, `kamar`, `ukuran`, `fasilitas`, `harga`, `status`, `gambar`) VALUES
(1, 'A1', '3x3', 'AC, WiFi', 750000, 'Terisi', 'kost_6889867fc4d8c5.95972450.png'),
(2, 'A2', '3x4', 'Kipas, WiFi', 650000, 'Terisi', 'kost_68713a8c2847f6.79215992.png'),
(3, 'A3', '2x3', 'ac', 130000, 'Terisi', 'kost_68713a937cd4c7.81793621.png'),
(4, 'A4', '2x5', 'kulkas', 120000, 'Terisi', 'kost_68713a9c967223.49359750.png'),
(6, 'A5', '4x6', 'ac', 1200000, 'Kosong', 'kost_68713aa944b0e3.41514134.png'),
(7, 'A6', '4x4', 'VVIP', 950000, 'Kosong', 'kost_68713ac8a8fc81.27050436.png'),
(8, 'A7', '4x4', 'VIP', 2500000, 'Terisi', 'kost_68713adead2541.30468783.png'),
(9, 'a8', '6x7', 'ac ', 5000, 'Terisi', 'kost_687623445c4528.93639926.jpe');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_penghuni` int(10) UNSIGNED NOT NULL,
  `id_ref` int(11) DEFAULT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `pesan` text DEFAULT NULL,
  `target` enum('admin','penghuni') DEFAULT 'admin',
  `tanggal` datetime DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0,
  `waktu` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifikasi`
--

INSERT INTO `notifikasi` (`id`, `id_penghuni`, `id_ref`, `judul`, `pesan`, `target`, `tanggal`, `is_read`, `waktu`) VALUES
(125, 73, 105, 'Info', 'Pembayaran bulan Juli menunggu konfirmasi.', 'admin', '2025-07-05 16:02:36', 1, '2025-07-05 16:02:36'),
(126, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:03:42', 0, '2025-07-05 16:03:42'),
(127, 73, 106, 'Info', 'Pembayaran bulan July 2025 menunggu konfirmasi.', 'admin', '2025-07-05 16:04:59', 1, '2025-07-05 16:04:59'),
(128, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:05:53', 0, '2025-07-05 16:05:53'),
(129, 73, 107, 'Info', 'Pembayaran bulan August 2025 menunggu konfirmasi.', 'admin', '2025-07-05 16:11:42', 1, '2025-07-05 16:11:42'),
(130, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:11:58', 0, '2025-07-05 16:11:58'),
(131, 73, 108, 'Info', 'Pembayaran bulan September 2025 menunggu konfirmasi.', 'admin', '2025-07-05 16:17:27', 1, '2025-07-05 16:17:27'),
(132, 73, 109, 'Info', 'Pembayaran bulan October 2025 menunggu konfirmasi.', 'admin', '2025-07-05 16:18:31', 1, '2025-07-05 16:18:31'),
(133, 73, 110, 'Info', 'Pembayaran bulan November 2025 menunggu konfirmasi.', 'admin', '2025-07-05 16:18:35', 1, '2025-07-05 16:18:35'),
(134, 73, 111, 'Info', 'Pembayaran bulan December 2025 menunggu konfirmasi.', 'admin', '2025-07-05 16:18:38', 1, '2025-07-05 16:18:38'),
(135, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:27:14', 0, '2025-07-05 16:27:14'),
(136, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:27:15', 0, '2025-07-05 16:27:15'),
(137, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:27:15', 0, '2025-07-05 16:27:15'),
(138, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:27:17', 0, '2025-07-05 16:27:17'),
(139, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:27:17', 0, '2025-07-05 16:27:17'),
(140, 73, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-05 16:27:18', 0, '2025-07-05 16:27:18'),
(141, 78, 112, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 11:57:58', 0, '2025-07-07 11:57:58'),
(142, 79, 113, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 12:00:37', 1, '2025-07-07 12:00:37'),
(143, 79, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 12:01:20', 0, '2025-07-07 12:01:20'),
(144, 79, 114, 'Info', 'Pembayaran bulan August 2025 menunggu konfirmasi.', 'admin', '2025-07-07 12:43:41', 1, '2025-07-07 12:43:41'),
(145, 79, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 12:44:10', 0, '2025-07-07 12:44:10'),
(146, 79, 115, 'Info', 'Pembayaran bulan 2025-09 menunggu konfirmasi.', 'admin', '2025-07-07 12:55:52', 0, '2025-07-07 12:55:52'),
(147, 80, 116, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 13:54:57', 1, '2025-07-07 13:54:57'),
(148, 80, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 13:55:29', 0, '2025-07-07 13:55:29'),
(149, 80, 117, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 13:55:50', 1, '2025-07-07 13:55:50'),
(150, 80, 118, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-07 13:55:55', 1, '2025-07-07 13:55:55'),
(151, 80, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 13:56:44', 0, '2025-07-07 13:56:44'),
(152, 80, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 13:56:45', 0, '2025-07-07 13:56:45'),
(153, 81, 119, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 19:28:17', 0, '2025-07-07 19:28:17'),
(154, 82, 120, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 19:31:42', 1, '2025-07-07 19:31:42'),
(155, 82, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 19:32:14', 0, '2025-07-07 19:32:14'),
(156, 82, 121, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-07 19:32:40', 1, '2025-07-07 19:32:40'),
(157, 82, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 19:33:26', 0, '2025-07-07 19:33:26'),
(158, 83, 122, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 20:41:20', 1, '2025-07-07 20:41:20'),
(159, 83, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 20:41:47', 0, '2025-07-07 20:41:47'),
(160, 83, 123, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-07 20:43:02', 1, '2025-07-07 20:43:02'),
(161, 83, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-07 20:44:54', 0, '2025-07-07 20:44:54'),
(162, 84, 124, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-07 20:47:00', 0, '2025-07-07 20:47:00'),
(163, 85, 125, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-08 12:12:33', 0, '2025-07-08 12:12:33'),
(164, 80, 126, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-08 16:46:57', 0, '2025-07-08 16:46:57'),
(165, 80, 127, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-08 16:47:13', 0, '2025-07-08 16:47:13'),
(166, 87, 128, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-08 16:51:13', 0, '2025-07-08 16:51:13'),
(167, 87, 129, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-08 16:52:27', 0, '2025-07-08 16:52:27'),
(168, 87, 130, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-08 16:52:40', 1, '2025-07-08 16:52:40'),
(169, 87, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-08 17:21:32', 0, '2025-07-08 17:21:32'),
(170, 80, 131, 'Info', 'Pembayaran bulan 2025-12 menunggu konfirmasi.', 'admin', '2025-07-10 19:11:29', 0, '2025-07-10 19:11:29'),
(171, 80, 132, 'Info', 'Pembayaran bulan 2025-10 menunggu konfirmasi.', 'admin', '2025-07-10 20:12:24', 0, '2025-07-10 20:12:24'),
(172, 80, 133, 'Info', 'Pembayaran bulan 2025-10 menunggu konfirmasi.', 'admin', '2025-07-10 20:12:33', 0, '2025-07-10 20:12:33'),
(173, 80, 134, 'Info', 'Pembayaran bulan 2025-11 menunggu konfirmasi.', 'admin', '2025-07-10 20:13:52', 0, '2025-07-10 20:13:52'),
(174, 80, 135, 'Info', 'Pembayaran bulan 2025-10 menunggu konfirmasi.', 'admin', '2025-07-10 20:14:08', 0, '2025-07-10 20:14:08'),
(175, 80, 136, 'Info', 'Pembayaran bulan 2025-11 menunggu konfirmasi.', 'admin', '2025-07-10 21:13:20', 0, '2025-07-10 21:13:20'),
(176, 80, 137, 'Info', 'Pembayaran bulan 2025-10 menunggu konfirmasi.', 'admin', '2025-07-10 21:13:42', 0, '2025-07-10 21:13:42'),
(177, 80, 138, 'Info', 'Pembayaran bulan 2025-10 menunggu konfirmasi.', 'admin', '2025-07-10 21:14:13', 0, '2025-07-10 21:14:13'),
(178, 80, 139, 'Info', 'Pembayaran bulan 2025-09 menunggu konfirmasi.', 'admin', '2025-07-10 21:50:32', 0, '2025-07-10 21:50:32'),
(179, 80, 140, 'Info', 'Pembayaran bulan 2025-09 menunggu konfirmasi.', 'admin', '2025-07-10 22:54:44', 0, '2025-07-10 22:54:44'),
(180, 80, 141, 'Info', 'Pembayaran bulan 2025-09 menunggu konfirmasi.', 'admin', '2025-07-10 22:56:42', 0, '2025-07-10 22:56:42'),
(181, 88, 142, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-10 23:08:10', 0, '2025-07-10 23:08:10'),
(182, 88, 143, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-10 23:08:30', 0, '2025-07-10 23:08:30'),
(183, 88, 144, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-10 23:12:22', 0, '2025-07-10 23:12:22'),
(184, 88, 145, 'Info', 'Pembayaran bulan 2025-12 menunggu konfirmasi.', 'admin', '2025-07-10 23:13:50', 0, '2025-07-10 23:13:50'),
(185, 89, 146, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-10 23:25:05', 0, '2025-07-10 23:25:05'),
(190, 80, 151, 'Info', 'Pembayaran bulan 2025-10 menunggu konfirmasi.', 'admin', '2025-07-10 23:28:47', 0, '2025-07-10 23:28:47'),
(191, 91, 152, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-11 05:50:42', 1, '2025-07-11 05:50:42'),
(192, 91, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-11 05:51:19', 0, '2025-07-11 05:51:19'),
(194, 94, 154, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-11 23:27:54', 1, '2025-07-11 23:27:54'),
(195, 95, 155, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-12 15:27:46', 1, '2025-07-12 15:27:46'),
(196, 95, 156, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-12 15:29:12', 1, '2025-07-12 15:29:12'),
(197, 95, 157, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-12 15:29:17', 1, '2025-07-12 15:29:17'),
(198, 95, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-12 15:30:42', 0, '2025-07-12 15:30:42'),
(199, 95, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-12 15:30:43', 0, '2025-07-12 15:30:43'),
(200, 95, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-12 15:30:44', 0, '2025-07-12 15:30:44'),
(201, 95, 158, 'Info', 'Pembayaran bulan 2025-10 menunggu konfirmasi.', 'admin', '2025-07-12 15:36:48', 1, '2025-07-12 15:36:48'),
(202, 95, 159, 'Info', 'Pembayaran bulan 2025-09 menunggu konfirmasi.', 'admin', '2025-07-12 16:11:14', 1, '2025-07-12 16:11:14'),
(203, 95, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-12 16:12:05', 0, '2025-07-12 16:12:05'),
(204, 95, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-12 16:12:06', 0, '2025-07-12 16:12:06'),
(205, 94, 160, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-15 15:55:24', 1, '2025-07-15 15:55:24'),
(206, 94, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-15 15:55:59', 0, '2025-07-15 15:55:59'),
(207, 94, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-15 15:56:01', 0, '2025-07-15 15:56:01'),
(208, 96, 161, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-15 16:40:49', 0, '2025-07-15 16:40:49'),
(209, 96, 162, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-15 16:41:42', 1, '2025-07-15 16:41:42'),
(210, 96, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-15 16:43:35', 0, '2025-07-15 16:43:35'),
(211, 96, 163, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-15 16:46:30', 1, '2025-07-15 16:46:30'),
(212, 96, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-15 16:47:07', 0, '2025-07-15 16:47:07'),
(213, 97, 164, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-30 09:48:41', 1, '2025-07-30 09:48:41'),
(214, 97, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-30 09:50:10', 0, '2025-07-30 09:50:10'),
(215, 97, 165, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-30 09:50:30', 0, '2025-07-30 09:50:30'),
(216, 94, 166, 'Info', 'Pembayaran bulan 2025-09 menunggu konfirmasi.', 'admin', '2025-07-30 10:13:46', 0, '2025-07-30 10:13:46'),
(217, 98, 167, 'Info', 'Pembayaran bulan 2025-07 menunggu konfirmasi.', 'admin', '2025-07-30 11:27:35', 1, '2025-07-30 11:27:35'),
(218, 98, NULL, 'Konfirmasi Pembayaran', 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.', 'penghuni', '2025-07-30 11:29:38', 0, '2025-07-30 11:29:38'),
(219, 98, 168, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-30 11:30:55', 0, '2025-07-30 11:30:55'),
(220, 98, 169, 'Info', 'Pembayaran bulan 2025-08 menunggu konfirmasi.', 'admin', '2025-07-30 11:31:05', 0, '2025-07-30 11:31:05');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi_penghuni`
--

CREATE TABLE `notifikasi_penghuni` (
  `id` int(11) NOT NULL,
  `id_penghuni` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `pesan` text NOT NULL,
  `target` varchar(50) DEFAULT 'penghuni',
  `tanggal` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifikasi_penghuni`
--

INSERT INTO `notifikasi_penghuni` (`id`, `id_penghuni`, `judul`, `pesan`, `target`, `tanggal`) VALUES
(1, 0, 'gerbang tutup', 'gerbang tutup jam 10 malam', 'penghuni', '2025-06-28 21:49:13'),
(2, 0, 'lampu mati jam 12 malam', 'lampu harus sudah mati jam 12 malam dan tidur semua', 'penghuni', '2025-07-07 14:01:06'),
(3, 0, 'penghuni baru', 'ada bonus bagi siapa saja yang berhasil mendaftarkan penghuni baru ', 'penghuni', '2025-07-07 19:59:18');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_sewa` int(10) UNSIGNED NOT NULL,
  `id_penghuni` int(10) UNSIGNED NOT NULL,
  `metode` enum('Cash','Transfer') NOT NULL,
  `nominal` int(10) UNSIGNED NOT NULL,
  `catatan` text DEFAULT NULL,
  `tanggal` datetime DEFAULT current_timestamp(),
  `status` enum('Menunggu Konfirmasi','Lunas','Ditolak') DEFAULT 'Menunggu Konfirmasi',
  `bulan` varchar(20) DEFAULT NULL,
  `bukti_transfer` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `id_sewa`, `id_penghuni`, `metode`, `nominal`, `catatan`, `tanggal`, `status`, `bulan`, `bukti_transfer`) VALUES
(112, 58, 78, 'Cash', 2121313, '', '2025-07-07 11:57:58', 'Menunggu Konfirmasi', '2025-07', NULL),
(113, 59, 79, 'Cash', 135000, '', '2025-07-07 12:00:37', 'Lunas', '2025-07', NULL),
(115, 59, 79, 'Cash', 130000, 'Pembayaran bulan 2025-09', '2025-07-07 12:55:52', 'Menunggu Konfirmasi', '2025-09', NULL),
(116, 60, 80, 'Cash', 125000, '', '2025-07-07 13:54:57', 'Lunas', '2025-07', NULL),
(117, 60, 80, 'Cash', 120000, 'Pembayaran bulan 2025-07', '2025-07-07 13:55:50', 'Lunas', '2025-07', NULL),
(118, 60, 80, 'Cash', 120000, 'Pembayaran bulan 2025-08', '2025-07-07 13:55:55', 'Lunas', '2025-08', NULL),
(119, 61, 81, 'Cash', 1132434444, '', '2025-07-07 19:28:17', 'Menunggu Konfirmasi', '2025-07', NULL),
(124, 64, 84, 'Cash', 2121213, '', '2025-07-07 20:47:00', 'Menunggu Konfirmasi', '2025-07', NULL),
(125, 65, 85, 'Cash', 1211313, '', '2025-07-08 12:12:33', 'Menunggu Konfirmasi', '2025-07', NULL),
(126, 60, 80, 'Cash', 120000, 'Pembayaran bulan 2025-07', '2025-07-08 16:46:57', 'Menunggu Konfirmasi', '2025-07', NULL),
(127, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-07', '2025-07-08 16:47:13', 'Menunggu Konfirmasi', '2025-07', NULL),
(128, 66, 87, 'Cash', 130000, '', '2025-07-08 16:51:13', 'Menunggu Konfirmasi', '2025-07', NULL),
(129, 66, 87, 'Cash', 130000, 'Pembayaran bulan 2025-08', '2025-07-08 16:52:27', 'Menunggu Konfirmasi', '2025-08', NULL),
(130, 66, 87, 'Transfer', 130000, 'Pembayaran bulan 2025-08', '2025-07-08 16:52:40', 'Lunas', '2025-08', NULL),
(131, 60, 80, 'Cash', 120000, 'Pembayaran bulan 2025-12', '2025-07-10 19:11:29', 'Menunggu Konfirmasi', '2025-12', NULL),
(132, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-10', '2025-07-10 20:12:24', 'Menunggu Konfirmasi', '2025-10', NULL),
(133, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-10', '2025-07-10 20:12:33', 'Menunggu Konfirmasi', '2025-10', NULL),
(134, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-11', '2025-07-10 20:13:52', 'Menunggu Konfirmasi', '2025-11', NULL),
(135, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-10', '2025-07-10 20:14:08', 'Menunggu Konfirmasi', '2025-10', NULL),
(136, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-11', '2025-07-10 21:13:20', 'Menunggu Konfirmasi', '2025-11', NULL),
(137, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-10', '2025-07-10 21:13:42', 'Menunggu Konfirmasi', '2025-10', NULL),
(138, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-10', '2025-07-10 21:14:13', 'Menunggu Konfirmasi', '2025-10', NULL),
(139, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-09', '2025-07-10 21:50:32', 'Menunggu Konfirmasi', '2025-09', 'uploads/686fd33c95ef7_1.jpg'),
(140, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-09', '2025-07-10 22:54:44', 'Menunggu Konfirmasi', '2025-09', 'uploads/686fe2484a48a_1.jpg'),
(141, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-09', '2025-07-10 22:56:42', 'Menunggu Konfirmasi', '2025-09', 'uploads/686fe2bed2e75_3.jpg'),
(146, 68, 89, 'Transfer', 150000, '', '2025-07-10 23:25:05', 'Menunggu Konfirmasi', '2025-07', 'uploads/686fe96646d09_jaringan.png'),
(151, 60, 80, 'Transfer', 120000, 'Pembayaran bulan 2025-10', '2025-07-10 23:28:47', 'Menunggu Konfirmasi', '2025-10', 'uploads/686fea43662fd_bg.jpg'),
(152, 70, 91, 'Transfer', 135000, '', '2025-07-11 05:50:42', 'Lunas', '2025-07', 'uploads/687043cc61943_Screenshot (12).png'),
(154, 72, 94, 'Transfer', 800000, '', '2025-07-11 23:27:54', 'Lunas', '2025-07', 'uploads/68713b8fc015f_bg.jpg'),
(155, 73, 95, 'Transfer', 300000, '', '2025-07-12 15:27:46', 'Lunas', '2025-07', 'uploads/68721c8820a19_8.jpg'),
(156, 73, 95, 'Cash', 2500000, 'Pembayaran bulan 2025-08', '2025-07-12 15:29:12', 'Lunas', '2025-08', NULL),
(157, 73, 95, 'Transfer', 2500000, 'Pembayaran bulan 2025-08', '2025-07-12 15:29:17', 'Lunas', '2025-08', 'uploads/68721ce2d33fd_jaringan.png'),
(158, 73, 95, 'Cash', 2500000, 'Pembayaran bulan 2025-10', '2025-07-12 15:36:48', 'Lunas', '2025-10', NULL),
(159, 73, 95, 'Transfer', 2500000, 'Pembayaran bulan 2025-09', '2025-07-12 16:11:14', 'Lunas', '2025-09', 'uploads/687226b674314_1.jpg'),
(160, 72, 94, 'Transfer', 750000, 'Pembayaran bulan 2025-08', '2025-07-15 15:55:24', 'Lunas', '2025-08', 'uploads/6876178565cfa_3.jpg'),
(161, 74, 96, 'Transfer', 50000, '', '2025-07-15 16:40:49', 'Menunggu Konfirmasi', '2025-07', NULL),
(162, 74, 96, 'Transfer', 150000, '', '2025-07-15 16:41:42', 'Lunas', '2025-07', 'uploads/68762284efcdc_ktp.jpg'),
(163, 74, 96, 'Cash', 130000, 'Pembayaran bulan 2025-08', '2025-07-15 16:46:30', 'Lunas', '2025-08', NULL),
(164, 76, 97, 'Transfer', 70000, '', '2025-07-30 09:48:41', 'Lunas', '2025-07', 'uploads/6889881551230_1.jpg'),
(165, 76, 97, 'Cash', 650000, 'Pembayaran bulan 2025-08', '2025-07-30 09:50:30', 'Menunggu Konfirmasi', '2025-08', NULL),
(166, 72, 94, 'Transfer', 750000, 'Pembayaran bulan 2025-09', '2025-07-30 10:13:46', 'Menunggu Konfirmasi', '2025-09', 'uploads/68898defce7e9_1.jpg'),
(167, 77, 98, 'Transfer', 100000, '', '2025-07-30 11:27:35', 'Lunas', '2025-07', 'uploads/68899f3e67e6b_1.jpg'),
(168, 77, 98, 'Transfer', 5000, 'Pembayaran bulan 2025-08', '2025-07-30 11:30:55', 'Menunggu Konfirmasi', '2025-08', NULL),
(169, 77, 98, 'Cash', 5000, 'Pembayaran bulan 2025-08', '2025-07-30 11:31:05', 'Menunggu Konfirmasi', '2025-08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id_pengeluaran` int(11) NOT NULL,
  `bulan` varchar(20) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengeluaran`
--

INSERT INTO `pengeluaran` (`id_pengeluaran`, `bulan`, `keterangan`, `jumlah`, `tanggal`) VALUES
(7, 'January 2025', 'lampu', 123000, '2025-07-07 06:57:30'),
(8, 'January 2025', 'da', 113, '2025-07-30 03:11:39'),
(9, 'January 2025', 'renovasi', 50000, '2025-07-30 04:36:04');

-- --------------------------------------------------------

--
-- Table structure for table `penghuni`
--

CREATE TABLE `penghuni` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telepon` varchar(20) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `tanggal_masuk` date DEFAULT NULL,
  `aktif` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penghuni`
--

INSERT INTO `penghuni` (`id`, `nama`, `alamat`, `email`, `telepon`, `username`, `password`, `tanggal_masuk`, `aktif`) VALUES
(64, 'donald', 'amerika', 'trump@gmail.com', '08277266391', 'trump', '$2y$10$YNdqEBQthEcBAzOEFKdLHe6hi/13Ap7fbn9zXrXGI1.ixRY5j2My6', '2025-06-29', 1),
(65, 'uus', 'loui', 'uus@kd.l', '092892', 'uus', '$2y$10$KrVYzJr9717eD5rm16.LYuTdSV9X7Z96FAf4mRNU33NFzW7g2YsSq', '2025-06-29', 1),
(73, 'aa', 'sari', 'aa@j.ll', '12345', 'aa', '$2y$10$3SntfOWfrYHK.gIbFqnXUenS8V81h1p753sBsDjcZIf.PLSutvjRW', '2025-07-05', 1),
(76, 'hana', 'karang', 'hana@j.d', '089939', 'hana', '$2y$10$T/s5wwnz.wIfS029knCAV.GWHZfZJY5rIsFj5e3pQ0btAKiaLx4Wy', '2025-07-07', 1),
(77, 'bb', 'abbb', 'bbb@sdd.j', '133232', 'bbbbb', '$2y$10$aAaEBs8j/zqxfq2c/KqVgOTA2SMUPPwKy2dHDU2nqNMVxqsBaduPK', '2025-07-07', 0),
(78, 'dadada', 'adada', 'aad@a.hd', '133223', 'sasdad', '$2y$10$KcCvlZKzoWicXgVAp3Q9h.A886gU45upBHeQcteIa7RNWJiMmp4D6', '2025-07-07', 0),
(79, 'subhan', 'karang', 'sbhan@L.S', '0899388', 'subhan', '$2y$10$HUEiuPm4CZiovirVzvrneO9t87gFB5MG08Y43HRrvrTY/KrnvzLBi', '2025-07-07', 1),
(80, 'kiki', 'cipasung', 'kiki2@k.l', '081992883', 'kiki', '$2y$10$2Zu//SdEMjSvVrEc.KA7SeU.zXtYbr7AJlTKIKdQ5h1dKvTVobf2G', '2025-07-07', 1),
(81, 'qqq', 'qqq', 'qqq@qwqw.ghh', '121323', 'dsscx', '$2y$10$10nW0dE5fqfx2g3vjs5OEeh2txyzLXoD7y/qpxZOEVrKKPt8ogN7i', '2025-07-07', 0),
(82, 'aan', 'kupang', 'aan@l.l', '089800131', 'aan', '$2y$10$gFIa5ixKO.6/A2bwoDlIhexGxtngSo5L4Iu9qg.w3SeTrFIVIfp9y', '2025-07-07', 1),
(83, 'baron', 'jambi', 'baron@gmail.com', '0891982920', 'baron', '$2y$10$rhsYC65rD.vb4nm0N.xKOONCwwz3G7MSicHbEh9DyEQKyJmP6UCru', '2025-07-07', 1),
(84, 'saasa', 'sasaa', 'saas@ffdf.ll', '121221213', 'ccxff', '$2y$10$ClDh57U4idGe.58HHCrLKuphqrPFTRYbVOa88TyyuFte4GLrsPmB.', '2025-07-07', 0),
(85, 'asas', 'aad', 'aad@wsfd.jfs', '123234', 'sfsfs', '$2y$10$IAdbNFElgq3/aZhNp/WsxuHq6CqpHIxEX4GnDVEEIx1eg6NBGD8ki', '2025-07-08', 0),
(86, 'maman', 'kupang', 'maan@l.sk', '0888138013', 'maman', '$2y$10$wVmehNNgwqZkGN1XCbZdNeqY4y8MP40mzhW3112wJ/M9l5TSiPcMG', '2025-07-08', 0),
(87, 'arya', 'cgl', 'arya@gmailc.o', '0819918289', 'arya', '$2y$10$Z2TvTuMimXiM4DRAZAY0weg2YxxNH7MXEn4WT5pRrZJUeAUmPZssy', '2025-07-08', 1),
(88, 'awal', 'bandung', 'awal@ks.l', '09328983', 'awal', '$2y$10$LbKwUiblT0y8itwT/bAhFurTCDJk5yFpW/VTO7AuYI7PWWyFH8b5S', '2025-07-10', 1),
(89, 'akhir', 'kida', 'akhir@jk.l', '093083', 'akhir', '$2y$10$ISdm67Y0FqKupi0gutR2/O6DhXZQqjbXmDAs1z3zHrjDSJNlUGdpi', '2025-07-10', 0),
(91, 'kalis', 'bekasi', 'kalis@gmail.com', '0819922889', 'kalis', '$2y$10$HXROqa.zjcMbMsXFyKRA6O.CRJj6Ej51myctLBe0w7I30HrM85qEi', '2025-07-11', 1),
(94, 'rijal', 'tasik', 'rijal@k.l', '09989892', 'rijal', '$2y$10$Jkkue86t1tnoEvdPD8j/fuLymEMTzzpCIJlfVdg/JWFKBf2XqHLJ6', '2025-07-11', 1),
(95, 'salma', 'tasik', 'salma@k.l', '088299288', 'salma', '$2y$10$k1Rt/rpD3DkY3/xyBVSLae9Xz6.JQz0js5bsiv.IyN3QQXt5.aJ9u', '2025-07-12', 1),
(96, 'jaed', 'kupang', 'JAED@gmail.com', '088838383', 'jaed', '$2y$10$br9McHkeNENWxsylgnNrYONS5KdEQS2lOGoSSFOdaiy0KPY476CDy', '2025-07-15', 1),
(97, 'eman', 'cipasung', 'eman@gmail.com', '08198927893', 'eman', '$2y$10$v5Oq/aD0C8UIIYn41mKG/Oj/6f44le2PAiU79BsxUF80GWn.tBy8e', '2025-07-30', 1),
(98, 'dede', 'tasikmalaya', 'dd@gmail.com', '08154648748734', 'dede', '$2y$10$YoxwRHRhBG9CceiQlAm.5.c27vZMt2xLfULQ4QLneqW3YyVnYgp3u', '2025-07-30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `permintaan_berhenti`
--

CREATE TABLE `permintaan_berhenti` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_penghuni` int(10) UNSIGNED NOT NULL,
  `alasan` text NOT NULL,
  `status` enum('Menunggu','Dikonfirmasi','Ditolak') NOT NULL DEFAULT 'Menunggu',
  `tanggal` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permintaan_berhenti`
--

INSERT INTO `permintaan_berhenti` (`id`, `id_penghuni`, `alasan`, `status`, `tanggal`) VALUES
(2, 82, 'Berhenti oleh penghuni', 'Menunggu', '2025-07-07 19:35:26'),
(5, 80, 'Berhenti oleh penghuni', 'Menunggu', '2025-07-07 19:57:33'),
(6, 83, 'Berhenti oleh penghuni', 'Menunggu', '2025-07-07 20:43:23'),
(7, 94, 'Berhenti oleh penghuni', 'Menunggu', '2025-07-15 15:56:36'),
(8, 97, 'Berhenti oleh penghuni', 'Menunggu', '2025-07-30 09:51:16');

-- --------------------------------------------------------

--
-- Table structure for table `permintaan_pindah`
--

CREATE TABLE `permintaan_pindah` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_penghuni` int(10) UNSIGNED NOT NULL,
  `alasan` text NOT NULL,
  `status` enum('Menunggu','Dikonfirmasi','Ditolak') DEFAULT 'Menunggu',
  `tanggal` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permintaan_pindah`
--

INSERT INTO `permintaan_pindah` (`id`, `id_penghuni`, `alasan`, `status`, `tanggal`) VALUES
(2, 82, 'gerah', 'Menunggu', '2025-07-07 19:32:50'),
(3, 80, 'bau selokan', 'Menunggu', '2025-07-07 19:46:40'),
(4, 83, 'tidak betah bau sampah', 'Menunggu', '2025-07-07 20:43:17'),
(5, 94, 'bau', 'Menunggu', '2025-07-11 23:31:16'),
(6, 94, 'gak betah', 'Menunggu', '2025-07-15 15:56:29'),
(7, 97, 'hujan deras , banjir', 'Menunggu', '2025-07-30 09:51:07'),
(8, 98, 'lampu mati', 'Menunggu', '2025-07-30 11:32:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_sewa`
--
ALTER TABLE `data_sewa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sewa_kost` (`id_kost`),
  ADD KEY `idx_penghuni` (`id_penghuni`);

--
-- Indexes for table `informasi_umum`
--
ALTER TABLE `informasi_umum`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kategori` (`kategori`);

--
-- Indexes for table `komplain`
--
ALTER TABLE `komplain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penghuni` (`id_penghuni`);

--
-- Indexes for table `kost`
--
ALTER TABLE `kost`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kamar` (`kamar`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penghuni` (`id_penghuni`),
  ADD KEY `idx_id_ref` (`id_ref`);

--
-- Indexes for table `notifikasi_penghuni`
--
ALTER TABLE `notifikasi_penghuni`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sewa` (`id_sewa`),
  ADD KEY `id_penghuni` (`id_penghuni`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id_pengeluaran`);

--
-- Indexes for table `penghuni`
--
ALTER TABLE `penghuni`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `permintaan_berhenti`
--
ALTER TABLE `permintaan_berhenti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penghuni` (`id_penghuni`);

--
-- Indexes for table `permintaan_pindah`
--
ALTER TABLE `permintaan_pindah`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penghuni` (`id_penghuni`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_sewa`
--
ALTER TABLE `data_sewa`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `informasi_umum`
--
ALTER TABLE `informasi_umum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `komplain`
--
ALTER TABLE `komplain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `kost`
--
ALTER TABLE `kost`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT for table `notifikasi_penghuni`
--
ALTER TABLE `notifikasi_penghuni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id_pengeluaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `penghuni`
--
ALTER TABLE `penghuni`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `permintaan_berhenti`
--
ALTER TABLE `permintaan_berhenti`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `permintaan_pindah`
--
ALTER TABLE `permintaan_pindah`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `data_sewa`
--
ALTER TABLE `data_sewa`
  ADD CONSTRAINT `fk_sewa_kost` FOREIGN KEY (`id_kost`) REFERENCES `kost` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sewa_penghuni` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `komplain`
--
ALTER TABLE `komplain`
  ADD CONSTRAINT `komplain_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id`);

--
-- Constraints for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD CONSTRAINT `notifikasi_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_sewa`) REFERENCES `data_sewa` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permintaan_berhenti`
--
ALTER TABLE `permintaan_berhenti`
  ADD CONSTRAINT `permintaan_berhenti_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permintaan_pindah`
--
ALTER TABLE `permintaan_pindah`
  ADD CONSTRAINT `permintaan_pindah_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
