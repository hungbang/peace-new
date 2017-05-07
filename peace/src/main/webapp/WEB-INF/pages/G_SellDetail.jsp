<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us">
	<jsp:include page="../pages/common/header.jsp"/>  
	<meta name="_csrf" content="${_csrf.token}"/>
 	<meta name="_csrf_header" content="${_csrf.headerName}"/> 
	<body class="fixed-page-footer">
		<style>
.ebay-fieldset{
	border: 1px solid #bfbebe !important;
    background: none !important;
}

.detail-action{
	list-style:none;
	display:inline-flex;
}

.detail-action li{
	border: 1px solid #bfbfbf;
    margin-right: 4px;
    margin-top: 3px;
    width: 110px;
    text-align: center;
}

.ebay-fieldset legend{
	color: black;
    font-size: 14px; 
    padding: 0px;
    display: inline;
}
.preview-image-list{
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
	height: 220px !important;
   
	
}

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

label {
    font-weight: bold !important;
    font-size: medium !important;
}
/* Required field END */
<!--http://cgi5.ebay.com/ws/eBayISAPI.dll-->
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
					<li>Home</li><li>Sell</li>
				</ol>
				<!-- end breadcrumb -->
			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">
				<!-- widget content -->
				<div class="widget-body">
					<ul id="myTab1" class="nav nav-tabs bordered">
						<li class="active">
							<a href="#s1" data-toggle="tab">商品情報</a>
						</li>
						<li id="tabEbay">
							<a href="#s2" data-toggle="tab"> eBay.com出品用</a>
						</li>
					</ul>
					
					<div id="myTabContent1" class="tab-content" >
						
							<div class="tab-pane fade in active" id="s1">
								<fieldset style="padding-bottom: 20px;">
								<section class="col-xs-10 col-md-10"> 
									<label class="">商品タイトル（英語）</label> 
									 
										<input type="text" class="input" id="product_title"   maxlength="80" style="width: 100%padding-bottom: 5px;
    padding-top: 5px;
    padding-left: 5px;">
									
								</section> 
								
								<!-- The detail part -->
								<section class="col-xs-10 col-md-10"> 
									<label class="">商品説明（英語）</label>   
									<textarea id="ckEditorForDescription">
										<c:if test ="${ebayProductAdd !=null}"> 
		<%-- 									${ebayProductAdd.viewItemUrl} --%>
										</c:if>
									</textarea> 
								</section>
									<!-- The image URL  part -->
									<section class="col-xs-10 col-md-10"> 
										<label class="">タイトル用画像URL </label> 
										<textarea id="imageUrl" style="width: 100%" rows="5"></textarea> 
									</section>
									<!-- End image URL  part -->
									
									<!-- The Product image URL for product description  part -->
									<section class="col-xs-10 col-md-10"> 
										<label class="">商品説明用画像URL </label> 
										<textarea id="imageDescription" style="width: 100%" rows="5"></textarea> 
									</section>
									<section class="col-xs-10 col-md-10" style="margin-bottom: 10px"> 
										<label class="">商品説明用画像URL </label> 
										<textarea id="imageDescription" style="width: 100%" rows="5"></textarea>
									</section>
								</fieldset>
							</div>
							<div class="tab-pane fade" id="s2">
								<fieldset>
									<div class="row" style="padding-left: 20px;">
										<section class="col col-md-12" >
											<label class="input">
												<input class="input" style="width: 800px" type="text" id="title"/>
											</label>
											<div class="note">
												<a>
													<i class="fa fa-hand-o-right" aria-hidden="true"></i>
													<span>こちらをeBayの出品画面のTitleにコピペしてください。</span>
												</a>
											</div>
										</section>
									</div>
									<div class="row" style="margin-bottom: 10px; padding-left: 20px;">
										<section class="col col-md-12">
											<label class="input" >
												<textarea id="description" style="width: 800px" rows="10"></textarea> 
											</label>
											<div class="note">
												<a>
													<i class="fa fa-hand-o-right" aria-hidden="true"></i>
													<span>こちらをeBayの出品画面のDetailsにコピペしてください。</span>
												</a>
											</div>
										</section>
									</div>
								</fieldset>
							</div>
						
					</div>

				</div>

			</div>
			<!-- END MAIN CONTENT -->

		</div>

		<script src="${pageContext.request.contextPath}/resources/js/third-party/jquery/jquery.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/third-party/jquery/jquery.cookie.js"></script>

		<script src="${pageContext.request.contextPath}/resources/js/lib/beautify.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/lib/beautify-css.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/lib/beautify-html.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/lib/unpackers/javascriptobfuscator_unpacker.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/lib/unpackers/urlencode_unpacker.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/lib/unpackers/p_a_c_k_e_r_unpacker.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/lib/unpackers/myobfuscate_unpacker.js"></script>
		<!-- EMBED CKEDITOR(napt2017) -->
		<script src="${pageContext.request.contextPath}/resources/js/plugin/ckeditor/ckeditor.js"></script>

		<jsp:include page="../pages/common/footer.jsp"/>
		<!--================================================== -->
		<jsp:include page="../pages/common/footer2.jsp"/>
		<script type="text/javascript">
			$(function(){
				CKEDITOR.replace("ckEditorForDescription");
			});
	        var the = {
	                use_codemirror: (!window.location.href.match(/without-codemirror/)),
	                beautify_in_progress: false,
	                editor: null // codemirror editor
	            };
	        function unpacker_filter(source) {
	            var trailing_comments = '',
	                comment = '',
	                unpacked = '',
	                found = false;

	            // cut trailing comments
	            do {
	                found = false;
	                if (/^\s*\/\*/.test(source)) {
	                    found = true;
	                    comment = source.substr(0, source.indexOf('*/') + 2);
	                    source = source.substr(comment.length).replace(/^\s+/, '');
	                    trailing_comments += comment + "\n";
	                } else if (/^\s*\/\//.test(source)) {
	                    found = true;
	                    comment = source.match(/^\s*\/\/.*/)[0];
	                    source = source.substr(comment.length).replace(/^\s+/, '');
	                    trailing_comments += comment + "\n";
	                }
	            } while (found);

	            var unpackers = [P_A_C_K_E_R, Urlencoded, JavascriptObfuscator/*, MyObfuscate*/];
	            for (var i = 0; i < unpackers.length; i++) {
	                if (unpackers[i].detect(source)) {
	                    unpacked = unpackers[i].unpack(source);
	                    if (unpacked != source) {
	                        source = unpacker_filter(unpacked);
	                    }
	                }
	            }

	            return trailing_comments + source;
	        }
			 function beautify() {
		            if (the.beautify_in_progress) return;

// 		            store_settings_to_cookie();

		            the.beautify_in_progress = true;

		            var source = the.editor ? the.editor.getValue() : $('#description').val(),
		                output,
		                opts = {};

		            opts.indent_size = $('#tabsize').val();
		            opts.indent_char = opts.indent_size == 1 ? '\t' : ' ';
		            opts.max_preserve_newlines = $('#max-preserve-newlines').val();
		            opts.preserve_newlines = opts.max_preserve_newlines !== "-1";
		            opts.keep_array_indentation = $('#keep-array-indentation').prop('checked');
		            opts.break_chained_methods = $('#break-chained-methods').prop('checked');
		            opts.indent_scripts = $('#indent-scripts').val();
		            opts.brace_style = $('#brace-style').val() + ($('#brace-preserve-inline').prop('checked') ? ",preserve-inline" : "");
		            opts.space_before_conditional = $('#space-before-conditional').prop('checked');
		            opts.unescape_strings = $('#unescape-strings').prop('checked');
		            opts.jslint_happy = $('#jslint-happy').prop('checked');
		            opts.end_with_newline = $('#end-with-newline').prop('checked');
		            opts.wrap_line_length = $('#wrap-line-length').val();
		            opts.indent_inner_html = $('#indent-inner-html').prop('checked');
		            opts.comma_first = $('#comma-first').prop('checked');
		            opts.e4x = true;

		            if (looks_like_html(source)) {
		                output = html_beautify(source, opts);
		            } else {
		                if ($('#detect-packers').prop('checked')) {
// 		                    source = unpacker_filter(source);
		                }
		                source = unpacker_filter(source);
		                output = js_beautify(source, opts);
		            }
		            if (the.editor) {
		                the.editor.setValue(output);
		            } else {
		                $('#description').val(output);
		            }

		            the.beautify_in_progress = false;
		        }

		        function looks_like_html(source) {
		            // <foo> - looks like html
		            var trimmed = source.replace(/^[ \t\n\r]+/, '');
		            return trimmed && (trimmed.substring(0, 1) === '<');
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
		<script type="text/javascript">
			function loadTemplate() {
				var title = $("#product_title").val();
				 var description =$("#cke_ckEditorForDescription").find(".cke_inner .cke_reset")
				  .find("iframe")
				  .contents()[0]
				  .documentElement
				  .getElementsByTagName("body")[0].innerHTML;
				var imageUrl = $("#imageUrl").val();
				var imageDescription = $("#imageDescription").val();
				var youtubeUrl = $("#youtubeUrl").val();
				var data = JSON.stringify({
	               	 title : title ,
	            	 description :description ,
	            	 imageUrl : imageUrl ,
	            	 imageDescription : imageDescription ,
	            	 youtubeUrl : youtubeUrl ,
	            });
				var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");

				$.ajax({
					type : "POST",
					contentType : "application/json",
					url : "/GetDataTemplate",
					data: data,
			        beforeSend:function(xhr){
			             xhr.setRequestHeader(header, token);
			        },
					dataType : 'json',
					timeout : 100000,
					success : function(data) {
						console.log("SUCCESS: ", data);
						$('#title').val(data.extraData.title);
						$('#description').val(data.extraData.description);
						beautify();
					 },
					error : function(e) {
						console.log("ERROR: ", e);
					},
					done : function(e) {
						console.log("DONE");
					}
				});
			}
			$( "#tabEbay" ).click(function() {
				loadTemplate();
			});
		</script>

	</body>

</html>