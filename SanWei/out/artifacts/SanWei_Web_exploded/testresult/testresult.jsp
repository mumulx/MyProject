<%--
  Created by IntelliJ IDEA.
  User: 木木
  Date: 2020/4/30
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String recordId = request.getParameter("recordId");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
    <title>三维模型质量检查-个人中心</title>
    <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    <link rel="shortcut icon" href="<%=basePath %>favicon.ico">
    <link href="<%=basePath %>testresult/font-awesome.min.css" rel="stylesheet">

    <style type="text/css">
        /*-------------------------------*/
        /*           VARIABLES           */
        /*-------------------------------*/
        body {
            position: relative;
            overflow-x: hidden;
        }

        body,
        html {
            height: 100%;
            /*#E3E7EA*/
            background-color: #E3E7EA;
        }

        .nav .open > a {
            background-color: transparent;
        }

        .nav .open > a:hover {
            background-color: transparent;
        }

        .nav .open > a:focus {
            background-color: transparent;
        }

        /*-------------------------------*/
        /*           Wrappers            */
        /*-------------------------------*/
        #wrapper {
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            -webkit-transition: all 0.5s ease;
            padding-left: 0;
            transition: all 0.5s ease;
        }

        #wrapper.toggled {
            padding-left: 220px;
        }

        #wrapper.toggled #sidebar-wrapper {
            width: 220px;
        }


        #sidebar-wrapper {
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            -webkit-transition: all 0.5s ease;
            height: 100%;
            left: 220px;
            margin-left: -220px;
            overflow-x: hidden;
            overflow-y: auto;
            transition: all 0.5s ease;
            background: #DEDEDE;
            width: 0;
            /*width: 220px;*/
            top: 70px;
            z-index: 1000;
        }

        #sidebar-wrapper::-webkit-scrollbar {
            display: none;
        }

        /*-------------------------------*/
        /*     Sidebar nav styles        */
        /*-------------------------------*/
        .sidebar-nav {
            list-style: none;
            margin: 0;
            padding: 0;
            position: absolute;
            top: 0;
            width: 220px;
        }

        .sidebar-nav li {
            display: inline-block;
            line-height: 20px;
            position: relative;
            width: 100%;
        }

        .sidebar-nav li:before {
            /*background-color: #7c5aae;*/
            content: '';
            height: 100%;
            left: 0;
            position: absolute;
            top: 0;
            -webkit-transition: width 0.2s ease-in;
            transition: width 0.2s ease-in;
            width: 3px;
            z-index: -1;

        }

        .sidebar-nav li a {
            color: #555;
            display: block;
            padding: 10px 15px 10px 15px;
            text-decoration: none;
        }

        .sidebar-nav li.open:hover before {
            -webkit-transition: width 0.2s ease-in;
            transition: width 0.2s ease-in;
            width: 100%;
        }

        .sidebar-nav li a i {
            margin-right: 5px;
        }

        .sidebar-nav > .sidebar-brand {
            font-size: 20px;
            height: 65px;
            line-height: 44px;
            color: #555;
            display: block;
            padding: 10px 15px 10px 15px;
            text-decoration: none;


        }

        .sidebar-nav > .sidebar-brand:hover {

            cursor: pointer;

        }

        /*-------------------------------*/
        /*       Hamburger-Cross         */
        /*-------------------------------*/
        .hamburger {
            background: transparent;
            border: none;
            display: block;
            height: 32px;
            margin-left: 15px;
            position: relative;
            /*top: 90px;*/
            width: 32px;
            z-index: 999;
        }

        .hamburger:hover {
            outline: none;
        }

        .hamburger:focus {
            outline: none;
        }

        .hamburger:active {
            outline: none;
        }

        .hamburger.is-closed:before {
            -webkit-transform: translate3d(0, 0, 0);
            -webkit-transition: all 0.35s ease-in-out;
            color: #ffffff;
            content: '';
            display: block;
            font-size: 14px;
            line-height: 32px;
            opacity: 0;
            text-align: center;
            width: 100px;
        }

        .hamburger.is-closed:hover before {
            -webkit-transform: translate3d(-100px, 0, 0);
            -webkit-transition: all 0.35s ease-in-out;
            display: block;
            opacity: 1;
        }

        .hamburger.is-closed:hover .hamb-top {
            -webkit-transition: all 0.35s ease-in-out;
            top: 0;
        }

        .hamburger.is-closed:hover .hamb-bottom {
            -webkit-transition: all 0.35s ease-in-out;
            bottom: 0;
        }

        .hamburger.is-closed .hamb-top {
            -webkit-transition: all 0.35s ease-in-out;
            background-color: #333;
            top: 5px;
        }

        .hamburger.is-closed .hamb-middle {
            background-color: #333;
            margin-top: -2px;
            top: 50%;
        }

        .hamburger.is-closed .hamb-bottom {
            -webkit-transition: all 0.35s ease-in-out;
            background-color: #333;
            bottom: 5px;
        }

        .hamburger.is-closed .hamb-top,
        .hamburger.is-closed .hamb-middle,
        .hamburger.is-closed .hamb-bottom,
        .hamburger.is-open .hamb-top,
        .hamburger.is-open .hamb-middle,
        .hamburger.is-open .hamb-bottom {
            height: 4px;
            left: 0;
            position: absolute;
            width: 100%;
        }

        .hamburger.is-open .hamb-top {
            -webkit-transform: rotate(45deg);
            -webkit-transition: -webkit-transform 0.2s cubic-bezier(0.73, 1, 0.28, 0.08);
            background-color: #333;
            margin-top: -2px;
            top: 50%;
        }

        .hamburger.is-open .hamb-middle {
            background-color: #333;
            display: none;
        }

        .hamburger.is-open .hamb-bottom {
            -webkit-transform: rotate(-45deg);
            -webkit-transition: -webkit-transform 0.2s cubic-bezier(0.73, 1, 0.28, 0.08);
            background-color: #333;
            margin-top: -2px;
            top: 50%;
        }

        .hamburger.is-open:hover .hamb-top {
            transition: all 0.5s;
            transform: scale(1.1);
        }

        .hamburger.is-open:hover .hamb-bottom {
            transition: all 0.5s;
            transform: scale(1.1);
        }

        .hamburger.is-open:before {
            -webkit-transform: translate3d(0, 0, 0);
            -webkit-transition: all 0.35s ease-in-out;
            color: #ffffff;
            content: '';
            display: block;
            font-size: 14px;
            line-height: 32px;
            opacity: 0;
            text-align: center;
            width: 100px;
        }

        .hamburger.is-open:hover before {
            -webkit-transform: translate3d(-100px, 0, 0);
            -webkit-transition: all 0.35s ease-in-out;
            display: block;
            opacity: 1;
        }


        .testOptionsNumbers-title,
        .testStatus-title {
            font-size: 12px;
            color: #333333;
            padding-top: 10px;


        }

        .testOptionsNumbers-btn,
        .testStatus-btn {

            margin-top: 10px;


        }

        #prtJpgpreview {

            margin-top: 7px;
            margin-bottom: 7px;
        }

        .label-primary {

            background: #1ab394;
            border-color: #1ab394;
            color: #fff;
        }

        .panel-body-body {
            display: none;

        }

        .panel-heading-heading {

            cursor: pointer;

        }

        .panel-primary > .panel-heading {

            background-color: #9BDACD;
            border-color: #9BDACD;

        }

        .panel-primary {
            border-color: #9BDACD;
        }

        /*        .panel .panel-primary .panel-primary-primary{

                    border-color: #9BDACD;



                }

                .panel .panel-primary .panel-primary-primary .panel-heading .panel-heading-heading {


                    background-color: #9BDACD;

                }*/

        .titlt_button_group{
            text-align: right;
            padding-right: 8em;
        }
        .titlt_button_group button {

            margin-left: 10px;
            margin-right: 10px;

        }
        .tooltip-inner{
            padding:10px;
            line-height: 20px;
            text-align: left;
            background-color: #f7f7f7;
            color: #333;

        }
        .panel-body{
            overflow: auto;
        }


    </style>

</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>


