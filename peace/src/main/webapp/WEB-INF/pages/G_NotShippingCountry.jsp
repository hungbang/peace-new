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
	
	#content {
		    position: relative;
		    padding: 0px;
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
			.smart-form .checkbox, .smart-form .radio {
				margin-bottom: 4px;
		    line-height: 25px;
        padding-left: 0px;
		    color: #404040;
		    cursor: pointer;
		    font-size: 13px;
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
			<div id="content" class="row " ng-controller="transportController" >

				<div class="row col-md-12" width="100%">
					<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4" style="padding-left: 20px;">
						<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> Dashboard <span>> EBay Setting</span> <span>> Shipping</span></h1>
					</div>
					<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
						
					</div>
				</div>
				<!-- widget grid -->
				
				<section id="widget-grid" class="col-md-12" style=" display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 15px; padding-bottom: 100px;
" > 
					<!-- Shipping Setting Area-->
					<div class="row col-md-12" width="100%">
						<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
							data-widget-editbutton="false">
							<header> 
								<h2><span class="widget-icon"> <i class="fa fa-table"></i></span> 発送しない国</h2> <br> 
							</header>
							<div>
								<div class="jarviswidget-editbox"></div>
								<div class="widget-body ">
									<div class="row smart-form">
										 <fieldset> 
										 <div class="row">
											<label >発送しない国の設定を選択してください </label>
											</div>
											<div class="row" ng-model="listOfGroupCountry" >
												<div class="col-sm-4 region" ng-repeat="countryGroup in listOfGroupCountry" napt-repeat-directive >
													 <span class="checkbox" style="display:inline-block">
														<label>
															<input type="checkbox"  class="checkbox style-0 country-group" data-country-group-index = "{{$index}}" data-region="{{countryGroup.name}}" class="toggleAll" name="checkbox">
															<span>{{countryGroup.name}}</span>
														</label>
													</span>
													[<a href="{{countryGroup.href}}" data-toggle="collapse">Hide all countries</a>]
													  <ul id="{{countryGroup.name}}" class="collapse" style="padding-left:40px" >
														 <div class="checkbox" ng-repeat="country in countryGroup.lstCountries" >
															  <label>
																<input type="checkbox" class="checkbox style-0" ng-model="country.isSelected" ng-checked="country.isSelected" ng-true-value="true" ng-false-value="false" data-country-id="{{country.id}}" name="country">
																<span>{{country.name}}</span>
															</label>
														</div>  
													  </ul>
												</div> 
											</div>									
										</fieldset>
										<div class="col-md-12">
											<div class="col-md-10"></div>
											<button ng-click="saveNotShippingCountry()" style="float: right;" class="btn btn-primary">セーブ
											</button>
										</div>
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
            transportSettingApp.directive('naptRepeatDirective', function($timeout) {
                return {
                    restrict: 'A',
                    link: function (scope, element, attr) {
                        if (scope.$last === true) {
                            $timeout(function () {
                                scope.registerEventForRadioButton();
                            });
                        }
                    }
                }
            });
	 		transportSettingApp.controller("transportController",function($scope,$http){ 
	 			var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content"); 
				$scope.headers = {
						headers:{ 
								'Accept':'application/json',
								'Content-Type': 'application/json' ,
								'X-CSRF-TOKEN':token
						}  
				}
				
				//Load not shipping country 
				$scope.loadNotShippingCountry = function(){
					$http.get("GetNotShippingCountry")
						 .success(function(data, status, headers,config) {  
							  $scope.listOfGroupCountry = data.extraData.lstCountryGroup;
						 })
						 .error(function(data, status, headers,config) {
							  console.log(data);
						});
				}

				$scope.registerEventForRadioButton = function(){
				    $(".country-group").on("change",function(){
				        var isSelectAll = $(this).prop("checked");
				        var countryGroupIndex= $(this).attr("data-country-group-index");
				        var countryGroup = $scope.listOfGroupCountry[countryGroupIndex];
                        countryGroup.lstCountries.forEach(function(country,index){
                            country.isSelected = isSelectAll;
						});

                        $("#"+countryGroup.name).find("div>label>input").prop("checked",isSelectAll);
					});
				}
				
				$scope.saveNotShippingCountry = function(){
					//The post data to db
					var dataPost = [];
					
					$scope.listOfGroupCountry.forEach(function(item,index){
						item.lstCountries.forEach(function($item,$index){ 
							dataPost.push({
								countryId:$item.id,
								isSelected:$item.isSelected
							});
						});
					}); 
					
					var finalDataPost = {
							lstCountryConfigurations:dataPost
					} 
					 
					//Send ajax to server to save notshipping country configuration
					$http.post("SaveNotShippingCountry",JSON.stringify(finalDataPost),$scope.headers)
						 .success(function(data, status, headers,config) {
							 console.log(data);
									
						 }).error(function(data, status, headers,config) {
							 console.log(data);
					});  
				};
				
				//Default load not shipping country
				$scope.loadNotShippingCountry();
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