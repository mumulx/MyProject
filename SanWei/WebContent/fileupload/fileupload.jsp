<%--
  Created by IntelliJ IDEA.
  User: 李旭
  Date: 2020/4/11
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>三维模型质量检查-个人中心</title>
    <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    <link href="<%=basePath %>plugins/bootstrapfileinput/css/fileinput.min.css" rel="stylesheet" media="screen">
    <link href="<%=basePath %>plugins/bootstrapfileinput/themes/explorer-fa/theme.css" rel="stylesheet" media="screen">
    <link rel="shortcut icon" href="<%=basePath %>favicon.ico">


    <style type="text/css">

        .disabled {
            pointer-events: none;
        }


        #selectTestOptions {
            margin-top: 20px;
        }

        .progressPanelBody p {

            margin-top: 10px;
            margin-bottom: 20px;
            color: #333;
        }

        #progressBarDiv {
            color: #333;
        }

        #progressButton {
            float: right;
        }

        #waitTestResult {
            display: none;
        }

    </style>
</head>
<body style="margin-top:70px;background: #E3E7EA">

<jsp:include page="../header.jsp"></jsp:include>
<div class="container">


    <div class="row">
        <div class="col-sm-8 col-sm-offset-1">
            <ol class="breadcrumb" style="margin-top:20px;background: #E3E7EA">
                <li class="active" id="step1">1.选择测试选项</li>
                <li id="step2">2.选择部件文件</li>
                <li id="step3">3.查看测试结果</li>
            </ol>
        </div>
        <nav aria-label="...">
            <ul class="pager">
                <input type="hidden" value="1" id="currentPage"/>
                <li class="previous disabled" id="prevPage"><a href="#"><span aria-hidden="true">&larr;</span> 上一步</a>
                </li>
                <li class="next" id="nextPage"><a href="#">下一步 <span aria-hidden="true">&rarr;</span></a></li>
            </ul>
        </nav>
    </div>


    <div id="selectTestOptions">

        <div class="row">
            <div class="col-sm-5">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="input-group">
                            <input id="input-search" type="text" class="form-control" placeholder="请输入要选择的测试选项...">

                            <span class="input-group-btn">
                                <button id="btn-search" class="btn btn-success" type="button">搜索</button>
                                <button id="btn-clear-search" class="btn btn-warning" type="button">清除</button>
                                <button id="btn-remove-serarch" class="btn btn-danger" type="button">移除</button>
                            </span>
                        </div>
                    </div>
                </div>

                <div id="tree">
                </div>
            </div>

            <div class="col-sm-4 col-sm-offset-2">
                <h4 style="color: #777;">选定的测试&nbsp;&nbsp;&nbsp;&nbsp;<span id="selectOptionsCount"
                                                                            class="badge">0</span></h4>

                <div class="list-group" id="search-output">

                </div>
            </div>
        </div>
    </div>


    <div id="selectTestFiles" style="display: none;">


        <div class="htmleaf-container">
            <div class="container kv-main">
                <div class="row">
                    <div class="col-sm-9 col-sm-offset-2">
                        <div id="successMessageDiv" class="alert alert-success alert-dismissible" role="alert"
                             style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                    aria-hidden="true">&times;</span></button>
                            <center>
                                <strong>提交信息成功!</strong> 点击下一步等待测试结果。
                            </center>
                        </div>

                    </div>

                    <div class="col-sm-9 col-sm-offset-2">
                        <form id="form" enctype="multipart/form-data">
                            <div class="form-group">
                                <input id="files" name="files" class="file-loading" type="file" multiple
                                       data-show-caption="true"/>
                            </div>
                        </form>
                    </div>


                </div>
            </div>
        </div>

    </div>

    <div id="waitTestResult" class="row col-sm-8 col-sm-offset-2">
        <div id="waitTestResult_waitDiv" class="alert alert-info alert-dismissible text-center" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>
            <strong>测试ing!</strong>&nbsp;&nbsp;&nbsp;&nbsp;正在测试中请耐心等待！
        </div>
        <div id="waitTestResult_successDiv" class="alert alert-success alert-dismissible text-center" role="alert"
             style="display: none">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>
            <strong>测试成功!</strong>&nbsp;&nbsp;&nbsp;&nbsp;点击查看测试结果按钮查看测试结果！
        </div>

        <div class="panel panel-default" style="border: 2px dashed #dadada;background: #E3E7EA">
            <div class="panel-body progressPanelBody">
                <p class="text-center" id="progressFile">
                    正在测试(<span id="progressFile_complete">0</span>/<span id="progressFile_count">4</span>)...
                </p>
                <p class="text-center" id="progressTime">
                    预计花费时间：<span id="progressTime_count">00:12</span> &nbsp;&nbsp;&nbsp;&nbsp; 已经测试时间：<span
                        id="progressTime_spend">00:12</span>
                </p>
                <div class="progress">
                    <div id="progressBarDiv" class="progress-bar progress-bar-info progress-bar-striped"
                         role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                        <span class="sr-only">20% Complete</span>
                        0%
                    </div>
                </div>
                <input type="hidden" id="submitRecordId"/>
                <button id="progressButton" type="button" class="btn btn-warning" disabled="disabled">查看测试结果</button>
            </div>
        </div>


    </div>


