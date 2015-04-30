-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Jeu 30 Avril 2015 à 08:31
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
-- Structure de la table `administrators`
--

CREATE TABLE IF NOT EXISTS `administrators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_store` int(11) NOT NULL,
  `mail` varchar(55) NOT NULL,
  `password` varchar(55) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_store` (`id_store`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `administrators`
--

INSERT INTO `administrators` (`id`, `id_store`, `mail`, `password`) VALUES
(1, 1, 'bordeaux@videostore.com', 'bordeaux'),
(2, 2, 'merignac@videostore.com', 'merignac');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=10 ;

--
-- Contenu de la table `categories`
--

INSERT INTO `categories` (`id`, `title`) VALUES
(2, 'Action'),
(3, 'Comédie'),
(4, 'Thriller'),
(5, 'Science Fiction'),
(6, 'Western'),
(7, 'Horreur'),
(8, 'Romantique'),
(9, 'Bollywood');

-- --------------------------------------------------------

--
-- Structure de la table `copies`
--

CREATE TABLE IF NOT EXISTS `copies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_movie` int(11) NOT NULL,
  `id_store` int(11) NOT NULL,
  `id_format` int(11) NOT NULL,
  `status` varchar(50) COLLATE utf8_roman_ci NOT NULL DEFAULT 'Disponible',
  PRIMARY KEY (`id`),
  KEY `id_movie` (`id_movie`,`id_store`,`id_format`),
  KEY `id_movie_2` (`id_movie`,`id_store`,`id_format`),
  KEY `id_store` (`id_store`),
  KEY `id_format` (`id_format`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=7 ;

--
-- Contenu de la table `copies`
--

INSERT INTO `copies` (`id`, `id_movie`, `id_store`, `id_format`, `status`) VALUES
(1, 6, 1, 1, 'Disponible'),
(2, 7, 1, 1, 'Disponible'),
(3, 10, 1, 3, 'Disponible'),
(4, 6, 1, 3, 'Disponible'),
(5, 9, 1, 1, 'Disponible'),
(6, 13, 2, 3, 'Disponible');

-- --------------------------------------------------------

--
-- Structure de la table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=10 ;

--
-- Contenu de la table `countries`
--

INSERT INTO `countries` (`id`, `name`) VALUES
(1, 'France'),
(2, 'Angleterre'),
(3, 'USA'),
(4, 'Allemagne'),
(5, 'Ecosse'),
(6, 'Belgique'),
(7, 'Suisse'),
(8, 'Luxembourg'),
(9, 'Irelande');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=5 ;

--
-- Contenu de la table `customers`
--

INSERT INTO `customers` (`id`, `mail`, `password`, `first_name`, `last_name`, `id_country`, `town`, `address`, `postalcode`, `phone`) VALUES
(1, 'sara.brin@hotmail.fr', 'sara', 'sara', 'brin', 1, 'Bordeaux', '89 Quais des Chartrons', 33300, '0678456732'),
(2, 'elodie.bironneau@hotmail.fr', 'elodie', 'elodie', 'bironneau', 1, 'Mérignac', 'Rue seguineau', 33700, '1234567890'),
(3, 'elisa.collot@hotmail.fr', 'elisa', 'elisa', 'collot', 1, 'Bordeaux', 'Quais des chartrons', 33300, '0987654321');

-- --------------------------------------------------------

--
-- Structure de la table `directors`
--

CREATE TABLE IF NOT EXISTS `directors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=5 ;

--
-- Contenu de la table `directors`
--

INSERT INTO `directors` (`id`, `first_name`, `last_name`) VALUES
(2, 'Quentin', 'Tarantino'),
(3, 'Joss', 'Whedon'),
(4, 'Christopher', 'Nolan');

-- --------------------------------------------------------

--
-- Structure de la table `formats`
--

