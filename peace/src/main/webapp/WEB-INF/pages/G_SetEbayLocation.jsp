<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en-us" ng-app="product_shopping_search">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
	<style>
		#productSearchBtn {
		}
		#productSearch {
			width: 320px;
		}
	</style>
</head>
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


	<div class="col-lg-12" style="display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 15px; padding-bottom: 100px;
" >
		<div class="row" style="width: 100%">
			<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
				 data-widget-editbutton="false">
				<header>
					<h2><fmt:message key="ebay.location" /></h2>
				</header>
				<div>
					<div class="jarviswidget-editbox"></div>
					<section id="widget-grid" class="">

						<!-- widget div-->
						<div class="row" ng-controller="productSearchController">
							<div class="widget-body ">
								<form:form action="saveEbayLocation" class="smart-form">
									<fieldset>
										<div class="row">
											<section class="col col-6">
												<%--<label class="label">Location</label> <label class="input" style="float:left">--%>
												<!-- <input type="text" id="productSearch" ng-change="searchProduct()" style="
										   margin-right: 15px;
										   margin-bottom: 10px;
										   " ng-model="searchModel" class="input" maxlength="80"> -->
											</label>

												<input id="city" name="location" value="${location}" style="
										   margin-right: 15px;
										   margin-bottom: 10px;
										   " ng-model="searchModel" class="form-control" maxlength="80" autocomplete="off" data-country="jp">
												<input style="
										   margin-right: 15px;
										   margin-bottom: 10px;
										   " type="button" class="btn btn-primary" id="productSearchBtn" value='<fmt:message key="search"/>'/>
											</section>
										</div>
									</fieldset>
								</form:form>
							</div>

						</div>
						<!-- end widget div -->

					</section>
					<!-- end widget grid -->

				</div>
			</div>
		</div>

	</div>

	<!--end div border -->
</div>
</div>
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
	#tbAmazon, #tbEbay, #tbRakuten, #tbYahooAution, #tbYahooShopping, #lbAmazonHeader, #lbEbayHeader, #lbRakutenHeader, #lbYahooHeader, #lbYahooShopping {
		display: none;
	}
	.labelHeader {
		font-size: 26px;
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

<!--Replace the angular-->
<script type="text/javascript">
    $(function () {
        //Function bind search product to layout

        $("#productSearchBtn").on("click",function(){
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $.ajax({
                url: 'saveEbayLocation',
                type: 'POST',
                data: {location: $('#city').val()},
                beforeSend:function(xhr){
                    xhr.setRequestHeader(header, token);
                },
            })
                .done(function(data) {
                    alert('成功を保存します。');
                })
                .fail(function(e) {
                    console.log(e);
                })
                .always(function() {
                    console.log("complete");
                });

        });

        // search all

    })
</script>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&language=jp&key=AIzaSyCZxqZz8DahO0GAKLcPEYWUkS8IDQhadc4"></script>

<script>
$('input#city').cityAutocomplete('AIzaSyCZxqZz8DahO0GAKLcPEYWUkS8IDQhadc4');
</script>

</body>
</html>