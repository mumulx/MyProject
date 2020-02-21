
## 说明

本项目涉及

* SSM
* bootstracp
* ajax
* jquery
* mysql
* json
* jsp
* java
* tomcat

后续会进行优化

* MybatisPlus
* easyUI

主要是对数据的CRUD，以及多表之间一对一，一对多，多对多关系的处理，图片文件上传保存更新。熟悉SSM框架的流程，以及jsp的使用。并且对一些前端的技术如jquery，ajax，bootstracp等技术的运用。

项目很简单，适合当入门级项目。

后续会对该项目进行优化，采用mybatisplus或mapper技术对mybatis进行优化，采用springboot+vue的方式实现前后端分离。同时使用elementui脚手架进行开发。

作为刚入门的人，还是希望自己能够坚持下去。我们的征途是星辰大海！

## 下面介绍的是自己开发时遇到的问题

### 搭建ssm环境

1. jar
2. 表和类
3. 配置数据库db.properties,log4j.properties
4. 加载spring配置文件applicationContext.xml
5. 加载springmvc配置文件applicationContext-controller.xml
6. spring加载数据库文件
7. 配置mybatis的sqlSessionFactory
8. 配置psringmvc视图解析器

### 数据库设计
```
用户: 学号,登录密码,所在学院,姓名,性别,学生照片,出生日期,联系电话,家庭地址

学院: 学院id,学院名称

寻物启事: 寻物id,标题,丢失物品,物品照片,丢失时间,丢失地点,物品描述,报酬,联系电话,学生,发布时间

失物招领: 招领id,标题,物品名称,捡得时间,拾得地点,描述说明,联系人,联系电话,发布时间

认领: 认领id,招领信息,认领人,认领时间,描述说明,发布时间

表扬: 表扬id,招领信息,标题,表扬内容,表扬时间

站内通知: 通知id,标题,内容,发布时间
```

### springmvc处理静态文件

添加配置

    <!-- SPringMVC基础配置、标配 -->
    <mvc:annotation-driven></mvc:annotation-driven>
    <!-- 处理静态资源 -->
    <mvc:default-servlet-handler></mvc:default-servlet-handler>
    
### 上传文件

	<bean id="multipartResolver"  class="org.springframework.web.multipart.commons.CommonsMultipartResolver">  
        <!-- 设置编码 -->
        <property name="defaultEncoding" value="UTF-8"></property>
        <!-- 设置上传文件的最大尺寸为2MB -->  
    	<property name="maxUploadSize">  
        	<value>2097152</value>
        </property>  
	</bean> 

### bootstracp组件失灵

1. js文件引用顺序

    1. 先jquery
    2. 再引用bootstracp文件
2. jquery引用重复并且版本不对

### tomcat配置虚拟路径实现访问本地文件

当客户端需要上传文件到服务器的时候，服务器需要将文件存放到本地中，如果保存在本项目的某个文件夹中时如上传的目录  upload ：（`http://localhost:8888/LostSomething/upload/`）

    //String photoBookRealPathDir = request.getSession().getServletContext().getRealPath(photoBookPathDir);     

这是发现会丢失上传的文件

1. 如果修改代码，则在tomcat重新启动时 会被删除

    原因：当修改代码的时候,tomcat会重新编译一份class 并且重新部署（重新创建各种目录）

2. 如果不修改代码，则不会删除

    原因： 没有修改代码，class仍然是之前的class

因此，为了防止 上传目录丢失

1. 配置虚拟路径

1. 更换上传目录 到非tomcat目录

将文件上传到`String photoBookRealPathDir = "C:\\workplace\\STS\\MyProject\\upload";
`本地计算机的某个文件夹中。

当用户需要访问这个图片的时候，如果直接填写文件的本地路径如：
```
String filePath = "C:\\workplace\\STS\\MyProject\\";
request.setAttribute("filePath", filePath);
```
```
<%
    String filePath=(String)request.getAttribute("filePath");
%>
    <img class="img-responsive" src="<%=filePath%><%=userInfo.getUserPhoto()%>" />
```
会发现文件的请求为`Request URL: file:///C:/workplace/STS/MyProject/upload/NoImage.jpg`
这根本就不是一个请求，当然是访问不到文件的

因此我们需要借助虚拟路径来解决，当用户访问upload请求时实际上访问的时本地的文件中

在tomcat配置文件的host标签中添加子标签

    <Context  docBase="C:\workplace\STS\MyProject\upload"  path="/upload"/>

