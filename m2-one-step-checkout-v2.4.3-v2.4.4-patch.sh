diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index 6aeaede..c0920d8 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -210,12 +210,6 @@ class LayoutProcessor implements LayoutProcessorInterface
             $fields
         );
 
-        foreach ($fields as $code => &$field) {
-            if(isset($field['label'])) {
-                $field['label'] = __($field['label']);
-            }
-        }
-
         return $this;
     }
 
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index 6bfb8cc..8475e59 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -73,18 +73,21 @@ class Index extends Onepage
     public function initDefaultMethods($quote)
     {
         $shippingAddress = $quote->getShippingAddress();
-
-        $defaultCountryId = $this->getDefaultCountryFromLocale();
         if (!$shippingAddress->getCountryId()) {
-            /** Get default country id from Geo Ip or Locale */
-            $geoIpData = $this->_checkoutHelper->getAddressHelper()->getGeoIpData();
-            if (!empty($geoIpData)) {
-                $defaultCountryId = $geoIpData['country_id'];
-            } elseif (!empty($this->_checkoutHelper->getDefaultCountryId())) {
+            if (!empty($this->_checkoutHelper->getDefaultCountryId())) {
                 $defaultCountryId = $this->_checkoutHelper->getDefaultCountryId();
+            } else {
+                /** Get default country id from Geo Ip or Locale */
+                $geoIpData = $this->_checkoutHelper->getAddressHelper()->getGeoIpData();
+                if (empty($geoIpData)) {
+                    $defaultCountryId = $geoIpData['country_id'];
+                } else {
+                    $defaultCountryId = $this->getDefaultCountryFromLocale();
+                }
             }
             $shippingAddress->setCountryId($defaultCountryId)->setCollectShippingRates(true);
         }
+
         $method = null;
 
         try {
diff --git a/Helper/Address.php b/Helper/Address.php
index 542c13f..4482bce 100644
--- a/Helper/Address.php
+++ b/Helper/Address.php
@@ -303,14 +303,10 @@ class Address extends Data
                         $geoIpData['region'] = $record->mostSpecificSubdivision->name;
                     }
                 }
-                $allowedCountries = $this->getConfigValue('general/country/allow');
-                $allowedCountries = explode(',',$allowedCountries);
-                if(!in_array($geoIpData['country_id'], $allowedCountries)){
-                    $geoIpData = [];
-                }
             } catch (\Exception $e) {
                 $geoIpData = [];
             }
+
             return $geoIpData;
         }
 
diff --git a/Model/Plugin/Customer/AccountManagement.php b/Model/Plugin/Customer/AccountManagement.php
deleted file mode 100644
index 1656828..0000000
--- a/Model/Plugin/Customer/AccountManagement.php
+++ /dev/null
@@ -1,63 +0,0 @@
-<?php
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model\Plugin\Customer;
-
-use Magento\Checkout\Model\Session;
-use Magento\Customer\Api\Data\CustomerInterface;
-use Magento\Customer\Model\AccountManagement as AM;
-
-/**
- * Class Address
- * @package Mageplaza\Osc\Model\Plugin\Customer
- */
-class AccountManagement
-{
-    /**
-     * @var Session
-     */
-    protected $checkoutSession;
-
-    /**
-     * AccountManagement constructor.
-     * @param Session $checkoutSession
-     */
-    public function __construct(Session $checkoutSession)
-    {
-        $this->checkoutSession = $checkoutSession;
-    }
-
-    /**
-     * @param AM $subject
-     * @param mixed $password
-     * @param mixed $redirectUrl
-     * @return mixed
-     */
-    public function beforeCreateAccount(AM $subject, CustomerInterface $customer, $password = null, $redirectUrl = '')
-    {
-        $oscData = $this->checkoutSession->getOscData();
-        if (isset($oscData['register']) && $oscData['register'] && isset($oscData['password']) && $oscData['password']) {
-            $password = $oscData['password'];
-
-            return [$customer, $password, $redirectUrl];
-        }
-    }
-}
diff --git a/Observer/QuoteSubmitSuccess.php b/Observer/QuoteSubmitSuccess.php
index bb832f5..82b7ad5 100644
--- a/Observer/QuoteSubmitSuccess.php
+++ b/Observer/QuoteSubmitSuccess.php
@@ -33,7 +33,6 @@ use Magento\Framework\Message\ManagerInterface;
 use Magento\Framework\Stdlib\Cookie\CookieMetadataFactory;
 use Magento\Framework\Stdlib\Cookie\PhpCookieManager;
 use Magento\Newsletter\Model\SubscriberFactory;
