<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us">
	<jsp:include page="../pages/common/header.jsp"/>
	<meta name="_csrf" content="${_csrf.token}"/>
 	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<body class="fixed-page-footer" ng-app="item_infomation_app">
	<style>
			input, textarea, button { margin-top:10px }

			/* Required field START */

			.required-field-block {
				position: relative;   
			}
			
			[ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
			  display: none !important;
			}

			.required-field-block .required-icon {
				display: inline-block;
				vertical-align: middle;
				margin: -0.25em 0.25em 0em;
				background-color: #E8E8E8;
				border-color: #E8E8E8;
				padding: 0.5em 0.8em;
				color: rgba(0, 0, 0, 0.65);
				text-transform: uppercase;
				font-weight: normal;
				border-radius: 0.325em;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
				-ms-box-sizing: border-box;
				box-sizing: border-box;
				-webkit-transition: background 0.1s linear;
				-moz-transition: background 0.1s linear;
				transition: background 0.1s linear;
				font-size: 75%;
			}
				
			.required-field-block .required-icon {
				background-color: transparent;
				position: absolute;
				top: 0em;
				right: 0em;
				z-index: 10;
				margin: 0em;
				width: 30px;
				height: 30px;
				padding: 0em;
				text-align: center;
				-webkit-transition: color 0.2s ease;
				-moz-transition: color 0.2s ease;
				transition: color 0.2s ease;
			}

			.required-field-block .required-icon:after {
				position: absolute;
				content: "";
				right: 1px;
				top: 1px;
				z-index: -1;
				width: 0em;
				height: 0em;
				border-top: 0em solid transparent;
				border-right: 30px solid transparent;
				border-bottom: 30px solid transparent;
				border-left: 0em solid transparent;
				border-right-color: inherit;
				-webkit-transition: border-color 0.2s ease;
				-moz-transition: border-color 0.2s ease;
				transition: border-color 0.2s ease;
			}

			.required-field-block .required-icon .text {
				color: #B80000;
				font-size: 26px;
				margin: -3px 0 0 12px;
			}
			/* Required field END */

		</style>
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
					<li>Home</li><li>Item Information</li>
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
				
				<section id="widget-grid" class="col-lg-11">

					<!-- widget div-->
					<div class="row" ng-controller="itemInfomationController">
						<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
							data-widget-editbutton="false">
							<header> 
								<h2><span class="widget-icon"> <i class="fa fa-table"></i></span>商品説明情報</h2>
							</header>
							<div>
								<div class="jarviswidget-editbox"></div>
								<div class="widget-body ">
									<form class="smart-form col col-10" ng-model="itemInfomationModel">
									<input type="hidden" id="item_infomation_id" value="{{itemInfomationModel.itemId}}"/>
									<fieldset>
										<section class="row" style="margin-bottom: 10px;">
											<label style="font-size: 20px" class="label col col-6" style="text-align: left;">Payment</label>
											<label class="textarea col col-6"> 									
												<textarea rows="5" id="payment" name="comment" ng-cloak placeholder="">{{itemInfomationModel.payment}}</textarea> 
											</label>
										</section>
										<section class="row" style="margin-bottom: 10px;">
											<label style="font-size: 20px" class="label col col-6" style="text-align: left;">Terms of Sale</label>
											<label class="textarea col col-6"> 									
												<textarea rows="5" name="comment" id="terms_of_sale"  ng-cloak placeholder="">{{itemInfomationModel.termsOfSale}}</textarea> 
											</label>
										</section>
										<section class="row" style="margin-bottom: 10px;">
											<label style="font-size: 20px" class="label col col-6" style="text-align: left;">About Us</label>
											<label class="textarea col col-6"> 										
												<textarea rows="5" name="comment" id="about_us" ng-cloak  placeholder="">{{itemInfomationModel.aboutUs}}</textarea> 
											</label>
										</section>
										<section class="row" style="margin-bottom: 2px;">
											<label style="font-size: 20px" class="label col col-6" style="text-align: left;">International Buyers - Please Note:</label>
											<label class="textarea col col-6">									
												<textarea rows="5" name="comment" ng-cloak id="international_buyers_note" placeholder="">{{itemInfomationModel.internationalBuyersNote}}</textarea> 
											</label>
										</section>
									</fieldset>
										<div class="row" style="padding: 25px;">
											<div class="col-md-10"></div>
										<button type="submit" class="btn btn-primary col-md-2" ng-cloak id="btnSave" ng-click="saveItemInfomation($event)">
											Save
										</button>
										</div>
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
		$(document).ready(function() {
			//$('#colorpicker').farbtastic('#color');
			//$('#colorpickerstr').farbtastic('#colorstr');
		});
		
		$(function() {
			$('.required-icon').tooltip({
				placement: 'left',
				title: 'Required field'
				});
		});
		// DO NOT REMOVE : GLOBAL FUNCTIONS!
		
		$(document).ready(function() {
			
			pageSetUp();
		
		})

		</script>
		<!-- LOAD ANGULAR JS MODULE -->
		<script type="text/javascript"src="<c:url value="/resources/js/angularjs/angular.min.js"/>"></script>
		
		<!-- HANDING EVENT SAVE NEW ITEM INFOMATION(napt2017) -->
		<script type="text/javascript">
		var itemInfomationModule = angular.module("item_infomation_app", []);
			itemInfomationModule.controller("itemInfomationController",function($scope, $http) { 
				
				//Load exist item infomation of user
				$scope.loadDefaultLoadExistIF = function(){
					//Default model
					$scope.itemInfomationModel = {
							payment:"",
							termsOfSale:"",
							aboutUs:"",
							internationalBuyersNote:"",
							itemId:"-1"
					};
					  
					$http.get("LoadItemInfomation")
						 .success(function(data, status, headers,config) {
							 	$scope.itemInfomationModel = data;
								console.log(data); 
							})
						 .error(function(data, status, headers,config) {
								console.log(data);
							});
					}
				
				//Handing event save item infomation
				$scope.saveItemInfomation = function($event){
					$event.preventDefault();
					if($("#payment").val()===""){
						alert("Empty payment!!!");
						return;
					}
					
					if($("#terms_of_sale").val()===""){
						alert("Empty terms of sale!!!");
						return;
					}
					
					if($("#about_us").val()===""){
						alert("Empty about us !!!!");
						return;
					}
					
					if($("#international_buyers_note").val()===""){
						alert("Empty international buyers note!!!");
						return;
					} 
				    
					var postData = {
							payment:$("#payment").val(),
							termsOfSale:$("#terms_of_sale").val(),
							aboutUs:$("#about_us").val(),
							internationalBuyersNote:$("#international_buyers_note").val(),
							itemId:$("#item_infomation_id").val(),
							
					};  
					
					var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content"); 
					var config = {
							headers:{ 
									'Accept':'application/json',
									'Content-Type': 'application/json' ,
									'X-CSRF-TOKEN':token
							}  
					} 
					
					$http.post("AddItemInfomation",JSON.stringify(postData),config)
						 .success(function(data, status, headers,config) {
							 	$scope.itemInfomationModel.itemId=data.recordId;
							 	alert("Save successfull!!!");
							})
						 .error(function(data, status, headers,config) {
								console.log(data);
						 });   
				}
				
				$scope.loadDefaultLoadExistIF();
			}); 
		</script>

		<!-- Your GOOGLE ANALYTICS CODE Below -->
		<%--<script type="text/javascript">--%>
			<%--var _gaq = _gaq || [];--%>
				<%--_gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);--%>
				<%--_gaq.push(['_trackPageview']);--%>
			<%----%>
			<%--(function() {--%>
				<%--var ga = document.createElement('script');--%>
				<%--ga.type = 'text/javascript';--%>
				<%--ga.async = true;--%>
				<%--ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';--%>
				<%--var s = document.getElementsByTagName('script')[0];--%>
				<%--s.parentNode.insertBefore(ga, s);--%>
			<%--})();--%>

		<%--</script>--%>

	</body>

</html>