```
<%    
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<img class="img-responsive" src="<%=basePath%><%=userInfo.getUserPhoto()%>" />
```
此时的请求为`Request URL: http://localhost:8888/LostSomething/upload/NoImage.jpg`,但是实际上请求的是
`C:\workplace\STS\MyProject\upload\NoImage.jpg`

这样就可以防止上传文件的丢失

但是在Eclipse中运行的话需要配置项目的根目录（或者双击servers在moudles中配置）

    <Context docBase="C:\workplace\STS\MyProject\upload" path="/LostSomething/upload" reloadable="true"/>

定义长传文件的本地保存位置
```
private static final String UPLADMIMGSRC = "C:\\workplace\\STS\\MyProject";
```
处理文件
```
/*
* 
* 处理图片文件上传，返回保存的文件名路径
* fileKeyName: 图片上传表单key
* @throws IOException 
* @throws IllegalStateException 
*/ 
public String handlePhotoUpload(HttpServletRequest request,String fileKeyName) throws IllegalStateException, IOException {
	// 设置默认的文件名
	String fileName = "upload/NoImage.jpg";
	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
	/**构建图片保存的目录**/    
	String photoBookPathDir = "/upload";     
	/**得到图片保存目录的真实路径**/    
	//String photoBookRealPathDir = request.getSession().getServletContext().getRealPath(photoBookPathDir);     
	// 保存在本地文件夹，因为tomcat在项目修改代码后会清理文件夹
	HelpDev helpdev = new HelpDev();
	String photoBookRealPathDir = helpdev.getUPLADMIMGSRC()+photoBookPathDir;
	/**根据真实路径创建目录**/    
	File photoBookSaveFile = new File(photoBookRealPathDir);     
	if(!photoBookSaveFile.exists())     
		photoBookSaveFile.mkdirs();           
	/**页面控件的文件流**/    
	MultipartFile multipartFile_photoBook = multipartRequest.getFile(fileKeyName);    
	if(!multipartFile_photoBook.isEmpty()) {
		/**获取文件的后缀**/    
		String suffix = multipartFile_photoBook.getOriginalFilename().substring  
						(multipartFile_photoBook.getOriginalFilename().lastIndexOf("."));  
		String smallSuffix = suffix.toLowerCase();
		if(!smallSuffix.equals(".jpg") && !smallSuffix.equals(".gif") && !smallSuffix.equals(".png") )
			throw new UserException("图片格式不正确！");
		/**使用UUID生成文件名称**/    
		String photoBookFileName = UUID.randomUUID().toString()+ suffix;//构建文件名称     
		//String logImageName = multipartFile.getOriginalFilename();  
		/**拼成完整的文件保存路径加文件**/    
		String photoBookFilePath = photoBookRealPathDir + File.separator  + photoBookFileName;                
		File photoBookFile = new File(photoBookFilePath);          
		multipartFile_photoBook.transferTo(photoBookFile);     
		fileName = "upload/" + photoBookFileName;
	} 
	return fileName;
}
```
```
<div class="form-group">
	<label for="userInfo_userPhoto_header" class="col-md-3 text-right">学生照片:</label>
	<div class="col-md-8">
		<img class="img-responsive" id="userInfo_userPhotoImg"
			border="0px" /><br /> <input type="hidden"
			id="userInfo_userPhoto_header" name="userInfo.userPhoto" /> 
			<input id="userPhotoFile_header" name="userPhotoFile" type="file" size="50" />
	</div>
</div>
```

* img:显示选择的图片

* hidden可以保存已经上传的图片的一些信息，帮助我们更新信息的时候判断图片是否更新，如果用户更新了图片，我们需要将旧的文件删除，再保存新的文件。我们如何知道用户是否更新了文件，可以将hidden中保存的信息和file组件中的信息进行对比

* file：文件上传组件

