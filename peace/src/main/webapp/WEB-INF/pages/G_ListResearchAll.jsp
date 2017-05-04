<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en-us" ng-app="product_shopping_search">
<jsp:include page="../pages/common/header.jsp" />
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
							<h2>まとめてリサーチ</h2>
						</header>
						<form class="smart-form">
							<fieldset>
								<div class="row">
									<section class="col col-4">
										<label class="label">Key Search</label> <label class="input ">
											<input type="text" id="productSearch" ng-change="searchProduct()" ng-model="searchModel" class="input" maxlength="80">
										</label>
									</section>
								</div>
								<section style="">
									<div class="inline-group" style="padding-top: 30px">
										<label class="radio "> <input type="radio" value="all"
											name="radio-inline" id="all" checked="checked"> <i></i>All
										</label> <label class="radio "> <input type="radio" value="ebay"
											name="radio-inline" id="ebay"> <i></i>Ebay
										</label> <label class="radio "> <input type="radio" value="yahooShopping"
											name="radio-inline" id="yahoo_shopping"> <i></i>
											Yahoo! Shopping
										</label> <label class="radio "> <input type="radio" value="yahooAuction"
											name="radio-inline" id="yahoo_auction"> <i></i>
											Yahoo! Auction
										</label> <label class="radio "> <input type="radio" value="rakuten"
											name="radio-inline" id="rakuten_research"> <i></i>
											Rakuten Research
										</label>
									</div>
								</section>
							</fieldset>
						</form>
					</div>
					<div class="row"
						style="background-color: white; padding-right: 40px;">
						<div class="col col-lg-12">
							<label id="lbAmazonHeader" class="label labelHeader">Amazon</label>
							<table
									id="tbAmazon"
							class="table table-bordered table-striped responsive-utilities"
							style="margin-left: 25px">
							<thead>
								<tr>
									<th ng-click="sort('image')">Image
										<span class="glyphicon sort-icon" ng-show="sortKey=='image'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('productName')">Product Name
										<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('price')">Price
										<span class="glyphicon sort-icon" ng-show="sortKey=='price'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('stock')">Stock
										<span class="glyphicon sort-icon" ng-show="sortKey=='stock'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('exhibition')">Exhibition
										<span class="glyphicon sort-icon" ng-show="sortKey=='exhibition'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
								</tr>
							</thead>
							<tbody class="searchBody">
								<!--
								<tr dir-paginate ="product in listOfProduct |orderBy:sortKey:reverse |itemsPerPage:6">
									<td class="col col-1" ng-cloak ><image width="64" height="64"
											src="{{product.image}}" /></td>
									<td ng-cloak class="is-visible"><p>{{product.productName}}</p></td>
									<td ng-cloak class="is-hidden">{{product.price}}</td>
									<td ng-cloak class="is-hidden">{{product.stock}}</td>
									<td class="is-hidden" ng-cloak>
										<!--
										<a ng-if="isEbaySearch==true" ng-cloak ng-click="sendToAddProduct($event,product.itemId)" href="{{product.exhibition}}">Go to add ebay item</a>
										<a ng-if="isEbaySearch==false" ng-cloak href="{{product.exhibition}}">{{product.exhibition}}</a>

										<a ng-cloak ng-click="sendToAddProduct($event,product.itemId,product.searchSite)" href="{{product.exhibition}}">Go to add ebay item</a>
									</td>
								</tr>
								-->
							</tbody> 
						</table>
						<!--
						<dir-pagination-controls
						       max-size="5"
						       direction-links="true"
						       boundary-links="true" >
						</dir-pagination-controls>
						-->
							<label id="lbEbayHeader" class="label labelHeader">Ebay</label>
							<table
									id="tbEbay"
									class="table table-bordered table-striped responsive-utilities"
									style="margin-left: 25px">
								<thead>
								<tr>
									<th ng-click="sort('image')">Image
										<span class="glyphicon sort-icon" ng-show="sortKey=='image'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('productName')">Product Name
										<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('price')">Price
										<span class="glyphicon sort-icon" ng-show="sortKey=='price'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('stock')">Stock
										<span class="glyphicon sort-icon" ng-show="sortKey=='stock'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('exhibition')">Exhibition
										<span class="glyphicon sort-icon" ng-show="sortKey=='exhibition'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
								</tr>
								</thead>
								<tbody class="searchBody">
								<!--
								<tr dir-paginate ="product in listOfProduct |orderBy:sortKey:reverse |itemsPerPage:6">
									<td class="col col-1" ng-cloak ><image width="64" height="64"
											src="{{product.image}}" /></td>
									<td ng-cloak class="is-visible"><p>{{product.productName}}</p></td>
									<td ng-cloak class="is-hidden">{{product.price}}</td>
									<td ng-cloak class="is-hidden">{{product.stock}}</td>
									<td class="is-hidden" ng-cloak>
										<!--
										<a ng-if="isEbaySearch==true" ng-cloak ng-click="sendToAddProduct($event,product.itemId)" href="{{product.exhibition}}">Go to add ebay item</a>
										<a ng-if="isEbaySearch==false" ng-cloak href="{{product.exhibition}}">{{product.exhibition}}</a>

										<a ng-cloak ng-click="sendToAddProduct($event,product.itemId,product.searchSite)" href="{{product.exhibition}}">Go to add ebay item</a>
									</td>
								</tr>
								-->
								</tbody>
							</table>

							<table
									id="tbYahooShopping"
									class="table table-bordered table-striped responsive-utilities"
									style="margin-left: 25px">
								<thead>
								<tr>
									<th ng-click="sort('image')">Image
										<span class="glyphicon sort-icon" ng-show="sortKey=='image'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('productName')">Product Name
										<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('price')">Price
										<span class="glyphicon sort-icon" ng-show="sortKey=='price'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('stock')">Stock
										<span class="glyphicon sort-icon" ng-show="sortKey=='stock'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('exhibition')">Exhibition
										<span class="glyphicon sort-icon" ng-show="sortKey=='exhibition'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
								</tr>
								</thead>
								<tbody class="searchBody">
								<!--
								<tr dir-paginate ="product in listOfProduct |orderBy:sortKey:reverse |itemsPerPage:6">
									<td class="col col-1" ng-cloak ><image width="64" height="64"
											src="{{product.image}}" /></td>
									<td ng-cloak class="is-visible"><p>{{product.productName}}</p></td>
									<td ng-cloak class="is-hidden">{{product.price}}</td>
									<td ng-cloak class="is-hidden">{{product.stock}}</td>
									<td class="is-hidden" ng-cloak>
										<!--
										<a ng-if="isEbaySearch==true" ng-cloak ng-click="sendToAddProduct($event,product.itemId)" href="{{product.exhibition}}">Go to add ebay item</a>
										<a ng-if="isEbaySearch==false" ng-cloak href="{{product.exhibition}}">{{product.exhibition}}</a>

										<a ng-cloak ng-click="sendToAddProduct($event,product.itemId,product.searchSite)" href="{{product.exhibition}}">Go to add ebay item</a>
									</td>
								</tr>
								-->
								</tbody>
							</table>

							<label id="lbYahooHeader" class="label labelHeader">Yahoo! Shopping</label>
							<table
									id="tbYahooAution"
									class="table table-bordered table-striped responsive-utilities"
									style="margin-left: 25px">
								<thead>
								<tr>
									<th ng-click="sort('image')">Image
										<span class="glyphicon sort-icon" ng-show="sortKey=='image'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('productName')">Product Name
										<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('price')">Price
										<span class="glyphicon sort-icon" ng-show="sortKey=='price'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('stock')">Stock
										<span class="glyphicon sort-icon" ng-show="sortKey=='stock'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('exhibition')">Exhibition
										<span class="glyphicon sort-icon" ng-show="sortKey=='exhibition'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
								</tr>
								</thead>
								<tbody class="searchBody">
								<!--
								<tr dir-paginate ="product in listOfProduct |orderBy:sortKey:reverse |itemsPerPage:6">
									<td class="col col-1" ng-cloak ><image width="64" height="64"
											src="{{product.image}}" /></td>
									<td ng-cloak class="is-visible"><p>{{product.productName}}</p></td>
									<td ng-cloak class="is-hidden">{{product.price}}</td>
									<td ng-cloak class="is-hidden">{{product.stock}}</td>
									<td class="is-hidden" ng-cloak>
										<!--
										<a ng-if="isEbaySearch==true" ng-cloak ng-click="sendToAddProduct($event,product.itemId)" href="{{product.exhibition}}">Go to add ebay item</a>
										<a ng-if="isEbaySearch==false" ng-cloak href="{{product.exhibition}}">{{product.exhibition}}</a>

										<a ng-cloak ng-click="sendToAddProduct($event,product.itemId,product.searchSite)" href="{{product.exhibition}}">Go to add ebay item</a>
									</td>
								</tr>
								-->
								</tbody>
							</table>

							<label id="lbRakutenHeader" class="label labelHeader">Rakuten</label>
							<table
									id="tbRakuten"
									class="table table-bordered table-striped responsive-utilities"
									style="margin-left: 25px">
								<thead>
								<tr>
									<th ng-click="sort('image')">Image
										<span class="glyphicon sort-icon" ng-show="sortKey=='image'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('productName')">Product Name
										<span class="glyphicon sort-icon" ng-show="sortKey=='productName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('price')">Price
										<span class="glyphicon sort-icon" ng-show="sortKey=='price'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('stock')">Stock
										<span class="glyphicon sort-icon" ng-show="sortKey=='stock'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
									<th ng-click="sort('exhibition')">Exhibition
										<span class="glyphicon sort-icon" ng-show="sortKey=='exhibition'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></span>
									</th>
								</tr>
								</thead>
								<tbody class="searchBody">
								<!--
								<tr dir-paginate ="product in listOfProduct |orderBy:sortKey:reverse |itemsPerPage:6">
									<td class="col col-1" ng-cloak ><image width="64" height="64"
											src="{{product.image}}" /></td>
									<td ng-cloak class="is-visible"><p>{{product.productName}}</p></td>
									<td ng-cloak class="is-hidden">{{product.price}}</td>
									<td ng-cloak class="is-hidden">{{product.stock}}</td>
									<td class="is-hidden" ng-cloak>
										<!--
										<a ng-if="isEbaySearch==true" ng-cloak ng-click="sendToAddProduct($event,product.itemId)" href="{{product.exhibition}}">Go to add ebay item</a>
										<a ng-if="isEbaySearch==false" ng-cloak href="{{product.exhibition}}">{{product.exhibition}}</a>

										<a ng-cloak ng-click="sendToAddProduct($event,product.itemId,product.searchSite)" href="{{product.exhibition}}">Go to add ebay item</a>
									</td>
								</tr>
								-->
								</tbody>
							</table>
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
#tbAmazon, #tbEbay, #tbRakuten, #tbYahooAution, #tbYahooShopping, #lbAmazonHeader, #lbEbayHeader, #lbRakutenHeader, #lbYahooHeader {
	display: none;
}
.labelHeader {
	font-size: 26px;
	margin-left: 10px;
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
	
	<!--Replace the angular-->
	<script type="text/javascript">
		$(function () {
		    //Function bind search product to layout
			function bindProductToLayout(listOfSearchProduct, idTable, keyword) {
                $("#"+idTable+" .searchBody").html('');
				listOfSearchProduct.forEach(function(product,index){
					var template =
                    "<tr><td class='col col-1'><image width='64' height='64'src='"+product.image+"'/></td>"+
                    "	<td class='is-visible'><p>"+product.productName +"</p></td>"+
                    "	<td class='is-hidden'>"+product.price +"</td>"+
                    "	<td class='is-hidden'>"+product.stock +"</td>"+
                    "	<td class='is-hidden send-to-ebay' data-product-id='"+product.itemId+"' data-search-site='"+product.searchSite+"'> "+
                    "	<a href='"+"SendToSell/"+product.searchSite+"/"+product.itemId+"/"+keyword+"'>Go to add ebay</a>"+
                    "	</td>"+
                    "</tr>";
					$("#"+idTable+" .searchBody").append($(template));
				});

                if (!$('#tbAmazon .searchBody tr').length) {
                    $("#"+idTable).hide();
				}
				$(".send-to-ebay").on("click","a",function(evt){
				    evt.preventDefault();
					var itemId = $(this).parent().attr("data-product-id");
					var searchSite= $(this).parent().attr("data-search-site");
					var keyword = $("#productSearch").val();
                    window.location.href = "SendToSell/"+searchSite+"/"+itemId+"/"+keyword;
				});
            }

            $("#productSearch").on("keypress",function (evt) {
				if(evt.keyCode ===13){
				    evt.preventDefault();
                    $("#searchBody").empty();
				    var keyword = $(this).val();
				    searchProduct(keyword);
				}
            })

            function searchProduct(keyword){
                if (keyword !== "") {

                    if ($("#all").prop("checked")) {
                        //Search all
                        searchAllKeyword(keyword);
                    } else if ($("#amazon").prop("checked")) {
                        //Search amazon
                        $scope.amazon.searchProductByKeyword(keyword);
                    } else if ($("#ebay").prop("checked")) {
                        //Search ebay
                        ebaySearchProductByKeyword(keyword);
                    } else if ($("#yahoo_shopping").prop("checked")) {
                        //Search yahoo shopping
                        yahooSearchProductByKeyword(keyword);
                    } else if ($("#yahoo_auction").prop("checked")) {
                        //Search yahoo auction
                        yahooSearchProductByKeyword(keyword);
                    } else if ($("#rakuten_research").prop("checked")) {
                        //Search rakuten
                        rakutenSearchProductByKeyword(keyword);
                    }
                }
			}

            function findItemsByKeywords(root) {
                var items = root.findItemsByKeywordsResponse[0].searchResult[0].item || [];
                var listOfProduct = [];
                for (var i = 0; i < items.length; ++i) {
                    var item = items[i];
                    var title = item.title[0];
                    var pic = item.galleryURL[0];
                    var viewitem = item.viewItemURL[0];
                    listOfProduct.push({
                        productName : title,
                        image : pic,
                        price : 0,
                        stock : "",
                        exhibition : viewitem,
                        itemId:item.itemId,
                        searchSite:"ebay"
                    });
                }
                return listOfProduct;
            }
            // search all
            function searchAllKeyword(keyWord) {
               $.get("searchAll/"+keyWord,function(data,status){
                   convertDataForSearchAll(data, keyWord);
            	});
            }
            $('input[type="radio"]').click(function () {
                onChangeRadioBtn();
			});

            const tb = {
                amazon: {
                    tbId: 'tbAmazon',
                    lbId: 'lbAmazonHeader'
                },
                ebay: {
                    tbId: 'tbEbay',
                    lbId: 'lbEbayHeader'
                },
                yahooShopping: {
                    tbId: 'tbYahooAution',
                    lbId: 'lbYahooHeader'
                },
                yahooAuction: {
                    tbId: 'tbYahooAution',
                    lbId: 'lbYahooHeader'
                },
                rakuten: {
                    tbId: 'tbRakuten',
                    lbId: 'lbRakutenHeader'
                }
            };
            function onChangeRadioBtn () {


				Object.keys(tb).map(function (data, index) {
                    $('#'+tb[data].tbId).hide();
                    $('#'+tb[data].lbId).hide();
				});

                switch ($('input[type="radio"]:checked').val()) {
					case 'all':
                        Object.keys(tb).map(function (data, index) {
                            $('#'+tb[data].tbId+' .searchBody tr').length && $('#'+tb[data].tbId).show();
                            $('#'+tb[data].tbId+' .searchBody tr').length && $('#'+tb[data].lbId).show();
                        });
					    break;
					default:
                        $('#'+tb[$('input[type="radio"]:checked').val()].tbId+' .searchBody tr').length && $('#'+tb[$('input[type="radio"]:checked').val()].tbId).show();
				}
			}

            function convertDataForSearchAll(data, keyword) {

                var newData = {};
                newData['rakuten'] = data.rakuten?data.rakuten: [];
                newData['ebay'] = data.ebay?findItemsByKeywords(JSON.parse(data.ebay)):[];
                newData['yahoo'] = data.yahoo && data.yahoo.extraData?data.yahoo.extraData : [];
                newData['amazon'] = data.amazon && data.amazon.lstProductSearch?data.amazon.lstProductSearch.map(function(data, index){
                    return {
                        "itemId": data.index,
                        "productName": data.name,
                        "description":"",
                        "exhibition": data.link,
                        "price": data.price,
                        "image": data.imageUrl,
                    };
                }):[];

                bindProductToLayout(newData.amazon, 'tbAmazon');
                bindProductToLayout(newData.ebay, 'tbEbay', keyword);
                bindProductToLayout(newData.yahoo, 'tbYahooAution');
                bindProductToLayout(newData.rakuten, 'tbRakuten');
                onChangeRadioBtn();
            }

            //Ebay search
            function ebaySearchProductByKeyword(keyWord) {
                $.get("EbayProductSearch/"+keyWord,function(data,status){
                    bindProductToLayout([], 'tbAmazon');
                    bindProductToLayout([], 'tbYahooAution');
                    bindProductToLayout([], 'tbRakuten');
                    bindProductToLayout(findItemsByKeywords(JSON.parse(data)), 'tbEbay', keyword);
                    onChangeRadioBtn();
				});
            }

            //Rakuten search
            function rakutenSearchProductByKeyword(keyWord) {
                //I dont know but rakuten say this! :-p
                if (keyWord.length > 1) {
                    //Send ajax to server to search product
                    $.get("RakutenProductSearch/"+ keyWord,function(data,status){
                        bindProductToLayout([], 'tbAmazon');
                        bindProductToLayout([], 'tbEbay');
                        bindProductToLayout([], 'tbYahooAution');
                        bindProductToLayout(data, 'tbRakuten');
                        onChangeRadioBtn();
                    });
                }
            };

            //Yahoo search
			function yahooSearchProductByKeyword(keyWord){
				//Send ajax to server to search product
				$.get("YahooProductSearchV2/"+keyWord,function(data,status){
                    bindProductToLayout([], 'tbAmazon');
                    bindProductToLayout([], 'tbEbay');
                    bindProductToLayout([], 'tbRakuten');
                    bindProductToLayout(data.extraData, 'tbYahooAution');
                    onChangeRadioBtn();
				});
			}
        })
	</script>

	<!-- LOAD ANGULAR JS MODULE
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/angular.js"/>"></script>
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/dirPagination.js"/>"></script>
	-->
	<!-- SCRIPT HANDING EVENT SEARCH PRODUCT (Author napt2017)-->
	<!--
	<script type="text/javascript">
		var shoppingSearchModule = angular
				.module("product_shopping_search", ['angularUtils.directives.dirPagination']);
		shoppingSearchModule
				.controller(
						"productSearchController",
						function($scope, $http) {
							$scope.isEbaySearch = false; 
							
							/*---------------------GLOBAL SEARCH PRODUCT FUNCTION ----------------------- */
							$scope.searchProduct = function() {
								var keyword = $scope.searchModel;
								if (keyword !== "") {
									if ($("#all").prop("checked")) {
										//Search all
									} else if ($("#amazon").prop("checked")) {
										//Search amazon
										$scope.amazon.searchProductByKeyword(keyword);
									} else if ($("#ebay").prop("checked")) {
										//Search ebay
										$scope.ebay.searchProductByKeyword(keyword);
									} else if ($("#yahoo_shopping").prop(
											"checked")) {
										//Search yahoo shopping
										$scope.yahoo.searchProductByKeywordV2(keyword);
									} else if ($("#yahoo_auction").prop(
											"checked")) {
										//Search yahoo auction
										$scope.yahoo.searchProductByKeywordV2(keyword);
									} else if ($("#rakuten_research").prop(
											"checked")) {
										//Search rakuten
										$scope.rakuten.searchProductByKeyword(keyword);
									}
								} else {
									$scope.listOfProduct = [];
								}
							};
							
							$scope.sort = function(keyname){
						        $scope.sortKey = keyname;   //set the sortKey to the param passed
						        $scope.reverse = !$scope.reverse; //if true make it false and vice versa
						    }

							/*--------------------------------EBAY SEARCH--------------------------------------*/
							$scope.ebay = {};

							//Find item by key word
							$scope.ebay.findItemsByKeywords = function findItemsByKeywords(
									root) {
								var items = root.findItemsByKeywordsResponse[0].searchResult[0].item
										|| [];
								var listOfProduct = [];
								for (var i = 0; i < items.length; ++i) {
									var item = items[i];
									var title = item.title[0];
									var pic = item.galleryURL[0];
									var viewitem = item.viewItemURL[0];
									listOfProduct.push({
										productName : title,
										image : pic,
										price : 0,
										stock : "",
										exhibition : viewitem,
										itemId:item.itemId,
										searchSite:"ebay"
									});
								}
								$scope.listOfProduct = listOfProduct;
							}

							//Search ebay function
							$scope.ebay.searchProductByKeyword = function(keyWord) {

								//Send ajax to server to search product
								$http.get("EbayProductSearch/"+keyWord)
									 .success(function(data, status, headers,config) {
										 $scope.isEbaySearch = true;
										 $scope.ebay.findItemsByKeywords(data);
									 })
									 .error(function(data, status, headers,config) {
										  console.log(data);
									});
							}
							
							//Send to add product
							$scope.sendToAddProduct = function($event,$index,$searchSite){
								$event.preventDefault(); 
								window.location.href = "SendToSell/"+$searchSite+"/"+ $index+"/"+$scope.searchModel;
							}

							/*--------------------------------AMAZON SEARCH--------------------------------------*/
							$scope.amazon = {};
							$scope.amazon.searchProductByKeyword = function(keyWord) {
								$scope.amazon.buildRequestUrl(keyWord,function(finalRequestUrl) {
									$http.post(finalRequestUrl)
										 .success(function(data,status,headers,config) {
														$scope.amazon.processServiceResponse(data);
										  })
										  .error(function(data,status,headers,config) {
														console .log(data);
										  });
								});
							}

							$scope.amazon.processServiceResponse = function(respData) {
								console.log(respData)
							}

							$scope.amazon.buildRequestUrl = function(keyWord,funcCallBack) {
							$http.get("AmazoneGetServiceUrl/" + keyWord)
									.success(
											function(data, status, headers,
													config) {
												console.log(data);
												funcCallBack(data);
											}).error(
											function(data, status, headers,
													config) {
												console.log(data);
											});
							}

							/*--------------------------------RAKUTEN SEARCH--------------------------------------*/
							$scope.rakuten = {};
							$scope.rakuten.searchProductByKeyword = function(keyWord) {
								//I dont know but rakuten say this! :-p
								if (keyWord.length > 1) { 
									$scope.isEbaySearch = false;
									//Send ajax to server to search product
									$http.get("RakutenProductSearch/"+ keyWord)
										 .success(function(data, status,headers, config) {
													$scope.listOfProduct = data;
										 }).error(
										 function(data, status,headers, config) {
											console.log(data);
										});
								}
							};

							/*----------------------------------YAHOO SEARCH-------------------------------------*/
							$scope.yahoo = {};
							$scope.yahoo.categories = [ {
								1 : "すべてのカテゴリから"
							}, {
								13457 : "ファッション"
							}, {
								2498 : "食品"
							}, {
								2500 : "ダイエット、健康"
							}, {
								2501 : "コスメ、香水"
							}, {
								2502 : "パソコン、周辺機器"
							}, {
								2504 : "AV機器、カメラ"
							}, {
								2505 : "家電"
							}, {
								2506 : "家具、インテリア"
							}, {
								2507 : "花、ガーデニング"
							}, {
								2508 : "キッチン、生活雑貨、日用品"
							}, {
								2503 : "DIY、工具、文具"
							}, {
								2509 : "ペット用品、生き物"
							}, {
								2510 : "楽器、趣味、学習"
							}, {
								2511 : "ゲーム、おもちゃ"
							}, {
								2497 : "ベビー、キッズ、マタニティ"
							}, {
								2512 : "スポーツ"
							}, {
								2513 : "レジャー、アウトドア"
							}, {
								2514 : "自転車、車、バイク用品"
							}, {
								2516 : "CD、音楽ソフト"
							}, {
								2517 : "DVD、映像ソフト"
							}, {
								10002 : "本、雑誌、コミック"
							} ];
							$scope.yahoo.sorttype = [ {
								"-score" : "おすすめ順"
							}, {
								"+price" : "商品価格が安い順"
							}, {
								"-price" : "商品価格が高い順"
							}, {
								"+name" : "ストア名昇順"
							}, {
								"-name" : "ストア名降順"
							}, {
								"-sold" : "売れ筋順"
							} ]
							//Process the response data of yahoo service 
							$scope.yahoo.processResponseData = function(data) {
								var parseData = jQuery.parseXML(data);
								var xmlDoc = $(parseData);
								var hitElement = xmlDoc.find("Hit");
								var listOfSearchProduct = [];
								hitElement.each(function(index, element) {
									var currentProductItem = $(element);
									var name = currentProductItem.find("Name")
											.text();
									var price = currentProductItem
											.find("Price").text();

									var imageTag = currentProductItem
											.find("Image")
									var image = imageTag.find("Medium").text() //You can find Small tag for the same result
									var url = currentProductItem.find("Url")
											.first().text();
									listOfSearchProduct.push({
										productName : name,
										price : price,
										stock : "",
										exhibition : url,
										image : image
									});
								});
								$scope.listOfProduct = listOfSearchProduct;
							}

							//The yahoo search function
							$scope.yahoo.searchProductByKeyword = function(keyWord) { 
								$scope.isEbaySearch = false;
								//Send ajax to server to search product
								$http.get("YahooProductSearch/"+keyWord)
									 .success(
												function(data, status, headers,
														config) {
													$scope.yahoo.processResponseData(data);
												}).error(
												function(data, status, headers,
														config) {
													console.log(data);
												});
							}

                            //The yahoo search function
                            $scope.yahoo.searchProductByKeywordV2 = function(keyWord) {
                                $scope.isEbaySearch = false;
                                //Send ajax to server to search product
                                $http.get("YahooProductSearchV2/"+keyWord)
                                    .success(
                                        function(data, status, headers, config) {
                                            $scope.listOfProduct = data.extraData;
                                        }).error(
                                    function(data, status, headers,
                                             config) {
                                        console.log(data);
                                    });
                            }
						});
	</script>
	-->
</body>
</html>