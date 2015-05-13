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

function connexionUser() {
    var mail = $("#mail").val();
    var mdp = $("#mdp").val();
    
    $.post("http://api.videostore.fr/user/connexion",
            {
                mail: mail,
                password: mdp
            },
            function(data){
                console.log(data);
                if(data!=" false"){
                    window.location="http://app.videostore.fr/index.html";
                }
                else {
                    $("#add_err").css('display', 'inline', 'important');
                    $("#add_err").html("Identifiant ou mot de passe incorrect.");
                }
            });
    }

function connexionAdmin() {   
    var mail = $("#mail").val();
    var mdp = $("#mdp").val();
    
    $.post("http://api.videostore.fr/admin/connexion",
            {
                mail: mail,
                password: mdp
            },
            function(data){
                console.log(data);
                if(data!=" false"){
                    window.location="http://app.videostore.fr/index.html";
                }
                else {
                    $("#add_err").css('display', 'inline', 'important');
                    $("#add_err").html("Identifiant ou mot de passe incorrect.");
                }
            });
    }

function getMovies() {
    var data;
    var xhr = getXMLHttpRequest();
    
    xhr.onreadystatechange = function() {
    
        if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
            data = JSON.parse(xhr.responseText);
            //console.log(data);
            for(i=0;i<data.length;i++){

                insertMovie(data[i]);
            }
        }
    };
    xhr.open("GET","http://api.videostore.fr/videos",true);
    xhr.send();

    return false;
}

