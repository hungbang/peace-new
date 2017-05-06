<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us">
<jsp:include page="../pages/common/header.jsp"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<body class="fixed-page-footer">
<style>
    .ebay-fieldset {
        border: 1px solid #bfbebe !important;
        background: none !important;
    }

    .detail-action {
        list-style: none;
        display: inline-flex;
    }

    .detail-action li {
        border: 1px solid #bfbfbf;
        margin-right: 4px;
        margin-top: 3px;
        width: 110px;
        text-align: center;
    }

    #panel_chinese {
        display: none;
    }

    .ebay-fieldset legend {
        color: black;
        font-size: 14px;
        padding: 0px;
        display: inline;
    }

    .preview-image-list {
        border: 1px solid #bfbfbf;
        list-style: none;
        margin-top: 3px;
        height: 113px;
        background: none;
    }

    ul.preview-image-list li {
        display: inline-block;
        border: 1px solid #bfbfbf;
        width: 90px;
        text-align: center;
        margin: 2px;
        height: 100px;
        padding: 3px;
        background: #f5f59c;
    }

    .pickListSelect {
        width: 45%;
        margin-bottom: 2%;
    }

    input, textarea, button {
        margin-top: 10px;
    }

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

    label {
        font-weight: bold !important;
        font-size: medium !important;
        line-height: 30px !important;
    }

    button#btnPreview {
        background-color: #009966;
        color: white;
    }

    button#btnAddEbayItem {
        background-color: #009965;
        color: white;
    }

    /* Required field END */
    <!--
    http:

    /
    /
    cgi5.ebay.com /ws/ eBayISAPI.dll-- >
</style>
<jsp:include page="../pages/common/menu-top.jsp"/>
<jsp:include page="../pages/common/menu-left.jsp"/>