</div>

<script src="<%=basePath%>plugins/jquery.min.js"></script>
<script src="<%=basePath%>plugins/bootstrap.js"></script>
<script src="<%=basePath%>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>plugins/locales/bootstrap-datetimepicker.zh-CN.js"
        charset="UTF-8"></script>
<script src="<%=basePath%>plugins/bootstrapfileinput/js/fileinput.min.js"></script>
<script src="<%=basePath%>plugins/bootstrapfileinput/js/locales/zh.js"></script>
<script src="<%=basePath%>plugins/bootstraptreeview/bootstrap-treeview.min.js"></script>
<script src="<%=basePath%>plugins/bootstrapfileinput/themes/explorer-fa/theme.js"></script>
<script>

    /*解析Json数据为bootstrap-treeview格式的数据*/
    function initRulesData(objs) {
        //递归结束
        if (objs.length == 0) {
            return [];
        }
        //给定的是一个数组，返回的是一个数组
        var values = [];
        //对数组中的对象进行遍历
        for (var i = 0, l = objs.length; i < l; i++) {
            //取出数组中的元素
            var obj = objs[i];
            //获取对象的属性信息
            var text = obj.ruleName;
            var nodes = initRulesData(obj.children);
            var tages = [nodes.length + ""];
            var ruleId = obj.ruleId;
            //为叶结点
            if (nodes.length == 0) {
                var value = {
                    text: text,
                    ruleId: ruleId,
                };
            } else {//该结点还有子节点的时候//它就不能被选中
                var value = {
                    text: text,
                    tags: tages,
                    nodes: nodes,
                    selectable: false,
                    ruleId: ruleId,
                };
            }
            //数组中增加元素
            values.push(value);
        }
        return values;
    }

    /*获取用户选中的测试选项对应的ruleId*/
    function getselectRuleIds() {
        var result = [];
        var selectOptions = $('#tree').treeview("getSelected");
        //将结果显示在“选定的测试列表中”
        selectOptions.forEach(function (selectOption) {
            var ruleId = selectOption.ruleId;
            result.push(ruleId);
        })
        return result;
    }

    /*显示用户选择的测试选项信息*/
    function showSelectOptions() {
        var selectOptions = $('#tree').treeview("getSelected");
        //先清空“选定的测试”列表中
        $("#search-output a").remove();
        /*小气泡赋值*/
        $("#selectOptionsCount").html(selectOptions.length);
        //将结果显示在“选定的测试列表中”
        selectOptions.forEach(function (selectOption) {
            var text = selectOption.text;
            var ruleId = selectOption.ruleId;
            /*构造li元素信息*/
            var $liItem = $("<a href=\"#\" class=\"list-group-item\" ruleId=\"" + ruleId + "\">" + text + "</a>")
            $("#search-output").append($liItem);
        })
    }

    /*初始化Treeview组件信息，即测试选项树形表*/
    function setTreeview(tree) {

        //console.log(tree);
        $('#tree').treeview({
            color: "#666",
            backColor: "#E3E7EA",//背景色
            //borderColor:'green',
            collapseIcon: "glyphicon glyphicon-minus",//可收缩的节点图标
            //nodeIcon: "glyphicon glyphicon-tags",
            //emptyIcon: "glyphicon glyphicon-ban-circle",//设置列表树中没有子节点的节点的图标
            expandIcon: "glyphicon glyphicon-plus",  //设置列表上中有子节点的图标
            highlightSearchResults: true,//是否高亮搜索结果 默认true
            highlightSelected: true,     //是否选中高亮显示
            onhoverColor: "#f5f5f5",    //鼠标滑过的颜色
            levels: 0,                 //设置初始化展开几级菜单 默认为2
            selectedIcon: ' glyphicon glyphicon-screenshot',
            selectedBackColor: '#fff',  //设置被选中的节点背景颜色
            selectedColor: 'black',      //设置被选择节点的字体、图标颜色
            showBorder: true,                //是否显示边框
            showCheckbox: false,              //是否显示多选框
            //uncheckedIcon:'',             //设置未选择节点的图标
            data: tree,
            showTags: true,//显示徽章
            multiSelect: true,//是否可以选择多个结点
            showBorder: false,                //是否显示边框
            showCheckbox: false,              //是否显示多选框
            onNodeSelected: function () {
                showSelectOptions();
            },
            onNodeUnselected: function () {
                showSelectOptions();
            }
        })
    }

    /**
     * 将秒转换为 分:秒
     * s int 秒数
     */
    function s_to_hs(s) {
        //计算分钟
        //算法：将秒数除以60，然后下舍入，既得到分钟数
        var h;
        h = Math.floor(s / 60);
        //计算秒
        //算法：取得秒%60的余数，既得到秒数
        s = s % 60;
        //将变量转换为字符串
        h += '';
        s += '';
        //如果只有一位数，前面增加一个0
        h = (h.length == 1) ? '0' + h : h;
        s = (s.length == 1) ? '0' + s : s;
        return h + ':' + s;
    }

    /*时间格式化*/
    function two_char(n) {
        return n >= 10 ? n : "0" + n;
    }
    /*定时器*/
    var initProgressTime_setInterval;
    /*初始化已经测试时间的定时器*/
    function initProgressTime_spend() {
        var sec = 0;
        initProgressTime_setInterval = setInterval(function () {
            sec++;
            var date = new Date(0, 0)
            date.setSeconds(sec);
            var m = date.getMinutes(), s = date.getSeconds();
            var time = two_char(m) + ":" + two_char(s);
            $("#progressTime_spend").text(time);
        }, 1000);
    }

    /*每隔一秒钟去请求一次服务
    * 更新测试信息
    * //srId    fileNum    testTime
    * */
    function initProgressData(obj) {
        var fileNum = obj.fileNum;
        $("#progressFile_count").text(fileNum);
        $("#progressTime_count").text(s_to_hs(obj.testTime));
        $("#submitRecordId").val(obj.srId);
        /*定时任务*/
        var interval = setInterval(function () {
            //请求测试数据
            $.ajax({
                url: "<%=basePath%>" + "submitRecord/getProgress",
                type: 'get',
                dataType: "json",
                data: {srId: obj.srId},
                //data : {srId:123},
                success: function (obj, response, status) {
                    if (obj.success) {
                        /*还没有检查的文件数*/
                        var fileNumNoCheck = obj.obj;
                        /*进度公式为：已经检查的文件数/总文件数 向下取证    *100%
                        已经检查的文件数=文件总数fileCount  -已经检查的文件数fileNum*/
                        /*已经检查的文件的个数*/
                        var fileChecked = fileNum - fileNumNoCheck;
                        $("#progressFile_complete").text(fileChecked);
                        /*进度*/
                        var progress = fileChecked / fileNum;
                        /*进度取整*/
                        progress = Math.floor(progress * 100);
                        var progressValue = progress
                        //进度条当前进度属性
                        $("#progressBarDiv").attr("aria-valuenow", progress);
                        progress = progress + '%';
                        $("#progressBarDiv").width(progress);
                        $("#progressBarDiv").text(progress);
                        //停止计时器,测试完成
                        if (progressValue == 100) {

                            /*清除两个计时器*/
                            clearInterval(interval);
                            clearInterval(initProgressTime_setInterval);
                            /*waitDiv隐藏*/
                            $("#waitTestResult_waitDiv").hide();
                            /*下一步可用*/
                            $("#progressButton").removeAttr("disabled");
                            /*显示*/
                            $("#waitTestResult_successDiv").show();
                        }
                    } else {
                        alert(obj.message);
                        window.location.href = "<%=basePath%>";
                    }
                }
            });
        }, 1000);
    }
    /*初始化第三步信息*/
    function initWaitTestResult(obj) {
        $("#currentPage").val(3);
        $("#successMessageDiv").show();
        //srId    fileNum    testTime
        $("#waitTestResult").fadeIn();
        $("#selectTestFiles").fadeOut();
        /*初始化已经测试时间*/
        initProgressTime_spend();
        initProgressData(obj);
    }
    /*向服务器发出开始测试请求*/
    function  beginTestFiles(obj) {
        //请求测试数据
        $.ajax({
            url: "<%=basePath%>" + "submitRecord/beginTestFiles",
            type: 'get',
            dataType: "json",
            data: {srId: obj.srId},
            //data : {srId:123},
            success: function (obj, response, status) {
                if (obj.success) {
                    console.log("文件测试成功");
                } else {
                    alert(obj.message);
                    window.location.href = "<%=basePath%>";
                }
            }
        });
    }
    /*初始化上传组件*/
    function initFileInput(formGropId, url, extraData) {
        //上传文件类型
        var prt = ['prt'];
        $(formGropId).fileinput({
            theme: "explorer-fa", //主题
            language: 'zh', //设置语言
            uploadAsync: false,//false 同步上传，后台用数组接收，true 异步上传，每次上传一个file,会调用多次接口
            uploadUrl: url,
            uploadExtraData: extraData,
            allowedFileExtensions: prt,//接收的文件后缀
            maxFileSize: 30 *1024,     //10 *1024kb
            maxFileCount: 10,
            minFileCount: 1,
            messages: {maxFileSize:'文件上传的最大大小为 30MB',acceptFileTypes:'此文件是不支持的prt格式'},
            enctype: 'multipart/form-data',
            showCaption: true,//是否显示标题
            showUpload: true, //是否显示上传按钮
            textEncoding: 'utf-8',
            browseClass: "btn btn-primary", //按钮样式
            overwriteInitial: true,
            previewFileIcon: "<i class='glyphicon glyphicon-cloud-upload'></i>",
            //previewFileIcon: '<i class="fa fa-file"></i>',
            //initialPreviewAsData: true, // defaults markup
            //preferIconicPreview: false, // 是否优先显示图标  false 即优先显示图片
            //showPreview: true,
            /*不同文件图标配置*/
            allowedPreviewTypes: false, //不预览
            previewSettings: {
                image: {width: "100px", height: "120px"},
            },
            layoutTemplates: {
                actionUpload: '',   //取消上传按钮
                actionZoom: ''      //取消放大镜按钮
            }
        }).on("filebatchuploadsuccess", function (event, data, previewId, index) {    //文件上传成功
            var response = data.response;
            /*文件上传成功*/
            if (response.success) {
                /*显示第三步正在测试*/
                initWaitTestResult(response.obj);
                beginTestFiles(response.obj);
            } else {//文件上传失败
                $("#files").trigger("filebatchuploaderror", data, "");
            }
        }).on('filebatchuploaderror', function (event, data, msg) {  //一个文件上传失败

            console.log(data.response);
            if (!data.response.success) {
                alert(data.response.message);
                //window.location.href = "<%=basePath%>"+"fileupload/fileupload.jsp";
            }
            //alert(data.response.message);
            //window.location.href = "<%=basePath%>";
        })
    }

    /*获取测试规则数据*/
    function getRules() {
        //请求数据
        $.ajax({
            url: "<%=basePath%>" + "Rule/",
            type: 'get',
            dataType: "json",
            data: {},
            success: function (obj, response, status) {
                if (obj.success) {
                    var defaultDatas = initRulesData(obj.obj);
                    setTreeview(defaultDatas[0].nodes);
                } else {
                    alert(obj.message);
                    window.location.href = "<%=basePath%>";
                }
            }
        });
    }

    $(function () {
        /*初始化步骤一：选择测试选项的树形结构的值*/
        getRules();
        /*测试选项的搜索功能*/
        var search = function () {
            /*获取搜索值*/
            var pattern = $.trim($('#input-search').val());
            //空搜索，展开所有结点
            if (pattern == "") {
                $('#tree').treeview('expandAll',
                    /*{ levels: 2, silent: true }*/
                    {silent: true}
                );
            } else {
                /*搜索选项*/
                var options = {
                    ignoreCase: true,//忽略大小写
                    exactMatch: false,//准确匹配
                    revealResults: true//显示结果
                };
                var results = $('#tree').treeview('search', [pattern, options]);
                var output = '<p>' + results.length + ' 匹配的搜索结果</p>';
                $.each(results, function (index, result) {
                    output += '<p>- <span style="color:red;">' + result.text + '</span></p>';
                });
            }
        };

        /*搜索按钮单击事件*/
        $('#btn-search').click(search)
        /*清除按钮点击事件*/
        $('#btn-clear-search').click(function () {
            $('#tree').treeview('clearSearch');
            $('#input-search').val('');
            $('#tree').treeview('collapseAll',
                {silent: true});//折叠所有的节点，折叠整个树
        });

        /*移除按钮点击事件*/
        $("#btn-remove-serarch").click(function () {
            var selectOptions = $('#tree').treeview("getSelected");
            $("#selectOptionsCount").html(0);
            //先清空“选定的测试”列表中
            $("#search-output a").remove();
            //将所有选中的结点置为空
            selectOptions.forEach(function (selectOption) {
                var nodeId = selectOption.nodeId;
                $('#tree').treeview('unselectNode',
                    [nodeId, {silent: true}]);
            })
        })
        /*上一步点击事件*/
        $("#prevPage").click(function () {
            var currentPage = $("#currentPage").val();

            if (currentPage == 2) {
                $("#selectTestOptions").fadeIn();
                $("#selectTestFiles").fadeOut();
                $("#prevPage").addClass("disabled");
                $("#nextPage").removeClass("disabled");
                $("#currentPage").val(--currentPage);
                $("#step2").removeClass("active");
            } else if (currentPage == 3) {
                $("#waitTestResult").fadeOut();
                $("#selectTestFiles").fadeIn();
                $("#prevPage").removeClass("disabled");
                $("#nextPage").removeClass("disabled");
                $("#currentPage").val(--currentPage);
                $("#step3").removeClass("active");
            }
        })
        /*下一步点击事件*/
        $("#nextPage").click(function () {
            var currentPage = $("#currentPage").val();
            if (currentPage == 1 || currentPage == "1") {
                //进行检查，选定的测试选项要大于等于1
                var length = $('#tree').treeview("getSelected").length;
                if (length < 1) {
                    alert("请至少选择一项检查选项！")
                } else {
                    $("#selectTestOptions").fadeOut();
                    $("#selectTestFiles").fadeIn();
                    $("#prevPage").removeClass("disabled");
                    $("#nextPage").addClass("disabled");
                    $("#currentPage").val(++currentPage);
                    $("#step2").addClass("active");
                    /*初始化文件上传组件，并添加额外的上传数据，用户选择的测试选项(数组形式)
                    * #files：组件id
                    * submitRecord/filesupload：文件上传路径
                    * getselectRuleIds():用户选择的测试选项的id数组
                    * */
                    initFileInput('#files', '<%=basePath%>submitRecord/filesupload', {"rules": getselectRuleIds()});
                }
            } else if (currentPage == 2 || currentPage == "2") {
                $("#waitTestResult").fadeIn();
                $("#selectTestFiles").fadeOut();
                $("#prevPage").removeClass("disabled");
                $("#nextPage").addClass("disabled");
                $("#currentPage").val(++currentPage);
                $("#step3").addClass("active");
            }
        })

        $("#progressButton").click(function () {
            var recordId = $("#submitRecordId").val();
            var f=document.createElement('form');
            f.style.display='none';
            f.action="<%=basePath%>"+"testresult/testresult.jsp";
            f.method='post';
            f.innerHTML="<input type=\"hidden\" name=\"recordId\" value=\""+recordId+"\"/>";
            document.body.appendChild(f);
            f.submit();
        })










    });


</script>

</body>
</html>