<div id="wrapper">
    <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
        <ul class="nav sidebar-nav">
            <li class="sidebar-brand" id="testFileListSidebarBrand">
                <span>检测文件列表</span>
            </li>


            <%-- <li>
                 <a href="#"><i class="fa fa-fw fa-folder"></i> Page one</a>
             </li>--%>


        </ul>
    </nav>
    <div id="testResultContainer" class="container"
         style="margin-left: 0px;margin-right: 0px; margin-top: 70px;width: 100%">

        <div class="row" style="margin-top: 20px;border-bottom: 1px solid #fff;padding-bottom: 10px">
            <div class="col-sm-2">
                <div>
                    <button id="sidebar_switch" type="button" class="hamburger is-closed animated fadeInLeft"
                            data-toggle="offcanvas">
                        <span class="hamb-top"></span>
                        <span class="hamb-middle"></span>
                        <span class="hamb-bottom"></span>
                    </button>
                </div>
            </div>
            <div class="col-sm-10 titlt_button_group">
                <button id="btn_callBack" type="button" class="btn btn-danger" data-toggle="tooltip" data-placement="top" title="返回测试记录"><span class="glyphicon glyphicon-arrow-left"></span></button>

                <button id="btn_refresh" sfrId="" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="刷新"><span class="glyphicon glyphicon-refresh"></span></button>

                <button id="btn_download" type="button" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="下载本次测试结果"><span class="glyphicon glyphicon-download-alt"></span></button>

                <button id="btn_open" type="button" class="btn btn-success" data-toggle="tooltip" data-placement="top" title="展开所有面板"><span class="glyphicon glyphicon-resize-full"></span></button>

                <button id="btn_close" type="button" class="btn btn-info" data-toggle="tooltip" data-placement="top" title="合并所有面板"><span class="glyphicon glyphicon-resize-small"></span></button>

<%--
                <button type="button" class="btn btn-warning">（警告）Warning</button>
