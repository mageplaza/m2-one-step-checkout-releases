diff --git a/Block/Adminhtml/System/Config/Geoip.php b/Block/Adminhtml/System/Config/Geoip.php
deleted file mode 100644
index a0f1b9a..0000000
--- a/Block/Adminhtml/System/Config/Geoip.php
+++ /dev/null
@@ -1,115 +0,0 @@
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
-namespace Mageplaza\Osc\Block\Adminhtml\System\Config;
-
-use Magento\Backend\Block\Template\Context;
-use Magento\Config\Block\System\Config\Form\Field;
-use Magento\Framework\Data\Form\Element\AbstractElement;
-use Mageplaza\Osc\Helper\Data as HelperData;
-
-
-class Geoip extends Field
-{
-	/**
-	 * @var string
-	 */
-	protected $_template = 'Mageplaza_Osc::system/config/geoip.phtml';
-
-	/**
-	 * @type \Mageplaza\Osc\Helper\Data
-	 */
-	protected $_helperData;
-
-	/**
-	 * @param Context $context
-	 * @param array $data
-	 */
-	public function __construct(
-		Context $context,
-		HelperData $helperData,
-		array $data = []
-	) {
-		$this->_helperData = $helperData;
-		parent::__construct($context, $data);
-	}
-
-	/**
-	 * Remove scope label
-	 *
-	 * @param  AbstractElement $element
-	 * @return string
-	 */
-	public function render(AbstractElement $element)
-	{
-		$element->unsScope()->unsCanUseWebsiteValue()->unsCanUseDefaultValue();
-		return parent::render($element);
-	}
-
-	/**
-	 * Return element html
-	 *
-	 * @param  AbstractElement $element
-	 * @return string
-	 */
-	protected function _getElementHtml(AbstractElement $element)
-	{
-		return $this->_toHtml();
-	}
-
-	/**
-	 * Return ajax url for collect button
-	 *
-	 * @return string
-	 */
-	public function getAjaxUrl()
-	{
-		return $this->getUrl('onestepcheckout/system_config/geoip');
-	}
-
-	/**
-	 * Generate collect button html
-	 *
-	 * @return string
-	 */
-	public function getButtonHtml()
-	{
-		$button = $this->getLayout()->createBlock(
-			'Magento\Backend\Block\Widget\Button'
-		)->setData(
-			[
-				'id' => 'geoip_button',
-				'label' => __('Download Library'),
-			]
-		);
-
-		return $button->toHtml();
-	}
-
-	/**
-	 * @return string
-	 */
-	public function isDisplayIcon(){
-		return $this->_helperData->checkHasLibrary() ? '' : 'hidden="hidden';
-	}
-
-}
-?>
\ No newline at end of file
diff --git a/Block/Checkout/CompatibleConfig.php b/Block/Checkout/CompatibleConfig.php
deleted file mode 100644
index 38ff574..0000000
--- a/Block/Checkout/CompatibleConfig.php
+++ /dev/null
@@ -1,60 +0,0 @@
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
-namespace Mageplaza\Osc\Block\Checkout;
-
-use Magento\Framework\View\Element\Template;
-
-class CompatibleConfig extends Template
-{
-    /**
-     * @var string $_template
-     */
-    protected $_template = "onepage/compatible-config.phtml";
-
-    /**
-     * @var \Mageplaza\Osc\Helper\Config
-     */
-    protected $_oscConfig;
-
-    /**
-     * CompatibleConfig constructor.
-     * @param Template\Context $context
-     * @param array $data
-     */
-    public function __construct(
-        Template\Context $context,
-        \Mageplaza\Osc\Helper\Config $oscConfig,
-        array $data = []
-    )
-    {
-        parent::__construct($context, $data);
-        $this->_oscConfig = $oscConfig;
-    }
-
-    /**
-     * @return bool
-     */
-    public function isEnableModulePostNL()
-    {
-        return $this->_oscConfig->isEnableModulePostNL();
-    }
-}
\ No newline at end of file
diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index fb45521..8775312 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -116,11 +116,17 @@ class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcesso
 		}
 
 		/** Remove billing customer email if quote is not virtual */
-		if (!$this->checkoutSession->getQuote()->isVirtual()) {
+		if (!$this->checkoutSession->getQuote()->isVirtual() && !$this->_oscHelper->isShowBillingAddressBeforeShippingAddress()) {
 			unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
 				['children']['customer-email']);
 		}
 
+		/** Remove shipping customer email if show billing address before shipping address is enable */
+		if ($this->_oscHelper->isShowBillingAddressBeforeShippingAddress()) {
+			unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+				['children']['customer-email']);
+		}
+
 		/** Remove billing address in payment method content */
 		$fields = &$jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
 		['payment']['children']['payments-list']['children'];
@@ -213,9 +219,6 @@ class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcesso
 	private function addAddressOption(&$fields)
 	{
 		$fieldPosition = $this->_oscHelper->getAddressFieldPosition();
-
-		$this->rewriteFieldStreet($fields);
-
 		foreach ($fields as $code => &$field) {
 			$fieldConfig = isset($fieldPosition[$code]) ? $fieldPosition[$code] : [];
 			if (!sizeof($fieldConfig)) {
@@ -259,30 +262,6 @@ class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcesso
 			}
 		} elseif (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
 			$field['config']['elementTmpl'] = $template;
-			if($this->_oscHelper->isUsedMaterialDesign()){
-				$field['config']['template'] = 'Mageplaza_Osc/container/form/field';
-			}
-		}
-
-		return $this;
-	}
-
-	/**
-	 * Change template street when enable material design
-	 * @param $fields
-	 * @return $this
-	 */
-	public function rewriteFieldStreet(&$fields){
-
-		if($this->_oscHelper->isUsedMaterialDesign()){
-			$fields['country_id']['config']['template'] =  'Mageplaza_Osc/container/form/field';
-			$fields['region_id']['config']['template']  =  'Mageplaza_Osc/container/form/field';
-			foreach ($fields['street']['children'] as $key => $value){
-				$fields['street']['children'][0]['label']= $fields['street']['label'];
-				$fields['street']['children'][$key]['config']['template'] = 'Mageplaza_Osc/container/form/field';
-			}
-			$fields['street']['config']['fieldTemplate'] = 'Mageplaza_Osc/container/form/field';
-			unset($fields['street']['label']);
 		}
 
 		return $this;
diff --git a/Block/Design.php b/Block/Design.php
index 5a55277..347b4fd 100644
--- a/Block/Design.php
+++ b/Block/Design.php
@@ -23,8 +23,6 @@ namespace Mageplaza\Osc\Block;
 use Mageplaza\Osc\Helper\Config;
 use Magento\Framework\View\Element\Template;
 use Magento\Framework\View\Element\Template\Context;
-use Magento\Framework\View\Design\Theme\ThemeProviderInterface;
-use Magento\Checkout\Model\Session as CheckoutSession;
 
 /**
  * Class Css
@@ -38,35 +36,19 @@ class Design extends Template
     protected $_helperConfig;
 
     /**
-     * @var ThemeProviderInterface
-     */
-    protected $_themeProviderInterface;
-
-    /**
-     * @type \Magento\Checkout\Model\Session
-     */
-    private $checkoutSession;
-
-    /**
-     * @param Context $context
-     * @param Config $helperConfig
-     * @param ThemeProviderInterface $themeProviderInterface
-     * @param CheckoutSession $checkoutSession
+     * @param \Magento\Framework\View\Element\Template\Context $context
+     * @param \Mageplaza\Osc\Helper\Config $helperConfig
      * @param array $data
      */
     public function __construct(
         Context $context,
         Config $helperConfig,
-        ThemeProviderInterface $themeProviderInterface,
-        CheckoutSession $checkoutSession,
         array $data = []
     ) {
     
         parent::__construct($context, $data);
 
-        $this->_helperConfig            = $helperConfig;
-        $this->_themeProviderInterface  = $themeProviderInterface;
-        $this->checkoutSession          = $checkoutSession;
+        $this->_helperConfig = $helperConfig;
     }
 
     /**
@@ -100,18 +82,4 @@ class Design extends Template
     {
         return $this->getHelperConfig()->getDesignConfig();
     }
-
-    /**
-     * @return string
-     */
-    public function getCurrentTheme(){
-        return $this->_themeProviderInterface->getThemeById($this->getHelperConfig()->getCurrentThemeId())->getCode();
-    }
-
-    /**
-     * @return bool
-     */
-    public function isVirtual(){
-       return $this->checkoutSession->getQuote()->isVirtual();
-    }
 }
diff --git a/Block/Order/View/DeliveryTime.php b/Block/Order/View/DeliveryTime.php
index 3264fba..7120dc7 100644
--- a/Block/Order/View/DeliveryTime.php
+++ b/Block/Order/View/DeliveryTime.php
@@ -62,19 +62,6 @@ class DeliveryTime extends \Magento\Framework\View\Element\Template
         return '';
     }
 
-	/**
-	 * Get osc house security code
-	 *
-	 * @return string
-	 */
-	public function getHouseSecurityCode()
-	{
-		if ($order = $this->getOrder())	{
-			return $order->getOscOrderHouseSecurityCode();
-		}
-		return '';
-	}
-
     /**
      * Get current order
      *
diff --git a/Block/Survey.php b/Block/Survey.php
index d68cc3b..67020e9 100644
--- a/Block/Survey.php
+++ b/Block/Survey.php
@@ -70,7 +70,7 @@ class Survey extends Template
 	 */
 	public function isEnableSurvey()
 	{
-		return $this->_helperData->getConfig()->isEnabled() && !$this->_helperData->getConfig()->isDisableSurvey();
+		return $this->_helperData->getConfig()->isDisableSurvey();
 	}
 
 	public function getLastOrderId(){
diff --git a/CHANGELOG b/CHANGELOG
deleted file mode 100644
index f901905..0000000
--- a/CHANGELOG
+++ /dev/null
@@ -1 +0,0 @@
-CHANGELOG: https://www.mageplaza.com/changelog/m2-one-step-checkout.txt
\ No newline at end of file
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index 46f63ce..f3ede5e 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -31,13 +31,13 @@ class Index extends \Magento\Checkout\Controller\Cart\Add
      */
     public function execute()
     {
-        $productId = $this->getRequest()->getParam('id') ? $this->getRequest()->getParam('id') : 11;
+		$productId = $this->getRequest()->getParam('id') ? $this->getRequest()->getParam('id') : 11;
         $storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
         $product = $this->productRepository->getById($productId, false, $storeId);
 
         $this->cart->addProduct($product, []);
         $this->cart->save();
-        return $this->goBack($this->_url->getUrl('onestepcheckout'));
 
+        return $this->goBack($this->_url->getUrl('onestepcheckout'));
     }
 }
diff --git a/Controller/Adminhtml/System/Config/Geoip.php b/Controller/Adminhtml/System/Config/Geoip.php
deleted file mode 100644
index b2ff11c..0000000
--- a/Controller/Adminhtml/System/Config/Geoip.php
+++ /dev/null
@@ -1,107 +0,0 @@
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
-
-namespace Mageplaza\Osc\Controller\Adminhtml\System\Config;
-
-use Magento\Backend\App\Action;
-use Magento\Backend\App\Action\Context;
-use Magento\Framework\Controller\Result\JsonFactory;
-use Magento\Framework\App\Filesystem\DirectoryList;
-use \Mageplaza\Osc\Helper\Config as OscConfig;
-
-class Geoip extends Action
-{
-
-	/**
-	 * @type \Magento\Framework\Controller\Result\JsonFactory
-	 */
-	protected $resultJsonFactory;
-
-	/**
-	 * @type \Magento\Framework\App\Filesystem\DirectoryList
-	 */
-	protected $_directoryList;
-
-	/**
-	 * @var OscConfig
-	 */
-	protected $_oscConfig;
-
-
-	/**
-	 * @param Context $context
-	 * @param JsonFactory $resultJsonFactory
-	 * @param DirectoryList $directoryList
-	 * @param OscConfig $config
-	 */
-	public function __construct(
-		Context $context,
-		JsonFactory $resultJsonFactory,
-		DirectoryList $directoryList,
-		OscConfig $config
-	)
-	{
-		$this->resultJsonFactory = $resultJsonFactory;
-		$this->_directoryList = $directoryList;
-		$this->_oscConfig	=	$config;
-		parent::__construct($context);
-	}
-
-
-	public function execute()
-	{
-		$status=false;
-		try {
-			$path = $this->_directoryList->getPath('var').'/Mageplaza/Osc/GeoIp';
-			if (!file_exists($path)) {
-				mkdir($path, 0777, true);
-			}
-			$folder=scandir($path,true);
-			$pathFile= $path.'/'.$folder[0].'/GeoLite2-City.mmdb';
-
-			if(file_exists($pathFile)){
-				foreach(scandir($path.'/'.$folder[0],true) as $filename){
-					if($filename== '..'|| $filename== '.' ){
-						continue;
-					}
-					@unlink($path.'/'.$folder[0].'/'. $filename);
-				}
-				@rmdir($path.'/'.$folder[0]);
-			}
-
-			file_put_contents($path.'/GeoLite2-City.tar.gz', fopen($this->_oscConfig->getDownloadPath(), 'r'));
-			$phar = new \PharData($path.'/GeoLite2-City.tar.gz');
-			$phar->extractTo($path);
-			$status = true;
-			$message = __("Download library success!");
-		} catch (\Exception $e) {
-			echo $e->getMessage();
-			$message = __("Can't download file. Please try again!");
-		}
-
-		/** @var \Magento\Framework\Controller\Result\Json $result */
-		$result = $this->resultJsonFactory->create();
-		return $result->setData(['success' => $status, 'message' => $message]);
-	}
-}
-
-?>
\ No newline at end of file
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index 6a5d52b..56de2d9 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -72,25 +72,8 @@ class Index extends \Magento\Checkout\Controller\Onepage
 	{
 		$shippingAddress = $quote->getShippingAddress();
 		if (!$shippingAddress->getCountryId()) {
-			if(!empty($this->_checkoutHelper->getConfig()->getDefaultCountryId())){
-				$defaultCountryId = $this->_checkoutHelper->getConfig()->getDefaultCountryId();
-			}else{
-				/**
-				 * Get default country id from Geo Ip or Locale
-				 */
-				if($this->_checkoutHelper->checkHasLibrary()){
-					try {
-						$ip = $_SERVER['REMOTE_ADDR']!= '127.0.0.1' ? $_SERVER['REMOTE_ADDR'] : '123.16.189.71';
-						$data = $this->_checkoutHelper->getGeoIpData($this->_objectManager->get('Mageplaza\Osc\Model\Geoip\Database\Reader')->city($ip));
-						$defaultCountryId = $data['country_id'];
-					} catch (\Exception $e) {
-						$defaultCountryId = $this->getDefaultCountryFromLocale();
-					}
-				}else{
-					$defaultCountryId = $this->getDefaultCountryFromLocale();
-				}
-			}
-			$shippingAddress->setCountryId($defaultCountryId)->setCollectShippingRates(true);
+			$shippingAddress->setCountryId($this->_checkoutHelper->getConfig()->getDefaultCountryId())
+				->setCollectShippingRates(true);
 		}
 
 		$method = null;
@@ -134,13 +117,4 @@ class Index extends \Magento\Checkout\Controller\Onepage
 
 		return false;
 	}
-
-	/**
-	 * Get  default country id from locale
-	 * @return string
-	 */
-	public function getDefaultCountryFromLocale(){
-		$locale = $this->_objectManager->get('Magento\Framework\Locale\Resolver')->getLocale();
-		return substr($locale, strrpos($locale, "_") + 1);
-	}
 }
diff --git a/Helper/Config.php b/Helper/Config.php
index 0f85d2f..f21c4c8 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -30,6 +30,7 @@ use Magento\Framework\ObjectManagerInterface;
 use Magento\Store\Model\StoreManagerInterface;
 use Mageplaza\Core\Helper\AbstractData;
 use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
+use Magento\Framework\Module\Manager as ModuleManager;
 
 /**
  * Class Config
@@ -52,12 +53,6 @@ class Config extends AbstractData
 	/** Design configuration path */
 	const DESIGN_CONFIGUARATION = 'osc/design_configuration';
 
-	/** Geo configuration path */
-	const GEO_IP_CONFIGUARATION = 'osc/geoip_configuration';
-
-	/** Is enable Geo Ip path */
-	const GEO_IP_IS_ENABLED    = 'osc/geoip_configuration/is_enable_geoip';
-
 	/** @var \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory */
 	protected $_addressesFactory;
 
@@ -71,6 +66,11 @@ class Config extends AbstractData
 	private $attributeMetadataDataProvider;
 
 	/**
+	 * @type \Magento\Framework\Module\Manager
+	 */
+	protected $_moduleManager;
+
+	/**
 	 * Config constructor.
 	 * @param \Magento\Framework\App\Helper\Context $context
 	 * @param \Magento\Framework\ObjectManagerInterface $objectManager
@@ -79,6 +79,7 @@ class Config extends AbstractData
 	 * @param \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory $addressesFactory
 	 * @param \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory $customerFactory
 	 * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+	 * @param \Magento\Framework\Module\Manager $moduleManager
 	 */
 	public function __construct(
 		Context $context,
@@ -87,7 +88,8 @@ class Config extends AbstractData
 		Address $addressHelper,
 		AddressFactory $addressesFactory,
 		CustomerFactory $customerFactory,
-		AttributeMetadataDataProvider $attributeMetadataDataProvider
+		AttributeMetadataDataProvider $attributeMetadataDataProvider,
+		ModuleManager $moduleManager
 	)
 	{
 		parent::__construct($context, $objectManager, $storeManager);
@@ -96,6 +98,7 @@ class Config extends AbstractData
 		$this->_addressesFactory             = $addressesFactory;
 		$this->_customerFactory              = $customerFactory;
 		$this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
+		$this->_moduleManager                = $moduleManager;
 	}
 
 	/**
@@ -392,6 +395,17 @@ class Config extends AbstractData
 	}
 
 	/**
+	 * Show billing address before shipping address
+	 *
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isShowBillingAddressBeforeShippingAddress($store = null)
+	{
+		return $this->getGeneralConfig('show_billing_before_shipping', $store) && $this->getShowBillingAddress();
+	}
+
+	/**
 	 * Google api key
 	 *
 	 * @param null $store
@@ -548,17 +562,6 @@ class Config extends AbstractData
 	}
 
 	/**
-	 * Gift message items
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isEnableGiftMessageItems($store = null)
-	{
-		return (bool)$this->getDisplayConfig('is_enabled_gift_message_items', $store);
-	}
-
-
-	/**
 	 * Gift wrap block will be hided if this function return 'true'
 	 *
 	 * @param null $store
@@ -659,16 +662,6 @@ class Config extends AbstractData
 	}
 
 	/**
-	 * House Security Code
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isDisabledHouseSecurityCode($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_house_security_code', $store);
-	}
-
-	/**
 	 * Delivery Time Format
 	 *
 	 * @param null $store
@@ -697,7 +690,8 @@ class Config extends AbstractData
 	 * @param null $store
 	 * @return bool
 	 */
-	public function isDisableSurvey($store = null){
+	public function isDisableSurvey($store = null)
+	{
 		return !$this->getDisplayConfig('is_enabled_survey', $store);
 	}
 
@@ -706,7 +700,8 @@ class Config extends AbstractData
 	 * @param null $store
 	 * @return mixed
 	 */
-	public function getSurveyQuestion($store = null){
+	public function getSurveyQuestion($store = null)
+	{
 		return $this->getDisplayConfig('survey_question', $store);
 	}
 
@@ -715,8 +710,9 @@ class Config extends AbstractData
 	 * @param null $stores
 	 * @return mixed
 	 */
-	public function getSurveyAnswers($stores = null){
-		return unserialize($this->getDisplayConfig('survey_answers',$stores));
+	public function getSurveyAnswers($stores = null)
+	{
+		return unserialize($this->getDisplayConfig('survey_answers', $stores));
 	}
 
 	/**
@@ -724,8 +720,9 @@ class Config extends AbstractData
 	 * @param null $stores
 	 * @return mixed
 	 */
-	public function isAllowCustomerAddOtherOption($stores = null){
-		return $this->getDisplayConfig('allow_customer_add_other_option',$stores);
+	public function isAllowCustomerAddOtherOption($stores = null)
+	{
+		return $this->getDisplayConfig('allow_customer_add_other_option', $stores);
 	}
 
 	/**
@@ -751,30 +748,7 @@ class Config extends AbstractData
 		return $this->getConfigValue($code, $store);
 	}
 
-	/**
-	 * @return bool
-	 */
-	public function isUsedMaterialDesign(){
-		return $this->getDesignConfig('page_design') == 'material' ? true : false;
-	}
 
-	/***************************** GeoIP Configuration *****************************
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function isEnableGeoIP($store = null)
-	{
-		return boolval($this->getConfigValue(self::GEO_IP_CONFIGUARATION.'/is_enable_geoip', $store));
-	}
-
-	/**
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getDownloadPath($store = null){
-		return $this->getConfigValue(self::GEO_IP_CONFIGUARATION.'/download_path',$store);
-	}
 	/***************************** Compatible Modules *****************************
 	 *
 	 * @return bool
@@ -783,20 +757,4 @@ class Config extends AbstractData
 	{
 		return $this->_moduleManager->isOutputEnabled('MultiSafepay_Connect');
 	}
-
-	/**
-	 * @return bool
-	 */
-	public function isEnableModulePostNL()
-	{
-		return $this->isModuleOutputEnabled('TIG_PostNL');
-	}
-
-	/**
-	 * Get current theme id
-	 * @return mixed
-	 */
-	public function getCurrentThemeId(){
-		return $this->getConfigValue(\Magento\Framework\View\DesignInterface::XML_PATH_THEME_ID);
-	}
 }
diff --git a/Helper/Data.php b/Helper/Data.php
index e12ec9f..e32ba78 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -27,9 +27,6 @@ use Magento\Framework\ObjectManagerInterface;
 use Magento\Framework\Pricing\PriceCurrencyInterface;
 use Magento\Store\Model\StoreManagerInterface;
 use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
-use Magento\Framework\App\Filesystem\DirectoryList;
-use Magento\Framework\Locale\Resolver;
-use Magento\Directory\Model\Region;
 
 /**
  * Class Data
@@ -53,30 +50,12 @@ class Data extends AbstractHelper
 	protected $_priceCurrency;
 
 	/**
-	 * @type \Magento\Framework\App\Filesystem\DirectoryList
-	 */
-	protected $_directoryList;
-
-	/**
-	 * @type \Magento\Framework\Locale\Resolver
-	 */
-	protected $_resolver;
-
-	/**
-	 * @type \Magento\Directory\Model\Region
-	 */
-	protected $_region;
-
-	/**
-	 * @param Context $context
-	 * @param HelperData $helperData
-	 * @param StoreManagerInterface $storeManager
-	 * @param Config $helperConfig
-	 * @param ObjectManagerInterface $objectManager
-	 * @param PriceCurrencyInterface $priceCurrency
-	 * @param DirectoryList $directoryList
-	 * @param Resolver $resolver
-	 * @param Region $region
+	 * @param \Magento\Framework\App\Helper\Context $context
+	 * @param \Magento\Checkout\Helper\Data $helperData
+	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+	 * @param \Mageplaza\Osc\Helper\Config $helperConfig
+	 * @param \Magento\Framework\ObjectManagerInterface $objectManager
+	 * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
 	 */
 	public function __construct(
 		Context $context,
@@ -84,19 +63,12 @@ class Data extends AbstractHelper
 		StoreManagerInterface $storeManager,
 		Config $helperConfig,
 		ObjectManagerInterface $objectManager,
-		PriceCurrencyInterface $priceCurrency,
-		DirectoryList $directoryList,
-		Resolver $resolver,
-		Region $region
+		PriceCurrencyInterface $priceCurrency
 	)
 	{
 		$this->_helperData   = $helperData;
 		$this->_helperConfig = $helperConfig;
 		$this->_priceCurrency   = $priceCurrency;
-		$this->_directoryList = $directoryList;
-		$this->_resolver      = $resolver;
-		$this->_region        = $region;
-
 
 		parent::__construct($context, $objectManager, $storeManager);
 	}
@@ -153,85 +125,4 @@ class Data extends AbstractHelper
 
 		return $this->convertPrice($baseOscGiftWrapAmount, $quote->getStore());
 	}
-
-	/**
-	 * Check has library at path var/Mageplaza/Osc/GeoIp/
-	 * @return bool|string
-	 */
-	public function checkHasLibrary()
-	{
-		$path = $this->_directoryList->getPath('var') . '/Mageplaza/Osc/GeoIp';
-		if (!file_exists($path)) return false;
-		$folder   = scandir($path, true);
-		$pathFile = $path . '/' . $folder[0] . '/GeoLite2-City.mmdb';
-		if (!file_exists($pathFile)) return false;
-
-		return $pathFile;
-	}
-
-	/**
-	 * @param $data
-	 * @return mixed
-	 */
-	public function getGeoIpData($data)
-	{
-		$geoIpData['city']       = $this->filterData($data, 'city', 'names');
-		$geoIpData['country_id'] = $this->filterData($data, 'country', 'iso_code', false);
-		if (!empty($this->getRegionId($data, $geoIpData['country_id']))) {
-			$geoIpData['region_id'] = $this->getRegionId($data, $geoIpData['country_id']);
-		} else {
-			$geoIpData['region'] = $this->filterData($data, 'subdivisions', 'names');
-		}
-		if (isset($data['postal'])) {
-			$geoIpData['postcode'] = $this->filterData($data, 'postal', 'code', false);
-		}
-
-		return $geoIpData;
-	}
-
-	/**
-	 * Filter GeoIP data
-	 * @param $data
-	 * @param $field
-	 * @param $child
-	 * @param bool|true $convert
-	 * @return string
-	 */
-	public function filterData($data, $field, $child, $convert = true)
-	{
-		$output = '';
-		if (isset($data[$field]) && is_array($data[$field])) {
-			if ($field == 'subdivisions') {
-				foreach ($data[$field][0] as $key => $value) {
-					$data[$field][$key] = $value;
-				}
-			}
-			if (isset($data[$field][$child])) {
-				if ($convert) {
-					if (is_array($data[$field][$child])) {
-						$locale   = $this->_resolver->getLocale();
-						$language = substr($locale, 0, 2) ? substr($locale, 0, 2) : 'en';
-						$output   = isset($data[$field][$child][$language]) ? $data[$field][$child][$language] : '';
-					}
-				} else {
-					$output = $data[$field][$child];
-				}
-			}
-		}
-
-		return $output;
-	}
-
-	/**
-	 * Find region id by Country
-	 * @param $data
-	 * @param $country
-	 * @return mixed
-	 */
-	public function getRegionId($data, $country)
-	{
-		$regionId = $this->_region->loadByCode($this->filterData($data, 'subdivisions', 'iso_code', false), $country)->getId();
-
-		return $regionId;
-	}
 }
diff --git a/LICENSE b/LICENSE
deleted file mode 100644
index f9c459c..0000000
--- a/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-LICENSE: https://www.mageplaza.com/LICENSE.txt
\ No newline at end of file
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index c054f2c..333ac80 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -18,7 +18,6 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model;
 
 use Magento\Checkout\Model\ConfigProviderInterface;
@@ -29,8 +28,6 @@ use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Mageplaza\Osc\Helper\Config as OscConfig;
 use Magento\Framework\Module\Manager as ModuleManager;
-use Mageplaza\Osc\Helper\Data as HelperData;
-use Mageplaza\Osc\Model\Geoip\Database\Reader;
 
 /**
  * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
@@ -70,16 +67,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	protected $moduleManager;
 
 	/**
-	 * @type \Mageplaza\Osc\Helper\Data
-	 */
-	protected $_helperData;
-
-	/**
-	 * @type \Mageplaza\Osc\Model\Geoip\Database\Reader
-	 */
-	protected $_geoIpData;
-
-	/**
 	 * DefaultConfigProvider constructor.
 	 * @param CheckoutSession $checkoutSession
 	 * @param PaymentMethodManagementInterface $paymentMethodManagement
@@ -87,8 +74,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	 * @param OscConfig $oscConfig
 	 * @param CompositeConfigProvider $configProvider
 	 * @param ModuleManager $moduleManager
-	 * @param HelperData $helperData
-	 * @param Reader $geoIpData
 	 */
 	public function __construct(
 		CheckoutSession $checkoutSession,
@@ -96,9 +81,7 @@ class DefaultConfigProvider implements ConfigProviderInterface
 		ShippingMethodManagementInterface $shippingMethodManagement,
 		OscConfig $oscConfig,
 		CompositeConfigProvider $configProvider,
-		ModuleManager $moduleManager,
-		HelperData $helperData,
-		Reader $geoIpData
+		ModuleManager $moduleManager
 	)
 	{
 		$this->checkoutSession           = $checkoutSession;
@@ -107,8 +90,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
 		$this->oscConfig                 = $oscConfig;
 		$this->giftMessageConfigProvider = $configProvider;
 		$this->moduleManager             = $moduleManager;
-		$this->_helperData               = $helperData;
-		$this->_geoIpData                = $geoIpData;
 	}
 
 	/**
@@ -122,7 +103,7 @@ class DefaultConfigProvider implements ConfigProviderInterface
 
 		$output = [
 			'shippingMethods'       => $this->getShippingMethods(),
-			'selectedShippingRate'  => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod()) ? $existShippingMethod : $this->oscConfig->getDefaultShippingMethod(),
+			'selectedShippingRate'  => $this->oscConfig->getDefaultShippingMethod(),
 			'paymentMethods'        => $this->getPaymentMethods(),
 			'selectedPaymentMethod' => $this->oscConfig->getDefaultPaymentMethod(),
 			'oscConfig'             => $this->getOscConfig()
@@ -137,33 +118,25 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	private function getOscConfig()
 	{
 		return [
-			'addressFields'        => $this->getAddressFields(),
-			'autocomplete'         => [
+			'addressFields'             => $this->getAddressFields(),
+			'autocomplete'              => [
 				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
 				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
 			],
-			'register'             => [
+			'register'                  => [
 				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
 				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
 			],
-			'allowGuestCheckout'   => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
-			'showBillingAddress'   => $this->oscConfig->getShowBillingAddress(),
-			'newsletterDefault'    => $this->oscConfig->isSubscribedByDefault(),
-			'isUsedGiftWrap'       => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
-			'giftMessageOptions'   => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), ['isEnableOscGiftMessageItems' => $this->oscConfig->isEnableGiftMessageItems()]),
-			'isDisplaySocialLogin' => $this->isDisplaySocialLogin(),
-			'deliveryTimeOptions'  => [
+			'allowGuestCheckout'        => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
+			'showBillingAddress'        => $this->oscConfig->getShowBillingAddress(),
+			'showBillingBeforeShipping' => $this->oscConfig->isShowBillingAddressBeforeShippingAddress(),
+			'newsletterDefault'         => $this->oscConfig->isSubscribedByDefault(),
+			'isUsedGiftWrap'            => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
+			'giftMessageOptions'        => $this->giftMessageConfigProvider->getConfig(),
+			'isDisplaySocialLogin'      => $this->isDisplaySocialLogin(),
+			'deliveryTimeOptions'       => [
 				'deliveryTimeFormat' => $this->oscConfig->getDeliveryTimeFormat(),
-				'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff(),
-				'houseSecurityCode'  => $this->oscConfig->isDisabledHouseSecurityCode()
-			],
-			'isUsedMaterialDesign' => $this->oscConfig->isUsedMaterialDesign(),
-			'geoIpOptions'         => [
-				'isEnableGeoIp' => $this->oscConfig->isEnableGeoIP(),
-				'geoIpData'     => $this->getGeoIpData()
-			],
-			'compatible'           => [
-				'isEnableModulePostNL' => $this->oscConfig->isEnableModulePostNL(),
+				'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff()
 			]
 		];
 	}
@@ -186,22 +159,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
 	}
 
 	/**
-	 * @return mixed
-	 */
-	public function getGeoIpData()
-	{
-		if ($this->oscConfig->isEnableGeoIP() && $this->_helperData->checkHasLibrary()) {
-			$ip = $_SERVER['REMOTE_ADDR'];
-			if (!filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE) || $ip == '127.0.0.1') {
-				$ip = '123.16.189.71';
-			}
-			$data = $this->_geoIpData->city($ip);
-
-			return $this->_helperData->getGeoIpData($data);
-		}
-	}
-
-	/**
 	 * Returns array of payment methods
 	 * @return array
 	 */
diff --git a/Model/Geoip/Database/Reader.php b/Model/Geoip/Database/Reader.php
deleted file mode 100644
index f00b468..0000000
--- a/Model/Geoip/Database/Reader.php
+++ /dev/null
@@ -1,148 +0,0 @@
-<?php
-namespace Mageplaza\Osc\Model\Geoip\Database;
-use Mageplaza\Osc\Model\Geoip\ProviderInterface;
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader as DbReader;
-
-/**
- * Instances of this class provide a reader for the GeoIP2 database format.
- * IP addresses can be looked up using the database specific methods.
- *
- * ## Usage ##
- *
- * The basic API for this class is the same for every database. First, you
- * create a reader object, specifying a file name. You then call the method
- * corresponding to the specific database, passing it the IP address you want
- * to look up.
- *
- * If the request succeeds, the method call will return a model class for
- * the method you called. This model in turn contains multiple record classes,
- * each of which represents part of the data returned by the database. If
- * the database does not contain the requested information, the attributes
- * on the record class will have a `null` value.
- *
- * If the address is not in the database, an
- * {@link \GeoIp2\Exception\AddressNotFoundException} exception will be
- * thrown. If an invalid IP address is passed to one of the methods, a
- * SPL {@link \InvalidArgumentException} will be thrown. If the database is
- * corrupt or invalid, a {@link \MaxMind\Db\Reader\InvalidDatabaseException}
- * will be thrown.
- *
- */
-class Reader implements ProviderInterface
-{
-    /**
-     * @type \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader
-     */
-    private $_dbReader;
-
-    /**
-     * @type array
-     */
-    private $locales;
-
-
-    /**
-     * @param \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader $dbreader
-     */
-    public function __construct(
-        DbReader $dbreader
-    ) {
-        $this->_dbReader = $dbreader;
-        $this->locales = array('en');
-    }
-
-    /**
-     * This method returns a GeoIP2 City model.
-     * @param string $ipAddress IPv4 or IPv6 address as a string.
-     * @return array
-     */
-    public function city($ipAddress)
-    {
-        return $this->modelFor('City', 'City', $ipAddress);
-    }
-
-    /**
-     * This method returns a GeoIP2 Country model.
-     * @param string $ipAddress IPv4 or IPv6 address as a string.
-     * @return array
-     */
-    public function country($ipAddress)
-    {
-        return $this->modelFor('Country', 'Country', $ipAddress);
-    }
-
-
-    /**
-     * @param $class
-     * @param $type
-     * @param $ipAddress
-     * @return array
-     * @throws \Mageplaza\Osc\Model\Geoip\Database\AddressNotFoundException
-     * @throws \Mageplaza\Osc\Model\Geoip\Database\InvalidDatabaseException
-     */
-    private function modelFor($class, $type, $ipAddress)
-    {
-        $record = $this->getRecord($class, $type, $ipAddress);
-
-        $record['traits']['ip_address'] = $ipAddress;
-        $this->close();
-        return $record;
-    }
-
-    /**
-     * @param $class
-     * @param $type
-     * @param $ipAddress
-     * @return array
-     * @throws \Mageplaza\Osc\Model\Geoip\Database\AddressNotFoundException
-     * @throws \Mageplaza\Osc\Model\Geoip\Database\InvalidDatabaseException
-     */
-    private function getRecord($class, $type, $ipAddress)
-    {
-        if (strpos($this->metadata()->databaseType, $type) === false) {
-            $method = lcfirst($class);
-            throw new \BadMethodCallException(
-                "The $method method cannot be used to open a "
-                . $this->metadata()->databaseType . " database"
-            );
-        }
-        $record = $this->_dbReader->get($ipAddress);
-        if ($record === null) {
-            throw new AddressNotFoundException(
-                "The address $ipAddress is not in the database."
-            );
-        }
-        if (!is_array($record)) {
-            // This can happen on corrupt databases. Generally,
-            // MaxMind\Db\Reader will throw a
-            // MaxMind\Db\Reader\InvalidDatabaseException, but occasionally
-            // the lookup may result in a record that looks valid but is not
-            // an array. This mostly happens when the user is ignoring all
-            // exceptions and the more frequent InvalidDatabaseException
-            // exceptions go unnoticed.
-            throw new InvalidDatabaseException(
-                "Expected an array when looking up $ipAddress but received: "
-                . gettype($record)
-            );
-        }
-        return $record;
-    }
-
-    /**
-     * @throws \InvalidArgumentException if arguments are passed to the method.
-     * @throws \BadMethodCallException if the database has been closed.
-     * @return Metadata object for the database.
-     */
-    public function metadata()
-    {
-        return $this->_dbReader->metadata();
-    }
-
-    /**
-     * Closes the GeoIP2 database and returns the resources to the system.
-     */
-    public function close()
-    {
-        $this->_dbReader->close();
-    }
-}
diff --git a/Model/Geoip/Maxmind/Db/Reader.php b/Model/Geoip/Maxmind/Db/Reader.php
deleted file mode 100644
index f22361c..0000000
--- a/Model/Geoip/Maxmind/Db/Reader.php
+++ /dev/null
@@ -1,369 +0,0 @@
-<?php
-
-namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db;
-
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Decoder;
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException;
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Metadata;
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util;
-
-/**
- * Instances of this class provide a reader for the MaxMind DB format. IP
- * addresses can be looked up using the <code>get</code> method.
- */
-class Reader
-{
-
-	private static $DATA_SECTION_SEPARATOR_SIZE = 16;
-	private static $METADATA_START_MARKER = "\xAB\xCD\xEFMaxMind.com";
-	private static $METADATA_START_MARKER_LENGTH = 14;
-	private static $METADATA_MAX_SIZE = 131072; // 128 * 1024 = 128KB
-
-	/**
-	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Decoder
-	 */
-	private $decoder;
-
-	/**
-	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
-	 */
-	private $invalidDatabaseException;
-
-	/**
-	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Util
-	 */
-	private $util;
-
-	/**
-	 * @type
-	 */
-	private $fileHandle;
-
-	/**
-	 * @type
-	 */
-	private $fileSize;
-
-	/**
-	 * @type
-	 */
-	private $ipV4Start;
-
-	/**
-	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Metadata
-	 */
-	private $metadata;
-
-	/**
-	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Decoder $decoder
-	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException $invalidDatabaseException
-	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Metadata $metadata
-	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Util $util
-	 */
-	public function __construct(
-		Decoder $decoder,
-		InvalidDatabaseException $invalidDatabaseException,
-		Metadata $metadata,
-		Util $util
-	)
-	{
-		$this->decoder                  = $decoder;
-		$this->invalidDatabaseException = $invalidDatabaseException;
-		$this->metadata                 = $metadata;
-		$this->util                     = $util;
-		$this->initReader();
-	}
-
-	public function initReader()
-	{
-		$objectManager = \Magento\Framework\App\ObjectManager::getInstance();
-		$database =  $objectManager->create('Mageplaza\Osc\Helper\Data')->checkHasLibrary();
-		if(!$database){
-			return $this;
-		}
-
-		if (!is_readable($database)) {
-			throw new \InvalidArgumentException(
-				"The file \"$database\" does not exist or is not readable."
-			);
-		}
-		$this->fileHandle = @fopen($database, 'rb');
-		if ($this->fileHandle === false) {
-			throw new \InvalidArgumentException(
-				"Error opening \"$database\"."
-			);
-		}
-		$this->fileSize = @filesize($database);
-		if ($this->fileSize === false) {
-			throw new \UnexpectedValueException(
-				"Error determining the size of \"$database\"."
-			);
-		}
-
-		$start           = $this->findMetadataStart($database);
-		$metadataDecoder = $this->decoder->init($this->fileHandle, $start);
-		// // $metadataDecoder = new Decoder($this->fileHandle, $start);
-		list($metadataArray) = $metadataDecoder->decode($start);
-		$this->metadata = $this->metadata->init($metadataArray);
-		$this->decoder  = $this->decoder->init(
-			$this->fileHandle,
-			$this->metadata->searchTreeSize + self::$DATA_SECTION_SEPARATOR_SIZE
-		);
-	}
-
-	/**
-	 * Looks up the <code>address</code> in the MaxMind DB.
-	 *
-	 * @param string $ipAddress
-	 *            the IP address to look up.
-	 * @return array the record for the IP address.
-	 * @throws \BadMethodCallException if this method is called on a closed database.
-	 * @throws \InvalidArgumentException if something other than a single IP address is passed to the method.
-	 * @throws InvalidDatabaseException
-	 *             if the database is invalid or there is an error reading
-	 *             from it.
-	 */
-	public function get($ipAddress)
-	{
-		if (func_num_args() != 1) {
-			throw new \InvalidArgumentException(
-				'Method takes exactly one argument.'
-			);
-		}
-
-		if (!is_resource($this->fileHandle)) {
-			throw new \BadMethodCallException(
-				'Attempt to read from a closed MaxMind DB.'
-			);
-		}
-
-		if (!filter_var($ipAddress, FILTER_VALIDATE_IP)) {
-			throw new \InvalidArgumentException(
-				"The value \"$ipAddress\" is not a valid IP address."
-			);
-		}
-
-		if ($this->metadata->ipVersion == 4 && strrpos($ipAddress, ':')) {
-			throw new \InvalidArgumentException(
-				"Error looking up $ipAddress. You attempted to look up an"
-				. " IPv6 address in an IPv4-only database."
-			);
-		}
-		$pointer = $this->findAddressInTree($ipAddress);
-		if ($pointer == 0) {
-			return null;
-		}
-
-		return $this->resolveDataPointer($pointer);
-	}
-
-	/**
-	 * @param $ipAddress
-	 * @return int
-	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
-	 */
-	private function findAddressInTree($ipAddress)
-	{
-		// XXX - could simplify. Done as a byte array to ease porting
-		$rawAddress = array_merge(unpack('C*', inet_pton($ipAddress)));
-
-		$bitCount = count($rawAddress) * 8;
-
-		// The first node of the tree is always node 0, at the beginning of the
-		// value
-		$node = $this->startNode($bitCount);
-
-		for ($i = 0; $i < $bitCount; $i++) {
-			if ($node >= $this->metadata->nodeCount) {
-				break;
-			}
-			$tempBit = 0xFF & $rawAddress[$i >> 3];
-			$bit     = 1 & ($tempBit >> 7 - ($i % 8));
-
-			$node = $this->readNode($node, $bit);
-		}
-		if ($node == $this->metadata->nodeCount) {
-			// Record is empty
-			return 0;
-		} elseif ($node > $this->metadata->nodeCount) {
-			// Record is a data pointer
-			return $node;
-		}
-		throw new InvalidDatabaseException("Something bad happened");
-	}
-
-	/**
-	 * @param $length
-	 * @return int
-	 */
-	private function startNode($length)
-	{
-		// Check if we are looking up an IPv4 address in an IPv6 tree. If this
-		// is the case, we can skip over the first 96 nodes.
-		if ($this->metadata->ipVersion == 6 && $length == 32) {
-			return $this->ipV4StartNode();
-		}
-		// The first node of the tree is always node 0, at the beginning of the
-		// value
-		return 0;
-	}
-
-	/**
-	 * @return int
-	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
-	 */
-	private function ipV4StartNode()
-	{
-		//This is a defensive check. There is no reason to call this when you
-		//have an IPv4 tree.
-		if ($this->metadata->ipVersion == 4) {
-			return 0;
-		}
-
-		if ($this->ipV4Start != 0) {
-			return $this->ipV4Start;
-		}
-		$node = 0;
-
-		for ($i = 0; $i < 96 && $node < $this->metadata->nodeCount; $i++) {
-			$node = $this->readNode($node, 0);
-		}
-		$this->ipV4Start = $node;
-
-		return $node;
-	}
-
-	/**
-	 * @param $nodeNumber
-	 * @param $index
-	 * @return mixed
-	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
-	 */
-	private function readNode($nodeNumber, $index)
-	{
-		$baseOffset = $nodeNumber * $this->metadata->nodeByteSize;
-
-		// XXX - probably could condense this.
-		switch ($this->metadata->recordSize) {
-			case 24:
-				$bytes = Util::read($this->fileHandle, $baseOffset + $index * 3, 3);
-				list(, $node) = unpack('N', "\x00" . $bytes);
-
-				return $node;
-			case 28:
-				$middleByte = Util::read($this->fileHandle, $baseOffset + 3, 1);
-				list(, $middle) = unpack('C', $middleByte);
-				if ($index == 0) {
-					$middle = (0xF0 & $middle) >> 4;
-				} else {
-					$middle = 0x0F & $middle;
-				}
-				$bytes = Util::read($this->fileHandle, $baseOffset + $index * 4, 3);
-				list(, $node) = unpack('N', chr($middle) . $bytes);
-
-				return $node;
-			case 32:
-				$bytes = Util::read($this->fileHandle, $baseOffset + $index * 4, 4);
-				list(, $node) = unpack('N', $bytes);
-
-				return $node;
-			default:
-				throw new InvalidDatabaseException(
-					'Unknown record size: '
-					. $this->metadata->recordSize
-				);
-		}
-	}
-
-	/**
-	 * @param $pointer
-	 * @return mixed
-	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
-	 */
-	private function resolveDataPointer($pointer)
-	{
-		$resolved = $pointer - $this->metadata->nodeCount
-			+ $this->metadata->searchTreeSize;
-		if ($resolved > $this->fileSize) {
-			throw new InvalidDatabaseException(
-				"The MaxMind DB file's search tree is corrupt"
-			);
-		}
-
-		list($data) = $this->decoder->decode($resolved);
-
-		return $data;
-	}
-
-	/*
-	 * This is an extremely naive but reasonably readable implementation. There
-	 * are much faster algorithms (e.g., Boyer-Moore) for this if speed is ever
-	 * an issue, but I suspect it won't be.
-	 */
-	private function findMetadataStart($filename)
-	{
-		$handle       = $this->fileHandle;
-		$fstat        = fstat($handle);
-		$fileSize     = $fstat['size'];
-		$marker       = self::$METADATA_START_MARKER;
-		$markerLength = self::$METADATA_START_MARKER_LENGTH;
-		$metadataMaxLengthExcludingMarker
-			= min(self::$METADATA_MAX_SIZE, $fileSize) - $markerLength;
-
-		for ($i = 0; $i <= $metadataMaxLengthExcludingMarker; $i++) {
-			for ($j = 0; $j < $markerLength; $j++) {
-				fseek($handle, $fileSize - $i - $j - 1);
-				$matchBit = fgetc($handle);
-				if ($matchBit != $marker[$markerLength - $j - 1]) {
-					continue 2;
-				}
-			}
-
-			return $fileSize - $i;
-		}
-		throw new InvalidDatabaseException(
-			"Error opening database file ($filename). " .
-			'Is this a valid MaxMind DB file?'
-		);
-	}
-
-	/**
-	 * @throws \InvalidArgumentException if arguments are passed to the method.
-	 * @throws \BadMethodCallException if the database has been closed.
-	 * @return Metadata object for the database.
-	 */
-	public function metadata()
-	{
-		if (func_num_args()) {
-			throw new \InvalidArgumentException(
-				'Method takes no arguments.'
-			);
-		}
-
-		// Not technically required, but this makes it consistent with
-		// C extension and it allows us to change our implementation later.
-		if (!is_resource($this->fileHandle)) {
-			throw new \BadMethodCallException(
-				'Attempt to read from a closed MaxMind DB.'
-			);
-		}
-
-		return $this->metadata;
-	}
-
-	/**
-	 * Closes the MaxMind DB and returns resources to the system.
-	 *
-	 * @throws \Exception
-	 *             if an I/O error occurs.
-	 */
-	public function close()
-	{
-		if (!is_resource($this->fileHandle)) {
-			throw new \BadMethodCallException(
-				'Attempt to close a closed MaxMind DB.'
-			);
-		}
-		fclose($this->fileHandle);
-	}
-}
diff --git a/Model/Geoip/Maxmind/Db/Reader/Decoder.php b/Model/Geoip/Maxmind/Db/Reader/Decoder.php
deleted file mode 100644
index b304c07..0000000
--- a/Model/Geoip/Maxmind/Db/Reader/Decoder.php
+++ /dev/null
@@ -1,422 +0,0 @@
-<?php
-
-namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
-
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException;
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util;
-
-class Decoder
-{
-
-    /**
-     * @type
-     */
-    private $fileStream;
-
-    /**
-     * @type
-     */
-    private $pointerBase;
-
-    /**
-     * @var \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException
-     */
-    private $invalidDatabaseException;
-
-    /**
-     * @var \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util
-     */
-    private $util;
-
-    // This is only used for unit testing
-    private $pointerTestHack;
-
-    /**
-     * @type
-     */
-    private $switchByteOrder;
-
-    /**
-     * @type array
-     */
-    private $types = array(
-        0 => 'extended',
-        1 => 'pointer',
-        2 => 'utf8_string',
-        3 => 'double',
-        4 => 'bytes',
-        5 => 'uint16',
-        6 => 'uint32',
-        7 => 'map',
-        8 => 'int32',
-        9 => 'uint64',
-        10 => 'uint128',
-        11 => 'array',
-        12 => 'container',
-        13 => 'end_marker',
-        14 => 'boolean',
-        15 => 'float',
-    );
-
-    /**
-     * @param \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException $invalidDatabaseException
-     * @param \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util $until
-     */
-    public function __construct(
-        InvalidDatabaseException $invalidDatabaseException,
-        Util $until
-    ){
-        $this->invalidDatabaseException =$invalidDatabaseException;
-        $this->util=$until;
-    }
-
-    /**
-     * @param $fileStream
-     * @param int $pointerBase
-     * @param bool|false $pointerTestHack
-     * @return $this
-     */
-    public function init($fileStream,$pointerBase=0,$pointerTestHack=false){
-        $this->fileStream = $fileStream;
-        $this->pointerBase = $pointerBase;
-        $this->pointerTestHack = $pointerTestHack;
-        $this->switchByteOrder = $this->isPlatformLittleEndian();
-        return $this;
-    }
-
-    /**
-     * @param $offset
-     * @return array
-     */
-    public function decode($offset)
-    {
-        list(, $ctrlByte) = unpack(
-            'C',
-            Util::read($this->fileStream, $offset, 1)
-        );
-        $offset++;
-
-        $type = $this->types[$ctrlByte >> 5];
-
-        // Pointers are a special case, we don't read the next $size bytes, we
-        // use the size to determine the length of the pointer and then follow
-        // it.
-        if ($type == 'pointer') {
-            list($pointer, $offset) = $this->decodePointer($ctrlByte, $offset);
-
-            // for unit testing
-            if ($this->pointerTestHack) {
-                return array($pointer);
-            }
-
-            list($result) = $this->decode($pointer);
-
-            return array($result, $offset);
-        }
-
-        if ($type == 'extended') {
-            list(, $nextByte) = unpack(
-                'C',
-                Util::read($this->fileStream, $offset, 1)
-            );
-
-            $typeNum = $nextByte + 7;
-
-            if ($typeNum < 8) {
-                throw new InvalidDatabaseException(
-                    "Something went horribly wrong in the decoder. An extended type "
-                    . "resolved to a type number < 8 ("
-                    . $this->types[$typeNum]
-                    . ")"
-                );
-            }
-
-            $type = $this->types[$typeNum];
-            $offset++;
-        }
-
-        list($size, $offset) = $this->sizeFromCtrlByte($ctrlByte, $offset);
-
-        return $this->decodeByType($type, $offset, $size);
-    }
-
-    /**
-     * @param $type
-     * @param $offset
-     * @param $size
-     * @return array
-     */
-    private function decodeByType($type, $offset, $size)
-    {
-        switch ($type) {
-            case 'map':
-                return $this->decodeMap($size, $offset);
-            case 'array':
-                return $this->decodeArray($size, $offset);
-            case 'boolean':
-                return array($this->decodeBoolean($size), $offset);
-        }
-
-        $newOffset = $offset + $size;
-        $bytes = Util::read($this->fileStream, $offset, $size);
-        switch ($type) {
-            case 'utf8_string':
-                return array($this->decodeString($bytes), $newOffset);
-            case 'double':
-                $this->verifySize(8, $size);
-                return array($this->decodeDouble($bytes), $newOffset);
-            case 'float':
-                $this->verifySize(4, $size);
-                return array($this->decodeFloat($bytes), $newOffset);
-            case 'bytes':
-                return array($bytes, $newOffset);
-            case 'uint16':
-            case 'uint32':
-                return array($this->decodeUint($bytes), $newOffset);
-            case 'int32':
-                return array($this->decodeInt32($bytes), $newOffset);
-            case 'uint64':
-            case 'uint128':
-                return array($this->decodeBigUint($bytes, $size), $newOffset);
-            default:
-                throw new InvalidDatabaseException(
-                    "Unknown or unexpected type: " . $type
-                );
-        }
-    }
-
-    /**
-     * @param $expected
-     * @param $actual
-     */
-    private function verifySize($expected, $actual)
-    {
-        if ($expected != $actual) {
-            throw new InvalidDatabaseException(
-                "The MaxMind DB file's data section contains bad data (unknown data type or corrupt data)"
-            );
-        }
-    }
-
-    /**
-     * @param $size
-     * @param $offset
-     * @return array
-     */
-    private function decodeArray($size, $offset)
-    {
-        $array = array();
-
-        for ($i = 0; $i < $size; $i++) {
-            list($value, $offset) = $this->decode($offset);
-            array_push($array, $value);
-        }
-
-        return array($array, $offset);
-    }
-
-    /**
-     * @param $size
-     * @return bool
-     */
-    private function decodeBoolean($size)
-    {
-        return $size == 0 ? false : true;
-    }
-
-    /**
-     * @param $bits
-     * @return mixed
-     */
-    private function decodeDouble($bits)
-    {
-        // XXX - Assumes IEEE 754 double on platform
-        list(, $double) = unpack('d', $this->maybeSwitchByteOrder($bits));
-        return $double;
-    }
-
-    /**
-     * @param $bits
-     * @return mixed
-     */
-    private function decodeFloat($bits)
-    {
-        // XXX - Assumes IEEE 754 floats on platform
-        list(, $float) = unpack('f', $this->maybeSwitchByteOrder($bits));
-        return $float;
-    }
-
-    /**
-     * @param $bytes
-     * @return mixed
-     */
-    private function decodeInt32($bytes)
-    {
-        $bytes = $this->zeroPadLeft($bytes, 4);
-        list(, $int) = unpack('l', $this->maybeSwitchByteOrder($bytes));
-        return $int;
-    }
-
-    /**
-     * @param $size
-     * @param $offset
-     * @return array
-     */
-    private function decodeMap($size, $offset)
-    {
-
-        $map = array();
-
-        for ($i = 0; $i < $size; $i++) {
-            list($key, $offset) = $this->decode($offset);
-            list($value, $offset) = $this->decode($offset);
-            $map[$key] = $value;
-        }
-
-        return array($map, $offset);
-    }
-
-    private $pointerValueOffset = array(
-        1 => 0,
-        2 => 2048,
-        3 => 526336,
-        4 => 0,
-    );
-
-    /**
-     * @param $ctrlByte
-     * @param $offset
-     * @return array
-     */
-    private function decodePointer($ctrlByte, $offset)
-    {
-        $pointerSize = (($ctrlByte >> 3) & 0x3) + 1;
-
-        $buffer = Util::read($this->fileStream, $offset, $pointerSize);
-        $offset = $offset + $pointerSize;
-
-        $packed = $pointerSize == 4
-            ? $buffer
-            : (pack('C', $ctrlByte & 0x7)) . $buffer;
-
-        $unpacked = $this->decodeUint($packed);
-        $pointer = $unpacked + $this->pointerBase
-            + $this->pointerValueOffset[$pointerSize];
-
-        return array($pointer, $offset);
-    }
-
-    /**
-     * @param $bytes
-     * @return mixed
-     */
-    private function decodeUint($bytes)
-    {
-        list(, $int) = unpack('N', $this->zeroPadLeft($bytes, 4));
-        return $int;
-    }
-
-    /**
-     * @param $bytes
-     * @param $byteLength
-     * @return int|string
-     */
-    private function decodeBigUint($bytes, $byteLength)
-    {
-        $maxUintBytes = log(PHP_INT_MAX, 2) / 8;
-
-        if ($byteLength == 0) {
-            return 0;
-        }
-
-        $numberOfLongs = ceil($byteLength / 4);
-        $paddedLength = $numberOfLongs * 4;
-        $paddedBytes = $this->zeroPadLeft($bytes, $paddedLength);
-        $unpacked = array_merge(unpack("N$numberOfLongs", $paddedBytes));
-
-        $integer = 0;
-
-        // 2^32
-        $twoTo32 = '4294967296';
-
-        foreach ($unpacked as $part) {
-            // We only use gmp or bcmath if the final value is too big
-            if ($byteLength <= $maxUintBytes) {
-                $integer = ($integer << 32) + $part;
-            } elseif (extension_loaded('gmp')) {
-                $integer = gmp_strval(gmp_add(gmp_mul($integer, $twoTo32), $part));
-            } elseif (extension_loaded('bcmath')) {
-                $integer = bcadd(bcmul($integer, $twoTo32), $part);
-            } else {
-                throw new \RuntimeException(
-                    'The gmp or bcmath extension must be installed to read this database.'
-                );
-            }
-        }
-        return $integer;
-    }
-
-    /**
-     * @param $bytes
-     * @return mixed
-     */
-    private function decodeString($bytes)
-    {
-        // XXX - NOOP. As far as I know, the end user has to explicitly set the
-        // encoding in PHP. Strings are just bytes.
-        return $bytes;
-    }
-
-    /**
-     * @param $ctrlByte
-     * @param $offset
-     * @return array
-     */
-    private function sizeFromCtrlByte($ctrlByte, $offset)
-    {
-        $size = $ctrlByte & 0x1f;
-        $bytesToRead = $size < 29 ? 0 : $size - 28;
-        $bytes = Util::read($this->fileStream, $offset, $bytesToRead);
-        $decoded = $this->decodeUint($bytes);
-
-        if ($size == 29) {
-            $size = 29 + $decoded;
-        } elseif ($size == 30) {
-            $size = 285 + $decoded;
-        } elseif ($size > 30) {
-            $size = ($decoded & (0x0FFFFFFF >> (32 - (8 * $bytesToRead))))
-                + 65821;
-        }
-
-        return array($size, $offset + $bytesToRead);
-    }
-
-    /**
-     * @param $content
-     * @param $desiredLength
-     * @return string
-     */
-    private function zeroPadLeft($content, $desiredLength)
-    {
-        return str_pad($content, $desiredLength, "\x00", STR_PAD_LEFT);
-    }
-
-    /**
-     * @param $bytes
-     * @return string
-     */
-    private function maybeSwitchByteOrder($bytes)
-    {
-        return $this->switchByteOrder ? strrev($bytes) : $bytes;
-    }
-
-    /**
-     * @return bool
-     */
-    private function isPlatformLittleEndian()
-    {
-        $testint = 0x00FF;
-        $packed = pack('S', $testint);
-        return $testint === current(unpack('v', $packed));
-    }
-}
diff --git a/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php b/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
deleted file mode 100644
index 8dc671f..0000000
--- a/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
+++ /dev/null
@@ -1,9 +0,0 @@
-<?php
-
-namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
-/**
- * This class should be thrown when unexpected data is found in the database.
- */
-class InvalidDatabaseException extends \Exception
-{
-}
diff --git a/Model/Geoip/Maxmind/Db/Reader/Metadata.php b/Model/Geoip/Maxmind/Db/Reader/Metadata.php
deleted file mode 100644
index 3a7775b..0000000
--- a/Model/Geoip/Maxmind/Db/Reader/Metadata.php
+++ /dev/null
@@ -1,77 +0,0 @@
-<?php
-
-namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
-
-/**
- * This class provides the metadata for the MaxMind DB file.
- *
- * @property integer nodeCount This is an unsigned 32-bit integer indicating
- * the number of nodes in the search tree.
- *
- * @property integer recordSize This is an unsigned 16-bit integer. It
- * indicates the number of bits in a record in the search tree. Note that each
- * node consists of two records.
- *
- * @property integer ipVersion This is an unsigned 16-bit integer which is
- * always 4 or 6. It indicates whether the database contains IPv4 or IPv6
- * address data.
- *
- * @property string databaseType This is a string that indicates the structure
- * of each data record associated with an IP address. The actual definition of
- * these structures is left up to the database creator.
- *
- * @property array languages An array of strings, each of which is a language
- * code. A given record may contain data items that have been localized to
- * some or all of these languages. This may be undefined.
- *
- * @property integer binaryFormatMajorVersion This is an unsigned 16-bit
- * integer indicating the major version number for the database's binary
- * format.
- *
- * @property integer binaryFormatMinorVersion This is an unsigned 16-bit
- * integer indicating the minor version number for the database's binary format.
- *
- * @property integer buildEpoch This is an unsigned 64-bit integer that
- * contains the database build timestamp as a Unix epoch value.
- *
- * @property array description This key will always point to a map
- * (associative array). The keys of that map will be language codes, and the
- * values will be a description in that language as a UTF-8 string. May be
- * undefined for some databases.
- */
-class Metadata
-{
-    private $binaryFormatMajorVersion;
-    private $binaryFormatMinorVersion;
-    private $buildEpoch;
-    private $databaseType;
-    private $description;
-    private $ipVersion;
-    private $languages;
-    private $nodeByteSize;
-    private $nodeCount;
-    private $recordSize;
-    private $searchTreeSize;
-
-    public function init($metadata){
-        $this->binaryFormatMajorVersion =
-            $metadata['binary_format_major_version'];
-        $this->binaryFormatMinorVersion =
-            $metadata['binary_format_minor_version'];
-        $this->buildEpoch = $metadata['build_epoch'];
-        $this->databaseType = $metadata['database_type'];
-        $this->languages = $metadata['languages'];
-        $this->description = $metadata['description'];
-        $this->ipVersion = $metadata['ip_version'];
-        $this->nodeCount = $metadata['node_count'];
-        $this->recordSize = $metadata['record_size'];
-        $this->nodeByteSize = $this->recordSize / 4;
-        $this->searchTreeSize = $this->nodeCount * $this->nodeByteSize;
-        return $this;
-    }
-
-    public function __get($var)
-    {
-        return $this->$var;
-    }
-}
diff --git a/Model/Geoip/Maxmind/Db/Reader/Util.php b/Model/Geoip/Maxmind/Db/Reader/Util.php
deleted file mode 100644
index 0ecd474..0000000
--- a/Model/Geoip/Maxmind/Db/Reader/Util.php
+++ /dev/null
@@ -1,35 +0,0 @@
-<?php
-
-namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
-
-use  Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException;
-
-class Util
-{
-    /**
-     * @param $stream
-     * @param $offset
-     * @param $numberOfBytes
-     * @return string
-     * @throws \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException
-     */
-    public static function read($stream, $offset, $numberOfBytes)
-    {
-        if ($numberOfBytes == 0) {
-            return '';
-        }
-        if (fseek($stream, $offset) == 0) {
-            $value = fread($stream, $numberOfBytes);
-
-            // We check that the number of bytes read is equal to the number
-            // asked for. We use ftell as getting the length of $value is
-            // much slower.
-            if (ftell($stream) - $offset === $numberOfBytes) {
-                return $value;
-            }
-        }
-        throw new InvalidDatabaseException(
-            "The MaxMind DB file contains bad data"
-        );
-    }
-}
diff --git a/Model/Geoip/ProviderInterface.php b/Model/Geoip/ProviderInterface.php
deleted file mode 100644
index 40b7d0a..0000000
--- a/Model/Geoip/ProviderInterface.php
+++ /dev/null
@@ -1,20 +0,0 @@
-<?php
-
-namespace Mageplaza\Osc\Model\Geoip;
-
-interface ProviderInterface
-{
-	/**
-	 * @param ipAddress
-	 *            IPv4 or IPv6 address to lookup.
-	 * @return Country model for the requested IP address.
-	 */
-	public function country($ipAddress);
-
-	/**
-	 * @param ipAddress
-	 *            IPv4 or IPv6 address to lookup.
-	 * @return City model for the requested IP address.
-	 */
-	public function city($ipAddress);
-}
diff --git a/Model/System/Config/Source/CheckboxStyle.php b/Model/System/Config/Source/CheckboxStyle.php
deleted file mode 100644
index 938c663..0000000
--- a/Model/System/Config/Source/CheckboxStyle.php
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
-/**
- * Class Checkbox Style
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
-class CheckboxStyle
-{
-    const STYLE_DEFAULT = 'default';
-    const FILLED_IN     = 'filled_in';
-
-    /**
-     * @return array
-     */
-    public function toOptionArray()
-    {
-        $options = [
-            [
-                'label' => __('Default'),
-                'value' => self::STYLE_DEFAULT
-            ],
-            [
-                'label' => __('Filled In'),
-                'value' => self::FILLED_IN
-            ]
-        ];
-
-        return $options;
-    }
-}
diff --git a/Model/System/Config/Source/Design.php b/Model/System/Config/Source/Design.php
index 04d9e57..9973dfb 100644
--- a/Model/System/Config/Source/Design.php
+++ b/Model/System/Config/Source/Design.php
@@ -24,9 +24,9 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
  */
 class Design
 {
-    const DESIGN_DEFAULT    = 'default';
-    const DESIGN_FLAT       = 'flat';
-    const DESIGN_MATERIAL   = 'material';
+    const DESIGN_DEFAULT = 'default';
+    const DESIGN_FLAT = 'flat';
+    const DESIGN_MATERIAL = 'material';
 
     /**
      * @return array
@@ -42,10 +42,10 @@ class Design
                 'label' => __('Flat'),
                 'value' => self::DESIGN_FLAT
             ],
-			[
-				'label' => __('Material'),
-				'value' => self::DESIGN_MATERIAL
-			]
+//			[
+//				'label' => __('Material'),
+//				'value' => self::DESIGN_MATERIAL
+//			]
         ];
 
         return $options;
diff --git a/Model/System/Config/Source/RadioStyle.php b/Model/System/Config/Source/RadioStyle.php
deleted file mode 100644
index a830de0..0000000
--- a/Model/System/Config/Source/RadioStyle.php
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
-/**
- * Class Radio Style
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
-class RadioStyle
-{
-    const STYLE_DEFAULT   = 'default';
-    const WITH_GAP        = 'with_gap';
-
-    /**
-     * @return array
-     */
-    public function toOptionArray()
-    {
-        $options = [
-            [
-                'label' => __('Default'),
-                'value' => self::STYLE_DEFAULT
-            ],
-            [
-                'label' => __('With Gap'),
-                'value' => self::WITH_GAP
-            ]
-        ];
-
-        return $options;
-    }
-}
diff --git a/Observer/CheckoutSubmitBefore.php b/Observer/CheckoutSubmitBefore.php
index 96f70e4..2e53782 100644
--- a/Observer/CheckoutSubmitBefore.php
+++ b/Observer/CheckoutSubmitBefore.php
@@ -23,6 +23,7 @@ namespace Mageplaza\Osc\Observer;
 use Magento\Framework\Event\ObserverInterface;
 use Magento\Quote\Model\Quote;
 use Magento\Quote\Model\CustomerManagement;
+use Mageplaza\Osc\Helper\Config as OscConfig;
 
 /**
  * Class CheckoutSubmitBefore
@@ -56,18 +57,26 @@ class CheckoutSubmitBefore implements ObserverInterface
 	protected $customerManagement;
 
 	/**
+	 * @var \Mageplaza\Osc\Helper\Config
+	 */
+	protected $oscConfig;
+
+	/**
+	 * CheckoutSubmitBefore constructor.
 	 * @param \Magento\Checkout\Model\Session $checkoutSession
 	 * @param \Magento\Framework\DataObject\Copy $objectCopyService
 	 * @param \Magento\Framework\Api\DataObjectHelper $dataObjectHelper
 	 * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
 	 * @param \Magento\Quote\Model\CustomerManagement $customerManagement
+	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
 	 */
 	public function __construct(
 		\Magento\Checkout\Model\Session $checkoutSession,
 		\Magento\Framework\DataObject\Copy $objectCopyService,
 		\Magento\Framework\Api\DataObjectHelper $dataObjectHelper,
 		\Magento\Customer\Api\AccountManagementInterface $accountManagement,
-		CustomerManagement $customerManagement
+		CustomerManagement $customerManagement,
+		OscConfig $oscConfig
 	)
 	{
 		$this->checkoutSession    = $checkoutSession;
@@ -75,6 +84,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 		$this->dataObjectHelper   = $dataObjectHelper;
 		$this->accountManagement  = $accountManagement;
 		$this->customerManagement = $customerManagement;
+		$this->oscConfig          = $oscConfig;
 	}
 
 	/**
@@ -140,16 +150,27 @@ class CheckoutSubmitBefore implements ObserverInterface
 			->setData('should_ignore_validation', true);
 
 		if ($shipping) {
-			if (isset($oscData['same_as_shipping']) && $oscData['same_as_shipping']) {
-				$shipping->setCustomerAddressData($customerBillingData);
-				$customerBillingData->setIsDefaultShipping(true);
+			if ($this->oscConfig->isShowBillingAddressBeforeShippingAddress()) {
+				if (isset($oscData['billing-same-shipping']) && $oscData['billing-same-shipping']) {
+					$customerShippingData = $shipping->exportCustomerAddress();
+					$customerShippingData->setIsDefaultShipping(true)
+						->setData('should_ignore_validation', true);
+					$shipping->setCustomerAddressData($customerShippingData);
+					// Add shipping address to quote since customer Data Object does not hold address information
+					$quote->addCustomerAddress($customerShippingData);
+				}
 			} else {
-				$customerShippingData = $shipping->exportCustomerAddress();
-				$customerShippingData->setIsDefaultShipping(true)
-					->setData('should_ignore_validation', true);
-				$shipping->setCustomerAddressData($customerShippingData);
-				// Add shipping address to quote since customer Data Object does not hold address information
-				$quote->addCustomerAddress($customerShippingData);
+				if (isset($oscData['same_as_shipping']) && $oscData['same_as_shipping']) {
+					$shipping->setCustomerAddressData($customerBillingData);
+					$customerBillingData->setIsDefaultShipping(true);
+				} else {
+					$customerShippingData = $shipping->exportCustomerAddress();
+					$customerShippingData->setIsDefaultShipping(true)
+						->setData('should_ignore_validation', true);
+					$shipping->setCustomerAddressData($customerShippingData);
+					// Add shipping address to quote since customer Data Object does not hold address information
+					$quote->addCustomerAddress($customerShippingData);
+				}
 			}
 		} else {
 			$customerBillingData->setIsDefaultShipping(true);
@@ -161,7 +182,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 		// If customer is created, set customerId for address to avoid create more address when checkout
 		if ($customerId = $quote->getCustomerId()) {
 			$billing->setCustomerId($customerId);
-			if($shipping) {
+			if ($shipping) {
 				$shipping->setCustomerId($customerId);
 			}
 		}
diff --git a/Observer/OscConfigObserver.php b/Observer/OscConfigObserver.php
index e849a66..ca377b5 100644
--- a/Observer/OscConfigObserver.php
+++ b/Observer/OscConfigObserver.php
@@ -24,8 +24,6 @@ use Magento\Config\Model\ResourceModel\Config as ModelConfig;
 use Magento\Framework\App\Config\ScopeConfigInterface;
 use Magento\GiftMessage\Helper\Message;
 use Mageplaza\Osc\Helper\Config as HelperConfig;
-use Mageplaza\Osc\Helper\Data as HelperData;
-use Magento\Framework\Message\ManagerInterface as MessageManager;
 
 /**
  * Class OscConfigObserver
@@ -49,32 +47,15 @@ class OscConfigObserver implements \Magento\Framework\Event\ObserverInterface
     protected $_modelConfig;
 
     /**
-     * @var MessageManager
-     */
-    protected $_messageManager;
-
-    /**
-     * @var HelperData
-     */
-    protected $_helperData;
-
-
-    /**
-     * @param HelperConfig $helperConfig
-     * @param ModelConfig $modelConfig
-     * @param MessageManager $messageManager
-     * @param HelperData $HelperData
+     * @param \Mageplaza\Osc\Helper\Config $helperConfig
+     * @param \Magento\Config\Model\ResourceModel\Config $modelConfig
      */
     public function __construct(
         HelperConfig $helperConfig,
-        ModelConfig $modelConfig,
-        MessageManager $messageManager,
-        HelperData  $HelperData
+        ModelConfig $modelConfig
     ) {
         $this->_helperConfig = $helperConfig;
         $this->_modelConfig  = $modelConfig;
-        $this->_messageManager = $messageManager;
-        $this->_helperData      = $HelperData;
     }
 
     /**
@@ -82,41 +63,20 @@ class OscConfigObserver implements \Magento\Framework\Event\ObserverInterface
      */
     public function execute(\Magento\Framework\Event\Observer $observer)
     {
-        $scopeId            = 0;
-        $isGiftMessage      = !$this->_helperConfig->isDisabledGiftMessage();
-        $isGiftMessageItems = $this->_helperConfig->isEnableGiftMessageItems();
-        $isEnableTOC        = ($this->_helperConfig->disabledPaymentTOC() || $this->_helperConfig->disabledReviewTOC());
-        $isEnableGeoIP      = $this->_helperConfig->isEnableGeoIP();
+        $scopeId       = 0;
+        $isGiftMessage = !$this->_helperConfig->isDisabledGiftMessage();
+        $isEnableTOC   = ($this->_helperConfig->disabledPaymentTOC() || $this->_helperConfig->disabledReviewTOC());
         $this->_modelConfig
             ->saveConfig(
                 Message::XPATH_CONFIG_GIFT_MESSAGE_ALLOW_ORDER,
                 $isGiftMessage,
                 ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
                 $scopeId
-            )
-            ->saveConfig(
-                Message::XPATH_CONFIG_GIFT_MESSAGE_ALLOW_ITEMS,
-                $isGiftMessageItems,
-                ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
-                $scopeId
-            )
-            ->saveConfig(
+            )->saveConfig(
                 'checkout/options/enable_agreements',
                 $isEnableTOC,
                 ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
                 $scopeId
             );
-        if($isEnableGeoIP){
-            if(!$this->_helperData->checkHasLibrary()){
-                $this->_modelConfig->saveConfig(
-                    HelperConfig::GEO_IP_IS_ENABLED,
-                    false,
-                    ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
-                    $scopeId
-                );
-                $this->_messageManager->addNotice(__("Notice: Please download GeoIp library before enable."));
-            }
-        }
-
     }
 }
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index 6842d47..60252c3 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -64,10 +64,6 @@ class QuoteSubmitBefore implements ObserverInterface
             $order->setData('osc_delivery_time', $oscData['deliveryTime']);
         }
 
-		if (isset($oscData['houseSecurityCode'])) {
-			$order->setData('osc_order_house_security_code', $oscData['houseSecurityCode']);
-		}
-
         $address = $quote->getShippingAddress();
         if ($address->getUsedGiftWrap() && $address->hasData('osc_gift_wrap_amount') && $address->getUsedGiftWrap()) {
             $order->setData('gift_wrap_type', $address->getGiftWrapType())
diff --git a/Observer/RedirectToOneStepCheckout.php b/Observer/RedirectToOneStepCheckout.php
index 075d714..88ce687 100644
--- a/Observer/RedirectToOneStepCheckout.php
+++ b/Observer/RedirectToOneStepCheckout.php
@@ -66,9 +66,9 @@ class RedirectToOneStepCheckout implements ObserverInterface
 	 */
 	public function execute(Observer $observer)
 	{
-		if ($this->_helperConfig->isEnabled() && $this->_helperConfig->isRedirectToOneStepCheckout()) {
-			$request = $observer->getRequest();
-			$request->setParam('return_url',$this->_url->getUrl('onestepcheckout/'));
+		if ($this->_helperConfig->isRedirectToOneStepCheckout()) {
+			$observer->getEvent()->getResponse()->setRedirect($this->_url->getUrl('onestepcheckout'));
+			$this->checkoutSession->setNoCartRedirect(true);
 		}
 	}
 }
\ No newline at end of file
diff --git a/README.md b/README.md
index 7a9627e..9bddf77 100644
--- a/README.md
+++ b/README.md
@@ -1,51 +1,3 @@
-## Documentation
+How to Install: https://docs.mageplaza.com/kb/installation.html
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
-- User Guide: https://docs.mageplaza.com/one-step-checkout-m2/
-- Product page: https://www.mageplaza.com/magento-2-one-step-checkout-extension/
-- Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
-- Changelog: https://www.mageplaza.com/changelog/m2-one-step-checkout.txt
-- License agreement: https://www.mageplaza.com/LICENSE.txt
-
-
-
-## How to install
-
-Install ready-to-paste package (Recommended)
-
-- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
-
-
-
-
-## How to upgrade
-
-1. Backup
-Backup your Magento code, database before upgrading.
-2. Remove OSC folder 
-In case of customization, you should backup the customized files and modify in newer version. 
-Now you remove `app/code/Mageplaza/Osc` folder. In this step, you can copy override Osc folder but this may cause of compilation issue. That why you should remove it.
-3. Upload new version
-Upload this package to Magento root directory
-4. Run command line:
-
-```
-php bin/magento setup:upgrade
-php bin/magento setup:static-content:deploy
-```
-
-
-
-## FAQs
-
-
-#### Q: I got error: `Mageplaza_Core has been already defined`
-A: Read solution: https://github.com/mageplaza/module-core/issues/3
-
-#### Q: I got compile error
-Total Errors Count: 5 Errors during compilation:
-A: There are 2 major Mageplaza Osc version: OSC v1.x and OSC v2.x . If you are upgrade from OSC v1.x to V2.x, you should remove app/code/Mageplaza/Osc folder before upgrading.
-
-#### Q: My site is down
-A: Please follow this guide: https://www.mageplaza.com/blog/magento-site-down.html
+User Guide: https://docs.mageplaza.com/one-step-checkout-m2/
\ No newline at end of file
diff --git a/Setup/UpgradeData.php b/Setup/UpgradeData.php
index 17dd03c..6258f2e 100644
--- a/Setup/UpgradeData.php
+++ b/Setup/UpgradeData.php
@@ -94,9 +94,6 @@ class UpgradeData implements UpgradeDataInterface
 			$salesInstaller->addAttribute('order', 'osc_survey_question', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
 			$salesInstaller->addAttribute('order', 'osc_survey_answers', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
 		}
-        if (version_compare($context->getVersion(), '2.1.3') < 0) {
-            $salesInstaller->addAttribute('order', 'osc_order_house_security_code', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
-        }
 
 		$setup->endSetup();
 	}
diff --git a/USER-GUIDE.md b/USER-GUIDE.md
deleted file mode 100644
index f2e2813..0000000
--- a/USER-GUIDE.md
+++ /dev/null
@@ -1,80 +0,0 @@
-## Documentation
-
-- Installation guide: https://docs.mageplaza.com/kb/installation.html
-- User Guide: https://docs.mageplaza.com/one-step-checkout-m2/
-- Product page: https://www.mageplaza.com/magento-2-one-step-checkout-extension/
-- Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
-- Changelog: https://www.mageplaza.com/changelog/m2-one-step-checkout.txt
-- License agreement: https://www.mageplaza.com/LICENSE.txt
-
-
-
-## How to install
-
-### Method 1: Install ready-to-paste package (Recommended)
-
-- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
-- Installation guide: https://docs.mageplaza.com/kb/installation.html
-
-
-
-### Method 2: Manually install via composer
-
-1. Access to your server via SSH
-2. Create a folder (Not Magento root directory) in called: `mageplaza`, 
-3. Download the zip package at https://store.mageplaza.com/my-downloadable-products.html
-4. Upload the zip package to `mageplaza` folder.
-
-
-3. Add the following snippet to `composer.json`
-
-```
-	{
-		"repositories": [
-		 {
-		 "type": "artifact",
-		 "url": "mageplaza/"
-		 }
-		]
-	}
-```
-
-4. Run composer command line
-
-```
-composer require mageplaza/magento-2-one-step-checkout-extension
-php bin/magento setup:upgrade
-php bin/magento setup:static-content:deploy
-```
-
-## How to upgrade
-
-1. Backup
-Backup your Magento code, database before upgrading.
-2. Remove OSC folder 
-In case of customization, you should backup the customized files and modify in newer version. 
-Now you remove `app/code/Mageplaza/Osc` folder. In this step, you can copy override Osc folder but this may cause of compilation issue. That why you should remove it.
-3. Upload new version
-Upload this package to Magento root directory
-4. Run command line:
-
-```
-php bin/magento setup:upgrade
-php bin/magento setup:static-content:deploy
-```
-
-
-
-## FAQs
-
-
-#### Q: I got error: `Mageplaza_Core has been already defined`
-A: Read solution: https://github.com/mageplaza/module-core/issues/3
-
-#### Q: I got compile error
-Total Errors Count: 5 Errors during compilation:
-A: There are 2 major Mageplaza Osc version: OSC v1.x and OSC v2.x . If you are upgrade from OSC v1.x to V2.x, you should remove app/code/Mageplaza/Osc folder before upgrading.
-
-#### Q: My site is down
-A: Please follow this guide: https://www.mageplaza.com/blog/magento-site-down.html
-
diff --git a/composer.json b/composer.json
index 28972ab..33967c5 100644
--- a/composer.json
+++ b/composer.json
@@ -1,21 +1,14 @@
 {
-    "name": "mageplaza/magento-2-one-step-checkout-extension",
+    "name": "Mageplaza\/Osc",
     "description": "",
     "require": {
-        "mageplaza/module-core": "*"
+        "php": "~5.5.0|~5.6.0"
     },
     "type": "magento2-module",
-    "version": "2.4.0",
-    "license": "Mageplaza License",
-    "authors": [
-        {
-          "name": "Hi",
-          "email": "hi@mageplaza.com",
-          "homepage": "https://www.mageplaza.com",
-          "role": "Leader"
-        }
+    "version": "2.0.0",
+    "license": [
+        "Proprietary"
     ],
-
     "autoload": {
         "files": [
             "registration.php"
@@ -23,6 +16,13 @@
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
-
 }
\ No newline at end of file
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 5b1a0d0..fc94df1 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -34,18 +34,16 @@
                 <field id="is_enabled" translate="label comment" sortOrder="10" type="select" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable One Step Checkout</label>
-                    <comment><![CDATA[Select <strong>Yes</strong> to enable the module.]]></comment>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
                 <field id="title" translate="label comment" sortOrder="20" type="text" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>One Step Checkout Page Title</label>
-                    <comment>Enter the title of the page.</comment>
                 </field>
                 <field id="description" translate="label comment" sortOrder="40" type="textarea" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>One Step Checkout Description</label>
-                    <comment>Enter description for the page. HTML allowed.</comment>
+                    <comment>HTML allowed</comment>
                 </field>
                 <field id="default_shipping_method" translate="label comment" sortOrder="70" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1">
@@ -63,25 +61,33 @@
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Allow Guest Checkout</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment>Select Yes to allow checking out as a guest. Guests can create an account in the Checkout Page.</comment>
+                    <comment>Allow checking out as a guest. Guest can create an account in the checkout page.</comment>
                 </field>
                 <field id="redirect_to_one_step_checkout" translate="label comment" sortOrder="95" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Auto-redirect to One Step Checkout Page</label>
+                    <label>After Adding a Product Redirect to OneStepCheckout Page</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment>Select Yes to enable redirecting to the Checkout Page after a product's added to cart.</comment>
                 </field>
-                <field id="show_billing_address" translate="label comment" sortOrder="100" type="select"
+                <field id="show_billing_address" translate="label comment" sortOrder="97" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Show Billing Address</label>
+                    <label>Can Show Billing Address</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select Yes to allow the <strong>Billing Address</strong> block to appear in the Checkout Page, or No to imply that <strong>Billing Address</strong> and <strong>Shipping Address</strong> are the same.]]></comment>
+                    <comment>Allow customers can billing to a different address from billing address.</comment>
+                </field>
+                <field id="show_billing_before_shipping" translate="label comment" sortOrder="99" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                    <label>Show Billing Address Before Shipping Address</label>
+                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                    <comment>Allow customers can set billing address before shipping address </comment>
+                    <depends>
+                        <field id="show_billing_address">1</field>
+                    </depends>
                 </field>
                 <field id="auto_detect_address" sortOrder="101" type="select" showInDefault="1" showInWebsite="1"
                        showInStore="1" canRestore="1">
                     <label>Use Auto Suggestion Technology</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\AddressSuggest</source_model>
-                    <comment><![CDATA[Select <strong>Google</strong> to use it for automatic address suggestion, or <strong>No</strong> to disable this feature.]]></comment>
+                    <comment>When customer fills address fields, it will suggest a list of full addresses.</comment>
                 </field>
                 <field id="google_api_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1"
                        showInStore="1" canRestore="1">
@@ -133,13 +139,12 @@
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Login Link</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to show a link for visitors to login.]]></comment>
                 </field>
                 <field id="is_enabled_review_cart_section" translate="label comment" sortOrder="5" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Order Review Section</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>No</strong> to remove the Order Review section. The section is displayed by default.]]></comment>
+                    <comment>You can disable Order Review Section. It is enabled by default.</comment>
                 </field>
                 <field id="is_show_product_image" translate="label comment" sortOrder="6" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
@@ -148,19 +153,16 @@
                     <depends>
                         <field id="is_enabled_review_cart_section">1</field>
                     </depends>
-                    <comment><![CDATA[Select <strong>Yes</strong> to show product thumbnail image.]]></comment>
                 </field>
                 <field id="show_coupon" translate="label comment" sortOrder="10" type="select" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Discount Code Section</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to show Discount Code section.]]></comment>
                 </field>
                 <field id="is_enabled_gift_wrap" translate="label comment" sortOrder="20" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Enable Gift Wrap</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to enable Gift Wrap.]]></comment>
                 </field>
                 <field id="gift_wrap_type" translate="label comment" sortOrder="21" type="select" showInDefault="1"
                        showInWebsite="1" showInStore="1">
@@ -184,31 +186,23 @@
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Order Comment</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to allow customers to comment on the order.]]></comment>
+                    <comment>Allow customer comment in order.</comment>
                 </field>
                 <field id="is_enabled_gift_message" translate="label comment" sortOrder="35" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Enable Gift Messages on order.</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to allow leaving messages on the whole order.]]></comment>
-                </field>
-                <field id="is_enabled_gift_message_items" translate="label comment" sortOrder="38" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Enable Gift Messages on item</label>
+                    <label>Enable Gift Message</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to allow leaving messages on each item.]]></comment>
                 </field>
                 <field id="show_toc" translate="label comment" sortOrder="40" type="select" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Terms and Conditions</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
-                    <comment><![CDATA[Select <strong>No</strong> to hide <strong>Terms and Conditions</strong>, or select an area to display it.]]></comment>
                 </field>
                 <field id="is_enabled_newsletter" translate="label comment" sortOrder="60" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Newsletter Checkbox</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to show the Newsletter checkbox.]]></comment>
+                    <comment>Show Sign up newsletter selection</comment>
                 </field>
                 <field id="is_checked_newsletter" translate="label comment" sortOrder="61" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
@@ -217,42 +211,26 @@
                     <depends>
                         <field id="is_enabled_newsletter">1</field>
                     </depends>
-                    <comment><![CDATA[Select <strong>Yes</strong> to have the Newsletter checkbox ticked by default.]]></comment>
                 </field>
                 <field id="is_enabled_social_login" translate="label comment" sortOrder="70" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Social Login On Checkout Page</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <if_module_enabled>Mageplaza_SocialLogin</if_module_enabled>
-                    <comment><![CDATA[Select <strong>Yes</strong> to allow customers to login via their social network accounts. Supports Mageplaza <a href="https://www.mageplaza.com/magento-2-social-login-extension"
-                        target="_blank">Social Login</a>]]></comment>
                 </field>
                 <field id="is_enabled_delivery_time" translate="label comment" sortOrder="80" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Delivery Time</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to allow customers to choose delivery time.]]></comment>
                 </field>
-                <field id="is_enabled_house_security_code" translate="label comment" sortOrder="81" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>House Security Code</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <depends>
-                        <field id="is_enabled_delivery_time">1</field>
-                    </depends>
-                    <comment><![CDATA[Select <strong>Yes</strong> to allow customers to fill their house security codes.]]></comment>
-                </field>
-
-                <field id="delivery_time_format" translate="label comment" sortOrder="82" type="select"
+                <field id="delivery_time_format" translate="label comment" sortOrder="81" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Date Format</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\DeliveryTime</source_model>
                     <depends>
                         <field id="is_enabled_delivery_time">1</field>
                     </depends>
-                    <comment>Select the date format used for delivery time.</comment>
                 </field>
-                <field id="delivery_time_off" translate="label" type="multiselect" sortOrder="83" showInDefault="1"
+                <field id="delivery_time_off" translate="label" type="multiselect" sortOrder="82" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Days Off</label>
                     <source_model>Magento\Config\Model\Config\Source\Locale\Weekdays</source_model>
@@ -260,13 +238,12 @@
                     <depends>
                         <field id="is_enabled_delivery_time">1</field>
                     </depends>
-                    <comment>Select days off</comment>
                 </field>
                 <field id="is_enabled_survey" translate="label comment" sortOrder="100" type="select"
                        showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Survey</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <comment><![CDATA[Select <strong>Yes</strong> to show a survey after successful checkout]]></comment>
+                    <comment>It will show on success page</comment>
                 </field>
                 <field id="survey_question" translate="label comment" sortOrder="104" type="text" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1" >
@@ -300,20 +277,18 @@
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Checkout Page Layout</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Layout</source_model>
-                    <comment>Select the layout used for the Checkout Page.</comment>
                 </field>
                 <field id="page_design" translate="label comment" sortOrder="10" type="select" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Design Style</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Design</source_model>
-                    <comment>Select the design style for the Checkout Page.</comment>
                 </field>
                 <field id="heading_background" translate="label comment" sortOrder="20" type="text" showInDefault="1"
                        showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Heading Background Color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                     <depends>
-                        <field id="page_design">flat</field>
+                        <field id="page_design" separator=",">flat,material</field>
                     </depends>
                 </field>
                 <field id="heading_text" translate="label comment" sortOrder="25" type="text" showInDefault="1"
@@ -321,37 +296,9 @@
                     <label>Heading Text Color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                     <depends>
-                        <field id="page_design" >flat</field>
-                    </depends>
-                </field>
-                <field id="radio_button_style" translate="label comment" sortOrder="26" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Radio Button Style</label>
-                    <depends>
-                        <field id="page_design" >material</field>
-                    </depends>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\RadioStyle</source_model>
-                    <comment>Select the radio button style.</comment>
-                </field>
-                <field id="checkbox_button_style" translate="label comment" sortOrder="27" type="select" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>CheckBox Button Style</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\CheckboxStyle</source_model>
-                    <depends>
-                        <field id="page_design" >material</field>
-                    </depends>
-                    <comment>Select the checkbox button style.</comment>
-                </field>
-                <field id="material_color" translate="label comment" sortOrder="28" type="text" showInDefault="1"
-                       showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Material Color</label>
-                    <validate>jscolor {hash:true,refine:false}</validate>
-                    <comment>Change color icon heading, border input text, radio,checkbox buttons.</comment>
-                    <depends>
-                        <field id="page_design" >material</field>
+                        <field id="page_design" separator=",">flat,material</field>
                     </depends>
                 </field>
-
                 <field id="place_order_button" sortOrder="30" type="text" showInDefault="1" showInWebsite="1"
                        showInStore="1" canRestore="1">
                     <label>Place Order button color</label>
@@ -363,20 +310,6 @@
                     <comment><![CDATA[Example: .step-title{background-color: #1979c3;}]]></comment>
                 </field>
             </group>
-            <group id="geoip_configuration" translate="label comment" sortOrder="40" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
-                <label>GeoIP Configuration</label>
-                <field id="is_enable_geoip" translate="label comment" sortOrder="1" type="select"
-                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Enable GeoIP</label>
-                    <comment>Please download library before enable.</comment>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="download_library" translate="label comment" type="button" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="0">
-                    <frontend_model>Mageplaza\Osc\Block\Adminhtml\System\Config\Geoip</frontend_model>
-                    <label></label>
-                </field>
-                <!--<field id="download_path" translate="label comment" sortOrder="20" type="hidden" showInDefault="1" showInWebsite="1" showInStore="1"></field>-->
-            </group>
         </section>
     </system>
 </config>
\ No newline at end of file
diff --git a/etc/config.xml b/etc/config.xml
index 9337356..f31ed25 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -29,6 +29,7 @@
                 <description>Please enter your details below to complete your purchase.</description>
                 <allow_guest_checkout>1</allow_guest_checkout>
                 <show_billing_address>1</show_billing_address>
+                <show_billing_before_shipping>0</show_billing_before_shipping>
                 <redirect_to_one_step_checkout>0</redirect_to_one_step_checkout>
                 <auto_detect_address>google</auto_detect_address>
                 <google_api_key>AIzaSyBW4vLsNZoKFMFMPUR4C0ZuKtaaDDEajos</google_api_key>
@@ -48,15 +49,8 @@
                 <page_design>flat</page_design>
                 <heading_background>#1979c3</heading_background>
                 <heading_text>#FFFFFF</heading_text>
-                <radio_button_style>with_gap</radio_button_style>
-                <checkbox_button_style>default</checkbox_button_style>
-                <material_color>#1979c3</material_color>
                 <place_order_button>#1979c3</place_order_button>
             </design_configuration>
-            <geoip_configuration>
-                <is_enable_geoip>0</is_enable_geoip>
-                <download_path><![CDATA[http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz]]></download_path>
-            </geoip_configuration>
             <field>
                 <position>[{"code":"firstname","colspan":6},{"code":"lastname","colspan":6},{"code":"street","colspan":12},{"code":"country_id","colspan":6},{"code":"city","colspan":6},{"code":"postcode","colspan":6},{"code":"region_id","colspan":6},{"code":"company","colspan":6},{"code":"telephone","colspan":6}]</position>
             </field>
diff --git a/etc/module.xml b/etc/module.xml
index f78dfd8..cad4fe1 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -21,7 +21,7 @@
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
-    <module name="Mageplaza_Osc" setup_version="2.1.3">
+    <module name="Mageplaza_Osc" setup_version="2.1.2">
         <sequence>
             <module name="Mageplaza_Core"/>
             <module name="Magento_Checkout"/>
diff --git a/i18n/af_ZA.csv b/i18n/af_ZA.csv
deleted file mode 100644
index 934533a..0000000
--- a/i18n/af_ZA.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Kies asseblief --"
-"1 Column","1 kolom"
-"2 Columns","2 kolomme"
-"3 Columns","3 kolomme"
-"3 Columns With Colspan","3 Kolomme Met Colspan"
-"Example: .step-title{background-color: #1979c3;}","Voorbeeld: .step-titel {agtergrond-kleur: # 1979c3;}"
-"AVAILABLE FIELDS","BESKIKBARE GEBIEDE"
-"Add","Voeg"
-"Additional Content","Bykomende inhoud"
-"Additional Information","Bykomende inligting"
-"After Adding a Product Redirect to OneStepCheckout Page","Nadat u 'n Produk Aanstuur na OneStepCheckout-bladsy bygevoeg het"
-"All fields have been saved.","Alle velde is gestoor."
-"Allow Customer Add Other Option","Laat kliënt ander opsie by"
-"Allow Guest Checkout","Laat gas-uitbetaling toe"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Laat check as 'n gas toe. Gaste kan 'n rekening in die kassa-bladsy skep."
-"Allow customer comment in order.","Laat kliënte kommentaar in orde."
-"Allow customers can billing to a different address from billing address.","Laat kliënte toe om na 'n ander adres te faktureer vanaf faktuuradres."
-"Amount","bedrag"
-"Calculate Method","Bereken Metode"
-"Can Show Billing Address","Kan faktuur adres wys"
-"Capture+ Key","Vang + Sleutel"
-"Capture+ by PCA Predict","Vang + deur PCA Voorspel"
-"Checked Newsletter by default","Gekontroleerde Nuusbrief by verstek"
-"Checkout Page Layout","Checkout bladsy uitleg"
-"Could not add gift wrap for this quote","Kon nie geskenkwrap vir hierdie kwotasie byvoeg nie"
-"Could not remove item from quote","Kon nie item uit kwotasie verwyder nie"
-"Could not update item from quote","Kon nie item van kwotasie opdateer nie"
-"Custom Css","Aangepaste Css"
-"Date Format","Datum formaat"
-"Day/Month/Year","Dag / maand / jaar"
-"Days Off","Dae af"
-"Default","verstek"
-"Default Payment Method","Verstek betaalmetode"
-"Default Shipping Method","Verstek Versendingsmetode"
-"Delivery Time","Afleweringstyd"
-"Design Configuration","Ontwerpkonfigurasie"
-"Design Style","Ontwerpstyl"
-"Display Configuration","Vertoon konfigurasie"
-"Enable Delivery Time","Aktiveer afleweringstyd"
-"Enable Gift Message","Aktiveer geskenkboodskap"
-"Enable Gift Wrap","Aktiveer Gift Wrap"
-"Enable One Step Checkout","Aktiveer een stapuitgawe"
-"Enable Social Login On Checkout Page","Aktiveer sosiale aanmelding op kassa-bladsy"
-"Enable Survey","Aktiveer opname"
-"Enter the amount of gift wrap fee.","Gee die bedrag van die geskenkafslagfooi in."
-"Error during save field position.","Fout tydens spaar veld posisie."
-"Field Management","Veldbestuur"
-"Flat","Plat"
-"General Configuration","Algemene konfigurasie"
-"Gift Wrap","Geskenkpapier"
-"Google","Google"
-"Google Api Key","Google Api sleutel"
-"HTML allowed","HTML toegelaat"
-"Heading Background Color","Opskrif agtergrondkleur"
-"Heading Text Color","Opskrif Tekst Kleur"
-"IP Country Lookup","IP Land Lookup"
-"In Payment Area","In Betaalarea"
-"In Review Area","In Review Area"
-"It will show on success page","Dit sal op die suksesbladsy wys"
-"Material","materiaal"
-"Month/Day/Year","Maand / dag / jaar"
-"No","Geen"
-"One Step Checkout","Een stapuitgawe"
-"One Step Checkout Description","Een stapuitgawe beskrywing"
-"One Step Checkout Page Title","Een-stap-uitgawe bladsy titel"
-"One step checkout is turned off.","Een stap-kassa is afgeskakel."
-"Options","opsies"
-"Order Comment","Bestel kommentaar"
-"Order Survey","Bestelling Opname"
-"Per Item","Per item"
-"Per Order","Per bestelling"
-"Place Order button color","Plaas Bestelknoppie kleur"
-"Restrict the auto suggestion for a specific country","Beperk die outomatiese voorstel vir 'n spesifieke land"
-"SORTED FIELDS","GEVORMDE GEBIEDE"
-"Save Position","Stoor posisie"
-"Set default payment method in the checkout process.","Stel verstek betaling metode in die kassa proses."
-"Set default shipping method in the checkout process.","Stel standaard gestuur metode in die kassa proses."
-"Show Discount Code Section","Wys afslagkode-afdeling"
-"Show Login Link","Wys Login Link"
-"Show Newsletter Checkbox","Wys Nuusbrief Checkbox"
-"Show Order Comment","Wys bestelling kommentaar"
-"Show Order Review Section","Wys bestellingsoorsig afdeling"
-"Show Product Thumbnail Image","Wys Produk Duimnaelskets Image"
-"Show Sign up newsletter selection","Wys Teken nuusbrief seleksie"
-"Show Terms and Conditions","Wys terme en voorwaardes"
-"Survey Answers","Opname Antwoorde"
-"Survey Question","Opname Vraag"
-"The default country will be set based on location of the customer.","Die standaard land sal ingestel word op grond van die ligging van die kliënt."
-"There is an error while subscribing for newsletter.","Daar is 'n fout tydens die inteken vir nuusbrief."
-"To calculate gift wrap fee based on item or order.","Om geskenkpakgeld te bereken op grond van item of bestelling."
-"Unable to save order information. Please check input data.","Kon nie bestellingsinligting stoor nie. Kontroleer asseblief insetdata."
-"Use Auto Suggestion Technology","Gebruik Auto Suggestion Technology"
-"When customer fills address fields, it will suggest a list of full addresses.","Wanneer kliënte adresvelde invul, sal dit 'n lys van volledige adresse voorstel."
-"Year/Month/Day","Jaar / maand / dag"
-"You can disable Order Review Section. It is enabled by default.","U kan bestellingsoorsig-afdeling deaktiveer. Dit is standaard aangeskakel."
\ No newline at end of file
diff --git a/i18n/ar_SA.csv b/i18n/ar_SA.csv
deleted file mode 100644
index 0be2bcc..0000000
--- a/i18n/ar_SA.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","- الرجاء الاختيار -"
-"1 Column","1 عمود"
-"2 Columns","2 أعمدة"
-"3 Columns","3 أعمدة"
-"3 Columns With Colspan","3 أعمدة مع كولسبان"
-"Example: .step-title{background-color: #1979c3;}","مثال: .step-تيتل {باكغروند-كولور: # 1979c3؛}"
-"AVAILABLE FIELDS","الحقول المتاحة"
-"Add","إضافة"
-"Additional Content","محتوى إضافي"
-"Additional Information","معلومة اضافية"
-"After Adding a Product Redirect to OneStepCheckout Page","بعد إضافة إعادة توجيه المنتج إلى صفحة أونيستيبشيكوت"
-"All fields have been saved.","تم حفظ جميع الحقول."
-"Allow Customer Add Other Option","السماح للعميل بإضافة خيار آخر"
-"Allow Guest Checkout","السماح بخروج الضيف"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","السماح بتسجيل الخروج كضيف. يمكن للضيوف إنشاء حساب في صفحة الدفع."
-"Allow customer comment in order.","السماح بتعليق العميل بالترتيب."
-"Allow customers can billing to a different address from billing address.","السماح للعملاء بإرسال الفواتير إلى عنوان مختلف من عنوان إرسال الفواتير."
-"Amount","كمية"
-"Calculate Method","حساب الطريقة"
-"Can Show Billing Address","يمكن عرض عنوان إرسال الفواتير"
-"Capture+ Key","التقاط + مفتاح"
-"Capture+ by PCA Predict","التقاط + من يكا التنبؤ"
-"Checked Newsletter by default","فحص النشرة الإخبارية بشكل افتراضي"
-"Checkout Page Layout","تشيكوت بادج لايوت"
-"Could not add gift wrap for this quote","تعذر إضافة غلاف هدايا لهذا الاقتباس"
-"Could not remove item from quote","تعذر إزالة العنصر من الاقتباس"
-"Could not update item from quote","تعذر تحديث العنصر من الاقتباس"
-"Custom Css","لغة تنسيق ويب حسب الطلب"
-"Date Format","صيغة التاريخ"
-"Day/Month/Year","يوم شهر سنة"
-"Days Off","أيام إيقاف"
-"Default","افتراضي"
-"Default Payment Method","طريقه تسديد خاطئه"
-"Default Shipping Method","طريقة الشحن الافتراضية"
-"Delivery Time","موعد التسليم"
-"Design Configuration","تكوين التصميم"
-"Design Style","تصميم نمط"
-"Display Configuration","تهيئة العرض"
-"Enable Delivery Time","تمكين وقت التسليم"
-"Enable Gift Message","تمكين رسالة هدية"
-"Enable Gift Wrap","تمكين التفاف الهدايا"
-"Enable One Step Checkout","تمكين الخروج خطوة واحدة"
-"Enable Social Login On Checkout Page","تمكين تسجيل الدخول الاجتماعي في صفحة الدفع"
-"Enable Survey","تمكين المسح"
-"Enter the amount of gift wrap fee.","أدخل مبلغ رسوم التفاف هدية."
-"Error during save field position.","حدث خطأ أثناء حفظ موضع الحقل."
-"Field Management","الإدارة الميدانية"
-"Flat","مسطحة"
-"General Configuration","التكوين العام"
-"Gift Wrap","تغليف الهدية"
-"Google","جوجل"
-"Google Api Key","مفتاح واجهة برمجة تطبيقات غوغل"
-"HTML allowed","يسمح هتمل"
-"Heading Background Color","عنوان لون الخلفية"
-"Heading Text Color","لون نص العنوان"
-"IP Country Lookup","إب بحث البلد"
-"In Payment Area","في منطقة الدفع"
-"In Review Area","في منطقة المراجعة"
-"It will show on success page","وسوف تظهر على صفحة النجاح"
-"Material","مواد"
-"Month/Day/Year","شهر يوم سنه"
-"No","لا"
-"One Step Checkout","خطوة واحدة الخروج"
-"One Step Checkout Description","خطوة واحدة الخروج الوصف"
-"One Step Checkout Page Title","عنوان صفحة الخروج خطوة واحدة"
-"One step checkout is turned off.","تم إيقاف الخروج من خطوة واحدة."
-"Options","خيارات"
-"Order Comment","طلب تعليق"
-"Order Survey","مسح الطلب"
-"Per Item","لكل بند"
-"Per Order","لكل طلب"
-"Place Order button color","وضع زر زر اللون"
-"Restrict the auto suggestion for a specific country","تقييد اقتراح السيارات لبلد معين"
-"SORTED FIELDS","مجالات محددة"
-"Save Position","حفظ موقف"
-"Set default payment method in the checkout process.","تعيين طريقة الدفع الافتراضية في عملية الدفع."
-"Set default shipping method in the checkout process.","تعيين طريقة الشحن الافتراضي في عملية الخروج."
-"Show Discount Code Section","عرض قسم رمز الخصم"
-"Show Login Link","عرض رابط تسجيل الدخول"
-"Show Newsletter Checkbox","عرض مربع النشرة الإخبارية"
-"Show Order Comment","عرض تعليق النظام"
-"Show Order Review Section","عرض قسم مراجعة الطلبات"
-"Show Product Thumbnail Image","عرض المنتج صورة مصغرة"
-"Show Sign up newsletter selection","إظهار الاشتراك اختيار النشرة الإخبارية"
-"Show Terms and Conditions","عرض الشروط والأحكام"
-"Survey Answers","إجابات المسح"
-"Survey Question","سؤال الاستبيان"
-"The default country will be set based on location of the customer.","سيتم تعيين البلد الافتراضي بناء على موقع العميل."
-"There is an error while subscribing for newsletter.","حدث خطأ أثناء الاشتراك في النشرة الإخبارية."
-"To calculate gift wrap fee based on item or order.","لحساب هدية التفاف هدية على أساس البند أو النظام."
-"Unable to save order information. Please check input data.","تعذر حفظ معلومات الطلب. يرجى التحقق من بيانات الإدخال."
-"Use Auto Suggestion Technology","استخدام تقنية اقتراح تلقائي"
-"When customer fills address fields, it will suggest a list of full addresses.","عندما يملأ العملاء حقول العنوان، فإنه سيقترح قائمة من العناوين الكاملة."
-"Year/Month/Day","سنة شهر يوم"
-"You can disable Order Review Section. It is enabled by default.","يمكنك تعطيل قسم مراجعة الطلبات. يتم تمكينه بشكل افتراضي."
\ No newline at end of file
diff --git a/i18n/be_BY.csv b/i18n/be_BY.csv
deleted file mode 100644
index 457cb7b..0000000
--- a/i18n/be_BY.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","- Калі ласка, вызначце -"
-"1 Column","1 калонка"
-"2 Columns","2 калонкі"
-"3 Columns","3 Калоны"
-"3 Columns With Colspan","3 Стоўбцы З Colspan"
-"Example: .step-title{background-color: #1979c3;}","Прыклад: .step-загаловак {фонавага колеру: # 1979c3;}"
-"AVAILABLE FIELDS","даступныя поля"
-"Add","дадаваць"
-"Additional Content","дадатковае ўтрыманне"
-"Additional Information","дадатковая інфармацыя"
-"After Adding a Product Redirect to OneStepCheckout Page","Пасля дадання Перанакіраванне прадукту ў OneStepCheckout Старонка"
-"All fields have been saved.","Усе палі былі захаваныя."
-"Allow Customer Add Other Option","Дазволіць кліентаў Дадаць прэч"
-"Allow Guest Checkout","Дазволіць Госць заказ"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Дазвольце праверыць у якасці госця. Госць можа стварыць уліковы запіс на старонцы афармлення замовы."
-"Allow customer comment in order.","Дазволіць кліент каментар у парадку."
-"Allow customers can billing to a different address from billing address.","Дазволіць кліенты могуць білінг на іншы адрас з плацёжнага адрасы."
-"Amount","сума"
-"Calculate Method","разлічыць метад"
-"Can Show Billing Address","Можна паказаць Billing Address"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Захоп + па PCA Прадказаць"
-"Checked Newsletter by default","Праверыў бюлетэнь па змаўчанні"
-"Checkout Page Layout","Кампаноўка заказ Старонка"
-"Could not add gift wrap for this quote","Не атрымалася дадаць падарункавую ўпакоўку для гэтай цытаты"
-"Could not remove item from quote","Не атрымалася выдаліць з цытаты"
-"Could not update item from quote","Не атрымалася абнавіць аб'ект з прапановы"
-"Custom Css","прыстасаваныя Css"
-"Date Format","фармат даты"
-"Day/Month/Year","Дзень / месяц / год"
-"Days Off","Выходныя дні"
-"Default","дэфолт"
-"Default Payment Method","Па змаўчанні Спосаб аплаты"
-"Default Shipping Method","Па змаўчанні спосаб дастаўкі"
-"Delivery Time","тэрмін пастаўкі"
-"Design Configuration","праектаванне канфігурацыі"
-"Design Style","дызайн Стыль"
-"Display Configuration","канфігурацыя дысплея"
-"Enable Delivery Time","Ўключыць Час дастаўкі"
-"Enable Gift Message","Ўключыць паведамленне для падарунка"
-"Enable Gift Wrap","Ўключыць Gift Wrap"
-"Enable One Step Checkout","Enable One Step Checkout"
-"Enable Social Login On Checkout Page","Ўключыць Сацыяльны ўваход на заказ Старонка"
-"Enable Survey","ўключыць апытанне"
-"Enter the amount of gift wrap fee.","Калі ласка, увядзіце суму ганарару падарункавым пакаванні."
-"Error during save field position.","Памылка пазіцыі эканоміі поля."
-"Field Management","Упраўленне палямі"
-"Flat","кватэра"
-"General Configuration","агульная канфігурацыя"
-"Gift Wrap","Падарункавая ўпакоўка"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTML дазволена"
-"Heading Background Color","Загаловак Колер фону"
-"Heading Text Color","Загаловак Колер тэксту"
-"IP Country Lookup","IP Краіна Lookup"
-"In Payment Area","У плацежнай зоне"
-"In Review Area","У зоне агляду"
-"It will show on success page","Ён будзе адлюстроўвацца на старонцы поспеху"
-"Material","матэрыял"
-"Month/Day/Year","Месяц / дзень / год"
-"No","няма"
-"One Step Checkout","крок заказ"
-"One Step Checkout Description","One Step Checkout Апісанне"
-"One Step Checkout Page Title","Крок заказ Назва старонкі"
-"One step checkout is turned off.","Адзін крок кантроль выключаны."
-"Options","опцыі"
-"Order Comment","Каментар да замовы"
-"Order Survey","парадак абследавання"
-"Per Item","за адзінку"
-"Per Order","на заказ"
-"Place Order button color","Змесціце заказ колер кнопкі"
-"Restrict the auto suggestion for a specific country","Абмежаванне аўтаматычнага прапановы для канкрэтнай краіны"
-"SORTED FIELDS","адсартаваных ПОЛЯ"
-"Save Position","захаваць пазіцыю"
-"Set default payment method in the checkout process.","Ўсталяваць спосаб аплаты па змаўчанні ў працэсе афармлення замовы."
-"Set default shipping method in the checkout process.","Ўсталяваць спосаб дастаўкі па змаўчанні ў працэсе афармлення замовы."
-"Show Discount Code Section","Паказаць раздзел код скідкі"
-"Show Login Link","Паказаць Увайсці Спасылка"
-"Show Newsletter Checkbox","Паказаць навіны Checkbox"
-"Show Order Comment","Паказаць заказ Каментаваць"
-"Show Order Review Section","Раздзел Паказаць заказ Агляд"
-"Show Product Thumbnail Image","Паказаць мініяцюрнае Выява"
-"Show Sign up newsletter selection","Паказаць Зарэгістравацца выбар бюлетэнь"
-"Show Terms and Conditions","Паказаць Правілы і ўмовы"
-"Survey Answers","апытанне адказы"
-"Survey Question","апытанне Пытанне"
-"The default country will be set based on location of the customer.","краіна па змаўчанні будзе ўстаноўлена ў залежнасці ад месцазнаходжання заказчыка."
-"There is an error while subscribing for newsletter.","Існуе памылка пры падпісцы на рассылку."
-"To calculate gift wrap fee based on item or order.","Для разліку падарункавым пакаванні платы на аснове пункта або замовы."
-"Unable to save order information. Please check input data.","Не атрымалася захаваць інфармацыю аб замове. Калі ласка, праверце ўведзеныя дадзеныя."
-"Use Auto Suggestion Technology","Выкарыстанне аўтаматычнага Прапанова тэхналогіі"
-"When customer fills address fields, it will suggest a list of full addresses.","Калі кліент запаўняе поля адрасы, ён прапануе спіс поўных адрасоў."
-"Year/Month/Day","Год / Месяц / Дзень"
-"You can disable Order Review Section. It is enabled by default.","Вы можаце адключыць раздзел агляду Order. Яна ўключана па змаўчанні."
\ No newline at end of file
diff --git a/i18n/ca_ES.csv b/i18n/ca_ES.csv
deleted file mode 100644
index 99af95e..0000000
--- a/i18n/ca_ES.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","- Seleccioneu -"
-"1 Column","1 columna"
-"2 Columns","2 columnes"
-"3 Columns","3 columnes"
-"3 Columns With Colspan","3 columnes amb Colspan"
-"Example: .step-title{background-color: #1979c3;}","Exemple: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","CAMPOS DISPONIBLES"
-"Add","Afegeix"
-"Additional Content","Contingut addicional"
-"Additional Information","informació adicional"
-"After Adding a Product Redirect to OneStepCheckout Page","Després d'afegir una redirecció de productes a OneStepCheckout Page"
-"All fields have been saved.","Tots els camps s'han desat."
-"Allow Customer Add Other Option","Permet que l'opció Afegeix un altre client"
-"Allow Guest Checkout","Permet la compra de clients"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Permetre la visita com a convidat. El client pot crear un compte a la pàgina de pagament."
-"Allow customer comment in order.","Permet que el comentari del client sigui correcte."
-"Allow customers can billing to a different address from billing address.","Permet que els clients puguin facturar a una adreça diferent de l'adreça de facturació."
-"Amount","Import"
-"Calculate Method","Calcula el mètode"
-"Can Show Billing Address","Es pot mostrar l'adreça de facturació"
-"Capture+ Key","Captura + clau"
-"Capture+ by PCA Predict","Capturar + per PCA Predir"
-"Checked Newsletter by default","Newsletter revisat per defecte"
-"Checkout Page Layout","Distribució de la pàgina de compra"
-"Could not add gift wrap for this quote","No s'ha pogut afegir l'embolcall de regal per a aquesta cita"
-"Could not remove item from quote","No s'ha pogut eliminar l'element de la cotització"
-"Could not update item from quote","No s'ha pogut actualitzar l'element de la comanda"
-"Custom Css","CSS personalitzat"
-"Date Format","Format de data"
-"Day/Month/Year","Dia / Mes / Any"
-"Days Off","Dies de descans"
-"Default","Per defecte"
-"Default Payment Method","Mètode de pagament per defecte"
-"Default Shipping Method","Mètode d'enviament predeterminat"
-"Delivery Time","Hora d'entrega"
-"Design Configuration","Configuració del disseny"
-"Design Style","Estil de disseny"
-"Display Configuration","Configuració de la pantalla"
-"Enable Delivery Time","Habilita el temps de lliurament"
-"Enable Gift Message","Activa el missatge de regal"
-"Enable Gift Wrap","Activa l'embolcall de regal"
-"Enable One Step Checkout","Habilita la compra d'un passi al pas"
-"Enable Social Login On Checkout Page","Activa la pàgina d'inici de sessió d'inici de sessió social"
-"Enable Survey","Habilita l'enquesta"
-"Enter the amount of gift wrap fee.","Introduïu la quantitat de quota d'embolcall de regal."
-"Error during save field position.","Error durant la posició del camp guardar."
-"Field Management","Gestió del camp"
-"Flat","Pis"
-"General Configuration","Configuració general"
-"Gift Wrap","Paper de regal"
-"Google","Google"
-"Google Api Key","Clau de Google Api"
-"HTML allowed","S'ha permès l'HTML"
-"Heading Background Color","Color de fons d'encapçalament"
-"Heading Text Color","Color del text de encapçalament"
-"IP Country Lookup","Cerca de països IP"
-"In Payment Area","A l'àrea de pagament"
-"In Review Area","A l'àrea de revisió"
-"It will show on success page","Es mostrarà a la pàgina d'èxit"
-"Material","Material"
-"Month/Day/Year","Mes / Dia / Any"
-"No","No"
-"One Step Checkout","Un cop d'entrada al pas"
-"One Step Checkout Description","Una descripció del procés d'eliminació de passos"
-"One Step Checkout Page Title","Títol de la pàgina d'enviament d'un pas"
-"One step checkout is turned off.","S'ha desactivat un procés de pagament inicial."
-"Options","Opcions"
-"Order Comment","Comanda el comentari"
-"Order Survey","Enquesta de comandes"
-"Per Item","Per article"
-"Per Order","Per ordre"
-"Place Order button color","Col.lecció del botó ""Ordena"""
-"Restrict the auto suggestion for a specific country","Restringiu el suggeriment automàtic d'un país concret"
-"SORTED FIELDS","CAMPS DESTINATS"
-"Save Position","Desa la posició"
-"Set default payment method in the checkout process.","Estableix el mètode de pagament predeterminat en el procés de pagament."
-"Set default shipping method in the checkout process.","Estableix el mètode d'enviament predeterminat en el procés de pagament."
-"Show Discount Code Section","Mostra la secció del codi de descompte"
-"Show Login Link","Mostra l'enllaç d'inici de sessió"
-"Show Newsletter Checkbox","Mostrar casella de selecció de butlletí de notícies"
-"Show Order Comment","Mostra el comentari de comanda"
-"Show Order Review Section","Mostra la secció de revisió de comandes"
-"Show Product Thumbnail Image","Mostra la imatge en miniatura del producte"
-"Show Sign up newsletter selection","Mostra la selecció del butlletí de registre de subscripció"
-"Show Terms and Conditions","Mostra els Termes i condicions"
-"Survey Answers","Respostes a l'enquesta"
-"Survey Question","Pregunta d'enquesta"
-"The default country will be set based on location of the customer.","El país per defecte serà configurat en funció de la ubicació del client."
-"There is an error while subscribing for newsletter.","Hi ha un error en subscriure's al butlletí de notícies."
-"To calculate gift wrap fee based on item or order.","Per calcular la quota d'embolcall de regal en funció de l'article o l'ordre."
-"Unable to save order information. Please check input data.","No es pot desar la informació de l'ordre. Comproveu les dades d'entrada."
-"Use Auto Suggestion Technology","Utilitzeu la tecnologia de suggeriment automàtica"
-"When customer fills address fields, it will suggest a list of full addresses.","Quan el client omple els camps d'adreça, us suggerirà una llista d'adreces completes."
-"Year/Month/Day","Any / Mes / Dia"
-"You can disable Order Review Section. It is enabled by default.","Podeu desactivar la secció de revisió de comanda. Està habilitat per defecte."
\ No newline at end of file
diff --git a/i18n/cs_CZ.csv b/i18n/cs_CZ.csv
deleted file mode 100644
index cc35894..0000000
--- a/i18n/cs_CZ.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Prosím vyberte --"
-"1 Column","1 sloupec"
-"2 Columns","2 sloupce"
-"3 Columns","3 sloupce"
-"3 Columns With Colspan","3 sloupce s Colspan"
-"Example: .step-title{background-color: #1979c3;}","Příklad: .step-title {barva pozadí: # 1979c3;}"
-"AVAILABLE FIELDS","DOSTUPNÉ POLE"
-"Add","Přidat"
-"Additional Content","Další obsah"
-"Additional Information","dodatečné informace"
-"After Adding a Product Redirect to OneStepCheckout Page","Po přidání přesměrování produktu na stránku OneStepCheckout"
-"All fields have been saved.","Všechna pole byla uložena."
-"Allow Customer Add Other Option","Povolit zákazníkovi přidat další možnost"
-"Allow Guest Checkout","Povolit službu Guest Checkout"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Povolit kontrolu jako host. Host si může vytvořit účet na stránce platby."
-"Allow customer comment in order.","Povolejte komentář zákazníka."
-"Allow customers can billing to a different address from billing address.","Umožněte zákazníkům účtovat na jinou adresu než fakturační adresa."
-"Amount","Množství"
-"Calculate Method","Metoda výpočtu"
-"Can Show Billing Address","Může zobrazit fakturační adresu"
-"Capture+ Key","Zachytit + klíč"
-"Capture+ by PCA Predict","Capture + podle předpovědi PCA"
-"Checked Newsletter by default","Ve výchozím nastavení je zaškrtnuto Newsletter"
-"Checkout Page Layout","Rozložení stránky Pokladna"
-"Could not add gift wrap for this quote","Nelze přidat dárkový zábal pro tuto citaci"
-"Could not remove item from quote","Nelze odebrat položku z nabídky"
-"Could not update item from quote","Nelze aktualizovat položku z nabídky"
-"Custom Css","Vlastní Css"
-"Date Format","Datový formát"
-"Day/Month/Year","Den / měsíc / rok"
-"Days Off","Dny volna"
-"Default","Výchozí nastavení"
-"Default Payment Method","Výchozí způsob platby"
-"Default Shipping Method","Výchozí metoda odeslání"
-"Delivery Time","Čas doručení"
-"Design Configuration","Konfigurace návrhu"
-"Design Style","Styl designu"
-"Display Configuration","Konfigurace zobrazení"
-"Enable Delivery Time","Povolit doručení"
-"Enable Gift Message","Povolit dárkovou zprávu"
-"Enable Gift Wrap","Povolit dárkové balení"
-"Enable One Step Checkout","Povolit poklad na jednom kroku"
-"Enable Social Login On Checkout Page","Povolit sociální přihlášení na stránce Pokladna"
-"Enable Survey","Povolit průzkum"
-"Enter the amount of gift wrap fee.","Zadejte částku poplatku za dárkové balení."
-"Error during save field position.","Chyba při uložení pozice pole."
-"Field Management","Správa polí"
-"Flat","Ploché"
-"General Configuration","Obecná konfigurace"
-"Gift Wrap","Dárek Wrap"
-"Google","Google"
-"Google Api Key","Klíč Google Api"
-"HTML allowed","HTML povoleno"
-"Heading Background Color","Výchozí barva pozadí"
-"Heading Text Color","Barva textu nadpisu"
-"IP Country Lookup","IP Země vyhledávání"
-"In Payment Area","V oblasti plateb"
-"In Review Area","V oblasti recenzí"
-"It will show on success page","Zobrazí se na stránce s úspěchem"
-"Material","Materiál"
-"Month/Day/Year","Měsíc den rok"
-"No","Ne"
-"One Step Checkout","Jednorázový poklad"
-"One Step Checkout Description","Popis kroku pro jeden krok"
-"One Step Checkout Page Title","Jeden krok Pokladna stránky"
-"One step checkout is turned off.","Krok za krokem je vypnutý."
-"Options","Možnosti"
-"Order Comment","Objednejte si komentář"
-"Order Survey","Průzkum objednávek"
-"Per Item","Za položku"
-"Per Order","Na objednávku"
-"Place Order button color","Umístěte barvu tlačítka objednávky"
-"Restrict the auto suggestion for a specific country","Omezit automatický návrh pro určitou zemi"
-"SORTED FIELDS","ROZŠIŘENÉ POLE"
-"Save Position","Uložit pozici"
-"Set default payment method in the checkout process.","Nastavte výchozí způsob platby v procesu platby."
-"Set default shipping method in the checkout process.","Nastavte výchozí způsob odeslání v procesu platby."
-"Show Discount Code Section","Zobrazit sekci Kód slevy"
-"Show Login Link","Zobrazit odkaz pro přihlášení"
-"Show Newsletter Checkbox","Zobrazit Newsletter Checkbox"
-"Show Order Comment","Zobrazit objednávkový komentář"
-"Show Order Review Section","Zobrazit sekci Přehled objednávek"
-"Show Product Thumbnail Image","Zobrazit miniaturu produktu"
-"Show Sign up newsletter selection","Zobrazit možnost Zapsat newsletter"
-"Show Terms and Conditions","Zobrazit smluvní podmínky"
-"Survey Answers","Odpovědi na průzkum"
-"Survey Question","Otázka průzkumu"
-"The default country will be set based on location of the customer.","Výchozí země bude nastavena na základě umístění zákazníka."
-"There is an error while subscribing for newsletter.","Během přihlášení k odběru zpravodaje došlo k chybě."
-"To calculate gift wrap fee based on item or order.","Vypočítat poplatek za dárkový zábal na základě položky nebo objednávky."
-"Unable to save order information. Please check input data.","Nelze uložit informace o objednávce. Zkontrolujte vstupní data."
-"Use Auto Suggestion Technology","Používejte technologii automatických návrhů"
-"When customer fills address fields, it will suggest a list of full addresses.","Když zákazník vyplní pole pro adresy, navrhne seznam úplných adres."
-"Year/Month/Day","Rok / Měsíc / Den"
-"You can disable Order Review Section. It is enabled by default.","Můžete zakázat sekci Ohodnocení objednávek. Je standardně povoleno."
\ No newline at end of file
diff --git a/i18n/da_DK.csv b/i18n/da_DK.csv
deleted file mode 100644
index 684fa8c..0000000
--- a/i18n/da_DK.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Vælg venligst --"
-"1 Column","1 kolonne"
-"2 Columns","2 kolonner"
-"3 Columns","3 kolonner"
-"3 Columns With Colspan","3 kolonner med Colspan"
-"Example: .step-title{background-color: #1979c3;}","Eksempel: .step-titel {baggrundsfarve: # 1979c3;}"
-"AVAILABLE FIELDS","TILGÆNGELIGE OMRÅDER"
-"Add","Tilføje"
-"Additional Content","Yderligere indhold"
-"Additional Information","Yderligere Information"
-"After Adding a Product Redirect to OneStepCheckout Page","Efter tilføjelse af en produkt omdirigering til OneStepCheckout-side"
-"All fields have been saved.","Alle felter er blevet gemt."
-"Allow Customer Add Other Option","Tillad, at kunden tilføjer andet valg"
-"Allow Guest Checkout","Tillad gæstcheck"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Tillad at tjekke som gæst. Gæsten kan oprette en konto i afkrydsningssiden."
-"Allow customer comment in order.","Tillad kundekommentar i rækkefølge."
-"Allow customers can billing to a different address from billing address.","Tillad kunder at fakturere til en anden adresse fra faktureringsadresse."
-"Amount","Beløb"
-"Calculate Method","Beregn metode"
-"Can Show Billing Address","Kan vise faktureringsadresse"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + ved PCA Predict"
-"Checked Newsletter by default","Kontrolleret Nyhedsbrev som standard"
-"Checkout Page Layout","Checkout Side Layout"
-"Could not add gift wrap for this quote","Kunne ikke tilføje gavepakke til dette citat"
-"Could not remove item from quote","Kunne ikke fjerne element fra citat"
-"Could not update item from quote","Kunne ikke opdatere vare fra citat"
-"Custom Css","Brugerdefineret css"
-"Date Format","Datoformat"
-"Day/Month/Year","Dag / Måned / År"
-"Days Off","Fridage"
-"Default","Standard"
-"Default Payment Method","Standard betalingsmetode"
-"Default Shipping Method","Standard forsendelsesmetode"
-"Delivery Time","Leveringstid"
-"Design Configuration","Designkonfiguration"
-"Design Style","Design stil"
-"Display Configuration","Vis konfiguration"
-"Enable Delivery Time","Aktivér leveringstid"
-"Enable Gift Message","Aktivér gavebesked"
-"Enable Gift Wrap","Aktivér gaveindpakning"
-"Enable One Step Checkout","Aktivér One Step Checkout"
-"Enable Social Login On Checkout Page","Aktivér social login på Checkout Page"
-"Enable Survey","Aktivér undersøgelse"
-"Enter the amount of gift wrap fee.","Indtast mængden af ​​gave wrap gebyr."
-"Error during save field position.","Fejl under gemt feltposition."
-"Field Management","Feltforvaltning"
-"Flat","Flad"
-"General Configuration","Generel konfiguration"
-"Gift Wrap","Gavepapir"
-"Google","Google"
-"Google Api Key","Google Api-nøgle"
-"HTML allowed","HTML tilladt"
-"Heading Background Color","Overskrift Baggrundsfarve"
-"Heading Text Color","Overskrift Tekstfarve"
-"IP Country Lookup","IP Land Lookup"
-"In Payment Area","I betalingsområdet"
-"In Review Area","I Review Area"
-"It will show on success page","Det vil vise på succes side"
-"Material","Materiale"
-"Month/Day/Year","Måned / dag / år"
-"No","Ingen"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","One Step Checkout Beskrivelse"
-"One Step Checkout Page Title","One Step Checkout Sidetitel"
-"One step checkout is turned off.","One-Step Checkout er slået fra."
-"Options","Muligheder"
-"Order Comment","Ordre Kommentar"
-"Order Survey","Ordreundersøgelse"
-"Per Item","Pr. Vare"
-"Per Order","Per Ordre"
-"Place Order button color","Placer bestillingsknapfarve"
-"Restrict the auto suggestion for a specific country","Begræns det automatiske forslag til et bestemt land"
-"SORTED FIELDS","SORTEDE OMRÅDER"
-"Save Position","Gem position"
-"Set default payment method in the checkout process.","Indstil standard betalingsmetode i checkout processen."
-"Set default shipping method in the checkout process.","Indstil standard forsendelsesmetode i checkout processen."
-"Show Discount Code Section","Vis rabatkode sektion"
-"Show Login Link","Vis Login Link"
-"Show Newsletter Checkbox","Vis nyhedsbrevets afkrydsningsfelt"
-"Show Order Comment","Vis ordre kommentar"
-"Show Order Review Section","Vis ordreanmeldelsesafsnit"
-"Show Product Thumbnail Image","Vis produkt thumbnail billede"
-"Show Sign up newsletter selection","Vis Tilmeld nyhedsbreve"
-"Show Terms and Conditions","Vis vilkår og betingelser"
-"Survey Answers","Survey Answers"
-"Survey Question","Undersøgelse Spørgsmål"
-"The default country will be set based on location of the customer.","Standardlandet vil blive indstillet ud fra kundens placering."
-"There is an error while subscribing for newsletter.","Der er en fejl, mens du abonnerer på nyhedsbrev."
-"To calculate gift wrap fee based on item or order.","At beregne gavepakning gebyr baseret på vare eller ordre."
-"Unable to save order information. Please check input data.","Kan ikke gemme ordreoplysninger. Kontroller indtastningsdata."
-"Use Auto Suggestion Technology","Brug Auto Suggestion Technology"
-"When customer fills address fields, it will suggest a list of full addresses.","Når kunden udfylder adressefelter, vil den foreslå en liste over fulde adresser."
-"Year/Month/Day","År / Måned / Dag"
-"You can disable Order Review Section. It is enabled by default.","Du kan deaktivere bestillingsoversigt. Det er aktiveret som standard."
\ No newline at end of file
diff --git a/i18n/de_DE.csv b/i18n/de_DE.csv
deleted file mode 100644
index 8a40859..0000000
--- a/i18n/de_DE.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Bitte auswählen --"
-"1 Column","1 säule"
-"2 Columns","2 säulen"
-"3 Columns","3 Spalten"
-"3 Columns With Colspan","3 Spalten mit Colspan"
-"Example: .step-title{background-color: #1979c3;}","Beispiel: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","VERFÜGBARE FELDER"
-"Add","Hinzufügen"
-"Additional Content","Zusätzlicher Inhalt"
-"Additional Information","zusätzliche Information"
-"After Adding a Product Redirect to OneStepCheckout Page","Nach Hinzufügen einer Produktumleitung zur OneStepCheckout-Seite"
-"All fields have been saved.","Alle Felder wurden gespeichert."
-"Allow Customer Add Other Option","Erlauben Sie Kunden, andere Option hinzuzufügen"
-"Allow Guest Checkout","Erlaube Gast Checkout"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Lassen Sie das Auschecken als Gast aus. Der Gast kann in der Kasse ein Konto erstellen."
-"Allow customer comment in order.","Erlaube Kundenkommentar in der Reihenfolge."
-"Allow customers can billing to a different address from billing address.","Ermöglicht es Kunden, eine andere Adresse aus der Rechnungsadresse abzurufen."
-"Amount","Menge"
-"Calculate Method","Berechnungsmethode"
-"Can Show Billing Address","Kann Rechnungsadresse anzeigen"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + von PCA Vorhersage"
-"Checked Newsletter by default","Checked Newsletter standardmäßig"
-"Checkout Page Layout","Checkout Seitenlayout"
-"Could not add gift wrap for this quote","Könnte keine Geschenkverpackung für dieses Zitat hinzufügen"
-"Could not remove item from quote","Konnte das Element nicht aus dem Angebot entfernen"
-"Could not update item from quote","Konnte das Element nicht auszählen"
-"Custom Css","Benutzerdefinierte CSS"
-"Date Format","Datumsformat"
-"Day/Month/Year","Tag Monat Jahr"
-"Days Off","Freie Tage"
-"Default","Standard"
-"Default Payment Method","Standard Zahlungsmethode"
-"Default Shipping Method","Default Versandmethode"
-"Delivery Time","Lieferzeit"
-"Design Configuration","Designkonfiguration"
-"Design Style","Design-Stil"
-"Display Configuration","Anzeige Konfiguration"
-"Enable Delivery Time","Lieferzeit aktivieren"
-"Enable Gift Message","Geschenkmitteilung aktivieren"
-"Enable Gift Wrap","Geschenkpackung aktivieren"
-"Enable One Step Checkout","Aktivieren Sie einen Schritt Checkout"
-"Enable Social Login On Checkout Page","Aktivieren Sie das soziale Login auf der Checkout-Seite"
-"Enable Survey","Ermöglichen Sie die Umfrage"
-"Enter the amount of gift wrap fee.","Geben Sie die Menge der Geschenkverpackung ein."
-"Error during save field position.","Fehler beim Speichern der Feldposition."
-"Field Management","Feldmanagement"
-"Flat","Wohnung"
-"General Configuration","Allgemeine Konfiguration"
-"Gift Wrap","Geschenkpapier"
-"Google","Google"
-"Google Api Key","Google Api Schlüssel"
-"HTML allowed","HTML erlaubt"
-"Heading Background Color","Überschrift Hintergrundfarbe"
-"Heading Text Color","Überschrift Textfarbe"
-"IP Country Lookup","IP Country Lookup"
-"In Payment Area","Im Zahlungsbereich"
-"In Review Area","Im Berichtsbereich"
-"It will show on success page","Es wird auf der Erfolgseite zeigen"
-"Material","Material"
-"Month/Day/Year","Monat Tag Jahr"
-"No","Nein"
-"One Step Checkout","Ein Schritt Checkout"
-"One Step Checkout Description","One Step Checkout Beschreibung"
-"One Step Checkout Page Title","One Step Checkout Seitentitel"
-"One step checkout is turned off.","Ein Schritt Checkout ist ausgeschaltet."
-"Options","Optionen"
-"Order Comment","Bemerkung bestellen"
-"Order Survey","Auftragsbefragung"
-"Per Item","Pro Stück"
-"Per Order","Pro Auftrag"
-"Place Order button color","Platzieren Sie die Schaltfläche Farbe"
-"Restrict the auto suggestion for a specific country","Beschränken Sie den automatischen Vorschlag für ein bestimmtes Land"
-"SORTED FIELDS","SORTIERTE FELDER"
-"Save Position","Sichere Lage"
-"Set default payment method in the checkout process.","Setzen Sie die Zahlungsmethode in der Kasse ein."
-"Set default shipping method in the checkout process.","Setzen Sie die Standard-Versandmethode in den Kassenvorgang."
-"Show Discount Code Section","Show Discount Code Abschnitt"
-"Show Login Link","Show Login Link"
-"Show Newsletter Checkbox","Newsletter anzeigen Checkbox"
-"Show Order Comment","Zeigen Sie den Kommentar"
-"Show Order Review Section","Bestellen"
-"Show Product Thumbnail Image","Produkt anzeigen Thumbnail Image"
-"Show Sign up newsletter selection","Show Newsletter abonnieren"
-"Show Terms and Conditions","Allgemeine Geschäftsbedingungen anzeigen"
-"Survey Answers","Umfrage Antworten"
-"Survey Question","Umfrage Frage"
-"The default country will be set based on location of the customer.","Das Standardland wird auf der Grundlage des Standortes des Kunden festgelegt."
-"There is an error while subscribing for newsletter.","Es gibt einen Fehler beim Abonnieren des Newsletters."
-"To calculate gift wrap fee based on item or order.","Um die Geschenkverpackungsgebühr auf der Grundlage des Artikels oder der Bestellung zu berechnen."
-"Unable to save order information. Please check input data.","Die Bestellinformationen können nicht gespeichert werden. Bitte überprüfen Sie die Eingabedaten."
-"Use Auto Suggestion Technology","Verwenden Sie Auto Suggestion Technology"
-"When customer fills address fields, it will suggest a list of full addresses.","Wenn der Kunde die Adressfelder ausfüllt, wird eine Liste der vollständigen Adressen angezeigt."
-"Year/Month/Day","Jahr Monat Tag"
-"You can disable Order Review Section. It is enabled by default.","Sie können den Abschnitt ""Bestellen"" deaktivieren. Sie ist standardmäßig aktiviert."
\ No newline at end of file
diff --git a/i18n/el_GR.csv b/i18n/el_GR.csv
deleted file mode 100644
index bdb23a0..0000000
--- a/i18n/el_GR.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Παρακαλώ επιλέξτε --"
-"1 Column","1 Στήλη"
-"2 Columns","2 Στήλες"
-"3 Columns","3 Στήλες"
-"3 Columns With Colspan","3 στήλες με Colspan"
-"Example: .step-title{background-color: #1979c3;}","Παράδειγμα: .step-title {χρώμα-φόντο: # 1979c3;}"
-"AVAILABLE FIELDS","ΔΙΑΘΕΣΙΜΑ ΠΕΔΙΑ"
-"Add","Προσθέτω"
-"Additional Content","Πρόσθετο περιεχόμενο"
-"Additional Information","Επιπλέον πληροφορίες"
-"After Adding a Product Redirect to OneStepCheckout Page","Μετά την προσθήκη ανακατεύθυνσης προϊόντος στη σελίδα OneStepCheckout"
-"All fields have been saved.","Όλα τα πεδία έχουν αποθηκευτεί."
-"Allow Customer Add Other Option","Επιτρέψτε στον Πελάτη να προσθέσει άλλη επιλογή"
-"Allow Guest Checkout","Να επιτρέπεται ο έλεγχος επισκέπτη"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Επιτρέψτε τον έλεγχο ως επισκέπτης. Ο επισκέπτης μπορεί να δημιουργήσει έναν λογαριασμό στη σελίδα πληρωμής."
-"Allow customer comment in order.","Αφήστε το σχόλιο του πελάτη στη σειρά."
-"Allow customers can billing to a different address from billing address.","Επιτρέψτε στους πελάτες τη δυνατότητα χρέωσης σε διαφορετική διεύθυνση από τη διεύθυνση χρέωσης."
-"Amount","Ποσό"
-"Calculate Method","Υπολογισμός μεθόδου"
-"Can Show Billing Address","Μπορεί να εμφανίσει τη διεύθυνση χρέωσης"
-"Capture+ Key","Σύλληψη + κλειδί"
-"Capture+ by PCA Predict","Capture + by PCA Predict"
-"Checked Newsletter by default","Ελεγμένο ενημερωτικό δελτίο από προεπιλογή"
-"Checkout Page Layout","Έλεγχος σελίδας"
-"Could not add gift wrap for this quote","Δεν ήταν δυνατή η προσθήκη περιτύλιξης δώρου για αυτό το απόσπασμα"
-"Could not remove item from quote","Δεν ήταν δυνατή η κατάργηση στοιχείου από την προσφορά"
-"Could not update item from quote","Δεν ήταν δυνατή η ενημέρωση του στοιχείου από την προσφορά"
-"Custom Css","Προσαρμοσμένο Css"
-"Date Format","Μορφή ημερομηνίας"
-"Day/Month/Year","ΗΜΕΡΑ ΜΗΝΑΣ ΕΤΟΣ"
-"Days Off","Ρεπό"
-"Default","Προκαθορισμένο"
-"Default Payment Method","Προεπιλεγμένη μέθοδος πληρωμής"
-"Default Shipping Method","Προεπιλεγμένη μέθοδος αποστολής"
-"Delivery Time","Ωρα παράδοσης"
-"Design Configuration","Διαμόρφωση σχεδιασμού"
-"Design Style","Στυλ σχεδίασης"
-"Display Configuration","Εμφάνιση διαμόρφωσης"
-"Enable Delivery Time","Ενεργοποίηση χρόνου παράδοσης"
-"Enable Gift Message","Ενεργοποίηση μηνυμάτων δώρων"
-"Enable Gift Wrap","Ενεργοποιήστε το περιτύλιγμα δώρων"
-"Enable One Step Checkout","Ενεργοποιήστε τον έλεγχο ενός βήματος"
-"Enable Social Login On Checkout Page","Ενεργοποίηση σύνδεσης κοινωνικής δικτύωσης στη σελίδα ελέγχου"
-"Enable Survey","Ενεργοποιήστε την Έρευνα"
-"Enter the amount of gift wrap fee.","Καταχωρίστε το ποσό της αμοιβής συσκευασίας δώρου."
-"Error during save field position.","Σφάλμα κατά την αποθήκευση θέσης πεδίου."
-"Field Management","Διαχείριση πεδίου"
-"Flat","Διαμέρισμα"
-"General Configuration","Γενική διαμόρφωση"
-"Gift Wrap","Χαρτί περιτυλίγματος"
-"Google","Google"
-"Google Api Key","Κλειδί Google Api"
-"HTML allowed","Το HTML επιτρέπεται"
-"Heading Background Color","Κεφαλίδα Χρώμα φόντου"
-"Heading Text Color","Κεφάλαιο Χρώμα κειμένου"
-"IP Country Lookup","Αναζήτηση χώρας IP"
-"In Payment Area","Στην περιοχή πληρωμής"
-"In Review Area","Στην Περιοχή Ανασκόπησης"
-"It will show on success page","Θα εμφανιστεί στη σελίδα επιτυχίας"
-"Material","Υλικό"
-"Month/Day/Year","Μηνας μερα χρονος"
-"No","Οχι"
-"One Step Checkout","Έλεγχος ενός βήματος"
-"One Step Checkout Description","Περιγραφή βηματοδότησης ενός βήματος"
-"One Step Checkout Page Title","Τίτλος σελίδας ενός τίτλου ελέγχου"
-"One step checkout is turned off.","Ένας σταθμός ελέγχου είναι απενεργοποιημένος."
-"Options","Επιλογές"
-"Order Comment","Παραγγελία Σχόλιο"
-"Order Survey","Έρευνα Παραγγελίας"
-"Per Item","Ανά αντικείμενο"
-"Per Order","Ανά παραγγελία"
-"Place Order button color","Τοποθετήστε χρώμα κουμπιού παραγγελίας"
-"Restrict the auto suggestion for a specific country","Περιορίστε την αυτόματη πρόταση για μια συγκεκριμένη χώρα"
-"SORTED FIELDS","ΠΕΔΙΑΚΑ ΠΕΔΙΑ"
-"Save Position","Αποθήκευση θέσης"
-"Set default payment method in the checkout process.","Ορίστε την προεπιλεγμένη μέθοδο πληρωμής στη διαδικασία πληρωμής."
-"Set default shipping method in the checkout process.","Ορίστε την προεπιλεγμένη μέθοδο αποστολής στη διαδικασία πληρωμής."
-"Show Discount Code Section","Εμφάνιση της ενότητας ""Κωδικός έκπτωσης"""
-"Show Login Link","Εμφάνιση σύνδεσμου σύνδεσης"
-"Show Newsletter Checkbox","Εμφάνιση κουτιού ελέγχου ενημερωτικών δελτίων"
-"Show Order Comment","Εμφάνιση σχολίου παραγγελίας"
-"Show Order Review Section","Εμφάνιση ενότητας αναθεώρησης παραγγελίας"
-"Show Product Thumbnail Image","Εμφάνιση μικρογραφίας εικόνας προϊόντος"
-"Show Sign up newsletter selection","Εμφανίστε την επιλογή Εγγραφή επιλογής ενημερωτικού δελτίου"
-"Show Terms and Conditions","Εμφάνιση Όρων και Προϋποθέσεων"
-"Survey Answers","Απαντήσεις Έρευνας"
-"Survey Question","Ερώτηση για έρευνα"
-"The default country will be set based on location of the customer.","Η προεπιλεγμένη χώρα θα οριστεί βάσει της θέσης του πελάτη."
-"There is an error while subscribing for newsletter.","Παρουσιάζεται σφάλμα κατά την εγγραφή σε ενημερωτικό δελτίο."
-"To calculate gift wrap fee based on item or order.","Για να υπολογίσετε το τέλος συσκευασίας δώρου βάσει στοιχείου ή παραγγελίας."
-"Unable to save order information. Please check input data.","Δεν είναι δυνατή η αποθήκευση πληροφοριών παραγγελιών. Ελέγξτε τα δεδομένα εισόδου."
-"Use Auto Suggestion Technology","Χρησιμοποιήστε την τεχνολογία αυτόματης προσφοράς"
-"When customer fills address fields, it will suggest a list of full addresses.","Όταν ο πελάτης γεμίσει πεδία διευθύνσεων, θα προτείνει μια λίστα πλήρων διευθύνσεων."
-"Year/Month/Day","Έτος / Μήνας / Ημέρα"
-"You can disable Order Review Section. It is enabled by default.","Μπορείτε να απενεργοποιήσετε την Ενότητα αναθεώρησης παραγγελιών. Είναι ενεργοποιημένη από προεπιλογή."
\ No newline at end of file
diff --git a/i18n/en_US.csv b/i18n/en_US.csv
index ffc8939..6416250 100644
--- a/i18n/en_US.csv
+++ b/i18n/en_US.csv
@@ -3,82 +3,63 @@
 "2 Columns","2 Columns"
 "3 Columns","3 Columns"
 "3 Columns With Colspan","3 Columns With Colspan"
-"Example: .step-title{background-color: #1979c3;}","Example: .step-title{background-color: #1979c3;}"
-"AVAILABLE FIELDS","AVAILABLE FIELDS"
-"Add","Add"
 "Additional Content","Additional Content"
 "Additional Information","Additional Information"
-"After Adding a Product Redirect to OneStepCheckout Page","After Adding a Product Redirect to OneStepCheckout Page"
-"All fields have been saved.","All fields have been saved."
-"Allow Customer Add Other Option","Allow Customer Add Other Option"
 "Allow Guest Checkout","Allow Guest Checkout"
 "Allow checking out as a guest. Guest can create an account in the checkout page.","Allow checking out as a guest. Guest can create an account in the checkout page."
 "Allow customer comment in order.","Allow customer comment in order."
 "Allow customers can billing to a different address from billing address.","Allow customers can billing to a different address from billing address."
-"Amount","Amount"
-"Calculate Method","Calculate Method"
+"Black","Black"
+"Blue","Blue"
 "Can Show Billing Address","Can Show Billing Address"
+"Capture+","Capture+"
 "Capture+ Key","Capture+ Key"
 "Capture+ by PCA Predict","Capture+ by PCA Predict"
 "Checked Newsletter by default","Checked Newsletter by default"
 "Checkout Page Layout","Checkout Page Layout"
-"Could not add gift wrap for this quote","Could not add gift wrap for this quote"
+"City","City"
 "Could not remove item from quote","Could not remove item from quote"
 "Could not update item from quote","Could not update item from quote"
-"Custom Css","Custom Css"
-"Date Format","Date Format"
-"Day/Month/Year","Day/Month/Year"
-"Days Off","Days Off"
+"Country Id","Country Id"
+"Custom","Custom"
+"Custom Heading Background Color","Custom Heading Background Color"
+"Dark Blue","Dark Blue"
 "Default","Default"
 "Default Payment Method","Default Payment Method"
 "Default Shipping Method","Default Shipping Method"
-"Delivery Time","Delivery Time"
 "Design Configuration","Design Configuration"
-"Design Style","Design Style"
+"Discount Code Section","Discount Code Section"
 "Display Configuration","Display Configuration"
-"Enable Delivery Time","Enable Delivery Time"
-"Enable Gift Message","Enable Gift Message"
-"Enable Gift Wrap","Enable Gift Wrap"
 "Enable One Step Checkout","Enable One Step Checkout"
-"Enable Social Login On Checkout Page","Enable Social Login On Checkout Page"
-"Enable Survey","Enable Survey"
-"Enter the amount of gift wrap fee.","Enter the amount of gift wrap fee."
-"Error during save field position.","Error during save field position."
-"Field Management","Field Management"
-"Flat","Flat"
+"Enable Terms and Conditions","Enable Terms and Conditions"
 "General Configuration","General Configuration"
-"Gift Wrap","Gift Wrap"
 "Google","Google"
 "Google Api Key","Google Api Key"
+"Green","Green"
 "HTML allowed","HTML allowed"
 "Heading Background Color","Heading Background Color"
+"Heading Style","Heading Style"
 "Heading Text Color","Heading Text Color"
 "IP Country Lookup","IP Country Lookup"
-"In Payment Area","In Payment Area"
-"In Review Area","In Review Area"
-"It will show on success page","It will show on success page"
-"Material","Material"
-"Month/Day/Year","Month/Day/Year"
+"Newsletter Checkbox","Newsletter Checkbox"
 "No","No"
 "One Step Checkout","One Step Checkout"
 "One Step Checkout Description","One Step Checkout Description"
 "One Step Checkout Page Title","One Step Checkout Page Title"
 "One step checkout is turned off.","One step checkout is turned off."
-"Options","Options"
+"Orange","Orange"
 "Order Comment","Order Comment"
-"Order Survey","Order Survey"
-"Per Item","Per Item"
-"Per Order","Per Order"
+"Pink","Pink"
 "Place Order button color","Place Order button color"
+"Postcode","Postcode"
+"Red","Red"
+"Region ","Region "
+"Region Id","Region Id"
 "Restrict the auto suggestion for a specific country","Restrict the auto suggestion for a specific country"
-"SORTED FIELDS","SORTED FIELDS"
-"Save Position","Save Position"
 "Set default payment method in the checkout process.","Set default payment method in the checkout process."
 "Set default shipping method in the checkout process.","Set default shipping method in the checkout process."
-"Show Discount Code Section","Show Discount Code Section"
+"Show Discount Code box in Checkout page.","Show Discount Code box in Checkout page."
 "Show Login Link","Show Login Link"
-"Show Newsletter Checkbox","Show Newsletter Checkbox"
-"Show Order Comment","Show Order Comment"
 "Show Order Review Section","Show Order Review Section"
 "Show Product Thumbnail Image","Show Product Thumbnail Image"
 "Show Sign up newsletter selection","Show Sign up newsletter selection"
@@ -90,10 +71,7 @@
 "Style 2","Style 2"
 "Style 3","Style 3"
 "The default country will be set based on location of the customer.","The default country will be set based on location of the customer."
-"There is an error while subscribing for newsletter.","There is an error while subscribing for newsletter."
-"To calculate gift wrap fee based on item or order.","To calculate gift wrap fee based on item or order."
-"Unable to save order information. Please check input data.","Unable to save order information. Please check input data."
 "Use Auto Suggestion Technology","Use Auto Suggestion Technology"
+"Violet","Violet"
 "When customer fills address fields, it will suggest a list of full addresses.","When customer fills address fields, it will suggest a list of full addresses."
-"Year/Month/Day","Year/Month/Day"
 "You can disable Order Review Section. It is enabled by default.","You can disable Order Review Section. It is enabled by default."
diff --git a/i18n/es_ES.csv b/i18n/es_ES.csv
deleted file mode 100644
index 70aa98f..0000000
--- a/i18n/es_ES.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","- Por favor seleccione -"
-"1 Column","1 columna"
-"2 Columns","2 columnas"
-"3 Columns","3 columnas"
-"3 Columns With Colspan","3 Columnas con Colspan"
-"Example: .step-title{background-color: #1979c3;}","Ejemplo: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","CAMPOS DISPONIBLES"
-"Add","Añadir"
-"Additional Content","Contenido adicional"
-"Additional Information","Información Adicional"
-"After Adding a Product Redirect to OneStepCheckout Page","Después de agregar una página Redireccionar producto a OneStepCheckout"
-"All fields have been saved.","Todos los campos se han guardado."
-"Allow Customer Add Other Option","Permitir que el cliente añada otra opción"
-"Allow Guest Checkout","Permitir la salida del cliente"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Permitir la salida como un invitado. El invitado puede crear una cuenta en la página de pago."
-"Allow customer comment in order.","Permitir comentarios del cliente en orden."
-"Allow customers can billing to a different address from billing address.","Permitir que los clientes puedan facturar a una dirección diferente de la dirección de facturación."
-"Amount","Cantidad"
-"Calculate Method","Calcular el método"
-"Can Show Billing Address","Puede mostrar la dirección de facturación"
-"Capture+ Key","Captura + tecla"
-"Capture+ by PCA Predict","Captura + por PCA Predict"
-"Checked Newsletter by default","Boletín revisado por defecto"
-"Checkout Page Layout","Disposición de Pagina de Pagos"
-"Could not add gift wrap for this quote","No se pudo agregar envoltura de regalo para esta cotización"
-"Could not remove item from quote","No se pudo eliminar el elemento de la cotización"
-"Could not update item from quote","No se pudo actualizar el elemento de la cita"
-"Custom Css","CSS personalizado"
-"Date Format","Formato de fecha"
-"Day/Month/Year","Día mes año"
-"Days Off","Días de descanso"
-"Default","Defecto"
-"Default Payment Method","método de pago por defecto"
-"Default Shipping Method","Método de envío predeterminado"
-"Delivery Time","El tiempo de entrega"
-"Design Configuration","Configuración del diseño"
-"Design Style","Estilo de diseño"
-"Display Configuration","Configuración de la pantalla"
-"Enable Delivery Time","Habilitar plazo de entrega"
-"Enable Gift Message","Habilitar mensaje de regalo"
-"Enable Gift Wrap","Habilitar envoltura de regalo"
-"Enable One Step Checkout","Habilitar la compra de un paso"
-"Enable Social Login On Checkout Page","Habilitar inicio de sesión social en la página de compra"
-"Enable Survey","Habilitar encuesta"
-"Enter the amount of gift wrap fee.","Ingrese la cantidad de la tasa de envoltura de regalo."
-"Error during save field position.","Error al guardar la posición del campo."
-"Field Management","Gestión del campo"
-"Flat","Plano"
-"General Configuration","Configuración general"
-"Gift Wrap","Papel de regalo"
-"Google","Google"
-"Google Api Key","Llave Api de Google"
-"HTML allowed","HTML permitido"
-"Heading Background Color","Color del fondo del título"
-"Heading Text Color","Título del texto"
-"IP Country Lookup","Búsqueda por país IP"
-"In Payment Area","En el área de pago"
-"In Review Area","En el área de revisión"
-"It will show on success page","Se mostrará en la página de éxito"
-"Material","Material"
-"Month/Day/Year","Mes día año"
-"No","No"
-"One Step Checkout","Un paso de pago"
-"One Step Checkout Description","One Step Checkout Descripción"
-"One Step Checkout Page Title","Título de la página"
-"One step checkout is turned off.","Se desactiva la comprobación de un paso."
-"Options","Opciones"
-"Order Comment","Comentario del pedido"
-"Order Survey","Encuesta de pedidos"
-"Per Item","Por artículo"
-"Per Order","Por orden"
-"Place Order button color","Colocar el color del botón de pedido"
-"Restrict the auto suggestion for a specific country","Restringir la sugerencia automática para un país específico"
-"SORTED FIELDS","CAMPOS CLASIFICADOS"
-"Save Position","Guardar posicion"
-"Set default payment method in the checkout process.","Establecer el método de pago predeterminado en el proceso de pago."
-"Set default shipping method in the checkout process.","Establezca el método de envío predeterminado en el proceso de pago."
-"Show Discount Code Section","Mostrar código de descuento"
-"Show Login Link","Mostrar enlace de conexión"
-"Show Newsletter Checkbox","Mostrar Boletín de Boletín"
-"Show Order Comment","Mostrar comentario del pedido"
-"Show Order Review Section","Mostrar sección de revisión de pedido"
-"Show Product Thumbnail Image","Mostrar imagen en miniatura del producto"
-"Show Sign up newsletter selection","Mostrar la selección del boletín de noticias"
-"Show Terms and Conditions","Mostrar Términos y Condiciones"
-"Survey Answers","Respuestas a la encuesta"
-"Survey Question","Pregunta de encuesta"
-"The default country will be set based on location of the customer.","El país predeterminado se establecerá en función de la ubicación del cliente."
-"There is an error while subscribing for newsletter.","Hay un error al suscribirse al boletín."
-"To calculate gift wrap fee based on item or order.","Para calcular la tarifa de envoltura de regalo basada en artículo u orden."
-"Unable to save order information. Please check input data.","No se puede guardar la información del pedido. Compruebe los datos de entrada."
-"Use Auto Suggestion Technology","Utilice la tecnología de sugerencia automática"
-"When customer fills address fields, it will suggest a list of full addresses.","Cuando el cliente rellena los campos de dirección, sugerirá una lista de direcciones completas."
-"Year/Month/Day","Año mes dia"
-"You can disable Order Review Section. It is enabled by default.","Puede desactivar la sección de revisión de pedidos. Está habilitado de forma predeterminada."
\ No newline at end of file
diff --git a/i18n/fi_FI.csv b/i18n/fi_FI.csv
deleted file mode 100644
index c3125f8..0000000
--- a/i18n/fi_FI.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Ole hyvä ja valitse --"
-"1 Column","1 sarake"
-"2 Columns","2 saraketta"
-"3 Columns","3 saraketta"
-"3 Columns With Colspan","3 saraketta Colspannalla"
-"Example: .step-title{background-color: #1979c3;}","Esimerkki: .step-title {taustaväri: # 1979c3;}"
-"AVAILABLE FIELDS","SAATAVAT KENTTÄ"
-"Add","Lisätä"
-"Additional Content","Lisäsisältö"
-"Additional Information","lisäinformaatio"
-"After Adding a Product Redirect to OneStepCheckout Page","Tuotteen uudelleenohjauksen lisääminen OneStepCheckout-sivulle"
-"All fields have been saved.","Kaikki kentät on tallennettu."
-"Allow Customer Add Other Option","Salli asiakkaan lisätä muita vaihtoehtoja"
-"Allow Guest Checkout","Salli Guest Checkout"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Salli vierailla vierailla. Vieras voi luoda tilin Kassalle -sivulla."
-"Allow customer comment in order.","Salli asiakkaan kommentti järjestyksessä."
-"Allow customers can billing to a different address from billing address.","Salli asiakkaat voivat laskuttaa eri osoitteeseen laskutusosoitteesta."
-"Amount","Määrä"
-"Calculate Method","Laske menetelmä"
-"Can Show Billing Address","Voit näyttää laskutusosoitteen"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + PCA: n ennustuksella"
-"Checked Newsletter by default","Oletuksena on tarkistettu uutiskirje"
-"Checkout Page Layout","Checkout-sivun asettelu"
-"Could not add gift wrap for this quote","Tätä tarjousta ei voitu lisätä lahjapakkaukseen"
-"Could not remove item from quote","Kohdetta ei voitu nostaa lainaan"
-"Could not update item from quote","Päivitystä ei voitu päivittää lainaan"
-"Custom Css","Custom Css"
-"Date Format","Päivämäärämuoto"
-"Day/Month/Year","Päivä kuukausi vuosi"
-"Days Off","Päivät pois"
-"Default","oletusarvo"
-"Default Payment Method","Oletusmaksutapa"
-"Default Shipping Method","Oletuslähetysmenetelmä"
-"Delivery Time","Toimitusaika"
-"Design Configuration","Suunnittelun kokoonpano"
-"Design Style","Design tyyli"
-"Display Configuration","Näytön kokoonpano"
-"Enable Delivery Time","Ota käyttöön toimitusaika"
-"Enable Gift Message","Ota lahjoitusviesti käyttöön"
-"Enable Gift Wrap","Ota lahjapakkaus käyttöön"
-"Enable One Step Checkout","Ota One Step Checkout käyttöön"
-"Enable Social Login On Checkout Page","Salli sosiaalinen kirjautuminen Checkout-sivulla"
-"Enable Survey","Ota kysely käyttöön"
-"Enter the amount of gift wrap fee.","Anna lahjapaperimaksun määrä."
-"Error during save field position.","Virhe tallennuskenttän aikana."
-"Field Management","Kenttähallinta"
-"Flat","tasainen"
-"General Configuration","Yleinen määritys"
-"Gift Wrap","Lahjapaperia"
-"Google","Google"
-"Google Api Key","Google Api -avain"
-"HTML allowed","HTML sallittu"
-"Heading Background Color","Otsikon taustaväri"
-"Heading Text Color","Tekstin otsikon väri"
-"IP Country Lookup","IP-maan haku"
-"In Payment Area","Maksualueella"
-"In Review Area","Tarkastelualueella"
-"It will show on success page","Se näkyy menestyssivulla"
-"Material","materiaali"
-"Month/Day/Year","Kuukausi päivä Vuosi"
-"No","Ei"
-"One Step Checkout","Yhden vaiheen kassalle"
-"One Step Checkout Description","One Step Checkout Kuvaus"
-"One Step Checkout Page Title","One Step Checkout -sivun otsikko"
-"One step checkout is turned off.","Yksiportainen kassalle on katkaistu virta."
-"Options","vaihtoehdot"
-"Order Comment","Tilaa kommentti"
-"Order Survey","Tilaustutkimus"
-"Per Item","Per tuote"
-"Per Order","Tilauksesta"
-"Place Order button color","Paikkamääräpainikkeen väri"
-"Restrict the auto suggestion for a specific country","Rajoita tietyn maan automaattinen ehdotus"
-"SORTED FIELDS","LAAJUITETUT ALUEET"
-"Save Position","Tallenna sijainti"
-"Set default payment method in the checkout process.","Aseta oletusmaksutapa kassaprosessissa."
-"Set default shipping method in the checkout process.","Aseta oletuslähetystapa kassaprosessissa."
-"Show Discount Code Section","Näytä alennuksen koodi"
-"Show Login Link","Näytä kirjautuminen"
-"Show Newsletter Checkbox","Näytä uutiskirje Checkbox"
-"Show Order Comment","Näytä tilauksen kommentti"
-"Show Order Review Section","Näytä tilauksen tarkistusosiota"
-"Show Product Thumbnail Image","Näytä tuotenäkymän kuva"
-"Show Sign up newsletter selection","Näytä Ilmoittautuminen uutiskirjeen valintaan"
-"Show Terms and Conditions","Näytä ehdot ja edellytykset"
-"Survey Answers","Survey Answers"
-"Survey Question","Kyselytutkimus"
-"The default country will be set based on location of the customer.","Oletusmaa määritetään asiakkaan sijainnin mukaan."
-"There is an error while subscribing for newsletter.","Ilmoittautumisen yhteydessä on virhe."
-"To calculate gift wrap fee based on item or order.","Voit laskea lahjapakkauspalkkion kohteen tai tilauksen perusteella."
-"Unable to save order information. Please check input data.","Tilaustietoja ei voi tallentaa. Tarkista syöttötiedot."
-"Use Auto Suggestion Technology","Käytä automaattista ehdotustekniikkaa"
-"When customer fills address fields, it will suggest a list of full addresses.","Kun asiakas täyttää osoiterivit, se ehdottaa luetteloa täydellisistä osoitteista."
-"Year/Month/Day","Vuosi / kuukausi / päivä"
-"You can disable Order Review Section. It is enabled by default.","Voit poistaa tilauksen tarkistuskappaleen käytöstä. Se on otettu käyttöön oletuksena."
\ No newline at end of file
diff --git a/i18n/fr_FR.csv b/i18n/fr_FR.csv
deleted file mode 100644
index 04afd4e..0000000
--- a/i18n/fr_FR.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","- Veuillez sélectionner -"
-"1 Column","1 colonne"
-"2 Columns","2 colonnes"
-"3 Columns","3 colonnes"
-"3 Columns With Colspan","3 colonnes avec colspan"
-"Example: .step-title{background-color: #1979c3;}","Exemple: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","DOMAINES DISPONIBLES"
-"Add","Ajouter"
-"Additional Content","Contenu additionnel"
-"Additional Information","Information additionnelle"
-"After Adding a Product Redirect to OneStepCheckout Page","Après avoir ajouté une redirection de produit à la page OneStepCheckout"
-"All fields have been saved.","Tous les champs ont été enregistrés."
-"Allow Customer Add Other Option","Autoriser le client à ajouter une autre option"
-"Allow Guest Checkout","Autoriser le paiement des clients"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Autoriser la visite en tant qu'invité. L'invité peut créer un compte dans la page de caisse."
-"Allow customer comment in order.","Autoriser les commentaires des clients dans l'ordre."
-"Allow customers can billing to a different address from billing address.","Permettre aux clients de facturer à une adresse différente de l'adresse de facturation."
-"Amount","Montant"
-"Calculate Method","Calculer la méthode"
-"Can Show Billing Address","Peut afficher l'adresse de facturation"
-"Capture+ Key","Capture + clé"
-"Capture+ by PCA Predict","Capture + par PCA Predict"
-"Checked Newsletter by default","Bulletin par défaut par défaut"
-"Checkout Page Layout","Checkout Page Layout"
-"Could not add gift wrap for this quote","Impossible d'ajouter une enveloppe cadeau pour cette citation"
-"Could not remove item from quote","Impossible de supprimer l'élément de la citation"
-"Could not update item from quote","Impossible de mettre à jour l'élément de la citation"
-"Custom Css","CSS personnalisé"
-"Date Format","Format de date"
-"Day/Month/Year","Jour mois année"
-"Days Off","Jours de congés"
-"Default","Défaut"
-"Default Payment Method","Méthode de paiement par défaut"
-"Default Shipping Method","Méthode d'expédition par défaut"
-"Delivery Time","Heure de livraison"
-"Design Configuration","Configuration de conception"
-"Design Style","Style de conception"
-"Display Configuration","Configuration de l'affichage"
-"Enable Delivery Time","Activer le délai de livraison"
-"Enable Gift Message","Activer le message cadeau"
-"Enable Gift Wrap","Enable Gift Wrap"
-"Enable One Step Checkout","Activer le paiement en une étape"
-"Enable Social Login On Checkout Page","Activer la connexion sociale à la page de contrôle"
-"Enable Survey","Enable Survey"
-"Enter the amount of gift wrap fee.","Entrez le montant des frais d'emballage de cadeaux."
-"Error during save field position.","Erreur lors de la sauvegarde du champ."
-"Field Management","Gestion de terrain"
-"Flat","Appartement"
-"General Configuration","Configuration générale"
-"Gift Wrap","Papier cadeau"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTML autorisé"
-"Heading Background Color","Couleur de fond"
-"Heading Text Color","Titre de la couleur du texte"
-"IP Country Lookup","IP Country Lookup"
-"In Payment Area","Dans la zone de paiement"
-"In Review Area","Dans la zone de révision"
-"It will show on success page","Il apparaîtra sur la page de succès"
-"Material","Matériel"
-"Month/Day/Year","Année mois jour"
-"No","Non"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","Description d'une étape de caisse"
-"One Step Checkout Page Title","Titre de la page d'une étape"
-"One step checkout is turned off.","Le paiement en une étape est désactivé."
-"Options","Options"
-"Order Comment","Commande Commentaire"
-"Order Survey","Enquête sur les commandes"
-"Per Item","Par objet"
-"Per Order","Par ordre"
-"Place Order button color","Couleur du bouton Commander"
-"Restrict the auto suggestion for a specific country","Limiter la suggestion automatique pour un pays spécifique"
-"SORTED FIELDS","DOMAINES SORTÉS"
-"Save Position","Sauvegarder la position"
-"Set default payment method in the checkout process.","Définissez le mode de paiement par défaut dans le processus de caisse."
-"Set default shipping method in the checkout process.","Définissez la méthode d'expédition par défaut dans le processus de caisse."
-"Show Discount Code Section","Afficher la section Code de réduction"
-"Show Login Link","Afficher le lien de connexion"
-"Show Newsletter Checkbox","Afficher la boîte aux lettres Checkbox"
-"Show Order Comment","Afficher le commentaire de la commande"
-"Show Order Review Section","Afficher la section de revue de commande"
-"Show Product Thumbnail Image","Afficher l'image miniature du produit"
-"Show Sign up newsletter selection","Sélection du bulletin Inscrivez-vous"
-"Show Terms and Conditions","Afficher les termes et conditions"
-"Survey Answers","Réponses du sondage"
-"Survey Question","Question d'enquête"
-"The default country will be set based on location of the customer.","Le pays par défaut sera défini en fonction de l'emplacement du client."
-"There is an error while subscribing for newsletter.","Il y a une erreur lors de l'abonnement à la newsletter."
-"To calculate gift wrap fee based on item or order.","Pour calculer les frais d'emballage de cadeaux en fonction de l'article ou de l'ordre."
-"Unable to save order information. Please check input data.","Impossible de sauvegarder les informations de commande. Vérifiez les données d'entrée."
-"Use Auto Suggestion Technology","Utiliser la technologie de suggestion automatique"
-"When customer fills address fields, it will suggest a list of full addresses.","Lorsque le client remplit les champs d'adresse, il proposera une liste d'adresses complètes."
-"Year/Month/Day","Année mois jour"
-"You can disable Order Review Section. It is enabled by default.","Vous pouvez désactiver la section Examen des commandes. Il est activé par défaut."
\ No newline at end of file
diff --git a/i18n/he_IL.csv b/i18n/he_IL.csv
deleted file mode 100644
index eecdb88..0000000
--- a/i18n/he_IL.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- בבקשה תבחר --"
-"1 Column","עמודה אחת"
-"2 Columns","2 עמודות"
-"3 Columns","3 עמודות"
-"3 Columns With Colspan","3 עמודות עם Colspan"
-"Example: .step-title{background-color: #1979c3;}","דוגמה: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","שדות זמינים"
-"Add","לְהוֹסִיף"
-"Additional Content","תוכן נוסף"
-"Additional Information","מידע נוסף"
-"After Adding a Product Redirect to OneStepCheckout Page","לאחר הוספת הפניה למוצר לדף OneStepCheckout"
-"All fields have been saved.","כל השדות נשמרו."
-"Allow Customer Add Other Option","אפשר ללקוח להוסיף אפשרות אחרת"
-"Allow Guest Checkout","אפשר תשלום אורח"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","אפשר לבדוק כאורח. אורח יכול ליצור חשבון בדף התשלום."
-"Allow customer comment in order.","אפשר תגובה של לקוחות לפי הסדר."
-"Allow customers can billing to a different address from billing address.","אפשר ללקוחות לבצע חיוב לכתובת אחרת מכתובת החיוב."
-"Amount","כמות"
-"Calculate Method","חישוב שיטה"
-"Can Show Billing Address","ניתן להציג כתובת לחיוב"
-"Capture+ Key","לכידת + מקש"
-"Capture+ by PCA Predict","לכידת + על ידי PCA לחזות"
-"Checked Newsletter by default","כברירת מחדל, ניוזלטר מסומן"
-"Checkout Page Layout","פריסת דף Checkout"
-"Could not add gift wrap for this quote","לא ניתן להוסיף גלישת מתנות עבור הצעת מחיר זו"
-"Could not remove item from quote","לא ניתן להסיר פריט מציטוט"
-"Could not update item from quote","לא ניתן לעדכן פריט מתוך הצעת מחיר"
-"Custom Css","CSS מותאם אישית"
-"Date Format","פורמט תאריך"
-"Day/Month/Year","יום חודש שנה"
-"Days Off","ימי חופש"
-"Default","בְּרִירַת מֶחדָל"
-"Default Payment Method","שיטת תשלום ברירת מחדל"
-"Default Shipping Method","שיטת משלוח ברירת מחדל"
-"Delivery Time","זמן משלוח"
-"Design Configuration","תצורת עיצוב"
-"Design Style","סגנון עיצוב"
-"Display Configuration","תצוגת תצוגה"
-"Enable Delivery Time","אפשר זמן אספקה"
-"Enable Gift Message","אפשר הודעת מתנה"
-"Enable Gift Wrap","אפשר גלישת מתנות"
-"Enable One Step Checkout","אפשר בצעד אחד"
-"Enable Social Login On Checkout Page","אפשר כניסה חברתית בדף Checkout"
-"Enable Survey","הפעל סקר"
-"Enter the amount of gift wrap fee.","הזן את כמות דמי מתנה לעטוף."
-"Error during save field position.","שגיאה במהלך מיקום השדה שמור."
-"Field Management","ניהול שדות"
-"Flat","שָׁטוּחַ"
-"General Configuration","תצורה כללית"
-"Gift Wrap","אריזות מתנה"
-"Google","Google"
-"Google Api Key","מפתח Google Api"
-"HTML allowed","HTML מותר"
-"Heading Background Color","כותרת צבע רקע"
-"Heading Text Color","כותרת צבע כותרת"
-"IP Country Lookup","בדיקת ארץ IP"
-"In Payment Area","באזור תשלום"
-"In Review Area","באזור סקירה"
-"It will show on success page","הוא יופיע בדף ההצלחה"
-"Material","חוֹמֶר"
-"Month/Day/Year","חודש יום שנה"
-"No","לא"
-"One Step Checkout","שלב אחד Checkout"
-"One Step Checkout Description","תיאור שלב אחד Checkout"
-"One Step Checkout Page Title","שלב אחד Checkout כותרת הדף"
-"One step checkout is turned off.","קופה אחת מופעלת."
-"Options","אפשרויות"
-"Order Comment","תגובה להזמנה"
-"Order Survey","סקר הזמנה"
-"Per Item","פריט"
-"Per Order","לפי הזמנה"
-"Place Order button color","לחץ על הלחצן 'צבע הזמנה'"
-"Restrict the auto suggestion for a specific country","הגבל את ההצעה האוטומטית עבור ארץ ספציפית"
-"SORTED FIELDS","שדות משוריינים"
-"Save Position","תישאר בפוזיטציה"
-"Set default payment method in the checkout process.","הגדר את ברירת המחדל של אמצעי התשלום בתהליך התשלום."
-"Set default shipping method in the checkout process.","הגדר שיטת ברירת מחדל למשלוח בתהליך היציאה."
-"Show Discount Code Section","הצג סעיף קוד הנחה"
-"Show Login Link","הצג קישור התחברות"
-"Show Newsletter Checkbox","הצג תיבת סימון של עלונים"
-"Show Order Comment","הצג תגובה להזמנה"
-"Show Order Review Section","הצג פריט סקירה"
-"Show Product Thumbnail Image","הצג תמונה ממוזערת של המוצר"
-"Show Sign up newsletter selection","הצג רישום הרשמה לניוזלטר"
-"Show Terms and Conditions","הצג תנאים והגבלות"
-"Survey Answers","תשובות סקר"
-"Survey Question","שאלת סקר"
-"The default country will be set based on location of the customer.","מדינת ברירת המחדל תוגדר בהתאם למיקום הלקוח."
-"There is an error while subscribing for newsletter.","אירעה שגיאה בעת ההרשמה לניוזלטר."
-"To calculate gift wrap fee based on item or order.","כדי לחשב דמי לעטוף מתנה מבוסס על פריט או סדר."
-"Unable to save order information. Please check input data.","לא ניתן לשמור פרטי הזמנה. בדוק נתוני קלט."
-"Use Auto Suggestion Technology","השתמש בטכנולוגיה של הצעה אוטומטית"
-"When customer fills address fields, it will suggest a list of full addresses.","כאשר הלקוח ממלא שדות כתובת, הוא יציע רשימה של כתובות מלאות."
-"Year/Month/Day","שנה חודש יום"
-"You can disable Order Review Section. It is enabled by default.","ניתן להשבית את 'סקירת סקירת פריטים'. הוא מופעל כברירת מחדל."
\ No newline at end of file
diff --git a/i18n/hu_HU.csv b/i18n/hu_HU.csv
deleted file mode 100644
index a5196fc..0000000
--- a/i18n/hu_HU.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Kérlek, válassz --"
-"1 Column","1 oszlop"
-"2 Columns","2 oszlop"
-"3 Columns","3 oszlop"
-"3 Columns With Colspan","3 oszlop Colspánnal"
-"Example: .step-title{background-color: #1979c3;}","Példa: .step-title {háttérszín: # 1979c3;}"
-"AVAILABLE FIELDS","ELÉRHETŐ TERÜLETEK"
-"Add","hozzáad"
-"Additional Content","További tartalom"
-"Additional Information","további információ"
-"After Adding a Product Redirect to OneStepCheckout Page","A termék átirányítása hozzáadása a OneStepCheckout oldalra"
-"All fields have been saved.","Minden mező mentésre került."
-"Allow Customer Add Other Option","Engedélyezze az ügyfél számára, hogy hozzáadjon másik opciót"
-"Allow Guest Checkout","Engedélyezze a Vendég fizetést"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Engedje meg, hogy vendégként látogasson el. A vendég létrehozhat egy fiókot a fizetési oldalon."
-"Allow customer comment in order.","Hagyja jóvá az ügyfelek véleményét."
-"Allow customers can billing to a different address from billing address.","Az ügyfelek számlázási címet adhatnak más címre."
-"Amount","Összeg"
-"Calculate Method","Számítási módszer"
-"Can Show Billing Address","Számlázási címet jeleníthet meg"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + a PCA Predict segítségével"
-"Checked Newsletter by default","Alapértelmezés szerint ellenőrzött hírlevél"
-"Checkout Page Layout","Pénztáras elrendezés"
-"Could not add gift wrap for this quote","Nem lehet hozzáadni ajándékcsomagot ehhez az ajánlathoz"
-"Could not remove item from quote","Nem sikerült eltávolítani az elemet az ajánlatból"
-"Could not update item from quote","Nem lehet frissíteni az elemet az ajánlatból"
-"Custom Css","Egyéni Css"
-"Date Format","Dátum formátum"
-"Day/Month/Year","Nap hónap év"
-"Days Off","Szünet"
-"Default","Alapértelmezett"
-"Default Payment Method","Alapértelmezett fizetési mód"
-"Default Shipping Method","Alapértelmezett szállítási mód"
-"Delivery Time","Szállítási idő"
-"Design Configuration","Designkonfiguráció"
-"Design Style","Design stílus"
-"Display Configuration","Display Configuration (Konfiguráció megjelenítése)"
-"Enable Delivery Time","Engedélyezze a szállítási időt"
-"Enable Gift Message","Engedélyezze az ajándéküzenetet"
-"Enable Gift Wrap","Engedélyezze az ajándékcsomagot"
-"Enable One Step Checkout","Engedélyezze a One Step Checkout szolgáltatást"
-"Enable Social Login On Checkout Page","Engedélyezze a bejelentkezés bejelentkezési oldalát"
-"Enable Survey","Felmérés engedélyezése"
-"Enter the amount of gift wrap fee.","Adja meg az ajándékkötési díj összegét."
-"Error during save field position.","Hiba a mentési mezőben."
-"Field Management","Field Management"
-"Flat","Lakás"
-"General Configuration","Általános konfiguráció"
-"Gift Wrap","Ajándékcsomagolás"
-"Google","Google"
-"Google Api Key","Google Api kulcs"
-"HTML allowed","HTML engedélyezett"
-"Heading Background Color","A háttérszín színének megnevezése"
-"Heading Text Color","Címsor szöveg színe"
-"IP Country Lookup","IP Country Lookup"
-"In Payment Area","Fizetési területen"
-"In Review Area","A Felülvizsgálati területen"
-"It will show on success page","A sikeroldalon fog megjelenni"
-"Material","Anyag"
-"Month/Day/Year","Hónap nap év"
-"No","Nem"
-"One Step Checkout","Egylépéses fizetés"
-"One Step Checkout Description","Egylépéses fizetés leírása"
-"One Step Checkout Page Title","Egylépéses Checkout oldal cím"
-"One step checkout is turned off.","Az egylépéses fizetés ki van kapcsolva."
-"Options","Lehetőségek"
-"Order Comment","Hozzászólás megrendelése"
-"Order Survey","Rendelési felmérés"
-"Per Item","Darabonként"
-"Per Order","Rendelésenként"
-"Place Order button color","Rendezési sorrend színe"
-"Restrict the auto suggestion for a specific country","Korlátozza az automatikus javaslatot egy adott országban"
-"SORTED FIELDS","RÉSZTETT TERÜLETEK"
-"Save Position","Pozíció mentése"
-"Set default payment method in the checkout process.","Állítsa be az alapértelmezett fizetési módot a fizetési folyamatban."
-"Set default shipping method in the checkout process.","Állítsa be az alapértelmezett szállítási módot a fizetési folyamatban."
-"Show Discount Code Section","Mutassa meg a kedvezménykódot"
-"Show Login Link","Bejelentkezési link megjelenítése"
-"Show Newsletter Checkbox","Hírlevél jelölőnégyzet megjelenítése"
-"Show Order Comment","Megrendelés megjelenítése"
-"Show Order Review Section","Rendelési áttekintés rész megjelenítése"
-"Show Product Thumbnail Image","Mutassa a termék miniatűr képét"
-"Show Sign up newsletter selection","Megjeleníti a hírlevél feliratkozását"
-"Show Terms and Conditions","Feltételek és feltételek megjelenítése"
-"Survey Answers","Kérdések felmérése"
-"Survey Question","Felmérési kérdés"
-"The default country will be set based on location of the customer.","Az alapértelmezett ország az ügyfél helyének megfelelően kerül beállításra."
-"There is an error while subscribing for newsletter.","Hiba történt a hírlevél feliratkozása közben."
-"To calculate gift wrap fee based on item or order.","Az ajándékozás díjának kiszámításához tételenként vagy rendelés alapján."
-"Unable to save order information. Please check input data.","A rendelési információk mentése nem sikerült. Kérjük, ellenőrizze a bemeneti adatokat."
-"Use Auto Suggestion Technology","Használja az Auto Suggestion technológiát"
-"When customer fills address fields, it will suggest a list of full addresses.","Amikor az ügyfél kitölti a címeket, akkor a teljes címek listáját javasolja."
-"Year/Month/Day","Év hónap nap"
-"You can disable Order Review Section. It is enabled by default.","Letilthatja a Megrendelés áttekintése részt. Alapértelmezés szerint engedélyezve van."
\ No newline at end of file
diff --git a/i18n/it_IT.csv b/i18n/it_IT.csv
deleted file mode 100644
index 047265b..0000000
--- a/i18n/it_IT.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","- Seleziona -"
-"1 Column","1 colonna"
-"2 Columns","2 colonne"
-"3 Columns","3 colonne"
-"3 Columns With Colspan","3 Colonne Con Colspan"
-"Example: .step-title{background-color: #1979c3;}","Esempio: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","CAMPI DISPONIBILI"
-"Add","Inserisci"
-"Additional Content","Contenuti aggiuntivi"
-"Additional Information","Informazioni aggiuntive"
-"After Adding a Product Redirect to OneStepCheckout Page","Dopo l'aggiunta di un reindirizzamento di prodotti a una pagina di OneStepCheckout"
-"All fields have been saved.","Tutti i campi sono stati salvati."
-"Allow Customer Add Other Option","Consenti al cliente di aggiungere un'altra opzione"
-"Allow Guest Checkout","Consenti il ​​pagamento degli ospiti"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Consenti il ​​check-out come ospite. L'ospite può creare un account nella pagina di pagamento."
-"Allow customer comment in order.","Consenti il ​​commento dei clienti in ordine."
-"Allow customers can billing to a different address from billing address.","Consenti ai clienti di fatturare un indirizzo diverso dall'indirizzo di fatturazione."
-"Amount","Quantità"
-"Calculate Method","Calcola il metodo"
-"Can Show Billing Address","Può mostrare l'indirizzo di fatturazione"
-"Capture+ Key","Cattura + chiave"
-"Capture+ by PCA Predict","Capture + da PCA Predict"
-"Checked Newsletter by default","Bolletta controllata per impostazione predefinita"
-"Checkout Page Layout","Layout pagina Checkout"
-"Could not add gift wrap for this quote","Impossibile aggiungere confezione regalo per questo preventivo"
-"Could not remove item from quote","Impossibile rimuovere l'elemento dalla citazione"
-"Could not update item from quote","Impossibile aggiornare l'elemento dalla citazione"
-"Custom Css","CSS personalizzato"
-"Date Format","Formato data"
-"Day/Month/Year","Giorno mese Anno"
-"Days Off","Giorni liberi"
-"Default","Predefinito"
-"Default Payment Method","Metodo di pagamento predefinito"
-"Default Shipping Method","Metodo di spedizione predefinito"
-"Delivery Time","Tempo di consegna"
-"Design Configuration","Configurazione di progettazione"
-"Design Style","Stile di progettazione"
-"Display Configuration","Configurazione della visualizzazione"
-"Enable Delivery Time","Abilita il tempo di consegna"
-"Enable Gift Message","Abilita messaggio regalo"
-"Enable Gift Wrap","Abilita confezione regalo"
-"Enable One Step Checkout","Abilita la verifica di un passo"
-"Enable Social Login On Checkout Page","Abilita l'accesso sociale alla pagina Checkout"
-"Enable Survey","Abilita indagine"
-"Enter the amount of gift wrap fee.","Inserisci l'importo della tassa di avvio regalo."
-"Error during save field position.","Errore durante la posizione del campo di salvataggio."
-"Field Management","Gestione del campo"
-"Flat","Piatto"
-"General Configuration","Configurazione generale"
-"Gift Wrap","Confezione regalo"
-"Google","Google"
-"Google Api Key","Chiave Google Api"
-"HTML allowed","HTML consentito"
-"Heading Background Color","Intestazione Colore Sfondo"
-"Heading Text Color","Testo del testo di direzione"
-"IP Country Lookup","Ricerca del paese IP"
-"In Payment Area","Nell'area di pagamento"
-"In Review Area","In Area di revisione"
-"It will show on success page","Sarà visualizzato sulla pagina di successo"
-"Material","Materiale"
-"Month/Day/Year","Mese giorno anno"
-"No","No"
-"One Step Checkout","Controllo di un passo"
-"One Step Checkout Description","Descrizione del passo di un passo"
-"One Step Checkout Page Title","Titolo della pagina di controllo di un passo"
-"One step checkout is turned off.","Una cassa di un passo è disattivata."
-"Options","Opzioni"
-"Order Comment","Ordine commento"
-"Order Survey","Indagine di ordine"
-"Per Item","Per articolo"
-"Per Order","Per ordine"
-"Place Order button color","Ordina il colore del pulsante Ordine Ordine"
-"Restrict the auto suggestion for a specific country","Limitare il suggerimento automatico di un paese specifico"
-"SORTED FIELDS","CAMPI SORTATI"
-"Save Position","Salva posizione"
-"Set default payment method in the checkout process.","Imposta il metodo di pagamento predefinito nel processo di pagamento."
-"Set default shipping method in the checkout process.","Impostare il metodo di spedizione predefinito nel processo di pagamento."
-"Show Discount Code Section","Mostra sezione codice sconto"
-"Show Login Link","Mostra collegamento di accesso"
-"Show Newsletter Checkbox","Casella di controllo Newsletter"
-"Show Order Comment","Visualizza ordine commento"
-"Show Order Review Section","Visualizza la sezione Review ordine"
-"Show Product Thumbnail Image","Mostra l'immagine miniatura del prodotto"
-"Show Sign up newsletter selection","Mostra Iscriviti alla selezione della newsletter"
-"Show Terms and Conditions","Visualizza Termini e Condizioni"
-"Survey Answers","Sondaggio Risposte"
-"Survey Question","Domanda di indagine"
-"The default country will be set based on location of the customer.","Il paese predefinito sarà impostato in base alla posizione del cliente."
-"There is an error while subscribing for newsletter.","Si è verificato un errore durante l'abbonamento alla newsletter."
-"To calculate gift wrap fee based on item or order.","Per calcolare la tassa di avvolgimento regalo in base all'articolo o all'ordine."
-"Unable to save order information. Please check input data.","Impossibile salvare le informazioni sugli ordini. Controllare i dati di input."
-"Use Auto Suggestion Technology","Utilizza la tecnologia di suggerimento automatico"
-"When customer fills address fields, it will suggest a list of full addresses.","Quando il cliente riempie i campi di indirizzi, suggerirà un elenco di indirizzi completi."
-"Year/Month/Day","Anno mese giorno"
-"You can disable Order Review Section. It is enabled by default.","Puoi disattivare la sezione Review ordine. Viene abilitato per impostazione predefinita."
\ No newline at end of file
diff --git a/i18n/ja_JP.csv b/i18n/ja_JP.csv
deleted file mode 100644
index 9c522ec..0000000
--- a/i18n/ja_JP.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-  選んでください  -"
-"1 Column","1列"
-"2 Columns","2列"
-"3 Columns","3列"
-"3 Columns With Colspan","Colspanで3つの列"
-"Example: .step-title{background-color: #1979c3;}","例：.step-title {背景色：＃1979c3;}"
-"AVAILABLE FIELDS","利用可能なフィールド"
-"Add","追加"
-"Additional Content","追加コンテンツ"
-"Additional Information","追加情報"
-"After Adding a Product Redirect to OneStepCheckout Page","OneStepCheckoutページへの製品リダイレクトの追加後"
-"All fields have been saved.","すべてのフィールドが保存されました。"
-"Allow Customer Add Other Option","顧客が他のオプションを追加できるようにする"
-"Allow Guest Checkout","ゲストのチェックアウトを許可する"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","ゲストとしてチェックアウトを許可します。ゲストは、チェックアウトページでアカウントを作成できます。"
-"Allow customer comment in order.","顧客のコメントを順序通りに許可する。"
-"Allow customers can billing to a different address from billing address.","顧客は請求先住所とは異なる住所に請求することができます。"
-"Amount","量"
-"Calculate Method","メソッドの計算"
-"Can Show Billing Address","請求先住所を表示できる"
-"Capture+ Key","キャプチャ+キー"
-"Capture+ by PCA Predict","PCAによるキャプチャ+予測"
-"Checked Newsletter by default","既定でチェックされたニュースレター"
-"Checkout Page Layout","チェックアウトページのレイアウト"
-"Could not add gift wrap for this quote","この見積もりにギフトラップを追加できませんでした"
-"Could not remove item from quote","見積もりから商品を削除できませんでした"
-"Could not update item from quote","見積もりからアイテムを更新できませんでした"
-"Custom Css","カスタムCSS"
-"Date Format","日付形式"
-"Day/Month/Year","日月年"
-"Days Off","休み"
-"Default","デフォルト"
-"Default Payment Method","デフォルトの支払い方法"
-"Default Shipping Method","デフォルト出荷方法"
-"Delivery Time","納期"
-"Design Configuration","設計構成"
-"Design Style","デザインスタイル"
-"Display Configuration","表示構成"
-"Enable Delivery Time","配信時間を有効にする"
-"Enable Gift Message","ギフトメッセージを有効にする"
-"Enable Gift Wrap","ギフトラッピングを有効にする"
-"Enable One Step Checkout","ワンステップチェックアウトを有効にする"
-"Enable Social Login On Checkout Page","チェックアウトページでソーシャルログインを有効にする"
-"Enable Survey","アンケートを有効にする"
-"Enter the amount of gift wrap fee.","ギフトラッピング料金の金額を入力してください。"
-"Error during save field position.","フィールドの位置を保存中にエラーが発生しました。"
-"Field Management","フィールド管理"
-"Flat","平らな"
-"General Configuration","一般的な設定"
-"Gift Wrap","ギフトラップ"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTMLが許可されました"
-"Heading Background Color","見出しの背景色"
-"Heading Text Color","見出しテキストの色"
-"IP Country Lookup","IP国の検索"
-"In Payment Area","支払いエリア"
-"In Review Area","レビューエリア"
-"It will show on success page","成功のページに表示されます"
-"Material","材料"
-"Month/Day/Year","月日年"
-"No","いいえ"
-"One Step Checkout","ワンステップチェックアウト"
-"One Step Checkout Description","ワンステップチェックアウトの説明"
-"One Step Checkout Page Title","ワンステップチェックアウトページのタイトル"
-"One step checkout is turned off.","ワンステップチェックアウトはオフになっています。"
-"Options","オプション"
-"Order Comment","注文コメント"
-"Order Survey","注文調査"
-"Per Item","アイテムごと"
-"Per Order","注文ごと"
-"Place Order button color","プレースオーダーボタンの色"
-"Restrict the auto suggestion for a specific country","特定の国の自動提案を制限する"
-"SORTED FIELDS","ソートされたフィールド"
-"Save Position","ポジションを保存"
-"Set default payment method in the checkout process.","チェックアウトプロセスでデフォルトの支払方法を設定します。"
-"Set default shipping method in the checkout process.","チェックアウトプロセスでデフォルトの出荷方法を設定します。"
-"Show Discount Code Section","割引コードセクションを表示する"
-"Show Login Link","ログインリンクを表示する"
-"Show Newsletter Checkbox","ニュースレターのチェックボックスを表示する"
-"Show Order Comment","注文のコメントを表示する"
-"Show Order Review Section","オーダーレビューセクションを表示する"
-"Show Product Thumbnail Image","商品サムネイル画像を表示する"
-"Show Sign up newsletter selection","ニュースレターの選択を表示する"
-"Show Terms and Conditions","条件を表示する"
-"Survey Answers","アンケート調査"
-"Survey Question","アンケートの質問"
-"The default country will be set based on location of the customer.","デフォルトの国は、顧客の所在地に基づいて設定されます。"
-"There is an error while subscribing for newsletter.","ニュースレターを購読中にエラーが発生しました。"
-"To calculate gift wrap fee based on item or order.","商品や注文に基づいてギフトラップ料金を計算する。"
-"Unable to save order information. Please check input data.","注文情報を保存できません。入力データを確認してください。"
-"Use Auto Suggestion Technology","自動提案技術を使用する"
-"When customer fills address fields, it will suggest a list of full addresses.","顧客が住所フィールドを入力すると、完全な住所のリストが表示されます。"
-"Year/Month/Day","年/月/日"
-"You can disable Order Review Section. It is enabled by default.","オーダーレビューセクションを無効にすることができます。デフォルトで有効になっています。"
\ No newline at end of file
diff --git a/i18n/ko_KR.csv b/i18n/ko_KR.csv
deleted file mode 100644
index 30059ab..0000000
--- a/i18n/ko_KR.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- 선택 해주세요 --"
-"1 Column","1 칼럼"
-"2 Columns","2 열"
-"3 Columns","3 열"
-"3 Columns With Colspan","Colspan으로 3 열"
-"Example: .step-title{background-color: #1979c3;}","예 : .step-title {background-color : # 1979c3}"
-"AVAILABLE FIELDS","사용 가능한 필드"
-"Add","더하다"
-"Additional Content","추가 콘텐츠"
-"Additional Information","추가 정보"
-"After Adding a Product Redirect to OneStepCheckout Page","OneStepCheckout 페이지로 제품 리디렉션을 추가 한 후"
-"All fields have been saved.","모든 입력란이 저장되었습니다."
-"Allow Customer Add Other Option","고객이 다른 옵션 추가 허용"
-"Allow Guest Checkout","손님 체크 아웃 허용"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","게스트로 체크 아웃 할 수 있습니다. 게스트는 결제 페이지에서 계정을 만들 수 있습니다."
-"Allow customer comment in order.","고객 의견을 순서대로 기재하십시오."
-"Allow customers can billing to a different address from billing address.","고객은 청구서 수신 주소와 다른 주소로 청구 할 수 있습니다."
-"Amount","양"
-"Calculate Method","방법 계산"
-"Can Show Billing Address","청구서 수신 주소 표시 가능"
-"Capture+ Key","캡쳐 + 키"
-"Capture+ by PCA Predict","PCA에 의한 캡쳐 + 예측"
-"Checked Newsletter by default","기본적으로 체크 된 뉴스 레터"
-"Checkout Page Layout","체크 아웃 페이지 레이아웃"
-"Could not add gift wrap for this quote","이 견적에 선물 포장을 추가 할 수 없습니다."
-"Could not remove item from quote","견적에서 항목을 삭제할 수 없습니다."
-"Could not update item from quote","견적에서 항목을 업데이트 할 수 없습니다."
-"Custom Css","사용자 정의 CSS"
-"Date Format","날짜 형식"
-"Day/Month/Year","일 / 월 / 년"
-"Days Off","휴가"
-"Default","태만"
-"Default Payment Method","기본 지불 방법"
-"Default Shipping Method","기본 배송 방법"
-"Delivery Time","배달 시간"
-"Design Configuration","디자인 구성"
-"Design Style","디자인 스타일"
-"Display Configuration","디스플레이 구성"
-"Enable Delivery Time","배달 시간 사용"
-"Enable Gift Message","선물 메시지 사용"
-"Enable Gift Wrap","선물 포장 사용"
-"Enable One Step Checkout","원 스텝 체크 아웃 사용"
-"Enable Social Login On Checkout Page","Checkout 페이지에서 소셜 로그인 사용"
-"Enable Survey","설문 조사 사용"
-"Enter the amount of gift wrap fee.","선물 포장 금액을 입력하십시오."
-"Error during save field position.","필드 위치를 저장하는 중 오류가 발생했습니다."
-"Field Management","현장 관리"
-"Flat","플랫"
-"General Configuration","일반 구성"
-"Gift Wrap","선물 포장"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTML 허용됨"
-"Heading Background Color","제목 배경색"
-"Heading Text Color","제목 텍스트 색"
-"IP Country Lookup","IP 국가 조회"
-"In Payment Area","지불 영역"
-"In Review Area","검토 영역"
-"It will show on success page","성공 페이지에 표시됩니다."
-"Material","자료"
-"Month/Day/Year","월 일 년"
-"No","아니"
-"One Step Checkout","원 스텝 체크 아웃"
-"One Step Checkout Description","원 스텝 체크 아웃 설명"
-"One Step Checkout Page Title","원 스텝 체크 아웃 페이지 제목"
-"One step checkout is turned off.","한 단계 체크 아웃이 꺼져 있습니다."
-"Options","옵션"
-"Order Comment","주문 설명"
-"Order Survey","주문 설문 조사"
-"Per Item","항목 별"
-"Per Order","주문 당"
-"Place Order button color","주문 버튼 색상"
-"Restrict the auto suggestion for a specific country","특정 국가에 대한 자동 제안 제한"
-"SORTED FIELDS","정렬 된 필드"
-"Save Position","위치 저장"
-"Set default payment method in the checkout process.","결제 프로세스에서 기본 결제 수단을 설정합니다."
-"Set default shipping method in the checkout process.","체크 아웃 프로세스에서 기본 운송 방법을 설정하십시오."
-"Show Discount Code Section","할인 코드 섹션 표시"
-"Show Login Link","로그인 링크 표시"
-"Show Newsletter Checkbox","뉴스 레터 확인란 표시"
-"Show Order Comment","주문 댓글 표시"
-"Show Order Review Section","주문 검토 섹션 표시"
-"Show Product Thumbnail Image","제품 축소판 이미지 표시"
-"Show Sign up newsletter selection","쇼 가입 뉴스 레터 선택"
-"Show Terms and Conditions","이용 약관 표시"
-"Survey Answers","설문 조사 응답"
-"Survey Question","설문 조사 질문"
-"The default country will be set based on location of the customer.","기본 국가는 고객의 위치에 따라 설정됩니다."
-"There is an error while subscribing for newsletter.","뉴스 레터를 구독하는 중에 오류가 발생했습니다."
-"To calculate gift wrap fee based on item or order.","항목 또는 주문을 기준으로 선물 포장 요금을 계산합니다."
-"Unable to save order information. Please check input data.","주문 정보를 저장할 수 없습니다. 입력 데이터를 확인하십시오."
-"Use Auto Suggestion Technology","자동 제안 기술 사용"
-"When customer fills address fields, it will suggest a list of full addresses.","고객이 주소 필드를 채우면 전체 주소 목록을 제안합니다."
-"Year/Month/Day","년 / 월 / 일"
-"You can disable Order Review Section. It is enabled by default.","주문 검토 섹션을 비활성화 할 수 있습니다. 기본적으로 사용하도록 설정되어 있습니다."
\ No newline at end of file
diff --git a/i18n/nl_NL.csv b/i18n/nl_NL.csv
deleted file mode 100644
index f87c75b..0000000
--- a/i18n/nl_NL.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Selecteer alstublieft --"
-"1 Column","1 kolom"
-"2 Columns","2 kolommen"
-"3 Columns","3 kolommen"
-"3 Columns With Colspan","3 Kolommen Met Colspan"
-"Example: .step-title{background-color: #1979c3;}","Voorbeeld: .step-titel {achtergrondkleur: # 1979c3;}"
-"AVAILABLE FIELDS","BESCHIKBARE GEBIEDEN"
-"Add","Toevoegen"
-"Additional Content","Extra inhoud"
-"Additional Information","Extra informatie"
-"After Adding a Product Redirect to OneStepCheckout Page","Na het toevoegen van een Product Redirect naar OneStepCheckout Page"
-"All fields have been saved.","Alle velden zijn opgeslagen."
-"Allow Customer Add Other Option","Laat de klant toe om andere mogelijkheden toe te voegen"
-"Allow Guest Checkout","Laat de gasten uitchecken"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Laat het uitchecken als gast. Gasten kunnen een account aanmaken op de kassa pagina."
-"Allow customer comment in order.","Laat klant commentaar in volgorde."
-"Allow customers can billing to a different address from billing address.","Sta klanten toe om op een ander adres te factureren vanaf factuuradres."
-"Amount","Bedrag"
-"Calculate Method","Bereken methode"
-"Can Show Billing Address","Kan factuuradres weergeven"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + door PCA Predict"
-"Checked Newsletter by default","Gecontroleerde nieuwsbrief standaard"
-"Checkout Page Layout","Checkout Pagina Layout"
-"Could not add gift wrap for this quote","Kan cadeauwrap voor dit citaat niet toevoegen"
-"Could not remove item from quote","Kon het item niet van het citaat verwijderen"
-"Could not update item from quote","Kon het item niet van het citaat bijwerken"
-"Custom Css","Aangepaste Css"
-"Date Format","Datumnotatie"
-"Day/Month/Year","Dag maand jaar"
-"Days Off","Vrije dagen"
-"Default","Standaard"
-"Default Payment Method","Standaard betalingsmethode"
-"Default Shipping Method","Standaard verzendmethode"
-"Delivery Time","Tijd om te bezorgen"
-"Design Configuration","Ontwerpconfiguratie"
-"Design Style","Design Style"
-"Display Configuration","Display configuratie"
-"Enable Delivery Time","Schakel Levertijd in"
-"Enable Gift Message","Cadeaubericht inschakelen"
-"Enable Gift Wrap","Cadeaupapier inschakelen"
-"Enable One Step Checkout","Schakel één stapcontrole in"
-"Enable Social Login On Checkout Page","Sociale login inschakelen op de kassa pagina"
-"Enable Survey","Enquête inschakelen"
-"Enter the amount of gift wrap fee.","Voer het bedrag van de cadeauverpakking in."
-"Error during save field position.","Fout tijdens opslaan veld positie."
-"Field Management","Veldbeheer"
-"Flat","Vlak"
-"General Configuration","Algemene configuratie"
-"Gift Wrap","Cadeaupapier"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTML toegestaan"
-"Heading Background Color","Achtergrondkleur Achtergrond"
-"Heading Text Color","Tekst Tekst Kleur"
-"IP Country Lookup","IP Land Lookup"
-"In Payment Area","In Betaalgebied"
-"In Review Area","In review gebied"
-"It will show on success page","Het zal op succes pagina tonen"
-"Material","Materiaal"
-"Month/Day/Year","Maand dag jaar"
-"No","Nee"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","One Step Checkout Beschrijving"
-"One Step Checkout Page Title","One Step Checkout Page Title"
-"One step checkout is turned off.","Een stapcontrole is uitgeschakeld."
-"Options","opties"
-"Order Comment","Bestelling Commentaar"
-"Order Survey","Order Survey"
-"Per Item","Per stuk"
-"Per Order","Per bestelling"
-"Place Order button color","Plaats de bestelknop kleur"
-"Restrict the auto suggestion for a specific country","Beperk de automatische suggestie voor een bepaald land"
-"SORTED FIELDS","GEVORMDE GEBIEDEN"
-"Save Position","Veilige positie"
-"Set default payment method in the checkout process.","Stel de standaard betaalmethode in de kassa."
-"Set default shipping method in the checkout process.","Stel standaard verzendmethode in de kassa."
-"Show Discount Code Section","Toon kortingcode sectie"
-"Show Login Link","Toon Login Link"
-"Show Newsletter Checkbox","Toon Nieuwsbrief Checkbox"
-"Show Order Comment","Toon orderopmerking"
-"Show Order Review Section","Toon Order Review Section"
-"Show Product Thumbnail Image","Toon product miniatuurafbeelding"
-"Show Sign up newsletter selection","Toon aanmelden nieuwsbrief selectie"
-"Show Terms and Conditions","Toon voorwaarden"
-"Survey Answers","Survey Antwoorden"
-"Survey Question","Onderzoeksvraag"
-"The default country will be set based on location of the customer.","Het standaard land wordt ingesteld op basis van de locatie van de klant."
-"There is an error while subscribing for newsletter.","Er is een fout bij het inschrijven voor de nieuwsbrief."
-"To calculate gift wrap fee based on item or order.","Om cadeauwrapkosten te berekenen op basis van item of bestelling."
-"Unable to save order information. Please check input data.","Kan bestelinformatie niet opslaan. Controleer de invoergegevens."
-"Use Auto Suggestion Technology","Gebruik de automatische suggestie technologie"
-"When customer fills address fields, it will suggest a list of full addresses.","Wanneer de klant invult velden, zal het een lijst van volledige adressen voorstellen."
-"Year/Month/Day","Jaar maand dag"
-"You can disable Order Review Section. It is enabled by default.","U kunt Order Review Section uitschakelen. Het is standaard ingeschakeld."
\ No newline at end of file
diff --git a/i18n/no_NO.csv b/i18n/no_NO.csv
deleted file mode 100644
index c919e24..0000000
--- a/i18n/no_NO.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Vennligst velg --"
-"1 Column","1 kolonne"
-"2 Columns","2 kolonner"
-"3 Columns","3 kolonner"
-"3 Columns With Colspan","3 kolonner med Colspan"
-"Example: .step-title{background-color: #1979c3;}","Eksempel: .step-tittel {bakgrunnsfarge: # 1979c3;}"
-"AVAILABLE FIELDS","TILGJENGELIGE FELLER"
-"Add","Legg til"
-"Additional Content","Tilleggsinnhold"
-"Additional Information","Tilleggsinformasjon"
-"After Adding a Product Redirect to OneStepCheckout Page","Etter at du har lagt til en omdirigering av produkt til OneStepCheckout-siden"
-"All fields have been saved.","Alle feltene er lagret."
-"Allow Customer Add Other Option","Tillat at kunden legger til et annet alternativ"
-"Allow Guest Checkout","Tillat Guest Checkout"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Tillat å sjekke ut som gjest. Gjest kan opprette en konto i kassen siden."
-"Allow customer comment in order.","Tillat kundekommentar i rekkefølge."
-"Allow customers can billing to a different address from billing address.","Tillat at kunder kan fakturere til en annen adresse fra faktureringsadresse."
-"Amount","Beløp"
-"Calculate Method","Beregn metode"
-"Can Show Billing Address","Kan vise faktureringsadresse"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + ved PCA Predict"
-"Checked Newsletter by default","Sjekket nyhetsbrev som standard"
-"Checkout Page Layout","Sjekk ut sidelayout"
-"Could not add gift wrap for this quote","Kunne ikke legge til gavepakke for dette sitatet"
-"Could not remove item from quote","Kunne ikke fjerne element fra sitat"
-"Could not update item from quote","Kunne ikke oppdatere element fra sitat"
-"Custom Css","Tilpasset Css"
-"Date Format","Datoformat"
-"Day/Month/Year","Dag / måned / år"
-"Days Off","Fridager"
-"Default","Misligholde"
-"Default Payment Method","Standard betalingsmetode"
-"Default Shipping Method","Standard leveringsmetode"
-"Delivery Time","Leveringstid"
-"Design Configuration","Designkonfigurasjon"
-"Design Style","Design stil"
-"Display Configuration","Skjermkonfigurasjon"
-"Enable Delivery Time","Aktiver leveringstid"
-"Enable Gift Message","Aktiver gavemelding"
-"Enable Gift Wrap","Aktiver gavepakke"
-"Enable One Step Checkout","Aktiver One Step Checkout"
-"Enable Social Login On Checkout Page","Aktiver sosial pålogging på kassen siden"
-"Enable Survey","Aktiver undersøkelse"
-"Enter the amount of gift wrap fee.","Skriv inn mengden gavepakkeavgift."
-"Error during save field position.","Feil under lagringsfeltposisjon."
-"Field Management","Feltbehandling"
-"Flat","Flat"
-"General Configuration","Generell konfigurasjon"
-"Gift Wrap","Gavepapir"
-"Google","Google"
-"Google Api Key","Google Api-nøkkel"
-"HTML allowed","HTML tillatt"
-"Heading Background Color","Overskrift Bakgrunnsfarge"
-"Heading Text Color","Overskrift Tekstfarge"
-"IP Country Lookup","IP Land Lookup"
-"In Payment Area","I betalingsområdet"
-"In Review Area","I Review Area"
-"It will show on success page","Det vil vise på suksess siden"
-"Material","Materiale"
-"Month/Day/Year","Måned dag år"
-"No","Nei"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","One Step Checkout Beskrivelse"
-"One Step Checkout Page Title","One Step Checkout Side Tittel"
-"One step checkout is turned off.","Én trinns kassa er slått av."
-"Options","alternativer"
-"Order Comment","Bestill kommentar"
-"Order Survey","Bestillingsundersøkelse"
-"Per Item","Per stykk"
-"Per Order","Per ordre"
-"Place Order button color","Plasser bestillingsfarge"
-"Restrict the auto suggestion for a specific country","Begrens automatisk forslaget til et bestemt land"
-"SORTED FIELDS","SORTEDE OMRÅDER"
-"Save Position","Lagre posisjon"
-"Set default payment method in the checkout process.","Angi standard betalingsmetode i kassen."
-"Set default shipping method in the checkout process.","Angi standard leveringsmetode i kassen."
-"Show Discount Code Section","Vis rabattkode-delen"
-"Show Login Link","Vis loggforbindelsen"
-"Show Newsletter Checkbox","Vis nyhetsbrev-boksen"
-"Show Order Comment","Vis bestillings kommentar"
-"Show Order Review Section","Vis bestillingsoversikt Seksjon"
-"Show Product Thumbnail Image","Vis produktminaturbilde"
-"Show Sign up newsletter selection","Vis Registrer nyhetsbrev utvalg"
-"Show Terms and Conditions","Vis vilkår og betingelser"
-"Survey Answers","Survey Answers"
-"Survey Question","Survey Question"
-"The default country will be set based on location of the customer.","Standardlandet vil bli angitt basert på kundens beliggenhet."
-"There is an error while subscribing for newsletter.","Det er en feil mens du abonnerer på nyhetsbrev."
-"To calculate gift wrap fee based on item or order.","Å beregne gavepakkeavgift basert på vare eller bestilling."
-"Unable to save order information. Please check input data.","Kan ikke lagre bestillingsinformasjon. Vennligst sjekk inndataene."
-"Use Auto Suggestion Technology","Bruk Auto Suggestion Technology"
-"When customer fills address fields, it will suggest a list of full addresses.","Når kunden fyller adressefelt, vil det foreslå en liste over fulle adresser."
-"Year/Month/Day","År / måned / dag"
-"You can disable Order Review Section. It is enabled by default.","Du kan deaktivere Bestillingsavsnittet. Den er aktivert som standard."
\ No newline at end of file
diff --git a/i18n/pl_PL.csv b/i18n/pl_PL.csv
deleted file mode 100644
index 90b50db..0000000
--- a/i18n/pl_PL.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Proszę wybrać --"
-"1 Column","1 kolumna"
-"2 Columns","2 kolumny"
-"3 Columns","3 kolumny"
-"3 Columns With Colspan","3 kolumny z Colspan"
-"Example: .step-title{background-color: #1979c3;}","Przykład: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","DOSTĘPNE DZIEDZINY"
-"Add","Dodaj"
-"Additional Content","Dodatkowa treść"
-"Additional Information","Dodatkowe informacje"
-"After Adding a Product Redirect to OneStepCheckout Page","Po dodaniu przekierowania produktu do strony OneStepCheckout"
-"All fields have been saved.","Wszystkie pola zostały zapisane."
-"Allow Customer Add Other Option","Pozwól klientowi dodać inną opcję"
-"Allow Guest Checkout","Zezwalaj na Gość"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Pozwól sprawdzić się jako gość. Gość może założyć konto na stronie kasowej."
-"Allow customer comment in order.","Zezwalaj na komentarze klientów w kolejności."
-"Allow customers can billing to a different address from billing address.","Zezwalaj klientom na rozliczanie się z innego adresu z adresu rozliczeniowego."
-"Amount","Ilość"
-"Calculate Method","Oblicz metodę"
-"Can Show Billing Address","Może wyświetlać adres rozliczeniowy"
-"Capture+ Key","Klucz przechwytywania +"
-"Capture+ by PCA Predict","Capture + przez PCA Predict"
-"Checked Newsletter by default","Sprawdzone Newsletter domyślnie"
-"Checkout Page Layout","Układ strony Checkout"
-"Could not add gift wrap for this quote","Nie można dodać oblewania prezentem dla tego cytatu"
-"Could not remove item from quote","Nie można usunąć elementu z oferty"
-"Could not update item from quote","Nie można zaktualizować elementu z cytatu"
-"Custom Css","Niestandardowy CSS"
-"Date Format","Format daty"
-"Day/Month/Year","Dzień miesiąc rok"
-"Days Off","Dni wolne"
-"Default","Zaniedbanie"
-"Default Payment Method","Domyślna metoda płatności"
-"Default Shipping Method","Domyślna metoda wysyłki"
-"Delivery Time","Czas dostawy"
-"Design Configuration","Konfiguracja projektu"
-"Design Style","Styl Projektowania"
-"Display Configuration","Konfiguracja wyświetlania"
-"Enable Delivery Time","Włącz czas dostawy"
-"Enable Gift Message","Włącz wiadomość z upominkami"
-"Enable Gift Wrap","Włącz zawijanie prezentów"
-"Enable One Step Checkout","Włącz jedną krok Checkout"
-"Enable Social Login On Checkout Page","Włącz logowanie socjalne na stronie usługi Checkout"
-"Enable Survey","Włącz ankietę"
-"Enter the amount of gift wrap fee.","Wprowadź kwotę opłaty z upominkami."
-"Error during save field position.","Błąd podczas pola pola zapisu."
-"Field Management","Zarządzanie terenem"
-"Flat","Mieszkanie"
-"General Configuration","Konfiguracja ogólna"
-"Gift Wrap","Opakowanie na prezent"
-"Google","Google"
-"Google Api Key","Klucz Api Google"
-"HTML allowed","Dozwolony HTML"
-"Heading Background Color","Kolor tła nagłówka"
-"Heading Text Color","Kolor tekstu nagłówkowego"
-"IP Country Lookup","IP Wyszukiwanie kraju"
-"In Payment Area","W obszarze płatności"
-"In Review Area","W obszarze przeglądu"
-"It will show on success page","Zostanie wyświetlone na stronie z sukcesem"
-"Material","Materiał"
-"Month/Day/Year","Miesiąc dzień rok"
-"No","Nie"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","Opis krok po kroku"
-"One Step Checkout Page Title","Jedna Strona Kroku Dokonania Strony"
-"One step checkout is turned off.","Jeden krok kontroli jest wyłączony."
-"Options","Opcje"
-"Order Comment","Komentarz zlecenia"
-"Order Survey","Zaplanuj zamówienie"
-"Per Item","Za sztukę"
-"Per Order","Na zamówienie"
-"Place Order button color","Umieść kolor przycisku zamówienia"
-"Restrict the auto suggestion for a specific country","Ogranicz propozycję automatyczną dla określonego kraju"
-"SORTED FIELDS","SORTOWANE POLE"
-"Save Position","Zachować pozycję"
-"Set default payment method in the checkout process.","Ustaw domyślną metodę płatności w procesie wypłaty."
-"Set default shipping method in the checkout process.","Ustaw domyślną metodę wysyłki w procesie wypłaty."
-"Show Discount Code Section","Pokaż sekcję rabatów"
-"Show Login Link","Pokaż link logowania"
-"Show Newsletter Checkbox","Pokaż skrzynkę Checkbox"
-"Show Order Comment","Pokaż zamówienie"
-"Show Order Review Section","Pokaż sekcję przeglądu zamówienia"
-"Show Product Thumbnail Image","Pokaż miniaturę produktu"
-"Show Sign up newsletter selection","Pokaż Zarejestruj się do newslettera"
-"Show Terms and Conditions","Pokaż warunki i zasady"
-"Survey Answers","Odpowiedzi na pytania z ankiety"
-"Survey Question","Pytanie ankietowe"
-"The default country will be set based on location of the customer.","Domyślny kraj zostanie ustawiony na podstawie lokalizacji klienta."
-"There is an error while subscribing for newsletter.","Podczas subskrypcji biuletynu wystąpił błąd."
-"To calculate gift wrap fee based on item or order.","Aby obliczyć opłatę na prezent w zależności od przedmiotu lub zamówienia."
-"Unable to save order information. Please check input data.","Nie można zapisać informacji o zamówieniu. Sprawdź dane wejściowe."
-"Use Auto Suggestion Technology","Użyj technologii Auto Suggestion"
-"When customer fills address fields, it will suggest a list of full addresses.","Gdy klient wypełnia pola adresowe, zaproponuje listę pełnych adresów."
-"Year/Month/Day","Rok miesiąc dzień"
-"You can disable Order Review Section. It is enabled by default.","Sekcję Recenzania zamówienia można wyłączyć. Domyślnie jest włączona."
\ No newline at end of file
diff --git a/i18n/pt_BR.csv b/i18n/pt_BR.csv
deleted file mode 100644
index 3c6829d..0000000
--- a/i18n/pt_BR.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Please select --"
-"1 Column","1 Column"
-"2 Columns","2 Columns"
-"3 Columns","3 Columns"
-"3 Columns With Colspan","3 Columns With Colspan"
-"Example: .step-title{background-color: #1979c3;}","Example: .step-title{background-color: #1979c3;}"
-"AVAILABLE FIELDS","AVAILABLE FIELDS"
-"Add","Add"
-"Additional Content","Additional Content"
-"Additional Information","Additional Information"
-"After Adding a Product Redirect to OneStepCheckout Page","After Adding a Product Redirect to OneStepCheckout Page"
-"All fields have been saved.","All fields have been saved."
-"Allow Customer Add Other Option","Allow Customer Add Other Option"
-"Allow Guest Checkout","Allow Guest Checkout"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Allow checking out as a guest. Guest can create an account in the checkout page."
-"Allow customer comment in order.","Allow customer comment in order."
-"Allow customers can billing to a different address from billing address.","Allow customers can billing to a different address from billing address."
-"Amount","Amount"
-"Calculate Method","Calculate Method"
-"Can Show Billing Address","Can Show Billing Address"
-"Capture+ Key","Capture+ Key"
-"Capture+ by PCA Predict","Capture+ by PCA Predict"
-"Checked Newsletter by default","Checked Newsletter by default"
-"Checkout Page Layout","Checkout Page Layout"
-"Could not add gift wrap for this quote","Could not add gift wrap for this quote"
-"Could not remove item from quote","Could not remove item from quote"
-"Could not update item from quote","Could not update item from quote"
-"Custom Css","Custom Css"
-"Date Format","Date Format"
-"Day/Month/Year","Day/Month/Year"
-"Days Off","Days Off"
-"Default","Default"
-"Default Payment Method","Default Payment Method"
-"Default Shipping Method","Default Shipping Method"
-"Delivery Time","Delivery Time"
-"Design Configuration","Design Configuration"
-"Design Style","Design Style"
-"Display Configuration","Display Configuration"
-"Enable Delivery Time","Enable Delivery Time"
-"Enable Gift Message","Enable Gift Message"
-"Enable Gift Wrap","Enable Gift Wrap"
-"Enable One Step Checkout","Enable One Step Checkout"
-"Enable Social Login On Checkout Page","Enable Social Login On Checkout Page"
-"Enable Survey","Enable Survey"
-"Enter the amount of gift wrap fee.","Enter the amount of gift wrap fee."
-"Error during save field position.","Error during save field position."
-"Field Management","Field Management"
-"Flat","Flat"
-"General Configuration","General Configuration"
-"Gift Wrap","Gift Wrap"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTML allowed"
-"Heading Background Color","Heading Background Color"
-"Heading Text Color","Heading Text Color"
-"IP Country Lookup","IP Country Lookup"
-"In Payment Area","In Payment Area"
-"In Review Area","In Review Area"
-"It will show on success page","It will show on success page"
-"Material","Material"
-"Month/Day/Year","Month/Day/Year"
-"No","No"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","One Step Checkout Description"
-"One Step Checkout Page Title","One Step Checkout Page Title"
-"One step checkout is turned off.","One step checkout is turned off."
-"Options","Options"
-"Order Comment","Order Comment"
-"Order Survey","Order Survey"
-"Per Item","Per Item"
-"Per Order","Per Order"
-"Place Order button color","Place Order button color"
-"Restrict the auto suggestion for a specific country","Restrict the auto suggestion for a specific country"
-"SORTED FIELDS","SORTED FIELDS"
-"Save Position","Save Position"
-"Set default payment method in the checkout process.","Set default payment method in the checkout process."
-"Set default shipping method in the checkout process.","Set default shipping method in the checkout process."
-"Show Discount Code Section","Show Discount Code Section"
-"Show Login Link","Show Login Link"
-"Show Newsletter Checkbox","Show Newsletter Checkbox"
-"Show Order Comment","Show Order Comment"
-"Show Order Review Section","Show Order Review Section"
-"Show Product Thumbnail Image","Show Product Thumbnail Image"
-"Show Sign up newsletter selection","Show Sign up newsletter selection"
-"Show Terms and Conditions","Show Terms and Conditions"
-"Survey Answers","Survey Answers"
-"Survey Question","Survey Question"
-"The default country will be set based on location of the customer.","The default country will be set based on location of the customer."
-"There is an error while subscribing for newsletter.","There is an error while subscribing for newsletter."
-"To calculate gift wrap fee based on item or order.","To calculate gift wrap fee based on item or order."
-"Unable to save order information. Please check input data.","Unable to save order information. Please check input data."
-"Use Auto Suggestion Technology","Use Auto Suggestion Technology"
-"When customer fills address fields, it will suggest a list of full addresses.","When customer fills address fields, it will suggest a list of full addresses."
-"Year/Month/Day","Year/Month/Day"
-"You can disable Order Review Section. It is enabled by default.","You can disable Order Review Section. It is enabled by default."
\ No newline at end of file
diff --git a/i18n/pt_PT.csv b/i18n/pt_PT.csv
deleted file mode 100644
index 61a5134..0000000
--- a/i18n/pt_PT.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Por favor selecione --"
-"1 Column","1 coluna"
-"2 Columns","2 colunas"
-"3 Columns","3 colunas"
-"3 Columns With Colspan","3 colunas com Colspan"
-"Example: .step-title{background-color: #1979c3;}","Exemplo: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","CAMPOS DISPONÍVEIS"
-"Add","Adicionar"
-"Additional Content","Conteúdo adicional"
-"Additional Information","informação adicional"
-"After Adding a Product Redirect to OneStepCheckout Page","Depois de adicionar uma redirecionamento de produto à página OneStepCheckout"
-"All fields have been saved.","Todos os campos foram salvos."
-"Allow Customer Add Other Option","Permitir ao Cliente adicionar outra opção"
-"Allow Guest Checkout","Permitir Guest Checkout"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Permitir conferir como visitante. Convidado pode criar uma conta na página de checkout."
-"Allow customer comment in order.","Permitir o comentário do cliente em ordem."
-"Allow customers can billing to a different address from billing address.","Permitir que os clientes possam facultar a um endereço diferente do endereço de cobrança."
-"Amount","Montante"
-"Calculate Method","Método de cálculo"
-"Can Show Billing Address","Pode mostrar o endereço de cobrança"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capturar + por PCA Predict"
-"Checked Newsletter by default","Boletim de notícias verificado por padrão"
-"Checkout Page Layout","Layout de página de compras"
-"Could not add gift wrap for this quote","Não foi possível adicionar embrulho para esta citação"
-"Could not remove item from quote","Não foi possível remover o item da cotação"
-"Could not update item from quote","Não foi possível atualizar o item da cotação"
-"Custom Css","CSS customizado"
-"Date Format","Formato de data"
-"Day/Month/Year","Dia mês ano"
-"Days Off","Dias fora"
-"Default","Padrão"
-"Default Payment Method","Metodo de pagamento padrão"
-"Default Shipping Method","Método de envio padrão"
-"Delivery Time","Tempo de entrega"
-"Design Configuration","Configuração do projeto"
-"Design Style","Estilo de design"
-"Display Configuration","Configuração da tela"
-"Enable Delivery Time","Habilitar o tempo de entrega"
-"Enable Gift Message","Permitir mensagem de presente"
-"Enable Gift Wrap","Enable Gift Wrap"
-"Enable One Step Checkout","Habilitar One Step Checkout"
-"Enable Social Login On Checkout Page","Ativar Login Social na Página de Checkout"
-"Enable Survey","Enable Survey"
-"Enter the amount of gift wrap fee.","Insira a quantidade de taxa de entrega de presente."
-"Error during save field position.","Erro durante a salvação da posição do campo."
-"Field Management","Gerenciamento de campo"
-"Flat","Plano"
-"General Configuration","Configuração Geral"
-"Gift Wrap","Embrulho de presente"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTML permitido"
-"Heading Background Color","Cabeçalho da cor do fundo"
-"Heading Text Color","Cabeçalho da cor do texto"
-"IP Country Lookup","IP Country Lookup"
-"In Payment Area","Na área de pagamento"
-"In Review Area","Na área de revisão"
-"It will show on success page","Será mostrado na página de sucesso"
-"Material","Material"
-"Month/Day/Year","Mês dia ano"
-"No","Não"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","One Step Checkout Description"
-"One Step Checkout Page Title","One Step Checkout Título da Página"
-"One step checkout is turned off.","O pagamento de uma etapa está desativado."
-"Options","Opções"
-"Order Comment","Comentário do pedido"
-"Order Survey","Pesquisa de pedidos"
-"Per Item","Por item"
-"Per Order","Por ordem"
-"Place Order button color","Cor do botão da ordem do pedido"
-"Restrict the auto suggestion for a specific country","Restringir a sugestão automática para um país específico"
-"SORTED FIELDS","CAMPOS ADEQUADOS"
-"Save Position","Salvar posição"
-"Set default payment method in the checkout process.","Defina o método de pagamento padrão no processo de checkout."
-"Set default shipping method in the checkout process.","Defina o método de envio padrão no processo de checkout."
-"Show Discount Code Section","Mostrar seção de código de desconto"
-"Show Login Link","Mostrar link de login"
-"Show Newsletter Checkbox","Mostrar caixa de seleção do boletim informativo"
-"Show Order Comment","Mostrar comentário do pedido"
-"Show Order Review Section","Mostrar seção de revisão de pedidos"
-"Show Product Thumbnail Image","Mostrar imagem em miniatura do produto"
-"Show Sign up newsletter selection","Seleção de boletim de inscrições de inscrições"
-"Show Terms and Conditions","Mostrar Termos e Condições"
-"Survey Answers","Respostas de pesquisa"
-"Survey Question","Questão de pesquisa"
-"The default country will be set based on location of the customer.","O país padrão será definido com base na localização do cliente."
-"There is an error while subscribing for newsletter.","Há um erro ao se inscrever no boletim informativo."
-"To calculate gift wrap fee based on item or order.","Para calcular a taxa de entrega de presentes com base no item ou ordem."
-"Unable to save order information. Please check input data.","Não é possível salvar informações de pedidos. Verifique os dados de entrada."
-"Use Auto Suggestion Technology","Use a tecnologia de sugestão automática"
-"When customer fills address fields, it will suggest a list of full addresses.","Quando o cliente preencher campos de endereço, ele irá sugerir uma lista de endereços completos."
-"Year/Month/Day","Ano mês dia"
-"You can disable Order Review Section. It is enabled by default.","Você pode desabilitar a seção de revisão de pedidos. É habilitado por padrão."
\ No newline at end of file
diff --git a/i18n/ro_RO.csv b/i18n/ro_RO.csv
deleted file mode 100644
index 4131600..0000000
--- a/i18n/ro_RO.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Te rog selecteaza --"
-"1 Column","1 Coloană"
-"2 Columns","2 Coloane"
-"3 Columns","3 Coloane"
-"3 Columns With Colspan","3 Coloane cu Colspan"
-"Example: .step-title{background-color: #1979c3;}","Exemplu: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","DOMENII DISPONIBILE"
-"Add","Adăuga"
-"Additional Content","Conținut suplimentar"
-"Additional Information","informatii suplimentare"
-"After Adding a Product Redirect to OneStepCheckout Page","După adăugarea redirecționării unui produs către pagina OneStepCheckout"
-"All fields have been saved.","Toate câmpurile au fost salvate."
-"Allow Customer Add Other Option","Permiteți clientului să adauge alte opțiuni"
-"Allow Guest Checkout","Permiteți Guest Checkout"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Permiteți verificarea ca oaspete. Vizitatorul poate crea un cont în pagina de control."
-"Allow customer comment in order.","Permiteți comentariile clienților în ordine."
-"Allow customers can billing to a different address from billing address.","Permiteți clienților posibilitatea de facturare la o adresă diferită de adresa de facturare."
-"Amount","Cantitate"
-"Calculate Method","Calculați metoda"
-"Can Show Billing Address","Poate afișa adresa de facturare"
-"Capture+ Key","Captură + cheie"
-"Capture+ by PCA Predict","Capture + by PCA Predict"
-"Checked Newsletter by default","Evaluează Newsletter-ul în mod implicit"
-"Checkout Page Layout","Verificați aspectul paginii"
-"Could not add gift wrap for this quote","Nu s-a putut adăuga înveliș cadou pentru această cotă"
-"Could not remove item from quote","Nu s-a putut elimina un articol din cotație"
-"Could not update item from quote","Nu s-a putut actualiza elementul din citat"
-"Custom Css","Css personalizat"
-"Date Format","Formatul datei"
-"Day/Month/Year","Zi lună an"
-"Days Off","Zile libere"
-"Default","Mod implicit"
-"Default Payment Method","Metoda de plată prestabilită"
-"Default Shipping Method","Metoda de expediere implicită"
-"Delivery Time","Timpul de livrare"
-"Design Configuration","Design Configuration"
-"Design Style","Stilul de design"
-"Display Configuration","Afișare configurație"
-"Enable Delivery Time","Activați ora de livrare"
-"Enable Gift Message","Activați Mesaj cadou"
-"Enable Gift Wrap","Activați Împachetarea cadourilor"
-"Enable One Step Checkout","Activați verificarea la un pas"
-"Enable Social Login On Checkout Page","Activați Login Social pe pagina de control Google Checkout"
-"Enable Survey","Activați Ancheta"
-"Enter the amount of gift wrap fee.","Introduceți suma taxei de împachetare cadou."
-"Error during save field position.","Eroare la salvarea poziției câmpului."
-"Field Management","Managementul terenurilor"
-"Flat","Apartament"
-"General Configuration","Configurație generală"
-"Gift Wrap","Ambalaj pentru cadouri"
-"Google","Google"
-"Google Api Key","Tasta Google Api"
-"HTML allowed","HTML permis"
-"Heading Background Color","Culoarea fundalului de fundal"
-"Heading Text Color","Culoarea textului din titlu"
-"IP Country Lookup","Căutare țara IP"
-"In Payment Area","În zona de plată"
-"In Review Area","În zona de examinare"
-"It will show on success page","Se va afișa pe pagina de succes"
-"Material","Material"
-"Month/Day/Year","Luna zi an"
-"No","Nu"
-"One Step Checkout","Verificarea unui singur pas"
-"One Step Checkout Description","Descrierea unui singur pas"
-"One Step Checkout Page Title","Titlul paginii cu o singură etapă de verificare"
-"One step checkout is turned off.","Verificarea unui pas este dezactivată."
-"Options","Opțiuni"
-"Order Comment","Comanda Comentariu"
-"Order Survey","Sondaj de comandă"
-"Per Item","Pe articol"
-"Per Order","Pe comandă"
-"Place Order button color","Așezați butonul Culoare buton"
-"Restrict the auto suggestion for a specific country","Restricționați sugestia automată pentru o anumită țară"
-"SORTED FIELDS","CÂMPURI CULTATE"
-"Save Position","Salvați poziția"
-"Set default payment method in the checkout process.","Setați metoda de plată implicită în procesul de plată."
-"Set default shipping method in the checkout process.","Setați metoda de livrare implicită în procesul de închidere."
-"Show Discount Code Section","Afișați secțiunea Codul de reducere"
-"Show Login Link","Afișați linkul de conectare"
-"Show Newsletter Checkbox","Afișați caseta de selectare a Newsletter-ului"
-"Show Order Comment","Afișați comanda Comentariu"
-"Show Order Review Section","Afișează secțiunea Review Order"
-"Show Product Thumbnail Image","Afișați imaginea miniatură a produsului"
-"Show Sign up newsletter selection","Afișați înscrierea selecției buletinelor informative"
-"Show Terms and Conditions","Afișați termenii și condițiile"
-"Survey Answers","Sondaj răspunsuri"
-"Survey Question","Întrebarea anchetei"
-"The default country will be set based on location of the customer.","Țara implicită va fi setată pe baza locației clientului."
-"There is an error while subscribing for newsletter.","Există o eroare în timp ce vă abonați la newsletter."
-"To calculate gift wrap fee based on item or order.","Pentru a calcula taxa de împachetare cadou pe baza articolului sau a comenzii."
-"Unable to save order information. Please check input data.","Imposibil de salvat informațiile despre comandă. Verificați datele de intrare."
-"Use Auto Suggestion Technology","Utilizați tehnologia Auto Suggestion"
-"When customer fills address fields, it will suggest a list of full addresses.","Atunci când clientul umple câmpurile de adresă, acesta va sugera o listă de adrese complete."
-"Year/Month/Day","An lună zi"
-"You can disable Order Review Section. It is enabled by default.","Puteți dezactiva secțiunea de examinare a comenzilor. Este activat implicit."
\ No newline at end of file
diff --git a/i18n/ru_RU.csv b/i18n/ru_RU.csv
deleted file mode 100644
index 6a4664c..0000000
--- a/i18n/ru_RU.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Пожалуйста выберите --"
-"1 Column","1 колонка"
-"2 Columns","2 столбца"
-"3 Columns","3 столбца"
-"3 Columns With Colspan","3 колонки с Colspan"
-"Example: .step-title{background-color: #1979c3;}","Пример: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","ДОСТУПНЫЕ ПОЛЯ"
-"Add","Добавить"
-"Additional Content","Дополнительный контент"
-"Additional Information","Дополнительная информация"
-"After Adding a Product Redirect to OneStepCheckout Page","После добавления перенаправления продукта на страницу OneStepCheckout"
-"All fields have been saved.","Все поля сохранены."
-"Allow Customer Add Other Option","Разрешить клиенту добавлять другой вариант"
-"Allow Guest Checkout","Разрешить проверку гостей"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Разрешить проверку в качестве гостя. Гость может создать учетную запись на странице проверки."
-"Allow customer comment in order.","Разрешить комментарий клиента в порядке."
-"Allow customers can billing to a different address from billing address.","Разрешить клиентам биллинг на другой адрес с платежного адреса."
-"Amount","Количество"
-"Calculate Method","Вычислить метод"
-"Can Show Billing Address","Показать выставленный платежный адрес"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + by PCA Predict"
-"Checked Newsletter by default","Проверенный информационный бюллетень по умолчанию"
-"Checkout Page Layout","Оформление макета страницы"
-"Could not add gift wrap for this quote","Не удалось добавить подарочную упаковку для этой цитаты"
-"Could not remove item from quote","Не удалось удалить элемент из цитаты."
-"Could not update item from quote","Не удалось обновить элемент из цитаты."
-"Custom Css","Пользовательские CSS"
-"Date Format","Формат даты"
-"Day/Month/Year","День месяц год"
-"Days Off","Выходные дни"
-"Default","По умолчанию"
-"Default Payment Method","Метод оплаты по умолчанию"
-"Default Shipping Method","Метод доставки по умолчанию"
-"Delivery Time","Срок поставки"
-"Design Configuration","Конфигурация конфигурации"
-"Design Style","Стиль дизайна"
-"Display Configuration","Конфигурация дисплея"
-"Enable Delivery Time","Включить время доставки"
-"Enable Gift Message","Включить подарочное сообщение"
-"Enable Gift Wrap","Включить подарочную упаковку"
-"Enable One Step Checkout","Включить одноэтапную проверку"
-"Enable Social Login On Checkout Page","Включить социальный вход на странице проверки"
-"Enable Survey","Включить опрос"
-"Enter the amount of gift wrap fee.","Введите сумму платы за подачу подарка."
-"Error during save field position.","Ошибка во время сохранения позиции поля."
-"Field Management","Управление полем"
-"Flat","Квартира"
-"General Configuration","Общая конфигурация"
-"Gift Wrap","Подарочная упаковка"
-"Google","Google"
-"Google Api Key","Google Api Key"
-"HTML allowed","HTML разрешен"
-"Heading Background Color","Цвет фона заголовка"
-"Heading Text Color","Цвет текста заголовка"
-"IP Country Lookup","Поиск по странам IP"
-"In Payment Area","В зоне оплаты"
-"In Review Area","В зоне обзора"
-"It will show on success page","Он отобразится на странице успеха"
-"Material","материал"
-"Month/Day/Year","Месяц день год"
-"No","нет"
-"One Step Checkout","Одноэтапная проверка"
-"One Step Checkout Description","Описание One Step Checkout"
-"One Step Checkout Page Title","Одноэтапная покупка Название страницы"
-"One step checkout is turned off.","Однократная проверка выключена."
-"Options","Опции"
-"Order Comment","Комментарий к заказу"
-"Order Survey","Заказать опрос"
-"Per Item","За единицу"
-"Per Order","За заказ"
-"Place Order button color","Цвет кнопки «Заказать заказ»"
-"Restrict the auto suggestion for a specific country","Ограничить автоматическое предложение для конкретной страны"
-"SORTED FIELDS","СОРТИРОВАННЫЕ ПОЛЯ"
-"Save Position","Сохранить позицию"
-"Set default payment method in the checkout process.","Установите способ оплаты по умолчанию в процессе оформления заказа."
-"Set default shipping method in the checkout process.","Установите способ доставки по умолчанию в процессе оформления заказа."
-"Show Discount Code Section","Показать раздел скидочных кодов"
-"Show Login Link","Показать ссылку входа"
-"Show Newsletter Checkbox","Показать новостную рассылку"
-"Show Order Comment","Показать комментарий к заказу"
-"Show Order Review Section","Показать список"
-"Show Product Thumbnail Image","Показать изображение миниатюры продукта"
-"Show Sign up newsletter selection","Показать Подписаться на рассылку новостей"
-"Show Terms and Conditions","Показать условия"
-"Survey Answers","Опрос"
-"Survey Question","Опрос"
-"The default country will be set based on location of the customer.","Страна по умолчанию будет установлена ​​на основе местоположения клиента."
-"There is an error while subscribing for newsletter.","При подписке на информационный бюллетень есть ошибка."
-"To calculate gift wrap fee based on item or order.","Чтобы рассчитать плату за подачу подарка на основе предмета или заказа."
-"Unable to save order information. Please check input data.","Не удалось сохранить информацию о заказе. Проверьте входные данные."
-"Use Auto Suggestion Technology","Использовать технологию автоматического предложения"
-"When customer fills address fields, it will suggest a list of full addresses.","Когда клиент заполняет поля адреса, он предлагает список полных адресов."
-"Year/Month/Day","Год месяц день"
-"You can disable Order Review Section. It is enabled by default.","Вы можете отключить раздел обзора заказов. Он включен по умолчанию."
\ No newline at end of file
diff --git a/i18n/sr_SP.csv b/i18n/sr_SP.csv
deleted file mode 100644
index ef6ddf7..0000000
--- a/i18n/sr_SP.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Молимо изаберите --"
-"1 Column","1 колона"
-"2 Columns","2 колоне"
-"3 Columns","3 колоне"
-"3 Columns With Colspan","3 колоне са Цолспан"
-"Example: .step-title{background-color: #1979c3;}","Пример: .степ-титле {бацкгроунд-цолор: # 1979ц3;}"
-"AVAILABLE FIELDS","АВАИЛАБЛЕ ФИЕЛДС"
-"Add","Додати"
-"Additional Content","Додатни садржај"
-"Additional Information","Додатне Информације"
-"After Adding a Product Redirect to OneStepCheckout Page","Након додавања преусмеравања производа на страницу ОнеСтепЦхецкоут"
-"All fields have been saved.","Сва поља су сачувана."
-"Allow Customer Add Other Option","Дозволи купцу да дода другу опцију"
-"Allow Guest Checkout","Дозволи куповину гостију"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Дозволите да се одјавите као гост. Гост може креирати налог на страници за проверу."
-"Allow customer comment in order.","Дозволи коментар купца у ред."
-"Allow customers can billing to a different address from billing address.","Дозволи корисницима да наплаћују на другу адресу са адресе за плаћање."
-"Amount","Износ"
-"Calculate Method","Израчунајте методу"
-"Can Show Billing Address","Може приказати адресу за обрачун"
-"Capture+ Key","Цаптуре + Кеи"
-"Capture+ by PCA Predict","Цаптуре + би ПЦА Предицт"
-"Checked Newsletter by default","Провјерен билтен је подразумевано"
-"Checkout Page Layout","Цхецкоут Паге Лаиоут"
-"Could not add gift wrap for this quote","Није могуће додати поклон поклона за овај цитат"
-"Could not remove item from quote","Није могуће уклонити ставку из цитата"
-"Could not update item from quote","Није могуће ажурирати ставку из цитата"
-"Custom Css","Цустом Цсс"
-"Date Format","Формат датума"
-"Day/Month/Year","Дан / Месец / Година"
-"Days Off","Даис офф"
-"Default","Уобичајено"
-"Default Payment Method","Подразумевани метод плаћања"
-"Default Shipping Method","Подразумевано метод испоруке"
-"Delivery Time","Време испоруке"
-"Design Configuration","Конфигурација дизајна"
-"Design Style","Стил дизајна"
-"Display Configuration","Конфигурација екрана"
-"Enable Delivery Time","Омогућите време испоруке"
-"Enable Gift Message","Омогућите поклон поруку"
-"Enable Gift Wrap","Омогући Гифт Врап"
-"Enable One Step Checkout","Омогућите Цхецкоут Оне Степ"
-"Enable Social Login On Checkout Page","Омогућите друштвену пријаву на благајни"
-"Enable Survey","Омогућите Анкету"
-"Enter the amount of gift wrap fee.","Унесите износ накнаде за поклон поклона."
-"Error during save field position.","Грешка приликом уштеде поља."
-"Field Management","Фиелд Манагемент"
-"Flat","Раван"
-"General Configuration","Општа конфигурација"
-"Gift Wrap","Украсни папир"
-"Google","Гоогле"
-"Google Api Key","Гоогле Апи Кеи"
-"HTML allowed","ХТМЛ дозвољен"
-"Heading Background Color","Хеадинг Бацкгроунд Цолор"
-"Heading Text Color","Боја наслова заглавља"
-"IP Country Lookup","ИП Цоунтри Лоокуп"
-"In Payment Area","У области плаћања"
-"In Review Area","У области прегледа"
-"It will show on success page","Показаће се на страници о успеху"
-"Material","Материјал"
-"Month/Day/Year","Месец дан година"
-"No","Не"
-"One Step Checkout","Један корак Цхецкоут"
-"One Step Checkout Description","Један Цхецк Цхецкоут Опис"
-"One Step Checkout Page Title","Наслов књиге за један корак Цхецкоут"
-"One step checkout is turned off.","Искључивање једне кораке је искључено."
-"Options","Опције"
-"Order Comment","Наручите коментар"
-"Order Survey","Анкета налога"
-"Per Item","По ставци"
-"Per Order","По поруџбини"
-"Place Order button color","Поставите боју дугмета"
-"Restrict the auto suggestion for a specific country","Ограничите ауто-предлог за одређену земљу"
-"SORTED FIELDS","СОРТИРАНИ ПОЉЕ"
-"Save Position","Сачувај позицију"
-"Set default payment method in the checkout process.","Подесите подразумевани метод плаћања у поступку провере."
-"Set default shipping method in the checkout process.","Постави подразумевани метод испоруке у процесу провере."
-"Show Discount Code Section","Прикажи одељак о дисконтном коду"
-"Show Login Link","Прикажи везу за пријаву"
-"Show Newsletter Checkbox","Прикажи билтен за потврду"
-"Show Order Comment","Прикажи коментар о наруџби"
-"Show Order Review Section","Прикажи одељак за преглед налога"
-"Show Product Thumbnail Image","Прикажи слику производа"
-"Show Sign up newsletter selection","Прикажи Сигн уп избор билтена"
-"Show Terms and Conditions","Прикажи одредбе и услове"
-"Survey Answers","Одговори на истраживање"
-"Survey Question","Анкетно питање"
-"The default country will be set based on location of the customer.","Подразумевана земља ће бити подешена на основу локације купца."
-"There is an error while subscribing for newsletter.","Постоји грешка приликом претплате за билтен."
-"To calculate gift wrap fee based on item or order.","Да бисте израчунали накнаду за поклон поклона на основу предмета или налога."
-"Unable to save order information. Please check input data.","Није могуће сачувати информације о поруџбини. Проверите улазне податке."
-"Use Auto Suggestion Technology","Користите технологију аутоматског предлажења"
-"When customer fills address fields, it will suggest a list of full addresses.","Када корисник попуни поља за адресу, предложиће вам попис потпуних адреса."
-"Year/Month/Day","Година / Месец / Дан"
-"You can disable Order Review Section. It is enabled by default.","Можете искључити Одјељење за преглед налога. Подразумевано је омогућено."
\ No newline at end of file
diff --git a/i18n/sv_SE.csv b/i18n/sv_SE.csv
deleted file mode 100644
index bf938ec..0000000
--- a/i18n/sv_SE.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Vänligen välj --"
-"1 Column","1 kolumn"
-"2 Columns","2 kolumner"
-"3 Columns","3 kolumner"
-"3 Columns With Colspan","3 kolumner med Colspan"
-"Example: .step-title{background-color: #1979c3;}","Exempel: .step-titel {bakgrundsfärg: # 1979c3;}"
-"AVAILABLE FIELDS","Tillgängliga områden"
-"Add","Lägg till"
-"Additional Content","Ytterligare innehåll"
-"Additional Information","ytterligare information"
-"After Adding a Product Redirect to OneStepCheckout Page","Efter att ha lagt till en produktomdirigering till OneStepCheckout-sida"
-"All fields have been saved.","Alla fält har sparats."
-"Allow Customer Add Other Option","Tillåt kunden lägga till andra alternativ"
-"Allow Guest Checkout","Tillåt gästcheckning"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Tillåt att kolla som gäst. Gäst kan skapa ett konto på kassan."
-"Allow customer comment in order.","Tillåt kundkommentar i ordning."
-"Allow customers can billing to a different address from billing address.","Tillåt kunderna att fakturera till en annan adress från faktureringsadressen."
-"Amount","mängd"
-"Calculate Method","Beräkna Metod"
-"Can Show Billing Address","Kan visa faktureringsadress"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Capture + genom PCA Predict"
-"Checked Newsletter by default","Kontrollerad Nyhetsbrev som standard"
-"Checkout Page Layout","Kassa Sidlayout"
-"Could not add gift wrap for this quote","Kunde inte lägga till presentförpackning för detta citat"
-"Could not remove item from quote","Det gick inte att ta bort objekt från citat"
-"Could not update item from quote","Kunde inte uppdatera objekt från citat"
-"Custom Css","Anpassad Css"
-"Date Format","Datumformat"
-"Day/Month/Year","Dag månad år"
-"Days Off","Lediga dagar"
-"Default","Standard"
-"Default Payment Method","Standard betalningsmetod"
-"Default Shipping Method","Standard leveransmetod"
-"Delivery Time","Leveranstid"
-"Design Configuration","Designkonfiguration"
-"Design Style","Designstil"
-"Display Configuration","Display Configuration"
-"Enable Delivery Time","Aktivera leveranstid"
-"Enable Gift Message","Aktivera presentationsmeddelande"
-"Enable Gift Wrap","Aktivera presentförpackning"
-"Enable One Step Checkout","Aktivera ett steg Kassa"
-"Enable Social Login On Checkout Page","Aktivera social inloggning på kassan"
-"Enable Survey","Aktivera undersökning"
-"Enter the amount of gift wrap fee.","Ange mängden presentavgift."
-"Error during save field position.","Fel vid spara fältposition."
-"Field Management","Fälthantering"
-"Flat","Platt"
-"General Configuration","Allmän konfiguration"
-"Gift Wrap","Presentpapper"
-"Google","Google"
-"Google Api Key","Google Api-nyckel"
-"HTML allowed","HTML tillåtet"
-"Heading Background Color","Rubrik Bakgrundsfärg"
-"Heading Text Color","Rubrik Textfärg"
-"IP Country Lookup","IP-landsökning"
-"In Payment Area","I Betalningsområdet"
-"In Review Area","I granskningsområdet"
-"It will show on success page","Det kommer att visas på framgångssidan"
-"Material","Material"
-"Month/Day/Year","Månad dag år"
-"No","Nej"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","One Step Checkout Beskrivning"
-"One Step Checkout Page Title","One Step Checkout Sida Titel"
-"One step checkout is turned off.","Ett stegs kassan är avstängd."
-"Options","alternativ"
-"Order Comment","Beställ kommentar"
-"Order Survey","Orderundersökning"
-"Per Item","Per styck"
-"Per Order","Per order"
-"Place Order button color","Placera beställningsknappens färg"
-"Restrict the auto suggestion for a specific country","Begränsa automatisk förslag till ett visst land"
-"SORTED FIELDS","SORTADE OMRÅDEN"
-"Save Position","Spara position"
-"Set default payment method in the checkout process.","Ange standard betalningsmetod i kassan."
-"Set default shipping method in the checkout process.","Ange standard leveransmetod i kassan."
-"Show Discount Code Section","Visa rabattkodsavsnitt"
-"Show Login Link","Visa inloggningslänk"
-"Show Newsletter Checkbox","Visa nyhetsbrev kryssrutan"
-"Show Order Comment","Visa orderkommentar"
-"Show Order Review Section","Visa Order Review Section"
-"Show Product Thumbnail Image","Visa produktminnebild"
-"Show Sign up newsletter selection","Visa Registrera nyhetsbrev val"
-"Show Terms and Conditions","Visa villkoren"
-"Survey Answers","Survey Answers"
-"Survey Question","Undersökningsfråga"
-"The default country will be set based on location of the customer.","Standardlandet kommer att ställas in baserat på kundens plats."
-"There is an error while subscribing for newsletter.","Det finns ett fel när du prenumererar på nyhetsbrev."
-"To calculate gift wrap fee based on item or order.","Att beräkna presentavgiften baserad på objekt eller order."
-"Unable to save order information. Please check input data.","Det gick inte att spara orderinformation. Kontrollera inmatningsdata."
-"Use Auto Suggestion Technology","Använd Auto Suggestion Technology"
-"When customer fills address fields, it will suggest a list of full addresses.","När kundfyller adressfält kommer det att föreslå en lista över fullständiga adresser."
-"Year/Month/Day","År månad dag"
-"You can disable Order Review Section. It is enabled by default.","Du kan inaktivera Order Review Section. Den är aktiverad som standard."
\ No newline at end of file
diff --git a/i18n/tr_TR.csv b/i18n/tr_TR.csv
deleted file mode 100644
index 273ba0f..0000000
--- a/i18n/tr_TR.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Lütfen seçin --"
-"1 Column","1 sütun"
-"2 Columns","2 sütun"
-"3 Columns","3 sütun"
-"3 Columns With Colspan","Colspan'lı 3 Sütun"
-"Example: .step-title{background-color: #1979c3;}","Örnek: .step-başlık {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","MEVCUT ALANLAR"
-"Add","Eklemek"
-"Additional Content","Ek İçerik"
-"Additional Information","ek bilgi"
-"After Adding a Product Redirect to OneStepCheckout Page","Bir Ürün Ekledikten Sonra OneStepCheckout Sayfasına Yönlendirme"
-"All fields have been saved.","Tüm alanlar kaydedildi."
-"Allow Customer Add Other Option","Müşterinin Diğer Seçenek Eklemesine İzin Ver"
-"Allow Guest Checkout","Konuk Checkout'a İzin Ver"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Konuk olarak check out yapmaya izin ver. Konuk, ödeme sayfasında bir hesap oluşturabilir."
-"Allow customer comment in order.","Müşterinin yorumuna sırayla izin verin."
-"Allow customers can billing to a different address from billing address.","Müşterilerin faturalandırma adresinden farklı bir adrese faturalandırma yapmasına izin verin."
-"Amount","Tutar"
-"Calculate Method","Hesaplama Yöntemi"
-"Can Show Billing Address","Fatura Adresi Gösterilebilir"
-"Capture+ Key","Yakalama + Anahtar"
-"Capture+ by PCA Predict","PCA Öngörüsü ile Yakalama +"
-"Checked Newsletter by default","Varsayılan olarak Kontrol Edilen Haber Bülteni"
-"Checkout Page Layout","Ödeme Sayfası Düzeni"
-"Could not add gift wrap for this quote","Bu teklif için hediye paketi eklenemedi"
-"Could not remove item from quote","Öğe alıntıdan kaldırılamadı"
-"Could not update item from quote","Alıntıdan öğe güncelleştirilemedi"
-"Custom Css","Özel Css"
-"Date Format","Tarih formatı"
-"Day/Month/Year","Gün ay yıl"
-"Days Off","İzin günleri"
-"Default","Varsayılan"
-"Default Payment Method","Varsayılan Ödeme Yöntemi"
-"Default Shipping Method","Varsayılan Nakliye Yöntemi"
-"Delivery Time","Teslimat süresi"
-"Design Configuration","Tasarım Konfigürasyonu"
-"Design Style","Tasarım Stili"
-"Display Configuration","Ekran Yapılandırması"
-"Enable Delivery Time","Teslim Süresini Etkinleştir"
-"Enable Gift Message","Hediye İletisini Etkinleştir"
-"Enable Gift Wrap","Hediye Paketini Etkinleştir"
-"Enable One Step Checkout","Bir Adımlı Ödemeyi Etkinleştir"
-"Enable Social Login On Checkout Page","Ödeme Sayfasında Sosyal Oturumu Etkinleştir"
-"Enable Survey","Anketi etkinleştir"
-"Enter the amount of gift wrap fee.","Hediye paketleme ücreti miktarını girin."
-"Error during save field position.","Kayıt yeri konumu sırasında hata oluştu."
-"Field Management","Alan Yönetimi"
-"Flat","Düz"
-"General Configuration","Genel Yapılandırma"
-"Gift Wrap","Hediye paketi"
-"Google","Google"
-"Google Api Key","Google Api Anahtarı"
-"HTML allowed","Izin verilen HTML"
-"Heading Background Color","Başlık Arka Planı Rengi"
-"Heading Text Color","Başlık Metin Rengi"
-"IP Country Lookup","IP Ülke Araştırması"
-"In Payment Area","Ödeme Bölgesi'nde"
-"In Review Area","İnceleme Alanında"
-"It will show on success page","Başarı sayfasında gösterilecek"
-"Material","Malzeme"
-"Month/Day/Year","Ay gün yıl"
-"No","Yok hayır"
-"One Step Checkout","Bir Adım Kontrolü"
-"One Step Checkout Description","Bir Adım Kontrolü Açıklaması"
-"One Step Checkout Page Title","Bir Adım Kontrolü Sayfa Başlığı"
-"One step checkout is turned off.","Bir adımla ödeme kapalı."
-"Options","Seçenekler"
-"Order Comment","Sipariş Yorum"
-"Order Survey","Sipariş Anketi"
-"Per Item","Madde başına"
-"Per Order","Sipariş Başına"
-"Place Order button color","Sipariş Ver düğmesi rengi"
-"Restrict the auto suggestion for a specific country","Belirli bir ülkenin otomatik önerisini kısıtla"
-"SORTED FIELDS","SIRALI ALANLAR"
-"Save Position","Konumu Kaydet"
-"Set default payment method in the checkout process.","Ödeme işleminde varsayılan ödeme yöntemini ayarlayın."
-"Set default shipping method in the checkout process.","Ödeme işleminde varsayılan gönderim yöntemi ayarlayın."
-"Show Discount Code Section","İndirim Kod Bölümünü Göster"
-"Show Login Link","Giriş Bağlantısını Göster"
-"Show Newsletter Checkbox","Haber bültenini onay kutusunu göster"
-"Show Order Comment","Sipariş Kodunu Göster"
-"Show Order Review Section","Siparişi Göster İnceleme Bölümü"
-"Show Product Thumbnail Image","Ürün Küçük Resim Göster"
-"Show Sign up newsletter selection","Göster Kayıt bülteni seçimi"
-"Show Terms and Conditions","Şartlar ve Koşulları Göster"
-"Survey Answers","Anket Yanıtları"
-"Survey Question","Anket Sorusu"
-"The default country will be set based on location of the customer.","Varsayılan ülke, müşterinin bulunduğu yere göre belirlenecektir."
-"There is an error while subscribing for newsletter.","Haber bültenine abone olurken bir hata var."
-"To calculate gift wrap fee based on item or order.","Maddeye veya siparişe göre hediye paketi ücreti hesaplamak."
-"Unable to save order information. Please check input data.","Sipariş bilgileri kaydedilemiyor. Lütfen giriş verilerini kontrol edin."
-"Use Auto Suggestion Technology","Otomatik Öneri Teknolojisini Kullan"
-"When customer fills address fields, it will suggest a list of full addresses.","Müşteri adres alanlarını doldurduğunda, tam adreslerin bir listesi önermektedir."
-"Year/Month/Day","Yıl ay gün"
-"You can disable Order Review Section. It is enabled by default.","Sipariş Gözden Geçirme Bölümünü devre dışı bırakabilirsiniz. Varsayılan olarak etkindir."
\ No newline at end of file
diff --git a/i18n/uk_UA.csv b/i18n/uk_UA.csv
deleted file mode 100644
index 5f003ad..0000000
--- a/i18n/uk_UA.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Виберіть будь ласка --"
-"1 Column","1 стовпчик"
-"2 Columns","2 стовпці"
-"3 Columns","3 стовпці"
-"3 Columns With Colspan","3 стовпці з Colspan"
-"Example: .step-title{background-color: #1979c3;}","Приклад: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","НАСТУПНІ ПОЛЯ"
-"Add","Додати"
-"Additional Content","Додатковий вміст"
-"Additional Information","Додаткова інформація"
-"After Adding a Product Redirect to OneStepCheckout Page","Після додавання перенаправлення продукту на сторінку OneStepCheckout"
-"All fields have been saved.","Усі поля були збережені."
-"Allow Customer Add Other Option","Дозволити клієнту додавати інший варіант"
-"Allow Guest Checkout","Дозволити гостьовий оформити замовлення"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Дозволити перевірку як гостя. Гість може створити обліковий запис на сторінці оформлення замовлення."
-"Allow customer comment in order.","Дозволити коментар клієнта у порядку."
-"Allow customers can billing to a different address from billing address.","Дозволити клієнтам здійснювати виставлення рахунків за іншою адресою із платіжної адреси."
-"Amount","Сума"
-"Calculate Method","Обчислити метод"
-"Can Show Billing Address","Можна відображати адресу для оплати"
-"Capture+ Key","Capture + Key"
-"Capture+ by PCA Predict","Захоплення + за допомогою PCA Predict"
-"Checked Newsletter by default","За замовчуванням перевірений бюлетень"
-"Checkout Page Layout","Макет оформлення оформлення замовлення"
-"Could not add gift wrap for this quote","Не вдалося додати подарункову упаковку для цієї цитати"
-"Could not remove item from quote","Не вдалося видалити елемент із цитата"
-"Could not update item from quote","Не вдалось оновити елемент із цитата"
-"Custom Css","Custom CSS"
-"Date Format","Формат дати"
-"Day/Month/Year","День / місяць / рік"
-"Days Off","Вихідні дні"
-"Default","За замовчуванням"
-"Default Payment Method","Стандартний метод платежу"
-"Default Shipping Method","Стандартний метод доставки"
-"Delivery Time","Час доставки"
-"Design Configuration","Конфігурація дизайну"
-"Design Style","Стиль дизайну"
-"Display Configuration","Конфігурація дисплея"
-"Enable Delivery Time","Увімкнути час доставки"
-"Enable Gift Message","Увімкнути подарункове повідомлення"
-"Enable Gift Wrap","Увімкнути подарункову упаковку"
-"Enable One Step Checkout","Увімкнути One-Step Checkout"
-"Enable Social Login On Checkout Page","Увімкнути соціальний вхід на сторінці оформлення"
-"Enable Survey","Увімкнути опитування"
-"Enter the amount of gift wrap fee.","Введіть суму подарункової упаковки."
-"Error during save field position.","Помилка під час поля збереження поля."
-"Field Management","Управління на місцях"
-"Flat","Квартира"
-"General Configuration","Загальна конфігурація"
-"Gift Wrap","Подарункова упаковка"
-"Google","Google"
-"Google Api Key","Google Апі Ключ"
-"HTML allowed","HTML дозволено"
-"Heading Background Color","Колір тла заголовка"
-"Heading Text Color","Колір тексту заголовка"
-"IP Country Lookup","IP Lookup"
-"In Payment Area","В області платежів"
-"In Review Area","У зоні огляду"
-"It will show on success page","Він буде показуватися на сторінці успіху"
-"Material","Матеріал"
-"Month/Day/Year","Місяць / день / рік"
-"No","Немає"
-"One Step Checkout","One Step Checkout"
-"One Step Checkout Description","Опис одного кроку"
-"One Step Checkout Page Title","Заголовок сторінки за квитком"
-"One step checkout is turned off.","Квиток на один крок вимкнено."
-"Options","Параметри"
-"Order Comment","Замовити коментар"
-"Order Survey","Огляд замовлення"
-"Per Item","За одиницю"
-"Per Order","На замовлення"
-"Place Order button color","Колір кнопки ""Місце замовлення"""
-"Restrict the auto suggestion for a specific country","Обмежте автоматичну пропозицію для певної країни"
-"SORTED FIELDS","СОРТИРОВАНІ ПОЛЯ"
-"Save Position","Зберегти позицію"
-"Set default payment method in the checkout process.","Вкажіть спосіб оплати за замовчуванням за умовчанням."
-"Set default shipping method in the checkout process.","Вкажіть метод доставки за умовчанням в процесі оформлення замовлення."
-"Show Discount Code Section","Показати розділ коду дисконту"
-"Show Login Link","Показ посилання на вхід"
-"Show Newsletter Checkbox","Показувати інформаційний бюлетень"
-"Show Order Comment","Показати коментар замовлення"
-"Show Order Review Section","Показати розділ перегляду замовлень"
-"Show Product Thumbnail Image","Показати мініатюру продукту"
-"Show Sign up newsletter selection","Показати підпис підпис на розсилку новин"
-"Show Terms and Conditions","Показати Загальні положення та умови"
-"Survey Answers","Опитування Відповіді"
-"Survey Question","Питання опитування"
-"The default country will be set based on location of the customer.","Країна за замовчуванням буде встановлена ​​залежно від місцезнаходження покупця."
-"There is an error while subscribing for newsletter.","Під час підписки на інформаційний бюлетень виникла помилка."
-"To calculate gift wrap fee based on item or order.","Для розрахунку вартості подарункової упаковки в залежності від предмета або замовлення."
-"Unable to save order information. Please check input data.","Не вдається зберегти інформацію про замовлення. Будь ласка, перевірте вхідні дані."
-"Use Auto Suggestion Technology","Використовуйте технологію автоматичного пропозицію"
-"When customer fills address fields, it will suggest a list of full addresses.","Коли користувач заповнює поля адреси, він запропонує список повних адрес."
-"Year/Month/Day","Рік / місяць / день"
-"You can disable Order Review Section. It is enabled by default.","Ви можете вимкнути розділ перегляду замовлень. Вона ввімкнена за замовчуванням."
\ No newline at end of file
diff --git a/i18n/vi_VN.csv b/i18n/vi_VN.csv
deleted file mode 100644
index 9c451e2..0000000
--- a/i18n/vi_VN.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-- Vui lòng chọn --"
-"1 Column","1 Cột"
-"2 Columns","2 cột"
-"3 Columns","3 Cột"
-"3 Columns With Colspan","3 Cột Với ​​Colspan"
-"Example: .step-title{background-color: #1979c3;}","Ví dụ: .step-title {background-color: # 1979c3;}"
-"AVAILABLE FIELDS","CÁC ĐIỂM CÓ S AVN CÓ"
-"Add","Thêm vào"
-"Additional Content","Nội dung bổ sung"
-"Additional Information","thông tin thêm"
-"After Adding a Product Redirect to OneStepCheckout Page","Sau khi Thêm Sản phẩm Chuyển hướng đến Trang OneStepCheckout"
-"All fields have been saved.","Tất cả các trường đã được lưu."
-"Allow Customer Add Other Option","Cho phép khách hàng Thêm tùy chọn khác"
-"Allow Guest Checkout","Cho phép Checkout của Khách"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","Cho phép kiểm tra là khách. Khách có thể tạo một tài khoản trong trang thanh toán."
-"Allow customer comment in order.","Cho phép nhận xét của khách hàng theo thứ tự."
-"Allow customers can billing to a different address from billing address.","Cho phép khách hàng có thể thanh toán cho một địa chỉ khác từ địa chỉ thanh toán."
-"Amount","Số tiền"
-"Calculate Method","Tính Phương pháp"
-"Can Show Billing Address","Có thể hiển thị địa chỉ thanh toán"
-"Capture+ Key","Phím Capture +"
-"Capture+ by PCA Predict","Capture + bởi PCA Predict"
-"Checked Newsletter by default","Bản tin Kiểm tra theo mặc định"
-"Checkout Page Layout","Giao diện Trang Thanh toán"
-"Could not add gift wrap for this quote","Không thể thêm gói quà tặng cho báo giá này"
-"Could not remove item from quote","Không thể xóa mục khỏi báo giá"
-"Could not update item from quote","Không thể cập nhật mục từ báo giá"
-"Custom Css","Css Tuỳ chỉnh"
-"Date Format","Định dạng ngày tháng"
-"Day/Month/Year","Ngày tháng năm"
-"Days Off","Ngày nghỉ"
-"Default","Mặc định"
-"Default Payment Method","Phương thức thanh toán mặc định"
-"Default Shipping Method","Mặc định Phương thức vận chuyển"
-"Delivery Time","Thời gian giao hàng"
-"Design Configuration","Thiết kế Cấu hình"
-"Design Style","Phong cách thiết kế"
-"Display Configuration","Cấu hình hiển thị"
-"Enable Delivery Time","Bật Thời gian giao hàng"
-"Enable Gift Message","Bật Thông báo quà tặng"
-"Enable Gift Wrap","Bật gói quà tặng"
-"Enable One Step Checkout","Bật một bước Checkout"
-"Enable Social Login On Checkout Page","Bật đăng nhập xã hội trên trang Thanh toán"
-"Enable Survey","Bật khảo sát"
-"Enter the amount of gift wrap fee.","Nhập số tiền gói quà."
-"Error during save field position.","Lỗi trong thời gian lưu trường."
-"Field Management","Quản lý thực địa"
-"Flat","Bằng phẳng"
-"General Configuration","Cấu hình chung"
-"Gift Wrap","Gói quà"
-"Google","Google"
-"Google Api Key","Khóa Google Api"
-"HTML allowed","HTML được phép"
-"Heading Background Color","Màu nền tiêu đề"
-"Heading Text Color","Tiêu đề màu văn bản"
-"IP Country Lookup","Tra cứu quốc gia IP"
-"In Payment Area","Trong Khu vực thanh toán"
-"In Review Area","Trong vùng đánh giá"
-"It will show on success page","Nó sẽ hiển thị trên trang thành công"
-"Material","Vật chất"
-"Month/Day/Year","Tháng ngày năm"
-"No","Không"
-"One Step Checkout","Một bước Thanh toán"
-"One Step Checkout Description","Một bước Thanh toán Mô tả"
-"One Step Checkout Page Title","Một Trang Checkout Trang Tiêu đề"
-"One step checkout is turned off.","Một bước thanh toán đã bị tắt."
-"Options","Tùy chọn"
-"Order Comment","Đặt hàng Bình luận"
-"Order Survey","Đặt hàng Khảo sát"
-"Per Item","Mỗi mục"
-"Per Order","Mỗi đơn đặt hàng"
-"Place Order button color","Đặt nút nút màu"
-"Restrict the auto suggestion for a specific country","Hạn chế đề xuất tự động cho một quốc gia cụ thể"
-"SORTED FIELDS","CÁC L SNH VỰC SORTED"
-"Save Position","Lưu vị trí"
-"Set default payment method in the checkout process.","Thiết lập phương thức thanh toán mặc định trong quá trình thanh toán."
-"Set default shipping method in the checkout process.","Thiết lập phương thức vận chuyển mặc định trong quá trình thanh toán."
-"Show Discount Code Section","Hiển thị phần mã giảm giá"
-"Show Login Link","Hiển thị liên kết đăng nhập"
-"Show Newsletter Checkbox","Showbox Checkbox"
-"Show Order Comment","Hiển thị Nhận xét Yêu cầu"
-"Show Order Review Section","Hiển thị Phần đánh giá Đặt hàng"
-"Show Product Thumbnail Image","Hiển thị hình ảnh thu nhỏ của sản phẩm"
-"Show Sign up newsletter selection","Hiển thị Đăng ký nhận bản tin"
-"Show Terms and Conditions","Hiển thị Điều khoản và Điều kiện"
-"Survey Answers","Câu hỏi khảo sát"
-"Survey Question","Câu hỏi điều tra"
-"The default country will be set based on location of the customer.","Quốc gia mặc định sẽ được đặt dựa trên vị trí của khách hàng."
-"There is an error while subscribing for newsletter.","Đã xảy ra lỗi khi đăng ký bản tin."
-"To calculate gift wrap fee based on item or order.","Để tính phí bọc quà tặng dựa trên mặt hàng hoặc đơn đặt hàng."
-"Unable to save order information. Please check input data.","Không thể lưu thông tin đơn hàng. Vui lòng kiểm tra dữ liệu nhập."
-"Use Auto Suggestion Technology","Sử dụng Công nghệ Tự gợi ý"
-"When customer fills address fields, it will suggest a list of full addresses.","Khi khách hàng điền vào các trường địa chỉ, nó sẽ đề xuất một danh sách các địa chỉ đầy đủ."
-"Year/Month/Day","Năm tháng ngày"
-"You can disable Order Review Section. It is enabled by default.","Bạn có thể vô hiệu hóa Mục Đánh giá Đặt hàng. Nó được kích hoạt mặc định."
\ No newline at end of file
diff --git a/i18n/zh_CN.csv b/i18n/zh_CN.csv
deleted file mode 100644
index 0b730d9..0000000
--- a/i18n/zh_CN.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-  请选择  -"
-"1 Column","1列"
-"2 Columns","2列"
-"3 Columns","3列"
-"3 Columns With Colspan","3列与Colspan"
-"Example: .step-title{background-color: #1979c3;}","示例：.step-title {background-color：＃1979c3;}"
-"AVAILABLE FIELDS","可用的字段"
-"Add","加"
-"Additional Content","附加内容"
-"Additional Information","附加信息"
-"After Adding a Product Redirect to OneStepCheckout Page","将产品重定向添加到OneStepCheckout页面之后"
-"All fields have been saved.","所有字段已保存。"
-"Allow Customer Add Other Option","允许客户添加其他选项"
-"Allow Guest Checkout","允许访客结帐"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","允许作为客人退房客人可以在结帐页面中创建一个帐户。"
-"Allow customer comment in order.","允许客户评论。"
-"Allow customers can billing to a different address from billing address.","允许客户可以从帐单地址计费到不同的地址。"
-"Amount","量"
-"Calculate Method","计算方法"
-"Can Show Billing Address","可显示帐单地址"
-"Capture+ Key","捕获+键"
-"Capture+ by PCA Predict","捕捉+由PCA预测"
-"Checked Newsletter by default","预设通讯录"
-"Checkout Page Layout","结帐页面布局"
-"Could not add gift wrap for this quote","无法为此报价添加礼物包装"
-"Could not remove item from quote","无法从报价中删除项目"
-"Could not update item from quote","无法从报价更新料品"
-"Custom Css","自定义Css"
-"Date Format","日期格式"
-"Day/Month/Year","日月年"
-"Days Off","休息日"
-"Default","默认"
-"Default Payment Method","默认付款方式"
-"Default Shipping Method","默认送货方式"
-"Delivery Time","交货时间"
-"Design Configuration","设计配置"
-"Design Style","设计风格"
-"Display Configuration","显示配置"
-"Enable Delivery Time","启用交货时间"
-"Enable Gift Message","启用礼品讯息"
-"Enable Gift Wrap","启用礼品包装"
-"Enable One Step Checkout","启用一步结帐"
-"Enable Social Login On Checkout Page","在Checkout页面上启用社交登录"
-"Enable Survey","启用调查"
-"Enter the amount of gift wrap fee.","输入礼品包裹金额。"
-"Error during save field position.","保存字段位置时出错。"
-"Field Management","现场管理"
-"Flat","平面"
-"General Configuration","一般配置"
-"Gift Wrap","礼品包装"
-"Google","谷歌"
-"Google Api Key","Google Api密钥"
-"HTML allowed","允许HTML"
-"Heading Background Color","标题背景颜色"
-"Heading Text Color","标题文字颜色"
-"IP Country Lookup","IP国家查询"
-"In Payment Area","在付款区域"
-"In Review Area","在审查区域"
-"It will show on success page","它将在成功页面上显示"
-"Material","材料"
-"Month/Day/Year","月日年"
-"No","没有"
-"One Step Checkout","一步结帐"
-"One Step Checkout Description","一步结帐说明"
-"One Step Checkout Page Title","一步结帐页面标题"
-"One step checkout is turned off.","一步结帐关闭。"
-"Options","选项"
-"Order Comment","订单评论"
-"Order Survey","订单调查"
-"Per Item","每件"
-"Per Order","按订单"
-"Place Order button color","放置订单按钮颜色"
-"Restrict the auto suggestion for a specific country","限制特定国家/地区的汽车建议"
-"SORTED FIELDS","已分配的字段"
-"Save Position","保存位置"
-"Set default payment method in the checkout process.","在结帐过程中设置默认付款方式。"
-"Set default shipping method in the checkout process.","在结帐过程中设置默认送货方式。"
-"Show Discount Code Section","显示折扣代码部分"
-"Show Login Link","显示登录链接"
-"Show Newsletter Checkbox","显示新闻复选框"
-"Show Order Comment","显示订单评论"
-"Show Order Review Section","显示订单审查部分"
-"Show Product Thumbnail Image","显示产品缩略图"
-"Show Sign up newsletter selection","显示注册通讯选择"
-"Show Terms and Conditions","显示条款和条件"
-"Survey Answers","调查答案"
-"Survey Question","调查问题"
-"The default country will be set based on location of the customer.","默认国家将根据客户的位置进行设置。"
-"There is an error while subscribing for newsletter.","订阅通讯时出现错误。"
-"To calculate gift wrap fee based on item or order.","根据物品或订单计算礼品包装费。"
-"Unable to save order information. Please check input data.","无法保存订单信息。请检查输入数据。"
-"Use Auto Suggestion Technology","使用自动建议技术"
-"When customer fills address fields, it will suggest a list of full addresses.","当客户填写地址字段时，它会建议一个完整地址列表。"
-"Year/Month/Day","年月日"
-"You can disable Order Review Section. It is enabled by default.","您可以禁用订单审查部分。默认情况下启用。"
\ No newline at end of file
diff --git a/i18n/zh_TW.csv b/i18n/zh_TW.csv
deleted file mode 100644
index 6eef6dc..0000000
--- a/i18n/zh_TW.csv
+++ /dev/null
@@ -1,95 +0,0 @@
-"-- Please select --","-  請選擇  -"
-"1 Column","1列"
-"2 Columns","2列"
-"3 Columns","3列"
-"3 Columns With Colspan","3列與Colspan"
-"Example: .step-title{background-color: #1979c3;}","示例：.step-title {background-color：＃1979c3;}"
-"AVAILABLE FIELDS","可用的字段"
-"Add","加"
-"Additional Content","附加內容"
-"Additional Information","附加信息"
-"After Adding a Product Redirect to OneStepCheckout Page","將產品重定向添加到OneStepCheckout頁面之後"
-"All fields have been saved.","所有字段已保存。"
-"Allow Customer Add Other Option","允許客戶添加其他選項"
-"Allow Guest Checkout","允許訪客結帳"
-"Allow checking out as a guest. Guest can create an account in the checkout page.","允許作為客人退房客人可以在結帳頁面中創建一個帳戶。"
-"Allow customer comment in order.","允許客戶評論。"
-"Allow customers can billing to a different address from billing address.","允許客戶可以從帳單地址計費到不同的地址。"
-"Amount","量"
-"Calculate Method","計算方法"
-"Can Show Billing Address","可顯示帳單地址"
-"Capture+ Key","捕獲+鍵"
-"Capture+ by PCA Predict","捕捉+由PCA預測"
-"Checked Newsletter by default","預設通訊錄"
-"Checkout Page Layout","結帳頁面佈局"
-"Could not add gift wrap for this quote","無法為此報價添加禮物包裝"
-"Could not remove item from quote","無法從報價中刪除項目"
-"Could not update item from quote","無法從報價更新料品"
-"Custom Css","自定義Css"
-"Date Format","日期格式"
-"Day/Month/Year","日月年"
-"Days Off","休息日"
-"Default","默認"
-"Default Payment Method","默認付款方式"
-"Default Shipping Method","默認送貨方式"
-"Delivery Time","交貨時間"
-"Design Configuration","設計配置"
-"Design Style","設計風格"
-"Display Configuration","顯示配置"
-"Enable Delivery Time","啟用交貨時間"
-"Enable Gift Message","啟用禮品訊息"
-"Enable Gift Wrap","啟用禮品包裝"
-"Enable One Step Checkout","啟用一步結帳"
-"Enable Social Login On Checkout Page","在Checkout頁面上啟用社交登錄"
-"Enable Survey","啟用調查"
-"Enter the amount of gift wrap fee.","輸入禮品包裹金額。"
-"Error during save field position.","保存字段位置時出錯。"
-"Field Management","現場管理"
-"Flat","平面"
-"General Configuration","一般配置"
-"Gift Wrap","禮品包裝"
-"Google","谷歌"
-"Google Api Key","Google Api密鑰"
-"HTML allowed","允許HTML"
-"Heading Background Color","標題背景顏色"
-"Heading Text Color","標題文字顏色"
-"IP Country Lookup","IP國家查詢"
-"In Payment Area","在付款區域"
-"In Review Area","在審查區域"
-"It will show on success page","它將在成功頁面上顯示"
-"Material","材料"
-"Month/Day/Year","月日年"
-"No","沒有"
-"One Step Checkout","一步結帳"
-"One Step Checkout Description","一步結帳說明"
-"One Step Checkout Page Title","一步結帳頁面標題"
-"One step checkout is turned off.","一步結帳關閉。"
-"Options","選項"
-"Order Comment","訂單評論"
-"Order Survey","訂單調查"
-"Per Item","每件"
-"Per Order","按訂單"
-"Place Order button color","放置訂單按鈕顏色"
-"Restrict the auto suggestion for a specific country","限制特定國家/地區的汽車建議"
-"SORTED FIELDS","已分配的字段"
-"Save Position","保存位置"
-"Set default payment method in the checkout process.","在結帳過程中設置默認付款方式。"
-"Set default shipping method in the checkout process.","在結帳過程中設置默認送貨方式。"
-"Show Discount Code Section","顯示折扣代碼部分"
-"Show Login Link","顯示登錄鏈接"
-"Show Newsletter Checkbox","顯示新聞複選框"
-"Show Order Comment","顯示訂單評論"
-"Show Order Review Section","顯示訂單審查部分"
-"Show Product Thumbnail Image","顯示產品縮略圖"
-"Show Sign up newsletter selection","顯示註冊通訊選擇"
-"Show Terms and Conditions","顯示條款和條件"
-"Survey Answers","調查答案"
-"Survey Question","調查問題"
-"The default country will be set based on location of the customer.","默認國家將根據客戶的位置進行設置。"
-"There is an error while subscribing for newsletter.","訂閱通訊時出現錯誤。"
-"To calculate gift wrap fee based on item or order.","根據物品或訂單計算禮品包裝費。"
-"Unable to save order information. Please check input data.","無法保存訂單信息。請檢查輸入數據。"
-"Use Auto Suggestion Technology","使用自動建議技術"
-"When customer fills address fields, it will suggest a list of full addresses.","當客戶填寫地址字段時，它會建議一個完整地址列表。"
-"Year/Month/Day","年月日"
-"You can disable Order Review Section. It is enabled by default.","您可以禁用訂單審查部分。默認情況下啟用。"
\ No newline at end of file
diff --git a/view/adminhtml/templates/order/view/delivery-time.phtml b/view/adminhtml/templates/order/view/delivery-time.phtml
index 72e9d4d..e716b9f 100644
--- a/view/adminhtml/templates/order/view/delivery-time.phtml
+++ b/view/adminhtml/templates/order/view/delivery-time.phtml
@@ -22,19 +22,13 @@
 // @codingStandardsIgnoreFile
 
 ?>
-<?php if (($deliveryTimeHtml = $block->getDeliveryTime())||($block->getHouseSecurityCode())): ?>
+<?php if ($deliveryTimeHtml = $block->getDeliveryTime()): ?>
     <div class="admin__page-section-item order-delivery-time">
         <div class="admin__page-section-item-title">
-            <span class="title"><?php if($block->getDeliveryTime() && $block->getHouseSecurityCode()){/* @escapeNotVerified */ echo __('Delivery Time & House Security Code');}elseif($block->getHouseSecurityCode()){/* @escapeNotVerified */ echo __('House Security Code');}elseif($block->getDeliveryTime()){/* @escapeNotVerified */ echo __('Delivery Time');} ?></span>
+            <span class="title"><?php /* @escapeNotVerified */ echo __('Delivery Time') ?></span>
         </div>
         <div class="admin__page-section-item-content">
-            <?php if($deliveryTimeHtml): ?>
-                <br><strong><?php /* @escapeNotVerified */ echo __('Delivery Time') ?>: </strong><span><?php echo $deliveryTimeHtml ?></span>
-			<?php endif; ?>
-			<?php if($houseSecurityCodeHtml = $block->getHouseSecurityCode()): ?>
-                <br><strong><?php /* @escapeNotVerified */ echo __('House Security Code') ?>: </strong><span><?php echo $houseSecurityCodeHtml ?></span>
-			<?php endif; ?>
+            <?php echo $deliveryTimeHtml ?>
         </div>
-
     </div>
 <?php endif; ?>
\ No newline at end of file
diff --git a/view/adminhtml/templates/system/config/geoip.phtml b/view/adminhtml/templates/system/config/geoip.phtml
deleted file mode 100644
index 386aa83..0000000
--- a/view/adminhtml/templates/system/config/geoip.phtml
+++ /dev/null
@@ -1,73 +0,0 @@
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
-<script>
-    require([
-		'jquery',
-		'prototype'
-	], function($){
-
-		var collectSpan = $('#collect_span');
-		var buttonDownload = $('#geoip_button');
-		$('#geoip_button').click(function () {
-
-			var params = {};
-			new Ajax.Request('<?php echo $block->getAjaxUrl() ?>', {
-				parameters:     params,
-				loaderArea:     false,
-				asynchronous:   true,
-				onCreate: function() {
-
-					collectSpan.find('.collected').hide();
-					collectSpan.find('.processing').show();
-					$('#collect_message_span').text('');
-					buttonDownload.prop( "disabled", true );
-
-				},
-				onSuccess: function(response) {
-					var response = JSON.parse(response.responseText);
-					collectSpan.find('.processing').hide();
-					collectSpan.find('.collected').show();
-					buttonDownload.prop( "disabled", false);
-					if(response.success){
-						$('<div class="message message-success" style="margin-bottom: 5px;color:#79a22e"><p>'+ response.message +'</p></div>').insertBefore(buttonDownload);
-					}else{
-						$('<div class="message message-error" style="margin-bottom: 5px;color:red"><p>'+ response.message +'</p></div>').insertBefore(buttonDownload);
-					}
-				},
-				always: function(){
-					buttonDownload.prop( "disabled", false);
-				}
-			});
-		});
-
-	});
-</script>
-
-<?php echo $block->getButtonHtml() ?>
-<span class="collect-indicator" id="collect_span">
-	<span class="processing" hidden="hidden">
-		<img alt="Collecting" style="margin:0 5px" src="<?php echo $block->getViewFileUrl('images/process_spinner.gif') ?>"/>
-		Please wait ...
-	</span>
-    <img class="collected" <?php echo $block->isDisplayIcon();?> alt="Collected" style="margin:-3px 5px" src="<?php echo $block->getViewFileUrl('images/rule_component_apply.gif') ?>"/>
-</span>
\ No newline at end of file
diff --git a/view/adminhtml/web/css/source/_module.less b/view/adminhtml/web/css/source/_module.less
new file mode 100644
index 0000000..ae6bfac
--- /dev/null
+++ b/view/adminhtml/web/css/source/_module.less
@@ -0,0 +1,6 @@
+.admin__menu #menu-mageplaza-core-menu .item-osc.parent.level-1 > strong:before {
+  content: '\e63f';
+  font-family: 'Admin Icons';
+  font-size: 1.5rem;
+  margin-right: .8rem;
+}
\ No newline at end of file
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index e49c9f7..42e8db8 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -28,9 +28,6 @@
         <css src="Mageplaza_Core::css/font-awesome.min.css"/>
     </head>
     <body>
-        <referenceBlock name="content">
-            <block class="Mageplaza\Osc\Block\Checkout\CompatibleConfig" name="mageplaza.osc.compatible-config" before="checkout.root"/>
-        </referenceBlock>
         <referenceBlock name="checkout.root">
             <arguments>
                 <argument name="jsLayout" xsi:type="array">
@@ -53,9 +50,6 @@
                                         <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisableAuthentication" />
                                     </item>
                                 </item>
-                                <item name="geoip" xsi:type="array">
-                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/geoip</item>
-                                </item>
                                 <item name="steps" xsi:type="array">
                                     <item name="children" xsi:type="array">
                                         <item name="shipping-step" xsi:type="array">
@@ -384,7 +378,7 @@
         </referenceBlock>
         <attribute name="class" value="checkout_index_index"/>
         <referenceBlock name="head.additional">
-            <block class="Mageplaza\Osc\Block\Design" name="osc.design" as="osc.generator.css" template="design.phtml"/>
+            <block class="Mageplaza\Osc\Block\Design" name="osc.design" as="generator.css" template="design.phtml"/>
         </referenceBlock>
         <referenceBlock name="page.main.title">
             <block class="Mageplaza\Osc\Block\Container" name="page.main.description" template="description.phtml" />
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index e3224f5..bab7807 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -45,13 +45,6 @@ if (window.location.href.indexOf('onestepcheckout') !== -1) {
             'Mageplaza_Osc/js/model/osc-loader': {
                 'Magento_Checkout/js/model/full-screen-loader': 'Magento_Checkout/js/model/full-screen-loader'
             }
-        },
-        config: {
-            mixins: {
-                'Magento_Braintree/js/view/payment/method-renderer/paypal': {
-                    'Mageplaza_Osc/js/view/payment/method-renderer/braintree-paypal-mixins': true
-                }
-            }
-        },
+        }
     };
 }
\ No newline at end of file
diff --git a/view/frontend/templates/design.phtml b/view/frontend/templates/design.phtml
index 706c040..7080964 100644
--- a/view/frontend/templates/design.phtml
+++ b/view/frontend/templates/design.phtml
@@ -21,7 +21,7 @@
 ?>
 
 <?php if ($block->isEnableGoogleApi() && $block->getGoogleApiKey()): ?>
-    <script type="text/javascript" src="//maps.googleapis.com/maps/api/js?key=<?= $block->getGoogleApiKey() ?>&libraries=places"></script>
+	<script type="text/javascript" src="//maps.googleapis.com/maps/api/js?key=<?= $block->getGoogleApiKey() ?>&libraries=places"></script>
 <?php endif; ?>
 
 <?php
@@ -35,320 +35,46 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
     /*===================================================================
     |                            CONFIGUARATION STYLE                    |
     ====================================================================*/
-    <?php switch ($design['page_design']): ?><?php case 'flat': ?>
-    .checkout-container a.button-action,
-    .popup-authentication button.action,
-    .popup-gift-message-item button.action,
-    .checkout-container button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link):not(.ui-datepicker-trigger){
-        background-color: <?php echo $headingBackground ?> !important;
-        border-color: <?php echo $headingBackground ?> !important;
-        box-shadow: none !important;
-        color: #FFFFFF !important;
-    }
-    .gift-message-item-content .fa-gift{
-        color: <?php echo $headingBackground ?> !important;
-    }
-    .step-title{
-        background-color: <?php echo $headingBackground ?>;
-        padding: 12px 10px 12px 12px !important;
-        font-weight: bold !important;
-        font-size: 16px !important;
-        color: <?php echo $headingText ?> !important;
-        text-transform: uppercase;
-        line-height: 1.1;
-    }
-    .step-title .fa{
-        display: inline-block !important;
-        font-size: 24px;
-        margin-right: 12px;
-        vertical-align: text-bottom;
-    }
-    .one-step-checkout-container .osc-geolocation {
-        color: <?php echo $headingBackground ?>;
-    }
-    <?php break; ?>
-    <?php case 'material': ?>
-
-        /*  Get material color from config */
-        <?php $color = $design['material_color'];?>
-
-        <?php switch ($design['page_layout']){ ?><?php case '1column': ?>
-            .opc-wrapper .form-login, .opc-wrapper .form-shipping-address {  max-width: 100% !important;  }#checkoutSteps .row-mp>.hoverable{padding-bottom: 25px;margin-top: 25px}  #opc-sidebar .order-summary.hoverable{margin-top: 25px !important;}  .checkout-agreements-block {margin-bottom: 20px !important;}  .osc-place-order-block .payment-option-inner .control {width:100% !important;}
-                <?php if($block->isVirtual()){ ?>
-                    div[data-bind="scope: 'checkout.steps.shipping-step'"]{display: none}
-                    @media only screen and (max-width:1024px){  div[data-bind="scope: 'checkout.sidebar'"] {  margin-top: 0px !important;  }}
-                <?php }?>
-            <?php break; ?>
-
-            <?php case '2columns': ?>
-                .opc-wrapper .form-login, .opc-wrapper .form-shipping-address {max-width: 100% !important;}.checkout-agreements-block {margin-bottom: 20px !important;  }  .osc-place-order-block .payment-option-inner .control {width:100% !important;}  @media (min-width: 768px), print {  div[data-bind="scope: 'checkout.steps.billing-step'"] {margin-top: 0 !important;  }  .one-step-checkout-container>.mp-6{width: 46% !important;margin: 0px 14px;}  div[data-bind="scope: 'checkout.sidebar'"],div[data-bind="scope: 'checkout.steps.shipping-step'"]{margin-top: 35px;  }  }
-                <?php if($block->isVirtual()){ ?>
-                    @media only screen and (max-width:766px){  div[data-bind="scope: 'checkout.steps.shipping-step'"]{margin-top: 0px !important;}}
-                <?php }?>
-            <?php break; ?>
-
-            <?php case '3columns': ?>
-                <?php if($block->isVirtual()){ ?>
-                    div[data-bind="scope: 'checkout.steps.billing-step'"] {margin-top: 0px !important;}
-                <?php }?>
-            <?php break; ?>
-
-            <?php case '3columns-colspan': ?>
-                @media (min-width: 1024px), print {div[data-bind="scope: 'checkout.sidebar'"]{margin-top: 30px;} .hoverable.only-colspan{width: 45% ; margin-left: 15px;  }  }  @media only screen and (max-width:766px){.hoverable.only-colspan{margin-top: 25px}}  .checkout-agreements-block {margin-bottom: 20px !important;}
-                <?php if($block->isVirtual()){ ?>
-                    @media (min-width: 1024px), print {.hoverable.only-colspan{ width: 100% !important; ; margin-left: initial;}}
-                    @media only screen and (max-width:766px){  div[data-bind="scope: 'checkout.steps.shipping-step'"]{margin-top: 0px !important;}}
-                <?php }?>
-            <?php break; ?>
-
-        <?php } ?>
-
-
-        /* icon */
-            .fa-stack.fa-2x>i,.fa.fa-gift.fa-2x,.fa.fa-check-circle{color:<?php echo $color;?>}
-            .fa.fa-check-circle{display: initial;margin-left: 10px;font-size: 1.3em;}
-            .fa-stack.fa-2x{font-size: 0.7em;}  .fa-stack.fa-2x>i{display: block;}
-
-        /* popup*/
-            .popup-authentication .block-authentication .messages{margin-bottom: 25px!important;}
-
-        /* address */
-            ._keyfocus *:focus, input:not([disabled]):focus, textarea:not([disabled]):focus, select:not([disabled]):focus{  box-shadow: none; }
-            .required-entry{color:#e02b27;font-size: 1.2rem}
-            fieldset.street.required legend.label {display:none}
-            .field .control.input-field .label{  position:absolute;  top:10px;  left:10px;-webkit-transition: 0.2s ease;  transition: 0.2s ease; pointer-events: none; }
-            .input-field input:focus ~ label,.input-field input.active ~ label {  color: #9d9d9d;  -webkit-transform:  transform: translate(-9%, -55%) scale(0.85);  transform: translate(-9%, -55%) scale(0.85);  top: 5px;  top: -9px !important;  left: 0 !important;  }
-            .input-field input:valid ~ label {  color: #9d9d9d;  -webkit-transform:  transform: translate(-9%, -55%) scale(0.85);  transform: translate(-9%, -55%) scale(0.85);  top: 5px;  top: -9px !important;  left: 0 !important;  }
-            .field._error .control input, .field._error .control select, .field._error .control textarea {  border-color: #ccc;  }
-            div[name='shippingAddress.country_id'] .label,div[name='shippingAddress.region_id'] .label,div[name='billingAddress.country_id'] .label,div[name='billingAddress.region_id'] .label{  top: -15px !important;transform: translate(-6%, -28%) scale(0.85);margin-left: 10px;  left: 0 !important;  color: #9d9d9d;  }  div[name='shippingAddress.country_id'], div[name='shippingAddress.city'], div[name='shippingAddress.postcode'], div[name='shippingAddress.region'], div[name='shippingAddress.region_id'], div[name='shippingAddress.company'], div[name='shippingAddress.telephone'], div[name='billingAddress.country_id'], div[name='billingAddress.city'], div[name='billingAddress.postcode'], div[name='billingAddress.region'], div[name='billingAddress.region_id'], div[name='billingAddress.company'], div[name='billingAddress.telephone']{  margin-top: 10px !important;  }
-            .modal-content #opc-new-shipping-address{margin-top: 25px}
-            .one-step-checkout-wrapper select,.modal-popup select{  border: none;  border-bottom: 1px solid #ccc;  margin-top: 5px;  }
-            #checkout-step-billing>.field.field-select-billing{margin-bottom: 35px;}
-            .row-mp>div[data-bind="scope: 'checkout.steps.billing-step'"]{  margin-top: 25px; }
-            fieldset#billing-new-address-form>.choice.field {clear:both}
-            #create-account-form{  padding-top: 20px;  }
-
-        /* shipping method */
-            .delivery-time .control button{position: absolute;top: 17px;right: 20px}
-
-        /*payment */
-            #payment .step-title {  border-bottom: 1px solid #ccc;  }
-
-        /* summary */
-            div[data-bind="scope: 'checkout.sidebar'"]{ padding:0; }
-            .mp-4 .opc-block-summary {  padding: 0 0px !important;  }
-            .opc-block-summary .table-totals{border: none; border-top: none !important;}
-            #checkout-review-table {border:none}
-            .field .control.input-field{position: relative;}
-            .gift-options-content textarea{  border-bottom: 1px solid #ccc !important;border: none;  }
-            .osc-place-order-block .payment-option-inner .control {width: 58%;float:left;margin-right: 5px;}
-            .order-summary.hoverable{  margin-top: -9px;  padding-top: 1px;  }
-            .order-summary.hoverable .step-title{padding-top: 0px;  }
-            .opc-block-summary .table-totals, table#checkout-review-table{  background:#f0f0f0;  }
-            tr.grand.totals,tr.grand.totals .mark{background: #e1e1e1 !important;  }
-            .mark{background: #f0f0f0; }
-            .order-summary.hoverable .opc-block-summary.step-content{  padding:0;  }
-            .order-summary.hoverable .opc-block-summary.step-content .block.items-in-cart{  padding:0 10px;  }
-            #checkout-review-table thead th{  text-align: center;  }
-            .product-item a{ background-color: #AAAAAA;  }
-            .qty-wrapper .qty-wrap .input-text.update{  border: 1px solid;  height: 22px;  }
-            .osc-place-order-block{border:none;padding:0 !important;  }
-            .osc-place-order-block .choice{  padding:0  }
-            .checkout-agreements-block{  margin-bottom:20px !important;  }
-            .product-item-name-block a:hover{text-decoration:underline;  }
-
-        /* Check width devices */
-            @media only screen and (max-width:1024px){
-                #checkout-step-shipping_method>.co-shipping-method-form{margin:0;padding:0}
-                .osc-place-order-block .payment-option-inner .control {width: 100%;float:left;margin-bottom: 5px;}
-                input[type="text"], input[type="password"]{  border-bottom: none;  }
-                #create-account-form .osc-password,#create-account-form .confirmation{padding:0 6px }
-            }
-            @media (max-width: 991px) and (min-width: 768px){
-                .mp-sm-6 {  width: 46% !important;  margin: 0px 14px;  }
-                div[data-bind="scope: 'checkout.sidebar'"] {  margin-top: 30px;  float: right;  }
-            }
-            @media only screen and (max-width:766px){
-                div[data-bind="scope: 'checkout.sidebar'"], div[data-bind="scope: 'checkout.steps.shipping-step'"], div[data-bind="scope: 'checkout.steps.billing-step'"] {margin-top:25px;}
-                form#co-shipping-method-form {padding: 0; margin: 0; }
-                .one-step-checkout-wrapper .step-title{font-size: 2.6rem;  }
-                .opc-wrapper .form-login, .opc-wrapper .form-shipping-address, .opc-wrapper .methods-shipping { background: none !important;  }
-                #payment .step-title {  border-bottom: none;}
-                input[type="text"], input[type="password"]{ border-bottom: none;  }
-                form#create-account-form .confirmation{margin-top:20px}
-            }
-
-        /* hoverable box  */
-            .opc-wrapper .step-title,#opc-sidebar .order-summary.hoverable .step-title{  padding-top: 10px;  }  @media (min-width:1020px) {  .mp-4 {  width: 30.3333333333% !important;  margin: 0px 13px !important;  }  #maincontent{  padding-left: 0 !important;  padding-right: 0 !important;  }  }
-            .one-step-checkout-wrapper .hoverable:hover {  transition: box-shadow .25s;  box-shadow: 0 8px 17px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19)  }
-            .one-step-checkout-wrapper .hoverable{transition:box-shadow .25s;box-shadow:0}
-            .one-step-checkout-wrapper .hoverable{transition:box-shadow .25s;box-shadow:0;box-shadow: 0 1px 5px rgba(0,0,0,0.10), 0 1px 5px rgba(0,0,0,0.30);transition: all .3s ease-in-out;}
-            #opc-sidebar .order-summary.hoverable, #opc-sidebar .order-summary.hoverable .step-title{  margin-top: 0px;  background:#f0f0f0;  }
-
-        /* input type text,password */
-            input[type="text"],input[type="password"],input[type="email"] {
-                display: block;
-                width: 100%;
-                color: #555;
-                height: 38px;
-                padding: 7px 0;
-                font-size: 16px;
-                line-height: 1.42857143;
-                margin-bottom: 7px;
-                border: 0;
-                background-image: -webkit-gradient(linear, left top, left bottom, from(<?php echo $color;?>), to(<?php echo $color;?>)), -webkit-gradient(linear, left top, left bottom, from(#D2D2D2), to(#D2D2D2));
-                background-image: -webkit-linear-gradient(<?php echo $color;?>, <?php echo $color;?>), -webkit-linear-gradient(#D2D2D2, #D2D2D2);
-                background-image: -o-linear-gradient(<?php echo $color;?>, <?php echo $color;?>), -o-linear-gradient(#D2D2D2, #D2D2D2);
-                background-image: linear-gradient(<?php echo $color;?>, <?php echo $color;?>), linear-gradient(#D2D2D2, #D2D2D2);
-                -webkit-background-size: 0 2px, 100% 1px;
-                background-size: 0 2px, 100% 1px;
-                background-repeat: no-repeat;
-                background-position: center bottom, center -webkit-calc(100% - 1px);
-                background-position: center bottom, center calc(100% - 1px);
-                background-color: rgba(0, 0, 0, 0);
-                -webkit-transition: background 0s ease-out;
-                -o-transition: background 0s ease-out;
-                transition: background 0s ease-out;
-                float: none;
-                -webkit-box-shadow: none;
-                box-shadow: none;
-                border-radius: 0;
-            }
-
-            input[type="text"]:focus,input[type="password"]:focus,input[type="email"]:focus {
-                outline: none;
-                background-image: -webkit-gradient(linear, left top, left bottom, from( <?php echo $color;?> ), to(<?php echo $color;?>)), -webkit-gradient(linear, left top, left bottom, from(#D2D2D2), to(#D2D2D2));
-                background-image: -webkit-linear-gradient(<?php echo $color;?>, <?php echo $color;?>), -webkit-linear-gradient(#D2D2D2, #D2D2D2);
-                background-image: -o-linear-gradient(<?php echo $color;?>, <?php echo $color;?>), -o-linear-gradient(#D2D2D2, #D2D2D2);
-                background-image: linear-gradient(<?php echo $color;?>, <?php echo $color;?>), linear-gradient(#D2D2D2, #D2D2D2);
-                -webkit-background-size: 100% 2px, 100% 1px;
-                background-size: 100% 2px, 100% 1px;
-                -webkit-box-shadow: none;
-                box-shadow: none;
-                -webkit-transition-duration: 0.3s;
-                -o-transition-duration: 0.3s;
-                transition-duration: 0.3s;
-            }
-        /* radio button - default */
-            input[type=checkbox], .one-step-checkout-wrapper input[type=radio]{box-sizing:border-box;padding:0}
-            [type=radio]:checked, .one-step-checkout-wrapper [type=radio]:not(:checked){position:absolute;left:-9999px;opacity:0}
-            [type=radio]:checked+label, .one-step-checkout-wrapper [type=radio]:not(:checked)+label{position:relative;padding-left:35px;cursor:pointer;display:inline-block;height:25px;line-height:25px;/*font-size:1rem;*/transition:.28s ease;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}
-            [type=radio].with-gap:checked+label:after, .one-step-checkout-wrapper [type=radio].with-gap:checked+label:before, .one-step-checkout-wrapper [type=radio]:checked+label:after{border:2px solid <?php echo $color;?>}
-            [type=radio].with-gap:checked+label:after, .one-step-checkout-wrapper [type=radio].with-gap:checked+label:before, .one-step-checkout-wrapper [type=radio]:checked+label:after, .one-step-checkout-wrapper [type=radio]:checked+label:before, .one-step-checkout-wrapper [type=radio]:not(:checked)+label:after, .one-step-checkout-wrapper [type=radio]:not(:checked)+label:before{border-radius:50%}
-            [type=radio]:checked+label:before{border:2px solid transparent}
-            [type=radio]+label:after, .one-step-checkout-wrapper [type=radio]+label:before{content:'';position:absolute;left:0;top:0;margin:3px;width:13px;height:13px;z-index:0;transition:.28s ease}
-            [type=radio].with-gap:checked+label:after{-webkit-transform:scale(.5);transform:scale(.5)}
-            [type=radio].with-gap:checked+label:after, .one-step-checkout-wrapper [type=radio]:checked+label:after{background-color:<?php echo $color;?>}
-            [type=radio]:checked+label:after{-webkit-transform:scale(1.02);transform:scale(1.02)}
-            [type=radio]:not(:checked)+label:after, .one-step-checkout-wrapper [type=radio]:not(:checked)+label:before{border:2px solid #5a5a5a;}
-            [type=radio]:not(:checked)+label:after{-webkit-transform:scale(0);transform:scale(0)}
-
-        /* radio button - width-wrap */
-            <?php if($design['radio_button_style'] == 'with_gap'){ ?>
-            [type=radio]:checked+label:after{-webkit-transform:scale(.5);transform:scale(.5);}
-            [type=radio]:checked+label:after, .one-step-checkout-wrapper [type=radio]:checked+label:before, .one-step-checkout-wrapper [type=radio]:checked+label:after{border:2px solid <?php echo $color;?>;}
-            <?php } ?>
-
-        /* checkbox button - default */
-            [type=checkbox]:checked, .one-step-checkout-wrapper [type=checkbox]:not(:checked){position:absolute;opacity:0;z-index: 999;}
-            .one-step-checkout-wrapper .payment-method-content input[type="checkbox"] {width:20px;height:20px;}
-            <?php if($design['checkbox_button_style'] == 'default'){ ?>
-            [type=checkbox]+label{position:relative;padding-left:35px;cursor:pointer;display:inline-block;height:25px;line-height:25px;/*font-size:1rem*/}
-            [type=checkbox]+label:before, .one-step-checkout-wrapper [type=checkbox]:not(.filled-in)+label:after{content:'';position:absolute;top:0;left:0;width:14px;height:14px;z-index:0;border:2px solid #5a5a5a;border-radius:1px;margin-top:2px;transition:.2s}
-            [type=checkbox]:not(.filled-in)+label:after{border:0;-webkit-transform:scale(0);transform:scale(0)}
-            [type="checkbox"]:checked+label:before {  top: -4px;  left: -5px;  width: 10px;  height: 20px;  border-top: 2px solid transparent;  border-left: 2px solid transparent;  border-right: 2px solid <?php echo $color;?>;  border-bottom: 2px solid <?php echo $color;?>;  transform: rotate(40deg);  -webkit-backface-visibility: hidden;  backface-visibility: hidden;  -webkit-transform-origin: 100% 100%;  transform-origin: 100% 100%  }
-
-            <?php }elseif($design['checkbox_button_style'] == 'filled_in'){?>
-
-        /* checkbox button - filled_in */
-            [type="checkbox"]:not(:checked), [type="checkbox"]:checked {  position: absolute;   box-sizing: border-box;z-index: 999;opacity: 0 }
-            [type="checkbox"]+label {  position: relative;  padding-left: 35px;  cursor: pointer;  display: inline-block;  height: 25px;  line-height: 25px;  -webkit-user-select: none;  -moz-user-select: none;  -khtml-user-select: none;  -ms-user-select: none;  }
-            [type="checkbox"]:checked+label:before {  top: 0;  left: 1px;  width: 8px;  height: 13px;  border-top: 2px solid transparent;  border-left: 2px solid transparent;  border-right: 2px solid #fff;  border-bottom: 2px solid #fff;  -webkit-transform: rotateZ(37deg);  transform: rotateZ(37deg);  -webkit-transform-origin: 100% 100%;  transform-origin: 100% 100%;  z-index: 99;  }
-            [type="checkbox"]+label:before, [type="checkbox"]+label:after {  content: '';  left: 0;  position: absolute;  transition: border .25s,background-color .25s,width .2s .1s,height .2s .1s,top .2s .1s,left .2s .1s;  box-sizing: border-box;  }
-            [type="checkbox"]+label:before {  content: '';  position: absolute;  top: 0;  left: 0;  width: 18px;  height: 18px;  z-index: 0;  border: 2px solid #5a5a5a;  border-radius: 1px;  margin-top: 2px;  -webkit-transition: 0.2s;  -moz-transition: 0.2s;  -o-transition: 0.2s;  -ms-transition: 0.2s;  transition: 0.2s;  }
-            [type="checkbox"]:not(:checked)+label:before {  width: 0;  height: 0;  border: 3px solid transparent;  left: 6px;  top: 10px;  -webkit-transform: rotateZ(37deg);  transform: rotateZ(37deg);  -webkit-transform-origin: 20% 40%;  transform-origin: 100% 100%;  }
-            [type="checkbox"]:not(:checked)+label:after {  height: 20px;  width: 20px;  background-color: transparent;  border: 2px solid #5a5a5a;  top: 0px;  z-index: 0;  }
-            [type="checkbox"]:checked+label:after {  top: 0px;  width: 20px;  height: 20px;  border: 2px solid <?php echo $color;?>;  background-color: <?php echo $color;?>;  z-index: 0;  }
-
-            <?php } ?>
-
-        /* ripple affect css*/
-            button {  border: 0;  outline: 0;  border-radius: 0.15em;  box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);  overflow: hidden;  position: relative;  cursor:pointer;  }
-            button .ripple {  border-radius: 50%;  background-color: rgba(255, 255, 255, 0.7);  position: absolute;  transform: scale(0);  animation: ripple 0.8s linear;  opacity: 0.4;  }
-            @keyframes ripple { to {  transform: scale(2.5);  opacity: 0;  } }
-
-        <?php break; ?>
-
-     <?php default: ?>
-        .checkout-payment-method .step-title,#shipping .step-title,#opc-shipping_method .step-title,.order-summary .step-title {  border-bottom: 1px solid #ccc;padding-bottom: 10px; }
-    <?php endswitch; ?>
-
-    .osc-place-order-wrapper .place-order-primary button.primary.checkout{
-        background-color: <?php echo $placeOrder ?> !important;
-        border-color: <?php echo $placeOrder ?> !important;
-    }
-    /*===================================================================
-    |                           Custom STYLE                             |
-    ====================================================================*/
-    <?php echo isset($design['custom_css']) ? $design['custom_css'] : ''; ?>
-
-    /*===================================================================
-    |                      Compatible Themes                             |
-    ====================================================================*/
-    /** Etheme_yourstore  **/
-    <?php if($block->getCurrentTheme() == "Etheme/yourstore"){ ?>
-    .create-account-block { border:none;padding:0; }
-    .product-image-container{display: initial;}
-    .content {margin-top: 0px !important}
-    .product-item .product-item-name-block a{background-color:#f0f0f0 !important}
-    .product-image-wrapper{height: initial;}
-    .qty-wrapper .qty-wrap .input-text.update{top:-2px}
-    .popup-authentication .modal-content{padding-top:0}
-    .osc-payment-after-methods .opc-payment-additional .field .control{border-bottom:none;}
-    dd.ui_tpicker_second,dd.ui_tpicker_millisec,dd.ui_tpicker_microsec {display:none}
-    .ui-timepicker-div dl dd{padding-bottom:0}
-    .ui-timepicker-div dl dt{font-size:14px}
-    .delivery-time .control button{display: none}
-    aside.modal-popup.osc-social-login-popup.modal-slide._inner-scroll._show .modal-inner-wrap header.modal-header{margin-top: -17px;}
-    aside.modal-popup.osc-social-login-popup.modal-slide._inner-scroll._show .modal-inner-wrap header.modal-header button.action-close{padding: 10px 20px 10px 10px !important;}
-    div#social-login-popup .social-login.block-container.authentication div#social-login-authentication {width:initial;}
-    aside.modal-popup.osc-social-login-popup.modal-slide._inner-scroll._show {z-index:9999999!important;}
-    div#social-login-authentication {width: 58.3333333333% !important;}
-    @media (min-width: 786px){
-        aside.modal-popup.osc-social-login-popup.modal-slide._inner-scroll._show .modal-inner-wrap{ top:200px;}
-    }
-    @media only screen and (max-width: 767px){
-        .navigation, .breadcrumbs, .page-header .header.panel, .header.content, .footer.content, .page-main, .page-wrapper > .widget, .page-wrapper > .page-bottom, .block.category.event, .top-container {padding-left: 15px;  padding-right: 15px; }
-    }
-
-    /** Sm_agood  **/
-    <?php }elseif($block->getCurrentTheme() == "Sm/agood"){ ?>
-    .create-account-block label[for="create-account-checkbox"],.billing-address-same-as-shipping-block label[for="billing-address-same-as-shipping"],.opc-payment label,.checkout-addition-block label{padding-left:20px !important}
-    .one-step-checkout-wrapper [type=checkbox]+label:before, .one-step-checkout-wrapper [type=checkbox]:not(.filled-in)+label:after {margin-top:5px}
-    .delivery-time .control button {top: 7px;}
-    .minicart-items .product > .product-image-container {float : none;}
-    .product-item .product-item-name-block a{background-color:#f0f0f0 !important}
-    header.modal-header {border:none}
-    .modal-content {border: none;box-shadow: none;}
-    <?php } ?>
+<?php switch ($design['page_design']): ?><?php case 'flat': ?>
+	.checkout-container a.button-action,
+	.popup-authentication button.action,
+	.checkout-container button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link):not(.ui-datepicker-trigger){
+		background-color: <?php echo $headingBackground ?> !important;
+		border-color: <?php echo $headingBackground ?> !important;
+		box-shadow: none !important;
+		color: #FFFFFF !important;
+	}
+	.step-title{
+		background-color: <?php echo $headingBackground ?>;
+		padding: 12px 10px 12px 12px !important;
+		font-weight: bold !important;
+		font-size: 16px !important;
+		color: <?php echo $headingText ?> !important;
+		text-transform: uppercase;
+		line-height: 1.1;
+	}
+	.step-title .fa{
+		display: inline-block !important;
+		font-size: 24px;
+		margin-right: 12px;
+		vertical-align: text-bottom;
+	}
+	.one-step-checkout-container .osc-geolocation {
+		color: <?php echo $headingBackground ?>;
+	}
+	<?php break; ?>
+<?php case 'material': ?>
+<?php default: ?>
+
+
+<?php endswitch; ?>
+
+	.osc-place-order-wrapper .place-order-primary button.primary.checkout{
+		background-color: <?php echo $placeOrder ?> !important;
+		border-color: <?php echo $placeOrder ?> !important;
+	}
+	/*===================================================================
+	|                           Custom STYLE                             |
+	====================================================================*/
+	<?php echo isset($design['custom_css']) ? $design['custom_css'] : ''; ?>
 </style>
-
-<?php if($design['page_design'] == 'material'){?>
-    <script type="text/javascript">
-        require(['jquery'], function($){
-
-            // Add ripple affect for button
-            $(document).on('click','button',function(e){
-                var circle = document.createElement('div');
-                $('.ripple').remove();
-                this.appendChild(circle);
-                var d = Math.max(this.clientWidth, this.clientHeight);
-                circle.style.width = circle.style.height = d + 'px';
-                var rect = this.getBoundingClientRect();
-                circle.style.left = e.clientX - rect.left -d/2 + 'px';
-                circle.style.top = e.clientY - rect.top - d/2 + 'px';
-                circle.classList.add('ripple');
-            });
-        });
-    </script>
-<?php } ?>
diff --git a/view/frontend/templates/onepage/compatible-config.phtml b/view/frontend/templates/onepage/compatible-config.phtml
deleted file mode 100644
index b5ec928..0000000
--- a/view/frontend/templates/onepage/compatible-config.phtml
+++ /dev/null
@@ -1,38 +0,0 @@
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
-/** @var \Mageplaza\Osc\Block\Checkout\CompatibleConfig $block */
-
-?>
-
-<?php if($block->isEnableModulePostNL()) : ?>
-    <script type="text/javascript">
-        require.config({
-            config: {
-                mixins: {
-                    'Mageplaza_Osc/js/view/shipping': {
-                        'Mageplaza_Osc/js/view/shipping-postnl': true
-                    }
-                }
-            }
-        })
-    </script>
-<?php endif; ?>
diff --git a/view/frontend/templates/onepage/success/survey.phtml b/view/frontend/templates/onepage/success/survey.phtml
index 8949792..262d76c 100644
--- a/view/frontend/templates/onepage/success/survey.phtml
+++ b/view/frontend/templates/onepage/success/survey.phtml
@@ -19,7 +19,7 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
-<?php if ($block->isEnableSurvey() && !empty($block->getSurveyQuestion()) && count($block->getAllSurveyAnswer()) > 0): ?>
+<?php if (!$block->isEnableSurvey() && !empty($block->getSurveyQuestion()) && count($block->getAllSurveyAnswer()) > 0): ?>
     <div id="survey">
         <div id="survey-message"></div>
         <div class="survey-content">
diff --git a/view/frontend/templates/order/view/delivery-time.phtml b/view/frontend/templates/order/view/delivery-time.phtml
index 6e3529a..6044b8e 100644
--- a/view/frontend/templates/order/view/delivery-time.phtml
+++ b/view/frontend/templates/order/view/delivery-time.phtml
@@ -19,18 +19,14 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
-<?php if (($deliveryTimeHtml = $block->getDeliveryTime())||($block->getHouseSecurityCode())): ?>
+
+<?php if ($deliveryTimeHtml = $block->getDeliveryTime()): ?>
     <div class="box box-order-delivery-time">
         <strong class="box-title">
-            <span class="title"><?php if($block->getDeliveryTime() && $block->getHouseSecurityCode()){/* @escapeNotVerified */ echo __('Delivery Time & House Security Code');}elseif($block->getHouseSecurityCode()){/* @escapeNotVerified */ echo __('House Security Code');}elseif($block->getDeliveryTime()){/* @escapeNotVerified */ echo __('Delivery Time');} ?></span>
+            <span><?php /* @escapeNotVerified */ echo __('Delivery Time') ?></span>
         </strong>
         <div class="box-delivery-time">
-            <?php if($deliveryTimeHtml): ?>
-                <br><strong><?php /* @escapeNotVerified */ echo __('Delivery Time') ?>: </strong><span><?php echo $deliveryTimeHtml ?></span>
-			<?php endif; ?>
-			<?php if($houseSecurityCodeHtml = $block->getHouseSecurityCode()): ?>
-                <br><strong><?php /* @escapeNotVerified */ echo __('House Security Code') ?>: </strong><span><?php echo $houseSecurityCodeHtml ?></span>
-			<?php endif; ?>
+            <?php echo $deliveryTimeHtml;?>
         </div>
     </div>
 <?php endif; ?>
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index 5407a84..8affb9c 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -19,8 +19,7 @@
  */
 
 /**************************************************** Osc style ****************************************************/
-.onestepcheckout-index-index .page-title-wrapper{position: relative;display: block;overflow: inherit;height: inherit;padding-left: 11px;width: inherit;margin: inherit;clip: inherit;border: inherit;}
-.page-title-wrapper{padding-left: 10px;margin-bottom:30px !important;}
+.page-title-wrapper{padding-left: 10px;}
 .one-step-checkout-wrapper{width: 100% !important; margin-top: 20px; padding: 0 !important;}
 .onestepcheckout-index-index input.google-auto-complete {margin-right: 10px; width: calc(100% - 36px);}
 .one-step-checkout-container .osc-geolocation {font-size: 20px;cursor: pointer;transition: all 0.3s ease 0s;}
@@ -54,7 +53,7 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 /** Theme **/
 .opc-wrapper .fieldset > .field > .label{float: none !important; width: auto !important; margin: 0 0 8px !important;}
 .fieldset > .field:not(.choice) > .control{float: none !important; width: 100% !important;}
-.fieldset > .field {margin: 0 0 20px}
+.fieldset > .field {margin: 0 0 20px !important;}
 #checkout-step-shipping .form-login, #checkout-step-billing .form-login {margin-top: 0 !important;}
 .fieldset > .form-create-account> .field.required > .label:after {  content: '*';  color: #e02b27;  font-size: 1.2rem;  margin: 0 0 0 5px;  }
 
@@ -70,17 +69,15 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .osc-shipping-method ul li{list-style: none;}
 .table-checkout-shipping-method thead th{display: none;}
 .fieldset > .form-create-account> .field.required > .label:after {  content: '*';  color: #e02b27;  font-size: 1.2rem;  margin: 0 0 0 5px;  }
-.delivery-time,.house-security-code{margin-bottom: 20px;}
-.delivery-time .title,.house-security-code .title{margin: 10px 0;}
-.delivery-time .title span,.house-security-code .title span{font-weight: bold;}
-.delivery-time .control,.house-security-code .control{position: relative;width: 80%;}
-.delivery-time .control input,.house-security-code .control input{width:80%}
+.delivery-time{margin-bottom: 20px;}
+.delivery-time .title{margin: 10px 0;}
+.delivery-time .title span{font-weight: bold;}
+.delivery-time .control{position: relative;width: 80%;}
+.delivery-time .control input{width:80%}
 .delivery-time .remove-delivery-time{  width: 20px;  height: 20px;  cursor: pointer;  text-align: center;  position: absolute;  top: 6px;  right: 60px; }
 
-.osc-place-order-wrapper .checkout-agreements-block{margin-bottom: 0px}
 /**************************************************** Payment method area ****************************************************/
-.osc-payment-after-methods .opc-payment-additional .field .control{float: left;margin-right: 3px;width: 100%;margin-bottom: 10px;}
-.osc-payment-after-methods .opc-payment-additional .actions-toolbar>.primary{width:100%;}
+.osc-payment-after-methods .opc-payment-additional .field .control{float: left; margin-right: 3px}
 .payment-method-content .payment-method-billing-address,
 .payment-method-content .actions-toolbar {display: none}
 .checkout-payment-method .payment-method-content {padding-bottom: 0 !important;}
@@ -109,17 +106,13 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .opc-block-summary .table-totals tbody .mark,.opc-block-summary .table-totals tfoot .mark{text-align: right;}
 .opc-block-summary .table-totals tbody .amount,.opc-block-summary .table-totals tfoot .amount{width: 150px;padding-right: 20px;}
 .opc-block-summary .table-totals .grand .mark{padding-right: 0 !important;}
-.one-step-checkout-wrapper .mp-4 .minicart-items-wrapper .product-image-container{/*display: none;*/}
-.one-step-checkout-wrapper .mp-4 .opc-block-summary{padding: 0 10px}
+.one-step-checkout-wrapper .mp-4 .minicart-items-wrapper .product-image-container{display: none;}
+.one-step-checkout-wrapper .mp-4 .opc-block-summary{padding: 0 10px !important;}
 .one-step-checkout-wrapper .mp-4 #checkout-review-table thead th,.one-step-checkout-wrapper .mp-4 #checkout-review-table tbody tr td,.one-step-checkout-wrapper .mp-4 #checkout-review-table tfoot tr td{padding-left: 5px !important;padding-right: 5px !important;}
 .cart-gift-item{float:left;margin-left: 0;width:100%}
 .gift-options-content{margin-top: 10px;}
 .gift-options-content .fieldset{margin:0}
 .gift-options-content .secondary{float:right;margin-right:7px}
-.gift-message-item{cursor: pointer}
-.gift-message-item>i {position: absolute;right:-5px;top: 11px;}
-.popup-gift-message-item .actions-toolbar .primary{float:right }
-
 
 /**************************************************** Place order area ****************************************************/
 #co-place-order-area{padding: 0 20px !important;}
@@ -131,7 +124,7 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .osc-place-order-block .actions-toolbar{margin-top: 6px}
 .checkout-addition-block{padding-top: 20px !important;}
 .osc-place-order-wrapper button.action.primary.checkout span {color: #FFFFFF;background: none;border: none;}
-.checkout-agreements-block #co-place-order-agreement{margin-bottom: 15px}
+.osc-place-order-wrapper .checkout-agreements-block{margin-bottom: 0px}
 
 /**************************************************** Survey ****************************************************/
 #survey-message{margin-top: 15px;}
@@ -147,11 +140,11 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 
 /**************************************************** Responsive ****************************************************/
 @media (min-width: 1024px), print {
-    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap,.popup-gift-message-item .modal-inner-wrap{  margin-left: auto !important;  margin-right: auto !important;  left: 0 !important;  right: 0 !important;  width: 500px !important;  min-width: 0;  }
-    .popup-gift-message-item .actions-toolbar .primary{float:right }
-    .popup-authentication .block[class] { padding-right: 0 !important;}
-    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap .block.block-customer-login{ margin-top: 20px;}
+    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap {  margin-left: auto !important;  margin-right: auto !important;  left: 0 !important;  right: 0 !important;  width: 500px !important;  min-width: 0;  }
 
+    .popup-authentication .block[class] {
+        padding-right: 0 !important;
+    }
 }
 @media (min-width: 786px), print {
     .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap {  margin-left: auto !important;  margin-right: auto !important;  left: 0 !important;  right: 0 !important;  width: 600px !important;  min-width: 0;  }
@@ -159,61 +152,15 @@ fieldset.field.col-mp{padding: 0 10px !important;}
     .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap header .action-close{padding: 15px !important;}
     .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap header .action-close:before{color: #fff !important;font-weight: bold}
     .checkout-index-index .modal-popup.osc-social-login-popup .modal-inner-wrap .modal-content{padding:0 !important}
-    .col-mp.mp-6.mp-sm-5.mp-xs-12 .delivery-time .remove-delivery-time{right:100px;}
-    .col-mp.mp-lg-7.mp-6.mp-xs-12 .delivery-time .remove-delivery-time{right:115px;}
-}
-@media (min-width: 768px), print {
-    .popup-authentication .modal-inner-wrap {
-        min-width: inherit !important;
-    }
-}
-@media (min-width: 320px), print {
-    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap .block.block-customer-login{
-        margin-top: 20px;
-    }
+
 }
 @media only screen and (max-width:786px){
     #checkout-step-shipping_method{padding:0}
     .opc-wrapper .form-login,.opc-wrapper .form-shipping-address, .opc-wrapper .methods-shipping{  margin: 20px 0px 15px;}
     .opc-block-summary{padding: 22px 0px;}
     #checkout-review-table thead th, #checkout-review-table tbody tr td, #checkout-review-table tfoot tr td{  padding: 15px 5px;}
-    .gift-message-item-content .fa-gift{  position: absolute;  right: 0;  z-index: 99;  }
-    .popup-gift-message-item .actions-toolbar .primary{margin-right: 10px;}
-}
-@media only screen and (max-width:736px){
-    #checkout-step-shipping .create-account-block .confirmation,#checkout-step-shipping .create-account-block  {margin-top:20px}
-    table#checkout-review-table .qty-wrapper{min-width:70px; padding: 5px 0px}
-    .minicart-items .product-item-name{font-size: 14px !important;}
 }
 @media only screen and (max-width:320px){
     #checkout-review-table thead th, #checkout-review-table tbody tr td, #checkout-review-table tfoot tr td{padding: 15px 0px;}
-    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap .block.block-customer-login{
-        margin-top: 20px;
-    }
-    table#checkout-review-table .qty-wrapper{min-width:inherit; padding: 5px 0px}
-    table#checkout-review-table .qty-wrapper .minus{margin-bottom:10px}
-    table#checkout-review-table .qty-wrapper .plus{margin-top: 5px}
-    table#checkout-review-table .product-item .price,table#checkout-review-table .remove-wrapper{line-height: 80px;}
-    .minicart-items .product-item-name{font-size: 14px !important;}
+    .delivery-time .remove-delivery-time{right:45px;}
 }
-
-
-/*************************************************** Compatible**************************************************************/
-
-/* Amasty_ShippingTableRates */
-div[data-bind="scope: 'checkout.steps.shipping-step'"] > .checkout-shipping-address{
-    display:none !important;
-}
-form#co-shipping-method-form div#shipping-method-buttons-container{display:none;}
-
-/* braintree-paypal */
-.payment-method-item.braintree-paypal-account {
-    width: 85%;
-    margin-bottom: 10px;
-}
-
-/* css TIG_PostNL */
-.checkout-container .postnl-deliveryoptions .delivery_options button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link):not(.ui-datepicker-trigger):not(.button-active) {
-    background-color: #eee !important;
-    color: black !important;
-}
\ No newline at end of file
diff --git a/view/frontend/web/js/action/gift-message-item.js b/view/frontend/web/js/action/gift-message-item.js
deleted file mode 100644
index b6de6a9..0000000
--- a/view/frontend/web/js/action/gift-message-item.js
+++ /dev/null
@@ -1,67 +0,0 @@
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
-        'Magento_Checkout/js/model/quote',
-        'Mageplaza_Osc/js/model/resource-url-manager',
-        'Mageplaza_Osc/js/model/gift-message',
-        'mage/storage'
-    ],
-    function (
-        $,
-        quote,
-        resourceUrlManager,
-        giftMessageModel,
-        storage
-    ) {
-        'use strict';
-
-        var giftMessageItems =  window.checkoutConfig.oscConfig.giftMessageOptions.giftMessage.itemLevel,
-            giftMessageModel = new giftMessageModel();
-
-        return function (data,itemId,remove) {
-            return storage.post(
-                resourceUrlManager.getUrlForGiftMessageItemInformation(quote,itemId),
-                JSON.stringify(data)
-            ).done(
-                function (response) {
-                    if(response == true ){
-                        if(remove){
-                            delete giftMessageItems[itemId].message;
-                            giftMessageModel.showMessage('success','Delete gift message item success.');
-                            return this;
-                        }
-                        giftMessageItems[itemId]['message'] = data.gift_message;
-                        giftMessageModel.showMessage('success','Update gift message item success.');
-                    }
-                }
-            ).fail(
-                function () {
-                    if(remove){
-                        giftMessageModel.showMessage('error','Can not delete gift message item. Please try again!');
-                    }
-                    giftMessageModel.showMessage('error','Can not update gift message item. Please try again!');
-                }
-            )
-        };
-    }
-);
diff --git a/view/frontend/web/js/model/billing-before-shipping.js b/view/frontend/web/js/model/billing-before-shipping.js
new file mode 100644
index 0000000..4af4cc3
--- /dev/null
+++ b/view/frontend/web/js/model/billing-before-shipping.js
@@ -0,0 +1,33 @@
+/**
+ * Mageplaza
+ *
+ * NOTICE OF LICENSE
+ *
+ * This source file is subject to the Mageplaza.com license that is
+ * available through the world-wide-web at this URL:
+ * https://www.mageplaza.com/LICENSE.txt
+ *
+ * DISCLAIMER
+ *
+ * Do not edit or add to this file if you wish to upgrade this extension to newer
+ * version in the future.
+ *
+ * @category    Mageplaza
+ * @package     Mageplaza_Osc
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+define(['ko', 'Mageplaza_Osc/js/model/osc-data'], function (ko, oscData) {
+    'use strict';
+    var isBillingSameShipping = oscData.getData('billing-same-shipping') ? oscData.getData('billing-same-shipping') : false;
+    return {
+        isBillingSameShipping: ko.observable(isBillingSameShipping),
+        getBillingSameShipping: function () {
+            return this.isBillingSameShipping();
+        },
+        setBillingSameShipping: function () {
+            oscData.setData('billing-same-shipping', !this.isBillingSameShipping());
+            return this.isBillingSameShipping(!this.isBillingSameShipping());
+        }
+    };
+});
\ No newline at end of file
diff --git a/view/frontend/web/js/model/braintree-paypal.js b/view/frontend/web/js/model/braintree-paypal.js
deleted file mode 100644
index e8c7260..0000000
--- a/view/frontend/web/js/model/braintree-paypal.js
+++ /dev/null
@@ -1,8 +0,0 @@
-define(['ko'], function (ko) {
-    'use strict';
-    return {
-        isReviewRequired: ko.observable(false),
-        customerEmail: ko.observable(null),
-        active: ko.observable(false)
-    }
-});
\ No newline at end of file
diff --git a/view/frontend/web/js/model/gift-message.js b/view/frontend/web/js/model/gift-message.js
index 6090e7c..8b39207 100644
--- a/view/frontend/web/js/model/gift-message.js
+++ b/view/frontend/web/js/model/gift-message.js
@@ -18,8 +18,8 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
-define(['jquery','ko', 'uiElement', 'underscore','mage/translate'],
-    function ($,ko, uiElement, _, $t) {
+define(['ko', 'uiElement', 'underscore'],
+    function (ko, uiElement, _) {
         'use strict';
 
         var provider = uiElement();
@@ -68,18 +68,6 @@ define(['jquery','ko', 'uiElement', 'underscore','mage/translate'],
                  */
                 isGiftMessageAvailable: function () {
                     return this.getConfigValue('isOrderLevelGiftOptionsEnabled');
-                },
-                /**
-                 * show message below order summary
-                 * @param type
-                 * @param message
-                 */
-                showMessage: function(type, message){
-                    var classElement = 'message ' + type;
-                    $('#opc-sidebar .block.items-in-cart').before('<div class=" '+ classElement +'"> <span>'+ $t(message)+'</span></div>');
-                    setTimeout(function(){
-                        $('#opc-sidebar .opc-block-summary .message.' + type).remove();
-                    }, 3000);
                 }
             };
             model.initialize();
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index 6641502..261c06d 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -65,14 +65,6 @@ define(
                 };
                 return this.getUrl(urls, params);
             },
-            getUrlForGiftMessageItemInformation: function(quote,itemId){
-                var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
-                var urls = {
-                    'guest': '/guest-carts/:cartId/gift-message/'+itemId,
-                    'customer': '/carts/mine/gift-message/'+itemId
-                };
-                return this.getUrl(urls, params);
-            }
         }, resourceUrlManager);
     }
 );
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 78db769..9046fbc 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -28,11 +28,14 @@ define(
         'Magento_Checkout/js/model/shipping-rates-validation-rules',
         'Magento_Checkout/js/model/address-converter',
         'Magento_Checkout/js/action/select-shipping-address',
+        'Magento_Checkout/js/action/select-billing-address',
         'Magento_Checkout/js/model/shipping-rate-service',
         'Magento_Checkout/js/model/shipping-service',
         'Magento_Checkout/js/model/postcode-validator',
         'mage/translate',
-        'uiRegistry'
+        'uiRegistry',
+        'Mageplaza_Osc/js/model/billing-before-shipping',
+        'Magento_Customer/js/model/customer'
     ],
     function (_,
               $,
@@ -42,11 +45,12 @@ define(
               shippingRatesValidationRules,
               addressConverter,
               selectShippingAddress,
+              selectBillingAddress,
               shippingRateService,
               shippingService,
               postcodeValidator,
               $t,
-              uiRegistry) {
+              uiRegistry, billingBeforeShipping, customer) {
         'use strict';
 
         var countryElement = null,
@@ -55,13 +59,15 @@ define(
             observedElements = [],
             observableElements,
             defaultRules = {'rate': {'postcode': {'required': true}, 'country_id': {'required': true}}},
-            addressFields = window.checkoutConfig.oscConfig.addressFields;
+            addressFields = window.checkoutConfig.oscConfig.addressFields,
+            isShowBillingBeforeShipping = window.checkoutConfig.oscConfig.showBillingBeforeShipping;
 
         return _.extend(Validator, {
             isFormInline: function () {
                 return addressList().length === 0;
             },
-
+            isBillingSameShipping: !billingBeforeShipping.isBillingSameShipping(),
+            isCustomerLoggedIn: customer.isLoggedIn,
             getValidationRules: function () {
                 var rules = shippingRatesValidationRules.getRules();
 
@@ -130,9 +136,53 @@ define(
 
                 $.each(addressFields, function (index, field) {
                     uiRegistry.async(formPath + '.' + field)(self.oscBindHandler.bind(self));
+                    if (isShowBillingBeforeShipping) {
+                        uiRegistry.async('checkout.steps.shipping-step.billingAddress.billing-address-fieldset' + '.' + field)(self.oscBillingAddressBindHandler.bind(self));
+                    }
                 });
             },
+            oscBillingAddressBindHandler: function (element) {
+                var self = this;
+                if (element.component.indexOf('/group') !== -1) {
+                    $.each(element.elems(), function (index, elem) {
+                        self.oscBillingAddressBindHandler(elem);
+                    });
+                } else if (element && element.hasOwnProperty('value')) {
 
+                    element.on('value', function () {
+                        if (billingBeforeShipping.isBillingSameShipping()) return;
+                        self.oscPostcodeValidation();
+                        if (self.isFormInline() && !self.isCustomerLoggedIn()) {
+                            var addressFlat = addressConverter.formDataProviderToFlatData(
+                                self.oscCollectObservedData(),
+                                'billingAddress'
+                                ),
+                                address;
+
+                            address = addressConverter.formAddressDataToQuoteAddress(addressFlat);
+                            selectShippingAddress(address);
+                            if (!billingBeforeShipping.isBillingSameShipping()) {
+                                selectBillingAddress(address);
+                            }
+
+                            if ($.inArray(element.index, observableElements) !== -1 && self.oscValidateAddressData(element.index, addressFlat)) {
+                                shippingRateService.isAddressChange = true;
+                                clearTimeout(self.validateAddressTimeout);
+                                self.validateAddressTimeout = setTimeout(function () {
+                                    shippingRateService.estimateShippingMethod();
+                                }, 200);
+                            }
+                        }
+                    });
+                    observedElements.push(element);
+                    if (element.index === postcodeElementName) {
+                        postcodeElement = element;
+                    }
+                    if (element.index === 'country_id') {
+                        countryElement = element;
+                    }
+                }
+            },
             oscBindHandler: function (element) {
                 var self = this;
 
@@ -155,8 +205,8 @@ define(
                             selectShippingAddress(address);
 
                             if ($.inArray(element.index, observableElements) !== -1 && self.oscValidateAddressData(element.index, addressFlat)) {
-                                shippingRateService.isAddressChange = true;
 
+                                shippingRateService.isAddressChange = true;
                                 clearTimeout(self.validateAddressTimeout);
                                 self.validateAddressTimeout = setTimeout(function () {
                                     shippingRateService.estimateShippingMethod();
diff --git a/view/frontend/web/js/view/authentication.js b/view/frontend/web/js/view/authentication.js
index 071980d..9e6e17a 100644
--- a/view/frontend/web/js/view/authentication.js
+++ b/view/frontend/web/js/view/authentication.js
@@ -35,9 +35,7 @@ define(
     function ($, ko, Component, loginAction, customer, $t, modal, messageContainer) {
         'use strict';
 
-        var checkoutConfig  = window.checkoutConfig;
-        var emailElement    = ('.popup-authentication #login-email'),
-            passwordElement = ('.popup-authentication #login-password');
+        var checkoutConfig = window.checkoutConfig;
 
         return Component.extend({
             registerUrl: checkoutConfig.registerUrl,
@@ -73,9 +71,9 @@ define(
                     'trigger': '.osc-authentication-toggle',
                     'buttons': []
                 };
-                if (window.checkoutConfig.oscConfig.isDisplaySocialLogin && $("#social-login-popup").length > 0) {
-                    this.modalWindow = $("#social-login-popup");
-                    options.modalClass = 'osc-social-login-popup';
+                if(window.checkoutConfig.oscConfig.isDisplaySocialLogin && $("#social-login-popup").length>0){
+                    this.modalWindow    =   $("#social-login-popup");
+                    options.modalClass  =   'osc-social-login-popup';
                 }
                 modal(options, $(this.modalWindow));
             },
@@ -109,14 +107,6 @@ define(
                             }
                         });
                 }
-            },
-
-            /** Move label element when input has value */
-            hasValue: function () {
-                if (window.checkoutConfig.oscConfig.isUsedMaterialDesign) {
-                    $(emailElement).val() ? $(emailElement).addClass('active') : $(emailElement).removeClass('active');
-                    $(passwordElement).val() ? $(passwordElement).addClass('active') : $(passwordElement).removeClass('active');
-                }
             }
         });
     }
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 50d6fe2..a4087ab 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -27,7 +27,9 @@ define(
         'Magento_Checkout/js/checkout-data',
         'Mageplaza_Osc/js/model/osc-data',
         'Magento_Checkout/js/action/create-billing-address',
+        'Magento_Checkout/js/action/create-shipping-address',
         'Magento_Checkout/js/action/select-billing-address',
+        'Magento_Checkout/js/action/select-shipping-address',
         'Magento_Customer/js/model/customer',
         'Magento_Checkout/js/action/set-billing-address',
         'Magento_Checkout/js/model/address-converter',
@@ -37,7 +39,11 @@ define(
         'Mageplaza_Osc/js/model/address/auto-complete',
         'uiRegistry',
         'mage/translate',
-        'rjsResolver'
+        'rjsResolver',
+        'Mageplaza_Osc/js/model/billing-before-shipping',
+        'Magento_Checkout/js/model/shipping-rate-service',
+        'Mageplaza_Osc/js/model/shipping-rates-validator',
+        'Magento_Customer/js/model/address-list',
     ],
     function ($,
               ko,
@@ -46,7 +52,9 @@ define(
               checkoutData,
               oscData,
               createBillingAddress,
+              createShippingAddress,
               selectBillingAddress,
+              selectShippingAddress,
               customer,
               setBillingAddressAction,
               addressConverter,
@@ -56,17 +64,27 @@ define(
               addressAutoComplete,
               registry,
               $t,
-              resolver) {
+              resolver,
+              billingBeforeShipping,
+              shippingRateService,
+              shippingRatesValidators,
+              addressList) {
         'use strict';
 
         var observedElements = [],
-            canShowBillingAddress = window.checkoutConfig.oscConfig.showBillingAddress;
+            canShowBillingAddress = window.checkoutConfig.oscConfig.showBillingAddress,
+            selectedShippingAddress = null,
+            fieldSelectBillingElement = '.field-select-billing select[name=billing_address_id] option',
+            reloadPage = true,
+            hasSetDefaultAddress = false;
 
         return Component.extend({
             defaults: {
                 template: ''
             },
             isCustomerLoggedIn: customer.isLoggedIn,
+            isShowBillingBeforeShipping: window.checkoutConfig.oscConfig.showBillingBeforeShipping,
+            isBillingSameShipping: !billingBeforeShipping.isBillingSameShipping(),
             quoteIsVirtual: quote.isVirtual(),
 
             canUseShippingAddress: ko.computed(function () {
@@ -100,11 +118,27 @@ define(
                     });
                 });
 
-                quote.shippingAddress.subscribe(function (newAddress) {
-                    if (self.isAddressSameAsShipping()) {
-                        selectBillingAddress(newAddress);
-                    }
-                });
+                if (this.isShowBillingBeforeShipping) {
+                    quote.billingAddress.subscribe(function (newAddress) {
+                        if (!billingBeforeShipping.isBillingSameShipping()) {
+                            self.isAddressSameAsShipping(!billingBeforeShipping.isBillingSameShipping());
+                            selectShippingAddress(newAddress);
+                        }
+                    });
+                    this.isAddressFormVisible.subscribe(function () {
+                        self.saveInAddressBook(true);
+                    });
+                    this.saveInAddressBook.subscribe(function () {
+                        if (self.isAddressFormVisible()) self.saveNewBillingAddress();
+                    });
+                } else {
+                    quote.shippingAddress.subscribe(function (newAddress) {
+                        if (self.isAddressSameAsShipping()) {
+                            selectBillingAddress(newAddress);
+                        }
+                    });
+                }
+
 
                 resolver(this.afterResolveDocument.bind(this));
 
@@ -113,33 +147,184 @@ define(
 
             afterResolveDocument: function () {
                 this.saveBillingAddress();
-
                 addressAutoComplete.register('billing');
             },
 
             /**
+             * set default address when page is reload
+             */
+            initDefaultAddress: function () {
+                if (reloadPage && customer.isLoggedIn() && this.customerHasAddresses) {
+                    var selectedBillingAddress = checkoutData.getSelectedBillingAddress(),
+                        newCustomerBillingAddressData = checkoutData.getNewCustomerBillingAddress();
+                    if (selectedBillingAddress) {
+                        if (selectedBillingAddress == 'new-customer-address' && newCustomerBillingAddressData) {
+
+                            $(fieldSelectBillingElement + ':last-child').prop('selected', true);
+                            this.isAddressFormVisible(true);
+                            this.setCustomerAddress('default-shipping', '');
+
+                        } else {
+                            this.setCustomerAddress('has-select-address', selectedBillingAddress);
+                        }
+                    } else if (window.customerData.default_billing != null) {
+                        this.setCustomerAddress('default-billing', '');
+                    }
+                }
+                reloadPage = false;
+            },
+
+            /**
+             * @param condition
+             * @param selectedValue
+             */
+            setCustomerAddress: function (condition, selectedValue) {
+                var self = this;
+                $.each(addressList(), function (key, address) {
+                    if (condition == 'default-shipping') {
+                        if (address.isDefaultShipping()) {
+                            selectedShippingAddress = address;
+                            return false;
+                        }
+                    }
+                    if (condition == 'default-billing') {
+                        if (address.isDefaultBilling()) {
+                            $(fieldSelectBillingElement).eq(key).prop('selected', true);
+                            self.selectAddress(address);
+                            return false;
+                        }
+                    }
+
+                    if (condition == 'has-select-address') {
+                        if (selectedValue == address.getKey()) {
+                            $(fieldSelectBillingElement).eq(key).prop('selected', true);
+                            self.selectAddress(address);
+                            return false;
+                        }
+                    }
+                });
+            },
+
+            /**
+             * Select Address
+             * @param address
+             */
+            selectAddress: function (address) {
+                if (!billingBeforeShipping.isBillingSameShipping()) {
+                    selectedShippingAddress = address;
+                    selectShippingAddress(address);
+                    checkoutData.setSelectedShippingAddress(address.getKey());
+                }
+                selectBillingAddress(address);
+                checkoutData.setSelectedBillingAddress(address.getKey());
+            },
+
+            /**
              * @return {Boolean}
              */
             useShippingAddress: function () {
-                if (this.isAddressSameAsShipping()) {
-                    selectBillingAddress(quote.shippingAddress());
-                    checkoutData.setSelectedBillingAddress(null);
-                    if (window.checkoutConfig.reloadOnBillingAddress) {
-                        setBillingAddressAction(globalMessageList);
+                if (this.isShowBillingBeforeShipping) {
+                    billingBeforeShipping.setBillingSameShipping();
+                    if (!billingBeforeShipping.isBillingSameShipping()) {
+                        if (this.selectedAddress() && !this.isAddressFormVisible()) {
+                            selectShippingAddress(this.selectedAddress());
+                            checkoutData.setSelectedShippingAddress(this.selectedAddress().getKey());
+                        } else {
+                            var addressFlat = addressConverter.formDataProviderToFlatData(this.collectObservedData(), 'billingAddress'),
+                                address;
+                            address = addressConverter.formAddressDataToQuoteAddress(addressFlat);
+                            selectShippingAddress(address);
+                            selectBillingAddress(address);
+                        }
+                        this.oscEstimateShippingMethod();
+
+                    } else {
+                        this.updateShippingAddress();
                     }
+
                 } else {
-                    this.updateAddress();
+                    if (this.isAddressSameAsShipping()) {
+                        selectBillingAddress(quote.shippingAddress());
+                        checkoutData.setSelectedBillingAddress(null);
+                        if (window.checkoutConfig.reloadOnBillingAddress) {
+                            setBillingAddressAction(globalMessageList);
+                        }
+                    } else {
+                        this.updateAddress();
+                    }
                 }
 
                 return true;
             },
 
+            /**
+             * @param address
+             */
             onAddressChange: function (address) {
                 this._super(address);
+                if (this.isShowBillingBeforeShipping) {
+                    this.initDefaultAddress();
+                    if (this.isAddressFormVisible()) {
+                        this.saveNewBillingAddress();
+                    } else {
+                        if (hasSetDefaultAddress) {
+                            this.selectAddress(this.selectedAddress());
+                        }
+                    }
+                    this.oscEstimateShippingMethod();
+                    hasSetDefaultAddress = true;
+                } else {
+                    if (!this.isAddressSameAsShipping() && canShowBillingAddress) {
+                        this.updateAddress();
+                    }
+                }
+            },
 
-                if (!this.isAddressSameAsShipping() && canShowBillingAddress) {
-                    this.updateAddress();
+            /**
+             * Save new Billing Address
+             * @returns {*}
+             */
+            saveNewBillingAddress: function () {
+                var addressData = this.source.get('billingAddress'),
+                    newBillingAddress;
+                if (customer.isLoggedIn() && !this.customerHasAddresses) {
+                    this.saveInAddressBook(1);
                 }
+                addressData.save_in_address_book = this.saveInAddressBook() ? 1 : 0;
+                newBillingAddress = createBillingAddress(addressData);
+
+                // New address must be selected as a billing address
+                selectBillingAddress(newBillingAddress);
+                checkoutData.setSelectedBillingAddress(newBillingAddress.getKey());
+                checkoutData.setNewCustomerBillingAddress(addressData);
+                return newBillingAddress;
+            },
+
+            /**
+             * Estimate shipping method
+             */
+            oscEstimateShippingMethod: function () {
+                shippingRateService.isAddressChange = true;
+                clearTimeout(self.validateAddressTimeout);
+                self.validateAddressTimeout = setTimeout(function () {
+                    shippingRateService.estimateShippingMethod();
+                }, 200);
+            },
+
+            /**
+             * Update shipping address action
+             */
+            updateShippingAddress: function () {
+                if (this.selectedAddress() && !this.isAddressFormVisible()) return;
+                if (customer.isLoggedIn() && this.isAddressFormVisible() && this.customerHasAddresses) {
+                    selectShippingAddress(selectedShippingAddress);
+                } else {
+                    var addressData = this.source.get('shippingAddress');
+                    selectShippingAddress(addressConverter.formAddressDataToQuoteAddress(addressData));
+                }
+                this.oscEstimateShippingMethod();
+
+
             },
 
             /**
@@ -173,6 +358,8 @@ define(
 
             /**
              * Perform postponed binding for fieldset elements
+             * on change value for billing addresss
+             *
              */
             initFields: function () {
                 var self = this,
@@ -200,6 +387,33 @@ define(
             },
 
             saveBillingAddress: function (fieldName) {
+                /**
+                 * when billing address before shipping address
+                 */
+                if (this.isShowBillingBeforeShipping) {
+                    if (customer.isLoggedIn() && this.isAddressFormVisible()) {
+                        var newBillingAddress = this.saveNewBillingAddress()
+                        if (!billingBeforeShipping.isBillingSameShipping() && this.isAddressFormVisible()) {
+                            if (shippingRatesValidators.oscValidateAddressData(fieldName, newBillingAddress)) {
+                                this.oscEstimateShippingMethod();
+                            }
+                        }
+                    } else {
+                        if (billingBeforeShipping.isBillingSameShipping()) {
+                            var addressFlat = addressConverter.formDataProviderToFlatData(
+                                this.collectObservedData(),
+                                'billingAddress'
+                            );
+
+                            selectBillingAddress(addressConverter.formAddressDataToQuoteAddress(addressFlat));
+                        }
+                    }
+                    return;
+                }
+
+                /**
+                 * when shipping address before billing address
+                 */
                 if (!this.isAddressSameAsShipping()) {
                     if (!canShowBillingAddress) {
                         selectBillingAddress(quote.shippingAddress());
@@ -233,10 +447,16 @@ define(
                 return observedValues;
             },
 
+            /**
+             * validate billing address
+             * @returns {boolean}
+             */
             validate: function () {
-                if (this.isAddressSameAsShipping()) {
-                    oscData.setData('same_as_shipping', true);
-                    return true;
+                if (!this.isShowBillingBeforeShipping) {
+                    if (this.isAddressSameAsShipping()) {
+                        oscData.setData('same_as_shipping', true);
+                        return true;
+                    }
                 }
 
                 if (!this.isAddressFormVisible()) {
@@ -249,8 +469,10 @@ define(
                 if (this.source.get('billingAddress.custom_attributes')) {
                     this.source.trigger('billingAddress.custom_attributes.data.validate');
                 }
+                if (!this.isShowBillingBeforeShipping) {
+                    oscData.setData('same_as_shipping', false);
+                }
 
-                oscData.setData('same_as_shipping', false);
                 return !this.source.get('params.invalid');
             },
             getAddressTemplate: function () {
diff --git a/view/frontend/web/js/view/delivery-time.js b/view/frontend/web/js/view/delivery-time.js
index 817abeb..3b4dd47 100644
--- a/view/frontend/web/js/view/delivery-time.js
+++ b/view/frontend/web/js/view/delivery-time.js
@@ -31,13 +31,11 @@ define(
         'use strict';
         var cacheKey = 'deliveryTime',
             isVisible = oscData.getData(cacheKey) ? true : false;
-        var cacheKeyHouseSecurityCode = 'houseSecurityCode';
 
         return Component.extend({
             defaults: {
                 template: 'Mageplaza_Osc/container/delivery-time'
             },
-            houseSecurityCodeValue: ko.observable(),
             deliveryTimeValue: ko.observable(),
             isVisible: ko.observable(isVisible),
             initialize: function () {
@@ -68,11 +66,6 @@ define(
                     oscData.setData(cacheKey, newValue);
                     self.isVisible(true);
                 });
-                //House Security Code
-                this.houseSecurityCodeValue(oscData.getData(cacheKeyHouseSecurityCode));
-                this.houseSecurityCodeValue.subscribe(function (newValue) {
-                    oscData.setData(cacheKeyHouseSecurityCode, newValue);
-                });
                 return this;
             },
             removeDeliveryTime: function () {
@@ -81,12 +74,6 @@ define(
                     $("#osc-delivery-time").attr('value', '');
                     this.isVisible(false);
                 }
-            },
-            canUseHouseSecurityCode: function () {
-                if(!window.checkoutConfig.oscConfig.deliveryTimeOptions.houseSecurityCode){
-                    return true;
-                }
-                return false;
             }
         });
     }
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index 4a8e686..bc2be75 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -26,17 +26,15 @@ define([
     'Mageplaza_Osc/js/model/osc-data',
     'Magento_Checkout/js/model/payment/additional-validators',
     'Magento_Customer/js/action/check-email-availability',
-    'mage/url',
     'rjsResolver',
     'mage/validation'
-], function ($, ko, Component, customer, oscData, additionalValidators, checkEmailAvailability,urlBuilder, resolver) {
+], function ($, ko, Component, customer, oscData, additionalValidators, checkEmailAvailability, resolver) {
     'use strict';
 
     var cacheKey = 'form_register_chechbox',
         allowGuestCheckout = window.checkoutConfig.oscConfig.allowGuestCheckout,
         passwordMinLength = window.checkoutConfig.oscConfig.register.dataPasswordMinLength,
-        passwordMinCharacter = window.checkoutConfig.oscConfig.register.dataPasswordMinCharacterSets,
-        customerEmailElement = '.form-login #customer-email';
+        passwordMinCharacter = window.checkoutConfig.oscConfig.register.dataPasswordMinCharacterSets;
 
     if (!customer.isLoggedIn() && !allowGuestCheckout) {
         oscData.setData(cacheKey, true);
@@ -79,11 +77,7 @@ define([
         },
 
         triggerLogin: function () {
-            if($('.osc-authentication-wrapper a.action-auth-toggle').hasClass('osc-authentication-toggle')){
-                $('.osc-authentication-toggle').trigger('click');
-            }else{
-                window.location.href = urlBuilder.build("customer/account/login");
-            }
+            $('.osc-authentication-toggle').trigger('click');
         },
 
 
@@ -105,7 +99,6 @@ define([
         },
 
         validate: function (type) {
-
             if (customer.isLoggedIn() || !this.isRegisterVisible() || this.isPasswordVisible()) {
                 oscData.setData('register', false);
                 return true;
@@ -133,13 +126,6 @@ define([
 
             return result;
 
-        },
-
-        /** Move label element when input has value */
-        hasValue: function(){
-            if (window.checkoutConfig.oscConfig.isUsedMaterialDesign) {
-                $(customerEmailElement).val() ? $(customerEmailElement).addClass('active') : $(customerEmailElement).removeClass('active');
-            }
         }
     });
 });
diff --git a/view/frontend/web/js/view/form/element/region.js b/view/frontend/web/js/view/form/element/region.js
index 2c5fe9a..33c55fa 100644
--- a/view/frontend/web/js/view/form/element/region.js
+++ b/view/frontend/web/js/view/form/element/region.js
@@ -25,11 +25,11 @@ define([
     'uiLayout'
 ], function (_, Component, utils, layout) {
     'use strict';
-    var template = window.checkoutConfig.oscConfig.isUsedMaterialDesign ? 'Mageplaza_Osc/container/form/field' : '${ $.$data.template }';
+
     var inputNode = {
         parent: '${ $.$data.parentName }',
         component: 'Magento_Ui/js/form/element/abstract',
-        template: template,
+        template: '${ $.$data.template }',
         elementTmpl: 'Mageplaza_Osc/container/form/element/input',
         provider: '${ $.$data.provider }',
         name: '${ $.$data.index }_input',
diff --git a/view/frontend/web/js/view/geoip.js b/view/frontend/web/js/view/geoip.js
deleted file mode 100644
index 57b1aec..0000000
--- a/view/frontend/web/js/view/geoip.js
+++ /dev/null
@@ -1,71 +0,0 @@
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
-        'underscore',
-        'uiComponent',
-        'Magento_Checkout/js/model/quote',
-        'Magento_Customer/js/model/customer',
-        'Magento_Checkout/js/checkout-data'
-    ],
-    function ($,
-              _,
-              Component,
-              quote,
-              customer,
-              checkoutData) {
-        'use strict';
-
-        var  isEnableGeoIp = window.checkoutConfig.oscConfig.geoIpOptions.isEnableGeoIp,
-             geoIpData     =  window.checkoutConfig.oscConfig.geoIpOptions.geoIpData;
-        return Component.extend({
-            initialize: function () {
-                this.initGeoIp();
-                this._super();
-                return this;
-            },
-            initGeoIp: function(){
-                if(isEnableGeoIp){
-                    if(!quote.isVirtual()){
-
-                        /**
-                         * Set Geo Ip data to shippingAddress
-                         */
-                        if((!customer.isLoggedIn() && checkoutData.getShippingAddressFromData() == null)
-                            || (customer.isLoggedIn() && checkoutData.getNewCustomerShippingAddress()== null)){
-                                checkoutData.setShippingAddressFromData(geoIpData);
-                        }
-                    }else{
-
-                        /**
-                         * Set Geo Ip data to billingAddress
-                         */
-                        if((!customer.isLoggedIn() && checkoutData.getBillingAddressFromData() == null)
-                            || (customer.isLoggedIn() && checkoutData.setNewCustomerBillingAddress()== null)){
-                            checkoutData.setBillingAddressFromData(geoIpData);
-                        }
-                    }
-                }
-            }
-        });
-    }
-);
diff --git a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js b/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
deleted file mode 100644
index 2141339..0000000
--- a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
+++ /dev/null
@@ -1,27 +0,0 @@
-define([
-    'jquery',
-    'Mageplaza_Osc/js/action/set-checkout-information',
-    'Mageplaza_Osc/js/model/braintree-paypal',
-    'Magento_Checkout/js/model/payment/additional-validators',
-], function ($, setCheckoutInformationAction, braintreePaypalModel, additionalValidators) {
-    'use strict';
-        return function (BraintreePaypalComponent) {
-            return BraintreePaypalComponent.extend({
-                /**
-                 * Set list of observable attributes
-                 * @returns {exports.initObservable}
-                 */
-                initObservable: function () {
-                    var self = this;
-
-                    this._super();
-                    // for each component initialization need update property
-                    this.isReviewRequired = braintreePaypalModel.isReviewRequired;
-                    this.customerEmail = braintreePaypalModel.customerEmail;
-                    this.active = braintreePaypalModel.active;
-
-                    return this;
-                }
-            })
-        }
-});
\ No newline at end of file
diff --git a/view/frontend/web/js/view/review/placeOrder.js b/view/frontend/web/js/view/review/placeOrder.js
index 16c27ff..d4223aa 100644
--- a/view/frontend/web/js/view/review/placeOrder.js
+++ b/view/frontend/web/js/view/review/placeOrder.js
@@ -9,8 +9,8 @@
  *
  * DISCLAIMER
  *
- * Do not edit or add to this file if you wish to upgrade this extension to
- * newer version in the future.
+ * Do not edit or add to this file if you wish to upgrade this extension to newer
+ * version in the future.
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
@@ -21,71 +21,28 @@
 define(
     [
         'jquery',
-        'underscore',
-        'ko',
         'uiComponent',
-        'uiRegistry',
-        'Magento_Checkout/js/model/quote',
         'Magento_Checkout/js/model/payment/additional-validators',
-        'Mageplaza_Osc/js/action/set-checkout-information',
-        'Mageplaza_Osc/js/model/braintree-paypal'
+        'Mageplaza_Osc/js/action/set-checkout-information'
     ],
     function (
         $,
-        _,
-        ko,
         Component,
-        registry,
-        quote,
         additionalValidators,
-        setCheckoutInformationAction,
-        braintreePaypalModel
+        setCheckoutInformationAction
     ) {
         "use strict";
-
         return Component.extend({
             defaults: {
-                template: 'Mageplaza_Osc/container/review/place-order',
-                visibleBraintreeButton: false
-            },
-            braintreePaypalModel: braintreePaypalModel,
-            selectors: {
-                default: '#co-payment-form .payment-method._active button.action.primary.checkout'
+                template: 'Mageplaza_Osc/container/review/place-order'
             },
-            initialize: function () {
-                this._super();
-                var self = this;
-                quote.paymentMethod.subscribe(function (value) {
-                    self.checkVisiblePlaceOrderButton();
-                });
-
-                registry.async(this.getPaymentPath('braintree_paypal'))
-                (this.asyncBraintreePaypal.bind(this));
-
-                return this;
-            },
-            /**
-             * Set list of observable attributes
-             * @returns {exports.initObservable}
-             */
-            initObservable: function () {
-                var self = this;
-
-                this._super()
-                    .observe(['visibleBraintreeButton']);
+            paymentButton: '#co-payment-form .payment-method._active button.action.primary.checkout',
 
-                return this;
-            },
-            asyncBraintreePaypal: function () {
-                this.checkVisiblePlaceOrderButton();
-            },
-            checkVisiblePlaceOrderButton: function () {
-                this.visibleBraintreeButton(this.getBraintreePaypalComponent() && this.isPaymentBraintreePaypal());
-            },
             placeOrder: function () {
                 var self = this;
                 if (additionalValidators.validate()) {
-                    this.preparePlaceOrder().done(function () {
+                    $.when(setCheckoutInformationAction()).done(function () {
+                        $("body").animate({ scrollTop: 0 }, "slow");
                         self._placeOrder();
                     });
                 }
@@ -93,59 +50,11 @@ define(
                 return this;
             },
 
-            brainTreePaypalPlaceOrder: function () {
-                var component = this.getBraintreePaypalComponent();
-                var _arguments = arguments;
-                if(component && additionalValidators.validate()) {
-                    this.preparePlaceOrder().done(function () {
-                        component.placeOrder.apply(component, _arguments);
-                    });
-                }
-
-                return this;
-            },
-
-            brainTreePayWithPayPal: function () {
-                var component = this.getBraintreePaypalComponent();
-                var _arguments = arguments;
-                if(component && additionalValidators.validate()) {
-                    if(component.isSkipOrderReview()) {
-                        this.preparePlaceOrder().done(function () {
-                            component.payWithPayPal.apply(component, _arguments);
-                        });
-                    } else {
-                        component.payWithPayPal.apply(component, _arguments);
-                    }
-                }
-            },
-            preparePlaceOrder: function (scrollTop) {
-                var scrollTop = scrollTop !== undefined ? scrollTop : true;
-                var deferer = $.when(setCheckoutInformationAction());
-
-                return scrollTop ? deferer.done(function () {
-                    $("body").animate({ scrollTop: 0 }, "slow");
-                }): deferer;
-            },
-
-            getPaymentPath: function(paymentMethodCode) {
-                return 'checkout.steps.billing-step.payment.payments-list.' + paymentMethodCode;
-            },
-
-            getPaymentMethodComponent: function (paymentMethodCode) {
-                return registry.get(this.getPaymentPath(paymentMethodCode));
-            },
-
-
-            isPaymentBraintreePaypal: function () {
-                return quote.paymentMethod() && quote.paymentMethod().method === 'braintree_paypal';
-            },
-
-            getBraintreePaypalComponent: function () {
-                return this.getPaymentMethodComponent('braintree_paypal');
-            },
-
             _placeOrder: function () {
-                $(this.selectors.default).trigger('click');
+                var paymentButton = $(this.paymentButton);
+                if (paymentButton.length) {
+                    paymentButton.first().trigger('click');
+                }
             },
 
             isPlaceOrderActionAllowed: function () {
diff --git a/view/frontend/web/js/view/shipping-postnl.js b/view/frontend/web/js/view/shipping-postnl.js
deleted file mode 100644
index 3705ebd..0000000
--- a/view/frontend/web/js/view/shipping-postnl.js
+++ /dev/null
@@ -1,55 +0,0 @@
-define([
-    'jquery',
-    'TIG_PostNL/js/Helper/State',
-    'Magento_Checkout/js/model/quote',
-    'Magento_Catalog/js/price-utils',
-    'Mageplaza_Osc/js/action/payment-total-information'
-], function (
-    $,
-    State,
-    quote,
-    priceUtils,
-    getPaymentTotalInformation
-) {
-    return function (Shipping) {
-        return Shipping.extend({
-            initialize: function () {
-                this._super();
-                $(document).on('compatible_postnl_deliveryoptions_save_done', function (event, data) {
-                    getPaymentTotalInformation();
-                });
-            },
-            PostNLFee: State.fee,
-            isEnableModulePostNL: window.checkoutConfig.oscConfig.compatible.isEnableModulePostNL,
-            canUseDeliveryOption: function () {
-                var deliveryOptionsActive = window.checkoutConfig.shipping.postnl.shippingoptions_active == 1;
-                var deliveryDaysActive = window.checkoutConfig.shipping.postnl.is_deliverydays_active;
-                var pakjegemakActive = window.checkoutConfig.shipping.postnl.pakjegemak_active == '1';
-
-                return deliveryOptionsActive && (deliveryDaysActive || pakjegemakActive);
-            },
-
-            isPostNLDeliveryMethod: function (method) {
-                return method.carrier_code == 'tig_postnl';
-            },
-
-            canUsePostnlDeliveryOptions: function (method) {
-                if (!this.canUseDeliveryOption()) {
-                    return false;
-                }
-
-                var result = this.isPostNLDeliveryMethod(method);
-
-                if (result) {
-                    State.method(method);
-                }
-
-                return result;
-            },
-
-            formatPrice: function (price) {
-                return priceUtils.formatPrice(price, quote.getPriceFormat());
-            }
-        });
-    }
-});
\ No newline at end of file
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index 36ff37f..f8547b8 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -37,7 +37,9 @@ define(
         'Magento_Checkout/js/model/shipping-service',
         'Mageplaza_Osc/js/model/checkout-data-resolver',
         'Mageplaza_Osc/js/model/address/auto-complete',
-        'rjsResolver'
+        'rjsResolver',
+        'Mageplaza_Osc/js/model/billing-before-shipping',
+        'Mageplaza_Osc/js/model/osc-data'
     ],
     function ($,
               _,
@@ -56,7 +58,9 @@ define(
               shippingService,
               oscDataResolver,
               addressAutoComplete,
-              resolver) {
+              resolver,
+              billingBeforeShipping,
+              oscData) {
         'use strict';
 
         oscDataResolver.resolveDefaultShippingMethod();
@@ -69,6 +73,8 @@ define(
                 template: 'Mageplaza_Osc/container/shipping'
             },
             currentMethod: null,
+            isBillingSameShipping: billingBeforeShipping.isBillingSameShipping,
+            isShowBillingBeforeShipping: window.checkoutConfig.oscConfig.showBillingBeforeShipping,
             initialize: function () {
                 this._super();
 
@@ -86,12 +92,14 @@ define(
                 this._super();
 
                 quote.shippingMethod.subscribe(function (oldValue) {
+
                     this.currentMethod = oldValue;
                 }, this, 'beforeChange');
 
                 quote.shippingMethod.subscribe(function (newValue) {
+
                     var isMethodChange = ($.type(this.currentMethod) !== 'object') ? true : this.currentMethod.method_code;
-                    if ($.type(newValue) === 'object' && (isMethodChange !== newValue.method_code)) {
+                    if ($.type(newValue) === 'object' && (isMethodChange != newValue.method_code)) {
                         setShippingInformationAction();
                     } else if (shippingRateService.isAddressChange) {
                         shippingRateService.isAddressChange = false;
@@ -110,36 +118,63 @@ define(
                 if (quote.isVirtual()) {
                     return true;
                 }
-
-                var shippingMethodValidationResult = true,
-                    shippingAddressValidationResult = true,
-                    loginFormSelector = 'form[data-role=email-with-possible-login]',
-                    emailValidationResult = customer.isLoggedIn();
-
+                var shippingMethodValidationResult = true;
                 if (!quote.shippingMethod()) {
                     this.errorValidationMessage('Please specify a shipping method.');
-
                     shippingMethodValidationResult = false;
                 }
 
+                if (this.isShowBillingBeforeShipping) {
+                    if (!billingBeforeShipping.isBillingSameShipping()) {
+                        oscData.setData('billing-same-shipping', false);
+                        return shippingMethodValidationResult;
+                    }
+                }
+
+
+                var shippingAddressValidationResult = true,
+                    loginFormSelector = 'form[data-role=email-with-possible-login]',
+                    emailValidationResult = customer.isLoggedIn();
+
                 if (!customer.isLoggedIn()) {
                     $(loginFormSelector).validation();
                     emailValidationResult = Boolean($(loginFormSelector + ' input[name=username]').valid());
                 }
+                if (this.isShowBillingBeforeShipping && customer.isLoggedIn() && billingBeforeShipping.isBillingSameShipping() && this.isFormInline) {
+                    var shippingAddress = quote.shippingAddress();
+                    shippingAddress.save_in_address_book = 1;
+                    selectShippingAddress(shippingAddress);
+                }
 
-                if (this.isFormInline) {
-                    this.source.set('params.invalid', false);
-                    this.source.trigger('shippingAddress.data.validate');
-
-                    if (this.source.get('shippingAddress.custom_attributes')) {
-                        this.source.trigger('shippingAddress.custom_attributes.data.validate');
-                    }
 
-                    if (this.source.get('params.invalid')) {
-                        shippingAddressValidationResult = false;
+                if (this.isFormInline) {
+                    if (this.isShowBillingBeforeShipping) {
+                        if (billingBeforeShipping.isBillingSameShipping()) {
+                            this.source.set('params.invalid', false);
+                            this.source.trigger('shippingAddress.data.validate');
+
+                            if (this.source.get('shippingAddress.custom_attributes')) {
+                                this.source.trigger('shippingAddress.custom_attributes.data.validate');
+                            }
+
+                            if (this.source.get('params.invalid')) {
+                                shippingAddressValidationResult = false;
+                            }
+                        }
+                    } else {
+                        this.source.set('params.invalid', false);
+                        this.source.trigger('shippingAddress.data.validate');
+
+                        if (this.source.get('shippingAddress.custom_attributes')) {
+                            this.source.trigger('shippingAddress.custom_attributes.data.validate');
+                        }
+
+                        if (this.source.get('params.invalid')) {
+                            shippingAddressValidationResult = false;
+                        }
+
+                        this.saveShippingAddress();
                     }
-
-                    this.saveShippingAddress();
                 }
 
                 if (!emailValidationResult) {
@@ -175,6 +210,7 @@ define(
             },
 
             saveNewAddress: function () {
+
                 this.source.set('params.invalid', false);
                 if (this.source.get('shippingAddress.custom_attributes')) {
                     this.source.trigger('shippingAddress.custom_attributes.data.validate');
diff --git a/view/frontend/web/js/view/summary/item/details.js b/view/frontend/web/js/view/summary/item/details.js
index de67052..d30e81e 100644
--- a/view/frontend/web/js/view/summary/item/details.js
+++ b/view/frontend/web/js/view/summary/item/details.js
@@ -25,38 +25,23 @@ define(
         'Magento_Checkout/js/view/summary/item/details',
         'Magento_Checkout/js/model/quote',
         'Mageplaza_Osc/js/action/update-item',
-        'Mageplaza_Osc/js/action/gift-message-item',
-        'mage/url',
-        'mage/translate',
-        'Magento_Ui/js/modal/modal'
+        'mage/url'
     ],
     function (_,
               $,
               Component,
               quote,
               updateItemAction,
-              giftMessageItem,
-              url,
-              $t,
-              modal
-    ) {
+              url) {
         "use strict";
 
-        var products = window.checkoutConfig.quoteItemData,
-            giftMessageOptions = window.checkoutConfig.oscConfig.giftMessageOptions;
-
+        var products = window.checkoutConfig.quoteItemData;
 
         return Component.extend({
             defaults: {
                 template: 'Mageplaza_Osc/container/summary/item/details'
             },
-            giftMessageItemsTitleHover : $t('Gift message item'),
 
-            /**
-             * Get product url
-             * @param parent
-             * @returns {*}
-             */
             getProductUrl: function (parent) {
                 var item = _.find(products, function (product) {
                     return product.item_id == parent.item_id;
@@ -71,117 +56,6 @@ define(
             },
 
             /**
-             * Init popup gift message item window
-             * @param element
-             */
-            setModalElement: function (element) {
-                this.modalWindow = element;
-                var options = {
-                    'type': 'popup',
-                    'title': $t('Gift Message Item &#40'+ element.title +'&#41'),
-                    'modalClass': 'popup-gift-message-item',
-                    'responsive': true,
-                    'innerScroll': true,
-                    'trigger': '#' +element.id ,
-                    'buttons': []
-                };
-                modal(options, $(this.modalWindow));
-            },
-
-            /**
-             * Load exist gift message item from
-             * @param itemId
-             */
-            loadGiftMessageItem: function(itemId){
-                $('.popup-gift-message-item #item'+ itemId).find('input:text,textarea').val('');
-                if(giftMessageOptions.giftMessage.itemLevel[itemId].hasOwnProperty('message')
-                    && typeof giftMessageOptions.giftMessage.itemLevel[itemId]['message'] == 'object'){
-                    var giftMessageItem = giftMessageOptions.giftMessage.itemLevel[itemId]['message'];
-                    $(this.createSelectorElement(itemId +' #gift-message-whole-from')).val(giftMessageItem.sender);
-                    $(this.createSelectorElement(itemId +' #gift-message-whole-to')).val(giftMessageItem.recipient);
-                    $(this.createSelectorElement(itemId +' #gift-message-whole-message')).val(giftMessageItem.message);
-                    $(this.createSelectorElement(itemId +' .action.delete')).show();
-                    return this;
-                }
-
-                $(this.createSelectorElement(itemId +' .action.delete')).hide();
-            },
-
-            /**
-             * create selector element
-             * @param selector
-             * @returns {string}
-             */
-            createSelectorElement: function(selector){
-                return '.popup-gift-message-item #item'+ selector;
-            },
-
-            /**
-             * Update gift message item
-             * @param itemId
-             */
-            updateGiftMessageItem: function(itemId){
-
-                var data = {
-                    gift_message: {
-                        sender:     $(this.createSelectorElement(itemId +' #gift-message-whole-from')).val(),
-                        recipient:  $(this.createSelectorElement(itemId +' #gift-message-whole-to')).val(),
-                        message:    $(this.createSelectorElement(itemId +' #gift-message-whole-message')).val()
-                    }
-                };
-                giftMessageItem(data,itemId ,false);
-                this.closePopup();
-            },
-            /**
-             * Delete gift message item
-             * @param itemId
-             */
-            deleteGiftMessageItem: function(itemId){
-                giftMessageItem({
-                    gift_message: {
-                        sender: '',
-                        recipient: '',
-                        message:''
-                    }
-                },itemId,true);
-                this.closePopup();
-            },
-
-            /**
-             * Close popup gift message item
-             */
-            closePopup: function(){
-                $('.action-close').trigger('click');
-            },
-
-            /**
-             * Check item is available
-             * @param itemId
-             * @returns {boolean}
-             */
-            isItemAvailable: function(itemId){
-                var isGloballyAvailable,
-                    itemConfig;
-                var item = _.find(products, function (product) {
-                    return product.item_id == itemId;
-                });
-                if(item.is_virtual == true || !giftMessageOptions.isEnableOscGiftMessageItems) return false;
-
-                // gift message product configuration must override system configuration
-                isGloballyAvailable = this.getConfigValue('isItemLevelGiftOptionsEnabled');
-                itemConfig = giftMessageOptions.giftMessage.hasOwnProperty('itemLevel')
-                &&  giftMessageOptions.giftMessage.itemLevel.hasOwnProperty(itemId) ?
-                    giftMessageOptions.giftMessage.itemLevel[itemId] : {};
-
-                return itemConfig.hasOwnProperty('is_available') ? itemConfig['is_available'] : isGloballyAvailable;
-            },
-            getConfigValue: function(key) {
-                return giftMessageOptions.hasOwnProperty(key) ?
-                    giftMessageOptions[key]
-                    : false;
-            },
-
-            /**
              * Plus item qty
              *
              * @param id
diff --git a/view/frontend/web/template/1column.html b/view/frontend/web/template/1column.html
index 9127555..2cc8f7f 100644
--- a/view/frontend/web/template/1column.html
+++ b/view/frontend/web/template/1column.html
@@ -35,30 +35,26 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-lg-7 mp-6 mp-xs-12">
             <div class="row-mp">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <div class="col-mp mp-12 " data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                 <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
-                <div class="col-mp mp-12 " data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
                 <!--/ko-->
-                <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <div class=" col-mp mp-12 hoverable">
-                    <div class="row-mp">
-                        <div class="col-mp mp-12 " data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                            <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                        </div>
-                        <div class="col-mp mp-12 " data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                            <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                        </div>
-                    </div>
+                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                </div>
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
                 <!--/ko-->
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.shipping-step'">
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.billing-step'">
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.billing-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
diff --git a/view/frontend/web/template/2columns.html b/view/frontend/web/template/2columns.html
index 34221bf..a7cfa14 100644
--- a/view/frontend/web/template/2columns.html
+++ b/view/frontend/web/template/2columns.html
@@ -36,28 +36,23 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-6 mp-sm-5 mp-xs-12">
             <div class="row-mp">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
+                <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                </div>
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                <!--/ko-->
+                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
                     <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
-                <!-- /ko -->
-                <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <div class=" col-mp mp-12 hoverable">
-                    <div class="row-mp">
-                        <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                            <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                        </div>
-                        <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                            <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                        </div>
-                    </div>
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
                 </div>
-                <!-- /ko -->
-
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.shipping-step'">
+                <!--/ko-->
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
                 <div class="mp-clear"></div>
@@ -65,7 +60,7 @@
         </div>
         <div class="col-mp mp-6 mp-sm-7 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.billing-step'">
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.billing-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index d22060d..4ef4d44 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -35,36 +35,33 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="mp-clear"></div>
-                <!--/ko-->
-                <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <div class=" col-mp mp-12 hoverable">
-                    <div class="row-mp">
-                        <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                            <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                        </div>
-                        <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                            <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                        </div>
-                        <div class="mp-clear"></div>
+
+                 <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
                     </div>
-                </div>
-                <!--/ko-->
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                    </div>
+                <!-- /ko -->
+
+                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                    </div>
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                    </div>
+                <!-- /ko -->
+                <div class="mp-clear"></div>
             </div>
         </div>
         <div class="col-mp mp-8 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-6 mp-sm-12 mp-xs-12 hoverable" data-bind="scope: 'checkout.steps.shipping-step'">
+                <div class="col-mp mp-6 mp-sm-12 mp-xs-12" data-bind="scope: 'checkout.steps.shipping-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
-                <div class="col-mp mp-sm-12 mp-xs-12 hoverable only-colspan" data-bind="scope: 'checkout.steps.billing-step', css: {'mp-12': window.checkoutConfig.quoteData.is_virtual, 'mp-6': !window.checkoutConfig.quoteData.is_virtual}">
+                <div class="col-mp mp-sm-12 mp-xs-12" data-bind="scope: 'checkout.steps.billing-step', css: {'mp-12': window.checkoutConfig.quoteData.is_virtual, 'mp-6': !window.checkoutConfig.quoteData.is_virtual}">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
                 <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
diff --git a/view/frontend/web/template/3columns.html b/view/frontend/web/template/3columns.html
index f938692..217aa66 100644
--- a/view/frontend/web/template/3columns.html
+++ b/view/frontend/web/template/3columns.html
@@ -33,23 +33,33 @@
 
 <div class="opc-wrapper one-step-checkout-wrapper">
     <div class="opc one-step-checkout-container" id="checkoutSteps">
-        <div class="col-mp mp-4 mp-sm-6 mp-xs-12 hoverable">
+        <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
+                <!-- ko if: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                    </div>
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                    </div>
+                <!--/ko-->
+                <!-- ko ifnot: window.checkoutConfig.oscConfig.showBillingBeforeShipping -->
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                    </div>
+                    <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
+                        <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                    </div>
+                <!--/ko-->
                 <div class="mp-clear"></div>
             </div>
         </div>
         <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.shipping-step'">
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.billing-step'">
+                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.billing-step'">
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 </div>
                 <div class="mp-clear"></div>
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index 6067448..9012cb3 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -20,19 +20,13 @@
  */
 -->
 
-<div id="billing" class="checkout-billing-address" data-bind="visible: !isAddressSameAsShipping()">
+<div id="billing" class="checkout-billing-address" data-bind="visible: (isShowBillingBeforeShipping != true )? !isAddressSameAsShipping() : true ">
     <div class="step-title" data-role="title">
         <i class="fa fa-home"></i>
-        <!-- ko if: (window.checkoutConfig.oscConfig.isUsedMaterialDesign && !!Number(window.checkoutConfig.quoteData.is_virtual)) -->
-        <span class="fa-stack fa-2x">
-            <i class="fa fa-circle fa-stack-2x"></i>
-            <strong class="fa-stack-1x fa-stack-text fa-inverse">1</strong>
-        </span>
-        <!-- /ko -->
         <span data-bind="i18n: 'Billing Address'"></span>
     </div>
     <div id="checkout-step-billing" class="step-content" data-role="content">
-        <!-- ko if: (quoteIsVirtual) -->
+        <!-- ko if: (quoteIsVirtual || isShowBillingBeforeShipping) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: getTemplate() --><!-- /ko -->
             <!--/ko-->
@@ -46,12 +40,18 @@
 
         <div class="mp-clear"></div>
 
-        <!-- ko if: (!isCustomerLoggedIn() && quoteIsVirtual) -->
+        <!-- ko if: ((!isCustomerLoggedIn() && quoteIsVirtual) || (!isCustomerLoggedIn() && isShowBillingBeforeShipping) ) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
 
+        <!-- ko if: (isShowBillingBeforeShipping && !quoteIsVirtual) -->
+            <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
+                <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
+            <!--/ko-->
+        <!--/ko-->
+
         <div class="mp-clear"></div>
     </div>
 </div>
\ No newline at end of file
diff --git a/view/frontend/web/template/container/address/billing/create.html b/view/frontend/web/template/container/address/billing/create.html
index 8ccc7f3..22d446c 100644
--- a/view/frontend/web/template/container/address/billing/create.html
+++ b/view/frontend/web/template/container/address/billing/create.html
@@ -29,11 +29,9 @@
     </div>
     <fieldset class="fieldset hidden-fields mp-clear" data-bind="fadeVisible: isRegisterVisible">
         <form class="form form-create-account" id="create-account-form">
-            <div class="field osc-password required col-mp mp-6">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
+            <div class="field password required col-mp mp-6">
                 <label for="osc-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
-                <!-- /ko -->
-                <div class="control input-field">
+                <div class="control">
                     <input type="password" name="password" id="osc-password"
                            class="input-text"
                            data-bind="
@@ -43,27 +41,17 @@
                                },
                                event: {change: function(){validate('password')}}"
                            data-validate="{required:true, 'validate-customer-password':true}"
-                           autocomplete="off" required/>
-                    <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                        <label for="osc-password" class="label"><span data-bind="i18n: 'Password'"></span><i class="required-entry">*</i></label>
-                        <div for="osc-password" generated="true" class="mage-error" id="osc-password-error"></div>
-                    <!-- /ko -->
+                           autocomplete="off"/>
                 </div>
             </div>
             <div class="field confirmation required col-mp mp-6">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
                 <label for="osc-password-confirmation" class="label"><span data-bind="i18n: 'Confirm Password'"></span></label>
-                <!-- /ko -->
-                <div class="control input-field">
+                <div class="control">
                     <input type="password" name="password_confirmation" id="osc-password-confirmation"
                            class="input-text"
                            data-bind="event: {change: function(){validate('password-confirmation')}}"
                            data-validate="{required:true, equalTo:'#osc-password'}"
-                           autocomplete="off" required/>
-                    <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                    <label for="osc-password-confirmation" class="label"><span data-bind="i18n: 'Confirm Password'"></span><i class="required-entry">*</i></label>
-                    <div for="osc-password-confirmation" generated="true" class="mage-error" id="osc-password-confirmation-error"></div>
-                    <!-- /ko -->
+                           autocomplete="off"/>
                 </div>
             </div>
             <div class="mp-clear"></div>
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index e6d95a4..354e7c0 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -20,33 +20,27 @@
  */
 -->
 
-<div id="shipping" class="checkout-shipping-address" data-bind="fadeVisible: visible()">
+<div id="shipping" class="checkout-shipping-address" data-bind="visible: (isShowBillingBeforeShipping == true )? isBillingSameShipping : true">
     <div class="step-title" data-role="title">
         <i class="fa fa-home"></i>
-        <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-        <span class="fa-stack fa-2x">
-            <i class="fa fa-circle fa-stack-2x"></i>
-            <strong class="fa-stack-1x fa-stack-text fa-inverse">1</strong>
-        </span>
-        <!-- /ko -->
         <span data-bind="i18n: 'Shipping Address'"></span>
     </div>
     <div id="checkout-step-shipping"
          class="step-content"
          data-role="content">
 
-        <!-- ko if: (!quoteIsVirtual) -->
+        <!-- ko if: (!quoteIsVirtual && !isShowBillingBeforeShipping) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: getTemplate() --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
 
         <!-- ko foreach: getRegion('address-list') -->
-        <!-- ko template: getTemplate() --><!-- /ko -->
+            <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
 
         <!-- ko foreach: getRegion('address-list-additional-addresses') -->
-        <!-- ko template: getTemplate() --><!-- /ko -->
+            <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
 
         <!-- Address form pop up -->
@@ -61,24 +55,25 @@
         <!-- /ko -->
 
         <!-- ko foreach: getRegion('before-form') -->
-        <!-- ko template: getTemplate() --><!-- /ko -->
+            <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
 
         <!-- Inline address form -->
         <!-- ko if: (isFormInline) -->
-        <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
+            <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
         <!-- /ko -->
 
-        <!-- ko if: (!isCustomerLoggedIn() && !quoteIsVirtual) -->
+        <!-- ko if: (!isCustomerLoggedIn() && !quoteIsVirtual && !isShowBillingBeforeShipping) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
 
         <div class="mp-clear"></div>
-        
-        <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
-            <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
+        <!-- ko if: (!isShowBillingBeforeShipping) -->
+            <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
+                <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
+            <!--/ko-->
         <!--/ko-->
 
         <div class="mp-clear"></div>
diff --git a/view/frontend/web/template/container/authentication.html b/view/frontend/web/template/container/authentication.html
index 5fbfe1e..4925f32 100644
--- a/view/frontend/web/template/container/authentication.html
+++ b/view/frontend/web/template/container/authentication.html
@@ -43,36 +43,26 @@
                   data-bind="submit:login">
                 <div class="fieldset" data-bind="attr: {'data-hasrequired': $t('* Required Fields')}">
                     <div class="field field-email required">
-                        <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
                         <label class="label" for="login-email"><span data-bind="i18n: 'Email Address'"></span></label>
-                        <!-- /ko -->
-                        <div class="control input-field">
+                        <div class="control">
                             <input type="email"
                                    class="input-text"
                                    id="login-email"
                                    name="username"
-                                   data-bind="attr: {autocomplete: autocomplete}, event: { blur: hasValue}"
-                                   data-validate="{required:true, 'validate-email':true}" required />
-                            <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                            <label class="label" for="login-email"><span data-bind="i18n: 'Email Address'"></span><i class="required-entry">*</i></label>
-                            <!-- /ko -->
+                                   data-bind="attr: {autocomplete: autocomplete}"
+                                   data-validate="{required:true, 'validate-email':true}" />
                         </div>
                     </div>
-                    <div class="field  field-password required">
-                        <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                            <label for="login-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
-                        <!-- /ko -->
-                        <div class="control input-field">
+                    <div class="field field-password required">
+                        <label for="login-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
+                        <div class="control">
                             <input type="password"
                                    class="input-text"
                                    id="login-password"
                                    name="password"
-                                   data-bind="attr: {autocomplete: autocomplete}, event: { blur: hasValue}"
+                                   data-bind="attr: {autocomplete: autocomplete}"
                                    data-validate="{required:true}"
-                                   autocomplete="off" required/>
-                            <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                            <label for="login-password" class="label"><span data-bind="i18n: 'Password'"></span><i class="required-entry">*</i></label>
-                            <!-- /ko -->
+                                   autocomplete="off"/>
                         </div>
                     </div>
                     <!-- ko foreach: getRegion('additional-login-form-fields') -->
diff --git a/view/frontend/web/template/container/delivery-time.html b/view/frontend/web/template/container/delivery-time.html
index 501ab29..7b5f398 100644
--- a/view/frontend/web/template/container/delivery-time.html
+++ b/view/frontend/web/template/container/delivery-time.html
@@ -31,13 +31,3 @@
         </div>
     </div>
 </div>
-<!-- ko if: canUseHouseSecurityCode() -->
-<div class="house-security-code">
-    <div class="title">
-        <span data-bind="i18n: 'House Security Code'">House Security Code</span>
-    </div>
-    <div class="control">
-        <input type="text" name="house-security-code" id="house-security-code" data-bind="value: houseSecurityCodeValue">
-    </div>
-</div>
-<!-- /ko -->
diff --git a/view/frontend/web/template/container/form/element/email.html b/view/frontend/web/template/container/form/element/email.html
index f8433a5..f34d007 100644
--- a/view/frontend/web/template/container/form/element/email.html
+++ b/view/frontend/web/template/container/form/element/email.html
@@ -30,30 +30,19 @@
       method="post">
     <fieldset id="customer-email-fieldset" class="fieldset" data-bind="blockLoader: isLoading">
         <div class="field required col-mp mp-12">
-            <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <label class="label" for="customer-email">
-                    <span data-bind="i18n: 'Email Address'"></span>
-
-                </label>
-            <!-- /ko -->
-            <div class="control input-field _with-tooltip">
+            <label class="label" for="customer-email">
+                <span data-bind="i18n: 'Email Address'"></span>
+            </label>
+            <div class="control _with-tooltip">
                 <input class="input-text"
                        type="email"
                        data-bind="
                             textInput: email,
                             hasFocus: emailFocused,
-                            css: hasValue() ,
-                            event: {change: emailHasChanged,blur: hasValue}"
+                            event: {change: emailHasChanged}"
                        name="username"
                        data-validate="{required:true, 'validate-email':true}"
-                       id="customer-email"  required/>
-                <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <label class="label" for="customer-email">
-                    <span data-bind="i18n: 'Email Address'"></span>
-                    <i class="required-entry">*</i>
-                </label>
-                <div for="customer-email" generated="true" class="mage-error" id="customer-email-error"></div>
-                <!-- /ko -->
+                       id="customer-email" />
                 <!-- ko template: 'ui/form/element/helper/tooltip' --><!-- /ko -->
                 <div data-bind="fadeVisible: isPasswordVisible" >
                     <span class="note" data-bind="i18n: 'You already have an account with us.'"></span>
diff --git a/view/frontend/web/template/container/form/element/input.html b/view/frontend/web/template/container/form/element/input.html
index ad502d7..214707c 100644
--- a/view/frontend/web/template/container/form/element/input.html
+++ b/view/frontend/web/template/container/form/element/input.html
@@ -29,4 +29,4 @@
         'aria-describedby': noticeId,
         id: uid,
         disabled: disabled
-    }" required />
+    }" />
diff --git a/view/frontend/web/template/container/form/field.html b/view/frontend/web/template/container/form/field.html
deleted file mode 100644
index 3ada7bf..0000000
--- a/view/frontend/web/template/container/form/field.html
+++ /dev/null
@@ -1,67 +0,0 @@
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
-<div class="field test" data-bind="visible: visible, attr: {'name': element.dataScope}, css: additionalClasses">
-
-    <div class="control input-field" data-bind="css: {'_with-tooltip': element.tooltip}">
-        <!-- ko ifnot: element.hasAddons() -->
-            <!-- ko template: element.elementTmpl --><!-- /ko -->
-        <!-- /ko -->
-            <label class="label" data-bind="attr: { for: element.uid }">
-            <!-- ko if: element.label -->
-                <span data-bind="text: element.label"></span>
-                <!-- ko if: element.validation['required-entry'] -->
-                    <i class="required-entry">*</i>
-                <!-- /ko -->
-            <!-- /ko -->
-            </label>
-        <!-- ko if: element.hasAddons() -->
-            <div class="control-addon">
-                <!-- ko template: element.elementTmpl --><!-- /ko -->
-
-                <!-- ko if: element.addbefore -->
-                    <label class="addon-prefix" data-bind="attr: { for: element.uid }"><span data-bind="text: element.addbefore"></span></label>
-                <!-- /ko -->
-
-                <!-- ko if: element.addafter -->
-                    <label class="addon-suffix" data-bind="attr: { for: element.uid }"><span data-bind="text: element.addafter"></span></label>
-                <!-- /ko -->
-            </div>
-        <!-- /ko -->
-
-        <!-- ko if: element.tooltip -->
-            <!-- ko template: element.tooltipTpl --><!-- /ko -->
-        <!-- /ko -->
-
-        <!-- ko if: element.notice -->
-            <div class="field-note" data-bind="attr: { id: element.noticeId }"><span data-bind="text: element.notice"></span></div>
-        <!-- /ko -->
-
-        <!-- ko if: element.error() -->
-            <div class="mage-error" data-bind="attr: { for: element.uid }, text: element.error" generated="true"></div>
-        <!-- /ko -->
-
-        <!-- ko if: element.warn() -->
-            <div class="message warning" generated="true"><span data-bind="text: element.warn"></span></div>
-        <!-- /ko -->
-    </div>
-</div>
-<!-- /ko -->
diff --git a/view/frontend/web/template/container/payment.html b/view/frontend/web/template/container/payment.html
index 8d6e208..5d67c42 100644
--- a/view/frontend/web/template/container/payment.html
+++ b/view/frontend/web/template/container/payment.html
@@ -23,17 +23,6 @@
 <div id="payment" role="presentation" class="checkout-payment-method">
     <div class="step-title" data-role="title">
         <i class="fa fa-credit-card"></i>
-        <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-            <span class="fa-stack fa-2x">
-                <i class="fa fa-circle fa-stack-2x"></i>
-                <!-- ko if: !!Number(window.checkoutConfig.quoteData.is_virtual) -->
-                    <strong class="fa-stack-1x fa-stack-text fa-inverse">2</strong>
-                <!-- /ko -->
-                <!-- ko ifnot: !!Number(window.checkoutConfig.quoteData.is_virtual) -->
-                    <strong class="fa-stack-1x fa-stack-text fa-inverse">3</strong>
-                <!-- /ko -->
-            </span>
-        <!-- /ko -->
         <span data-bind="i18n: 'Payment Methods'"></span>
     </div>
     <div id="checkout-step-payment"
diff --git a/view/frontend/web/template/container/review/addition/gift-message.html b/view/frontend/web/template/container/review/addition/gift-message.html
index 7272330..0b06d7c 100644
--- a/view/frontend/web/template/container/review/addition/gift-message.html
+++ b/view/frontend/web/template/container/review/addition/gift-message.html
@@ -1,22 +1,7 @@
 <!--
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
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 -->
 <!-- ko if: isActive() -->
@@ -28,45 +13,28 @@
     <div class="gift-options-content" data-bind="visible: formBlockVisibility() || resultBlockVisibility()">
         <div class="fieldset">
             <div class="field field-from col-mp mp-6">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
                 <label for="gift-message-whole-from" class="label">
                     <span data-bind="i18n: 'From:'"></span>
                 </label>
-                <!-- /ko -->
-
-                <div class="control input-field">
+                <div class="control">
                     <input type="text"
                            id="gift-message-whole-from"
                            class="input-text"
-                           data-bind="value: getObservable('sender')" required>
-                    <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                    <label for="gift-message-whole-from" class="label">
-                        <span data-bind="i18n: 'From:'"></span>
-                    </label>
-                    <div class="bar"></div>
-                    <!-- /ko -->
+                           data-bind="value: getObservable('sender')">
                 </div>
             </div>
             <div class="field field-to col-mp mp-6">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                    <label for="gift-message-whole-to" class="label">
-                        <span data-bind="i18n: 'To:'"></span>
-                    </label>
-                <!-- /ko -->
-                <div class="control input-field">
+                <label for="gift-message-whole-to" class="label">
+                    <span data-bind="i18n: 'To:'"></span>
+                </label>
+                <div class="control">
                     <input type="text"
                            id="gift-message-whole-to"
                            class="input-text"
-                           data-bind="value: getObservable('recipient')" required>
-                    <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                    <label for="gift-message-whole-to" class="label">
-                        <span data-bind="i18n: 'To:'"></span>
-                    </label>
-                    <!-- /ko -->
+                           data-bind="value: getObservable('recipient')">
                 </div>
             </div>
             <div class="field text col-mp mp-12">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
                 <label for="gift-message-whole-message" class="label">
                     <span data-bind="i18n: 'Message:'"></span>
                 </label>
@@ -76,15 +44,6 @@
                               rows="5" cols="10"
                               data-bind="value: getObservable('message')"></textarea>
                 </div>
-                <!-- /ko -->
-                <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <div class="control">
-                    <textarea id="gift-message-whole-message material"
-                              class="input-text"
-                              rows="3" cols="10"
-                              data-bind="value: getObservable('message'),attr:{placeholder: $t('Message')}"></textarea>
-                </div>
-                <!-- /ko -->
             </div>
         </div>
     </div>
diff --git a/view/frontend/web/template/container/review/place-order.html b/view/frontend/web/template/container/review/place-order.html
index aea33b8..ea6513f 100644
--- a/view/frontend/web/template/container/review/place-order.html
+++ b/view/frontend/web/template/container/review/place-order.html
@@ -23,11 +23,10 @@
 <div class="checkout-agreements-block mp-12">
     <form id="co-place-order-agreement" class="form" novalidate="novalidate">
         <!-- ko foreach: getRegion('checkout-agreements') -->
-        <!-- ko template: getTemplate() --><!-- /ko -->
+            <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
     </form>
 </div>
-<!-- ko ifnot: visibleBraintreeButton() -->
 <div class="actions-toolbar">
     <div class="place-order-primary">
         <button class="action primary checkout"
@@ -40,35 +39,4 @@
             <span data-bind="i18n: 'Place Order'"></span>
         </button>
     </div>
-</div>
-<!-- /ko -->
-<!-- ko if: visibleBraintreeButton() -->
-<div class="actions-toolbar">
-    <div class="payment-method-item braintree-paypal-account" data-bind="visible: braintreePaypalModel.isReviewRequired()">
-        <span class="payment-method-type">PayPal</span>
-        <span class="payment-method-description" data-bind="text: braintreePaypalModel.customerEmail()"></span>
-    </div>
-    <div class="place-order-primary">
-        <button class="action primary checkout"
-                type="button"
-                data-bind="
-                visible: braintreePaypalModel.isReviewRequired(),
-                click: brainTreePaypalPlaceOrder,
-                attr: {'title': $t('Place Order')},
-                enable: (getBraintreePaypalComponent().isActive())
-                ">
-            <span data-bind="i18n: 'Place Order'"></span>
-        </button>
-        <button class="action primary checkout"
-                type="button"
-                data-bind="
-                visible: !braintreePaypalModel.isReviewRequired(),
-                click: brainTreePayWithPayPal,
-                attr: {'title': $t(getBraintreePaypalComponent().getButtonTitle())},
-                enable: (getBraintreePaypalComponent().isActive())
-                ">
-            <span data-bind="i18n: getBraintreePaypalComponent().getButtonTitle()"></span>
-        </button>
-    </div>
-</div>
-<!-- /ko -->
\ No newline at end of file
+</div>
\ No newline at end of file
diff --git a/view/frontend/web/template/container/shipping.html b/view/frontend/web/template/container/shipping.html
index 3b101a1..8bf5cf7 100644
--- a/view/frontend/web/template/container/shipping.html
+++ b/view/frontend/web/template/container/shipping.html
@@ -28,12 +28,6 @@
     <div class="checkout-shipping-method">
         <div class="step-title" data-role="title">
             <i class="fa fa-truck"></i>
-            <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <span class="fa-stack fa-2x">
-                    <i class="fa fa-circle fa-stack-2x"></i>
-                    <strong class="fa-stack-1x fa-stack-text fa-inverse">2</strong>
-                </span>
-            <!-- /ko -->
             <span data-bind="i18n: 'Shipping Methods'"></span>
         </div>
         <!-- ko foreach: getRegion('before-shipping-method-form') -->
@@ -72,7 +66,6 @@
                                                     'id': 's_method_' + method.method_code,
                                                     'aria-labelledby': 'label_method_' + method.method_code + '_' + method.carrier_code + ' ' + 'label_carrier_' + method.method_code + '_' + method.carrier_code
                                                  }" />
-                                <label></label>
                                 <!-- /ko -->
                                 <!--ko ifnot: ($parent.rates().length == 1)-->
                                 <input type="radio"
@@ -84,7 +77,6 @@
                                                     'aria-labelledby': 'label_method_' + method.method_code + '_' + method.carrier_code + ' ' + 'label_carrier_' + method.method_code + '_' + method.carrier_code
                                                 }"
                                        class="radio"/>
-                                <label></label>
                                 <!--/ko-->
                                 <!-- /ko -->
                             </td>
@@ -92,12 +84,6 @@
                                 <!-- ko foreach: $parent.getRegion('price') -->
                                 <!-- ko template: getTemplate() --><!-- /ko -->
                                 <!-- /ko -->
-
-                                <!-- TIG PostNL modification start -->
-                                <!-- ko if: $parent.isEnableModulePostNL && $parent.isPostNLDeliveryMethod(method) && $parent.PostNLFee() -->
-                                + <span data-bind="text: $parent.formatPrice($parent.PostNLFee())"></span>
-                                <!-- /ko -->
-                                <!-- TIG PostNL modification end -->
                             </td>
 
                             <td class="col col-method"
@@ -120,18 +106,6 @@
                         </tr>
                         <!-- /ko -->
 
-                        <!-- TIG PostNL modification start -->
-                        <!-- ko if: $parent.isEnableModulePostNL && $parent.canUsePostnlDeliveryOptions(method) -->
-                        <tr>
-                            <td colspan="10" class="postnl-deliveryoptions">
-                                <!-- ko foreach: $parent.getRegion('postnl-deliveryoptions') -->
-                                <!-- ko template: getTemplate() --><!-- /ko -->
-                                <!-- /ko -->
-                            </td>
-                        </tr>
-                        <!-- /ko -->
-                        <!-- TIG PostNL modification end -->
-
                         <!-- /ko -->
                         </tbody>
                     </table>
diff --git a/view/frontend/web/template/container/summary.html b/view/frontend/web/template/container/summary.html
index a28796c..4b16cae 100644
--- a/view/frontend/web/template/container/summary.html
+++ b/view/frontend/web/template/container/summary.html
@@ -19,24 +19,19 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<div class="order-summary hoverable">
-	<div class="step-title" data-role="title">
-		<i class="fa fa-check-square"></i>
-		<!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-			<i class="fa fa-check-circle"></i>
-		<!-- /ko -->
-		<span data-bind="i18n: 'Order Summary'"></span>
-	</div>
-	<div class="opc-block-summary step-content" data-bind="blockLoader: isLoading">
-		<!-- ko foreach: elems() -->
-			<!-- ko template: getTemplate() --><!-- /ko -->
-		<!-- /ko -->
+<div class="step-title" data-role="title">
+    <i class="fa fa-check-square"></i>
+    <span data-bind="i18n: 'Order Summary'"></span>
+</div>
+<div class="opc-block-summary step-content" data-bind="blockLoader: isLoading">
+    <!-- ko foreach: elems() -->
+        <!-- ko template: getTemplate() --><!-- /ko -->
+    <!-- /ko -->
 
-		<p class="col-wide forgot-item" data-bind="style:{textAlign: 'right'}, visible: false">
-			<span>
-				<!-- ko i18n: 'Forgot an item?'--><!-- /ko -->
-				<a data-bind="attr: {href: window.checkout.shoppingCartUrl}, i18n: 'Edit your cart'"></a>
-			</span>
-		</p>
-	</div>
-</div>
\ No newline at end of file
+    <p class="col-wide forgot-item" data-bind="style:{textAlign: 'right'}, visible: false">
+	    <span>
+	    	<!-- ko i18n: 'Forgot an item?'--><!-- /ko -->
+			<a data-bind="attr: {href: window.checkout.shoppingCartUrl}, i18n: 'Edit your cart'"></a>
+	    </span>
+	</p>
+</div>
diff --git a/view/frontend/web/template/container/summary/item/details.html b/view/frontend/web/template/container/summary/item/details.html
index 25674c5..545b08a 100644
--- a/view/frontend/web/template/container/summary/item/details.html
+++ b/view/frontend/web/template/container/summary/item/details.html
@@ -58,77 +58,6 @@
         </div>
         <!-- /ko -->
     </div>
-
-    <!-- ko if: isItemAvailable($parent.item_id) -->
-    <div class="gift-message-item-content">
-        <div class="gift-message-item" data-bind="attr: { id: 'item' +$parent.item_id, title: giftMessageItemsTitleHover},click: loadGiftMessageItem.bind($data,$parent.item_id)">
-            <i class="fa fa-gift fa-2x" aria-hidden="true"></i>
-        </div>
-        <div style="display: none" data-bind="attr: { id: 'item' + $parent.item_id,title: $parent.name},afterRender: setModalElement">
-            <div class="gift-options-content">
-                <div class="fieldset">
-                    <div class="field field-from col-mp mp-6">
-                        <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                        <label for="gift-message-whole-from" class="label">
-                            <span data-bind="i18n: 'From:'"></span>
-                        </label>
-                        <!-- /ko -->
-                        <div class="control input-field">
-                            <input type="text" id="gift-message-whole-from" class="input-text" required>
-                            <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                            <label for="gift-message-whole-from" class="label">
-                                <span data-bind="i18n: 'From:'"></span>
-                            </label>
-                            <!-- /ko -->
-                        </div>
-                    </div>
-                    <div class="field field-to col-mp mp-6">
-                        <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                        <label for="gift-message-whole-to" class="label">
-                            <span data-bind="i18n: 'To:'"></span>
-                        </label>
-                        <!-- /ko -->
-                        <div class="control input-field">
-                            <input type="text" id="gift-message-whole-to" class="input-text" required>
-                            <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                            <label for="gift-message-whole-to" class="label">
-                                <span data-bind="i18n: 'To:'"></span>
-                            </label>
-                            <!-- /ko -->
-                        </div>
-                    </div>
-                    <div class="field text col-mp mp-12">
-                        <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                        <label for="gift-message-whole-message" class="label">
-                            <span data-bind="i18n: 'Message:'"></span>
-                        </label>
-                        <div class="control">
-                            <textarea id="gift-message-whole-message" class="input-text" rows="5" cols="10"></textarea>
-                        </div>
-                        <!-- /ko -->
-                        <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                        <div class="control">
-                            <textarea id="gift-message-whole-message" class="input-text" rows="3" cols="10" data-bind="attr:{placeholder: $t('Message')}"></textarea>
-                        </div>
-                        <!-- /ko -->
-                    </div>
-                </div>
-            </div>
-            <div class="actions-toolbar">
-                <div class="primary">
-                    <button type="submit" name="update" class="action update"  data-bind="click: updateGiftMessageItem.bind($data,$parent.item_id)">
-                        <span data-bind="i18n: 'Update'"></span>
-                    </button>
-                </div>
-                <div class="primary">
-                    <button type="submit" name="delete" class="action delete" data-bind="click: deleteGiftMessageItem.bind($data,$parent.item_id)">
-                        <span data-bind="i18n: 'Delete'"></span>
-                    </button>
-                </div>
-            </div>
-        </div>
-    </div>
-    <!-- /ko -->
 </td>
 <td class="a-center details-qty">
     <div class="qty-wrapper">
