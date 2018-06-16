diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index 6a06f0a..24fdc8e 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -276,11 +276,11 @@ class CheckoutManagement implements CheckoutManagementInterface
 		/** @var \Magento\Quote\Model\Quote $quote */
 		$quote = $this->cartRepository->getActive($cartId);
 
-		if (!$this->oscConfig->isDisabledGiftMessage() && isset($additionInformation['giftMessage'])) {
+		if (!$this->oscConfig->isDisabledGiftMessage()) {
 			$giftMessage = json_decode($additionInformation['giftMessage'], true);
-			$this->giftMessage->setSender(isset($giftMessage['sender']) ? $giftMessage['sender'] : '');
-			$this->giftMessage->setRecipient(isset($giftMessage['recipient']) ? $giftMessage['recipient'] : '');
-			$this->giftMessage->setMessage(isset($giftMessage['message']) ? $giftMessage['message'] : '');
+			$this->giftMessage->setSender($giftMessage['sender']);
+			$this->giftMessage->setRecipient($giftMessage['recipient']);
+			$this->giftMessage->setMessage($giftMessage['message']);
 			$this->giftMessageManagement->setMessage($quote, 'quote', $this->giftMessage);
 		}
 	}
diff --git a/Model/System/Config/Source/PaymentMethods.php b/Model/System/Config/Source/PaymentMethods.php
index 2ff5eda..bd7e484 100644
--- a/Model/System/Config/Source/PaymentMethods.php
+++ b/Model/System/Config/Source/PaymentMethods.php
@@ -21,7 +21,6 @@
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Option\ArrayInterface;
-use Magento\Store\Model\ScopeInterface;
 
 /**
  * Class Methods
@@ -30,26 +29,27 @@ use Magento\Store\Model\ScopeInterface;
 class PaymentMethods implements ArrayInterface
 {
 	/**
-	 * @type \Magento\Framework\App\Config\ScopeConfigInterface
+	 * @var \Magento\Payment\Helper\Data
 	 */
-	protected $_scopeConfig;
+	protected $_paymentHelperData;
 
 	/**
-	 * @type \Magento\Payment\Model\Method\Factory
+	 * @var \Magento\Payment\Model\Config
 	 */
-	protected $_paymentMethodFactory;
+	protected $_paymentModelConfig;
 
 	/**
-	 * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
-	 * @param \Magento\Payment\Model\Method\Factory $paymentMethodFactory
+	 * PaymentMethods constructor.
+	 * @param \Magento\Payment\Helper\Data $paymentHelperData
+	 * @param \Magento\Payment\Model\Config $paymentModelConfig
 	 */
 	public function __construct(
-		\Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
-		\Magento\Payment\Model\Method\Factory $paymentMethodFactory
+		\Magento\Payment\Helper\Data $paymentHelperData,
+		\Magento\Payment\Model\Config $paymentModelConfig
 	)
 	{
-		$this->_scopeConfig          = $scopeConfig;
-		$this->_paymentMethodFactory = $paymentMethodFactory;
+		$this->_paymentHelperData  = $paymentHelperData;
+		$this->_paymentModelConfig = $paymentModelConfig;
 	}
 
 	/**
@@ -57,9 +57,14 @@ class PaymentMethods implements ArrayInterface
 	 */
 	public function toOptionArray()
 	{
-		$options = [['label' => __('-- Please select --'), 'value' => '']];
+		$options = [
+			[
+				'label' => __('-- Please select --'),
+				'value' => '',
+			],
+		];
 
-		$payments = $this->getActiveMethods();
+		$payments = $this->_paymentModelConfig->getActiveMethods();
 		foreach ($payments as $paymentCode => $paymentModel) {
 			$options[$paymentCode] = array(
 				'label' => $paymentModel->getTitle(),
@@ -69,30 +74,4 @@ class PaymentMethods implements ArrayInterface
 
 		return $options;
 	}
-
-	/**
-	 * Get all active payment method
-	 *
-	 * @return array
-	 */
-	public function getActiveMethods()
-	{
-		$methods = [];
-		foreach ($this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null) as $code => $data) {
-			if (isset($data['active'], $data['model']) && (bool)$data['active']) {
-				try {
-					$methodModel = $this->_paymentMethodFactory->create($data['model']);
-
-					$methodModel->setStore(null);
-					if ($methodModel->getConfigData('active', null)) {
-						$methods[$code] = $methodModel;
-					}
-				} catch (\Exception $e) {
-					continue;
-				}
-			}
-		}
-
-		return $methods;
-	}
 }
