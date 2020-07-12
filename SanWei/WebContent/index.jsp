<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
    <title>三维模型质量检查-首页</title>
    <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    <link rel="shortcut icon" href="<%=basePath %>favicon.ico">
</head>
<body style="background: #E3E7EA">
<jsp:include page="header.jsp"></jsp:include>

<div class="container">

    <%--<div id="main_ad" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        &lt;%&ndash;<ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>
&ndash;%&gt;
        <!-- 下面的小点点，活动指示器 -->
        <ol class="carousel-indicators">
            <li data-target="#main_ad" data-slide-to="0" class="active"></li>
            <li data-target="#main_ad" data-slide-to="1"></li>
            <li data-target="#main_ad" data-slide-to="2"></li>
            <li data-target="#main_ad" data-slide-to="3"></li>
        </ol>
        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            &lt;%&ndash;        <div class="item active">
                        <img src="..." alt="...">
                        <div class="carousel-caption">
                            ...
                        </div>
                    </div>
                    <div class="item">
                        <img src="..." alt="...">
                        <div class="carousel-caption">
                            ...
                        </div>
                    </div>&ndash;%&gt;

            <div class="item active">
                <img src="<%=basePath %>images/slider/slide_01_640x340.jpg" alt="...">
                <div class="carousel-caption">
                </div>

            </div>
            <div class="item active">
                <img src="<%=basePath %>images/slider/slide_02_2000x410.jpg" alt="...">
                <div class="carousel-caption">
                </div>

            </div>
            <div class="item active">
                <img src="<%=basePath %>images/slider/slide_03_2000x410.jpg" alt="...">
                <div class="carousel-caption">
                </div>

            </div>
            <div class="item active">
                <img src="<%=basePath %>images/slider/slide_04_2000x410.jpg" alt="...">
                <div class="carousel-caption">
                </div>

            </div>


        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
--%>

    <div class="row" style="margin-top: 3em">
        <div clas s="col-sm-12">

            <!-- 广告轮播开始 -->
            <section id="main_ad" class="carousel slide" data-ride="carousel">
                <!-- 下面的小点点，活动指示器 -->
                <ol class="carousel-indicators">
                    <li data-target="#main_ad" data-slide-to="0" class="active"></li>
                    <li data-target="#main_ad" data-slide-to="1"></li>
                    <li data-target="#main_ad" data-slide-to="2"></li>
                    <li data-target="#main_ad" data-slide-to="3"></li>
                </ol>
                <!-- 轮播项 -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active" data-image-lg="<%=basePath %>images/slider/slide_01_2000x410.jpg"
                         data-image-xs="<%=basePath %>images/slider/slide_01_640x340.jpg"></div>
                    <div class="item" data-image-lg="<%=basePath %>images/slider/slide_02_2000x410.jpg"
                         data-image-xs="<%=basePath %>images/slider/slide_02_640x340.jpg"></div>
                    <div class="item" data-image-lg="<%=basePath %>images/slider/slide_03_2000x410.jpg"
                         data-image-xs="<%=basePath %>images/slider/slide_03_640x340.jpg"></div>
                    <div class="item" data-image-lg="<%=basePath %>images/slider/slide_04_2000x410.jpg"
                         data-image-xs="<%=basePath %>images/slider/slide_04_640x340.jpg"></div>
                </div>
                <!-- 控制按钮 -->
                <a class="left carousel-control" href="#main_ad" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">上一页</span>
                </a>
                <a class="right carousel-control" href="#main_ad" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">下一页</span>
                </a>
            </section>
            <!-- /广告轮播结束 -->
        </div>
    </div>

    <!-- 特色介绍开始 -->
    <section id="tese">
        <div class="container">
            <div class="row">
                <div class="col-xs-6 col-md-4">
                    <a href="#">
                        <div class="media">
                            <div class="media-left">
                                <i class="icon-uniE907"></i>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">木木就是两个木</h4>
                                <p>我们的征途是星辰大海</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xs-6 col-md-4">
                    <a href="#">
                        <div class="media">
                            <div class="media-left">
                                <i class="icon-uniE907"></i>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">木木就是两个木</h4>
                                <p>我们的征途是星辰大海</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xs-6 col-md-4">
                    <a href="#">
                        <div class="media">
                            <div class="media-left">
                                <i class="icon-uniE907"></i>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">木木就是两个木</h4>
                                <p>我们的征途是星辰大海</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xs-6 col-md-4">
                    <a href="#">
                        <div class="media">
                            <div class="media-left">
                                <i class="icon-uniE907"></i>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">木木就是两个木</h4>
                                <p>我们的征途是星辰大海</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xs-6 col-md-4">
                    <a href="#">
                        <div class="media">
                            <div class="media-left">
                                <i class="icon-uniE907"></i>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">木木就是两个木</h4>
                                <p>我们的征途是星辰大海</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xs-6 col-md-4">
                    <a href="#">
                        <div class="media">
                            <div class="media-left">
                                <i class="icon-uniE907"></i>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">木木就是两个木</h4>
                                <p>我们的征途是星辰大海</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>
    <!-- /特色介绍 结束-->


</div>
<jsp:include page="footer.jsp"></jsp:include>

<script src="<%=basePath%>plugins/jquery.min.js"></script>
<script src="<%=basePath%>plugins/bootstrap.js"></script>
<script src="<%=basePath%>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>plugins/locales/bootstrap-datetimepicker.zh-CN.js"
        charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>js/index.js"></script>


</body>
</html>
