<%--
  Created by IntelliJ IDEA.
  User: nitin
  Date: 6/13/2020
  Time: 7:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Maze Bank- Online Mall</title>
    <link href="css/noti.css">
    <!-- Bootstrap core CSS -->
    <link href="assets1/css/bootstrap.css" rel="stylesheet">
    <!-- Fontawesome core CSS -->
    <link href="assets1/css/font-awesome.min.css" rel="stylesheet" />
    <!--GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <!--Slide Show Css -->
    <link href="assets1/ItemSlider/css/main-style.css" rel="stylesheet" />
    <!-- custom CSS here -->
    <link href="assets1/css/style.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            let myobj,txt="",str="";
            $.ajax({
                url : "mall",
                success: function (response) {
                    myobj = JSON.parse(response);
                    let len = myobj.length;
                    console.log(len);
                    let str = "";
                    len = len + 1;
                    let i,iter;
                    iter=1;
                    for(let x in myobj)
                    {
                        txt += "<div class='col-md-4 text-center col-sm-6 col-xs-6'><div class='thumbnail product-box'>"+
                            "<img src='assets1/img/dummyimg.png'/><div class='caption'><h3 id='Name'><a href='#'>"+
                            myobj[x].name+
                            "</a></h3><p id='price'>Price : <strong>Rs."+
                            myobj[x].price+
                            "</strong></p><p id='Description' >"+
                            myobj[x].description+
                            "</p><p><form action='test' id='"+
                            myobj[x].id +"'>" + "<input type='hidden' name='id' value='"+
                            myobj[x].id+
                            "'><input type='submit' class='btn btn-success' role='button' value='Add To Cart'></form></p>"+
                            "</div></div></div>";
                        i=myobj[x].id;
                        str += "#" + i.toString();
                        iter=iter+1;
                        if(iter!=len)
                        {
                            str = str + ",";
                        }
                    }
                    document.getElementById('myrow').innerHTML = txt;
                    $(str.toString()).on('submit',function (event) {
                        event.preventDefault();
                        let f = $(this).serialize();
                        console.log(f);
                        $.ajax({
                            url : "test",
                            data : f,
                            type : "POST",
                            success:function (data) {
                                $.ajax({
                                    type: "POST",
                                    url : "cartquantity",
                                    success:function (data) {
                                        $('#prod_num').html(data.toString());
                                        // $('#modal_button').click();
                                        $('#exampleModal').modal('show')
                                    }
                                })
                            }
                        });
                    });

                }
            });
            $.ajax({
                type: "POST",
                url : "cartquantity",
                success:function (data) {
                    $('#prod_num').html(data.toString());
                }
            })
        });

    </script>
</head>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><strong>MAZE</strong> Shop</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="cart" class="notification">
                        <span>My cart</span>
                        <span class="badge" id="prod_num">0</span>
                    </a>
                </li>

                <li><a href="home.jsp">Dashboard</a></li>
                <!--
                <li><a href="index.jsp">Sign up</a></li>
                -->
                <!--
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">24x7 Support <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"><strong>Call: </strong>+09-456-567-890</a></li>
                        <li><a href="#"><strong>Mail: </strong>info@yourdomain.com</a></li>
                        <li class="divider"></li>
                        <li><a href="#"><strong>Address: </strong>
                            <div>
                                234, New york Street,<br />
                                Just Location, USA
                            </div>
                        </a></li>
                    </ul>
                </li>
                -->
            </ul>
<%--btn by nitin--%>

            <div class="navbar-form navbar-right" role="search">
                <form method="post" action="keyword.jsp">
                <div class="form-group">
                    <input type="text" placeholder="Enter Keyword Here ..." class="form-control" name="keyword" >
                </div>
                <input type="submit" class="btn btn-primary"></input>
                </form>
            </div>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger" id="exampleModalLabel">Message</h5>
            </div>
            <div class="modal-body text-success">
                Item Added to the Cart Successfully
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <!--<div class="row">
        <div class="col-md-12">
            <div class="well well-lg offer-box text-center">
                Today's Offer : &nbsp; <span class="glyphicon glyphicon-cog"></span>&nbsp;40 % off  on purchase of $ 2,000 and above till 24 dec !
            </div>

            <br />
        </div>
    </div>
    -->
    <!-- /.row -->
    <div class="col-md-12" id="Main_box">
        <div class="row" id="myrow"></div>

    </div>
</div>
<!-- /.container -->
<!--
<div class="col-md-12 download-app-box text-center">

    <span class="glyphicon glyphicon-download-alt"></span>Download Our Android App and Get 10% additional Off on all Products . <a href="#" class="btn btn-danger btn-lg">DOWNLOAD  NOW</a>

