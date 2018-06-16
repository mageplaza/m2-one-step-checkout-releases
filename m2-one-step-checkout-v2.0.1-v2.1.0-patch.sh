diff --git a/Api/CheckoutManagementInterface.php b/Api/CheckoutManagementInterface.php
index 550db2f..9069054 100644
--- a/Api/CheckoutManagementInterface.php
+++ b/Api/CheckoutManagementInterface.php
@@ -46,25 +46,16 @@ interface CheckoutManagementInterface
      * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
      */
     public function getPaymentTotalInformation($cartId);
- 
-    /**
-     * @param int $cartId
-     * @param bool $isUseGiftWrap
-     * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
-     */
-    public function updateGiftWrap($cartId,$isUseGiftWrap);
 
     /**
      * @param int $cartId
      * @param \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation
-     * @param string[] $customerAttributes
      * @param string[] $additionInformation
      * @return bool
      */
     public function saveCheckoutInformation(
         $cartId,
         \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
-        $customerAttributes = [],
         $additionInformation = []
     );
 }
diff --git a/Api/GuestCheckoutManagementInterface.php b/Api/GuestCheckoutManagementInterface.php
index 3e1e25d..1e400ac 100644
--- a/Api/GuestCheckoutManagementInterface.php
+++ b/Api/GuestCheckoutManagementInterface.php
@@ -23,7 +23,7 @@ namespace Mageplaza\Osc\Api;
 /**
  * Interface for update item information
  * @api
- */ 
+ */
 interface GuestCheckoutManagementInterface
 {
     /**
@@ -49,22 +49,13 @@ interface GuestCheckoutManagementInterface
 
     /**
      * @param string $cartId
-     * @param bool $isUseGiftWrap
-     * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
-     */
-    public function updateGiftWrap($cartId,$isUseGiftWrap);
-
-    /**
-     * @param string $cartId
      * @param \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation
-     * @param string[] $customerAttributes
      * @param string[] $additionInformation
      * @return bool
      */
     public function saveCheckoutInformation(
         $cartId,
         \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
-        $customerAttributes = [],
         $additionInformation = []
     );
 }
diff --git a/Block/Adminhtml/Field/Position.php b/Block/Adminhtml/Field/Position.php
deleted file mode 100644
index e8ea37b..0000000
--- a/Block/Adminhtml/Field/Position.php
+++ /dev/null
@@ -1,122 +0,0 @@
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
-namespace Mageplaza\Osc\Block\Adminhtml\Field;
-
-class Position extends \Magento\Backend\Block\Widget\Container
-{
-	/**
-	 * @type \Mageplaza\Osc\Helper\Data
-	 */
-	protected $_helper;
-
-	/**
-	 * @type array
-	 */
-	protected $sortedFields = [];
-
-	/**
-	 * @type array
-	 */
-	protected $availableFields = [];
-
-	/**
-	 * @param \Magento\Backend\Block\Widget\Context $context
-	 * @param \Mageplaza\Osc\Helper\Data $helperData
-	 * @param array $data
-	 */
-	public function __construct(
-		\Magento\Backend\Block\Widget\Context $context,
-		\Mageplaza\Osc\Helper\Data $helperData,
-		array $data = []
-	)
-	{
-		$this->_helper = $helperData;
-
-		parent::__construct($context, $data);
-	}
-
-	protected function _construct()
-	{
-		parent::_construct();
-
-		$this->addButton(
-			'save',
-			[
-				'label'   => __('Save Position'),
-				'class'   => 'save primary',
-				'onclick' => 'saveOscPosition()'
-			],
-			1
-		);
-
-		$this->prepareCollection();
-	}
-
-	/**
-	 * @return array
-	 */
-	public function prepareCollection()
-	{
-		list($this->sortedFields, $this->availableFields) = $this->getHelperData()->getConfig()->getSortedField(false);
-	}
-
-	/**
-	 * Retrieve the header text
-	 *
-	 * @return \Magento\Framework\Phrase|string
-	 */
-	public function getHeaderText()
-	{
-		return __('Field Management');
-	}
-
-	/**
-	 * @return array
-	 */
-	public function getSortedFields()
-	{
-		return $this->sortedFields;
-	}
-
-	/**
-	 * @return mixed
-	 */
-	public function getAvailableFields()
-	{
-		return $this->availableFields;
-	}
-
-	/**
-	 * @return \Mageplaza\Osc\Helper\Data
-	 */
-	public function getHelperData()
-	{
-		return $this->_helper;
-	}
-
-	/**
-	 * @return string
-	 */
-	public function getAjaxUrl()
-	{
-		return $this->getUrl('*/*/save');
-	}
-}
diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index be2aea4..a6c19b2 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -22,10 +22,11 @@ namespace Mageplaza\Osc\Block\Checkout;
 
 use Magento\Framework\App\ObjectManager;
 use Magento\Checkout\Model\Session as CheckoutSession;
-use Mageplaza\Osc\Helper\Config as OscHelper;
+use Mageplaza\Osc\Helper\Data as OscHelper;
 use Magento\Customer\Model\AttributeMetadataDataProvider;
 use Magento\Ui\Component\Form\AttributeMapper;
 use Magento\Checkout\Block\Checkout\AttributeMerger;
+use Magento\Framework\App\RequestInterface;
 
 /**
  * Class LayoutProcessor
@@ -33,306 +34,267 @@ use Magento\Checkout\Block\Checkout\AttributeMerger;
  */
 class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcessorInterface
 {
-	/**
-	 * @type \Mageplaza\Osc\Helper\Config
-	 */
-	private $_oscHelper;
-
-	/**
-	 * @var \Magento\Customer\Model\AttributeMetadataDataProvider
-	 */
-	private $attributeMetadataDataProvider;
-
-	/**
-	 * @var \Magento\Ui\Component\Form\AttributeMapper
-	 */
-	protected $attributeMapper;
-
-	/**
-	 * @var \Magento\Checkout\Block\Checkout\AttributeMerger
-	 */
-	protected $merger;
-
-	/**
-	 * @var \Magento\Customer\Model\Options
-	 */
-	private $options;
-
-	/**
-	 * @type \Magento\Checkout\Model\Session
-	 */
-	private $checkoutSession;
-
-	/**
-	 * @param \Magento\Checkout\Model\Session $checkoutSession
-	 * @param \Mageplaza\Osc\Helper\Config $oscHelper
-	 * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
-	 * @param \Magento\Ui\Component\Form\AttributeMapper $attributeMapper
-	 * @param \Magento\Checkout\Block\Checkout\AttributeMerger $merger
-	 */
-	public function __construct(
-		CheckoutSession $checkoutSession,
-		OscHelper $oscHelper,
-		AttributeMetadataDataProvider $attributeMetadataDataProvider,
-		AttributeMapper $attributeMapper,
-		AttributeMerger $merger
-	)
-	{
-		$this->checkoutSession               = $checkoutSession;
-		$this->_oscHelper                    = $oscHelper;
-		$this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-		$this->attributeMapper               = $attributeMapper;
-		$this->merger                        = $merger;
-	}
-
-	/**
-	 * Process js Layout of block
-	 *
-	 * @param array $jsLayout
-	 * @return array
-	 */
-	public function process($jsLayout)
-	{
-		if (!$this->_oscHelper->isOscPage()) {
-			return $jsLayout;
-		}
-
-		/** Shipping address fields */
-		if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
-			['children']['shippingAddress']['children']['shipping-address-fieldset']['children'])) {
-			$fields                                               = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-			['children']['shipping-address-fieldset']['children'];
-			$jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-			['children']['shipping-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'shippingAddress');
-		}
-
-		/** Billing address fields */
-		if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
-			['children']['billingAddress']['children']['billing-address-fieldset']['children'])) {
-			$fields                                              = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
-			['children']['billing-address-fieldset']['children'];
-			$jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
-			['children']['billing-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'billingAddress');
-		}
-
-		/** Remove billing customer email if quote is not virtual */
-		if (!$this->checkoutSession->getQuote()->isVirtual()) {
-			unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
-				['children']['customer-email']);
-		}
-
-		/** Remove billing address in payment method content */
-		$fields = &$jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
-		['payment']['children']['payments-list']['children'];
-		foreach ($fields as $code => $field) {
-			if ($field['component'] == 'Magento_Checkout/js/view/billing-address') {
-				unset($fields[$code]);
-			}
-		}
-
-		return $jsLayout;
-	}
-
-	/**
-	 * Get address fieldset for shipping/billing address
-	 *
-	 * @param $fields
-	 * @return array
-	 */
-	public function getAddressFieldset($fields, $type)
-	{
-		$elements = $this->getAddressAttributes();
-
-		$systemAttribute = $elements['default'];
-		if (sizeof($systemAttribute)) {
-			$attributesToConvert = [
-				'prefix' => [$this->getOptions(), 'getNamePrefixOptions'],
-				'suffix' => [$this->getOptions(), 'getNameSuffixOptions'],
-			];
-			$systemAttribute     = $this->convertElementsToSelect($systemAttribute, $attributesToConvert);
-			$fields              = $this->merger->merge(
-				$systemAttribute,
-				'checkoutProvider',
-				$type,
-				$fields
-			);
-		}
-
-		$customAttribute = $elements['custom'];
-		if (sizeof($customAttribute)) {
-			$fields = $this->merger->merge(
-				$customAttribute,
-				'checkoutProvider',
-				$type . '.custom_attributes',
-				$fields
-			);
-		}
-
-		$this->addCustomerAttribute($fields, $type);
-		$this->addAddressOption($fields);
-
-
-		return $fields;
-	}
-
-	/**
-	 * Add customer attribute like gender, dob, taxvat
-	 *
-	 * @param $fields
-	 * @param $type
-	 * @return $this
-	 */
-	private function addCustomerAttribute(&$fields, $type)
-	{
-		$attributes      = $this->attributeMetadataDataProvider->loadAttributesCollection(
-			'customer',
-			'customer_account_create'
-		);
-		$addressElements = [];
-		foreach ($attributes as $attribute) {
-			if (!$this->_oscHelper->isCustomerAttributeVisible($attribute)) {
-				continue;
-			}
-			$addressElements[$attribute->getAttributeCode()] = $this->attributeMapper->map($attribute);
-		}
-
-		$fields = $this->merger->merge(
-			$addressElements,
-			'checkoutProvider',
-			$type . '.custom_attributes',
-			$fields
-		);
-
-		return $this;
-	}
-
-	/**
-	 * @param $fields
-	 * @return $this
-	 */
-	private function addAddressOption(&$fields)
-	{
-		$fieldPosition = $this->_oscHelper->getAddressFieldPosition();
-		foreach ($fields as $code => &$field) {
-			$fieldConfig = isset($fieldPosition[$code]) ? $fieldPosition[$code] : [];
-			if (!sizeof($fieldConfig)) {
-				if (in_array($code, ['country_id'])) {
-					$field['config']['additionalClasses'] = "mp-hidden";
-					continue;
-				} else {
-					unset($fields[$code]);
-				}
-			} else {
-				$oriClasses                           = isset($field['config']['additionalClasses']) ? $field['config']['additionalClasses'] : '';
-				$field['config']['additionalClasses'] = "{$oriClasses} col-mp mp-{$fieldConfig['colspan']}" . ($fieldConfig['isNewRow'] ? ' mp-clear' : '');
-				$field['sortOrder']                   = $fieldConfig['sortOrder'];
-				if ($code == 'dob') {
-					$field['options'] = ['yearRange' => '-120y:c+nn', 'maxDate' => '-1d', 'changeMonth' => true, 'changeYear' => true];
-				}
-
-				$this->rewriteTemplate($field);
-			}
-		}
-
-		return $this;
-	}
-
-	/**
-	 * Change template to remove valueUpdate = 'keyup'
-	 *
-	 * @param $field
-	 * @param string $template
-	 * @return $this
-	 */
-	public function rewriteTemplate(&$field, $template = 'Mageplaza_Osc/container/form/element/input')
-	{
-		if (isset($field['type']) && $field['type'] == 'group') {
-			foreach ($field['children'] as $key => &$child) {
-				if ($key == 0 && in_array('street', explode('.', $field['dataScope'])) && $this->_oscHelper->isGoogleHttps()) {
-					$this->rewriteTemplate($child, 'Mageplaza_Osc/container/form/element/street');
-					continue;
-				}
-				$this->rewriteTemplate($child);
-			}
-		} elseif (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
-			$field['config']['elementTmpl'] = $template;
-		}
-
-		return $this;
-	}
-
-	/**
-	 * @return \Magento\Customer\Model\Options
-	 */
-	private function getOptions()
-	{
-		if (!is_object($this->options)) {
-			$this->options = ObjectManager::getInstance()->get(\Magento\Customer\Model\Options::class);
-		}
-
-		return $this->options;
-	}
-
-	/**
-	 * @return array
-	 */
-	private function getAddressAttributes()
-	{
-		/** @var \Magento\Eav\Api\Data\AttributeInterface[] $attributes */
-		$attributes = $this->attributeMetadataDataProvider->loadAttributesCollection(
-			'customer_address',
-			'customer_register_address'
-		);
-
-		$elements = [
-			'custom'  => [],
-			'default' => []
-		];
-		foreach ($attributes as $attribute) {
-			$code    = $attribute->getAttributeCode();
-			$element = $this->attributeMapper->map($attribute);
-			if (isset($element['label'])) {
-				$label            = $element['label'];
-				$element['label'] = __($label);
-			}
-
-			($attribute->getIsUserDefined()) ?
-				$elements['custom'][$code] = $element :
-				$elements['default'][$code] = $element;
-		}
-
-		return $elements;
-	}
-
-	/**
-	 * Convert elements(like prefix and suffix) from inputs to selects when necessary
-	 *
-	 * @param array $elements address attributes
-	 * @param array $attributesToConvert fields and their callbacks
-	 * @return array
-	 */
-	private function convertElementsToSelect($elements, $attributesToConvert)
-	{
-		$codes = array_keys($attributesToConvert);
-		foreach (array_keys($elements) as $code) {
-			if (!in_array($code, $codes)) {
-				continue;
-			}
-			$options = call_user_func($attributesToConvert[$code]);
-			if (!is_array($options)) {
-				continue;
-			}
-			$elements[$code]['dataType']    = 'select';
-			$elements[$code]['formElement'] = 'select';
-
-			foreach ($options as $key => $value) {
-				$elements[$code]['options'][] = [
-					'value' => $key,
-					'label' => $value,
-				];
-			}
-		}
-
-		return $elements;
-	}
+    /**
+     * @type \Mageplaza\Osc\Helper\Data
+     */
+    private $_oscHelper;
+
+    /**
+     * @var \Magento\Customer\Model\AttributeMetadataDataProvider
+     */
+    private $attributeMetadataDataProvider;
+
+    /**
+     * @var \Magento\Ui\Component\Form\AttributeMapper
+     */
+    protected $attributeMapper;
+
+    /**
+     * @var \Magento\Checkout\Block\Checkout\AttributeMerger
+     */
+    protected $merger;
+
+    /**
+     * @var \Magento\Customer\Model\Options
+     */
+    private $options;
+
+    /**
+     * @type \Magento\Framework\App\RequestInterface
+     */
+    private $request;
+
+    /**
+     * @type \Magento\Checkout\Model\Session
+     */
+    private $checkoutSession;
+
+    /**
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Mageplaza\Osc\Helper\Data $oscHelper
+     * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+     * @param \Magento\Ui\Component\Form\AttributeMapper $attributeMapper
+     * @param \Magento\Checkout\Block\Checkout\AttributeMerger $merger
+     * @param \Magento\Framework\App\RequestInterface $request
+     */
+    public function __construct(
+        CheckoutSession $checkoutSession,
+        OscHelper $oscHelper,
+        AttributeMetadataDataProvider $attributeMetadataDataProvider,
+        AttributeMapper $attributeMapper,
+        AttributeMerger $merger,
+        RequestInterface $request
+    ) {
+    
+        $this->checkoutSession               = $checkoutSession;
+        $this->_oscHelper                    = $oscHelper;
+        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
+        $this->attributeMapper               = $attributeMapper;
+        $this->merger                        = $merger;
+        $this->request                       = $request;
+    }
+
+    /**
+     * @deprecated
+     * @return \Magento\Customer\Model\Options
+     */
+    private function getOptions()
+    {
+        if (!is_object($this->options)) {
+            $this->options = ObjectManager::getInstance()->get(\Magento\Customer\Model\Options::class);
+        }
+
+        return $this->options;
+    }
+
+    /**
+     * @return array
+     */
+    private function getAddressAttributes()
+    {
+        /** @var \Magento\Eav\Api\Data\AttributeInterface[] $attributes */
+        $attributes = $this->attributeMetadataDataProvider->loadAttributesCollection(
+            'customer_address',
+            'customer_register_address'
+        );
+
+        $elements = [];
+        foreach ($attributes as $attribute) {
+            $code = $attribute->getAttributeCode();
+            if ($attribute->getIsUserDefined()) {
+                continue;
+            }
+            $elements[$code] = $this->attributeMapper->map($attribute);
+            if (isset($elements[$code]['label'])) {
+                $label                    = $elements[$code]['label'];
+                $elements[$code]['label'] = __($label);
+            }
+        }
+
+        return $elements;
+    }
+
+    /**
+     * Convert elements(like prefix and suffix) from inputs to selects when necessary
+     *
+     * @param array $elements address attributes
+     * @param array $attributesToConvert fields and their callbacks
+     * @return array
+     */
+    private function convertElementsToSelect($elements, $attributesToConvert)
+    {
+        $codes = array_keys($attributesToConvert);
+        foreach (array_keys($elements) as $code) {
+            if (!in_array($code, $codes)) {
+                continue;
+            }
+            $options = call_user_func($attributesToConvert[$code]);
+            if (!is_array($options)) {
+                continue;
+            }
+            $elements[$code]['dataType']    = 'select';
+            $elements[$code]['formElement'] = 'select';
+
+            foreach ($options as $key => $value) {
+                $elements[$code]['options'][] = [
+                    'value' => $key,
+                    'label' => $value,
+                ];
+            }
+        }
+
+        return $elements;
+    }
+
+    /**
+     * Process js Layout of block
+     *
+     * @param array $jsLayout
+     * @return array
+     */
+    public function process($jsLayout)
+    {
+        if (!$this->_oscHelper->getConfig()->isOscPage()) {
+            return $jsLayout;
+        }
+
+        /** Shipping address fields */
+        $this->sortAddressPosition($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+        ['children']['shippingAddress']['children']['shipping-address-fieldset']['children']);
+
+        /** Billing address fields */
+        if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+            ['children']['shippingAddress']['children']['billing-address-form']['children']['form-fields']['children'])) {
+            $fields                                                                     = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+            ['children']['billing-address-form']['children']['form-fields']['children'];
+            $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+            ['children']['billing-address-form']['children']['form-fields']['children'] = $this->getBillingAddressFieldset($fields);
+        }
+
+        /** Disable double load customer-email (don't know why) */
+        if (!$this->checkoutSession->getQuote()->isVirtual()) {
+            unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+                ['children']['billing-address-form']['children']['customer-email']);
+        }
+
+        /** Remove billing address in payment method content */
+        $fields = $jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
+        ['payment']['children']['payments-list']['children'];
+        foreach ($fields as $code => $field) {
+            if ($field['component'] == 'Magento_Checkout/js/view/billing-address') {
+                unset($jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
+                    ['payment']['children']['payments-list']['children'][$code]);
+            }
+        }
+
+        return $jsLayout;
+    }
+
+    /**
+     * @param $fields
+     * @return array
+     */
+    public function getBillingAddressFieldset($fields)
+    {
+        $attributesToConvert = [
+            'prefix' => [$this->getOptions(), 'getNamePrefixOptions'],
+            'suffix' => [$this->getOptions(), 'getNameSuffixOptions'],
+        ];
+
+        $elements = $this->getAddressAttributes();
+        $elements = $this->convertElementsToSelect($elements, $attributesToConvert);
+
+        $fields = $this->merger->merge(
+            $elements,
+            'checkoutProvider',
+            'billingAddress',
+            $fields
+        );
+
+        $this->sortAddressPosition($fields, 'billing');
+
+        return $fields;
+    }
+
+    /**
+     * @param $fields
+     * @param string $type
+     * @return $this
+     */
+    private function sortAddressPosition(&$fields, $type = 'shipping')
+    {
+        $fieldPosition = $this->_oscHelper->getAddressFieldPosition();
+        foreach ($fields as $code => $field) {
+            if (!isset($fieldPosition[$code])) {
+                $fieldPosition[$code] = [
+                    'sortOrder' => 200,
+                    'colspan'   => 12
+                ];
+            }
+
+            $fields[$code]['sortOrder']                   = $fieldPosition[$code]['sortOrder'];
+            $fields[$code]['config']['additionalClasses'] = [
+                'col-mp'                                 => true,
+                'mp-' . $fieldPosition[$code]['colspan'] => true
+            ];
+
+            $this->rewriteTemplate($fields[$code]);
+        }
+
+        return $this;
+    }
+
+    /**
+     * Change template to remove valueUpdate = 'keyup'
+     *
+     * @param $field
+     * @param string $template
+     * @return $this
+     */
+    public function rewriteTemplate(&$field, $template = 'Mageplaza_Osc/container/form/element/input')
+    {
+        if (isset($field['type']) && $field['type'] == 'group') {
+            foreach ($field['children'] as $key => &$child) {
+                if ($key == 0 && in_array('street', explode('.', $field['dataScope'])) && $this->isGoogleHttps()) {
+                    $this->rewriteTemplate($child, 'Mageplaza_Osc/container/form/element/street');
+                    continue;
+                }
+                $this->rewriteTemplate($child);
+            }
+        } elseif (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
+            $field['config']['elementTmpl'] = $template;
+        }
+
+        return $this;
+    }
+
+    /**
+     * @return bool
+     */
+    private function isGoogleHttps()
+    {
+        $isEnable = ($this->_oscHelper->getConfig()->getAutoDetectedAddress() == 'google');
+
+        return $isEnable && $this->request->isSecure();
+    }
 }
diff --git a/Block/Design.php b/Block/Generator/Css.php
similarity index 92%
rename from Block/Design.php
rename to Block/Generator/Css.php
index 347b4fd..0871e9b 100644
--- a/Block/Design.php
+++ b/Block/Generator/Css.php
@@ -18,7 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\Osc\Block;
+namespace Mageplaza\Osc\Block\Generator;
 
 use Mageplaza\Osc\Helper\Config;
 use Magento\Framework\View\Element\Template;
@@ -28,7 +28,7 @@ use Magento\Framework\View\Element\Template\Context;
  * Class Css
  * @package Mageplaza\Osc\Block\Generator
  */
-class Design extends Template
+class Css extends Template
 {
     /**
      * @var Config
@@ -80,6 +80,6 @@ class Design extends Template
      */
     public function getDesignConfiguration()
     {
-        return $this->getHelperConfig()->getDesignConfig();
+        return $this->getHelperConfig()->getDesignConfiguration();
     }
 }
diff --git a/Block/Order/Totals.php b/Block/Order/Totals.php
deleted file mode 100644
index aa7b32e..0000000
--- a/Block/Order/Totals.php
+++ /dev/null
@@ -1,46 +0,0 @@
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
-namespace Mageplaza\Osc\Block\Order;
-
-use Magento\Framework\DataObject;
-use Magento\Framework\View\Element\Template;
-
-/**
- * Class GiftWrap
- * @package Mageplaza\Osc\Block\Totals\Order
- */
-class Totals extends Template
-{
-	public function initTotals()
-	{
-		$totalsBlock = $this->getParentBlock();
-		$source      = $totalsBlock->getSource();
-		if ($source && $source->getOscGiftWrapAmount() > 0.0001) {
-			$totalsBlock->addTotal(new DataObject([
-				'code'  => 'gift_wrap',
-				'field' => 'osc_gift_wrap_amount',
-				'label' => __('Gift Wrap'),
-				'value' => $source->getOscGiftWrapAmount(),
-			]));
-		}
-	}
-}
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index 20643b4..0ffcc95 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -31,7 +31,6 @@ class Index extends \Magento\Checkout\Controller\Cart\Add
      */
     public function execute()
     {
-//        $this->_objectManager->create('Magento\Catalog\Model\ResourceModel\Product\Collection');
         $productId = 36;
         $storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
         $product = $this->productRepository->getById($productId, false, $storeId);
diff --git a/Controller/Adminhtml/Field/Position.php b/Controller/Adminhtml/Field/Position.php
deleted file mode 100644
index 15cab58..0000000
--- a/Controller/Adminhtml/Field/Position.php
+++ /dev/null
@@ -1,67 +0,0 @@
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
-namespace Mageplaza\Osc\Controller\Adminhtml\Field;
-
-/**
- * Class Position
- * @package Mageplaza\Osc\Controller\Adminhtml\Field
- */
-class Position extends \Magento\Backend\App\Action
-{
-	/**
-	 * @var \Magento\Framework\View\Result\PageFactory
-	 */
-	protected $resultPageFactory;
-
-	/**
-	 * @param \Magento\Backend\App\Action\Context $context
-	 * @param \Magento\Framework\View\Result\PageFactory $resultPageFactory
-	 */
-	public function __construct(
-		\Magento\Backend\App\Action\Context $context,
-		\Magento\Framework\View\Result\PageFactory $resultPageFactory
-	)
-	{
-		parent::__construct($context);
-		$this->resultPageFactory = $resultPageFactory;
-	}
-
-	/**
-	 * @return \Magento\Framework\View\Result\Page
-	 */
-	public function execute()
-	{
-		$resultPage = $this->resultPageFactory->create();
-		/**
-		 * Set active menu item
-		 */
-		$resultPage->setActiveMenu('Mageplaza_Osc::field_management');
-		$resultPage->getConfig()->getTitle()->prepend(__('Field Management'));
-
-		/**
-		 * Add breadcrumb item
-		 */
-		$resultPage->addBreadcrumb(__('One Step Checkout'), __('One Step Checkout'));
-		$resultPage->addBreadcrumb(__('Field Management'), __('Field Management'));
-
-		return $resultPage;
-	}
-}
diff --git a/Controller/Adminhtml/Field/Save.php b/Controller/Adminhtml/Field/Save.php
deleted file mode 100644
index 3d0794f..0000000
--- a/Controller/Adminhtml/Field/Save.php
+++ /dev/null
@@ -1,89 +0,0 @@
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
-namespace Mageplaza\Osc\Controller\Adminhtml\Field;
-
-use Magento\Framework\App\Config\ScopeConfigInterface;
-use Mageplaza\Osc\Helper\Config as HelperConfig;
-
-/**
- * Class Save
- * @package Mageplaza\Osc\Controller\Adminhtml\Field
- */
-class Save extends \Magento\Backend\App\Action
-{
-	/**
-	 * @var \Magento\Config\Model\ResourceModel\Config
-	 */
-	protected $resourceConfig;
-
-	/**
-	 * Application config
-	 *
-	 * @var \Magento\Framework\App\Config\ScopeConfigInterface
-	 */
-	protected $_appConfig;
-
-	/**
-	 * @param \Magento\Backend\App\Action\Context $context
-	 * @param \Magento\Config\Model\ResourceModel\Config $resourceConfig
-	 * @param \Magento\Framework\App\Config\ReinitableConfigInterface $config
-	 */
-	public function __construct(
-		\Magento\Backend\App\Action\Context $context,
-		\Magento\Config\Model\ResourceModel\Config $resourceConfig,
-		\Magento\Framework\App\Config\ReinitableConfigInterface $config
-	)
-	{
-		parent::__construct($context);
-
-		$this->resourceConfig = $resourceConfig;
-		$this->_appConfig = $config;
-	}
-
-	/**
-	 * save position to config
-	 */
-	public function execute()
-	{
-		$result = [
-			'success' => false,
-			'message' => __('Error during save field position.')
-		];
-
-		$fields = $this->getRequest()->getParam('fields', false);
-		if ($fields) {
-			$this->resourceConfig->saveConfig(
-				HelperConfig::SORTED_FIELD_POSITION,
-				$fields,
-				ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
-				0
-			);
-
-			// re-init configuration
-			$this->_appConfig->reinit();
-
-			$result['success'] = true;
-			$result['message'] = __('All fields have been saved.');
-		}
-
-		$this->getResponse()->setBody(\Zend_Json::encode($result));
-	}
-}
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index 6e92baf..a3cd3e0 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -26,90 +26,68 @@ namespace Mageplaza\Osc\Controller\Index;
  */
 class Index extends \Magento\Checkout\Controller\Onepage
 {
-	/**
-	 * @type \Mageplaza\Osc\Helper\Data
-	 */
-	protected $_checkoutHelper;
-
-	/**
-	 *
-	 * @return $this|\Magento\Framework\View\Result\Page
-	 */
-	public function execute()
-	{
-		$this->_checkoutHelper = $this->_objectManager->get('Mageplaza\Osc\Helper\Data');
-		if (!$this->_checkoutHelper->isEnabled()) {
-			$this->messageManager->addError(__('One step checkout is turned off.'));
-
-			return $this->resultRedirectFactory->create()->setPath('checkout');
-		}
-
-		$quote = $this->getOnepage()->getQuote();
-		if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
-			return $this->resultRedirectFactory->create()->setPath('checkout/cart');
-		}
-
-		$this->_customerSession->regenerateId();
-		$this->_objectManager->get('Magento\Checkout\Model\Session')->setCartWasUpdated(false);
-		$this->getOnepage()->initCheckout();
-
-		$this->initDefaultMethods($quote);
-
-		$resultPage = $this->resultPageFactory->create();
-		$resultPage->getConfig()->getTitle()->set($this->_checkoutHelper->getConfig()->getCheckoutTitle());
-
-		return $resultPage;
-	}
-
-	/**
-	 * Default shipping/payment method
-	 *
-	 * @param $quote
-	 * @return bool
-	 */
-	public function initDefaultMethods($quote)
-	{
-		$shippingAddress = $quote->getShippingAddress();
-		if (!$shippingAddress->getCountryId()) {
-			$shippingAddress->setCountryId($this->_checkoutHelper->getConfig()->getDefaultCountryId())
-				->setCollectShippingRates(true);
-		}
-
-		$method = null;
-
-		try {
-			$availableMethods = $this->_objectManager->get('Magento\Quote\Api\ShippingMethodManagementInterface')
-				->getList($quote->getId());
-			if (sizeof($availableMethods) == 1) {
-				$method = array_shift($availableMethods);
-			} else if (!$shippingAddress->getShippingMethod() && sizeof($availableMethods)) {
-				$defaultMethod = array_filter($availableMethods, [$this, 'filterMethod']);
-				if (sizeof($defaultMethod)) {
-					$method = array_shift($defaultMethod);
-				}
-			}
-
-			if ($method) {
-				$methodCode = $method->getCarrierCode() . '_' . $method->getMethodCode();
-				$this->getOnepage()->saveShippingMethod($methodCode);
-			}
-
-			$this->quoteRepository->save($quote);
-		} catch (\Exception $e) {
-			return false;
-		}
-
-		return true;
-	}
-
-	public function filterMethod($method)
-	{
-		$defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
-		$methodCode            = $method->getCarrierCode() . '_' . $method->getMethodCode();
-		if ($methodCode == $defaultShippingMethod) {
-			return true;
-		}
-
-		return false;
-	}
+    /**
+     * @type \Mageplaza\Osc\Helper\Data
+     */
+    protected $_checkoutHelper;
+
+    /**
+     *
+     * @return $this|\Magento\Framework\View\Result\Page
+     */
+    public function execute()
+    {
+        $this->_checkoutHelper = $this->_objectManager->get('Mageplaza\Osc\Helper\Data');
+        if (!$this->_checkoutHelper->isEnabled()) {
+            $this->messageManager->addError(__('One step checkout is turned off.'));
+
+            return $this->resultRedirectFactory->create()->setPath('checkout');
+        }
+
+        $quote = $this->getOnepage()->getQuote();
+        if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
+            return $this->resultRedirectFactory->create()->setPath('checkout/cart');
+        }
+
+        $this->_customerSession->regenerateId();
+        $this->_objectManager->get('Magento\Checkout\Model\Session')->setCartWasUpdated(false);
+        $this->getOnepage()->initCheckout();
+
+        $this->initDefaultMethods($quote);
+
+        $resultPage = $this->resultPageFactory->create();
+        $resultPage->getConfig()->getTitle()->set($this->_checkoutHelper->getConfig()->getCheckoutTitle());
+
+        return $resultPage;
+    }
+
+    /**
+     * Default shipping/payment method
+     *
+     * @param $quote
+     * @return bool
+     */
+    public function initDefaultMethods($quote)
+    {
+        $shippingAddress = $quote->getShippingAddress();
+        if (!$shippingAddress->getCountryId()) {
+            $shippingAddress->setCountryId($this->_checkoutHelper->getConfig()->getDefaultCountryId())
+                ->setCollectShippingRates(true)
+                ->collectShippingRates()
+                ->save();
+        }
+
+        $defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
+        if (!$shippingAddress->getShippingMethod() && $defaultShippingMethod) {
+            $this->getOnepage()->saveShippingMethod($defaultShippingMethod);
+        }
+
+        try {
+            $this->quoteRepository->save($quote);
+        } catch (\Exception $e) {
+            return false;
+        }
+
+        return true;
+    }
 }
