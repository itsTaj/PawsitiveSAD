-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 01, 2025 at 01:09 PM
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
-- Database: `pawsitive`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `password`) VALUES
(1, 'sumaiyalima@gmail.com', '$2y$10$2cvvQgl6XLUrp3dLoFmMReEQL37Bxpr.0EKRdetgmUrp5QSdjTGVi');

-- --------------------------------------------------------

--
-- Table structure for table `adopters`
--

CREATE TABLE `adopters` (
  `a_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `preferences` text NOT NULL,
  `adoption_date` date NOT NULL,
  `experience` text NOT NULL,
  `address` varchar(255) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adopters`
--

INSERT INTO `adopters` (`a_id`, `name`, `phone_number`, `email`, `preferences`, `adoption_date`, `experience`, `address`, `status`) VALUES
(9, 'sumaiya', '01861666884', 'sumaiya@gmail.com', 'Bichon Frise', '2024-10-03', 'yes', 'Dhaka', 'approved'),
(10, 'limaa', '01861666884', 'lima@gmail.com', 'Bichon Frise', '2024-10-03', 'no', 'Barishal', 'approved'),
(11, 'sristy', '01569108045', 'sristy@gmail.com', 'Budgerigar', '2024-10-04', 'yes', 'Dhaka', 'approved'),
(14, 'sristy', '01569108045', 'mina@gmail.com', 'Poodle', '2023-10-04', 'no', 'Chittagong', 'approved'),
(15, 'khushbu', '234455555', 'khushbu@gmail.com', 'Budgerigar', '2024-10-10', 'i have no experience', 'Dhaka', 'approved'),
(20, 'minaas', '01569108045', 'llll@gmail.com', 'Exotic Shorthair', '2024-10-06', 'no', 'Rajshahi', 'approved'),
(21, 'minaas', '01569108045', 'lalala@gmail.com', 'Budgerigar', '2024-10-06', 'yes', 'Barishal', 'approved'),
(23, 'sristy', '01569108045', 'aabdc@gmail.com', 'Budgerigar', '2024-10-11', 'yes', 'Rajshahi', 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(11) NOT NULL,
  `adopter_email` varchar(255) NOT NULL,
  `certificate_number` varchar(50) NOT NULL,
  `date_of_issue` date NOT NULL,
  `pet_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `certificates`
--

INSERT INTO `certificates` (`id`, `adopter_email`, `certificate_number`, `date_of_issue`, `pet_name`, `file_path`, `created_at`) VALUES
(7, 'sumaiya@gmail.com', 'CERT_66fe8dbcbabcf', '2024-10-03', '', '', '2024-10-03 12:27:40'),
(8, 'sumaiya@gmail.com', 'CERT_66fe8dedf11ad', '2024-10-03', '', '', '2024-10-03 12:28:29'),
(9, 'lima@gmail.com', 'CERT_66fe930c21906', '2024-10-03', '', '', '2024-10-03 12:50:20'),
(10, 'lima@gmail.com', 'CERT_66fe933551d63', '2024-10-03', '', '', '2024-10-03 12:51:01'),
(11, 'sristy@gmail.com', 'CERT_66ff98915711c', '2024-10-04', '', '', '2024-10-04 07:26:09'),
(12, 'sristy@gmail.com', 'CERT_66ff98a84dac9', '2024-10-04', '', '', '2024-10-04 07:26:32'),
(13, 'mina@gmail.com', 'CERT_66fff5c2522ac', '2023-10-04', '', '', '2024-10-04 14:03:46'),
(14, 'mina@gmail.com', 'CERT_66fff5dccc269', '2023-10-04', '', '', '2024-10-04 14:04:12'),
(15, 'khushbu@gmail.com', 'CERT_670253c101160', '2024-10-10', '', '', '2024-10-06 09:09:21'),
(16, 'khushbu@gmail.com', 'CERT_670254909ddac', '2024-10-10', '', '', '2024-10-06 09:12:48'),
(17, 'llll@gmail.com', 'CERT_67026c52ee541', '2024-10-06', '', '', '2024-10-06 10:54:10'),
(18, 'lalala@gmail.com', 'CERT_67026d9e0f3a6', '2024-10-06', '', '', '2024-10-06 10:59:42'),
(19, 'llll@gmail.com', 'CERT_67060c155ab5a', '2024-10-06', '', '', '2024-10-09 04:52:37'),
(20, 'lalala@gmail.com', 'CERT_670807177f9f0', '2024-10-06', '', '', '2024-10-10 16:55:51'),
(21, 'aabdc@gmail.com', 'CERT_670928a52e1a4', '2024-10-11', '', '', '2024-10-11 13:31:17'),
(22, 'aabdc@gmail.com', 'CERT_67092ad37c825', '2024-10-11', '', '', '2024-10-11 13:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `competitions`
--

CREATE TABLE `competitions` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `location` varchar(255) NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `how_to_win` text DEFAULT NULL,
  `previous_winners` text DEFAULT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `competitions`
--

INSERT INTO `competitions` (`id`, `title`, `date`, `location`, `contact`, `how_to_win`, `previous_winners`, `image`) VALUES
(1, 'Annual Pet Talent Show', '2024-11-01', 'Pet Event Center, Cityname', '123-456-7890', 'Showcase your pet\'s best trick, behavior, or talent! Judges will be evaluating based on creativity, execution, and audience appeal.', 'Winner 2023: Bella the Beagle - Best trick: balancing 5 balls.', 'com.jpg'),
(2, 'Pet Fashion Parade', '0000-00-00', 'Downtown Plaza, Cityname', '+8801568754631', 'Dress up your pets in their fanciest costumes. Judges will be scoring based on originality, detail, and pet comfort.', 'Winner 2023: Max the Poodle - Best Costume: Superhero Outfit.', 'compi.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `contact_info`
--

CREATE TABLE `contact_info` (
  `id` int(11) NOT NULL,
  `contact_type` enum('phone','email','facebook') NOT NULL,
  `contact_value` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_info`
--

INSERT INTO `contact_info` (`id`, `contact_type`, `contact_value`, `created_at`) VALUES
(1, 'phone', '0186166884', '2024-10-03 05:37:45'),
(2, 'email', 'sumaiyalima789@gmail.com', '2024-10-03 05:37:45'),
(3, 'facebook', 'https://www.facebook.com/sumaiya.lima.25', '2024-10-03 05:37:45'),
(4, 'phone', '01569108045', '2024-10-03 05:37:45'),
(5, 'email', 'msristy221447@bscse.uiu.ac.bd', '2024-10-03 05:37:45'),
(6, 'facebook', 'https://www.facebook.com/mahmudaakter.sristy', '2024-10-03 05:37:45'),
(7, 'phone', '01745531727', '2024-10-03 05:37:45'),
(8, 'email', 'mdalmahfuzchowdhury@gmail.com', '2024-10-03 05:37:45'),
(9, 'facebook', 'https://www.facebook.com/siam.mahfuz.7', '2024-10-03 05:37:45');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `created_at`) VALUES
(1, 'How do I adopt a pet?', 'You can browse the pets available for adoption and submit an adoption request.', '2024-10-03 05:37:45'),
(2, 'What is the adoption fee?', 'The adoption fee varies depending on the pet. Please contact us for more details.', '2024-10-03 05:37:45'),
(3, 'How long does the adoption process take?', 'The adoption process typically takes between 2-5 days, depending on the pet and the application.', '2024-10-03 05:37:45'),
(4, 'Can I return a pet if it doesn’t fit in?', 'While we do our best to match pets with the right owners, we understand things happen. Please contact us for returns.', '2024-10-03 05:37:45'),
(5, 'Do you offer support after adoption?', 'Yes, we offer post-adoption support through our network of veterinarians and trainers.', '2024-10-03 05:37:45');

-- --------------------------------------------------------

--
-- Table structure for table `parks`
--

CREATE TABLE `parks` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parks`
--

INSERT INTO `parks` (`id`, `name`, `location`, `image`) VALUES
(1, 'Central Park', '123 Park Avenue, Cityname', 'park1.jpg'),
(2, 'Greenwood Park', '456 Green St, Cityname', 'park2.jpg'),
(3, 'Sunshine Park', '789 Sunshine Blvd, Cityname', 'park3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `pets1`
--

CREATE TABLE `pets1` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `breed` varchar(255) NOT NULL,
  `age` varchar(50) NOT NULL,
  `location` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `pet_size` varchar(255) NOT NULL,
  `fee` varchar(255) NOT NULL,
  `temp` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pets1`
--

INSERT INTO `pets1` (`id`, `name`, `breed`, `age`, `location`, `gender`, `pet_size`, `fee`, `temp`, `image_url`) VALUES
(1, 'Bella', 'Poodle', '3 years', 'Los Angeles', 'Male', 'Medium', '15k', 'Friendly', 'images/dogpod.png'),
(2, 'Max', 'Poodle', '2 years', 'New York', 'Male', 'Large', '25k', 'Energetic', 'images/poddle2.jpg'),
(3, 'Chini', 'Exotic Shorthair', '6 month', 'San Francisco', 'Female', 'Medium', '22k', 'Calm', 'images/catExo.png'),
(4, 'Mini', 'Exotic Shorthair', '1 year', 'San Francisco', 'Male', 'Medium', '16k', 'Friendly', 'images/exo2.jpg'),
(5, 'Leo', 'Budgerigar', '8 month', 'Pakistan', 'Female', 'Small', '18k', 'Energetic', 'images/birdBud.png'),
(6, 'Tweety', 'Budgerigar', '1.5 years', 'Pakistan', 'Female', 'Small', '12k', 'Friendly', 'images/bud2.jpg'),
(7, 'Johny', 'Bichon Frisé ', '2 years', 'Finland', 'Male', 'Large', '30k', 'Friendly', 'images/dog2.png'),
(8, 'Tommy', 'Bichon Frisé ', '2 years', 'Finland', 'Male', 'Medium', '20k', 'Energetic', 'images/bic2.jpg'),
(9, 'Anny', 'Norwegian Forest cat', '1 year', 'Norwegian ', 'Female', 'Medium', '18k', 'Calm', 'images/catNor.png'),
(10, 'Peanut', 'Norwegian Forest cat', '2 years', 'Norwegian ', 'Male', 'Small', '25k', 'Friendly', 'images/nor2.jpg'),
(11, 'Lanny', 'Cockatiel', '1.5 years', 'India', 'Female', 'Medium', '10k', 'Friendly', 'images/birdCok.png'),
(12, 'Pinni', 'Cockatiel', '5 months', 'India', 'Female', 'Small', '20k', 'Calm', 'images/cock2.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `date_posted` date DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `views` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `author`, `date_posted`, `category`, `tags`, `image_url`, `is_featured`, `views`) VALUES
(1, 'The Benefits of Pet Adoption', 'Adopting a pet saves lives...', 'John Doe', '2024-09-21', 'Pet Care', 'adoption, rescue', 'images/picpic.webp', 1, 0),
(2, 'How to Care for Your New Puppy', 'Caring for a new puppy...', 'Jane Smith', '2024-09-20', 'Pet Care', 'puppy, care', 'images/picpic2.jpg', 0, 0),
(3, 'Upcoming Shelter Events', 'Join us for our shelter event...', 'Shelter Team', '2024-09-18', 'Events', 'events, adoption', 'images/pipcpic3.jpg', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rehomers_application`
--

CREATE TABLE `rehomers_application` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `pet_choice` varchar(50) DEFAULT NULL,
  `pet_age` varchar(10) DEFAULT NULL,
  `pet_picture` varchar(255) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rehomers_application`
--

INSERT INTO `rehomers_application` (`id`, `name`, `email`, `phone`, `pet_choice`, `pet_age`, `pet_picture`, `approved`) VALUES
(1, 'sristy', 'sristy@gmail.com', '01861666884', 'cat', '2', 'images/cat.png', 1),
(2, 'lima', 'sristy@gmail.com', '01861666884', 'bird', '3', 'images/bird.png', 1),
(3, 'siam', 'sristy@gmail.com', '01861666884', 'dog', '1', 'images/bic2.jpg', 1),
(4, 'minaas', 'sristy@gmail.com', '01861666884', 'cat', '1', 'images/birdCok.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `temporary_housing`
--

CREATE TABLE `temporary_housing` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` text NOT NULL,
  `pet_type` enum('dog','cat','bird') NOT NULL,
  `pet_name` varchar(100) NOT NULL,
  `pet_breed` varchar(100) DEFAULT NULL,
  `pet_age` varchar(50) NOT NULL,
  `health_status` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `reason` text NOT NULL,
  `pet_picture` varchar(255) NOT NULL,
  `approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `temporary_housing`
--

INSERT INTO `temporary_housing` (`id`, `name`, `email`, `phone`, `address`, `pet_type`, `pet_name`, `pet_breed`, `pet_age`, `health_status`, `start_date`, `end_date`, `reason`, `pet_picture`, `approved`, `created_at`) VALUES
(1, 'sristy', 'sristy@gmail.com', '01861666884', 'dhaka', 'dog', 'kitty', 'poddle', '2', 'normal', '2024-10-07', '2024-10-10', 'I am going for treatment', 'images/bic2.jpg', 1, '2024-10-06 13:39:00'),
(2, 'khushbu', 'khushbu@gmail.com', '01861666884', 'dhaka', 'bird', 'kitty', 'parsian', '3', 'good', '2024-10-12', '2024-10-15', 'I am going for treatment\r\n', 'images/cock2.jpg', 0, '2024-10-11 13:38:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `profile_pic` varchar(255) DEFAULT 'uploads/default.png',
  `password` varchar(255) NOT NULL,
  `pet_type` varchar(100) DEFAULT NULL,
  `pet_picture` varchar(255) DEFAULT 'uploads/default_pet.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `profile_pic`, `password`, `pet_type`, `pet_picture`) VALUES
(1, '', 'lima@gmail.com', 'uploads/default.png', '$2y$10$OXhp5QiJQjLAdhJ7KdW9D.GAFFBuuzXXk30mLBpeXjoBgInf4hijW', NULL, 'uploads/default_pet.png'),
(2, '', 'afnan@gmail.com', 'uploads/default.png', '$2y$10$yjBPeQHJ600Eqn/8P.CC8OJiMWbkpI3vKy86i5/hxHNgIpuJ7Ag4q', NULL, 'uploads/default_pet.png'),
(3, '', 'sumaiya@gmail.com', 'uploads/default.png', '$2y$10$qhEPyYKGxSB9buu7RiEt9.K3b77V3o5itUYGZu27p6C4VvBH4Lt5q', NULL, 'uploads/default_pet.png'),
(4, '', 'sristy@gmail.com', 'uploads/default.png', '$2y$10$ubOWjPp1Dna/pU/TUJVuvunon1EyMAAH1q7GheAkT1pJavAe02ihi', NULL, 'uploads/default_pet.png');

-- --------------------------------------------------------

--
-- Table structure for table `user_pets`
--

CREATE TABLE `user_pets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pet_type` varchar(100) NOT NULL,
  `pet_picture` varchar(255) DEFAULT 'uploads/default_pet.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_posts`
--

CREATE TABLE `user_posts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `blog_post` text NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `date_submitted` datetime DEFAULT current_timestamp(),
  `approved` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_posts`
--

INSERT INTO `user_posts` (`id`, `name`, `email`, `blog_post`, `picture`, `date_submitted`, `approved`) VALUES
(1, 'siam', 'sristy@gmail.com', 'i want to post without image', 'images/birdBud.png', '2024-10-06 19:53:00', 1),
(2, 'sristy', 'sristy@gmail.com', 'bsghdhdgbfsfb', 'images/dog2.png', '2024-10-06 20:08:54', 1),
(3, 'sristy', 'sristy@gmail.com', 'i want to see the bird', 'images/bud2.jpg', '2024-10-06 20:36:33', 1),
(4, 'minaas', 'sristy@gmail.com', 'dfgedtjndgbsfbsfb', 'images/catExo.png', '2024-10-06 20:50:20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_questions`
--

CREATE TABLE `user_questions` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `question` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vets`
--

CREATE TABLE `vets` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `experience` int(11) NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vets`
--

INSERT INTO `vets` (`id`, `name`, `specialization`, `experience`, `contact`, `image`) VALUES
(1, 'Dr. Sarah Lee', 'Small Animal Surgery', 10, '017123549', 'vet1.jpg'),
(2, 'Dr. John Smith', 'Veterinary Dermatology', 8, '014502456', 'vet4.jpg'),
(3, 'Dr. Emily Davis', 'Animal Behavior', 12, '01569405075', 'vet2.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `vet_appointments`
--

CREATE TABLE `vet_appointments` (
  `id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `pet_name` varchar(100) NOT NULL,
  `vet_id` int(11) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `contact_info` varchar(50) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `time_slot` varchar(10) NOT NULL,
  `status` enum('pending','confirmed') DEFAULT 'pending',
  `admin_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vet_appointments`
--

INSERT INTO `vet_appointments` (`id`, `user_name`, `pet_name`, `vet_id`, `appointment_date`, `contact_info`, `email`, `time_slot`, `status`, `admin_message`) VALUES
(1, 'sristy', 'ululu', 1, '2024-10-04', '01861666884', 'sristy@gmail.com', '09:00', 'confirmed', NULL),
(2, 'sristy', 'ululu', 1, '2024-10-04', '01861666884', 'sristy@gmail.com', '10:00', 'confirmed', NULL),
(3, 'lima', 'kitty', 3, '2024-10-04', '01861666884', 'sristy@gmail.com', '13:00', 'confirmed', NULL),
(5, 'khushbu', 'Budgerigar', NULL, '2024-10-06', '234455555', 'khushbu@gmail.com', '10:00', 'confirmed', NULL),
(6, 'khushbu', 'Budgerigar', NULL, '2024-10-06', '234455555', 'khushbu@gmail.com', '10:00', 'confirmed', NULL),
(7, 'sristy', 'Budgerigar', NULL, '2024-10-07', '01569108045', 'sristy@gmail.com', '14:00', 'confirmed', NULL),
(8, 'sristy', 'Budgerigar', NULL, '2024-10-08', '01569108045', 'sristy@gmail.com', '10:00', 'confirmed', NULL),
(9, 'sristy', 'Budgerigar', NULL, '2024-10-08', '01569108045', 'sristy@gmail.com', '11:00', 'confirmed', NULL),
(10, 'sristy', 'Poodle', NULL, '2024-10-08', '01569108045', 'mina@gmail.com', '10:00', 'confirmed', NULL),
(11, 'sristy', 'Budgerigar', NULL, '2024-10-01', '01569108045', 'sristy@gmail.com', '09:00', 'confirmed', NULL),
(12, 'sristy', 'Budgerigar', NULL, '2024-10-12', '01569108045', 'sristy@gmail.com', '09:00', 'confirmed', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `adopters`
--
ALTER TABLE `adopters`
  ADD PRIMARY KEY (`a_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `certificate_number` (`certificate_number`),
  ADD KEY `adopter_email` (`adopter_email`);

--
-- Indexes for table `competitions`
--
ALTER TABLE `competitions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_info`
--
ALTER TABLE `contact_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parks`
--
ALTER TABLE `parks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pets1`
--
ALTER TABLE `pets1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rehomers_application`
--
ALTER TABLE `rehomers_application`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `temporary_housing`
--
ALTER TABLE `temporary_housing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_pets`
--
ALTER TABLE `user_pets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_posts`
--
ALTER TABLE `user_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_questions`
--
ALTER TABLE `user_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vets`
--
ALTER TABLE `vets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vet_appointments`
--
ALTER TABLE `vet_appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vet_id` (`vet_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `adopters`
--
ALTER TABLE `adopters`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `competitions`
--
ALTER TABLE `competitions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contact_info`
--
ALTER TABLE `contact_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `parks`
--
ALTER TABLE `parks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pets1`
--
ALTER TABLE `pets1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rehomers_application`
--
ALTER TABLE `rehomers_application`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `temporary_housing`
--
ALTER TABLE `temporary_housing`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_pets`
--
ALTER TABLE `user_pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_posts`
--
ALTER TABLE `user_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_questions`
--
ALTER TABLE `user_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vets`
--
ALTER TABLE `vets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vet_appointments`
--
ALTER TABLE `vet_appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_ibfk_1` FOREIGN KEY (`adopter_email`) REFERENCES `adopters` (`email`) ON DELETE CASCADE;

--
-- Constraints for table `user_pets`
--
ALTER TABLE `user_pets`
  ADD CONSTRAINT `user_pets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vet_appointments`
--
ALTER TABLE `vet_appointments`
  ADD CONSTRAINT `vet_appointments_ibfk_1` FOREIGN KEY (`vet_id`) REFERENCES `vets` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
