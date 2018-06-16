diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index 56de2d9..332a940 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -56,8 +56,7 @@ class Index extends \Magento\Checkout\Controller\Onepage
 		$this->initDefaultMethods($quote);
 
 		$resultPage = $this->resultPageFactory->create();
-		$checkoutTitle = $this->_checkoutHelper->getConfig()->getCheckoutTitle();
-		$resultPage->getConfig()->getTitle()->set($checkoutTitle);
+		$resultPage->getConfig()->getTitle()->set($this->_checkoutHelper->getConfig()->getCheckoutTitle());
 
 		return $resultPage;
 	}
diff --git a/Helper/Config.php b/Helper/Config.php
index 0f92d0f..efce766 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -18,7 +18,6 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Helper;
 
 use Magento\Customer\Helper\Address;
@@ -37,43 +36,46 @@ use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
  */
 class Config extends AbstractData
 {
-	/** Is enable module path */
+	/**
+	 * Is enable module path
+	 */
 	const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
 
-	/** Field position */
+	/**
+	 * Field position
+	 */
 	const SORTED_FIELD_POSITION = 'osc/field/position';
 
-	/** General configuration path */
+	/**
+	 * General configuaration path
+	 */
 	const GENERAL_CONFIGUARATION = 'osc/general';
 
-	/** Display configuration path */
+	/**
+	 * Display configuaration path
+	 */
 	const DISPLAY_CONFIGUARATION = 'osc/display_configuration';
 
-	/** Design configuration path */
+	/**
+	 * Design configuaration path
+	 */
 	const DESIGN_CONFIGUARATION = 'osc/design_configuration';
 
-	/** @var \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory */
+	/**
+	 * @var \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory
+	 */
 	protected $_addressesFactory;
 
-	/** @var \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory */
+	/**
+	 * @var \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory
+	 */
 	protected $_customerFactory;
 
-	/** @var \Magento\Customer\Helper\Address */
-	protected $addressHelper;
-
-	/** @var \Magento\Customer\Model\AttributeMetadataDataProvider */
-	private $attributeMetadataDataProvider;
-
 	/**
-	 * Config constructor.
-	 * @param \Magento\Framework\App\Helper\Context $context
-	 * @param \Magento\Framework\ObjectManagerInterface $objectManager
-	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-	 * @param \Magento\Customer\Helper\Address $addressHelper
-	 * @param \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory $addressesFactory
-	 * @param \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory $customerFactory
-	 * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+	 * @var \Magento\Customer\Model\AttributeMetadataDataProvider
 	 */
+	private $attributeMetadataDataProvider;
+
 	public function __construct(
 		Context $context,
 		ObjectManagerInterface $objectManager,
@@ -93,6 +95,19 @@ class Config extends AbstractData
 	}
 
 	/**
+	 * Is enable module on frontend
+	 *
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isEnabled($store = null)
+	{
+		$isModuleOutputEnabled = $this->isModuleOutputEnabled();
+
+		return $isModuleOutputEnabled && $this->getConfigValue(self::GENERAL_IS_ENABLED, $store);
+	}
+
+	/**
 	 * Check the current page is osc
 	 *
 	 * @param null $store
@@ -106,17 +121,20 @@ class Config extends AbstractData
 		return $moduleEnable && $isOscModule;
 	}
 
-	/**
-	 * Is enable module on frontend
-	 *
-	 * @param null $store
-	 * @return bool
+	/************************ Field Position *************************
+	 * @return array|mixed
 	 */
-	public function isEnabled($store = null)
+	public function getFieldPosition()
 	{
-		$isModuleOutputEnabled = $this->isModuleOutputEnabled();
+		$fields = $this->getConfigValue(self::SORTED_FIELD_POSITION);
 
-		return $isModuleOutputEnabled && $this->getConfigValue(self::GENERAL_IS_ENABLED, $store);
+		try {
+			$result = \Zend_Json::decode($fields);
+		} catch (\Exception $e) {
+			$result = [];
+		}
+
+		return $result;
 	}
 
 	/**
@@ -196,6 +214,22 @@ class Config extends AbstractData
 	}
 
 	/**
+	 * @param $colSpan
+	 * @param $isNewRow
+	 * @return $this
+	 */
+	private function checkNewRow($colSpan, &$isNewRow)
+	{
+		if ($colSpan == 6 && $isNewRow) {
+			$isNewRow = false;
+		} else if ($colSpan == 12 || ($colSpan == 6 && !$isNewRow)) {
+			$isNewRow = true;
+		}
+
+		return $this;
+	}
+
+	/**
 	 * Check if address attribute can be visible on frontend
 	 *
 	 * @param $attribute
@@ -235,36 +269,17 @@ class Config extends AbstractData
 		return true;
 	}
 
-	/************************ Field Position *************************
-	 * @return array|mixed
-	 */
-	public function getFieldPosition()
-	{
-		$fields = $this->getConfigValue(self::SORTED_FIELD_POSITION);
-
-		try {
-			$result = \Zend_Json::decode($fields);
-		} catch (\Exception $e) {
-			$result = [];
-		}
-
-		return $result;
-	}
-
-	/**
-	 * @param $colSpan
-	 * @param $isNewRow
-	 * @return $this
+	/************************ General Configuration *************************
+	 *
+	 * @param      $code
+	 * @param null $store
+	 * @return mixed
 	 */
-	private function checkNewRow($colSpan, &$isNewRow)
+	public function getGeneralConfig($code = '', $store = null)
 	{
-		if ($colSpan == 6 && $isNewRow) {
-			$isNewRow = false;
-		} else if ($colSpan == 12 || ($colSpan == 6 && !$isNewRow)) {
-			$isNewRow = true;
-		}
+		$code = $code ? self::GENERAL_CONFIGUARATION . '/' . $code : self::GENERAL_CONFIGUARATION;
 
-		return $this;
+		return $this->getConfigValue($code, $store);
 	}
 
 	/**
@@ -275,20 +290,7 @@ class Config extends AbstractData
 	 */
 	public function getCheckoutTitle($store = null)
 	{
-		return $this->getGeneralConfig('title', $store) ?: 'One Step Checkout';
-	}
-
-	/************************ General Configuration *************************
-	 *
-	 * @param      $code
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getGeneralConfig($code = '', $store = null)
-	{
-		$code = $code ? self::GENERAL_CONFIGUARATION . '/' . $code : self::GENERAL_CONFIGUARATION;
-
-		return $this->getConfigValue($code, $store);
+		return $this->getGeneralConfig('title', $store);
 	}
 
 	/**
@@ -311,6 +313,7 @@ class Config extends AbstractData
 	public function getDefaultCountryId($store = null)
 	{
 		return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
+//		return $this->getConfigValue('general/country/default', $store);
 	}
 
 	/**
@@ -350,8 +353,7 @@ class Config extends AbstractData
 			\Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver::XML_PATH_DISABLE_GUEST_CHECKOUT,
 			\Magento\Store\Model\ScopeInterface::SCOPE_STORE,
 			$store
-		)
-		) {
+		)) {
 			foreach ($quote->getAllItems() as $item) {
 				if (($product = $item->getProduct())
 					&& $product->getTypeId() == \Magento\Downloadable\Model\Product\Type::TYPE_DOWNLOADABLE
@@ -376,6 +378,16 @@ class Config extends AbstractData
 	}
 
 	/**
+	 * Get auto detected address
+	 * @param null $store
+	 * @return null|'google'|'pca'
+	 */
+	public function getAutoDetectedAddress($store = null)
+	{
+		return $this->getGeneralConfig('auto_detect_address', $store);
+	}
+
+	/**
 	 * Google api key
 	 *
 	 * @param null $store
@@ -409,14 +421,17 @@ class Config extends AbstractData
 		return $isEnable && $this->_request->isSecure();
 	}
 
-	/**
-	 * Get auto detected address
+	/********************************** Display Configuration *********************
+	 *
+	 * @param $code
 	 * @param null $store
-	 * @return null|'google'|'pca'
+	 * @return mixed
 	 */
-	public function getAutoDetectedAddress($store = null)
+	public function getDisplayConfig($code = '', $store = null)
 	{
-		return $this->getGeneralConfig('auto_detect_address', $store);
+		$code = $code ? self::DISPLAY_CONFIGUARATION . '/' . $code : self::DISPLAY_CONFIGUARATION;
+
+		return $this->getConfigValue($code, $store);
 	}
 
 	/**
@@ -430,19 +445,6 @@ class Config extends AbstractData
 		return !$this->getDisplayConfig('is_enabled_login_link', $store);
 	}
 
-	/********************************** Display Configuration *********************
-	 *
-	 * @param $code
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getDisplayConfig($code = '', $store = null)
-	{
-		$code = $code ? self::DISPLAY_CONFIGUARATION . '/' . $code : self::DISPLAY_CONFIGUARATION;
-
-		return $this->getConfigValue($code, $store);
-	}
-
 	/**
 	 * Item detail will be hided if this function return 'true'
 	 *
@@ -546,6 +548,17 @@ class Config extends AbstractData
 	}
 
 	/**
+	 * Gift wrap type
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getGiftWrapType($store = null)
+	{
+		return $this->getDisplayConfig('gift_wrap_type', $store);
+	}
+
+	/**
 	 * Gift wrap amount
 	 *
 	 * @param null $store
@@ -568,17 +581,6 @@ class Config extends AbstractData
 	}
 
 	/**
-	 * Gift wrap type
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getGiftWrapType($store = null)
-	{
-		return $this->getDisplayConfig('gift_wrap_type', $store);
-	}
-
-	/**
 	 * @return mixed
 	 */
 	public function formatGiftWrapAmount()
@@ -608,7 +610,7 @@ class Config extends AbstractData
 	 */
 	public function isSubscribedByDefault($store = null)
 	{
-		return (bool)$this->getDisplayConfig('is_checked_newsletter', $store);
+		return $this->getDisplayConfig('is_checked_newsletter', $store);
 	}
 
 	/**
@@ -642,7 +644,7 @@ class Config extends AbstractData
 	{
 		$deliveryTimeFormat = $this->getDisplayConfig('delivery_time_format', $store);
 
-		return $deliveryTimeFormat ?: \Mageplaza\Osc\Model\System\Config\Source\DeliveryTime::DAY_MONTH_YEAR;
+		return !empty($deliveryTimeFormat) ? $deliveryTimeFormat : 'dd/mm/yy';
 	}
 
 	/**
@@ -652,18 +654,9 @@ class Config extends AbstractData
 	 */
 	public function getDeliveryTimeOff($store = null)
 	{
-		return $this->getDisplayConfig('delivery_time_off', $store);
-	}
+		$deliveryTimeOff = $this->getDisplayConfig('delivery_time_off', $store);
 
-	/**
-	 * Get layout tempate: 1 or 2 or 3 columns
-	 *
-	 * @param null $store
-	 * @return string
-	 */
-	public function getLayoutTemplate($store = null)
-	{
-		return 'Mageplaza_Osc/' . $this->getDesignConfig('page_layout', $store);
+		return !empty($deliveryTimeOff) ? $deliveryTimeOff : false;
 	}
 
 	/***************************** Design Configuration *****************************
@@ -677,4 +670,15 @@ class Config extends AbstractData
 
 		return $this->getConfigValue($code, $store);
 	}
+
+	/**
+	 * Get layout tempate: 1 or 2 or 3 columns
+	 *
+	 * @param null $store
+	 * @return string
+	 */
+	public function getLayoutTemplate($store = null)
+	{
+		return 'Mageplaza_Osc/' . $this->getDesignConfig('page_layout', $store);
+	}
 }
