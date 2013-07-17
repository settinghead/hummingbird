CREATE TABLE `hits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `url` varchar(1024) DEFAULT NULL,
  `referral_url` varchar(1024) DEFAULT NULL,
  `cccid` int(11) DEFAULT NULL,
  `user-agent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8$$