--%>
            </div>
        </div>
        <div id="testBasicInfo" class="row" style="margin-top: 10px">
            <div class="col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading panel-heading-heading">
                        <h3 class="panel-title">测试基本信息</h3>
                    </div>
                    <div class="panel-body panel-body-body" style="background: #E3E7EA;display: block">
                        <div class="col-sm-8">
                            <div class="panel panel-default">
                                <div class="panel-heading">测试文件基本信息</div>

                                <div class="panel-body">
                                    <table class="table table-condensed table-bordered table-hover"
                                           id="testPartBasicInfo">
                                        <tr>
                                            <td>Author</td>
                                            <td id="PLMXML_Author">PLMXML.Author</td>
                                        </tr>
                                        <tr>
                                            <td>Timestamp</td>
                                            <td id="PLMXML_Timestamp">PLMXML.date PLMXML.time</td>
                                        </tr>
                                        <tr>
                                            <td>Machine Type</td>
                                            <td id="CheckReport_machineType">CheckReport.machineType
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Machine OS</td>
                                            <td id="CheckReport_machineOS">CheckReport.machineOS</td>
                                        </tr>
                                        <tr>
                                            <td>Hardware/Memory</td>
                                            <td id="CheckReport_hardware_memory">
                                                Processors(CheckReport.machineProcessors)
                                                Memory(CheckReport.machineMemory)
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Part Type</td>
                                            <td id="CheckPart_part_type">CheckPart.objectType</td>
                                        </tr>
                                        <tr>
                                            <td>Name</td>
                                            <td id="CheckPart_name">CheckPart.name</td>
                                        </tr>
                                        <tr>
                                            <td>ID</td>
                                            <td id="CheckPart_id">CheckPart.partId</td>
                                        </tr>
                                        <tr>
                                            <td>Version (mod)</td>
                                            <td id="CheckPart_Version_mod">CheckPart.version (CheckPart.mod)</td>
                                        </tr>
                                        <tr>
                                            <td>Program</td>
                                            <td id="CheckPart_program">CheckPart.program</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="panel panel-default">
                                <div class="panel-heading">测试文件预览图</div>
                                <div class="panel-body">
                                    <table class="table table-bordered" id="testPrtPreView">
                                        <tr>
                                            <td colspan="2" class="text-center">
                                                <%--<img id="prtJpgpreview" data-src="holder.js/140x140" class="img-rounded"
                                                     alt="247x185"
                                                     src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTQwIiBoZWlnaHQ9IjE0MCIgdmlld0JveD0iMCAwIDE0MCAxNDAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjwhLS0KU291cmNlIFVSTDogaG9sZGVyLmpzLzE0MHgxNDAKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+PCFbQ0RBVEFbI2hvbGRlcl8xNzFlZGUxOWZjNyB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQgfSBdXT48L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE3MWVkZTE5ZmM3Ij48cmVjdCB3aWR0aD0iMTQwIiBoZWlnaHQ9IjE0MCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9IjQ0LjA1NDY4NzUiIHk9Ijc0LjU2MDkzNzUiPjE0MHgxNDA8L3RleHQ+PC9nPjwvZz48L3N2Zz4="
                                                     data-holder-rendered="true" style="width: 247px; height: 185px;">--%>
                                                <img id="prtJpgpreview" data-src="holder.js/140x140" class="img-rounded"
                                                     alt="247x185"
                                                     src=""
                                                     data-holder-rendered="true" style="width: 247px; height: 185px;">
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="col-sm-6 text-center">

                                                <div class="testOptionsNumbers-btn">
                                                    <button id="testPrtPreView_testOps" type="button"
                                                            class="btn btn-default btn-block"
                                                            data-container="body" data-toggle="popover"
                                                            data-placement="left" data-content="本次共选择了测试选选项的个数"
                                                            data-original-title="" title="">10
                                                    </button>
                                                </div>
                                                <div class="testOptionsNumbers-title">
                                                    测试选项
                                                </div>

                                            </td>
                                            <td class="col-sm-6 text-center">
                                                <div class="testStatus-btn">
                                                    <button testStatus="btn-danger" id="testPrtPreView_testStatus"
                                                            type="button" class="btn btn-danger btn-block"
                                                            data-container="body" data-toggle="popover"
                                                            data-placement="right" data-content="这里的测试状态取为本次测试状态最为严重的状态"
                                                            data-original-title="" title="">
                                                        error
                                                    </button>
                                                </div>
                                                <div class="testStatus-title">
                                                    测试状态
                                                </div>

                                            </td>
                                        </tr>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%--

        <div class="row" style="margin-top: 10px">
            <div class="col-sm-12">

                <div class="panel panel-info">
                    <div class="panel-heading panel-heading-heading">
                        <h3 class="panel-title">Profile Session &nbsp;&nbsp;<span
                                class="label label-info">message</span>
                        </h3>

                    </div>
                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                        <table class="table table-condensed table-bordered table-hover">

                            <thead>

                            <tr>

                                <th>Name</th>
                                <th>Description</th>
                                <th>Details</th>
                            </tr>

                            </thead>
                            <tbody>
                            <tr>
                                <td>Session</td>
                                <td>Session</td>
                                <td>()()</td>
                            </tr>


                            </tbody>
                        </table>


                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-12">

                                <div class="panel panel-info">
                                    <div class="panel-heading panel-heading-heading">
                                        <h3 class="panel-title">Check clearance analysis has been run or not <span
                                                class="label label-info">message</span>
                                        </h3>

                                    </div>
                                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                        <div class="col-sm-5">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">测试选项基本信息</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">
                                                        <tr>
                                                            <td>中文名称</td>
                                                            <td>哈哈哈</td>
                                                        </tr>
                                                        <tr>
                                                            <td>description</td>
                                                            <td>Check clearance analysis has been run or not</td>
                                                        </tr>
                                                        <tr>
                                                            <td>category</td>
                                                            <td>Assemblies
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>class</td>
                                                            <td>%mqc_check_assembly_clearance_analysis</td>
                                                        </tr>
                                                        <tr>
                                                            <td>name</td>
                                                            <td>%mqc_check_assembly_clearance_analysis_0</td>
                                                        </tr>
                                                        <tr>
                                                            <td>program</td>
                                                            <td>NX 12.0.0.27</td>
                                                        </tr>
                                                        <tr>
                                                            <td>version</td>
                                                            <td>85 (1588055862)</td>
                                                        </tr>
                                                        <tr>
                                                            <td>status</td>
                                                            <td>message</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Parameters</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">

                                                        <thead>
                                                        <tr>
                                                            <th>Parameters</th>
                                                            <th>checkSum=5575</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>


                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-sm-7">

                                            <div class="panel panel-default">
                                                <div class="panel-heading">CheckResult</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">


                                                        <tr>
                                                            <td>Status</td>
                                                            <td>message</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Total Entity Count</td>
                                                            <td>4</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Total Entity Set Count</td>
                                                            <td>0</td>
                                                        </tr>


                                                    </table>
                                                </div>
                                            </div>


                                            <div class="panel panel-default">
                                                <div class="panel-heading">Message</div>
                                                <div class="panel-body">
                                                    <span>This is not an assembly part, this checker does not run.
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="panel panel-default">
                                                <div class="panel-heading">Images</div>

                                                <div class="panel-body">
                                                    <a href="#" target="_blank"> fileName</a>
                                                </div>
                                            </div>


                                            <div class="panel panel-default">
                                                <div class="panel-heading">Detail Info</div>

                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <table class="table table-condensed table-bordered table-hover">

                                                                <thead>
                                                                <tr>
                                                                    <th>Status</th>
                                                                    <th>Name</th>
                                                                    <th>ItemEntity</th>
                                                                    <th>Points</th>
                                                                    <th>Vectors</th>
                                                                    <th>ID</th>
                                                                    <th>ItemLayer</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <tr>
                                                                    <td>message</td>
                                                                    <td></td>
                                                                    <td>Datum Coordinate System(0):C-5-1</td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td>CMfeats.prt C0000000500000001</td>
                                                                    <td>61</td>
                                                                <tr>
                                                                    <td>message</td>
                                                                    <td></td>
                                                                    <td>Block(1):C-18-71</td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td>CMfeats.prt C0000001200000047</td>
                                                                    <td>1</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>message</td>
                                                                    <td></td>
                                                                    <td>Edge Blend(2):C-42-71</td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td>CMfeats.prt C0000002a00000047</td>
                                                                    <td>1</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>message</td>
                                                                    <td></td>
                                                                    <td>Chamfer(3):C-48-71</td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td>CMfeats.prt C0000002a00000047</td>
                                                                    <td>1</td>
                                                                </tr>


                                                                </tbody>


                                                            </table>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>


                                            <div class="panel panel-default">
                                                <div class="panel-heading">Detail Set</div>
                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <table class="table table-condensed table-bordered table-hover">
                                                                <tr>
                                                                    <td>Total Entity Count</td>
                                                                    <td>1</td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-12">

                                <div class="panel panel-primary panel-primary-primary">
                                    <div class="panel-heading panel-heading-heading">
                                        <h3 class="panel-title">Report Boolean Features that Generate Multiple Bodies
                                            <span
                                                    class="label label-primary">skip</span>
                                        </h3>

                                    </div>
                                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">测试选项基本信息</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">
                                                        <tr>
                                                            <td>中文名称</td>
                                                            <td>哈哈哈</td>
                                                        </tr>
                                                        <tr>
                                                            <td>description</td>
                                                            <td>Report Boolean Features that Generate Multiple Bodies
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>category</td>
                                                            <td>Get Information.Modeling
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>class</td>
                                                            <td>%mqc_report_boolean_feature_generating_multiple_bodies
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>name</td>
                                                            <td>
                                                                %mqc_report_boolean_feature_generating_multiple_bodies_3
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>program</td>
                                                            <td>NX 12.0.0.27</td>
                                                        </tr>
                                                        <tr>
                                                            <td>version</td>
                                                            <td>85 (1588055862)</td>
                                                        </tr>
                                                        <tr>
                                                            <td>status</td>
                                                            <td>skip</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Message</div>

                                                <div class="panel-body">
                                                    <span>
                                                        There are no boolean features.

                                                    </span>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-12">

                                <div class="panel panel-success">
                                    <div class="panel-heading panel-heading-heading">
                                        <h3 class="panel-title">Check Paths of Components
                                            <span class="label label-success">pass</span>
                                        </h3>

                                    </div>
                                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">测试选项基本信息</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">
                                                        <tr>
                                                            <td>中文名称</td>
                                                            <td>哈哈哈</td>
                                                        </tr>
                                                        <tr>
                                                            <td>description</td>
                                                            <td>Check Paths of Components</td>
                                                        </tr>
                                                        <tr>
                                                            <td>category</td>
                                                            <td>Assemblies
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>class</td>
                                                            <td>%mqc_check_assembly_paths</td>
                                                        </tr>
                                                        <tr>
                                                            <td>name</td>
                                                            <td>%mqc_check_assembly_paths_1</td>
                                                        </tr>
                                                        <tr>
                                                            <td>program</td>
                                                            <td>NX 12.0.0.27</td>
                                                        </tr>
                                                        <tr>
                                                            <td>version</td>
                                                            <td>85 (1588055862)</td>
                                                        </tr>
                                                        <tr>
                                                            <td>status</td>
                                                            <td>pass</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Message</div>

                                                <div class="panel-body">
                                    <span>
                                        pass不许要进行测试

                                    </span>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-12">

                                <div class="panel panel-warning">
                                    <div class="panel-heading panel-heading-heading">
                                        <h3 class="panel-title">Check Paths of Components
                                            <span class="label label-warning">warning</span>
                                        </h3>

                                    </div>
                                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">测试选项基本信息</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">
                                                        <tr>
                                                            <td>中文名称</td>
                                                            <td>哈哈哈</td>
                                                        </tr>
                                                        <tr>
                                                            <td>description</td>
                                                            <td>Check Angle Range Between Two Lines</td>
                                                        </tr>
                                                        <tr>
                                                            <td>category</td>
                                                            <td>Template.Measurement
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>class</td>
                                                            <td>%measure_angle_between_2lines</td>
                                                        </tr>
                                                        <tr>
                                                            <td>name</td>
                                                            <td>%measure_angle_between_2lines_0</td>
                                                        </tr>
                                                        <tr>
                                                            <td>program</td>
                                                            <td>NX 12.0.0.27 - ug_check_part.exe</td>
                                                        </tr>
                                                        <tr>
                                                            <td>version</td>
                                                            <td>85 (1588055862)</td>
                                                        </tr>
                                                        <tr>
                                                            <td>status</td>
                                                            <td>warning</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Message</div>

                                                <div class="panel-body">
                                    <span>
                                       No values given to the parameters.

                                    </span>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-12">

                                <div class="panel panel-danger">
                                    <div class="panel-heading panel-heading-heading">
                                        <h3 class="panel-title">Check Paths of Components
                                            <span class="label label-danger">fail</span>
                                        </h3>

                                    </div>
                                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">测试选项基本信息</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">
                                                        <tr>
                                                            <td>中文名称</td>
                                                            <td>哈哈哈</td>
                                                        </tr>
                                                        <tr>
                                                            <td>description</td>
                                                            <td>Check Minimum Distance Range</td>
                                                        </tr>
                                                        <tr>
                                                            <td>category</td>
                                                            <td>Template.Measurement
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>class</td>
                                                            <td>%measure_minimum_dist</td>
                                                        </tr>
                                                        <tr>
                                                            <td>name</td>
                                                            <td>%measure_minimum_dist_3</td>
                                                        </tr>
                                                        <tr>
                                                            <td>program</td>
                                                            <td>NX 12.0.0.27 - ug_check_part.exe</td>
                                                        </tr>
                                                        <tr>
                                                            <td>version</td>
                                                            <td>85 (1588055862)</td>
                                                        </tr>
                                                        <tr>
                                                            <td>status</td>
                                                            <td>fail</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Message</div>

                                                <div class="panel-body">
                                    <span>
                                       Fail to check due to invalid geometry objects.

                                    </span>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>

