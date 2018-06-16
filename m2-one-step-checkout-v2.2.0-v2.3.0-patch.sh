diff --git a/Block/Order/View/DeliveryTime.php b/Block/Order/View/DeliveryTime.php
deleted file mode 100644
index 7120dc7..0000000
--- a/Block/Order/View/DeliveryTime.php
+++ /dev/null
@@ -1,74 +0,0 @@
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
- * Class DeliveryTime
- * @package Mageplaza\Osc\Block\Order\View
- */
-class DeliveryTime extends \Magento\Framework\View\Element\Template
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
-    )
-    {
-
-        $this->_coreRegistry = $registry;
-
-        parent::__construct($context, $data);
-    }
-
-    /**
-     * Get osc delivery time
-     *
-     * @return string
-     */
-    public function getDeliveryTime()
-    {
-        if ($order = $this->getOrder()) {
-            return $order->getOscDeliveryTime();
-        }
-
-        return '';
-    }
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
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index d49c4bc..20643b4 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -32,7 +32,7 @@ class Index extends \Magento\Checkout\Controller\Cart\Add
     public function execute()
     {
 //        $this->_objectManager->create('Magento\Catalog\Model\ResourceModel\Product\Collection');
-        $productId = 8;
+        $productId = 36;
         $storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
         $product = $this->productRepository->getById($productId, false, $storeId);
 
diff --git a/Helper/Config.php b/Helper/Config.php
index d7017c7..4e62529 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -506,9 +506,9 @@ class Config extends AbstractData
 	 * @param null $store
 	 * @return mixed
 	 */
-	public function isDisabledGiftMessage($store = null)
+	public function isEnabledGiftMessage($store = null)
 	{
-		return !$this->getDisplayConfig('is_enabled_gift_message', $store);
+		return !$this->getDisplayConfig('is_enabled_giftmessage', $store);
 	}
 
 	/**
@@ -591,52 +591,6 @@ class Config extends AbstractData
 		return $this->getDisplayConfig('is_checked_newsletter', $store);
 	}
 
-	/**
-	 * Social Login On Checkout Page
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isDisabledSocialLoginOnCheckout($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_social_login', $store);
-	}
-
-	/**
-	 * Delivery Time
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isDisabledDeliveryTime($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_delivery_time', $store);
-	}
-
-	/**
-	 * Delivery Time Format
-	 *
-	 * @param null $store
-	 *
-	 * @return string 'dd/mm/yy'|'mm/dd/yy'|'yy/mm/dd'
-	 */
-	public function getDeliveryTimeFormat($store = null)
-	{
-		$deliveryTimeFormat = $this->getDisplayConfig('delivery_time_format', $store);
-
-		return !empty($deliveryTimeFormat) ? $deliveryTimeFormat : 'dd/mm/yy';
-	}
-
-	/**
-	 * Delivery Time Off
-	 * @param null $store
-	 * @return bool|mixed
-	 */
-	public function getDeliveryTimeOff($store = null)
-	{
-		$deliveryTimeOff = $this->getDisplayConfig('delivery_time_off', $store);
-
-		return !empty($deliveryTimeOff) ? $deliveryTimeOff : false;
-	}
-
 	/***************************** Design Configuration *****************************
 	 *
 	 * @param null $store
diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index 24fdc8e..a48dcc3 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -24,14 +24,11 @@ use Magento\Framework\Exception\CouldNotSaveException;
 use Magento\Framework\Exception\InputException;
 use Magento\Framework\Exception\NoSuchEntityException;
 use Magento\Framework\UrlInterface;
-use Magento\GiftMessage\Model\GiftMessageManager;
-use Magento\GiftMessage\Model\Message;
 use Magento\Quote\Api\CartRepositoryInterface;
 use Magento\Quote\Api\CartTotalRepositoryInterface;
 use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Mageplaza\Osc\Api\CheckoutManagementInterface;
-use Mageplaza\Osc\Helper\Config as OscConfig;
 use Mageplaza\Osc\Model\OscDetailsFactory;
 
 /**
@@ -85,34 +82,14 @@ class CheckoutManagement implements CheckoutManagementInterface
 	protected $shippingInformationManagement;
 
 	/**
-	 * @type \Mageplaza\Osc\Helper\Config
-	 */
-	protected $oscConfig;
-
-	/**
-	 * @var Message
-	 */
-	protected $giftMessage;
-
-	/**
-	 * @var GiftMessageManager
-	 */
-	protected $giftMessageManagement;
-
-
-	/**
-	 * CheckoutManagement constructor.
-	 * @param CartRepositoryInterface $cartRepository
+	 * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
 	 * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
-	 * @param ShippingMethodManagementInterface $shippingMethodManagement
-	 * @param PaymentMethodManagementInterface $paymentMethodManagement
-	 * @param CartTotalRepositoryInterface $cartTotalsRepository
-	 * @param UrlInterface $urlBuilder
+	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+	 * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
+	 * @param \Magento\Framework\UrlInterface $urlBuilder
 	 * @param \Magento\Checkout\Model\Session $checkoutSession
 	 * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
-	 * @param OscConfig $oscConfig
-	 * @param Message $giftMessage
-	 * @param GiftMessageManager $giftMessageManager
 	 */
 	public function __construct(
 		CartRepositoryInterface $cartRepository,
@@ -122,10 +99,7 @@ class CheckoutManagement implements CheckoutManagementInterface
 		CartTotalRepositoryInterface $cartTotalsRepository,
 		UrlInterface $urlBuilder,
 		\Magento\Checkout\Model\Session $checkoutSession,
-		\Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement,
-		OscConfig $oscConfig,
-		Message $giftMessage,
-		GiftMessageManager $giftMessageManager
+		\Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
 	)
 	{
 		$this->cartRepository                = $cartRepository;
@@ -136,9 +110,6 @@ class CheckoutManagement implements CheckoutManagementInterface
 		$this->_urlBuilder                   = $urlBuilder;
 		$this->checkoutSession               = $checkoutSession;
 		$this->shippingInformationManagement = $shippingInformationManagement;
-		$this->oscConfig                     = $oscConfig;
-		$this->giftMessage                   = $giftMessage;
-		$this->giftMessageManagement         = $giftMessageManager;
 	}
 
 	/**
@@ -254,7 +225,6 @@ class CheckoutManagement implements CheckoutManagementInterface
 		try {
 			$additionInformation['customerAttributes'] = $customerAttributes;
 			$this->checkoutSession->setOscData($additionInformation);
-			$this->addGiftMessage($cartId, $additionInformation);
 
 			if ($addressInformation->getShippingAddress()) {
 				$this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
@@ -265,23 +235,4 @@ class CheckoutManagement implements CheckoutManagementInterface
 
 		return true;
 	}
-
-	/**
-	 * @param $cartId
-	 * @param $additionInformation
-	 * @throws \Magento\Framework\Exception\CouldNotSaveException
-	 */
-	public function addGiftMessage($cartId, $additionInformation)
-	{
-		/** @var \Magento\Quote\Model\Quote $quote */
-		$quote = $this->cartRepository->getActive($cartId);
-
-		if (!$this->oscConfig->isDisabledGiftMessage()) {
-			$giftMessage = json_decode($additionInformation['giftMessage'], true);
-			$this->giftMessage->setSender($giftMessage['sender']);
-			$this->giftMessage->setRecipient($giftMessage['recipient']);
-			$this->giftMessage->setMessage($giftMessage['message']);
-			$this->giftMessageManagement->setMessage($quote, 'quote', $this->giftMessage);
-		}
-	}
 }
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index d95d406..26fd722 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -23,11 +23,9 @@ namespace Mageplaza\Osc\Model;
 use Magento\Checkout\Model\ConfigProviderInterface;
 use Magento\Checkout\Model\Session as CheckoutSession;
 use Magento\Customer\Model\AccountManagement;