<!-- MAIN PANEL -->
<div id="main" role="main">

    <!-- RIBBON -->
    <div id="ribbon">

                <span class="ribbon-button-alignment">
                    <span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh"
                          rel="tooltip" data-placement="bottom"
                          data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings."
                          data-html="true">
                        <i class="fa fa-refresh"></i>
                    </span>
                </span>

        <!-- breadcrumb -->
        <ol class="breadcrumb">
            <li>Home</li>
            <li>Sell</li>
        </ol>
        <!-- end breadcrumb -->
    </div>
    <!-- END RIBBON -->

    <!-- MAIN CONTENT -->
    <div id="content">
        <!-- widget grid -->
        <section id="widget-grid" class="row" style="margin-left:15px; paa">

            <!-- widget content -->
            <!-- end widget content -->
            <!-- row -->
            <form class="smart-form" style="">
                <!-- The product title part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">商品タイトル（英語）</label>
                    <label class="input ">
                        <input type="text" class="input" id="product_title"
                               value="<c:if test ="${ebayProductAdd !=null}"> ${ebayProductAdd.title}</c:if>"
                               maxlength="80">
                    </label>
                    <div class="note">
                        <p id="titleSub">0 characters (max. 80 letters)</p>
                        <a href="#"> <i class="fa fa-hand-o-right" aria-hidden="true"></i>
                            <span> <fmt:message key="translate"/> </span>
                        </a>
                    </div>
                </section>

                <!-- The detail part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">商品説明（英語）</label>
                    <textarea id="ckEditorForDescription">
                                <c:if test="${ebayProductAdd !=null}">
                                    <%--                                    ${ebayProductAdd.viewItemUrl} --%>
                                </c:if>
                            </textarea>
                </section>

                <!-- The sel_item_country part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">出品国</label>
                    <label class="input ">
                        <select class="form-control" id="sel_item_country" style="width:auto;">
                            <option value="US">United States</option>
                            <option value="AU">Australia</option>
                            <option value="GB">United Kingdom</option>
                            <option value="CA">Canada</option>
                            <option value="MTRS">eBay Motors</option>
                        </select>
                    </label>
                </section>
                <!-- End sel_item_country part -->

                <!-- The category part -->
                <section class="col-xs-10 col-md-10">
                    <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>



                    <label class="label">カテゴリー</label>
                    <div id="category" class="tab-content" style="padding-left: 10px">
                        <div class="" style="100%">
                            <div>
                                <div class="panel-body">
                                    <div id="pickList"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="categoryId"/>
                </section>


                <!-- The condition part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">状態</label>
                    <label class="input ">
                        <select id="itemCondition" name="itemCondition">
                            <option value="-1">選択して下さい</option>
                            <option value="1000">New</option>
                            <option value="3000">Used</option>
                        </select>
                    </label>
                </section>
                <!-- End condition part -->

                <!-- The UPC part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">UPC（JANコードなど）</label>
                    <!--                            <label class="input ">  -->
                    <!--                                <select id="upc" name="upc"> -->
                    <!--                                    <option value="-1">選択して下さい</option> -->
                    <!--                                    <option value="1000">New</option> -->
                    <!--                                    <option value="3000">Used</option> -->
                    <!--                                </select> -->
                    <!--                            </label>  -->
                </section>
                <!-- End UPC part -->

                <!-- The Item Specifics part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">Item Specifics</label>
                    <section class="input" id="panel_item_specifics">

                    </section>
                </section>

                <!-- The Ebay Store part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">eBay Store カテゴリー</label>
                    <label class="input col-xs-6 col-md-4">
                        <select class="form-control" style="width: 95%" id="itemCondition" name="itemCondition">
                            <option value="-1">選択して下さい</option>
                        </select>
                    </label>
                    <label class="input col-xs-6 col-md-4">
                        <select class="form-control" style="width: 95%" id="itemCondition" name="itemCondition">
                            <option value="-1">選択して下さい</option>
                        </select>
                    </label>
                </section>
                <!-- End Ebay part -->

                <!-- The image URL  part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">タイトル用画像URL </label>
                    <textarea id="imageUrl" style="width: 100%" rows="5"></textarea>
                </section>
                <!-- End image URL  part -->

                <!-- The Product image URL for product description  part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">商品説明用画像URL </label>
                    <textarea id="imageDescription" style="width: 100%" rows="5"></textarea>
                </section>
                <!-- End Product image URL for product description  part -->

                <!-- The YouTube URL   part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">YouTube URL </label>
                    <textarea id="youtubeUrl" style="width: 100%" rows="5"></textarea>
                </section>
                <!-- End YouTube URL -->

                <!-- The listing type   part -->
                <form name="radioForm" class="col-xs-10 col-md-10">
                    <label class="col-xs-6 col-md-3">
                        <input type="radio" name="rad_listing_type" value="CHINESE">
                        オークション
                    </label>
                    <label class="col-xs-6 col-md-3">
                        <input type="radio" name="rad_listing_type" value="FIXED_PRICE_ITEM" checked="">
                        即決
                    </label>
                </form>

                <!-- End listing type URL -->

                <!-- The start price part -->

                <section class="col-xs-10 col-md-10">
                    <label class="label">開始価格</label>
                    <br>
                    <input type="text" class="form-control" id="txt_start_price"
                           style="width:250px; display:inline-block;">
                </section>
                <!-- End start price part -->

                <!-- The buy it now part -->
                <section id="panel_chinese" class="col-xs-10 col-md-10">
                    <label>Buy It Now 価格</label>
                    <br>
                    <input type="text" class="form-control" id="txt_buyitnow_priceA"
                           style="width:250px; display:inline-block;">
                    <br>
                    <!-- End buy it now part -->

                    <!-- The listing duration part -->
                    <label class="label">出品日数</label>
                    <select class="form-control" id="sel_listing_durationA" style="width:250px;">
                        <option value="Days_1">1日</option>
                        <option value="Days_3">3日</option>
                        <option value="Days_5">5日</option>
                        <option value="Days_7">7日</option>
                        <option value="Days_10">10日</option>
                    </select>
                    <!-- End listing duration part -->

                    <!-- The chk schedule datetime part -->
                    <label>
                        <input type="checkbox" id="chk_schedule_datetime">
                        出品日時指定
                    </label>
                </section>

                <!-- The chk schedule datetime part - right radio  -->
                <section id="panel_fixedPrice" class="col-xs-10 col-md-10">
                    <label>Buy It Now 価格</label>
                    <input type="text" class="form-control" id="txt_buyitnow_priceB" style="width:250px;">
                    <br>
                    <label>
                        <input type="checkbox" id="chk_best_offer">
                        Best Offer 価格
                    </label>
                    <br>
                    <input type="text" class="form-control" id="txt_best_offer_accept_price"
                           style="width:250px; display:inline-block;">
                    これ以上の額は自動的に受け付ける
                    <br>
                    <input type="text" class="form-control" id="txt_best_offer_minimum_price"
                           style="width:250px; display:inline-block;">
                    これ以下の額は自動的に拒否する
                    <br>
                    <br>
                    <div><label>出品数</label></div>
                    <select class="form-control" id="sel_quantity" style="width:250px; display:inline-block;">
                        <option value="1" selected="">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>
                    <br>
                    <div><label>出品日数</label></div>
                    <select class="form-control" id="sel_listing_durationB" style="width:250px; display:inline-block;">
                        <option value="Days_5">5日</option>
                        <option value="Days_7">7日</option>
                        <option value="Days_10" selected="">10日</option>
                        <option value="Days_30">30日</option>
                        <option value="GTC">売れるまで</option>
                    </select>
                    <br>
                </section>
                <!-- The chk chk_shipping_free part -->
                <section class="col-xs-10 col-md-10">
                    <label>
                        <input type="checkbox" id="chk_shipping_free">
                        送料無料
                    </label>
                </section>

                <!-- The txt_sku part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">SKU</label>
                    <input type="text" class="form-control" id="txt_sku">
                </section>

                <section class="col-xs-10 col-md-10">
                    <label>
                        <input type="checkbox" id="chk_private_listing">
                        Private Listing
                    </label>
                </section>

                <!-- The txt_sku part -->
                <section class="col-xs-10 col-md-10">
                    <label class="label">在庫URL</label>
                    <input type="text" class="form-control" id="txt_stockurl" maxlength="80">
                </section>

                <!-- The footer part -->
                <footer class="col-xs-10 col-md-10" style="">
                    <button type="submit" class="btn btn-primary" id="btnAddEbayItem">出品する</button>
                    <button type="button" class="btn btn-default" id="btnPreview">プレビューの確認</button>
                </footer>
            </form>
            <!-- end row -->

            <!-- row -->


            <!-- end row -->

        </section>
        <!-- end widget grid -->

    </div>
    <!-- END MAIN CONTENT -->

