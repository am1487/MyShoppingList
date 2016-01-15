function loginActions(){
                        //document.cookie = "name=myShoppingList;username="+user+";expires=Fri, 31 Dec 9999 23:59:59 GMT";
                        $('#usernameField').text('Δημήτρης');
                        $('#fullNameField').text('Δημήτρης Τάγκαλος')
                        $('#emailField').text('tagkalos@uth.gr')
                        $('#userField').show();
                        $('#loginButton').hide();
                        $('#login').modal('hide');
                        
                        $("#loginSuccess").modal('show');
                            setTimeout(function(){
                            $("#loginSuccess").modal('hide');
                        },1000 );
}
