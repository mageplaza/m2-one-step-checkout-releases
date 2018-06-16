diff --git a/Helper/Config.php b/Helper/Config.php
index e12910f..d7017c7 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -336,29 +336,12 @@ class Config extends AbstractData
 	/**
 	 * Allow guest checkout
 	 *
-	 * @param $quote
 	 * @param null $store
-	 * @return bool
+	 * @return mixed
 	 */
-	public function getAllowGuestCheckout($quote, $store = null)
+	public function getAllowGuestCheckout($store = null)
 	{
-		$allowGuestCheckout = boolval($this->getGeneralConfig('allow_guest_checkout', $store));
-
-		if ($this->scopeConfig->isSetFlag(
-			\Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver::XML_PATH_DISABLE_GUEST_CHECKOUT,
-			\Magento\Store\Model\ScopeInterface::SCOPE_STORE,
-			$store
-		)) {
-			foreach ($quote->getAllItems() as $item) {
-				if (($product = $item->getProduct())
-					&& $product->getTypeId() == \Magento\Downloadable\Model\Product\Type::TYPE_DOWNLOADABLE
-				) {
-					return false;
-				}
-			}
-		}
-
-		return $allowGuestCheckout;
+		return boolval($this->getGeneralConfig('allow_guest_checkout', $store));
 	}
 
 	/**
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index df4467d..d95d406 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -127,7 +127,7 @@ class DefaultConfigProvider implements ConfigProviderInterface
 				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
 				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
 			],
-			'allowGuestCheckout' 	=> $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
+			'allowGuestCheckout' 	=> $this->oscConfig->getAllowGuestCheckout(),
 			'showBillingAddress' 	=> $this->oscConfig->getShowBillingAddress(),
 			'newsletterDefault' 	=> $this->oscConfig->isSubscribedByDefault(),
 			'isUsedGiftWrap'     	=> (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
diff --git a/Model/Plugin/Checkout/ShippingMethodManagement.php b/Model/Plugin/Checkout/ShippingMethodManagement.php
index 1f5f65e..8662bf4 100644
--- a/Model/Plugin/Checkout/ShippingMethodManagement.php
+++ b/Model/Plugin/Checkout/ShippingMethodManagement.php
@@ -29,118 +29,109 @@ use Magento\Quote\Api\Data\AddressInterface;
  */
 class ShippingMethodManagement
 {
-	/**
-	 * Quote repository.
-	 *
-	 * @var \Magento\Quote\Api\CartRepositoryInterface
-	 */
-	protected $quoteRepository;
-
-	/**
-	 * Customer Address repository
-	 *
-	 * @var \Magento\Customer\Api\AddressRepositoryInterface
-	 */
-	protected $addressRepository;
-
-	/**
-	 * @param \Magento\Quote\Api\CartRepositoryInterface $quoteRepository
-	 * @param \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
-	 */
-	public function __construct(
-		\Magento\Quote\Api\CartRepositoryInterface $quoteRepository,
-		\Magento\Customer\Api\AddressRepositoryInterface $addressRepository
-	)
-	{
-
-		$this->quoteRepository   = $quoteRepository;
-		$this->addressRepository = $addressRepository;
-	}
-
-	/**
-	 * @param \Magento\Quote\Model\ShippingMethodManagement $subject
-	 * @param \Closure $proceed
-	 * @param $cartId
-	 * @param EstimateAddressInterface $address
-	 * @return array
-	 */
-	public function aroundEstimateByAddress(
-		\Magento\Quote\Model\ShippingMethodManagement $subject,
-		\Closure $proceed,
-		$cartId,
-		EstimateAddressInterface $address
-	)
-	{
-
-		$this->saveAddress($cartId, $address);
-
-		return $proceed($cartId, $address);
-	}
-
-	/**
-	 * @param \Magento\Quote\Model\ShippingMethodManagement $subject
-	 * @param \Closure $proceed
-	 * @param $cartId
-	 * @param \Magento\Quote\Api\Data\AddressInterface $address
-	 * @return mixed
-	 */
-	public function aroundEstimateByExtendedAddress(
-		\Magento\Quote\Model\ShippingMethodManagement $subject,
-		\Closure $proceed,
-		$cartId,
-		AddressInterface $address
-	)
-	{
-
-		$this->saveAddress($cartId, $address);
-
-		return $proceed($cartId, $address);
-	}
-
-	/**
-	 * @param \Magento\Quote\Model\ShippingMethodManagement $subject
-	 * @param \Closure $proceed
-	 * @param $cartId
-	 * @param $addressId
-	 * @return mixed
-	 */
-	public function aroundEstimateByAddressId(
-		\Magento\Quote\Model\ShippingMethodManagement $subject,
-		\Closure $proceed,
-		$cartId,
-		$addressId
-	)
-	{
-
-		$address = $this->addressRepository->getById($addressId);
-		$this->saveAddress($cartId, $address);
-
-		return $proceed($cartId, $addressId);
-	}
-
-	private function saveAddress($cartId, $address)
-	{
-		/** @var \Magento\Quote\Model\Quote $quote */
-		$quote = $this->quoteRepository->getActive($cartId);
-
-		if (!$quote->isVirtual()) {
-			$addressData = [
-				EstimateAddressInterface::KEY_COUNTRY_ID => $address->getCountryId(),
-				EstimateAddressInterface::KEY_POSTCODE   => $address->getPostcode(),
-				EstimateAddressInterface::KEY_REGION_ID  => $address->getRegionId(),
-				EstimateAddressInterface::KEY_REGION     => $address->getRegion()
-			];
-
-			$shippingAddress = $quote->getShippingAddress();
-			try {
-				$shippingAddress->addData($addressData)
-					->save();
-				$this->quoteRepository->save($quote);
-			} catch (\Exception $e) {
-				return $this;
-			}
-		}
-
-		return $this;
-	}
+    /**
+     * Quote repository.
+     *
+     * @var \Magento\Quote\Api\CartRepositoryInterface
+     */
+    protected $quoteRepository;
+
+    /**
+     * Customer Address repository
+     *
+     * @var \Magento\Customer\Api\AddressRepositoryInterface
+     */
+    protected $addressRepository;
+
+    /**
+     * @param \Magento\Quote\Api\CartRepositoryInterface $quoteRepository
+     * @param \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
+     */
+    public function __construct(
+        \Magento\Quote\Api\CartRepositoryInterface $quoteRepository,
+        \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
+    ) {
+    
+        $this->quoteRepository   = $quoteRepository;
+        $this->addressRepository = $addressRepository;
+    }
+
+    /**
+     * @param \Magento\Quote\Model\ShippingMethodManagement $subject
+     * @param \Closure $proceed
+     * @param $cartId
+     * @param EstimateAddressInterface $address
+     * @return array
+     */
+    public function aroundEstimateByAddress(
+        \Magento\Quote\Model\ShippingMethodManagement $subject,
+        \Closure $proceed,
+        $cartId,
+        EstimateAddressInterface $address
+    ) {
+    
+        $this->saveAddress($cartId, $address);
+
+        return $proceed($cartId, $address);
+    }
+
+    /**
+     * @param \Magento\Quote\Model\ShippingMethodManagement $subject
+     * @param \Closure $proceed
+     * @param $cartId
+     * @param \Magento\Quote\Api\Data\AddressInterface $address
+     * @return mixed
+     */
+    public function aroundEstimateByExtendedAddress(
+        \Magento\Quote\Model\ShippingMethodManagement $subject,
+        \Closure $proceed,
+        $cartId,
+        AddressInterface $address
+    ) {
+    
+        $this->saveAddress($cartId, $address);
+
+        return $proceed($cartId, $address);
+    }
+
+    /**
+     * @param \Magento\Quote\Model\ShippingMethodManagement $subject
+     * @param \Closure $proceed
+     * @param $cartId
+     * @param $addressId
+     * @return mixed
+     */
+    public function aroundEstimateByAddressId(
+        \Magento\Quote\Model\ShippingMethodManagement $subject,
+        \Closure $proceed,
+        $cartId,
+        $addressId
+    ) {
+    
+        $address = $this->addressRepository->getById($addressId);
+        $this->saveAddress($cartId, $address);
+
+        return $proceed($cartId, $addressId);
+    }
+
+    private function saveAddress($cartId, $address)
+    {
+        /** @var \Magento\Quote\Model\Quote $quote */
+        $quote = $this->quoteRepository->getActive($cartId);
+
+        if (!$quote->isVirtual()) {
+            $addressData = [
+                EstimateAddressInterface::KEY_COUNTRY_ID => $address->getCountryId(),
+                EstimateAddressInterface::KEY_POSTCODE   => $address->getPostcode(),
+                EstimateAddressInterface::KEY_REGION_ID  => $address->getRegionId(),
+                EstimateAddressInterface::KEY_REGION     => $address->getRegion()
+            ];
+
+            $shippingAddress = $quote->getShippingAddress();
+            $shippingAddress->addData($addressData)
+                ->save();
+        }
+
+        return $this;
+    }
 }