</div>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog" >
    <div class="modal-dialog row" style="display: flex;
                        justify-content: center;
                        width: 100%; padding-top: 60px;">
        <div class="col-md-6 col-sm-10 col-xs-10" style="border-width: 1 #d1d1d1 solid; border-radius: 5px; background-color: white; padding-top: 20px;">
            <div class="col-md-12" style="margin-bottom: 15px;">
                <h4>Search Categories</h4>
            </div>
            <div class="col-md-12 col-xs-12 col-sm-12" >
                <input id='keywordSearchCategories' type="text" class="col-md-9 col-sm-9 col-xs-9" style="padding: 5px; margin-bottom: 5px;" >
                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1"></div>
                <button class="btn btn-success col-sm-2 col-md-2 col-xs-2" id="btnSearchCategories" >Search</button>
            </div>
            <div id='popUpcontentSearchCategories'>
            </div>
            <div class="col-md-12" style="padding-bottom: 20px; margin-top: 10px;">
                <div class="col-sm-10 col-md-10 col-xs-10"></div>
                <button  data-dismiss="modal" class="btn btn-default col-sm-2 col-md-2 col-xs-2" id='btnSearchCategories' ">cancel</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../pages/common/footer.jsp"/>
<!--================================================== -->
<jsp:include page="../pages/common/footer2.jsp"/>
<script type="text/javascript">
    $(function () {
        $("input[name=rad_listing_type]:radio").change(function () {
            console.log(this.value);
            toggleViewWhenChangeRadio(this.value);
        });

        function toggleViewWhenChangeRadio(value) {
            toggleDiv('#panel_fixedPrice');
            toggleDiv('#panel_chinese');
        }

        function toggleDiv(idOrClass) {
            $(idOrClass).css("display") == 'none' ? $(idOrClass).fadeIn(200) : $(idOrClass).fadeOut(100);
        }

        $('.required-icon').tooltip({
            placement: 'left',
            title: 'Required field'
        });

    });


    // DO NOT REMOVE : GLOBAL FUNCTIONS!
    var pickListId = 2;
    var nameValueListArrayType = [];
    var nameValueListType = {};

    $(document).ready(function () {

        pageSetUp();

        // Get ebay Category

        // Init all category level 1
        var pick = $("#pickList").pickList({
            data: []
        });


        getCategoryEbay(1, 0, pick);

        $("#pickData").on('change', function () {
            // Set default level limit
            var levelLimit = 2;

            for (var int = 2; int <= pickListId; int++) {
                //$( "#pickListResult" + pickListId).css("display","none");
                $("#col" + int).remove();
            }

            pickListId = pickListId + 1;
            // Initial template select
            var temp = " <div id='col" + levelLimit + "'>" +
                "    <select class='form-control pickListSelect' count='" + pickListId + "' style='display:none' levelLimit='" + levelLimit + "' id='pickListResult" + pickListId + "'></select>" +
                " </div>";

            // If have not pickListResult, add template
            // Else Remove other pickListResut have limitLevel > 2
            $("#categories").append(temp);


            var p = pick.find("#pickData option:selected");
            getCategoryEbay(levelLimit, p[0].id, pick);
        });
    })

