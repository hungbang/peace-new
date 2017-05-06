package com.vn.hungtq.peace.common;
 
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.MalformedURLException;
import java.net.Proxy;
import java.net.Proxy.Type;
import java.net.URL;
import java.net.URLConnection;
import java.text.MessageFormat;
import java.util.*;

/**
 *
 * The AmazonSearchEngine.java class
 * Provide search function by keyword or by Asin Code
 *
 * @author napt2017
 * @since  25/04/2017
 * @version 1.0.1
 *
 * */
public class AmazonSearchEngine {
    //The amazon search url pattern
    private static final String SEARCH_URL_PATTERN = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords={0}";
    private final String pagingTagWebId;
    private final String titleAndLinkXpath ="div[class=s-item-container]>div[class=a-fixed-left-grid]>div[class=a-fixed-left-grid-inner]>div[class=a-fixed-left-grid-col a-col-right]>div[class=a-row a-spacing-small]";
    private int totalPage =-1;
    private int currentPage = -1;
    private String keyWord = null;
    private final Logger logger = LoggerFactory.getLogger(AmazonSearchEngine.class);
    
    public  AmazonSearchEngine(String pagingTagWebId ){
        this.pagingTagWebId = pagingTagWebId;
        currentPage = 1;
    }

    public int getTotalPage(){
        return this.totalPage;
    } 

