diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index 8775312..be2aea4 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -116,17 +116,11 @@ class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcesso
 		}
 
 		/** Remove billing customer email if quote is not virtual */
-		if (!$this->checkoutSession->getQuote()->isVirtual() && !$this->_oscHelper->isShowBillingAddressBeforeShippingAddress()) {
+		if (!$this->checkoutSession->getQuote()->isVirtual()) {
 			unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
 				['children']['customer-email']);
 		}
 
-		/** Remove shipping customer email if show billing address before shipping address is enable */
-		if ($this->_oscHelper->isShowBillingAddressBeforeShippingAddress()) {
-			unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-				['children']['customer-email']);
-		}
-
 		/** Remove billing address in payment method content */
 		$fields = &$jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
 		['payment']['children']['payments-list']['children'];
diff --git a/Block/Order/Totals.php b/Block/Order/Totals.php
index 2fd37ae..f012c96 100644
--- a/Block/Order/Totals.php
+++ b/Block/Order/Totals.php
@@ -37,7 +37,7 @@ class Totals extends Template
 	{
 		$totalsBlock = $this->getParentBlock();
 		$source      = $totalsBlock->getSource();
-		if ($source && !empty($source->getOscGiftWrapAmount())) {
+		if ($source && $source->getOscGiftWrapAmount() > 0.0001) {
 			$totalsBlock->addTotal(new DataObject([
 				'code'  => 'gift_wrap',
 				'field' => 'osc_gift_wrap_amount',
diff --git a/Block/Order/View/Survey.php b/Block/Order/View/Survey.php
deleted file mode 100644
index a7183d9..0000000
--- a/Block/Order/View/Survey.php
+++ /dev/null
@@ -1,83 +0,0 @@
-<?php
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * https://mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza
- * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
- * @license     http://mageplaza.com/LICENSE.txt
- */
-namespace Mageplaza\Osc\Block\Order\View;
-
-/**
- * Class Survey
- * @package Mageplaza\Osc\Block\Order\View
- */
-class Survey extends \Magento\Framework\View\Element\Template
-{
-    /**
-     * @type \Magento\Framework\Registry|null
-     */
-    protected $_coreRegistry = null;
-
-    /**
-     * @param \Magento\Framework\View\Element\Template\Context $context
-     * @param \Magento\Framework\Registry $registry
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Framework\View\Element\Template\Context $context,
-        \Magento\Framework\Registry $registry,
-        array $data = []
-    ) {
-    
-        $this->_coreRegistry = $registry;
-
-        parent::__construct($context, $data);
-    }
-
-	/**
-	 * @return string
-	 */
-    public function getSurveyQuestion()
-    {
-        if ($order = $this->getOrder()) {
-            return $order->getOscSurveyQuestion();
-        }
-
-        return '';
-    }
-
-	/**
-	 * @return string
-	 */
-	public function getSurveyAnswers()
-	{
-		if ($order = $this->getOrder()) {
-			return $order->getOscSurveyAnswers();
-		}
-
-		return '';
-	}
-
-    /**
-     * Get current order
-     *
-     * @return mixed
-     */
-    public function getOrder()
-    {
-        return $this->_coreRegistry->registry('current_order');
-    }
-}
diff --git a/Block/Survey.php b/Block/Survey.php
deleted file mode 100644
index 67020e9..0000000
--- a/Block/Survey.php
+++ /dev/null
@@ -1,105 +0,0 @@
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
- * @category   Mageplaza
- * @package    Mageplaza_Osc
- * @version    3.0.0
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-namespace Mageplaza\Osc\Block;
-
-use Magento\Framework\View\Element\Template;
-use Mageplaza\Osc\Helper\Data as HelperData;
-use Magento\Checkout\Model\Session;
-
-/**
- * Class Survey
- * @package Mageplaza\Osc\Block\Survey
- */
-class Survey extends Template
-{
-	/**
-	 * @var \Mageplaza\Osc\Helper\Data
-	 */
-	protected $_helperData;
-
-	/**
-	 * @var $_helperConfig
-	 */
-	protected $_helperConfig;
-
-	/**
-	 * @var \Magento\Checkout\Model\Session
-	 */
-	protected $_checkoutSession;
-
-	/**
-	 * @param \Magento\Framework\View\Element\Template\Context $context
-	 * @param \Mageplaza\Osc\Helper\Data $helperData
-	 * @param array $data
-	 */
-	public function __construct(
-		Template\Context $context,
-		HelperData $helperData,
-		Session $checkoutSession,
-		array $data = []
-	) {
-
-		$this->_helperData 		= $helperData;
-		$this->_checkoutSession = $checkoutSession;
-
-		parent::__construct($context, $data);
-		$this->getLastOrderId();
-	}
-
-	/**
-	 * @return bool
-	 */
-	public function isEnableSurvey()
-	{
-		return $this->_helperData->getConfig()->isDisableSurvey();
-	}
-
-	public function getLastOrderId(){
-		$orderId = $this->_checkoutSession->getLastRealOrder()->getEntityId();
-		$this->_checkoutSession->setOscData(array('survey'=>array('orderId' => $orderId )));
-	}
-
-	/**
-	 * @return mixed
-	 */
-	public function getSurveyQuestion(){
-		return $this->_helperData->getConfig()->getSurveyQuestion();
-	}
-
-	/**
-	 * @return array
-	 */
-	public function getAllSurveyAnswer(){
-		$answers=[];
-		foreach ($this->_helperData->getConfig()->getSurveyAnswers() as $key=>$item){
-			$answers[]=['id'=>$key,'value'=>$item['value']];
-		}
-		return $answers;
-	}
-
-	/**
-	 * @return mixed
-	 */
-	public function isAllowCustomerAddOtherOption(){
-		return $this->_helperData->getConfig()->isAllowCustomerAddOtherOption();
-	}
-}
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index f3ede5e..d49c4bc 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -31,7 +31,8 @@ class Index extends \Magento\Checkout\Controller\Cart\Add
      */
     public function execute()
     {
-		$productId = $this->getRequest()->getParam('id') ? $this->getRequest()->getParam('id') : 11;
+//        $this->_objectManager->create('Magento\Catalog\Model\ResourceModel\Product\Collection');
+        $productId = 8;
         $storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
         $product = $this->productRepository->getById($productId, false, $storeId);
 
diff --git a/Controller/Survey/Save.php b/Controller/Survey/Save.php
deleted file mode 100644
index d035fc9..0000000
--- a/Controller/Survey/Save.php
+++ /dev/null
@@ -1,104 +0,0 @@
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
-namespace Mageplaza\Osc\Controller\Survey;
-
-use Magento\Framework\App\Action\Action;
-use Magento\Framework\App\Action\Context;
-use Magento\Framework\Json\Helper\Data;
-use Magento\Checkout\Model\Session;
-use Magento\Sales\Model\Order;
-use Mageplaza\Osc\Helper\Config as OscConfig;
-
-class Save extends Action
-{
-
-	/**
-	 * @var \Magento\Framework\Json\Helper\Data
-	 */
-	protected $jsonHelper;
-
-	/**
-	 * @var \Magento\Checkout\Model\Session
-	 */
-	protected $_checkoutSession;
-
-	/**
-	 * @var \Magento\Sales\Model\Order
-	 */
-	protected $_order;
-
-	/**
-	 * @var \Mageplaza\Osc\Helper\Config
-	 */
-	protected $oscConfig;
-
-	/**
-	 * Save constructor.
-	 * @param \Magento\Framework\App\Action\Context $context
-	 * @param \Magento\Framework\Json\Helper\Data $jsonHelper
-	 * @param \Magento\Checkout\Model\Session $checkoutSession
-	 * @param \Magento\Sales\Model\Order $order
-	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
-	 */
-	public function __construct(
-		Context $context,
-		Data $jsonHelper,
-		Session $checkoutSession,
-		Order $order,
-		OscConfig $oscConfig
-	) {
-
-		$this->jsonHelper = $jsonHelper;
-		$this->_checkoutSession = $checkoutSession;
-		$this->_order			= $order;
-		$this->oscConfig		= $oscConfig;
-		parent::__construct($context);
-	}
-
-	/**
-	 * @return mixed
-	 */
-	public function execute()
-	{
-		$response= array();
-		if($this->getRequest()->getParam('answerChecked') && isset( $this->_checkoutSession->getOscData()['survey'])){
-			try{
-				$order= $this->_order->load($this->_checkoutSession->getOscData()['survey']['orderId']);
-				$answers = '';
-				foreach ($this->getRequest()->getParam('answerChecked') as $item){
-					$answers.= $item .' - ';
-				}
-				$order->setData('osc_survey_question', $this->oscConfig->getSurveyQuestion());
-				$order->setData('osc_survey_answers', substr($answers, 0, -2));
-				$order->save();
-
-				$response['status'] = 'success';
-				$response['message']='Thank you for completing our survey!';
-				$this->_checkoutSession->unsOscData();
-			}catch (\Exception $e){
-				$response['status'] = 'error';
-				$response['message'] = "Can't save survey answer. Please try again! ";
-			}
-		return $this->getResponse()->representJson($this->jsonHelper->jsonEncode($response));
-		}
-	}
-
-}
diff --git a/Helper/Config.php b/Helper/Config.php
index f21c4c8..0f92d0f 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -30,7 +30,6 @@ use Magento\Framework\ObjectManagerInterface;
 use Magento\Store\Model\StoreManagerInterface;
 use Mageplaza\Core\Helper\AbstractData;
 use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
-use Magento\Framework\Module\Manager as ModuleManager;
 
 /**
  * Class Config
@@ -66,11 +65,6 @@ class Config extends AbstractData
 	private $attributeMetadataDataProvider;
 
 	/**
-	 * @type \Magento\Framework\Module\Manager
-	 */
-	protected $_moduleManager;
-
-	/**
 	 * Config constructor.
 	 * @param \Magento\Framework\App\Helper\Context $context
 	 * @param \Magento\Framework\ObjectManagerInterface $objectManager
@@ -79,7 +73,6 @@ class Config extends AbstractData
 	 * @param \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory $addressesFactory
 	 * @param \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory $customerFactory
 	 * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
-	 * @param \Magento\Framework\Module\Manager $moduleManager
 	 */
 	public function __construct(
 		Context $context,
@@ -88,8 +81,7 @@ class Config extends AbstractData
 		Address $addressHelper,
 		AddressFactory $addressesFactory,
 		CustomerFactory $customerFactory,
-		AttributeMetadataDataProvider $attributeMetadataDataProvider,
-		ModuleManager $moduleManager
+		AttributeMetadataDataProvider $attributeMetadataDataProvider
 	)
 	{
 		parent::__construct($context, $objectManager, $storeManager);
@@ -98,7 +90,6 @@ class Config extends AbstractData
 		$this->_addressesFactory             = $addressesFactory;
 		$this->_customerFactory              = $customerFactory;
 		$this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-		$this->_moduleManager                = $moduleManager;
 	}
 
 	/**
@@ -374,16 +365,6 @@ class Config extends AbstractData
 	}
 
 	/**
-	 * Redirect To OneStepCheckout
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isRedirectToOneStepCheckout($store = null)
-	{
-		return boolval($this->getGeneralConfig('redirect_to_one_step_checkout', $store));
-	}
-
-	/**
 	 * Show billing address
 	 *
 	 * @param null $store
@@ -395,17 +376,6 @@ class Config extends AbstractData
 	}
 
 	/**
-	 * Show billing address before shipping address
-	 *
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isShowBillingAddressBeforeShippingAddress($store = null)
-	{
-		return $this->getGeneralConfig('show_billing_before_shipping', $store) && $this->getShowBillingAddress();
-	}
-
-	/**
 	 * Google api key
 	 *
 	 * @param null $store
@@ -572,7 +542,7 @@ class Config extends AbstractData
 		$giftWrapEnabled = $this->getDisplayConfig('is_enabled_gift_wrap', $store);
 		$giftWrapAmount  = $this->getOrderGiftwrapAmount();
 
-		return !$giftWrapEnabled || ($giftWrapAmount < 0);
+		return !$giftWrapEnabled || ($giftWrapAmount < 0.0001);
 	}
 
 	/**
@@ -686,46 +656,6 @@ class Config extends AbstractData
 	}
 
 	/**
-	 * Survey
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isDisableSurvey($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_survey', $store);
-	}
-
-	/**
-	 * Survey Question
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getSurveyQuestion($store = null)
-	{
-		return $this->getDisplayConfig('survey_question', $store);
-	}
-
-	/**
-	 * Survey Answers
-	 * @param null $stores
-	 * @return mixed
-	 */
-	public function getSurveyAnswers($stores = null)
-	{
-		return unserialize($this->getDisplayConfig('survey_answers', $stores));
-	}
-
-	/**
-	 * Allow Customer Add Other Option
-	 * @param null $stores
-	 * @return mixed
-	 */
-	public function isAllowCustomerAddOtherOption($stores = null)
-	{
-		return $this->getDisplayConfig('allow_customer_add_other_option', $stores);
-	}
-
-	/**
 	 * Get layout tempate: 1 or 2 or 3 columns
 	 *
 	 * @param null $store
@@ -747,14 +677,4 @@ class Config extends AbstractData
 
 		return $this->getConfigValue($code, $store);
 	}
-
-
-	/***************************** Compatible Modules *****************************
-	 *
-	 * @return bool
-	 */
-	public function isEnabledMultiSafepay()
-	{
-		return $this->_moduleManager->isOutputEnabled('MultiSafepay_Connect');
-	}
 }
diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index bc9d96f..6a06f0a 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -33,10 +33,6 @@ use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Mageplaza\Osc\Api\CheckoutManagementInterface;
 use Mageplaza\Osc\Helper\Config as OscConfig;
 use Mageplaza\Osc\Model\OscDetailsFactory;
-use Magento\Customer\Model\Session as CustomerSession;
-use Magento\Quote\Model\Quote\TotalsCollector;
-use Magento\Quote\Api\Data\AddressInterface;
-use Magento\Quote\Model\Cart\ShippingMethodConverter;
 
 /**
  * Class CheckoutManagement
@@ -103,41 +99,20 @@ class CheckoutManagement implements CheckoutManagementInterface
 	 */
 	protected $giftMessageManagement;
 
-	/**
-	 * @var \Magento\Customer\Model\Session
-	 */
-	protected $_customerSession;
-
-	/**
-	 * @var \Magento\Quote\Model\Quote\TotalsCollector
-	 */
-	protected $_totalsCollector;
-
-	/**
-	 * @var \Magento\Quote\Api\Data\AddressInterface
-	 */
-	protected $_addressInterface;
-
-	/**
-	 * @var \Magento\Quote\Model\Cart\ShippingMethodConverter
-	 */
-	protected $_shippingMethodConverter;
-
 
 	/**
 	 * CheckoutManagement constructor.
-	 * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
+	 * @param CartRepositoryInterface $cartRepository
 	 * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
-	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
-	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
-	 * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
-	 * @param \Magento\Framework\UrlInterface $urlBuilder
+	 * @param ShippingMethodManagementInterface $shippingMethodManagement
+	 * @param PaymentMethodManagementInterface $paymentMethodManagement
+	 * @param CartTotalRepositoryInterface $cartTotalsRepository
+	 * @param UrlInterface $urlBuilder
 	 * @param \Magento\Checkout\Model\Session $checkoutSession
 	 * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
-	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
-	 * @param \Magento\GiftMessage\Model\Message $giftMessage
-	 * @param \Magento\GiftMessage\Model\GiftMessageManager $giftMessageManager
-	 * @param \Magento\Customer\Model\Session $customerSession
+	 * @param OscConfig $oscConfig
+	 * @param Message $giftMessage
+	 * @param GiftMessageManager $giftMessageManager
 	 */
 	public function __construct(
 		CartRepositoryInterface $cartRepository,
@@ -150,11 +125,7 @@ class CheckoutManagement implements CheckoutManagementInterface
 		\Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement,
 		OscConfig $oscConfig,
 		Message $giftMessage,
-		GiftMessageManager $giftMessageManager,
-		customerSession $customerSession,
-		TotalsCollector $totalsCollector,
-		AddressInterface $addressInterface,
-		ShippingMethodConverter $shippingMethodConverter
+		GiftMessageManager $giftMessageManager
 	)
 	{
 		$this->cartRepository                = $cartRepository;
@@ -168,10 +139,6 @@ class CheckoutManagement implements CheckoutManagementInterface
 		$this->oscConfig                     = $oscConfig;
 		$this->giftMessage                   = $giftMessage;
 		$this->giftMessageManagement         = $giftMessageManager;
-		$this->_customerSession              = $customerSession;
-		$this->_totalsCollector              = $totalsCollector;
-		$this->_addressInterface             = $addressInterface;
-		$this->_shippingMethodConverter      = $shippingMethodConverter;
 	}
 
 	/**
@@ -179,10 +146,6 @@ class CheckoutManagement implements CheckoutManagementInterface
 	 */
 	public function updateItemQty($cartId, $itemId, $itemQty)
 	{
-		if ($itemQty == 0) {
-			return $this->removeItemById($cartId, $itemId);
-		}
-
 		/** @var \Magento\Quote\Model\Quote $quote */
 		$quote     = $this->cartRepository->getActive($cartId);
 		$quoteItem = $quote->getItemById($itemId);
@@ -269,7 +232,7 @@ class CheckoutManagement implements CheckoutManagementInterface
 			$oscDetails->setRedirectUrl($this->_urlBuilder->getUrl('checkout/cart'));
 		} else {
 			if ($quote->getShippingAddress()->getCountryId()) {
-				$oscDetails->setShippingMethods($this->getShippingMethods($quote));
+				$oscDetails->setShippingMethods($this->shippingMethodManagement->getList($quote->getId()));
 			}
 			$oscDetails->setPaymentMethods($this->paymentMethodManagement->getList($quote->getId()));
 			$oscDetails->setTotals($this->cartTotalsRepository->get($quote->getId()));
@@ -294,9 +257,6 @@ class CheckoutManagement implements CheckoutManagementInterface
 			$this->addGiftMessage($cartId, $additionInformation);
 
 			if ($addressInformation->getShippingAddress()) {
-				if ($this->_customerSession->isLoggedIn() && isset($additionInformation['billing-same-shipping']) && !$additionInformation['billing-same-shipping']) {
-					$addressInformation->getShippingAddress()->setSaveInAddressBook(0);
-				}
 				$this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
 			}
 		} catch (\Exception $e) {
@@ -307,27 +267,6 @@ class CheckoutManagement implements CheckoutManagementInterface
 	}
 
 	/**
-	 * @param \Magento\Quote\Model\Quote $quote
-	 * @return array
-	 */
-	public function getShippingMethods(\Magento\Quote\Model\Quote $quote)
-	{
-		$result          = [];
-		$shippingAddress = $quote->getShippingAddress();
-		$shippingAddress->addData($this->_addressInterface->getData());
-		$shippingAddress->setCollectShippingRates(true);
-		$this->_totalsCollector->collectAddressTotals($quote, $shippingAddress);
-		$shippingRates = $shippingAddress->getGroupedAllShippingRates();
-		foreach ($shippingRates as $carrierRates) {
-			foreach ($carrierRates as $rate) {
-				$result[] = $this->_shippingMethodConverter->modelToDataObject($rate, $quote->getQuoteCurrencyCode());
-			}
-		}
-
-		return $result;
-	}
-
-	/**
 	 * @param $cartId
 	 * @param $additionInformation
 	 * @throws \Magento\Framework\Exception\CouldNotSaveException
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index 333ac80..249cfd8 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -84,12 +84,12 @@ class DefaultConfigProvider implements ConfigProviderInterface
 		ModuleManager $moduleManager
 	)
 	{
-		$this->checkoutSession           = $checkoutSession;
-		$this->paymentMethodManagement   = $paymentMethodManagement;
-		$this->shippingMethodManagement  = $shippingMethodManagement;
-		$this->oscConfig                 = $oscConfig;
-		$this->giftMessageConfigProvider = $configProvider;
-		$this->moduleManager             = $moduleManager;
+		$this->checkoutSession         				= $checkoutSession;
+		$this->paymentMethodManagement  			= $paymentMethodManagement;
+		$this->shippingMethodManagement 			= $shippingMethodManagement;
+		$this->oscConfig                			= $oscConfig;
+		$this->giftMessageConfigProvider 			= $configProvider;
+		$this->moduleManager						= $moduleManager;
 	}
 
 	/**
@@ -118,25 +118,24 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	private function getOscConfig()
 	{
 		return [
-			'addressFields'             => $this->getAddressFields(),
-			'autocomplete'              => [
+			'addressFields'      	=> $this->getAddressFields(),
+			'autocomplete'       	=> [
 				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
 				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
 			],
-			'register'                  => [
+			'register'           	=> [
 				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
 				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
 			],
-			'allowGuestCheckout'        => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
-			'showBillingAddress'        => $this->oscConfig->getShowBillingAddress(),
-			'showBillingBeforeShipping' => $this->oscConfig->isShowBillingAddressBeforeShippingAddress(),
-			'newsletterDefault'         => $this->oscConfig->isSubscribedByDefault(),
-			'isUsedGiftWrap'            => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
-			'giftMessageOptions'        => $this->giftMessageConfigProvider->getConfig(),
-			'isDisplaySocialLogin'      => $this->isDisplaySocialLogin(),
-			'deliveryTimeOptions'       => [
-				'deliveryTimeFormat' => $this->oscConfig->getDeliveryTimeFormat(),
-				'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff()
+			'allowGuestCheckout' 	=> $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
+			'showBillingAddress' 	=> $this->oscConfig->getShowBillingAddress(),
+			'newsletterDefault' 	=> $this->oscConfig->isSubscribedByDefault(),
+			'isUsedGiftWrap'     	=> (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
+			'giftMessageOptions' 	=> $this->giftMessageConfigProvider->getConfig(),
+			'isDisplaySocialLogin'	=> $this->isDisplaySocialLogin(),
+			'deliveryTimeOptions'	=> [
+				'deliveryTimeFormat'		=> $this->oscConfig->getDeliveryTimeFormat(),
+				'deliveryTimeOff'			=> $this->oscConfig->getDeliveryTimeOff()
 			]
 		];
 	}
@@ -193,8 +192,7 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	/**
 	 * @return bool
 	 */
-	private function isDisplaySocialLogin()
-	{
+	private function isDisplaySocialLogin(){
 
 		return $this->moduleManager->isOutputEnabled('Mageplaza_SocialLogin') && !$this->oscConfig->isDisabledSocialLoginOnCheckout();
 	}
diff --git a/Model/System/Config/Source/PaymentMethods.php b/Model/System/Config/Source/PaymentMethods.php
index f61bf14..2ff5eda 100644
--- a/Model/System/Config/Source/PaymentMethods.php
+++ b/Model/System/Config/Source/PaymentMethods.php
@@ -22,7 +22,6 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Option\ArrayInterface;
 use Magento\Store\Model\ScopeInterface;
-use Mageplaza\Osc\Helper\Config as OscConfig;
 
 /**
  * Class Methods
@@ -41,24 +40,16 @@ class PaymentMethods implements ArrayInterface
 	protected $_paymentMethodFactory;
 
 	/**
-	 * @type \Mageplaza\Osc\Helper\Config
-	 */
-	protected $_oscConfig;
-
-	/**
 	 * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
 	 * @param \Magento\Payment\Model\Method\Factory $paymentMethodFactory
-	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
 	 */
 	public function __construct(
 		\Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
-		\Magento\Payment\Model\Method\Factory $paymentMethodFactory,
-		OscConfig $oscConfig
+		\Magento\Payment\Model\Method\Factory $paymentMethodFactory
 	)
 	{
 		$this->_scopeConfig          = $scopeConfig;
 		$this->_paymentMethodFactory = $paymentMethodFactory;
-		$this->_oscConfig            = $oscConfig;
 	}
 
 	/**
@@ -86,22 +77,16 @@ class PaymentMethods implements ArrayInterface
 	 */
 	public function getActiveMethods()
 	{
-		$methods       = [];
-		$paymentConfig = $this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null);
-		if ($this->_oscConfig->isEnabledMultiSafepay()) {
-			$paymentConfig = array_merge($this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null), $this->_scopeConfig->getValue('gateways', ScopeInterface::SCOPE_STORE, null));
-		}
-		foreach ($paymentConfig as $code => $data) {
+		$methods = [];
+		foreach ($this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null) as $code => $data) {
 			if (isset($data['active'], $data['model']) && (bool)$data['active']) {
 				try {
-					if (class_exists($data['model'])) {
-						$methodModel = $this->_paymentMethodFactory->create($data['model']);
-						$methodModel->setStore(null);
-						if ($methodModel->getConfigData('active', null)) {
-							$methods[$code] = $methodModel;
-						}
-					}
+					$methodModel = $this->_paymentMethodFactory->create($data['model']);
 
+					$methodModel->setStore(null);
+					if ($methodModel->getConfigData('active', null)) {
+						$methods[$code] = $methodModel;
+					}
 				} catch (\Exception $e) {
 					continue;
 				}
diff --git a/Model/System/Config/Source/Survey.php b/Model/System/Config/Source/Survey.php
deleted file mode 100644
index a36a3ce..0000000
--- a/Model/System/Config/Source/Survey.php
+++ /dev/null
@@ -1,50 +0,0 @@
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
-
-namespace Mageplaza\Osc\Model\System\Config\Source;
-class Survey extends \Magento\Config\Block\System\Config\Form\Field\FieldArray\AbstractFieldArray{
-	/**
-	 * @var \Magento\Framework\Data\Form\Element\Factory
-	 */
-	protected $_elementFactory;
-
-	/**
-	 * @param \Magento\Backend\Block\Template\Context $context
-	 * @param \Magento\Framework\Data\Form\Element\Factory $elementFactory
-	 * @param array $data
-	 */
-	public function __construct(
-		\Magento\Backend\Block\Template\Context $context,
-		\Magento\Framework\Data\Form\Element\Factory $elementFactory,
-		array $data = []
-	) {
-
-		$this->_elementFactory  = $elementFactory;
-		parent::__construct($context, $data);
-	}
-	protected function _construct()
-	{
-		$this->addColumn('value', ['label' => __('Options')]);
-		$this->_addAfter = false;
-		$this->_addButtonLabel = __('Add');
-		parent::_construct();
-	}
-}
\ No newline at end of file
diff --git a/Model/Total/Quote/GiftWrap.php b/Model/Total/Quote/GiftWrap.php
index 8a76fdd..4a8b169 100644
--- a/Model/Total/Quote/GiftWrap.php
+++ b/Model/Total/Quote/GiftWrap.php
@@ -137,7 +137,7 @@ class GiftWrap extends AbstractTotal
 	{
 		if ($this->_baseGiftWrapAmount == null) {
 			$baseOscGiftWrapAmount = $this->_helperConfig->getOrderGiftwrapAmount();
-			if ($baseOscGiftWrapAmount == 0) {
+			if ($baseOscGiftWrapAmount < 0.0001) {
 				return 0;
 			}
 
diff --git a/Observer/CheckoutSubmitBefore.php b/Observer/CheckoutSubmitBefore.php
index 2e53782..96f70e4 100644
--- a/Observer/CheckoutSubmitBefore.php
+++ b/Observer/CheckoutSubmitBefore.php
@@ -23,7 +23,6 @@ namespace Mageplaza\Osc\Observer;
 use Magento\Framework\Event\ObserverInterface;
 use Magento\Quote\Model\Quote;
 use Magento\Quote\Model\CustomerManagement;
-use Mageplaza\Osc\Helper\Config as OscConfig;
 
 /**
  * Class CheckoutSubmitBefore
@@ -57,26 +56,18 @@ class CheckoutSubmitBefore implements ObserverInterface
 	protected $customerManagement;
 
 	/**
-	 * @var \Mageplaza\Osc\Helper\Config
-	 */
-	protected $oscConfig;
-
-	/**
-	 * CheckoutSubmitBefore constructor.
 	 * @param \Magento\Checkout\Model\Session $checkoutSession
 	 * @param \Magento\Framework\DataObject\Copy $objectCopyService
 	 * @param \Magento\Framework\Api\DataObjectHelper $dataObjectHelper
 	 * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
 	 * @param \Magento\Quote\Model\CustomerManagement $customerManagement
-	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
 	 */
 	public function __construct(
 		\Magento\Checkout\Model\Session $checkoutSession,
 		\Magento\Framework\DataObject\Copy $objectCopyService,
 		\Magento\Framework\Api\DataObjectHelper $dataObjectHelper,
 		\Magento\Customer\Api\AccountManagementInterface $accountManagement,
-		CustomerManagement $customerManagement,
-		OscConfig $oscConfig
+		CustomerManagement $customerManagement
 	)
 	{
 		$this->checkoutSession    = $checkoutSession;
@@ -84,7 +75,6 @@ class CheckoutSubmitBefore implements ObserverInterface
 		$this->dataObjectHelper   = $dataObjectHelper;
 		$this->accountManagement  = $accountManagement;
 		$this->customerManagement = $customerManagement;
-		$this->oscConfig          = $oscConfig;
 	}
 
 	/**
@@ -150,27 +140,16 @@ class CheckoutSubmitBefore implements ObserverInterface
 			->setData('should_ignore_validation', true);
 
 		if ($shipping) {
-			if ($this->oscConfig->isShowBillingAddressBeforeShippingAddress()) {
-				if (isset($oscData['billing-same-shipping']) && $oscData['billing-same-shipping']) {
-					$customerShippingData = $shipping->exportCustomerAddress();
-					$customerShippingData->setIsDefaultShipping(true)
-						->setData('should_ignore_validation', true);
-					$shipping->setCustomerAddressData($customerShippingData);
-					// Add shipping address to quote since customer Data Object does not hold address information
-					$quote->addCustomerAddress($customerShippingData);
-				}
+			if (isset($oscData['same_as_shipping']) && $oscData['same_as_shipping']) {
+				$shipping->setCustomerAddressData($customerBillingData);
+				$customerBillingData->setIsDefaultShipping(true);
 			} else {
-				if (isset($oscData['same_as_shipping']) && $oscData['same_as_shipping']) {
-					$shipping->setCustomerAddressData($customerBillingData);
-					$customerBillingData->setIsDefaultShipping(true);
-				} else {
-					$customerShippingData = $shipping->exportCustomerAddress();
-					$customerShippingData->setIsDefaultShipping(true)
-						->setData('should_ignore_validation', true);
-					$shipping->setCustomerAddressData($customerShippingData);
-					// Add shipping address to quote since customer Data Object does not hold address information
-					$quote->addCustomerAddress($customerShippingData);
-				}
+				$customerShippingData = $shipping->exportCustomerAddress();
+				$customerShippingData->setIsDefaultShipping(true)
+					->setData('should_ignore_validation', true);
+				$shipping->setCustomerAddressData($customerShippingData);
+				// Add shipping address to quote since customer Data Object does not hold address information
+				$quote->addCustomerAddress($customerShippingData);
 			}
 		} else {
 			$customerBillingData->setIsDefaultShipping(true);
@@ -182,7 +161,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 		// If customer is created, set customerId for address to avoid create more address when checkout
 		if ($customerId = $quote->getCustomerId()) {
 			$billing->setCustomerId($customerId);
-			if ($shipping) {
+			if($shipping) {
 				$shipping->setCustomerId($customerId);
 			}
 		}
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index 60252c3..3981962 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -65,7 +65,7 @@ class QuoteSubmitBefore implements ObserverInterface
         }
 
         $address = $quote->getShippingAddress();
-        if ($address->getUsedGiftWrap() && $address->hasData('osc_gift_wrap_amount') && $address->getUsedGiftWrap()) {
+        if ($address->getUsedGiftWrap() && $address->hasData('osc_gift_wrap_amount')) {
             $order->setData('gift_wrap_type', $address->getGiftWrapType())
                 ->setData('osc_gift_wrap_amount', $address->getOscGiftWrapAmount())
                 ->setData('base_osc_gift_wrap_amount', $address->getBaseOscGiftWrapAmount());
diff --git a/Observer/RedirectToOneStepCheckout.php b/Observer/RedirectToOneStepCheckout.php
deleted file mode 100644
index 88ce687..0000000
--- a/Observer/RedirectToOneStepCheckout.php
+++ /dev/null
@@ -1,74 +0,0 @@
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
-
-namespace Mageplaza\Osc\Observer;
-
-use Magento\Checkout\Model\Session as CheckoutSession;
-use Magento\Framework\Event\Observer;
-use Magento\Framework\Event\ObserverInterface;
-use Magento\Framework\UrlInterface;
-use Mageplaza\Osc\Helper\Config as HelperConfig;
-
-/**
- * Class RedirectToOneStepCheckout
- * @package Mageplaza\Osc\Observer
- */
-class RedirectToOneStepCheckout implements ObserverInterface
-{
-	/** @var UrlInterface */
-	protected $_url;
-
-	/** @var HelperConfig */
-	protected $_helperConfig;
-
-	/** @var CheckoutSession */
-	protected $checkoutSession;
-
-	/**
-	 * RedirectToOneStepCheckout constructor.
-	 * @param \Magento\Framework\UrlInterface $url
-	 * @param \Mageplaza\Osc\Helper\Config $helperConfig
-	 * @param \Magento\Checkout\Model\Session $checkoutSession
-	 */
-	public function __construct(
-		UrlInterface $url,
-		HelperConfig $helperConfig,
-		CheckoutSession $checkoutSession
-	)
-	{
-		$this->_url            = $url;
-		$this->_helperConfig   = $helperConfig;
-		$this->checkoutSession = $checkoutSession;
-	}
-
-	/**
-	 * @param Observer $observer
-	 * @return void
-	 * @SuppressWarnings(PHPMD.CyclomaticComplexity)
-	 */
-	public function execute(Observer $observer)
-	{
-		if ($this->_helperConfig->isRedirectToOneStepCheckout()) {
-			$observer->getEvent()->getResponse()->setRedirect($this->_url->getUrl('onestepcheckout'));
-			$this->checkoutSession->setNoCartRedirect(true);
-		}
-	}
-}
\ No newline at end of file
diff --git a/Setup/UpgradeData.php b/Setup/UpgradeData.php
index 6258f2e..ec17588 100644
--- a/Setup/UpgradeData.php
+++ b/Setup/UpgradeData.php
@@ -90,10 +90,6 @@ class UpgradeData implements UpgradeDataInterface
 		if (version_compare($context->getVersion(), '2.1.1') < 0) {
 			$salesInstaller->addAttribute('order', 'osc_delivery_time', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
 		}
-		if (version_compare($context->getVersion(), '2.1.2') < 0) {
-			$salesInstaller->addAttribute('order', 'osc_survey_question', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
-			$salesInstaller->addAttribute('order', 'osc_survey_answers', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
-		}
 
 		$setup->endSetup();
 	}
diff --git a/composer.json b/composer.json
index 33967c5..dfc24c8 100644
--- a/composer.json
+++ b/composer.json
@@ -1,8 +1,8 @@
 {
-    "name": "Mageplaza\/Osc",
+    "name": "mageplaza/magento-2-one-step-checkout-extension",
     "description": "",
     "require": {
-        "php": "~5.5.0|~5.6.0"
+        "mageplaza/core-m2": "^1.3|dev-master"
     },
     "type": "magento2-module",
     "version": "2.0.0",
@@ -16,13 +16,5 @@
         "psr-4": {
             "Mageplaza\\Osc\\": ""
         }
-    },
-    "extra": {
-        "map": [
-            [
-                "*",
-                "Mageplaza\/Osc"
-            ]
-        ]
     }
 }
\ No newline at end of file
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index fc94df1..48a867a 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -63,26 +63,12 @@
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Allow checking out as a guest. Guest can create an account in the checkout page.</comment>
                 </field>
-                <field id="redirect_to_one_step_checkout" translate="label comment" sortOrder="95" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>After Adding a Product Redirect to OneStepCheckout Page</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="show_billing_address" translate="label comment" sortOrder="97" type="select"
+                <field id="show_billing_address" translate="label comment" sortOrder="100" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Can Show Billing Address</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Allow customers can billing to a different address from billing address.</comment>
                 </field>
-                <field id="show_billing_before_shipping" translate="label comment" sortOrder="99" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Show Billing Address Before Shipping Address</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment>Allow customers can set billing address before shipping address </comment>
-                    <depends>
-                        <field id="show_billing_address">1</field>
-                    </depends>
-                </field>
                 <field id="auto_detect_address" sortOrder="101" type="select" showInDefault="1" showInWebsite="1"
                        showInStore="1" canRestore="1">
                     <label>Use Auto Suggestion Technology</label>
@@ -177,7 +163,6 @@
                        showInWebsite="1" showInStore="1">
                     <label>Amount</label>
                     <comment>Enter the amount of gift wrap fee.</comment>
-                    <validate>validate-number</validate>
                     <depends>
                         <field id="is_enabled_gift_wrap">1</field>
                     </depends>
@@ -216,6 +201,9 @@
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Social Login On Checkout Page</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                    <if_module_enabled>Mageplaza_SocialLogin</if_module_enabled>
+                    <comment>You should install &lt;a href="https://www.mageplaza.com/magento-2-social-login-extension"
+                        target="_blank">Social Login by Mageplaza&lt;/a&gt;</comment>
                 </field>
                 <field id="is_enabled_delivery_time" translate="label comment" sortOrder="80" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
@@ -239,36 +227,6 @@
                         <field id="is_enabled_delivery_time">1</field>
                     </depends>
                 </field>
-                <field id="is_enabled_survey" translate="label comment" sortOrder="100" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Enable Survey</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment>It will show on success page</comment>
-                </field>
-                <field id="survey_question" translate="label comment" sortOrder="104" type="text" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1" >
-                    <label>Survey Question</label>
-                    <depends>
-                        <field id="is_enabled_survey">1</field>
-                    </depends>
-                </field>
-                <field id="survey_answers" translate="label comment" sortOrder="106"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Survey Answers</label>
-                    <frontend_model>Mageplaza\Osc\Model\System\Config\Source\Survey</frontend_model>
-                    <backend_model>Magento\Config\Model\Config\Backend\Serialized\ArraySerialized</backend_model>
-                    <depends>
-                        <field id="is_enabled_survey">1</field>
-                    </depends>
-                </field>
-                <field id="allow_customer_add_other_option" translate="label comment" sortOrder="108" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Allow Customer Add Other Option</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <depends>
-                        <field id="is_enabled_survey">1</field>
-                    </depends>
-                </field>
             </group>
             <group id="design_configuration" translate="label comment" sortOrder="30" type="text" showInDefault="1"
                    showInWebsite="1" showInStore="1">
diff --git a/etc/config.xml b/etc/config.xml
index f31ed25..d81bd7c 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -29,8 +29,6 @@
                 <description>Please enter your details below to complete your purchase.</description>
                 <allow_guest_checkout>1</allow_guest_checkout>
                 <show_billing_address>1</show_billing_address>
-                <show_billing_before_shipping>0</show_billing_before_shipping>
-                <redirect_to_one_step_checkout>0</redirect_to_one_step_checkout>
                 <auto_detect_address>google</auto_detect_address>
                 <google_api_key>AIzaSyBW4vLsNZoKFMFMPUR4C0ZuKtaaDDEajos</google_api_key>
             </general>
diff --git a/etc/frontend/events.xml b/etc/frontend/events.xml
index d852657..476ea14 100644
--- a/etc/frontend/events.xml
+++ b/etc/frontend/events.xml
@@ -24,7 +24,4 @@
     <event name="checkout_allow_guest">
         <observer name="checkout_allow_guest" instance="Mageplaza\Osc\Observer\IsAllowedGuestCheckoutObserver" />
     </event>
-    <event name="checkout_cart_add_product_complete">
-        <observer name="redirect_to_one_step_checkout" instance="Mageplaza\Osc\Observer\RedirectToOneStepCheckout" />
-    </event>
 </config>
diff --git a/etc/module.xml b/etc/module.xml
index cad4fe1..26559f7 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -21,13 +21,12 @@
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
-    <module name="Mageplaza_Osc" setup_version="2.1.2">
-        <sequence>
-            <module name="Mageplaza_Core"/>
-            <module name="Magento_Checkout"/>
-            <module name="Magento_Customer"/>
-            <module name="Magento_Sales"/>
-            <module name="Magento_Catalog"/>
-        </sequence>
-    </module>
+    <module name="Mageplaza_Osc" setup_version="2.1.1"/>
+    <sequence>
+        <module name="Mageplaza_Core"/>
+        <module name="Magento_Checkout"/>
+        <module name="Magento_Customer"/>
+        <module name="Magento_Sales"/>
+        <module name="Magento_Catalog"/>
+    </sequence>
 </config>
\ No newline at end of file
diff --git a/i18n/en_US.csv b/i18n/en_US.csv
index 6416250..9b52999 100644
--- a/i18n/en_US.csv
+++ b/i18n/en_US.csv
@@ -63,9 +63,6 @@
 "Show Order Review Section","Show Order Review Section"
 "Show Product Thumbnail Image","Show Product Thumbnail Image"
 "Show Sign up newsletter selection","Show Sign up newsletter selection"
-"You already have an account with us","You already have an account with us"
-"Sign in","Sign in"
-"continue as guest.","continue as guest."
 "Street","Street"
 "Style 1","Style 1"
 "Style 2","Style 2"
diff --git a/view/adminhtml/layout/sales_order_view.xml b/view/adminhtml/layout/sales_order_view.xml
index a02ebc9..ba56590 100644
--- a/view/adminhtml/layout/sales_order_view.xml
+++ b/view/adminhtml/layout/sales_order_view.xml
@@ -33,8 +33,6 @@
                        template="order/view/comment.phtml"/>
                 <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time"
                        template="order/view/delivery-time.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\Survey" name="survey"
-                       template="order/view/survey.phtml"/>
             </block>
         </referenceBlock>
         <referenceBlock name="order_totals">
diff --git a/view/adminhtml/templates/order/view/survey.phtml b/view/adminhtml/templates/order/view/survey.phtml
deleted file mode 100644
index a939b47..0000000
--- a/view/adminhtml/templates/order/view/survey.phtml
+++ /dev/null
@@ -1,39 +0,0 @@
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
-
-// @codingStandardsIgnoreFile
-
-?>
-<?php if (!empty($surveyQuestion = $block->getSurveyQuestion()) && !empty($surveyAnswers = $block->getSurveyAnswers())): ?>
-    <div class="admin__page-section-item order-osc-survey">
-    <div class="admin__page-section-item-title">
-        <span class="title"><?php /* @escapeNotVerified */ echo __('Order Survey') ?></span>
-    </div>
-    <div class="admin__page-section-item-content">
-        <div class="question">
-             <strong>Question: </strong><span><?php echo $surveyQuestion ?></span>
-        </div>
-       <div class="answers">
-           <strong>Answers: </strong><span><?php echo $surveyAnswers ?></span>
-       </div>
-    </div>
-</div>
-<?php endif; ?>
\ No newline at end of file
diff --git a/view/adminhtml/web/css/source/_module.less b/view/adminhtml/web/css/source/_module.less
deleted file mode 100644
index ae6bfac..0000000
--- a/view/adminhtml/web/css/source/_module.less
+++ /dev/null
@@ -1,6 +0,0 @@
-.admin__menu #menu-mageplaza-core-menu .item-osc.parent.level-1 > strong:before {
-  content: '\e63f';
-  font-family: 'Admin Icons';
-  font-size: 1.5rem;
-  margin-right: .8rem;
-}
\ No newline at end of file
diff --git a/view/frontend/layout/checkout_onepage_success.xml b/view/frontend/layout/checkout_onepage_success.xml
deleted file mode 100644
index 689d5da..0000000
--- a/view/frontend/layout/checkout_onepage_success.xml
+++ /dev/null
@@ -1,32 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="1column" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <head>
-        <css src="Mageplaza_Osc::css/style.css"/>
-    </head>
-    <body>
-        <referenceContainer name="content">
-            <block class="Mageplaza\Osc\Block\Survey" name="osc.survey" template="Mageplaza_Osc::onepage/success/survey.phtml"/>
-        </referenceContainer>
-    </body>
-</page>
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index 42e8db8..34a894c 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -68,13 +68,6 @@
                                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/delivery-time</item>
                                                                     <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledDeliveryTime" />
                                                                 </item>
-                                                                <item name="place-order-comment" xsi:type="array">
-                                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/comment</item>
-                                                                    <item name="sortOrder" xsi:type="string">20</item>
-                                                                    <item name="config" xsi:type="array">
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledComment" />
-                                                                    </item>
-                                                                </item>
                                                             </item>
                                                         </item>
                                                         <item name="address-list" xsi:type="array">
@@ -351,6 +344,13 @@
                                             <item name="component" xsi:type="string">uiComponent</item>
                                             <item name="displayArea" xsi:type="string">place-order-information-right</item>
                                             <item name="children" xsi:type="array">
+                                                <item name="place-order-comment" xsi:type="array">
+                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/comment</item>
+                                                    <item name="sortOrder" xsi:type="string">20</item>
+                                                    <item name="config" xsi:type="array">
+                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledComment" />
+                                                    </item>
+                                                </item>
                                                 <item name="place-order-button" xsi:type="array">
                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/placeOrder</item>
                                                     <item name="sortOrder" xsi:type="string">99</item>
diff --git a/view/frontend/layout/sales_order_view.xml b/view/frontend/layout/sales_order_view.xml
index abe940d..a653c1d 100644
--- a/view/frontend/layout/sales_order_view.xml
+++ b/view/frontend/layout/sales_order_view.xml
@@ -30,8 +30,6 @@
                        template="order/view/comment.phtml"/>
                 <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time"
                        template="order/view/delivery-time.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\Survey" name="survey"
-                       template="order/view/survey.phtml"/>
             </block>
         </referenceContainer>
         <referenceBlock name="order_totals">
diff --git a/view/frontend/templates/onepage/success/survey.phtml b/view/frontend/templates/onepage/success/survey.phtml
deleted file mode 100644
index 262d76c..0000000
--- a/view/frontend/templates/onepage/success/survey.phtml
+++ /dev/null
@@ -1,51 +0,0 @@
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
- * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-?>
-<?php if (!$block->isEnableSurvey() && !empty($block->getSurveyQuestion()) && count($block->getAllSurveyAnswer()) > 0): ?>
-    <div id="survey">
-        <div id="survey-message"></div>
-        <div class="survey-content">
-           <strong>Question: </strong><span> <?php echo $block->getSurveyQuestion(); ?></span>
-           <div class="list-answer">
-               <?php
-                    foreach ($block->getAllSurveyAnswer() as $option){
-                        echo '<div class="survey-answer"> <div class="checkbox-survey"><input type="checkbox" value="'.$option['id'].'"></div><div class="option-value"><span>'.$option['value'].'</span></div></div>';
-                    }
-                    if($block->isAllowCustomerAddOtherOption()) echo '<div class="option-survey-new"> <input type="text" id="new-answer" placeholder="Add an option..." maxlength="50"> </div>';
-    ?>
-           </div>
-           <div class="actions-toolbar" id="submit-answers">
-              <div class="primary">
-                 <a class="action primary continue" href="javascript:void(0)"><span>Submit Answers</span></a>
-              </div>
-           </div>
-        </div>
-    </div>
-    <script type="text/x-magento-init">
-		{
-			"#survey": {
-				"Mageplaza_Osc/js/view/survey":{
-					"url": "<?php /* @escapeNotVerified */ echo $block->getUrl("onestepcheckout/survey/save/"); ?>"
-				}
-			}
-		}
-	</script>
-<?php endif; ?>
\ No newline at end of file
diff --git a/view/frontend/templates/order/view/survey.phtml b/view/frontend/templates/order/view/survey.phtml
deleted file mode 100644
index 6b761a0..0000000
--- a/view/frontend/templates/order/view/survey.phtml
+++ /dev/null
@@ -1,36 +0,0 @@
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
-?>
-<?php if (!empty($surveyQuestion = $block->getSurveyQuestion()) && !empty($surveyAnswers = $block->getSurveyAnswers())): ?>
-<div class="box box-order-survey">
-    <strong class="box-title">
-        <span><?php /* @escapeNotVerified */ echo __('Order Survey') ?></span>
-    </strong>
-    <div class="box-content">
-        <div class="question">
-             <strong>Question: </strong><span><?php echo $surveyQuestion ?></span>
-        </div>
-       <div class="answers">
-           <strong>Answers: </strong><span><?php echo $surveyAnswers ?></span>
-       </div>
-    </div>
-</div>
-<?php endif; ?>
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index 8affb9c..ff25edb 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -69,13 +69,9 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .osc-shipping-method ul li{list-style: none;}
 .table-checkout-shipping-method thead th{display: none;}
 .fieldset > .form-create-account> .field.required > .label:after {  content: '*';  color: #e02b27;  font-size: 1.2rem;  margin: 0 0 0 5px;  }
-.delivery-time{margin-bottom: 20px;}
 .delivery-time .title{margin: 10px 0;}
 .delivery-time .title span{font-weight: bold;}
-.delivery-time .control{position: relative;width: 80%;}
-.delivery-time .control input{width:80%}
-.delivery-time .remove-delivery-time{  width: 20px;  height: 20px;  cursor: pointer;  text-align: center;  position: absolute;  top: 6px;  right: 60px; }
-
+.delivery-time .control input{width:65%}
 /**************************************************** Payment method area ****************************************************/
 .osc-payment-after-methods .opc-payment-additional .field .control{float: left; margin-right: 3px}
 .payment-method-content .payment-method-billing-address,
@@ -124,19 +120,6 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .osc-place-order-block .actions-toolbar{margin-top: 6px}
 .checkout-addition-block{padding-top: 20px !important;}
 .osc-place-order-wrapper button.action.primary.checkout span {color: #FFFFFF;background: none;border: none;}
-.osc-place-order-wrapper .checkout-agreements-block{margin-bottom: 0px}
-
-/**************************************************** Survey ****************************************************/
-#survey-message{margin-top: 15px;}
-.survey-content{margin: 10px 15px;  }
-.survey-answer{    margin: 5px 0px;position: relative;}
-.survey-answer .checkbox-survey{float:left;}
-.survey-answer .option-value{border: 1px solid #ddd;padding: 6px 5px;margin-left: 20px;}
-.survey-answer .checkbox-survey{margin-top: 10px;}
-.option-survey-new{padding-left: 20px;}
-#remove-answer{position: absolute;right: -28px;top: 4px;width: 25px;height: 25px;text-align: center;cursor: pointer;background: #ddd;border: 1px solid #ccc2c2;line-height: 25px;}
-#remove-answer:hover{font-weight: bold;}
-.survey-content .actions-toolbar{float: right;margin: 15px;}
 
 /**************************************************** Responsive ****************************************************/
 @media (min-width: 1024px), print {
@@ -162,5 +145,4 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 }
 @media only screen and (max-width:320px){
     #checkout-review-table thead th, #checkout-review-table tbody tr td, #checkout-review-table tfoot tr td{padding: 15px 0px;}
-    .delivery-time .remove-delivery-time{right:45px;}
 }
diff --git a/view/frontend/web/js/action/gift-wrap.js b/view/frontend/web/js/action/gift-wrap.js
index ea40834..4bee240 100644
--- a/view/frontend/web/js/action/gift-wrap.js
+++ b/view/frontend/web/js/action/gift-wrap.js
@@ -12,8 +12,7 @@ define(
         'Magento_Checkout/js/model/payment/method-converter',
         'Magento_Checkout/js/model/payment-service',
         'Magento_Checkout/js/model/shipping-service',
-        'Mageplaza_Osc/js/model/osc-loader',
-        'Mageplaza_Osc/js/model/osc-data'
+        'Mageplaza_Osc/js/model/osc-loader'
     ],
     function (quote,
               resourceUrlManager,
@@ -23,8 +22,7 @@ define(
               methodConverter,
               paymentService,
               shippingService,
-              oscLoader,
-              oscData) {
+              oscLoader) {
         'use strict';
 
         var itemUpdateLoader = ['shipping', 'payment', 'total'];
@@ -45,7 +43,6 @@ define(
                         window.location.href = response.redirect_url;
                         return;
                     }
-                    oscData.setData('is_use_gift_wrap', payload.is_use_gift_wrap);
                     quote.setTotals(response.totals);
                     paymentService.setPaymentMethods(methodConverter(response.payment_methods));
                     if (response.shipping_methods && !quote.isVirtual()) {
diff --git a/view/frontend/web/js/model/billing-before-shipping.js b/view/frontend/web/js/model/billing-before-shipping.js
deleted file mode 100644
index 4af4cc3..0000000
--- a/view/frontend/web/js/model/billing-before-shipping.js
+++ /dev/null
@@ -1,33 +0,0 @@
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
-define(['ko', 'Mageplaza_Osc/js/model/osc-data'], function (ko, oscData) {
-    'use strict';
-    var isBillingSameShipping = oscData.getData('billing-same-shipping') ? oscData.getData('billing-same-shipping') : false;
-    return {
-        isBillingSameShipping: ko.observable(isBillingSameShipping),
-        getBillingSameShipping: function () {
-            return this.isBillingSameShipping();
-        },
-        setBillingSameShipping: function () {
-            oscData.setData('billing-same-shipping', !this.isBillingSameShipping());
-            return this.isBillingSameShipping(!this.isBillingSameShipping());
-        }
-    };
-});
\ No newline at end of file
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 9046fbc..4bcabc6 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -28,14 +28,11 @@ define(
         'Magento_Checkout/js/model/shipping-rates-validation-rules',
         'Magento_Checkout/js/model/address-converter',
         'Magento_Checkout/js/action/select-shipping-address',
-        'Magento_Checkout/js/action/select-billing-address',
         'Magento_Checkout/js/model/shipping-rate-service',
         'Magento_Checkout/js/model/shipping-service',
         'Magento_Checkout/js/model/postcode-validator',
         'mage/translate',
-        'uiRegistry',
-        'Mageplaza_Osc/js/model/billing-before-shipping',
-        'Magento_Customer/js/model/customer'
+        'uiRegistry'
     ],
     function (_,
               $,
@@ -45,12 +42,11 @@ define(
               shippingRatesValidationRules,
               addressConverter,
               selectShippingAddress,
-              selectBillingAddress,
               shippingRateService,
               shippingService,
               postcodeValidator,
               $t,
-              uiRegistry, billingBeforeShipping, customer) {
+              uiRegistry) {
         'use strict';
 
         var countryElement = null,
@@ -59,15 +55,11 @@ define(
             observedElements = [],
             observableElements,
             defaultRules = {'rate': {'postcode': {'required': true}, 'country_id': {'required': true}}},
-            addressFields = window.checkoutConfig.oscConfig.addressFields,
-            isShowBillingBeforeShipping = window.checkoutConfig.oscConfig.showBillingBeforeShipping;
+            addressFields = window.checkoutConfig.oscConfig.addressFields;
 
         return _.extend(Validator, {
-            isFormInline: function () {
-                return addressList().length === 0;
-            },
-            isBillingSameShipping: !billingBeforeShipping.isBillingSameShipping(),
-            isCustomerLoggedIn: customer.isLoggedIn,
+            isFormInline: addressList().length == 0,
+
             getValidationRules: function () {
                 var rules = shippingRatesValidationRules.getRules();
 
@@ -107,7 +99,7 @@ define(
             isFieldExisted: function (field) {
                 var result = false;
                 $.each(observedElements, function (key, element) {
-                    if (field === element.index) {
+                    if (field == element.index) {
                         result = true;
                         return false;
                     }
@@ -136,53 +128,9 @@ define(
 
                 $.each(addressFields, function (index, field) {
                     uiRegistry.async(formPath + '.' + field)(self.oscBindHandler.bind(self));
-                    if (isShowBillingBeforeShipping) {
-                        uiRegistry.async('checkout.steps.shipping-step.billingAddress.billing-address-fieldset' + '.' + field)(self.oscBillingAddressBindHandler.bind(self));
-                    }
                 });
             },
-            oscBillingAddressBindHandler: function (element) {
-                var self = this;
-                if (element.component.indexOf('/group') !== -1) {
-                    $.each(element.elems(), function (index, elem) {
-                        self.oscBillingAddressBindHandler(elem);
-                    });
-                } else if (element && element.hasOwnProperty('value')) {
 
-                    element.on('value', function () {
-                        if (billingBeforeShipping.isBillingSameShipping()) return;
-                        self.oscPostcodeValidation();
-                        if (self.isFormInline() && !self.isCustomerLoggedIn()) {
-                            var addressFlat = addressConverter.formDataProviderToFlatData(
-                                self.oscCollectObservedData(),
-                                'billingAddress'
-                                ),
-                                address;
-
-                            address = addressConverter.formAddressDataToQuoteAddress(addressFlat);
-                            selectShippingAddress(address);
-                            if (!billingBeforeShipping.isBillingSameShipping()) {
-                                selectBillingAddress(address);
-                            }
-
-                            if ($.inArray(element.index, observableElements) !== -1 && self.oscValidateAddressData(element.index, addressFlat)) {
-                                shippingRateService.isAddressChange = true;
-                                clearTimeout(self.validateAddressTimeout);
-                                self.validateAddressTimeout = setTimeout(function () {
-                                    shippingRateService.estimateShippingMethod();
-                                }, 200);
-                            }
-                        }
-                    });
-                    observedElements.push(element);
-                    if (element.index === postcodeElementName) {
-                        postcodeElement = element;
-                    }
-                    if (element.index === 'country_id') {
-                        countryElement = element;
-                    }
-                }
-            },
             oscBindHandler: function (element) {
                 var self = this;
 
@@ -194,10 +142,10 @@ define(
                     element.on('value', function () {
                         self.oscPostcodeValidation();
 
-                        if (self.isFormInline()) {
+                        if (self.isFormInline) {
                             var addressFlat = addressConverter.formDataProviderToFlatData(
-                                self.oscCollectObservedData(),
-                                'shippingAddress'
+                                    self.oscCollectObservedData(),
+                                    'shippingAddress'
                                 ),
                                 address;
 
@@ -205,8 +153,8 @@ define(
                             selectShippingAddress(address);
 
                             if ($.inArray(element.index, observableElements) !== -1 && self.oscValidateAddressData(element.index, addressFlat)) {
-
                                 shippingRateService.isAddressChange = true;
+
                                 clearTimeout(self.validateAddressTimeout);
                                 self.validateAddressTimeout = setTimeout(function () {
                                     shippingRateService.estimateShippingMethod();
@@ -248,7 +196,7 @@ define(
                     validationResult,
                     warnMessage;
 
-                if (postcodeElement === null || postcodeElement.value() === null) {
+                if (postcodeElement == null || postcodeElement.value() == null) {
                     return true;
                 }
 
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index a4087ab..50d6fe2 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -27,9 +27,7 @@ define(
         'Magento_Checkout/js/checkout-data',
         'Mageplaza_Osc/js/model/osc-data',
         'Magento_Checkout/js/action/create-billing-address',
-        'Magento_Checkout/js/action/create-shipping-address',
         'Magento_Checkout/js/action/select-billing-address',
-        'Magento_Checkout/js/action/select-shipping-address',
         'Magento_Customer/js/model/customer',
         'Magento_Checkout/js/action/set-billing-address',
         'Magento_Checkout/js/model/address-converter',
@@ -39,11 +37,7 @@ define(
         'Mageplaza_Osc/js/model/address/auto-complete',
         'uiRegistry',
         'mage/translate',
-        'rjsResolver',
-        'Mageplaza_Osc/js/model/billing-before-shipping',
-        'Magento_Checkout/js/model/shipping-rate-service',
-        'Mageplaza_Osc/js/model/shipping-rates-validator',
-        'Magento_Customer/js/model/address-list',
+        'rjsResolver'
     ],
     function ($,
               ko,
@@ -52,9 +46,7 @@ define(
               checkoutData,
               oscData,
               createBillingAddress,
-              createShippingAddress,
               selectBillingAddress,
-              selectShippingAddress,
               customer,
               setBillingAddressAction,
               addressConverter,
@@ -64,27 +56,17 @@ define(
               addressAutoComplete,
               registry,
               $t,
-              resolver,
-              billingBeforeShipping,
-              shippingRateService,
-              shippingRatesValidators,
-              addressList) {
+              resolver) {
         'use strict';
 
         var observedElements = [],
-            canShowBillingAddress = window.checkoutConfig.oscConfig.showBillingAddress,
-            selectedShippingAddress = null,
-            fieldSelectBillingElement = '.field-select-billing select[name=billing_address_id] option',
-            reloadPage = true,
-            hasSetDefaultAddress = false;
+            canShowBillingAddress = window.checkoutConfig.oscConfig.showBillingAddress;
 
         return Component.extend({
             defaults: {
                 template: ''
             },
             isCustomerLoggedIn: customer.isLoggedIn,
-            isShowBillingBeforeShipping: window.checkoutConfig.oscConfig.showBillingBeforeShipping,
-            isBillingSameShipping: !billingBeforeShipping.isBillingSameShipping(),
             quoteIsVirtual: quote.isVirtual(),
 
             canUseShippingAddress: ko.computed(function () {
@@ -118,27 +100,11 @@ define(
                     });
                 });
 
-                if (this.isShowBillingBeforeShipping) {
-                    quote.billingAddress.subscribe(function (newAddress) {
-                        if (!billingBeforeShipping.isBillingSameShipping()) {
-                            self.isAddressSameAsShipping(!billingBeforeShipping.isBillingSameShipping());
-                            selectShippingAddress(newAddress);
-                        }
-                    });
-                    this.isAddressFormVisible.subscribe(function () {
-                        self.saveInAddressBook(true);
-                    });
-                    this.saveInAddressBook.subscribe(function () {
-                        if (self.isAddressFormVisible()) self.saveNewBillingAddress();
-                    });
-                } else {
-                    quote.shippingAddress.subscribe(function (newAddress) {
-                        if (self.isAddressSameAsShipping()) {
-                            selectBillingAddress(newAddress);
-                        }
-                    });
-                }
-
+                quote.shippingAddress.subscribe(function (newAddress) {
+                    if (self.isAddressSameAsShipping()) {
+                        selectBillingAddress(newAddress);
+                    }
+                });
 
                 resolver(this.afterResolveDocument.bind(this));
 
@@ -147,184 +113,33 @@ define(
 
             afterResolveDocument: function () {
                 this.saveBillingAddress();
-                addressAutoComplete.register('billing');
-            },
-
-            /**
-             * set default address when page is reload
-             */
-            initDefaultAddress: function () {
-                if (reloadPage && customer.isLoggedIn() && this.customerHasAddresses) {
-                    var selectedBillingAddress = checkoutData.getSelectedBillingAddress(),
-                        newCustomerBillingAddressData = checkoutData.getNewCustomerBillingAddress();
-                    if (selectedBillingAddress) {
-                        if (selectedBillingAddress == 'new-customer-address' && newCustomerBillingAddressData) {
-
-                            $(fieldSelectBillingElement + ':last-child').prop('selected', true);
-                            this.isAddressFormVisible(true);
-                            this.setCustomerAddress('default-shipping', '');
-
-                        } else {
-                            this.setCustomerAddress('has-select-address', selectedBillingAddress);
-                        }
-                    } else if (window.customerData.default_billing != null) {
-                        this.setCustomerAddress('default-billing', '');
-                    }
-                }
-                reloadPage = false;
-            },
-
-            /**
-             * @param condition
-             * @param selectedValue
-             */
-            setCustomerAddress: function (condition, selectedValue) {
-                var self = this;
-                $.each(addressList(), function (key, address) {
-                    if (condition == 'default-shipping') {
-                        if (address.isDefaultShipping()) {
-                            selectedShippingAddress = address;
-                            return false;
-                        }
-                    }
-                    if (condition == 'default-billing') {
-                        if (address.isDefaultBilling()) {
-                            $(fieldSelectBillingElement).eq(key).prop('selected', true);
-                            self.selectAddress(address);
-                            return false;
-                        }
-                    }
 
-                    if (condition == 'has-select-address') {
-                        if (selectedValue == address.getKey()) {
-                            $(fieldSelectBillingElement).eq(key).prop('selected', true);
-                            self.selectAddress(address);
-                            return false;
-                        }
-                    }
-                });
-            },
-
-            /**
-             * Select Address
-             * @param address
-             */
-            selectAddress: function (address) {
-                if (!billingBeforeShipping.isBillingSameShipping()) {
-                    selectedShippingAddress = address;
-                    selectShippingAddress(address);
-                    checkoutData.setSelectedShippingAddress(address.getKey());
-                }
-                selectBillingAddress(address);
-                checkoutData.setSelectedBillingAddress(address.getKey());
+                addressAutoComplete.register('billing');
             },
 
             /**
              * @return {Boolean}
              */
             useShippingAddress: function () {
-                if (this.isShowBillingBeforeShipping) {
-                    billingBeforeShipping.setBillingSameShipping();
-                    if (!billingBeforeShipping.isBillingSameShipping()) {
-                        if (this.selectedAddress() && !this.isAddressFormVisible()) {
-                            selectShippingAddress(this.selectedAddress());
-                            checkoutData.setSelectedShippingAddress(this.selectedAddress().getKey());
-                        } else {
-                            var addressFlat = addressConverter.formDataProviderToFlatData(this.collectObservedData(), 'billingAddress'),
-                                address;
-                            address = addressConverter.formAddressDataToQuoteAddress(addressFlat);
-                            selectShippingAddress(address);
-                            selectBillingAddress(address);
-                        }
-                        this.oscEstimateShippingMethod();
-
-                    } else {
-                        this.updateShippingAddress();
+                if (this.isAddressSameAsShipping()) {
+                    selectBillingAddress(quote.shippingAddress());
+                    checkoutData.setSelectedBillingAddress(null);
+                    if (window.checkoutConfig.reloadOnBillingAddress) {
+                        setBillingAddressAction(globalMessageList);
                     }
-
                 } else {
-                    if (this.isAddressSameAsShipping()) {
-                        selectBillingAddress(quote.shippingAddress());
-                        checkoutData.setSelectedBillingAddress(null);
-                        if (window.checkoutConfig.reloadOnBillingAddress) {
-                            setBillingAddressAction(globalMessageList);
-                        }
-                    } else {
-                        this.updateAddress();
-                    }
+                    this.updateAddress();
                 }
 
                 return true;
             },
 
-            /**
-             * @param address
-             */
             onAddressChange: function (address) {
                 this._super(address);
-                if (this.isShowBillingBeforeShipping) {
-                    this.initDefaultAddress();
-                    if (this.isAddressFormVisible()) {
-                        this.saveNewBillingAddress();
-                    } else {
-                        if (hasSetDefaultAddress) {
-                            this.selectAddress(this.selectedAddress());
-                        }
-                    }
-                    this.oscEstimateShippingMethod();
-                    hasSetDefaultAddress = true;
-                } else {
-                    if (!this.isAddressSameAsShipping() && canShowBillingAddress) {
-                        this.updateAddress();
-                    }
-                }
-            },
 
-            /**
-             * Save new Billing Address
-             * @returns {*}
-             */
-            saveNewBillingAddress: function () {
-                var addressData = this.source.get('billingAddress'),
-                    newBillingAddress;
-                if (customer.isLoggedIn() && !this.customerHasAddresses) {
-                    this.saveInAddressBook(1);
+                if (!this.isAddressSameAsShipping() && canShowBillingAddress) {
+                    this.updateAddress();
                 }
-                addressData.save_in_address_book = this.saveInAddressBook() ? 1 : 0;
-                newBillingAddress = createBillingAddress(addressData);
-
-                // New address must be selected as a billing address
-                selectBillingAddress(newBillingAddress);
-                checkoutData.setSelectedBillingAddress(newBillingAddress.getKey());
-                checkoutData.setNewCustomerBillingAddress(addressData);
-                return newBillingAddress;
-            },
-
-            /**
-             * Estimate shipping method
-             */
-            oscEstimateShippingMethod: function () {
-                shippingRateService.isAddressChange = true;
-                clearTimeout(self.validateAddressTimeout);
-                self.validateAddressTimeout = setTimeout(function () {
-                    shippingRateService.estimateShippingMethod();
-                }, 200);
-            },
-
-            /**
-             * Update shipping address action
-             */
-            updateShippingAddress: function () {
-                if (this.selectedAddress() && !this.isAddressFormVisible()) return;
-                if (customer.isLoggedIn() && this.isAddressFormVisible() && this.customerHasAddresses) {
-                    selectShippingAddress(selectedShippingAddress);
-                } else {
-                    var addressData = this.source.get('shippingAddress');
-                    selectShippingAddress(addressConverter.formAddressDataToQuoteAddress(addressData));
-                }
-                this.oscEstimateShippingMethod();
-
-
             },
 
             /**
@@ -358,8 +173,6 @@ define(
 
             /**
              * Perform postponed binding for fieldset elements
-             * on change value for billing addresss
-             *
              */
             initFields: function () {
                 var self = this,
@@ -387,33 +200,6 @@ define(
             },
 
             saveBillingAddress: function (fieldName) {
-                /**
-                 * when billing address before shipping address
-                 */
-                if (this.isShowBillingBeforeShipping) {
-                    if (customer.isLoggedIn() && this.isAddressFormVisible()) {
-                        var newBillingAddress = this.saveNewBillingAddress()
-                        if (!billingBeforeShipping.isBillingSameShipping() && this.isAddressFormVisible()) {
-                            if (shippingRatesValidators.oscValidateAddressData(fieldName, newBillingAddress)) {
-                                this.oscEstimateShippingMethod();
-                            }
-                        }
-                    } else {
-                        if (billingBeforeShipping.isBillingSameShipping()) {
-                            var addressFlat = addressConverter.formDataProviderToFlatData(
-                                this.collectObservedData(),
-                                'billingAddress'
-                            );
-
-                            selectBillingAddress(addressConverter.formAddressDataToQuoteAddress(addressFlat));
-                        }
-                    }
-                    return;
-                }
-
-                /**
-                 * when shipping address before billing address
-                 */
                 if (!this.isAddressSameAsShipping()) {
                     if (!canShowBillingAddress) {
                         selectBillingAddress(quote.shippingAddress());
@@ -447,16 +233,10 @@ define(
                 return observedValues;
             },
 
-            /**
-             * validate billing address
-             * @returns {boolean}
-             */
             validate: function () {
-                if (!this.isShowBillingBeforeShipping) {
-                    if (this.isAddressSameAsShipping()) {
-                        oscData.setData('same_as_shipping', true);
-                        return true;
-                    }
+                if (this.isAddressSameAsShipping()) {
+                    oscData.setData('same_as_shipping', true);
+                    return true;
                 }
 
                 if (!this.isAddressFormVisible()) {
@@ -469,10 +249,8 @@ define(
                 if (this.source.get('billingAddress.custom_attributes')) {
                     this.source.trigger('billingAddress.custom_attributes.data.validate');
                 }
-                if (!this.isShowBillingBeforeShipping) {
-                    oscData.setData('same_as_shipping', false);
-                }
 
+                oscData.setData('same_as_shipping', false);
                 return !this.source.get('params.invalid');
             },
             getAddressTemplate: function () {
diff --git a/view/frontend/web/js/view/delivery-time.js b/view/frontend/web/js/view/delivery-time.js
index 3b4dd47..82a4a0b 100644
--- a/view/frontend/web/js/view/delivery-time.js
+++ b/view/frontend/web/js/view/delivery-time.js
@@ -29,18 +29,15 @@ define(
     ],
     function ($, ko, Component, oscData) {
         'use strict';
-        var cacheKey = 'deliveryTime',
-            isVisible = oscData.getData(cacheKey) ? true : false;
+        var cacheKey = 'deliveryTime';
 
         return Component.extend({
             defaults: {
                 template: 'Mageplaza_Osc/container/delivery-time'
             },
             deliveryTimeValue: ko.observable(),
-            isVisible: ko.observable(isVisible),
             initialize: function () {
                 this._super();
-                var self = this;
                 ko.bindingHandlers.datepicker = {
                     init: function (element) {
                         var dateFormat = window.checkoutConfig.oscConfig.deliveryTimeOptions.deliveryTimeFormat,
@@ -64,16 +61,8 @@ define(
                 this.deliveryTimeValue(oscData.getData(cacheKey));
                 this.deliveryTimeValue.subscribe(function (newValue) {
                     oscData.setData(cacheKey, newValue);
-                    self.isVisible(true);
                 });
                 return this;
-            },
-            removeDeliveryTime: function () {
-                if (oscData.getData(cacheKey) && oscData.getData(cacheKey) != null) {
-                    oscData.setData(cacheKey, '');
-                    $("#osc-delivery-time").attr('value', '');
-                    this.isVisible(false);
-                }
             }
         });
     }
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index bc2be75..920b7da 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -76,11 +76,6 @@ define([
             return this;
         },
 
-        triggerLogin: function () {
-            $('.osc-authentication-toggle').trigger('click');
-        },
-
-
         validateEmail: function (focused) {
             var loginFormSelector = 'form[data-role=email-with-possible-login]',
                 usernameSelector = loginFormSelector + ' input[name=username]',
diff --git a/view/frontend/web/js/view/review/addition/gift-wrap.js b/view/frontend/web/js/view/review/addition/gift-wrap.js
index 3004a76..fb7b9f2 100644
--- a/view/frontend/web/js/view/review/addition/gift-wrap.js
+++ b/view/frontend/web/js/view/review/addition/gift-wrap.js
@@ -50,7 +50,7 @@ define(
                     gwAmount = gwSegment.extension_attributes.gift_wrap_amount;
                 }
 
-                if (gwAmount >= 0) {
+                if (gwAmount > 0) {
                     return priceUtils.formatPrice(gwAmount, quote.getPriceFormat());
                 }
 
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index f8547b8..f1ddabd 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -37,9 +37,7 @@ define(
         'Magento_Checkout/js/model/shipping-service',
         'Mageplaza_Osc/js/model/checkout-data-resolver',
         'Mageplaza_Osc/js/model/address/auto-complete',
-        'rjsResolver',
-        'Mageplaza_Osc/js/model/billing-before-shipping',
-        'Mageplaza_Osc/js/model/osc-data'
+        'rjsResolver'
     ],
     function ($,
               _,
@@ -58,9 +56,7 @@ define(
               shippingService,
               oscDataResolver,
               addressAutoComplete,
-              resolver,
-              billingBeforeShipping,
-              oscData) {
+              resolver) {
         'use strict';
 
         oscDataResolver.resolveDefaultShippingMethod();
@@ -73,8 +69,6 @@ define(
                 template: 'Mageplaza_Osc/container/shipping'
             },
             currentMethod: null,
-            isBillingSameShipping: billingBeforeShipping.isBillingSameShipping,
-            isShowBillingBeforeShipping: window.checkoutConfig.oscConfig.showBillingBeforeShipping,
             initialize: function () {
                 this._super();
 
@@ -92,12 +86,10 @@ define(
                 this._super();
 
                 quote.shippingMethod.subscribe(function (oldValue) {
-
                     this.currentMethod = oldValue;
                 }, this, 'beforeChange');
 
                 quote.shippingMethod.subscribe(function (newValue) {
-
                     var isMethodChange = ($.type(this.currentMethod) !== 'object') ? true : this.currentMethod.method_code;
                     if ($.type(newValue) === 'object' && (isMethodChange != newValue.method_code)) {
                         setShippingInformationAction();
@@ -118,63 +110,36 @@ define(
                 if (quote.isVirtual()) {
                     return true;
                 }
-                var shippingMethodValidationResult = true;
+
+                var shippingMethodValidationResult = true,
+                    shippingAddressValidationResult = true,
+                    loginFormSelector = 'form[data-role=email-with-possible-login]',
+                    emailValidationResult = customer.isLoggedIn();
+
                 if (!quote.shippingMethod()) {
                     this.errorValidationMessage('Please specify a shipping method.');
-                    shippingMethodValidationResult = false;
-                }
 
-                if (this.isShowBillingBeforeShipping) {
-                    if (!billingBeforeShipping.isBillingSameShipping()) {
-                        oscData.setData('billing-same-shipping', false);
-                        return shippingMethodValidationResult;
-                    }
+                    shippingMethodValidationResult = false;
                 }
 
-
-                var shippingAddressValidationResult = true,
-                    loginFormSelector = 'form[data-role=email-with-possible-login]',
-                    emailValidationResult = customer.isLoggedIn();
-
                 if (!customer.isLoggedIn()) {
                     $(loginFormSelector).validation();
                     emailValidationResult = Boolean($(loginFormSelector + ' input[name=username]').valid());
                 }
-                if (this.isShowBillingBeforeShipping && customer.isLoggedIn() && billingBeforeShipping.isBillingSameShipping() && this.isFormInline) {
-                    var shippingAddress = quote.shippingAddress();
-                    shippingAddress.save_in_address_book = 1;
-                    selectShippingAddress(shippingAddress);
-                }
-
 
                 if (this.isFormInline) {
-                    if (this.isShowBillingBeforeShipping) {
-                        if (billingBeforeShipping.isBillingSameShipping()) {
-                            this.source.set('params.invalid', false);
-                            this.source.trigger('shippingAddress.data.validate');
-
-                            if (this.source.get('shippingAddress.custom_attributes')) {
-                                this.source.trigger('shippingAddress.custom_attributes.data.validate');
-                            }
-
-                            if (this.source.get('params.invalid')) {
-                                shippingAddressValidationResult = false;
-                            }
-                        }
-                    } else {
-                        this.source.set('params.invalid', false);
-                        this.source.trigger('shippingAddress.data.validate');
-
-                        if (this.source.get('shippingAddress.custom_attributes')) {
-                            this.source.trigger('shippingAddress.custom_attributes.data.validate');
-                        }
-
-                        if (this.source.get('params.invalid')) {
-                            shippingAddressValidationResult = false;
-                        }
-
-                        this.saveShippingAddress();
+                    this.source.set('params.invalid', false);
+                    this.source.trigger('shippingAddress.data.validate');
+
+                    if (this.source.get('shippingAddress.custom_attributes')) {
+                        this.source.trigger('shippingAddress.custom_attributes.data.validate');
+                    }
+
+                    if (this.source.get('params.invalid')) {
+                        shippingAddressValidationResult = false;
                     }
+
+                    this.saveShippingAddress();
                 }
 
                 if (!emailValidationResult) {
@@ -210,7 +175,6 @@ define(
             },
 
             saveNewAddress: function () {
-
                 this.source.set('params.invalid', false);
                 if (this.source.get('shippingAddress.custom_attributes')) {
                     this.source.trigger('shippingAddress.custom_attributes.data.validate');
diff --git a/view/frontend/web/js/view/summary/gift-wrap.js b/view/frontend/web/js/view/summary/gift-wrap.js
index d4de324..9e51618 100644
--- a/view/frontend/web/js/view/summary/gift-wrap.js
+++ b/view/frontend/web/js/view/summary/gift-wrap.js
@@ -25,10 +25,9 @@ define(
         'ko',
         'Magento_Checkout/js/view/summary/abstract-total',
         'Magento_Checkout/js/model/quote',
-        'Magento_Checkout/js/model/totals',
-        'Mageplaza_Osc/js/model/osc-data'
+        'Magento_Checkout/js/model/totals'
     ],
-    function (ko, Component, quote, totals, oscData) {
+    function (ko, Component, quote, totals) {
         "use strict";
 
         return Component.extend({
@@ -37,7 +36,7 @@ define(
             },
             totals: quote.getTotals(),
             isDisplay: function () {
-                return this.getPureValue() >= 0 && oscData.getData('is_use_gift_wrap');
+                return this.getPureValue() > 0;
             },
             getPureValue: function () {
                 var giftWrapAmount = 0;
diff --git a/view/frontend/web/js/view/survey.js b/view/frontend/web/js/view/survey.js
deleted file mode 100644
index e92ca0c..0000000
--- a/view/frontend/web/js/view/survey.js
+++ /dev/null
@@ -1,86 +0,0 @@
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
-define([
-    'jquery'
-], function($) {
-    "use strict";
-
-    $.widget('mageplaza.survey', {
-        options: {
-            url: ''
-        },
-
-        _create: function() {
-            this.initObserve();
-        },
-
-        initObserve: function(){
-            var self = this;
-
-            $("#new-answer").blur(function(){
-                self.addNewAnswer();
-            });
-
-            $('#survey').on('click','#remove-answer',function(){
-                $(this).parent().remove();
-                $('#new-answer').show();
-            });
-
-            $("#submit-answers").click(function(){
-                self.submitAnswers();
-            });
-
-        },
-
-        submitAnswers: function(){
-            var self = this;
-            var answerChecked = [];
-            $(".list-answer  input:checkbox:checked").each(function(){
-                answerChecked.push($(this).parent().next().children('span').text());
-            });
-            if(answerChecked.length > 0){
-                $.ajax({
-                    method : 'POST',
-                    url: this.options.url,
-                    data: {answerChecked: answerChecked}
-                }).done(function(response) {
-                    if(response.status=='success') $('.survey-content').hide();
-                    self.addSurveyMessage(response.status ,response.message);
-                });
-            }else{
-                self.addSurveyMessage('notice','You need to choose answer.')
-            }
-        },
-
-        addNewAnswer: function(){
-            var newAnswer= $('#new-answer').val();
-            if(newAnswer.length > 0){
-                var d= new Date();
-                $('<div class="survey-answer"><div class="checkbox-survey"><input type="checkbox" value="_' + d.getTime() +' " checked/></div><div class="option-value"><span>' + newAnswer + '</span></div><span id="remove-answer">X</span></div>').insertBefore(".option-survey-new");
-                $('#new-answer').val('').hide();
-            }
-        },
-        addSurveyMessage: function(type,message){
-            $("#survey-message").html('<div class="'+ type +' message"><span>'+ message +'</span></div>');
-        }
-    });
-
-    return $.mageplaza.survey;
-});
diff --git a/view/frontend/web/template/1column.html b/view/frontend/web/template/1column.html
index 2cc8f7f..cc3fe77 100644
--- a/view/frontend/web/template/1column.html
+++ b/view/frontend/web/template/1column.html
@@ -35,22 +35,12 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-lg-7 mp-6 mp-xs-12">
             <div class="row-mp">
-                 <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <!--/ko-->
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
-                <!--/ko-->
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
diff --git a/view/frontend/web/template/2columns.html b/view/frontend/web/template/2columns.html
index a7cfa14..91969f8 100644
--- a/view/frontend/web/template/2columns.html
+++ b/view/frontend/web/template/2columns.html
@@ -36,22 +36,12 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-6 mp-sm-5 mp-xs-12">
             <div class="row-mp">
-                <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <!--/ko-->
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
-                <!--/ko-->
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index 4ef4d44..03d6311 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -35,24 +35,12 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-
-                 <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                <!-- /ko -->
-
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                <!-- /ko -->
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                </div>
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                </div>
                 <div class="mp-clear"></div>
             </div>
         </div>
diff --git a/view/frontend/web/template/3columns.html b/view/frontend/web/template/3columns.html
index 217aa66..4041273 100644
--- a/view/frontend/web/template/3columns.html
+++ b/view/frontend/web/template/3columns.html
@@ -35,22 +35,12 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-                <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                <!--/ko-->
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                    </div>
-                <!--/ko-->
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                </div>
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                </div>
                 <div class="mp-clear"></div>
             </div>
         </div>
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index 9012cb3..b8beafb 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -20,13 +20,13 @@
  */
 -->
 
-<div id="billing" class="checkout-billing-address" data-bind="visible: (isShowBillingBeforeShipping != true )? !isAddressSameAsShipping() : true ">
+<div id="billing" class="checkout-billing-address" data-bind="visible: !isAddressSameAsShipping()">
     <div class="step-title" data-role="title">
         <i class="fa fa-home"></i>
         <span data-bind="i18n: 'Billing Address'"></span>
     </div>
     <div id="checkout-step-billing" class="step-content" data-role="content">
-        <!-- ko if: (quoteIsVirtual || isShowBillingBeforeShipping) -->
+        <!-- ko if: (quoteIsVirtual) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: getTemplate() --><!-- /ko -->
             <!--/ko-->
@@ -40,18 +40,12 @@
 
         <div class="mp-clear"></div>
 
-        <!-- ko if: ((!isCustomerLoggedIn() && quoteIsVirtual) || (!isCustomerLoggedIn() && isShowBillingBeforeShipping) ) -->
+        <!-- ko if: (!isCustomerLoggedIn() && quoteIsVirtual) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
 
-        <!-- ko if: (isShowBillingBeforeShipping && !quoteIsVirtual) -->
-            <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
-                <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
-            <!--/ko-->
-        <!--/ko-->
-
         <div class="mp-clear"></div>
     </div>
 </div>
\ No newline at end of file
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index 354e7c0..1d5edb5 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -20,7 +20,7 @@
  */
 -->
 
-<div id="shipping" class="checkout-shipping-address" data-bind="visible: (isShowBillingBeforeShipping == true )? isBillingSameShipping : true">
+<div id="shipping" class="checkout-shipping-address" data-bind="fadeVisible: visible()">
     <div class="step-title" data-role="title">
         <i class="fa fa-home"></i>
         <span data-bind="i18n: 'Shipping Address'"></span>
@@ -29,18 +29,18 @@
          class="step-content"
          data-role="content">
 
-        <!-- ko if: (!quoteIsVirtual && !isShowBillingBeforeShipping) -->
+        <!-- ko if: (!quoteIsVirtual) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: getTemplate() --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
 
         <!-- ko foreach: getRegion('address-list') -->
-            <!-- ko template: getTemplate() --><!-- /ko -->
+        <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
 
         <!-- ko foreach: getRegion('address-list-additional-addresses') -->
-            <!-- ko template: getTemplate() --><!-- /ko -->
+        <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
 
         <!-- Address form pop up -->
@@ -55,25 +55,24 @@
         <!-- /ko -->
 
         <!-- ko foreach: getRegion('before-form') -->
-            <!-- ko template: getTemplate() --><!-- /ko -->
+        <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
 
         <!-- Inline address form -->
         <!-- ko if: (isFormInline) -->
-            <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
+        <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
         <!-- /ko -->
 
-        <!-- ko if: (!isCustomerLoggedIn() && !quoteIsVirtual && !isShowBillingBeforeShipping) -->
+        <!-- ko if: (!isCustomerLoggedIn() && !quoteIsVirtual) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
 
         <div class="mp-clear"></div>
-        <!-- ko if: (!isShowBillingBeforeShipping) -->
-            <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
-                <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
-            <!--/ko-->
+        
+        <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
+            <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
         <!--/ko-->
 
         <div class="mp-clear"></div>
diff --git a/view/frontend/web/template/container/delivery-time.html b/view/frontend/web/template/container/delivery-time.html
index 7b5f398..1d28cbb 100644
--- a/view/frontend/web/template/container/delivery-time.html
+++ b/view/frontend/web/template/container/delivery-time.html
@@ -26,8 +26,5 @@
     </div>
     <div class="control">
         <input type="text" readonly="readonly" data-bind="datepicker: true, value: deliveryTimeValue" id="osc-delivery-time"/>
-        <div class="remove-delivery-time" data-bind="click:removeDeliveryTime.bind($data),visible: isVisible()">
-            <i class="fa fa-remove"></i>
-        </div>
     </div>
 </div>
diff --git a/view/frontend/web/template/container/form/element/email.html b/view/frontend/web/template/container/form/element/email.html
index f34d007..4dcc012 100644
--- a/view/frontend/web/template/container/form/element/email.html
+++ b/view/frontend/web/template/container/form/element/email.html
@@ -44,11 +44,7 @@
                        data-validate="{required:true, 'validate-email':true}"
                        id="customer-email" />
                 <!-- ko template: 'ui/form/element/helper/tooltip' --><!-- /ko -->
-                <div data-bind="fadeVisible: isPasswordVisible" >
-                    <span class="note" data-bind="i18n: 'You already have an account with us.'"></span>
-                    <a href="javascript:void(0)" data-bind="click:triggerLogin.bind(),i18n: 'Sign in'"></a>
-                    <span class="note" data-bind="i18n: 'continue as guest.'"></span>
-                </div>
+                <span class="note" data-bind="fadeVisible: isPasswordVisible, i18n: 'You already have an account with us. Sign in or continue as guest.'"></span>
                 <!--<span class="note" data-bind="fadeVisible: isPasswordVisible() == false">&lt;!&ndash; ko i18n: 'You can create an account after checkout.'&ndash;&gt;&lt;!&ndash; /ko &ndash;&gt;</span>-->
             </div>
         </div>
diff --git a/view/frontend/web/template/container/review/comment.html b/view/frontend/web/template/container/review/comment.html
index 3b4eafc..d58b2fe 100644
--- a/view/frontend/web/template/container/review/comment.html
+++ b/view/frontend/web/template/container/review/comment.html
@@ -20,7 +20,7 @@
  */
 -->
 
-<div class="osc-place-order-block checkout-comment-block">
+<div class="osc-place-order-block checkout-comment-block col-mp mp-12">
     <div class="field-row">
         <label for="comments" data-bind="i18n: 'Comments'"></label>
         <div class="input-box">