</script>

<!-- HANDING BUSSINESS LOGIC FOR ADD EBAY ITEM(napt2017) -->
<script type="text/javascript">
    $(function () {
        $("#btnAddEbayItem").on("click", function (evt) {
            evt.preventDefault();
            validate(function () {
                addItem();
            });
        });

        $("#btnPreview").on("click", function (evt) {
            //Csrf token

            var confirmFlg = confirm("現在の入力内容でプレビューを表示しますか？");
            if (!confirmFlg)
                return;

            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");

            //The post data
            var postData = {
                title: $("#product_title").val(),
                categoryId: 0,
                conditionID: $("#itemCondition").val(),
                description: $("#cke_ckEditorForDescription").find(".cke_inner .cke_reset")
                    .find("iframe")
                    .contents()[0]
                    .documentElement
                    .getElementsByTagName("body")[0].innerText,
                upc: 1000,
                timePeriod: $("#").val(),
                country: $("#sel_item_country").val(),
                imageUrl: $("#imageUrl").val(),
                imageDescription: $("#imageDescription").val(),
                youtubeUrl: $("#youtubeUrl").val(),
                radListingType: $("#").val(),
                startPrice: $("#txt_start_price").val(),
                buyItNow: $("#txt_buyitnow_priceA").val(),
                duration: $("#sel_listing_durationA").val(),
                isScheduleDate: $("#chk_schedule_datetime").prop("checked"),
                isFreeShip: $("#chk_shipping_free").prop("checked")
            };

            $.ajax({
                type: "POST",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token);
                },
                url: "/GetDataTemplate",
                data: JSON.stringify(postData),
                contentType: "application/json",
                mimeType: 'application/json',
                dataType: "json",
                success: function (respData) {
                    if (respData.status === "OK") {
                        var htmlTemplate = respData.extraData.description;
                        var winpops = window.open('', "_blank", "toolbar=yes,status=yes, " +
                            "scrollbars=yes,resizable=yes,directories=yes,location=yes, " +
                            "width=900,height=600,left=100,top=50,screenX=100,screenY=100");
                        console.log(htmlTemplate);
                        winpops.document.write(htmlTemplate);
                    } else {
                        alert(respData.cause);
                    }
                },
                error: function (evt) {
                    console.log(evt);
                }
            });
        });

        $("#use-paypal-email").on("change", function (evt) {
            if ($("#use-paypal-email").is(":checked")) {
                $("#paypal-email").attr('readonly', false);
            } else {
                $("#paypal-email").val("");
                $("#paypal-email").attr('readonly', true);
            }
        });

        function addItem() {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");

            var title = $("#product_title").val();
            var categoryId = $("#categories").find("select").last().find("option[isleafcategory=true]:selected").attr("id");
            var conditionID = $("#itemCondition").val();
            var description = $("#cke_ckEditorForDescription").find(".cke_inner .cke_reset")
                .find("iframe")
                .contents()[0]
                .documentElement
                .getElementsByTagName("body")[0].innerHTML;
            var upc = $("#upc").val();
            var timePeriod = $("#timePeriod").val();
            var country = $("#sel_item_country").val();
            var imageUrl = $("#imageUrl").val();
            var imageDescription = $("#imageDescription").val();
            var youtubeUrl = $("#youtubeUrl").val();
            var radListingType = $('input[name=rad_listing_type]:checked').val();
            var startPrice = $("#txt_start_price").val();
            var buyItNow = $("#txt_buyitnow_priceA").val();
            var duration = $("#sel_listing_durationA option:selected").val();
            var isScheduleDate = $("#chk_schedule_datetime").val();
            var isFreeShip = $("#chk_shipping_free").val();
            var sku = $("#txt_sku").val();
            var isPrivateListing = $("#chk_private_listing").val();
            var stockUrl = $("#txt_stockurl").val();

            $.ajax({
                type: "POST",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token);
                },
                url: "AddItem",
                data: JSON.stringify({
                    title: title,
                    categoryId: categoryId,
                    conditionID: conditionID,
                    description: description,
                    upc: upc,
                    nameValueListTypes: nameValueListArrayType,
                    timePeriod: timePeriod,
                    country: country,
                    imageUrl: imageUrl,
                    imageDescription: imageDescription,
                    youtubeUrl: youtubeUrl,
                    radListingType: radListingType,
                    startPrice: startPrice,
                    buyItNow: buyItNow,
                    duration: duration,
                    isScheduleDate: isScheduleDate,
                    isFreeShip: isFreeShip,
                    sku: sku,
                    isPrivateListing: isPrivateListing,
                    stockUrl: stockUrl
                }),
                contentType: "application/json",
                mimeType: 'application/json',
                dataType: "json",
                success: function (respData) {
                    if (respData.status === "OK") {
                        alert(respData.msg)
                        //TODO add code to insert stock here
                        addStockRegistor();
                    } else {
                        alert(respData.cause);
                    }
                },
                error: function (evt) {
                    console.log(evt);
                }
            });
        }

        function addStockRegistor() {
            $http.post("AddStockRegistor", JSON.stringify({
                id: 0,
                storeName: "Store From G_Sell",
                productName: $("#product_title").val(),
                vendorURL: $("#txt_stockurl").val(),
                buyPrice: $("#txt_start_price").val(),
                logicCheck: 2,
                stock: 12,
                note: $("#cke_ckEditorForDescription").find(".cke_inner .cke_reset")
                    .find("iframe")
                    .contents()[0]
                    .documentElement
                    .getElementsByTagName("body")[0].innerHTML,
                stockWord: ""
            }), config)
                .success(function (data, status, headers, config) {
                    if (data.status === "OK") {
                        alert("Add success!");
                        window.location.reload();
                    } else {
                        alert(data.cause);
                    }
                })
                .error(function (data, status, headers, config) {
                    console.log("Error");
                })
        }

        $("#add-shipping-service-option").on("click", function (evt) {
            evt.preventDefault();
            var prev = $(".panel-shipping-service-option").last();
            var nextIndex = parseInt(prev.attr("data-index")) + 1;
            var addition = prev.clone()
            addition.find("legend").text("Shipping Service Option " + nextIndex);
            addition.attr("data-index", nextIndex);
            addition.appendTo(prev.parent());
            $(this).remove();
        });

        function getListShippingOptionDto() {
            return $.map($(".panel-shipping-service-option"), function (val, index) {
                var shippingMethod = $(val).find(".select-shipping-method-code-type").val();
                var shippingServiceCost = $(val).find(".shipping-service-cost").val();
                var shippingAddtionCost = $(val).find(".shipping-addition-cost").val();
                var shippingIsuranceCost = $(val).find(".shipping-isurance-cost").val();
                return {
                    shippingMethodType: shippingMethod,
                    shippingServiceCost: shippingServiceCost,
                    shippingServiceAddtionalCost: shippingAddtionCost,
                    shippingInsuranceCost: shippingIsuranceCost
                };
            });

        };

        function validate(onValidateSuccessCallBack) {
            if ($("#product_title").val() === "") {
                alert("Empty title");
                return;
            }

            var selectedCategory = $("#categories").find("select").last().find("option[isleafcategory=true]:selected").attr("id");
            if (!selectedCategory) {
                alert("You must select left category")
                return;
            }

            if ($("#itemCondition").val() === "-1") {
                alert("You must select condition!");
                return;
            }

            if ($("#quantity").val() === "") {
                alert("You must enter quantity!");
                return;
            } else {
                if (parseInt($("#quantity").val()) <= 0) {
                    alert("The quantity must be greater than zero ");
                    return;
                }
            }

            if ($("#startingPrice").val() === "") {
                alert("You must enter the starting price")
                return;
            } else {
                if (parseInt($("#startingPrice").val()) < 0) {
                    alert("Starting price must greater than zero")
                    return;
                }
            }

            if ($("#reservePrice").val() !== "") {
                if (parseInt($("#reservePrice").val()) < 0) {
                    alert("Reserve price must greater than zero")
                    return;
                } else {
                    if (parseInt($("#startingPrice").val()) >= parseInt($("#reservePrice").val())) {
                        alert("The starting price must less than reserve price");
                        return;
                    }
                }


                if ($("#buyNowPrice").val() === "") {
                    alert("You must enter the buy it now price")
                    return;
                } else {
                    if (parseInt($("#buyNowPrice").val()) < 0) {
                        alert("Buy It Now price must greater than zero")
                        return;
                    }
                }

                if (parseInt($("#buyNowPrice").val() < parseInt($("#startingPrice").val()))) {
                    alert("Buy it now price must greater than starting price!")
                    return;
                }

                if ($("#use-paypal-email").is(":checked")) {
                    if ($("#paypal-email").val() === "") {
                        alert("You must enter the paypal email");
                        return;
                    } else {
                        if (!$.trim($("#paypal-email").val()).match(/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/)) {
                            alert("Paypal Email not correct form!")
                            return;
                        }
                    }
                }

                if ($("#payment-instructions").val() === "") {
                    alert("You must enter the payment instruction!")
                    return;
                }

                //Validate the shipping service option
                var listOfShippingMethodType = $(".select-shipping-method-code-type");
                var originLength = listOfShippingMethodType.size();
                var mapToValue = $.map(listOfShippingMethodType, function (val, i) {
                    return $(val).val()
                });
                var uniqueValue = $.unique(mapToValue);
                var validateLength = uniqueValue.length;
                if (originLength !== validateLength) {
                    alert("The shipping method type must be different from each other");
                    return;
                }

                onValidateSuccessCallBack();
            }
        }
    });

