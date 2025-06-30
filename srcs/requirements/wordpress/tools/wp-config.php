<?php

	#mysql settings 
	define('DB_NAME', 'wordpress');
	define('DB_USER', 'gianni');
	define('DB_PASSWORD', 'nino');
	define('DB_HOST', 'mariadb');
	define('DB_CHARSET', 'utf8');
	define('DB_COLLATE', '');
	define('WP_ALLOW_REPAIR', true);

	define( 'WP_SITEURL', 'https://nromito.42.fr' );
	define( 'WP_HOME',    'https://nromito.42.fr' );
	define( 'FORCE_SSL_ADMIN', true );   // opzionale ma consigliato


	# Auth unique keys and salts.
	define('AUTH_KEY',         'jh|Sk{.~y7]*Z5oLkB&yk }E0`-O+H+h~~}BG:1pzOK[UlyD&Vv?whE=zXc=}oB{');
	define('SECURE_AUTH_KEY',  'B,(m4J~TH[Z)Y[B;9q<,LFn|Z{v9|x+_-K7VhH^6+!V_qVSTbOrh5|-c{idj@%2i');
	define('LOGGED_IN_KEY',    'l+kEa`;kee{O@U`MMqgf;*IU 673-Gt!&<Uz+N!%6`-!#PHKhh!mE%yEum;bM~+=');
	define('NONCE_KEY',        'eF|%<!J7ziws.narK$K6(_,j~u;^5*qFh=tN|*gnVMar3~@HtLl]dI6}a1[vB&l}');
	define('AUTH_SALT',        '$d6}?Ij4l|!y<cVW~-(KQ1r)m@|?ca>Y=VI)D@mRDq!_[;<o:c|maFFV6|U?I)8@');
	define('SECURE_AUTH_SALT', '0#i_.qL!._54#m:Z)eU:lG({fz96_}lmrlt!r:b#E&;C-;|2nM}hxRp/0qb8<rJ,');
	define('LOGGED_IN_SALT',   'n2jk7zm1Tghe}#K4}l+-6A(b#y#-](zt [g2-eL3co:+*~nGKN]-?/}4|9stL}so');
	define('NONCE_SALT',       '_va:=5T.n?>KCA(`vJ3kmk6O0E#&h-F2g_Sxz:P(_o]R#37-`AUn@D|Bc6}+}7M6');

	// define( 'WP_REDIS_HOST', 'redis' );
	// define( 'WP_REDIS_PORT', 6379 );

	define('WP_CACHE', true);

	$table_prefix = 'wp_';

	define('WP_DEBUG', true);

	# Assign absolute path if does not exist

	if ( !defined('ABSPATH') ) {
		define('ABSPATH', dirname(__FILE__) . '/');
	}

	# Set up wordpress vars and included files

	require_once(ABSPATH . 'wp-settings.php');

?>