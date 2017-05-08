<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us" ng-app="transport-setting-app">
	<jsp:include page="../pages/common/header.jsp"/>  
	<meta name="_csrf" content="${_csrf.token}"/>
 	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<body class="fixed-page-footer">
	<style>
			input, textarea, button { margin-top:10px }

			/* Required field START */

			.required-field-block {
				position: relative;   
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
					<li>Home</li><li>Dashboard</li>
				</ol> 
			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content" ng-controller="transportController">

				<div class="row">
					<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
						<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> Dashboard <span>> EBay Setting</span> <span>> Shipping</span></h1>
					</div>
					<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
						
					</div>
				</div>
				<!-- widget grid -->
				
				<section id="widget-grid" class=""> 
					<!-- Shipping Setting Area-->
					<div class="row">
						<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
							data-widget-editbutton="false">
							<header> 
								<h2><span class="widget-icon"> <i class="fa fa-table"></i></span> eBay 設定 : 送料編集</h2> <br> 
							</header>
							<div>
								<div class="jarviswidget-editbox"></div>
								<div class="widget-body ">
									<div class="row smart-form">
										<fieldset> 
											<legend>
												<select ng-model="transportType" class="input" id="select-transport-config-type" ng-change="loadTransportConfig()">
													<option selected value="6">EMS</option>
													<option value="7">国際小包SAL </option>
													<option value="8">書留付小形包装物航空便</option>
													<option value="9">書留付小形包装物航空SAL便</option>
													<option value="10">書留無小形包装物航空便</option>
													<option value="11">書留無小形包装物航空SAL便</option>
													<option value="12">国際eパケット</option>
													<option value="13">FedEX</option>
												</select>
											</legend>
											<div class="row" style="background-color:white; padding-right: 40px;">
												<table class="table table-bordered table-striped responsive-utilities" style="margin-left:15px;"> 
													<thead>
													  <tr >
													    <th>重量 </th>
													    <th>アジア</th>
													    <th>オセアニア・北米・中米・中近東</th>
													    <th>ヨーロッパ</th>
													    <th>南米・アフリカ</th>
													  </tr>
													</thead>
													<!-- START TBODY -->
													<tbody>
													  <tr ng-repeat="userAreaModel in areaTableModelData">
													  	<td class="">{{userAreaModel.shippingMethodName}}</td>
													  	<td class="" ng-repeat="areaTimeUnitMapping in userAreaModel.listOfAreaTimeUnitMapping">
													  		<section id="area-time-unit-mapping-{{areaTimeUnitMapping.recordId}}">
																<p><input type="number" class="input" value="areaTimeUnitMapping.timeShipping" ng-model="areaTimeUnitMapping.timeShipping" >円 </p> {{areaTimeUnitMapping.placeHolder}}
															</section>
													  	</td>
													  </tr>
													</tbody>
													<!-- END TBODY -->
												</table> 
												</div>
										</fieldset>
										<footer>
											<button ng-click="saveTransportSetting()" class="btn btn-primary">Save</button>
										</footer>
									</div>
								</div>
							</div>
						</div>
					</div> 
				</section>
				<!-- end widget grid -->
				
			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<jsp:include page="../pages/common/footer.jsp"/>
		<!--================================================== -->	
		<jsp:include page="../pages/common/footer2.jsp"/>  
		
		<script type="text/javascript">
		
		$(function() {
			$('.required-icon').tooltip({
				placement: 'left',
				title: 'Required field'
				});
		});
		// DO NOT REMOVE : GLOBAL FUNCTIONS!
		
		$(document).ready(function() {
			
			pageSetUp();
			
			$('input.toggleAll').change(function(){
				var checked = $(this).prop("checked");
				$(this).closest('.region').find('ul input').prop('checked',checked);
				updateListCountriesNotShipping();	
			});
			
			$('input[name=country]').click(function(){
				var region = $(this).closest('.region');
				var count = 0;
				$('input[name=country]',region).each(function(){
					count ++;
					var checked = $(this).prop('checked');
					if(checked){
						count--;
					};
				});
				$('input.toggleAll',region).prop('checked', count == 0);
				updateListCountriesNotShipping();	
			})
			
			function updateListCountriesNotShipping(){
				var container = $('#countriesNotShipping');
				container.html('');
				$('')
				$('input.toggleAll').each(function(){

					var checked = $(this).prop('checked');
					var span = document.createElement('span');
					var region = $(this).attr('data-region');
					if(checked){
						$(span).html(region);
						$(container).append(span);
						$(container).append('<span>,</span>');
					}else{
						var divRegion = $(this).closest('.region');
						$('input[name=country]', divRegion).each(function(){
							var span2 = document.createElement('span');
							var country = $(this).attr('data-country');

							var checked2 = $(this).prop('checked');
							if(checked2){
								$(span2).html(country);
								$(container).append(span2);
								$(container).append('<span>,</span>');
							}
						});	
					}
				});
				$('span:last-child',container).remove();
			}
		})

		</script>
		
		<!-- LOAD ANGULAR JS MODULE -->
		<script type="text/javascript"src="<c:url value="/resources/js/angularjs/angular.min.js"/>"></script>
		
		<!-- HANDING ALL BUSSSINESS LOGIC FOR SHIPPING SETTING APP(napt2017) -->
		<script type="text/javascript">
	 		var transportSettingApp = angular.module("transport-setting-app",[]);
	 		transportSettingApp.controller("transportController",function($scope,$http){
	 			$scope.transportType ={};
	 			var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content"); 
				$scope.config = {
						headers:{ 
								'Accept':'application/json',
								'Content-Type': 'application/json' ,
								'X-CSRF-TOKEN':token
						}  
				} 
	 			$scope.loadTransportConfig = function(){
		 			var areaId = $("#select-transport-config-type").val();
		 			$http.get("LoadLayoutAreaSetting/"+areaId)
					 .success(function(data, status, headers,config) {
						 
						 //Extract data from ajax response
						 var shippingSettingModel = data.extraData; 
						 var tableModelData = shippingSettingModel.lstAreaSettingDto;
						 
						 //Assign for $scope model data
						 $scope.columnHeaders = ["重量","アジア","オセアニア・北米・中米・中近東","ヨーロッパ","南米・アフリカ"];
						 $scope.areaTableModelData = tableModelData;
					 })
					 .error(function(data, status, headers,config) {
						  console.log(data);
					});
	 			};
	 			
	 			$scope.saveTransportSetting =function(){
					var dataPost = $scope.areaTableModelData;
					$http.post("SaveUserAreaSetting",JSON.stringify(dataPost),$scope.config)
						 .success(function(data, status, headers,config) {  
							  console.log(data);
						 })
						 .error(function(data, status, headers,config) {
							  console.log(data);
						});
				}
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