<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>MyShoppingList</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/landing-page.css" rel="stylesheet">
        <link href="css/login.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->


        <!--google map source-->
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src='http://maps.google.com/maps/api/js?sensor=false&libraries=places'></script>
        <script src="js/locationpicker.jquery.js"></script>


    </head>

    <body>

        <%
            //allow access only if session exists
            String user = null;
            String fullname = null;
            String name = null;
            String email = null;
//            if (session.getAttribute("user") == null) {
//                response.sendRedirect("index.jsp");
//            } else {
//                user = (String) session.getAttribute("user");
//            }
            String userName = null;
            String sessionID = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("user")) {
                        userName = cookie.getValue();
                        user = cookie.getValue();

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/myshoppinglist", "final", "123456789");

                        Statement statement = connection.createStatement();

                        ResultSet resultset
                                = statement.executeQuery("SELECT * FROM user WHERE username='" + user + "'");
                        if (resultset.next()) {
                            fullname = resultset.getString(2);
                            name = (fullname.split(" "))[1];
                            email = resultset.getString(3);
                        }

                    }
                    if (cookie.getName().equals("JSESSIONID")) {
                        sessionID = cookie.getValue();
                    }
                }
            }


        %>





        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
            <div class="container topnav">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand topnav" href="index.jsp">MyShoppingList</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#about">Αρχική</a>
                        </li>
                        <li>
                            <a href="#services">Υπηρεσίες</a>
                        </li>
                        <li>
                            <a href="manual.html">Εγχειρίδιο</a>
                        </li>
                        <li>
                            <a href="" id="loginButton" data-toggle="modal" data-target="#login" <%                                if (user != null) {
                                    out.print(" style=\"display:none;\" ");
                                }%>>Σύνδεση
                            </a>
                        </li>
                        <li>
                            <div id="userField" class="userClass" style="color: #3c763d; <%
                                if (user == null) {
                                    out.print("display:none;");
                                }
                                 %> 
                                 text-align: center">
                                <ul class="nav navbar-nav navbar-right"  >
                                    <li class="dropdown" >
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                            <span class="glyphicon glyphicon-user" style="color: #3c763d; display:none; text-align: center"></span> 
                                            <div id="usernameField" style="color: #3c763d;"><%=name%><strong></strong>
                                            </div>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <div class="navbar-login">
                                                    <div class="row">
                                                        <div class="col-lg-4">
                                                            <p class="text-center">
                                                                <span class="glyphicon glyphicon-user icon-size"></span>
                                                            </p>
                                                        </div>
                                                        <div class="col-lg-8">
                                                            <p class="text-left" id="fullNameField" style="color: #3c763d;"><%=fullname%></p>
                                                            <p class="text-left small" id="emailField"><%=email%></p>
                                                            <p class="text-left">
                                                                <a href="#" class="btn btn-primary btn-block btn-sm">Προφίλ</a>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="divider"></li>
                                            <li>
                                                <div class="navbar-login navbar-login-session">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <p>
                                                                <a id="logoutajax" class="btn btn-danger btn-block">Αποσύνδεση</a>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </li>

                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>


        <!-- Header -->
        <a name="about"></a>
        <div class="intro-header">
            <div class="container">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="intro-message">
                            <h2>Δημιουργήστε τη δική σας λίστα!</h2>
                            <h3>Είναι δωρεάν!</h3>
                            <hr class="intro-divider">
                            <ul class="list-inline intro-social-buttons">
                                <li>
                                    <a id="createList" class="btn btn-default btn-lg"> <span class="network-name">Δημιουργια λιστας</span></a>
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container -->

        </div>
        <!-- /.intro-header -->

        <!-- Page Content -->


        <!-- login -->
        <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="loginmodal-container">
                    <h1>Σύνδεση</h1><br>
                    <p style="color: #204d74;">Για την σύνδεση στην υπηρεσία απαιτείται λογαριασμός στο Πανεπιστήμιο Θεσσαλίας</p>
                    <div id="ajaxLoginResponse" style="color: red;"></div>

                    <form>
                        <input type="text" id="user" placeholder="Username">
                        <input type="password" id="pass" placeholder="Password">
                        <input style="width: 100%"  type="button"  id="loginAjax" class="login loginmodal-submit" value="Σύνδεση">
                    </form>

                </div>
            </div>
        </div>

        <!-- loginSuccess -->

        <div class="modal fade" id="loginSuccess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="loginmodal-container" style="color: #3c763d">
                    <h1>Σύνδεση Επιτυχής!</h1><br>				
                </div>
            </div>
        </div>


        <!-- logoutSucces -->

        <div class="modal fade" id="logoutSucces" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="loginmodal-container" style="color: #843534">
                    <h1>Αποσύνδεση...</h1><br>				
                </div>
            </div>
        </div>


        <!-- map -->

        <div id="us6-dialog" class="modal show" style="visibility: hidden;"  data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" id="closeModal" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Παρακαλώ επιλέξτε περιοχή</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal" style="width: 550px">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Location:</label>

                                <div class="col-sm-10"><input type="text" class="form-control" id="us6-address"/></div>
                            </div>

                            <div id="us6" style="width: 100%; height: 400px;"></div>
                            <div class="clearfix">&nbsp;</div>

                            <div class="clearfix"></div>
                            <script>
                                $('#us6').locationpicker({
                                    location: {latitude: 39.36484395724071, longitude: 22.941386523803658},
                                    radius: 400,
                                    inputBinding: {
                                        latitudeInput: null,
                                        longitudeInput: null,
                                        radiusInput: $('#us6-radius'),
                                        locationNameInput: $('#us6-address')
                                    },
                                    enableAutocomplete: true
                                });
                                $('#us6-dialog').on('shown.bs.modal', function () {
                                    $('#us6').locationpicker('autosize');


                                });
                            </script>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="closeModal2" type="button" class="btn btn-default" data-dismiss="modal">Άκυρο</button>
                        <button id="epomeno"  data-toggle="modal" data-target="#tableCreate" type="button" class="btn btn-primary">επόμενο</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->


        <a  name="services"></a>
        <div class="content-section-a">

            <div class="container" >
                <div class="row">
                    <div class="col-lg-5 col-sm-6">
                        <hr class="section-heading-spacer">
                        <div class="clearfix"></div>
                        <h2 class="section-heading">1.  Δημιουργήστε τη λίστα με τα<br>Ψώνια σας</h2>
                        <p class="lead">Εισάγετε όλα τα προιόντα που πρόκειτε να αγοράσετε και τις ποσότητες τους εύκολα και γρήγορα.</p>
                    </div>
                    <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                        <img class="img-responsive" src="img/ipad.png" alt="">
                    </div>
                </div>

            </div>
            <!-- /.container -->

        </div>
        <!-- /.content-section-a -->

        <div class="content-section-b">

            <div class="container">

                <div class="row">
                    <div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
                        <hr class="section-heading-spacer">
                        <div class="clearfix"></div>
                        <h2 class="section-heading">2. Πληρώστε Λιγότερα</h2>
                        <p class="lead">Εμείς θα σας βοηθήσουμε να βρείτε που θα αγοράσετε τα προιόντα της λίστας σας στη καλύτερη τιμή.</p>
                    </div>

                    <div class="col-lg-5 col-sm-pull-6  col-sm-6">
                        <img class="img-responsive" src="img/dog.png" alt="">
                    </div>
                </div>

            </div>
            <!-- /.container -->

        </div>
        <!-- /.content-section-b -->

        <div class="content-section-a">

            <div class="container">

                <div class="row">
                    <div class="col-lg-5 col-sm-6">
                        <hr class="section-heading-spacer">
                        <div class="clearfix"></div>
                        <h2 class="section-heading">3. Προσφορές</h2>
                        <p class="lead">Θα σας προτείνουμε προσφορές που μπορούν να κάνουν τα ψώνια σας ακόμα πιο οικονομικά!</p>
                    </div>
                    <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                        <img class="img-responsive" src="img/phones.png" alt="">
                    </div>
                </div>

            </div>
            <!-- /.container -->

        </div>
        <!-- /.content-section-a -->

        <a  name="contact"></a>
        <div class="banner">

            <div class="container">

                <div class="row">
                    <div class="col-lg-6">
                        <h2>Βρείτε μας:</h2>
                    </div>
                    <div class="col-lg-6">
                        <ul class="list-inline banner-social-buttons">
                            <li>
                                <a href="#" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i> <span class="network-name">Twitter</span></a>
                            </li>
                            <li>
                                <a href="#" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i> <span class="network-name">Github</span></a>
                            </li>
                            <li>
                                <a href="#" class="btn btn-default btn-lg"><i class="fa fa-linkedin fa-fw"></i> <span class="network-name">Linkedin</span></a>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
            <!-- /.container -->



        </div>
        <!-- /.banner -->

        <!-- Footer -->
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <ul class="list-inline">
                            <li>
                                <a href="#">Home</a>
                            </li>
                            <li class="footer-menu-divider">&sdot;</li>
                            <li>
                                <a href="#about">About</a>
                            </li>
                            <li class="footer-menu-divider">&sdot;</li>
                            <li>
                                <a href="#services">Services</a>
                            </li>
                            <li class="footer-menu-divider">&sdot;</li>
                            <li>
                                <a href="#contact">Contact</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>

        <!-- jQuery -->
        <script src="js/jquery.js"></script>

        <!-- login -->
        <script src="js/login-ajax.js" type="text/javascript"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

    </body>

</html>
