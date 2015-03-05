<?php 
  //require composer autoload (load all my libraries)
  require 'vendor/autoload.php';
  
  //require my models
  //require 'models/*';

  // Slim initialisation
  $app = new \Slim\Slim();

  // hook before.router, now $app is accessible in my views
  $app->hook('slim.before.router', function () use ($app) {
    $app->view()->setData('app', $app);
  });


  //ROUTES

  // root
  $app->get('/', function(){
  	echo "Vous etes à la racine";
   	})->name('root'); // named route so I can use with "urlFor" method
  
  //GET all videos 
  $app->get('/videos', function(){
    echo "Get All videos";
	});

  //GET video by id
  $app->get('/videos/:id', function($id){
    echo "Get videos where id = $id";
	});

  $app->run();