--%>

        <%--<div class="row" style="margin-top: 10px">
            <div class="col-sm-12">

                <div class="panel panel-info">
                    <div class="panel-heading panel-heading-heading">
                        <h3 class="panel-title">Profile <span>Session</span> &nbsp;&nbsp;
                            <span class="label label-info">message</span>
                        </h3>
                    </div>
                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                        <table class="table table-condensed table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Details</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Session</td>
                                <td>Session</td>
                                <td>()()</td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-12">

                                <div class="panel panel-info">
                                    <div class="panel-heading panel-heading-heading">
                                        <h3 class="panel-title">Check clearance analysis has been run or not <span
                                                class="label label-info">message</span>
                                        </h3>

                                    </div>
                                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                        <div class="col-sm-5">
                                            <div class="panel panel-default basicInfoOfTestOpt">
                                                <div class="panel-heading">测试选项基本信息</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">
                                                        <tr>
                                                            <td>中文名称</td>
                                                            <td>哈哈哈</td>
                                                        </tr>
                                                        <tr>
                                                            <td>description</td>
                                                            <td>Check clearance analysis has been run or not</td>
                                                        </tr>
                                                        <tr>
                                                            <td>category</td>
                                                            <td>Assemblies
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>class</td>
                                                            <td>%mqc_check_assembly_clearance_analysis</td>
                                                        </tr>
                                                        <tr>
                                                            <td>name</td>
                                                            <td>%mqc_check_assembly_clearance_analysis_0</td>
                                                        </tr>
                                                        <tr>
                                                            <td>program</td>
                                                            <td>NX 12.0.0.27</td>
                                                        </tr>
                                                        <tr>
                                                            <td>version</td>
                                                            <td>85 (1588055862)</td>
                                                        </tr>
                                                        <tr>
                                                            <td>status</td>
                                                            <td>message</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Parameters</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">

                                                        <thead>
                                                        <tr>
                                                            <th>Parameters</th>
                                                            <th>checkSum=5575</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>title</td>
                                                            <td>value</td>
                                                        </tr>

                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-sm-7">

                                            <div class="panel panel-default">
                                                <div class="panel-heading">CheckResult</div>
                                                <div class="panel-body">
                                                    <table class="table table-condensed table-bordered table-hover">


                                                        <tr>
                                                            <td>Status</td>
                                                            <td>message</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Total Entity Count</td>
                                                            <td>4</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Total Entity Set Count</td>
                                                            <td>0</td>
                                                        </tr>


                                                    </table>
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Detail Info</div>
                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <table class="table table-condensed table-bordered table-hover">
                                                                <thead>
                                                                <tr>
                                                                    <th>Status</th>
                                                                    <th>Name</th>
                                                                    <th>ItemEntity</th>
                                                                    <th>Points</th>
                                                                    <th>Vectors</th>
                                                                    <th>ID</th>
                                                                    <th>ItemLayer</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <tr>
                                                                    <td>message</td>
                                                                    <td></td>
                                                                    <td>Chamfer(3):C-48-71</td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td>CMfeats.prt C0000002a00000047</td>
                                                                    <td>1</td>
                                                                </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>--%>
    </div>

