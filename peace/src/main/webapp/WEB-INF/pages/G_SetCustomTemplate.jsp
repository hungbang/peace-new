<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us" ng-app="template_upload_app">
<jsp:include page="../pages/common/header.jsp"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<body class="fixed-page-footer">
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

	.required-field-block .required-icon .text {
		color: #B80000;
		font-size: 26px;
		margin: -3px 0 0 12px;
	}

	#preview_image {
		margin-top: 20px;
		margin-bottom: 20px;
		width: "200px",
		height: "300px",
		border: "1px solid #827d7d",
	"border-radius": "3px"
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
			<li>Home</li><li>Dashboard</li><li>Custom Tempalte</li>
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
	<div id="content" class="col-lg-12" ng-controller="templateUploadController">
		<!-- widget grid -->
		<section id="widget-grid">
			<div class="row" >
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
					 data-widget-editbutton="false">
					<header>
						<h2><span class="widget-icon"> <i class="fa fa-table"></i></span> eBay 設定：カスタムテンプレート</h2>
					</header>
					<div>
						<div class="jarviswidget-editbox"></div>
						<div class="widget-body ">
							<div class="row smart-form">
								<fieldset>
									<section class="row">
										<div class="note col col-lg-10">
											<a href='${contextPath}/DownloadTemplate' download>
												<i class="fa fa-hand-o-right" aria-hidden="true"></i>
												<span>サンプルテンプレートダウンロード</span>
											</a>
										</div>
									</section>
									<section class="row">
										<div class="input input-file col col-lg-10">
											<input type="text" style="margin-bottom: 3px;" placeholder="ファイル名" id="template_name"/>
										</div>
									</section>
									<section class="row" style="margin-bottom:3px;">
										<div class="col col-lg-10">
											<div class="input input-file">
																	<span class="button">
																		<input id="templateUploadFile" type="file" ng-model="uploadFileModel" name="file2" onchange="angular.element(this).scope().handingEventFileUpload()">Browse
																	</span>
												<input type="text" placeholder="テンプレートアップロードファイルを選択する">
											</div>
										</div>
									</section>
									<section class="row" style="margin-bottom:3px;">
										<div class="col col-lg-10">
											<div class="input input-file">
																<span class="button">
																	<input id="templateUploadImage" type="file" ng-model="uploadImageModel" name="file2" onchange="angular.element(this).scope().handingEventImageUpload()">Browse
																</span>
												<input type="text" placeholder="カスタムテンプレートのアップロード">
											</div>
											<img id="preview_image" />
											<span style="display: none;" id='templateData'></span>
										</div>
									</section>
									<section class="row">
										<div class="col col-lg-10">
											<div class="btn-group">
												<button type="button" ng-click="ajaxUploadTemplate()" class="btn btn-primary btn-sm">アップロード</button>
												<button type="button" class="btn btn-default btn-sm" ng-click="clearUserTemplateForm()">Clear</button>
											</div>
										</div>
									</section>
								</fieldset>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Row for list exist template -->
			<div class="row">
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
					 data-widget-editbutton="false">
					<header>
						<h2><span class="widget-icon"> <i class="fa fa-table"></i></span> 出品テンプレートの選択</h2>
					</header>
					<div>
						<div class="jarviswidget-editbox"></div>
						<div class="widget-body ">
							<div id='vSelectTemplate' class="inline-group" style="padding-top: 30px; padding-bottom: 30px;">

							</div>
						</div>
					</div>
					<!-- End of list exist template -->
				</div>
			</div>
	</div>
	<jsp:include page="../pages/common/footer.jsp"/>
	<!--================================================== -->
	<jsp:include page="../pages/common/footer2.jsp"/>

	<script type="text/javascript">
		/* $(document).ready(function() {
		 $('#colorpicker').farbtastic('#color');
		 $('#colorpickerstr').farbtastic('#colorstr');
		 }); */

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

	<!-- HANDING BUSSINESS LOGIC FOR UPLOAD FORM VIA ANGULARJS (napt2017) -->
	<script type="text/javascript"src="<c:url value="/resources/js/angularjs/angular.min.js"/>"></script>
	<script type="text/javascript">
        function onSelectRadio (e) {
            console.log($(e).parent().parent().find('.htmlFile'));
            var item = $(e).parent().parent();
            $('#preview_image').attr('src', item.find('img').attr('src'));
            $("#template_name").val(item.find('.title').text());
            $("#user_template_id").val($(e).val());
            $("#templateData").val(item.find('.htmlFile').attr('value'));
            $('#preview_image').show();
            // $(e).parent().parent().find('img').
        }

        $(function() {
            function requestTemplateFromServer () {
                $.get('./LoadUserTemplate', function(data, status) {
                    if (status == 'success') {
                        data[0].forEach( function(data, index) {
                            renderTemplateItem(data);
                        });
                    }
                });
            }




            function renderTemplateItem (data) {
                console.log(data)
                var item = '<section class="col col-2 col-sm-2" style=" padding-bottom: 50px;" >'+
                    '<label class="radio"  >'+
                    '<input type="radio" onclick="onSelectRadio(this)" value="'+data.templateId+'" class="selected_template" name="radio-inline">'+
                    '<i></i><span class="title">'+data.title+'</span></label>'+
                    '<img src="'+data.base64StringImage+'" height="300" width="200"/>'+
                    '<span class="htmlFile" style="display: none;" type="hidden" value="'+data.htmlCode+'"></span>'+
                    '</section> ';
                $('#vSelectTemplate').append(item);
            }

            requestTemplateFromServer();
        });
        //Get app
        var templateUploadApp = angular.module("template_upload_app", []);
        console.log(templateUploadApp)
        //Custom directive to handing end of event repeat
        templateUploadApp.directive('naptRepeatDirective', function($timeout) {
            return {
                restrict: 'A',
                link: function (scope, element, attr) {
                    if (scope.$last === true) {
                        $timeout(function () {
                            scope.registerEventForRadioButton();
                        });
                    }
                }
            }
        });

        //Config the controller
        templateUploadApp.controller("templateUploadController",function($scope,$http){

            //Process event upload template file
            $scope.handingEventFileUpload = function ($this) {
                $scope.templateFileContent = "";
                $("#templateUploadFile").parent().next().val("");
                var templateFile =templateUploadFile.files[0];
                if(templateFile){
                    var fileType = templateFile.type;
                    if(fileType==="text/html"){
                        $("#templateUploadFile").parent().next().val(templateFile.name);
                        $scope.readLocalHtmlFile(templateFile,function(data){
                            $scope.templateFileContent = encodeURIComponent(data);
                        });
                    }
                    else{
                        alert("You must select html template file (*.html)!!!");
                    }
                }
            }

            //Process event upload image
            $scope.handingEventImageUpload = function($this){
                var selectedFile = templateUploadImage.files[0];
                if(selectedFile){
                    var fileType = selectedFile.type;
                    if(fileType==="image/jpeg"||fileType==="image/png"){
                        $("#templateUploadImage").parent().next().val(selectedFile.name);

                        $scope.readLocalImage(selectedFile,function(imageData){
                            $("#preview_image").css({
                                width: "200px",
                                height: "300px",
                                border: "1px solid #827d7d",
                                "border-radius": "3px"
                            });

                            $("#preview_image").attr("src",imageData)
                        });
                    }else{
                        $("#templateUploadImage").parent().next().val("");
                        $("#preview_image").attr("src","");
                        alert("You must select image file (*.jpeg or *.png)!");
                    }
                }
            };

            $scope.clearUserTemplateForm = function(){
                $("#template_name").val("");
                $("#preview_image").attr("src","");
                $("#preview_image").attr("style","");
                $("#templateData").attr("value","");
                $("#user_template_id").val("-1")
                if($("input[name='radio-inline']:checked")){
                    $("input[name='radio-inline']:checked").prop("checked",false)
                }
                $("#templateUploadFile").parent().next().val("");
                $("#templateUploadImage").parent().next().val("");
            }

            //Send ajax to server to upload template
            $scope.ajaxUploadTemplate = function(evt){
                if($("#template_name").val()===""){
                    alert("Empty template name");
                    return;
                }

                if($("#templateData").val()===""){
                    alert("Empty html content for template!!!")
                    return;
                }

                if(!$("#preview_image").attr("src") ||$("#preview_image").attr("src")===""){
                    alert("Empty image for template");
                    return;
                }

                //Prepare the upload form data
                var uploadData = {
                    title:$("#template_name").val(),
                    htmlCode:$("#templateData").val(),
                    base64StringImage:$("#preview_image").attr("src"),
                    templateId:$("#user_template_id").val()||-1
                };

                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");
                var config = {
                    headers:{
                        'Accept':'application/json',
                        'Content-Type': 'application/json' ,
                        'X-CSRF-TOKEN':token
                    }
                }

                $http.post("CustomTemplateUpload",JSON.stringify(uploadData),config)
                    .success(function(data, status, headers,config) {
                        if(data.status==="OK"){
                            //$scope.reloadUserTemplate();
                            alert("Save success!!");
                            window.location.reload();
                        }else{
                            alert(data.cause);
                        }
                    })
                    .error(function(data, status, headers,config){
                        console.log("Error");
                    })
            };

            //Reload user template
            $scope.reloadUserTemplate = function(){
                $http.get("LoadUserTemplate")
                    .success(function(data, status, headers,config) {
                        $scope.listOfUserTemplate = data;
                    })
                    .error(function(data, status, headers,config){
                        console.log("Error");
                    })
            };

            //Bind selected template to layout
            $scope.bindTemplateToLayout = function($this,$event){
                var title = $this.next().prop('nextSibling').textContent;
                var imageString = $this.parent().next().attr("src");
                var htmlCode = decodeURI($this.parent().next().next().val());
                var templateId = $this.val();
                //TODO fix this

                $("#user_template_id").val(templateId);

                if($("#template_name").val()!=="" ||
                    $.trim($scope.templateFileContent) !=="" ||
                    $("#preview_image").attr("src")!==""){
                    var answer = confirm("Seem you are some new template content to add or edit! \n Are you want to edit the exist template ? ");
                    if(answer){
                        $scope.bindingValue(title,htmlCode,imageString );
                        $scope.currentSelectedTemplate = $this;
                    }else{
                        $this.prop('checked', false);
                        if(typeof($scope.currentSelectedTemplate)!=="undefined"){
                            $scope.currentSelectedTemplate.prop('checked', true)
                        }
                    }
                }else{
                    $scope.bindingValue(title,htmlCode,imageString );
                    $scope.currentSelectedTemplate = $this;
                }
            };

            //Binding value
            $scope.bindingValue = function(title,htmlCode,imageString){
                $("#template_name").val(title);
                $("#preview_image").css({
                    width: "200px",
                    height: "300px",
                    border: "1px solid #827d7d",
                    "border-radius": "3px"
                });
                $("#preview_image").attr("src",imageString);
            }

            //Read local image file as base64 string
            $scope.readLocalImage = function($imgeFile,callback){
                var reader = new FileReader();
                reader.onload = function(e) {
                    callback(e.target.result);
                }
                reader.readAsDataURL($imgeFile);
            }

            //Read local html file
            $scope.readLocalHtmlFile = function ($htmlFile,callback) {
                var reader = new FileReader();
                reader.onload = function (evt) {
                    callback(evt.target.result);
                }

                reader.readAsText($htmlFile);
            }

            //Register checked event for all radiobutton onlayout
            $scope.registerEventForRadioButton = function(){
                $(".selected_template").on("change",function(evt){
                    var currentSelectedTemplate = ($('input[name=radio-inline]:checked'));
                    var templateId = currentSelectedTemplate.attr("data-template-id");
                    $scope.updateToDefaultTemplate(templateId);
                    $scope.bindTemplateToLayout($(this),evt);
                });
            };

            $scope.updateToDefaultTemplate = function($templateId){
                $http.get("UpdateDefaultTemplate/"+$templateId);
            };

            //Default load template of current user
            $scope.reloadUserTemplate();
        });

	</script>

	<!-- Your GOOGLE ANALYTICS CODE Below -->
	<%--<script type="text/javascript">--%>
	<%--var _gaq = _gaq || [];--%>
	<%--_gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);--%>
	<%--_gaq.push(['_trackPageview']);--%>
	<%----%>
	<%--(function() {--%>
	<%--var ga = document.createElement('script');--%>
	<%--ga.type = 'text/javascript';--%>
	<%--ga.async = true;--%>
	<%--ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';--%>
	<%--var s = document.getElementsByTagName('script')[0];--%>
	<%--s.parentNode.insertBefore(ga, s);--%>
	<%--})();--%>

	<%--</script>--%>

</body>

</html>