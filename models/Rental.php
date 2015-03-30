<?php 

/**
* 
*/
class Rental
{
	
	public static function get_all_rental(){
    global $bdd;
    
    $requete = $bdd->prepare("SELECT * FROM rentals");
      // l'execution 
    $requete->execute();
    $rentals = $requete->fetchAll(PDO::FETCH_OBJ);
    
    return $rentals;
  }

  public static function get_rental_by_id($id){
    global $bdd;
    
    $requete = $bdd->prepare("SELECT * FROM rentals WHERE id=:id");
      // l'execution 
    $requete->bindParam(':id', $id);
    $requete->execute();
    $rental = $requete->fetch(PDO::FETCH_OBJ);
    
    return $rental;
  }

  public static function get_rental_by_user($user_id){
    global $bdd;
    
    $requete = $bdd->prepare("SELECT * FROM rentals WHERE id_customer=:user_id");
      // l'execution 
    $requete->bindParam(':user_id', $user_id);
    $requete->execute();
    $rentals = $requete->fetch(PDO::FETCH_OBJ);
    
    return $rentals;
  }

  public static function get_rental_by_copy($copy_id){
    global $bdd;
    
    $requete = $bdd->prepare("SELECT * FROM rentals WHERE id_copy=:copy_id");
      // l'execution 
    $requete->bindParam(':copy_id', $copy_id);
    $requete->execute();
    $rentals = $requete->fetch(PDO::FETCH_OBJ);
    
    return $rentals;
  }
}

?>