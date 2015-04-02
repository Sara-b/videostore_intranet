<?php 
/**
* 
*/
class Customer
{
	public static function get_all_users(){
    global $bdd;
    
    $requete = $bdd->prepare("SELECT * FROM customers");
      // l'execution 
    $requete->execute();
    $customers = $requete->fetchAll(PDO::FETCH_OBJ);
    
    return $customers;
  }

  public static function get_user_by_id($id){
    global $bdd;
    
    $requete = $bdd->prepare("SELECT customers.*, countries.name FROM customers
                              LEFT JOIN countries ON countries.id = customers.id_country
                              WHERE customers.id=:id");
      // l'execution 
    $requete->bindParam(':id', $id);
    $requete->execute();
    $user = $requete->fetch(PDO::FETCH_OBJ);
    
    return $user;
  }

  public static function create_user($post){
    global $bdd;

    $req = $bdd->prepare("INSERT INTO customers (mail, password, first_name, last_name, id_country, town, address, posteCode, phone) 
                          VALUES (:mail, :password, :first_name, :last_name, 1, :town, :address, :posteCode, :phone)");

    $requete->bindParam(':mail', $post['mail']);
    $requete->bindParam(':password', $post['password']);
    $requete->bindParam(':first_name', $post['first_name']);
    $requete->bindParam(':last_name', $post['last_name']);
    $requete->bindParam(':town', $post['town']);
    $requete->bindParam(':address', $post['address']);
    $requete->bindParam(':posteCode', $post['posteCode']);
    $requete->bindParam(':phone', $post['phone']);
    $req->execute();

    return true;
  }


}

?>