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
										<label class="radio "> <input type="radio"
											name="radio-inline" id="all" checked="checked"> <i></i>All
										</label> <label class="radio "> <input type="radio"
											name="radio-inline" id="ebay"> <i></i>Ebay
										</label> <label class="radio "> <input type="radio"
											name="radio-inline" id="yahoo_shopping"> <i></i>
											Yahoo! Shopping
										</label> <label class="radio "> <input type="radio"
											name="radio-inline" id="yahoo_auction"> <i></i>
											Yahoo! Auction
										</label> <label class="radio "> <input type="radio"
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
							<table
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
							<tbody id="searchBody">
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
			function bindProductToLayout(listOfSearchProduct) {
				listOfSearchProduct.forEach(function(product,index){
					var template =
                    "<tr><td class='col col-1'><image width='64' height='64'src='"+product.image+"'/></td>"+
                    "	<td class='is-visible'><p>"+product.productName +"</p></td>"+
                    "	<td class='is-hidden'>"+product.price +"</td>"+
                    "	<td class='is-hidden'>"+product.stock +"</td>"+
                    "	<td class='is-hidden send-to-ebay' data-product-id='"+product.itemId+"' data-search-site='"+product.searchSite+"'> "+
                    "	<a ng-click='sendToAddProduct($event,product.itemId,product.searchSite)' href='"+product.exhibition+"'>Go to add ebay</a>"+
                    "	</td>"+
                    "</tr>";
					$("#searchBody").append($(template));
				});

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
						console.log('all');
                        searchAllKeyword();
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
                	var data = {
                        "rakuten":[
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/poni/cabinet/05355462/imgrc0069147994.jpg?_ex\u003d128x128",
                                "productName":"MDR-1A SONY ソニー ヘッドホン ハイレゾ オーバーヘッド 密閉 シルバー ブラック 本体 新品 送料無料 回線セット販売 光 SoftBank光 申込み セット キャンペーン Apr17",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/poni/10000316/",
                                "searchSite":"rakuten",
                                "itemId":"0"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/hachihachimobile/cabinet/syounin/04250517/05029678/imgrc0067547782.jpg?_ex\u003d128x128",
                                "productName":"UQ WiMAX正規代理店 2年契約UQ Flat ツープラスまとめてプラン1670ダイソン Dyson V6 Motorhead + WIMAX2＋ Speed Wi-Fi NEXT WX02 コードレス掃除機 家電 セット ワイマックス新品【回線セット販売】",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/hachihachimobile/941514256111/",
                                "searchSite":"rakuten",
                                "itemId":"1"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_gold/innkankoubo/image/hairaccessory/fs012ck01-1.jpg?_ex\u003d128x128",
                                "productName":"1円3個 単品購入可 全12色ヘアゴム/ヘアアイテム/ヘアアクセサリー/子供 女性 ヘアスタイル/髪飾り/hair accessories headwear/ ヘアアレンジ/シンプル 激安 ヘッドアクセサリー レディース キッズ",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/innkankoubo/fs012-1/",
                                "searchSite":"rakuten",
                                "itemId":"2"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/itennis/cabinet/item2/murray-no1-p.jpg?_ex\u003d128x128",
                                "productName":"【ヘッド】「アンディ・マレー選手No.1キャンペーン」プレゼントキャンペーンエントリー☆",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/itennis/murray-no1-p/",
                                "searchSite":"rakuten",
                                "itemId":"3"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/hachihachimobile/cabinet/syounin/04250517/05029678/imgrc0068943921.jpg?_ex\u003d128x128",
                                "productName":"UQ WiMAX正規代理店 2年契約UQ Flat ツープラス まとめてプラン1100ダイソン Dyson V6 Motorhead + WIMAX2＋ novas Home+CA コードレス掃除機 家電 セット ワイマックス新品【回線セット販売】",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/hachihachimobile/861514265410/",
                                "searchSite":"rakuten",
                                "itemId":"4"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/kpi24/cabinet/item2/murray-no1-p.jpg?_ex\u003d128x128",
                                "productName":"【ヘッド】「アンディ・マレー選手No.1キャンペーン」プレゼントキャンペーンエントリー",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/kpi24/murray-no1-p/",
                                "searchSite":"rakuten",
                                "itemId":"5"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/koubudo/cabinet/02888343/img60327533.jpg?_ex\u003d128x128",
                                "productName":"【Winning/ウイニング】　ヘッドギア ネーム加工※代引不可※",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/koubudo/10002432/",
                                "searchSite":"rakuten",
                                "itemId":"6"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/only-select/cabinet/2017/17032101hab/kanban0.jpg?_ex\u003d128x128",
                                "productName":"数量限定！【お買い得1円セール】バレッタ 髪飾り ヘアアクセサリー お花バレッタ 海辺用 ヘアアイテム プルメリア ヘッドアクセサリー ヘア飾り花 かわいい 綺麗 髪留めクリップ ビーチ 旅行 結婚式 記念日 パーティ ウエディングバレッタ お花ヘアピン 海辺用",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/only-select/17032101/",
                                "searchSite":"rakuten",
                                "itemId":"7"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/oooo/cabinet/item2/murray-no1-p.jpg?_ex\u003d128x128",
                                "productName":"【ヘッド】「アンディ・マレー選手No.1キャンペーン」プレゼントキャンペーンエントリー",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/oooo/murray-no1-p/",
                                "searchSite":"rakuten",
                                "itemId":"8"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/hmvjapan/cabinet/5314000/5313121.jpg?_ex\u003d128x128",
                                "productName":"【中古】 Pinhead Three / Fast Reaction / Split 【CD】",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/hmvjapan/5313121/",
                                "searchSite":"rakuten",
                                "itemId":"9"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/kpi/cabinet/item2/murray-no1-p.jpg?_ex\u003d128x128",
                                "productName":"【ヘッド】「アンディ・マレー選手No.1キャンペーン」プレゼントキャンペーンエントリー",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/kpi/murray-no1-p/",
                                "searchSite":"rakuten",
                                "itemId":"10"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/rmflower/cabinet/img56933207.jpg?_ex\u003d128x128",
                                "productName":"■オーダーメイド ブライダルフラワー　「ブーケ・ブートニア・ヘッドドレス・トスブーケ・リストブーケ・贈呈用花束など」造花 プリザーブドフラワー",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/rmflower/ordermade/",
                                "searchSite":"rakuten",
                                "itemId":"11"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/rokusen/cabinet/boxing/name-headgear01.jpg?_ex\u003d128x128",
                                "productName":"【ウイニング・Winning】ヘッドギア　プリントネーム■ボクシング■ヘッドガード■ウィニング",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/rokusen/winhn/",
                                "searchSite":"rakuten",
                                "itemId":"12"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/prospo/cabinet/item2/murray-no1-p.jpg?_ex\u003d128x128",
                                "productName":"【ヘッド】「アンディ・マレー選手No.1キャンペーン」プレゼントキャンペーンエントリー",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/prospo/murray-no1-p/",
                                "searchSite":"rakuten",
                                "itemId":"13"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/kpiswim/cabinet/item2/murray-no1-p.jpg?_ex\u003d128x128",
                                "productName":"【ヘッド】「アンディ・マレー選手No.1キャンペーン」プレゼントキャンペーンエントリー",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/kpiswim/murray-no1-p/",
                                "searchSite":"rakuten",
                                "itemId":"14"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/hmvjapan-plus/cabinet/5314000/5313121.jpg?_ex\u003d128x128",
                                "productName":"【中古】 Pinhead Three / Fast Reaction / Split 【CD】",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/hmvjapan-plus/5313121/",
                                "searchSite":"rakuten",
                                "itemId":"15"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/sportsjapan/cabinet/item2/murray-no1-p.jpg?_ex\u003d128x128",
                                "productName":"【ヘッド】「アンディ・マレー選手No.1キャンペーン」プレゼントキャンペーンエントリー",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/sportsjapan/murray-no1-p/",
                                "searchSite":"rakuten",
                                "itemId":"16"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/hachihachimobile/cabinet/syounin/04250517/05029678/imgrc0067547782.jpg?_ex\u003d128x128",
                                "productName":"UQ WiMAX正規代理店 2年契約UQ Flat ツープラスまとめてプラン1100ダイソン Dyson V6 Motorhead + WIMAX2＋ Speed Wi-Fi NEXT WX02 コードレス掃除機 家電 セット ワイマックス新品【回線セット販売】",
                                "price":"1",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/hachihachimobile/841514254410/",
                                "searchSite":"rakuten",
                                "itemId":"17"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1600/1/cg16001224.jpg?_ex\u003d128x128",
                                "productName":"【中古】[プレイ用][TCG]デュエマ DMR04 37/55C ガガの守護者サメヘッド(20130801)【RCP】",
                                "price":"8",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/16001224003/",
                                "searchSite":"rakuten",
                                "itemId":"18"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1500/3/cg15003067.jpg?_ex\u003d128x128",
                                "productName":"【中古】[TCG]ヴァンガード BT16/051C 喧嘩屋 ヘッドバンド・オブ・グリッド(20140516)【RCP】",
                                "price":"9",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/15003067001/",
                                "searchSite":"rakuten",
                                "itemId":"19"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1400/6/cg14006544.jpg?_ex\u003d128x128",
                                "productName":"【中古】[プレイ用][TCG]遊戯王 SC-08N ツインヘッド・ケルベロス【RCP】",
                                "price":"9",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/14006544003/",
                                "searchSite":"rakuten",
                                "itemId":"20"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1600/1/cg16001224.jpg?_ex\u003d128x128",
                                "productName":"【中古】[TCG]デュエマ DMR04 37/55C ガガの守護者サメヘッド(20130801)【RCP】",
                                "price":"9",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/16001224001/",
                                "searchSite":"rakuten",
                                "itemId":"21"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1400/6/cg14006733.jpg?_ex\u003d128x128",
                                "productName":"【中古】[プレイ用][TCG]遊戯王 TB-31N スパイク・ヘッド【RCP】",
                                "price":"9",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/14006733003/",
                                "searchSite":"rakuten",
                                "itemId":"22"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1400/9/cg14009900.jpg?_ex\u003d128x128",
                                "productName":"【中古】[プレイ用][TCG]遊戯王 BE02-JP102N ツインヘッド・ケルベロス【RCP】",
                                "price":"9",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/14009900003/",
                                "searchSite":"rakuten",
                                "itemId":"23"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1400/9/cg14009900.jpg?_ex\u003d128x128",
                                "productName":"【中古】[TCG]遊戯王 BE02-JP102N ツインヘッド・ケルベロス【RCP】",
                                "price":"10",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/14009900001/",
                                "searchSite":"rakuten",
                                "itemId":"24"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/mediaworldkaitoriworld/cabinet/1700/0/cg17000222.jpg?_ex\u003d128x128",
                                "productName":"【中古】[TCG]Z/X(ゼクス) B01-062C 漂うヘッドクラッシャー(20120727)【RCP】",
                                "price":"10",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/mediaworldkaitoriworld/17000222001/",
                                "searchSite":"rakuten",
                                "itemId":"25"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/card-museum/cabinet/zx/zx-b01-062-c.jpg?_ex\u003d128x128",
                                "productName":"ゼクス（Z/X） 漂うヘッドクラッシャー / 異世界との邂逅 / B01 / Z/X-Zillions of enemy X",
                                "price":"10",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/card-museum/zx-b01-062-c/",
                                "searchSite":"rakuten",
                                "itemId":"26"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/hmvjapan/cabinet/5470000/5468619.jpg?_ex\u003d128x128",
                                "productName":"【中古】 Shinehead / Troddin 【CD】",
                                "price":"11",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/hmvjapan/5468619/",
                                "searchSite":"rakuten",
                                "itemId":"27"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/hmvjapan/cabinet/5414000/5413656.jpg?_ex\u003d128x128",
                                "productName":"【中古】 Shinehead / Troddin 【CD】",
                                "price":"11",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/hmvjapan/5413656/",
                                "searchSite":"rakuten",
                                "itemId":"28"
                            },
                            {
                                "image":"http://thumbnail.image.rakuten.co.jp/@0_mall/side-b/cabinet/base/imgrc0068819299.jpg?_ex\u003d128x128",
                                "productName":"ペンダントヘッド用パーツ・B（プラ製）",
                                "price":"11",
                                "stock":"",
                                "exhibition":"http://item.rakuten.co.jp/side-b/zac9353/",
                                "searchSite":"rakuten",
                                "itemId":"29"
                            }
                        ],
                        "yahoo":{
                            "recordId":0,
                            "extraData":[
                                {
                                    "itemId":"1",
                                    "productName":"フラットヘッド Tシャツ 半袖 THE FLAT HEAD フライング ホイール THC-171",
                                    "description":"土日祝日も営業 15:00 までのご注文は 即日発送 THE FLAT HEAD SMALL FLYING WHEEL T-Shirt THC Series フラットヘッド スモール フライイング ホイール Tシャツ THCシリーズ フラットヘッドを代表するＴシャツシリーズ「THCシリーズ」。 フラットヘッドのこだわりが随所に見ることができます。 紡績段階からオリジナルにこだわったコットン100％でボディも型崩れがしにくい度詰めの生地を使用しています。 ■ブランド：THE FLAT HEAD (ザ・フラットヘッド) ■DETAIL ネック部：20番糸を使用した3本針の1本はずし縫製 スリーブ：FLAT HEAD織りネーム WHITE/DARK RED：染み込みプリント BLACK/NAVY：抜染プリント 度詰めの生地使用 ■素材：綿 100％ ■加工：ワンウォッシュ ■日本製 【サイズ】 身幅/着丈/肩幅/袖丈/重量 38(M)：45/58/41/17cm/230g 40(L)：48/62/43/18cm/250g 42(XL)：51/65/46/19cm/270g 44(XXL)：55/68/49/20cm/290g 46(XXXL)：58/75/52/22cm/340g サイズは若干前後します。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/rodeobros/thc-171.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/rodeobros_thc-171",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"2",
                                    "productName":"フラットヘッド Tシャツ 半袖 THE FLAT HEAD REAL SEE YOU ON THE ROAD THC-178",
                                    "description":"土日祝日も営業 15:00 までのご注文は 即日発送 THE FLAT HEAD SEE YOU ON THE ROAD WHEEL T-Shirt THC Series フラットヘッド SEE YOU ON THE ROAD ホイール Tシャツ THCシリーズ フラットヘッドを代表するＴシャツシリーズ「THCシリーズ」。 フラットヘッドのこだわりが随所に見ることができます。 ■ブランド：THE FLAT HEAD (ザ・フラットヘッド) ■DETAIL ネック部：20番糸を使用した3本針の1本はずし縫製 WHITE / NAVY：染み込みプリント+シルバーパウダー BLACK / DARK RED：抜染プリント+ゴールドパウダー 度詰めの生地使用 ■素材 綿 100％ ■日本製 ■モデル Hide/ 171cm/ 62kg サイズ：40(L) ■加工：ワンウォッシュ ■サイズ 身幅/着丈/肩幅/袖丈cm/重量(g) 38(M)：44/62/41/18cm/210 g 40(L)：48/63/43/19cm/230 g 42(XL)：50/67/46/20cm/240 g 44(3L)：54/70/48/21cm/270 g 46(4L)：56/73/50/22cm/290 g 48(5L)：58/75/52/23cm/310g サイズは若干前後します。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/rodeobros/thc-178.html",
                                    "price":"9800",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/rodeobros_thc-178",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"3",
                                    "productName":"THE FLAT HEAD THC-171 半袖Tシャツ S/S TEE SHIRT SMALL FLYING WHEEL フラットヘッド",
                                    "description":"THE FLAT HEAD SHORT SLEEVE TEE SHIRT SMALL FLYING WHEEL Lot No.THC-171 マテリアル＆ディテール： 　コットン100％ 　ワンウォッシュ 　日本製 カラー： 　ブラック（BLACK） 　ダークレッド（D.RED） 　ネイビー（NAVY） 　ホワイト（WHITE） レギュラーサイズ： 　36（胸囲約 84cm、肩幅約38cm、着丈約59cm） 　38（胸囲約 90cm、肩幅約41cm、着丈約62cm） 　40（胸囲約 96cm、肩幅約43cm、着丈約64cm） 　42（胸囲約104cm、肩幅約46cm、着丈約67cm） ワイドボディサイズ： 　38/WIDE（胸囲約102cm、肩幅約42cm、着丈約60cm） 　40/WIDE（胸囲約108cm、肩幅約45cm、着丈約65cm） 　42/WIDE（胸囲約116cm、肩幅約48cm、着丈約67cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhthc-171-17ss.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhthc-171-17ss",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"4",
                                    "productName":"THE FLAT HEAD THC-170 半袖Tシャツ S/S TEE SHIRT FH FLYING WHEEL フラットヘッド",
                                    "description":"THE FLAT HEAD SHORT SLEEVE TEE SHIRT FH FLYING WHEEL Lot No.THC-170 マテリアル＆ディテール： 　コットン100％ 　ワンウォッシュ 　日本製 カラー： 　ブラック（BLACK） 　ダークレッド（D.RED） 　ネイビー（NAVY） 　ホワイト（WHITE） レギュラーサイズ： 　36（胸囲約 84cm、肩幅約38cm、着丈約59cm） 　38（胸囲約 90cm、肩幅約41cm、着丈約62cm） 　40（胸囲約 96cm、肩幅約43cm、着丈約64cm） 　42（胸囲約104cm、肩幅約46cm、着丈約67cm） ワイドボディサイズ： 　38/WIDE（胸囲約102cm、肩幅約42cm、着丈約60cm） 　40/WIDE（胸囲約108cm、肩幅約45cm、着丈約65cm） 　42/WIDE（胸囲約116cm、肩幅約48cm、着丈約67cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhthc-170-17ss.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhthc-170-17ss",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"5",
                                    "productName":"フラットヘッド THE FLAT HEAD Tシャツ 半袖 ボーダー BT-08W",
                                    "description":"送料無料 ＋ 土日祝日も営業 15:00 までのご注文は 即日発送 THE FLAT HEAD Orignal Border T-Shirt フラッドヘッド オリジナル ボーダー Tシャツ 綺麗なボーダー柄を表現する為に度を詰めて編み立てています。 単純に度を詰めてしまうと、生地が硬くなってしまいますが、それを考慮して 糸の段階でコーミングの工程を行うことで、ソフトな風合いに仕上げています。 ■ブランド：THE FLAT HEAD (ザ・フラットヘッド) ■DETAIL 縫製仕様：脇接ぎ仕様 ネック部：3本針の1本外し 左袖：刺繍 特殊2本針縫製 度詰めの生地使用 ■素材：綿 100％ ■加工：ワンウォッシュ ■日本製 【サイズ】 身幅/着丈/肩幅/袖丈/重量 38(M)：45/59/39/19cm/210g 40(L)：48/61/44/20cm/230g 42(XL)：51/64/48/21cm/250g サイズは若干前後します。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/rodeobros/bt-08w.html",
                                    "price":"9800",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/rodeobros_bt-08w",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"6",
                                    "productName":"フラットヘッド（The Flat Head）プリントTシャツ FLYING WHEEL THC-170",
                                    "description":"フラットヘッド（The Flat Head）プリントTシャツ FLYING WHEEL THC-170",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/ot-emens/mfa35-thc-170.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/ot-emens_mfa35-thc-170",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"7",
                                    "productName":"THE FLAT HEAD LWX-02 ワックス スプレー式リキッドタイプ WAX OF THE DEERSKIN フラットヘッド",
                                    "description":"THE FLAT HEAD WAX OF THE DEERSKIN Lot No.LWX-02 マテリアル＆ディテール： 　ミルクカゼイン 　シェラック 　パラフィン 　ソルビタオンモノオレエート 　カルナバ 　内容量150ml 　日本製 カラー： 　ミルク（MILK） サイズ： 　150ml（F） ≪注意事項≫ 商品の取り扱いは、「取扱説明書」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhlwx-02reg.html",
                                    "price":"2600",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhlwx-02reg",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"8",
                                    "productName":"HEAD ヘッド　硬式テニスラケット 張り上がり MX Spark Tour スパークツアー 234606-S20-11-CN",
                                    "description":"HEAD(ヘッド) ■フェイス面積：100平方インチ ■フレームウエイト：275g ■長さ：27インチ ■適正テンション：40〜50lbs ■バランス：ミディアム ■素材：アルミ ■グリップサイズ：2 ※予告なしでパッケージなどのデザインや商品のカラー等が変更になる場合があります。 ※商品画像のカラーにつきましては、ご利用のパソコン等環境によって実物と多少異なる場合がありますので、あらかじめご了承ください。アルペン alpen スポーツデポ/ラケットスポーツ/ガット張り上りラケット/硬式ラケット（一般）",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/alpen-group/2000741106.html",
                                    "price":"7999",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/alpen-group_2000741106",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"9",
                                    "productName":"HEAD ヘッド　硬式テニス プレッシャーテニスボール チーム 3球入り 3缶 ：イエロー 575891",
                                    "description":"HEAD(ヘッド) 【バウンドの安定感が抜群！迷った時はこのボール！】 ◆1缶＝3球・1パック＝3缶(9球)入り ■カラー： イエロー ■生産国： 中国 ※予告なしでパッケージなどのデザインや商品のカラー等が変更になる場合があります。 ※商品画像のカラーにつきましては、ご利用のパソコン等環境によって実物と多少異なる場合がありますので、あらかじめご了承ください。アルペン alpen スポーツデポ/ラケットスポーツ/ボール・シャトル/硬式",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/alpen-group/2015740505.html",
                                    "price":"1080",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/alpen-group_2015740505",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"10",
                                    "productName":"HEAD(ヘッド)HEAD ATP 4球入り1箱(18缶/72球） 570674　硬式テニスボール",
                                    "description":"HEAD(ヘッド)HEAD ATP 4球入り1箱(18缶/72球） 570674　テニスボール",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/kpi/570674.html",
                                    "price":"15120",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/kpi_570674",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"11",
                                    "productName":"フラットヘッド Tシャツ 半袖 THE FLAT HEAD フライング ホイール THC-170",
                                    "description":"土日祝日も営業 15:00 までのご注文は 即日発送 THE FLAT HEAD FLYING WHEEL T-Shirt THC Series フラッドヘッド FLYING WHEEL 半袖 Tシャツ THC シリーズ フラットヘッドを代表するＴシャツシリーズ「THCシリーズ」。 フラットヘッドのこだわりが随所に見ることができます。 ■ブランド：THE FLAT HEAD (ザ・フラットヘッド) ■DETAIL ネック部：20番糸を使用した3本針の1本はずし縫製 WHITE/DARK RED：染み込みプリント BLACK/NAVY：抜染プリント 度詰めの生地使用 ■素材：綿 100％ ■加工：ワンウォッシュ ■日本製 【サイズ】 身幅/着丈/肩幅/袖丈/重量(g) 38(M)：44/62/41/18/210g 40(L)：48/63/43/19/230g 42(XL)：50/67/46/20/240g 44(3L)：54/70/48/21/270g 46(4L)：56/73/50/22/290g 48(5L)：58/75/52/23/310g サイズは若干前後します。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/rodeobros/thc-170.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/rodeobros_thc-170",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"12",
                                    "productName":"フラットヘッド FLT-02W 半半袖Tシャツ S/S TEE SHIRT FLATLOCK - RED SEAL THE FLAT HEAD",
                                    "description":"THE FLAT HEAD SHORT SLEEVE TEE SHIRT FLATLOCK - RED SEAL Lot No.FLT-02W マテリアル＆ディテール： 　コットン100％ 　フラットロック縫製 　3本針の1本外し20番綿糸（ネック部） 　吊り生地（丸胴） 　度詰め 　レッドシール付き 　日本製 カラー： 　ブラック（BLK） 　グレー（MGRY） 　ホワイト（WHT） サイズ： 　36（胸囲約80cm、肩幅約39cm、着丈約55cm、袖丈約17cm） 　38（胸囲約86cm、肩幅約43cm、着丈約59cm、袖丈約19cm） 　40（胸囲約91cm、肩幅約45cm、着丈約61cm、袖丈約20cm） 　42（胸囲約98cm、肩幅約47cm、着丈約65cm、袖丈約21cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhflt-02w.html",
                                    "price":"12000",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhflt-02w",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"13",
                                    "productName":"フラットヘッド F-DS001 ウエスタンシャツ デニムシャツ 10oz. Denim western L/S shirt THE FLAT HEAD",
                                    "description":"THE FLAT HEAD 10oz. Denim western long sleeve shirt Lot No.F-DS001 マテリアル＆ディテール： 　コットン100％ 　10oz. インディゴデニム（旧式力織機） 　天然黄蝶貝ボタン 　タイトショートシルエット 　ワンウォッシュ 　日本製 カラー： 　インディゴブルー（INDIGO） サイズ： 　36（胸囲約 94cm、肩幅約40cm、着丈約63cm、袖丈約60cm） 　38（胸囲約100cm、肩幅約44cm、着丈約68cm、袖丈約62cm） 　40（胸囲約106cm、肩幅約46cm、着丈約69cm、袖丈約64cm） 　42（胸囲約110cm、肩幅約48cm、着丈約71cm、袖丈約65cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhf-ds001-16fw.html",
                                    "price":"25000",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhf-ds001-16fw",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"14",
                                    "productName":"フラットヘッド THC-60W 半袖Tシャツ S/S TEE SHIRT NEW HUMAN ニューカラー THE FLAT HEAD",
                                    "description":"THE FLAT HEAD SHORT SLEEVE TEE SHIRT NEW HUMAN Lot No.THC-60W マテリアル＆ディテール： 　コットン100％ 　3本針20番綿糸（ネック部） 　度詰 / 丸胴 　染み込みプリント 　ワンウォッシュ 　日本製 ボディ X プリントカラー： 　グリーン X アイボリー（GRN） 　ライトピンク X ライトブラック（LPNK） サイズ： 　36（胸囲約 86cm、肩幅約40cm、着丈約56cm、袖丈約16cm） 　38（胸囲約 90cm、肩幅約41cm、着丈約57cm、袖丈約17cm） 　40（胸囲約 96cm、肩幅約44cm、着丈約62cm、袖丈約18cm） 　42（胸囲約102cm、肩幅約48cm、着丈約65cm、袖丈約19cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhthc-60wb.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhthc-60wb",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"15",
                                    "productName":"フラットヘッド THC-66W 半袖Tシャツ S/S TEE SHIRT EARLY WORKS ベーシックカラー THE FLAT HEAD",
                                    "description":"THE FLAT HEAD SHORT SLEEVE TEE SHIRT EARLY WORKS Lot No.THC-66W マテリアル＆ディテール： 　コットン100％ 　3本針20番綿糸（ネック部） 　度詰 / 丸胴 　染込み＆ラバープリント 　ワンウォッシュ 　日本製 ボディ X プリントカラー： 　ホワイト X ネイビー（WHT） 　ブラック X オレンジ（BLK） 　ライトピンク X ネイビー（LPNK） サイズ： 　36（胸囲約 86cm、肩幅約40cm、着丈約56cm、袖丈約16cm） 　38（胸囲約 90cm、肩幅約42cm、着丈約56cm、袖丈約18cm） 　40（胸囲約 96cm、肩幅約43cm、着丈約59cm、袖丈約19cm） 　42（胸囲約104cm、肩幅約48cm、着丈約63cm、袖丈約20cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhthc-66wa.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhthc-66wa",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"16",
                                    "productName":"フラットヘッド BT-08W 半袖Tシャツ ボーダーT BORDER TEE SHIRT 16SS THE FLAT HEAD",
                                    "description":"THE FLAT HEAD BORDER TEE SHIRT 16SS Lot No.BT-08W マテリアル＆ディテール： 　コットン100％ 　度詰生地 　3本針の1本外し（ネック部） 　オリジナル特殊2本針縫製 　ロゴ刺繍（左袖） 　ワンウォッシュ 　日本製 カラー： 　ブラック x パープル（BLKxPPL） 　ブラック x ホワイト（BLKxWHT） サイズ： 　38（胸囲約 96cm、肩幅約41cm、着丈約60cm、袖丈約20cm） 　40（胸囲約100cm、肩幅約45cm、着丈約63cm、袖丈約21cm） 　42（胸囲約104cm、肩幅約48cm、着丈約66cm、袖丈約22cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhbt-08w-16ss.html",
                                    "price":"9800",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhbt-08w-16ss",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"17",
                                    "productName":"フラットヘッド TKT-003 半袖Tシャツ S/S TEE SHIRT CUSTOM ENGINES CLUB THE FLAT HEAD",
                                    "description":"THE FLAT HEAD SHORT SLEEVE TEE SHIRT CUSTOM ENGINES CLUB Lot No.TKT-003 マテリアル＆ディテール： 　コットン100％ 　吊り生地 　2本針両振り（ネック部） 　抜染プリント（BLK） 　染み込みプリント（WHT, GRY） 　ワンウォッシュ 　日本製 カラー： 　ブラック x グレー（BLK） 　グレー x ワイン（GRY） 　ホワイト x ネイビー（WHT） サイズ： 　38（胸囲約84cm、肩幅約39cm、着丈約58cm、袖丈約18cm） 　40（胸囲約90cm、肩幅約43cm、着丈約60cm、袖丈約18cm） 　42（胸囲約96cm、肩幅約44cm、着丈約64cm、袖丈約19cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhtkt-003-16ss.html",
                                    "price":"8500",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhtkt-003-16ss",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"18",
                                    "productName":"送料280円発送OK！THE FLAT HEAD（フラットヘッド）SPEED WAY フロッキープリント仕様 半袖Ｔシャツ 白 ホワイト THC-177【メンズ/アメカジ/日本製】",
                                    "description":"ネコポス便280円発送OK!! The FLAT HEAD　THCシリーズ HIGH QUALITY S/S Tee フラットヘッドを代表するＴシャツ「THC」シリーズ 強靭なネックと丈夫なボディで常に人気のある究極アイテムです！ さらなる進化！ 今回の新型モデルは立体的なパターンへと改良されており、着用時のシルエットが抜群です！ ３本針の１本外し ネック部リブを縫製する３本針のうち、２本はリブ、１本はボディへ 外すことにより洗濯乾燥時の生地収縮率を同調させ形状を維持し、 旧式丸胴編み機による重厚な質感の生地を採用した世界に誇る究極のＴシャツです 高耐久＆高品質 ヘビーローテーションにも型崩れしにくい、頑強な作りのＴシャツです 1度着るとやみつきになりデザイン違い、色違いを求める方も多い万能アイテムです！ ・ネック：3本針の1本外し（20番綿糸） ・4本針（フラットシーマ） ・ワンウォッシュ ・日本製 ・プリント仕様：本フロッキー＋染み込みプリント 素材：コットン100% サイズ：38(S) 肩幅:40cm　袖丈:19cm　身幅:44cm　着丈:68cm サイズ：40(M) 肩幅:43cm　袖丈:20cm　身幅:47cm　着丈:65cm サイズ:42(L) 肩幅:46cm　袖丈:21cm　身幅:50cm　着丈:67cm",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/rise-rock/flathead-thc177-wht.html",
                                    "price":"9799",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/rise-rock_flathead-thc177-wht",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"19",
                                    "productName":"フラットヘッド THC-166 半袖Tシャツ S/S TEE SHIRT FH WAY THE FLAT HEAD",
                                    "description":"THE FLAT HEAD SHORT SLEEVE TEE SHIRT FH WAY Lot No.THC-166 マテリアル＆ディテール： 　コットン100％ 　度詰生地 　3本針の1本外し20番綿糸（ネック部） 　抜染プリント（BLK） 　染み込みプリント（WHT） 　ワンウォッシュ 　日本製 カラー： 　ブラック X ホワイト（BLK） 　ホワイト X ブラック（WHT） サイズ： 　36（胸囲約 88cm、肩幅約40cm、着丈約55cm、袖丈約17cm） 　38（胸囲約 92cm、肩幅約41cm、着丈約58cm、袖丈約18cm） 　40（胸囲約 96cm、肩幅約44cm、着丈約62cm、袖丈約19cm） 　42（胸囲約104cm、肩幅約47cm、着丈約64cm、袖丈約20cm） ≪注意事項≫ 商品の取り扱いは、「品質表示」をご確認の上、記載事項に沿ってお取り扱い下さい。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/vintage/fhthc-166-16ss.html",
                                    "price":"7200",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/vintage_fhthc-166-16ss",
                                    "searchSite":"yahoo"
                                },
                                {
                                    "itemId":"20",
                                    "productName":"フラットヘッド RJB コラボ ジーンズ デニム パンツ テーパード ストレート THE FLAT HEAD D109FXR",
                                    "description":"送料無料 ＋ 土日祝日も営業 15:00 までのご注文は 即日発送 R.J.B × THE FLAT HEAD 14oz Taperd Straight Jeans R.J.B × THE FLAT HEAD コラボ 14オンス テーパード ジーンズ ■ブランド：THE FLAT HEAD×R.J.B ※こちらの商品は未洗いのため、 初回のお洗濯でウエストで約2インチ(5cm)、股下で約10cm程度の縮みがでますのでご注意ください。 未洗いのため水洗いのみで、数回様子をみてからの丈詰めをお奨めします。 ■DETAIL ポケット部：特殊二重縫製(綿糸×コアスパン糸) ジンバブエコットン左綾デニム 帯部：カーブベルト バックポケット：FHステッチ/ウルトラスウェード シルエット：テーパード ■素材：ジンバブエコットン 100％ ■加工：ノンウォッシュ ■日本製 ■サイズ ウエスト/股下/股上/ワタリ/裾幅/重量 30:81/92/24/28/18.5cm/850g 31:84/92/26/30/19cm/870g 32:86/92/26.5/30.5/19.5cm/890g 33:89/92/27/31/20cm/910g\u0026lt;BR\u0026gt; 34:91/92/27.5/31.5/20.5cm/930g 36:94/92/28/32.5/21cm/960g サイズは若干前後します。",
                                    "exhibition":"http://store.shopping.yahoo.co.jp/rodeobros/d109fxr.html",
                                    "price":"34000",
                                    "image":"https://item-shopping.c.yimg.jp/i/c/rodeobros_d109fxr",
                                    "searchSite":"yahoo"
                                }
                            ]
                        },
                        "ebay":"{\"findItemsByKeywordsResponse\":[{\"ack\":[\"Success\"],\"version\":[\"1.13.0\"],\"timestamp\":[\"2017-05-03T19:06:30.177Z\"],\"searchResult\":[{\"@count\":\"3\",\"item\":[{\"itemId\":[\"351937652965\"],\"title\":[\"Head Ti S6 Tennis Racquet\"],\"globalId\":[\"EBAY-US\"],\"subtitle\":[\"International Shipping Available\"],\"primaryCategory\":[{\"categoryId\":[\"20871\"],\"categoryName\":[\"Racquets\"]}],\"galleryURL\":[\"http:\\/\\/thumbs2.ebaystatic.com\\/pict\\/351937652965404000000003_1.jpg\"],\"viewItemURL\":[\"http:\\/\\/www.ebay.com\\/itm\\/Head-Ti-S6-Tennis-Racquet-\\/351937652965?var\u003d621476318257\"],\"paymentMethod\":[\"PayPal\"],\"autoPay\":[\"true\"],\"location\":[\"USA\"],\"country\":[\"US\"],\"shippingInfo\":[{\"shippingServiceCost\":[{\"@currencyId\":\"USD\",\"__value__\":\"0.0\"}],\"shippingType\":[\"Free\"],\"shipToLocations\":[\"US\",\"GB\",\"AU\",\"AT\",\"BE\",\"FR\",\"DE\",\"IT\",\"JP\",\"ES\",\"TW\",\"NL\",\"CN\",\"HK\",\"MX\",\"DK\",\"RO\",\"SK\",\"BG\",\"CZ\",\"FI\",\"HU\",\"LV\",\"LT\",\"MT\",\"EE\",\"GR\",\"PT\",\"CY\",\"SI\",\"SE\",\"KR\",\"ID\",\"ZA\",\"TH\",\"IE\",\"PL\",\"RU\",\"IL\",\"NZ\"],\"expeditedShipping\":[\"true\"],\"oneDayShippingAvailable\":[\"true\"],\"handlingTime\":[\"1\"]}],\"sellingStatus\":[{\"currentPrice\":[{\"@currencyId\":\"USD\",\"__value__\":\"71.99\"}],\"convertedCurrentPrice\":[{\"@currencyId\":\"USD\",\"__value__\":\"71.99\"}],\"sellingState\":[\"Active\"],\"timeLeft\":[\"P15DT15H6M33S\"]}],\"listingInfo\":[{\"bestOfferEnabled\":[\"false\"],\"buyItNowAvailable\":[\"false\"],\"startTime\":[\"2016-12-20T10:13:03.000Z\"],\"endTime\":[\"2017-05-19T10:13:03.000Z\"],\"listingType\":[\"FixedPrice\"],\"gift\":[\"false\"]}],\"returnsAccepted\":[\"true\"],\"galleryPlusPictureURL\":[\"http:\\/\\/galleryplus.ebayimg.com\\/ws\\/web\\/351937652965_1_0_1_00000003.jpg\"],\"condition\":[{\"conditionId\":[\"1000\"],\"conditionDisplayName\":[\"New\"]}],\"isMultiVariationListing\":[\"true\"],\"topRatedListing\":[\"false\"]},{\"itemId\":[\"292062348791\"],\"title\":[\"Chevy BBC Big Block 454 360cc 115cc High Performance Aluminum Cylinder Head\"],\"globalId\":[\"EBAY-MOTOR\"],\"primaryCategory\":[{\"categoryId\":[\"33617\"],\"categoryName\":[\"Cylinder Heads \u0026 Parts\"]}],\"galleryURL\":[\"http:\\/\\/thumbs4.ebaystatic.com\\/m\\/mAqP4XoXzYWhGENedm3WacQ\\/140.jpg\"],\"viewItemURL\":[\"http:\\/\\/www.ebay.com\\/itm\\/Chevy-BBC-Big-Block-454-360cc-115cc-High-Performance-Aluminum-Cylinder-Head-\\/292062348791\"],\"paymentMethod\":[\"PayPal\"],\"autoPay\":[\"false\"],\"postalCode\":[\"92376\"],\"location\":[\"Rialto,CA,USA\"],\"country\":[\"US\"],\"shippingInfo\":[{\"shippingServiceCost\":[{\"@currencyId\":\"USD\",\"__value__\":\"0.0\"}],\"shippingType\":[\"Free\"],\"shipToLocations\":[\"US\",\"CA\",\"GB\",\"AU\",\"AT\",\"BE\",\"FR\",\"DE\",\"IT\",\"JP\",\"ES\",\"TW\",\"NL\",\"CN\",\"HK\",\"MX\",\"DK\",\"RO\",\"SK\",\"BG\",\"CZ\",\"FI\",\"HU\",\"LV\",\"LT\",\"MT\",\"EE\",\"GR\",\"PT\",\"CY\",\"SI\",\"SE\",\"KR\",\"ID\",\"ZA\",\"TH\",\"IE\",\"PL\",\"RU\",\"IL\"],\"expeditedShipping\":[\"false\"],\"oneDayShippingAvailable\":[\"true\"],\"handlingTime\":[\"1\"]}],\"sellingStatus\":[{\"currentPrice\":[{\"@currencyId\":\"USD\",\"__value__\":\"289.87\"}],\"convertedCurrentPrice\":[{\"@currencyId\":\"USD\",\"__value__\":\"289.87\"}],\"sellingState\":[\"Active\"],\"timeLeft\":[\"P16DT3H45M7S\"]}],\"listingInfo\":[{\"bestOfferEnabled\":[\"false\"],\"buyItNowAvailable\":[\"false\"],\"startTime\":[\"2017-03-20T22:51:37.000Z\"],\"endTime\":[\"2017-05-19T22:51:37.000Z\"],\"listingType\":[\"FixedPrice\"],\"gift\":[\"false\"]}],\"returnsAccepted\":[\"true\"],\"condition\":[{\"conditionId\":[\"1000\"],\"conditionDisplayName\":[\"New\"]}],\"isMultiVariationListing\":[\"false\"],\"topRatedListing\":[\"true\"]},{\"itemId\":[\"351937652965\"],\"title\":[\"Head Ti S6 Tennis Racquet\"],\"globalId\":[\"EBAY-US\"],\"subtitle\":[\"International Shipping Available\"],\"primaryCategory\":[{\"categoryId\":[\"20871\"],\"categoryName\":[\"Racquets\"]}],\"galleryURL\":[\"http:\\/\\/thumbs2.ebaystatic.com\\/pict\\/351937652965404000000005_1.jpg\"],\"viewItemURL\":[\"http:\\/\\/www.ebay.com\\/itm\\/Head-Ti-S6-Tennis-Racquet-\\/351937652965?var\u003d621476318259\"],\"paymentMethod\":[\"PayPal\"],\"autoPay\":[\"true\"],\"location\":[\"USA\"],\"country\":[\"US\"],\"shippingInfo\":[{\"shippingServiceCost\":[{\"@currencyId\":\"USD\",\"__value__\":\"0.0\"}],\"shippingType\":[\"Free\"],\"shipToLocations\":[\"US\",\"GB\",\"AU\",\"AT\",\"BE\",\"FR\",\"DE\",\"IT\",\"JP\",\"ES\",\"TW\",\"NL\",\"CN\",\"HK\",\"MX\",\"DK\",\"RO\",\"SK\",\"BG\",\"CZ\",\"FI\",\"HU\",\"LV\",\"LT\",\"MT\",\"EE\",\"GR\",\"PT\",\"CY\",\"SI\",\"SE\",\"KR\",\"ID\",\"ZA\",\"TH\",\"IE\",\"PL\",\"RU\",\"IL\",\"NZ\"],\"expeditedShipping\":[\"true\"],\"oneDayShippingAvailable\":[\"true\"],\"handlingTime\":[\"1\"]}],\"sellingStatus\":[{\"currentPrice\":[{\"@currencyId\":\"USD\",\"__value__\":\"71.99\"}],\"convertedCurrentPrice\":[{\"@currencyId\":\"USD\",\"__value__\":\"71.99\"}],\"sellingState\":[\"Active\"],\"timeLeft\":[\"P15DT15H6M33S\"]}],\"listingInfo\":[{\"bestOfferEnabled\":[\"false\"],\"buyItNowAvailable\":[\"false\"],\"startTime\":[\"2016-12-20T10:13:03.000Z\"],\"endTime\":[\"2017-05-19T10:13:03.000Z\"],\"listingType\":[\"FixedPrice\"],\"gift\":[\"false\"]}],\"returnsAccepted\":[\"true\"],\"galleryPlusPictureURL\":[\"http:\\/\\/galleryplus.ebayimg.com\\/ws\\/web\\/351937652965_1_0_1_00000005.jpg\"],\"condition\":[{\"conditionId\":[\"1000\"],\"conditionDisplayName\":[\"New\"]}],\"isMultiVariationListing\":[\"true\"],\"topRatedListing\":[\"false\"]}]}],\"paginationOutput\":[{\"pageNumber\":[\"1\"],\"entriesPerPage\":[\"3\"],\"totalPages\":[\"1931831\"],\"totalEntries\":[\"5795491\"]}],\"itemSearchURL\":[\"http:\\/\\/www.ebay.com\\/sch\\/i.html?_nkw\u003dhead\u0026_ddo\u003d1\u0026_ipg\u003d3\u0026_pgn\u003d1\"]}]}",
                        "amazon":{
                            "lstProductSearch":[
                                {
                                    "name":"HEAD(ヘッド) テニス ラケット 振動止め プロ ダンプ ブラック 285515",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B01ANHGIZK?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB01ANHGIZK",
                                    "sin":"B01ANHGIZK",
                                    "productAttribute":{

                                    },
                                    "index":0
                                },
                                {
                                    "name":"HEAD(ヘッド)吸汗速乾 ブリスター メンズ ジャージ上下セット Lサイズ 74.ネイビー",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B01LPTPSR4?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB01LPTPSR4",
                                    "sin":"B01LPTPSR4",
                                    "productAttribute":{

                                    },
                                    "index":1
                                },
                                {
                                    "name":"HEAD(ヘッド) テニス ラケット スピード プロ ノバク・ジョコビッチ使用モデル (フレームのみ) 2 230625",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B00RV58810?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB00RV58810",
                                    "sin":"B00RV58810",
                                    "productAttribute":{

                                    },
                                    "index":2
                                },
                                {
                                    "name":"[ヘッド] HEAD 防水スニーカー HD-8059 YELLOW(イエロー/26.5)",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B011O46J1Y?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB011O46J1Y",
                                    "sin":"B011O46J1Y",
                                    "productAttribute":{

                                    },
                                    "index":3
                                },
                                {
                                    "name":"HEAD(ヘッド) Graphene XT Speed Rev Pro (フレームのみ) 2 230615",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B00RV57TWE?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB00RV57TWE",
                                    "sin":"B00RV57TWE",
                                    "productAttribute":{

                                    },
                                    "index":4
                                },
                                {
                                    "name":"HEAD(ヘッド) テニス ラケットバッグ ジョコビッチ・バックパック 283097",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B01KVHTD1S?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB01KVHTD1S",
                                    "sin":"B01KVHTD1S",
                                    "productAttribute":{

                                    },
                                    "index":5
                                },
                                {
                                    "name":"HEAD(ヘッド) テニス プロプレーヤー・キャップ ホワイト 287015",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B00SNTLPZY?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB00SNTLPZY",
                                    "sin":"B00SNTLPZY",
                                    "productAttribute":{

                                    },
                                    "index":6
                                },
                                {
                                    "name":"HEAD(ヘッド) XtremeSoft (3本入り) ホワイト 285104",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B001DESZHM?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB001DESZHM",
                                    "sin":"B001DESZHM",
                                    "productAttribute":{

                                    },
                                    "index":7
                                },
                                {
                                    "name":"ミズノ 競泳 スイムキャップ GX・SONIC HEAD PLUS FINA承認 N2JW600009 09:ブラック",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B01AK1JTDM?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB01AK1JTDM",
                                    "sin":"B01AK1JTDM",
                                    "productAttribute":{

                                    },
                                    "index":8
                                },
                                {
                                    "name":"(ヘッド)HEAD メンズ用ウィンドブレーカージャケット【154134】 M チャコール",
                                    "price":"0f",
                                    "imageUrl":"",
                                    "link":"https://www.amazon.co.jp/gp/pdp/taf/B017688VJ0?SubscriptionId\u003dAKIAJKP5TCR5AML423FQ\u0026tag\u003dguen-22\u0026linkCode\u003dxm2\u0026camp\u003d2025\u0026creative\u003d5143\u0026creativeASIN\u003dB017688VJ0",
                                    "sin":"B017688VJ0",
                                    "productAttribute":{

                                    },
                                    "index":9
                                }
                            ],
                            "totalPage":0,
                            "currentPage":0
                        }
                    };

                    var newData = {all: []};
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
                    newData.all = newData['rakuten'].concat(newData['ebay']).concat(newData['yahoo']).concat(newData['amazon']);

                console.log(newData);
				bindProductToLayout(newData.all);
            }

            //Ebay search
            function ebaySearchProductByKeyword(keyWord) {
                $.get("EbayProductSearch/"+keyWord,function(data,status){
                    bindProductToLayout(findItemsByKeywords(JSON.parse(data)));
				});
            }

            //Rakuten search
            function rakutenSearchProductByKeyword(keyWord) {
                //I dont know but rakuten say this! :-p
                if (keyWord.length > 1) {
                    //Send ajax to server to search product
                    $.get("RakutenProductSearch/"+ keyWord,function(data,status){
                        bindProductToLayout(data);
                    });
                }
            };

            //Yahoo search
			function yahooSearchProductByKeyword(keyWord){
				//Send ajax to server to search product
				$.get("YahooProductSearchV2/"+keyWord,function(data,status){
					bindProductToLayout(data.extraData);
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