diff --git a/Helper/Config.php b/Helper/Config.php
index 4e62529..6cc44da 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -20,15 +20,7 @@
  */
 namespace Mageplaza\Osc\Helper;
 
-use Magento\Customer\Helper\Address;
-use Magento\Customer\Model\AttributeMetadataDataProvider;
-use Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory as AddressFactory;
-use Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory as CustomerFactory;
-use Magento\Framework\App\Helper\Context;
-use Magento\Framework\ObjectManagerInterface;
-use Magento\Store\Model\StoreManagerInterface;
 use Mageplaza\Core\Helper\AbstractData;
-use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
 
 /**
  * Class Config
@@ -36,581 +28,354 @@ use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
  */
 class Config extends AbstractData
 {
-	/**
-	 * Is enable module path
-	 */
-	const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
-
-	/**
-	 * Field position
-	 */
-	const SORTED_FIELD_POSITION = 'osc/field/position';
-
-	/**
-	 * General configuaration path
-	 */
-	const GENERAL_CONFIGUARATION = 'osc/general';
-
-	/**
-	 * Display configuaration path
-	 */
-	const DISPLAY_CONFIGUARATION = 'osc/display_configuration';
-
-	/**
-	 * Design configuaration path
-	 */
-	const DESIGN_CONFIGUARATION = 'osc/design_configuration';
-
-	/**
-	 * @var \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory
-	 */
-	protected $_addressesFactory;
-
-	/**
-	 * @var \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory
-	 */
-	protected $_customerFactory;
-
-	/**
-	 * @var \Magento\Customer\Model\AttributeMetadataDataProvider
-	 */
-	private $attributeMetadataDataProvider;
-
-	public function __construct(
-		Context $context,
-		ObjectManagerInterface $objectManager,
-		StoreManagerInterface $storeManager,
-		Address $addressHelper,
-		AddressFactory $addressesFactory,
-		CustomerFactory $customerFactory,
-		AttributeMetadataDataProvider $attributeMetadataDataProvider
-	)
-	{
-		parent::__construct($context, $objectManager, $storeManager);
-
-		$this->addressHelper                 = $addressHelper;
-		$this->_addressesFactory             = $addressesFactory;
-		$this->_customerFactory              = $customerFactory;
-		$this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-	}
-
-	/**
-	 * Is enable module on frontend
-	 *
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isEnabled($store = null)
-	{
-		$isModuleOutputEnabled = $this->isModuleOutputEnabled();
-
-		return $isModuleOutputEnabled && $this->getConfigValue(self::GENERAL_IS_ENABLED, $store);
-	}
-
-	/**
-	 * Check the current page is osc
-	 *
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isOscPage($store = null)
-	{
-		$moduleEnable = $this->isEnabled($store);
-		$isOscModule  = ($this->_request->getRouteName() == 'onestepcheckout');
-
-		return $moduleEnable && $isOscModule;
-	}
-
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
-	 * Get position to display on one step checkout
-	 *
-	 * @return array
-	 */
-	public function getAddressFieldPosition()
-	{
-		$fieldPosition = [];
-		$sortedField   = $this->getSortedField();
-		foreach ($sortedField as $field) {
-			$fieldPosition[$field->getAttributeCode()] = [
-				'sortOrder' => $field->getSortOrder(),
-				'colspan'   => $field->getColspan(),
-				'isNewRow'  => $field->getIsNewRow()
-			];
-		}
-
-		return $fieldPosition;
-	}
-
-	/**
-	 * Get attribute collection to show on osc and manage field
-	 *
-	 * @param bool|true $onlySorted
-	 * @return array
-	 */
-	public function getSortedField($onlySorted = true)
-	{
-		$availableFields = [];
-		$sortedFields    = [];
-		$sortOrder       = 1;
-
-		/** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
-		$collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
-			'customer_address',
-			'customer_register_address'
-		);
-		foreach ($collection as $key => $field) {
-			if (!$this->isAddressAttributeVisible($field)) {
-				continue;
-			}
-			$availableFields[] = $field;
-		}
-
-		/** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
-		$collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
-			'customer',
-			'customer_account_create'
-		);
-		foreach ($collection as $key => $field) {
-			if (!$this->isCustomerAttributeVisible($field)) {
-				continue;
-			}
-			$availableFields[] = $field;
-		}
-
-		$isNewRow    = true;
-		$fieldConfig = $this->getFieldPosition();
-		foreach ($fieldConfig as $field) {
-			foreach ($availableFields as $key => $avField) {
-				if ($field['code'] == $avField->getAttributeCode()) {
-					$avField->setColspan($field['colspan'])
-						->setSortOrder($sortOrder++)
-						->setIsNewRow($isNewRow);
-					$sortedFields[] = $avField;
-					unset($availableFields[$key]);
-
-					$this->checkNewRow($field['colspan'], $isNewRow);
-					break;
-				}
-			}
-		}
-
-		return $onlySorted ? $sortedFields : [$sortedFields, $availableFields];
-	}
-
-	private function checkNewRow($colSpan, &$isNewRow)
-	{
-		if ($colSpan == 6 && $isNewRow) {
-			$isNewRow = false;
-		} else if ($colSpan == 12 || ($colSpan == 6 && !$isNewRow)) {
-			$isNewRow = true;
-		}
-
-		return $this;
-	}
-
-	/**
-	 * Check if address attribute can be visible on frontend
-	 *
-	 * @param $attribute
-	 * @return bool|null|string
-	 */
-	public function isAddressAttributeVisible($attribute)
-	{
-		$code   = $attribute->getAttributeCode();
-		$result = $attribute->getIsVisible();
-		switch ($code) {
-			case 'vat_id':
-				$result = $this->addressHelper->isVatAttributeVisible();
-				break;
-			case 'region':
-				$result = false;
-				break;
-		}
-
-		return $result;
-	}
-
-	/**
-	 * Check if customer attribute can be visible on frontend
-	 *
-	 * @param \Magento\Eav\Api\Data\AttributeInterface $attribute
-	 * @return bool|null|string
-	 */
-	public function isCustomerAttributeVisible($attribute)
-	{
-		$code = $attribute->getAttributeCode();
-		if (in_array($code, ['gender', 'taxvat', 'dob'])) {
-			return $attribute->getIsVisible();
-		} else if (!$attribute->getIsUserDefined()) {
-			return false;
-		}
-
-		return true;
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
-	}
-
-	/**
-	 * One step checkout page title
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getCheckoutTitle($store = null)
-	{
-		return $this->getGeneralConfig('title', $store);
-	}
-
-	/**
-	 * One step checkout page description
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getCheckoutDescription($store = null)
-	{
-		return $this->getGeneralConfig('description', $store);
-	}
-
-	/**
-	 * Get magento default country
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getDefaultCountryId($store = null)
-	{
-		return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
+    /**
+     * Is enable module path
+     */
+    const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
+
+    /**
+     * General configuaration path
+     */
+    const GENERAL_CONFIGUARATION = 'osc/general/';
+
+    /**
+     * Display configuaration path
+     */
+    const DISPLAY_CONFIGUARATION = 'osc/display_configuration/';
+
+    /**
+     * Design configuaration path
+     */
+    const DESIGN_CONFIGUARATION = 'osc/design_configuration/';
+
+    /**
+     * Is enable module on frontend
+     *
+     * @param null $store
+     * @return bool
+     */
+    public function isEnabled($store = null)
+    {
+        $isModuleOutputEnabled = $this->isModuleOutputEnabled();
+
+        return $isModuleOutputEnabled && $this->getConfigValue(self::GENERAL_IS_ENABLED, $store);
+    }
+
+    /**
+     * Check the current page is osc
+     *
+     * @param null $store
+     * @return bool
+     */
+    public function isOscPage($store = null)
+    {
+        $moduleEnable = $this->isEnabled($store);
+        $isOscModule  = ($this->_request->getRouteName() == 'onestepcheckout');
+
+        return $moduleEnable && $isOscModule;
+    }
+
+    /**
+     * Get magento default country
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getDefaultCountryId($store = null)
+    {
+        return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
 //		return $this->getConfigValue('general/country/default', $store);
-	}
-
-	/**
-	 * Default shipping method
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getDefaultShippingMethod($store = null)
-	{
-		return $this->getGeneralConfig('default_shipping_method', $store);
-	}
-
-	/**
-	 * Default payment method
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getDefaultPaymentMethod($store = null)
-	{
-		return $this->getGeneralConfig('default_payment_method', $store);
-	}
-
-	/**
-	 * Allow guest checkout
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getAllowGuestCheckout($store = null)
-	{
-		return boolval($this->getGeneralConfig('allow_guest_checkout', $store));
-	}
-
-	/**
-	 * Show billing address
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getShowBillingAddress($store = null)
-	{
-		return boolval($this->getGeneralConfig('show_billing_address', $store));
-	}
-
-	/**
-	 * Get auto detected address
-	 * @param null $store
-	 * @return null|'google'|'pca'
-	 */
-	public function getAutoDetectedAddress($store = null)
-	{
-		return $this->getGeneralConfig('auto_detect_address', $store);
-	}
-
-	/**
-	 * Google api key
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getGoogleApiKey($store = null)
-	{
-		return $this->getGeneralConfig('google_api_key', $store);
-	}
+    }
 
-	/**
-	 * Google restric country
+    /************************ General Configuration *************************
 	 *
+	 * @param      $code
 	 * @param null $store
 	 * @return mixed
 	 */
-	public function getGoogleSpecificCountry($store = null)
-	{
-		return $this->getGeneralConfig('google_specific_country', $store);
-	}
-
-	/**
-	 * Check if the page is https
-	 *
-	 * @return bool
-	 */
-	public function isGoogleHttps()
-	{
-		$isEnable = ($this->getAutoDetectedAddress() == 'google');
-
-		return $isEnable && $this->_request->isSecure();
-	}
-
-	/********************************** Display Configuration *********************
+    public function getGeneralConfig($code, $store = null)
+    {
+        return $this->getConfigValue(self::GENERAL_CONFIGUARATION . $code, $store);
+    }
+
+    /**
+     * One step checkout page title
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getCheckoutTitle($store = null)
+    {
+        return $this->getGeneralConfig('title', $store);
+    }
+
+    /**
+     * One step checkout page description
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getCheckoutDescription($store = null)
+    {
+        return $this->getGeneralConfig('description', $store);
+    }
+
+    /**
+     * Default shipping method
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getDefaultShippingMethod($store = null)
+    {
+        return $this->getGeneralConfig('default_shipping_method', $store);
+    }
+
+    /**
+     * Default payment method
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getDefaultPaymentMethod($store = null)
+    {
+        return $this->getGeneralConfig('default_payment_method', $store);
+    }
+
+    /**
+     * Allow guest checkout
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getAllowGuestCheckout($store = null)
+    {
+        return boolval($this->getGeneralConfig('allow_guest_checkout', $store));
+    }
+
+    /**
+     * Show billing address
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getShowBillingAddress($store = null)
+    {
+        return boolval($this->getGeneralConfig('show_billing_address', $store));
+    }
+
+    /**
+     * Get auto detected address
+     * @param null $store
+     * @return null|'google'|'pca'
+     */
+    public function getAutoDetectedAddress($store = null)
+    {
+        return $this->getGeneralConfig('auto_detect_address', $store);
+    }
+
+    /**
+     * Google api key
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getGoogleApiKey($store = null)
+    {
+        return $this->getGeneralConfig('google_api_key', $store);
+    }
+
+    /**
+     * Google restric country
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getGoogleSpecificCountry($store = null)
+    {
+        return $this->getGeneralConfig('google_specific_country', $store);
+    }
+
+    /********************************** Display Configuration *********************
 	 *
 	 * @param $code
 	 * @param null $store
 	 * @return mixed
 	 */
-	public function getDisplayConfig($code = '', $store = null)
-	{
-		$code = $code ? self::DISPLAY_CONFIGUARATION . '/' . $code : self::DISPLAY_CONFIGUARATION;
-
-		return $this->getConfigValue($code, $store);
-	}
-
-	/**
-	 * Login link will be hide if this function return true
-	 *
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isDisableAuthentication($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_login_link', $store);
-	}
-
-	/**
-	 * Item detail will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isDisabledReviewCartSection($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_review_cart_section', $store);
-	}
-
-	/**
-	 * Product image will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isHideProductImage($store = null)
-	{
-		return !$this->getDisplayConfig('is_show_product_image', $store);
-	}
-
-	/**
-	 * Coupon will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function disabledPaymentCoupon($store = null)
-	{
-		return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_PAYMENT;
-	}
-
-	/**
-	 * Coupon will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function disabledReviewCoupon($store = null)
-	{
-		return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_REVIEW;
-	}
-
-	/**
-	 * Comment will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function isDisabledComment($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_comments', $store);
-	}
-
-	/**
-	 * Term and condition checkbox in payment block will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function disabledPaymentTOC($store = null)
-	{
-		return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_PAYMENT;
-	}
-
-	/**
-	 * Term and condition checkbox in review will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function disabledReviewTOC($store = null)
-	{
-		return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_REVIEW;
-	}
-
-	/**
-	 * GiftMessage will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function isEnabledGiftMessage($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_giftmessage', $store);
-	}
-
-	/**
-	 * Gift wrap block will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function isDisabledGiftWrap($store = null)
-	{
-		$giftWrapEnabled = $this->getDisplayConfig('is_enabled_gift_wrap', $store);
-		$giftWrapAmount  = $this->getOrderGiftwrapAmount();
-
-		return !$giftWrapEnabled || ($giftWrapAmount < 0.0001);
-	}
-
-	/**
-	 * Gift wrap type
+    public function getDisplayConfig($code, $store = null)
+    {
+        return $this->getConfigValue(self::DISPLAY_CONFIGUARATION . $code, $store);
+    }
+
+    /**
+     * Login link will be hide if this function return true
+     *
+     * @param null $store
+     * @return bool
+     */
+    public function isDisableAuthentication($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_login_link', $store);
+    }
+
+    /**
+     * Item detail will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return bool
+     */
+    public function isDisabledReviewCartSection($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_review_cart_section', $store);
+    }
+
+    /**
+     * Product image will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return bool
+     */
+    public function isHideProductImage($store = null)
+    {
+        return !$this->getDisplayConfig('is_show_product_image', $store);
+    }
+
+    /**
+     * Coupon will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isDisabledCoupon($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_coupon', $store);
+    }
+
+    /**
+     * Comment will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isDisabledComment($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_comments', $store);
+    }
+
+    /**
+     * Term and condition checkbox will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isDisabledTOC($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_toc', $store);
+    }
+
+    /**
+     * GiftMessage will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isEnabledGiftMessage($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_giftmessage', $store);
+    }
+
+    /**
+     * Gift wrap block will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isEnabledGiftWrap($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_giftwrap', $store);
+    }
+
+    /**
+     * Gift wrap type
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getGiftWrapType($store = null)
+    {
+        return $this->getDisplayConfig('giftwrap_type', $store);
+    }
+
+    /**
+     * Gift wrap amount
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getOrderGiftwrapAmount($store = null)
+    {
+        return $this->getDisplayConfig('giftwrap_amount', $store);
+    }
+
+    /**
+     * Newsleter block will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isDisabledNewsletter($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_newsletter', $store);
+    }
+
+    /**
+     * Is newsleter subcribed default
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isSubscribedByDefault($store = null)
+    {
+        return $this->getDisplayConfig('is_checked_newsletter', $store);
+    }
+
+    /***************************** Design Configuration *****************************
 	 *
 	 * @param null $store
 	 * @return mixed
 	 */
-	public function getGiftWrapType($store = null)
-	{
-		return $this->getDisplayConfig('gift_wrap_type', $store);
-	}
-
-	/**
-	 * Gift wrap amount
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getOrderGiftWrapAmount($store = null)
-	{
-		return doubleval($this->getDisplayConfig('gift_wrap_amount', $store));
-	}
-
-	/**
-	 * @return array
-	 */
-	public function getGiftWrapConfiguration()
-	{
-		return [
-			'gift_wrap_type'   => $this->getGiftWrapType(),
-			'gift_wrap_amount' => $this->formatGiftWrapAmount()
-		];
-	}
-
-	/**
-	 * @return mixed
-	 */
-	public function formatGiftWrapAmount()
-	{
-		$objectManager  = \Magento\Framework\App\ObjectManager::getInstance();
-		$giftWrapAmount = $objectManager->create('Magento\Checkout\Helper\Data')->formatPrice($this->getOrderGiftWrapAmount());
-
-		return $giftWrapAmount;
-	}
-
-	/**
-	 * Newsleter block will be hided if this function return 'true'
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function isDisabledNewsletter($store = null)
-	{
-		return !$this->getDisplayConfig('is_enabled_newsletter', $store);
-	}
-
-	/**
-	 * Is newsleter subcribed default
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function isSubscribedByDefault($store = null)
-	{
-		return $this->getDisplayConfig('is_checked_newsletter', $store);
-	}
-
-	/***************************** Design Configuration *****************************
-	 *
-	 * @param null $store
-	 * @return mixed
-	 */
-	public function getDesignConfig($code = '', $store = null)
-	{
-		$code = $code ? self::DESIGN_CONFIGUARATION . '/' . $code : self::DESIGN_CONFIGUARATION;
-
-		return $this->getConfigValue($code, $store);
-	}
-
-	/**
-	 * Get layout tempate: 1 or 2 or 3 columns
-	 *
-	 * @param null $store
-	 * @return string
-	 */
-	public function getLayoutTemplate($store = null)
-	{
-		return 'Mageplaza_Osc/' . $this->getDesignConfig('page_layout', $store);
-	}
+    public function getDesignConfig($code, $store = null)
+    {
+        return $this->getConfigValue(self::DESIGN_CONFIGUARATION . $code, $store);
+    }
+
+    /**
+     * Get design configuration
+     *
+     * @return array
+     */
+    public function getDesignConfiguration()
+    {
+        $design = [
+            'page_layout'        => $this->getDesignConfig('page_layout'),
+            'page_design'        => $this->getDesignConfig('page_design'),
+            'heading_background' => $this->getDesignConfig('heading_background'),
+            'heading_text'       => $this->getDesignConfig('heading_text'),
+            'place_order_button' => $this->getDesignConfig('place_order_button'),
+            'custom_css'         => $this->getDesignConfig('custom_css')
+        ];
+
+        return $design;
+    }
+
+    /**
+     * Get layout tempate: 1 or 2 or 3 columns
+     *
+     * @param null $store
+     * @return string
+     */
+    public function getLayoutTemplate($store = null)
+    {
+        return 'Mageplaza_Osc/' . $this->getDesignConfig('page_layout', $store);
+    }
 }
diff --git a/Helper/Data.php b/Helper/Data.php
index 00d17ec..dd4d72d 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -21,13 +21,13 @@
 namespace Mageplaza\Osc\Helper;
 
 use Magento\Checkout\Helper\Data as HelperData;
+use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
 use Magento\Framework\App\Helper\Context;
 use Magento\Framework\App\ObjectManager;
-use Magento\Framework\ObjectManagerInterface;
+use Magento\Store\Model\StoreManagerInterface;
 use Magento\Framework\Pricing\PriceCurrencyInterface;
+use Magento\Framework\ObjectManagerInterface;
 use Magento\Newsletter\Model\Subscriber;
-use Magento\Store\Model\StoreManagerInterface;
-use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
 
 /**
  * Class Data
@@ -35,86 +35,252 @@ use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
  */
 class Data extends AbstractHelper
 {
-	/**
-	 * @type \Magento\Checkout\Helper\Data
-	 */
-	protected $_helperData;
-
-	/**
-	 * @type \Mageplaza\Osc\Helper\Config
-	 */
-	protected $_helperConfig;
-
-	/**
-	 * @type \Magento\Newsletter\Model\Subscriber
-	 */
-	protected $_subscriber;
-
-	/**
-	 * @param \Magento\Framework\App\Helper\Context $context
-	 * @param \Magento\Checkout\Helper\Data $helperData
-	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-	 * @param \Mageplaza\Osc\Helper\Config $helperConfig
-	 * @param \Magento\Framework\ObjectManagerInterface $objectManager
-	 * @param \Magento\Newsletter\Model\Subscriber $subscriber
-	 */
-	public function __construct(
-		Context $context,
-		HelperData $helperData,
-		StoreManagerInterface $storeManager,
-		Config $helperConfig,
-		ObjectManagerInterface $objectManager,
-		Subscriber $subscriber
-	)
-	{
-
-		$this->_helperData   = $helperData;
-		$this->_helperConfig = $helperConfig;
-		$this->_subscriber   = $subscriber;
-		parent::__construct($context, $objectManager, $storeManager);
-	}
-
-	/**
-	 * @return \Mageplaza\Osc\Helper\Config
-	 */
-	public function getConfig()
-	{
-		return $this->_helperConfig;
-	}
-
-	/**
-	 * @param null $store
-	 * @return bool
-	 */
-	public function isEnabled($store = null)
-	{
-		return $this->getConfig()->isEnabled($store);
-	}
-
-	public function convertPrice($amount, $store = null)
-	{
-		return $this->priceCurrency->convert($amount, $store);
-	}
-
-	public function calculateGiftWrapAmount($quote)
-	{
-		$baseOscGiftWrapAmount = $this->getConfig()->getOrderGiftwrapAmount();
-		if ($baseOscGiftWrapAmount < 0.0001) {
-			return 0;
-		}
-
-		$giftWrapType = $this->getConfig()->getGiftWrapType();
-		if ($giftWrapType == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
-			$giftWrapBaseAmount    = $baseOscGiftWrapAmount;
-			$baseOscGiftWrapAmount = 0;
-			foreach ($quote->getAllVisibleItems() as $item) {
-				if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
-					continue;
-				}
-				$baseOscGiftWrapAmount += $giftWrapBaseAmount * $item->getQty();
-			}
-		}
-
-		return $this->convertPrice($baseOscGiftWrapAmount, $quote->getStore());
-	}
+    /**
+     * @type \Magento\Checkout\Helper\Data
+     */
+    protected $_helperData;
+
+    /**
+     * @type \Mageplaza\Osc\Helper\Config
+     */
+    protected $_helperConfig;
+
+    /**
+     * @type \Magento\Framework\Pricing\PriceCurrencyInterface
+     */
+    protected $_priceCurrency;
+
+    /**
+     * @type \Magento\Newsletter\Model\Subscriber
+     */
+    protected $_subscriber;
+
+    /**
+     * @param \Magento\Framework\App\Helper\Context $context
+     * @param \Magento\Checkout\Helper\Data $helperData
+     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+     * @param \Mageplaza\Osc\Helper\Config $helperConfig
+     * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
+     * @param \Magento\Framework\ObjectManagerInterface $objectManager
+     * @param \Magento\Newsletter\Model\Subscriber $subscriber
+     */
+    public function __construct(
+        Context $context,
+        HelperData $helperData,
+        StoreManagerInterface $storeManager,
+        Config $helperConfig,
+        PriceCurrencyInterface $priceCurrency,
+        ObjectManagerInterface $objectManager,
+        Subscriber $subscriber
+    ) {
+    
+        $this->_helperData    = $helperData;
+        $this->_helperConfig  = $helperConfig;
+        $this->_priceCurrency = $priceCurrency;
+        $this->_subscriber    = $subscriber;
+        parent::__construct($context, $objectManager, $storeManager);
+    }
+
+    /**
+     * @return \Mageplaza\Osc\Helper\Config
+     */
+    public function getConfig()
+    {
+        return $this->_helperConfig;
+    }
+
+    /**
+     * @param null $store
+     * @return bool
+     */
+    public function isEnabled($store = null)
+    {
+        return $this->getConfig()->isEnabled($store);
+    }
+
+    /**
+     * Check if user must be logged during checkout process
+     *
+     * @return boolean
+     * @codeCoverageIgnore
+     */
+    public function isCustomerMustBeLogged()
+    {
+        return $this->_helperData->isCustomerMustBeLogged();
+    }
+
+    /**
+     * Get Customer by email
+     *
+     * @param string $email
+     * @return bool|\Magento\Customer\Model\Customer
+     */
+    public function getCustomerByEmail($email, $websiteId = null)
+    {
+        $websiteId = $websiteId ?: $this->storeManager->getWebsite()->getId();
+        /** @var \Magento\Customer\Model\Customer $customer */
+        $customer = $this->objectManager->get('Magento\Customer\Model\Customer');
+        $customer->setWebsiteId($websiteId)
+            ->loadByEmail($email);
+
+        if ($customer && $customer->getId()) {
+            return $customer;
+        }
+
+        return null;
+    }
+
+    /**
+     * Get formated grand total
+     *
+     * @param \Magento\Quote\Model\Quote $quote
+     * @return mixed
+     */
+    public function getGrandTotal($quote)
+    {
+        $grandTotal = $quote->getGrandTotal();
+
+        return $this->storeManager->getStore()->getCurrentCurrency()->format($grandTotal, [], false);
+    }
+
+    /**
+     * @return array
+     */
+    public function getAddressFieldPosition()
+    {
+        return [
+            'prefix'  => [
+                'sortOrder' => 5,
+                'colspan'   => 6
+            ],
+            'firstname'  => [
+                'sortOrder' => 10,
+                'colspan'   => 6
+            ],
+            'middlename'  => [
+                'sortOrder' => 15,
+                'colspan'   => 6
+            ],
+            'lastname'   => [
+                'sortOrder' => 20,
+                'colspan'   => 6
+            ],
+            'suffix'  => [
+                'sortOrder' => 25,
+                'colspan'   => 6
+            ],
+            'street'     => [
+                'sortOrder' => 30,
+                'colspan'   => 12
+            ],
+            'country_id' => [
+                'sortOrder' => 40,
+                'colspan'   => 6
+            ],
+            'city'       => [
+                'sortOrder' => 50,
+                'colspan'   => 6
+            ],
+            'postcode'   => [
+                'sortOrder' => 60,
+                'colspan'   => 6
+            ],
+            'region_id'  => [
+                'sortOrder' => 70,
+                'colspan'   => 6
+            ],
+            'region'  => [
+                'sortOrder' => 75,
+                'colspan'   => 6
+            ],
+            'company'    => [
+                'sortOrder' => 80,
+                'colspan'   => 12
+            ],
+            'vat_id'  => [
+                'sortOrder' => 90,
+                'colspan'   => 6
+            ],
+            'telephone'  => [
+                'sortOrder' => 100,
+                'colspan'   => 6
+            ],
+            'fax'        => [
+                'sortOrder' => 110,
+                'colspan'   => 6
+            ]
+        ];
+    }
+
+    /**
+     * Removes empty values from the array given
+     *
+     * @param mixed $data Array to inspect or data to be placed in new array as first value
+     * @return array Array processed
+     */
+    public static function noEmptyValues($data)
+    {
+        $result = [];
+        if (is_array($data)) {
+            foreach ($data as $a) {
+                if ($a) {
+                    $result[] = $a;
+                }
+            }
+        } else {
+            $result = $data ? [] : [$data];
+        }
+
+        return $result;
+    }
+
+    /**
+     * @param $value
+     * @return string
+     */
+    public function formatPrice($value)
+    {
+        return $this->_priceCurrency->convertAndFormat($value);
+    }
+
+    /**
+     * @param $value
+     * @return float
+     */
+    public function convertPrice($value)
+    {
+        return $this->_priceCurrency->convert($value);
+    }
+
+    /**
+     * @return string
+     */
+    public function getHowToCheckoutUrl()
+    {
+        return $this->_urlBuilder->getBaseUrl(true) . 'how-to-checkout-our-store';
+    }
+
+    /**
+     * Subscriber Newsletter
+     *
+     * @return Subscriber
+     */
+    public function getSubscriber()
+    {
+        return $this->_subscriber;
+    }
+
+    /**
+     * @param $email
+     * @return bool
+     */
+    public function isSubscribed($email)
+    {
+        $subscriber = $this->getSubscriber()->loadByEmail($email);
+        if ($subscriber && $subscriber->getId()) {
+            return true;
+        }
+
+        return false;
+    }
 }
diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index a48dcc3..bca5c2e 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -20,16 +20,15 @@
  */
 namespace Mageplaza\Osc\Model;
 
-use Magento\Framework\Exception\CouldNotSaveException;
-use Magento\Framework\Exception\InputException;
-use Magento\Framework\Exception\NoSuchEntityException;
-use Magento\Framework\UrlInterface;
-use Magento\Quote\Api\CartRepositoryInterface;
-use Magento\Quote\Api\CartTotalRepositoryInterface;
-use Magento\Quote\Api\PaymentMethodManagementInterface;
-use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Mageplaza\Osc\Api\CheckoutManagementInterface;
+use Magento\Quote\Api\CartRepositoryInterface;
 use Mageplaza\Osc\Model\OscDetailsFactory;