diff --git a/Observer/CheckoutSubmitBefore.php b/Observer/CheckoutSubmitBefore.php
index 96f70e4..344ba50 100644
--- a/Observer/CheckoutSubmitBefore.php
+++ b/Observer/CheckoutSubmitBefore.php
@@ -161,9 +161,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 		// If customer is created, set customerId for address to avoid create more address when checkout
 		if ($customerId = $quote->getCustomerId()) {
 			$billing->setCustomerId($customerId);
-			if($shipping) {
-				$shipping->setCustomerId($customerId);
-			}
+			$shipping->setCustomerId($customerId);
 		}
 	}
 
diff --git a/view/adminhtml/templates/order/additional.phtml b/view/adminhtml/templates/order/additional.phtml
index 55511de..3198d40 100644
--- a/view/adminhtml/templates/order/additional.phtml
+++ b/view/adminhtml/templates/order/additional.phtml
@@ -22,13 +22,13 @@
 // @codingStandardsIgnoreFile
 
 ?>
-<?php if ($html = $block->getChildHtml()): ?>
+<?php if ($block->getChildHtml()): ?>
 <section class="admin__page-section order-osc-additional">
     <div class="admin__page-section-title">
         <strong class="title"><?php /* @escapeNotVerified */ echo __('Additional Content') ?></strong>
     </div>
     <div class="admin__page-section-content">
-        <?php echo $html ?>
+        <?php echo $block->getChildHtml() ?>
     </div>
 </section>
-<?php endif ?>
\ No newline at end of file
+<?php endif ?>
diff --git a/view/adminhtml/templates/order/view/delivery-time.phtml b/view/adminhtml/templates/order/view/delivery-time.phtml
index e716b9f..0fa0c07 100644
--- a/view/adminhtml/templates/order/view/delivery-time.phtml
+++ b/view/adminhtml/templates/order/view/delivery-time.phtml
@@ -31,4 +31,5 @@
             <?php echo $deliveryTimeHtml ?>
         </div>
     </div>
-<?php endif; ?>
\ No newline at end of file
+<?php endif; ?>
+
diff --git a/view/frontend/templates/design.phtml b/view/frontend/templates/design.phtml
index 7080964..7448d51 100644
--- a/view/frontend/templates/design.phtml
+++ b/view/frontend/templates/design.phtml
@@ -24,12 +24,7 @@
 	<script type="text/javascript" src="//maps.googleapis.com/maps/api/js?key=<?= $block->getGoogleApiKey() ?>&libraries=places"></script>
 <?php endif; ?>
 