</script>

<!-- EMBED CKEDITOR(napt2017) -->
<script src="${pageContext.request.contextPath}/resources/js/plugin/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
    $(function () {
        CKEDITOR.replace("ckEditorForDescription");
    });
</script>

<!-- Thu vien xu ly picklist -->
<script type="text/javascript">
    (function ($) {


        $.fn.pickList = function (options) {

            var opts = $.extend({}, $.fn.pickList.defaults, options);
            var levelLimit = 2;
            var isHandle = false;


            // Fill data
            this.fill = function (data) {
                var option = '';
                if (data) {
                    $.each(data, function (key, val) {
                        option += '<option id=' + val.id + '>'
                            + val.name
                            + '</option>';
                    });
                    this.find('#pickData').append(option);
                }
                ;
            };


            // Controll data
            this.controll = function (data) {
                var pickThis = this;
                if (data) {
                    $("#pickListResult" + pickListId).css("display", "block");
                    var option = '';
                    $.each(data, function (key, val) {
                        if (val.leafCategory) {
                            option += '<option id=' + val.id + ' isLeafCategory=' + val.leafCategory + '>' + val.name + '</option>';
                        } else {
                            option += '<option id=' + val.id + '>' + val.name + '</option>';
                        }
                    });
                    this.find('#pickListResult' + pickListId).append(option);
                    return this.controll();
                }


                $("#pickListResult" + pickListId).on('change', function () {

                    var levelLimitTemp = parseInt($(this).attr("levellimit"), 10);
                    var electmentId = $(this).attr("id");
                    var count = parseInt($(this).attr("count"));

                    var p = pickThis.find("#" + electmentId + " option:selected");
                    var isLeafCategory = $(p[0]).attr("isLeafCategory");

                    for (var int = (count + 1); int <= (pickListId + 5); int++) {
                        $("#col" + int).remove();
                    }

                    if (p[0] && !isLeafCategory) {

                        // If have not select next
                        pickListId = pickListId + 1;
                        var temp = " <div id='col" + pickListId + "'>" +
                            "    <select class='form-control pickListSelect' style='display:none' count='" + pickListId + "' levellimit='" + (levelLimitTemp + 1) + "' id='pickListResult" + pickListId + "'></select>" +
                            " </div>";

                        $("#categories").append(temp);
                        getCategoryEbay((levelLimitTemp + 1), p[0].id, pickThis);
                    }

                    if (p[0] && isLeafCategory) {
                        getCategorySpecifics(p[0].id);
                    }
                });

                $("#add-shipping-service-option").on("click",function(evt){
                    evt.preventDefault();
                    var prev = $(".panel-shipping-service-option").last();
                    var nextIndex= parseInt(prev.attr("data-index")) +1;
                    var addition = prev.clone()
                    addition.find("legend").text("Shipping Service Option "+nextIndex);
                    addition.attr("data-index",nextIndex);
                    addition.appendTo(prev.parent());
                    $(this).remove();
                });

                function getListShippingOptionDto(){
                    return $.map($(".panel-shipping-service-option"),function(val,index){
                        var shippingMethod = $(val).find(".select-shipping-method-code-type").val();
                        var shippingServiceCost = $(val).find(".shipping-service-cost").val();
                        var shippingAddtionCost = $(val).find(".shipping-addition-cost").val();
                        var shippingIsuranceCost = $(val).find(".shipping-isurance-cost").val();
                        return {
                            shippingMethodType:shippingMethod,
                            shippingServiceCost:shippingServiceCost,
                            shippingServiceAddtionalCost:shippingAddtionCost,
                            shippingInsuranceCost:shippingIsuranceCost
                        };
                    })

                }

                function validate(onValidateSuccessCallBack) {
                    if($("#product_title").val()===""){
                        alert("Empty title");
                        return;
                    }

                    var selectedCategory =$("#categories").find("select").last().find("option[isleafcategory=true]:selected").attr("id");
                    if(!selectedCategory){
                        alert("You must select left category")
                        return;
                    }

                    if($("#itemCondition").val()==="-1"){
                        alert("You must select condition!");
                        return;
                    }

                    if($("#quantity").val()===""){
                        alert("You must enter quantity!");
                        return;
                    }else{
                        if(parseInt($("#quantity").val())<=0){
                            alert("The quantity must be greater than zero ");
                            return;
                        }
                    }

                    if($("#startingPrice").val()===""){
                        alert("You must enter the starting price")
                        return;
                    }else{
                        if(parseInt($("#startingPrice").val())<0){
                            alert("Starting price must greater than zero")
                            return;
                        }
                    }

                    if($("#reservePrice").val()!==""){
                        if(parseInt($("#reservePrice").val())<0){
                            alert("Reserve price must greater than zero")
                            return;
                        }else{
                            if(parseInt($("#startingPrice").val())>=parseInt($("#reservePrice").val())){
                                alert("The starting price must less than reserve price");
                                return;
                            }
                        }
                    }

                    if($("#buyNowPrice").val()===""){
                        alert("You must enter the buy it now price")
                        return;
                    }else{
                        if(parseInt($("#buyNowPrice").val())<0){
                            alert("Buy It Now price must greater than zero")
                            return;
                        }
                    }

                    if(parseInt($("#buyNowPrice").val() <parseInt($("#startingPrice").val()))){
                        alert("Buy it now price must greater than starting price!")
                        return;
                    }

                    if($("#use-paypal-email").is(":checked")){
                        if($("#paypal-email").val()===""){
                            alert("You must enter the paypal email");
                            return;
                        }else{
                            if(!$.trim($("#paypal-email").val()).match(/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/)){
                                alert("Paypal Email not correct form!")
                                return;
                            }
                        }
                    }

                    if($("#payment-instructions").val()===""){
                        alert("You must enter the payment instruction!")
                        return;
                    }

                    //Validate the shipping service option
                    var listOfShippingMethodType = $(".select-shipping-method-code-type");
                    var originLength = listOfShippingMethodType.size();
                    var mapToValue = $.map(listOfShippingMethodType,function(val,i){return $(val).val()});
                    var uniqueValue = $.unique(mapToValue);
                    var validateLength = uniqueValue.length;
                    if(originLength!==validateLength){
                        alert("The shipping method type must be different from each other");
                        return;
                    }

                    onValidateSuccessCallBack();
                };
            }
        }
    });
