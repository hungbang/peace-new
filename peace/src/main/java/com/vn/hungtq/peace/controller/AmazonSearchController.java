package com.vn.hungtq.peace.controller;

import com.vn.hungtq.peace.common.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.*;

/**
 * Created by KAI on 5/7/17.
 */
@Controller
public class AmazonSearchController {

    private final Logger logger = LoggerFactory.getLogger(AmazonSearchController.class);

    /*
     * Your AWS Access Key ID, as taken from the AWS Your Account page.
     */
    private static final String AWS_ACCESS_KEY_ID = "AKIAJKP5TCR5AML423FQ";

    /*
     * Your AWS Secret Key corresponding to the above ID, as taken from the AWS
     * Your Account page.
     */
    private static final String AWS_SECRET_KEY = "7mjPUr7RCeximWgcyrTaJgYK6AwVf5mJXOHNF/ne";

    /*
     * Use the end-point according to the region you are interested in.
     */
    private static final String ENDPOINT = "webservices.amazon.co.jp";

//    public static void main(String[] args) {
//
//        /*
//         * Set up the signed requests helper.
//         */
//        SignedRequestsHelper helper;
//
//        try {
//            helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return;
//        }
//
//        String requestUrl = null;
//
//        Map<String, String> params = new HashMap<String, String>();
//
//        params.put("Service", "AWSECommerceService");
//        params.put("Operation", "ItemLookup");
//        params.put("AWSAccessKeyId", "AKIAJKP5TCR5AML423FQ");
//        params.put("AssociateTag", "guen-22");
//        params.put("ItemId", "B00C9442AY");
//        params.put("IdType", "ASIN");
//        params.put("ResponseGroup", "Images,ItemAttributes,Offers,Small");
//
//        requestUrl = helper.sign(params);
//        Document doc;
//        AmazonSearchResult result = new AmazonSearchResult();
//        try {
//            result = processAmazonSearchASINResult(requestUrl);
//        } catch (Exception e) {
//            e.printStackTrace();
//            doc = new Document("");
//            result = new AmazonSearchResult();
//        }
//        result.getLstProductSearch();
//    }