CREATE TABLE IF NOT EXISTS `formats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8_roman_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=4 ;

--
-- Contenu de la table `formats`
--

INSERT INTO `formats` (`id`, `type`) VALUES
(1, 'DVD'),
(2, 'VHS'),
(3, 'BlueRay');

-- --------------------------------------------------------

--
-- Structure de la table `movies`
--

CREATE TABLE IF NOT EXISTS `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) COLLATE utf8_roman_ci NOT NULL,
  `description` text COLLATE utf8_roman_ci NOT NULL,
  `picture` varchar(500) COLLATE utf8_roman_ci NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_director` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_director` (`id_director`),
  KEY `id_category` (`id_category`),
  KEY `id_category_2` (`id_category`,`id_director`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=14 ;

--
-- Contenu de la table `movies`
--

INSERT INTO `movies` (`id`, `title`, `description`, `picture`, `id_category`, `id_director`) VALUES
(6, 'Inception', 'Dom Cobb est un voleur expérimenté – le meilleur qui soit dans l’art périlleux de l’extraction : sa spécialité consiste à s’approprier les secrets les plus précieux d’un individu, enfouis au plus profond de son subconscient, pendant qu’il rêve et que son esprit est particulièrement vulnérable. Très recherché pour ses talents dans l’univers trouble de l’espionnage industriel, Cobb est aussi devenu un fugitif traqué dans le monde entier qui a perdu tout ce qui lui est cher. Mais une ultime mission pourrait lui permettre de retrouver sa vie d’avant – à condition qu’il puisse accomplir l’impossible : l’inception. Au lieu de subtiliser un rêve, Cobb et son équipe doivent faire l’inverse : implanter une idée dans l’esprit d’un individu. S’ils y parviennent, il pourrait s’agir du crime parfait. Et pourtant, aussi méthodiques et doués soient-ils, rien n’aurait pu préparer Cobb et ses partenaires à un ennemi redoutable qui semble avoir systématiquement un coup d’avance sur eux. Un ennemi dont seul Cobb aurait pu soupçonner l’existence.', 'http://vignette1.wikia.nocookie.net/inception/images/d/de/Inception_Poster.jpg/revision/latest?cb=20100707155644', 2, 4),
(7, 'Interstellar', 'Le film raconte les aventures d’un groupe d’explorateurs qui utilisent une faille récemment découverte dans l’espace-temps afin de repousser les limites humaines et partir à la conquête des distances astronomiques dans un voyage interstellaire.', 'http://www.lyricis.fr/wp-content/uploads/2014/09/Lyricis-Interactive-Affiche-Imax-Interstellar.jpg', 5, 4),
(8, 'Le Prestige', 'Robert Angier et Alfred Borden sont deux magiciens surdoués, promis dès leur plus jeune âge à un glorieux avenir. Une compétition amicale les oppose d''abord l''un à l''autre, mais l''émulation tourne vite à la jalousie, puis à la haine. Devenus de farouches ennemis, les deux rivaux vont s''efforcer de se détruire l''un l''autre en usant des plus noirs secrets de leur art. Cette obsession aura pour leur entourage des conséquences dramatiques...', 'http://fr.web.img5.acsta.net/r_160_240/b_1_d6d6d6/medias/nmedia/18/62/84/94/18680369.jpg', 4, 4),
(9, 'The Dark Knight Rises ', 'Il y a huit ans, Batman a disparu dans la nuit : lui qui était un héros est alors devenu un fugitif. S''accusant de la mort du procureur-adjoint Harvey Dent, le Chevalier Noir a tout sacrifié au nom de ce que le commissaire Gordon et lui-même considéraient être une noble cause. Et leurs actions conjointes se sont avérées efficaces pour un temps puisque la criminalité a été éradiquée à Gotham City grâce à l''arsenal de lois répressif initié par Dent.\r\nMais c''est un chat – aux intentions obscures – aussi rusé que voleur qui va tout bouleverser. À moins que ce ne soit l''arrivée à Gotham de Bane, terroriste masqué, qui compte bien arracher Bruce à l''exil qu''il s''est imposé. Pourtant, même si ce dernier est prêt à endosser de nouveau la cape et le casque du Chevalier Noir, Batman n''est peut-être plus de taille à affronter Bane…', 'http://fr.web.img1.acsta.net/r_160_240/b_1_d6d6d6/medias/nmedia/18/83/56/27/20158098.jpg', 2, 4),
(10, 'Django Unchained', 'Dans le sud des États-Unis, deux ans avant la guerre de Sécession, le Dr King Schultz, un chasseur de primes allemand, fait l’acquisition de Django, un esclave qui peut l’aider à traquer les frères Brittle, les meurtriers qu’il recherche. Schultz promet à Django de lui rendre sa liberté lorsqu’il aura capturé les Brittle – morts ou vifs.\r\nAlors que les deux hommes pistent les dangereux criminels, Django n’oublie pas que son seul but est de retrouver Broomhilda, sa femme, dont il fut séparé à cause du commerce des esclaves…\r\nLorsque Django et Schultz arrivent dans l’immense plantation du puissant Calvin Candie, ils éveillent les soupçons de Stephen, un esclave qui sert Candie et a toute sa confiance. Le moindre de leurs mouvements est désormais épié par une dangereuse organisation de plus en plus proche… Si Django et Schultz veulent espérer s’enfuir avec Broomhilda, ils vont devoir choisir entre l’indépendance et la solidarité, entre le sacrifice et la survie…', 'http://fr.web.img4.acsta.net/r_160_240/b_1_d6d6d6/medias/nmedia/18/90/08/59/20366454.jpg', 6, 2),
(11, 'Inglourious Basterds ', 'Dans la France occupée de 1940, Shosanna Dreyfus assiste à l''exécution de sa famille tombée entre les mains du colonel nazi Hans Landa. Shosanna s''échappe de justesse et s''enfuit à Paris où elle se construit une nouvelle identité en devenant exploitante d''une salle de cinéma.\r\nQuelque part ailleurs en Europe, le lieutenant Aldo Raine forme un groupe de soldats juifs américains pour mener des actions punitives particulièrement sanglantes contre les nazis. "Les bâtards", nom sous lequel leurs ennemis vont apprendre à les connaître, se joignent à l''actrice allemande et agent secret Bridget von Hammersmark pour tenter d''éliminer les hauts dignitaires du Troisième Reich. Leurs destins vont se jouer à l''entrée du cinéma où Shosanna est décidée à mettre à exécution une vengeance très personnelle...', 'http://fr.web.img6.acsta.net/r_160_240/b_1_d6d6d6/medias/nmedia/18/70/45/22/19123474.jpg', 2, 2),
(12, 'Avengers : L''ère d''Ultron', 'Alors que Tony Stark tente de relancer un programme de maintien de la paix jusque-là suspendu, les choses tournent mal et les super-héros Iron Man, Captain America, Thor, Hulk, Black Widow et Hawkeye vont devoir à nouveau unir leurs forces pour combattre le plus puissant de leurs adversaires : le terrible Ultron, un être technologique terrifiant qui s’est juré d’éradiquer l’espèce humaine.\r\nAfin d’empêcher celui-ci d’accomplir ses sombres desseins, des alliances inattendues se scellent, les entraînant dans une incroyable aventure et une haletante course contre le temps…', 'http://fr.web.img1.acsta.net/r_160_240/b_1_d6d6d6/pictures/15/02/25/09/55/340147.jpg', 5, 3),
(13, 'Avengers', 'Lorsque Nick Fury, le directeur du S.H.I.E.L.D., l''organisation qui préserve la paix au plan mondial, cherche à former une équipe de choc pour empêcher la destruction du monde, Iron Man, Hulk, Thor, Captain America, Hawkeye et Black Widow répondent présents.\r\nLes Avengers ont beau constituer la plus fantastique des équipes, il leur reste encore à apprendre à travailler ensemble, et non les uns contre les autres, d''autant que le redoutable Loki a réussi à accéder au Cube Cosmique et à son pouvoir illimité...', 'http://fr.web.img1.acsta.net/r_160_240/b_1_d6d6d6/medias/nmedia/18/85/31/58/20042068.jpg', 5, 3);

-- --------------------------------------------------------

--
-- Structure de la table `rentals`
--

CREATE TABLE IF NOT EXISTS `rentals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_customer` int(11) NOT NULL,
  `id_copy` int(11) NOT NULL,
  `loaning_date` date NOT NULL,
  `return_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_customer` (`id_customer`,`id_copy`),
  KEY `id_copy` (`id_copy`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=5 ;

--
-- Contenu de la table `rentals`
--

INSERT INTO `rentals` (`id`, `id_customer`, `id_copy`, `loaning_date`, `return_date`) VALUES
(1, 1, 1, '2015-05-12', '2015-05-15'),
(2, 1, 3, '2015-04-30', '2015-05-03'),
(3, 2, 6, '2015-05-10', '2015-05-17'),
(4, 3, 5, '2015-05-12', '2015-05-16');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_roman_ci AUTO_INCREMENT=8 ;

--
-- Contenu de la table `stores`
--

INSERT INTO `stores` (`id`, `id_country`, `town`, `address`, `postalcode`) VALUES
(1, 1, 'Bordeaux', '57 Rue Ste Catherine', 33000),
(2, 1, 'Mérignac', '30 Rue du 8 mai', 33700),
(3, 1, 'Nantes', '12 Avenue du Général de Gaulle', 44000),
(4, 1, 'Poitiers', '33 Rue Rabelais', 86000),
(5, 1, 'Montpellier', '102 Avenue Leclerc', 34000),
(6, 1, 'Paris', '89 Avenue des Champs Elysées', 75000),
(7, 1, 'Lille', '21 Place du Befroi', 59000);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `administrators`
--
ALTER TABLE `administrators`
  ADD CONSTRAINT `administrators_ibfk_1` FOREIGN KEY (`id_store`) REFERENCES `stores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `copies`
--
ALTER TABLE `copies`
  ADD CONSTRAINT `copies_ibfk_1` FOREIGN KEY (`id_movie`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `copies_ibfk_2` FOREIGN KEY (`id_store`) REFERENCES `stores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `copies_ibfk_3` FOREIGN KEY (`id_format`) REFERENCES `formats` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`);

--
-- Contraintes pour la table `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `movies_ibfk_2` FOREIGN KEY (`id_director`) REFERENCES `directors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`id_copy`) REFERENCES `copies` (`id`);

--
-- Contraintes pour la table `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
