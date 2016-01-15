$(document).ready(function () {
    $('#loginAjax').click(function () {
        var username = $('#user').val();
        var password = $('#pass').val();

        $.post('UserLogin', {user: username, pass: password}, function (responseText) {
            var obj = JSON.parse(responseText);
            if ('error' in obj) {
                $('#ajaxLoginResponse').text('Λάθος όνομα χρήστη η κωδικός.');
            } else {

                //document.cookie = "name="+obj['user']+";expires=Fri, 31 Dec 9999 23:59:59 GMT";
                $('#usernameField').text(obj['name']);
                $('#fullNameField').text(obj['fullname'])
                $('#emailField').text(obj['email'])
                $('#userField').show();
                $('#loginButton').hide();
                $('#login').modal('hide');
                $("#loginSuccess").modal('show');
                setTimeout(function () {
                    $("#loginSuccess").modal('hide');
                }, 1000);
            }

        });
    });
});




$(document).ready(function () {
    $('#logoutajax').click(function () {
                $("#logoutSucces").modal('show');


        $.post('Logout', {}, function (responseText) {
            
            //document.cookie = "name="+obj['user']+";expires=Fri, 31 Dec 9999 23:59:59 GMT";

          
            setTimeout(function () {
                window.location.href = "index.jsp";
            }, 1000);
        });


    });
});
$(document).ready(function () {
    $('#loginButton').click(function () {
        $('#ajaxLoginResponse').text('');

    });
});

$(document).ready(function () {
    $('#createList').click(function () {
        var x = document.cookie;
        if(getCookie('user')!=""){
             //document.getElementById("mappicker").style.display="block";

            $('#us6-dialog').modal('show');
            document.getElementById("us6-dialog").style.visibility="visible";



        }
        else{
            $('#login').modal('show');
            $('#ajaxLoginResponse').text('Πρέπει να συνδεθείτε πρώτα.');

        }
        

    });
    
    function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
} 
});

$(document).ready(function () {
    $('#closeModal').click(function () {
             document.getElementById("us6-dialog").style.visibility="hidden";

});
});


$(document).ready(function () {
    $('#closeModal2').click(function () {
             document.getElementById("us6-dialog").style.visibility="hidden";

});
});

$(document).ready(function () {
    $('#epomeno').click(function () {
             document.getElementById("us6-dialog").style.visibility="hidden";
             window.location.href = "newList.jsp";
             });
});








$(document).ready(function() {
    $("#add_row").on("click", function() {
        // Dynamic Rows Code
        
        // Get max row id and set new id
        var newid = 0;
        $.each($("#tab_logic tr"), function() {
            if (parseInt($(this).data("id")) > newid) {
                newid = parseInt($(this).data("id"));
            }
        });
        newid++;
        
        var tr = $("<tr></tr>", {
            id: "addr"+newid,
            "data-id": newid
        });
        
        // loop through each td and create new elements with name of newid
        $.each($("#tab_logic tbody tr:nth(0) td"), function() {
            var cur_td = $(this);
            
            var children = cur_td.children();
            
            // add new td and element if it has a nane
            if ($(this).data("name") != undefined) {
                var td = $("<td></td>", {
                    "data-name": $(cur_td).data("name")
                });
                
                var c = $(cur_td).find($(children[0]).prop('tagName')).clone().val("");
                c.attr("name", $(cur_td).data("name") + newid);
                c.appendTo($(td));
                td.appendTo($(tr));
            } else {
                var td = $("<td></td>", {
                    'text': $('#tab_logic tr').length
                }).appendTo($(tr));
            }
        });
        
        // add delete button and td
        /*
        $("<td></td>").append(
            $("<button class='btn btn-danger glyphicon glyphicon-remove row-remove'></button>")
                .click(function() {
                    $(this).closest("tr").remove();
                })
        ).appendTo($(tr));
        */
        
        // add the new row
        $(tr).appendTo($('#tab_logic'));
        
        $(tr).find("td button.row-remove").on("click", function() {
             $(this).closest("tr").remove();
        });
});




    // Sortable Code
    var fixHelperModified = function(e, tr) {
        var $originals = tr.children();
        var $helper = tr.clone();
    
        $helper.children().each(function(index) {
            $(this).width($originals.eq(index).width())
        });
        
        return $helper;
    };
  
    $(".table-sortable tbody").sortable({
        helper: fixHelperModified      
    }).disableSelection();

    $(".table-sortable thead").disableSelection();



    $("#add_row").trigger("click");
});