diff --git a/etc/frontend/events.xml b/etc/frontend/events.xml
deleted file mode 100644
index fa6c909..0000000
--- a/etc/frontend/events.xml
+++ /dev/null
@@ -1,27 +0,0 @@
-<?xml version="1.0"?>
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
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
-    <event name="checkout_allow_guest">
-        <observer name="checkout_allow_guest" disabled="true" />
-    </event>
-</config>
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index 7059e97..1c88a83 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -32,9 +32,6 @@ if (window.location.href.indexOf('onestepcheckout') !== -1) {
             'Magento_Checkout/js/model/shipping-save-processor/default': {
                 'Magento_Checkout/js/model/full-screen-loader': 'Mageplaza_Osc/js/model/osc-loader'
             },
-            'Magento_Checkout/js/action/set-billing-address': {
-                'Magento_Checkout/js/model/full-screen-loader': 'Mageplaza_Osc/js/model/osc-loader'
-            },
             'Mageplaza_Osc/js/model/osc-loader': {
                 'Magento_Checkout/js/model/full-screen-loader': 'Magento_Checkout/js/model/full-screen-loader'
             }
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index 951345a..a7a95a4 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -54,7 +54,7 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .opc-wrapper .fieldset > .field > .label{float: none !important; width: auto !important; margin: 0 0 8px !important;}
 .fieldset > .field:not(.choice) > .control{float: none !important; width: 100% !important;}
 .fieldset > .field {margin: 0 0 20px !important;}
-#checkout-step-shipping .form-login, #checkout-step-billing .form-login {margin-top: 0 !important;}
+#checkout-step-shipping .form-login {margin-top: 0 !important;}
 .fieldset > .form-create-account> .field.required > .label:after {  content: '*';  color: #e02b27;  font-size: 1.2rem;  margin: 0 0 0 5px;  }
 
 
@@ -112,8 +112,8 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 
 /**************************************************** Place order area ****************************************************/
 #co-place-order-area{padding: 0 20px !important;}
-.one-step-checkout-wrapper .mp-4 #co-place-order-area{padding: 0 !important;}
-.one-step-checkout-wrapper .mp-4 #co-place-order-area .col-mp{width: 100% !important;}
+.one-step-checkout-wrapper .mp-4 #co-place-order-form{padding: 0 !important;}
+.one-step-checkout-wrapper .mp-4 #co-place-order-form .col-mp{width: 100% !important;}
 .osc-place-order-wrapper button.action.primary.checkout {padding: 10px 30px;margin: 0;border: none;font-size: 18px;font-weight: bold;width: 100%;height: 70px;}
 .osc-place-order-block{border: 1px solid #ccc;padding: 10px !important;margin-bottom: 20px;}
 .osc-place-order-block .field-row label{display: block; margin-bottom: 6px}
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 3085fa5..1e171ca 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -59,8 +59,7 @@ define(
               resolver) {
         'use strict';
 
-        var observedElements = [],
-            canShowBillingAddress = window.checkoutConfig.oscConfig.showBillingAddress;
+        var observedElements = [];
 
         return Component.extend({
             defaults: {
@@ -70,7 +69,7 @@ define(
 
             canUseShippingAddress: ko.computed(function () {
                 return !quote.isVirtual() && quote.shippingAddress() &&
-                    quote.shippingAddress().canUseForBilling() && canShowBillingAddress;
+                    quote.shippingAddress().canUseForBilling() && window.checkoutConfig.oscConfig.showBillingAddress;
             }),
 
             /**
@@ -136,7 +135,7 @@ define(
             onAddressChange: function (address) {
                 this._super(address);
 
-                if (!this.isAddressSameAsShipping() && canShowBillingAddress) {
+                if (!this.isAddressSameAsShipping()) {
                     this.updateAddress();
                 }
             },
@@ -149,8 +148,11 @@ define(
                     newBillingAddress = createBillingAddress(this.selectedAddress());
                     selectBillingAddress(newBillingAddress);
                     checkoutData.setSelectedBillingAddress(this.selectedAddress().getKey());
+                    if (window.checkoutConfig.reloadOnBillingAddress) {
+                        setBillingAddressAction(globalMessageList);
+                    }
                 } else {
-                    var addressData = this.source.get('billingAddress'),
+                    var addressData = this.source.get(this.dataScopePrefix),
                         newBillingAddress;
 
                     if (customer.isLoggedIn() && !this.customerHasAddresses) {
@@ -163,10 +165,10 @@ define(
                     selectBillingAddress(newBillingAddress);
                     checkoutData.setSelectedBillingAddress(newBillingAddress.getKey());
                     checkoutData.setNewCustomerBillingAddress(addressData);
-                }
 
-                if (window.checkoutConfig.reloadOnBillingAddress) {
-                    setBillingAddressAction(globalMessageList);
+                    if (window.checkoutConfig.reloadOnBillingAddress) {
+                        setBillingAddressAction(globalMessageList);
+                    }
                 }
             },
 
@@ -175,11 +177,12 @@ define(
              */
             initFields: function () {
                 var self = this,
-                    addressFields = window.checkoutConfig.oscConfig.addressFields,
                     fieldsetName = 'checkout.steps.shipping-step.billingAddress.billing-address-fieldset';
 
-                $.each(addressFields, function (index, field) {
-                    registry.async(fieldsetName + '.' + field)(self.bindHandler.bind(self));
+                var elements = registry.async(fieldsetName)().elems();
+
+                $.each(elements, function (index, elem) {
+                    self.bindHandler(elem);
                 });
 
                 return this;
@@ -193,14 +196,14 @@ define(
                         self.bindHandler(elem);
                     });
                 } else {
-                    element.on('value', this.saveBillingAddress.bind(this, element.index));
+                    element.on('value', this.saveBillingAddress.bind(this));
                     observedElements.push(element);
                 }
             },
 
-            saveBillingAddress: function (fieldName) {
+            saveBillingAddress: function () {
                 if (!this.isAddressSameAsShipping()) {
-                    if (!canShowBillingAddress) {
+                    if (!window.checkoutConfig.oscConfig.showBillingAddress) {
                         selectBillingAddress(quote.shippingAddress());
                     } else {
                         var addressFlat = addressConverter.formDataProviderToFlatData(
@@ -209,10 +212,6 @@ define(
                         );
 
                         selectBillingAddress(addressConverter.formAddressDataToQuoteAddress(addressFlat));
-
-                        if (window.checkoutConfig.reloadOnBillingAddress && (fieldName == 'country_id')) {
-                            setBillingAddressAction(globalMessageList);
-                        }
                     }
                 }
             },
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index f1ddabd..858b7cf 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -21,7 +21,6 @@
 define(
     [
         'jquery',
-        'underscore',
         'Magento_Checkout/js/view/shipping',
         'Magento_Checkout/js/model/quote',
         'Magento_Customer/js/model/customer',
@@ -40,7 +39,6 @@ define(
         'rjsResolver'
     ],
     function ($,
-              _,
               Component,
               quote,
               customer,