</div>
-->
<!--Footer -->
<!--
<div class="col-md-12 footer-box">
    <div class="row small-box ">
        <strong>Mobiles :</strong> <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |
        <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |
        <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |  <a href="#">Sony</a> |
        <a href="#">Microx</a> |<a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |
        <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |
        <a href="#">Sony</a> | <a href="#">Microx</a> | view all items

    </div>
    <div class="row small-box ">
        <strong>Laptops :</strong> <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx Laptops</a> |
        <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |
        <a href="#">Sony Laptops</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |  <a href="#">Sony</a> |
        <a href="#">Microx</a> |<a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |
        <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |
        <a href="#">Sony</a> | <a href="#">Microx</a> | view all items
    </div>
    <div class="row small-box ">
        <strong>Tablets : </strong><a href="#">samsung</a> |  <a href="#">Sony Tablets</a> | <a href="#">Microx</a> |
        <a href="#">samsung </a>|  <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |
        <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung Tablets</a> |  <a href="#">Sony</a> |
        <a href="#">Microx</a> |<a href="#">samsung Tablets</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |
        <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |
        <a href="#">Sony</a> | <a href="#">Microx Tablets</a> | view all items

    </div>
    <div class="row small-box pad-botom ">
        <strong>Computers :</strong> <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |
        <a href="#">samsung Computers</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |
        <a href="#">Sony</a> | <a href="#">Microx</a> |<a href="#">samsung</a> |  <a href="#">Sony</a> |
        <a href="#">Microx Computers</a> |<a href="#">samsung Computers</a> |  <a href="#">Sony</a> | <a href="#">Microx</a> |
        <a href="#">samsung</a> |  <a href="#">Sony</a> | <a href="#">Microx Computers</a> |<a href="#">samsung</a> |
        <a href="#">Sony</a> | <a href="#">Microx</a> | view all items

    </div>
    <div class="row">
        <div class="col-md-4">
            <strong>Send a Quick Query </strong>
            <hr>
            <form>
                <div class="row">
                    <div class="col-md-6 col-sm-6">
                        <div class="form-group">
                            <input type="text" class="form-control" required="required" placeholder="Name">
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6">
                        <div class="form-group">
                            <input type="text" class="form-control" required="required" placeholder="Email address">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="form-group">
                            <textarea name="message" id="message" required="required" class="form-control" rows="3" placeholder="Message"></textarea>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Submit Request</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-md-4">
            <strong>Our Location</strong>
            <hr>
            <p>
                234, New york Street,<br />
                Just Location, USA<br />
                Call: +09-456-567-890<br>
                Email: info@yourdomain.com<br>
            </p>

            2014 www.yourdomain.com | All Right Reserved
        </div>
        <div class="col-md-4 social-box">
            <strong>We are Social </strong>
            <hr>
            <a href="#"><i class="fa fa-facebook-square fa-3x "></i></a>
            <a href="#"><i class="fa fa-twitter-square fa-3x "></i></a>
            <a href="#"><i class="fa fa-google-plus-square fa-3x c"></i></a>
            <a href="#"><i class="fa fa-linkedin-square fa-3x "></i></a>
            <a href="#"><i class="fa fa-pinterest-square fa-3x "></i></a>
            <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur nec nisl odio. Mauris vehicula at nunc id posuere. Curabitur nec nisl odio. Mauris vehicula at nunc id posuere.
            </p>
        </div>
    </div>
    <hr>
</div>

<div class="col-md-12 end-box ">
    &copy; 2014 | &nbsp; All Rights Reserved | &nbsp; www.yourdomain.com | &nbsp; 24x7 support | &nbsp; Email us: info@yourdomain.com
</div>
-->
<%--<button type="button" id="modal_button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" aria-hidden="true"></button>--%>
<!--Footer end -->
<!--Core JavaScript file  -->
<script src="assets1/js/jquery-1.10.2.js"></script>
<!--bootstrap JavaScript file  -->
<script src="assets1/js/bootstrap.js"></script>
<!--Slider JavaScript file  -->
<script src="assets1/ItemSlider/js/modernizr.custom.63321.js"></script>
<script src="assets1/ItemSlider/js/jquery.catslider.js"></script>
<script>
    $(function () {
        $('#mi-slider').catslider();
    });
    $('#1').on('submit',function (event) {
        event.preventDefault();
        let f = $(this).serialize();
        console.log(f);
    });
</script>
</body>
</html>