-use Magento\GiftMessage\Model\CompositeConfigProvider;
 use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Mageplaza\Osc\Helper\Config as OscConfig;
-use Magento\Framework\Module\Manager as ModuleManager;
 
 /**
  * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
@@ -57,39 +55,22 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	protected $oscConfig;
 
 	/**
-	 * @var \Magento\Checkout\Model\CompositeConfigProvider
-	 */
-	protected $giftMessageConfigProvider;
-
-	/**
-	 * @var ModuleManager
-	 */
-	protected $moduleManager;
-
-	/**
-	 * DefaultConfigProvider constructor.
-	 * @param CheckoutSession $checkoutSession
-	 * @param PaymentMethodManagementInterface $paymentMethodManagement
-	 * @param ShippingMethodManagementInterface $shippingMethodManagement
-	 * @param OscConfig $oscConfig
-	 * @param CompositeConfigProvider $configProvider
-	 * @param ModuleManager $moduleManager
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
 	 */
 	public function __construct(
 		CheckoutSession $checkoutSession,
 		PaymentMethodManagementInterface $paymentMethodManagement,
 		ShippingMethodManagementInterface $shippingMethodManagement,
-		OscConfig $oscConfig,
-		CompositeConfigProvider $configProvider,
-		ModuleManager $moduleManager
+		OscConfig $oscConfig
 	)
 	{
-		$this->checkoutSession         				= $checkoutSession;
-		$this->paymentMethodManagement  			= $paymentMethodManagement;
-		$this->shippingMethodManagement 			= $shippingMethodManagement;
-		$this->oscConfig                			= $oscConfig;
-		$this->giftMessageConfigProvider 			= $configProvider;
-		$this->moduleManager						= $moduleManager;
+		$this->checkoutSession          = $checkoutSession;
+		$this->paymentMethodManagement  = $paymentMethodManagement;
+		$this->shippingMethodManagement = $shippingMethodManagement;
+		$this->oscConfig                = $oscConfig;
 	}
 
 	/**
@@ -118,25 +99,19 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	private function getOscConfig()
 	{
 		return [
-			'addressFields'      	=> $this->getAddressFields(),
-			'autocomplete'       	=> [
+			'addressFields'      => $this->getAddressFields(),
+			'autocomplete'       => [
 				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
 				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
 			],
-			'register'           	=> [
+			'register'           => [
 				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
 				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
 			],
-			'allowGuestCheckout' 	=> $this->oscConfig->getAllowGuestCheckout(),
-			'showBillingAddress' 	=> $this->oscConfig->getShowBillingAddress(),
-			'newsletterDefault' 	=> $this->oscConfig->isSubscribedByDefault(),
-			'isUsedGiftWrap'     	=> (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
-			'giftMessageOptions' 	=> $this->giftMessageConfigProvider->getConfig(),
-			'isDisplaySocialLogin'	=> $this->isDisplaySocialLogin(),
-			'deliveryTimeOptions'	=> [
-				'deliveryTimeFormat'		=> $this->oscConfig->getDeliveryTimeFormat(),
-				'deliveryTimeOff'			=> $this->oscConfig->getDeliveryTimeOff()
-			]
+			'allowGuestCheckout' => $this->oscConfig->getAllowGuestCheckout(),
+			'showBillingAddress' => $this->oscConfig->getShowBillingAddress(),
+			'newsletterDefault'  => $this->oscConfig->isSubscribedByDefault(),
+			'isUsedGiftWrap'     => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap()
 		];
 	}
 
@@ -183,12 +158,4 @@ class DefaultConfigProvider implements ConfigProviderInterface
 
 		return $methodLists;
 	}
-
-	/**
-	 * @return bool
-	 */
-	private function isDisplaySocialLogin(){
-
-		return $this->moduleManager->isOutputEnabled('Mageplaza_SocialLogin') && !$this->oscConfig->isDisabledSocialLoginOnCheckout();
-	}
 }
diff --git a/Model/System/Config/Source/DeliveryTime.php b/Model/System/Config/Source/DeliveryTime.php
deleted file mode 100644
index cd1c1f2..0000000
--- a/Model/System/Config/Source/DeliveryTime.php
+++ /dev/null
@@ -1,48 +0,0 @@
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement.html
- */
-namespace Mageplaza\Osc\Model\System\Config\Source;
-
-use Magento\Framework\Model\AbstractModel;
-
-class DeliveryTime extends AbstractModel
-{
-    const DAY_MONTH_YEAR = 'dd/mm/yy';
-    const MONTH_DAY_YEAR = 'mm/dd/yy';
-    const YEAR_MONTH_DAY = 'yy/mm/dd';
-
-    public function toOptionArray()
-    {
-        $options = [
-            [
-                'label' => __('Day/Month/Year'),
-                'value' => self::DAY_MONTH_YEAR
-            ],
-            [
-                'label' => __('Month/Day/Year'),
-                'value' => self::MONTH_DAY_YEAR
-            ],
-            [
-                'label' => __('Year/Month/Day'),
-                'value' => self::YEAR_MONTH_DAY
-            ]
-        ];
-
-        return $options;
-    }
-}
\ No newline at end of file
diff --git a/Model/System/Config/Source/PaymentMethods.php b/Model/System/Config/Source/PaymentMethods.php
index bd7e484..f83868c 100644
--- a/Model/System/Config/Source/PaymentMethods.php
+++ b/Model/System/Config/Source/PaymentMethods.php
@@ -28,50 +28,50 @@ use Magento\Framework\Option\ArrayInterface;
  */
 class PaymentMethods implements ArrayInterface
 {
-	/**
-	 * @var \Magento\Payment\Helper\Data
-	 */
-	protected $_paymentHelperData;
+    /**
+     * @var \Magento\Checkout\Model\Type\Onepage
+     */
+    protected $_modelTypeOnepage;
 
-	/**
-	 * @var \Magento\Payment\Model\Config
-	 */
-	protected $_paymentModelConfig;
+    /**
+     * @var \Magento\Payment\Helper\Data
+     */
+    protected $_paymentHelperData;
 
-	/**
-	 * PaymentMethods constructor.
-	 * @param \Magento\Payment\Helper\Data $paymentHelperData
-	 * @param \Magento\Payment\Model\Config $paymentModelConfig
-	 */
-	public function __construct(
-		\Magento\Payment\Helper\Data $paymentHelperData,
-		\Magento\Payment\Model\Config $paymentModelConfig
-	)
-	{
-		$this->_paymentHelperData  = $paymentHelperData;
-		$this->_paymentModelConfig = $paymentModelConfig;
-	}
+    /**
+     * @param \Magento\Payment\Helper\Data $paymentHelperData
+     */
+    public function __construct(
+        \Magento\Payment\Helper\Data $paymentHelperData
+    ) {
+        $this->_paymentHelperData = $paymentHelperData;
+    }
 
-	/**
-	 * {@inheritdoc}
-	 */
-	public function toOptionArray()
-	{
-		$options = [
-			[
-				'label' => __('-- Please select --'),
-				'value' => '',
-			],
-		];
+    /**
+     * {@inheritdoc}
+     */
+    public function toOptionArray()
+    {
+        $options = [
+            [
+                'label' => __('-- Please select --'),
+                'value' => '',
+            ],
+        ];
 
-		$payments = $this->_paymentModelConfig->getActiveMethods();
-		foreach ($payments as $paymentCode => $paymentModel) {
-			$options[$paymentCode] = array(
-				'label' => $paymentModel->getTitle(),
-				'value' => $paymentCode
-			);
-		}
+        $methods = $this->_paymentHelperData->getPaymentMethods();
+        foreach(array_keys($methods) as $code){
+            try{
+                $model = $this->_paymentHelperData->getMethodInstance($code);
+                $options[] = [
+                    'label' => $model->getTitle(),
+                    'value' => $model->getCode(),
+                ];
+            } catch (\Exception $e){
+                continue;
+            }
+        }
 
-		return $options;
-	}
+        return $options;
+    }
 }
