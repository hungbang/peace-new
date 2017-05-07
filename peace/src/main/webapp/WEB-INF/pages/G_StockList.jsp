<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en-us" ng-app="stock-list-module">
<jsp:include page="../pages/common/header.jsp" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<body class="fixed-page-footer">
	<jsp:include page="../pages/common/menu-top.jsp" />
	<jsp:include page="../pages/common/menu-left.jsp" />
	<!-- MAIN PANEL -->
	<div id="main" role="main">
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
			 
    		[ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
			  display: none !important;
			}

			.required-field-block .required-icon .text {
				color: #B80000;
				font-size: 26px;
				margin: -3px 0 0 12px;
			}
			/* Required field END */
			
			.smart-form .row {
				margin: 0px;
				margin-bottom: 10px;
			}

			.jarviswidget>header {
    height: 50px;
    padding: 0;
    padding-left: 15px;
    line-height: 40px;
}

		</style> 

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

    <div class="col-lg-12" style=" display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 15px; padding-bottom: 100px;
" >
            <div class="row  col-md-12" width="100%">
                <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
                     data-widget-editbutton="false">
                    <header>
                        <h1>在庫チェック：在庫一覧</h1>
                    </header>
                    <div>
                        <div class="jarviswidget-editbox"></div>
                        
			<div id="content" class="row" width="100%">
				<!-- widget grid -->
				
				<section id="widget-grid" class="">

					<!-- widget div-->
					<div class="row" ng-controller="stockListController">
						<div class="widget-body ">
							<form class="smart-form">
								<fieldset>
									<div class="row" style="background-color:white;">
										<table class="table table-bordered table-striped responsive-utilities">
											<thead>
											  <tr> 
												<th class="select-checkbox " style="width: 15px;">
							                        <label class="checkbox">
							                        	<input name="select_all" id="select_all" value="1" type="checkbox"><i style="top: -16px !important"></i>
							                        </label>
							                     </th>
												<th ng-click="sort('id')">
												  No.
												<span class="glyphicon sort-icon" ng-show="sortKey=='id'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th>
												<th ng-click="sort('storeName')">
												  店舗名
												<span class="glyphicon sort-icon" ng-show="sortKey=='storeName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th>
												<th ng-click="sort('productName')">
												  商品名	
												<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th>
												<th ng-click="sort('productName')">
												  仕入URL
												<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th>
												<th ng-click="sort('buyPrice')">
												  仕入価格(円)
												<span class="glyphicon sort-icon" ng-show="sortKey=='buyPrice'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th>
												<th ng-click="sort('logicCheck')">
												  Check Logic
												  <span class="glyphicon sort-icon" ng-show="sortKey=='checkLogic'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th>
												<th ng-click="sort('stockWord')">
												  在庫ワード
												<span class="glyphicon sort-icon" ng-show="sortKey=='stockWord'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th>
												<th ng-click="sort('note')">
												  	メモ
												<span class="glyphicon sort-icon" ng-show="sortKey=='note'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
												</th> 
											  </tr>
											</thead>
											<tbody id="listContent">
											<!--
											  <tr dir-paginate ="stock in listStock |orderBy:sortKey:reverse |itemsPerPage:20 track by $index  " ng-cloak>
												<td class="select-checkbox" style="width: 15px;">
							                        <label class="checkbox">
							                        	<input name="select_stock"  ng-change="recordSelectedChange($index)" ng-model="stock.isSelected" value="1" data-stock-id="{{stock.id}}" type="checkbox"><i></i>
							                        </label>
							                     </td>
												<td class="is-hidden">{{stock.id}}</td>
												<td class="is-hidden">{{stock.storeName}}</td>
												<td class="is-hidden">{{stock.productName}}</td>
												<td class="">
													<a href="{{stock.vendorURL}}">仕入れ先</a> 
												</td>
												<td class="is-visible">{{stock.buyPrice}}</td>
												<td class="is-hidden">{{stock.logicCheck}}</td>
												<td class="is-hidden">{{stock.stockWord}}</td>
												<td class="is-hidden">{{stock.note}}</td>  
											  </tr>
											</tbody>
											-->
										</table>
										<!-- Pagination
							            <dir-pagination-controls
										       max-size="5"
										       direction-links="true"
										       boundary-links="true" style=" width: 100%;display: -webkit-box;margin-left: 24px;margin-top: 12px;align-items: center;" >
										</dir-pagination-controls>
									</div>
									-->
									<div class="row col-md-12" style="margin-top: 10px;" >
									<div class="col-md-8"></div>
									
									<button type="submit" style="float: right;" id="btnReset" class="btn btn-primary col-md-1" >
										Reset
									</button>
									<button style="margin-right: 10px; margin-left: 10px; float: right;" type="submit" id="btnDelete"  class="btn btn-primary col-md-1" >
										削除
									</button>
									<button style="margin-left: 10px; float: right;" type="button" id="btnChange" class="btn btn-default col-md-1">
										変更
									</button>
								</div>
								</fieldset>
								
							</form>
						</div>
					</div>
					<!-- end widget div -->
				</section>
				<!-- end widget grid -->
				
			</div>
                    </div>
                </div>
            </div>
	
        
            </div>
        </div>
    </div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->

	
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

	<!--Replace angularjs-->
	<script type="text/javascript">
		$(function () {
		    //Reset
			$("#btnReset").on("click",function (evt) {
				evt.preventDefault();
				alert("reset");
            })

			//Delete
			$("#btnDelete").on("click",function(evt){
			    evt.preventDefault();
                var selectedStockLayout= $("input[name=select_stock]:checked");
                if(selectedStockLayout.size()>0){
                    var selectedStockIds = [];
                    selectedStockLayout.each(function(k,v){
                        selectedStockIds.push($(v).attr("data-stock-id"));
                    });

                    //Send ajax to add stock registor
                    var token = $("meta[name='_csrf']").attr("content");
                    var header = $("meta[name='_csrf_header']").attr("content");
                    $.ajax({
                        type : "POST",
                        contentType : "application/json",
                        url : "DeleteStocks",
                        data: JSON.stringify(selectedStockIds),
                        beforeSend:function(xhr){
                            xhr.setRequestHeader(header, token);
                        },
                        dataType : 'json',
                        timeout : 100000,
                        success : function(data) {
                            if(data.status==="OK"){
                                alert("Delete success!")
                                window.location.reload();
                            }else{
                                alert(data.cause);
                            }
                        },
                        error : function(e) {
                            console.log("ERROR: ", e);
                        },
                        done : function(e) {
                            console.log("DONE");
                        }
                    });

                }else{
                    alert("You must select least one of stock records to delete!");
                }
			});

			//Change
			$("#btnChange").on("click",function (evt) {
				evt.preventDefault();
                var selectedStockLayout= $("input[name=select_stock]:checked");
                if(selectedStockLayout.size()>0){
                    var stockId = selectedStockLayout.first().attr("data-stock-id");
                    window.location.href = "StockRegistor/"+ stockId;
                }else{
                    alert("You must select one record to edit!!")
                }
            })

			//Select all
			$("#select_all").on("change",function(evt){
                $("input[name=select_stock]").prop("checked",$(this).prop("checked"));
			});


            function loadStockList(){
                $.get("LoadStockList",function(data,status){
                    var listStock = data.extraData;
                    listStock.forEach(function (stock,index) {
						var template = "<tr><td class='select-checkbox' style='width: 15px;'>"+
                            "<label class='checkbox'>"+
                            "<input name='select_stock' class='select_stock' value='1' data-stock-id='"+stock.id+"' type='checkbox'><i></i></label></td>"+
                            "<td class='is-hidden'>"+stock.id+"</td>"+
                            "<td class='is-hidden'>"+stock.storeName+"</td>"+
                            "<td class='is-hidden'"+stock.productName+"</td>"+
                            "<td class=''>"+
                            "  <a href='"+stock.vendorURL+"'>仕入れ先</a> "+
                            "</td>"+
                            "<td class='is-visible'>"+stock.buyPrice+"</td>"+
                            "<td class='is-hidden'>"+stock.logicCheck+"</td>"+
                            "<td class='is-hidden'>"+stock.stockWord+"</td>"+
                            "<td class='is-hidden'>"+stock.note+"</td>  "+
                            "</tr>";
						$("#listContent").append($(template));
                    });

                    //Handing event change
					$(".select_stock").on("change",function(){
                        if(!$(this).prop("checked")){
                            if($("input[name=select_stock]:checked").size()===0){
                                $("#select_all").prop("checked",false);
                            }
                        }
					});
				});
            };

			//Default load stock list
            loadStockList();
        })
	</script>

	<!-- LOAD ANGULAR JS MODULE
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/angular.js"/>"></script>
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/dirPagination.js"/>"></script>
	-->
	<!-- SCRIPT HANDING EVENT SEARCH PRODUCT (Author napt2017)
	<script type="text/javascript">
		var stockListModule = angular.module("stock-list-module", ['angularUtils.directives.dirPagination']); 
		stockListModule.controller("stockListController",function($scope, $http) {   
			$scope.isSelectAll = false;
			$scope.reset = function($event){ 
				$event.preventDefault();
				alert("reset");
			};
			
			$scope.recordSelectedChange = function($index){
				var stockRecord = $scope.listStock[$index];
				if(!stockRecord.isSelected){
					if($("input[name=select_stock]:checked").size()===0){
						$scope.isSelectAll = false;
					}
				}
			}
			
			$scope.selectAll =function(_this){ 
				$("input[name=select_stock]").prop("checked",$scope.isSelectAll);
			};
			
			$scope.sort = function(keyname){
		        $scope.sortKey = keyname;   //set the sortKey to the param passed
		        $scope.reverse = !$scope.reverse; //if true make it false and vice versa
		    }
			
			$scope.deleteStock = function($event){
				$event.preventDefault();
				var selectedStockLayout= $("input[name=select_stock]:checked");
				if(selectedStockLayout.size()>0){
					var selectedStockIds = [];
					selectedStockLayout.each(function(k,v){
						selectedStockIds.push($(v).attr("data-stock-id"));
					});
					
					//Send ajax to add stock registor 
					var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content"); 
					var config = {
							headers:{ 
									'Accept':'application/json',
									'Content-Type': 'application/json' ,
									'X-CSRF-TOKEN':token
							}  
					} 
					
					$http.post("DeleteStocks",JSON.stringify(selectedStockIds),config)
						 .success(function(data, status, headers,config) {
							 if(data.status==="OK"){ 
								alert("Delete success!")
								window.location.reload();
							 }else{
								alert(data.cause); 
							 }							 
						 })
						 .error(function(data, status, headers,config){
								console.log("Error");
						 })  
				}else{
					alert("You must select least one of stock records to delete!");
				}
			};
			
			$scope.change = function($event){ 
				$event.preventDefault();
				var selectedStockLayout= $("input[name=select_stock]:checked");
				if(selectedStockLayout.size()>0){
					var stockId = selectedStockLayout.first().attr("data-stock-id");
					window.location.href = "StockRegistor/"+ stockId;
				}else{
					alert("You must select one record to edit!!")
				}
			};   
			
			$scope.loadStockList = function(){
				//LoadStockList
				$http.get("LoadStockList")
				 .success(function(data, status, headers,config) {
					 $scope.listStock = data.extraData;
				 })
				 .error(function(data, status, headers,config) {
					  console.log(data);
				});
			};
			
			//Default load stock list
			$scope.loadStockList();
		});
	</script>
	-->
</body>
</html>