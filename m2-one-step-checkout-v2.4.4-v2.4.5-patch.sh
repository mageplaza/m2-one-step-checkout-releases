diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index b9345bd..1325e77 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -21,17 +21,15 @@
 
 namespace Mageplaza\Osc\Model;
 
-use Magento\CatalogInventory\Api\StockRegistryInterface;
 use Magento\Checkout\Model\ConfigProviderInterface;
 use Magento\Checkout\Model\Session as CheckoutSession;
 use Magento\Customer\Model\AccountManagement;
 use Magento\Framework\Module\Manager as ModuleManager;
 use Magento\GiftMessage\Model\CompositeConfigProvider;
-use Magento\Quote\Api\CartItemRepositoryInterface as QuoteItemRepository;
 use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
-use Magento\Quote\Model\Quote\Item;
 use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Model\Geoip\Database\Reader;
 
 /**
  * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
@@ -70,23 +68,11 @@ class DefaultConfigProvider implements ConfigProviderInterface
     protected $_oscHelper;
 
     /**
-     * @var QuoteItemRepository
-     */
-    protected $quoteItemRepository;
-
-    /**
-     * @var StockRegistryInterface
-     */
-    protected $stockRegistry;
-
-    /**
      * DefaultConfigProvider constructor.
      * @param CheckoutSession $checkoutSession
      * @param PaymentMethodManagementInterface $paymentMethodManagement
      * @param ShippingMethodManagementInterface $shippingMethodManagement
      * @param CompositeConfigProvider $configProvider
-     * @param QuoteItemRepository $quoteItemRepository
-     * @param StockRegistryInterface $stockRegistry
      * @param ModuleManager $moduleManager
      * @param OscHelper $oscHelper
      */
@@ -95,20 +81,16 @@ class DefaultConfigProvider implements ConfigProviderInterface
         PaymentMethodManagementInterface $paymentMethodManagement,
         ShippingMethodManagementInterface $shippingMethodManagement,
         CompositeConfigProvider $configProvider,