```
/* ajax方式更新用户信息 */
@RequestMapping(value = "/{user_name}/update", method = RequestMethod.POST)
public void update(@Validated UserInfo userInfo, BindingResult br, Model model, HttpServletRequest request,
		HttpServletResponse response) throws Exception {
	String message = "";
	boolean success = false;
	if (br.hasErrors()) {
		message = "输入的信息有错误！";
		writeJsonResponse(response, success, message);
		return;
	}
	String userPhotoFileName = this.handlePhotoUpload(request, "userPhotoFile");
	// 重新选择了头像就赋值
	if (!userPhotoFileName.equals("upload/NoImage.jpg")) {
		// 删除用户头像文件
		String imgSrc = userInfo.getUserPhoto();
		userInfoService.getHelpDev().deleteImgPhoto(imgSrc);
		// 重新赋值用户头像文件
		userInfo.setUserPhoto(userPhotoFileName);
	} else {
		// 没有选择头像，就不修改
		userInfo.setUserPhoto(null);
	}
	try {
		userInfoService.updateUserInfo(userInfo);
		message = "用户更新成功!";
		success = true;
		writeJsonResponse(response, success, message);
	} catch (Exception e) {
		e.printStackTrace();
		message = "用户更新失败!";
		writeJsonResponse(response, success, message);
	}
}
```
```
//删除本地图片
public void deleteImgPhoto(String imgSrc) {
	if(!imgSrc.equals("upload/NoImage.jpg")) {
		File file = new File(UPLADMIMGSRC+"\\"+imgSrc);
		if(file.isFile()&& file.exists()){
			file.delete();
		}
	}
}
```
```
/*更新用户记录*/
public void updateUserInfo(UserInfo userInfo) throws Exception {
	String pwd = userInfo.getPassword();
	//用户对密码进行了修改，进行加密
	if(pwd!=null && !pwd.equals("")) {
		pwd=helpDev.md5Encode(pwd.getBytes());
	}else {
		//没进行密码修改给密码赋默认值，方便mybatis进行更新
		pwd=null;
	}
	userInfo.setPassword(pwd);
	userInfoMapper.updateUserInfo(userInfo);
}
```
```
<!-- 更新用户记录 -->
<update id="updateUserInfo" parameterType="userInfo">
	update t_userInfo set 
	<if test="password!=null and password!=''">
		password=#{password},
	</if>
	<if test="userPhoto!=null and userPhoto!=''">
		userPhoto=#{userPhoto},
	</if>
		areaObj=#{areaObj.areaId},name=#{name},sex=#{sex},birthday=#{birthday},telephone=#{telephone},address=#{address} where user_name = #{user_name}
</update>
```
mybatis使用if标签进行判断

### 封装返回ajax请求的响应的方法

```
/* 向客户端输出操作成功或失败信息 */
public void writeJsonResponse(HttpServletResponse response, boolean success, String message)
		throws IOException, JSONException {
	response.setContentType("text/json;charset=UTF-8");
	PrintWriter out = response.getWriter();
	// 将要被返回到客户端的对象
	JSONObject json = new JSONObject();
	json.accumulate("success", success);
	json.accumulate("message", message);
	out.println(json.toString());
	out.flush();
	out.close();
}
```
可以将常用的方法，属性封装成一个类，我们在需要使用他们呢的时候就可以继承它或，把它的一个对象作为自己的成员。

```
public class UserInfoController extends HelpDevController {}
```
```
private HelpDev helpDev;
```

### 快速返回上一个url

    <button onclick="history.back();">返回</button>

back() 方法可加载历史列表中的前一个 URL（如果存在）。

调用该方法的效果等价于点击后退按钮或调用 history.go(-1)。

history 是js的内置对象

### 页面刷新

```
window.location.reload();
```

### 更新用户信息问题

由于对用户的密码进行了MD5进行加密，因此我们实际上是不知道用户的密码的，因此在做用户修改个人信息的时候，显示要显示用户的信息，密码的话，我们不能直接显示给用户，因此密码的input框的值是空的，这时用户提交更新的请求就有两种情况了，一种是用户进行了密码修改，一种是用户对密码没有进行操作，此时密码为空，那么我们在写sql语句的时候就需要判断一下密码是否为空（别忘了对修改的密码进行加密），可以使用if标签来实现if判断

    <if test="password!=null and password!=''">
		password=#{password},
	</if>

用户上传的照片也是同理，在更新时也要判断一下，用户是否对照片进行了更改，

总结，在更新时注意判断值是否改变以及是否为空的问题

### 删除用户信息

也要对用户的图片进行删除，以及在更新静态资源（用户的头像，图片文件）进行更新时考虑是否将旧的文件进行删除，之后再更新

### springmvc捕获上传文件太大的异常并返回客户端

```
<bean id="multipartResolver"  class="org.springframework.web.multipart.commons.CommonsMultipartResolver">  
        <!-- 设置上传文件的最大尺寸为2MB -->  
    	<property name="maxUploadSize">  
        	<value>2097152</value>
        </property>  
	</bean>  
	
<!-- SpringMVC在超出上传文件限制时，会抛出org.springframework.web.multipart.MaxUploadSizeExceededException -->  
<!-- 该异常是SpringMVC在检查上传的文件信息时抛出来的，而且此时还没有进入到Controller方法中 -->  
<bean id="exceptionResolver"  
    class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver">  
    <property name="exceptionMappings">  
        <props>  
            <!-- 遇到MaxUploadSizeExceededException异常时，自动跳转到upload_error页面 -->  
            <prop key="org.springframework.web.multipart.MaxUploadSizeExceededException">upload_error</prop>  
            <prop key="com.chengxusheji.utils.UserException">user_error</prop>
        </props>  
    </property>  
</bean>  
```
这两个一个是设置上传文件的格式，一个是捕获异常，SimpleMappingExceptionResolver是spring内部帮我们实现好的一个类，它可以帮助我们捕获异常，但是遗憾的是，它对ajax请求就不是很友好，它不支持ajax请求，这是我们使用ajax上传文件的时候，当文件太大是，会触发MaxUploadSizeExceededException这个异常，这时就需要我们实现捕获异常

