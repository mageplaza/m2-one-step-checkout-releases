diff --git a/Block/Container/Address.php b/Block/Container/Address.php
index b6eb80f..3c1b0b7 100644
--- a/Block/Container/Address.php
+++ b/Block/Container/Address.php
@@ -303,8 +303,7 @@ class Address extends Container
 
     public function getAddressTriggerElements()
     {
-//        $triggers = ['street1', 'city', 'country_id','region_id', 'postcode', 'telephone'];
-        $triggers = ['country_id','region_id', 'postcode', 'region'];
+        $triggers = ['street1', 'city', 'country_id','region_id', 'postcode', 'telephone'];
 
         return $triggers;
     }
diff --git a/Block/Container/Form.php b/Block/Container/Form.php
index e44f08d..d7dc096 100644
--- a/Block/Container/Form.php
+++ b/Block/Container/Form.php
@@ -51,7 +51,7 @@ class Form extends Container
         return array(
             'savePaymentUrl'       => $this->getSavePaymentUrl(),
             'defaultPaymentMethod' => $this->_checkoutPayment->getDefaultPaymentMethod(),
-            'baseUrl' => $this->getUrl('', ['_secure' => true])
+            'baseUrl' => $this->getBaseUrl()
         );
     }
 
diff --git a/Controller/Ajax/AbstractCheckout.php b/Controller/Ajax/AbstractCheckout.php
index f0a35f1..eb413e2 100644
--- a/Controller/Ajax/AbstractCheckout.php
+++ b/Controller/Ajax/AbstractCheckout.php
@@ -102,7 +102,7 @@ abstract class AbstractCheckout extends Action
 		$this->_resultRawFactory            = $resultRawFactory;
 		$this->_giftMessage                 = $giftMessage;
 		$this->quoteRepository              = $quoteRepository;
-		$this->addressRepository            = $addressRepository;
+		$this->addressRepository = $addressRepository;
 	}
 
 
@@ -186,11 +186,6 @@ abstract class AbstractCheckout extends Action
 		);
 
 		try {
-			$this->getShippingAddress()
-				->addData($dataShipping)
-				->setCollectShippingRates(true)
-				->save();
-
 			$customerAddressId = $dataShipping['same_as_billing'] ? $this->getRequest()->getPost('billing_address_id', null) : $this->getRequest()->getPost('shipping_address_id', null);
 
 			$this->getOnepage()->saveShipping($dataShipping, $customerAddressId);
@@ -264,7 +259,7 @@ abstract class AbstractCheckout extends Action
 
 	public function collectQuote()
 	{
-		$this->getQuote()->setTotalsCollectedFlag(false)->collectTotals()->save();
+		$this->getQuote()->collectTotals()->save();
 	}
 
 	/**
@@ -298,9 +293,7 @@ abstract class AbstractCheckout extends Action
 		];
 		try {
 			if ($this->getRequest()->isPost()) {
-				$this->getOnepage()->getQuote()->getShippingAddress()
-					->setCollectShippingRates(true);
-				$this->collectQuote();
+				$this->getOnepage()->getQuote()->collectTotals()->save();
 				$result['blocks'] = $this->getBlockHelper()->getActionBlocks();
 				if ($this->_helperConfig->showGrandTotal()) {
 					$result['grand_total'] = $this->getGrandTotal();
diff --git a/view/frontend/web/js/osc/address/region-updater.js b/view/frontend/web/js/osc/address/region-updater.js
index bf55cac..784de1e 100644
--- a/view/frontend/web/js/osc/address/region-updater.js
+++ b/view/frontend/web/js/osc/address/region-updater.js
@@ -17,7 +17,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-define(["jquery", "prototype"], function (jq) {
+define(["prototype"], function () {
     RegionUpdater = Class.create();
     RegionUpdater.prototype = {
         initialize: function (countryEl, regionTextEl, regionSelectEl, regions, disableAction, clearRegionValueOnDisable) {
@@ -61,7 +61,7 @@ define(["jquery", "prototype"], function (jq) {
                     return;
                 }
                 var form = currentElement.form,
-                    validationInstance = form ? jq(form).data('validation') : null,
+                    validationInstance = form ? jQuery(form).data('validation') : null,
                     field = currentElement.up('.field') || new Element('div');
 
                 if (validationInstance) {