function insertMovie(row){


    var tableau = document.getElementById("list_movies");

    var ligne = tableau.insertRow(-1);//on a ajouté une ligne

    var colonne1 = ligne.insertCell(0);//on a une ajouté une cellule
    colonne1.innerHTML += row.id;//on y met le contenu de id

    var colonne2 = ligne.insertCell(1);//on ajoute la seconde cellule
    colonne2.innerHTML += row.title;

    var colonne3 = ligne.insertCell(2);

    colonne3.innerHTML += row.director ;//on ajoute le realisateur
    
    var colonne4 = ligne.insertCell(3);
    colonne4.innerHTML += row.description;//description
    //boutons actions
    var colonne5 = ligne.insertCell(4);
    colonne5.innerHTML += "<img src='images/update.png' width=20/><a onclick='delete_movie("+row.id+");'><img src='images/delete.png' width=20/></a>";
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

    function delete_movie(id){
        /*var xhr = getXMLHttpRequest();
        var answer = confirm("Voulez vous vraiment supprimer cet élément ?")
        if (answer){
            xhr.open("DELETE","http://api.videostore.fr/video/"+id,false);
            xhr.send();
        }
        else{return;}*/
        var answer = confirm("Voulez vous vraiment supprimer cet élément ???")
        if (answer){
            $.ajax({
                type: "DELETE",
                method: "POST",
                url: "http://api.videostore.fr/video/"+id
            })
            .done(function( msg ) {
                alert( "Data deleted: " + msg );
            })
            .fail(function(data){
                alert("message de retour : " + data);}
            );
        }

    }

    function resetFields(){
        $('#title').val="";
        $('#description').val="";
        $('#category').selectedIndex=-1;
        $('#director').selectedIndex=-1;
    }


    function create_movie(){
        //initialisation du httpRequest
        var xhr = getXMLHttpRequest();
        //on recupere la valeur des input dans la page html
        var titre = encodeURIComponent($("#title").val());
        var description = encodeURIComponent($("#description").val());
        var director = encodeURIComponent($("#director").val());
        var category = encodeURIComponent($("#category").val());
        var picture = encodeURIComponent($("#picture").val());

        console.log("titre : " + titre);
        console.log("description : " + description);
        console.log("director : " + director);
        console.log("category : " + category);
        console.log("picture : " + picture);
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                alert("Le film a bien été ajouté");
                resetFields();
                //var data = JSON.parse(xhr.responseText);
                //console.log(data);
                //insertMovie(JSON.parse(data));
            }
        };

        var params = "title="+titre+"&description="+description+"&id_director="+director+"&id_category="+category+"&picture="+picture;
        //on envoie un POST sur l'api à l'url voulue
        xhr.open("POST","http://api.videostore.fr/videos",true);
        //on indique au Header qu'il s'agit d'un formulaire
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        //on envoie les parametres
        xhr.send(params);
    }    

    function create_user(){
        //initialisation du httpRequest
        var xhr = getXMLHttpRequest();
        //on recupere la valeur des input dans la page html
        var titre = encodeURIComponent($("#title").val());
        var description = encodeURIComponent($("#description").val());
        var director = encodeURIComponent($("#director").val());
        var category = encodeURIComponent($("#category").val());
        var picture = encodeURIComponent($("#picture").val());

        console.log("titre : " + titre);
        console.log("description : " + description);
        console.log("director : " + director);
        console.log("category : " + category);
        console.log("picture : " + picture);
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                alert("Le film a bien été ajouté");
                var data = JSON.parse(xhr.responseText);
                console.log(data);
                insertMovie(JSON.parse(data));
            }
        };

        var params = "title="+titre+"&description="+description+"&id_director="+director+"&id_category="+category+"&picture="+picture;
        //on envoie un POST sur l'api à l'url voulue
        xhr.open("POST","http://api.videostore.fr/videos",true);
        //on indique au Header qu'il s'agit d'un formulaire
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        //on envoie les parametres
        xhr.send(params);
    }    

    function getCopies() {
        var data;
        var xhr = getXMLHttpRequest();
        
        xhr.onreadystatechange = function() {
        
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                data = JSON.parse(xhr.responseText);
                //console.log(data);
                for(i=0;i<data.length;i++){

                    insertCopies(data[i]);
                        /*var tableau = document.getElementById("list_movies");

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
                        colonne5.innerHTML += "<img src='images/update.png' width=20/><a onclick='delete_movie("+data[i].id+");'><img src='images/delete.png' width=20/></a>";*/
                }
            }
        };
        xhr.open("GET","http://api.videostore.fr/exemplaires",true);
        xhr.send();

        return false;
    }

    function insertCopies(row){


    var tableau = document.getElementById("list_copies");

    var ligne = tableau.insertRow(-1);//on a ajouté une ligne

    var colonne1 = ligne.insertCell(0);//on a une ajouté une cellule
    colonne1.innerHTML += row.id;//on y met le contenu de id

    var colonne2 = ligne.insertCell(1);//on ajoute la seconde cellule
    colonne2.innerHTML += row.title;

    var colonne3 = ligne.insertCell(2);
    colonne3.innerHTML += row.director;//on ajoute le realisateur
    
    var colonne4 = ligne.insertCell(3);
    colonne4.innerHTML += row.format;//format

    var colonne5 = ligne.insertCell(4);
    colonne5.innerHTML += row.status;//status
    //boutons actions
    var colonne6 = ligne.insertCell(5);
    colonne6.innerHTML += "<img src='images/update.png' width=20/><a onclick='delete_movie("+row.id+");'><img src='images/delete.png' width=20/></a>";
}

//Ne fonctionne pas
function create_copies(){
        //initialisation du httpRequest
        var xhr = getXMLHttpRequest();
        //on recupere la valeur des input dans la page html
        var id_movie = encodeURIComponent($("#movie").val());
        var id_store = 1;
        var id_format = encodeURIComponent($("#format").val());
        var nbCopies = encodeURIComponent($("#nbCopies").val());

        console.log("id_movie : " + id_movie);
        console.log("id_store : " + id_store);
        console.log("id_format : " + id_format);
        console.log("nbCopies : " + nbCopies);
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                alert("L'exemplaires a bien été ajouté");
                var data = JSON.parse(xhr.responseText);
                console.log(data);
                alert(data);
                insertCopies(JSON.parse(data));
            }
        };

        for(i=0;i<nbCopies.length;i++){
            var params = "id_movie="+id_movie+"&id_format="+id_format+"&id_store="+id_store;
            //on envoie un POST sur l'api à l'url voulue
            xhr.open("POST","http://api.videostore.fr/exemplaires",true);
            //on indique au Header qu'il s'agit d'un formulaire
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            //on envoie les parametres
            xhr.send(params);
        }
    } 

    function getOneMovie(){
        var data;
        var xhr = getXMLHttpRequest();
        
        xhr.onreadystatechange = function() {
        
            if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                data = JSON.parse(xhr.responseText);
                //console.log(data);
                for(i=0;i<data.length;i++){

                    insertCopies(data[i]);
                        /*var tableau = document.getElementById("list_movies");

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
                        colonne5.innerHTML += "<img src='images/update.png' width=20/><a onclick='delete_movie("+data[i].id+");'><img src='images/delete.png' width=20/></a>";*/
                }
            }
        }
        xhr.open("GET","http://api.videostore.fr/exemplaires",true);
        xhr.send();

        return false;
    }

