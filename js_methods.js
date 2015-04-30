//Méthode qui crée l'objet XMLHttpRequest => sert à envoyer des requetes HTTP donc necessaire
//dans toutes les autres méthodes
function getXMLHttpRequest() {
    var xhr = null;
    
    if (window.XMLHttpRequest || window.ActiveXObject) {
        if (window.ActiveXObject) {
            try {
                xhr = new ActiveXObject("Msxml2.XMLHTTP");
            } catch(e) {
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
            }
        } else {
            xhr = new XMLHttpRequest(); 
        }
    } else {
        alert("Votre navigateur ne supporte pas l'objet XMLHTTPRequest...");
        return null;
    }
    
    return xhr;
}

function connexion() {
    //initialisation du httpRequest
    var xhr = getXMLHttpRequest();
    //on recupere la valeur des input mail et mdp dans la page html
    var mail = encodeURIComponent(document.getElementById("mail").value);
    var mdp = encodeURIComponent(document.getElementById("mdp").value);
    
    //quand l'appel ajax a été réalisé on passe dans cette fonction (donc normalement en dernier)
    xhr.onreadystatechange = function() {
    //si la requete a bien été envoyé et qu'on obtient le code réponse 200 (ok) ou 0 
        if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
            //on parse en JSON la réponse de l'url qu'on a appelé
            var data = JSON.parse(xhr.responseText);
            //si on a bien un résultat on redirige sur l'index
            if(data)
                document.location.href = "http://app.videostore.fr/index.html";
            //sinon message d'erreur
            else
                alert("Identifiant ou mot de passe incorrect.\n Merci de réessayer.");
        }
    };

    //ici on va envoyer une requete POST
    //on commence par créer une variable contenant les parametres
    var params = "mail="+mail+"&password="+mdp;
    //on envoie un POST sur l'api à l'url voulue
    xhr.open("POST","http://api.videostore.fr/users/connexion",true);
    //on indique au Header qu'il s'agit d'un formulaire
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    //on envoie les parametres
    xhr.send(params);

    //à ce stade on passe dans la méthode 'onreadystatechange'

    return false;
}
function getMovies() {
        var data;
        var xhr = getXMLHttpRequest();
        
        xhr.onreadystatechange = function() {
        
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                data = JSON.parse(xhr.responseText);
                //console.log(data);
                for(i=0;i<data.length;i++){
                        var tableau = document.getElementById("list_movies");

                        var ligne = tableau.insertRow(-1);//on a ajouté une ligne

                        var colonne1 = ligne.insertCell(0);//on a une ajouté une cellule
                        colonne1.innerHTML += data[i].id;//on y met le contenu de id

                        var colonne2 = ligne.insertCell(1);//on ajoute la seconde cellule
                        colonne2.innerHTML += data[i].title;

                        var colonne3 = ligne.insertCell(2);

                        colonne3.innerHTML += data[i].director ;//on ajoute le realisateur
                        
                        var colonne4 = ligne.insertCell(3);
                        colonne4.innerHTML += data[i].description;//description
                        //boutons actions
                        var colonne5 = ligne.insertCell(4);
                        colonne5.innerHTML += "<img src='images/update.png' width=20> <img src='images/delete.png' width=20>";
                    }
            }
        };
        xhr.open("GET","http://api.videostore.fr/videos",true);
        xhr.send();

        return false;
    }

function getUsers() {
        var data;
        var xhr = getXMLHttpRequest();
        
        xhr.onreadystatechange = function() {
        
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                data = JSON.parse(xhr.responseText);
                //console.log(data);
                for(i=0;i<data.length;i++){
                        var tableau = document.getElementById("list_users");

                        var ligne = tableau.insertRow(-1);//on a ajouté une ligne

                        var colonne1 = ligne.insertCell(0);//on a une ajouté une cellule
                        colonne1.innerHTML += data[i].first_name;//on y met le contenu de id

                        var colonne2 = ligne.insertCell(1);//on ajoute la seconde cellule
                        colonne2.innerHTML += data[i].last_name;

                        var colonne3 = ligne.insertCell(2);
                        colonne3.innerHTML += data[i].mail ;//on ajoute le realisateur
                        
                        var colonne4 = ligne.insertCell(3);
                        colonne4.innerHTML += data[i].phone;//description
                        //boutons actions
                        var colonne5 = ligne.insertCell(4);
                        colonne5.innerHTML += "<img src='images/update.png' width=20> <img src='images/delete.png' width=20>";
                    }
            }
        };
        xhr.open("GET","http://api.videostore.fr/users",true);
        xhr.send();

        return false;
    }