+use Magento\Framework\UrlInterface;
+use Magento\Quote\Api\ShippingMethodManagementInterface;
+use Magento\Quote\Api\PaymentMethodManagementInterface;
+use Magento\Quote\Api\CartTotalRepositoryInterface;
+use Magento\Framework\Exception\CouldNotSaveException;
+use Magento\Framework\Exception\NoSuchEntityException;
 
 /**
  * Class CheckoutManagement
@@ -37,202 +36,178 @@ use Mageplaza\Osc\Model\OscDetailsFactory;
  */
 class CheckoutManagement implements CheckoutManagementInterface
 {
-	/**
-	 * @var CartRepositoryInterface
-	 */
-	protected $cartRepository;
-
-	/**
-	 * @type \Mageplaza\Osc\Model\OscDetailFactory
-	 */
-	protected $oscDetailsFactory;
-
-	/**
-	 * @var \Magento\Quote\Api\ShippingMethodManagementInterface
-	 */
-	protected $shippingMethodManagement;
-
-	/**
-	 * @var \Magento\Quote\Api\PaymentMethodManagementInterface
-	 */
-	protected $paymentMethodManagement;
-
-	/**
-	 * @var \Magento\Quote\Api\CartTotalRepositoryInterface
-	 */
-	protected $cartTotalsRepository;
-
-	/**
-	 * Url Builder
-	 *
-	 * @var \Magento\Framework\UrlInterface
-	 */
-	protected $_urlBuilder;
-
-	/**
-	 * Checkout session
-	 *
-	 * @type \Magento\Checkout\Model\Session
-	 */
-	protected $checkoutSession;
-
-	/**
-	 * @var \Magento\Checkout\Api\ShippingInformationManagementInterface
-	 */
-	protected $shippingInformationManagement;
-
-	/**
-	 * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
-	 * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
-	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
-	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
-	 * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
-	 * @param \Magento\Framework\UrlInterface $urlBuilder
-	 * @param \Magento\Checkout\Model\Session $checkoutSession
-	 * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
-	 */
-	public function __construct(
-		CartRepositoryInterface $cartRepository,
-		OscDetailsFactory $oscDetailsFactory,
-		ShippingMethodManagementInterface $shippingMethodManagement,
-		PaymentMethodManagementInterface $paymentMethodManagement,
-		CartTotalRepositoryInterface $cartTotalsRepository,
-		UrlInterface $urlBuilder,
-		\Magento\Checkout\Model\Session $checkoutSession,
-		\Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
-	)
-	{
-		$this->cartRepository                = $cartRepository;
-		$this->oscDetailsFactory             = $oscDetailsFactory;
-		$this->shippingMethodManagement      = $shippingMethodManagement;
-		$this->paymentMethodManagement       = $paymentMethodManagement;
-		$this->cartTotalsRepository          = $cartTotalsRepository;
-		$this->_urlBuilder                   = $urlBuilder;
-		$this->checkoutSession               = $checkoutSession;
-		$this->shippingInformationManagement = $shippingInformationManagement;
-	}
-
-	/**
-	 * {@inheritDoc}
-	 */
-	public function updateItemQty($cartId, $itemId, $itemQty)
-	{
-		/** @var \Magento\Quote\Model\Quote $quote */
-		$quote     = $this->cartRepository->getActive($cartId);
-		$quoteItem = $quote->getItemById($itemId);
-		if (!$quoteItem) {
-			throw new NoSuchEntityException(
-				__('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
-			);
-		}
-
-		try {
-			$quoteItem->setQty($itemQty)->save();
-			$this->cartRepository->save($quote);
-		} catch (\Exception $e) {
-			throw new CouldNotSaveException(__('Could not update item from quote'));
-		}
-
-		return $this->getResponseData($quote);
-	}
-
-	/**
-	 * {@inheritDoc}
-	 */
-	public function removeItemById($cartId, $itemId)
-	{
-		/** @var \Magento\Quote\Model\Quote $quote */
-		$quote     = $this->cartRepository->getActive($cartId);
-		$quoteItem = $quote->getItemById($itemId);
-		if (!$quoteItem) {
-			throw new NoSuchEntityException(
-				__('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
-			);
-		}
-		try {
-			$quote->removeItem($itemId);
-			$this->cartRepository->save($quote);
-		} catch (\Exception $e) {
-			throw new CouldNotSaveException(__('Could not remove item from quote'));
-		}
-
-		return $this->getResponseData($quote);
-	}
-
-	/**
-	 * {@inheritDoc}
-	 */
-	public function getPaymentTotalInformation($cartId)
-	{
-		/** @var \Magento\Quote\Model\Quote $quote */
-		$quote = $this->cartRepository->getActive($cartId);
-
-		return $this->getResponseData($quote);
-	}
-
-	/**
-	 * {@inheritDoc}
-	 */
-	public function updateGiftWrap($cartId, $isUseGiftWrap)
-	{
-		/** @var \Magento\Quote\Model\Quote $quote */
-		$quote = $this->cartRepository->getActive($cartId);
-		$quote->getShippingAddress()->setUsedGiftWrap($isUseGiftWrap);
-
-		try {
-			$this->cartRepository->save($quote);
-		} catch (\Exception $e) {
-			throw new CouldNotSaveException(__('Could not add gift wrap for this quote'));
-		}
-
-		return $this->getResponseData($quote);
-	}
-
-	/**
-	 * Response data to update osc block
-	 *
-	 * @param \Magento\Quote\Model\Quote $quote
-	 * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
-	 */
-	public function getResponseData(\Magento\Quote\Model\Quote $quote)
-	{
-		/** @var \Mageplaza\Osc\Api\Data\OscDetailsInterface $oscDetails */
-		$oscDetails = $this->oscDetailsFactory->create();
-
-		if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
-			$oscDetails->setRedirectUrl($this->_urlBuilder->getUrl('checkout/cart'));
-		} else {
-			if ($quote->getShippingAddress()->getCountryId()) {
-				$oscDetails->setShippingMethods($this->shippingMethodManagement->getList($quote->getId()));
-			}
-			$oscDetails->setPaymentMethods($this->paymentMethodManagement->getList($quote->getId()));
-			$oscDetails->setTotals($this->cartTotalsRepository->get($quote->getId()));
-		}
-
-		return $oscDetails;
-	}
-
-	/**
-	 * {@inheritDoc}
-	 */
-	public function saveCheckoutInformation(
-		$cartId,
-		\Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
-		$customerAttributes = [],
-		$additionInformation = []
-	)
-	{
-		try {
-			$additionInformation['customerAttributes'] = $customerAttributes;
-			$this->checkoutSession->setOscData($additionInformation);
-
-			if ($addressInformation->getShippingAddress()) {
-				$this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
-			}
-		} catch (\Exception $e) {
-			throw new InputException(__('Unable to save order information. Please check input data.'));
-		}
-
-		return true;
-	}
+    /**
+     * @var CartRepositoryInterface
+     */
+    protected $cartRepository;
+
+    /**
+     * @type \Mageplaza\Osc\Model\OscDetailFactory
+     */
+    protected $oscDetailsFactory;
+
+    /**
+     * @var \Magento\Quote\Api\ShippingMethodManagementInterface
+     */
+    protected $shippingMethodManagement;
+
+    /**
+     * @var \Magento\Quote\Api\PaymentMethodManagementInterface
+     */
+    protected $paymentMethodManagement;
+
+    /**
+     * @var \Magento\Quote\Api\CartTotalRepositoryInterface
+     */
+    protected $cartTotalsRepository;
+
+    /**
+     * Url Builder
+     *
+     * @var \Magento\Framework\UrlInterface
+     */
+    protected $_urlBuilder;
+
+    /**
+     * Checkout session
+     *
+     * @type \Magento\Checkout\Model\Session
+     */
+    protected $checkoutSession;
+
+    /**
+     * @var \Magento\Checkout\Api\ShippingInformationManagementInterface
+     */
+    protected $shippingInformationManagement;
+
+    /**
+     * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
+     * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
+     * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+     * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+     * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
+     * @param \Magento\Framework\UrlInterface $urlBuilder
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
+     */
+    public function __construct(
+        CartRepositoryInterface $cartRepository,
+        OscDetailsFactory $oscDetailsFactory,
+        ShippingMethodManagementInterface $shippingMethodManagement,
+        PaymentMethodManagementInterface $paymentMethodManagement,
+        CartTotalRepositoryInterface $cartTotalsRepository,
+        UrlInterface $urlBuilder,
+        \Magento\Checkout\Model\Session $checkoutSession,
+        \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
+    ) {
+    
+        $this->cartRepository                = $cartRepository;
+        $this->oscDetailsFactory             = $oscDetailsFactory;
+        $this->shippingMethodManagement      = $shippingMethodManagement;
+        $this->paymentMethodManagement       = $paymentMethodManagement;
+        $this->cartTotalsRepository          = $cartTotalsRepository;
+        $this->_urlBuilder                   = $urlBuilder;
+        $this->checkoutSession               = $checkoutSession;
+        $this->shippingInformationManagement = $shippingInformationManagement;
+    }
+
+    /**
+     * {@inheritDoc}
+     */
+    public function updateItemQty($cartId, $itemId, $itemQty)
+    {
+        /** @var \Magento\Quote\Model\Quote $quote */
+        $quote     = $this->cartRepository->getActive($cartId);
+        $quoteItem = $quote->getItemById($itemId);
+        if (!$quoteItem) {
+            throw new NoSuchEntityException(
+                __('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
+            );
+        }
+
+        try {
+            $quoteItem->setQty($itemQty)->save();
+            $this->cartRepository->save($quote);
+        } catch (\Exception $e) {
+            throw new CouldNotSaveException(__('Could not update item from quote'));
+        }
+
+        return $this->getResponseData($quote);
+    }
+
+    /**
+     * {@inheritDoc}
+     */
+    public function removeItemById($cartId, $itemId)
+    {
+        /** @var \Magento\Quote\Model\Quote $quote */
+        $quote     = $this->cartRepository->getActive($cartId);
+        $quoteItem = $quote->getItemById($itemId);
+        if (!$quoteItem) {
+            throw new NoSuchEntityException(
+                __('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
+            );
+        }
+        try {
+            $quote->removeItem($itemId);
+            $this->cartRepository->save($quote);
+        } catch (\Exception $e) {
+            throw new CouldNotSaveException(__('Could not remove item from quote'));
+        }
+
+        return $this->getResponseData($quote);
+    }
+
+    /**
+     * {@inheritDoc}
+     */
+    public function getPaymentTotalInformation($cartId)
+    {
+        /** @var \Magento\Quote\Model\Quote $quote */
+        $quote     = $this->cartRepository->getActive($cartId);
+
+        return $this->getResponseData($quote);
+    }
+
+    /**
+     * Response data to update osc block
+     *
+     * @param \Magento\Quote\Model\Quote $quote
+     * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
+     */
+    public function getResponseData(\Magento\Quote\Model\Quote $quote)
+    {
+        /** @var \Mageplaza\Osc\Api\Data\OscDetailsInterface $oscDetails */
+        $oscDetails = $this->oscDetailsFactory->create();
+
+        if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
+            $oscDetails->setRedirectUrl($this->_urlBuilder->getUrl('checkout/cart'));
+        } else {
+            if ($quote->getShippingAddress()->getCountryId()) {
+                $oscDetails->setShippingMethods($this->shippingMethodManagement->getList($quote->getId()));
+            }
+            $oscDetails->setPaymentMethods($this->paymentMethodManagement->getList($quote->getId()));
+            $oscDetails->setTotals($this->cartTotalsRepository->get($quote->getId()));
+        }
+
+        return $oscDetails;
+    }
+
+    /**
+     * {@inheritDoc}
+     */
+    public function saveCheckoutInformation(
+        $cartId,
+        \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
+        $additionInformation = []
+    ) {
+    
+        if ($addressInformation->getShippingAddress()) {
+            $this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
+        }
+
+        $this->checkoutSession->setOscData($additionInformation);
+
+        return true;
+    }
 }
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index 26fd722..554ddf4 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -20,9 +20,9 @@
  */
 namespace Mageplaza\Osc\Model;
 
+use Magento\Customer\Model\AccountManagement;
 use Magento\Checkout\Model\ConfigProviderInterface;
 use Magento\Checkout\Model\Session as CheckoutSession;
-use Magento\Customer\Model\AccountManagement;
 use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Mageplaza\Osc\Helper\Config as OscConfig;
@@ -34,128 +34,135 @@ use Mageplaza\Osc\Helper\Config as OscConfig;
 class DefaultConfigProvider implements ConfigProviderInterface
 {
 
-	/**
-	 * @var CheckoutSession
-	 */
-	private $checkoutSession;
-
-	/**
-	 * @var \Magento\Quote\Api\PaymentMethodManagementInterface
-	 */
-	protected $paymentMethodManagement;
-
-	/**
-	 * @type \Magento\Quote\Api\ShippingMethodManagementInterface
-	 */
-	protected $shippingMethodManagement;
-
-	/**
-	 * @type \Mageplaza\Osc\Helper\Config
-	 */
-	protected $oscConfig;
-
-	/**
-	 * @param \Magento\Checkout\Model\Session $checkoutSession
-	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
-	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
-	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
-	 */
-	public function __construct(
-		CheckoutSession $checkoutSession,
-		PaymentMethodManagementInterface $paymentMethodManagement,
-		ShippingMethodManagementInterface $shippingMethodManagement,
-		OscConfig $oscConfig
-	)
-	{
-		$this->checkoutSession          = $checkoutSession;
-		$this->paymentMethodManagement  = $paymentMethodManagement;
-		$this->shippingMethodManagement = $shippingMethodManagement;
-		$this->oscConfig                = $oscConfig;
-	}
-
-	/**
-	 * {@inheritdoc}
-	 */
-	public function getConfig()
-	{
-		if (!$this->oscConfig->isOscPage()) {
-			return [];
-		}
-
-		$output = [
-			'shippingMethods'       => $this->getShippingMethods(),
-			'selectedShippingRate'  => $this->oscConfig->getDefaultShippingMethod(),
-			'paymentMethods'        => $this->getPaymentMethods(),
-			'selectedPaymentMethod' => $this->oscConfig->getDefaultPaymentMethod(),
-			'oscConfig'             => $this->getOscConfig()
-		];
-
-		return $output;
-	}
-
-	/**
-	 * @return array
-	 */
-	private function getOscConfig()
-	{
-		return [
-			'addressFields'      => $this->getAddressFields(),
-			'autocomplete'       => [
-				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
-				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
-			],
-			'register'           => [
-				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
-				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
-			],
-			'allowGuestCheckout' => $this->oscConfig->getAllowGuestCheckout(),
-			'showBillingAddress' => $this->oscConfig->getShowBillingAddress(),
-			'newsletterDefault'  => $this->oscConfig->isSubscribedByDefault(),
-			'isUsedGiftWrap'     => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap()
-		];
-	}
-
-	private function getAddressFields()
-	{
-		$fieldPosition = $this->oscConfig->getAddressFieldPosition();
-
-		$fields = array_keys($fieldPosition);
-		if (!in_array('country_id', $fields)) {
-			array_unshift($fields, 'country_id');
-		}
-
-		return $fields;
-	}
-
-	/**
-	 * Returns array of payment methods
-	 * @return array
-	 */
-	private function getPaymentMethods()
-	{
-		$paymentMethods = [];
-		$quote          = $this->checkoutSession->getQuote();
-		foreach ($this->paymentMethodManagement->getList($quote->getId()) as $paymentMethod) {
-			$paymentMethods[] = [
-				'code'  => $paymentMethod->getCode(),
-				'title' => $paymentMethod->getTitle()
-			];
-		}
-
-		return $paymentMethods;
-	}
-
-	/**
-	 * Returns array of payment methods
-	 * @return array
-	 */
-	private function getShippingMethods()
-	{
-		$methodLists = $this->shippingMethodManagement->getList($this->checkoutSession->getQuote()->getId());
-		foreach ($methodLists as $key => $method) {
-			$methodLists[$key] = $method->__toArray();
-		}
-
-		return $methodLists;
-	}
+    /**
+     * @var CheckoutSession
+     */
+    private $checkoutSession;
+
+    /**
+     * @var \Magento\Quote\Api\PaymentMethodManagementInterface
+     */
+    protected $paymentMethodManagement;
+
+    /**
+     * @type \Magento\Quote\Api\ShippingMethodManagementInterface
+     */
+    protected $shippingMethodManagement;
+
+    /**
+     * @type \Mageplaza\Osc\Helper\Config
+     */
+    protected $oscConfig;
+
+    /**
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+     * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+     * @param \Mageplaza\Osc\Helper\Config $oscConfig
+     */
+    public function __construct(
+        CheckoutSession $checkoutSession,
+        PaymentMethodManagementInterface $paymentMethodManagement,
+        ShippingMethodManagementInterface $shippingMethodManagement,
+        OscConfig $oscConfig
+    ) {
+    
+        $this->checkoutSession          = $checkoutSession;
+        $this->paymentMethodManagement  = $paymentMethodManagement;
+        $this->shippingMethodManagement = $shippingMethodManagement;
+        $this->oscConfig                = $oscConfig;
+    }
+
+    /**
+     * {@inheritdoc}
+     */
+    public function getConfig()
+    {
+        if (!$this->oscConfig->isOscPage()) {
+            return [];
+        }
+
+        $output = [
+            'shippingMethods'       => $this->getShippingMethods(),
+            'selectedShippingRate'  => $this->oscConfig->getDefaultShippingMethod(),
+            'paymentMethods'        => $this->getPaymentMethods(),
+            'selectedPaymentMethod' => $this->oscConfig->getDefaultPaymentMethod(),
+            'oscConfig'             => $this->getOscConfig()
+        ];
+
+        return $output;
+    }
+
+    /**
+     * @return array
+     */
+    private function getOscConfig()
+    {
+        return [
+            'autocomplete'       => [
+                'type'                   => $this->oscConfig->getAutoDetectedAddress(),
+                'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
+            ],
+            'register'           => [
+                'dataPasswordMinLength'        => $this->getMinimumPasswordLength(),
+                'dataPasswordMinCharacterSets' => $this->getRequiredCharacterClassesNumber()
+            ],
+            'allowGuestCheckout' => $this->oscConfig->getAllowGuestCheckout(),
+            'showBillingAddress' => $this->oscConfig->getShowBillingAddress(),
+            'newsletterDefault'  => $this->oscConfig->isSubscribedByDefault(),
+            'design'             => $this->oscConfig->getDesignConfiguration()
+        ];
+    }
+
+    /**
+     * Returns array of payment methods
+     * @return array
+     */
+    private function getPaymentMethods()
+    {
+        $paymentMethods = [];
+        $quote          = $this->checkoutSession->getQuote();
+        foreach ($this->paymentMethodManagement->getList($quote->getId()) as $paymentMethod) {
+            $paymentMethods[] = [
+                'code'  => $paymentMethod->getCode(),
+                'title' => $paymentMethod->getTitle()
+            ];
+        }
+
+        return $paymentMethods;
+    }
+
+    /**
+     * Returns array of payment methods
+     * @return array
+     */
+    private function getShippingMethods()
+    {
+        $methodLists = $this->shippingMethodManagement->getList($this->checkoutSession->getQuote()->getId());
+        foreach ($methodLists as $key => $method) {
+            $methodLists[$key] = $method->__toArray();
+        }
+
+        return $methodLists;
+    }
+
+    /**
+     * Get minimum password length
+     *
+     * @return string
+     */
+    public function getMinimumPasswordLength()
+    {
+        return $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH);
+    }
+
+    /**
+     * Get number of password required character classes
+     *
+     * @return string
+     */
+    public function getRequiredCharacterClassesNumber()
+    {
+        return $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER);
+    }
 }
diff --git a/Model/GuestCheckoutManagement.php b/Model/GuestCheckoutManagement.php
index 93faf7e..d0dc0f3 100644
--- a/Model/GuestCheckoutManagement.php
+++ b/Model/GuestCheckoutManagement.php
@@ -81,17 +81,6 @@ class GuestCheckoutManagement implements \Mageplaza\Osc\Api\GuestCheckoutManagem
 
         return $this->checkoutManagement->getPaymentTotalInformation($quoteIdMask->getQuoteId());
     }