-        QuoteItemRepository $quoteItemRepository,
-        StockRegistryInterface $stockRegistry,
         ModuleManager $moduleManager,
         OscHelper $oscHelper
     )
     {
-        $this->checkoutSession           = $checkoutSession;
-        $this->paymentMethodManagement   = $paymentMethodManagement;
-        $this->shippingMethodManagement  = $shippingMethodManagement;
+        $this->checkoutSession = $checkoutSession;
+        $this->paymentMethodManagement = $paymentMethodManagement;
+        $this->shippingMethodManagement = $shippingMethodManagement;
         $this->giftMessageConfigProvider = $configProvider;
-        $this->quoteItemRepository       = $quoteItemRepository;
-        $this->stockRegistry             = $stockRegistry;
-        $this->moduleManager             = $moduleManager;
-        $this->_oscHelper                = $oscHelper;
+        $this->moduleManager = $moduleManager;
+        $this->_oscHelper = $oscHelper;
     }
 
     /**
@@ -121,12 +103,12 @@ class DefaultConfigProvider implements ConfigProviderInterface
         }
 
         $output = [
-            'shippingMethods'       => $this->getShippingMethods(),
-            'selectedShippingRate'  => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod())
+            'shippingMethods' => $this->getShippingMethods(),
+            'selectedShippingRate' => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod())
                 ? $existShippingMethod : $this->_oscHelper->getDefaultShippingMethod(),
-            'paymentMethods'        => $this->getPaymentMethods(),
+            'paymentMethods' => $this->getPaymentMethods(),
             'selectedPaymentMethod' => $this->_oscHelper->getDefaultPaymentMethod(),
-            'oscConfig'             => $this->getOscConfig()
+            'oscConfig' => $this->getOscConfig()
         ];
 
         return $output;
@@ -138,39 +120,38 @@ class DefaultConfigProvider implements ConfigProviderInterface
     private function getOscConfig()
     {
         return [
-            'addressFields'           => $this->_oscHelper->getAddressHelper()->getAddressFields(),
-            'autocomplete'            => [
-                'type'                   => $this->_oscHelper->getAutoDetectedAddress(),
+            'addressFields' => $this->_oscHelper->getAddressHelper()->getAddressFields(),
+            'autocomplete' => [
+                'type' => $this->_oscHelper->getAutoDetectedAddress(),
                 'google_default_country' => $this->_oscHelper->getGoogleSpecificCountry(),
             ],
-            'register'                => [
-                'dataPasswordMinLength'        => $this->_oscHelper->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
+            'register' => [
+                'dataPasswordMinLength' => $this->_oscHelper->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
                 'dataPasswordMinCharacterSets' => $this->_oscHelper->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
             ],
-            'allowGuestCheckout'      => $this->_oscHelper->getAllowGuestCheckout($this->checkoutSession->getQuote()),
-            'showBillingAddress'      => $this->_oscHelper->getShowBillingAddress(),
-            'newsletterDefault'       => $this->_oscHelper->isSubscribedByDefault(),
-            'isUsedGiftWrap'          => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
-            'giftMessageOptions'      => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), [
+            'allowGuestCheckout' => $this->_oscHelper->getAllowGuestCheckout($this->checkoutSession->getQuote()),
+            'showBillingAddress' => $this->_oscHelper->getShowBillingAddress(),
+            'newsletterDefault' => $this->_oscHelper->isSubscribedByDefault(),
+            'isUsedGiftWrap' => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
+            'giftMessageOptions' => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), [
                 'isEnableOscGiftMessageItems' => $this->_oscHelper->isEnableGiftMessageItems()
             ]),
-            'isDisplaySocialLogin'    => $this->isDisplaySocialLogin(),
-            'deliveryTimeOptions'     => [
+            'isDisplaySocialLogin' => $this->isDisplaySocialLogin(),
+            'deliveryTimeOptions' => [
                 'deliveryTimeFormat' => $this->_oscHelper->getDeliveryTimeFormat(),
-                'deliveryTimeOff'    => $this->_oscHelper->getDeliveryTimeOff(),
-                'houseSecurityCode'  => $this->_oscHelper->isDisabledHouseSecurityCode()
+                'deliveryTimeOff' => $this->_oscHelper->getDeliveryTimeOff(),
+                'houseSecurityCode' => $this->_oscHelper->isDisabledHouseSecurityCode()
             ],
-            'isUsedMaterialDesign'    => $this->_oscHelper->isUsedMaterialDesign(),
+            'isUsedMaterialDesign' => $this->_oscHelper->isUsedMaterialDesign(),
             'isAmazonAccountLoggedIn' => false,
-            'geoIpOptions'            => [
+            'geoIpOptions' => [
                 'isEnableGeoIp' => $this->_oscHelper->isEnableGeoIP(),
-                'geoIpData'     => $this->_oscHelper->getAddressHelper()->getGeoIpData()
+                'geoIpData' => $this->_oscHelper->getAddressHelper()->getGeoIpData()
             ],
-            'compatible'              => [
+            'compatible' => [
                 'isEnableModulePostNL' => $this->_oscHelper->isEnableModulePostNL(),
             ],
-            'show_toc'                => $this->_oscHelper->getShowTOC(),
-            'qtyIncrements'           => $this->getItemQtyIncrement()
+            'show_toc' => $this->_oscHelper->getShowTOC()
         ];
     }
 
@@ -183,11 +164,11 @@ class DefaultConfigProvider implements ConfigProviderInterface
     private function getPaymentMethods()
     {
         $paymentMethods = [];
-        $quote          = $this->checkoutSession->getQuote();
+        $quote = $this->checkoutSession->getQuote();
         if (!$quote->getIsVirtual()) {
             foreach ($this->paymentMethodManagement->getList($quote->getId()) as $paymentMethod) {
                 $paymentMethods[] = [
-                    'code'  => $paymentMethod->getCode(),
+                    'code' => $paymentMethod->getCode(),
                     'title' => $paymentMethod->getTitle()
                 ];
             }
@@ -212,36 +193,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
     }
 
     /**
-     * Retrieve quote item data
-     *
-     * @return array
-     */
-    private function getItemQtyIncrement()
-    {
-        $itemQty = [];
-
-        try {
-            $quoteId = $this->checkoutSession->getQuote()->getId();
-            if ($quoteId) {
-                /** @var array $quoteItems */
-                $quoteItems = $this->quoteItemRepository->getList($quoteId);
-
-                /** @var Item $item */
-                foreach ($quoteItems as $item) {
-                    $stockItem = $this->stockRegistry->getStockItem($item->getProduct()->getId(), $item->getStore()->getWebsiteId());
-                    if ($stockItem->getEnableQtyIncrements() && $stockItem->getQtyIncrements()) {
-                        $itemQty[$item->getId()] = $stockItem->getQtyIncrements() ?: 1;
-                    }
-                }
-            }
-        } catch (\Exception $e) {
-            $itemQty = [];
-        }
-
-        return $itemQty;
-    }
-
-    /**
      * @return bool
      */
     private function isDisplaySocialLogin()
diff --git a/composer.json b/composer.json
index 9c516dc..963abf3 100644
--- a/composer.json
+++ b/composer.json
@@ -6,7 +6,7 @@
     "geoip2/geoip2": "~2.0"
   },
   "type": "magento2-module",
