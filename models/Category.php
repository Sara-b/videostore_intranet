<?php

/**
* 
*/
class Category
{
	
	public static function get_all_categories(){
    global $bdd;
    
    $requete = $bdd->prepare("SELECT * FROM category");
      // l'execution 
    $requete->execute();
    $Categories = $requete->fetchAll(PDO::FETCH_OBJ);
    
    return $Categories;
  }

}

?>