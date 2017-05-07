<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us"> 
		<jsp:include page="../pages/common/header.jsp"/>
	<body class="">
		<style>
			input, textarea, button { margin-top:10px }

			/* Required field START */

			.required-field-block {
				position: relative;   
			}
			
			.jarviswidget>header {
			    height: 50px;
			    padding: 0;
			    padding-left: 20px;
			    line-height: 40px;
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
			<div id="content">

				<div class="row">
					<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
						<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> Dashboard <span>> EBay Setting</span> <span>> Listing template</span></h1>
					</div>
					<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
						
					</div>
				</div>
				<!-- widget grid -->
				
    <div class="col-lg-12" style=" display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 15px; padding-bottom: 100px;
" >
            <div class="row" width="100%">
                <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
                     data-widget-editbutton="false">
                    <header>
                        <h1>Exhibit Template</h1>
                    </header>
                    <div>
                        <div class="jarviswidget-editbox"></div>
                        
				<section id="widget-grid" class="">

					<!-- widget div-->
					<div class="row">
						<div class="widget-body ">
							<form class="smart-form">
								<fieldset>
									<div class="row">
										<section class="col col-12">
											<label class="label" style="    margin-left: 10px;">Selection of an exhibition template</label>
											<div class="inline-group" style="padding-top: 30px">
												<section class="col col-2 col-sm-2" style="">
												<label class="radio">
													<input type="radio" name="radio-inline" >
													<i></i>
													Template 1</label>
												<img src="<c:url value="/resources/img/template/photo1.png"/>" height="300" width="200"/>
												</section>
												<section class="col col-2" style="">
												<label class="radio">
													<input type="radio" name="radio-inline" >
													<i></i>
													Template 2</label>
												<img src="<c:url value="/resources/img/template/photo2.png"/>" height="300" width="200"/>
												</section>
												<section class="col col-2" style="">
												<label class="radio">
													<input type="radio" name="radio-inline" >
													<i></i>
													Template 3</label>
												<img src="<c:url value="/resources/img/template/photo3.png"/>" height="300" width="200"/>
												</section>
												<section class="col col-2" style="">
												<label class="radio">
													<input type="radio" name="radio-inline" >
													<i></i>
													Template 4</label>
												<img src="<c:url value="/resources/img/template/photo4.png"/>" height="300" width="200"/>
												</section>
												<section class="col col-2" style="">
												<label class="radio">
													<input type="radio" name="radio-inline" >
													<i></i>
													Template 5</label>
												<img src="<c:url value="/resources/img/template/photo5.png"/>" height="300" width="200"/>
												</section>
											</div>
										</section>
									</div>
									<div class="row">
										<div id="colorpickerstr">
											<div class="farbtastic">
												<div class="color" style="background-color: rgb(255, 0, 0);"></div>
												<div class="wheel"></div>
												<div class="overlay"></div>
												<div class="h-marker marker" style="left: 97px; top: 13px;"></div>
												<div class="sl-marker marker" style="left: 74px; top: 126px;"></div>
											</div>
										</div>
										<input type="text" id="colorstr" name="colorstr" value="#FFFFFF" style="margin-left: 25px;">
										<div id="colorpickerstr">
											<div class="farbtastic">
												<div class="color" style="background-color: rgb(255, 0, 0);"></div>
												<div class="wheel"></div>
												<div class="overlay"></div>
												<div class="h-marker marker" style="left: 97px; top: 13px;"></div>
												<div class="sl-marker marker" style="left: 74px; top: 126px;"></div>
											</div>
										</div>
										<input type="text" id="colorstr" name="colorstr" value="#FFFFFF" style="margin-left: 25px;">
									</div>
								</fieldset>
								<div class="row col-md-12" style="padding-bottom: 25px; padding-right: 25px;">
									<div class="col-md-10"></div>
									<button type="submit" class="btn btn-primary col-md-2">
										Save
									</button>
								</div>
							</form>
						</div>
					</div>
					<!-- end widget div -->

				</section>
                    </div>
                </div>
            </div>
	
        
            </div>
        </div>
    </div>
				<!-- end widget grid -->
				
			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<jsp:include page="../pages/common/footer.jsp"/>
		<!--================================================== -->	
		<jsp:include page="../pages/common/footer2.jsp"/>

		<script type="text/javascript">
		$(document).ready(function() {
			$('#colorpicker').farbtastic('#color');
			$('#colorpickerstr').farbtastic('#colorstr');
		});
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