diff --git a/Observer/CheckoutSubmitBefore.php b/Observer/CheckoutSubmitBefore.php
index 344ba50..2a0d909 100644
--- a/Observer/CheckoutSubmitBefore.php
+++ b/Observer/CheckoutSubmitBefore.php
@@ -22,7 +22,6 @@ namespace Mageplaza\Osc\Observer;
 
 use Magento\Framework\Event\ObserverInterface;
 use Magento\Quote\Model\Quote;
-use Magento\Quote\Model\CustomerManagement;
 
 /**
  * Class CheckoutSubmitBefore
@@ -51,30 +50,22 @@ class CheckoutSubmitBefore implements ObserverInterface
 	protected $accountManagement;
 
 	/**
-	 * @var CustomerManagement
-	 */
-	protected $customerManagement;
-
-	/**
 	 * @param \Magento\Checkout\Model\Session $checkoutSession
 	 * @param \Magento\Framework\DataObject\Copy $objectCopyService
 	 * @param \Magento\Framework\Api\DataObjectHelper $dataObjectHelper
 	 * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
-	 * @param \Magento\Quote\Model\CustomerManagement $customerManagement
 	 */
 	public function __construct(
 		\Magento\Checkout\Model\Session $checkoutSession,
 		\Magento\Framework\DataObject\Copy $objectCopyService,
 		\Magento\Framework\Api\DataObjectHelper $dataObjectHelper,
-		\Magento\Customer\Api\AccountManagementInterface $accountManagement,
-		CustomerManagement $customerManagement
+		\Magento\Customer\Api\AccountManagementInterface $accountManagement
 	)
 	{
 		$this->checkoutSession    = $checkoutSession;
 		$this->_objectCopyService = $objectCopyService;
 		$this->dataObjectHelper   = $dataObjectHelper;
 		$this->accountManagement  = $accountManagement;
-		$this->customerManagement = $customerManagement;
 	}
 
 	/**
@@ -131,9 +122,6 @@ class CheckoutSubmitBefore implements ObserverInterface
 
 		$quote->setCustomer($customer);
 
-		/** Create customer */
-		$this->customerManagement->populateCustomerInfo($quote);
-
 		/** Init customer address */
 		$customerBillingData = $billing->exportCustomerAddress();
 		$customerBillingData->setIsDefaultBilling(true)
diff --git a/Observer/OscConfigObserver.php b/Observer/OscConfigObserver.php
deleted file mode 100644
index 9738d9d..0000000
--- a/Observer/OscConfigObserver.php
+++ /dev/null
@@ -1,66 +0,0 @@
-<?php
-
-/**
- * Copyright ? 2015 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-
-namespace Mageplaza\Osc\Observer;
-
-use Magento\Config\Model\ResourceModel\Config as ModelConfig;
-use Magento\Framework\App\Config\ScopeConfigInterface;
-use Magento\GiftMessage\Helper\Message;
-use Mageplaza\Osc\Helper\Config as HelperConfig;
-
-class OscConfigObserver implements \Magento\Framework\Event\ObserverInterface
-{
-    /**
-     * @var \Magento\Store\Model\StoreManagerInterface
-     */
-    protected $_storeManager;
-
-    /**
-     * @var HelperConfig
-     */
-    protected $_helperConfig;
-
-    /**
-     * @var ModelConfig
-     */
-    protected $_modelConfig;
-
-    /**
-     * GiftMessageConfigObserver constructor.
-     *
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     */
-    public function __construct(
-        HelperConfig $helperConfig,
-        ModelConfig $modelConfig
-    ) {
-        $this->_helperConfig = $helperConfig;
-        $this->_modelConfig  = $modelConfig;
-    }
-
-    /**
-     * @param \Magento\Framework\Event\Observer $observer
-     */
-    public function execute(\Magento\Framework\Event\Observer $observer)
-    {
-        $scopeId       = 0;
-        $isGiftMessage = !$this->_helperConfig->isDisabledGiftMessage();
-        $isEnableTOC   = ($this->_helperConfig->disabledPaymentTOC() || $this->_helperConfig->disabledReviewTOC());
-        $this->_modelConfig
-            ->saveConfig(
-                Message::XPATH_CONFIG_GIFT_MESSAGE_ALLOW_ORDER,
-                $isGiftMessage,
-                ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
-                $scopeId
-            )->saveConfig(
-                'checkout/options/enable_agreements',
-                $isEnableTOC,
-                ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
-                $scopeId
-            );
-    }
-}
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index 3981962..e1a47dd 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -28,55 +28,51 @@ use Magento\Framework\Event\ObserverInterface;
  */
 class QuoteSubmitBefore implements ObserverInterface
 {
-    /**
-     * @var \Magento\Checkout\Model\Session
-     */
-    protected $checkoutSession;
+	/**
+	 * @var \Magento\Checkout\Model\Session
+	 */
+	protected $checkoutSession;
 
-    /**
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @codeCoverageIgnore
-     */
-    public function __construct(
-        \Magento\Checkout\Model\Session $checkoutSession
-    )
-    {
+	/**
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @codeCoverageIgnore
+	 */
+	public function __construct(
+		\Magento\Checkout\Model\Session $checkoutSession
+	)
+	{
 
-        $this->checkoutSession = $checkoutSession;
-    }
+		$this->checkoutSession = $checkoutSession;
+	}
 
-    /**
-     * @param \Magento\Framework\Event\Observer $observer
-     * @return void
-     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
-     */
-    public function execute(\Magento\Framework\Event\Observer $observer)
-    {
-        $order = $observer->getEvent()->getOrder();
-        $quote = $observer->getEvent()->getQuote();
+	/**
+	 * @param \Magento\Framework\Event\Observer $observer
+	 * @return void
+	 * @SuppressWarnings(PHPMD.UnusedFormalParameter)
+	 */
+	public function execute(\Magento\Framework\Event\Observer $observer)
+	{
+		$order = $observer->getEvent()->getOrder();
+		$quote = $observer->getEvent()->getQuote();
 
-        $oscData = $this->checkoutSession->getOscData();
-        if (isset($oscData['comment'])) {
-            $order->setData('osc_order_comment', $oscData['comment']);
-        }
+		$oscData = $this->checkoutSession->getOscData();
+		if (isset($oscData['comment'])) {
+			$order->setData('osc_order_comment', $oscData['comment']);
+		}
 
-        if (isset($oscData['deliveryTime'])) {
-            $order->setData('osc_delivery_time', $oscData['deliveryTime']);
-        }
+		$address = $quote->getShippingAddress();
+		if ($address->getUsedGiftWrap() && $address->hasData('osc_gift_wrap_amount')) {
+			$order->setData('gift_wrap_type', $address->getGiftWrapType())
+				->setData('osc_gift_wrap_amount', $address->getOscGiftWrapAmount())
+				->setData('base_osc_gift_wrap_amount', $address->getBaseOscGiftWrapAmount());
 
-        $address = $quote->getShippingAddress();
-        if ($address->getUsedGiftWrap() && $address->hasData('osc_gift_wrap_amount')) {
-            $order->setData('gift_wrap_type', $address->getGiftWrapType())
-                ->setData('osc_gift_wrap_amount', $address->getOscGiftWrapAmount())
-                ->setData('base_osc_gift_wrap_amount', $address->getBaseOscGiftWrapAmount());
-
-            foreach ($order->getItems() as $item) {
-                $quoteItem = $quote->getItemById($item->getQuoteItemId());
-                if ($quoteItem && $quoteItem->hasData('osc_gift_wrap_amount')) {
-                    $item->setData('osc_gift_wrap_amount', $quoteItem->getOscGiftWrapAmount())
-                        ->setData('base_osc_gift_wrap_amount', $quoteItem->getBaseOscGiftWrapAmount());
-                }
-            }
-        }
-    }
+			foreach ($order->getItems() as $item) {
+				$quoteItem = $quote->getItemById($item->getQuoteItemId());
+				if ($quoteItem && $quoteItem->hasData('osc_gift_wrap_amount')) {
+					$item->setData('osc_gift_wrap_amount', $quoteItem->getOscGiftWrapAmount())
+						->setData('base_osc_gift_wrap_amount', $quoteItem->getBaseOscGiftWrapAmount());
+				}
+			}
+		}
+	}
 }