-  "version": "2.4.5",
+  "version": "2.4.4",
   "license": "proprietary",
   "authors": [
     {
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 72f727f..1fb6cb7 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -307,7 +307,7 @@
                     <validate>jscolor {hash:true,refine:false}</validate>
                 </field>
                 <field id="custom_css" sortOrder="100" type="textarea" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Custom CSS</label>
+                    <label>Custom Css</label>
                     <comment><![CDATA[Example: .step-title{background-color: #1979c3;}]]></comment>
                 </field>
             </group>
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 5837c0c..4c24c30 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -46,8 +46,7 @@ define(
               shippingService,
               postcodeValidator,
               $t,
-              uiRegistry
-    ) {
+              uiRegistry) {
         'use strict';
 
         var countryElement = null,
@@ -139,9 +138,7 @@ define(
 
                 if (element.component.indexOf('/group') !== -1) {
                     $.each(element.elems(), function (index, elem) {
-                        uiRegistry.async(elem.name)(function () {
-                            self.oscBindHandler(elem);
-                        });
+                        self.oscBindHandler(elem);
                     });
                 } else if (element && element.hasOwnProperty('value')) {
                     element.on('value', function () {
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index ce1e334..b72c67f 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -194,9 +194,7 @@ define(
 
                 if (element.component.indexOf('/group') !== -1) {
                     $.each(element.elems(), function (index, elem) {
-                        registry.async(elem.name) (function () {
-                            self.bindHandler(elem);
-                        });
+                        self.bindHandler(elem);
                     });
                 } else {
                     element.on('value', this.saveBillingAddress.bind(this, element.index));
@@ -273,7 +271,7 @@ define(
                 if (this.source.get('params.invalid')) {
                     var offsetHeight = $(window).height()/2,
                         errorMsgSelector = $('#billing-new-address-form .mage-error:first').closest('.field');
-                    errorMsgSelector = errorMsgSelector.length ? errorMsgSelector : $('#co-shipping-form .field-error:first').closest('.field');
+
                     if (errorMsgSelector.length) {
                         if (errorMsgSelector.find('select').length) {
                             $('html, body').scrollTop(
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index 60263ae..b085358 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -166,7 +166,6 @@ define(
                     $(loginFormSelector + ' input[name=username]').focus();
                 } else if (!shippingAddressValidationResult) {
                     var errorMsgSelector = $('#co-shipping-form .mage-error:first').closest('.field');
-                    errorMsgSelector = errorMsgSelector.length ? errorMsgSelector : $('#co-shipping-form .field-error:first').closest('.field');
                     if (errorMsgSelector.length) {
                         if (errorMsgSelector.find('select').length) {
                             $('html, body').scrollTop(
diff --git a/view/frontend/web/js/view/summary/item/details.js b/view/frontend/web/js/view/summary/item/details.js
index a77db93..d719bc1 100644
--- a/view/frontend/web/js/view/summary/item/details.js
+++ b/view/frontend/web/js/view/summary/item/details.js
@@ -30,12 +30,19 @@ define(
         'mage/translate',
         'Magento_Ui/js/modal/modal'
     ],
-    function (_, $, Component, quote, updateItemAction, giftMessageItem, url, $t, modal) {
+    function (_,
+              $,
+              Component,
+              quote,
+              updateItemAction,
+              giftMessageItem,
+              url,
+              $t,
+              modal) {
         "use strict";
 
         var products = window.checkoutConfig.quoteItemData,
-            giftMessageOptions = window.checkoutConfig.oscConfig.giftMessageOptions,
-            qtyIncrements = window.checkoutConfig.oscConfig.qtyIncrements;
+            giftMessageOptions = window.checkoutConfig.oscConfig.giftMessageOptions;
 
 
         return Component.extend({
@@ -183,18 +190,10 @@ define(
              * @param event
              */
             plusQty: function (id, event) {
-                var target = $(event.target).prev().children(".item_qty"),
-                    itemId = parseInt(target.attr("id")),
-                    qty = parseInt(target.val());
-
-                if (qtyIncrements.hasOwnProperty(itemId)) {
-                    var qtyDelta = qtyIncrements[itemId];
-
-                    qty = (Math.floor(qty / qtyDelta) + 1) * qtyDelta;
-                } else {
-                    qty += 1;
-                }
-
+                var target = $(event.target).prev().children(".item_qty");
+                var qty = parseInt(target.val()) + 1;
+                var itemId = parseInt(target.attr("id"));
+                //target.val(qty);
                 this.updateItem(itemId, qty);
             },
 
@@ -205,18 +204,10 @@ define(
              * @param event
              */
             minusQty: function (item, event) {
-                var target = $(event.target).next().children(".item_qty"),
-                    itemId = parseInt(target.attr("id")),
-                    qty = parseInt(target.val());
-
-                if (qtyIncrements.hasOwnProperty(itemId)) {
-                    var qtyDelta = qtyIncrements[itemId];
-
-                    qty = (Math.ceil(qty / qtyDelta) -1) * qtyDelta;
-                } else {
-                    qty -= 1;
-                }
-
+                var target = $(event.target).next().children(".item_qty");
+                var qty = parseInt(target.val()) - 1;
+                var itemId = parseInt(target.attr("id"));
+                //target.val(qty);
                 this.updateItem(itemId, qty);
             },
 
@@ -227,15 +218,9 @@ define(
              * @param event
              */
             changeQty: function (item, event) {
-                var target = $(event.target),
-                    itemId = parseInt(target.attr("id")),
-                    qty = parseInt(target.val());
-
-                if (qtyIncrements.hasOwnProperty(itemId) && (qty % qtyIncrements[itemId])) {
-                    var qtyDelta = qtyIncrements[itemId];
-
-                    qty = (Math.ceil(qty / qtyDelta) -1) * qtyDelta;
-                }
+                var target = $(event.target);
+                var qty = parseInt(target.val());
+                var itemId = parseInt(target.attr("id"));
 
                 this.updateItem(itemId, qty);
             },
