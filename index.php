<?php 
  //require composer autoload (load all my libraries)
  require 'vendor/autoload.php';
  require 'rb.php';
  require 'connection_bdd.php';
  //require my models
  require 'models/Movie.php';

  // set up database connection
  R::setup('mysql:host=localhost;dbname=videostore','root','');
  R::freeze(true);

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
  

  //VIDEOS
  //GET all videos 
  $app->get('/videos', function () use ($app) {  
    $movies = R::findAll('movies'); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode(R::exportAll($movies));
  });

  //GET video by id
  $app->get('/videos/:id', function($id) use($app) {
    $movie = Movie::get_movie_by_id($id); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($movie);
	});

  //GET video by title
  $app->get('/videos/title/:title', function($title) use($app){
    $movie = Movie::get_movie_by_title($title);
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($movie);
  });

  //GET videos by category
  $app->get('/videos/category/:category', function($category) use($app){
    $movie = Movie::get_movie_by_category($category);
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($movie);
  });  



/*Return JSON*/
// handle GET requests for /articles
$app->get('/movies/:id', function ($id) use ($app) {  
  // query database for all movies
  $movies = Movie::get_movie_by_id($id); 
  
  // send response header for JSON content type
  $app->response()->header('Content-Type', 'application/json');
  
  // return JSON-encoded response body with query results
  echo json_encode($movies);
  });

  $app->run();
?>