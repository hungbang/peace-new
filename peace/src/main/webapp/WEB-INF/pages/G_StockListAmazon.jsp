<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us" ng-app="list-sold-app">
<jsp:include page="../pages/common/header.jsp" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<body class="fixed-page-footer">
<jsp:include page="../pages/common/menu-top.jsp" />
<jsp:include page="../pages/common/menu-left.jsp" />
<style>
    [ng\:cloak],
    [ng-cloak],
    [data-ng-cloak],
    [x-ng-cloak],
    .ng-cloak,
    .x-ng-cloak {
        display: none !important;
    }
</style>
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
            <li>在庫チェック：在庫一覧（Amazon）</li>
        </ol>
    </div>
    <!-- END RIBBON -->
    <!-- MAIN CONTENT -->
    <div class="col-lg-12" style=" display: flex;justify-content: center; align-items: center; margin-top: 15px;padding-bottom: 100px;">
        <div class="row" style="width: 100%">
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3" data-widget-editbutton="false">
                <header>
                    <h2 style="margin-left: 13px">在庫チェック：在庫一覧（Amazon）</h2>
                </header>
                <div>
                    <div class="jarviswidget-editbox"></div>
                    <div>
                        <section id="widget-grid" class="" >
                            <div>
                                <section class="col col-6">
                                    <button style="
																											   margin-right: 15px;
																											   margin-bottom: 10px;
																											   " type="button" class="btn btn-success" id="btnChoice">アラート有りを全て選択</button>
                                    <button style="
																											   margin-right: 15px;
																											   margin-bottom: 10px;
																											   " type="button" class="btn btn-success" id="btnDoclear">チェック行を全てreset</button>
                                    <button style="
																											   margin-right: 15px;
																											   margin-bottom: 10px;
																											   " type="button" class="btn btn-danger" id="btnDelChecked">チェック行を全て削除</button>
                                </section>
                                <div id="datatable_tabletools_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer" id="table-sell">
                                    <table id="tbStockListAmazon" class="table table-striped table-bordered table-hover smart-form dataTable no-footer">
                                        <thead>
                                        <tr>

                                            <th ng-click="sort('purchaser')">check
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th ng-click="sort('reListing')">No.
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th>ASINコード
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th>商品名
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th>仕入URL
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th ng-click="sort('title')">基準価格（円）
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th ng-click="sort('title')">下限価格
                                                <span class="glyphicon sort-icon"></span>
                                            </th>


                                            <th ng-click="sort('title')">上限価格
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th ng-click="sort('endTime')">対象
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th ng-click="sort('purchaser')">メモ
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th ng-click="sort('reListing')">変更
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th>削除
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                            <th>reset
                                                <span class="glyphicon sort-icon"></span>
                                            </th>

                                        </tr>
                                        </thead>
                                        <tbody id='tbStockListAmazonBody'>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                    </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<!-- END MAIN CONTENT -->
</div>
<jsp:include page="../pages/common/footer.jsp" />
<!--================================================== -->
<jsp:include page="../pages/common/footer2.jsp" />
<script>
    $(document)
        .ready(
            function() {
                // DO NOT REMOVE : GLOBAL FUNCTIONS!
                pageSetUp();
            });
</script>
<!--Replace the angular-->
</body>

</html>