diff --git a/Observer/IsAllowedGuestCheckoutObserver.php b/Observer/IsAllowedGuestCheckoutObserver.php
deleted file mode 100644
index 4d93645..0000000
--- a/Observer/IsAllowedGuestCheckoutObserver.php
+++ /dev/null
@@ -1,55 +0,0 @@
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-namespace Mageplaza\Osc\Observer;
-
-use Magento\Framework\Event\ObserverInterface;
-
-/**
- * Class CheckoutSubmitBefore
- * @package Mageplaza\Osc\Observer
- */
-class IsAllowedGuestCheckoutObserver extends \Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver implements ObserverInterface
-{
-	protected $_helper;
-
-	public function __construct(
-		\Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
-		\Mageplaza\Osc\Helper\Data $helper
-	)
-	{
-		$this->_helper = $helper;
-
-		parent::__construct($scopeConfig);
-	}
-
-	/**
-	 * @param \Magento\Framework\Event\Observer $observer
-	 * @return $this
-	 */
-	public function execute(\Magento\Framework\Event\Observer $observer)
-	{
-		if ($this->_helper->isEnabled()) {
-			return $this;
-		}
-
-		return parent::execute($observer);
-	}
-}
diff --git a/composer.json b/composer.json
index dfc24c8..33967c5 100644
--- a/composer.json
+++ b/composer.json
@@ -1,8 +1,8 @@
 {
-    "name": "mageplaza/magento-2-one-step-checkout-extension",
+    "name": "Mageplaza\/Osc",
     "description": "",
     "require": {
-        "mageplaza/core-m2": "^1.3|dev-master"
+        "php": "~5.5.0|~5.6.0"
     },
     "type": "magento2-module",
     "version": "2.0.0",
@@ -16,5 +16,13 @@
         "psr-4": {
             "Mageplaza\\Osc\\": ""
         }
+    },
+    "extra": {
+        "map": [
+            [
+                "*",
+                "Mageplaza\/Osc"
+            ]
+        ]
     }
 }