一般我们想实现某种功能无非是先实现功能再配置，这时我们需要继承SimpleMappingExceptionResolver并重写doResolveException方法

```
public class MaxUploadSizeExceptionResolver extends SimpleMappingExceptionResolver {
	private static Logger log = Logger.getLogger(MaxUploadSizeExceptionResolver.class);
	public static final String UTF_8 = "utf-8";
	public static final String ACCEPT = "accept";
	public static final String APPLICATION_JSON = "application/json";
	public static final String X_REQUESTED_WITH = "X-Requested-With";
	public static final String XML_HTTP_REQUEST = "XMLHttpRequest";
	public static final String APPLICATION_JSON_CHARSET_UTF_8 = "application/json; charset=utf-8";
	/**
	 * 重写Spring统一异常处理方法
	 */
	@Override
	protected ModelAndView doResolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		ModelAndView mv = new ModelAndView("error");
		//文件太大异常
		if(MaxUploadSizeExceededException.class.isInstance(ex)) {
			response.setContentType("text/json;charset=UTF-8");
			try {
				PrintWriter out = response.getWriter(); 
				//将要被返回到客户端的对象 
				JSONObject json=new JSONObject();
				boolean success=false;
				String message="图片太大！";
				json.accumulate("success", success);
				json.accumulate("message", message);
				out.println(json.toString());
				out.flush(); 
				out.close();
				return null;
			} catch (Exception e) {
				// TODO: handle exception
				return null;
			}
		}else {
			mv.addObject("exception",ex.toString());
		}
		return mv;
	}
}
```
但是这样之后会捕捉所有的异常，因此要对异常进行判断，什么异常做什么处理。（个人感觉怪怪的）

该方法的核心是要像ajax返回json数据，告知ajax文件过大的信息，让它提醒用户，更换文件，可以发现它的功能和controller的功能类似，因此可以向写controller那样编写

配置

将异常类纳入ioc
```
<bean id="exceptionResolver"  
    class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver">  
    <property name="exceptionMappings">  
        <props>  
            <prop key="org.springframework.web.multipart.MaxUploadSizeExceededException">upload_error</prop>  
        </props>  
    </property>  
</bean>  
```

### @Autowired 与@Resource的区别

@Resource的作用相当于@Autowired，只不过@Autowired按byType自动注入，而@Resource默认按 byName自动注入罢了。@Resource有两个属性是比较重要的，分是name和type，Spring将@Resource注解的name属性解析为bean的名字，而type属性则解析为bean的类型。所以如果使用name属性，则使用byName的自动注入策略，而使用type属性时则使用byType自动注入策略。如果既不指定name也不指定type属性，这时将通过反射机制使用byName自动注入策略。

@Autowired通过byName自动注入

	@Autowired
	@Qualifier("xx")

@Resource通过属性name指定通过byName注入

	@Resource(name = "userInfoService")


### @Validated数据校验和@Valid数据校验

[参考博客](https://blog.csdn.net/qq_27680317/article/details/79970590
)
#### @Valid

1. 在属性前加注解

        public class Student {
            @Past//当前时间以前
            private Date birthday ;
        }
	
