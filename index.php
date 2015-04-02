<?php  header("Access-Control-Allow-Origin: *");
  session_start();
  //require composer autoload (load all my libraries)
  require 'vendor/autoload.php';
  require 'rb.php';
  require 'connection_bdd.php';
  //require my models
  require 'models/Movie.php';
  require 'models/Customer.php';
  require 'models/Store.php';
  require 'models/Rental.php';

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


  //CUSTOMERS
  //GET all customers 
  $app->get('/users', function () use ($app) {  
    $users = Customer::get_all_users(); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($users);
  });

  //Get User by id
   $app->get('/users/:id', function ($id) use ($app) {  
    $user = Customer::get_user_by_id($id); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($user);
  });

  //Connexion
   $app->post('/users/connexion', function () use ($app) {  
    $user = Customer::connexion($_POST['mail'],$_POST['password']); 
    $app->response("connexion reussie")->header('Content-Type', 'application/json');
    echo json_encode($user);
  });
     //Connexion
   $app->get('/users/connexion/:mail', function ($mail) use ($app) {  
    $user = Customer::connexion2($mail); 
    $app->response("connexion reussie")->header('Content-Type', 'application/json');
    echo json_encode($user);
  });


   //STORES
  //GET all stores 
  $app->get('/stores', function () use ($app) {  
    $stores = Store::get_all_store(); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($stores);
  });

  //Get User by id
   $app->get('/stores/:id', function ($id) use ($app) {  
    $store = Store::get_store_by_id($id); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($store);
  });



   //RENTALS
  //GET all rentals 
  $app->get('/locations', function () use ($app) {  
    $rentals = Rental::get_all_rental(); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($rentals);
  });

  //Get Rental by id
   $app->get('/locations/:id', function ($id) use ($app) {  
    $rental = Rental::get_rental_by_id($id); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($rental);
  });

   //Get Rental by user
   $app->get('/locations/user/:id', function ($id) use ($app) {  
    $rentals = Rental::get_rental_by_user($id); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($rentals);
  });

   //Get Rental by copy
   $app->get('/locations/copy/:id', function ($id) use ($app) {  
    $rentals = Rental::get_rental_by_copy($id); 
    $app->response()->header('Content-Type', 'application/json');
    echo json_encode($rentals);
  });



  $app->run();
?>