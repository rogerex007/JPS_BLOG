

<%@page import="java.util.Iterator"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="web.*" %>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%
    if (session.getAttribute("user") != null) {
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">


        <title>Search | :)</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <!-- Add custom CSS here -->
        <link href="css/modern-business.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">


    </head>

    <body>

        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!-- You'll want to use a responsive image option so this logo looks good on devices - I recommend using something like retina.js (do a quick Google search for it and you'll find it) -->
                    <a class="navbar-brand logo" href="index.jsp">Blog</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="blog.jsp">Blog</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">${user} <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="myPosts.jsp">My Posts</a></li>
                                <li><a href="./LoginAPI?action=logout">LogOut</a></li>
                            </ul>
                        </li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container -->
        </nav>

        <br>
        <div class="container">
            <br>
            <br>
            <div class="row row-offcanvas row-offcanvas-right">
                <div class="col-lg-9 col-md-9 col-xs-9 col-sm-9">

                    <% DbManager db = new DbManager();
                        String title = request.getParameter("q");

                        List<Post> posts = db.SearchPosts(title);

                    %>
                    <% for (Iterator<Post> i = posts.iterator(); i.hasNext();) {
                            Post post = i.next();
                    %>
                    <div class="jumbotron">
                        <h2><a href="#"><%= post.PostTitle%></a></h2>
                        <img class="postimg" src="<%= post.PostImage%>" title="Image Title !!!" />
                        <p><%= post.PostDescription%></p>
                        <br>
                        <p> Author : <strong> <%= post.PostAuthor%> </strong> </p>
                        <a href="./post.jsp?id=<%= post.ID%>" class="btn btn-primary">Read More...</a>
                    </div>
                    <hr />
                    <%}%>

                </div>


                <div class="col-lg-3 col-md-3 col-xs-3 col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation">
                    <br>
                    <a href="./newpost.jsp" class="btn btn-success">Write New Post!</a>
                    <br>
                    <br>
                    <div class="well sidebar-nav">
                        <ul class="nav">
                            <li><b>Categories</b></li>
                            <li class="active"><a href="#">Home</a></li>
                            <li><a href="#">Programming</a></li>
                            <li><a href="#">Web</a></li>
                            <hr />
                            <li><b>Social Links</b></li>
                            <li><a href="#">Facebook</a></li>
                            <li><a href="#">Youtube</a></li>
                        </ul>

                    </div>
                    <!--/.well -->

                    <!--/span-->
                </div>



                <hr>

                <footer>
                    <div class="row">
                        <div class="col-lg-12">
                            <p>Copyright &copy; Roger Mesa 2021</p>
                        </div>
                    </div>
                </footer>

            </div><!-- /.container -->

            <!-- JavaScript -->
            <script src="js/jquery-1.10.2.js"></script>
            <script src="js/bootstrap.js"></script>
            <script src="js/modern-business.js"></script>

    </body>
</html>
<%
    } else {
        response.sendRedirect("./login.jsp");
    }
%>

