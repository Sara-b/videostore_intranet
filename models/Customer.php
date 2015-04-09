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

  public static function connexion($mail,$password){
    global $bdd;
    
    //on passe par le formulaire
    if(isset($mail) AND $mail!="" AND isset($password) AND $password!="") // On a le pseudo et mdp
      {
        // On récupère tout le contenu de la table 
        $req = $bdd->prepare('SELECT * FROM customers WHERE mail=:mail AND password=:password LIMIT 1'); 
        //on passe en paramètre de la requete nos variables $_POST
        $req->execute(array(
          'mail' => $mail,
          'password' => $password
          ));
        if($user=$req->fetch(PDO::FETCH_OBJ)){
          return $user;
        }
        else return false;
          
      }
      else{
        return false;
      }
  }

  public static function connexion2($mail){
    global $bdd;
    
    //on passe par le formulaire
    if(isset($mail) AND $mail!="" ) // On a le pseudo et mdp
      {
        // On récupère tout le contenu de la table 
        $req = $bdd->prepare('SELECT * FROM customers WHERE mail=:mail'); 
        //on passe en paramètre de la requete nos variables $_POST
        $req->execute(array(
          'mail' => $mail
          ));
        /*if($donnees=$req->fetchAll(PDO::FETCH_OBJ)){  
          $_SESSION['id']=$donnees['id'];
          $_SESSION['mail']=$donnees['mail'];
          $_SESSION['first_name']=$donnees['first_name'];
          $_SESSION['last_name']=$donnees['last_name'];
        */
        if($user=$req->fetchAll(PDO::FETCH_OBJ)){
          return $user;
        }
        else return false;
          
      }
      else{
        return false;
      }
  }


}

?>