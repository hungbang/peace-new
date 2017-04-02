<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en-us" ng-app="product_shopping_search">
<jsp:include page="../pages/common/header.jsp" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<body class="fixed-page-footer">
	<jsp:include page="../pages/common/menu-top.jsp" />
	<jsp:include page="../pages/common/menu-left.jsp" />
	<!-- MAIN PANEL -->
	<div id="main" role="main">

		<!-- RIBBON -->
		<div id="ribbon">

			<span class="ribbon-button-alignment"> <span id="refresh"
				class="btn btn-ribbon" data-action="resetWidgets"
				data-title="refresh" rel="tooltip" data-placement="bottom"
				data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings."
				data-html="true"> <i class="fa fa-refresh"></i>
			</span>
			</span>

			<!-- breadcrumb -->
			<ol class="breadcrumb">
				<li>Home</li>
				<li>Research</li>
			</ol> 
		</div>
		<!-- END RIBBON -->

		<!-- MAIN CONTENT -->
		<div id="content">
			<!-- widget grid -->

			<section id="widget-grid" class="">

				<!-- widget div-->
				<div class="row" ng-controller="productSearchController">
					<div class="widget-body ">
						<header>
							<h2 class="amazon-search-title">リサーチ：amazon.co.jp</h2> 
						</header> 
						<form class="smart-form">
							<div class="row">
								<div class="col col-lg-2" style="text-align:right">
									キーワード / ASIN:
								</div>
								<div class="col col-lg-9">
									<label class="input">
										<input type="search" id="search-by-keyword" />
									</label> 
								</div>
							</div>
							<div class="row" style="margin-top:5px;margin-bottom:5px;">
								<div class="col col-lg-2" style="text-align:right">
								ASINから関連商品
								</div>
								<div class="col col-lg-9">
									<label class="input">
										<input type="search" id="search-by-asin" />
									</label> 
								</div>
							</div>
							</form>
					</div>
					<div class="row"
						style="background-color: white; padding-right: 40px;">
						<div class="col col-lg-12">
							<table
							class="table table-bordered table-striped responsive-utilities"
							style="margin-left: 25px">
							<thead>
								<tr>
									<th ng-click="sort('image')">画像
										<span class="glyphicon sort-icon" ng-show="sortKey=='image'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('productName')">	商品名
										<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('price')">価格（円）
										<span class="glyphicon sort-icon" ng-show="sortKey=='price'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('stock')">	関連
										<span class="glyphicon sort-icon" ng-show="sortKey=='stock'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('exhibition')">出品
										<span class="glyphicon sort-icon" ng-show="sortKey=='exhibition'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat ="product in listOfProduct |orderBy:sortKey:reverse">
									<td class="col col-1"><image width="64" height="64"
											src="{{product.imageUrl}}" /></td>
									<td class="is-visible"><p>{{product.name}}</p></td>
									<td class="is-hidden">{{product.price}}</td>
									<td class="is-hidden">{{product.stock}}</td>
									<td class="is-hidden"> 
										<a href="{{product.link}}">Add to ebay</a>
									</td>
								</tr>
							</tbody> 
						</table> 
				          <!-- Pagination -->
				          <div class="row" ng-if="pages&&pages.length>0">  
			                  <div class="btn-toolbar" role="toolbar">
			                    <div class="btn-group center-paging">
			                        <button type="button" class="btn btn-default" id="btn-prev-page" ng-click="prevPage($event)">&lt;&lt;</button>
			                        <button type="button" ng-repeat="page in pages" class="btn btn-default" ng-click="changePage($event,page)" napt-repeat-directive>{{page}}</button>
			                        <button type="button" class="btn btn-default" id="btn-next-page" ng-click="nextPage($event)">&gt;&gt;</button>
			                        
			                    </div> 
			               </div>
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
	<!-- END MAIN PANEL -->
	<style>
input, textarea, button {
	margin-top: 10px
}

/* Required field START */
.required-field-block {
	position: relative;
}