2. 在校验的Controller中 ，给校验的对象前增加 @Valid

		public String testDateTimeFormat(@Valid Student student, BindingResult result ,Map<String,Object> map) {

#### @Validated

1. 在属性前加注解

        public class UserInfo {
			@NotEmpty(message="学号不能为空")
			private String user_name;
        }
	
2. 在校验的Controller中 ，给校验的对象前增加 @Valid

		ublic void add(@Validated LookingFor lookingFor, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response){}

### 分页查询问题

#### 分页

我们要将数据库中的东西显示在页面上，当数据有很多时，一页时不可能全部显示出来的因此需要对结果进行分页，此时需要的请求参数有，第几页

响应的参数有

1. 当前页的所有数据的集合
2. 总共的页数
3. 数据的总数
1. 当前页

当我们需要增加搜索查询时，需要客户端提交的东西包括，搜索的信息，以及第几页，这和我们显示所有结果是类似的，只不过显示所有结果的查询条件为空。因此搜索查询可以和分页写在一起，分页是查询条件为空的搜索查询

```
/* 前台按照查询条件分页查询用户信息 */
@RequestMapping(value = { "/frontlist" }, method = { RequestMethod.GET, RequestMethod.POST })
public String frontlist(String user_name, @ModelAttribute("areaObj") Area areaObj, String name, String birthday,
		String telephone, Integer currentPage, Model model, HttpServletRequest request) throws Exception {
	if (currentPage == null || currentPage == 0)
		currentPage = 1;
	if (user_name == null)
		user_name = "";
	if (name == null)
		name = "";
	if (birthday == null)
		birthday = "";
	if (telephone == null)
		telephone = "";
	// 查询当前页数据
	List<UserInfo> userInfoList = userInfoService.queryUserInfo(user_name, areaObj, name, birthday, telephone,currentPage);
	/* 计算总的页数和总的记录数 */
	userInfoService.queryTotalPageAndRecordNumber(user_name, areaObj, name, birthday, telephone);
	/* 获取到总的页码数目 */
	int totalPage = userInfoService.getHelpDev().getTotalPage();
	/* 当前查询条件下总记录数 */
	int recordNumber = userInfoService.getHelpDev().getRecordNumber();
	request.setAttribute("userInfoList", userInfoList);
	request.setAttribute("totalPage", totalPage);
	request.setAttribute("recordNumber", recordNumber);
	request.setAttribute("currentPage", currentPage);
	request.setAttribute("user_name", user_name);
	request.setAttribute("areaObj", areaObj);
	request.setAttribute("name", name);
	request.setAttribute("birthday", birthday);
	request.setAttribute("telephone", telephone);
	List<Area> areaList = areaService.queryAllArea();
	request.setAttribute("areaList", areaList);
	return "UserInfo/userInfo_frontquery_result";
}
```
要对查询的条件进行初始化操作，当查询条件为空时，仅仅为普通的分页。
```
/*按照查询条件分页查询用户记录*/
public ArrayList<UserInfo> queryUserInfo(String user_name,Area areaObj,String name,String birthday,String telephone,int currentPage) throws Exception { 
	String where = "where 1=1";
	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_userInfo.areaObj=" + areaObj.getAreaId();
	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
	if(!birthday.equals("")) where = where + " and t_userInfo.birthday like '%" + birthday + "%'";
	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
	int startIndex = (currentPage-1) * this.helpDev.getRows();
	return userInfoMapper.queryUserInfo(where, startIndex, this.helpDev.getRows());
}
/*当前查询条件下计算总的页数和记录数*/
public void queryTotalPageAndRecordNumber(String user_name,Area areaObj,String name,String birthday,String telephone) throws Exception {
	String where = "where 1=1";
	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_userInfo.areaObj=" + areaObj.getAreaId();
	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
	if(!birthday.equals("")) where = where + " and t_userInfo.birthday like '%" + birthday + "%'";
	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
	this.helpDev.computeTotalPag(userInfoMapper.queryUserInfoCount(where));
}
```
```
//计算总的页数
public void computeTotalPag(int rm) {
	this.recordNumber=rm;
	int mod = this.recordNumber % this.rows;
	this.totalPage = this.recordNumber / this.rows;
	if(mod != 0) this.totalPage++;
}
```
```
<!-- 按照查询条件的用户记录数 -->
<select id="queryUserInfoCount" resultType="int">
	select count(*) from t_userInfo,t_area ${where} and t_userInfo.areaObj = t_area.areaId
</select>
<!-- 按照查询条件分页查询用户记录 -->
<select id="queryUserInfo" resultMap="userInfoMap" >
	select t_userInfo.* from t_userInfo,t_area ${where} and t_userInfo.areaObj = t_area.areaId limit #{startIndex},#{pageSize}
</select>
<resultMap id="userInfoMap" type="userInfo">
	<id property="user_name" column="user_name" />
	<association property="areaObj" column="areaObj" select="com.mumulx.mapper.AreaMapper.getArea" />
</resultMap>
```
在查询数据库的当页数据时，我们又需要知道，当前页面显示几条数据


### @ModelAttribute和@RequestParam

[参考博客](https://www.cnblogs.com/zeroingToOne/p/8992746.html)


#### 连接远程mysql显示表不存在

更改数据的配置文件，让大小写不敏感
```
vi /etc/my.cnf
	
```
在`[mysqld]`下添加
```
lower_case_table_names=1
```
重启mysql

	service mysql restart











































































