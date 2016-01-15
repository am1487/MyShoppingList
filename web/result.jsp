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
                            <a href="index.jsp">Αρχική</a>
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
        <div class="intro-header2">
            <div class="container">



                <div class="container" style="color:white; text-align:center;"><h2>Η λίστα μου</h2></div>
                <div class="panel with-nav-tabs panel-default"  >
                    <div class="panel-heading">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab1default" data-toggle="tab">1 ${requestScope['super']}</a></li>
                            <li><a href="#tab2default" data-toggle="tab">2 Καταστήματα</a></li>
                            <li><a href="#tab3default" data-toggle="tab">3 Καταστήματα</a></li>
                            <li><a href="#tab4default" data-toggle="tab">Προτάσεις</a></li>
                            <li><a href="#tab5default" data-toggle="tab">Επεξεργασία</a></li>
                        </ul>
                    </div>
                    <div class="panel-body" style="height: 500px;max-height: 500;overflow-y: scroll;">
                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="tab1default">
                                <h2 >${requestScope['super']}</h2>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Προιον</th>
                                            <th>Ποσότητα</th>
                                            <th>Τιμή</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>

                                            <td>1</td>
                                            <td>        <a href="#" title="Header" data-toggle="popover" data-placement="bottom" data-content="Content"> ${requestScope['prod1']}</a></td>
                                            <td>${requestScope['quant1']}</td>
                                            <td>${requestScope['price1']}</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>        <a href="#" title="Header" data-toggle="popover" data-placement="bottom" data-content="Content"> ${requestScope['prod2']}</a></td>
                                            <td>${requestScope['quant2']}</td>
                                            <td>${requestScope['price2']}</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>        <a href="#" title="Header" data-toggle="popover" data-placement="bottom" data-content="Content"> ${requestScope['prod3']}</a></td>
                                            <td>${requestScope['quant3']}</td>
                                            <td>${requestScope['price3']}</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>        <a href="#" title="Header" data-toggle="popover" data-placement="bottom" data-content="Content"> ${requestScope['prod4']}</a></td>
                                            <td>${requestScope['quant4']}</td>
                                            <td>${requestScope['price4']}</td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>        <a href="#" title="Header" data-toggle="popover" data-placement="bottom" data-content="Content"> ${requestScope['prod5']}</a></td>
                                            <td>${requestScope['quant5']}</td>
                                            <td>${requestScope['price5']}</td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>        <a href="#" title="Header" data-toggle="popover" data-placement="bottom" data-content="Content"> ${requestScope['prod6']}</a></td>
                                            <td>${requestScope['quant6']}</td>
                                            <td>${requestScope['price6']}</td>
                                        </tr>	
                                        <tr>
                                            <td>7</td>
                                            <td>        <a href="#" title="Header" data-toggle="popover" data-placement="bottom" data-content="Content"> ${requestScope['prod7']}</a></td>
                                            <td>${requestScope['quant7']}</td>
                                            <td>${requestScope['price7']}</td>
                                        </tr>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align:right;">Total</td>
                                    <td><b>${requestScope['minPrice']}</b></td>
                                    </tr>
                                    </tbody>
                                </table>


                            </div>
                            <div class="tab-pane fade" id="tab2default">
                                <h2>Σουπερμάρκετ: Πλανήτης</h2>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Προιον</th>
                                            <th>Ποσότητα</th>
                                            <th>Τιμή</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>

                                            <td>1</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>3</td>
                                            <td>5€</td>
                                        </tr>
                                        </a>
                                        <tr>
                                            <td>2</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>4</td>
                                            <td>2€</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>2</td>
                                            <td>2€</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>2</td>
                                            <td>2€</td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>2</td>
                                            <td>2€</td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>2</td>
                                            <td>2€</td>
                                        </tr>		<tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align:right;">Σύνολο</td>
                                            <td><b>10€</b></td>
                                        </tr>
                                    </tbody>
                                </table>

                                <h2>Σουπερμάρκετ: Πλανήτης</h2>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Προιον</th>
                                            <th>Ποσότητα</th>
                                            <th>Τιμή</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>

                                            <td>1</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>3</td>
                                            <td>5€</td>
                                        </tr>
                                        </a>
                                        <tr>
                                            <td>2</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>4</td>
                                            <td>2€</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>2</td>
                                            <td>2€</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Κάποιο Προιον</td>
                                            <td>2</td>
                                            <td>2€</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align:right;">Σύνολο</td>
                                            <td><b>10€</b></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align:right;">Γενικό Σύνολο</td>
                                            <td><b>20€</b></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="tab3default">3</div>
                            <div class="tab-pane fade" id="tab4default">-</div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container -->

        </div>
        <!-- /.intro-header -->

        <!-- Page Content -->


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

        <script>
            $(document).ready(function () {
                $('[data-toggle="popover"]').popover();
            });
        </script>
        <!-- jQuery -->
        <script src="js/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

    </body>

</html>