\ No newline at end of file
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 48a867a..48851ca 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -201,7 +201,6 @@
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Social Login On Checkout Page</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <if_module_enabled>Mageplaza_SocialLogin</if_module_enabled>
                     <comment>You should install &lt;a href="https://www.mageplaza.com/magento-2-social-login-extension"
                         target="_blank">Social Login by Mageplaza&lt;/a&gt;</comment>
                 </field>
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index 7403880..bf0e577 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -52,11 +52,4 @@
             </argument>
         </arguments>
     </type>
-    <type name="Magento\Customer\Block\SectionConfig">
-        <arguments>
-            <argument name="clientSideSections" xsi:type="array">
-                <item name="osc-data" xsi:type="string">osc-data</item>
-            </argument>
-        </arguments>
-    </type>
 </config>
\ No newline at end of file
diff --git a/etc/frontend/events.xml b/etc/frontend/events.xml
index 476ea14..fa6c909 100644
--- a/etc/frontend/events.xml
+++ b/etc/frontend/events.xml
@@ -22,6 +22,6 @@
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
     <event name="checkout_allow_guest">
-        <observer name="checkout_allow_guest" instance="Mageplaza\Osc\Observer\IsAllowedGuestCheckoutObserver" />
+        <observer name="checkout_allow_guest" disabled="true" />
     </event>
 </config>
