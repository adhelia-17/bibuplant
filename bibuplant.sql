-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Mar 2026 pada 02.54
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bibuplant`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `basis_pengetahuan`
--

CREATE TABLE `basis_pengetahuan` (
  `No` int(11) NOT NULL,
  `Kode_Penyakit` varchar(10) NOT NULL,
  `Kode_Gejala` varchar(10) NOT NULL,
  `bobot` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `basis_pengetahuan`
--

INSERT INTO `basis_pengetahuan` (`No`, `Kode_Penyakit`, `Kode_Gejala`, `bobot`) VALUES
(1, 'P01', 'G01', 5),
(2, 'P01', 'G02', 1),
(3, 'P01', 'G03', 3),
(4, 'P01', 'G04', 5),
(5, 'P01', 'G05', 3),
(6, 'P02', 'G06', 5),
(7, 'P02', 'G07', 3),
(8, 'P02', 'G08', 5),
(9, 'P02', 'G09', 1),
(10, 'P02', 'G10', 1),
(11, 'P03', 'G11', 5),
(12, 'P03', 'G12', 5),
(13, 'P03', 'G13', 3),
(14, 'P03', 'G14', 1),
(15, 'P04', 'G15', 5),
(16, 'P04', 'G16', 3),
(17, 'P04', 'G17', 3),
(18, 'P04', 'G18', 5),
(19, 'P04', 'G19', 1),
(20, 'P05', 'G20', 5),
(21, 'P05', 'G21', 1),
(22, 'P05', 'G22', 5),
(23, 'P05', 'G23', 3),
(24, 'P05', 'G24', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `gejala`
--

CREATE TABLE `gejala` (
  `Kode` varchar(5) NOT NULL,
  `Gejala` varchar(10000) NOT NULL,
  `Bobot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `gejala`
--