-    
-    /**
-     * {@inheritDoc}
-     */
-    public function updateGiftWrap($cartId, $isUseGiftWrap)
-    {
-        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
-        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
-
-        return $this->checkoutManagement->updateGiftWrap($quoteIdMask->getQuoteId(), $isUseGiftWrap);
-    }
 
     /**
      * {@inheritDoc}
@@ -99,7 +88,6 @@ class GuestCheckoutManagement implements \Mageplaza\Osc\Api\GuestCheckoutManagem
     public function saveCheckoutInformation(
         $cartId,
         \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
-        $customerAttributes = [],
         $additionInformation = []
     ) {
         /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
@@ -108,7 +96,6 @@ class GuestCheckoutManagement implements \Mageplaza\Osc\Api\GuestCheckoutManagem
         return $this->checkoutManagement->saveCheckoutInformation(
             $quoteIdMask->getQuoteId(),
             $addressInformation,
-            $customerAttributes,
             $additionInformation
         );
     }
diff --git a/Model/Plugin/Customer/Address.php b/Model/Plugin/Customer/Address.php
deleted file mode 100644
index 5a54fb4..0000000
--- a/Model/Plugin/Customer/Address.php
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
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-namespace Mageplaza\Osc\Model\Plugin\Customer;
-
-use Magento\Customer\Api\Data\AddressInterface;
-
-/**
- * Class Address
- * @package Mageplaza\Osc\Model\Plugin\Customer
- */
-class Address
-{
-	/**
-	 * @param \Magento\Customer\Model\Address $subject
-	 * @param \Closure $proceed
-	 * @param \Magento\Customer\Api\Data\AddressInterface $address
-	 * @return mixed
-	 */
-	public function aroundUpdateData(\Magento\Customer\Model\Address $subject, \Closure $proceed, AddressInterface $address)
-	{
-		$object = $proceed($address);
-
-		$addressData = $address->__toArray();
-		if (isset($addressData['should_ignore_validation'])) {
-			$object->setShouldIgnoreValidation($addressData['should_ignore_validation']);
-		}
-
-		return $object;
-	}
-}
diff --git a/Model/Plugin/Quote/GiftWrap.php b/Model/Plugin/Quote/GiftWrap.php
deleted file mode 100644
index 8416931..0000000
--- a/Model/Plugin/Quote/GiftWrap.php
+++ /dev/null
@@ -1,80 +0,0 @@
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
-namespace Mageplaza\Osc\Model\Plugin\Quote;
-
-use Magento\Quote\Api\Data\TotalSegmentExtensionFactory;
-
-/**
- * Class Address
- * @package Mageplaza\Osc\Model\Plugin\Customer
- */
-class GiftWrap
-{
-	const GIFT_WRAP_CODE = 'osc_gift_wrap';
-
-	/**
-	 * @var TotalSegmentExtensionFactory
-	 */
-	protected $totalSegmentExtensionFactory;
-
-	/**
-	 * @param \Magento\Quote\Api\Data\TotalSegmentExtensionFactory $totalSegmentExtensionFactory
-	 */
-	public function __construct(
-		TotalSegmentExtensionFactory $totalSegmentExtensionFactory
-	)
-	{
-		$this->totalSegmentExtensionFactory = $totalSegmentExtensionFactory;
-	}
-
-	/**
-	 * @param \Magento\Quote\Model\Cart\TotalsConverter $subject
-	 * @param \Closure $proceed
-	 * @param array $addressTotals
-	 * @return mixed
-	 */
-	public function aroundProcess(
-		\Magento\Quote\Model\Cart\TotalsConverter $subject,
-		\Closure $proceed,
-		array $addressTotals = []
-	)
-	{
-		$totalSegments = $proceed($addressTotals);
-
-		if (!array_key_exists(self::GIFT_WRAP_CODE, $addressTotals)) {
-			return $totalSegments;
-		}
-
-		$giftWrap = $addressTotals[self::GIFT_WRAP_CODE]->getData();
-		if (!array_key_exists('gift_wrap_amount', $giftWrap)) {
-			return $totalSegments;
-		}
-
-		$attributes = $totalSegments[self::GIFT_WRAP_CODE]->getExtensionAttributes();
-		if ($attributes === null) {
-			$attributes = $this->totalSegmentExtensionFactory->create();
-		}
-		$attributes->setGiftWrapAmount($giftWrap['gift_wrap_amount']);
-		$totalSegments[self::GIFT_WRAP_CODE]->setExtensionAttributes($attributes);
-
-		return $totalSegments;
-	}
-}
diff --git a/Model/Plugin/Checkout/ShippingMethodManagement.php b/Model/Plugin/ShippingMethodManagement.php
similarity index 97%
rename from Model/Plugin/Checkout/ShippingMethodManagement.php
rename to Model/Plugin/ShippingMethodManagement.php
index 8662bf4..aaca07a 100644
--- a/Model/Plugin/Checkout/ShippingMethodManagement.php
+++ b/Model/Plugin/ShippingMethodManagement.php
@@ -18,14 +18,14 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\Osc\Model\Plugin\Checkout;
+namespace Mageplaza\Osc\Model\Plugin;
 
 use Magento\Quote\Api\Data\EstimateAddressInterface;
 use Magento\Quote\Api\Data\AddressInterface;
 
 /**
  * Class ShippingMethodManagement
- * @package Mageplaza\Osc\Model\Plugin\Checkout
+ * @package Mageplaza\Osc\Model\Plugin
  */
 class ShippingMethodManagement
 {
diff --git a/Model/System/Config/Source/AddressSuggest.php b/Model/System/Config/Source/Address/Suggest.php
similarity index 93%
rename from Model/System/Config/Source/AddressSuggest.php
rename to Model/System/Config/Source/Address/Suggest.php
index a3aa97f..4f37d71 100644
--- a/Model/System/Config/Source/AddressSuggest.php
+++ b/Model/System/Config/Source/Address/Suggest.php
@@ -16,13 +16,13 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-namespace Mageplaza\Osc\Model\System\Config\Source;
+namespace Mageplaza\Osc\Model\System\Config\Source\Address;
 
 /**
  * Class Suggest
  * @package Mageplaza\Osc\Model\System\Config\Source\Address
  */
-class AddressSuggest
+class Suggest
 {
     /**
      * @return array
diff --git a/Model/System/Config/Source/ComponentPosition.php b/Model/System/Config/Source/ComponentPosition.php
deleted file mode 100644
index 853600c..0000000
--- a/Model/System/Config/Source/ComponentPosition.php
+++ /dev/null
@@ -1,37 +0,0 @@
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
-class ComponentPosition extends AbstractModel
-{
-	const NOT_SHOW = 0;
-	const SHOW_IN_PAYMENT = 1;
-	const SHOW_IN_REVIEW = 2;
-
-	public function toOptionArray()
-	{
-		return [
-			self::NOT_SHOW        => __('No'),
-			self::SHOW_IN_PAYMENT => __('In Payment Area'),
-			self::SHOW_IN_REVIEW  => __('In Review Area')
-		];
-	}
-}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Enableddisabled.php b/Model/System/Config/Source/Enableddisabled.php
new file mode 100644
index 0000000..a1096ea
--- /dev/null
+++ b/Model/System/Config/Source/Enableddisabled.php
@@ -0,0 +1,65 @@
+<?php
+/**
+* Mageplaza
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
+namespace Mageplaza\Osc\Model\System\Config\Source;
+
+/**
+ * Class Enableddisabled
+ * @package Mageplaza\Osc\Model\System\Config\Source
+ */
+class Enableddisabled
+{
+    const DISABLED_CODE = 0;
+    const ENABLED_CODE  = 1;
+    const DISABLED_LABEL = 'Disabled';
+    const ENABLED_LABEL  = 'Enabled';
+
+    /**
+     * Options getter
+     *
+     * @return array
+     */
+    public function toOptionArray()
+    {
+        return [
+            [
+                'value' => self::ENABLED_CODE,
+                'label' => __(self::ENABLED_LABEL),
+            ],
+            [
+                'value' => self::DISABLED_CODE,
+                'label' => __(self::DISABLED_LABEL),
+            ],
+        ];
+    }
+
+    /**
+     * Get options in "key-value" format
+     *
+     * @return array
+     */
+    public function toArray()
+    {
+        return [
+            self::ENABLED_CODE  => __(self::ENABLED_LABEL),
+            self::DISABLED_CODE => __(self::DISABLED_LABEL),
+        ];
+    }
+}
diff --git a/Model/System/Config/Source/Giftwrap.php b/Model/System/Config/Source/Giftwrap.php
deleted file mode 100644
index a539520..0000000
--- a/Model/System/Config/Source/Giftwrap.php
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement.html
- */
-namespace Mageplaza\Osc\Model\System\Config\Source;
-
-use Magento\Framework\Model\AbstractModel;
-
-class Giftwrap extends AbstractModel
-{
-    const PER_ORDER = 0;
-    const PER_ITEM  = 1;
- 
-    public function toOptionArray()
-    {
-        return [
-            self::PER_ORDER => __('Per Order'),
-            self::PER_ITEM  => __('Per Item')
-        ];
-    }
-}
\ No newline at end of file
diff --git a/Model/System/Config/Source/PaymentMethods.php b/Model/System/Config/Source/Payment/Methods.php
similarity index 71%
rename from Model/System/Config/Source/PaymentMethods.php
rename to Model/System/Config/Source/Payment/Methods.php
index f83868c..076a3c1 100644
--- a/Model/System/Config/Source/PaymentMethods.php
+++ b/Model/System/Config/Source/Payment/Methods.php
@@ -18,7 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\Osc\Model\System\Config\Source;
+namespace Mageplaza\Osc\Model\System\Config\Source\Payment;
 
 use Magento\Framework\Option\ArrayInterface;
 
@@ -26,7 +26,7 @@ use Magento\Framework\Option\ArrayInterface;
  * Class Methods
  * @package Mageplaza\Osc\Model\System\Config\Source\Payment
  */
-class PaymentMethods implements ArrayInterface
+class Methods implements ArrayInterface
 {
     /**
      * @var \Magento\Checkout\Model\Type\Onepage
@@ -59,17 +59,12 @@ class PaymentMethods implements ArrayInterface
             ],
         ];
 
-        $methods = $this->_paymentHelperData->getPaymentMethods();
-        foreach(array_keys($methods) as $code){
-            try{
-                $model = $this->_paymentHelperData->getMethodInstance($code);
-                $options[] = [
-                    'label' => $model->getTitle(),
-                    'value' => $model->getCode(),
-                ];
-            } catch (\Exception $e){
-                continue;
-            }
+        $methods = $this->_paymentHelperData->getStoreMethods();
+        foreach ($methods as $key => $method) {
+            $options[] = [
+                'label' => $method->getTitle(),
+                'value' => $method->getCode(),
+            ];
         }
 
         return $options;
diff --git a/Model/System/Config/Source/ShippingMethods.php b/Model/System/Config/Source/Shipping/Methods.php
similarity index 97%
rename from Model/System/Config/Source/ShippingMethods.php
rename to Model/System/Config/Source/Shipping/Methods.php
index 34d28aa..9b18562 100644
--- a/Model/System/Config/Source/ShippingMethods.php
+++ b/Model/System/Config/Source/Shipping/Methods.php
@@ -18,7 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\Osc\Model\System\Config\Source;
+namespace Mageplaza\Osc\Model\System\Config\Source\Shipping;
 
 use Magento\Framework\App\ObjectManager;
 use Magento\Framework\App\Config\ScopeConfigInterface as StoreConfig;
@@ -28,7 +28,7 @@ use Magento\Shipping\Model\Config as CarrierConfig;
  * Class Methods
  * @package Mageplaza\Osc\Model\System\Config\Source\Shipping
  */
-class ShippingMethods
+class Methods
 {
     /**
      * @var \Magento\Framework\App\Config\ScopeConfigInterface
diff --git a/Model/Total/Creditmemo/GiftWrap.php b/Model/Total/Creditmemo/GiftWrap.php
deleted file mode 100644
index c273ede..0000000
--- a/Model/Total/Creditmemo/GiftWrap.php
+++ /dev/null
@@ -1,86 +0,0 @@
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
-namespace Mageplaza\Osc\Model\Total\Creditmemo;
-
-use Magento\Sales\Model\Order\Creditmemo;
-use Magento\Sales\Model\Order\Creditmemo\Total\AbstractTotal;
-
-/**
- * Class GiftWrap
- * @package Mageplaza\Osc\Model\Total\Creditmemo
- */
-class GiftWrap extends AbstractTotal
-{
-	/**
-	 * @param \Magento\Sales\Model\Order\Creditmemo $creditmemo
-	 * @return $this|void
-	 */
-	public function collect(Creditmemo $creditmemo)
-	{
-		$order = $creditmemo->getOrder();
-		if ($order->getOscGiftWrapAmount() < 0.0001) {
-			return $this;
-		}
-		$totalGiftWrapAmount     = 0;
-		$totalBaseGiftWrapAmount = 0;
-		if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
-			foreach ($creditmemo->getAllItems() as $item) {
-				$orderItem = $item->getOrderItem();
-				if ($orderItem->isDummy() || ($orderItem->getOscGiftWrapAmount() < 0.001)) {
-					continue;
-				}
-				$rate = $item->getQty() / $orderItem->getQtyOrdered();
-
-				$totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
-				$totalGiftWrapAmount += $orderItem->getOscGiftWrapAmount() * $rate;
-			}
-		} else if ($this->isLast($creditmemo)) {
-			$totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
-			$totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
-		}
-
-		$creditmemo->setBaseOscGiftWrapAmount($totalBaseGiftWrapAmount);
-		$creditmemo->setOscGiftWrapAmount($totalGiftWrapAmount);
-
-		$creditmemo->setGrandTotal($creditmemo->getGrandTotal() + $totalGiftWrapAmount);
-		$creditmemo->setBaseGrandTotal($creditmemo->getBaseGrandTotal() + $totalBaseGiftWrapAmount);
-
-		return $this;
-	}
-
-	/**
-	 * check credit memo is last or not
-	 *
-	 * @param Creditmemo $creditmemo
-	 * @return boolean
-	 */
-	public function isLast($creditmemo)
-	{
-		foreach ($creditmemo->getAllItems() as $item) {
-			if (!$item->isLast()) {
-				return false;
-			}
-		}
-
-		return true;
-	}
-}
diff --git a/Model/Total/Invoice/GiftWrap.php b/Model/Total/Invoice/GiftWrap.php
deleted file mode 100644
index 30a3c23..0000000
--- a/Model/Total/Invoice/GiftWrap.php
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
-
-namespace Mageplaza\Osc\Model\Total\Invoice;
-
-use Magento\Sales\Model\Order\Invoice;
-use Magento\Sales\Model\Order\Invoice\Total\AbstractTotal;
-
-/**
- * Class GiftWrap
- * @package Mageplaza\Osc\Model\Total\Invoice
- */
-class GiftWrap extends AbstractTotal
-{
-	/**
-	 * @param \Magento\Sales\Model\Order\Invoice $invoice
-	 * @return $this
-	 */
-	public function collect(Invoice $invoice)
-	{
-		$order = $invoice->getOrder();
-		if ($order->getOscGiftWrapAmount() < 0.0001) {
-			return $this;
-		}
-		$totalGiftWrapAmount     = 0;
-		$totalBaseGiftWrapAmount = 0;
-
-		if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
-			foreach ($invoice->getAllItems() as $item) {
-				$orderItem = $item->getOrderItem();
-				if ($orderItem->isDummy() || ($orderItem->getOscGiftWrapAmount() < 0.001)) {
-					continue;
-				}
-				$rate = $item->getQty() / $orderItem->getQtyOrdered();
-
-				$totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
-				$totalGiftWrapAmount += $orderItem->getOscGiftWrapAmount() * $rate;
-			}
-		} else {
-			$invoiceCollections = $order->getInvoiceCollection();
-			if ($invoiceCollections->getSize() == 0) {
-				$totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
-				$totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
-			}
-		}
-		$invoice->setBaseOscGiftWrapAmount($totalBaseGiftWrapAmount);
-		$invoice->setOscGiftWrapAmount($totalGiftWrapAmount);
-
-		$invoice->setGrandTotal($invoice->getGrandTotal() + $totalGiftWrapAmount);
-		$invoice->setBaseGrandTotal($invoice->getBaseGrandTotal() + $totalBaseGiftWrapAmount);
-
-		return $this;
-	}
-
-}
diff --git a/Model/Total/Quote/GiftWrap.php b/Model/Total/Quote/GiftWrap.php
deleted file mode 100644
index 2f8af22..0000000
--- a/Model/Total/Quote/GiftWrap.php
+++ /dev/null
@@ -1,159 +0,0 @@
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
-namespace Mageplaza\Osc\Model\Total\Quote;
-
-use Magento\Checkout\Model\Session;
-use Magento\Quote\Model\Quote;
-use Magento\Quote\Model\Quote\Address;
-use Magento\Quote\Model\Quote\Address\Total;
-use Magento\Quote\Api\Data\ShippingAssignmentInterface;
-use Magento\Quote\Model\Quote\Address\Total\AbstractTotal;
-use Magento\Framework\Pricing\PriceCurrencyInterface;
-use Mageplaza\Osc\Model\System\Config\Source\Giftwrap as SourceGiftwrap;
-use Mageplaza\Osc\Helper\Config as HelperConfig;
-
-/**
- * Class GiftWrap
- * @package Mageplaza\Osc\Model\Total\Quote
- */
-class GiftWrap extends AbstractTotal
-{
-	/**
-	 * @type \Mageplaza\Osc\Helper\Config
-	 */
-	protected $_helperConfig;
-
-	/**
-	 * @type \Magento\Checkout\Model\Session
-	 */
-	protected $_checkoutSession;
-
-	/**
-	 * @type \Magento\Framework\Pricing\PriceCurrencyInterface
-	 */
-	protected $priceCurrency;
-
-	protected $_baseGiftWrapAmount;
-
-	/**
-	 * @param \Magento\Checkout\Model\Session $checkoutSession
-	 * @param \Mageplaza\Osc\Helper\Config $helperConfig
-	 * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
-	 */
-	public function __construct(
-		Session $checkoutSession,
-		HelperConfig $helperConfig,
-		PriceCurrencyInterface $priceCurrency
-	)
-	{
-		$this->_checkoutSession = $checkoutSession;
-		$this->_helperConfig    = $helperConfig;
-		$this->priceCurrency    = $priceCurrency;
-
-		$this->setCode('osc_gift_wrap');
-	}
-
-
-	/**
-	 * Collect gift wrap totals
-	 *
-	 * @param Quote $quote
-	 * @param ShippingAssignmentInterface $shippingAssignment
-	 * @param Total $total
-	 * @return $this
-	 */
-	public function collect(
-		Quote $quote,
-		ShippingAssignmentInterface $shippingAssignment,
-		Total $total
-	)
-	{
-		parent::collect($quote, $shippingAssignment, $total);
-
-		if ($this->_helperConfig->isDisabledGiftWrap() ||
-			($shippingAssignment->getShipping()->getAddress()->getAddressType() !== Address::TYPE_SHIPPING) ||
-			!$quote->getShippingAddress()->getUsedGiftWrap()
-		) {
-			return $this;
-		}
-
-		$baseOscGiftWrapAmount = $this->calculateGiftWrapAmount($quote);
-		$oscGiftWrapAmount     = $this->priceCurrency->convert($baseOscGiftWrapAmount, $quote->getStore());
-
-		$this->_addAmount($oscGiftWrapAmount);
-		$this->_addBaseAmount($baseOscGiftWrapAmount);
-
-		return $this;
-	}
-
-	/**
-	 * Assign gift wrap amount and label to address object
-	 *
-	 * @param \Magento\Quote\Model\Quote $quote
-	 * @param Address\Total $total
-	 * @return array
-	 */
-	public function fetch(Quote $quote, Total $total)
-	{
-		$amount = $total->getOscGiftWrapAmount();
-
-		$baseInitAmount = $this->calculateGiftWrapAmount($quote);
-		$initAmount     = $this->priceCurrency->convert($baseInitAmount, $quote->getStore());
-
-		return [
-			'code'             => $this->getCode(),
-			'title'            => __('Gift Wrap'),
-			'value'            => $amount,
-			'gift_wrap_amount' => $initAmount
-		];
-	}
-
-	public function calculateGiftWrapAmount($quote)
-	{
-		if ($this->_baseGiftWrapAmount == null) {
-			$baseOscGiftWrapAmount = $this->_helperConfig->getOrderGiftwrapAmount();
-			if ($baseOscGiftWrapAmount < 0.0001) {
-				return 0;
-			}
-
-			$giftWrapType = $this->_helperConfig->getGiftWrapType();
-			if ($giftWrapType == SourceGiftwrap::PER_ITEM) {
-				$giftWrapBaseAmount    = $baseOscGiftWrapAmount;
-				$baseOscGiftWrapAmount = 0;
-				foreach ($quote->getAllVisibleItems() as $item) {
-					if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
-						continue;
-					}
-					$baseItemGiftWrapAmount = $giftWrapBaseAmount * $item->getQty();
-					$item->setBaseOscGiftWrapAmount($baseItemGiftWrapAmount);
-					$item->setOscGiftWrapAmount($this->priceCurrency->convert($baseItemGiftWrapAmount, $quote->getStore()));
-
-					$baseOscGiftWrapAmount += $baseItemGiftWrapAmount;
-				}
-			}
-			$quote->getShippingAddress()->setGiftWrapType($giftWrapType);
-
-			$this->_baseGiftWrapAmount = $baseOscGiftWrapAmount;
-		}
-
-		return $this->_baseGiftWrapAmount;
-	}
-}
diff --git a/Observer/CheckoutSubmitBefore.php b/Observer/CheckoutSubmitBefore.php
index 2a0d909..6ba7d26 100644
--- a/Observer/CheckoutSubmitBefore.php
+++ b/Observer/CheckoutSubmitBefore.php
@@ -62,6 +62,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 		\Magento\Customer\Api\AccountManagementInterface $accountManagement
 	)
 	{
+
 		$this->checkoutSession    = $checkoutSession;
 		$this->_objectCopyService = $objectCopyService;
 		$this->dataObjectHelper   = $dataObjectHelper;
@@ -78,13 +79,14 @@ class CheckoutSubmitBefore implements ObserverInterface
 		/** @type \Magento\Quote\Model\Quote $quote */
 		$quote = $observer->getEvent()->getQuote();
 
-		/** Validate address */
-		$this->validateAddressBeforeSubmit($quote);
-
-		/** One step check out additional data */
-		$oscData = $this->checkoutSession->getOscData();
+		/** Remove address validation */
+		if (!$quote->isVirtual()) {
+			$quote->getShippingAddress()->setShouldIgnoreValidation(true);
+		}
+		$quote->getBillingAddress()->setShouldIgnoreValidation(true);
 
 		/** Create account when checkout */
+		$oscData = $this->checkoutSession->getOscData();
 		if (isset($oscData['register']) && $oscData['register']
 			&& isset($oscData['password']) && $oscData['password']
 		) {
@@ -108,12 +110,8 @@ class CheckoutSubmitBefore implements ObserverInterface
 		$billing  = $quote->getBillingAddress();
 		$shipping = $quote->isVirtual() ? null : $quote->getShippingAddress();
 
-		$customer  = $quote->getCustomer();
-		$dataArray = $billing->getData();
-		if (isset($oscData['customerAttributes']) && $oscData['customerAttributes']) {
-			$dataArray = array_merge($dataArray, $oscData['customerAttributes']);
-		}
-
+		$customer            = $quote->getCustomer();
+		$dataArray           = $billing->getData();
 		$this->dataObjectHelper->populateWithArray(
 			$customer,
 			$dataArray,
@@ -122,7 +120,6 @@ class CheckoutSubmitBefore implements ObserverInterface
 
 		$quote->setCustomer($customer);
 
-		/** Init customer address */
 		$customerBillingData = $billing->exportCustomerAddress();
 		$customerBillingData->setIsDefaultBilling(true)
 			->setData('should_ignore_validation', true);
@@ -143,30 +140,14 @@ class CheckoutSubmitBefore implements ObserverInterface
 			$customerBillingData->setIsDefaultShipping(true);
 		}
 		$billing->setCustomerAddressData($customerBillingData);
+		// TODO : Eventually need to remove this legacy hack
 		// Add billing address to quote since customer Data Object does not hold address information
 		$quote->addCustomerAddress($customerBillingData);
 
 		// If customer is created, set customerId for address to avoid create more address when checkout
-		if ($customerId = $quote->getCustomerId()) {
+		if($customerId = $quote->getCustomerId()){
 			$billing->setCustomerId($customerId);
 			$shipping->setCustomerId($customerId);
 		}
 	}
-
-	/**
-	 * @param \Magento\Quote\Model\Quote $quote
-	 * @return $this
-	 */
-	public function validateAddressBeforeSubmit(\Magento\Quote\Model\Quote $quote)
-	{
-		/** Remove address validation */
-		if (!$quote->isVirtual()) {
-			$quote->getShippingAddress()->setShouldIgnoreValidation(true);
-		}
-		$quote->getBillingAddress()->setShouldIgnoreValidation(true);
-
-		// TODO : Validate address (depend on field require, show on osc or not)
-
-		return $this;
-	}
 }
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index e1a47dd..8a8edc6 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -28,51 +28,34 @@ use Magento\Framework\Event\ObserverInterface;
  */
 class QuoteSubmitBefore implements ObserverInterface
 {
-	/**
-	 * @var \Magento\Checkout\Model\Session
-	 */
-	protected $checkoutSession;
-
-	/**
-	 * @param \Magento\Checkout\Model\Session $checkoutSession
-	 * @codeCoverageIgnore
-	 */
-	public function __construct(
-		\Magento\Checkout\Model\Session $checkoutSession
-	)
-	{
-
-		$this->checkoutSession = $checkoutSession;
-	}
-
-	/**
-	 * @param \Magento\Framework\Event\Observer $observer
-	 * @return void
-	 * @SuppressWarnings(PHPMD.UnusedFormalParameter)
-	 */
-	public function execute(\Magento\Framework\Event\Observer $observer)
-	{
-		$order = $observer->getEvent()->getOrder();
-		$quote = $observer->getEvent()->getQuote();
-
-		$oscData = $this->checkoutSession->getOscData();
-		if (isset($oscData['comment'])) {
-			$order->setData('osc_order_comment', $oscData['comment']);
-		}
-
-		$address = $quote->getShippingAddress();
-		if ($address->getUsedGiftWrap() && $address->hasData('osc_gift_wrap_amount')) {
-			$order->setData('gift_wrap_type', $address->getGiftWrapType())
-				->setData('osc_gift_wrap_amount', $address->getOscGiftWrapAmount())
-				->setData('base_osc_gift_wrap_amount', $address->getBaseOscGiftWrapAmount());
-
-			foreach ($order->getItems() as $item) {
-				$quoteItem = $quote->getItemById($item->getQuoteItemId());
-				if ($quoteItem && $quoteItem->hasData('osc_gift_wrap_amount')) {
-					$item->setData('osc_gift_wrap_amount', $quoteItem->getOscGiftWrapAmount())
-						->setData('base_osc_gift_wrap_amount', $quoteItem->getBaseOscGiftWrapAmount());
-				}
-			}
-		}
-	}
+    /**
+     * @var \Magento\Checkout\Model\Session
+     */
+    protected $checkoutSession;
+
+    /**
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @codeCoverageIgnore
+     */
+    public function __construct(
+        \Magento\Checkout\Model\Session $checkoutSession
+    ) {
+    
+        $this->checkoutSession = $checkoutSession;
+    }
+
+    /**
+     * @param \Magento\Framework\Event\Observer $observer
+     * @return void
+     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
+     */
+    public function execute(\Magento\Framework\Event\Observer $observer)
+    {
+        $order = $observer->getEvent()->getOrder();
+
+        $oscData = $this->checkoutSession->getOscData();
+        if (isset($oscData['comment'])) {
+            $order->setData('osc_order_comment', $oscData['comment']);
+        }
+    }
 }
diff --git a/Setup/InstallData.php b/Setup/InstallData.php
deleted file mode 100644
index cd6e673..0000000
--- a/Setup/InstallData.php
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-namespace Mageplaza\Osc\Setup;
-
-use Magento\Framework\Setup\InstallDataInterface;
-use Magento\Framework\Setup\ModuleContextInterface;
-use Magento\Framework\Setup\ModuleDataSetupInterface;
-use Magento\Sales\Setup\SalesSetupFactory;
-
-/**
- * Class InstallData
- * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
- * @codeCoverageIgnore
- */
-class InstallData implements InstallDataInterface
-{
-	/**
-	 * @var SalesSetupFactory
-	 */
-	protected $salesSetupFactory;
-
-	/**
-	 * @param SalesSetupFactory $salesSetupFactory
-	 */
-	public function __construct(SalesSetupFactory $salesSetupFactory)
-	{
-		$this->salesSetupFactory = $salesSetupFactory;
-	}
-
-	/**
-	 * {@inheritdoc}
-	 * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
-	 */
-	public function install(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
-	{
-		/** @var \Magento\Sales\Setup\SalesSetup $salesInstaller */
-		$salesInstaller = $this->salesSetupFactory->create(['resourceName' => 'sales_setup', 'setup' => $setup]);
-
-		$setup->startSetup();
-
-		$salesInstaller->addAttribute('order', 'osc_order_comment', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT]);
-
-		$setup->endSetup();
-	}
-}
diff --git a/Setup/InstallSchema.php b/Setup/InstallSchema.php
new file mode 100644
index 0000000..1c0456b
--- /dev/null
+++ b/Setup/InstallSchema.php
@@ -0,0 +1,51 @@
+<?php
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
+namespace Mageplaza\Osc\Setup;
+
+/**
+ * Class InstallSchema
+ * @package Mageplaza\Osc\Setup
+ */
+class InstallSchema implements \Magento\Framework\Setup\InstallSchemaInterface
+{
+    /**
+     * install tables
+     *
+     * @param \Magento\Framework\Setup\SchemaSetupInterface $setup
+     * @param \Magento\Framework\Setup\ModuleContextInterface $context
+     * @return void
+     * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
+     */
+    public function install(
+        \Magento\Framework\Setup\SchemaSetupInterface $setup,
+        \Magento\Framework\Setup\ModuleContextInterface $context
+    ) {
+    
+        $installer = $setup;
+        $installer->startSetup();
+        $setup->getConnection()->addColumn(
+            $setup->getTable('sales_order'),
+            'osc_order_comment',
+            'text NULL'
+        );
+        $installer->endSetup();
+    }
+}
diff --git a/Setup/UpgradeData.php b/Setup/UpgradeData.php
deleted file mode 100644
index aa648fa..0000000
--- a/Setup/UpgradeData.php
+++ /dev/null
@@ -1,90 +0,0 @@
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
-namespace Mageplaza\Osc\Setup;
-
-use Magento\Framework\Setup\ModuleContextInterface;
-use Magento\Framework\Setup\ModuleDataSetupInterface;
-use Magento\Framework\Setup\UpgradeDataInterface;
-use Magento\Quote\Setup\QuoteSetupFactory;
-use Magento\Sales\Setup\SalesSetupFactory;
-
-/**
- * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
- * @codeCoverageIgnore
- */
-class UpgradeData implements UpgradeDataInterface
-{
-	/**
-	 * @var QuoteSetupFactory
-	 */
-	protected $quoteSetupFactory;
-
-	/**
-	 * @var SalesSetupFactory
-	 */
-	protected $salesSetupFactory;
-
-	/**
-	 * @param QuoteSetupFactory $quoteSetupFactory
-	 * @param SalesSetupFactory $salesSetupFactory
-	 */
-	public function __construct(
-		QuoteSetupFactory $quoteSetupFactory,
-		SalesSetupFactory $salesSetupFactory
-	)
-	{
-		$this->quoteSetupFactory = $quoteSetupFactory;
-		$this->salesSetupFactory = $salesSetupFactory;
-	}
-
-	/**
-	 * {@inheritdoc}
-	 */
-	public function upgrade(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
-	{
-		/** @var \Magento\Quote\Setup\QuoteSetup $quoteInstaller */
-		$quoteInstaller = $this->quoteSetupFactory->create(['resourceName' => 'quote_setup', 'setup' => $setup]);
-
-		/** @var \Magento\Sales\Setup\SalesSetup $salesInstaller */
-		$salesInstaller = $this->salesSetupFactory->create(['resourceName' => 'sales_setup', 'setup' => $setup]);
-
-		$setup->startSetup();
-		if (version_compare($context->getVersion(), '2.1.0') < 0) {
-			$entityAttributesCodes = [
-				'osc_gift_wrap_amount'      => \Magento\Framework\DB\Ddl\Table::TYPE_DECIMAL,
-				'base_osc_gift_wrap_amount' => \Magento\Framework\DB\Ddl\Table::TYPE_DECIMAL
-			];
-			foreach ($entityAttributesCodes as $code => $type) {
-				$quoteInstaller->addAttribute('quote_address', $code, ['type' => $type, 'visible' => false]);
-				$quoteInstaller->addAttribute('quote_item', $code, ['type' => $type, 'visible' => false]);
-				$salesInstaller->addAttribute('order', $code, ['type' => $type, 'visible' => false]);
-				$salesInstaller->addAttribute('order_item', $code, ['type' => $type, 'visible' => false]);
-				$salesInstaller->addAttribute('invoice', $code, ['type' => $type, 'visible' => false]);
-				$salesInstaller->addAttribute('creditmemo', $code, ['type' => $type, 'visible' => false]);
-			}
-
-			$quoteInstaller->addAttribute('quote_address', 'used_gift_wrap', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_BOOLEAN, 'visible' => false]);
-			$quoteInstaller->addAttribute('quote_address', 'gift_wrap_type', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT, 'visible' => false]);
-			$salesInstaller->addAttribute('order', 'gift_wrap_type', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT, 'visible' => false]);
-		}
-		$setup->endSetup();
-	}
-}
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index 8fde81f..c0b0cd2 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -1,29 +1,7 @@
 <?xml version="1.0"?>
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
     <menu>
         <add id="Mageplaza_Osc::osc" resource="Mageplaza_Osc::osc" module="Mageplaza_Osc" title="One Step Checkout" sortOrder="10" parent="Mageplaza_Core::menu"/>
-        <add id="Mageplaza_Osc::field_management" title="Field Management" module="Mageplaza_Osc" sortOrder="50" action="onestepcheckout/field/position" resource="Mageplaza_Osc::field_management" parent="Mageplaza_Osc::osc"/>
-        <add id="Mageplaza_Osc::configuration" title="Configuration" module="Mageplaza_Osc" sortOrder="1000" action="adminhtml/system_config/edit/section/osc" resource="Mageplaza_Osc::configuration" parent="Mageplaza_Osc::osc"/>
+        <add id="Mageplaza_Osc::configuration" title="Configuration" module="Mageplaza_Osc" sortOrder="10" action="adminhtml/system_config/edit/section/osc" resource="Mageplaza_Osc::configuration" parent="Mageplaza_Osc::osc"/>
     </menu>
 </config>
\ No newline at end of file
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 0702fc8..6d84bbe 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -41,12 +41,12 @@
                 </field>
                 <field id="default_shipping_method" translate="label comment" sortOrder="70" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Default Shipping Method</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\ShippingMethods</source_model>
+                    <source_model>Mageplaza\Osc\Model\System\Config\Source\Shipping\Methods</source_model>
                     <comment>Set default shipping method in the checkout process.</comment>
                 </field>
                 <field id="default_payment_method" translate="label comment" sortOrder="80" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Default Payment Method</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\PaymentMethods</source_model>
+                    <source_model>Mageplaza\Osc\Model\System\Config\Source\Payment\Methods</source_model>
                     <comment>Set default payment method in the checkout process.</comment>
                 </field>
                 <field id="allow_guest_checkout" translate="label comment" sortOrder="90" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
@@ -61,7 +61,7 @@
                 </field>
                 <field id="auto_detect_address" sortOrder="101" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Use Auto Suggestion Technology</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\AddressSuggest</source_model>
+                    <source_model>Mageplaza\Osc\Model\System\Config\Source\Address\Suggest</source_model>
                     <comment>When customer fills address fields, it will suggest a list of full addresses.</comment>
                 </field>
                 <field id="google_api_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
@@ -117,41 +117,23 @@
                         <field id="is_enabled_review_cart_section">1</field>
                     </depends>
                 </field>
-                <field id="show_coupon" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Show Discount Code Section</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
-                </field>
-                <field id="is_enabled_gift_wrap" translate="label comment" sortOrder="20" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Enable Gift Wrap</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="gift_wrap_type" translate="label comment" sortOrder="21" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Calculate Method</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\Giftwrap</source_model>
-                    <comment>To calculate gift wrap fee based on item or order.</comment>
-                    <depends>
-                        <field id="is_enabled_gift_wrap">1</field>
-                    </depends>
-                </field>
-                <field id="gift_wrap_amount" translate="label comment" sortOrder="22" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Amount</label>
-                    <comment>Enter the amount of gift wrap fee.</comment>
-                    <depends>
-                        <field id="is_enabled_gift_wrap">1</field>
-                    </depends>
+                <field id="is_enabled_coupon" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                    <label>Discount Code Section</label>
+                    <source_model>Mageplaza\Osc\Model\System\Config\Source\Enableddisabled</source_model>
+                    <comment>Show Discount Code box in Checkout page.</comment>
                 </field>
                 <field id="is_enabled_comments" translate="label comment" sortOrder="30" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Show Order Comment</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                    <label>Order Comment</label>
+                    <source_model>Mageplaza\Osc\Model\System\Config\Source\Enableddisabled</source_model>
                     <comment>Allow customer comment in order.</comment>
                 </field>
-                <field id="show_toc" translate="label comment" sortOrder="40" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Show Terms and Conditions</label>
-                    <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
+                <field id="is_enabled_toc" translate="label comment" sortOrder="40" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                    <label>Enable Terms and Conditions</label>
+                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
                 <field id="is_enabled_newsletter" translate="label comment" sortOrder="60" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Show Newsletter Checkbox</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                    <label>Newsletter Checkbox</label>
+                    <source_model>Mageplaza\Osc\Model\System\Config\Source\Enableddisabled</source_model>
                     <comment>Show Sign up newsletter selection</comment>
                 </field>
                 <field id="is_checked_newsletter" translate="label comment" sortOrder="61" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
diff --git a/etc/config.xml b/etc/config.xml
index d81bd7c..0c93d0c 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -36,11 +36,10 @@
                 <is_enabled_login_link>1</is_enabled_login_link>
                 <is_enabled_review_cart_section>1</is_enabled_review_cart_section>
                 <is_show_product_image>1</is_show_product_image>
-                <show_coupon>1</show_coupon>
+                <is_enabled_coupon>1</is_enabled_coupon>
                 <is_enabled_comments>1</is_enabled_comments>
-                <show_toc>2</show_toc>
+                <is_enabled_toc>1</is_enabled_toc>
                 <is_enabled_newsletter>1</is_enabled_newsletter>
-                <is_enabled_gift_wrap>0</is_enabled_gift_wrap>
             </display_configuration>
             <design_configuration>
                 <page_layout>3columns-colspan</page_layout>
@@ -49,9 +48,6 @@
                 <heading_text>#FFFFFF</heading_text>
                 <place_order_button>#1979c3</place_order_button>
             </design_configuration>
-            <field>
-                <position>[{"code":"firstname","colspan":6},{"code":"lastname","colspan":6},{"code":"street","colspan":12},{"code":"country_id","colspan":6},{"code":"city","colspan":6},{"code":"postcode","colspan":6},{"code":"region_id","colspan":6},{"code":"company","colspan":6},{"code":"telephone","colspan":6}]</position>
-            </field>
         </osc>
     </default>
 </config>
\ No newline at end of file
diff --git a/etc/di.xml b/etc/di.xml
index 217d8df..2db66d6 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -23,12 +23,4 @@
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <preference for="Mageplaza\Osc\Api\CheckoutManagementInterface" type="Mageplaza\Osc\Model\CheckoutManagement" />
     <preference for="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" type="Mageplaza\Osc\Model\GuestCheckoutManagement" />
-
-    <type name="Magento\Customer\Model\Address">
-        <plugin name="setShouldIgnoreValidation" type="Mageplaza\Osc\Model\Plugin\Customer\Address"/>
-    </type>
-
-    <type name="Magento\Quote\Model\Cart\TotalsConverter">
-        <plugin name="addGiftWrapInitialAmount" type="Mageplaza\Osc\Model\Plugin\Quote\GiftWrap"/>
-    </type>
 </config>
diff --git a/etc/events.xml b/etc/events.xml
index 09acf84..fa7af09 100644
--- a/etc/events.xml
+++ b/etc/events.xml
@@ -24,10 +24,10 @@
     <event name="sales_model_service_quote_submit_before">
         <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\QuoteSubmitBefore" />
     </event>
-    <event name="checkout_submit_before">
-        <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\CheckoutSubmitBefore" />
-    </event>
     <event name="sales_model_service_quote_submit_success">
         <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\QuoteSubmitSuccess" />
     </event>
+    <event name="checkout_submit_before">
+        <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\CheckoutSubmitBefore" />
+    </event>
 </config>
