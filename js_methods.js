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
    var xhr = getXMLHttpRequest();

    var mail = encodeURIComponent(document.getElementById("mail").value);
    var mdp = encodeURIComponent(document.getElementById("mdp").value);
    
    xhr.onreadystatechange = function() {
    
        if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
            var data = JSON.parse(xhr.responseText);
            if(data)
                document.location.href = "http://app.videostore.fr/index.html";
            else
                alert("Identifiant ou mot de passe incorrect.\n Merci de réessayer.");
        }
    };
    var params = "mail="+mail+"&password="+mdp;
    xhr.open("POST","http://api.videostore.fr/users/connexion",true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(params);
    return false;
}

    function getMovies() {
        var data;
        var xhr = getXMLHttpRequest();
        
        xhr.onreadystatechange = function() {
        
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                data = JSON.parse(xhr.responseText);
                console.log(data);
                for(i=0;i<data.length;i++){
                        var tableau = document.getElementById("list_movies");

                        var ligne = tableau.insertRow(-1);//on a ajouté une ligne

                        var colonne1 = ligne.insertCell(0);//on a une ajouté une cellule
                        colonne1.innerHTML += data[i].id;//on y met le contenu de id

                        var colonne2 = ligne.insertCell(1);//on ajoute la seconde cellule
                        colonne2.innerHTML += data[i].title;

                        var colonne3 = ligne.insertCell(2);
                        colonne3.innerHTML += data[i].id_director;//on ajoute l'id du realisateur

                        var colonne4 = ligne.insertCell(3);
                        colonne4.innerHTML += data[i].description;//description
                        //boutons actions
                        var colonne5 = ligne.insertCell(4);
                        colonne4.innerHTML += "<img src='images/update.png' width=20>   <img src='images/delete.png' width=20>";
                    }
            }
        };
        xhr.open("GET","http://api.videostore.fr/videos",true);
        xhr.send();

        return false;
    }