</script>

<!-- EMBED CKEDITOR(napt2017) -->
<script src="${pageContext.request.contextPath}/resources/js/plugin/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
    $(function(){
        CKEDITOR.replace("ckEditorForDescription");
    });
</script>

<!-- Thu vien xu ly picklist -->
<script type="text/javascript">
    (function ($) {


        $.fn.pickList = function (options) {

            var opts = $.extend({}, $.fn.pickList.defaults, options);
            var levelLimit = 2;
            var isHandle = false;


            // Fill data
            this.fill = function (data) {
                var option = '';
                if (data) {
                    $.each(data, function (key, val) {
                        option += '<option id=' + val.id + '>'
                            + val.name
                            + '</option>';
                    });
                    this.find('#pickData').append(option);
                }
                ;
            };


            // Controll data
            this.controll = function (data) {
                var pickThis = this;
                if (data) {
                    $("#pickListResult" + pickListId).css("display", "block");
                    var option = '';
                    $.each(data, function (key, val) {
                        if (val.leafCategory) {
                            option += '<option id=' + val.id + ' isLeafCategory=' + val.leafCategory + '>' + val.name + '</option>';
                        } else {
                            option += '<option id=' + val.id + '>' + val.name + '</option>';
                        }
                    });
                    this.find('#pickListResult' + pickListId).append(option);
                    return this.controll();
                }

                $("#pickListResult" + pickListId).on('change', function () {

                    var levelLimitTemp = parseInt($(this).attr("levellimit"), 10);
                    var electmentId = $(this).attr("id");
                    var count = parseInt($(this).attr("count"));

                    var p = pickThis.find("#" + electmentId + " option:selected");
                    var isLeafCategory = $(p[0]).attr("isLeafCategory");

                    for (var int = (count + 1); int <= (pickListId + 5); int++) {
                        $("#col" + int).remove();
                    }

                    if (p[0] && !isLeafCategory) {

                        // If have not select next
                        pickListId = pickListId + 1;
                        var temp = " <div id='col" + pickListId + "'>" +
                            "    <select class='form-control pickListSelect' style='display:none' count='" + pickListId + "' levellimit='" + (levelLimitTemp + 1) + "' id='pickListResult" + pickListId + "'></select>" +
                            " </div>";

                        $("#categories").append(temp);
                        getCategoryEbay((levelLimitTemp + 1), p[0].id, pickThis);
                    }

                    if (p[0] && isLeafCategory) {
                        getCategorySpecifics(p[0].id);
                    }
                });

            }

            this.getValues = function () {
                var objResult = [];
                this.find("#pickListResult option").each(function () {
                    objResult.push({
                        id: this.id,
                        text: this.text
                    });
                });
                return objResult;
            };
            this.init = function () {
                var pickListHtml =
                    "<div class='row' id='categories'>"
                    + " <select class='form-control pickListSelect' id='pickData'></"
                    + "    select>" +
                    "</div>";

                this.append(pickListHtml);

                this.fill();
                this.controll();
            };

            this.init();
            return this;
        };

        $.fn.pickList.defaults = {
            add: 'Add',
            addAll: 'Add All',
            remove: 'Remove',
            removeAll: 'Remove All'
        };


    }(jQuery));

    function getCategoryEbay(levelLimit, categoryId, pick) {
        var data = {categoryLevel: levelLimit, id: categoryId};
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/GetCategory",
            data: JSON.stringify(data),
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                console.log("SUCCESS: ", data);
                if (categoryId == 0) {
                    pick.fill(data.extraData);
                } else {

                    pick.controll(data.extraData);
                }

            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        });
    }

    function getCategorySpecifics(categoryId) {
        var data = {categoryId: categoryId}
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "GET",
            contentType: "application/json",
            url: "/GetCategorySpecifics",
            data: data,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                console.log("SUCCESS: ", data);
                appendRecommendationsType(data.extraData[0].nameRecommendation);
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        });
    }

    function appendRecommendationsType(data) {
        $("#panel_item_specifics").html('');
        for (var i = 0; i < data.length; i++) {
            var temp = "<section class='col-xs-6 col-md-4'>" + data[i].name + "<br>";
            if (data[i].valueRecommendation) {
                temp += "<select class='form-control nameRecommendation' style='width:95%' id='" + data[i].name + "' name='nameRecommendation'>";
                for (var int2 = 0; int2 < data[i].valueRecommendation.length; int2++) {
                    temp += '<option value=' + data[i].valueRecommendation[int2].value + '>' + data[i].valueRecommendation[int2].value + ' </option>';
                }
                temp += "</select>";
            } else {
                temp += "<input type='text' class='input' style='width:95%' id='" + data[i].name + "' name='nameRecommendation'>";
            }
            temp += "</section>";

            $("#panel_item_specifics").append(temp);
        }
    }

    $(document).on('change', 'select[name="nameRecommendation"]', function () {
        nameValueListType = {};
        nameValueListType.name = $(this).attr("id");

        var p = $(this).find("option:selected");
        nameValueListType.value = [];
        nameValueListType.value.push($(p[0]).attr("value"));

        nameValueListArrayType.push(nameValueListType);
    });


    $("#product_title").on('keypress',function() {
        setSizeTitle();
    })
    $("#product_title").on('keyup',function() {
        setSizeTitle();
    })

    function setSizeTitle() {
        $("#titleSub").text($("#product_title").val().length +" characters (max. 80 letters)");
    }

    $('#btnSearchCategories').click(function () {
        //on request search categories here
        var dummyData = [
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
        ];
        console.log('eee')
        renderResultSearchCategories(dummyData);
    })
    $('#keywordSearchCategories').keyup(function (e) {
        //on request search categories here
        console.log('yyyy')
        var dummyData = [
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
            'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot',
        ]
        if (e.keyCode == 13) {
            renderResultSearchCategories(dummyData);
        }
    })

    function renderResultSearchCategories (data) {
        $('#popUpcontentSearchCategories').html(data.map(function (_data, index) {
            return '<div class="col-md-12" style="margin-top: 5px"><a href="#">'+_data+'</a></div>';
        }));
    }

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