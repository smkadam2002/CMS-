-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2024 at 07:04 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cms`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cat_id` int(3) NOT NULL,
  `cat_title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_title`) VALUES
(1, 'HTML'),
(2, 'CSS'),
(3, 'JavaScript'),
(4, 'jQuery'),
(5, 'PHP'),
(6, 'Ajax');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `comment_post_id` int(11) NOT NULL,
  `comment_author` varchar(255) NOT NULL,
  `comment_email` varchar(255) NOT NULL,
  `comment_content` text NOT NULL,
  `comment_status` varchar(255) NOT NULL,
  `comment_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `comment_post_id`, `comment_author`, `comment_email`, `comment_content`, `comment_status`, `comment_date`) VALUES
(2, 1, 'Bharati', 'bharti@gmail.com', 'Nice post !', 'approved', '2024-02-07'),
(3, 3, 'neha', 'neha@gmail.com', 'Awesome ... !!!', 'unapproved', '2024-02-26');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`) VALUES
(1, 54, 1);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `post_category_id` int(11) NOT NULL,
  `post_title` varchar(255) NOT NULL,
  `post_author` varchar(255) NOT NULL,
  `post_user` varchar(255) NOT NULL,
  `post_date` date NOT NULL,
  `post_image` text NOT NULL,
  `post_content` text NOT NULL,
  `post_tags` varchar(255) NOT NULL,
  `post_comment_count` int(11) NOT NULL,
  `post_status` varchar(255) NOT NULL DEFAULT 'draft',
  `post_views_count` int(11) NOT NULL,
  `likes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `post_category_id`, `post_title`, `post_author`, `post_user`, `post_date`, `post_image`, `post_content`, `post_tags`, `post_comment_count`, `post_status`, `post_views_count`, `likes`) VALUES
(1, 1, 'HTML', '', 'shrawani', '2024-02-07', 'HTML.jpg', '<p>Hypertext Markup Language is the standard markup language for creating web pages and web applications. With Cascading Style Sheets and JavaScript, it forms a triad of cornerstone technologies for the World Wide Web.</p>', 'Hyper Text Markup Language, HTML, Language', 0, 'published', 101, 0),
(2, 2, 'CSS', '', 'shrawani', '2024-02-07', 'CSS.jpg', '<p>Cascading Style Sheets is a style sheet language used for describing the presentation of a document written in a markup language like HTML. CSS is a cornerstone technology of the World Wide Web, alongside HTML and JavaScript.</p>', 'cacading, styles, sheet, CSS, design', 0, 'published', 6, 0),
(3, 3, 'JavaScript', '', 'shrawani', '2024-02-07', 'cms3.jpg', '<p>JavaScript, often abbreviated as JS, is a high-level, interpreted programming language. It is a language which is also characterized as dynamic, weakly typed, prototype-based and multi-paradigm.</p>', 'js, javascript, animation, validation', 0, 'published', 5, 0),
(4, 4, 'jQuery', '', 'shrawani', '2024-02-07', 'JQUERY.png', '<p>jQuery is a cross-platform JavaScript library designed to simplify the client-side scripting of HTML. It is free, open-source software using the permissive MIT License.</p>', 'jQuery, front-end, minified, fast', 0, 'published', 8, 0),
(5, 5, 'PHP', '', 'Aditya', '2024-02-24', 'PHP.jpg', 'PHP: Hypertext Preprocessor is a server-side scripting language designed for web development but also used as a general-purpose programming language.', 'PHP, Hyper, Text, Pre Processor, Back-End, Programming, Language', 0, 'published', 7, 0),
(6, 6, 'Ajax', '', 'Aditya', '2024-02-12', 'ajax.png', '', 'ajax, aditya, web server', 0, 'published', 9, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_firstname` varchar(255) NOT NULL,
  `user_lastname` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_image` text NOT NULL,
  `user_role` varchar(255) NOT NULL,
  `randSalt` varchar(255) NOT NULL DEFAULT '$2y$10$iusesomecrazystrings22'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `user_firstname`, `user_lastname`, `user_email`, `user_image`, `user_role`, `randSalt`) VALUES
(50, 'Aditya', '$2y$12$0FXhfqD4pDHGwMz1z1WxcuMLhrEvSU.PvpSrVawrSm9Mgzy2AeolK', 'aditya', 'kadam', 'aditya@gmail.com', 'malelogo.jpg', 'Admin', '$2y$10$iusesomecrazystrings22'),
(53, 'bharti', '$2y$12$R0m9V2fZlW1utHh0ogEApupDzOzq8FP4boUMxxR3v9QLgk3isdr3O', 'bharati', '', 'bharti@gmail.com', 'logo.jpg', 'Subscriber', '$2y$10$iusesomecrazystrings22'),
(54, 'shrawani', '$2y$12$Hpl6fh9JTBtLHXFOeOZki.xqvFEoLGh80ySy6.6.IVePhdKdl6pqa', '', '', 'smkadam2002@gmail.com', '', 'Admin', '$2y$10$iusesomecrazystrings22'),
(56, 'neha', '$2y$12$D9drLKQ5niCwZeywGzHsjuxKGkc7m9tMcLOY7kWRMG8301JcJxvem', '', '', 'neha@gmail.com', '', 'Admin', '$2y$10$iusesomecrazystrings22'),
(58, 'shruu', '$2y$12$zbQY83V9yEjS0SFgfyIKJekrp4kzWbRUz9eSar..Yrz20zYaa8YJe', '', '', 'shruu@gmail.com', '', 'Subscriber', '$2y$10$iusesomecrazystrings22'),
(59, 'neharupesh', '$2y$12$wu1jS1dzio6CjPXhM4/s3.ndfXIdT6LuvhG02FbdZlf4ozGN93vsu', '', '', 'neharupesh@gmail.com', '', 'subscriber', '$2y$10$iusesomecrazystrings22'),
(61, 'sakshi', '$2y$12$/9GRyKE7V2QwKrdDu5/iXe.P8ES9eeujjp55mSp96NbUv/vhO0vw2', '', '', 'sakshi@gmail.com', '', 'Subscriber', '$2y$10$iusesomecrazystrings22');

-- --------------------------------------------------------

--
-- Table structure for table `users_online`
--

CREATE TABLE `users_online` (
  `id` int(11) NOT NULL,
  `session` varchar(255) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_online`