<%--

    <div class="row" style="margin-top: 10px">
        <div class="col-sm-12">

            <div class="panel panel-info">
                <div class="panel-heading panel-heading-heading">
                    <h3 class="panel-title">Profile Session<span
                            class="label label-info">message</span>
                    </h3>

                </div>
                <div class="panel-body panel-body-body" style="background: #E3E7EA">
                    <table class="table table-condensed table-bordered table-hover">

                        <thead>

                        <tr>

                            <th>Name</th>
                            <th>Description</th>
                            <th>Details</th>
                        </tr>

                        </thead>
                        <tbody>
                        <tr>
                            <td>Session</td>
                            <td>Session</td>
                            <td>()()</td>
                        </tr>


                        </tbody>
                    </table>


                    <div class="row" style="margin-top: 10px">
                        <div class="col-sm-12">

                            <div class="panel panel-info">
                                <div class="panel-heading panel-heading-heading">
                                    <h3 class="panel-title">Check clearance analysis has been run or not <span
                                            class="label label-info">message</span>
                                    </h3>

                                </div>
                                <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                    <div class="col-sm-5">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">测试选项基本信息</div>
                                            <div class="panel-body">
                                                <table class="table table-condensed table-bordered table-hover">
                                                    <tr>
                                                        <td>中文名称</td>
                                                        <td>哈哈哈</td>
                                                    </tr>
                                                    <tr>
                                                        <td>description</td>
                                                        <td>Check clearance analysis has been run or not</td>
                                                    </tr>
                                                    <tr>
                                                        <td>category</td>
                                                        <td>Assemblies
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>class</td>
                                                        <td>%mqc_check_assembly_clearance_analysis</td>
                                                    </tr>
                                                    <tr>
                                                        <td>name</td>
                                                        <td>%mqc_check_assembly_clearance_analysis_0</td>
                                                    </tr>
                                                    <tr>
                                                        <td>program</td>
                                                        <td>NX 12.0.0.27</td>
                                                    </tr>
                                                    <tr>
                                                        <td>version</td>
                                                        <td>85 (1588055862)</td>
                                                    </tr>
                                                    <tr>
                                                        <td>status</td>
                                                        <td>message</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Parameters</div>
                                            <div class="panel-body">
                                                <table class="table table-condensed table-bordered table-hover">

                                                    <thead>
                                                    <tr>
                                                        <th>Parameters</th>
                                                        <th>checkSum=5575</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>
                                                    <tr>
                                                        <td>title</td>
                                                        <td>value</td>
                                                    </tr>


                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="col-sm-7">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Message</div>

                                            <div class="panel-body">
                                    <span>
                                    This is not an assembly part, this checker does not run.

                                    </span>


                                            </div>
                                        </div>

                                        <div class="panel panel-default">
                                            <div class="panel-heading">Images</div>

                                            <div class="panel-body">
                                                <a href="#" target="_blank"> fileName</a>


                                            </div>
                                        </div>


                                        <div class="panel panel-default">
                                            <div class="panel-heading">Detail Info</div>

                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <table class="table table-condensed table-bordered table-hover">

                                                            <thead>
                                                            <tr>
                                                                <th>Status</th>
                                                                <th>Name</th>
                                                                <th>ItemEntity</th>
                                                                <th>Points</th>
                                                                <th>Vectors</th>
                                                                &lt;%&ndash;
                                                                                                                                    <th>Message</th>
                                                                &ndash;%&gt;
                                                                &lt;%&ndash;这是检测状态  五种状态&ndash;%&gt;
                                                                <th>ID</th>
                                                                <th>ItemLayer</th>
                                                                &lt;%&ndash;
                                                                                                                                    <th>Image</th>
                                                                &ndash;%&gt;
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr>
                                                                <td>message</td>
                                                                <td></td>
                                                                <td>Datum Coordinate System(0):C-5-1</td>
                                                                <td></td>
                                                                <td></td>
                                                                <td>CMfeats.prt C0000000500000001</td>
                                                                <td>61</td>
                                                            <tr>
                                                                <td>message</td>
                                                                <td></td>
                                                                <td>Block(1):C-18-71</td>
                                                                <td></td>
                                                                <td></td>
                                                                <td>CMfeats.prt C0000001200000047</td>
                                                                <td>1</td>
                                                            </tr>
                                                            <tr>
                                                                <td>message</td>
                                                                <td></td>
                                                                <td>Edge Blend(2):C-42-71</td>
                                                                <td></td>
                                                                <td></td>
                                                                <td>CMfeats.prt C0000002a00000047</td>
                                                                <td>1</td>
                                                            </tr>
                                                            <tr>
                                                                <td>message</td>
                                                                <td></td>
                                                                <td>Chamfer(3):C-48-71</td>
                                                                <td></td>
                                                                <td></td>
                                                                <td>CMfeats.prt C0000002a00000047</td>
                                                                <td>1</td>
                                                            </tr>


                                                            </tbody>


                                                        </table>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>


                                        <div class="panel panel-default">
                                            <div class="panel-heading">Detail Set</div>

                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <table class="table table-condensed table-bordered table-hover">

                                                            <tr>
                                                                <td>Total Entity Count</td>
                                                                <td>1</td>
                                                            </tr>


                                                        </table>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-sm-12">

                            <div class="panel panel-primary panel-primary-primary">
                                <div class="panel-heading panel-heading-heading">
                                    <h3 class="panel-title">Report Boolean Features that Generate Multiple Bodies
                                        <span
                                                class="label label-primary">skip</span>
                                    </h3>

                                </div>
                                <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">测试选项基本信息</div>
                                            <div class="panel-body">
                                                <table class="table table-condensed table-bordered table-hover">
                                                    <tr>
                                                        <td>中文名称</td>
                                                        <td>哈哈哈</td>
                                                    </tr>
                                                    <tr>
                                                        <td>description</td>
                                                        <td>Report Boolean Features that Generate Multiple Bodies
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>category</td>
                                                        <td>Get Information.Modeling
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>class</td>
                                                        <td>%mqc_report_boolean_feature_generating_multiple_bodies
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>name</td>
                                                        <td>
                                                            %mqc_report_boolean_feature_generating_multiple_bodies_3
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>program</td>
                                                        <td>NX 12.0.0.27</td>
                                                    </tr>
                                                    <tr>
                                                        <td>version</td>
                                                        <td>85 (1588055862)</td>
                                                    </tr>
                                                    <tr>
                                                        <td>status</td>
                                                        <td>skip</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Message</div>

                                            <div class="panel-body">
                                                    <span>
                                                        There are no boolean features.

                                                    </span>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-sm-12">

                            <div class="panel panel-success">
                                <div class="panel-heading panel-heading-heading">
                                    <h3 class="panel-title">Check Paths of Components
                                        <span class="label label-success">pass</span>
                                    </h3>

                                </div>
                                <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">测试选项基本信息</div>
                                            <div class="panel-body">
                                                <table class="table table-condensed table-bordered table-hover">
                                                    <tr>
                                                        <td>中文名称</td>
                                                        <td>哈哈哈</td>
                                                    </tr>
                                                    <tr>
                                                        <td>description</td>
                                                        <td>Check Paths of Components</td>
                                                    </tr>
                                                    <tr>
                                                        <td>category</td>
                                                        <td>Assemblies
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>class</td>
                                                        <td>%mqc_check_assembly_paths</td>
                                                    </tr>
                                                    <tr>
                                                        <td>name</td>
                                                        <td>%mqc_check_assembly_paths_1</td>
                                                    </tr>
                                                    <tr>
                                                        <td>program</td>
                                                        <td>NX 12.0.0.27</td>
                                                    </tr>
                                                    <tr>
                                                        <td>version</td>
                                                        <td>85 (1588055862)</td>
                                                    </tr>
                                                    <tr>
                                                        <td>status</td>
                                                        <td>pass</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Message</div>

                                            <div class="panel-body">
                                    <span>
                                        pass不许要进行测试

                                    </span>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row" style="margin-top: 10px">
                        <div class="col-sm-12">

                            <div class="panel panel-warning">
                                <div class="panel-heading panel-heading-heading">
                                    <h3 class="panel-title">Check Paths of Components
                                        <span class="label label-warning">warning</span>
                                    </h3>

                                </div>
                                <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">测试选项基本信息</div>
                                            <div class="panel-body">
                                                <table class="table table-condensed table-bordered table-hover">
                                                    <tr>
                                                        <td>中文名称</td>
                                                        <td>哈哈哈</td>
                                                    </tr>
                                                    <tr>
                                                        <td>description</td>
                                                        <td>Check Angle Range Between Two Lines</td>
                                                    </tr>
                                                    <tr>
                                                        <td>category</td>
                                                        <td>Template.Measurement
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>class</td>
                                                        <td>%measure_angle_between_2lines</td>
                                                    </tr>
                                                    <tr>
                                                        <td>name</td>
                                                        <td>%measure_angle_between_2lines_0</td>
                                                    </tr>
                                                    <tr>
                                                        <td>program</td>
                                                        <td>NX 12.0.0.27 - ug_check_part.exe</td>
                                                    </tr>
                                                    <tr>
                                                        <td>version</td>
                                                        <td>85 (1588055862)</td>
                                                    </tr>
                                                    <tr>
                                                        <td>status</td>
                                                        <td>warning</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Message</div>

                                            <div class="panel-body">
                                    <span>
                                       No values given to the parameters.

                                    </span>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-sm-12">

                            <div class="panel panel-danger">
                                <div class="panel-heading panel-heading-heading">
                                    <h3 class="panel-title">Check Paths of Components
                                        <span class="label label-danger">fail</span>
                                    </h3>

                                </div>
                                <div class="panel-body panel-body-body" style="background: #E3E7EA">
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">测试选项基本信息</div>
                                            <div class="panel-body">
                                                <table class="table table-condensed table-bordered table-hover">
                                                    <tr>
                                                        <td>中文名称</td>
                                                        <td>哈哈哈</td>
                                                    </tr>
                                                    <tr>
                                                        <td>description</td>
                                                        <td>Check Minimum Distance Range</td>
                                                    </tr>
                                                    <tr>
                                                        <td>category</td>
                                                        <td>Template.Measurement
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>class</td>
                                                        <td>%measure_minimum_dist</td>
                                                    </tr>
                                                    <tr>
                                                        <td>name</td>
                                                        <td>%measure_minimum_dist_3</td>
                                                    </tr>
                                                    <tr>
                                                        <td>program</td>
                                                        <td>NX 12.0.0.27 - ug_check_part.exe</td>
                                                    </tr>
                                                    <tr>
                                                        <td>version</td>
                                                        <td>85 (1588055862)</td>
                                                    </tr>
                                                    <tr>
                                                        <td>status</td>
                                                        <td>fail</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Message</div>

                                            <div class="panel-body">
                                    <span>
                                       Fail to check due to invalid geometry objects.

                                    </span>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
--%>

</div>


</div>

<script src="<%=basePath%>plugins/jquery.min.js"></script>
<script src="<%=basePath%>plugins/bootstrap.js"></script>
<script src="<%=basePath%>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>plugins/locales/bootstrap-datetimepicker.zh-CN.js"
        charset="UTF-8"></script>