-<?php
-$design = $block->getDesignConfiguration();
-$headingBackground = '#' . trim ($design['heading_background'], '#');
-$headingText = '#' . trim ($design['heading_text'], '#');
-$placeOrder = '#' . trim ($design['place_order_button'], '#');
-?>
+<?php $design = $block->getDesignConfiguration(); ?>
 
 <style type="text/css">
     /*===================================================================
@@ -39,17 +34,17 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
 	.checkout-container a.button-action,
 	.popup-authentication button.action,
 	.checkout-container button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link):not(.ui-datepicker-trigger){
-		background-color: <?php echo $headingBackground ?> !important;
-		border-color: <?php echo $headingBackground ?> !important;
+		background-color: <?php echo $design['heading_background'] ?> !important;
+		border-color: <?php echo $design['heading_background'] ?> !important;
 		box-shadow: none !important;
 		color: #FFFFFF !important;
 	}
 	.step-title{
-		background-color: <?php echo $headingBackground ?>;
+		background-color: <?php echo $design['heading_background'] ?>;
 		padding: 12px 10px 12px 12px !important;
 		font-weight: bold !important;
 		font-size: 16px !important;
-		color: <?php echo $headingText ?> !important;
+		color: <?php echo $design['heading_text'] ?> !important;
 		text-transform: uppercase;
 		line-height: 1.1;
 	}
@@ -60,7 +55,7 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
 		vertical-align: text-bottom;
 	}
 	.one-step-checkout-container .osc-geolocation {
-		color: <?php echo $headingBackground ?>;
+		color: <?php echo $design['heading_background'] ?>;
 	}
 	<?php break; ?>
 <?php case 'material': ?>
@@ -70,8 +65,8 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
 <?php endswitch; ?>
 
 	.osc-place-order-wrapper .place-order-primary button.primary.checkout{
-		background-color: <?php echo $placeOrder ?> !important;
-		border-color: <?php echo $placeOrder ?> !important;
+		background-color: <?php echo $design['place_order_button'] ?> !important;
+		border-color: <?php echo $design['place_order_button'] ?> !important;
 	}
 	/*===================================================================
 	|                           Custom STYLE                             |
diff --git a/view/frontend/web/js/model/shipping-rate-service.js b/view/frontend/web/js/model/shipping-rate-service.js
index 5e3d140..d537d58 100644
--- a/view/frontend/web/js/model/shipping-rate-service.js
+++ b/view/frontend/web/js/model/shipping-rate-service.js
@@ -22,9 +22,10 @@ define(
     [
         'Magento_Checkout/js/model/quote',
         'Magento_Checkout/js/model/shipping-rate-processor/new-address',
-        'Magento_Checkout/js/model/shipping-rate-processor/customer-address'
+        'Magento_Checkout/js/model/shipping-rate-processor/customer-address',
+        'Magento_Checkout/js/model/shipping-service'
     ],
-    function (quote, defaultProcessor, customerAddressProcessor) {
+    function (quote, defaultProcessor, customerAddressProcessor, shippingService) {
         'use strict';
 
         var processors = [];
@@ -38,6 +39,10 @@ define(
                 processors[type] = processor;
             },
             estimateShippingMethod: function () {
+                if (shippingService.isLoading()) {
+                    return;
+                }
+
                 var type = quote.shippingAddress().getType();
 
                 if (processors[type]) {
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 54af6ec..454f3d2 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -150,11 +150,7 @@ define(
 
                             if ($.inArray(element.index, observableElements) !== -1 && self.oscValidateAddressData(element.index, addressFlat)) {
                                 shippingRateService.isAddressChange = true;
-
-                                clearTimeout(self.validateAddressTimeout);
-                                self.validateAddressTimeout = setTimeout(function () {
-                                    shippingRateService.estimateShippingMethod();
-                                }, 200);
+                                shippingRateService.estimateShippingMethod();
                             }
                         }
                     });
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 50d6fe2..3085fa5 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -66,7 +66,6 @@ define(
             defaults: {
                 template: ''
             },
-            isCustomerLoggedIn: customer.isLoggedIn,
             quoteIsVirtual: quote.isVirtual(),
 
             canUseShippingAddress: ko.computed(function () {
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index 03d6311..2ead188 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -49,7 +49,7 @@
                 <div class="col-mp mp-6 mp-sm-12 mp-xs-12" data-bind="scope: 'checkout.steps.shipping-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
-                <div class="col-mp mp-sm-12 mp-xs-12" data-bind="scope: 'checkout.steps.billing-step', css: {'mp-12': window.checkoutConfig.quoteData.is_virtual, 'mp-6': !window.checkoutConfig.quoteData.is_virtual}">
+                <div class="col-mp mp-6 mp-sm-12 mp-xs-12" data-bind="scope: 'checkout.steps.billing-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index b8beafb..0d44031 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -40,7 +40,7 @@
 
         <div class="mp-clear"></div>
 
-        <!-- ko if: (!isCustomerLoggedIn() && quoteIsVirtual) -->
+        <!-- ko ifnot: (isCustomerLoggedIn || !quoteIsVirtual) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index 1d5edb5..10f373b 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -63,7 +63,7 @@
         <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
         <!-- /ko -->
 
-        <!-- ko if: (!isCustomerLoggedIn() && !quoteIsVirtual) -->
+        <!-- ko ifnot: (isCustomerLoggedIn || quoteIsVirtual) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