diff --git a/etc/frontend/sections.xml b/etc/frontend/sections.xml
index 1d7c63c..a2f90f3 100644
--- a/etc/frontend/sections.xml
+++ b/etc/frontend/sections.xml
@@ -38,16 +38,4 @@
         <section name="cart"/>
         <section name="checkout-data"/>
     </action>
-    <action name="rest/*/V1/carts/*/payment-information">
-        <section name="osc-data"/>
-    </action>
-    <action name="rest/*/V1/guest-carts/*/payment-information">
-        <section name="osc-data"/>
-    </action>
-    <action name="rest/*/V1/guest-carts/*/selected-payment-method">
-        <section name="osc-data"/>
-    </action>
-    <action name="rest/*/V1/carts/*/selected-payment-method">
-        <section name="osc-data"/>
-    </action>
 </config>
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index 34a894c..3de639e 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -221,9 +221,7 @@
                                                         <item name="afterMethods" xsi:type="array">
                                                             <item name="children" xsi:type="array">
                                                                 <item name="discount" xsi:type="array">
-                                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/payment/discount</item>
                                                                     <item name="config" xsi:type="array">
-                                                                        <item name="template" xsi:type="string">Mageplaza_Osc/container/payment/discount</item>
                                                                         <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledPaymentCoupon" />
                                                                     </item>
                                                                 </item>
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index bab7807..7059e97 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -24,8 +24,7 @@ if (window.location.href.indexOf('onestepcheckout') !== -1) {
         map: {
             '*': {
                 'Magento_Checkout/js/model/shipping-rate-service': 'Mageplaza_Osc/js/model/shipping-rate-service',
-                'Magento_Checkout/js/model/shipping-rates-validator': 'Mageplaza_Osc/js/model/shipping-rates-validator',
-                'Magento_CheckoutAgreements/js/model/agreements-assigner': 'Mageplaza_Osc/js/model/agreements-assigner'
+                'Magento_Checkout/js/model/shipping-rates-validator': 'Mageplaza_Osc/js/model/shipping-rates-validator'
             },
             'Mageplaza_Osc/js/model/shipping-rates-validator': {
                 'Magento_Checkout/js/model/shipping-rates-validator': 'Magento_Checkout/js/model/shipping-rates-validator'
@@ -36,12 +35,6 @@ if (window.location.href.indexOf('onestepcheckout') !== -1) {
             'Magento_Checkout/js/action/set-billing-address': {
                 'Magento_Checkout/js/model/full-screen-loader': 'Mageplaza_Osc/js/model/osc-loader'
             },
-            'Magento_SalesRule/js/action/set-coupon-code': {
-                'Magento_Checkout/js/model/full-screen-loader': 'Mageplaza_Osc/js/model/osc-loader/discount'
-            },
-            'Magento_SalesRule/js/action/cancel-coupon': {
-                'Magento_Checkout/js/model/full-screen-loader': 'Mageplaza_Osc/js/model/osc-loader/discount'
-            },
             'Mageplaza_Osc/js/model/osc-loader': {
                 'Magento_Checkout/js/model/full-screen-loader': 'Magento_Checkout/js/model/full-screen-loader'
             }
diff --git a/view/frontend/web/js/model/agreements-assigner.js b/view/frontend/web/js/model/agreements-assigner.js
deleted file mode 100644
index 08bad7d..0000000
--- a/view/frontend/web/js/model/agreements-assigner.js
+++ /dev/null
@@ -1,39 +0,0 @@
-/**
- * Copyright © 2013-2017 Magento, Inc. All rights reserved.
- * See COPYING.txt for license details.
- */
-
-/*jshint browser:true jquery:true*/
-/*global alert*/
-define([
-    'jquery'
-], function ($) {
-    'use strict';
-
-    var agreementsConfig = window.checkoutConfig.checkoutAgreements;
-
-    /** Override default place order action and add agreement_ids to request */
-    return function (paymentData) {
-        var agreementForm,
-            agreementData,
-            agreementIds;
-
-        if (!agreementsConfig.isEnabled) {
-            return;
-        }
-
-        agreementForm = $('#co-place-order-agreement div[data-role=checkout-agreements] input');
-        agreementData = agreementForm.serializeArray();
-        agreementIds = [];
-
-        agreementData.forEach(function (item) {
-            agreementIds.push(item.value);
-        });
-
-        if (paymentData['extension_attributes'] === undefined) {
-            paymentData['extension_attributes'] = {};
-        }
-
-        paymentData['extension_attributes']['agreement_ids'] = agreementIds;
-    };
-});
diff --git a/view/frontend/web/js/model/osc-loader/discount.js b/view/frontend/web/js/model/osc-loader/discount.js
deleted file mode 100644
index 9e20337..0000000
--- a/view/frontend/web/js/model/osc-loader/discount.js
+++ /dev/null
@@ -1,46 +0,0 @@
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-define(
-    [
-        'ko'
-    ],
-    function (ko) {
-        'use strict';
-
-        return {
-            isLoading: ko.observable(false),
-
-            /**
-             * Start full page loader action
-             */
-            startLoader: function () {
-                this.isLoading(true);
-            },
-
-            /**
-             * Stop full page loader action
-             */
-            stopLoader: function () {
-                this.isLoading(false);
-            }
-        };
-    }
-);
diff --git a/view/frontend/web/js/view/delivery-time.js b/view/frontend/web/js/view/delivery-time.js
index 82a4a0b..e273bad 100644
--- a/view/frontend/web/js/view/delivery-time.js
+++ b/view/frontend/web/js/view/delivery-time.js
@@ -23,14 +23,14 @@ define(
         'jquery',
         'ko',
         'uiComponent',
-        'Mageplaza_Osc/js/model/osc-data',
-        'jquery/ui',
-        'jquery/jquery-ui-timepicker-addon'
+        'mage/calendar',
+        'Mageplaza_Osc/js/model/osc-data'
     ],
-    function ($, ko, Component, oscData) {
+    function ($, ko, Component, calendar, oscData) {
         'use strict';
-        var cacheKey = 'deliveryTime';
-
+        var cacheKey   = 'deliveryTime';
+        var dateFormat = window.checkoutConfig.oscConfig.deliveryTimeOptions.deliveryTimeFormat;
+        var daysOff    = window.checkoutConfig.oscConfig.deliveryTimeOptions.deliveryTimeOff;
         return Component.extend({
             defaults: {
                 template: 'Mageplaza_Osc/container/delivery-time'
@@ -40,21 +40,21 @@ define(
                 this._super();
                 ko.bindingHandlers.datepicker = {
                     init: function (element) {
-                        var dateFormat = window.checkoutConfig.oscConfig.deliveryTimeOptions.deliveryTimeFormat,
-                            daysOff = window.checkoutConfig.oscConfig.deliveryTimeOptions.deliveryTimeOff,
-                            options = {
-                                minDate: 0,
-                                showButtonPanel: false,
-                                dateFormat: dateFormat,
-                                showOn: 'both',
-                                buttonText: '',
-                                beforeShowDay: function (date) {
-                                    if (!daysOff)
-                                        return [true];
-
-                                    return [daysOff.indexOf(date.getDay()) === -1];
-                                }
-                            };
+                        var options = {
+                            minDate: 0,
+                            showButtonPanel: false,
+                            dateFormat: dateFormat,
+                            showOn: 'both',
+                            buttonText: '',
+                            beforeShowDay: function (date) {
+                                if(!daysOff) return [true];
+                                var daysOffToArray = daysOff.split(',');
+                                $(daysOffToArray).each(function (index) {
+                                    daysOffToArray[index] = parseInt(daysOffToArray[index]);
+                                });
+                                return daysOff.indexOf(date.getDay()) != -1 ? [false] : [true];
+                            }
+                        };
                         $(element).datetimepicker(options);
                     }
                 };
diff --git a/view/frontend/web/js/view/payment/discount.js b/view/frontend/web/js/view/payment/discount.js
index 7b095ba..764ca63 100644
--- a/view/frontend/web/js/view/payment/discount.js
+++ b/view/frontend/web/js/view/payment/discount.js
@@ -23,17 +23,15 @@
 define(
     [
         'ko',
-        'Magento_SalesRule/js/view/payment/discount',
-        'Mageplaza_Osc/js/model/osc-loader/discount'
+        'Magento_SalesRule/js/view/payment/discount'
     ],
-    function (ko, Component, discountLoader) {
+    function (ko, Component) {
         'use strict';
 
         return Component.extend({
             defaults: {
                 template: 'Mageplaza_Osc/container/review/discount'
-            },
-            isBlockLoading: discountLoader.isLoading
+            }
         });
     }
 );
diff --git a/view/frontend/web/js/view/review/addition/newsletter.js b/view/frontend/web/js/view/review/addition/newsletter.js
index 047c258..ef7bcd4 100644
--- a/view/frontend/web/js/view/review/addition/newsletter.js
+++ b/view/frontend/web/js/view/review/addition/newsletter.js
@@ -27,7 +27,12 @@ define(
     function (ko, Component, oscData) {
         "use strict";
 
-        var cacheKey = 'is_subscribed';
+        var cacheKey = 'is_subscribed',
+            checkedDefault = window.checkoutConfig.oscConfig.newsletterDefault;
+
+        if (checkedDefault && !oscData.getData(cacheKey)) {
+            oscData.setData(cacheKey, true);
+        }
 
         return Component.extend({
             defaults: {
@@ -36,7 +41,7 @@ define(
             initObservable: function () {
                 this._super()
                     .observe({
-                        isRegisterNewsletter: (typeof oscData.getData(cacheKey) === 'undefined') ? window.checkoutConfig.oscConfig.newsletterDefault : oscData.getData(cacheKey)
+                        isRegisterNewsletter: oscData.getData(cacheKey)
                     });
 
                 this.isRegisterNewsletter.subscribe(function (newValue) {
diff --git a/view/frontend/web/template/container/delivery-time.html b/view/frontend/web/template/container/delivery-time.html
index 1d28cbb..c262dda 100644
--- a/view/frontend/web/template/container/delivery-time.html
+++ b/view/frontend/web/template/container/delivery-time.html
@@ -25,6 +25,6 @@
         <span data-bind="i18n: 'Delivery Time'">Delivery Time</span>
     </div>
     <div class="control">
-        <input type="text" readonly="readonly" data-bind="datepicker: true, value: deliveryTimeValue" id="osc-delivery-time"/>
+        <input type="text" readonly="true" data-bind="datepicker: true,value: deliveryTimeValue" id="osc-delivery-time"/>
     </div>
 </div>
diff --git a/view/frontend/web/template/container/payment/discount.html b/view/frontend/web/template/container/payment/discount.html
deleted file mode 100644
index bfb87dd..0000000
--- a/view/frontend/web/template/container/payment/discount.html
+++ /dev/null
@@ -1,65 +0,0 @@
-<!--
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
--->
-<div class="payment-option _collapsible opc-payment-additional discount-code"
-     data-bind="mageInit: {'collapsible':{'openedState': '_active'}}">
-    <div class="payment-option-title field choice" data-role="title">
-        <span class="action action-toggle" id="block-discount-heading" role="heading" aria-level="2">
-            <!-- ko i18n: 'Apply Discount Code'--><!-- /ko -->
-        </span>
-    </div>
-    <div class="payment-option-content" data-role="content">
-        <!-- ko foreach: getRegion('messages') -->
-        <!-- ko template: getTemplate() --><!-- /ko -->
-        <!--/ko-->
-        <form class="form form-discount" id="discount-form" data-bind="blockLoader: (typeof isLoading === 'undefined') ? isBlockLoading : isLoading">
-            <div class="payment-option-inner">
-                <div class="field">
-                    <label class="label" for="discount-code">
-                        <span data-bind="i18n: 'Enter discount code'"></span>
-                    </label>
-                    <div class="control">
-                        <input class="input-text"
-                               type="text"
-                               id="discount-code"
-                               name="discount_code"
-                               data-validate="{'required-entry':true}"
-                               data-bind="value: couponCode, attr:{placeholder: $t('Enter discount code')} " />
-                    </div>
-                </div>
-            </div>
-            <div class="actions-toolbar">
-                <div class="primary">
-                    <!-- ko ifnot: isApplied() -->
-                        <button class="action action-apply" type="submit" data-bind="'value': $t('Apply Discount'), click: apply">
-                            <span><!-- ko i18n: 'Apply Discount'--><!-- /ko --></span>
-                        </button>
-                    <!-- /ko -->
-                    <!-- ko if: isApplied() -->
-                        <button class="action action-cancel" type="submit" data-bind="'value': $t('Cancel'), click: cancel">
-                            <span><!-- ko i18n: 'Cancel coupon'--><!-- /ko --></span>
-                        </button>
-                    <!-- /ko -->
-                </div>
-            </div>
-        </form>
-    </div>
-</div>
diff --git a/view/frontend/web/template/container/review/discount.html b/view/frontend/web/template/container/review/discount.html
index 7dca378..ddb29e2 100644
--- a/view/frontend/web/template/container/review/discount.html
+++ b/view/frontend/web/template/container/review/discount.html
@@ -19,6 +19,7 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <div class="osc-place-order-block checkout-comment-block col-mp mp-12">
     <div class="field-row">
         <label for="discount-code" data-bind="i18n: 'Apply Discount Code'"></label>
@@ -26,7 +27,7 @@
             <!-- ko foreach: getRegion('messages') -->
             <!-- ko template: getTemplate() --><!-- /ko -->
             <!--/ko-->
-            <form class="form form-discount" id="discount-form" data-bind="blockLoader: (typeof isLoading === 'undefined') ? isBlockLoading : isLoading">
+            <form class="form form-discount" id="discount-form" data-bind="blockLoader: isLoading">
                 <div class="payment-option-inner">
                     <div class="field">
                         <div class="control">
diff --git a/view/frontend/web/template/container/shipping.html b/view/frontend/web/template/container/shipping.html
index 8bf5cf7..23dc2f9 100644
--- a/view/frontend/web/template/container/shipping.html
+++ b/view/frontend/web/template/container/shipping.html
@@ -54,7 +54,7 @@
                         <tbody>
 
                         <!--ko foreach: { data: rates(), as: 'method'}-->
-                        <tr class="row" data-bind="click: $parent.selectShippingMethod, style: {cursor: 'pointer'}">
+                        <tr class="row" data-bind="click: $parent.selectShippingMethod">
                             <td class="col col-method">
                                 <!-- ko ifnot: method.error_message -->
                                 <!-- ko if: $parent.rates().length == 1 -->