diff --git a/etc/extension_attributes.xml b/etc/extension_attributes.xml
deleted file mode 100644
index f0c2ae9..0000000
--- a/etc/extension_attributes.xml
+++ /dev/null
@@ -1,29 +0,0 @@
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
-
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-        xsi:noNamespaceSchemaLocation="urn:magento:framework:Api/etc/extension_attributes.xsd">
-    <extension_attributes for="Magento\Quote\Api\Data\TotalSegmentInterface">
-        <attribute code="gift_wrap_amount" type="float"/>
-    </extension_attributes>
-</config>
diff --git a/view/frontend/web/template/container/summary/gift-wrap.html b/etc/frontend/page_types.xml
similarity index 67%
rename from view/frontend/web/template/container/summary/gift-wrap.html
rename to etc/frontend/page_types.xml
index 1dc2f4b..dc0f906 100644
--- a/view/frontend/web/template/container/summary/gift-wrap.html
+++ b/etc/frontend/page_types.xml
@@ -1,3 +1,4 @@
+<?xml version="1.0"?>
 <!--
 /**
  * Mageplaza
@@ -19,13 +20,6 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
-<!-- ko if: isDisplay() -->
-<tr class="gift-wrap">
-    <th data-bind="i18n: title" class="mark" scope="row"></th>
-    <td class="amount">
-        <span class="price" data-bind="text: getValue(), attr: {'data-th': title}"></span>
-    </td>
-</tr>
-<!-- /ko -->
-
+<page_types xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_types.xsd">
+    <type id="onestepcheckout_index_index" label="One Step Checkout"/>
+</page_types>
diff --git a/etc/module.xml b/etc/module.xml
index 70325fb..252f0db 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -21,11 +21,10 @@
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
-    <module name="Mageplaza_Osc" setup_version="2.1.0"/>
+    <module name="Mageplaza_Osc" setup_version="2.0.0"/>
     <sequence>
         <module name="Mageplaza_Core"/>
         <module name="Magento_Checkout"/>
-        <module name="Magento_Customer"/>
         <module name="Magento_Sales"/>
         <module name="Magento_Catalog"/>
     </sequence>
diff --git a/etc/sales.xml b/etc/sales.xml
deleted file mode 100644
index 77c5ecb..0000000
--- a/etc/sales.xml
+++ /dev/null
@@ -1,39 +0,0 @@
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
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Sales:etc/sales.xsd">
-    <section name="quote">
-        <group name="totals">
-            <item name="osc_gift_wrap" instance="Mageplaza\Osc\Model\Total\Quote\GiftWrap" sort_order="500"/>
-        </group>
-    </section>
-    <section name="order_invoice">
-        <group name="totals">
-            <item name="osc_gift_wrap" instance="Mageplaza\Osc\Model\Total\Invoice\GiftWrap" sort_order="500"/>
-        </group>
-    </section>
-    <section name="order_creditmemo">
-        <group name="totals">
-            <item name="osc_gift_wrap" instance="Mageplaza\Osc\Model\Total\Creditmemo\GiftWrap" sort_order="500"/>
-        </group>
-    </section>
-</config>
diff --git a/etc/webapi.xml b/etc/webapi.xml
index e64bde0..7e737f2 100644
--- a/etc/webapi.xml
+++ b/etc/webapi.xml
@@ -37,6 +37,7 @@
             <parameter name="cartId" force="true">%cart_id%</parameter>
         </data>
     </route>
+
     <route url="/V1/guest-carts/:cartId/remove-item" method="POST">
         <service class="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" method="removeItemById"/>
         <resources>
@@ -52,21 +53,7 @@
             <parameter name="cartId" force="true">%cart_id%</parameter>
         </data>
     </route>
-    <route url="/V1/guest-carts/:cartId/update-gift-wrap" method="POST">
-        <service class="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" method="updateGiftWrap"/>
-        <resources>
-            <resource ref="anonymous"/>
-        </resources>
-    </route>
-    <route url="/V1/carts/mine/update-gift-wrap" method="POST">
-        <service class="Mageplaza\Osc\Api\CheckoutManagementInterface" method="updateGiftWrap"/>
-        <resources>
-            <resource ref="self"/>
-        </resources>
-        <data>
-            <parameter name="cartId" force="true">%cart_id%</parameter>
-        </data>
-    </route>
+
     <route url="/V1/guest-carts/:cartId/payment-total-information" method="POST">
         <service class="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" method="getPaymentTotalInformation"/>
         <resources>
@@ -82,6 +69,7 @@
             <parameter name="cartId" force="true">%cart_id%</parameter>
         </data>
     </route>
+
     <route url="/V1/guest-carts/:cartId/checkout-information" method="POST">
         <service class="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" method="saveCheckoutInformation"/>
         <resources>
diff --git a/etc/webapi_rest/di.xml b/etc/webapi_rest/di.xml
index 5afe245..9c28aee 100644
--- a/etc/webapi_rest/di.xml
+++ b/etc/webapi_rest/di.xml
@@ -23,6 +23,6 @@
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <!-- Save address when estimate shipping method -->
     <type name="Magento\Quote\Model\ShippingMethodManagement">
-        <plugin name="saveAddressWhenEstimate" type="Mageplaza\Osc\Model\Plugin\Checkout\ShippingMethodManagement"/>
+        <plugin name="saveAddressWhenEstimate" type="Mageplaza\Osc\Model\Plugin\ShippingMethodManagement"/>
     </type>
 </config>
\ No newline at end of file
diff --git a/view/adminhtml/layout/onestepcheckout_field_position.xml b/view/adminhtml/layout/onestepcheckout_field_position.xml
deleted file mode 100644
index b8e8227..0000000
--- a/view/adminhtml/layout/onestepcheckout_field_position.xml
+++ /dev/null
@@ -1,33 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-1column" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <head>
-        <css src="Mageplaza_Osc::css/style.css"/>
-        <css src="Mageplaza_Osc::css/jquery-ui.min.css"/>
-    </head>
-    <body>
-        <referenceContainer name="content">
-            <block class="\Mageplaza\Osc\Block\Adminhtml\Field\Position" name="onestepcheckout.adminhtml.field.position" template="field/position.phtml" />
-        </referenceContainer>
-    </body>
-</page>
diff --git a/view/adminhtml/layout/sales_order_creditmemo_new.xml b/view/adminhtml/layout/sales_order_creditmemo_new.xml
deleted file mode 100644
index 2b98016..0000000
--- a/view/adminhtml/layout/sales_order_creditmemo_new.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="creditmemo_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml b/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
deleted file mode 100644
index 2b98016..0000000
--- a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="creditmemo_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_creditmemo_view.xml b/view/adminhtml/layout/sales_order_creditmemo_view.xml
deleted file mode 100644
index 2b98016..0000000
--- a/view/adminhtml/layout/sales_order_creditmemo_view.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="creditmemo_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_invoice_email.xml b/view/adminhtml/layout/sales_order_invoice_email.xml
deleted file mode 100644
index 20ba0df..0000000
--- a/view/adminhtml/layout/sales_order_invoice_email.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_invoice_new.xml b/view/adminhtml/layout/sales_order_invoice_new.xml
deleted file mode 100644
index 20ba0df..0000000
--- a/view/adminhtml/layout/sales_order_invoice_new.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_invoice_print.xml b/view/adminhtml/layout/sales_order_invoice_print.xml
deleted file mode 100644
index 20ba0df..0000000
--- a/view/adminhtml/layout/sales_order_invoice_print.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_invoice_updateqty.xml b/view/adminhtml/layout/sales_order_invoice_updateqty.xml
deleted file mode 100644
index 20ba0df..0000000
--- a/view/adminhtml/layout/sales_order_invoice_updateqty.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_invoice_view.xml b/view/adminhtml/layout/sales_order_invoice_view.xml
deleted file mode 100644
index 20ba0df..0000000
--- a/view/adminhtml/layout/sales_order_invoice_view.xml
+++ /dev/null
@@ -1,30 +0,0 @@
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
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/adminhtml/layout/sales_order_view.xml b/view/adminhtml/layout/sales_order_view.xml
index 40c252d..72ac5e8 100644
--- a/view/adminhtml/layout/sales_order_view.xml
+++ b/view/adminhtml/layout/sales_order_view.xml
@@ -20,18 +20,12 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-2columns-left"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-2columns-left" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="order_tab_info">
-            <block class="Magento\Backend\Block\Template" name="osc_additional_content"
-                   template="Mageplaza_Osc::order/additional.phtml">
-                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="order_comment"
-                       template="order/view/comment.phtml"/>
+            <block class="Magento\Backend\Block\Template" name="osc_additional_content" template="Mageplaza_Osc::order/additional.phtml">
+                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="order_comment" template="order/view/comment.phtml"/>
             </block>
         </referenceBlock>
-        <referenceBlock name="order_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
     </body>
 </page>
diff --git a/view/adminhtml/templates/field/position.phtml b/view/adminhtml/templates/field/position.phtml
deleted file mode 100644
index 1ae2cd8..0000000
--- a/view/adminhtml/templates/field/position.phtml
+++ /dev/null
@@ -1,172 +0,0 @@
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
-<?php
-$_sortedFields    = $block->getSortedFields();
-$_availableFields = $block->getAvailableFields();
-$_helper          = $block->getHelperData();
-?>
-<div class="field-postion-content" id="field-position-sortable">
-	<div id="position-save-messages">
-		<div class="messages">
-			<div class="message message-success success position-save-messages" style="display: none">
-				<div data-ui-id="messages-message-success" id="position-save-messages-success"></div>
-			</div>
-			<div class="message message-error error position-save-messages" style="display: none">
-				<div data-ui-id="messages-message-error" id="position-save-messages-error"></div>
-			</div>
-		</div>
-	</div>
-	<div id="containment">
-		<div class="column left">
-			<div class="field-wrapper available-wrapper">
-				<div class="field-title available">
-					<h2><?php echo __('AVAILABLE FIELDS') ?></h2>
-				</div>
-				<div class="field field-available">
-					<ul class="sortable-list ui-sortable">
-						<?php foreach ($_availableFields as $field): ?>
-							<li class="sortable-item" id="<?php echo $field->getId() ?>" code="<?php echo $field->getAttributeCode() ?>">
-								<div class="attribute-label">
-									<?php echo $field->getFrontendLabel() ?>
-								</div>
-							</li>
-						<?php endforeach; ?>
-					</ul>
-				</div>
-			</div>
-		</div>
-		<div class="column right">
-			<div class="field-wrapper sorted-wrapper">
-				<div class="field-title sorted-title">
-					<h2><?php echo __('SORTED FIELDS') ?></h2>
-				</div>
-				<div class="field field-sorted">
-					<ul class="sortable-list ui-sortable">
-						<?php foreach ($_sortedFields as $field): ?>
-							<li class="sortable-item <?php echo $field->getColspan() == 12 ? 'wide' : '' ?>"
-								id="<?php echo $field->getId() ?>"
-								code="<?php echo $field->getAttributeCode() ?>">
-								<div class="attribute-label">
-									<?php echo $field->getFrontendLabel() ?>
-								</div>
-							</li>
-						<?php endforeach; ?>
-					</ul>
-				</div>
-			</div>
-		</div>
-		<div class="clearer">&nbsp;</div>
-	</div>
-</div>
-<script>
-	require(['jquery', 'prototype', 'jquery/ui'], function ($j) {
-		//<![CDATA[
-		$j(function () {
-			$j("#field-position-sortable .sortable-list").sortable({
-				connectWith: '#field-position-sortable .sortable-list',
-				containment: '#containment',
-				placeholder: "suggest-position",
-				start: function (e, hash) {
-					if (hash.item.hasClass('wide')) {
-						hash.placeholder.addClass('wide');
-					}
-				}
-			});
-
-			$j("#field-position-sortable .sortable-list").disableSelection();
-			$j("#field-position-sortable .sortable-list .sortable-item").addClass('left');
-
-			/*Resize able*/
-			$j("#containment ul li .attribute-label").resizable({
-				maxHeight: 40,
-				minHeight: 40,
-				helper: "ui-resizable-border",
-				stop: function (e, ui) {
-					var field = ui.element.parent();
-					(ui.element.width() * 2 > field.width()) ?
-						field.addClass('wide') :
-						field.removeClass('wide');
-
-					ui.element.css({width: ''});
-				}
-			});
-		});
-
-		function savePosition() {
-			var fields = [];
-
-			$j('.right .sortable-item').each(function (index, el) {
-				fields.push({
-					code: $j(el).attr('code'),
-					colspan: $j(el).hasClass('wide') ? 12 : 6
-				});
-			});
-
-			updateMessage(false);
-
-			new Ajax.Request('<?php /* @escapeNotVerified */ echo $block->getAjaxUrl() ?>', {
-				parameters: {
-					fields: JSON.stringify(fields)
-				},
-				onSuccess: function (response) {
-					var message = '<?php /* @escapeNotVerified */ echo __('Error during save field position.') ?>',
-						success = false;
-					try {
-						if (response.responseText.isJSON()) {
-							response = response.responseText.evalJSON();
-							message = response.message;
-							success = response.success;
-						}
-					} catch (e) {
-						success = false;
-					}
-
-					updateMessage(true, success, message);
-				}
-			});
-		}
-
-		function updateMessage(show, success, message) {
-			var resultMessage = 'position-save-messages',
-				messageType = (typeof success !== 'undefined' && success) ? 'success' : 'error';
-
-			if (!show) {
-				$j('.' + resultMessage).hide();
-				return;
-			}
-
-			var messageElement = $j('#' + resultMessage + '-' + messageType);
-			messageElement.html(message);
-			messageElement.parent().show();
-		}
-
-		window.saveOscPosition = savePosition;
-		//]]>
-	});
-</script>
-
-<?php $design = $this->getHelperData()->getConfig()->getDesignConfig(); ?>
-<style type="text/css">
-	.field-title {
-		background-color: <?php echo (isset($design['heading_background']) && $design['heading_background']) ? $design['heading_background'] : '#FF7800' ?>;
-	}
-</style>
\ No newline at end of file
diff --git a/view/adminhtml/web/css/images/billing_title.png b/view/adminhtml/web/css/images/billing_title.png
deleted file mode 100644
index 99538ef..0000000
Binary files a/view/adminhtml/web/css/images/billing_title.png and /dev/null differ
diff --git a/view/adminhtml/web/css/images/next.png b/view/adminhtml/web/css/images/next.png
deleted file mode 100644
index 2e67367..0000000
Binary files a/view/adminhtml/web/css/images/next.png and /dev/null differ
diff --git a/view/adminhtml/web/css/images/ui-icons_222222_256x240.png b/view/adminhtml/web/css/images/ui-icons_222222_256x240.png
deleted file mode 100644
index c1cb117..0000000
Binary files a/view/adminhtml/web/css/images/ui-icons_222222_256x240.png and /dev/null differ
diff --git a/view/adminhtml/web/css/jquery-ui.min.css b/view/adminhtml/web/css/jquery-ui.min.css
deleted file mode 100644
index 6bfb2a8..0000000
--- a/view/adminhtml/web/css/jquery-ui.min.css
+++ /dev/null
@@ -1,7 +0,0 @@
-/*! jQuery UI - v1.11.1 - 2014-09-25
-* http://jqueryui.com
-* Includes: core.css, draggable.css, resizable.css, selectable.css, sortable.css, accordion.css, autocomplete.css, button.css, datepicker.css, dialog.css, menu.css, progressbar.css, selectmenu.css, slider.css, spinner.css, tabs.css, tooltip.css, theme.css
-* To view and modify this theme, visit http://jqueryui.com/themeroller/?ffDefault=Trebuchet%20MS%2CTahoma%2CVerdana%2CArial%2Csans-serif&fwDefault=bold&fsDefault=1.1em&cornerRadius=4px&bgColorHeader=f6a828&bgTextureHeader=gloss_wave&bgImgOpacityHeader=35&borderColorHeader=e78f08&fcHeader=ffffff&iconColorHeader=ffffff&bgColorContent=eeeeee&bgTextureContent=highlight_soft&bgImgOpacityContent=100&borderColorContent=dddddd&fcContent=333333&iconColorContent=222222&bgColorDefault=f6f6f6&bgTextureDefault=glass&bgImgOpacityDefault=100&borderColorDefault=cccccc&fcDefault=1c94c4&iconColorDefault=ef8c08&bgColorHover=fdf5ce&bgTextureHover=glass&bgImgOpacityHover=100&borderColorHover=fbcb09&fcHover=c77405&iconColorHover=ef8c08&bgColorActive=ffffff&bgTextureActive=glass&bgImgOpacityActive=65&borderColorActive=fbd850&fcActive=eb8f00&iconColorActive=ef8c08&bgColorHighlight=ffe45c&bgTextureHighlight=highlight_soft&bgImgOpacityHighlight=75&borderColorHighlight=fed22f&fcHighlight=363636&iconColorHighlight=228ef1&bgColorError=b81900&bgTextureError=diagonals_thick&bgImgOpacityError=18&borderColorError=cd0a0a&fcError=ffffff&iconColorError=ffd27a&bgColorOverlay=666666&bgTextureOverlay=diagonals_thick&bgImgOpacityOverlay=20&opacityOverlay=50&bgColorShadow=000000&bgTextureShadow=flat&bgImgOpacityShadow=10&opacityShadow=20&thicknessShadow=5px&offsetTopShadow=-5px&offsetLeftShadow=-5px&cornerRadiusShadow=5px
-* Copyright 2014 jQuery Foundation and other contributors; Licensed MIT */
-
-.ui-helper-hidden{display:none}.ui-helper-hidden-accessible{border:0;clip:rect(0 0 0 0);height:1px;margin:-1px;overflow:hidden;padding:0;position:absolute;width:1px}.ui-helper-reset{margin:0;padding:0;border:0;outline:0;line-height:1.3;text-decoration:none;font-size:100%;list-style:none}.ui-helper-clearfix:before,.ui-helper-clearfix:after{content:"";display:table;border-collapse:collapse}.ui-helper-clearfix:after{clear:both}.ui-helper-clearfix{min-height:0}.ui-helper-zfix{width:100%;height:100%;top:0;left:0;position:absolute;opacity:0;filter:Alpha(Opacity=0)}.ui-front{z-index:100}.ui-state-disabled{cursor:default!important}.ui-icon{display:block;text-indent:-99999px;overflow:hidden;background-repeat:no-repeat}.ui-widget-overlay{position:fixed;top:0;left:0;width:100%;height:100%}.ui-draggable-handle{-ms-touch-action:none;touch-action:none}.ui-resizable{position:relative}.ui-resizable-handle{position:absolute;font-size:0.1px;display:block;-ms-touch-action:none;touch-action:none}.ui-resizable-disabled .ui-resizable-handle,.ui-resizable-autohide .ui-resizable-handle{display:none}.ui-resizable-n{cursor:n-resize;height:7px;width:100%;top:-5px;left:0}.ui-resizable-s{cursor:s-resize;height:7px;width:100%;bottom:-5px;left:0}.ui-resizable-e{cursor:e-resize;width:7px;right:-5px;top:0;height:100%}.ui-resizable-w{cursor:w-resize;width:7px;left:-5px;top:0;height:100%}.ui-resizable-se{cursor:se-resize;width:12px;height:12px;right:1px;bottom:1px}.ui-resizable-sw{cursor:sw-resize;width:9px;height:9px;left:-5px;bottom:-5px}.ui-resizable-nw{cursor:nw-resize;width:9px;height:9px;left:-5px;top:-5px}.ui-resizable-ne{cursor:ne-resize;width:9px;height:9px;right:-5px;top:-5px}.ui-selectable{-ms-touch-action:none;touch-action:none}.ui-selectable-helper{position:absolute;z-index:100;border:1px dotted black}.ui-sortable-handle{-ms-touch-action:none;touch-action:none}.ui-accordion .ui-accordion-header{display:block;cursor:pointer;position:relative;margin:2px 0 0 0;padding:.5em .5em .5em .7em;min-height:0;font-size:100%}.ui-accordion .ui-accordion-icons{padding-left:2.2em}.ui-accordion .ui-accordion-icons .ui-accordion-icons{padding-left:2.2em}.ui-accordion .ui-accordion-header .ui-accordion-header-icon{position:absolute;left:.5em;top:50%;margin-top:-8px}.ui-accordion .ui-accordion-content{padding:1em 2.2em;border-top:0;overflow:auto}.ui-autocomplete{position:absolute;top:0;left:0;cursor:default}.ui-button{display:inline-block;position:relative;padding:0;line-height:normal;margin-right:.1em;cursor:pointer;vertical-align:middle;text-align:center;overflow:visible}.ui-button,.ui-button:link,.ui-button:visited,.ui-button:hover,.ui-button:active{text-decoration:none}.ui-button-icon-only{width:2.2em}button.ui-button-icon-only{width:2.4em}.ui-button-icons-only{width:3.4em}button.ui-button-icons-only{width:3.7em}.ui-button .ui-button-text{display:block;line-height:normal}.ui-button-text-only .ui-button-text{padding:.4em 1em}.ui-button-icon-only .ui-button-text,.ui-button-icons-only .ui-button-text{padding:.4em;text-indent:-9999999px}.ui-button-text-icon-primary .ui-button-text,.ui-button-text-icons .ui-button-text{padding:.4em 1em .4em 2.1em}.ui-button-text-icon-secondary .ui-button-text,.ui-button-text-icons .ui-button-text{padding:.4em 2.1em .4em 1em}.ui-button-text-icons .ui-button-text{padding-left:2.1em;padding-right:2.1em}input.ui-button{padding:.4em 1em}.ui-button-icon-only .ui-icon,.ui-button-text-icon-primary .ui-icon,.ui-button-text-icon-secondary .ui-icon,.ui-button-text-icons .ui-icon,.ui-button-icons-only .ui-icon{position:absolute;top:50%;margin-top:-8px}.ui-button-icon-only .ui-icon{left:50%;margin-left:-8px}.ui-button-text-icon-primary .ui-button-icon-primary,.ui-button-text-icons .ui-button-icon-primary,.ui-button-icons-only .ui-button-icon-primary{left:.5em}.ui-button-text-icon-secondary .ui-button-icon-secondary,.ui-button-text-icons .ui-button-icon-secondary,.ui-button-icons-only .ui-button-icon-secondary{right:.5em}.ui-buttonset{margin-right:7px}.ui-buttonset .ui-button{margin-left:0;margin-right:-.3em}input.ui-button::-moz-focus-inner,button.ui-button::-moz-focus-inner{border:0;padding:0}.ui-datepicker{width:17em;padding:.2em .2em 0;display:none}.ui-datepicker .ui-datepicker-header{position:relative;padding:.2em 0}.ui-datepicker .ui-datepicker-prev,.ui-datepicker .ui-datepicker-next{position:absolute;top:2px;width:1.8em;height:1.8em}.ui-datepicker .ui-datepicker-prev-hover,.ui-datepicker .ui-datepicker-next-hover{top:1px}.ui-datepicker .ui-datepicker-prev{left:2px}.ui-datepicker .ui-datepicker-next{right:2px}.ui-datepicker .ui-datepicker-prev-hover{left:1px}.ui-datepicker .ui-datepicker-next-hover{right:1px}.ui-datepicker .ui-datepicker-prev span,.ui-datepicker .ui-datepicker-next span{display:block;position:absolute;left:50%;margin-left:-8px;top:50%;margin-top:-8px}.ui-datepicker .ui-datepicker-title{margin:0 2.3em;line-height:1.8em;text-align:center}.ui-datepicker .ui-datepicker-title select{font-size:1em;margin:1px 0}.ui-datepicker select.ui-datepicker-month,.ui-datepicker select.ui-datepicker-year{width:45%}.ui-datepicker table{width:100%;font-size:.9em;border-collapse:collapse;margin:0 0 .4em}.ui-datepicker th{padding:.7em .3em;text-align:center;font-weight:bold;border:0}.ui-datepicker td{border:0;padding:1px}.ui-datepicker td span,.ui-datepicker td a{display:block;padding:.2em;text-align:right;text-decoration:none}.ui-datepicker .ui-datepicker-buttonpane{background-image:none;margin:.7em 0 0 0;padding:0 .2em;border-left:0;border-right:0;border-bottom:0}.ui-datepicker .ui-datepicker-buttonpane button{float:right;margin:.5em .2em .4em;cursor:pointer;padding:.2em .6em .3em .6em;width:auto;overflow:visible}.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current{float:left}.ui-datepicker.ui-datepicker-multi{width:auto}.ui-datepicker-multi .ui-datepicker-group{float:left}.ui-datepicker-multi .ui-datepicker-group table{width:95%;margin:0 auto .4em}.ui-datepicker-multi-2 .ui-datepicker-group{width:50%}.ui-datepicker-multi-3 .ui-datepicker-group{width:33.3%}.ui-datepicker-multi-4 .ui-datepicker-group{width:25%}.ui-datepicker-multi .ui-datepicker-group-last .ui-datepicker-header,.ui-datepicker-multi .ui-datepicker-group-middle .ui-datepicker-header{border-left-width:0}.ui-datepicker-multi .ui-datepicker-buttonpane{clear:left}.ui-datepicker-row-break{clear:both;width:100%;font-size:0}.ui-datepicker-rtl{direction:rtl}.ui-datepicker-rtl .ui-datepicker-prev{right:2px;left:auto}.ui-datepicker-rtl .ui-datepicker-next{left:2px;right:auto}.ui-datepicker-rtl .ui-datepicker-prev:hover{right:1px;left:auto}.ui-datepicker-rtl .ui-datepicker-next:hover{left:1px;right:auto}.ui-datepicker-rtl .ui-datepicker-buttonpane{clear:right}.ui-datepicker-rtl .ui-datepicker-buttonpane button{float:left}.ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current,.ui-datepicker-rtl .ui-datepicker-group{float:right}.ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header,.ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header{border-right-width:0;border-left-width:1px}.ui-dialog{overflow:hidden;position:absolute;top:0;left:0;padding:.2em;outline:0}.ui-dialog .ui-dialog-titlebar{padding:.4em 1em;position:relative}.ui-dialog .ui-dialog-title{float:left;margin:.1em 0;white-space:nowrap;width:90%;overflow:hidden;text-overflow:ellipsis}.ui-dialog .ui-dialog-titlebar-close{position:absolute;right:.3em;top:50%;width:20px;margin:-10px 0 0 0;padding:1px;height:20px}.ui-dialog .ui-dialog-content{position:relative;border:0;padding:.5em 1em;background:none;overflow:auto}.ui-dialog .ui-dialog-buttonpane{text-align:left;border-width:1px 0 0 0;background-image:none;margin-top:.5em;padding:.3em 1em .5em .4em}.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset{float:right}.ui-dialog .ui-dialog-buttonpane button{margin:.5em .4em .5em 0;cursor:pointer}.ui-dialog .ui-resizable-se{width:12px;height:12px;right:-5px;bottom:-5px;background-position:16px 16px}.ui-draggable .ui-dialog-titlebar{cursor:move}.ui-menu{list-style:none;padding:0;margin:0;display:block;outline:none}.ui-menu .ui-menu{position:absolute}.ui-menu .ui-menu-item{position:relative;margin:0;padding:3px 1em 3px .4em;cursor:pointer;min-height:0;list-style-image:url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7")}.ui-menu .ui-menu-divider{margin:5px 0;height:0;font-size:0;line-height:0;border-width:1px 0 0 0}.ui-menu .ui-state-focus,.ui-menu .ui-state-active{margin:-1px}.ui-menu-icons{position:relative}.ui-menu-icons .ui-menu-item{padding-left:2em}.ui-menu .ui-icon{position:absolute;top:0;bottom:0;left:.2em;margin:auto 0}.ui-menu .ui-menu-icon{left:auto;right:0}.ui-progressbar{height:2em;text-align:left;overflow:hidden}.ui-progressbar .ui-progressbar-value{margin:-1px;height:100%}.ui-progressbar .ui-progressbar-overlay{background:url("data:image/gif;base64,R0lGODlhKAAoAIABAAAAAP///yH/C05FVFNDQVBFMi4wAwEAAAAh+QQJAQABACwAAAAAKAAoAAACkYwNqXrdC52DS06a7MFZI+4FHBCKoDeWKXqymPqGqxvJrXZbMx7Ttc+w9XgU2FB3lOyQRWET2IFGiU9m1frDVpxZZc6bfHwv4c1YXP6k1Vdy292Fb6UkuvFtXpvWSzA+HycXJHUXiGYIiMg2R6W459gnWGfHNdjIqDWVqemH2ekpObkpOlppWUqZiqr6edqqWQAAIfkECQEAAQAsAAAAACgAKAAAApSMgZnGfaqcg1E2uuzDmmHUBR8Qil95hiPKqWn3aqtLsS18y7G1SzNeowWBENtQd+T1JktP05nzPTdJZlR6vUxNWWjV+vUWhWNkWFwxl9VpZRedYcflIOLafaa28XdsH/ynlcc1uPVDZxQIR0K25+cICCmoqCe5mGhZOfeYSUh5yJcJyrkZWWpaR8doJ2o4NYq62lAAACH5BAkBAAEALAAAAAAoACgAAAKVDI4Yy22ZnINRNqosw0Bv7i1gyHUkFj7oSaWlu3ovC8GxNso5fluz3qLVhBVeT/Lz7ZTHyxL5dDalQWPVOsQWtRnuwXaFTj9jVVh8pma9JjZ4zYSj5ZOyma7uuolffh+IR5aW97cHuBUXKGKXlKjn+DiHWMcYJah4N0lYCMlJOXipGRr5qdgoSTrqWSq6WFl2ypoaUAAAIfkECQEAAQAsAAAAACgAKAAAApaEb6HLgd/iO7FNWtcFWe+ufODGjRfoiJ2akShbueb0wtI50zm02pbvwfWEMWBQ1zKGlLIhskiEPm9R6vRXxV4ZzWT2yHOGpWMyorblKlNp8HmHEb/lCXjcW7bmtXP8Xt229OVWR1fod2eWqNfHuMjXCPkIGNileOiImVmCOEmoSfn3yXlJWmoHGhqp6ilYuWYpmTqKUgAAIfkECQEAAQAsAAAAACgAKAAAApiEH6kb58biQ3FNWtMFWW3eNVcojuFGfqnZqSebuS06w5V80/X02pKe8zFwP6EFWOT1lDFk8rGERh1TTNOocQ61Hm4Xm2VexUHpzjymViHrFbiELsefVrn6XKfnt2Q9G/+Xdie499XHd2g4h7ioOGhXGJboGAnXSBnoBwKYyfioubZJ2Hn0RuRZaflZOil56Zp6iioKSXpUAAAh+QQJAQABACwAAAAAKAAoAAACkoQRqRvnxuI7kU1a1UU5bd5tnSeOZXhmn5lWK3qNTWvRdQxP8qvaC+/yaYQzXO7BMvaUEmJRd3TsiMAgswmNYrSgZdYrTX6tSHGZO73ezuAw2uxuQ+BbeZfMxsexY35+/Qe4J1inV0g4x3WHuMhIl2jXOKT2Q+VU5fgoSUI52VfZyfkJGkha6jmY+aaYdirq+lQAACH5BAkBAAEALAAAAAAoACgAAAKWBIKpYe0L3YNKToqswUlvznigd4wiR4KhZrKt9Upqip61i9E3vMvxRdHlbEFiEXfk9YARYxOZZD6VQ2pUunBmtRXo1Lf8hMVVcNl8JafV38aM2/Fu5V16Bn63r6xt97j09+MXSFi4BniGFae3hzbH9+hYBzkpuUh5aZmHuanZOZgIuvbGiNeomCnaxxap2upaCZsq+1kAACH5BAkBAAEALAAAAAAoACgAAAKXjI8By5zf4kOxTVrXNVlv1X0d8IGZGKLnNpYtm8Lr9cqVeuOSvfOW79D9aDHizNhDJidFZhNydEahOaDH6nomtJjp1tutKoNWkvA6JqfRVLHU/QUfau9l2x7G54d1fl995xcIGAdXqMfBNadoYrhH+Mg2KBlpVpbluCiXmMnZ2Sh4GBqJ+ckIOqqJ6LmKSllZmsoq6wpQAAAh+QQJAQABACwAAAAAKAAoAAAClYx/oLvoxuJDkU1a1YUZbJ59nSd2ZXhWqbRa2/gF8Gu2DY3iqs7yrq+xBYEkYvFSM8aSSObE+ZgRl1BHFZNr7pRCavZ5BW2142hY3AN/zWtsmf12p9XxxFl2lpLn1rseztfXZjdIWIf2s5dItwjYKBgo9yg5pHgzJXTEeGlZuenpyPmpGQoKOWkYmSpaSnqKileI2FAAACH5BAkBAAEALAAAAAAoACgAAAKVjB+gu+jG4kORTVrVhRlsnn2dJ3ZleFaptFrb+CXmO9OozeL5VfP99HvAWhpiUdcwkpBH3825AwYdU8xTqlLGhtCosArKMpvfa1mMRae9VvWZfeB2XfPkeLmm18lUcBj+p5dnN8jXZ3YIGEhYuOUn45aoCDkp16hl5IjYJvjWKcnoGQpqyPlpOhr3aElaqrq56Bq7VAAAOw==");height:100%;filter:alpha(opacity=25);opacity:0.25}.ui-progressbar-indeterminate .ui-progressbar-value{background-image:none}.ui-selectmenu-menu{padding:0;margin:0;position:absolute;top:0;left:0;display:none}.ui-selectmenu-menu .ui-menu{overflow:auto;overflow-x:hidden;padding-bottom:1px}.ui-selectmenu-menu .ui-menu .ui-selectmenu-optgroup{font-size:1em;font-weight:bold;line-height:1.5;padding:2px 0.4em;margin:0.5em 0 0 0;height:auto;border:0}.ui-selectmenu-open{display:block}.ui-selectmenu-button{display:inline-block;overflow:hidden;position:relative;text-decoration:none;cursor:pointer}.ui-selectmenu-button span.ui-icon{right:0.5em;left:auto;margin-top:-8px;position:absolute;top:50%}.ui-selectmenu-button span.ui-selectmenu-text{text-align:left;padding:0.4em 2.1em 0.4em 1em;display:block;line-height:1.4;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.ui-slider{position:relative;text-align:left}.ui-slider .ui-slider-handle{position:absolute;z-index:2;width:1.2em;height:1.2em;cursor:default;-ms-touch-action:none;touch-action:none}.ui-slider .ui-slider-range{position:absolute;z-index:1;font-size:.7em;display:block;border:0;background-position:0 0}.ui-slider.ui-state-disabled .ui-slider-handle,.ui-slider.ui-state-disabled .ui-slider-range{filter:inherit}.ui-slider-horizontal{height:.8em}.ui-slider-horizontal .ui-slider-handle{top:-.3em;margin-left:-.6em}.ui-slider-horizontal .ui-slider-range{top:0;height:100%}.ui-slider-horizontal .ui-slider-range-min{left:0}.ui-slider-horizontal .ui-slider-range-max{right:0}.ui-slider-vertical{width:.8em;height:100px}.ui-slider-vertical .ui-slider-handle{left:-.3em;margin-left:0;margin-bottom:-.6em}.ui-slider-vertical .ui-slider-range{left:0;width:100%}.ui-slider-vertical .ui-slider-range-min{bottom:0}.ui-slider-vertical .ui-slider-range-max{top:0}.ui-spinner{position:relative;display:inline-block;overflow:hidden;padding:0;vertical-align:middle}.ui-spinner-input{border:none;background:none;color:inherit;padding:0;margin:.2em 0;vertical-align:middle;margin-left:.4em;margin-right:22px}.ui-spinner-button{width:16px;height:50%;font-size:.5em;padding:0;margin:0;text-align:center;position:absolute;cursor:default;display:block;overflow:hidden;right:0}.ui-spinner a.ui-spinner-button{border-top:none;border-bottom:none;border-right:none}.ui-spinner .ui-icon{position:absolute;margin-top:-8px;top:50%;left:0}.ui-spinner-up{top:0}.ui-spinner-down{bottom:0}.ui-spinner .ui-icon-triangle-1-s{background-position:-65px -16px}.ui-tabs{position:relative;padding:.2em}.ui-tabs .ui-tabs-nav{margin:0;padding:.2em .2em 0}.ui-tabs .ui-tabs-nav li{list-style:none;float:left;position:relative;top:0;margin:1px .2em 0 0;border-bottom-width:0;padding:0;white-space:nowrap}.ui-tabs .ui-tabs-nav .ui-tabs-anchor{float:left;padding:.5em 1em;text-decoration:none}.ui-tabs .ui-tabs-nav li.ui-tabs-active{margin-bottom:-1px;padding-bottom:1px}.ui-tabs .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor,.ui-tabs .ui-tabs-nav li.ui-state-disabled .ui-tabs-anchor,.ui-tabs .ui-tabs-nav li.ui-tabs-loading .ui-tabs-anchor{cursor:text}.ui-tabs-collapsible .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor{cursor:pointer}.ui-tabs .ui-tabs-panel{display:block;border-width:0;padding:1em 1.4em;background:none}.ui-tooltip{padding:8px;position:absolute;z-index:9999;max-width:300px;-webkit-box-shadow:0 0 5px #aaa;box-shadow:0 0 5px #aaa}body .ui-tooltip{border-width:2px}.ui-widget{font-family:Trebuchet MS,Tahoma,Verdana,Arial,sans-serif;font-size:1.1em}.ui-widget .ui-widget{font-size:1em}.ui-widget input,.ui-widget select,.ui-widget textarea,.ui-widget button{font-family:Trebuchet MS,Tahoma,Verdana,Arial,sans-serif;font-size:1em}.ui-widget-content{border:1px solid #ddd;background:#eee url("images/ui-bg_highlight-soft_100_eeeeee_1x100.png") 50% top repeat-x;color:#333}.ui-widget-content a{color:#333}.ui-widget-header{border:1px solid #e78f08;background:#f6a828 url("images/ui-bg_gloss-wave_35_f6a828_500x100.png") 50% 50% repeat-x;color:#fff;font-weight:bold}.ui-widget-header a{color:#fff}.ui-state-default,.ui-widget-content .ui-state-default,.ui-widget-header .ui-state-default{border:1px solid #ccc;background:#f6f6f6 url("images/ui-bg_glass_100_f6f6f6_1x400.png") 50% 50% repeat-x;font-weight:bold;color:#1c94c4}.ui-state-default a,.ui-state-default a:link,.ui-state-default a:visited{color:#1c94c4;text-decoration:none}.ui-state-hover,.ui-widget-content .ui-state-hover,.ui-widget-header .ui-state-hover,.ui-state-focus,.ui-widget-content .ui-state-focus,.ui-widget-header .ui-state-focus{border:1px solid #fbcb09;background:#fdf5ce url("images/ui-bg_glass_100_fdf5ce_1x400.png") 50% 50% repeat-x;font-weight:bold;color:#c77405}.ui-state-hover a,.ui-state-hover a:hover,.ui-state-hover a:link,.ui-state-hover a:visited,.ui-state-focus a,.ui-state-focus a:hover,.ui-state-focus a:link,.ui-state-focus a:visited{color:#c77405;text-decoration:none}.ui-state-active,.ui-widget-content .ui-state-active,.ui-widget-header .ui-state-active{border:1px solid #fbd850;background:#fff url("images/ui-bg_glass_65_ffffff_1x400.png") 50% 50% repeat-x;font-weight:bold;color:#eb8f00}.ui-state-active a,.ui-state-active a:link,.ui-state-active a:visited{color:#eb8f00;text-decoration:none}.ui-state-highlight,.ui-widget-content .ui-state-highlight,.ui-widget-header .ui-state-highlight{border:1px solid #fed22f;background:#ffe45c url("images/ui-bg_highlight-soft_75_ffe45c_1x100.png") 50% top repeat-x;color:#363636}.ui-state-highlight a,.ui-widget-content .ui-state-highlight a,.ui-widget-header .ui-state-highlight a{color:#363636}.ui-state-error,.ui-widget-content .ui-state-error,.ui-widget-header .ui-state-error{border:1px solid #cd0a0a;background:#b81900 url("images/ui-bg_diagonals-thick_18_b81900_40x40.png") 50% 50% repeat;color:#fff}.ui-state-error a,.ui-widget-content .ui-state-error a,.ui-widget-header .ui-state-error a{color:#fff}.ui-state-error-text,.ui-widget-content .ui-state-error-text,.ui-widget-header .ui-state-error-text{color:#fff}.ui-priority-primary,.ui-widget-content .ui-priority-primary,.ui-widget-header .ui-priority-primary{font-weight:bold}.ui-priority-secondary,.ui-widget-content .ui-priority-secondary,.ui-widget-header .ui-priority-secondary{opacity:.7;filter:Alpha(Opacity=70);font-weight:normal}.ui-state-disabled,.ui-widget-content .ui-state-disabled,.ui-widget-header .ui-state-disabled{opacity:.35;filter:Alpha(Opacity=35);background-image:none}.ui-state-disabled .ui-icon{filter:Alpha(Opacity=35)}.ui-icon{width:16px;height:16px}.ui-icon,.ui-widget-content .ui-icon{background-image:url("images/ui-icons_222222_256x240.png")}.ui-widget-header .ui-icon{background-image:url("images/ui-icons_ffffff_256x240.png")}.ui-state-default .ui-icon{background-image:url("images/ui-icons_ef8c08_256x240.png")}.ui-state-hover .ui-icon,.ui-state-focus .ui-icon{background-image:url("images/ui-icons_ef8c08_256x240.png")}.ui-state-active .ui-icon{background-image:url("images/ui-icons_ef8c08_256x240.png")}.ui-state-highlight .ui-icon{background-image:url("images/ui-icons_228ef1_256x240.png")}.ui-state-error .ui-icon,.ui-state-error-text .ui-icon{background-image:url("images/ui-icons_ffd27a_256x240.png")}.ui-icon-blank{background-position:16px 16px}.ui-icon-carat-1-n{background-position:0 0}.ui-icon-carat-1-ne{background-position:-16px 0}.ui-icon-carat-1-e{background-position:-32px 0}.ui-icon-carat-1-se{background-position:-48px 0}.ui-icon-carat-1-s{background-position:-64px 0}.ui-icon-carat-1-sw{background-position:-80px 0}.ui-icon-carat-1-w{background-position:-96px 0}.ui-icon-carat-1-nw{background-position:-112px 0}.ui-icon-carat-2-n-s{background-position:-128px 0}.ui-icon-carat-2-e-w{background-position:-144px 0}.ui-icon-triangle-1-n{background-position:0 -16px}.ui-icon-triangle-1-ne{background-position:-16px -16px}.ui-icon-triangle-1-e{background-position:-32px -16px}.ui-icon-triangle-1-se{background-position:-48px -16px}.ui-icon-triangle-1-s{background-position:-64px -16px}.ui-icon-triangle-1-sw{background-position:-80px -16px}.ui-icon-triangle-1-w{background-position:-96px -16px}.ui-icon-triangle-1-nw{background-position:-112px -16px}.ui-icon-triangle-2-n-s{background-position:-128px -16px}.ui-icon-triangle-2-e-w{background-position:-144px -16px}.ui-icon-arrow-1-n{background-position:0 -32px}.ui-icon-arrow-1-ne{background-position:-16px -32px}.ui-icon-arrow-1-e{background-position:-32px -32px}.ui-icon-arrow-1-se{background-position:-48px -32px}.ui-icon-arrow-1-s{background-position:-64px -32px}.ui-icon-arrow-1-sw{background-position:-80px -32px}.ui-icon-arrow-1-w{background-position:-96px -32px}.ui-icon-arrow-1-nw{background-position:-112px -32px}.ui-icon-arrow-2-n-s{background-position:-128px -32px}.ui-icon-arrow-2-ne-sw{background-position:-144px -32px}.ui-icon-arrow-2-e-w{background-position:-160px -32px}.ui-icon-arrow-2-se-nw{background-position:-176px -32px}.ui-icon-arrowstop-1-n{background-position:-192px -32px}.ui-icon-arrowstop-1-e{background-position:-208px -32px}.ui-icon-arrowstop-1-s{background-position:-224px -32px}.ui-icon-arrowstop-1-w{background-position:-240px -32px}.ui-icon-arrowthick-1-n{background-position:0 -48px}.ui-icon-arrowthick-1-ne{background-position:-16px -48px}.ui-icon-arrowthick-1-e{background-position:-32px -48px}.ui-icon-arrowthick-1-se{background-position:-48px -48px}.ui-icon-arrowthick-1-s{background-position:-64px -48px}.ui-icon-arrowthick-1-sw{background-position:-80px -48px}.ui-icon-arrowthick-1-w{background-position:-96px -48px}.ui-icon-arrowthick-1-nw{background-position:-112px -48px}.ui-icon-arrowthick-2-n-s{background-position:-128px -48px}.ui-icon-arrowthick-2-ne-sw{background-position:-144px -48px}.ui-icon-arrowthick-2-e-w{background-position:-160px -48px}.ui-icon-arrowthick-2-se-nw{background-position:-176px -48px}.ui-icon-arrowthickstop-1-n{background-position:-192px -48px}.ui-icon-arrowthickstop-1-e{background-position:-208px -48px}.ui-icon-arrowthickstop-1-s{background-position:-224px -48px}.ui-icon-arrowthickstop-1-w{background-position:-240px -48px}.ui-icon-arrowreturnthick-1-w{background-position:0 -64px}.ui-icon-arrowreturnthick-1-n{background-position:-16px -64px}.ui-icon-arrowreturnthick-1-e{background-position:-32px -64px}.ui-icon-arrowreturnthick-1-s{background-position:-48px -64px}.ui-icon-arrowreturn-1-w{background-position:-64px -64px}.ui-icon-arrowreturn-1-n{background-position:-80px -64px}.ui-icon-arrowreturn-1-e{background-position:-96px -64px}.ui-icon-arrowreturn-1-s{background-position:-112px -64px}.ui-icon-arrowrefresh-1-w{background-position:-128px -64px}.ui-icon-arrowrefresh-1-n{background-position:-144px -64px}.ui-icon-arrowrefresh-1-e{background-position:-160px -64px}.ui-icon-arrowrefresh-1-s{background-position:-176px -64px}.ui-icon-arrow-4{background-position:0 -80px}.ui-icon-arrow-4-diag{background-position:-16px -80px}.ui-icon-extlink{background-position:-32px -80px}.ui-icon-newwin{background-position:-48px -80px}.ui-icon-refresh{background-position:-64px -80px}.ui-icon-shuffle{background-position:-80px -80px}.ui-icon-transfer-e-w{background-position:-96px -80px}.ui-icon-transferthick-e-w{background-position:-112px -80px}.ui-icon-folder-collapsed{background-position:0 -96px}.ui-icon-folder-open{background-position:-16px -96px}.ui-icon-document{background-position:-32px -96px}.ui-icon-document-b{background-position:-48px -96px}.ui-icon-note{background-position:-64px -96px}.ui-icon-mail-closed{background-position:-80px -96px}.ui-icon-mail-open{background-position:-96px -96px}.ui-icon-suitcase{background-position:-112px -96px}.ui-icon-comment{background-position:-128px -96px}.ui-icon-person{background-position:-144px -96px}.ui-icon-print{background-position:-160px -96px}.ui-icon-trash{background-position:-176px -96px}.ui-icon-locked{background-position:-192px -96px}.ui-icon-unlocked{background-position:-208px -96px}.ui-icon-bookmark{background-position:-224px -96px}.ui-icon-tag{background-position:-240px -96px}.ui-icon-home{background-position:0 -112px}.ui-icon-flag{background-position:-16px -112px}.ui-icon-calendar{background-position:-32px -112px}.ui-icon-cart{background-position:-48px -112px}.ui-icon-pencil{background-position:-64px -112px}.ui-icon-clock{background-position:-80px -112px}.ui-icon-disk{background-position:-96px -112px}.ui-icon-calculator{background-position:-112px -112px}.ui-icon-zoomin{background-position:-128px -112px}.ui-icon-zoomout{background-position:-144px -112px}.ui-icon-search{background-position:-160px -112px}.ui-icon-wrench{background-position:-176px -112px}.ui-icon-gear{background-position:-192px -112px}.ui-icon-heart{background-position:-208px -112px}.ui-icon-star{background-position:-224px -112px}.ui-icon-link{background-position:-240px -112px}.ui-icon-cancel{background-position:0 -128px}.ui-icon-plus{background-position:-16px -128px}.ui-icon-plusthick{background-position:-32px -128px}.ui-icon-minus{background-position:-48px -128px}.ui-icon-minusthick{background-position:-64px -128px}.ui-icon-close{background-position:-80px -128px}.ui-icon-closethick{background-position:-96px -128px}.ui-icon-key{background-position:-112px -128px}.ui-icon-lightbulb{background-position:-128px -128px}.ui-icon-scissors{background-position:-144px -128px}.ui-icon-clipboard{background-position:-160px -128px}.ui-icon-copy{background-position:-176px -128px}.ui-icon-contact{background-position:-192px -128px}.ui-icon-image{background-position:-208px -128px}.ui-icon-video{background-position:-224px -128px}.ui-icon-script{background-position:-240px -128px}.ui-icon-alert{background-position:0 -144px}.ui-icon-info{background-position:-16px -144px}.ui-icon-notice{background-position:-32px -144px}.ui-icon-help{background-position:-48px -144px}.ui-icon-check{background-position:-64px -144px}.ui-icon-bullet{background-position:-80px -144px}.ui-icon-radio-on{background-position:-96px -144px}.ui-icon-radio-off{background-position:-112px -144px}.ui-icon-pin-w{background-position:-128px -144px}.ui-icon-pin-s{background-position:-144px -144px}.ui-icon-play{background-position:0 -160px}.ui-icon-pause{background-position:-16px -160px}.ui-icon-seek-next{background-position:-32px -160px}.ui-icon-seek-prev{background-position:-48px -160px}.ui-icon-seek-end{background-position:-64px -160px}.ui-icon-seek-start{background-position:-80px -160px}.ui-icon-seek-first{background-position:-80px -160px}.ui-icon-stop{background-position:-96px -160px}.ui-icon-eject{background-position:-112px -160px}.ui-icon-volume-off{background-position:-128px -160px}.ui-icon-volume-on{background-position:-144px -160px}.ui-icon-power{background-position:0 -176px}.ui-icon-signal-diag{background-position:-16px -176px}.ui-icon-signal{background-position:-32px -176px}.ui-icon-battery-0{background-position:-48px -176px}.ui-icon-battery-1{background-position:-64px -176px}.ui-icon-battery-2{background-position:-80px -176px}.ui-icon-battery-3{background-position:-96px -176px}.ui-icon-circle-plus{background-position:0 -192px}.ui-icon-circle-minus{background-position:-16px -192px}.ui-icon-circle-close{background-position:-32px -192px}.ui-icon-circle-triangle-e{background-position:-48px -192px}.ui-icon-circle-triangle-s{background-position:-64px -192px}.ui-icon-circle-triangle-w{background-position:-80px -192px}.ui-icon-circle-triangle-n{background-position:-96px -192px}.ui-icon-circle-arrow-e{background-position:-112px -192px}.ui-icon-circle-arrow-s{background-position:-128px -192px}.ui-icon-circle-arrow-w{background-position:-144px -192px}.ui-icon-circle-arrow-n{background-position:-160px -192px}.ui-icon-circle-zoomin{background-position:-176px -192px}.ui-icon-circle-zoomout{background-position:-192px -192px}.ui-icon-circle-check{background-position:-208px -192px}.ui-icon-circlesmall-plus{background-position:0 -208px}.ui-icon-circlesmall-minus{background-position:-16px -208px}.ui-icon-circlesmall-close{background-position:-32px -208px}.ui-icon-squaresmall-plus{background-position:-48px -208px}.ui-icon-squaresmall-minus{background-position:-64px -208px}.ui-icon-squaresmall-close{background-position:-80px -208px}.ui-icon-grip-dotted-vertical{background-position:0 -224px}.ui-icon-grip-dotted-horizontal{background-position:-16px -224px}.ui-icon-grip-solid-vertical{background-position:-32px -224px}.ui-icon-grip-solid-horizontal{background-position:-48px -224px}.ui-icon-gripsmall-diagonal-se{background-position:-64px -224px}.ui-icon-grip-diagonal-se{background-position:-80px -224px}.ui-corner-all,.ui-corner-top,.ui-corner-left,.ui-corner-tl{border-top-left-radius:4px}.ui-corner-all,.ui-corner-top,.ui-corner-right,.ui-corner-tr{border-top-right-radius:4px}.ui-corner-all,.ui-corner-bottom,.ui-corner-left,.ui-corner-bl{border-bottom-left-radius:4px}.ui-corner-all,.ui-corner-bottom,.ui-corner-right,.ui-corner-br{border-bottom-right-radius:4px}.ui-widget-overlay{background:#666 url("images/ui-bg_diagonals-thick_20_666666_40x40.png") 50% 50% repeat;opacity:.5;filter:Alpha(Opacity=50)}.ui-widget-shadow{margin:-5px 0 0 -5px;padding:5px;background:#000 url("images/ui-bg_flat_10_000000_40x100.png") 50% 50% repeat-x;opacity:.2;filter:Alpha(Opacity=20);border-radius:5px}
\ No newline at end of file
diff --git a/view/adminhtml/web/css/style.css b/view/adminhtml/web/css/style.css
deleted file mode 100644
index 1d38dab..0000000
--- a/view/adminhtml/web/css/style.css
+++ /dev/null
@@ -1,145 +0,0 @@
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
-/*
-	Stylesheet for examples by DevHeart.
-	http://devheart.org/
-
-	Article title:	jQuery: Customizable layout using drag n drop
-	Article URI:	http://devheart.org/articles/jquery-customizable-layout-using-drag-and-drop/
-
-	Example title:	1. Getting started with sortable lists
-	Example URI:	http://devheart.org/examples/jquery-customizable-layout-using-drag-and-drop/1-getting-started-with-sortable-lists/index.html
-*/
-
-/*
-	Alignment
-------------------------------------------------------------------- */
-/* Floats */
-
-.clear, .clearer {
-    clear: both;
-}
-
-.clearer {
-    display: block;
-    font-size: 0;
-    height: 0;
-    line-height: 0;
-}
-.field-wrapper .field ul .suggest-position{
-    height: 40px;
-    float: left;
-    width: 48%;
-    background: #ccc;
-    margin: 1%;
-    padding: 0;
-}
-/*
-------------------------------------------------------------------- */
-
-/* General */
-
-.column {
-    width: 49%;
-
-}
-.field-wrapper .field {
-    background: #fafafa;
-    width: 100%;
-    display: block;
-    text-align: center;
-    min-height: 50px;
-}
-
-.field-wrapper .field ul {
-    display: inline-block;
-    padding: 2% 0;
-    width: 100%;
-    min-height: 450px;
-}
-
-.field-wrapper .field ul li {
-    /*float: left;*/
-    margin: 1%;
-    width: 48%;
-}
-.field-wrapper .field ul li .attribute-label{
-    border: 1px solid #ccc;
-    text-align: center;
-    padding: 10px 10px;
-    cursor: move;
-    background: #fff;
-    height: 20px !important;
-    box-sizing: content-box;
-}
-
-.available-wrapper .ui-resizable-handle{
-    display: none !important;
-}
-.ui-resizable-s{
-    display: none !important;
-}
-/*Billing field*/
-.sorted-wrapper .field ul li.wide{
-    width: 98%;
-}
-/* Containment area */
-
-#containment {
-    padding: 0 30px;
-    margin-top: 20px;
-}
-
-.ui-resizable-border {
-    border: 1px dotted #ccc;
-}
-
-.field-title {
-    font-weight: 600;
-    background-position: 12px 12px;
-    background-repeat: no-repeat;
-    padding: 10px;
-}
-
-.field-title h2 {
-    margin: 0 0 0 35px;
-    color: #FFFFFF !important;
-}
-
-.field-title.available h2 {
-    margin: 0 0 0 20px;
-}
-
-.field-title.sorted-title {
-    background-image: url(images/billing_title.png);
-}
-
-.field-title.available {
-    background-image: url(images/next.png);
-}
-
-.f-left, .left {
-    float: left;
-}
-.f-right, .right {
-    float: right;
-}
-ul.sortable-list{list-style: none !important;}
\ No newline at end of file
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index 897bae5..6a937af 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -28,6 +28,13 @@
         <css src="Mageplaza_Core::css/font-awesome.min.css"/>
     </head>
     <body>
