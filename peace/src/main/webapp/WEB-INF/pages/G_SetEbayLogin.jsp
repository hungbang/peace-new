<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<html lang="en-us">
	<jsp:include page="../pages/common/header.jsp"/> 
	<meta name="_csrf" content="${_csrf.token}"/>
 <!-- default header name is X-CSRF-TOKEN -->
 	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<body class="fixed-page-footer">
		<jsp:include page="../pages/common/menu-top.jsp"/>
		<jsp:include page="../pages/common/menu-left.jsp"/> 
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
					<li>Home</li><li>eBay 設定 : eBayログイン</li>
				</ol>
				<!-- end breadcrumb -->
			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">
				<!-- widget grid -->
				<section id="widget-grid" class="">
					<h1><b>eBay 設定 : eBayログイン</b></h1>
					<hr/>
					
					<h2><b>STEP 1.</b> <a class="btn btn-success" href="${urlEbayLogin}" target="_blank">eBay認証</a></h2>
					<p>※別画面が開きますので、[Sign in] ＞ [I agree] と進み、eBay認証を完了させて下さい。 
　　「Thank You」の画面まで行ったらその画面を閉じ、下の「完了」ボタンを押して下さい。
					</p>
					<h2><b>STEP 2.</b> <button id="ebayLoginComplete" class="btn btn-success">完了！</button></h2>
					
						
				</section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<jsp:include page="../pages/common/footer.jsp"/>
		<!--================================================== -->	
		<jsp:include page="../pages/common/footer2.jsp"/> 
		<script>
		
			jQuery(document).ready(function($) {
				$("#ebayLoginComplete").click(function(event) {

					// Prevent the form from submitting via the browser.
					event.preventDefault();
					ebayLoginComplete();

				});
			});

			function ebayLoginComplete() {
				var data = {}
// 				data["query"] = $("#query").val();
				var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");
			    
				$.ajax({
					type : "POST",
					contentType : "application/json",
					url : "GetEbayToken",
					data: token,
			        beforeSend:function(xhr){
			             xhr.setRequestHeader(header, token);
			        },
					dataType : 'json',
					timeout : 100000,
					success : function(data) {
						console.log("SUCCESS: ", data);
// 						display(data);
					},
					error : function(e) {
						console.log("ERROR: ", e);
						alert(e.msg);
// 						display(e);
					},
					done : function(e) {
						console.log("DONE");
					}
				});
			}
		</script>
		<script>
			$(document).ready(function() {

				// DO NOT REMOVE : GLOBAL FUNCTIONS!
				pageSetUp();

				/*
				 * PAGE RELATED SCRIPTS
				 */
			

			});
		</script>

		<!-- Your GOOGLE ANALYTICS CODE Below -->
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

		</script>

	</body>

</html>