--

INSERT INTO `users_online` (`id`, `session`, `time`) VALUES
(1, 'pf2ovmbhtdn7dtrli83rjetlv6', 1525603889),
(2, 'g4eaojs9lup5uoi9clh0a7dlj2', 1525600070),
(3, 'u5b26mae8k9upvdf0loiv4qh80', 1525600816),
(4, '7dg0jaipc161dirait3omf4fk0', 1525603284),
(5, 'p9e0jf3ama3n4hvbp6eknime52', 1525603543),
(6, 'hqhn3mcl82dg0t12i01do5gkp2', 1525753912),
(7, 'krkd2v356t3jv5k5d2v6sa4om6', 1525837122),
(8, '04nli9lc34bfm8qnnbn0s47t63', 1525861608),
(9, 'drpe2pej7n3glgdkgltdu59ft1', 1525925780),
(10, 'nvqkpc95pdac56qmctcrm89jh0', 1526038120),
(11, '66isnml6mnu741n3r5q9s5m956', 1526200326),
(12, 'jdicp9b8bbek3opi4b7970lo02', 1526219068),
(13, '8o8u5o0gglhrok5fjobnrll0s0', 1526268404),
(14, 'ins7sdp4b5gbb079c4kv5hd734', 1526273159),
(15, 'rmtl5qd6uo6nadc4ql7fifcr47', 1526306904),
(16, '7d1vov1qav2kgbi18hrcgtcmd2', 1526312831),
(17, '7sjflm0u8i7qonakjs6341jdl1', 1526355967),
(18, '32hpoav8ksrhvi4qd7f5iisdh7', 1526395857),
(19, 'b51ki4eoffu1a3suqagcjcb662', 1526441933),
(20, 'ndlermkg270fbdi9rm6ecdjd8q', 1707309896),
(21, 'qve21sni75fp8qsqnt7fmuk0jq', 1707396632),
(22, '22s797hq03gn465tgc0e93o5dd', 1707465736),
(23, '5h7k38ac8nq6bkv803j1i9onrn', 1707550973),
(24, 'u4vuui8gtkplpsabi1ck9e6ncs', 1707724655),
(25, '73t1fp5qpgfhvu8h5f5crd3ags', 1707727469),
(26, 't3dvc9gah0vbta05559nqed3ap', 1707742153),
(27, 't0ajrecocf2p1al5jgu8ursd9j', 1707811335),
(28, 'ln85eb7iidrh45u6pi45312pvr', 1707897421),
(29, 'hjvufrg3jcfo01kvuh9h01qcv2', 1707983810),
(30, '1fdkfpglovc9cfe588aap0cnv8', 1707983810),
(31, 'f5mcnv7elfkdrbmnqhibue14du', 1707999044),
(32, '3r16qcpcq9rmlhomuspcker3u1', 1707991184),
(33, '5ediieliq8cpu3dvid1265q60f', 1708415023),
(34, 'av8ivblt0lsaum1vnh2i91cb9o', 1708425126),
(35, '592s1n2a5m3qe01o7gg29vantu', 1708502587),
(36, '94renv7eug0rbc3e20s6tiquu1', 1708587075),
(37, 'am7284tmne5m3gehi88onf1vgs', 1708603246),
(38, 'v3tof89g2ru7ai72njq71dicjh', 1708671532),
(39, 'u9tu9asq7l061224l58le8htvg', 1708753274),
(40, 'rmrbnvg9dokhcn8sors73o9e0f', 1708776184),
(41, '28n37mdp1glfhoqgk55d1tcbq1', 1708924743);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `users_online`
--
ALTER TABLE `users_online`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `users_online`
--
ALTER TABLE `users_online`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