+        <attribute name="class" value="checkout_index_index"/>
+        <referenceBlock name="head.additional">
+            <block class="Mageplaza\Osc\Block\Generator\Css" name="secure-checkout-generator-css" as="generator.css" template="generator/css/design.phtml"/>
+        </referenceBlock>
+        <referenceBlock name="page.main.title">
+            <block class="Mageplaza\Osc\Block\Container" name="page.main.description" template="description.phtml" />
+        </referenceBlock>
         <referenceBlock name="checkout.root">
             <arguments>
                 <argument name="jsLayout" xsi:type="array">
@@ -38,15 +45,8 @@
                             </item>
                             <item name="children" xsi:type="array">
                                 <item name="authentication" xsi:type="array">
-                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/authentication</item>
-                                    <item name="children" xsi:type="array">
-                                        <item name="errors" xsi:type="array">
-                                            <item name="sortOrder" xsi:type="string">0</item>
-                                            <item name="component" xsi:type="string">Magento_Checkout/js/view/authentication-messages</item>
-                                            <item name="displayArea" xsi:type="string">messages</item>
-                                        </item>
-                                    </item>
                                     <item name="config" xsi:type="array">
+                                        <item name="template" xsi:type="string">Mageplaza_Osc/container/authentication</item>
                                         <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisableAuthentication" />
                                     </item>
                                 </item>
@@ -72,103 +72,101 @@
                                                                 </item>
                                                             </item>
                                                         </item>
-                                                        <item name="shipping-address-fieldset" xsi:type="array">
-                                                            <item name="children" xsi:type="array">
-                                                                <item name="region_id" xsi:type="array">
-                                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/form/element/region</item>
+                                                        <item name="billing-address-form" xsi:type="array">
+                                                            <item name="component" xsi:type="string">Mageplaza_Osc/js/view/billing-address</item>
+                                                            <item name="config" xsi:type="array">
+                                                                <item name="deps" xsi:type="array">
+                                                                    <item name="0" xsi:type="string">checkoutProvider</item>
                                                                 </item>
                                                             </item>
-                                                        </item>
-                                                    </item>
-                                                </item>
-                                                <item name="billingAddress" xsi:type="array">
-                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/billing-address</item>
-                                                    <item name="config" xsi:type="array">
-                                                        <item name="deps" xsi:type="array">
-                                                            <item name="0" xsi:type="string">checkoutProvider</item>
-                                                        </item>
-                                                    </item>
-                                                    <item name="provider" xsi:type="string">checkoutProvider</item>
-                                                    <item name="children" xsi:type="array">
-                                                        <item name="customer-email" xsi:type="array">
-                                                            <item name="component" xsi:type="string">Mageplaza_Osc/js/view/form/element/email</item>
-                                                            <item name="displayArea" xsi:type="string">customer-email</item>
-                                                            <item name="tooltip" xsi:type="array">
-                                                                <item name="description" xsi:type="string" translate="true">We'll send your order confirmation here.</item>
-                                                            </item>
+                                                            <item name="displayArea" xsi:type="string">billing-address-form</item>
+                                                            <item name="provider" xsi:type="string">checkoutProvider</item>
+                                                            <item name="sortOrder" xsi:type="string">1</item>
+                                                            <item name="dataScopePrefix" xsi:type="string">billingAddress</item>
                                                             <item name="children" xsi:type="array">
-                                                                <item name="before-login-form" xsi:type="array">
-                                                                    <item name="component" xsi:type="string">uiComponent</item>
-                                                                    <item name="displayArea" xsi:type="string">before-login-form</item>
+                                                                <item name="customer-email" xsi:type="array">
+                                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/form/element/email</item>
+                                                                    <item name="displayArea" xsi:type="string">customer-email</item>
+                                                                    <item name="tooltip" xsi:type="array">
+                                                                        <item name="description" xsi:type="string" translate="true">We'll send your order confirmation here.</item>
+                                                                    </item>
                                                                     <item name="children" xsi:type="array">
-                                                                        <!-- before login form fields -->
+                                                                        <item name="before-login-form" xsi:type="array">
+                                                                            <item name="component" xsi:type="string">uiComponent</item>
+                                                                            <item name="displayArea" xsi:type="string">before-login-form</item>
+                                                                            <item name="children" xsi:type="array">
+                                                                                <!-- before login form fields -->
+                                                                            </item>
+                                                                        </item>
+                                                                        <item name="additional-login-form-fields" xsi:type="array">
+                                                                            <item name="component" xsi:type="string">uiComponent</item>
+                                                                            <item name="displayArea" xsi:type="string">additional-login-form-fields</item>
+                                                                            <item name="children" xsi:type="array">
+                                                                                <!-- additional login form fields -->
+                                                                            </item>
+                                                                        </item>
                                                                     </item>
                                                                 </item>
-                                                                <item name="additional-login-form-fields" xsi:type="array">
+                                                                <item name="form-fields" xsi:type="array">
                                                                     <item name="component" xsi:type="string">uiComponent</item>
-                                                                    <item name="displayArea" xsi:type="string">additional-login-form-fields</item>
+                                                                    <item name="displayArea" xsi:type="string">additional-fieldsets</item>
                                                                     <item name="children" xsi:type="array">
-                                                                        <!-- additional login form fields -->
+                                                                        <!-- The following items override configuration of corresponding address attributes -->
+                                                                        <item name="region" xsi:type="array">
+                                                                            <!-- Make region attribute invisible on frontend. Corresponding input element is created by region_id field -->
+                                                                            <item name="visible" xsi:type="boolean">false</item>
+                                                                        </item>
+                                                                        <item name="region_id" xsi:type="array">
+                                                                            <item name="component" xsi:type="string">Mageplaza_Osc/js/view/form/element/region</item>
+                                                                            <item name="config" xsi:type="array">
+                                                                                <item name="template" xsi:type="string">ui/form/field</item>
+                                                                                <item name="elementTmpl" xsi:type="string">ui/form/element/select</item>
+                                                                                <item name="customEntry" xsi:type="string">billingAddress.region</item>
+                                                                            </item>
+                                                                            <item name="validation" xsi:type="array">
+                                                                                <item name="required-entry" xsi:type="boolean">true</item>
+                                                                            </item>
+                                                                            <!-- Value of region_id field is filtered by the value of county_id attribute -->
+                                                                            <item name="filterBy" xsi:type="array">
+                                                                                <item name="target" xsi:type="string"><![CDATA[${ $.provider }:${ $.parentScope }.country_id]]></item>
+                                                                                <item name="field" xsi:type="string">country_id</item>
+                                                                            </item>
+                                                                        </item>
+                                                                        <item name="postcode" xsi:type="array">
+                                                                            <!-- post-code field has custom UI component -->
+                                                                            <item name="component" xsi:type="string">Magento_Ui/js/form/element/post-code</item>
+                                                                            <item name="validation" xsi:type="array">
+                                                                                <item name="required-entry" xsi:type="string">true</item>
+                                                                            </item>
+                                                                        </item>
+                                                                        <item name="company" xsi:type="array">
+                                                                            <item name="validation" xsi:type="array">
+                                                                                <item name="min_text_length" xsi:type="number">0</item>
+                                                                            </item>
+                                                                        </item>
+                                                                        <item name="fax" xsi:type="array">
+                                                                            <item name="validation" xsi:type="array">
+                                                                                <item name="min_text_length" xsi:type="number">0</item>
+                                                                            </item>
+                                                                        </item>
+                                                                        <item name="country_id" xsi:type="array">
+                                                                            <item name="sortOrder" xsi:type="string">115</item>
+                                                                        </item>
+                                                                        <item name="telephone" xsi:type="array">
+                                                                            <item name="config" xsi:type="array">
+                                                                                <item name="tooltip" xsi:type="array">
+                                                                                    <item name="description" xsi:type="string" translate="true">For delivery questions.</item>
+                                                                                </item>
+                                                                            </item>
+                                                                        </item>
                                                                     </item>
                                                                 </item>
                                                             </item>
                                                         </item>
-                                                        <item name="billing-address-fieldset" xsi:type="array">
-                                                            <item name="component" xsi:type="string">uiComponent</item>
-                                                            <item name="config" xsi:type="array">
-                                                                <item name="deps" xsi:type="array">
-                                                                    <item name="0" xsi:type="string">checkoutProvider</item>
-                                                                </item>
-                                                            </item>
-                                                            <item name="displayArea" xsi:type="string">additional-fieldsets</item>
+                                                        <item name="shipping-address-fieldset" xsi:type="array">
                                                             <item name="children" xsi:type="array">
-                                                                <!-- The following items override configuration of corresponding address attributes -->
-                                                                <item name="region" xsi:type="array">
-                                                                    <!-- Make region attribute invisible on frontend. Corresponding input element is created by region_id field -->
-                                                                    <item name="visible" xsi:type="boolean">false</item>
-                                                                </item>
                                                                 <item name="region_id" xsi:type="array">
                                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/form/element/region</item>
-                                                                    <item name="config" xsi:type="array">
-                                                                        <item name="template" xsi:type="string">ui/form/field</item>
-                                                                        <item name="elementTmpl" xsi:type="string">ui/form/element/select</item>
-                                                                        <item name="customEntry" xsi:type="string">billingAddress.region</item>
-                                                                    </item>
-                                                                    <item name="validation" xsi:type="array">
-                                                                        <item name="required-entry" xsi:type="boolean">true</item>
-                                                                    </item>
-                                                                    <!-- Value of region_id field is filtered by the value of county_id attribute -->
-                                                                    <item name="filterBy" xsi:type="array">
-                                                                        <item name="target" xsi:type="string"><![CDATA[${ $.provider }:${ $.parentScope }.country_id]]></item>
-                                                                        <item name="field" xsi:type="string">country_id</item>
-                                                                    </item>
-                                                                </item>
-                                                                <item name="postcode" xsi:type="array">
-                                                                    <!-- post-code field has custom UI component -->
-                                                                    <item name="component" xsi:type="string">Magento_Ui/js/form/element/post-code</item>
-                                                                    <item name="validation" xsi:type="array">
-                                                                        <item name="required-entry" xsi:type="string">true</item>
-                                                                    </item>
-                                                                </item>
-                                                                <item name="company" xsi:type="array">
-                                                                    <item name="validation" xsi:type="array">
-                                                                        <item name="min_text_length" xsi:type="number">0</item>
-                                                                    </item>
-                                                                </item>
-                                                                <item name="fax" xsi:type="array">
-                                                                    <item name="validation" xsi:type="array">
-                                                                        <item name="min_text_length" xsi:type="number">0</item>
-                                                                    </item>
-                                                                </item>
-                                                                <item name="country_id" xsi:type="array">
-                                                                    <item name="sortOrder" xsi:type="string">115</item>
-                                                                </item>
-                                                                <item name="telephone" xsi:type="array">
-                                                                    <item name="config" xsi:type="array">
-                                                                        <item name="tooltip" xsi:type="array">
-                                                                            <item name="description" xsi:type="string" translate="true">For delivery questions.</item>
-                                                                        </item>
-                                                                    </item>
                                                                 </item>
                                                             </item>
                                                         </item>
@@ -185,7 +183,7 @@
                                                             <item name="children" xsi:type="array">
                                                                 <item name="agreements-validator" xsi:type="array">
                                                                     <item name="config" xsi:type="array">
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledPaymentTOC" />
+                                                                        <item name="componentDisabled" xsi:type="boolean">true</item>
                                                                     </item>
                                                                 </item>
                                                             </item>
@@ -201,7 +199,7 @@
                                                                     <item name="children" xsi:type="array">
                                                                         <item name="agreements" xsi:type="array">
                                                                             <item name="config" xsi:type="array">
-                                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledPaymentTOC" />
+                                                                                <item name="componentDisabled" xsi:type="boolean">true</item>
                                                                             </item>
                                                                         </item>
                                                                     </item>
@@ -212,7 +210,8 @@
                                                             <item name="children" xsi:type="array">
                                                                 <item name="discount" xsi:type="array">
                                                                     <item name="config" xsi:type="array">
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledPaymentCoupon" />
+                                                                        <item name="template" xsi:type="string">Mageplaza_Osc/container/payment/discount</item>
+                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledCoupon" />
                                                                     </item>
                                                                 </item>
                                                             </item>
@@ -260,19 +259,6 @@
                                                 </item>
                                                 <item name="totals" xsi:type="array">
                                                     <item name="sortOrder" xsi:type="string">20</item>
-                                                    <item name="children" xsi:type="array">
-                                                        <item name="before_grandtotal" xsi:type="array">
-                                                            <item name="children" xsi:type="array">
-                                                                <item name="osc_gift_wrap" xsi:type="array">
-                                                                    <item name="component"  xsi:type="string">Mageplaza_Osc/js/view/summary/gift-wrap</item>
-                                                                    <item name="config" xsi:type="array">
-                                                                        <item name="title" xsi:type="string" translate="true">Gift Wrap</item>
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledGiftWrap" />
-                                                                    </item>
-                                                                </item>
-                                                            </item>
-                                                        </item>
-                                                    </item>
                                                 </item>
                                             </item>
                                         </item>
@@ -285,19 +271,6 @@
                                             <item name="component" xsi:type="string">uiComponent</item>
                                             <item name="displayArea" xsi:type="string">place-order-information-left</item>
                                             <item name="children" xsi:type="array">
-                                                <item name="discount" xsi:type="array">
-                                                    <item name="component" xsi:type="string">Mageplaza_Osc/js/view/payment/discount</item>
-                                                    <item name="config" xsi:type="array">
-                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledReviewCoupon" />
-                                                    </item>
-                                                    <item name="children" xsi:type="array">
-                                                        <item name="errors" xsi:type="array">
-                                                            <item name="sortOrder" xsi:type="string">0</item>
-                                                            <item name="component" xsi:type="string">Magento_SalesRule/js/view/payment/discount-messages</item>
-                                                            <item name="displayArea" xsi:type="string">messages</item>
-                                                        </item>
-                                                    </item>
-                                                </item>
                                                 <item name="addition-information" xsi:type="array">
                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/addition</item>
                                                     <item name="sortOrder" xsi:type="string">20</item>
@@ -310,13 +283,6 @@
                                                                 <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledNewsletter" />
                                                             </item>
                                                         </item>
-                                                        <item name="gift_wrap" xsi:type="array">
-                                                            <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/addition/gift-wrap</item>
-                                                            <item name="sortOrder" xsi:type="string">30</item>
-                                                            <item name="config" xsi:type="array">
-                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledGiftWrap" />
-                                                            </item>
-                                                        </item>
                                                     </item>
                                                 </item>
                                             </item>
@@ -339,7 +305,7 @@
                                                         <item name="agreements" xsi:type="array">
                                                             <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/checkout-agreements</item>
                                                             <item name="config" xsi:type="array">
-                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledReviewTOC" />
+                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledTOC" />
                                                             </item>
                                                             <item name="displayArea" xsi:type="string">checkout-agreements</item>
                                                             <item name="dataScope" xsi:type="string">checkoutAgreements</item>
@@ -357,12 +323,5 @@
                 </argument>
             </arguments>
         </referenceBlock>
-        <attribute name="class" value="checkout_index_index"/>
-        <referenceBlock name="head.additional">
-            <block class="Mageplaza\Osc\Block\Design" name="osc.design" as="generator.css" template="design.phtml"/>
-        </referenceBlock>
-        <referenceBlock name="page.main.title">
-            <block class="Mageplaza\Osc\Block\Container" name="page.main.description" template="description.phtml" />
-        </referenceBlock>
     </body>
 </page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_email_order_creditmemo_items.xml b/view/frontend/layout/sales_email_order_creditmemo_items.xml