function getRentals() {
    var data;
    var xhr = getXMLHttpRequest();
    
    xhr.onreadystatechange = function() {
    
        if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
            data = JSON.parse(xhr.responseText);
            //console.log(data);
            for(i=0;i<data.length;i++){

                insertRentals(data[i]);
            }
        }
    };
    xhr.open("GET","http://api.videostore.fr/locations",true);
    xhr.send();

    return false;
}

function insertRentals(row){
    var tableau = document.getElementById("list_rentals");

    var ligne = tableau.insertRow(-1);//on a ajouté une ligne

    var colonne1 = ligne.insertCell(0);//on a une ajouté une cellule
    colonne1.innerHTML += row.id;//on y met le contenu de id

    var colonne2 = ligne.insertCell(1);//on ajoute la seconde cellule
    colonne2.innerHTML += row.utilisateur;

    var colonne3 = ligne.insertCell(2);
    colonne3.innerHTML += row.film;//on ajoute le realisateur
    
    var colonne4 = ligne.insertCell(3);
    colonne4.innerHTML += row.date_emprunt;//description

    var colonne5 = ligne.insertCell(4);
    colonne5.innerHTML += row.date_retour;//description
    //boutons actions
    var colonne6 = ligne.insertCell(5);
    colonne6.innerHTML += "<img src='images/update.png' width=20/><a onclick='delete_movie("+row.id+");'><img src='images/delete.png' width=20/></a>";
}

function getOneUser() {
    var data;
    var xhr = getXMLHttpRequest();
    
    xhr.onreadystatechange = function() {
    
        if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
            data = JSON.parse(xhr.responseText);

            var nom = document.getElementById("name");
            nom.innerHTML = data.name;

            var adresse = document.getElementById("address");
            adresse.innerHTML = data.address;

            var ville = document.getElementById("town");
            ville.innerHTML = data.town;

            var tel = document.getElementById("tel");
            tel.innerHTML = "Telephone: "+data.phone;

            var mail = document.getElementById("mail");
            mail.innerHTML ="mail: "+data.mail;

            var adresse = document.getElementById("address");
            adresse.innerHTML = data.address;

            getRentalsByUser();
        }
    };
    xhr.open("GET","http://api.videostore.fr/users/3",true);
    xhr.send();

    return false;
}

function getRentalsByUser() {
    var data;
    var xhr = getXMLHttpRequest();
    
    xhr.onreadystatechange = function() {
    
        if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
            data = JSON.parse(xhr.responseText);
            console.log(data);
            for(i=0;i<data.length;i++){
                insertRentalsByUser(data[i]);
            }
        }
    };
    xhr.open("GET","http://api.videostore.fr/users/3/rentals",true);
    xhr.send();

    return false;
}

function insertRentalsByUser(row){
    var tableau = document.getElementById("list_rentals");

    var ligne = tableau.insertRow(-1);//on a ajouté une ligne

    var colonne1 = ligne.insertCell(0);//on a une ajouté une cellule
    colonne1.innerHTML += row.title;//on y met le contenu de id

    var colonne2 = ligne.insertCell(1);//on ajoute la seconde cellule
    colonne2.innerHTML += row.loaning_date;

    var colonne3 = ligne.insertCell(2);
    colonne3.innerHTML += row.return_date;
}
