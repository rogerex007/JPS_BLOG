
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="web.*"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%
    if (session.getAttribute("user") != null) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Posts | :)</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <!-- Add custom CSS here -->
        <link href="css/modern-business.css" rel="stylesheet">
        <link href="css/table.css" rel="stylesheet">
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
        <br>                 <br>                 <br> 


        <div class="container">
            <div class="row">
                <div class="col-12">

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Title</th>
                                <th scope="col">Author</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <% DbManager db = new DbManager();
                            String username = request.getSession().getAttribute("user").toString();
                            List<Post> posts = db.GetAllMyPost(username);
                            int count = 1;

                        %>
                        <% for (Iterator<Post> i = posts.iterator(); i.hasNext();) {
                                Post post = i.next();
                        %>
                        <tbody>
                            <tr>
                                <th scope="row"><%= count%></th>
                                <td><%= post.PostTitle%></td>
                                <td><%= post.PostAuthor%></td>
                                <td>
                                    <a href="./post.jsp?id=<%= post.ID%>" class="btn btn-primary">Open</a>
                                </td>
                            </tr>
                        </tbody>
                        <%
                                count++;
                            }%>
                    </table>

                </div>
            </div>
        </div>                 
    </body>
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
</html>
<%
    } else {
        response.sendRedirect("./login.jsp");
    }
%>