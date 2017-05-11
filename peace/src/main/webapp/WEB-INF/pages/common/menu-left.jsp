<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="left-panel">
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
			<!-- User info -->
			<div class="login-info">
				<span class="dropdown"> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a href="javascript:void(0);" id="show-shortcut" data-toggle="dropdown" aria-expanded="true">
<%-- 						<img src="${pageContext.request.contextPath}/resources/img/avatars/sunny.png" alt="me" class="online" />  --%>
						
						<span style="font-size: 16px;font-weight: bold;margin-left: 10px">
							<sec:authentication property="principal.Username" />
						</span>
						<i class="fa fa-angle-down"></i>
					</a> 
					<ul class="dropdown-menu" role="menu">
						<li>
							<a href="${contextPath}/SetAccount" title="Account"><i class="fa fa-fw fa-user"></i> My Account</a>
						</li>
						<li class="divider"></li>
						<li>
							<a href="/logout" title="Logout" data-action="userLogout" data-logout-msg="Test"><i class="fa fa-fw fa-sign-out"></i>ログアウト</a>
						</li>
					</ul>
				</span>
			</div>
			<!-- end user info -->

			<!-- NAVIGATION : This navigation is also responsive-->
			<nav>
				<!-- ssssssss
				NOTE: Notice the gaps after each icon usage <i></i>..
				Please note that these links work a bit different than
				traditional href="" links. See documentation for details.
				-->

				<ul>
					<li class="active">
						<a href="${contextPath}/" title="Dashboard"><i class="fa fa-lg fa-fw fa-home"></i> <span class="menu-item-parent">ホーム</span></a>
					</li>
					<li class="top-menu-invisible">
						<a href="#"> <span class="menu-item-parent">eBay出品</span></a>
						<ul>
							<li class="">
								<a href='${contextPath}/Sell' title=""><i class=""></i> <span class="menu-item-parent">商品出品</span></a>
							</li>
							<li class="">
								<a href='${contextPath}/SellDetail' title=""><i class=""></i> <span class="menu-item-parent">eBay出品用</span></a>
							</li>
<!-- 							<li > -->
<!-- 								<a href="#"><i class=""></i>カテゴリー検索</a> -->
<!-- 							</li> -->
						</ul>
					</li>
					<li>
						<a href="#"> <span class="menu-item-parent">eBay商品一覧</span></a>
						<ul>
							<li class="">
								<a href="${contextPath}/ListSell" title=""> <span class="menu-item-parent">出品中</span></a>
							</li>
							<li class="">
								<a href="${contextPath}/ListUnsold" title=""><span class="menu-item-parent">出品終了</span></a>
							</li>
							<li>
								<a href="${contextPath}/ListSold">販売済み</a>
							</li>
							<li>
								<a href="${contextPath}/ListError">エラー</a>
							</li>
						</ul>
					</li>
					<li class="" >
						<a href="#"> <span class="menu-item-parent">リサーチ</span></a>
						<ul>
							<li class="" >
								<a href="${contextPath}/ListResearchAll"> <span class="menu-item-parent">キーワード</span></a>
							</li>
							<li class="" >
								<a href="${contextPath}/AmazonSearch"> <span class="menu-item-parent">ASIN</span></a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#"> <span class="menu-item-parent">eBay設定</span></a>
						<ul>
							<li >
								<a href="${contextPath}/SetEbayLocation">出品ロケーション</a>
							</li>
							<li >
								<a href="${contextPath}/CustomTemplate">カスタム出品テンプレート</a>
							</li>
							<li>
								<a href="${contextPath}/SetItemInfo">商品説明情報</a>
							</li>
							<li>
								<a href="${contextPath}/SetShip">発送方法</a>
							</li>
							<li>
								<a href="${contextPath}/TransportSetting">送料編集</a>
							</li>
							<li>
								<a href="${contextPath}/NotShippingCountrySetting">発送しない国</a>
							</li>
							<li>
								<a href="${contextPath}/SetBuyer">Buyer Requirement</a>
							</li>
							<li>
								<a href="${contextPath}/SetEbayLogin">eBayログイン</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#"> <span class="menu-item-parent">在庫チェック</span></a>
						<ul>
							<li>
								<a href="${contextPath}/StockRegistor">新規登録</a>
							</li>
							<li>
								<a href="${contextPath}/StockList">在庫一覧</a>
							</li>
							<li>
								<a href="${contextPath}/StockRegistorAmazon">新規登録（Amazon)</a>
							</li>
							<li>
								<a href="${contextPath}/StockListAmazon">在庫一覧（Amazon）</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="${contextPath}/SetAccount"> <span class="menu-item-parent">アカウント</span></a>
					</li>	
					<li>
						<a href="${contextPath}/Manual"><span class="menu-item-parent">マニュアル</span></a>
					</li>
					<li>
						<a href="${contextPath}/ContactUs"> <span class="menu-item-parent">お問い合わせ</span></a>
					</li>
				</ul>
			</nav>
			<span class="minifyme" data-action="minifyMenu"> 
				<i class="fa fa-arrow-circle-left hit"></i> 
			</span>

		</aside>