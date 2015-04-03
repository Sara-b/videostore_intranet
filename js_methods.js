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