-use Magento\Sales\Model\Order\CustomerManagement;
 
 /**
  * Class QuoteSubmitSuccess
@@ -72,18 +71,12 @@ class QuoteSubmitSuccess implements ObserverInterface
     protected $subscriberFactory;
 
     /**
-     * @type CustomerManagement
-     */
-    protected $customerManagement;
-
-    /**
      * @param \Magento\Checkout\Model\Session $checkoutSession
      * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
      * @param \Magento\Customer\Model\Url $customerUrl
      * @param \Magento\Framework\Message\ManagerInterface $messageManager
      * @param \Magento\Customer\Model\Session $customerSession
      * @param \Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
-     * @param CustomerManagement $subscriberFactory
      */
     public function __construct(
         Session $checkoutSession,
@@ -91,8 +84,7 @@ class QuoteSubmitSuccess implements ObserverInterface
         Url $customerUrl,
         ManagerInterface $messageManager,
         CustomerSession $customerSession,
-        SubscriberFactory $subscriberFactory,
-        CustomerManagement $customerManagement
+        SubscriberFactory $subscriberFactory
     )
     {
         $this->checkoutSession = $checkoutSession;
@@ -101,7 +93,6 @@ class QuoteSubmitSuccess implements ObserverInterface
         $this->messageManager = $messageManager;
         $this->_customerSession = $customerSession;
         $this->subscriberFactory = $subscriberFactory;
-        $this->customerManagement = $customerManagement;
     }
 
     /**
@@ -112,13 +103,12 @@ class QuoteSubmitSuccess implements ObserverInterface
     {
         /** @type \Magento\Quote\Model\Quote $quote $quote */
         $quote = $observer->getEvent()->getQuote();
