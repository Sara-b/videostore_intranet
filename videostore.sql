-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Jeu 05 Mars 2015 à 13:44
-- Version du serveur: 5.6.12-log
-- Version de PHP: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `videostore`
--
CREATE DATABASE IF NOT EXISTS `videostore` DEFAULT CHARACTER SET utf8 COLLATE utf8_roman_ci;
USE `videostore`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `copies`
--

CREATE TABLE IF NOT EXISTS `copies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_movie` int(11) NOT NULL,
  `id_store` int(11) NOT NULL,
  `id_format` int(11) NOT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_roman_ci NOT NULL DEFAULT 'Disponible',
  PRIMARY KEY (`id`),
  KEY `id_movie` (`id_movie`,`id_store`,`id_format`),
  KEY `id_movie_2` (`id_movie`,`id_store`,`id_format`),
  KEY `id_store` (`id_store`),
  KEY `id_format` (`id_format`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(500) COLLATE utf8_roman_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  `id_country` int(11) NOT NULL,
  `town` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  `postalcode` int(11) NOT NULL,
  `phone` varchar(10) COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_country` (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `directors`
--

CREATE TABLE IF NOT EXISTS `directors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_roman_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `formats`
--

CREATE TABLE IF NOT EXISTS `formats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `movies`
--

CREATE TABLE IF NOT EXISTS `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) CHARACTER SET utf8 COLLATE utf8_roman_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_roman_ci NOT NULL,
  `picture` varchar(500) CHARACTER SET utf8 COLLATE utf8_roman_ci NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_director` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_director` (`id_director`),
  KEY `id_category` (`id_category`),
  KEY `id_category_2` (`id_category`,`id_director`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `rentals`
--

CREATE TABLE IF NOT EXISTS `rentals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_customer` int(11) NOT NULL,
  `id_copy` int(11) NOT NULL,
  `leaving_date` date NOT NULL,
  `return_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_customer` (`id_customer`,`id_copy`),
  KEY `id_copy` (`id_copy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `stores`
--

CREATE TABLE IF NOT EXISTS `stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_country` int(50) NOT NULL,
  `town` varchar(50) COLLATE utf8_roman_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  `postalcode` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_country` (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=1 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `copies`
--
ALTER TABLE `copies`
  ADD CONSTRAINT `copies_ibfk_3` FOREIGN KEY (`id_format`) REFERENCES `formats` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `copies_ibfk_1` FOREIGN KEY (`id_movie`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `copies_ibfk_2` FOREIGN KEY (`id_store`) REFERENCES `stores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`);

--
-- Contraintes pour la table `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_2` FOREIGN KEY (`id_director`) REFERENCES `directors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`id_copy`) REFERENCES `copies` (`id`),
  ADD CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`);

--
-- Contraintes pour la table `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