deleted file mode 100644
index 75e7d81..0000000
--- a/view/frontend/layout/sales_email_order_creditmemo_items.xml
+++ /dev/null
@@ -1,28 +0,0 @@
-<?xml version="1.0"?>
-<!--
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * http://mageplaza.com/license-agreement/
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
- -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="creditmemo_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_email_order_invoice_items.xml b/view/frontend/layout/sales_email_order_invoice_items.xml
deleted file mode 100644
index b4a73d9..0000000
--- a/view/frontend/layout/sales_email_order_invoice_items.xml
+++ /dev/null
@@ -1,29 +0,0 @@
-<?xml version="1.0"?>
-<!--
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * http://mageplaza.com/license-agreement/
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
-
- -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_email_order_items.xml b/view/frontend/layout/sales_email_order_items.xml
deleted file mode 100644
index 59cce31..0000000
--- a/view/frontend/layout/sales_email_order_items.xml
+++ /dev/null
@@ -1,14 +0,0 @@
-<?xml version="1.0"?>
-<!--
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
--->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd" label="Email Order Items List" design_abstraction="custom">
-    <body>
-        <referenceBlock name="order_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
diff --git a/view/frontend/layout/sales_order_creditmemo.xml b/view/frontend/layout/sales_order_creditmemo.xml
deleted file mode 100644
index aa3f180..0000000
--- a/view/frontend/layout/sales_order_creditmemo.xml
+++ /dev/null
@@ -1,29 +0,0 @@
-<?xml version="1.0"?>
-<!--
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * http://mageplaza.com/license-agreement/
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
-
- -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="creditmemo_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_order_invoice.xml b/view/frontend/layout/sales_order_invoice.xml
deleted file mode 100644
index 586e7d5..0000000
--- a/view/frontend/layout/sales_order_invoice.xml
+++ /dev/null
@@ -1,28 +0,0 @@
-<?xml version="1.0"?>
-<!--
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * http://mageplaza.com/license-agreement/
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
-
- -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_order_print.xml b/view/frontend/layout/sales_order_print.xml
deleted file mode 100644
index 5dff10e..0000000
--- a/view/frontend/layout/sales_order_print.xml
+++ /dev/null
@@ -1,29 +0,0 @@
-<?xml version="1.0"?>
-<!--
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * http://mageplaza.com/license-agreement/
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
-
- -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="order_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_order_printcreditmemo.xml b/view/frontend/layout/sales_order_printcreditmemo.xml
deleted file mode 100644
index aa3f180..0000000
--- a/view/frontend/layout/sales_order_printcreditmemo.xml
+++ /dev/null
@@ -1,29 +0,0 @@
-<?xml version="1.0"?>
-<!--
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * http://mageplaza.com/license-agreement/
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
-
- -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="creditmemo_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_order_printinvoice.xml b/view/frontend/layout/sales_order_printinvoice.xml
deleted file mode 100644
index b4a73d9..0000000
--- a/view/frontend/layout/sales_order_printinvoice.xml
+++ /dev/null
@@ -1,29 +0,0 @@
-<?xml version="1.0"?>
-<!--
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * http://mageplaza.com/license-agreement/
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
-
- -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="invoice_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
-    </body>
-</page>
\ No newline at end of file
diff --git a/view/frontend/layout/sales_order_view.xml b/view/frontend/layout/sales_order_view.xml
index ee6ca2d..ad40e23 100644
--- a/view/frontend/layout/sales_order_view.xml
+++ b/view/frontend/layout/sales_order_view.xml
@@ -20,18 +20,12 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceContainer name="content">
-            <block class="Magento\Framework\View\Element\Template" name="osc.additional.content"
-                   template="Mageplaza_Osc::order/additional.phtml" after="-">
-                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="comment"
-                       template="order/view/comment.phtml"/>
+            <block class="Magento\Framework\View\Element\Template" name="osc.additional.content" template="Mageplaza_Osc::order/additional.phtml" after="-">
+                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="comment" template="order/view/comment.phtml" />
             </block>
         </referenceContainer>
-        <referenceBlock name="order_totals">
-            <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
-        </referenceBlock>
     </body>
 </page>
diff --git a/view/frontend/templates/design.phtml b/view/frontend/templates/generator/css/design.phtml
similarity index 86%
rename from view/frontend/templates/design.phtml
rename to view/frontend/templates/generator/css/design.phtml
index 6e93dd9..5b04ec2 100644
--- a/view/frontend/templates/design.phtml
+++ b/view/frontend/templates/generator/css/design.phtml
@@ -30,10 +30,10 @@
     /*===================================================================
     |                            CONFIGUARATION STYLE                    |
     ====================================================================*/
-<?php switch ($design['page_design']): ?><?php case 'flat': ?>
+<?php switch ($design['page_design']): ?>
+<?php case 'flat': ?>
 	.checkout-container a.button-action,