-        $order = $observer->getEvent()->getOrder();
 
         $oscData = $this->checkoutSession->getOscData();
         if (isset($oscData['register']) && $oscData['register']
             && isset($oscData['password']) && $oscData['password']
         ) {
-           $customer = $this->customerManagement->create($order->getId());
+            $customer = $quote->getCustomer();
 
             /* Set customer Id for address */
             if ($customer->getId()) {
diff --git a/composer.json b/composer.json
index 963abf3..75e85d4 100644
--- a/composer.json
+++ b/composer.json
@@ -6,7 +6,7 @@
     "geoip2/geoip2": "~2.0"
   },
   "type": "magento2-module",
-  "version": "2.4.4",
+  "version": "2.4.3",
   "license": "proprietary",
   "authors": [
     {
diff --git a/etc/di.xml b/etc/di.xml
index 49e5f0e..ac66390 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -31,10 +31,7 @@
     <type name="Magento\Quote\Model\Cart\TotalsConverter">
         <plugin name="addGiftWrapInitialAmount" type="Mageplaza\Osc\Model\Plugin\Quote\GiftWrap"/>
     </type>
-   <!--  <type name="Magento\Quote\Model\QuoteManagement">
+    <type name="Magento\Quote\Model\QuoteManagement">
         <plugin name="mz_osc_quotemanagement" type="Mageplaza\Osc\Model\Plugin\Quote\QuoteManagement"/>
-    </type> -->
-    <type name="Magento\Customer\Model\AccountManagement">
-        <plugin name="mz_osc_newaccount" type="Mageplaza\Osc\Model\Plugin\Customer\AccountManagement"/>
     </type>
 </config>
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index b72c67f..4ac876e 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -268,25 +268,6 @@ define(
                     this.source.trigger('billingAddress.custom_attributes.data.validate');
                 }
 
-                if (this.source.get('params.invalid')) {
-                    var offsetHeight = $(window).height()/2,
-                        errorMsgSelector = $('#billing-new-address-form .mage-error:first').closest('.field');
-
-                    if (errorMsgSelector.length) {
-                        if (errorMsgSelector.find('select').length) {
-                            $('html, body').scrollTop(
-                                errorMsgSelector.find('select').offset().top - offsetHeight
-                            );
-                            errorMsgSelector.find('select').focus();
-                        } else if (errorMsgSelector.find('input').length) {
-                            $('html, body').scrollTop(
-                                errorMsgSelector.find('input').offset().top - offsetHeight
-                            );
-                            errorMsgSelector.find('input').focus();
-                        }
-                    }
-                }
-
                 oscData.setData('same_as_shipping', false);
                 return !this.source.get('params.invalid');
             },
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index 1c8dba3..13489f7 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -147,10 +147,6 @@ define([
             if (result) {
                 oscData.setData('register', true);
                 oscData.setData('password', passwordSelector.val());
-            } else if (!password) {
-                $('#osc-password').focus();
-            } else if (!confirm) {
-                $('#osc-password-confirmation').focus();
             }
 
             return result;
diff --git a/view/frontend/web/js/view/payment.js b/view/frontend/web/js/view/payment.js
index b6c1705..a264862 100644
--- a/view/frontend/web/js/view/payment.js
+++ b/view/frontend/web/js/view/payment.js
@@ -21,7 +21,6 @@
 define(
     [
         'ko',
-        'jquery',
         'Magento_Checkout/js/view/payment',
         'Magento_Checkout/js/model/quote',
         'Magento_Checkout/js/model/step-navigator',
@@ -31,7 +30,6 @@ define(
         'mage/translate'
     ],
     function (ko,
-              $,
               Component,
               quote,
               stepNavigator,
@@ -69,10 +67,6 @@ define(
                 if (!quote.paymentMethod()) {
                     this.errorValidationMessage($.mage.__('Please specify a payment method.'));
 
-                    $('html, body').scrollTop(
-                        $('#checkout-step-payment').offset().top - $(window).height()/2
-                    );
-
                     return false;
                 }
 
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index b085358..c9a5d25 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -161,32 +161,8 @@ define(
                     this.saveShippingAddress();
                 }
 
-                var offsetHeight = $(window).height()/2;
                 if (!emailValidationResult) {
                     $(loginFormSelector + ' input[name=username]').focus();
-                } else if (!shippingAddressValidationResult) {
-                    var errorMsgSelector = $('#co-shipping-form .mage-error:first').closest('.field');
-                    if (errorMsgSelector.length) {
-                        if (errorMsgSelector.find('select').length) {
-                            $('html, body').scrollTop(
-                                errorMsgSelector.find('select').offset().top - offsetHeight
-                            );
-                            errorMsgSelector.find('select').focus();
-                        } else if (errorMsgSelector.find('input').length) {
-                            $('html, body').scrollTop(
-                                errorMsgSelector.find('input').offset().top - offsetHeight
-                            );
-                            errorMsgSelector.find('input').focus();
-                        }
-                    }
-                } else if (!shippingMethodValidationResult) {
-                    if ($('._warn[name="shippingAddress.postcode"]').length) {
-                        $('._warn[name="shippingAddress.postcode"]').find('input').focus();
-                    } else {
-                        $('html, body').scrollTop(
-                            $('#opc-shipping_method').offset().top - offsetHeight/3
-                        );
-                    }
                 }
 
                 return shippingMethodValidationResult && shippingAddressValidationResult && emailValidationResult;