    public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	} 

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public Optional<AmazonSearchResult> searchByKeyWord(String keyWord) {
        this.keyWord = keyWord;
        String searchUrl = MessageFormat.format(SEARCH_URL_PATTERN, keyWord);
        return getAmazonSearchResultFromUrl(searchUrl);
    }

    public Optional<AmazonSearchResult> searchByASIN(String asin){
        String searchUrl = MessageFormat.format(SEARCH_URL_PATTERN, asin);
        return getAmazonSearchAsinResult(searchUrl);
    }

    private Optional<String> getMainProductUrl(Document htmlDocument){
        Element aLinkElement = htmlDocument.select("li[class=s-result-item celwidget]>div[class=s-item-container]>div[class=a-fixed-left-grid]>div[class=a-fixed-left-grid-inner]>div[class=a-fixed-left-grid-col a-col-right]>div[class=a-row a-spacing-small]")
                                           .first()
                                           .children()
                                           .iterator()
                                           .next()
                                           .children().iterator().next();
        return Optional.ofNullable(aLinkElement.attr("href"));
    }

    /**
     *
     *  Get the amazon product when search by Asin code
     *
     *  @param searchURL
     *  @return Optional<AmazonSearchResult>
     *
     *
     * **/
    private  Optional<AmazonSearchResult> getAmazonSearchAsinResult(String searchURL){
        AmazonSearchResult amazonSearchResult = null;
        String rawHtml = getHTMLContent(searchURL);
        if(!"".equals(rawHtml)) {
            //Parse to html document
            Document htmlDocument = Jsoup.parse(rawHtml);

            //Get main product
            Optional<String> mainProductOption = getMainProductUrl(htmlDocument);
            if(mainProductOption.isPresent()){
                String mainProductUrl = mainProductOption.get();
                rawHtml = getHTMLContent(mainProductUrl);
                if(!"".equals(rawHtml)){
                    amazonSearchResult = new AmazonSearchResult();

                    //Parse to html document
                    htmlDocument = Jsoup.parse(rawHtml);

                    //Get main product title
                    Element titleElement = htmlDocument.getElementById("titleSection").getElementById("title");

                    //Get main product price
                    Element priceElement = htmlDocument.getElementById("priceblock_ourprice");
                    if(priceElement==null){
                    	priceElement = htmlDocument.getElementById("olp_feature_div").select("div[class=a-section a-spacing-small a-spacing-top-small]>span>a").first();
                    	//priceElement = htmlDocument.getElementById("s-results-list-atf").select("li[class=s-result-item celwidget]>div[class=s-item-container]>div[class=a-fixed-left-grid]>div[class=a-fixed-left-grid-inner]>div[class=a-fixed-left-grid-col a-col-right]>div[class=a-row]>div[class=a-column a-span7]>div[class=a-row a-spacing-mini]>div[class=a-row a-spacing-none]>a>span[class=a-size-base a-color-base]").first();
                    }

                    //Get main product image
                    Element imageElement = htmlDocument.getElementById("imgTagWrapperId").select("img").first();

                    //Add to search result
                    amazonSearchResult.addProductSearch(new AmazonProductSearch(titleElement.text(),priceElement.text(),searchURL,imageElement.attr("data-old-hires"),"",0));

                    //Get related product
                    Element relatedProductSearch = htmlDocument.getElementById("sp_detail");
                    if(relatedProductSearch!=null){
                    	 List<AmazonProductSearch> lstRelatedProduct = getRelatedProduct(relatedProductSearch.select("div[class=a-row a-carousel-controls a-carousel-row a-carousel-has-buttons]").first());
                         amazonSearchResult.addAllProductSearch(lstRelatedProduct);
                    }
                   
                }
            }
        }
        return Optional.ofNullable(amazonSearchResult);
    }

    private  List<AmazonProductSearch> getRelatedProduct(Element releatedProductElement){
        Elements allProductRelatedTags = releatedProductElement.select("div[class=a-carousel-row-inner]>div[class=a-carousel-col a-carousel-center]>div[class=a-carousel-viewport]>ol[class=a-carousel]>li[class=a-carousel-card]");
        Iterator<Element> childRelatedIter = allProductRelatedTags.iterator();
        List<AmazonProductSearch> lstAmazonProductSearch = new ArrayList<>();
        int index = 1;
        while (childRelatedIter.hasNext()){
            Element childRelatedTag = childRelatedIter.next().select("div").first();

            //Get data sin
            String dataSin = childRelatedTag.attr("data-asin");

            //Get title and link
            Element titleAndLinkTag = childRelatedTag.select("div[class=sp_offerVertical]>div[class=sp_dpOffer]>a").first();
            String title = titleAndLinkTag.attr("title");
            String link = "https://www.amazon.com"+ titleAndLinkTag.attr("href");

            //Get image
            String imageUrl = titleAndLinkTag.select("div[class=a-carousel-photo]>img").first().attr("src");

            //Get price
            String price = childRelatedTag.select("div[class=sp_offerVertical]>div[class=sp_dpOffer]>div[class=a-row a-color-price]").first().text();

            //Add to list String name, String price,String link ,String imageUrl,String sin
            lstAmazonProductSearch.add(new AmazonProductSearch(title,price,link,imageUrl,dataSin,index));

            //Increment index
            index++;
        }
        return lstAmazonProductSearch;
    }

    private Optional<AmazonSearchResult> getAmazonSearchResultFromUrl(String searchUrl){
        AmazonSearchResult amzSearchResult = null;
        String rawHtml = getHTMLContent(searchUrl);
        if(!"".equals(rawHtml)) {
            //Parse to html document
            Document htmlDocument = Jsoup.parse(rawHtml);
            
            //Instance amzSearchResult
            amzSearchResult = new AmazonSearchResult();

            //Get the paging tag
            if(totalPage==-1){
                Elements pagingTags = htmlDocument.getElementById("page").select("span[class=pageDisabled]");
                if(pagingTags==null){
                	pagingTags = htmlDocument.getElementById("page").select("span[class=pageLink]");
                }
                
                Element pagingTag = pagingTags.last();
                totalPage = Integer.valueOf(pagingTag.text().trim());
            } 
            
            amzSearchResult.setTotalPage(totalPage);

            //Get the product ul tag
            Element productTag = htmlDocument.getElementById("atfResults")
                                            .select("ul[id=s-results-list-atf]")
                                            .first();
            Elements productChildElements = productTag.children();
            List<AmazonProductSearch> lstProductSearch = processProductTags(productChildElements);
            amzSearchResult.addAllProductSearch(lstProductSearch);

            //Get next
            productTag = htmlDocument.getElementById("btfResults");
            if(productTag!=null){
                productTag = productTag.select("ul[class=s-result-list s-col-1 s-col-ws-1 s-result-list-hgrid s-height-equalized s-list-view s-text-condensed]")
                                        .first();
                productChildElements = productTag.children();
                lstProductSearch = processProductTags(productChildElements);
                amzSearchResult.addAllProductSearch(lstProductSearch);
            }
        }
        return Optional.ofNullable(amzSearchResult);
    }

    /**
     *
     *  Jump to next page then get data
     *  @return Optional<AmazonSearchProduct>
     *
     * */
    public Optional<AmazonSearchResult> nextPage(){
        if(totalPage!=-1){
            if(currentPage<totalPage){
                currentPage = currentPage+1;
                String searchUrl = MessageFormat.format(SEARCH_URL_PATTERN, keyWord);
                searchUrl+="&page="+currentPage;
                System.out.println("Current page:"+currentPage);
                return getAmazonSearchResultFromUrl(searchUrl);
            }
        }
        return Optional.empty();
    }

    /**
     *
     *  Jump to prev page then get data
     *  @return Optional<AmazonSearchProduct>
     *
     * */
    public Optional<AmazonSearchResult> prevPage(){
        if(totalPage!=-1){
            if(currentPage>1){
                currentPage = currentPage-1;
                String searchUrl = MessageFormat.format(SEARCH_URL_PATTERN, keyWord);
                searchUrl+="&page="+currentPage;
                return getAmazonSearchResultFromUrl(searchUrl);
            }
        }
        return  Optional.empty();
    }

    public Optional<AmazonSearchResult> goToPage(int page){ 
        String searchUrl = MessageFormat.format(SEARCH_URL_PATTERN, keyWord);
        searchUrl+="&page="+page;
        return getAmazonSearchResultFromUrl(searchUrl); 
    }

    /**
     *
     *  Process the ul tag which contain the infomation
     *  of product then convert each tag to AmazonProductSearch
     *  add to list
     *
     *  @param  productTagElements
     *              The element which contain all product child tag
     *  @return List<AmazonProductSearch>
     *
     * */
    private List<AmazonProductSearch> processProductTags(Elements productTagElements){
        List<AmazonProductSearch> lstAmazonProductSearch = new ArrayList<>(26);
        Iterator<Element> productTagIter = productTagElements.iterator();
        int index = 0;
        while (productTagIter.hasNext()){
            Element productTag = productTagIter.next();
            String sin = productTag.attr("data-asin");
            String title = null;
            String link = null;
            Iterator<Element> tempIter = productTag.select(titleAndLinkXpath).iterator();
            if(!tempIter.hasNext()){
                tempIter = productTag.select("div[class=s-item-container]>div[class=a-row a-spacing-mini]>div[class=a-section acs-mn2-widget-wrapper]>div[class=acs-mn2-widget acs-mn2-midWidget s-position-relative s-overflow-hidden]>div[class=a-section acs-mn2-content]").iterator();
                if(!tempIter.hasNext()){
                    tempIter = productTag.select("div[class=s-item-container]>div[class=a-row a-spacing-mini]>div[class=a-fixed-left-grid]>div[class=a-fixed-left-grid-inner]>div[class=a-fixed-left-grid-col a-col-left]").iterator();
                }
            }
            try {
                Elements titleAndLinkTag = tempIter.next().select("a");
                Iterator<Element> titleAndLinkIter = titleAndLinkTag.iterator();
                if (titleAndLinkIter.hasNext()) {
                    Element childElement = titleAndLinkIter.next();
                    title = childElement.attr("title");
                    link = childElement.attr("href");
                    if (!link.startsWith("https://www.amazon.com")) {
                        link = "https://www.amazon.com" + link;
                    }
                }
            }catch (Exception ex){
                logger.debug(ex.getMessage());
            }


            //Get Image source
            Elements imgElement = productTagElements.select("div[class=s-item-container]>div[class=a-fixed-left-grid]>div[class=a-fixed-left-grid-inner]>div[class=a-fixed-left-grid-col a-col-left]>div[class=a-row]>div[class=a-column a-span12 a-text-center]>a[class*=a-link-normal]>img[class=s-access-image cfMarker]");
            String imgSource = imgElement.attr("src");

            //Get price
            String price = null;
            Element priceElement = productTagElements.select("div[class=s-item-container]>div[class=a-fixed-left-grid]>div[class=a-fixed-left-grid-inner]>div[class=a-fixed-left-grid-col a-col-right]>div[class=a-row]>div[class=a-column a-span7]>div[class=a-row a-spacing-none]>a[class*=a-link-normal]>span[class=a-color-base sx-zero-spacing]").first();
            if(priceElement!=null){
                price = priceElement.attr("aria-label");
            }else{
                priceElement = productTagElements.select("div[class=s-item-container]>div[class=a-fixed-left-grid]>div[class=a-fixed-left-grid-inner]>div[class=a-fixed-left-grid-col a-col-right]>div[class=a-row]>div[class=a-column a-span7]>div[class=a-row a-spacing-mini]>div[class=a-row a-spacing-none]>a[class*=a-size-small]>span[class=a-size-base a-color-base]").first();
                price = priceElement.text();
            }

            //Create new product
            AmazonProductSearch amazonProductSearch = new AmazonProductSearch(title,price,link,imgSource,sin,index++);
            lstAmazonProductSearch.add(amazonProductSearch);
        }
        return lstAmazonProductSearch;
    }

    /**
     *
     *  The getHTMLContent method
     *  Send HttpRequest to webserver then get response
     *  as text plain which contain html ,css,javascript code of webpage
     *  @param 	url
     *  @author napt2017
     *  @return String
     *
     * **/
    private String getHTMLContent(String url) {
        if (!"".equals(url) && url != null) {
            try {
                URL _url = new URL(url);
                //Proxy proxy = new Proxy(Type.HTTP, new InetSocketAddress("58.176.232.16", 80));
                //URLConnection cnn = _url.openConnection(proxy);
                URLConnection cnn = _url.openConnection();
                HttpURLConnection httpUrlConnection = (HttpURLConnection) cnn;
                cnn.addRequestProperty(
                        "User-Agent",
                        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36");
                
                httpUrlConnection.setRequestMethod("GET");
                httpUrlConnection.setDoInput(true);
                httpUrlConnection.setDoOutput(true);

                try (final InputStream in = cnn.getInputStream();
                     final InputStreamReader inRead = new InputStreamReader(in,"UTF-8");
                     final BufferedReader bRead = new BufferedReader(inRead)) {
                    StringBuilder sb = new StringBuilder();
                    String line;
                    while ((line = bRead.readLine()) != null) {
                        sb.append(line);
                    }
                    return sb.toString();
                }
            } catch (MalformedURLException ex) {
                logger.debug(ex.getMessage());
            } catch (IOException ex) {
            	logger.debug(ex.getMessage());
            }
        }

        return "";
    }
}
