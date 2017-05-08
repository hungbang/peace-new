<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en-us" ng-app="stock-register-module">
<jsp:include page="../pages/common/header.jsp" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<body class="fixed-page-footer">
<jsp:include page="../pages/common/menu-top.jsp" />
<jsp:include page="../pages/common/menu-left.jsp" />
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

	.smart-form .row {
		margin: 0px;
		margin-bottom: 10px;
	}

	@media (min-width: 320px) {

		.smart-form *, .smart-form :after, .smart-form :before  {
			margin-bottom: 5px;
			padding: 0;
			box-sizing: content-box;
		}
	}

	@media (max-width: 420px) {

		.smart-form .label.col {
			margin: 0;
			padding-bottom: 10px;
			padding-top: 0px;
		}
	}


	.smart-form .label.col {
		margin: 0;
		padding-top: 10px;
	}
	
	.smart-form fieldset {

    display: block;
    /* padding: 25px 14px 5px; */
    border: none;
    background: rgba(255,255,255,.9);
    position: relative;
	}
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
			<li>Home</li><li>在庫チェック：新規登録</li>
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
            <div class="row col-md-12" width="100%">
                <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
                     data-widget-editbutton="false">
                    <header>
                        <h2>在庫チェック：新規登録</h2>
                    </header>
                    <div>
                        <div class="jarviswidget-editbox"></div>
                        <div id="content">
		<!-- widget grid -->

		<section id="widget-grid" class="">

			<!-- widget div-->
			<div class="row">
				<div class="widget-body" >
					<form class="smart-form">
						<fieldset>
							<section class="row" style="margin-bottom:20px;font-size: larger; display:none;" >
								<div class="col col-1"></div>

								<div class="col col-6 inline-group" style="margin-top:5px">
									<label class="">
										<input type="radio" name="radioStock" checked="checked" id="all" onClick="radioClick(this)">
										<i></i>Any Stock</label>
									<label class="">
										<input type="radio" name="radioStock" id="amazon" onClick="radioClick(this)">
										<i></i>Stock Amazon</label>
								</div>
							</section>
							<div class="row" id="AllStock">
								<input type="hidden" value="${stockId}" id="stockId"/>
								<section class="row smart-form"> <label
										class="label col col-2">店舗名</label> <label
										class="col col-10">
									<input type="text" id="store-name"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">※商品名</label> <label
										class="col col-10">
									<input type="text" id="product-name"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">※仕入URL</label> <label
										class="col col-10">
									<input type="text" id="purchasing-url"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">★仕入価格(円)</label> <label
										class="col col-10">
									<input type="number" value="0"  id="puschase-price"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">※チェックロジック(1,2)</label> <div
										class="col col-6">
									<div class="row smart-form ">
										<div  class='col-sm-1 col-xs-1' style="padding-top: 2px;">
											<input type="radio" checked="" name="radio-inline" id="option-check1" value="1" class="">
										</div>

										<div class="col-sm-10 col-xs-10">
											check1 (在庫チェック対象を「在庫ワード」のみとします。)
										</div>
									</div>
									<div class="row smart-form">
										<div  class='col-sm-1 col-xs-1' style="padding-top: 2px;">
											<input type="radio" checked="" name="radio-inline"  id="option-check2"  value="2" >
										</div>
										<div class="col-sm-10 col-xs-10">
											check2 (在庫チェック対象を「在庫ワード」且つ「仕入れ価格（円）」とします。)
										</div>
									</div>
								</div>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">※在庫ワード</label> <label
										class="col col-10">
									<input type="text" id="stock-word" class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">メモ</label> <label
										class="col col-10">
									<input type="text" id="note"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
							</div>
							<div class="row" id="AmazonStock" style="display:none">
								<section class="row smart-form"> <label
										class="label col col-2">ASIN code</label> <label
										class="col col-10">
									<input type="text"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">Product name</label> <label
										class="col col-10">
									<input type="text"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>

								<section class="row smart-form"> <label
										class="label col col-2">Base price</label> <label
										class="col col-10">
									<input type="text"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>

								<section class="row smart-form"> <label
										class="label col col-2">Alert lower limit price</label> <label
										class="col col-6">
									<input type="text"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>

								<section class="row smart-form"> <label
										class="label col col-2">Alert upper limit price</label> <label
										class="col col-10">
									<input type="text"  class="form-control" style="width: 100%; padding-left: 5px;" >
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">Alert upper limit price</label> <label
										class="col col-10">
									<select class="" style="width:50%" id="select-" >
										<option>Only check for new items</option>
										<option>Check only secondhand</option>
										<option>Check both of them (Prioritize new items if they are both)</option>
										<option>Check both of them (Prioritize new items if they are both)</option>
										<option>Check both (If you have both, second hand first)</option>
									</select>
								</label>
								</section>
								<section class="row smart-form"> <label
										class="label col col-2">Notes</label> <label
										class="col col-10">
									<input type="text"  class="form-control" style="width: 100%" >
								</label>
								</section>

								<div class="note">
									<p>
										[Supplement] How to use
										(â» 1) I want to sell this product, but I thought that the lowest price at that time is 15000 yen when thinking that it is not easy to get out because Amazon's selling price is high.
										If you think that you would like to buy at 13500 yen
										ãbase price: 15000
										ãAlert lower limit price:
										set as 1500 , so that notification comes when the lowest price becomes less than 13500 yen.
										(* 2) is simply the opposite of â» 1.
									</p>
								</div>
							</div>
						</fieldset>
						<div type="submit" class='row' style="margin: 20px;">
							<div  class="col-lg-11 col-md-11 col-sm-8"></div>
							<button id ="btnRegistorStock"  class="col-lg-1 col-md-1 col-sm-4 col-xs-12 btn btn-primary">登録</button>
						</div>
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
<%--<script type="text/javascript">--%>
    <%--var _gaq = _gaq || [];--%>
    <%--_gaq.push([ '_setAccount', 'UA-XXXXXXXX-X' ]);--%>
    <%--_gaq.push([ '_trackPageview' ]);--%>

    <%--(function() {--%>
        <%--var ga = document.createElement('script');--%>
        <%--ga.type = 'text/javascript';--%>
        <%--ga.async = true;--%>
        <%--ga.src = ('https:' == document.location.protocol ? 'https://ssl'--%>
                <%--: 'http://www')--%>
            <%--+ '.google-analytics.com/ga.js';--%>
        <%--var s = document.getElementsByTagName('script')[0];--%>
        <%--s.parentNode.insertBefore(ga, s);--%>
    <%--})();--%>