diff --git a/Setup/UpgradeData.php b/Setup/UpgradeData.php
index ec17588..aa648fa 100644
--- a/Setup/UpgradeData.php
+++ b/Setup/UpgradeData.php
@@ -84,13 +84,7 @@ class UpgradeData implements UpgradeDataInterface
 			$quoteInstaller->addAttribute('quote_address', 'used_gift_wrap', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_BOOLEAN, 'visible' => false]);
 			$quoteInstaller->addAttribute('quote_address', 'gift_wrap_type', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT, 'visible' => false]);
 			$salesInstaller->addAttribute('order', 'gift_wrap_type', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT, 'visible' => false]);
-
-		}
-
-		if (version_compare($context->getVersion(), '2.1.1') < 0) {
-			$salesInstaller->addAttribute('order', 'osc_delivery_time', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
 		}
-
 		$setup->endSetup();
 	}
 }
diff --git a/etc/adminhtml/events.xml b/etc/adminhtml/events.xml
deleted file mode 100644
index d42bf92..0000000
--- a/etc/adminhtml/events.xml
+++ /dev/null
@@ -1,28 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<!--
-/**
- * Magestore
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Magestore.com license that is
- * available through the world-wide-web at this URL:
- * http://www.magestore.com/license-agreement.html
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Magestore
- * @package     Magestore_OneStepCheckout
- * @copyright   Copyright (c) 2012 Magestore (http://www.magestore.com/)
- * @license     http://www.magestore.com/license-agreement.html
- */
--->
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
-    <event name="admin_system_config_changed_section_osc">
-        <observer name="osc_config_observer" instance="Mageplaza\Osc\Observer\OscConfigObserver" />
-    </event>
-
-</config>
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 48851ca..0702fc8 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -20,96 +20,77 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-        xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
+<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
     <system>
-        <section id="osc" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1"
-                 showInStore="1">
+        <section id="osc" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
             <label>One Step Checkout</label>
             <tab>mageplaza</tab>
             <resource>Mageplaza_Osc::config_osc</resource>
-            <group id="general" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1"
-                   showInStore="1">
+            <group id="general" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>General Configuration</label>
-                <field id="is_enabled" translate="label comment" sortOrder="10" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable One Step Checkout</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
-                <field id="title" translate="label comment" sortOrder="20" type="text" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="title" translate="label comment" sortOrder="20" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>One Step Checkout Page Title</label>
                 </field>
-                <field id="description" translate="label comment" sortOrder="40" type="textarea" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="description" translate="label comment" sortOrder="40" type="textarea" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>One Step Checkout Description</label>
                     <comment>HTML allowed</comment>
                 </field>
-                <field id="default_shipping_method" translate="label comment" sortOrder="70" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="default_shipping_method" translate="label comment" sortOrder="70" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Default Shipping Method</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ShippingMethods</source_model>
                     <comment>Set default shipping method in the checkout process.</comment>
                 </field>
-                <field id="default_payment_method" translate="label comment" sortOrder="80" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="default_payment_method" translate="label comment" sortOrder="80" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Default Payment Method</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\PaymentMethods</source_model>
                     <comment>Set default payment method in the checkout process.</comment>
                 </field>
-                <field id="allow_guest_checkout" translate="label comment" sortOrder="90" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="allow_guest_checkout" translate="label comment" sortOrder="90" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Allow Guest Checkout</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Allow checking out as a guest. Guest can create an account in the checkout page.</comment>
                 </field>
-                <field id="show_billing_address" translate="label comment" sortOrder="100" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="show_billing_address" translate="label comment" sortOrder="100" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Can Show Billing Address</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Allow customers can billing to a different address from billing address.</comment>
                 </field>
-                <field id="auto_detect_address" sortOrder="101" type="select" showInDefault="1" showInWebsite="1"
-                       showInStore="1" canRestore="1">
+                <field id="auto_detect_address" sortOrder="101" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Use Auto Suggestion Technology</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\AddressSuggest</source_model>
                     <comment>When customer fills address fields, it will suggest a list of full addresses.</comment>
                 </field>
-                <field id="google_api_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1"
-                       showInStore="1" canRestore="1">
+                <field id="google_api_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Google Api Key</label>
                     <comment>
-                        You should register a new key. Get Api key &lt;a
-                        href="https://developers.google.com/maps/documentation/javascript/get-api-key"
-                        target="_blank">here&lt;/a&gt;
+                        You should register a new key. Get Api key &lt;a href="https://developers.google.com/maps/documentation/javascript/get-api-key" target="_blank">here&lt;/a&gt;
                     </comment>
                     <validate>required-entry</validate>
                     <depends>
                         <field id="auto_detect_address">google</field>
                     </depends>
                 </field>
-                <field id="google_specific_country" sortOrder="102" type="select" showInDefault="1" showInWebsite="1"
-                       showInStore="1">
+                <field id="google_specific_country" sortOrder="102" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Restrict the auto suggestion for a specific country</label>
                     <source_model>Magento\Directory\Model\Config\Source\Country</source_model>
                     <depends>
                         <field id="auto_detect_address">google</field>
                     </depends>
                 </field>
-                <field id="pca_website_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1"
-                       showInStore="1">
+                <field id="pca_website_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Capture+ Key</label>
                     <comment>
