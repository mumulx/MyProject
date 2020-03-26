$(document).ready(function() {
	//每隔1500毫秒更换一次内容
	//定义变量保存
	var n = 0;

	var box = document.getElementById("box");
	var boxs = box.getElementsByTagName("li");

	var radio1 = document.getElementById("radio");
	var radio1s = radio1.getElementsByTagName("p");
	var slide = document.getElementById("slide");

	//获取上下按钮
	var next = document.getElementById("next");
	var prev = document.getElementById("prev");

	//为slide注册事件
	slide.onmouseover = function() {
		clearInterval(timer);
		next.style.display = "block";
		prev.style.display = "block";
	}
	slide.onmouseout = function() {
		timer = setInterval(timedown, 3000);
		next.style.display = "none";
		prev.style.display = "none";
	}
	//向下运动prev
	prev.onclick = timedown;
	//向上
	next.onclick = timeUp;

	//给p注册事件
	for(var j = 0; j < radio1s.length; j++) {
		//建立对应关系
		radio1s[j].b = j;
		radio1s[j].onclick = function() {
			//解决点击后移出的问题
			n = this.b;

			//先清除所有内容在把当前的内容显示
			for(var i = 0; i < boxs.length; i++) {
				boxs[i].className = "";
				radio1s[i].className = "";
			}
			boxs[this.b].className = "active";
			radio1s[this.b].className = "active"

		}

	}

	//定义计时器
	var timer = setInterval(timedown, 3000);

	function timedown() {
		//通过n的值变化内容
		n++;
		if(n == boxs.length) {
			n = 0;
		}
		//先清除所有内容在把当前的内容显示
		for(var i = 0; i < boxs.length; i++) {
			boxs[i].className = "";
			radio1s[i].className = "";
		}
		boxs[n].className = "active";
		radio1s[n].className = "active";
	}

	function timeUp() {
		//通过n的值变化内容
		n--;
		if(n < 0) {
			n = boxs.length - 1;
		}
		//先清除所有内容在把当前的内容显示
		for(var i = 0; i < boxs.length; i++) {
			boxs[i].className = "";
			radio1s[i].className = "";
		}
		boxs[n].className = "active";
		radio1s[n].className = "active";
	}
	/*********************************/

	//console.dir(daoahng);
	$("#nav1 a").each(function() {

		if($(this).attr("class") != "active") {
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

	/************************************************/
	$("#login_login").click(function() {
		$("#div_login_form input").each(function() {
			$(this).attr("value", "");
		});
		$("#cover").show();
		$("#loginandregister_login").show();
		$("#div_login").slideDown(300);
		$("body").css("overflow", "hidden");
	});

	$("#login_register").click(function() {
		$("#div_register_form input").each(function() {
			$(this).attr("value", "");
		});
		$("#cover").show();
		$("#loginandregister_register").show();
		$("body").css("overflow", "hidden");
		$("#div_register").slideDown(500);

	});
	$("#div_login_button_close").click(function() {
		$("#cover").hide();
		$("#loginandregister_login").hide();
		$("#div_login").slideUp();
		$("body").css("overflow", "auto");
	});
	$("#div_login_header>a").click(function() {
		return $("#div_login_button_close").click();
	});
	$("#div_register_button_close").click(function() {
		$("#cover").hide();
		$("#loginandregister_register").hide();
		$("#div_register").slideUp(500);
		$("body").css("overflow", "auto");
	});
	$("#div_register_header>a").click(function() {
		return $("#div_register_button_close").click();
	});
	$("#div_login_button_submit").click(function() {
		$("#login_login").css("display", "none");
		$("#login_welcome").css("display", "block");
		$("#login_register").css("display", "none");
		$("#login_exit").css("display", "block");
		return $("#div_login_button_close").click();

	});

}); //-----jQuery