<%--</script>--%>

<!--Replace angularjs-->
<script type="text/javascript">
    $(function () {
        //Register event click submit
        $("#btnRegistorStock").on("click",function(evt){
            registerStock(evt);
        });

        //Is valid url
        function isVaildUrl(str){
            var pattern =  /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
            return pattern.test(str);
        }

        //Registor stock function
        function registerStock(evt) {
            evt.preventDefault();
            if($("#store-name").val()===""){
                alert("Empty store name!")
                return false;
            }
            if($("#product-name").val()===""){
                alert("Empty product name!")
                return false;
            }
            if($("#purchasing-url").val()===""){
                alert("Empty purchasing url!")
                return false;
            }else{
                if(!isVaildUrl($("#purchasing-url").val())){
                    alert("The puschasing url is not correct format!");
                    return;
                }
            }
            if(parseInt($("#puschase-price").val())<=0){
                alert("The puschase price must greater than 0!!")
                return false;
            }
            if($("#stock-word").val()===""){
                alert("Empty stock word!")
                return false;
            }
            if($("#note").val()===""){
                alert("Empty note!!")
                return false;
            }

            //Send ajax to add stock registor
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");

            if(parseInt($("#stockId").val()) >0){
                var dataPost = {
                    id:parseInt($("#stockId").val()),
                    storeName:$("#store-name").val(),
                    productName:$("#product-name").val(),
                    vendorURL:$("#purchasing-url").val(),
                    buyPrice:$("#puschase-price").val(),
                    logicCheck:$("#option-check1").prop("checked")===true?1:2,
                    stock:0,
                    note:$("#note").val(),
                    stockWord:$("#stock-word").val(),
                    isSelected:false
                };

                $.ajax({
                    type : "POST",
                    contentType : "application/json",
                    url : "/UpdateStockRegistor",
                    data: JSON.stringify(dataPost),
                    beforeSend:function(xhr){
                        xhr.setRequestHeader(header, token);
                    },
                    dataType : 'json',
                    timeout : 100000,
                    success : function(data) {
                        if(data.status==="OK"){
                            alert("Update Success!!");
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
                //Add new
                var dataPost = {
                    id:0,
                    storeName:$("#store-name").val(),
                    productName:$("#product-name").val(),
                    vendorURL:$("#purchasing-url").val(),
                    buyPrice:$("#puschase-price").val(),
                    logicCheck:$("#option-check1").prop("checked")===true?1:2,
                    stock:0,
                    note:$("#note").val(),
                    stockWord:$("#stock-word").val(),
                    isSelected:false
                };

                $.ajax({
                    type : "POST",
                    contentType : "application/json",
                    url : "AddStockRegistor",
                    data: JSON.stringify(dataPost),
                    beforeSend:function(xhr){
                        xhr.setRequestHeader(header, token);
                    },
                    dataType : 'json',
                    timeout : 100000,
                    success : function(data) {
                        if(data.status==="OK"){
                            alert("Add success!");
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
            }
        }

        function defaultLoadModel() {
            //Default load model
            if(parseInt($("#stockId").val()) >0){
                $.get("/GetStockRegistor/"+$("#stockId").val(),function (data,status) {
                    if(data.extraData){
                        var stockModel = data.extraData;
                        $("#stockId").val(stockModel.id)
                        $("#store-name").val(stockModel.storeName)
                        $("#product-name").val(stockModel.productName)
                        $("#purchasing-url").val(stockModel.vendorURL)
                        $("#puschase-price").val(stockModel.buyPrice)
                        if(stockModel.logicCheck===1){
                            $("#option-check1").prop("checked",true);
                        }else{
                            $("#option-check2").prop("checked",true);
                        }
                        $("#note").val(stockModel.note)
                        $("#stock-word").val(stockModel.stockWord)
                    }
                }) ;
            }
        }

        //Default load model
        defaultLoadModel();
    })
</script>
<!-- LOAD ANGULAR JS MODULE
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/angular.js"/>"></script>
	-->
<!-- SCRIPT HANDING EVENT SEARCH PRODUCT (Author napt2017)
<script type="text/javascript">
    var stockRegisterModule = angular.module("stock-register-module", []);
    stockRegisterModule.controller("stockRegistorController",function($scope,$http){
        $scope.registerStock = function($event){
            $event.preventDefault();
            if($("#store-name").val()===""){
                alert("Empty store name!")
                return false;
            }
            if($("#product-name").val()===""){
                alert("Empty product name!")
                return false;
            }
            if($("#purchasing-url").val()===""){
                alert("Empty purchasing url!")
                return false;
            }else{
                if(!$scope.isVaildUrl($("#purchasing-url").val())){
                    alert("The puschasing url is not correct format!");
                    return;

                }
            }
            if(parseInt($("#puschase-price").val())<=0){
                alert("The puschase price must greater than 0!!")
                return false;
            }
            /*if($("#option-check1").val()===""){
                alert("Empty!")
                return false;
            }
            if($("#option-check2").val()===""){
                alert("Empty!")
                return false;
            }*/
            if($("#stock-word").val()===""){
                alert("Empty stock word!")
                return false;
            }
            if($("#note").val()===""){
                alert("Empty note!!")
                return false;
            }

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
            if(parseInt($("#stockId").val()) >0){
                //Update
                $scope.stockModel.logicCheck =1;
                $http.post("/UpdateStockRegistor",JSON.stringify($scope.stockModel),config)
                 .success(function(data, status, headers,config) {
                     if(data.status==="OK"){
                        alert("Update Success!!");
                        window.location.reload();
                     }else{
                        alert(data.cause);
                     }
                 })
                 .error(function(data, status, headers,config){
                        console.log("Error");
                 })
            }else{
                //Add new
                $http.post("AddStockRegistor",JSON.stringify($scope.stockModel),config)
                 .success(function(data, status, headers,config) {
                     if(data.status==="OK"){
                        alert("Add success!");
                        window.location.reload();
                     }else{
                        alert(data.cause);
                     }
                 })
                 .error(function(data, status, headers,config){
                        console.log("Error");
                 })
            }
        };

        $scope.isVaildUrl = function(str) {
              var pattern =  /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
              return pattern.test(str);
        }

        //Default load model
        if(parseInt($("#stockId").val()) >0){
            $http.get("/GetStockRegistor/"+$("#stockId").val())
             .success(function(data, status, headers,config) {
                 if(data.extraData){
                     $scope.stockModel = data.extraData;
                 }
             })
             .error(function(data, status, headers,config) {
                  console.log(data);
            });
        }else{
            //Init default model
            $scope.stockModel = {
                id:0,
                storeName:"",
                productName:"",
                vendorURL:"",
                buyPrice:"",
                logicCheck:2,
                stock:12,
                note:"",
                stockWord:""
            };
        }
    });
</script>
-->
</body>
</html>