INSERT INTO `gejala` (`Kode`, `Gejala`, `Bobot`) VALUES
('G01', 'Terdapat lengkungan cekung berwarna gelap pada daun, batang, maupun buah', 5),
('G02', 'Daun menguning dan gugur', 1),
('G03', 'Kulit batang mengelupas', 3),
('G04', 'Bentuk buah tidak normal', 5),
('G05', 'Muncul bercak gelap pada buah, daun, atau batang', 3),
('G06', 'Batang lunak dan berair', 5),
('G07', 'Warna batang berubah menjadi kecoklatan', 3),
('G08', 'Muncul jamur pada batang', 5),
('G09', 'Kerontokan pada bagian tanaman', 1),
('G10', 'Daun menguning dan mudah rontok', 1),
('G11', 'Terdapat lapisan hitam pada daun', 5),
('G12', 'Daun tampak lengket dan kotor', 5),
('G13', 'Terdapat bercak putih pada bagian bawah daun', 3),
('G14', 'Pertumbuhan tanaman lambat', 1),
('G15', 'Bercak kuning atau orange pada tanaman', 5),
('G16', 'Daun keriput', 3),
('G17', 'Daun gugur lebih sering', 3),
('G18', 'Timbulnya pustula berwarna coklat atau oranye', 5),
('G19', 'Bunga tidak berkembang', 1),
('G20', 'Tanaman terlihat lemah', 5),
('G21', 'Terdapat retakan pada batang', 1),
('G22', 'Tanaman kering', 5),
('G23', 'Pangkal batang lembek', 3),
('G24', 'Bentuk daun tidak sempurna dengan perubahan warna menjadi gelap', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pencegahan`
--

CREATE TABLE `pencegahan` (
  `Kode` varchar(5) NOT NULL,
  `Pencegahan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pencegahan`
--

INSERT INTO `pencegahan` (`Kode`, `Pencegahan`) VALUES
('PG01', 'Memilih lokasi tanam dengan pencahayaan yang cukup dan sirkulasi udara baik'),
('PG02', 'Menjaga kebersihan alat pertanian dengan mencucinya setelah digunakan untuk menghindari penularan pe'),
('PG03', 'Menjaga kelembapan tanah agar tidak berlebihan untuk mencegah kondisi lembab'),
('PG04', 'Mengatur jarak tanam untuk meningkatkan sirkulasi udara di antara tanaman'),
('PG05', 'Rutin memeriksa tanaman untuk mendeteksi gejala awal antraknos'),
('PG06', 'Menghilangkan sisa-sisa tanaman yang terinfeksi setelah panen.'),
('PG07', 'Memilih lokasi tanam yang memiliki drainase baik untuk mencegah genangan air'),
('PG08', 'Rutin memeriksa kesehatan batang dan akar untuk mendeteksi gejala awal'),
('PG09', 'Mengatur kelembapan tanah sesuai kebutuhan tanaman agar tidak berlebih'),
('PG10', 'Menghindari penanaman tanaman berdekatan yang menyebabkan kerumunan'),
('PG11', 'Menghilangkan sisa-sisa tanaman yang sudah mati atau terinfeksi dari area tanam'),
('PG12', 'Menggunakan material mulsa untuk menjaga kelembapan tanah dan mengontrol gulma'),
('PG13', 'Menjaga kebersihan area tanam untuk menghindari akumulasi kotoran dan debu.'),
('PG14', 'Menghindari penyiraman di malam hari untuk mencegah kelembapan yang berlebihan'),
('PG15', 'Melakukan pemangkasan pada bagian dedaunan yang rimbun untuk meningkatkan cahaya'),
('PG16', 'Rutin membersihkan area kebun dari rumput dan sisa tanaman yang membusuk'),
('PG17', 'Menggunakan pestisida nabati secara rutin untuk mengendalikan hama yang memicu embun jelaga'),
('PG18', 'Rutin memeriksa tanaman untuk mendeteksi tanda-tanda awal embun jelaga'),
('PG19', 'Menerapkan rotasi tanaman untuk mengurangi risiko infeksi berulang'),
('PG20', 'Menghindari penyiraman dari atas untuk meminimalkan kelembapan pada daun'),
('PG21', 'Menghilangkan daun yang terinfeksi untuk mencegah penyebaran patogen'),
('PG22', 'Rutin membersihkan alat pertanian untuk mencegah penularan penyakit dari satu tanaman ke tanaman lai'),
('PG23', 'Menerapkan teknik pemangkasan untuk meningkatkan cahaya dan sirkulasi udara di dalam tanaman'),
('PG24', 'Mengatur sistem irigasi agar tidak terjadi genangan air'),
('PG25', 'Menjaga kebersihan area tanam dengan menghilangkan sisa-sisa tanaman yang membusuk'),
('PG26', 'Menggunakan mulsa untuk mengatur kelembapan tanah dan mengurangi kompetisi dari gulma'),
('PG27', 'Memastikan kualitas air irigasi agar tidak terkontaminasi patogen.'),
('PG28', 'Meningkatkan sirkulasi udara dengan memperhatikan jarak tanam yang ideal.'),
('PG29', 'Memberikan nutrisi yang cukup untuk memperkuat pertumbuhan dan ketahanan tanaman.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengguna`
--

CREATE TABLE `pengguna` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengguna`
--

INSERT INTO `pengguna` (`id`, `username`, `email`, `password`, `role`) VALUES
(1, 'admin', 'admin1@gmail.com', 'scrypt:32768:8:1$yxgzyAErSLcyA3yN$0d85b1fae29083b17b56f0c2fa58e043328cea2ed482cd87817bf34a683ed35f577e06082b0a467eb274ce59f4664c04b65820865ba216ca706aa2de460b7e47', 'admin'),
(2, 'imam', 'imamuldoenk214@gmail.com', 'scrypt:32768:8:1$TXMvwb4ARXuEv9ST$d20bf5fe36b0d50da3dad9fbb12af82497873e6962c38d8a623f4ae60d0c6fdc113972031d75c645d55df06f93f7014053375576dd460ca1aeb79123931af870', 'user'),
(3, 'chika', 'chikeunbyeol@gmail.com', 'scrypt:32768:8:1$R9ivyHpFZ79aIOOS$647017ac446a44b44317aeb8ac31fd70bcc0ac98d129c280dcc727c43222749a283495b27957570d5fb5089653795ca4a0d41253bc83198d6f4557e17ef808f0', 'user'),
(4, 'adhelia', 'adheliafradia60@gmail.com', 'scrypt:32768:8:1$cmGgXlODgF2VicmE$7fedb5e4406eb5c9b61bccdba65ad293b51f4d0c0014c77b531022c1c69ec01f9317aebe823c73d76513c418119002ec7e929c307f5589598a941e8b960fd1a9', 'user'),
(5, 'eko marwanto', 'ekomarwanto11@gmail.com', 'scrypt:32768:8:1$TVL7TD9Ofufx6jC7$09b39d0edcf01afe7fb503500d8d9ee49f4c7a638b9516df8d53b86c94c7ad091540ac37eb668b4402046c79e23eb9ab8db4ea6e9a612a1c31bd2b41ddf71c12', 'user');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengobatan`
--

CREATE TABLE `pengobatan` (
  `Kode` varchar(5) NOT NULL,
  `Pengobatan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengobatan`
--

INSERT INTO `pengobatan` (`Kode`, `Pengobatan`) VALUES
('PN01', 'Menggunakan fungisida berbahan aktif seperti propikonazol'),
('PN02', 'Memangkas bagian tanaman yang terinfeksi untuk mencegah penyebaran jamur'),
('PN03', 'Menggunakan larutan baking soda sebagai perawatan preventif.'),
('PN04', 'Mengatur kembali letak tanaman untuk mencegah akumulasi patogen'),
('PN05', 'Menggunakan mulsa untuk menjaga kelembapan tanah dan mencegah gulma.'),
('PN06', 'Menggunakan fungisida seperti klorotalonil atau metalaksil untuk mengatasi busuk batang'),
('PN07', 'Memangkas bagian batang yang terinfeksi untuk mencegah penyebaran jamur'),
('PN08', 'Mengatur drainase yang baik untuk menghindari genangan air di sekitar akar'),
('PN09', 'Menyemprotkan larutan Hidrogen Peroksida atau larutan Vanis (H2O2)'),
('PN10', 'Menghilangkan sisa tanaman yang membusuk di sekitar area kebun'),
('PN11', 'Menggunakan pestisida nabati seperti ekstrak neem untuk mengurangi hama yang berpotensi menginfeksi'),
('PN12', 'Menggunakan fungisida berbahan aktif seperti bikalutamid atau propikonazol'),
('PN13', 'Menggunakan larutan sabun insektisida untuk membersihkan daun yang terkena embun jelaga'),
('PN14', 'Meningkatkan sirkulasi udara di sekitar tanaman dengan mengatur jarak tanam'),
('PN15', 'Menggunakan pestisida nabati seperti ekstrak neem untuk mengendalikan hama yang menyebabkan embun je'),
('PN16', 'Rutin membersihkan daun dengan air bersih untuk menghilangkan lapisan hitam'),
('PN17', 'Menggunakan fungisida berbahan aktif seperti triadimefon atau chlorothalonil untuk mengatasi karat'),
('PN18', 'Memangkas daun yang terinfeksi untuk mencegah penyebaran penyakit ke bagian lain'),
('PN19', 'Menggunakan larutan sabun insektisida untuk membersihkan daun dari pustula'),
('PN20', 'Menggunakan ekstrak bawang sebagai pestisida nabati untuk mencegah infeksi'),
('PN21', 'Menggunakan fungisida berbahan aktif seperti metalaksil untuk mengatasi infeksi'),
('PN22', 'Memangkas bagian tanaman yang terinfeksi atau layu untuk mencegah penyebaran'),
('PN23', 'Mengatur kelembapan tanah agar tidak terlalu basah atau kering'),
('PN24', 'Meningkatkan drainase di sekitar akar untuk mencegah genangan air'),
('PN25', 'Menggunakan larutan nutrisi yang mengandung kalium untuk membantu pemulihan tanaman');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyakit`
--

CREATE TABLE `penyakit` (
  `Kode` varchar(5) NOT NULL,
  `Jenis_Penyakit` varchar(100) NOT NULL,
  `Deskripsi` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penyakit`
--

INSERT INTO `penyakit` (`Kode`, `Jenis_Penyakit`, `Deskripsi`) VALUES
('P01', 'Antraknosa', 'Antraknosa adalah penyakit tanaman akibat jamur Colletotrichum spp. Pada tanaman buah, penyakit ini berdampak langsung pada kualitas dan hasil panen. Infeksi menyebabkan munculnya bercak gelap pada kulit buah yang kemudian berkembang menjadi luka cekung dan busuk. Akibatnya, buah menjadi cacat, mudah rontok sebelum matang, cepat membusuk saat penyimpanan, dan tidak layak jual atau konsumsi.'),
('P02', 'Busuk Batang', 'Busuk batang adalah penyakit tanaman yang umumnya disebabkan oleh jamur patogen seperti Phytophthora atau Fusarium. Penyakit ini menyerang bagian batang, terutama di pangkal batang dekat permukaan tanah. Pada tanaman buah, busuk batang menyebabkan jaringan batang membusuk, melemah, dan menghambat aliran air serta nutrisi ke seluruh tanaman. Akibatnya, tanaman menjadi layu, pertumbuhan terganggu, daun menguning, buah tidak berkembang optimal, bahkan tanaman bisa mati sehingga menyebabkan penurunan hasil panen dan kerugian.'),
('P03', 'Embun Jelaga', 'Embun jelaga adalah penyakit tanaman yang ditandai dengan lapisan hitam seperti jelaga pada daun, batang, atau buah akibat pertumbuhan jamur di atas embun madu yang dihasilkan oleh hama. Pada tanaman buah, penyakit ini menghambat fotosintesis sehingga pertumbuhan tanaman terganggu, serta menurunkan kualitas dan mengganggu estetika tanaman karena tampilannya menjadi kotor dan tidak menarik.'),
('P04', 'Karat', 'Karat adalah penyakit tanaman yang disebabkan oleh jamur patogen yang menimbulkan bercak atau bintik berwarna kuning, cokelat, hingga kemerahan seperti karat pada daun, batang, atau buah. Pada tanaman buah, penyakit ini mengganggu proses fotosintesis, menyebabkan daun mengering dan gugur, sehingga pertumbuhan tanaman melemah dan produksi serta kualitas buah menurun.'),
('P05', 'Penyakit Layu', 'Penyakit layu adalah gangguan pada tanaman yang umumnya disebabkan oleh jamur atau bakteri yang menyerang jaringan pembuluh. Pada tanaman buah, penyakit ini menyebabkan tanaman tampak layu meskipun cukup air, daun menguning dan rontok, pertumbuhan terhambat, serta produksi buah menurun, bahkan dapat menyebabkan tanaman mati jika serangan parah.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyakit_pencegahan`
--

CREATE TABLE `penyakit_pencegahan` (
  `id` int(11) NOT NULL,
  `kode_penyakit` varchar(5) DEFAULT NULL,
  `kode_pencegahan` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penyakit_pencegahan`
--

INSERT INTO `penyakit_pencegahan` (`id`, `kode_penyakit`, `kode_pencegahan`) VALUES
(1, 'P01', 'PG01'),
(2, 'P01', 'PG02'),
(3, 'P01', 'PG03'),
(4, 'P01', 'PG04'),
(5, 'P01', 'PG05'),
(6, 'P01', 'PG06'),
(7, 'P02', 'PG07'),
(8, 'P02', 'PG08'),
(9, 'P02', 'PG09'),
(10, 'P02', 'PG10'),
(11, 'P02', 'PG11'),
(12, 'P02', 'PG12'),
(13, 'P03', 'PG13'),
(14, 'P03', 'PG14'),
(15, 'P03', 'PG15'),
(16, 'P03', 'PG16'),
(17, 'P03', 'PG17'),
(18, 'P03', 'PG18'),
(19, 'P03', 'PG19'),
(20, 'P04', 'PG20'),
(21, 'P04', 'PG21'),
(22, 'P04', 'PG22'),
(23, 'P04', 'PG23'),
(24, 'P05', 'PG24'),
(25, 'P05', 'PG25'),
(26, 'P05', 'PG26'),
(27, 'P05', 'PG27'),
(28, 'P05', 'PG28'),
(29, 'P05', 'PG29');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyakit_pengobatan`
--

CREATE TABLE `penyakit_pengobatan` (
  `id` int(11) NOT NULL,
  `kode_penyakit` varchar(5) DEFAULT NULL,
  `kode_pengobatan` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penyakit_pengobatan`
--

INSERT INTO `penyakit_pengobatan` (`id`, `kode_penyakit`, `kode_pengobatan`) VALUES
(4, 'P01', 'PN01'),
(5, 'P01', 'PN02'),
(6, 'P01', 'PN03'),
(7, 'P01', 'PN04'),
(8, 'P01', 'PN05'),
(9, 'P02', 'PN06'),
(10, 'P02', 'PN07'),
(11, 'P02', 'PN08'),
(12, 'P02', 'PN09'),
(13, 'P02', 'PN10'),
(14, 'P02', 'PN11'),
(15, 'P03', 'PN12'),
(16, 'P03', 'PN13'),
(17, 'P03', 'PN14'),
(18, 'P03', 'PN15'),
(19, 'P03', 'PN16'),
(20, 'P04', 'PN17'),
(21, 'P04', 'PN18'),
(22, 'P04', 'PN19'),
(23, 'P04', 'PN20'),
(24, 'P05', 'PN21'),
(25, 'P05', 'PN22'),
(26, 'P05', 'PN23'),
(27, 'P05', 'PN24'),
(28, 'P05', 'PN25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `riwayat_pengguna`
--

CREATE TABLE `riwayat_pengguna` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `tanggal` datetime DEFAULT current_timestamp(),
  `gejala` text DEFAULT NULL,
  `kode_penyakit` varchar(10) DEFAULT NULL,
  `similarity` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `riwayat_pengguna`
--

INSERT INTO `riwayat_pengguna` (`id`, `user_id`, `username`, `tanggal`, `gejala`, `kode_penyakit`, `similarity`) VALUES
(1, 5, 'eko marwanto', '2026-02-12 11:31:51', 'G01,G02,G05,G11,G12', 'P03', 71.43),
(2, 5, 'eko marwanto', '2026-02-12 11:32:21', 'G03,G06,G07,G21,G23', 'P02', 53.33),
(3, 5, 'eko marwanto', '2026-02-12 11:32:56', 'G02,G09,G10,G17,G20', 'P05', 29.41),
(4, 5, 'eko marwanto', '2026-02-12 11:33:31', 'G05,G11,G13,G15,G18', 'P04', 58.82),
(5, 5, 'eko marwanto', '2026-02-12 11:34:03', 'G06,G07,G20,G21,G23', 'P02', 53.33),
(6, 5, 'eko marwanto', '2026-02-12 11:34:45', 'G01,G03,G04,G05,G24', 'P01', 94.12),
(7, 5, 'eko marwanto', '2026-02-12 11:35:28', 'G06,G07,G08,G21,G23', 'P02', 86.67),
(8, 5, 'eko marwanto', '2026-02-12 11:36:01', 'G02,G09,G10,G17,G20', 'P05', 29.41),
(9, 5, 'eko marwanto', '2026-02-12 11:36:29', 'G01,G04,G05,G11,G12', 'P01', 76.47),
(10, 5, 'eko marwanto', '2026-02-12 11:37:02', 'G13,G14,G15,G18,G20', 'P04', 58.82),
(11, 5, 'eko marwanto', '2026-02-12 11:44:13', 'G03,G06,G07,G21,G23', 'P02', 53.33),
(12, 5, 'eko marwanto', '2026-02-12 11:44:57', 'G02,G10,G17,G19,G20', 'P05', 29.41),
(13, 5, 'eko marwanto', '2026-02-12 11:45:24', 'G01,G04,G05,G11,G24', 'P01', 76.47),
(14, 5, 'eko marwanto', '2026-02-12 11:46:03', 'G06,G07,G08,G21,G23', 'P02', 86.67),
(15, 5, 'eko marwanto', '2026-02-12 11:49:21', 'G05,G12,G13,G15,G18', 'P04', 58.82),
(16, 5, 'eko marwanto', '2026-02-12 11:50:31', 'G11,G12,G13,G19,G24', 'P03', 92.86),
(17, 5, 'eko marwanto', '2026-02-20 10:46:18', 'G11,G12,G13,G14', 'P03', 100),
(18, 5, 'eko marwanto', '2026-02-23 11:12:38', 'G14,G17,G19,G20,G23', 'P05', 47.06),
(19, 5, 'eko marwanto', '2026-02-23 11:15:22', 'G02,G04,G10,G15,G16,G18,G19', 'P04', 82.35),
(20, 5, 'eko marwanto', '2026-02-23 11:15:45', 'G02,G19,G20,G21,G22', 'P05', 64.71),
(21, 5, 'eko marwanto', '2026-02-23 11:17:05', 'G04,G05,G07,G08,G11,G12,G13', 'P03', 92.86),
(22, 5, 'eko marwanto', '2026-02-23 11:19:41', 'G01,G02,G04,G17,G19,G22', 'P01', 64.71),
(23, 5, 'eko marwanto', '2026-02-23 11:20:02', 'G08,G10,G11,G12,G13', 'P03', 92.86),
(24, 5, 'eko marwanto', '2026-02-23 11:22:14', 'G12,G13,G14,G15,G16', 'P03', 64.29),
(25, 5, 'eko marwanto', '2026-02-23 11:23:46', 'G16,G19,G22,G23,G24', 'P05', 64.71),
(26, 5, 'eko marwanto', '2026-02-23 11:24:08', 'G17,G19,G20,G23', 'P05', 47.06);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `basis_pengetahuan`
--
ALTER TABLE `basis_pengetahuan`
  ADD PRIMARY KEY (`No`),
  ADD KEY `Kode_Penyakit` (`Kode_Penyakit`),
  ADD KEY `Kode_Gejala` (`Kode_Gejala`);

--
-- Indeks untuk tabel `gejala`
--
ALTER TABLE `gejala`
  ADD PRIMARY KEY (`Kode`);

--
-- Indeks untuk tabel `pencegahan`
--
ALTER TABLE `pencegahan`
  ADD PRIMARY KEY (`Kode`);

--
-- Indeks untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `pengobatan`
--
ALTER TABLE `pengobatan`
  ADD PRIMARY KEY (`Kode`);

--
-- Indeks untuk tabel `penyakit`
--
ALTER TABLE `penyakit`
  ADD PRIMARY KEY (`Kode`);

--
-- Indeks untuk tabel `penyakit_pencegahan`
--
ALTER TABLE `penyakit_pencegahan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kode_penyakit` (`kode_penyakit`),
  ADD KEY `kode_pencegahan` (`kode_pencegahan`);

--
-- Indeks untuk tabel `penyakit_pengobatan`
--
ALTER TABLE `penyakit_pengobatan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kode_penyakit` (`kode_penyakit`),
  ADD KEY `kode_pengobatan` (`kode_pengobatan`);

--
-- Indeks untuk tabel `riwayat_pengguna`
--
ALTER TABLE `riwayat_pengguna`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `basis_pengetahuan`
--
ALTER TABLE `basis_pengetahuan`
  MODIFY `No` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `penyakit_pencegahan`
--
ALTER TABLE `penyakit_pencegahan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT untuk tabel `penyakit_pengobatan`
--
ALTER TABLE `penyakit_pengobatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `riwayat_pengguna`
--
ALTER TABLE `riwayat_pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `basis_pengetahuan`
--
ALTER TABLE `basis_pengetahuan`
  ADD CONSTRAINT `basis_pengetahuan_ibfk_1` FOREIGN KEY (`Kode_Penyakit`) REFERENCES `penyakit` (`Kode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `basis_pengetahuan_ibfk_2` FOREIGN KEY (`Kode_Gejala`) REFERENCES `gejala` (`Kode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `penyakit_pencegahan`
--
ALTER TABLE `penyakit_pencegahan`
  ADD CONSTRAINT `penyakit_pencegahan_ibfk_1` FOREIGN KEY (`kode_penyakit`) REFERENCES `penyakit` (`Kode`),
  ADD CONSTRAINT `penyakit_pencegahan_ibfk_2` FOREIGN KEY (`kode_pencegahan`) REFERENCES `pencegahan` (`Kode`);

--
-- Ketidakleluasaan untuk tabel `penyakit_pengobatan`
--
ALTER TABLE `penyakit_pengobatan`
  ADD CONSTRAINT `penyakit_pengobatan_ibfk_1` FOREIGN KEY (`kode_penyakit`) REFERENCES `penyakit` (`Kode`),
  ADD CONSTRAINT `penyakit_pengobatan_ibfk_2` FOREIGN KEY (`kode_pengobatan`) REFERENCES `pengobatan` (`Kode`);

--
-- Ketidakleluasaan untuk tabel `riwayat_pengguna`
--
ALTER TABLE `riwayat_pengguna`
  ADD CONSTRAINT `riwayat_pengguna_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `pengguna` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