-                        To set up a Capture+ account or these keys, please visit &lt;a
-                        href="http://www.pcapredict.com/en-us/address-capture-software/?utm_source=mageplaza.com&amp;utm_medium=one-step-checkout&amp;utm_campaign=one-step-checkout"
-                        target="_blank" style="margin-left:0;"&gt;Getting Started&lt;/a&gt; page
+                        To set up a Capture+ account or these keys, please visit &lt;a href="http://www.pcapredict.com/en-us/address-capture-software/?utm_source=mageplaza.com&amp;utm_medium=one-step-checkout&amp;utm_campaign=one-step-checkout" target="_blank" style="margin-left:0;"&gt;Getting Started&lt;/a&gt; page
                     </comment>
                     <depends>
                         <field id="auto_detect_address">pca</field>
                     </depends>
                 </field>
-                <field id="pca_country_lookup" sortOrder="103" type="select" showInDefault="1" showInWebsite="1"
-                       showInStore="1">
+                <field id="pca_country_lookup" sortOrder="103" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>IP Country Lookup</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>The default country will be set based on location of the customer.</comment>
@@ -118,40 +99,33 @@
                     </depends>
                 </field>
             </group>
-            <group id="display_configuration" translate="label comment" sortOrder="20" type="text" showInDefault="1"
-                   showInWebsite="1" showInStore="1">
+            <group id="display_configuration" translate="label comment" sortOrder="20" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>Display Configuration</label>
-                <field id="is_enabled_login_link" translate="label comment" sortOrder="2" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_login_link" translate="label comment" sortOrder="2" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Login Link</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
-                <field id="is_enabled_review_cart_section" translate="label comment" sortOrder="5" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_review_cart_section" translate="label comment" sortOrder="5" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Order Review Section</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>You can disable Order Review Section. It is enabled by default.</comment>
                 </field>
-                <field id="is_show_product_image" translate="label comment" sortOrder="6" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_show_product_image" translate="label comment" sortOrder="6" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Product Thumbnail Image</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <depends>
                         <field id="is_enabled_review_cart_section">1</field>
                     </depends>
                 </field>
-                <field id="show_coupon" translate="label comment" sortOrder="10" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="show_coupon" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Discount Code Section</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
                 </field>
-                <field id="is_enabled_gift_wrap" translate="label comment" sortOrder="20" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="is_enabled_gift_wrap" translate="label comment" sortOrder="20" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Enable Gift Wrap</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
-                <field id="gift_wrap_type" translate="label comment" sortOrder="21" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1">
+                <field id="gift_wrap_type" translate="label comment" sortOrder="21" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Calculate Method</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Giftwrap</source_model>
                     <comment>To calculate gift wrap fee based on item or order.</comment>
@@ -159,110 +133,64 @@
                         <field id="is_enabled_gift_wrap">1</field>
                     </depends>
                 </field>
-                <field id="gift_wrap_amount" translate="label comment" sortOrder="22" type="text" showInDefault="1"
-                       showInWebsite="1" showInStore="1">
+                <field id="gift_wrap_amount" translate="label comment" sortOrder="22" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Amount</label>
                     <comment>Enter the amount of gift wrap fee.</comment>
                     <depends>
                         <field id="is_enabled_gift_wrap">1</field>
                     </depends>
                 </field>
-                <field id="is_enabled_comments" translate="label comment" sortOrder="30" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_comments" translate="label comment" sortOrder="30" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Order Comment</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Allow customer comment in order.</comment>
                 </field>
-                <field id="is_enabled_gift_message" translate="label comment" sortOrder="35" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Enable Gift Message</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="show_toc" translate="label comment" sortOrder="40" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="show_toc" translate="label comment" sortOrder="40" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Terms and Conditions</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
                 </field>
-                <field id="is_enabled_newsletter" translate="label comment" sortOrder="60" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_newsletter" translate="label comment" sortOrder="60" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Newsletter Checkbox</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Show Sign up newsletter selection</comment>
                 </field>
-                <field id="is_checked_newsletter" translate="label comment" sortOrder="61" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_checked_newsletter" translate="label comment" sortOrder="61" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Checked Newsletter by default</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <depends>
                         <field id="is_enabled_newsletter">1</field>
                     </depends>
                 </field>
-                <field id="is_enabled_social_login" translate="label comment" sortOrder="70" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Enable Social Login On Checkout Page</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment>You should install &lt;a href="https://www.mageplaza.com/magento-2-social-login-extension"
-                        target="_blank">Social Login by Mageplaza&lt;/a&gt;</comment>
-                </field>
-                <field id="is_enabled_delivery_time" translate="label comment" sortOrder="80" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Enable Delivery Time</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="delivery_time_format" translate="label comment" sortOrder="81" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Date Format</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\DeliveryTime</source_model>
-                    <depends>
-                        <field id="is_enabled_delivery_time">1</field>
-                    </depends>
-                </field>
-                <field id="delivery_time_off" translate="label" type="multiselect" sortOrder="82" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Days Off</label>
-                    <source_model>Magento\Config\Model\Config\Source\Locale\Weekdays</source_model>
-                    <can_be_empty>1</can_be_empty>
-                    <depends>
-                        <field id="is_enabled_delivery_time">1</field>
-                    </depends>
-                </field>
             </group>
-            <group id="design_configuration" translate="label comment" sortOrder="30" type="text" showInDefault="1"
-                   showInWebsite="1" showInStore="1">
+            <group id="design_configuration" translate="label comment" sortOrder="30" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>Design Configuration</label>
-                <field id="page_layout" translate="label comment" sortOrder="1" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="page_layout" translate="label comment" sortOrder="1" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Checkout Page Layout</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Layout</source_model>
                 </field>
-                <field id="page_design" translate="label comment" sortOrder="10" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="page_design" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Design Style</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Design</source_model>
                 </field>
-                <field id="heading_background" translate="label comment" sortOrder="20" type="text" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="heading_background" translate="label comment" sortOrder="20" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Heading Background Color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                     <depends>
                         <field id="page_design" separator=",">flat,material</field>
                     </depends>
                 </field>
-                <field id="heading_text" translate="label comment" sortOrder="25" type="text" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="heading_text" translate="label comment" sortOrder="25" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Heading Text Color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                     <depends>
                         <field id="page_design" separator=",">flat,material</field>
                     </depends>
                 </field>
