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
        AmazonSearchResult result;
        String requestUrl = null;
        try {
            Map<String, String> params = new HashMap<String, String>();
            params.put("Service", "AWSECommerceService");
            params.put("Operation", "ItemLookup");
            params.put("AWSAccessKeyId", "AKIAJKP5TCR5AML423FQ");
            params.put("AssociateTag", "guen-22");
            params.put("ItemId", asinCode);
            params.put("IdType", "ASIN");
            params.put("ResponseGroup", "Images,ItemAttributes,Offers,Small");
            requestUrl = new APISearchUtils.Builder().mapConfig(params).getRequestURL();
            if (requestUrl != null)
                result = APISearchUtils.processAmazonSearchASINResult(requestUrl);
            else
                result = null;
        } catch (Exception e) {
            logger.info("ERROR : " + e.getMessage());
            result = null;
        }
        return result;
    }



    @RequestMapping(value = "/searchAsinRelate/{asinCode}", method = RequestMethod.GET)
    @ResponseBody
    public AmazonSearchResult searchASINRelate(@PathVariable("asinCode") String asinCode) {
        AmazonSearchResult result;
        try {
            String requestUrl;
            Map<String, String> params = new HashMap<>();
            params.put("Service", "AWSECommerceService");
            params.put("Operation", "SimilarityLookup");
            params.put("AWSAccessKeyId", "AKIAJKP5TCR5AML423FQ");
            params.put("AssociateTag", "");
            params.put("ItemId", asinCode);
            params.put("MerchantId", "Amazon");
            params.put("ResponseGroup", "Images,Small");
            requestUrl = new APISearchUtils.Builder().mapConfig(params).getRequestURL();
            if (requestUrl != null)
                result = APISearchUtils.processAmazonSearchASINRelateResult(requestUrl);
            else
                result = null;
        } catch (Exception e) {
            logger.info("ERROR : " + e.getMessage());
            result = null;
        }
        return result;
    }

}