<script>
    var srId = <%=recordId%>;

    $(document).ready(function () {

        $("#btn_callBack").click(function () {
            var f=document.createElement('form');
            f.style.display='none';
            f.action="<%=basePath%>"+"testrecord/testrecord.jsp";
            f.method='post';
            document.body.appendChild(f);
            f.submit();
        });
        $("#btn_download").click(function () {

            var f=document.createElement('form');
            f.style.display='none';
            f.action="<%=basePath%>"+"submitRecord/downloadZip";
            f.method='get';
            f.innerHTML="<input type=\"hidden\" name=\"srId\" value=\""+srId+"\"/>";
            document.body.appendChild(f);
            f.submit();

        });

        $("#btn_open").click(function () {


            $("#testResultContainer").find(".panel-body-body").show();

        });
        $("#btn_close").click(function () {


            $("#testResultContainer").find(".panel-body-body").hide();

        });
        $("#btn_refresh").click(function () {

            var sfrId=$(this).attr("sfrId");
            //console.log(sfrId);
            $("#sidebar_switch").click();
            initTestResultData();
            initThePrtTestResult(sfrId);
        });

        var trigger = $('.hamburger'),
            overlay = $('.overlay'),
            isClosed = false;

        trigger.click(function () {
            hamburger_cross();
        });

        function hamburger_cross() {

            if (isClosed == true) {
                overlay.hide();
                trigger.removeClass('is-open');
                trigger.addClass('is-closed');
                isClosed = false;
            } else {
                overlay.show();
                trigger.removeClass('is-closed');
                trigger.addClass('is-open');
                isClosed = true;
            }
        }
        $("[data-toggle='tooltip']").tooltip({
            trigger: 'hover'
        });

        $('[data-toggle="offcanvas"]').click(function () {
            $('#wrapper').toggleClass('toggled');
        });

        /*        $(".panel-heading-heading").click(function () {
                    $(this).next("div[class='panel-body panel-body-body']").toggle();
                })*/


    });

    function getStatus(profile_status) {
        var status;
        if (profile_status == "skip") {
            status = "primary";

        } else if (profile_status == "pass") {
            status = "success";

        } else if (profile_status == "message") {
            status = "info";

        } else if (profile_status == "warning") {
            status = "warning";

        } else if (profile_status == "fail") {
            status = "danger";

        } else {
            status = "default";
        }
        return status;
    }


    function initThePrtTestResult(sfrId) {

        $("#btn_refresh").attr("sfrId", sfrId);
        $(".profile_row_title").remove();
        //console.log(sfrId);
        //请求数据
        $.ajax({
            url: "<%=basePath%>" + "submitRecord/getThePrtTestResult",
            type: 'get',
            dataType: "json",
            async: false,//变成同步请求
            data: {sfrId: sfrId},
            success: function (obj, response, status) {
                //console.log(obj);

                if (obj.success) {
                    /*初始化xml文件信息*/
                    initxmlFiles(obj.obj.xmlFile);
                    /*初始化prt文件预览图*/
                    initprtJpgpreview(obj.obj.jpgFilePath);
                    $(".panel-heading-heading").click(function () {
                        $(this).next("div[class='panel-body panel-body-body']").toggle();
                        $(this).next("div[class='panel-body panel-body-body profilePannel']").toggle();
                    })
                } else {
                    //console.log(obj);
                    alert(obj.message);
                    //window.location.href = "<%=basePath%>";
                }
            }
        });
    }

    /*初始化文件预览图*/
    function initprtJpgpreview(jpgFilePath) {
        $("#prtJpgpreview").attr("src", "<%=basePath%>" + jpgFilePath);
    }

    /*初始化所有测试结果，即xml中的必须元素*/
    function initxmlFiles(xmlFile) {
        var jsonFile = $.parseJSON(xmlFile)
        //console.log(jsonFile);
        var checkPart = initTestPartBasicInfo(jsonFile.PLMXML);
        initCheckPart(checkPart);
    }

    function initProfile(profile) {
        /*模板
        * <div class="row" style="margin-top: 10px">
            <div class="col-sm-12">

                <div id="profile_panel_title_div" class="panel panel-info">
                    <div class="panel-heading panel-heading-heading">
                        <h3 class="panel-title">Profile <span id="profile_name_panel_title">Session</span> &nbsp;&nbsp;<span id="profile_status_panel_title"
                                class="label label-info">message</span>
                        </h3>

                    </div>
                    <div class="panel-body panel-body-body" style="background: #E3E7EA">
                        <table id="profile_title_table" class="table table-condensed table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Details</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td id="profile_name">Session</td>
                                <td id="profile_description">Session</td>
                                <td id="profile_details">()()</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        * */
        var profile_status = profile.status;
        var profile_description = profile.description;
        var profile_name = profile.name;
        var profile_class = profile.class;
        var profile_modName = profile.modName;
        var status = getStatus(profile_status);
        if (typeof profile_modName === 'undefined') {

            profile_modName = "";
        }
        var $profilePannel = $("<div class=\"row profile_row_title\" style=\"margin-top: 10px\">\n" +
            "            <div class=\"col-sm-12\">\n" +
            "\n" +
            "                <div class=\"panel panel-" + status + "\">\n" +
            "                    <div class=\"panel-heading panel-heading-heading\">\n" +
            "                        <h3 class=\"panel-title\">Profile <span>" + profile_description + "</span> &nbsp;&nbsp;\n" +
            "                            <span class=\"label label-" + status + "\">" + profile_status + "</span>\n" +
            "                        </h3>\n" +
            "                    </div>\n" +
            "                    <div class=\"panel-body panel-body-body profilePannel\" style=\"background: #E3E7EA\">\n" +
            "                        <table class=\"table table-condensed table-bordered table-hover\">\n" +
            "                            <thead>\n" +
            "                            <tr>\n" +
            "                                <th>Name</th>\n" +
            "                                <th>Description</th>\n" +
            "                                <th>Details</th>\n" +
            "                            </tr>\n" +
            "                            </thead>\n" +
            "                            <tbody>\n" +
            "                            <tr>\n" +
            "                                <td>" + profile_name + "</td>\n" +
            "                                <td>" + profile_description + "</td>\n" +
            "                                <td>(" + profile_modName + ")(" + profile_class + ")</td>\n" +
            "                            </tr>\n" +
            "                            </tbody>\n" +
            "                        </table>\n" +
            "                    </div>\n" +
            "                </div>\n" +
            "            </div>\n" +
            "        </div>");

        //$profilePannel

        var chk_Checkers = profile.chk_Checker;//数组
        if (!(chk_Checkers instanceof Array)) {
            chk_Checkers = [chk_Checkers];
        }

        /*注意：在使用forEach前需要确保它是array类型的数据否则会报异常*/
        chk_Checkers.forEach(function (value, index) {

            var $checkerPannel = initCheckerPannel(value);
            $profilePannel.find(".profilePannel").append($checkerPannel);

        })


        $("#testBasicInfo").after($profilePannel);


    }

    function initCheckerPannel(checker) {
        //console.log(checker);
        var checker_status = checker.status;
        var status = getStatus(checker_status);
        var description = checker.description;
        var $checkerPannel = $("<div class=\"row\" style=\"margin-top: 10px\">\n" +
            "                            <div class=\"col-sm-12\">\n" +
            "\n" +
            "                                <div class=\"panel panel-" + status + "\">\n" +
            "                                    <div class=\"panel-heading panel-heading-heading\">\n" +
            "                                        <h3 class=\"panel-title\">" + description + " &nbsp;&nbsp;<span\n" +
            "                                                class=\"label label-" + status + "\">" + checker_status + "</span>\n" +
            "                                        </h3>\n" +
            "\n" +
            "                                    </div>\n" +
            "                                    <div class=\"panel-body panel-body-body\" style=\"background: #E3E7EA\">\n" +
            "                                        <div class=\"col-sm-5\">\n" +
            "\n" +
            "\n" +
            "                                        </div>\n" +
            "\n" +
            "                                        <div class=\"col-sm-7\">\n" +
            "\n" +
            "                                        </div>\n" +
            "\n" +
            "                                    </div>\n" +
            "                                </div>\n" +
            "                            </div>\n" +
            "                        </div>");


        var $basicInfoOfTestOpt = initBasicInfoOfTestOpt(checker);
        $checkerPannel.find(".col-sm-5").append($basicInfoOfTestOpt);

        var $checkerParameters = initCheckerParameters(checker.chk_Parameters);
        $checkerPannel.find(".col-sm-5").append($checkerParameters);

        var chk_CheckResult = checker.chk_CheckResult;
        if (typeof chk_CheckResult !="undefined"){
            //console.log("asdad")

            var $checkResult = initCheckResult(chk_CheckResult);

            $checkerPannel.find(".col-sm-7").append($checkResult);

            var CheckMessageInfo = chk_CheckResult.chk_CheckMessageInfo;
            if (typeof CheckMessageInfo != "undefined") {
                var $checkMessage = initCheckMessageInfo(CheckMessageInfo);
                $checkerPannel.find(".col-sm-7").append($checkMessage);
            }
            var ImageRef = chk_CheckResult.chk_ImageRef;
            if (typeof ImageRef != "undefined") {
                var $imageRef = initImageRef(ImageRef);
                $checkerPannel.find(".col-sm-7").append($imageRef);
            }

            var DetailInfo = chk_CheckResult.chk_DetailInfo;
            if (typeof DetailInfo != "undefined") {
                //console.log(DetailInfo);
                if (!(DetailInfo instanceof Array)) {
                    DetailInfo = [DetailInfo];
                }
                var $detailInfo = initDetailInfo(DetailInfo);

                $checkerPannel.find(".col-sm-7").append($detailInfo);
            }

            var DetailSetInfo = chk_CheckResult.chk_DetailSetInfo;
            if (typeof DetailSetInfo != "undefined") {

                var $detailSetInfo = initDetailSetInfo(DetailSetInfo);
                $checkerPannel.find(".col-sm-7").append($detailSetInfo);

            }
        }



        return $checkerPannel;


    }

    function initCheckMessageInfo(CheckMessageInfo) {

        var $checkMessage = $("<div class=\"panel panel-default\">\n" +
            "                                                <div class=\"panel-heading\">Message</div>\n" +
            "                                                <div class=\"panel-body\">\n" +
            "                                                    <textarea class=\"form-control\" rows=\"8\">" + CheckMessageInfo + "\n" +
            "                                                    </textarea >\n" +
            "                                                </div>\n" +
            "                                            </div>\n");

        return $checkMessage;
    }

    function initImageRef(ImageRef) {

        var $imageRef = $("<div class=\"panel panel-default\">\n" +
            "                                                <div class=\"panel-heading\">Images</div>\n" +
            "\n" +
            "                                                <div class=\"panel-body\">\n" +
            "                                                    <a href=\"" + ImageRef.filename + "\" target=\"_blank\"> fileName</a>\n" +
            "                                                </div>\n" +
            "                                            </div>");
        return $imageRef;
    }

    function initDetailSetInfo(DetailInfo) {

        /*
        <div class="panel panel-default">
            <div class="panel-heading">Detail Set</div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-condensed table-bordered table-hover">
                            <tr>
                                <td>Total Entity Count</td>
                                <td>1</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        * */
        var totalEntityCount = DetailInfo.totalEntityCount;
        if (typeof totalEntityCount == "undefined") {
            totalEntityCount = 0;
        }


        var $detailSetInfo = $("<div class=\"panel panel-default\">\n" +
            "    <div class=\"panel-heading\">Detail Set</div>\n" +
            "    <div class=\"panel-body\">\n" +
            "        <div class=\"row\">\n" +
            "            <div class=\"col-sm-12\">\n" +
            "                <table class=\"table table-condensed table-bordered table-hover\">\n" +
            "                    <tr>\n" +
            "                        <td>Total Entity Count</td>\n" +
            "                        <td>" + totalEntityCount + "</td>\n" +
            "                    </tr>\n" +
            "                </table>\n" +
            "            </div>\n" +
            "        </div>\n" +
            "    </div>\n" +
            "</div>");

        var chk_CheckMessageInfo = DetailInfo.chk_CheckMessageInfo;
        if (typeof chk_CheckMessageInfo != "undefined") {

            var $checkMessageInfo = initCheckMessageInfo(chk_CheckMessageInfo);
            $detailSetInfo.find("table").after($checkMessageInfo);

        }

        var chk_ImageRef = DetailInfo.chk_ImageRef;
        if (typeof chk_ImageRef != "undefined") {
            var $imageRef = initImageRef(chk_ImageRef);
            $detailSetInfo.find("table").after($imageRef);

        }

        var DetailInfo = DetailInfo.chk_DetailInfo;
        if (typeof DetailInfo != "undefined") {
            var $detailInfo = initDetailInfo(DetailInfo);
            $detailSetInfo.find("table").append($detailInfo);
        }

        return $detailSetInfo;


    }

    function initDetailInfo(DetailSetInfo) {
        /*

        <tr>
            <td>message</td>
            <td></td>
            <td>Chamfer(3):C-48-71</td>
            <td></td>
            <td></td>
            <td>CMfeats.prt C0000002a00000047</td>
            <td>1</td>
        </tr>


        <div class="panel panel-default">
            <div class="panel-heading">Detail Info</div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-condensed table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>Status</th>
                                <th>Name</th>
                                <th>ItemEntity</th>
                                <th>Points</th>
                                <th>Vectors</th>
                                <th>ID</th>
                                <th>ItemLayer</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        * */


        var $detailInfo = $("<div class=\"panel panel-default\">\n" +
            "    <div class=\"panel-heading\">Detail Info</div>\n" +
            "    <div class=\"panel-body\">\n" +
            "        <div class=\"row\">\n" +
            "            <div class=\"col-sm-12\">\n" +
            "                <table class=\"table table-condensed table-bordered table-hover\">\n" +
            "                    <thead>\n" +
            "                    <tr>\n" +
            "                        <th>Status</th>\n" +
            "                        <th>Name</th>\n" +
            "                        <th>ItemEntity</th>\n" +
            "                        <th>Points</th>\n" +
            "                        <th>Vectors</th>\n" +
            "                        <th>ID</th>\n" +
            "                        <th>ItemLayer</th>\n" +
            "                    </tr>\n" +
            "                    </thead>\n" +
            "                    <tbody>\n" +
            "                    </tbody>\n" +
            "                </table>\n" +
            "            </div>\n" +
            "        </div>\n" +
            "    </div>\n" +
            "</div>");

        DetailSetInfo.forEach(function (value, index) {
            var status = value.status;
            if (typeof status == "undefined") {
                status = "";
            }
            var name = value.itemName;
            if (typeof name == "undefined") {
                name = "";
            }
            var itemEntity = value.itemEntity;
            if (typeof itemEntity == "undefined") {
                itemEntity = "";
            }
            var points = value.points;
            if (typeof points == "undefined") {
                points = "";
            }
            var vectors = value.vectors;
            if (typeof vectors == "undefined") {
                vectors = "";
            }
            var id = value.itemEntityId;
            if (typeof id == "undefined") {
                id = "";
            }
            var itemLayer = value.itemLayer;
            if (typeof itemLayer == "undefined") {
                itemLayer = "";
            }
            var chk_CheckMessageInfo = value.chk_CheckMessageInfo;
            if (typeof chk_CheckMessageInfo != "undefined") {

                var $checkMessageInfo = initCheckMessageInfo(chk_CheckMessageInfo);
                $detailInfo.find("table").after($checkMessageInfo);

            }

            var chk_ImageRef = value.chk_ImageRef;
            if (typeof chk_ImageRef != "undefined") {
                var $imageRef = initImageRef(chk_ImageRef);
                $detailInfo.find("table").after($imageRef);

            }
            var $tableTr = $("<tr>\n" +
                "    <td>" + status + "</td>\n" +
                "    <td>" + name + "</td>\n" +
                "    <td>" + itemEntity + "</td>\n" +
                "    <td>" + points + "</td>\n" +
                "    <td>" + vectors + "</td>\n" +
                "    <td>" + id + "</td>\n" +
                "    <td>" + itemLayer + "</td>\n" +
                "</tr>");

            $detailInfo.find("tbody").append($tableTr);

        })


        return $detailInfo;
    }


    function initCheckResult(checkResult) {

        var status = checkResult.status;
        var totalEntityCount = checkResult.totalEntityCount;
        var totalSetCount = checkResult.totalSetCount;
        if (typeof totalEntityCount == "undefined") {
            totalEntityCount = 0;
        }
        if (typeof totalSetCount == "undefined") {
            totalSetCount = 0;
        }

        var $checkResult = $("<div class=\"panel panel-default\">\n" +
            "                                                <div class=\"panel-heading\">CheckResult</div>\n" +
            "                                                <div class=\"panel-body\">\n" +
            "                                                    <table class=\"table table-condensed table-bordered table-hover\">\n" +
            "\n" +
            "\n" +
            "                                                        <tr>\n" +
            "                                                            <td>Status</td>\n" +
            "                                                            <td>" + status + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>Total Entity Count</td>\n" +
            "                                                            <td>" + totalEntityCount + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>Total Entity Set Count</td>\n" +
            "                                                            <td>" + totalSetCount + "</td>\n" +
            "                                                        </tr>\n" +
            "\n" +
            "\n" +
            "                                                    </table>\n" +
            "                                                </div>\n" +
            "                                            </div>");


        return $checkResult;

        //console.log(checkResult);
    }


    function initCheckerParameters(parameters) {
        /*
        <tr>
            <td>title</td>
            <td>value</td>
        </tr>
        <div class="panel panel-default">
            <div class="panel-heading">Parameters</div>
            <div class="panel-body">
                <table class="table table-condensed table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>Parameters</th>
                        <th>checkSum=5575</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        * */
        //console.log(parameters);
        var checkSum = parameters.checkSum;
        var parameter = parameters.chk_Parameter;//数组
        if (!(parameter instanceof Array)) {

            parameter = [parameter];
        }

        var $checkerParameters = $("<div class=\"panel panel-default\">\n" +
            "    <div class=\"panel-heading\">Parameters</div>\n" +
            "    <div class=\"panel-body\">\n" +
            "        <table class=\"table table-condensed table-bordered table-hover\">\n" +
            "            <thead>\n" +
            "            <tr>\n" +
            "                <th>Parameters</th>\n" +
            "                <th>checkSum=" + checkSum + "</th>\n" +
            "            </tr>\n" +
            "            </thead>\n" +
            "            <tbody>\n" +
            "            </tbody>\n" +
            "        </table>\n" +
            "    </div>\n" +
            "</div>");

        parameter.forEach(function (value, index) {
            var parameter_label = value.label;
            var parameter_value = value.value;
            var $tr = $("<tr>\n" +
                "    <td>" + parameter_label + "</td>\n" +
                "    <td>" + parameter_value + "</td>\n" +
                "</tr>");
            $checkerParameters.find("tbody").append($tr);
        })
        return $checkerParameters;


    }

    function initBasicInfoOfTestOpt(checker) {
        var checker_description = checker.description;
        var checker_category = checker.category;
        var checker_class = checker.class;
        var checker_name = checker.name;
        var checker_program = checker.program;
        var checker_version = checker.version = " (" + checker.mod + ")";
        var checker_status = checker.status;
        var ruleName = "";

        //var status = getStatus(checker_status);
        $.ajax({
            url: "<%=basePath%>" + "Rule/getRuleByEnglishName",
            type: 'get',
            dataType: "json",
            async: false,//发送同步请求
            data: {englishName: checker_description},
            success: function (obj, response, status) {
                if (obj.success) {
                    ruleName = obj.obj.ruleName;
                } else {
                    console.log("该测试选项的中文名不存在");
                    console.log(checker_description);
                    ruleName = checker_description;
                }
            }
        });

        //console.log(checker_description);


        var $basicInfoOfTestOpt = $("<div class=\"panel panel-default basicInfoOfTestOpt\">\n" +
            "                                                <div class=\"panel-heading\">测试选项基本信息</div>\n" +
            "                                                <div class=\"panel-body\">\n" +
            "                                                    <table class=\"table table-condensed table-bordered table-hover\">\n" +
            "                                                        <tr>\n" +
            "                                                            <td>中文名称</td>\n" +
            "                                                            <td>" + ruleName + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>description</td>\n" +
            "                                                            <td>" + checker_description + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>category</td>\n" +
            "                                                            <td>" + checker_category + "\n" +
            "                                                            </td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>class</td>\n" +
            "                                                            <td>" + checker_class + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>name</td>\n" +
            "                                                            <td>" + checker_name + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>program</td>\n" +
            "                                                            <td>" + checker_program + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>version</td>\n" +
            "                                                            <td>" + checker_version + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                        <tr>\n" +
            "                                                            <td>status</td>\n" +
            "                                                            <td>" + checker_status + "</td>\n" +
            "                                                        </tr>\n" +
            "                                                    </table>\n" +
            "                                                </div>\n" +
            "                                            </div>\n");


        return $basicInfoOfTestOpt;

    }


    function initCheckPart(checkPart) {

        //console.log(checkPart);
        var chk_Profile = checkPart.chk_Profile;//一个的时候是一个对象，多个的时候是一个数组
        /*将单个对象变为数组*/
        if (!(chk_Profile instanceof Array)) {
            chk_Profile = [chk_Profile];
        }
        //console.log(chk_Profile instanceof Array );
        chk_Profile.forEach(function (value, index) {
            initProfile(value);
        });
    }

    /*初始化TestPartBasicInfo表格*/
    function initTestPartBasicInfo(obj) {
        //console.log(obj);
        var PLMXML_Author = obj.author;
        var PLMXML_Timestamp = obj.date + " " + obj.time;
        var CheckReport = obj.chk_CheckReport;
        var CheckReport_machineType = CheckReport.machineType;
        var CheckReport_machineOS = CheckReport.machineOS;
        var CheckReport_hardware_memory = "Processors(" + CheckReport.machineProcessors + ") Memory(" + CheckReport.machineMemory + ")";
        var CheckPart = CheckReport.chk_CheckPart;
        var CheckPart_part_type = CheckPart.objectType;
        var CheckPart_name = CheckPart.name;
        var CheckPart_id = CheckPart.partId;
        var CheckPart_Version_mod = CheckPart.version + " (" + CheckPart.mod + ")";
        var CheckPart_program = CheckPart.program;
        var CheckPart_status = CheckPart.status;
        //console.log(CheckPart_status);
        $("#PLMXML_Author").html(PLMXML_Author);
        $("#PLMXML_Timestamp").html(PLMXML_Timestamp);
        $("#CheckReport_machineType").html(CheckReport_machineType);
        $("#CheckReport_machineOS").html(CheckReport_machineOS);
        $("#CheckReport_hardware_memory").html(CheckReport_hardware_memory);
        $("#CheckPart_part_type").html(CheckPart_part_type);
        $("#CheckPart_name").html(CheckPart_name);
        $("#CheckPart_id").html(CheckPart_id);
        $("#CheckPart_Version_mod").html(CheckPart_Version_mod);
        $("#CheckPart_program").html(CheckPart_program);
        /*初始化 测试文件预览图的测试状态*/
        var testStatus = $("#testPrtPreView_testStatus").attr("testStatus");
        $("#testPrtPreView_testStatus").removeClass(testStatus);
        if (CheckPart_status == "fail") {
            $("#testPrtPreView_testStatus").addClass("btn-danger");
            $("#testPrtPreView_testStatus").html("fail");
            $("#testPrtPreView_testStatus").attr("testStatus", "btn-danger");
        } else if (CheckPart_status == "message") {
            $("#testPrtPreView_testStatus").addClass("btn-info");
            $("#testPrtPreView_testStatus").html("message");
            $("#testPrtPreView_testStatus").attr("testStatus", "btn-info");
        } else if (CheckPart_status == "skip") {
            $("#testPrtPreView_testStatus").addClass("btn-primary");
            $("#testPrtPreView_testStatus").html("skip");
            $("#testPrtPreView_testStatus").attr("testStatus", "btn-primary");
        } else if (CheckPart_status == "pass") {
            $("#testPrtPreView_testStatus").addClass("btn-success");
            $("#testPrtPreView_testStatus").html("pass");
            $("#testPrtPreView_testStatus").attr("testStatus", "btn-success");
        } else if (CheckPart_status == "warning") {
            $("#testPrtPreView_testStatus").addClass("btn-warning");
            $("#testPrtPreView_testStatus").html("warning");
            $("#testPrtPreView_testStatus").attr("testStatus", "btn-warning");
        } else {
            $("#testPrtPreView_testStatus").addClass("btn-default");
            $("#testPrtPreView_testStatus").html("default");
            $("#testPrtPreView_testStatus").attr("testStatus", "btn-default");
        }
        return CheckPart;


    }


    function initTestFileList(data) {
        /*先清除文件列表*/
        $("#testFileListSidebarBrand").siblings().remove();

        if (!(data instanceof Array)) {
            data = [data];
        }
        data.forEach(function (value, index) {
            var sfrId = value.sfrId;
            var sfrFileName = value.sfrFileName;
            /*
            模板
            <li>
                <a href="#"><i class="fa fa-fw fa-folder"></i> Page one</a>
            </li>*/

            var $fileListTem = $("<li>\n" +
                "                <a onclick=\"initThePrtTestResult(" + sfrId + ")\" href=\"#\"><i class=\"fa fa-fw fa-folder\"></i>" + sfrFileName + "</a>\n" +
                "            </li>");

            $("#testFileListSidebarBrand").after($fileListTem);
        });
        /*侧边栏，检测文件列表弹出*/
        $("#sidebar_switch").click();
        /*检测列表中的第一个文件*/
        $("#testFileListSidebarBrand").next("li").children("a").first().click();
    }

    function initTestResultData() {
        //请求数据
        $.ajax({
            url: "<%=basePath%>" + "submitRecord/getTestResultFileList",
            type: 'get',
            dataType: "json",
            data: {srId: srId},
            success: function (obj, response, status) {
                if (obj.success) {

                    initTestFileList(obj.obj.fileList);
                    $("#testPrtPreView_testOps").html(obj.obj.submitRecord.srRuleNumber);
                } else {
                    console.log(obj);
                    //alert(obj.message);
                    //window.location.href = "<%=basePath%>";
                }
            }
        });
    }

    $(function () {

        initTestResultData();
        $('[data-toggle="popover"]').popover()
    });


</script>

</body>
</html>