-                <field id="place_order_button" sortOrder="30" type="text" showInDefault="1" showInWebsite="1"
-                       showInStore="1" canRestore="1">
+                <field id="place_order_button" sortOrder="30" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Place Order button color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                 </field>
-                <field id="custom_css" sortOrder="100" type="textarea" showInDefault="1" showInWebsite="1"
-                       showInStore="1">
+                <field id="custom_css" sortOrder="100" type="textarea" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Custom Css</label>
                     <comment><![CDATA[Example: .step-title{background-color: #1979c3;}]]></comment>
                 </field>
diff --git a/etc/module.xml b/etc/module.xml
index 26559f7..70325fb 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -21,7 +21,7 @@
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
-    <module name="Mageplaza_Osc" setup_version="2.1.1"/>
+    <module name="Mageplaza_Osc" setup_version="2.1.0"/>
     <sequence>
         <module name="Mageplaza_Core"/>
         <module name="Magento_Checkout"/>
diff --git a/view/adminhtml/layout/sales_order_view.xml b/view/adminhtml/layout/sales_order_view.xml
index ba56590..40c252d 100644
--- a/view/adminhtml/layout/sales_order_view.xml
+++ b/view/adminhtml/layout/sales_order_view.xml
@@ -22,17 +22,12 @@
 -->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-2columns-left"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <head>
-        <css src="Mageplaza_Osc::css/style.css"/>
-    </head>
     <body>
         <referenceBlock name="order_tab_info">
             <block class="Magento\Backend\Block\Template" name="osc_additional_content"
                    template="Mageplaza_Osc::order/additional.phtml">
                 <block class="Mageplaza\Osc\Block\Order\View\Comment" name="order_comment"
                        template="order/view/comment.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time"
-                       template="order/view/delivery-time.phtml"/>
             </block>
         </referenceBlock>
         <referenceBlock name="order_totals">
diff --git a/view/adminhtml/templates/order/view/delivery-time.phtml b/view/adminhtml/templates/order/view/delivery-time.phtml
deleted file mode 100644
index 0fa0c07..0000000
--- a/view/adminhtml/templates/order/view/delivery-time.phtml
+++ /dev/null
@@ -1,35 +0,0 @@
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
-<?php if ($deliveryTimeHtml = $block->getDeliveryTime()): ?>
-    <div class="admin__page-section-item order-delivery-time">
-        <div class="admin__page-section-item-title">
-            <span class="title"><?php /* @escapeNotVerified */ echo __('Delivery Time') ?></span>
-        </div>
-        <div class="admin__page-section-item-content">
-            <?php echo $deliveryTimeHtml ?>
-        </div>
-    </div>
-<?php endif; ?>
-
diff --git a/view/adminhtml/web/css/style.css b/view/adminhtml/web/css/style.css
index dea4d34..1d38dab 100644
--- a/view/adminhtml/web/css/style.css
+++ b/view/adminhtml/web/css/style.css
@@ -142,10 +142,4 @@
 .f-right, .right {
     float: right;
 }
-ul.sortable-list{list-style: none !important;}
-
-/** Additional Content*/
-.order-osc-additional .admin__page-section-item{
-    float:left;
-    width:50%;
-}
\ No newline at end of file
+ul.sortable-list{list-style: none !important;}
\ No newline at end of file
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index 3de639e..897bae5 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -60,16 +60,6 @@
                                                         <item name="customer-email" xsi:type="array">
                                                             <item name="component" xsi:type="string">Mageplaza_Osc/js/view/form/element/email</item>
                                                         </item>
-                                                        <item name="shippingAdditional" xsi:type="array">
-                                                            <item name="component" xsi:type="string">uiComponent</item>
-                                                            <item name="displayArea" xsi:type="string">shippingAdditional</item>
-                                                            <item name="children" xsi:type="array">
-                                                                <item name="additional_block" xsi:type="array">
-                                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/delivery-time</item>
-                                                                    <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledDeliveryTime" />
-                                                                </item>
-                                                            </item>
-                                                        </item>
                                                         <item name="address-list" xsi:type="array">
                                                             <item name="config" xsi:type="array">
                                                                 <item name="rendererTemplates" xsi:type="array">
@@ -327,13 +317,6 @@
                                                                 <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledGiftWrap" />
                                                             </item>
                                                         </item>
-                                                        <item name="gift-message" xsi:type="array">
-                                                            <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/addition/gift-message</item>
-                                                            <item name="sortOrder" xsi:type="string">40</item>
-                                                            <item name="config" xsi:type="array">
-                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledGiftMessage" />
-                                                            </item>
-                                                        </item>
                                                     </item>
                                                 </item>
                                             </item>
diff --git a/view/frontend/layout/sales_order_view.xml b/view/frontend/layout/sales_order_view.xml
index a653c1d..ee6ca2d 100644
--- a/view/frontend/layout/sales_order_view.xml
+++ b/view/frontend/layout/sales_order_view.xml
@@ -28,8 +28,6 @@
                    template="Mageplaza_Osc::order/additional.phtml" after="-">
                 <block class="Mageplaza\Osc\Block\Order\View\Comment" name="comment"
                        template="order/view/comment.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time"
-                       template="order/view/delivery-time.phtml"/>
             </block>
         </referenceContainer>
         <referenceBlock name="order_totals">
diff --git a/view/frontend/templates/design.phtml b/view/frontend/templates/design.phtml
index 7448d51..6e93dd9 100644
--- a/view/frontend/templates/design.phtml
+++ b/view/frontend/templates/design.phtml
@@ -33,7 +33,7 @@
 <?php switch ($design['page_design']): ?><?php case 'flat': ?>
 	.checkout-container a.button-action,
 	.popup-authentication button.action,
-	.checkout-container button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link):not(.ui-datepicker-trigger){
+	.checkout-container button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link){
 		background-color: <?php echo $design['heading_background'] ?> !important;
 		border-color: <?php echo $design['heading_background'] ?> !important;
 		box-shadow: none !important;
diff --git a/view/frontend/templates/order/view/delivery-time.phtml b/view/frontend/templates/order/view/delivery-time.phtml
deleted file mode 100644
index 6044b8e..0000000
--- a/view/frontend/templates/order/view/delivery-time.phtml
+++ /dev/null
@@ -1,33 +0,0 @@
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
-
-<?php if ($deliveryTimeHtml = $block->getDeliveryTime()): ?>
-    <div class="box box-order-delivery-time">
-        <strong class="box-title">
-            <span><?php /* @escapeNotVerified */ echo __('Delivery Time') ?></span>
-        </strong>
-        <div class="box-delivery-time">
-            <?php echo $deliveryTimeHtml;?>
-        </div>
-    </div>
-<?php endif; ?>
-
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index a7a95a4..6b2c3a5 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -34,8 +34,6 @@
 .osc-authentication-wrapper{padding-left: 10px}
 .osc-authentication-toggle{cursor: pointer}
 .popup-authentication .block-authentication {border: none !important;}
-.checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap .modal-content .mfp-hide {display: block !important;}
-.checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap h1.modal-title{display: none}
 
 /**************************************************** Shipping address area ****************************************************/
 .one-step-checkout-wrapper .form.form-login{border-bottom: 0 !important; padding-bottom: 0 !important;}
@@ -55,8 +53,6 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .fieldset > .field:not(.choice) > .control{float: none !important; width: 100% !important;}
 .fieldset > .field {margin: 0 0 20px !important;}
 #checkout-step-shipping .form-login {margin-top: 0 !important;}
-.fieldset > .form-create-account> .field.required > .label:after {  content: '*';  color: #e02b27;  font-size: 1.2rem;  margin: 0 0 0 5px;  }
-
 
 /**************************************************** Billing address area ****************************************************/
 .checkout-billing-address .step-content .field.field-select-billing label{display: none}
@@ -68,10 +64,7 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .osc-shipping-method ul{padding:0;}
 .osc-shipping-method ul li{list-style: none;}
 .table-checkout-shipping-method thead th{display: none;}
-.fieldset > .form-create-account> .field.required > .label:after {  content: '*';  color: #e02b27;  font-size: 1.2rem;  margin: 0 0 0 5px;  }
-.delivery-time .title{margin: 10px 0;}
-.delivery-time .title span{font-weight: bold;}
-.delivery-time .control input{width:65%}
+
 /**************************************************** Payment method area ****************************************************/
 .osc-payment-after-methods .opc-payment-additional .field .control{float: left; margin-right: 3px}
 .payment-method-content .payment-method-billing-address,
@@ -105,10 +98,6 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .one-step-checkout-wrapper .mp-4 .minicart-items-wrapper .product-image-container{display: none;}
 .one-step-checkout-wrapper .mp-4 .opc-block-summary{padding: 0 10px !important;}
 .one-step-checkout-wrapper .mp-4 #checkout-review-table thead th,.one-step-checkout-wrapper .mp-4 #checkout-review-table tbody tr td,.one-step-checkout-wrapper .mp-4 #checkout-review-table tfoot tr td{padding-left: 5px !important;padding-right: 5px !important;}
-.cart-gift-item{float:left;margin-left: 0;width:100%}
-.gift-options-content{margin-top: 10px;}
-.gift-options-content .fieldset{margin:0}
-.gift-options-content .secondary{float:right;margin-right:7px}
 
 /**************************************************** Place order area ****************************************************/
 #co-place-order-area{padding: 0 20px !important;}
@@ -123,17 +112,15 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 
 /**************************************************** Responsive ****************************************************/
 @media (min-width: 1024px), print {
-    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap {  margin-left: auto !important;  margin-right: auto !important;  left: 0 !important;  right: 0 !important;  width: 500px !important;  min-width: 0;  }
-
+    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap {
+        margin-left: auto !important;
+        margin-right: auto !important;
+        left: 0 !important;
+        right: 0 !important;
+        width: 500px !important;
+        min-width: 0;
+    }
     .popup-authentication .block[class] {
         padding-right: 0 !important;
     }
 }
-@media (min-width: 786px), print {
-    .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap {  margin-left: auto !important;  margin-right: auto !important;  left: 0 !important;  right: 0 !important;  width: 600px !important;  min-width: 0;  }
-    .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap header{padding: 0 !important;z-index:99;}
-    .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap header .action-close{padding: 15px !important;}
-    .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap header .action-close:before{color: #fff !important;font-weight: bold}
-    .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap .modal-content{padding:0 !important}
-
-}
diff --git a/view/frontend/web/js/model/gift-message.js b/view/frontend/web/js/model/gift-message.js
deleted file mode 100644
index 8b39207..0000000
--- a/view/frontend/web/js/model/gift-message.js
+++ /dev/null
@@ -1,77 +0,0 @@
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
-define(['ko', 'uiElement', 'underscore'],
-    function (ko, uiElement, _) {
-        'use strict';
-
-        var provider = uiElement();
-
-        return function () {
-            var model = {
-                observables: {},
-                initialize: function () {
-                    this.getObservable('alreadyAdded')(false);
-                    var message = window.checkoutConfig.oscConfig.giftMessageOptions.giftMessage.hasOwnProperty('orderLevel')
-                        ? window.checkoutConfig.oscConfig.giftMessageOptions.giftMessage['orderLevel']
-                        : null;
-                    if (_.isObject(message)) {
-                        this.getObservable('recipient')(message.recipient);
-                        this.getObservable('sender')(message.sender);
-                        this.getObservable('message')(message.message);
-                        this.getObservable('alreadyAdded')(true);
-                    }
-                },
-                getObservable: function (key) {
-                    this.initObservable('message-orderLevel', key);
-                    return provider[this.getUniqueKey('message-orderLevel', key)];
-                },
-                initObservable: function (node, key) {
-                    if (node && !this.observables.hasOwnProperty(node)) {
-                        this.observables[node] = [];
-                    }
-                    if (key && this.observables[node].indexOf(key) == -1) {
-                        this.observables[node].push(key);
-                        provider.observe(this.getUniqueKey(node, key));
-                    }
-                },
-                getUniqueKey: function (node, key) {
-                    return node + '-' + key;
-                },
-                getConfigValue: function (key) {
-                    return window.checkoutConfig.oscConfig.giftMessageOptions.hasOwnProperty(key) ?
-                        window.checkoutConfig.oscConfig.giftMessageOptions[key]
-                        : null;
-                },
-
-                /**
-                 * Check if gift message can be displayed
-                 *
-                 * @returns {Boolean}
-                 */
-                isGiftMessageAvailable: function () {
-                    return this.getConfigValue('isOrderLevelGiftOptionsEnabled');
-                }
-            };
-            model.initialize();
-            return model;
-        }
-    }
-);
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index 261c06d..e6ca356 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -56,6 +56,7 @@ define(
                 };
                 return this.getUrl(urls, params);
             },
+
             /** Get url for update item qty and remove item */
             getUrlForUpdatePaymentTotalInformation: function (quote) {
                 var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 454f3d2..e19e320 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -54,11 +54,8 @@ define(
             postcodeElementName = 'postcode',
             observedElements = [],
             observableElements,
-            rules = shippingRatesValidationRules.getRules(),
             addressFields = window.checkoutConfig.oscConfig.addressFields;
 
-            rules = _.isEmpty(rules) ? {'rate': {'postcode': {'required': true}, 'country_id': {'required': true}}} : rules;
-
         return _.extend(Validator, {
             isFormInline: addressList().length == 0,
 
@@ -66,7 +63,7 @@ define(
                 var self = this,
                     canLoad = false;
 
-                $.each(rules, function (carrier, fields) {
+                $.each(shippingRatesValidationRules.getRules(), function (carrier, fields) {
                     if (fields.hasOwnProperty(field)) {
                         var missingValue = false;
                         $.each(fields, function (key, rule) {
@@ -113,10 +110,6 @@ define(
                 var self = this;
 
                 observableElements = shippingRatesValidationRules.getObservableFields();
-                if(_.isEmpty(observableElements)){
-                    observableElements.push('country_id');
-                }
-
                 if ($.inArray(postcodeElementName, observableElements) === -1) {
                     // Add postcode field to observables if not exist for zip code validation support
                     observableElements.push(postcodeElementName);
diff --git a/view/frontend/web/js/model/shipping-save-processor/checkout.js b/view/frontend/web/js/model/shipping-save-processor/checkout.js
index 5389aa8..116f757 100644
--- a/view/frontend/web/js/model/shipping-save-processor/checkout.js
+++ b/view/frontend/web/js/model/shipping-save-processor/checkout.js
@@ -42,8 +42,7 @@ define(
               methodConverter,
               errorProcessor,
               fullScreenLoader,
-              selectBillingAddressAction
-    ) {
+              selectBillingAddressAction) {
         'use strict';
 
         return {
@@ -51,9 +50,7 @@ define(
                 var payload,
                     addressInformation = {},
                     additionInformation = oscData.getData();
-                if(window.checkoutConfig.oscConfig.giftMessageOptions.isOrderLevelGiftOptionsEnabled) {
-                    additionInformation.giftMessage = this.saveGiftMessage();
-                }
+
                 if (!quote.billingAddress()) {
                     selectBillingAddressAction(quote.shippingAddress());
                 }
@@ -89,14 +86,6 @@ define(
                         fullScreenLoader.stopLoader();
                     }
                 );
-            },
-            saveGiftMessage: function(){
-                var giftMessage={};
-                if(!$("#osc-gift-message").is(":checked"))$('.gift-options-content').find('input:text,textarea').val('');
-                giftMessage.sender      = $("#gift-message-whole-from").val();
-                giftMessage.recipient   = $("#gift-message-whole-to").val();
-                giftMessage.message     = $("#gift-message-whole-message").val();
-                return JSON.stringify(giftMessage);
             }
         };
     }
diff --git a/view/frontend/web/js/view/authentication.js b/view/frontend/web/js/view/authentication.js
index 9e6e17a..40d92f9 100644
--- a/view/frontend/web/js/view/authentication.js
+++ b/view/frontend/web/js/view/authentication.js
@@ -71,10 +71,6 @@ define(
                     'trigger': '.osc-authentication-toggle',
                     'buttons': []
                 };
-                if(window.checkoutConfig.oscConfig.isDisplaySocialLogin && $("#social-login-popup").length>0){
-                    this.modalWindow    =   $("#social-login-popup");
-                    options.modalClass  =   'osc-social-login-popup';
-                }
                 modal(options, $(this.modalWindow));
             },
 
diff --git a/view/frontend/web/js/view/delivery-time.js b/view/frontend/web/js/view/delivery-time.js
deleted file mode 100644
index e273bad..0000000
--- a/view/frontend/web/js/view/delivery-time.js
+++ /dev/null
@@ -1,69 +0,0 @@
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
-        'jquery',
-        'ko',
-        'uiComponent',
-        'mage/calendar',
-        'Mageplaza_Osc/js/model/osc-data'
-    ],
-    function ($, ko, Component, calendar, oscData) {
-        'use strict';
-        var cacheKey   = 'deliveryTime';
-        var dateFormat = window.checkoutConfig.oscConfig.deliveryTimeOptions.deliveryTimeFormat;
-        var daysOff    = window.checkoutConfig.oscConfig.deliveryTimeOptions.deliveryTimeOff;
-        return Component.extend({
-            defaults: {
-                template: 'Mageplaza_Osc/container/delivery-time'
-            },
-            deliveryTimeValue: ko.observable(),
-            initialize: function () {
-                this._super();
-                ko.bindingHandlers.datepicker = {
-                    init: function (element) {
-                        var options = {
-                            minDate: 0,
-                            showButtonPanel: false,
-                            dateFormat: dateFormat,
-                            showOn: 'both',
-                            buttonText: '',
-                            beforeShowDay: function (date) {
-                                if(!daysOff) return [true];
-                                var daysOffToArray = daysOff.split(',');
-                                $(daysOffToArray).each(function (index) {
-                                    daysOffToArray[index] = parseInt(daysOffToArray[index]);
-                                });
-                                return daysOff.indexOf(date.getDay()) != -1 ? [false] : [true];
-                            }
-                        };
-                        $(element).datetimepicker(options);
-                    }
-                };
-                this.deliveryTimeValue(oscData.getData(cacheKey));
-                this.deliveryTimeValue.subscribe(function (newValue) {
-                    oscData.setData(cacheKey, newValue);
-                });
-                return this;
-            }
-        });
-    }
-);
diff --git a/view/frontend/web/js/view/review/addition/gift-message.js b/view/frontend/web/js/view/review/addition/gift-message.js
deleted file mode 100644
index e3346f8..0000000
--- a/view/frontend/web/js/view/review/addition/gift-message.js
+++ /dev/null
@@ -1,105 +0,0 @@
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
-        'ko',
-        'jquery',
-        'uiComponent',
-        'Mageplaza_Osc/js/model/gift-message'
-    ],
-    function (ko, $, Component, giftMessageModel) {
-        'use strict';
-        return Component.extend({
-
-            defaults: {
-                template: 'Mageplaza_Osc/container/review/addition/gift-message'
-            },
-            formBlockVisibility: null,
-            resultBlockVisibility: null,
-            model: {},
-
-            /**
-             * Component init
-             */
-            initialize: function () {
-                this._super()
-                    .observe('formBlockVisibility')
-                    .observe({
-                        'resultBlockVisibility': false
-                    });
-                this.model = new giftMessageModel();
-                this.isResultBlockVisible();
-                this.isUseGiftMessage();
-            },
-
-            /**
-             *
-             * @returns {boolean}
-             */
-            isUseGiftMessage: function () {
-                return !!window.checkoutConfig.oscConfig.giftMessageOptions.giftMessage.orderLevel.hasOwnProperty("gift_message_id");
-            },
-
-            /**
-             * Is reslt block visible
-             */
-            isResultBlockVisible: function () {
-                var self = this;
-
-                if (this.model.getObservable('alreadyAdded')()) {
-                    this.resultBlockVisibility(true);
-                }
-                this.model.getObservable('additionalOptionsApplied').subscribe(function (value) {
-                    if (value == true) {
-                        self.resultBlockVisibility(true);
-                    }
-                });
-            },
-
-            /**
-             * @param {String} key
-             * @return {*}
-             */
-            getObservable: function (key) {
-                return this.model.getObservable(key);
-            },
-
-            /**
-             * Hide\Show form block
-             */
-            toggleFormBlockVisibility: function () {
-                if (!this.model.getObservable('alreadyAdded')()) {
-                    this.formBlockVisibility(!this.formBlockVisibility());
-                } else {
-                    this.resultBlockVisibility(!this.resultBlockVisibility());
-                }
-                return true;
-            },
-
-            /**
-             * @return {Boolean}
-             */
-            isActive: function () {
-                return this.model.isGiftMessageAvailable();
-            }
-        });
-    }
-);
diff --git a/view/frontend/web/template/container/delivery-time.html b/view/frontend/web/template/container/delivery-time.html
deleted file mode 100644
index c262dda..0000000
--- a/view/frontend/web/template/container/delivery-time.html
+++ /dev/null
@@ -1,30 +0,0 @@
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
-
-<div class="delivery-time">
-    <div class="title">
-        <span data-bind="i18n: 'Delivery Time'">Delivery Time</span>
-    </div>
-    <div class="control">
-        <input type="text" readonly="true" data-bind="datepicker: true,value: deliveryTimeValue" id="osc-delivery-time"/>
-    </div>
-</div>
diff --git a/view/frontend/web/template/container/review/addition/gift-message.html b/view/frontend/web/template/container/review/addition/gift-message.html
deleted file mode 100644
index 0b06d7c..0000000
--- a/view/frontend/web/template/container/review/addition/gift-message.html
+++ /dev/null
@@ -1,52 +0,0 @@
-<!--
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
--->
-<!-- ko if: isActive() -->
-<div class="gift-message field choice col-mp mp-12">
-    <input type="checkbox" name="osc-gift-message" data-bind="attr: {id: 'osc-gift-message'}, click: $data.toggleFormBlockVisibility.bind($data),checked: isUseGiftMessage()" />
-    <label data-bind="attr: {for: 'osc-gift-message'}">
-        <span data-bind="i18n: 'Gift Message'"></span>
-    </label>
-    <div class="gift-options-content" data-bind="visible: formBlockVisibility() || resultBlockVisibility()">
-        <div class="fieldset">
-            <div class="field field-from col-mp mp-6">
-                <label for="gift-message-whole-from" class="label">
-                    <span data-bind="i18n: 'From:'"></span>
-                </label>
-                <div class="control">
-                    <input type="text"
-                           id="gift-message-whole-from"
-                           class="input-text"
-                           data-bind="value: getObservable('sender')">
-                </div>
-            </div>
-            <div class="field field-to col-mp mp-6">
-                <label for="gift-message-whole-to" class="label">
-                    <span data-bind="i18n: 'To:'"></span>
-                </label>
-                <div class="control">
-                    <input type="text"
-                           id="gift-message-whole-to"
-                           class="input-text"
-                           data-bind="value: getObservable('recipient')">
-                </div>
-            </div>
-            <div class="field text col-mp mp-12">
-                <label for="gift-message-whole-message" class="label">
-                    <span data-bind="i18n: 'Message:'"></span>
-                </label>
-                <div class="control">
-                    <textarea id="gift-message-whole-message"
-                              class="input-text"
-                              rows="5" cols="10"
-                              data-bind="value: getObservable('message')"></textarea>
-                </div>
-            </div>
-        </div>
-    </div>
-</div>
-<!-- /ko -->
-
