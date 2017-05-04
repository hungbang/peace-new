<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en-us"> 
	<jsp:include page="../pages/common/header.jsp"/>
	<meta name="_csrf" content="${_csrf.token}"/>
 	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<body class="fixed-page-footer">
		<jsp:include page="../pages/common/menu-top.jsp"/>
		<jsp:include page="../pages/common/menu-left.jsp"/>
	    <style>
			.main {
				clear: both;
				padding: 15px;
				font-size: 108%;
			}

			table {
				margin: 0 0 10px;
				width: 100%;
				font-size: 108%;
				table-layout: fixed;
			}

			table th {
				width: 25%;
				padding: 5px 10px;
				border: 1px solid #ccc;
				background: #FFFFCC; /* #eee; */
				text-align: left;
				vertical-align: middle;
			}

			table td {
				padding: 10px;
				border: 1px solid #ccc;
			}

			.inputText {
				width: 97%;
				padding: 3px;
				font-size: 130%;
			}

			.inputSelect {
				padding: 3px;
				font-size: 130%;
				max-width: 97%;
			}

			.inputText.inputTextShort {
				width: 45%;
			}

			.inputText.inputTextShortest {
				width: 20%;
			}

			textarea {
				width: 70%;
				height: 150px;
				padding: 3px;
			}

			/*.formBtn {*/
				/*font-size: 140%;*/
				/*padding: 4px;*/
				/*padding-left: 8px;*/
				/*padding-right: 8px;*/
				/*width: 150px;*/
				/*-webkit-border-radius: 6px;*/
				/*-webkit-box-shadow: 0 2px 2px #CCC;*/
				/*border-radius: 6px;*/
				/*box-shadow: 0 2px 2px #CCC;*/
				/*font-weight: bold;*/
				/*background-color: rgba(88, 88, 88, 0.31);*/
			/*}*/

			.center-text {
				text-align: right;
				margin: 4%;
			}

			.error {
				color: #FF0000;
			}

			span.require {
				color: red;
				font-weight: bold;
			}

			/* Required field END */

		</style> 
		<!-- MAIN PANEL -->
		<div id="main" role="main"> 
			<!-- RIBBON -->
			<div id="ribbon">

				<span class="ribbon-button-alignment"> 
					<span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh"  rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true">
						<i class="fa fa-refresh"></i>
					</span> 
				</span>

				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>Home</li><li>Dashboard</li>
				</ol>
				<!-- end breadcrumb -->

				<!-- You can also add more buttons to the
				ribbon for further usability

				Example below:

				<span class="ribbon-button-alignment pull-right">
				<span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa-grid"></i> Change Grid</span>
				<span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa-plus"></i> Add</span>
				<span id="search" class="btn btn-ribbon" data-title="search"><i class="fa-search"></i> <span class="hidden-mobile">Search</span></span>
				</span> -->

			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">
				<!-- widget grid -->
				
				<section id="widget-grid" class="">

					<!-- widget div-->
					<div class="row">
						<div class="jarviswidget-color-blueDark" id="wid-id-3" style="width:60%; margin-left: 10px"
							data-widget-editbutton="false">
							<header> 
								<h2><span class="widget-icon"> <i class="fa fa-table"></i></span>  イーストライク問い合わせフォーム</h2>
							</header>
							<div>
								<div class="widget-body ">
									<form class="col col-10" ng-model="itemInfomationModel">
									<input type="hidden" id="item_infomation_id" value="{{itemInfomationModel.itemId}}"/>
										<fieldset>
											<table class="formTable">
												<tbody>
												<tr><th><label for="contact_name">お名前 <span class="require">※</span></label></th>
													<td>
														<input type="text" id="contact_name" size="30" value="" class="inputText inputTextShort" />
													</td></tr>
												<tr><th><label for="contact_email">メールアドレス <span class="require">※</span></label></th>
													<td>
														<input type="text" id="contact_email" size="60" istyle="3" mode="alphabet" value="" class="inputText inputTextLong" />
													</td></tr>
												<tr><th><label for="contact_tel">TEL <span class="require">※</span></label></th>
													<td>
														<input type="text" id="contact_tel" size="20" value="" class="inputText inputTextShort" />
													</td></tr>
												<tr><th><label for="touroku_free1">出品時のエラーの場合、出品カテゴリー、商品URL、発送方法、送料設定、4点を必ず合わせてご記載ください。 </label></th>
													<td>
														<textarea name="comment" id="contact_list_url" cols="35" rows="7" class="inputText" /></textarea>
													</td></tr>
												<tr><th><label for="touroku_free2">お問い合わせ内容をできるだけ、詳しくご記載ください。（48時間以内に上記ご記載頂いているメールアドレスにご返事させて頂きます） <span class="require">※</span></label></th>
													<td>
														<textarea name="comment" id="contact_describle" cols="35" rows="7" class="inputText" /></textarea>
													</td></tr>
												</tbody>
											</table>
											<p class="center-text">
												<input type="hidden" name="no" value="300342" />
												<input type="hidden" name="action" value="kakunin" />
												<input type="submit" name="submit" value="送信" class="btn btn-primary" id="save_contact" />
											</p>
										</fieldset>
										<%--<footer class="">--%>
									<%--</footer>--%>
									</form>
								</div>
							</div>
						</div> 
					</div>
					<!-- end widget div --> 

				</section>
				<!-- end widget grid -->
				
			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<jsp:include page="../pages/common/footer.jsp"/>
		<!--================================================== -->	
		<jsp:include page="../pages/common/footer2.jsp"/>
		<script type="text/javascript">

		// DO NOT REMOVE : GLOBAL FUNCTIONS!
		
		$(document).ready(function() {
			
			pageSetUp();
		
		})

		</script>
		
		<!-- HANDING BUSSINESS LOGIC FOR CONTACT FORM (napt2017) --> 
		<script type="text/javascript">
			$(function(){
				$("#save_contact").on("click",function(e){
					e.preventDefault();
					
					//Validate user input data
					if($("#contact_name").val()===""){
						alert("Empty");
						return;
					}
					if($("#contact_email").val()===""){
						alert("Empty");
						return;
					}
					if($("#contact_tel").val()===""){
						alert("Empty");
						return;
					}
					if($("#contact_list_url").val()===""){
						alert("Empty");
						return;
					}
					if($("#contact_describle").val()===""){
						alert("Empty");
						return;
					} 
					
					var postData = {
	                    	id:0,
	                    	email:$("#contact_email").val(),
	                    	name:encodeURIComponent($("#contact_name").val()),
	                    	phone:encodeURIComponent($("#contact_tel").val()),
	                    	createdDate:new Date(),
	                    	exhibitionCategory:encodeURIComponent($("#contact_list_url").val()),
	                    	describeContent:encodeURIComponent($("#contact_describle").val()),
	                    };
					
					var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content"); 					
					
					//Process main bussiness logic
					$.ajax({
	                    type: "POST",
	                    headers: {
	                        'Accept':'application/json',
	                        'Content-Type': 'application/json'
	                    },
	                    beforeSend:function(xhr){
	                    	xhr.setRequestHeader(header, token);
	                    },
	                    url: "Contact",
	                    data:JSON.stringify(postData),
	                    contentType: "application/json",
	                    mimeType: 'application/json',
	                    dataType: "json",
	                    success: function(respData){
	                        alert(respData);
	                    },
	                    error:function(evt){
	                    	console.log(evt);
	                    }
	                });  
	                
				 });
			});
		</script>

		<!-- Your GOOGLE ANALYTICS CODE Below 
		<script type="text/javascript">
			var _gaq = _gaq || [];
				_gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
				_gaq.push(['_trackPageview']);
			
			(function() {
				var ga = document.createElement('script');
				ga.type = 'text/javascript';
				ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(ga, s);
			})();

		</script>-->

	</body>

</html>