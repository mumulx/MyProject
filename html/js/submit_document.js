$(document).ready(function() {
	
	$("#nav1 a").each(function() {
		
		if($(this).attr("class")!="active"){
			$(this).mouseout(function() {
	
				$(this).attr("class", "");
			});			
		}
		$(this).mouseover(function() {
			$(this).attr("class", "active");
		});
		
		$(this).click(function() {
			$(this).attr("class", "active");
		});
		
			
		
	});
	$("#login a").each(function() {
		$(this).mouseover(function() {

			$(this).attr("class", "active");
		});
		$(this).mouseout(function() {

			$(this).attr("class", "");

		});
	});	
	
	//导航栏
	
	
	// 保存当前选择的（更新后）文件列表
	var curFiles = [];
	//console.log(11111111);
	//console.dir(curFiles);
	$("#choiceFile div:first").click(function() {
		$(this).siblings("div").each(function() {

			$(this).toggle(500);

		});
		$(this).parent().next("div").show(1000);
		$("#box2").fadeOut(500);
		setTimeout(function() {
			$("#box3").fadeIn();
		}, 500);
		$("#showFile").fadeIn(50);
		$("#fileOpreation").fadeIn(50);

	});
	$("#choiceRule div:first").click(function() {
		$(this).siblings("div").each(function() {
			$(this).toggle(500);
		});
		$(this).parent().next("div").show(1000);
		setTimeout(function() {
			$("#showRule").fadeIn(50);
			$("#ruleOpreation").fadeIn(50);
		}, 500);

	});

	$("#submitFile div:first").click(function() {
		$(this).siblings("div").each(function() {

			$(this).toggle(500);

		});

	});
	//注册鼠标移入移除
	$("#box1 #choiceFile1").each(function() {

		$(this).mouseover(function() {

			$(this).attr("class", "active");
			//alert(111);
			$($(this).children("a")[0]).attr("class", "active");

		});
		$(this).mouseout(function() {

			$(this).attr("class", "");
			$(this).children("a").attr("class", "");

		});

	});

	//双击添加规则*********************************
	$("#choiceRule #choiceFile1").each(function() {
		$(this).dblclick(function() {
			var value = $(this).text();
			var boolIs = false;
			//alert(value);
			//	alert($newLi.val());
			//$newLi.text("&nbsp;&nbsp;")
			$("#RuleTable ul li").each(function(index, element) {
				if(index != 0) {
					var oldValue = $(this).text();
					if($.trim(oldValue) == $.trim(value)) {
						boolIs = true;
					}
				}
			});
			if(!boolIs) {

				var $lastLi = $("#RuleTable ul li:last");
				var lastInputValue = $("#RuleTable ul li:last input").attr("value");
				var value1 = (Number(lastInputValue) + 1);
				//创建新节点
				var $newLi = $("<li><input name='filename' type='checkbox' value=" + value1.toString() + " />&nbsp;&nbsp;<span>" + value + "</span></li>");
				//$newLi.html(value);
				//<li><input type="checkbox" name="filename" value="0" />&nbsp;&nbsp;规则名</li>
				$("#RuleTable ul li:last").after($newLi[0]);
				$($("#RuleTable ul li:last").children()[1]).click(function() {

					if($(this).prev("input").attr("checked") != "checked") {

						$(this).prev("input").attr("checked", "checked");

					} else {

						$(this).prev("input").prop("checked", false);
						if($($("#RuleTable ul li:first").children()[0]).attr("checked") == "checked") {

							$($("#RuleTable ul li:first").children()[0]).prop("checked", false);

						}

					}

				});
				$($("#RuleTable ul li:last").children()[0]).click(function() {

					if($(this).attr("checked") != "checked") {
						$(this).prop("checked", false);
						if($($("#RuleTable ul li:first").children()[0]).attr("checked") == "checked") {

							$($("#RuleTable ul li:first").children()[0]).prop("checked", false);
						}
					} else {
						$(this).attr("checked", "checked");
					}

				});
				$("#RuleTable ul li:last").mouseover(function() {

					$(this).css("background-color", "#369");
					$(this).css("color", "#fff");
				});
				$("#RuleTable ul li:last").mouseout(function() {

					$(this).css("background-color", "");
					$(this).css("color", "black");
				});

			} else {
				//alert("该规则已选中！");
			}
		});
	});

	//设置全选  文件名的复选框
	$("#FileTable ul input:first").click(function() {
		if($(this).attr("checked") == "checked") {
			$("#FileTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).attr("checked", "checked");
				}
			});
			//alert(1);
		} else {
			$("#FileTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).prop("checked", false);
				}
			});
		}
	});
	$("#FileTable ul input").each(function(index, element) {
		if(index != 0) {
			$(this).click(function() {

				if($(this).attr("checked") != "checked") {
					$("#FileTable ul input:first").prop("checked", false);
				}
			});
		}
	});

	$($("#RuleTable ul li:first").children()[1]).click(function() {

		if($(this).prev("input").attr("checked") != "checked") {

			$(this).prev("input").attr("checked", "checked");
			$("#RuleTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).attr("checked", "checked");
				}
			});

		} else {

			$(this).prev("input").prop("checked", false);
			$("#RuleTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).prop("checked", false);
				}
			});

		}

	});

	//设置全选
	$("#RuleTable ul input:first").click(function() {
		if($(this).attr("checked") == "checked") {
			$("#RuleTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).attr("checked", "checked");
				}
			});
			//alert(1);
		} else {
			$("#RuleTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).prop("checked", false);
				}
			});
		}
	});
	$("#RuleTable ul input").each(function(index, element) {
		if(index != 0) {
			$(this).click(function() {

				if($(this).attr("checked") != "checked") {
					$("#RuleTable ul input:first").prop("checked", false);
				}
			});
		}
	});
	//文件名的点击事件
	$($("#FileTable ul li:first").children()[1]).click(function() {

		if($(this).prev("input").attr("checked") != "checked") {

			$(this).prev("input").attr("checked", "checked");
			$("#FileTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).attr("checked", "checked");
				}
			});

		} else {

			$(this).prev("input").prop("checked", false);
			$("#FileTable ul input").each(function(index, element) {
				if(index != 0) {
					$(this).prop("checked", false);
				}
			});

		}

	});

	//获取单个文件
	$("#box1 #choiceFile #choiceFile1:first").dblclick(function() {

		return $($(this).children("input")).click();
	});
	$("#box1 #choiceFile #choiceFile1:first input:last").change(function() {
		var str = $(this).val(); //文件路径
		//console.log(str);
		//alert(str);
		var arr = str.split("\\");
		var prt = arr[arr.length - 1]; //文件名
		var tep = prt.split(".")[1]; //文件类型
		files = this.files;
		//console.dir(files);

		//alert(prt);
		//alert(tep);
		if(tep == "prt") { //文件类型正确
			var boolIs = false;
			$("#FileTable ul li").each(function(index, element) {
				if(index != 0) {
					var oldValue = $(this).text();
					if($.trim(oldValue) == $.trim(prt)) {
						boolIs = true;
					}
				}
			});
			if(!boolIs) { //文件不存在
				//alert(11111);
				var $lastLi = $("#FileTable ul li:last");
				var lastInputValue = $("#FileTable ul li:last input").attr("value");
				var value1 = (Number(lastInputValue) + 1);
				//创建新节点
				var $newLi = $("<li><input name='filename' type='checkbox' value=" + value1.toString() + " />&nbsp;&nbsp;<span>" + prt + "</span></li>");

				//$newLi.html(value);
				//<li><input type="checkbox" name="filename" value="0" />&nbsp;&nbsp;规则名</li>
				$("#FileTable ul li:last").after($newLi[0]);

				// 原始FileList对象不可更改，所以将其赋予curFiles提供接下来的修改

				Array.prototype.push.apply(curFiles, files);
				//				console.log(111111);
				//				console.dir(curFiles);
				//				console.dir(files);

				$($("#FileTable ul li:last").children()[1]).click(function() {

					if($(this).prev("input").attr("checked") != "checked") {

						$(this).prev("input").attr("checked", "checked");

					} else {

						$(this).prev("input").prop("checked", false);
						if($($("#FileTable ul li:first").children()[0]).attr("checked") == "checked") {

							$($("#FileTable ul li:first").children()[0]).prop("checked", false);

						}

					}

				});
				$($("#FileTable ul li:last").children()[0]).click(function() {

					if($(this).attr("checked") != "checked") {
						$(this).prop("checked", false);
						if($($("#FileTable ul li:first").children()[0]).attr("checked") == "checked") {

							$($("#FileTable ul li:first").children()[0]).prop("checked", false);
						}
					} else {
						$(this).attr("checked", "checked");
					}

				});

				$("#FileTable ul li:last").mouseover(function() {

					$(this).css("background-color", "#369");
					$(this).css("color", "#fff");
				});
				$("#FileTable ul li:last").mouseout(function() {

					$(this).css("background-color", "");
					$(this).css("color", "black");
				});

			} else {
				alert("文件已存在")
			}
		} else {
			alert("文件类型有错")
		}

	});
	//获取多个文件
	$($("#box1 #choiceFile #choiceFile1")[1]).dblclick(function() {

		return $(this).children("input").click();
	});
	$("#box1 #choiceFile #choiceFile1:eq(1) input:last").change(function(e) {
		var files = e.target.files;
		//console.log(files);
		[].forEach.call(files, function(item) {
			if(item) {
				var fileName = uploading1(item); //上传文件夹
				var tep = fileName.split('.')[1];
				if(tep == "prt") { //文件类型正确
					var boolIs = false;
					$("#FileTable ul li").each(function(index, element) {
						if(index != 0) {
							var oldValue = $(this).text();
							if($.trim(oldValue) == $.trim(fileName)) {
								boolIs = true;
							}
						}
					});
					if(!boolIs) { //文件不存在
						//alert(11111);
						var $lastLi = $("#FileTable ul li:last");
						var lastInputValue = $("#FileTable ul li:last input").attr("value");
						var value1 = (Number(lastInputValue) + 1);
						//创建新节点
						var $newLi = $("<li><input name='filename' type='checkbox' value=" + value1.toString() + " />&nbsp;&nbsp;<span>" + fileName + "</span></li>");
						//$newLi.html(value);
						//<li><input type="checkbox" name="filename" value="0" />&nbsp;&nbsp;规则名</li>
						$("#FileTable ul li:last").after($newLi[0]);

						//console.log(1);
						//console.dir(item);

						//console.log(2);
						//console.dir(aa);
						//console.log(3);

						//console.dir(curFiles);
						var aa = [item];
						Array.prototype.push.apply(curFiles, aa);
						//console.dir(curFiles);
						$("#FileTable ul li:last").mouseover(function() {

							$(this).css("background-color", "#369");
							$(this).css("color", "#fff");
						});
						$("#FileTable ul li:last").mouseout(function() {

							$(this).css("background-color", "");
							$(this).css("color", "black");
						});
						$($("#FileTable ul li:last").children()[1]).click(function() {

							if($(this).prev("input").attr("checked") != "checked") {

								$(this).prev("input").attr("checked", "checked");

							} else {

								$(this).prev("input").prop("checked", false);
								if($($("#FileTable ul li:first").children()[0]).attr("checked") == "checked") {

									$($("#FileTable ul li:first").children()[0]).prop("checked", false);

								}

							}

						});
						$($("#FileTable ul li:last").children()[0]).click(function() {

							if($(this).attr("checked") != "checked") {
								$(this).prop("checked", false);
								if($($("#FileTable ul li:first").children()[0]).attr("checked") == "checked") {

									$($("#FileTable ul li:first").children()[0]).prop("checked", false);
								}
							} else {
								$(this).attr("checked", "checked");
							}

						});

					} else {
						//alert("文件已存在")
					}
				} else {
					//alert("文件类型有错")
				}
			}
		}, false / true);

	});
	//获取目录下文件
	$("#box1 #choiceFile #choiceFile1").dblclick(function() {

		return $(this).children("input").click();
	});
	//$("#box1 #choiceFile #choiceFile1 a:last").next()

	$("#box1 #choiceFile #choiceFile1:eq(2) input:last").change(function(e) {
		var files = e.target.files;
		[].forEach.call(files, function(item) {
			if(item) {
				//console.log(item);
				var fileName1 = uploading(item); //上传文件夹
				var fileName = fileName1.split('/')[1];
				var src = fileName1.split('/')[0];
				var tep = fileName.split('.')[1];
				if(tep == "prt") { //文件类型正确
					var boolIs = false;
					$("#FileTable ul li").each(function(index, element) {
						if(index != 0) {
							var oldValue = $(this).text();
							if($.trim(oldValue) == $.trim(fileName)) {
								boolIs = true;
							}
						}
					});
					if(!boolIs) { //文件不存在
						//alert(11111);
						var $lastLi = $("#FileTable ul li:last");
						var lastInputValue = $("#FileTable ul li:last input").attr("value");
						var value1 = (Number(lastInputValue) + 1);
						//创建新节点
						var $newLi = $("<li><input name='filename' type='checkbox' value=" + value1.toString() + " />&nbsp;&nbsp;<span>" + fileName + "</span></li>");
						//$newLi.html(value);
						//<li><input type="checkbox" name="filename" value="0" />&nbsp;&nbsp;规则名</li>
						$("#FileTable ul li:last").after($newLi[0]);
						var aa = [item];
						Array.prototype.push.apply(curFiles, aa);

						$("#FileTable ul li:last").mouseover(function() {

							$(this).css("background-color", "#369");
							$(this).css("color", "#fff");
						});
						$("#FileTable ul li:last").mouseout(function() {

							$(this).css("background-color", "");
							$(this).css("color", "black");
						});
						$($("#FileTable ul li:last").children()[1]).click(function() {

							if($(this).prev("input").attr("checked") != "checked") {

								$(this).prev("input").attr("checked", "checked");

							} else {

								$(this).prev("input").prop("checked", false);
								if($($("#FileTable ul li:first").children()[0]).attr("checked") == "checked") {

									$($("#FileTable ul li:first").children()[0]).prop("checked", false);

								}

							}

						});
						$($("#FileTable ul li:last").children()[0]).click(function() {

							if($(this).attr("checked") != "checked") {
								$(this).prop("checked", false);
								if($($("#FileTable ul li:first").children()[0]).attr("checked") == "checked") {

									$($("#FileTable ul li:first").children()[0]).prop("checked", false);
								}
							} else {
								$(this).attr("checked", "checked");
							}

						});

					} else {
						//alert("文件已存在")
					}
				} else {
					//alert("文件类型有错")
				}
			}
		}, false / true);

	});
	//注册按钮事件
	$($("#fileOpreation div")[0]).click(function() {
		if($("#FileTable ul li").length < 2) {
			alert("请添加文件！");
		} else {
			var a = 0;
			$("#FileTable ul li input").each(function(index, element) {
				if(index != 0) {
					if($(this).attr("checked") == "checked") {
						a++;
					}
				}
			});
			if(a > 0) {
				if(confirm("确定移除选定部分？")) {
					$("#FileTable ul li").each(function(index, element) {
						if(index != 0) {
							//定义选中的文件名
							var prtName;
							if($($(element).children("input")[0]).attr("checked") == "checked") {
								prtName = $($(element).children("span")[0]).text();
								$(element).remove();

							}
							//console.dir(curFiles);
							if(prtName) {
								curFiles = curFiles.filter(function(file) {
									return file.name !== prtName;
								});
								//console.dir(curFiles);
							}
						} else {
							$($(element).children("input")[0]).prop("checked", false);

						}
					});

				}
			} else {
				alert("未选中任何文件！");
			}
		}
	});
	$($("#fileOpreation div")[1]).click(function() {
		if($("#FileTable ul li").length < 2) {

			alert("请添加文件！");
		} else {
			if(confirm("确定全部移除？")) {
				$("#box1 #choiceFile #choiceFile1:first input").each(function(index, element) {

					if(index != 0) {
						$(element).remove();
					}
				});
				$("#box1 #choiceFile #choiceFile1:eq(1) input").each(function(index, element) {

					if(index != 0) {
						$(element).remove();
					}
				});
				$("#box1 #choiceFile #choiceFile1:eq(2) input").each(function(index, element) {

					if(index != 0) {
						$(element).remove();
					}
				});
				$("#FileTable ul li").each(function(index, element) {
					if(index != 0) {
						$(element).remove();
					} else {
						$($(element).children("input")[0]).prop("checked", false);

					}
				});

			}
		}

	});

	//提交文件  左侧导航栏 按钮在下
	$($("#box1 #submitFile #choiceFile1")[0]).dblclick(function() {
		return $($("#fileOpreation div")[2]).dblclick();

	});

	$("#fileOpreation div").each(function() {

		$(this).mouseover(function() {
			$($(this).children("button")[0]).css("color", "black");
			//alert($(this).children("button").html());
		});
		$(this).mouseout(function() {
			$($(this).children("button")[0]).css("color", "#fff");
		});

	});
	//注册按钮事件
	$($("#ruleOpreation div")[0]).click(function() {
		if($("#RuleTable ul li").length < 2) {

			alert("请添加规则！");
		} else {
			var a = 0;
			$("#RuleTable ul li input").each(function(index, element) {
				if(index != 0) {
					if($(this).attr("checked") == "checked") {
						a++;
					}
				}
			});
			if(a > 0) {
				if(confirm("确定移除选定部分？")) {
					$("#RuleTable ul li").each(function(index, element) {
						if(index != 0) {
							if($($(element).children("input")[0]).attr("checked") == "checked") {
								$(element).remove();
							}
						} else {
							$($(element).children("input")[0]).prop("checked", false);
						}
					});

				}

			} else {
				alert("未选中规则");

			}

		}

	});
	$($("#ruleOpreation div")[1]).click(function() {
		if($("#RuleTable ul li").length < 2) {

			alert("请添加规则！");
		} else {
			if(confirm("确定全部移除？")) {
				$("#RuleTable ul li").each(function(index, element) {
					if(index != 0) {
						$(element).remove();
					} else {
						$($(element).children("input")[0]).prop("checked", false);
					}
				});

			}
		}

	});
	$($("#ruleOpreation div")[2]).dblclick(function() {
		$("#choiceRule #choiceFile1 a").each(function() {

			return $(this).dblclick();

		});

	});

	$("#ruleOpreation div").each(function() {

		$(this).mouseover(function() {
			$($(this).children("button")[0]).css("color", "black");
			//alert($(this).children("button").html());
		});
		$(this).mouseout(function() {
			$($(this).children("button")[0]).css("color", "#fff");
		});

	});

	$("#FileTable ul li").each(function() {

		$(this).mouseover(function() {

			$(this).css("background-color", "#369");
			$(this).css("color", "#fff");
		});
		$(this).mouseout(function() {

			$(this).css("background-color", "");
			$(this).css("color", "black");
		});
	});
	$("#RuleTable ul li").each(function() {

		$(this).mouseover(function() {

			$(this).css("background-color", "#369");
			$(this).css("color", "#fff");
		});
		$(this).mouseout(function() {

			$(this).css("background-color", "");
			$(this).css("color", "black");
		});
	});

	//提交文件   按钮
	$($("#fileOpreation div")[2]).dblclick(function() {
		if($("#FileTable ul input").length < 2 || $("#RuleTable ul input").length < 2) {

			alert("请添加文件或规则！");

		} else {
			var fd = new FormData($('#myForm')[0]);
			//文件
			for(var i = 0, j = curFiles.length; i < j; ++i) {
				fd.append("myFileTest[" + i + "]", curFiles[i]);
			}
			//规则
			var rule = [];
			$("#showRule #RuleTable ul span").each(function(index, element) {
				if(index != 0) {
					rule.push($(this).text());
				}
			});
			fd.append("myRule", rule);
			//提交时间
			var myDate = new Date();
			//console.log(date);
			fd.append("myDate", myDate);
			//		for(var i = 0, j = curFiles.length; i < j; ++i) {
			//				console.dir(fd.get("myFileTest["+i+"]"));
			//		}
			//		console.dir(fd.get("myRule"));
			//console.dir(curFiles);
			$.ajax({
				url: '../upload_file/',
				type: 'post',
				data: fd,
				processData: false,
				contentType: false,
				success: function(data) {
					//rs = JSON.parse(rs);
					console.log(data);
					if(data.status == 'ok') {
						alert('上传成功！');
					}
				},
				error: function(err) {
					console.log("上传失败")
				}
			});

		}

	});

}); //jQuery1111111111111111111111111111111
//窗口滚动
window.onscroll = function() {
	var windowh = document.documentElement.scrollTop;
	if(windowh <= 65) {
		document.getElementById("box1").style.top = 65 - windowh + "px";
	} else {
		document.getElementById("box1").style.top = 0 + "px";

	}
	if(windowh <= 130) {

		document.getElementById("FileTable").style.top = 130 - windowh + "px";
		document.getElementById("RuleTable").style.top = 130 - windowh + "px";
	} else {
		document.getElementById("RuleTable").style.top = 0 + "px";

		document.getElementById("FileTable").style.top = 0 + "px";

	}
	var windowW = document.documentElement.scrollLeft;

	document.getElementById("box1").style.left = -windowW + "px";
	document.getElementById("RuleTable").style.left = 780 - windowW + "px";

	document.getElementById("FileTable").style.left = 308 - windowW + "px";

}
//文件显示
function uploading(file) {
	if(/^\..*/.test(file.name)) return // 隐藏文件 取消
	return file.webkitRelativePath;
}
//文件显示
function uploading1(file) {
	if(/^\..*/.test(file.name)) return // 隐藏文件 取消
	return file.name;
}