-	.popup-authentication button.action,
-	.checkout-container button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link){
+	.checkout-container button:not(.primary):not(.action-show):not(.action-close){
 		background-color: <?php echo $design['heading_background'] ?> !important;
 		border-color: <?php echo $design['heading_background'] ?> !important;
 		box-shadow: none !important;
@@ -41,7 +41,7 @@
 	}
 	.step-title{
 		background-color: <?php echo $design['heading_background'] ?>;
-		padding: 12px 10px 12px 12px !important;
+		padding: 12px 10px 12px 12px;
 		font-weight: bold !important;
 		font-size: 16px !important;
 		color: <?php echo $design['heading_text'] ?> !important;
@@ -54,9 +54,7 @@
 		margin-right: 12px;
 		vertical-align: text-bottom;
 	}
-	.one-step-checkout-container .osc-geolocation {
-		color: <?php echo $design['heading_background'] ?>;
-	}
+
 	<?php break; ?>
 <?php case 'material': ?>
 <?php default: ?>
@@ -71,5 +69,5 @@
 	/*===================================================================
 	|                           Custom STYLE                             |
 	====================================================================*/
-	<?php echo isset($design['custom_css']) ? $design['custom_css'] : ''; ?>
+	<?php echo $design['custom_css']; ?>
 </style>
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index 6b2c3a5..039370f 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -19,21 +19,17 @@
  */
 
 /**************************************************** Osc style ****************************************************/
-.page-title-wrapper{padding-left: 10px;}
 .one-step-checkout-wrapper{width: 100% !important; margin-top: 20px; padding: 0 !important;}
 .onestepcheckout-index-index input.google-auto-complete {margin-right: 10px; width: calc(100% - 36px);}
 .one-step-checkout-container .osc-geolocation {font-size: 20px;cursor: pointer;transition: all 0.3s ease 0s;}
 .fieldset.address .field.choice{width: 100%; padding: 0 10px}
-.onestepcheckout-index-index .field.choice.col-mp {margin-bottom: 10px}
+.onestepcheckout-index-index .field.choice{margin-bottom: 10px}
 .opc-wrapper .create-account-block .fieldset .field .label{font-weight: 400 !important;}
 .step-title .fa{display: none;}
-.step-content{border-radius: 0 !important; padding-top: 20px !important;}
-.mp-hidden {display: none}
+.step-content{border-radius: 0 !important;}
 
 /**************************************************** Authetication area ****************************************************/
-.osc-authentication-wrapper{padding-left: 10px}
-.osc-authentication-toggle{cursor: pointer}
-.popup-authentication .block-authentication {border: none !important;}
+.osc-authentication-wrapper{z-index: 999; position: relative; max-width: 50%}
 
 /**************************************************** Shipping address area ****************************************************/
 .one-step-checkout-wrapper .form.form-login{border-bottom: 0 !important; padding-bottom: 0 !important;}
@@ -45,22 +41,21 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .opc-wrapper .shipping-address-item button.edit-address-link{position: absolute; top: 14px; right: 40px; margin-top: 0;}
 .opc-wrapper .action-select-shipping-item{display: none !important;}
 .opc-wrapper .form-shipping-address{margin-bottom: 0 !important;}
-.opc-wrapper .shipping-address-item:not(.selected-item){border-color: #ccc}
-.opc-wrapper .shipping-address-item:before{background: none !important;}
-.opc-wrapper .create-account-block {margin-bottom: 20px}
 /** Theme **/
 .opc-wrapper .fieldset > .field > .label{float: none !important; width: auto !important; margin: 0 0 8px !important;}
 .fieldset > .field:not(.choice) > .control{float: none !important; width: 100% !important;}
 .fieldset > .field {margin: 0 0 20px !important;}
-#checkout-step-shipping .form-login {margin-top: 0 !important;}
+#checkout-step-shipping .form-login {margin-top: 0 !important; padding-top: 28px !important;}
 
 /**************************************************** Billing address area ****************************************************/
 .checkout-billing-address .step-content .field.field-select-billing label{display: none}
+#checkout-step-billing {margin-top: 20px}
 .fieldset#billing-new-address-form > .field > .label{font-weight: normal}
 #checkout-step-billing .field.field-select-billing{margin-bottom: 20px; padding: 0 10px;}
 
 /**************************************************** Shipping method area ****************************************************/
 #checkout-shipping-method-load .table-checkout-shipping-method {width: 100% !important; min-width: 0;}
+#co-shipping-method-form{margin-top: 10px}
 .osc-shipping-method ul{padding:0;}
 .osc-shipping-method ul li{list-style: none;}
 .table-checkout-shipping-method thead th{display: none;}
@@ -68,10 +63,8 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 /**************************************************** Payment method area ****************************************************/
 .osc-payment-after-methods .opc-payment-additional .field .control{float: left; margin-right: 3px}
 .payment-method-content .payment-method-billing-address,
+.payment-method-content .checkout-agreements-block,
 .payment-method-content .actions-toolbar {display: none}
-.checkout-payment-method .payment-method-content {padding-bottom: 0 !important;}
-/** 2.1.3 **/
-.checkout-payment-method .payment-group .step-title {display: none;}
 
 /**************************************************** Order summary area ****************************************************/
 .opc-block-summary .minicart-items-wrapper{max-height: none !important;}
@@ -100,27 +93,15 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .one-step-checkout-wrapper .mp-4 #checkout-review-table thead th,.one-step-checkout-wrapper .mp-4 #checkout-review-table tbody tr td,.one-step-checkout-wrapper .mp-4 #checkout-review-table tfoot tr td{padding-left: 5px !important;padding-right: 5px !important;}
 
 /**************************************************** Place order area ****************************************************/
-#co-place-order-area{padding: 0 20px !important;}
+#co-place-order-form{padding: 0 20px !important;}
 .one-step-checkout-wrapper .mp-4 #co-place-order-form{padding: 0 !important;}
 .one-step-checkout-wrapper .mp-4 #co-place-order-form .col-mp{width: 100% !important;}
 .osc-place-order-wrapper button.action.primary.checkout {padding: 10px 30px;margin: 0;border: none;font-size: 18px;font-weight: bold;width: 100%;height: 70px;}
 .osc-place-order-block{border: 1px solid #ccc;padding: 10px !important;margin-bottom: 20px;}
-.osc-place-order-block .field-row label{display: block; margin-bottom: 6px}
-.osc-place-order-block .actions-toolbar{margin-top: 6px}
 .checkout-addition-block{padding-top: 20px !important;}
 .osc-place-order-wrapper button.action.primary.checkout span {color: #FFFFFF;background: none;border: none;}
 
 /**************************************************** Responsive ****************************************************/
-@media (min-width: 1024px), print {
-    .checkout-index-index .modal-popup.popup-authentication .modal-inner-wrap {
-        margin-left: auto !important;
-        margin-right: auto !important;
-        left: 0 !important;
-        right: 0 !important;
-        width: 500px !important;
-        min-width: 0;
-    }
-    .popup-authentication .block[class] {
-        padding-right: 0 !important;
-    }
+@media (min-width: 768px), print {
+    .osc-authentication-wrapper {width: 33.33333333%;}
 }
diff --git a/view/frontend/web/js/action/gift-wrap.js b/view/frontend/web/js/action/gift-wrap.js
deleted file mode 100644
index 4bee240..0000000
--- a/view/frontend/web/js/action/gift-wrap.js
+++ /dev/null
@@ -1,63 +0,0 @@
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-define(
-    [
-        'Magento_Checkout/js/model/quote',
-        'Mageplaza_Osc/js/model/resource-url-manager',
-        'mage/storage',
-        'Magento_Checkout/js/model/error-processor',
-        'Magento_Customer/js/model/customer',
-        'Magento_Checkout/js/model/payment/method-converter',
-        'Magento_Checkout/js/model/payment-service',
-        'Magento_Checkout/js/model/shipping-service',
-        'Mageplaza_Osc/js/model/osc-loader'
-    ],
-    function (quote,
-              resourceUrlManager,
-              storage,
-              errorProcessor,
-              customer,
-              methodConverter,
-              paymentService,
-              shippingService,
-              oscLoader) {
-        'use strict';
-
-        var itemUpdateLoader = ['shipping', 'payment', 'total'];
-
-        return function (payload) {
-            if (!customer.isLoggedIn()) {
-                payload.cart_id = quote.getQuoteId();
-            }
-
-            oscLoader.startLoader(itemUpdateLoader);
-
-            return storage.post(
-                resourceUrlManager.getUrlForGiftWrapInformation(quote),
-                JSON.stringify(payload)
-            ).done(
-                function (response) {
-                    if (response.redirect_url) {
-                        window.location.href = response.redirect_url;
-                        return;
-                    }
-                    quote.setTotals(response.totals);
-                    paymentService.setPaymentMethods(methodConverter(response.payment_methods));
-                    if (response.shipping_methods && !quote.isVirtual()) {
-                        shippingService.setShippingRates(response.shipping_methods);
-                    }
-                }
-            ).fail(
-                function (response) {
-                    errorProcessor.process(response);
-                }
-            ).always(
-                function () {
-                    oscLoader.stopLoader(itemUpdateLoader);
-                }
-            );
-        };
-    }
-);
diff --git a/view/frontend/web/js/action/update-item.js b/view/frontend/web/js/action/update-item.js
index e6675fb..e9dc11b 100644
--- a/view/frontend/web/js/action/update-item.js
+++ b/view/frontend/web/js/action/update-item.js
@@ -20,6 +20,7 @@
 
 define(
     [
+        'jquery',
         'Magento_Checkout/js/model/quote',
         'Mageplaza_Osc/js/model/resource-url-manager',
         'mage/storage',
@@ -31,6 +32,7 @@ define(
         'Mageplaza_Osc/js/model/osc-loader'
     ],
     function (
+        $,
         quote,
         resourceUrlManager,
         storage,
diff --git a/view/frontend/web/js/model/address/auto-complete.js b/view/frontend/web/js/model/address/auto-complete.js
index 0b5360f..b4a4f30 100644
--- a/view/frontend/web/js/model/address/auto-complete.js
+++ b/view/frontend/web/js/model/address/auto-complete.js
@@ -24,7 +24,7 @@ define([
     'use strict';
 
     var addressType = {
-        billing: 'checkout.steps.shipping-step.billingAddress.billing-address-fieldset',
+        billing: 'checkout.steps.shipping-step.shippingAddress.billing-address-form.form-fields',
         shipping: 'checkout.steps.shipping-step.shippingAddress.shipping-address-fieldset'
     };
 
diff --git a/view/frontend/web/js/model/agreement-validator.js b/view/frontend/web/js/model/agreement-validator.js
index cf78544..e197fed 100644
--- a/view/frontend/web/js/model/agreement-validator.js
+++ b/view/frontend/web/js/model/agreement-validator.js
@@ -45,7 +45,7 @@ define(
                     return true;
                 }
 
-                return $('#co-place-order-agreement').validate({
+                return $('#co-place-order-form').validate({
                     errorClass: 'mage-error',
                     errorElement: 'div',
                     meta: 'validate',
diff --git a/view/frontend/web/js/model/gift-wrap.js b/view/frontend/web/js/model/gift-wrap.js
deleted file mode 100644
index 962330d..0000000
--- a/view/frontend/web/js/model/gift-wrap.js
+++ /dev/null
@@ -1,17 +0,0 @@
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-define(['ko'], function(ko) {
-    'use strict';
-    var hasWrap = ko.observable(window.checkoutConfig.oscConfig.giftWrap.hasWrap);
-    return {
-        hasWrap: hasWrap,
-        getIsWrap: function() {
-            return this.hasWrap();
-        },
-        setIsWrap: function(isWrap) {
-            return this.hasWrap(isWrap); 
-        }
-    };
-});
\ No newline at end of file
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index e6ca356..b548380 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -48,14 +48,6 @@ define(
                 };
                 return this.getUrl(urls, params);
             },
-            getUrlForGiftWrapInformation: function(quote){
-                var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
-                var urls = {
-                    'guest': '/guest-carts/:cartId/update-gift-wrap',
-                    'customer': '/carts/mine/update-gift-wrap'
-                };
-                return this.getUrl(urls, params);
-            },
 
             /** Get url for update item qty and remove item */
             getUrlForUpdatePaymentTotalInformation: function (quote) {
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index e19e320..b4a5a1e 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -20,10 +20,8 @@
 
 define(
     [
-        'underscore',
         'jquery',
         'mageUtils',
-        'Magento_Customer/js/model/address-list',
         'Magento_Checkout/js/model/shipping-rates-validator',
         'Magento_Checkout/js/model/shipping-rates-validation-rules',
         'Magento_Checkout/js/model/address-converter',
@@ -34,40 +32,36 @@ define(
         'mage/translate',
         'uiRegistry'
     ],
-    function (_,
-              $,
-              utils,
-              addressList,
-              Validator,
-              shippingRatesValidationRules,
-              addressConverter,
-              selectShippingAddress,
-              shippingRateService,
-              shippingService,
-              postcodeValidator,
-              $t,
-              uiRegistry) {
+    function (
+        $,
+        utils,
+        Validator,
+        shippingRatesValidationRules,
+        addressConverter,
+        selectShippingAddress,
+        shippingRateService,
+        shippingService,
+        postcodeValidator,
+        $t,
+        uiRegistry
+    ) {
         'use strict';
 
         var countryElement = null,
             postcodeElement = null,
             postcodeElementName = 'postcode',
-            observedElements = [],
-            observableElements,
-            addressFields = window.checkoutConfig.oscConfig.addressFields;
+            observedElements = [];
 
-        return _.extend(Validator, {
-            isFormInline: addressList().length == 0,
+        return $.extend(Validator, {
 
             oscValidateAddressData: function (field, address) {
-                var self = this,
-                    canLoad = false;
+                var canLoad = false;
 
                 $.each(shippingRatesValidationRules.getRules(), function (carrier, fields) {
                     if (fields.hasOwnProperty(field)) {
                         var missingValue = false;
                         $.each(fields, function (key, rule) {
-                            if (self.isFieldExisted(key) && address.hasOwnProperty(key) && rule.required && utils.isEmpty(address[key])) {
+                            if (address.hasOwnProperty(key) && rule.required && utils.isEmpty(address[key])) {
                                 var regionFields = ['region', 'region_id', 'region_id_input'];
                                 if ($.inArray(key, regionFields) === -1
                                     || utils.isEmpty(address['region']) && utils.isEmpty(address['region_id'])
@@ -89,62 +83,52 @@ define(
                 return canLoad;
             },
 
-            isFieldExisted: function (field) {
-                var result = false;
-                $.each(observedElements, function (key, element) {
-                    if (field == element.index) {
-                        result = true;
-                        return false;
-                    }
-                });
-
-                return result;
-            },
-
             /**
              * Perform postponed binding for fieldset elements
              *
              * @param {String} formPath
              */
             initFields: function (formPath) {
-                var self = this;
+                var self = this,
+                    elements = uiRegistry.async(formPath)().elems(),
+                    observableElements = shippingRatesValidationRules.getObservableFields();
 
-                observableElements = shippingRatesValidationRules.getObservableFields();
                 if ($.inArray(postcodeElementName, observableElements) === -1) {
                     // Add postcode field to observables if not exist for zip code validation support
                     observableElements.push(postcodeElementName);
                 }
 
-                $.each(addressFields, function (index, field) {
-                    uiRegistry.async(formPath + '.' + field)(self.oscBindHandler.bind(self));
+                $.each(elements, function (index, elem) {
+                    self.oscBindHandler(elem, observableElements);
                 });
             },
 
-            oscBindHandler: function (element) {
+            oscBindHandler: function (element, observableElements) {
                 var self = this;
 
                 if (element.component.indexOf('/group') !== -1) {
                     $.each(element.elems(), function (index, elem) {
                         self.oscBindHandler(elem);
                     });
-                } else if (element && element.hasOwnProperty('value')) {
+                } else {
+                    if (!element || !element.hasOwnProperty('value')) {
+                        return this;
+                    }
                     element.on('value', function () {
                         self.oscPostcodeValidation();
 
-                        if (self.isFormInline) {
-                            var addressFlat = addressConverter.formDataProviderToFlatData(
-                                    self.oscCollectObservedData(),
-                                    'shippingAddress'
-                                ),
-                                address;
+                        var addressFlat = addressConverter.formDataProviderToFlatData(
+                            self.oscCollectObservedData(),
+                            'shippingAddress'
+                        ),
+                            address;
 
-                            address = addressConverter.formAddressDataToQuoteAddress(addressFlat);
-                            selectShippingAddress(address);
+                        address = addressConverter.formAddressDataToQuoteAddress(addressFlat);
+                        selectShippingAddress(address);
 
-                            if ($.inArray(element.index, observableElements) !== -1 && self.oscValidateAddressData(element.index, addressFlat)) {
-                                shippingRateService.isAddressChange = true;
-                                shippingRateService.estimateShippingMethod();
-                            }
+                        if ($.inArray(element.index, observableElements) !== -1 && self.oscValidateAddressData(element.index, addressFlat)) {
+                            shippingRateService.isAddressChange = true;
+                            shippingRateService.estimateShippingMethod();
                         }
                     });
                     observedElements.push(element);
diff --git a/view/frontend/web/js/model/shipping-save-processor/checkout.js b/view/frontend/web/js/model/shipping-save-processor/checkout.js
index 116f757..69a81b0 100644
--- a/view/frontend/web/js/model/shipping-save-processor/checkout.js
+++ b/view/frontend/web/js/model/shipping-save-processor/checkout.js
@@ -32,17 +32,19 @@ define(
         'Magento_Checkout/js/model/full-screen-loader',
         'Magento_Checkout/js/action/select-billing-address'
     ],
-    function (ko,
-              $,
-              quote,
-              resourceUrlManager,
-              storage,
-              oscData,
-              paymentService,
-              methodConverter,
-              errorProcessor,
-              fullScreenLoader,
-              selectBillingAddressAction) {
+    function (
+        ko,
+        $,
+        quote,
+        resourceUrlManager,
+        storage,
+        oscData,
+        paymentService,
+        methodConverter,
+        errorProcessor,
+        fullScreenLoader,
+        selectBillingAddressAction
+    ) {
         'use strict';
 
         return {
@@ -68,7 +70,6 @@ define(
 
                 payload = {
                     addressInformation: addressInformation,
-                    customerAttributes: quote.billingAddress().customAttributes,
                     additionInformation: additionInformation
                 };
 
diff --git a/view/frontend/web/js/view/authentication.js b/view/frontend/web/js/view/authentication.js
deleted file mode 100644
index 40d92f9..0000000
--- a/view/frontend/web/js/view/authentication.js
+++ /dev/null
@@ -1,109 +0,0 @@
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
-/*jshint browser:true jquery:true*/
-/*global alert*/
-define(
-    [
-        'jquery',
-        'ko',
-        'uiComponent',
-        'Magento_Customer/js/action/login',
-        'Magento_Customer/js/model/customer',
-        'mage/translate',
-        'Magento_Ui/js/modal/modal',
-        'Magento_Checkout/js/model/authentication-messages',
-        'mage/validation'
-    ],
-    function ($, ko, Component, loginAction, customer, $t, modal, messageContainer) {
-        'use strict';
-
-        var checkoutConfig = window.checkoutConfig;
-
-        return Component.extend({
-            registerUrl: checkoutConfig.registerUrl,
-            forgotPasswordUrl: checkoutConfig.forgotPasswordUrl,
-            autocomplete: checkoutConfig.autocomplete,
-            modalWindow: null,
-            isLoading: ko.observable(false),
-
-            defaults: {
-                template: 'Mageplaza_Osc/container/authentication'
-            },
-
-            /**
-             * Init
-             */
-            initialize: function () {
-                var self = this;
-                this._super();
-                loginAction.registerLoginCallback(function () {
-                    self.isLoading(false);
-                });
-            },
-
-            /** Init popup login window */
-            setModalElement: function (element) {
-                this.modalWindow = element;
-                var options = {
-                    'type': 'popup',
-                    'title': $t('Sign In'),
-                    'modalClass': 'popup-authentication',
-                    'responsive': true,
-                    'innerScroll': true,
-                    'trigger': '.osc-authentication-toggle',
-                    'buttons': []
-                };
-                modal(options, $(this.modalWindow));
-            },
-
-            /** Is login form enabled for current customer */
-            isActive: function () {
-                return !customer.isLoggedIn();
-            },
-
-            /** Show login popup window */
-            showModal: function () {
-                $(this.modalWindow).modal('openModal');
-            },
-
-            /** Provide login action */
-            login: function (loginForm) {
-                var loginData = {},
-                    formDataArray = $(loginForm).serializeArray();
-                formDataArray.forEach(function (entry) {
-                    loginData[entry.name] = entry.value;
-                });
-
-                if ($(loginForm).validation() &&
-                    $(loginForm).validation('isValid')
-                ) {
-                    this.isLoading(true);
-                    loginAction(loginData, null, false, messageContainer)
-                        .done(function (response) {
-                            if (!response.errors) {
-                                messageContainer.addSuccessMessage({'message': $t('Login successfully. Please wait...')});
-                            }
-                        });
-                }
-            }
-        });
-    }
-);
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 1e171ca..e3d1712 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -36,34 +36,34 @@ define(
         'Magento_Checkout/js/model/checkout-data-resolver',
         'Mageplaza_Osc/js/model/address/auto-complete',
         'uiRegistry',
-        'mage/translate',
         'rjsResolver'
     ],
-    function ($,
-              ko,
-              Component,
-              quote,
-              checkoutData,
-              oscData,
-              createBillingAddress,
-              selectBillingAddress,
-              customer,
-              setBillingAddressAction,
-              addressConverter,
-              additionalValidators,
-              globalMessageList,
-              checkoutDataResolver,
-              addressAutoComplete,
-              registry,
-              $t,
-              resolver) {
+    function (
+        $,
+        ko,
+        Component,
+        quote,
+        checkoutData,
+        oscData,
+        createBillingAddress,
+        selectBillingAddress,
+        customer,
+        setBillingAddressAction,
+        addressConverter,
+        additionalValidators,
+        globalMessageList,
+        checkoutDataResolver,
+        addressAutoComplete,
+        registry,
+        resolver
+    ) {
         'use strict';
 
         var observedElements = [];
 
         return Component.extend({
             defaults: {
-                template: ''
+                template: 'Mageplaza_Osc/container/address/billing-address'
             },
             quoteIsVirtual: quote.isVirtual(),
 
@@ -119,57 +119,34 @@ define(
              * @return {Boolean}
              */
             useShippingAddress: function () {
-                if (this.isAddressSameAsShipping()) {
-                    selectBillingAddress(quote.shippingAddress());
-                    checkoutData.setSelectedBillingAddress(null);
-                    if (window.checkoutConfig.reloadOnBillingAddress) {
-                        setBillingAddressAction(globalMessageList);
-                    }
-                } else {
-                    this.updateAddress();
-                }
-
-                return true;
-            },
+                var newBillingAddress, newBillingKey, newBillingAddressData;
 
-            onAddressChange: function (address) {
-                this._super(address);
-
-                if (!this.isAddressSameAsShipping()) {
-                    this.updateAddress();
-                }
-            },
-
-            /**
-             * Update address action
-             */
-            updateAddress: function () {
-                if (this.selectedAddress() && !this.isAddressFormVisible()) {
-                    newBillingAddress = createBillingAddress(this.selectedAddress());
-                    selectBillingAddress(newBillingAddress);
-                    checkoutData.setSelectedBillingAddress(this.selectedAddress().getKey());
-                    if (window.checkoutConfig.reloadOnBillingAddress) {
-                        setBillingAddressAction(globalMessageList);
-                    }
+                if (this.isAddressSameAsShipping()) {
+                    newBillingAddress = quote.shippingAddress();
+                    newBillingKey = null;
+                    newBillingAddressData = null;
                 } else {
-                    var addressData = this.source.get(this.dataScopePrefix),
-                        newBillingAddress;
+                    var addressData = this.source.get(this.dataScopePrefix);
 
                     if (customer.isLoggedIn() && !this.customerHasAddresses) {
                         this.saveInAddressBook(1);
                     }
+
                     addressData.save_in_address_book = this.saveInAddressBook() ? 1 : 0;
                     newBillingAddress = createBillingAddress(addressData);
+                    newBillingKey = newBillingAddress.getKey();
+                    newBillingAddressData = addressData;
+                }
 
-                    // New address must be selected as a billing address
-                    selectBillingAddress(newBillingAddress);
-                    checkoutData.setSelectedBillingAddress(newBillingAddress.getKey());
-                    checkoutData.setNewCustomerBillingAddress(addressData);
+                selectBillingAddress(newBillingAddress);
+                checkoutData.setSelectedBillingAddress(newBillingKey);
+                checkoutData.setNewCustomerBillingAddress(newBillingAddressData);
 
-                    if (window.checkoutConfig.reloadOnBillingAddress) {
-                        setBillingAddressAction(globalMessageList);
-                    }
+                if (window.checkoutConfig.reloadOnBillingAddress) {
+                    setBillingAddressAction(globalMessageList);
                 }
+
+                return true;
             },
 
             /**
@@ -177,7 +154,7 @@ define(
              */
             initFields: function () {
                 var self = this,
-                    fieldsetName = 'checkout.steps.shipping-step.billingAddress.billing-address-fieldset';
+                    fieldsetName = 'checkout.steps.shipping-step.shippingAddress.billing-address-form.form-fields';
 
                 var elements = registry.async(fieldsetName)().elems();
 
@@ -237,10 +214,6 @@ define(
                     return true;
                 }
 
-                if (!this.isAddressFormVisible()) {
-                    return true;
-                }
-
                 this.source.set('params.invalid', false);
                 this.source.trigger('billingAddress.data.validate');
 
@@ -250,9 +223,6 @@ define(
 
                 oscData.setData('same_as_shipping', false);
                 return !this.source.get('params.invalid');
-            },
-            getAddressTemplate: function () {
-                return 'Mageplaza_Osc/container/address/billing-address';
             }
         });
     }
diff --git a/view/frontend/web/js/view/payment/discount.js b/view/frontend/web/js/view/payment/discount.js
deleted file mode 100644
index 764ca63..0000000
--- a/view/frontend/web/js/view/payment/discount.js
+++ /dev/null
@@ -1,37 +0,0 @@
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
-/*jshint browser:true jquery:true*/
-/*global alert*/
-define(
-    [
-        'ko',
-        'Magento_SalesRule/js/view/payment/discount'
-    ],
-    function (ko, Component) {
-        'use strict';
-
-        return Component.extend({
-            defaults: {
-                template: 'Mageplaza_Osc/container/review/discount'
-            }
-        });
-    }
-);
diff --git a/view/frontend/web/js/view/review/addition/gift-wrap.js b/view/frontend/web/js/view/review/addition/gift-wrap.js
deleted file mode 100644
index fb7b9f2..0000000
--- a/view/frontend/web/js/view/review/addition/gift-wrap.js
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
-define(
-    [
-        'jquery',
-        'ko',
-        'uiComponent',
-        'Magento_Checkout/js/model/quote',
-        'Magento_Checkout/js/model/totals',
-        'Magento_Catalog/js/price-utils',
-        'Mageplaza_Osc/js/action/gift-wrap'
-    ],
-    function ($,
-              ko,
-              Component,
-              quote,
-              totals,
-              priceUtils,
-              giftWrapAction) {
-        "use strict";
-
-        return Component.extend({
-            defaults: {
-                template: 'Mageplaza_Osc/container/review/addition/gift-wrap'
-            },
-            quoteIsVirtual: quote.isVirtual(),
-            initialAmount: ko.computed(function () {
-                var gwAmount = 0;
-
-                var gwSegment = totals.getSegment('osc_gift_wrap');
-                if (gwSegment && gwSegment.extension_attributes) {
-                    gwAmount = gwSegment.extension_attributes.gift_wrap_amount;
-                }
-
-                if (gwAmount > 0) {
-                    return priceUtils.formatPrice(gwAmount, quote.getPriceFormat());
-                }
-
-                return '';
-            }),
-            initObservable: function () {
-                this._super()
-                    .observe({
-                        isUseGiftWrap: window.checkoutConfig.oscConfig.isUsedGiftWrap
-                    });
-
-                this.isUseGiftWrap.subscribe(function (newValue) {
-                    var payload = {
-                        is_use_gift_wrap: newValue
-                    };
-
-                    giftWrapAction(payload);
-                });
-
-                return this;
-            }
-        });
-    }
-);
diff --git a/view/frontend/web/js/view/review/placeOrder.js b/view/frontend/web/js/view/review/placeOrder.js
index d4223aa..dfd9b1f 100644
--- a/view/frontend/web/js/view/review/placeOrder.js
+++ b/view/frontend/web/js/view/review/placeOrder.js
@@ -42,7 +42,6 @@ define(
                 var self = this;
                 if (additionalValidators.validate()) {
                     $.when(setCheckoutInformationAction()).done(function () {
-                        $("body").animate({ scrollTop: 0 }, "slow");
                         self._placeOrder();
                     });
                 }
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index 858b7cf..c76bb09 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -38,23 +38,25 @@ define(
         'Mageplaza_Osc/js/model/address/auto-complete',
         'rjsResolver'
     ],
-    function ($,
-              Component,
-              quote,
-              customer,
-              setShippingInformationAction,
-              getPaymentTotalInformation,
-              stepNavigator,
-              additionalValidators,
-              checkoutData,
-              selectBillingAddress,
-              selectShippingAddress,
-              addressConverter,
-              shippingRateService,
-              shippingService,
-              oscDataResolver,
-              addressAutoComplete,
-              resolver) {
+    function (
+        $,
+        Component,
+        quote,
+        customer,
+        setShippingInformationAction,
+        getPaymentTotalInformation,
+        stepNavigator,
+        additionalValidators,
+        checkoutData,
+        selectBillingAddress,
+        selectShippingAddress,
+        addressConverter,
+        shippingRateService,
+        shippingService,
+        oscDataResolver,
+        addressAutoComplete,
+        resolver
+    ) {
         'use strict';
 
         oscDataResolver.resolveDefaultShippingMethod();
@@ -160,7 +162,8 @@ define(
                         _.isEqual(shippingAddress[field], addressData[field])
                     ) {
                         shippingAddress[field] = addressData[field];
-                    } else if (typeof addressData[field] != 'function' && !_.isEqual(shippingAddress[field], addressData[field])) {
+                    } else if (typeof addressData[field] != 'function' &&
+                        !_.isEqual(shippingAddress[field], addressData[field])) {
                         shippingAddress = addressData;
                         break;
                     }
@@ -170,26 +173,6 @@ define(
                     shippingAddress.save_in_address_book = 1;
                 }
                 selectShippingAddress(shippingAddress);
-            },
-
-            saveNewAddress: function () {
-                this.source.set('params.invalid', false);
-                if (this.source.get('shippingAddress.custom_attributes')) {
-                    this.source.trigger('shippingAddress.custom_attributes.data.validate');
-                }
-
-                if (!this.source.get('params.invalid')) {
-                    this._super();
-                }
-
-                if (!this.source.get('params.invalid')) {
-                    shippingRateService.isAddressChange = true;
-                    shippingRateService.estimateShippingMethod();
-                }
-            },
-
-            getAddressTemplate: function () {
-                return 'Mageplaza_Osc/container/address/shipping-address';
             }
         });
     }
diff --git a/view/frontend/web/js/view/summary/gift-wrap.js b/view/frontend/web/js/view/summary/gift-wrap.js
deleted file mode 100644
index 9e51618..0000000
--- a/view/frontend/web/js/view/summary/gift-wrap.js
+++ /dev/null
@@ -1,55 +0,0 @@
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
-/*jshint browser:true jquery:true*/
-/*global alert*/
-define(
-    [
-        'ko',
-        'Magento_Checkout/js/view/summary/abstract-total',
-        'Magento_Checkout/js/model/quote',
-        'Magento_Checkout/js/model/totals'
-    ],
-    function (ko, Component, quote, totals) {
-        "use strict";
-
-        return Component.extend({
-            defaults: {
-                template: 'Mageplaza_Osc/container/summary/gift-wrap'
-            },
-            totals: quote.getTotals(),
-            isDisplay: function () {
-                return this.getPureValue() > 0;
-            },
-            getPureValue: function () {
-                var giftWrapAmount = 0;
-
-                if (this.totals() && totals.getSegment('osc_gift_wrap')) {
-                    giftWrapAmount = parseFloat(totals.getSegment('osc_gift_wrap').value);
-                }
-
-                return giftWrapAmount;
-            },
-            getValue: function () {
-                return this.getFormattedPrice(this.getPureValue());
-            }
-        });
-    }
-);
diff --git a/view/frontend/web/js/view/summary/item/details.js b/view/frontend/web/js/view/summary/item/details.js
index d30e81e..57e1ca8 100644
--- a/view/frontend/web/js/view/summary/item/details.js
+++ b/view/frontend/web/js/view/summary/item/details.js
@@ -20,19 +20,19 @@
 
 define(
     [
-        'underscore',
         'jquery',
         'Magento_Checkout/js/view/summary/item/details',
         'Magento_Checkout/js/model/quote',
         'Mageplaza_Osc/js/action/update-item',
         'mage/url'
     ],
-    function (_,
-              $,
-              Component,
-              quote,
-              updateItemAction,
-              url) {
+    function (
+        $,
+        Component,
+        quote,
+        updateItemAction,
+        url
+    ) {
         "use strict";
 
         var products = window.checkoutConfig.quoteItemData;
@@ -43,7 +43,7 @@ define(
             },
 
             getProductUrl: function (parent) {
-                var item = _.find(products, function (product) {
+                var item = products.find(function (product) {
                     return product.item_id == parent.item_id;
                 });
 
@@ -91,7 +91,7 @@ define(
              */
             changeQty: function (item, event) {
                 var target = $(event.target);
-                var qty = parseInt(target.val());
+                var qty = parseInt(target.val()) ;
                 var itemId = parseInt(target.attr("id"));
 
                 this.updateItem(itemId, qty);
diff --git a/view/frontend/web/template/1column.html b/view/frontend/web/template/1column.html
index cc3fe77..7ea5234 100644
--- a/view/frontend/web/template/1column.html
+++ b/view/frontend/web/template/1column.html
@@ -19,11 +19,12 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<!-- ko foreach: getRegion('estimation') -->
+
+<!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
-<!-- ko foreach: getRegion('authentication') -->
+<!-- ko foreach: getRegion('estimation') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
@@ -34,25 +35,35 @@
 <div class="opc-wrapper one-step-checkout-wrapper">
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-lg-7 mp-6 mp-xs-12">
-            <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.billing-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
+            <div class="col-mp mp-12">
+                <!-- ko scope: requestChild('steps') -->
+                    <!-- ko scope: requestChild('shipping-step') -->
+                        <!-- ko scope: requestChild('shippingAddress') -->
+                            <!-- ko template: 'Mageplaza_Osc/container/address/shipping-address' --><!-- /ko -->
+                        <!--/ko-->
+                    <!--/ko-->
+                <!--/ko-->
+            </div>
+            <div class="col-mp mp-12">
+                <!-- ko scope: requestChild('steps') -->
+                    <!-- ko scope: requestChild('shipping-step') -->
+                        <!-- ko template: getTemplate() --><!-- /ko -->
+                    <!--/ko-->
+                <!--/ko-->
+            </div>
+            <div class="col-mp mp-12">
+                <!-- ko scope: requestChild('steps') -->
+                    <!-- ko scope: requestChild('billing-step') -->
+                        <!-- ko template: getTemplate() --><!-- /ko -->
+                    <!--/ko-->
+                <!--/ko-->
+            </div>
+            <div class="col-mp mp-12">
+                <!-- ko foreach: getRegion('sidebar') -->
                     <!-- ko template: getTemplate() --><!-- /ko -->
-                </div>
-                <div class="mp-clear"></div>
+                <!--/ko-->
             </div>
+            <div class="mp-clear"></div>
         </div>
-        <div class="mp-clear"></div>
     </div>
 </div>
\ No newline at end of file
diff --git a/view/frontend/web/template/2columns.html b/view/frontend/web/template/2columns.html
index 91969f8..79bf88b 100644
--- a/view/frontend/web/template/2columns.html
+++ b/view/frontend/web/template/2columns.html
@@ -20,11 +20,11 @@
  */
 -->
 
-<!-- ko foreach: getRegion('estimation') -->
+<!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
-<!-- ko foreach: getRegion('authentication') -->
+<!-- ko foreach: getRegion('estimation') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
@@ -36,25 +36,38 @@
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-6 mp-sm-5 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
+                <div class="col-mp mp-12">
+                    <!-- ko scope: requestChild('steps') -->
+                        <!-- ko scope: requestChild('shipping-step') -->
+                            <!-- ko scope: requestChild('shippingAddress') -->
+                                <!-- ko template: 'Mageplaza_Osc/container/address/shipping-address' --><!-- /ko -->
+                            <!--/ko-->
+                        <!--/ko-->
+                    <!--/ko-->
                 </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-12">
+                    <!-- ko scope: requestChild('steps') -->
+                        <!-- ko scope: requestChild('shipping-step') -->
+                            <!-- ko template: getTemplate() --><!-- /ko -->
+                        <!--/ko-->
+                    <!--/ko-->
                 </div>
                 <div class="mp-clear"></div>
             </div>
         </div>
         <div class="col-mp mp-6 mp-sm-7 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.billing-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-12">
+                    <!-- ko scope: requestChild('steps') -->
+                        <!-- ko scope: requestChild('billing-step') -->
+                            <!-- ko template: getTemplate() --><!-- /ko -->
+                        <!--/ko-->
+                    <!--/ko-->
                 </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-12">
+                    <!-- ko foreach: getRegion('sidebar') -->
+                        <!-- ko template: getTemplate() --><!-- /ko -->
+                    <!--/ko-->
                 </div>
                 <div class="mp-clear"></div>
             </div>
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index 2ead188..af50f07 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -19,11 +19,12 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<!-- ko foreach: getRegion('estimation') -->
+
+<!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
-<!-- ko foreach: getRegion('authentication') -->
+<!-- ko foreach: getRegion('estimation') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
@@ -34,30 +35,37 @@
 <div class="opc-wrapper one-step-checkout-wrapper">
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
-            <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="mp-clear"></div>
-            </div>
+            <!-- ko scope: requestChild('steps') -->
+                <!-- ko scope: requestChild('shipping-step') -->
+                    <!-- ko scope: requestChild('shippingAddress') -->
+                        <!-- ko template: 'Mageplaza_Osc/container/address/shipping-address' --><!-- /ko -->
+                    <!--/ko-->
+                <!--/ko-->
+            <!--/ko-->
         </div>
         <div class="col-mp mp-8 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-6 mp-sm-12 mp-xs-12" data-bind="scope: 'checkout.steps.shipping-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-6 mp-sm-12 mp-xs-12">
+                    <!-- ko scope: requestChild('steps') -->
+                        <!-- ko scope: requestChild('shipping-step') -->
+                            <!-- ko template: getTemplate() --><!-- /ko -->
+                        <!--/ko-->
+                    <!--/ko-->
                 </div>
-                <div class="col-mp mp-6 mp-sm-12 mp-xs-12" data-bind="scope: 'checkout.steps.billing-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-6 mp-sm-12 mp-xs-12">
+                    <!-- ko scope: requestChild('steps') -->
+                        <!-- ko scope: requestChild('billing-step') -->
+                            <!-- ko template: getTemplate() --><!-- /ko -->
+                        <!--/ko-->
+                    <!--/ko-->
                 </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-12">
+                    <!-- ko foreach: getRegion('sidebar') -->
+                        <!-- ko template: getTemplate() --><!-- /ko -->
+                    <!--/ko-->
                 </div>
                 <div class="mp-clear"></div>
             </div>
         </div>
-        <div class="mp-clear"></div>
     </div>
 </div>
\ No newline at end of file
diff --git a/view/frontend/web/template/3columns.html b/view/frontend/web/template/3columns.html
index 4041273..96866b4 100644
--- a/view/frontend/web/template/3columns.html
+++ b/view/frontend/web/template/3columns.html
@@ -19,11 +19,12 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<!-- ko foreach: getRegion('estimation') -->
+
+<!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
-<!-- ko foreach: getRegion('authentication') -->
+<!-- ko foreach: getRegion('estimation') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
 
@@ -34,29 +35,37 @@
 <div class="opc-wrapper one-step-checkout-wrapper">
     <div class="opc one-step-checkout-container" id="checkoutSteps">
         <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
-            <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="mp-clear"></div>
-            </div>
+            <!-- ko scope: requestChild('steps') -->
+                <!-- ko scope: requestChild('shipping-step') -->
+                    <!-- ko scope: requestChild('shippingAddress') -->
+                        <!-- ko template: 'Mageplaza_Osc/container/address/shipping-address' --><!-- /ko -->
+                    <!--/ko-->
+                <!--/ko-->
+            <!--/ko-->
         </div>
         <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
             <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-12">
+                    <!-- ko scope: requestChild('steps') -->
+                        <!-- ko scope: requestChild('shipping-step') -->
+                            <!-- ko template: getTemplate() --><!-- /ko -->
+                        <!--/ko-->
+                    <!--/ko-->
                 </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.billing-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
+                <div class="col-mp mp-12">
+                    <!-- ko scope: requestChild('steps') -->
+                        <!-- ko scope: requestChild('billing-step') -->
+                            <!-- ko template: getTemplate() --><!-- /ko -->
+                        <!--/ko-->
+                    <!--/ko-->
                 </div>
                 <div class="mp-clear"></div>
             </div>
         </div>
-        <div class="col-mp mp-4 mp-sm-6 mp-xs-12" data-bind="scope: 'checkout.sidebar'">
-            <!-- ko template: getTemplate() --><!-- /ko -->
+        <div class="col-mp mp-4 mp-sm-6 mp-xs-12">
+            <!-- ko foreach: getRegion('sidebar') -->
+                <!-- ko template: getTemplate() --><!-- /ko -->
+            <!--/ko-->
         </div>
         <div class="mp-clear"></div>
     </div>
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index 0d44031..f19dd09 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -32,20 +32,8 @@
             <!--/ko-->
         <!--/ko-->
 
-        <!-- ko if: (addressOptions.length > 1) -->
-            <!-- ko template: 'Magento_Checkout/billing-address/list' --><!-- /ko -->
-        <!-- /ko -->
-
+        <!-- ko template: 'Magento_Checkout/billing-address/list' --><!-- /ko -->
         <!-- ko template: 'Magento_Checkout/billing-address/form' --><!-- /ko -->
-
-        <div class="mp-clear"></div>
-
-        <!-- ko ifnot: (isCustomerLoggedIn || !quoteIsVirtual) -->
-            <!-- ko foreach: getRegion('customer-email') -->
-                <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
-            <!--/ko-->
-        <!--/ko-->
-
-        <div class="mp-clear"></div>
     </div>
-</div>
\ No newline at end of file
+</div>
+<div class="mp-clear"></div>
\ No newline at end of file
diff --git a/view/frontend/web/template/container/address/billing/create.html b/view/frontend/web/template/container/address/billing/create.html
index 22d446c..a5b1a0b 100644
--- a/view/frontend/web/template/container/address/billing/create.html
+++ b/view/frontend/web/template/container/address/billing/create.html
@@ -20,7 +20,7 @@
  */
 -->
 
-<div class="create-account-block" data-bind="fadeVisible: isPasswordVisible() == false">
+<div class="create-account-block"  data-bind="fadeVisible: isPasswordVisible() == false">
     <div class="create-account-checkbox field choice col-mp mp-12" data-bind="visible: isCheckboxRegisterVisible">
         <input type="checkbox" name="create-account-checkbox" data-bind="checked: isRegisterVisible, attr: {id: 'create-account-checkbox'}"/>
         <label data-bind="attr: {for: 'create-account-checkbox'}">
@@ -28,33 +28,31 @@
         </label>
     </div>
     <fieldset class="fieldset hidden-fields mp-clear" data-bind="fadeVisible: isRegisterVisible">
-        <form class="form form-create-account" id="create-account-form">
-            <div class="field password required col-mp mp-6">
-                <label for="osc-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
-                <div class="control">
-                    <input type="password" name="password" id="osc-password"
-                           class="input-text"
-                           data-bind="
-                               attr: {
-                                    'data-password-min-length': dataPasswordMinLength,
-                                    'data-password-min-character-sets': dataPasswordMinCharacterSets
-                               },
-                               event: {change: function(){validate('password')}}"
-                           data-validate="{required:true, 'validate-customer-password':true}"
-                           autocomplete="off"/>
-                </div>
+        <div class="field password required col-mp mp-6">
+            <label for="osc-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
+            <div class="control">
+                <input type="password" name="password" id="osc-password"
+                       class="input-text"
+                       data-bind="
+                           attr: {
+                                'data-password-min-length': dataPasswordMinLength,
+                                'data-password-min-character-sets': dataPasswordMinCharacterSets
+                           },
+                           event: {change: function(){validate('password')}}"
+                       data-validate="{required:true, 'validate-customer-password':true}"
+                       autocomplete="off" />
             </div>
-            <div class="field confirmation required col-mp mp-6">
-                <label for="osc-password-confirmation" class="label"><span data-bind="i18n: 'Confirm Password'"></span></label>
-                <div class="control">
-                    <input type="password" name="password_confirmation" id="osc-password-confirmation"
-                           class="input-text"
-                           data-bind="event: {change: function(){validate('password-confirmation')}}"
-                           data-validate="{required:true, equalTo:'#osc-password'}"
-                           autocomplete="off"/>
-                </div>
+        </div>
+        <div class="field confirmation required col-mp mp-6">
+            <label for="osc-password-confirmation" class="label"><span data-bind="i18n: 'Confirm Password'"></span></label>
+            <div class="control">
+                <input type="password" name="password_confirmation" id="osc-password-confirmation"
+                       class="input-text"
+                       data-bind="event: {change: function(){validate('password-confirmation')}}"
+                       data-validate="{required:true, equalTo:'#osc-password'}"
+                       autocomplete="off" />
             </div>
-            <div class="mp-clear"></div>
-        </form>
+        </div>
+        <div class="mp-clear"></div>
     </fieldset>
 </div>
\ No newline at end of file
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index 10f373b..b28d9a0 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -50,7 +50,7 @@
                 class="action action-show-popup">
             <span data-bind="i18n: 'New Address'"></span></button>
         <div id="opc-new-shipping-address" data-bind="visible: isFormPopUpVisible()">
-            <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
+            <!-- ko template: 'Magento_Checkout/shipping-address/form' --><!-- /ko -->
         </div>
         <!-- /ko -->
 
@@ -63,18 +63,14 @@
         <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
         <!-- /ko -->
 
-        <!-- ko ifnot: (isCustomerLoggedIn || quoteIsVirtual) -->
-            <!-- ko foreach: getRegion('customer-email') -->
-                <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
-            <!--/ko-->
-        <!--/ko-->
-
-        <div class="mp-clear"></div>
-        
-        <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
+        <!-- ko foreach: getRegion('billing-address-form') -->
             <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
         <!--/ko-->
 
         <div class="mp-clear"></div>
     </div>
-</div>
\ No newline at end of file
+</div>
+
+<!-- ko foreach: getRegion('billing-address-form') -->
+<!-- ko template: getTemplate() --><!-- /ko -->
+<!--/ko-->
\ No newline at end of file
diff --git a/view/frontend/web/template/container/address/shipping/form.html b/view/frontend/web/template/container/address/shipping/form.html
index 2e661be..55a9eac 100644
--- a/view/frontend/web/template/container/address/shipping/form.html
+++ b/view/frontend/web/template/container/address/shipping/form.html
@@ -39,5 +39,13 @@
         <!-- /ko -->
 
         <div class="mp-clear"></div>
+
+        <!-- ko if: (!quoteIsVirtual) -->
+            <!-- ko foreach: getRegion('customer-email') -->
+                <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
+            <!--/ko-->
+        <!--/ko-->
+
+        <div class="mp-clear"></div>
     </div>
 </form>
diff --git a/view/frontend/web/template/container/authentication.html b/view/frontend/web/template/container/authentication.html
index 4925f32..1a4193a 100644
--- a/view/frontend/web/template/container/authentication.html
+++ b/view/frontend/web/template/container/authentication.html
@@ -20,70 +20,84 @@
  */
 -->
 
-<!-- ko if: isActive() -->
-<div class="osc-authentication-wrapper">
-    <a class="action action-auth-toggle osc-authentication-toggle">
+<div class="osc-authentication-wrapper" data-block="authentication" data-bind="visible: isActive()">
+    <a href="javascript:void(0)" class="action action-auth-toggle" data-trigger="authentication">
         <span data-bind="i18n: 'Already have an account? Click here to login'"></span>
     </a>
-</div>
-<div class="block-authentication"
-     data-bind="afterRender: setModalElement, blockLoader: isLoading"
-     style="display: none">
-    <div class="block block-customer-login"
-         data-bind="attr: {'data-label': $t('or')}">
-        <!-- ko foreach: getRegion('messages') -->
-        <!-- ko template: getTemplate() --><!-- /ko -->
-        <!--/ko-->
+    <div class="block-authentication"
+         style="display: none"
+         data-bind="mageInit: {
+            'Magento_Ui/js/modal/modal':{
+                'type': 'custom',
+                'modalClass': 'authentication-dropdown',
+                'trigger': '[data-trigger=authentication]',
+                'wrapperClass': 'osc-authentication-wrapper',
+                'parentModalClass': '_has-modal-custom _has-auth-shown',
+                'responsive': true,
+                'responsiveClass': 'custom-slide',
+                'overlayClass': 'dropdown-overlay modal-custom-overlay',
+                'buttons': []
+            }}">
         <!-- ko foreach: getRegion('before') -->
         <!-- ko template: getTemplate() --><!-- /ko -->
         <!-- /ko -->
-        <div class="block-content" aria-labelledby="block-customer-login-heading">
-            <form class="form form-login"
-                  method="post"
-                  data-bind="submit:login">
-                <div class="fieldset" data-bind="attr: {'data-hasrequired': $t('* Required Fields')}">
-                    <div class="field field-email required">
-                        <label class="label" for="login-email"><span data-bind="i18n: 'Email Address'"></span></label>
-                        <div class="control">
-                            <input type="email"
-                                   class="input-text"
-                                   id="login-email"
-                                   name="username"
-                                   data-bind="attr: {autocomplete: autocomplete}"
-                                   data-validate="{required:true, 'validate-email':true}" />
+        <div class="block block-customer-login"
+             data-bind="attr: {'data-label': $t('or')}">
+            <div class="block-title">
+                <strong id="block-customer-login-heading"
+                        role="heading"
+                        aria-level="2"
+                        data-bind="i18n: 'Sign In'"></strong>
+            </div>
+            <!-- ko foreach: getRegion('messages') -->
+            <!-- ko template: getTemplate() --><!-- /ko -->
+            <!--/ko-->
+            <div class="block-content" aria-labelledby="block-customer-login-heading">
+                <form data-role="login"
+                      data-bind="submit:login"
+                      method="post">
+                    <div class="fieldset"
+                         data-bind="attr: {'data-hasrequired': $t('* Required Fields')}">
+                        <div class="field field-email required">
+                            <label class="label" for="login-email"><span data-bind="i18n: 'Email Address'"></span></label>
+                            <div class="control">
+                                <input type="email"
+                                       class="input-text"
+                                       id="login-email"
+                                       name="username"
+                                       data-bind="attr: {autocomplete: autocomplete}"
+                                       data-validate="{required:true, 'validate-email':true}" />
+                            </div>
                         </div>
-                    </div>
-                    <div class="field field-password required">
-                        <label for="login-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
-                        <div class="control">
-                            <input type="password"
-                                   class="input-text"
-                                   id="login-password"
-                                   name="password"
-                                   data-bind="attr: {autocomplete: autocomplete}"
-                                   data-validate="{required:true}"
-                                   autocomplete="off"/>
+                        <div class="field field-password required">
+                            <label for="login-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
+                            <div class="control">
+                                <input type="password"
+                                       class="input-text"
+                                       id="login-password"
+                                       name="password"
+                                       data-bind="attr: {autocomplete: autocomplete}"
+                                       data-validate="{required:true}"
+                                       autocomplete="off"/>
+                            </div>
                         </div>
+                        <!-- ko foreach: getRegion('additional-login-form-fields') -->
+                        <!-- ko template: getTemplate() --><!-- /ko -->
+                        <!-- /ko -->
                     </div>
-                    <!-- ko foreach: getRegion('additional-login-form-fields') -->
-                    <!-- ko template: getTemplate() --><!-- /ko -->
-                    <!-- /ko -->
-                </div>
-                <div class="actions-toolbar">
-                    <input name="context" type="hidden" value="checkout" />
-                    <div class="primary">
-                        <button type="submit" class="action action-login secondary" name="send" id="send2">
-                            <span data-bind="i18n: 'Sign In'"></span>
-                        </button>
-                    </div>
-                    <div class="secondary">
-                        <a class="action" data-bind="attr: {href: forgotPasswordUrl}">
-                            <span data-bind="i18n: 'Forgot Your Password?'"></span>
-                        </a>
+                    <div class="actions-toolbar">
+                        <input name="context" type="hidden" value="checkout" />
+                        <div class="primary">
+                            <button type="submit" class="action action-login secondary"><span data-bind="i18n: 'Sign In'"></span></button>
+                        </div>
+                        <div class="secondary">
+                            <a class="action action-remind" data-bind="attr: { href: forgotPasswordUrl }">
+                                <span data-bind="i18n: 'Forgot Your Password?'"></span>
+                            </a>
+                        </div>
                     </div>
-                </div>
-            </form>
+                </form>
+            </div>
         </div>
     </div>
 </div>
-<!-- /ko -->
diff --git a/view/frontend/web/template/container/payment.html b/view/frontend/web/template/container/payment.html
index 5d67c42..d207f4d 100644
--- a/view/frontend/web/template/container/payment.html
+++ b/view/frontend/web/template/container/payment.html
@@ -37,7 +37,7 @@
             <fieldset class="fieldset">
                 <legend class="legend">
                     <span data-bind="i18n: 'Payment Information'"></span>
-                </legend>
+                </legend><br />
                 <!-- ko foreach: getRegion('beforeMethods') -->
                     <!-- ko template: getTemplate() --><!-- /ko -->
                 <!-- /ko -->
diff --git a/view/frontend/web/template/container/payment/discount.html b/view/frontend/web/template/container/payment/discount.html
new file mode 100644
index 0000000..9366731
--- /dev/null
+++ b/view/frontend/web/template/container/payment/discount.html
@@ -0,0 +1,64 @@
+<!--
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
+-->
+
+<div class="payment-option opc-payment-additional discount-code">
+    <div class="payment-option-title field choice" data-role="title">
+        <span class="action" id="block-discount-heading" role="heading" aria-level="2">
+            <!-- ko i18n: 'Apply Discount Code'--><!-- /ko -->
+        </span>
+    </div>
+    <div class="payment-option-content" data-role="content">
+        <!-- ko foreach: getRegion('messages') -->
+        <!-- ko template: getTemplate() --><!-- /ko -->
+        <!--/ko-->
+        <form class="form form-discount" id="discount-form" data-bind="blockLoader: isLoading">
+            <div class="payment-option-inner">
+                <div class="field">
+                    <label class="label" for="discount-code">
+                        <span data-bind="i18n: 'Enter discount code'"></span>
+                    </label>
+                    <div class="control">
+                        <input class="input-text"
+                               type="text"
+                               id="discount-code"
+                               name="discount_code"
+                               data-validate="{'required-entry':true}"
+                               data-bind="value: couponCode, attr:{placeholder: $t('Enter discount code')} " />
+                    </div>
+                    <div class="control">
+                        <!-- ko ifnot: isApplied() -->
+                            <button class="action action-apply" type="submit" data-bind="'value': $t('Apply Discount'), click: apply">
+                                <span><!-- ko i18n: 'Apply Discount'--><!-- /ko --></span>
+                            </button>
+                        <!-- /ko -->
+                        <!-- ko if: isApplied() -->
+                            <button class="action action-cancel" type="submit" data-bind="'value': $t('Cancel'), click: cancel">
+                                <span><!-- ko i18n: 'Cancel coupon'--><!-- /ko --></span>
+                            </button>
+                        <!-- /ko -->
+                    </div>
+                    <div class="mp-clear"></div>
+                </div>
+            </div>
+        </form>
+    </div>
+</div>
diff --git a/view/frontend/web/template/container/review/addition/gift-wrap.html b/view/frontend/web/template/container/review/addition/gift-wrap.html
deleted file mode 100644
index fedda4e..0000000
--- a/view/frontend/web/template/container/review/addition/gift-wrap.html
+++ /dev/null
@@ -1,32 +0,0 @@
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
-<!-- ko if: quoteIsVirtual == 0 -->
-<div class="osc-gift-wrap field choice col-mp mp-12">
-    <input type="checkbox" name="osc-gift-wrap" data-bind="attr: {id: 'osc-gift-wrap'}, checked: isUseGiftWrap" />
-    <label data-bind="attr: {for: 'osc-gift-wrap'}">
-        <span data-bind="i18n: 'Gift Wrap'"></span>
-        <i data-bind="html: initialAmount"></i>
-    </label>
-</div>
-<!-- /ko -->
-
diff --git a/view/frontend/web/template/container/review/comment.html b/view/frontend/web/template/container/review/comment.html
index d58b2fe..a9a6c08 100644
--- a/view/frontend/web/template/container/review/comment.html
+++ b/view/frontend/web/template/container/review/comment.html
@@ -22,7 +22,7 @@
 
 <div class="osc-place-order-block checkout-comment-block col-mp mp-12">
     <div class="field-row">
-        <label for="comments" data-bind="i18n: 'Comments'"></label>
+        <label for="comments" data-bind="i18n: 'Comments'"></label><br>
         <div class="input-box">
             <textarea name="comments" id="comments" rows="2" data-bind="value: commentValue"></textarea>
         </div>
diff --git a/view/frontend/web/template/container/review/discount.html b/view/frontend/web/template/container/review/discount.html
deleted file mode 100644
index ddb29e2..0000000
--- a/view/frontend/web/template/container/review/discount.html
+++ /dev/null
@@ -1,60 +0,0 @@
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
-<div class="osc-place-order-block checkout-comment-block col-mp mp-12">
-    <div class="field-row">
-        <label for="discount-code" data-bind="i18n: 'Apply Discount Code'"></label>
-        <div class="payment-option-content" data-role="content">
-            <!-- ko foreach: getRegion('messages') -->
-            <!-- ko template: getTemplate() --><!-- /ko -->
-            <!--/ko-->
-            <form class="form form-discount" id="discount-form" data-bind="blockLoader: isLoading">
-                <div class="payment-option-inner">
-                    <div class="field">
-                        <div class="control">
-                            <input class="input-text"
-                                   type="text"
-                                   id="discount-code"
-                                   name="discount_code"
-                                   data-validate="{'required-entry':true}"
-                                   data-bind="value: couponCode, attr:{placeholder: $t('Enter discount code')} "/>
-                        </div>
-                    </div>
-                </div>
-                <div class="actions-toolbar">
-                    <div class="primary">
-                        <!-- ko ifnot: isApplied() -->
-                            <button class="action action-apply" type="submit" data-bind="'value': $t('Apply Discount'), click: apply">
-                                <span><!-- ko i18n: 'Apply Discount'--><!-- /ko --></span>
-                            </button>
-                        <!-- /ko -->
-                        <!-- ko if: isApplied() -->
-                            <button class="action action-cancel" type="submit" data-bind="'value': $t('Cancel'), click: cancel">
-                                <span><!-- ko i18n: 'Cancel coupon'--><!-- /ko --></span>
-                            </button>
-                        <!-- /ko -->
-                    </div>
-                </div>
-            </form>
-        </div>
-    </div>
-</div>
diff --git a/view/frontend/web/template/container/review/place-order.html b/view/frontend/web/template/container/review/place-order.html
index ea6513f..8376de2 100644
--- a/view/frontend/web/template/container/review/place-order.html
+++ b/view/frontend/web/template/container/review/place-order.html
@@ -21,11 +21,9 @@
 -->
 
 <div class="checkout-agreements-block mp-12">
-    <form id="co-place-order-agreement" class="form" novalidate="novalidate">
-        <!-- ko foreach: getRegion('checkout-agreements') -->
-            <!-- ko template: getTemplate() --><!-- /ko -->
-        <!--/ko-->
-    </form>
+    <!-- ko foreach: getRegion('checkout-agreements') -->
+        <!-- ko template: getTemplate() --><!-- /ko -->
+    <!--/ko-->
 </div>
 <div class="actions-toolbar">
     <div class="place-order-primary">
diff --git a/view/frontend/web/template/container/sidebar.html b/view/frontend/web/template/container/sidebar.html
index 050bc05..4af0cef 100644
--- a/view/frontend/web/template/container/sidebar.html
+++ b/view/frontend/web/template/container/sidebar.html
@@ -32,7 +32,7 @@
         <!--/ko-->
     </div>
 
-    <div id="co-place-order-area">
+    <form id="co-place-order-form" class="form" novalidate="novalidate">
         <div class="osc-addition-content-wrapper col-mp mp-lg-6 mp-md-6 mp-sm-12 mp-xs-12">
             <!-- ko foreach: getRegion('place-order-information-left') -->
                 <!-- ko template: getTemplate() --><!-- /ko -->
@@ -44,5 +44,5 @@
             <!--/ko-->
         </div>
         <div class="mp-clear"></div>
-    </div>
+    </form>
 </div>
diff --git a/view/frontend/web/template/container/summary.html b/view/frontend/web/template/container/summary.html
index 4b16cae..ac804af 100644
--- a/view/frontend/web/template/container/summary.html
+++ b/view/frontend/web/template/container/summary.html
@@ -27,11 +27,4 @@
     <!-- ko foreach: elems() -->
         <!-- ko template: getTemplate() --><!-- /ko -->
     <!-- /ko -->
-
-    <p class="col-wide forgot-item" data-bind="style:{textAlign: 'right'}, visible: false">
-	    <span>
-	    	<!-- ko i18n: 'Forgot an item?'--><!-- /ko -->
-			<a data-bind="attr: {href: window.checkout.shoppingCartUrl}, i18n: 'Edit your cart'"></a>
-	    </span>
-	</p>
 </div>
