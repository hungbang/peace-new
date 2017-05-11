<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en-us" ng-app="stock-register-module">
<jsp:include page="../pages/common/header.jsp" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<body class="fixed-page-footer">
<jsp:include page="../pages/common/menu-top.jsp" />
<jsp:include page="../pages/common/menu-left.jsp" />
<style>
    input,
    textarea,
    button {
        margin-top: 10px
    }
    /* Required field START */

    .required-field-block {
        position: relative;
    }

    [ng\:cloak],
    [ng-cloak],
    [data-ng-cloak],
    [x-ng-cloak],
    .ng-cloak,
    .x-ng-cloak {
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
        .smart-form *,
        .smart-form:after,
        .smart-form:before {
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
        background: rgba(255, 255, 255, .9);
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
            <li>Home</li>
            <li>在庫チェック：新規登録（Amazon）</li>
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
">
        <div class="row col-md-12" width="100%">
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3" data-widget-editbutton="false">
                <header>
                    <h2>在庫チェック：新規登録（Amazon）</h2>
                </header>
                <div>
                    <div class="jarviswidget-editbox"></div>
                    <div id="content">
                        <!-- widget grid -->
                        <section id="widget-grid" class="">
                            <!-- widget div-->
                            <section class="row smart-form">
                                <label class="label col col-10">
                                    ※がついている項目は必須入力です。</label>
                            </section>
                            <div class="row">
                                <div class="widget-body">
                                    <form class="smart-form">
                                        <fieldset>
                                            <div class="row" id="stockAmazonRegistor">
                                                <input type="hidden" value="${stockId}" id="stockId" />
                                                <section class="row smart-form">
                                                    <label class="label col col-2">
                                                        ※ASINコード</label>
                                                    <label class="col col-10">
                                                        <input type="text" id="asin" name="location" placeholder="ASINコードを入力してください" class="form-control" style="width: 100%; padding-left: 5px;">
                                                    </label>
                                                </section>
                                                <section class="row smart-form">
                                                    <label class="label col col-2">※商品名</label>
                                                    <label class="col col-10">
                                                        <input type="text"  id="item_name" placeholder="商品名を入力してください"  class="form-control" style="width: 100%; padding-left: 5px;">
                                                    </label>
                                                </section>
                                                <section class="row smart-form">
                                                    <label class="label col col-2">※基準価格</label>
                                                    <label class="col col-10">
                                                        <input type="text" id="price" placeholder="基準価格を入力してください"  class="form-control" style="width: 100%; padding-left: 5px;">
                                                    </label>
                                                </section>
                                                <section class="row smart-form">
                                                    <label class="label col col-2">※アラート下限価格</label>
                                                    <div class="col col-10">
                                                        <div class="row smart-form ">
                                                            <input type="number" value='0' id="price_lower" placeholder="下限価格を入力してください" class="form-control" style="width: 100%; padding-left: 5px;">
                                                        </div>
                                                        <div class="row smart-form">
                                                            <div class="col-sm-10 col-xs-10" style="color: #c00;">
                                                                Amazonでの最安値価格が、基準価格より「アラート下限価格」以上下回ったらアラートを出します(※1)
                                                                　																	価格でアラートを表示したくない場合は、基準価格と同じ金額を設定してください。
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <section class="row smart-form">
                                                    <label class="label col col-2">※アラート上限価格</label>
                                                    <div class="col col-10">
                                                        <div class="row smart-form ">
                                                            <input type="number" value='0' id="price_upper" name="location" placeholder="上限価格を入力してください" class="form-control" style="width: 100%; padding-left: 5px;">
                                                        </div>
                                                        <div class="row smart-form">
                                                            <div class="col-sm-10 col-xs-10" style="color: #c00;">
                                                                AAmazonでの最安値価格が、基準価格より「アラート上限価格」以上上回ったらアラートを出します(※2)
                                                                　価格でアラートを表示したくない場合は、99999など高めの数値を設定してください。
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <section class="row smart-form">
                                                    <label class="label col col-2">在庫チェック対象</label>
                                                    <label class="col col-10">
                                                        <label class="input ">
                                                            <select class="form-control" id="checktype">
                                                                <option value="0" selected="">新品のみチェック</option>
                                                                <option value="1">中古のみチェック</option>
                                                                <option value="2">両方ともチェック（両方あれば新品を優先）</option>
                                                                <option value="3">両方ともチェック（両方あれば中古を優先）</option>
                                                            </select>
                                                        </label>
                                                    </label>
                                                </section>
                                                <section class="row smart-form">
                                                    <label class="label col col-2">メモ</label>
                                                    <label class="col col-10">
                                                        <input type="text"  id="memo" placeholder="メモを入力してください" class="form-control" style="width: 100%; padding-left: 5px;">
                                                    </label>
                                                </section>
                                                <section class="row smart-form">
                                                    <label class="label col col-2">【補足】使い方 </label>
                                                    <label class="col col-10">
                                                        <div class="how-to-use" style="color: #c00;">(※1)この商品売りたいけど、Amazonでの販売価格が高いのでなかなか手を出せないと思っていた時に、その時の最安値が15000円とします。
                                                            <br>13500円になれば買いたいなと思っている場合
                                                            <br>　基準価格：15000
                                                            <br>　アラート下限価格：1500
                                                            <br>と設定して、最安値価格が13500円以下になれば通知が来るようにします。
                                                            <br><br>(※2)は単純に※1の逆です。
                                                        </div>
                                                    </label>
                                                </section>
                                            </div>
                                        </fieldset>
                                        <div type="submit" class='row' style="margin: 20px;">
                                            <div class="col-lg-11 col-md-11 col-sm-8"></div>
                                            <button id="btnRegistorStock" class="col-lg-1 col-md-1 col-sm-4 col-xs-12 btn btn-primary">登録</button>
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
            placement: 'left',
            title: 'Required field'
        });
    });
    // DO NOT REMOVE : GLOBAL FUNCTIONS!

    $(document).ready(function() {

        pageSetUp();

    })
</script>
</body>

</html>
