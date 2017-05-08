<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us" ng-app="acount-setting-app">
<jsp:include page="../pages/common/header.jsp" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<body class="fixed-page-footer">
<style>
	input, textarea, button {
		margin-top: 10px
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
	/* Required field END */
</style>
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
			<li>My Account</li>
		</ol>

	</div>
	<!-- END RIBBON -->

	<!-- MAIN CONTENT -->
	<div class="col-lg-8" >
		<div id="content">
			<div class="row">
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
					 data-widget-editbutton="false">
					<header>
						<h2><span class="widget-icon"> <i class="fa fa-table"></i></span>  Infomation</h2>
					</header>
					<div>
						<div class="jarviswidget-editbox"></div>
						<div class="widget-body ">
							<div class="row smart-form">
								<fieldset>
									<section class="row smart-form"> <label
											class="label col col-6">パスワード変更前</label> <label
											class="col col-6">
										<input type="password" class="form-control" style="width: 100%" id="old-pass">
									</label> </section>
									<section class="row smart-form"> <label
											class="label col col-6">パスワード変更後（半角英数字6文字以上12文字以下）</label> <label
											class="col col-6">
										<input type="password" class="form-control"
											   style="width: 100%" id="new-pass">
									</label> </section>
									<section class="row smart-form"> <label
											class="label col col-6">パスワード変更後（確認用）</label> <label
											class="col col-6"> <input type="password" class="form-control"
																	  style="width: 100%" id="re-new-pass">
									</label> </section>
									<section class="row smart-form"> <label
											class="label col col-6">Inventory check result mail distribution setting
									</label>
										<div class="col col-6">
											<label class=""> <input type="radio"
																	name="radio-inline"  id="rdIsDeliver"> <i></i>配信する
											</label> <label class=""> <input type="radio"
																			 name="radio-inline"  id="rdIsNotDeliver"> <i></i>配信しない<label>
										</div>
									</section>
									<section class="row smart-form"> <label
											class="label col col-6">メールアドレス（255文字以内）</label> <label
											class="col col-6"> <input type="text" class="form-control"
																	  style="width: 100%" id="email" >
									</label> </section>
								</fieldset>
								<div class='row' style="padding: 10px 29px 5px 30px;">
									<div class="col-md-10" ></div>
									<button id="btnSaveAccountConfig" class="col-md-2 col-sm-12 col-xs-12 btn btn-success">Save</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
					 data-widget-editbutton="false">
					<header>
						<h2><span class="widget-icon"> <i class="fa fa-table"></i></span>   Setting Amazon</h2>
					</header>
					<div>
						<div class="jarviswidget-editbox"></div>
						<div class="widget-body ">
							<div class="row smart-form">
								<fieldset>
									<section class="row smart-form"> <label
											class="label col col-6">Access Key</label> <label
											class="col col-6"> <input type="text" class="form-control" style="width: 100%"
																	  id="access-key">
									</label> </section>
									<section class="row smart-form"> <label
											class="label col col-6">Secret Key</label> <label
											class="col col-6"> <input type="text" class="form-control" style="width: 100%"
																	  id="secret-key">
									</label> </section>
									<section class="row smart-form"> <label
											class="label col col-6">Id</label> <label class="col col-6">
										<input type="text" class="form-control" style="width: 100%" id="amazon-id">
									</label> </section>
								</fieldset>
								<div class='row' style="padding: 10px 29px 5px 30px;">
									<div class="col-md-10" ></div>
									<button id="btnSaveAmazonConfig" class="col-md-2 col-sm-12 col-xs-12 btn btn-success">Save</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"
					 data-widget-editbutton="false">
					<header>
						<h2><span class="widget-icon"> <i class="fa fa-table"></i></span>   Paypal Setting</h2>
					</header>
					<div>
						<div class="jarviswidget-editbox"></div>
						<div class="widget-body ">
							<div class="row smart-form">
								<fieldset>
									<section class="row smart-form"> <label
											class="label col col-6">PayPal Email</label>
										<label class="col col-6">
											<input type="text" class="form-control" style="width: 100%"   id="paypal-email">
										</label>
									</section>
									<section class="row ">
										<label class="col col-md-12 col-sm-12 col-xs-12 flex">
											<p> <input type="checkbox" id="cbIsImmediateStettlement"
													   name="checkbox" checked="checked" style="margin-right: 10px;font-size: 200% !important;">Require immediate payment when buyer uses Buy It Now /
												Buy It Now Buyer needs to pay immediately</p>
										</label>
									</section>
								</fieldset>
								<div class='row' style="padding: 10px 29px 5px 30px;">
									<div class="col-md-10" ></div>
									<button id="btnSavePaypalConfig" class="col-md-2 col-sm-12 col-xs-12 btn btn-success">Save</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class='row' style="padding: 10px 29px 5px 30px;">
			<button id="btnSaveConfig" ng-click="saveAccountSetting($event)" class="col-md-2 col-sm-12 col-xs-12 btn btn-primary">Save</button>
		</div>

	</div>
	<!-- END MAIN CONTENT -->

</div>
<jsp:include page="../pages/common/footer.jsp" />
<!--================================================== -->
<jsp:include page="../pages/common/footer2.jsp" />

<script type="text/javascript">
    $(document).ready(function() {
        //$('#colorpicker').farbtastic('#color');
        //$('#colorpickerstr').farbtastic('#colorstr');
    });
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
<!--Replace the angularjs-->
<script type="text/javascript">
    $(function () {
        //CSRF Token
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        //Check correct old password
        function checkCorrectOldPassword(oldPassword, success_callback, failed_callback) {
            $.get("CheckPassword/" + encodeURI(oldPassword),function(data,status){
                if (data.extraData) {
                    success_callback();
                } else {
                    failed_callback();
                }
            });
        }

        //Load account setting of user
        function loadAccountSettingOfUser() {
            $.get("GetAccountSetting",function(data,status){
                if (data.recordId != -1) {
                    var accountSettingModel = data.extraData;
                    $("#email").val(accountSettingModel.email);
                    $("#access-key").val(accountSettingModel.amazonAccessKey);
                    $("#secret-key").val(accountSettingModel.amazonSecretKey);
                    $("#amazon-id").val(accountSettingModel.amazoneId);
                    $("#paypal-email").val(accountSettingModel.paypalEmail);
                    if(accountSettingModel.isImmediateStettlement){
                        //Check the check box
                        $("#cbIsImmediateStettlement").prop("checked",accountSettingModel.isImmediateStettlement)
                    }

                    if(accountSettingModel.isDeliver){
                        //Check the radiobox
                        $("#rdIsDeliver").prop("checked",true);
                    }else{
                        $("#rdIsNotDeliver").prop("checked",true);
                    }
                }
            });
        }

        //Validate Account form
        function validateAccountForm(success_callback) {
            if ($("#email").val() === "") {
                alert("Empty email");
                return;
            } else {
                if (!$.trim($("#email").val()).match(
                        /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/)) {
                    alert("Email not correct!")
                    return;
                }
            }

            success_callback();
        }

        //Validate Amazon form
        function validateAmazonForm(success_callback) {

            if ($("#access-key").val() === "") {
                alert("Empty access key");
                return;
            }

            if ($("#secret-key").val() === "") {
                alert("Empty secret key");
                return;
            }

            if ($("#amazon-id").val() === "") {
                alert("Empty amazon id");
                return;
            }

            success_callback();
        }

        //Validate Paypal form
        function validatePaypalForm(success_callback) {

            if ($("#paypal-email").val() === "") {
                alert("Empty paypal email");
                return;
            } else {
                if (!$.trim($("#paypal-email").val())
                        .match(
                            /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/)) {
                    alert("Paypal email not correct!")
                    return;
                }
            }
            success_callback();
        }

        //Update user info
        function updateOldUserInfo(update_sucess_callback){
            var dataPost = {
                id: 0,
                username: "",
                password: $("#new-pass").val(),
                email: $("#email").val(),
                fullname: "",
                date: new Date()
            };

            $.ajax({
                type : "POST",
                contentType : "application/json",
                url : "ChangeUserPasswordEmail",
                data: JSON.stringify(dataPost),
                beforeSend:function(xhr){
                    xhr.setRequestHeader(header, token);
                },
                dataType : 'json',
                timeout : 100000,
                success : function(data) {
                    if (data.status === "OK") {
                        update_sucess_callback();
                    } else {
                        alert("Update password failed!")
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

        //Save account setting
        function saveAccountSetting(evt) {
            evt.preventDefault();

            if ($("#old-pass").val() === "") {
                alert("Empty old pass");
                return;
            }

            if ($("#new-pass").val() === "") {
                alert("Empty new pass");
                return;
            }

            if ($("#re-new-pass").val() === "") {
                alert("Empty retype new pass");
                return;
            }

            if ($("#re-new-pass").val() !== $("#new-pass")
                    .val()) {
                alert("New pass not same with retype new pass");
                return;
            }

            //Check correct old password
            checkCorrectOldPassword($("#old-pass").val(),function(){
                //Password correct then validate rest form
                validateAccountForm(function(){
                    //When all validate success
                    updateOldUserInfo(function(){
                        console.log("Update password success!");
                        var dataPost ={
                            email:$("#email").val(),
                            isDeliver:$("#rdIsDeliver").prop("checked"),
                        };

                        $.ajax({
                            type : "POST",
                            contentType : "application/json",
                            url : "SaveAccountSetting",
                            data: JSON.stringify(dataPost),
                            beforeSend:function(xhr){
                                xhr.setRequestHeader(header, token);
                            },
                            dataType : 'json',
                            timeout : 100000,
                            success : function(data) {
                                if (data.status === "OK") {
                                    alert("Update user info success");
                                    window.location.reload();
                                } else {
                                    alert("Update user info failed!")
                                }
                            },
                            error : function(e) {
                                console.log("ERROR: ", e);
                            },
                            done : function(e) {
                                console.log("DONE");
                            }
                        });

                    });
                });
            },function(){
                //Password incorrect
                alert("Old password incorrect");
            });
        }

        //Save Amazon setting
        function saveAmazonSetting(evt) {
            validateAmazonForm(function(){
				var dataPost ={
					amazonAccessKey:$("#access-key").val(),
					amazonSecretKey:$("#secret-key").val(),
					amazoneId:$("#amazon-id").val(),
				};

				$.ajax({
					type: "POST",
					contentType: "application/json",
					url: "/saveAmazonSetting",
					data: JSON.stringify(dataPost),
					beforeSend: function (xhr) {
						xhr.setRequestHeader(header, token);
					},
					dataType: 'json',
					timeout: 100000,
					success: function (data) {
						if (data.status === "OK") {
							alert("Update user info success");
							window.location.reload();
						} else {
							alert("Update user info failed!")
						}
					},
					error: function (e) {
						console.log("ERROR: ", e);
					},
					done: function (e) {
						console.log("DONE");
					}
				});
            });
        }

        //Save Paypal setting
        function savePaypalSetting(evt) {
            validatePaypalForm(function(){
				var dataPost ={
					paypalEmail:$("#paypal-email").val(),
					isImmediateStettlement:$("#cbIsImmediateStettlement").prop("checked")
				};

				$.ajax({
					type: "POST",
					contentType: "application/json",
					url: "/savePaypalSetting",
					data: JSON.stringify(dataPost),
					beforeSend: function (xhr) {
						xhr.setRequestHeader(header, token);
					},
					dataType: 'json',
					timeout: 100000,
					success: function (data) {
						if (data.status === "OK") {
							alert("Update user info success");
							window.location.reload();
						} else {
							alert("Update user info failed!")
						}
					},
					error: function (e) {
						console.log("ERROR: ", e);
					},
					done: function (e) {
						console.log("DONE");
					}
				});
            });
        }

        //Register event add save
        $("#btnSaveAccountConfig").on("click",function (evt) {
            saveAccountSetting(evt);
        })

		$("#btnSaveAmazonConfig").on("click",function (evt) {
			saveAmazonSetting(evt);
		})

        $("#btnSavePaypalConfig").on("click",function (evt) {
            savePaypalSetting(evt);
        })

        //Default load
        loadAccountSettingOfUser();
    });
</script>
<!-- LOAD ANGULAR JS MODULE
	<script type="text/javascript"
		src="<c:url value="/resources/js/angularjs/angular.js"/>"></script>
    -->
<!-- HANDING BUSSINESS LOGIC FOR ACCOUNT SETTING
<script type="text/javascript">
    var accountSettingApp = angular.module("acount-setting-app", []);
    accountSettingApp
        .controller(
            "accountSettingController",
            function($scope, $http) {
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr(
                    "content");
                var config = {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': token
                    }
                };

                $scope.headers = config;
                $scope.saveAccountSetting = function($event) {
                    $event.preventDefault();
                    if ($("#new-pass").val() !== "" || $("#re-new-pass").val() !== "") {
                        if ($("#old-pass").val() === "") {
                            alert("Empty old pass");
                            return;
                        }

                        if ($("#new-pass").val() === "") {
                            alert("Empty new pass");
                            return;
                        }

                        if ($("#re-new-pass").val() === "") {
                            alert("Empty retype new pass");
                            return;
                        }

                        if ($("#re-new-pass").val() !== $("#new-pass")
                                .val()) {
                            alert("New pass not same with retype new pass");
                            return;
                        }
                        //Validate old password
                        $scope.checkCorrectOldPassword(
                            $("#old-pass").val(),
                            function() {
                                //Password correct
                                $scope.validateRestOfForm(function() {
                                    //Validate all success
                                    $scope.updateOldUserInfo(function() {
                                        //Update user info success
                                        var dataPost = $scope.accountSettingModel;
                                        $http
                                            .post(
                                                "SaveAccountSetting",
                                                JSON
                                                    .stringify(dataPost),
                                                $scope.headers)
                                            .success(
                                                function(
                                                    data,
                                                    status,
                                                    headers,
                                                    config) {
                                                    console
                                                        .log(data)
                                                })
                                            .error(
                                                function(
                                                    data,
                                                    status,
                                                    headers,
                                                    config) {
                                                    console
                                                        .log(data);
                                                });
                                    })
                                })

                            },
                            function() {
                                alert("Old password incorrect");
                            })
                    }
                };

                //Must implement it
                $scope.updateOldUserInfo = function(
                    update_sucess_callback) {
                    var dataPost = {
                        id: 0,
                        username: "",
                        password: $("#new-pass").val(),
                        email: $("#email").val(),
                        fullname: "",
                        date: new Date()
                    };

                    $http
                        .post("ChangeUserPasswordEmail", JSON.stringify(dataPost), $scope.headers)
                        .success(
                            function(data, status, headers,
                                     config) {
                                if (data.status === "OK") {
                                    update_sucess_callback();
                                } else {
                                    alert("Update password failed!")
                                }
                            }).error(
                        function(data, status, headers,
                                 config) {
                            console.log(data);
                        });
                }

                $scope.validateRestOfForm = function(
                    success_callback) {
                    if ($("#email").val() === "") {
                        alert("Empty email");
                        return;
                    } else {
                        if (!$
                                .trim($("#email").val())
                                .match(
                                    /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/)) {
                            alert("Email not correct!")
                            return;
                        }
                    }

                    if ($("#access-key").val() === "") {
                        alert("Empty access key");
                        return;
                    }

                    if ($("#secret-key").val() === "") {
                        alert("Empty secret key");
                        return;
                    }

                    if ($("#amazon-id").val() === "") {
                        alert("Empty amazon id");
                        return;
                    }

                    if ($("#paypal-email").val() === "") {
                        alert("Empty paypal email");
                        return;
                    } else {
                        if (!$
                                .trim($("#paypal-email").val())
                                .match(
                                    /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/)) {
                            alert("Paypal email not correct!")
                            return;
                        }
                    }
                    success_callback();
                };

                $scope.loadAccountSettingOfUser = function() {
                    $http
                        .get("GetAccountSetting")
                        .success(
                            function(data, status, headers,
                                     config) {
                                if (data.recordId != -1) {
                                    $scope.accountSettingModel = data.extraData;
                                }
                            }).error(
                        function(data, status, headers,
                                 config) {
                            console.log(data);
                        });
                }

                $scope.checkCorrectOldPassword = function(
                    oldPassword, success_callback,
                    failed_callback) {
                    $http.get(
                        "CheckPassword/" +
                        encodeURI(oldPassword))
                        .success(
                            function(data, status, headers,
                                     config) {
                                if (data.extraData) {
                                    success_callback();
                                } else {
                                    failed_callback();
                                }
                            }).error(
                        function(data, status, headers,
                                 config) {
                            console.log(data);
                        });
                }

                //Default load
                $scope.loadAccountSettingOfUser();
            });
</script>
-->
</body>

</html>