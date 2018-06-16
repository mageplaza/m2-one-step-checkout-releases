diff --git a/Block/Adminhtml/Field/Position.php b/Block/Adminhtml/Field/Position.php
index 8bce1d0..e8ea37b 100644
--- a/Block/Adminhtml/Field/Position.php
+++ b/Block/Adminhtml/Field/Position.php
@@ -20,10 +20,6 @@
  */
 namespace Mageplaza\Osc\Block\Adminhtml\Field;
 
-/**
- * Class Position
- * @package Mageplaza\Osc\Block\Adminhtml\Field
- */
 class Position extends \Magento\Backend\Block\Widget\Container
 {
 	/**
@@ -57,9 +53,6 @@ class Position extends \Magento\Backend\Block\Widget\Container
 		parent::__construct($context, $data);
 	}
 
-	/**
-	 * @inheritdoc
-	 */
 	protected function _construct()
 	{
 		parent::_construct();
diff --git a/Block/Order/Totals.php b/Block/Order/Totals.php
index f012c96..aa7b32e 100644
--- a/Block/Order/Totals.php
+++ b/Block/Order/Totals.php
@@ -30,9 +30,6 @@ use Magento\Framework\View\Element\Template;
  */
 class Totals extends Template
 {
-	/**
-	 * Init Totals
-	 */
 	public function initTotals()
 	{
 		$totalsBlock = $this->getParentBlock();
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index 332a940..6e92baf 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -102,10 +102,6 @@ class Index extends \Magento\Checkout\Controller\Onepage
 		return true;
 	}
 
-	/**
-	 * @param $method
-	 * @return bool
-	 */
 	public function filterMethod($method)
 	{
 		$defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
diff --git a/Helper/Config.php b/Helper/Config.php
index efce766..e12910f 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -213,11 +213,6 @@ class Config extends AbstractData
 		return $onlySorted ? $sortedFields : [$sortedFields, $availableFields];
 	}
 
-	/**
-	 * @param $colSpan
-	 * @param $isNewRow
-	 * @return $this
-	 */
 	private function checkNewRow($colSpan, &$isNewRow)
 	{
 		if ($colSpan == 6 && $isNewRow) {
diff --git a/Helper/Data.php b/Helper/Data.php
index e32ba78..00d17ec 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -25,6 +25,7 @@ use Magento\Framework\App\Helper\Context;
 use Magento\Framework\App\ObjectManager;
 use Magento\Framework\ObjectManagerInterface;
 use Magento\Framework\Pricing\PriceCurrencyInterface;
+use Magento\Newsletter\Model\Subscriber;
 use Magento\Store\Model\StoreManagerInterface;
 use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
 
@@ -45,9 +46,9 @@ class Data extends AbstractHelper
 	protected $_helperConfig;
 
 	/**
-	 * @type \Magento\Framework\Pricing\PriceCurrencyInterface
+	 * @type \Magento\Newsletter\Model\Subscriber
 	 */
-	protected $_priceCurrency;
+	protected $_subscriber;
 
 	/**
 	 * @param \Magento\Framework\App\Helper\Context $context
@@ -55,7 +56,7 @@ class Data extends AbstractHelper
 	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
 	 * @param \Mageplaza\Osc\Helper\Config $helperConfig
 	 * @param \Magento\Framework\ObjectManagerInterface $objectManager
-	 * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
+	 * @param \Magento\Newsletter\Model\Subscriber $subscriber
 	 */
 	public function __construct(
 		Context $context,
@@ -63,13 +64,13 @@ class Data extends AbstractHelper
 		StoreManagerInterface $storeManager,
 		Config $helperConfig,
 		ObjectManagerInterface $objectManager,
-		PriceCurrencyInterface $priceCurrency
+		Subscriber $subscriber
 	)
 	{
+
 		$this->_helperData   = $helperData;
 		$this->_helperConfig = $helperConfig;
-		$this->_priceCurrency   = $priceCurrency;
-
+		$this->_subscriber   = $subscriber;
 		parent::__construct($context, $objectManager, $storeManager);
 	}
 
@@ -90,20 +91,11 @@ class Data extends AbstractHelper
 		return $this->getConfig()->isEnabled($store);
 	}
 
-	/**
-	 * @param $amount
-	 * @param null $store
-	 * @return float
-	 */
 	public function convertPrice($amount, $store = null)
 	{
-		return $this->_priceCurrency->convert($amount, $store);
+		return $this->priceCurrency->convert($amount, $store);
 	}
 
-	/**
-	 * @param $quote
-	 * @return float|int
-	 */
 	public function calculateGiftWrapAmount($quote)
 	{
 		$baseOscGiftWrapAmount = $this->getConfig()->getOrderGiftwrapAmount();
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index 249cfd8..df4467d 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -140,11 +140,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
 		];
 	}
 
-	/**
-	 * Address Fields
-	 *
-	 * @return array
-	 */
 	private function getAddressFields()
 	{
 		$fieldPosition = $this->oscConfig->getAddressFieldPosition();
diff --git a/Model/Plugin/Checkout/ShippingMethodManagement.php b/Model/Plugin/Checkout/ShippingMethodManagement.php
index 378ad77..1f5f65e 100644
--- a/Model/Plugin/Checkout/ShippingMethodManagement.php
+++ b/Model/Plugin/Checkout/ShippingMethodManagement.php
@@ -118,11 +118,6 @@ class ShippingMethodManagement
 		return $proceed($cartId, $addressId);
 	}
 
-	/**
-	 * @param $cartId
-	 * @param $address
-	 * @return $this
-	 */
 	private function saveAddress($cartId, $address)
 	{
 		/** @var \Magento\Quote\Model\Quote $quote */
diff --git a/Model/System/Config/Source/ComponentPosition.php b/Model/System/Config/Source/ComponentPosition.php
index 659942c..853600c 100644
--- a/Model/System/Config/Source/ComponentPosition.php
+++ b/Model/System/Config/Source/ComponentPosition.php
@@ -20,19 +20,12 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Model\AbstractModel;
 
-/**
- * Class ComponentPosition
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
 class ComponentPosition extends AbstractModel
 {
 	const NOT_SHOW = 0;
 	const SHOW_IN_PAYMENT = 1;
 	const SHOW_IN_REVIEW = 2;
 
-	/**
-	 * @return array
-	 */
 	public function toOptionArray()
 	{
 		return [
diff --git a/Model/System/Config/Source/DeliveryTime.php b/Model/System/Config/Source/DeliveryTime.php
index cf826aa..cd1c1f2 100644
--- a/Model/System/Config/Source/DeliveryTime.php
+++ b/Model/System/Config/Source/DeliveryTime.php
@@ -20,19 +20,12 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Model\AbstractModel;
 
-/**
- * Class DeliveryTime
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
 class DeliveryTime extends AbstractModel
 {
     const DAY_MONTH_YEAR = 'dd/mm/yy';
     const MONTH_DAY_YEAR = 'mm/dd/yy';
     const YEAR_MONTH_DAY = 'yy/mm/dd';
 
-    /**
-     * @return array
-     */
     public function toOptionArray()
     {
         $options = [
diff --git a/Model/System/Config/Source/Giftwrap.php b/Model/System/Config/Source/Giftwrap.php
index ba7a86d..a539520 100644
--- a/Model/System/Config/Source/Giftwrap.php
+++ b/Model/System/Config/Source/Giftwrap.php
@@ -20,18 +20,11 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Model\AbstractModel;
 
-/**
- * Class Giftwrap
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
 class Giftwrap extends AbstractModel
 {
     const PER_ORDER = 0;
     const PER_ITEM  = 1;
-
-    /**
-     * @return array
-     */
+ 
     public function toOptionArray()
     {
         return [
diff --git a/Model/Total/Quote/GiftWrap.php b/Model/Total/Quote/GiftWrap.php
index 4a8b169..2f8af22 100644
--- a/Model/Total/Quote/GiftWrap.php
+++ b/Model/Total/Quote/GiftWrap.php
@@ -51,9 +51,6 @@ class GiftWrap extends AbstractTotal
 	 */
 	protected $priceCurrency;
 
-	/**
-	 * @type
-	 */
 	protected $_baseGiftWrapAmount;
 
 	/**
@@ -129,10 +126,6 @@ class GiftWrap extends AbstractTotal
 		];
 	}
 
-	/**
-	 * @param $quote
-	 * @return int|mixed
-	 */
 	public function calculateGiftWrapAmount($quote)
 	{
 		if ($this->_baseGiftWrapAmount == null) {
diff --git a/Observer/OscConfigObserver.php b/Observer/OscConfigObserver.php
index ca377b5..9738d9d 100644
--- a/Observer/OscConfigObserver.php
+++ b/Observer/OscConfigObserver.php
@@ -1,23 +1,10 @@
 <?php
+
 /**
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
+ * Copyright ? 2015 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
+
 namespace Mageplaza\Osc\Observer;
 
 use Magento\Config\Model\ResourceModel\Config as ModelConfig;
@@ -25,10 +12,6 @@ use Magento\Framework\App\Config\ScopeConfigInterface;
 use Magento\GiftMessage\Helper\Message;
 use Mageplaza\Osc\Helper\Config as HelperConfig;
 
-/**
- * Class OscConfigObserver
- * @package Mageplaza\Osc\Observer
- */
 class OscConfigObserver implements \Magento\Framework\Event\ObserverInterface
 {
     /**
@@ -47,8 +30,9 @@ class OscConfigObserver implements \Magento\Framework\Event\ObserverInterface
     protected $_modelConfig;
 
     /**
-     * @param \Mageplaza\Osc\Helper\Config $helperConfig
-     * @param \Magento\Config\Model\ResourceModel\Config $modelConfig
+     * GiftMessageConfigObserver constructor.
+     *
+     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
      */
     public function __construct(
         HelperConfig $helperConfig,
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index ff25edb..951345a 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -137,12 +137,3 @@ fieldset.field.col-mp{padding: 0 10px !important;}
     .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap .modal-content{padding:0 !important}
 
 }
-@media only screen and (max-width:786px){
-    #checkout-step-shipping_method{padding:0}
-    .opc-wrapper .form-login,.opc-wrapper .form-shipping-address, .opc-wrapper .methods-shipping{  margin: 20px 0px 15px;}
-    .opc-block-summary{padding: 22px 0px;}
-    #checkout-review-table thead th, #checkout-review-table tbody tr td, #checkout-review-table tfoot tr td{  padding: 15px 5px;}
-}
-@media only screen and (max-width:320px){
-    #checkout-review-table thead th, #checkout-review-table tbody tr td, #checkout-review-table tfoot tr td{padding: 15px 0px;}
-}
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 4bcabc6..54af6ec 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -54,23 +54,19 @@ define(
             postcodeElementName = 'postcode',
             observedElements = [],
             observableElements,
-            defaultRules = {'rate': {'postcode': {'required': true}, 'country_id': {'required': true}}},
+            rules = shippingRatesValidationRules.getRules(),
             addressFields = window.checkoutConfig.oscConfig.addressFields;
 
+            rules = _.isEmpty(rules) ? {'rate': {'postcode': {'required': true}, 'country_id': {'required': true}}} : rules;
+
         return _.extend(Validator, {
             isFormInline: addressList().length == 0,
 
-            getValidationRules: function () {
-                var rules = shippingRatesValidationRules.getRules();
-
-                return _.isEmpty(rules) ? defaultRules : rules;
-            },
-
             oscValidateAddressData: function (field, address) {
                 var self = this,
                     canLoad = false;
 
-                $.each(self.getValidationRules(), function (carrier, fields) {
+                $.each(rules, function (carrier, fields) {
                     if (fields.hasOwnProperty(field)) {
                         var missingValue = false;
                         $.each(fields, function (key, rule) {
@@ -117,7 +113,7 @@ define(
                 var self = this;
 
                 observableElements = shippingRatesValidationRules.getObservableFields();
-                if (_.isEmpty(observableElements)) {
+                if(_.isEmpty(observableElements)){
                     observableElements.push('country_id');
                 }
 