.center-paging{
	width: 100%;
    /* margin: 0 auto; */
    display: flex;
    justify-content: center;
    align-items: center;
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

.amazon-search-title{
	border: 1px solid #bfbfbf;
    font-size: 28px;
    padding-left: 20px;
    background: #524d4d;
    color: white;
    margin-bottom: 52px;
}

.required-field-block .required-icon .text {
	color: #B80000;
	font-size: 26px;
	margin: -3px 0 0 12px;
}
/* Required field END */
</style>

	<jsp:include page="../pages/common/footer.jsp" />
	<!--================================================== -->
	<jsp:include page="../pages/common/footer2.jsp" />
	<!-- PAGE RELATED PLUGIN(S) 
		<script src="..."></script>-->
	<script type="text/javascript">
		$(function() {
			$('.required-icon').tooltip({
				placement : 'left',
				title : 'Required field'
			});
		});
		// DO NOT REMOVE : GLOBAL FUNCTIONS!

		$(document).ready(function() {

			pageSetUp();

		})
	</script>

	<!-- Your GOOGLE ANALYTICS CODE Below -->
	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-XXXXXXXX-X' ]);
		_gaq.push([ '_trackPageview' ]);

		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl'
					: 'http://www')
					+ '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>

	<!-- LOAD ANGULAR JS MODULE -->
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/angular.js"/>"></script>
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/dirPagination.js"/>"></script>

	<!-- SCRIPT HANDING EVENT SEARCH PRODUCT (Author napt2017)-->
	<script type="text/javascript">
		var shoppingSearchModule = angular.module("product_shopping_search", ['angularUtils.directives.dirPagination']);
		shoppingSearchModule.directive('naptRepeatDirective', function($timeout) {
			 return {
			        restrict: 'A',
			        link: function (scope, element, attr) {
			            if (scope.$last === true) {
			                $timeout(function () {
			                	scope.activeStyleForCurrentPage();
			                });
			            }
			        }
			    }
		 });
		shoppingSearchModule.controller("productSearchController",function($scope, $http) {  
			
			$.expr[':']['hasText'] = function(node, index, props){
				  return node.innerText ===props[3];
			};
			
			$scope.activeStyleForCurrentPage = function(){
				//Remove last active button
				$("button[type=button][class*=btn-primary]").removeClass("btn-primary").addClass("btn-default");
				
				//Active new button 
				var selector = "button[type=button]:hasText("+$scope.currentPage+")";
				$(selector).removeClass("btn-default").addClass("btn-primary"); 
				
				//Disable prev ,next button if need
				if($scope.currentPage ==1){
					$("#btn-prev-page").addClass("disabled");
				}else{
					$("#btn-prev-page").removeClass("disabled");
				}
				
				if($scope.currentPage==$scope.totalPage){
					$("#btn-next-page").addClass("disabled")
				}else{
					$("#btn-next-page").removeClass("disabled")
				}
				
				//Disable button has text ...
				$("button[type=button]:hasText(...)").addClass("disabled"); 
			}; 
			
			$scope.nextPage = function($event){
				if(!$("#btn-next-page").hasClass("disabled")){
					//SearchAmazonProduct
					var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content"); 
					var config = {
							headers:{ 
									'Accept':'application/json',
									'Content-Type': 'application/json' ,
									'X-CSRF-TOKEN':token
							}  
					} 
					
					$http.post("SearchAmazonProduct",JSON.stringify({
						searchData:$("#search-by-keyword").val(),
						isAsinSearch:false,
						page:$scope.currentPage+1,
						totalPage:$scope.totalPage
					}),config)
						 .success(function(data, status, headers,config) {
							 if(data.status==="OK"){ 
								$scope.currentPage= data.extraData.currentPage; 
								$scope.pages = []; 
								for(var pageIndex=0;pageIndex<data.extraData.totalPage;pageIndex++){
									$scope.pages.push(pageIndex+1);
								}
								$scope.listOfProduct = data.extraData.lstProductSearch;
								$scope.activeStyleForCurrentPage();
							 }else{
								alert(data.cause); 
							 }							 
						 })
						 .error(function(data, status, headers,config){
								console.log("Error");
						 }) 
				}  
			};
			
			$scope.prevPage = function($event){
				if(!$("#btn-prev-page").hasClass("disabled")){
					//SearchAmazonProduct
					var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content"); 
					var config = {
							headers:{ 
									'Accept':'application/json',
									'Content-Type': 'application/json' ,
									'X-CSRF-TOKEN':token
							}  
					} 
					
					$http.post("SearchAmazonProduct",JSON.stringify({
						searchData:$("#search-by-keyword").val(),
						isAsinSearch:false,
						page:$scope.currentPage-1,
						totalPage:$scope.totalPage
					}),config)
						 .success(function(data, status, headers,config) {
							 if(data.status==="OK"){ 
								$scope.currentPage= data.extraData.currentPage; 
								$scope.pages = []; 
								for(var pageIndex=0;pageIndex<data.extraData.totalPage;pageIndex++){
									$scope.pages.push(pageIndex+1);
								}
								$scope.listOfProduct = data.extraData.lstProductSearch;
								$scope.activeStyleForCurrentPage();
							 }else{
								alert(data.cause); 
							 }							 
						 })
						 .error(function(data, status, headers,config){
								console.log("Error");
						 }) 
				} 
			};
			
			$scope.changePage = function($event,$page,$totalPage){ 
				//SearchAmazonProduct
				var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content"); 
				var config = {
						headers:{ 
								'Accept':'application/json',
								'Content-Type': 'application/json' ,
								'X-CSRF-TOKEN':token
						}  
				} 
				
				$http.post("SearchAmazonProduct",JSON.stringify({
					searchData:$("#search-by-keyword").val(),
					isAsinSearch:false,
					page:$page,
					totalPage:$scope.totalPage
				}),config)
					 .success(function(data, status, headers,config) {
						 if(data.status==="OK"){ 
							$scope.currentPage= data.extraData.currentPage; 
							$scope.pages = []; 
							for(var pageIndex=0;pageIndex<data.extraData.totalPage;pageIndex++){
								$scope.pages.push(pageIndex+1);
							}
							$scope.listOfProduct = data.extraData.lstProductSearch;
							$scope.activeStyleForCurrentPage();
						 }else{
							alert(data.cause); 
						 }							 
					 })
					 .error(function(data, status, headers,config){
							console.log("Error");
					 })
				 
			}; 
			
			$("#search-by-keyword").on("keypress",function(evt){
				if(evt.which===13){ 
					//SearchAmazonProduct
					var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content"); 
					var config = {
							headers:{ 
									'Accept':'application/json',
									'Content-Type': 'application/json' ,
									'X-CSRF-TOKEN':token
							}  
					} 
					
					/* $http.post("SearchAmazonProduct",JSON.stringify({
						searchData:$("#search-by-keyword").val(),
						isAsinSearch:false,
						page:1
					}),config)
						 .success(function(data, status, headers,config) {
							 if(data.status==="OK"){ 
								$scope.listOfProduct = data.extraData.lstProductSearch;
								$scope.totalPage=data.extraData.totalPage;
								$scope.currentPage= data.extraData.currentPage;
								$scope.pages = [];
								if($scope.totalPage <=20){
									for(var pageIndex=0;pageIndex<data.extraData.totalPage;pageIndex++){
										$scope.pages.push(pageIndex+1);
									}
								}else{
									
								}
								
								console.log($scope.currentPage)
								
							 }else{
								alert(data.cause); 
							 }							 
						 })
						 .error(function(data, status, headers,config){
								console.log("Error");
						 }) */ 
					$http.post("SearchAmazonProductXml",JSON.stringify({
						searchData:$("#search-by-keyword").val(),
						isAsinSearch:false,
						page:1
					}),config)
						 .success(function(data, status, headers,config) {
							 if(data.status==="OK"){ 
								$scope.listOfProduct = data.extraData.lstProductSearch; 
							 }else{
								alert(data.cause); 
							 }							 
						 })
						 .error(function(data, status, headers,config){
								console.log("Error");
						 }) 
				}
			});		
			
			$("#search-by-asin").on("keypress",function(evt){
				if(evt.which===13){
					//SearchAmazonProduct
					var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content"); 
					var config = {
							headers:{ 
									'Accept':'application/json',
									'Content-Type': 'application/json' ,
									'X-CSRF-TOKEN':token
							}  
					} 
					
					/* $http.post("SearchAmazonProduct",JSON.stringify({
						searchData:$("#search-by-asin").val(),
						isAsinSearch:true,
						page:-1
					}),config)
						 .success(function(data, status, headers,config) {
							 if(data.status==="OK"){
								 $scope.listOfProduct = data.extraData.lstProductSearch;
								 $scope.pages = [];
							 }else{
								alert(data.cause); 
							 }							 
						 })
						 .error(function(data, status, headers,config){
								console.log("Error");
						 }) */ 
					$http.post("SearchAmazonProductXml",JSON.stringify({
						searchData:$("#search-by-asin").val(),
						isAsinSearch:true,
						page:-1
					}),config)
						 .success(function(data, status, headers,config) {
							 if(data.status==="OK"){
								 $scope.listOfProduct = data.extraData.lstProductSearch;
								 $scope.pages = [];
							 }else{
								alert(data.cause); 
							 }							 
						 })
						 .error(function(data, status, headers,config){
								console.log("Error");
						 }) 
				}
			});
		});
	</script>
</body>
</html>