    @RequestMapping(value = "/searchAsin/{asinCode}", method = RequestMethod.GET)
    @ResponseBody
    public AmazonSearchResult searchAsin(@PathVariable("asinCode") String asinCode) {
        SignedRequestsHelper helper;
        AmazonSearchResult result;
        try {
            helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);
            String requestUrl = null;
            Map<String, String> params = new HashMap<String, String>();

            params.put("Service", "AWSECommerceService");
            params.put("Operation", "ItemLookup");
            params.put("AWSAccessKeyId", "AKIAJKP5TCR5AML423FQ");
            params.put("AssociateTag", "guen-22");
            params.put("ItemId", asinCode);
            params.put("IdType", "ASIN");
            params.put("ResponseGroup", "Images,ItemAttributes,Offers,Small");

            requestUrl = helper.sign(params);

            if (requestUrl != null)
                result = processAmazonSearchASINResult(requestUrl);
            else
                result = null;
        } catch (Exception e) {
            logger.info("ERROR : " + e.getMessage());
            result = null;
        }
        return result;
    }

    private AmazonSearchResult processAmazonSearchASINResult(String requestUrl) {
        AmazonSearchResult amzSearchResult = new AmazonSearchResult();
        List<AmazonProductSearch> lstAmazSearch = new ArrayList<>();
        try {
            String response = CommonUtils.getHTMLContent(requestUrl, Tuple.make("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"),
                    Tuple.make("Accept-Encoding", "gzip, deflate, sdch"),
                    Tuple.make("Accept-Language", "vi-VN,vi;q=0.8,fr-FR;q=0.6,fr;q=0.4,en-US;q=0.2,en;q=0.2,ro;q=0.2,und;q=0.2"),
                    Tuple.make("Accept-Charset", "UTF-8"),
                    Tuple.make("Cookie", "ubid-acbjp=352-2065366-8993931; session-token=\"fZXdjEjgK8uR6fth39+5xc65xw00eK1S/VV1L0uwCVjJGSdDS17l+BV6codbMvHFs8mCC8yVKJ5LmIcIXi54AbFNeVm/J8i+ky/BfjqDmWSYVcYb5PjuJNAtpZZiqnhkuSkldVUyECMclcveQ6J/0XClOFlkAYu0RldNopA/HVG0+InHQYFgfayFjOGTDXPdYm75xpRZBxk7vbjdgU0dhqV3uYWkCXDRRukKp+4Yl+8=\"; x-acbjp=\"N82igyz2nuVH@XNt@cQkpObsv3dZQOa@9ss7pdR5xKsnhx?8WRGYSU5BYbznHlY@\"; session-id=353-9960805-6338904; session-id-time=2082758400; ubid-tacbjp=353-1361336-5340853"),
                    Tuple.make("Cache-Control", "max-age=0"));
            Document htmlDocument = Jsoup.parse(response, "", Parser.htmlParser());
            Elements itemsElement = htmlDocument.select("ItemLookupResponse>Items>Item");
            Iterator<Element> itemsIterator = itemsElement.iterator();
            String imageURL = "N/A";
            String title = "N/A";
            String stock = "N/A";
            String price = "N/A";
            String asinCode = "N/A";
            String detailURLPage = "N/A";
            int index = 0;
            while (itemsIterator.hasNext()) {
                Element item = itemsIterator.next();
                if (item.select("ASIN") != null)
                    asinCode = item.select("ASIN").first().text();
                if (item.select("DetailPageURL") != null)
                    detailURLPage = item.select("DetailPageURL").text();
                Elements images = item.select("SmallImage>URL");
                if (images != null)
                    imageURL = images.first().text();
                Elements titleElements = item.select("ItemAttributes>Title");
                if (titleElements != null)
                    title = titleElements.first().text();
                Elements elementsStock = item.select("Offers>Offer>OfferListing>Availability");
                if (elementsStock != null)
                    stock = elementsStock.first().text();
                Elements elementsPrice = item.select("Offers>Offer>OfferListing>Price>FormattedPrice");
                if (elementsPrice != null) {
                    price = elementsPrice.first().text();
                }
                //set result to object
                AmazonProductSearch searchResult = new AmazonProductSearch();
                searchResult.setName(title);
                searchResult.setPrice(price);
                searchResult.setLink(detailURLPage);
                searchResult.setImageUrl(imageURL);
                searchResult.setSin(asinCode);
                searchResult.setIndex(index);
                searchResult.setStock(stock);
                lstAmazSearch.add(searchResult);
                index++;
            }
            amzSearchResult.setLstProductSearch(lstAmazSearch);

        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
        }
        logger.info("=======list result: " + lstAmazSearch.size());
        return amzSearchResult;
    }

    @RequestMapping(value = "/searchAsinRelate/{asinCode}", method = RequestMethod.GET)
    @ResponseBody
    public AmazonSearchResult searchASINRelate(@PathVariable("asinCode") String asinCode) {
        SignedRequestsHelper helper;
        AmazonSearchResult result;
        try {
            helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);
            String requestUrl = null;
            Map<String, String> params = new HashMap<>();
            params.put("Service", "AWSECommerceService");
            params.put("Operation", "SimilarityLookup");
            params.put("AWSAccessKeyId", "AKIAJKP5TCR5AML423FQ");
            params.put("AssociateTag", "");
            params.put("ItemId", asinCode);
            params.put("MerchantId", "Amazon");
            params.put("ResponseGroup", "Images,Small");
            requestUrl = helper.sign(params);
            if (requestUrl != null)
                result = processAmazonSearchASINRelateResult(requestUrl);
            else
                result = null;
        } catch (Exception e) {
            logger.info("ERROR : " + e.getMessage());
            result = null;
        }
        return result;
    }


    private AmazonSearchResult processAmazonSearchASINRelateResult(String amazonSearchURL) throws IOException {

        AmazonSearchResult amzSearchResult = new AmazonSearchResult();
        List<AmazonProductSearch> lstAmazSearch = new ArrayList<>();
        try {
            String response = CommonUtils.getHTMLContent(amazonSearchURL, Tuple.make("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"),
                    Tuple.make("Accept-Encoding", "gzip, deflate, sdch"),
                    Tuple.make("Accept-Language", "vi-VN,vi;q=0.8,fr-FR;q=0.6,fr;q=0.4,en-US;q=0.2,en;q=0.2,ro;q=0.2,und;q=0.2"),
                    Tuple.make("Accept-Charset", "UTF-8"),
                    Tuple.make("Cookie", "ubid-acbjp=352-2065366-8993931; session-token=\"fZXdjEjgK8uR6fth39+5xc65xw00eK1S/VV1L0uwCVjJGSdDS17l+BV6codbMvHFs8mCC8yVKJ5LmIcIXi54AbFNeVm/J8i+ky/BfjqDmWSYVcYb5PjuJNAtpZZiqnhkuSkldVUyECMclcveQ6J/0XClOFlkAYu0RldNopA/HVG0+InHQYFgfayFjOGTDXPdYm75xpRZBxk7vbjdgU0dhqV3uYWkCXDRRukKp+4Yl+8=\"; x-acbjp=\"N82igyz2nuVH@XNt@cQkpObsv3dZQOa@9ss7pdR5xKsnhx?8WRGYSU5BYbznHlY@\"; session-id=353-9960805-6338904; session-id-time=2082758400; ubid-tacbjp=353-1361336-5340853"),
                    Tuple.make("Cache-Control", "max-age=0"));
            Document htmlDocument = Jsoup.parse(response, "", Parser.htmlParser());
            Elements itemsElement = htmlDocument.select("SimilarityLookupResponse>Items>Item");
            Iterator<Element> itemsIterator = itemsElement.iterator();
            int index = 0;
            while (itemsIterator.hasNext()) {
                Element item = itemsIterator.next();
                String asinCode = item.select("ASIN").first().text();
                String detailURLPage = item.select("DetailPageURL").text();
                Elements images = item.select("SmallImage>URL");
                String imageURL = images.first().text();
                Document detailProduct = Jsoup.connect(detailURLPage).userAgent("Mozilla/17.0").timeout(30000).get();
                Element elementPrice = detailProduct.getElementById("priceblock_ourprice");
                String price = "N/A";
                String stockText = "N/A";
                if (elementPrice == null) {
                    Elements bookPrice = detailProduct.select(".a-link-normal.rbbHeaderLink > div.a-section > div.a-row > .inlineBlock-display > span.a-color-base.offer-price.a-text-normal");
                    price = (bookPrice == null || bookPrice.isEmpty()) ? "N/A" : bookPrice.first().text();
                } else {
                    price = elementPrice.text();
                }

                Element stock = detailProduct.getElementById("availability");
                if (stock != null)
                    stockText = stock.getElementsByClass("availabilityHelpLink") == null ? "N/A" : stock.getElementsByClass("availabilityHelpLink").text();
                Element itemAttribute = item.select("ItemAttributes").first();
                String titleName = itemAttribute.select("Title") == null ? "N/A" : itemAttribute.select("Title").first().text();
                //set info to result
                AmazonProductSearch searchResult = new AmazonProductSearch();
                searchResult.setName(titleName);
                searchResult.setPrice(price);
                searchResult.setLink(detailURLPage);
                searchResult.setImageUrl(imageURL);
                searchResult.setSin(asinCode);
                searchResult.setIndex(index);
                searchResult.setStock(stockText);
                lstAmazSearch.add(searchResult);
                index++;
            }
            amzSearchResult.setLstProductSearch(lstAmazSearch);
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
        }
        logger.info("=======list result: " + lstAmazSearch.size());
        return amzSearchResult;
    }
}
