diff --git a/Api/CheckoutManagementInterface.php b/Api/CheckoutManagementInterface.php
index 55100a3..8095958 100644
--- a/Api/CheckoutManagementInterface.php
+++ b/Api/CheckoutManagementInterface.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Api/Data/OscDetailsInterface.php b/Api/Data/OscDetailsInterface.php
index fe45c9b..80d26db 100644
--- a/Api/Data/OscDetailsInterface.php
+++ b/Api/Data/OscDetailsInterface.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Api/GuestCheckoutManagementInterface.php b/Api/GuestCheckoutManagementInterface.php
index 1083b38..00a3cc7 100644
--- a/Api/GuestCheckoutManagementInterface.php
+++ b/Api/GuestCheckoutManagementInterface.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Adminhtml/Field/Position.php b/Block/Adminhtml/Field/Position.php
index 4dca4e1..8d6826f 100644
--- a/Block/Adminhtml/Field/Position.php
+++ b/Block/Adminhtml/Field/Position.php
@@ -15,26 +15,22 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block\Adminhtml\Field;
 
-use Magento\Backend\Block\Widget\Container;
-use Magento\Backend\Block\Widget\Context;
-use Mageplaza\Osc\Helper\Data as OscHelper;
-
 /**
  * Class Position
  * @package Mageplaza\Osc\Block\Adminhtml\Field
  */
-class Position extends Container
+class Position extends \Magento\Backend\Block\Widget\Container
 {
     /**
-     * @var OscHelper 
+     * @type \Mageplaza\Osc\Helper\Data
      */
-    protected $_oscHelper;
+    protected $_helper;
 
     /**
      * @type array
@@ -47,18 +43,17 @@ class Position extends Container
     protected $availableFields = [];
 
     /**
-     * Position constructor.
-     * @param Context $context
-     * @param OscHelper $oscHelper
+     * @param \Magento\Backend\Block\Widget\Context $context
+     * @param \Mageplaza\Osc\Helper\Data $helperData
      * @param array $data
      */
     public function __construct(
-        Context $context,
-        OscHelper $oscHelper,
+        \Magento\Backend\Block\Widget\Context $context,
+        \Mageplaza\Osc\Helper\Data $helperData,
         array $data = []
     )
     {
-        $this->_oscHelper = $oscHelper;
+        $this->_helper = $helperData;
 
         parent::__construct($context, $data);
     }
@@ -73,15 +68,22 @@ class Position extends Container
         $this->addButton(
             'save',
             [
-                'label' => __('Save Position'),
-                'class' => 'save primary',
+                'label'   => __('Save Position'),
+                'class'   => 'save primary',
                 'onclick' => 'saveOscPosition()'
             ],
             1
         );
 
-        /** Prepare collection */
-        list($this->sortedFields, $this->availableFields) = $this->getHelperData()->getAddressHelper()->getSortedField(false);
+        $this->prepareCollection();
+    }
+
+    /**
+     * @return array
+     */
+    public function prepareCollection()
+    {
+        list($this->sortedFields, $this->availableFields) = $this->getHelperData()->getConfig()->getSortedField(false);
     }
 
     /**
@@ -111,11 +113,11 @@ class Position extends Container
     }
 
     /**
-     * @return OscHelper
+     * @return \Mageplaza\Osc\Helper\Data
      */
     public function getHelperData()
     {
-        return $this->_oscHelper;
+        return $this->_helper;
     }
 
     /**
diff --git a/Block/Adminhtml/Plugin/OrderViewTabInfo.php b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
index 2953837..7b6e4fb 100644
--- a/Block/Adminhtml/Plugin/OrderViewTabInfo.php
+++ b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Adminhtml/System/Config/Geoip.php b/Block/Adminhtml/System/Config/Geoip.php
index e2e8954..21be16b 100644
--- a/Block/Adminhtml/System/Config/Geoip.php
+++ b/Block/Adminhtml/System/Config/Geoip.php
@@ -13,9 +13,10 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @category   Mageplaza
+ * @package    Mageplaza_Osc
+ * @version    3.0.0
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -24,7 +25,7 @@ namespace Mageplaza\Osc\Block\Adminhtml\System\Config;
 use Magento\Backend\Block\Template\Context;
 use Magento\Config\Block\System\Config\Form\Field;
 use Magento\Framework\Data\Form\Element\AbstractElement;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Data as HelperData;
 
 /**
  * Class Geoip
@@ -40,21 +41,21 @@ class Geoip extends Field
     /**
      * @type \Mageplaza\Osc\Helper\Data
      */
-    protected $_oscHelper;
+    protected $_helperData;
 
     /**
      * Geoip constructor.
      * @param \Magento\Backend\Block\Template\Context $context
-     * @param \Mageplaza\Osc\Helper\Data $oscHelper
+     * @param \Mageplaza\Osc\Helper\Data $helperData
      * @param array $data
      */
     public function __construct(
         Context $context,
-        OscHelper $oscHelper,
+        HelperData $helperData,
         array $data = []
     )
     {
-        $this->_oscHelper = $oscHelper;
+        $this->_helperData = $helperData;
         parent::__construct($context, $data);
     }
 
@@ -95,8 +96,7 @@ class Geoip extends Field
     /**
      * Generate collect button html
      *
-     * @return mixed
-     * @throws \Magento\Framework\Exception\LocalizedException
+     * @return string
      */
     public function getButtonHtml()
     {
@@ -104,7 +104,7 @@ class Geoip extends Field
             'Magento\Backend\Block\Widget\Button'
         )->setData(
             [
-                'id' => 'geoip_button',
+                'id'    => 'geoip_button',
                 'label' => __('Download Library'),
             ]
         );
@@ -117,7 +117,7 @@ class Geoip extends Field
      */
     public function isDisplayIcon()
     {
-        return $this->_oscHelper->getAddressHelper()->checkHasLibrary() ? '' : 'hidden="hidden';
+        return $this->_helperData->checkHasLibrary() ? '' : 'hidden="hidden';
     }
 
 }
\ No newline at end of file
diff --git a/Block/Checkout/CompatibleConfig.php b/Block/Checkout/CompatibleConfig.php
index b34fb6f..cdd1908 100644
--- a/Block/Checkout/CompatibleConfig.php
+++ b/Block/Checkout/CompatibleConfig.php
@@ -15,14 +15,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block\Checkout;
 
 use Magento\Framework\View\Element\Template;
-use Mageplaza\Osc\Helper\Data as OscHelper;
 
 /**
  * Class CompatibleConfig
@@ -36,25 +35,24 @@ class CompatibleConfig extends Template
     protected $_template = "onepage/compatible-config.phtml";
 
     /**
-     * @var OscHelper
+     * @var \Mageplaza\Osc\Helper\Config
      */
-    protected $_oscHelper;
+    protected $_oscConfig;
 
     /**
      * CompatibleConfig constructor.
      * @param Template\Context $context
-     * @param OscHelper $oscHelper
      * @param array $data
      */
     public function __construct(
         Template\Context $context,
-        OscHelper $oscHelper,
+        \Mageplaza\Osc\Helper\Config $oscConfig,
         array $data = []
     )
     {
         parent::__construct($context, $data);
 
-        $this->_oscHelper = $oscHelper;
+        $this->_oscConfig = $oscConfig;
     }
 
     /**
@@ -62,6 +60,6 @@ class CompatibleConfig extends Template
      */
     public function isEnableModulePostNL()
     {
-        return $this->_oscHelper->isEnableModulePostNL();
+        return $this->_oscConfig->isEnableModulePostNL();
     }
 }
\ No newline at end of file
diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index c0920d8..c1f8d80 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -15,369 +15,362 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block\Checkout;
 
 use Magento\Checkout\Block\Checkout\AttributeMerger;
-use Magento\Checkout\Block\Checkout\LayoutProcessorInterface;
 use Magento\Checkout\Model\Session as CheckoutSession;
 use Magento\Customer\Model\AttributeMetadataDataProvider;
 use Magento\Framework\App\ObjectManager;
 use Magento\Ui\Component\Form\AttributeMapper;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as OscHelper;
 
 /**
  * Class LayoutProcessor
  * @package Mageplaza\Osc\Block\Checkout
  */
-class LayoutProcessor implements LayoutProcessorInterface
+class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcessorInterface
 {
-    /**
-     * @var OscHelper
-     */
-    private $_oscHelper;
-
-    /**
-     * @var \Magento\Customer\Model\AttributeMetadataDataProvider
-     */
-    private $attributeMetadataDataProvider;
-
-    /**
-     * @var \Magento\Ui\Component\Form\AttributeMapper
-     */
-    protected $attributeMapper;
-
-    /**
-     * @var \Magento\Checkout\Block\Checkout\AttributeMerger
-     */
-    protected $merger;
-
-    /**
-     * @var \Magento\Customer\Model\Options
-     */
-    private $options;
-
-    /**
-     * @type \Magento\Checkout\Model\Session
-     */
-    private $checkoutSession;
-
-    /**
-     * LayoutProcessor constructor.
-     * @param CheckoutSession $checkoutSession
-     * @param OscHelper $oscHelper
-     * @param AttributeMetadataDataProvider $attributeMetadataDataProvider
-     * @param AttributeMapper $attributeMapper
-     * @param AttributeMerger $merger
-     */
-    public function __construct(
-        CheckoutSession $checkoutSession,
-        OscHelper $oscHelper,
-        AttributeMetadataDataProvider $attributeMetadataDataProvider,
-        AttributeMapper $attributeMapper,
-        AttributeMerger $merger
-    )
-    {
-        $this->checkoutSession = $checkoutSession;
-        $this->_oscHelper = $oscHelper;
-        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-        $this->attributeMapper = $attributeMapper;
-        $this->merger = $merger;
-    }
-
-    /**
-     * Process js Layout of block
-     *
-     * @param array $jsLayout
-     * @return array
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    public function process($jsLayout)
-    {
-        if (!$this->_oscHelper->isOscPage()) {
-            return $jsLayout;
-        }
-
-        /** Shipping address fields */
-        if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
-            ['children']['shippingAddress']['children']['shipping-address-fieldset']['children'])) {
-            $fields = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-            ['children']['shipping-address-fieldset']['children'];
-            $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-            ['children']['shipping-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'shippingAddress');
-        }
-
-        /** Billing address fields */
-        if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
-            ['children']['billingAddress']['children']['billing-address-fieldset']['children'])) {
-            $fields = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
-            ['children']['billing-address-fieldset']['children'];
-            $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
-            ['children']['billing-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'billingAddress');
-        }
-
-        /** Remove billing customer email if quote is not virtual */
-        if (!$this->checkoutSession->getQuote()->isVirtual()) {
-            unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
-                ['children']['customer-email']);
-        }
-
-        /** Remove billing address in payment method content */
-        $fields = &$jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
-        ['payment']['children']['payments-list']['children'];
-        foreach ($fields as $code => $field) {
-            if ($field['component'] == 'Magento_Checkout/js/view/billing-address') {
-                unset($fields[$code]);
-            }
-        }
-
-        return $jsLayout;
-    }
-
-    /**
-     * Get address fieldset for shipping/billing address
-     *
-     * @param $fields
-     * @param $type
-     * @return array
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    public function getAddressFieldset($fields, $type)
-    {
-        $elements = $this->getAddressAttributes();
-
-        $systemAttribute = $elements['default'];
-        if (sizeof($systemAttribute)) {
-            $attributesToConvert = [
-                'prefix' => [$this->getOptions(), 'getNamePrefixOptions'],
-                'suffix' => [$this->getOptions(), 'getNameSuffixOptions'],
-            ];
-            $systemAttribute = $this->convertElementsToSelect($systemAttribute, $attributesToConvert);
-            $fields = $this->merger->merge(
-                $systemAttribute,
-                'checkoutProvider',
-                $type,
-                $fields
-            );
-        }
-
-        $customAttribute = $elements['custom'];
-        if (sizeof($customAttribute)) {
-            $fields = $this->merger->merge(
-                $customAttribute,
-                'checkoutProvider',
-                $type . '.custom_attributes',
-                $fields
-            );
-        }
-
-        $this->addCustomerAttribute($fields, $type);
-        $this->addAddressOption($fields);
-
-
-        return $fields;
-    }
-
-    /**
-     * Add customer attribute like gender, dob, taxvat
-     *
-     * @param $fields
-     * @param $type
-     * @return $this
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    private function addCustomerAttribute(&$fields, $type)
-    {
-        $attributes = $this->attributeMetadataDataProvider->loadAttributesCollection(
-            'customer',
-            'customer_account_create'
-        );
-        $addressElements = [];
-        foreach ($attributes as $attribute) {
-            if (!$this->_oscHelper->getAddressHelper()->isCustomerAttributeVisible($attribute)) {
-                continue;
-            }
-            $addressElements[$attribute->getAttributeCode()] = $this->attributeMapper->map($attribute);
-        }
-
-        $fields = $this->merger->merge(
-            $addressElements,
-            'checkoutProvider',
-            $type . '.custom_attributes',
-            $fields
-        );
-
-        return $this;
-    }
-
-    /**
-     * @param $fields
-     * @return $this
-     */
-    private function addAddressOption(&$fields)
-    {
-        $fieldPosition = $this->_oscHelper->getAddressHelper()->getAddressFieldPosition();
-
-        $this->rewriteFieldStreet($fields);
-
-        foreach ($fields as $code => &$field) {
-            $fieldConfig = isset($fieldPosition[$code]) ? $fieldPosition[$code] : [];
-            if (!sizeof($fieldConfig)) {
-                if (in_array($code, ['country_id'])) {
-                    $field['config']['additionalClasses'] = "mp-hidden";
-                    continue;
-                } else {
-                    unset($fields[$code]);
-                }
-            } else {
-                $oriClasses = isset($field['config']['additionalClasses']) ? $field['config']['additionalClasses'] : '';
-                $field['config']['additionalClasses'] = "{$oriClasses} col-mp mp-{$fieldConfig['colspan']}" . ($fieldConfig['isNewRow'] ? ' mp-clear' : '');
-                $field['sortOrder'] = $fieldConfig['sortOrder'];
-                if ($code == 'dob') {
-                    $field['options'] = ['yearRange' => '-120y:c+nn', 'maxDate' => '-1d', 'changeMonth' => true, 'changeYear' => true];
-                }
-
-                $this->rewriteTemplate($field);
-            }
-        }
-        /**
-         * Compatible Amazon Pay
-         */
-        if ($this->_oscHelper->isEnableAmazonPay()) {
-            $fields['inline-form-manipulator'] = array(
-                'component' => 'Mageplaza_Osc/js/view/amazon'
-            );
-
-        }
-
-        return $this;
-    }
-
-    /**
-     * Change template to remove valueUpdate = 'keyup'
-     *
-     * @param $field
-     * @param string $template
-     * @return $this
-     */
-    public function rewriteTemplate(&$field, $template = 'Mageplaza_Osc/container/form/element/input')
-    {
-        if (isset($field['type']) && $field['type'] == 'group') {
-            foreach ($field['children'] as $key => &$child) {
-                if ($key == 0 && in_array('street', explode('.', $field['dataScope'])) && $this->_oscHelper->isGoogleHttps()) {
-                    $this->rewriteTemplate($child, 'Mageplaza_Osc/container/form/element/street');
-                    continue;
-                }
-                $this->rewriteTemplate($child);
-            }
-        } elseif (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
-            $field['config']['elementTmpl'] = $template;
-            if ($this->_oscHelper->isUsedMaterialDesign()) {
-                $field['config']['template'] = 'Mageplaza_Osc/container/form/field';
-            }
-        }
-
-        return $this;
-    }
-
-    /**
-     * Change template street when enable material design
-     * @param $fields
-     * @return $this
-     */
-    public function rewriteFieldStreet(&$fields)
-    {
-
-        if ($this->_oscHelper->isUsedMaterialDesign()) {
-            $fields['country_id']['config']['template'] = 'Mageplaza_Osc/container/form/field';
-            $fields['region_id']['config']['template'] = 'Mageplaza_Osc/container/form/field';
-            foreach ($fields['street']['children'] as $key => $value) {
-                $fields['street']['children'][0]['label'] = $fields['street']['label'];
-                $fields['street']['children'][$key]['config']['template'] = 'Mageplaza_Osc/container/form/field';
-            }
-            $fields['street']['config']['fieldTemplate'] = 'Mageplaza_Osc/container/form/field';
-            unset($fields['street']['label']);
-        }
-
-        return $this;
-    }
-
-    /**
-     * @return \Magento\Customer\Model\Options
-     */
-    private function getOptions()
-    {
-        if (!is_object($this->options)) {
-            $this->options = ObjectManager::getInstance()->get(\Magento\Customer\Model\Options::class);
-        }
-
-        return $this->options;
-    }
-
-    /**
-     * @return array
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    private function getAddressAttributes()
-    {
-        /** @var \Magento\Eav\Api\Data\AttributeInterface[] $attributes */
-        $attributes = $this->attributeMetadataDataProvider->loadAttributesCollection(
-            'customer_address',
-            'customer_register_address'
-        );
-
-        $elements = [
-            'custom' => [],
-            'default' => []
-        ];
-        foreach ($attributes as $attribute) {
-            $code = $attribute->getAttributeCode();
-            $element = $this->attributeMapper->map($attribute);
-            if (isset($element['label'])) {
-                $label = $element['label'];
-                $element['label'] = __($label);
-            }
-
-            ($attribute->getIsUserDefined()) ?
-                $elements['custom'][$code] = $element :
-                $elements['default'][$code] = $element;
-        }
-
-        return $elements;
-    }
-
-    /**
-     * Convert elements(like prefix and suffix) from inputs to selects when necessary
-     *
-     * @param array $elements address attributes
-     * @param array $attributesToConvert fields and their callbacks
-     * @return array
-     */
-    private function convertElementsToSelect($elements, $attributesToConvert)
-    {
-        $codes = array_keys($attributesToConvert);
-        foreach (array_keys($elements) as $code) {
-            if (!in_array($code, $codes)) {
-                continue;
-            }
-            $options = call_user_func($attributesToConvert[$code]);
-            if (!is_array($options)) {
-                continue;
-            }
-            $elements[$code]['dataType'] = 'select';
-            $elements[$code]['formElement'] = 'select';
-
-            foreach ($options as $key => $value) {
-                $elements[$code]['options'][] = [
-                    'value' => $key,
-                    'label' => $value,
-                ];
-            }
-        }
-
-        return $elements;
-    }
+	/**
+	 * @type \Mageplaza\Osc\Helper\Config
+	 */
+	private $_oscHelper;
+
+	/**
+	 * @var \Magento\Customer\Model\AttributeMetadataDataProvider
+	 */
+	private $attributeMetadataDataProvider;
+
+	/**
+	 * @var \Magento\Ui\Component\Form\AttributeMapper
+	 */
+	protected $attributeMapper;
+
+	/**
+	 * @var \Magento\Checkout\Block\Checkout\AttributeMerger
+	 */
+	protected $merger;
+
+	/**
+	 * @var \Magento\Customer\Model\Options
+	 */
+	private $options;
+
+	/**
+	 * @type \Magento\Checkout\Model\Session
+	 */
+	private $checkoutSession;
+
+	/**
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Mageplaza\Osc\Helper\Config $oscHelper
+	 * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+	 * @param \Magento\Ui\Component\Form\AttributeMapper $attributeMapper
+	 * @param \Magento\Checkout\Block\Checkout\AttributeMerger $merger
+	 */
+	public function __construct(
+		CheckoutSession $checkoutSession,
+		OscHelper $oscHelper,
+		AttributeMetadataDataProvider $attributeMetadataDataProvider,
+		AttributeMapper $attributeMapper,
+		AttributeMerger $merger
+	)
+	{
+		$this->checkoutSession               = $checkoutSession;
+		$this->_oscHelper                    = $oscHelper;
+		$this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
+		$this->attributeMapper               = $attributeMapper;
+		$this->merger                        = $merger;
+	}
+
+	/**
+	 * Process js Layout of block
+	 *
+	 * @param array $jsLayout
+	 * @return array
+	 */
+	public function process($jsLayout)
+	{
+		if (!$this->_oscHelper->isOscPage()) {
+			return $jsLayout;
+		}
+
+		/** Shipping address fields */
+		if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+			['children']['shippingAddress']['children']['shipping-address-fieldset']['children'])) {
+			$fields                                               = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+			['children']['shipping-address-fieldset']['children'];
+			$jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+			['children']['shipping-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'shippingAddress');
+		}
+
+		/** Billing address fields */
+		if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+			['children']['billingAddress']['children']['billing-address-fieldset']['children'])) {
+			$fields                                              = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
+			['children']['billing-address-fieldset']['children'];
+			$jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
+			['children']['billing-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'billingAddress');
+		}
+
+		/** Remove billing customer email if quote is not virtual */
+		if (!$this->checkoutSession->getQuote()->isVirtual()) {
+			unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
+				['children']['customer-email']);
+		}
+
+		/** Remove billing address in payment method content */
+		$fields = &$jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
+		['payment']['children']['payments-list']['children'];
+		foreach ($fields as $code => $field) {
+			if ($field['component'] == 'Magento_Checkout/js/view/billing-address') {
+				unset($fields[$code]);
+			}
+		}
+
+		return $jsLayout;
+	}
+
+	/**
+	 * Get address fieldset for shipping/billing address
+	 *
+	 * @param $fields
+	 * @return array
+	 */
+	public function getAddressFieldset($fields, $type)
+	{
+		$elements = $this->getAddressAttributes();
+
+		$systemAttribute = $elements['default'];
+		if (sizeof($systemAttribute)) {
+			$attributesToConvert = [
+				'prefix' => [$this->getOptions(), 'getNamePrefixOptions'],
+				'suffix' => [$this->getOptions(), 'getNameSuffixOptions'],
+			];
+			$systemAttribute     = $this->convertElementsToSelect($systemAttribute, $attributesToConvert);
+			$fields              = $this->merger->merge(
+				$systemAttribute,
+				'checkoutProvider',
+				$type,
+				$fields
+			);
+		}
+
+		$customAttribute = $elements['custom'];
+		if (sizeof($customAttribute)) {
+			$fields = $this->merger->merge(
+				$customAttribute,
+				'checkoutProvider',
+				$type . '.custom_attributes',
+				$fields
+			);
+		}
+
+		$this->addCustomerAttribute($fields, $type);
+		$this->addAddressOption($fields);
+
+
+		return $fields;
+	}
+
+	/**
+	 * Add customer attribute like gender, dob, taxvat
+	 *
+	 * @param $fields
+	 * @param $type
+	 * @return $this
+	 */
+	private function addCustomerAttribute(&$fields, $type)
+	{
+		$attributes      = $this->attributeMetadataDataProvider->loadAttributesCollection(
+			'customer',
+			'customer_account_create'
+		);
+		$addressElements = [];
+		foreach ($attributes as $attribute) {
+			if (!$this->_oscHelper->isCustomerAttributeVisible($attribute)) {
+				continue;
+			}
+			$addressElements[$attribute->getAttributeCode()] = $this->attributeMapper->map($attribute);
+		}
+
+		$fields = $this->merger->merge(
+			$addressElements,
+			'checkoutProvider',
+			$type . '.custom_attributes',
+			$fields
+		);
+
+		return $this;
+	}
+
+	/**
+	 * @param $fields
+	 * @return $this
+	 */
+	private function addAddressOption(&$fields)
+	{
+		$fieldPosition = $this->_oscHelper->getAddressFieldPosition();
+
+		$this->rewriteFieldStreet($fields);
+
+		foreach ($fields as $code => &$field) {
+			$fieldConfig = isset($fieldPosition[$code]) ? $fieldPosition[$code] : [];
+			if (!sizeof($fieldConfig)) {
+				if (in_array($code, ['country_id'])) {
+					$field['config']['additionalClasses'] = "mp-hidden";
+					continue;
+				} else {
+					unset($fields[$code]);
+				}
+			} else {
+				$oriClasses                           = isset($field['config']['additionalClasses']) ? $field['config']['additionalClasses'] : '';
+				$field['config']['additionalClasses'] = "{$oriClasses} col-mp mp-{$fieldConfig['colspan']}" . ($fieldConfig['isNewRow'] ? ' mp-clear' : '');
+				$field['sortOrder']                   = $fieldConfig['sortOrder'];
+				if ($code == 'dob') {
+					$field['options'] = ['yearRange' => '-120y:c+nn', 'maxDate' => '-1d', 'changeMonth' => true, 'changeYear' => true];
+				}
+
+				$this->rewriteTemplate($field);
+			}
+		}
+		/**
+		 * Compatible Amazon Pay
+		 */
+		if($this->_oscHelper->isEnableAmazonPay()){
+			$fields['inline-form-manipulator'] = array(
+				'component' => 'Mageplaza_Osc/js/view/amazon'
+			);
+
+		}
+
+		return $this;
+	}
+
+	/**
+	 * Change template to remove valueUpdate = 'keyup'
+	 *
+	 * @param $field
+	 * @param string $template
+	 * @return $this
+	 */
+	public function rewriteTemplate(&$field, $template = 'Mageplaza_Osc/container/form/element/input')
+	{
+		if (isset($field['type']) && $field['type'] == 'group') {
+			foreach ($field['children'] as $key => &$child) {
+				if ($key == 0 && in_array('street', explode('.', $field['dataScope'])) && $this->_oscHelper->isGoogleHttps()) {
+					$this->rewriteTemplate($child, 'Mageplaza_Osc/container/form/element/street');
+					continue;
+				}
+				$this->rewriteTemplate($child);
+			}
+		} elseif (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
+			$field['config']['elementTmpl'] = $template;
+			if ($this->_oscHelper->isUsedMaterialDesign()) {
+				$field['config']['template'] = 'Mageplaza_Osc/container/form/field';
+			}
+		}
+
+		return $this;
+	}
+
+	/**
+	 * Change template street when enable material design
+	 * @param $fields
+	 * @return $this
+	 */
+	public function rewriteFieldStreet(&$fields)
+	{
+
+		if ($this->_oscHelper->isUsedMaterialDesign()) {
+			$fields['country_id']['config']['template'] = 'Mageplaza_Osc/container/form/field';
+			$fields['region_id']['config']['template']  = 'Mageplaza_Osc/container/form/field';
+			foreach ($fields['street']['children'] as $key => $value) {
+				$fields['street']['children'][0]['label']                 = $fields['street']['label'];
+				$fields['street']['children'][$key]['config']['template'] = 'Mageplaza_Osc/container/form/field';
+			}
+			$fields['street']['config']['fieldTemplate'] = 'Mageplaza_Osc/container/form/field';
+			unset($fields['street']['label']);
+		}
+
+		return $this;
+	}
+
+	/**
+	 * @return \Magento\Customer\Model\Options
+	 */
+	private function getOptions()
+	{
+		if (!is_object($this->options)) {
+			$this->options = ObjectManager::getInstance()->get(\Magento\Customer\Model\Options::class);
+		}
+
+		return $this->options;
+	}
+
+	/**
+	 * @return array
+	 */
+	private function getAddressAttributes()
+	{
+		/** @var \Magento\Eav\Api\Data\AttributeInterface[] $attributes */
+		$attributes = $this->attributeMetadataDataProvider->loadAttributesCollection(
+			'customer_address',
+			'customer_register_address'
+		);
+
+		$elements = [
+			'custom'  => [],
+			'default' => []
+		];
+		foreach ($attributes as $attribute) {
+			$code    = $attribute->getAttributeCode();
+			$element = $this->attributeMapper->map($attribute);
+			if (isset($element['label'])) {
+				$label            = $element['label'];
+				$element['label'] = __($label);
+			}
+
+			($attribute->getIsUserDefined()) ?
+				$elements['custom'][$code] = $element :
+				$elements['default'][$code] = $element;
+		}
+
+		return $elements;
+	}
+
+	/**
+	 * Convert elements(like prefix and suffix) from inputs to selects when necessary
+	 *
+	 * @param array $elements address attributes
+	 * @param array $attributesToConvert fields and their callbacks
+	 * @return array
+	 */
+	private function convertElementsToSelect($elements, $attributesToConvert)
+	{
+		$codes = array_keys($attributesToConvert);
+		foreach (array_keys($elements) as $code) {
+			if (!in_array($code, $codes)) {
+				continue;
+			}
+			$options = call_user_func($attributesToConvert[$code]);
+			if (!is_array($options)) {
+				continue;
+			}
+			$elements[$code]['dataType']    = 'select';
+			$elements[$code]['formElement'] = 'select';
+
+			foreach ($options as $key => $value) {
+				$elements[$code]['options'][] = [
+					'value' => $key,
+					'label' => $value,
+				];
+			}
+		}
+
+		return $elements;
+	}
 }
diff --git a/Block/Container.php b/Block/Container.php
index 46719fd..00d2d71 100644
--- a/Block/Container.php
+++ b/Block/Container.php
@@ -13,16 +13,17 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @category   Mageplaza
+ * @package    Mageplaza_Osc
+ * @version    3.0.0
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block;
 
 use Magento\Framework\View\Element\Template;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Data as HelperData;
 
 /**
  * Class Container
@@ -31,23 +32,22 @@ use Mageplaza\Osc\Helper\Data as OscHelper;
 class Container extends Template
 {
     /**
-     * @var OscHelper
+     * @var \Mageplaza\Osc\Helper\Data
      */
-    protected $_oscHelper;
+    protected $_helperData;
 
     /**
-     * Container constructor.
-     * @param Template\Context $context
-     * @param OscHelper $oscHelper
+     * @param \Magento\Framework\View\Element\Template\Context $context
+     * @param \Mageplaza\Osc\Helper\Data $helperData
      * @param array $data
      */
     public function __construct(
         Template\Context $context,
-        OscHelper $oscHelper,
+        HelperData $helperData,
         array $data = []
     )
     {
-        $this->_oscHelper = $oscHelper;
+        $this->_helperData = $helperData;
 
         parent::__construct($context, $data);
     }
@@ -57,6 +57,6 @@ class Container extends Template
      */
     public function getCheckoutDescription()
     {
-        return $this->_oscHelper->getConfigGeneral('description');
+        return $this->_helperData->getConfig()->getGeneralConfig('description');
     }
 }
diff --git a/Block/Design.php b/Block/Design.php
index f873dd6..d4d461f 100644
--- a/Block/Design.php
+++ b/Block/Design.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -25,18 +25,18 @@ use Magento\Checkout\Model\Session as CheckoutSession;
 use Magento\Framework\View\Design\Theme\ThemeProviderInterface;
 use Magento\Framework\View\Element\Template;
 use Magento\Framework\View\Element\Template\Context;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config;
 
 /**
- * Class Design
- * @package Mageplaza\Osc\Block
+ * Class Css
+ * @package Mageplaza\Osc\Block\Generator
  */
 class Design extends Template
 {
     /**
-     * @var OscHelper
+     * @var Config
      */
-    protected $_oscHelper;
+    protected $_helperConfig;
 
     /**
      * @var ThemeProviderInterface
@@ -49,34 +49,34 @@ class Design extends Template
     private $checkoutSession;
 
     /**
-     * Design constructor.
      * @param Context $context
-     * @param OscHelper $oscHelper
+     * @param Config $helperConfig
      * @param ThemeProviderInterface $themeProviderInterface
      * @param CheckoutSession $checkoutSession
      * @param array $data
      */
     public function __construct(
         Context $context,
-        OscHelper $oscHelper,
+        Config $helperConfig,
         ThemeProviderInterface $themeProviderInterface,
         CheckoutSession $checkoutSession,
         array $data = []
     )
     {
+
         parent::__construct($context, $data);
 
-        $this->_oscHelper = $oscHelper;
+        $this->_helperConfig           = $helperConfig;
         $this->_themeProviderInterface = $themeProviderInterface;
-        $this->checkoutSession = $checkoutSession;
+        $this->checkoutSession         = $checkoutSession;
     }
 
     /**
-     * @return OscHelper
+     * @return \Mageplaza\Osc\Helper\Config
      */
     public function getHelperConfig()
     {
-        return $this->_oscHelper;
+        return $this->_helperConfig;
     }
 
     /**
diff --git a/Block/Order/Totals.php b/Block/Order/Totals.php
index 5e084e0..404e706 100644
--- a/Block/Order/Totals.php
+++ b/Block/Order/Totals.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -36,10 +36,10 @@ class Totals extends Template
     public function initTotals()
     {
         $totalsBlock = $this->getParentBlock();
-        $source = $totalsBlock->getSource();
+        $source      = $totalsBlock->getSource();
         if ($source && !empty($source->getOscGiftWrapAmount())) {
             $totalsBlock->addTotal(new DataObject([
-                'code' => 'gift_wrap',
+                'code'  => 'gift_wrap',
                 'field' => 'osc_gift_wrap_amount',
                 'label' => __('Gift Wrap'),
                 'value' => $source->getOscGiftWrapAmount(),
diff --git a/Block/Order/View/Comment.php b/Block/Order/View/Comment.php
index 3bb302e..774325e 100644
--- a/Block/Order/View/Comment.php
+++ b/Block/Order/View/Comment.php
@@ -4,9 +4,9 @@
  *
  * NOTICE OF LICENSE
  *
- * This source file is subject to the Mageplaza.com license that is
+ * This source file is subject to the mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * https://mageplaza.com/LICENSE.txt
  *
  * DISCLAIMER
  *
@@ -14,36 +14,32 @@
  * version in the future.
  *
  * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @package     Mageplaza
+ * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @license     http://mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block\Order\View;
 
-use Magento\Framework\Registry;
-use Magento\Framework\View\Element\Template;
-use Magento\Framework\View\Element\Template\Context;
-
 /**
  * Class Comment
  * @package Mageplaza\Osc\Block\Order\View
  */
-class Comment extends Template
+class Comment extends \Magento\Framework\View\Element\Template
 {
     /**
-     * @type Registry|null
+     * @type \Magento\Framework\Registry|null
      */
     protected $_coreRegistry = null;
 
     /**
-     * @param Context $context
-     * @param Registry $registry
+     * @param \Magento\Framework\View\Element\Template\Context $context
+     * @param \Magento\Framework\Registry $registry
      * @param array $data
      */
     public function __construct(
-        Context $context,
-        Registry $registry,
+        \Magento\Framework\View\Element\Template\Context $context,
+        \Magento\Framework\Registry $registry,
         array $data = []
     )
     {
diff --git a/Block/Order/View/DeliveryTime.php b/Block/Order/View/DeliveryTime.php
index 677dbbb..c09924a 100644
--- a/Block/Order/View/DeliveryTime.php
+++ b/Block/Order/View/DeliveryTime.php
@@ -4,9 +4,9 @@
  *
  * NOTICE OF LICENSE
  *
- * This source file is subject to the Mageplaza.com license that is
+ * This source file is subject to the mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * https://mageplaza.com/LICENSE.txt
  *
  * DISCLAIMER
  *
@@ -14,36 +14,32 @@
  * version in the future.
  *
  * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @package     Mageplaza
+ * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @license     http://mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block\Order\View;
 
-use Magento\Framework\Registry;
-use Magento\Framework\View\Element\Template;
-use Magento\Framework\View\Element\Template\Context;
-
 /**
  * Class DeliveryTime
  * @package Mageplaza\Osc\Block\Order\View
  */
-class DeliveryTime extends Template
+class DeliveryTime extends \Magento\Framework\View\Element\Template
 {
     /**
-     * @type Registry|null
+     * @type \Magento\Framework\Registry|null
      */
     protected $_coreRegistry = null;
 
     /**
-     * @param Context $context
-     * @param Registry $registry
+     * @param \Magento\Framework\View\Element\Template\Context $context
+     * @param \Magento\Framework\Registry $registry
      * @param array $data
      */
     public function __construct(
-        Context $context,
-        Registry $registry,
+        \Magento\Framework\View\Element\Template\Context $context,
+        \Magento\Framework\Registry $registry,
         array $data = []
     )
     {
diff --git a/Block/Order/View/Survey.php b/Block/Order/View/Survey.php
index ef86a94..2c1d732 100644
--- a/Block/Order/View/Survey.php
+++ b/Block/Order/View/Survey.php
@@ -4,9 +4,9 @@
  *
  * NOTICE OF LICENSE
  *
- * This source file is subject to the Mageplaza.com license that is
+ * This source file is subject to the mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * https://mageplaza.com/LICENSE.txt
  *
  * DISCLAIMER
  *
@@ -14,36 +14,32 @@
  * version in the future.
  *
  * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @package     Mageplaza
+ * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @license     http://mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block\Order\View;
 
-use Magento\Framework\Registry;
-use Magento\Framework\View\Element\Template;
-use Magento\Framework\View\Element\Template\Context;
-
 /**
  * Class Survey
  * @package Mageplaza\Osc\Block\Order\View
  */
-class Survey extends Template
+class Survey extends \Magento\Framework\View\Element\Template
 {
     /**
-     * @type Registry|null
+     * @type \Magento\Framework\Registry|null
      */
     protected $_coreRegistry = null;
 
     /**
-     * @param Context $context
-     * @param Registry $registry
+     * @param \Magento\Framework\View\Element\Template\Context $context
+     * @param \Magento\Framework\Registry $registry
      * @param array $data
      */
     public function __construct(
-        Context $context,
-        Registry $registry,
+        \Magento\Framework\View\Element\Template\Context $context,
+        \Magento\Framework\Registry $registry,
         array $data = []
     )
     {
diff --git a/Block/Plugin/Link.php b/Block/Plugin/Link.php
index 0556c3a..3c3d243 100644
--- a/Block/Plugin/Link.php
+++ b/Block/Plugin/Link.php
@@ -15,15 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Block\Plugin;
 
-use Magento\Framework\App\RequestInterface;
-use Mageplaza\Osc\Helper\Data as OscHelper;
-
 /**
  * Class Link
  * @package Mageplaza\Osc\Block\Plugin
@@ -33,27 +30,27 @@ class Link
     /**
      * Request object
      *
-     * @var RequestInterface
+     * @var \Magento\Framework\App\RequestInterface
      */
     protected $_request;
 
     /**
-     * @var OscHelper
+     * @var \Mageplaza\Osc\Helper\Config
      */
-    protected $oscHelper;
+    protected $configHelper;
 
     /**
      * Link constructor.
-     * @param RequestInterface $httpRequest
-     * @param OscHelper $oscHelper
+     * @param \Magento\Framework\App\RequestInterface $httpRequest
+     * @param \Mageplaza\Osc\Helper\Config $configHelper
      */
     public function __construct(
-        RequestInterface $httpRequest,
-        OscHelper $oscHelper
+        \Magento\Framework\App\RequestInterface $httpRequest,
+        \Mageplaza\Osc\Helper\Config $configHelper
     )
     {
-        $this->_request = $httpRequest;
-        $this->oscHelper = $oscHelper;
+        $this->_request     = $httpRequest;
+        $this->configHelper = $configHelper;
     }
 
     /**
@@ -64,7 +61,7 @@ class Link
      */
     public function beforeGetUrl(\Magento\Framework\Url $subject, $routePath = null, $routeParams = null)
     {
-        if ($this->oscHelper->isEnabled() && $routePath == 'checkout' && $this->_request->getFullActionName() != 'checkout_index_index') {
+        if ($this->configHelper->isEnabled() && $routePath == 'checkout' && $this->_request->getFullActionName() != 'checkout_index_index') {
             return ['onestepcheckout', $routeParams];
         }
 
diff --git a/Block/Survey.php b/Block/Survey.php
index 36f6cdd..f862e7c 100644
--- a/Block/Survey.php
+++ b/Block/Survey.php
@@ -13,9 +13,10 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @category   Mageplaza
+ * @package    Mageplaza_Osc
+ * @version    3.0.0
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -23,7 +24,7 @@ namespace Mageplaza\Osc\Block;
 
 use Magento\Checkout\Model\Session;
 use Magento\Framework\View\Element\Template;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Data as HelperData;
 
 /**
  * Class Survey
@@ -32,9 +33,14 @@ use Mageplaza\Osc\Helper\Data as OscHelper;
 class Survey extends Template
 {
     /**
-     * @var OscHelper
+     * @var \Mageplaza\Osc\Helper\Data
      */
-    protected $_oscHelper;
+    protected $_helperData;
+
+    /**
+     * @var $_helperConfig
+     */
+    protected $_helperConfig;
 
     /**
      * @var \Magento\Checkout\Model\Session
@@ -42,20 +48,19 @@ class Survey extends Template
     protected $_checkoutSession;
 
     /**
-     * Survey constructor.
-     * @param Template\Context $context
-     * @param OscHelper $oscHelper
-     * @param Session $checkoutSession
+     * @param \Magento\Framework\View\Element\Template\Context $context
+     * @param \Mageplaza\Osc\Helper\Data $helperData
      * @param array $data
      */
     public function __construct(
         Template\Context $context,
-        OscHelper $oscHelper,
+        HelperData $helperData,
         Session $checkoutSession,
         array $data = []
     )
     {
-        $this->_oscHelper = $oscHelper;
+
+        $this->_helperData      = $helperData;
         $this->_checkoutSession = $checkoutSession;
 
         parent::__construct($context, $data);
@@ -67,12 +72,9 @@ class Survey extends Template
      */
     public function isEnableSurvey()
     {
-        return $this->_oscHelper->isEnabled() && !$this->_oscHelper->isDisableSurvey();
+        return $this->_helperData->getConfig()->isEnabled() && !$this->_helperData->getConfig()->isDisableSurvey();
     }
 
-    /**
-     * get Last order id
-     */
     public function getLastOrderId()
     {
         $orderId = $this->_checkoutSession->getLastRealOrder()->getEntityId();
@@ -84,17 +86,16 @@ class Survey extends Template
      */
     public function getSurveyQuestion()
     {
-        return $this->_oscHelper->getSurveyQuestion();
+        return $this->_helperData->getConfig()->getSurveyQuestion();
     }
 
     /**
      * @return array
-     * @throws \Zend_Serializer_Exception
      */
     public function getAllSurveyAnswer()
     {
         $answers = [];
-        foreach ($this->_oscHelper->getSurveyAnswers() as $key => $item) {
+        foreach ($this->_helperData->getConfig()->getSurveyAnswers() as $key => $item) {
             $answers[] = ['id' => $key, 'value' => $item['value']];
         }
 
@@ -106,6 +107,6 @@ class Survey extends Template
      */
     public function isAllowCustomerAddOtherOption()
     {
-        return $this->_oscHelper->isAllowCustomerAddOtherOption();
+        return $this->_helperData->getConfig()->isAllowCustomerAddOtherOption();
     }
 }
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index ebf6622..a1c2743 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -28,19 +28,18 @@ namespace Mageplaza\Osc\Controller\Add;
 class Index extends \Magento\Checkout\Controller\Cart\Add
 {
     /**
-     * @return $this|\Magento\Framework\Controller\Result\Redirect
-     * @throws \Magento\Framework\Exception\LocalizedException
-     * @throws \Magento\Framework\Exception\NoSuchEntityException
+     * @return $this|\Magento\Framework\View\Result\Page
      */
     public function execute()
     {
         $productId = $this->getRequest()->getParam('id') ? $this->getRequest()->getParam('id') : 11;
-        $storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
-        $product = $this->productRepository->getById($productId, false, $storeId);
+        $storeId   = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
+        $product   = $this->productRepository->getById($productId, false, $storeId);
 
         $this->cart->addProduct($product, []);
         $this->cart->save();
 
         return $this->goBack($this->_url->getUrl('onestepcheckout'));
+
     }
 }
diff --git a/Controller/Adminhtml/Field/Position.php b/Controller/Adminhtml/Field/Position.php
index f733dba..4429775 100644
--- a/Controller/Adminhtml/Field/Position.php
+++ b/Controller/Adminhtml/Field/Position.php
@@ -15,34 +15,30 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Controller\Adminhtml\Field;
 
-use Magento\Backend\App\Action;
-use Magento\Backend\App\Action\Context;
-use Magento\Framework\View\Result\PageFactory;
-
 /**
  * Class Position
  * @package Mageplaza\Osc\Controller\Adminhtml\Field
  */
-class Position extends Action
+class Position extends \Magento\Backend\App\Action
 {
     /**
-     * @var PageFactory
+     * @var \Magento\Framework\View\Result\PageFactory
      */
     protected $resultPageFactory;
 
     /**
-     * @param Context $context
-     * @param PageFactory $resultPageFactory
+     * @param \Magento\Backend\App\Action\Context $context
+     * @param \Magento\Framework\View\Result\PageFactory $resultPageFactory
      */
     public function __construct(
-        Context $context,
-        PageFactory $resultPageFactory
+        \Magento\Backend\App\Action\Context $context,
+        \Magento\Framework\View\Result\PageFactory $resultPageFactory
     )
     {
         parent::__construct($context);
diff --git a/Controller/Adminhtml/Field/Save.php b/Controller/Adminhtml/Field/Save.php
index cebba66..3b0d9ce 100644
--- a/Controller/Adminhtml/Field/Save.php
+++ b/Controller/Adminhtml/Field/Save.php
@@ -15,27 +15,23 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Controller\Adminhtml\Field;
 
-use Magento\Backend\App\Action;
-use Magento\Backend\App\Action\Context;
-use Magento\Config\Model\ResourceModel\Config;
-use Magento\Framework\App\Config\ReinitableConfigInterface;
 use Magento\Framework\App\Config\ScopeConfigInterface;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as HelperConfig;
 
 /**
  * Class Save
  * @package Mageplaza\Osc\Controller\Adminhtml\Field
  */
-class Save extends Action
+class Save extends \Magento\Backend\App\Action
 {
     /**
-     * @var Config
+     * @var \Magento\Config\Model\ResourceModel\Config
      */
     protected $resourceConfig;
 
@@ -47,20 +43,20 @@ class Save extends Action
     protected $_appConfig;
 
     /**
-     * @param Context $context
-     * @param Config $resourceConfig
-     * @param ReinitableConfigInterface $config
+     * @param \Magento\Backend\App\Action\Context $context
+     * @param \Magento\Config\Model\ResourceModel\Config $resourceConfig
+     * @param \Magento\Framework\App\Config\ReinitableConfigInterface $config
      */
     public function __construct(
-        Context $context,
-        Config $resourceConfig,
-        ReinitableConfigInterface $config
+        \Magento\Backend\App\Action\Context $context,
+        \Magento\Config\Model\ResourceModel\Config $resourceConfig,
+        \Magento\Framework\App\Config\ReinitableConfigInterface $config
     )
     {
         parent::__construct($context);
 
         $this->resourceConfig = $resourceConfig;
-        $this->_appConfig = $config;
+        $this->_appConfig     = $config;
     }
 
     /**
@@ -76,7 +72,7 @@ class Save extends Action
         $fields = $this->getRequest()->getParam('fields', false);
         if ($fields) {
             $this->resourceConfig->saveConfig(
-                OscHelper::SORTED_FIELD_POSITION,
+                HelperConfig::SORTED_FIELD_POSITION,
                 $fields,
                 ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
                 0
@@ -89,6 +85,6 @@ class Save extends Action
             $result['message'] = __('All fields have been saved.');
         }
 
-        $this->getResponse()->setBody(OscHelper::jsonEncode($result));
+        $this->getResponse()->setBody(\Zend_Json::encode($result));
     }
 }
diff --git a/Controller/Adminhtml/System/Config/Geoip.php b/Controller/Adminhtml/System/Config/Geoip.php
index 4248886..6425f95 100644
--- a/Controller/Adminhtml/System/Config/Geoip.php
+++ b/Controller/Adminhtml/System/Config/Geoip.php
@@ -13,9 +13,10 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @category   Mageplaza
+ * @package    Mageplaza_Osc
+ * @version    3.0.0
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -25,14 +26,11 @@ use Magento\Backend\App\Action;
 use Magento\Backend\App\Action\Context;
 use Magento\Framework\App\Filesystem\DirectoryList;
 use Magento\Framework\Controller\Result\JsonFactory;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as OscConfig;
 
-/**
- * Class Geoip
- * @package Mageplaza\Osc\Controller\Adminhtml\System\Config
- */
 class Geoip extends Action
 {
+
     /**
      * @type \Magento\Framework\Controller\Result\JsonFactory
      */
@@ -44,32 +42,33 @@ class Geoip extends Action
     protected $_directoryList;
 
     /**
-     * @var OscHelper
+     * @var OscConfig
      */
-    protected $_oscHelper;
+    protected $_oscConfig;
+
 
     /**
      * @param Context $context
      * @param JsonFactory $resultJsonFactory
      * @param DirectoryList $directoryList
-     * @param OscHelper $oscHelper
+     * @param OscConfig $config
      */
     public function __construct(
         Context $context,
         JsonFactory $resultJsonFactory,
         DirectoryList $directoryList,
-        OscHelper $oscHelper
+        OscConfig $config
     )
     {
         $this->resultJsonFactory = $resultJsonFactory;
-        $this->_directoryList = $directoryList;
-        $this->_oscHelper = $oscHelper;
+        $this->_directoryList    = $directoryList;
+        $this->_oscConfig        = $config;
 
         parent::__construct($context);
     }
 
     /**
-     * @return $this|\Magento\Framework\App\ResponseInterface|\Magento\Framework\Controller\ResultInterface
+     * @return $this
      */
     public function execute()
     {
@@ -79,8 +78,9 @@ class Geoip extends Action
             if (!file_exists($path)) {
                 mkdir($path, 0777, true);
             }
-            $folder = scandir($path, true);
+            $folder   = scandir($path, true);
             $pathFile = $path . '/' . $folder[0] . '/GeoLite2-City.mmdb';
+
             if (file_exists($pathFile)) {
                 foreach (scandir($path . '/' . $folder[0], true) as $filename) {
                     if ($filename == '..' || $filename == '.') {
@@ -91,13 +91,13 @@ class Geoip extends Action
                 @rmdir($path . '/' . $folder[0]);
             }
 
-            file_put_contents($path . '/GeoLite2-City.tar.gz', fopen($this->_oscHelper->getDownloadPath(), 'r'));
+            file_put_contents($path . '/GeoLite2-City.tar.gz', fopen($this->_oscConfig->getDownloadPath(), 'r'));
             $phar = new \PharData($path . '/GeoLite2-City.tar.gz');
             $phar->extractTo($path);
-            $status = true;
+            $status  = true;
             $message = __("Download library success!");
         } catch (\Exception $e) {
-            $message = __("Can't download file. Please try again! %1", $e->getMessage());
+            $message = __("Can't download file. Please try again!");
         }
 
         /** @var \Magento\Framework\Controller\Result\Json $result */
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index 8475e59..64e5d28 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -15,19 +15,17 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Controller\Index;
 
-use Magento\Checkout\Controller\Onepage;
-
 /**
  * Class Index
  * @package Mageplaza\Osc\Controller\Index
  */
-class Index extends Onepage
+class Index extends \Magento\Checkout\Controller\Onepage
 {
     /**
      * @type \Mageplaza\Osc\Helper\Data
@@ -35,11 +33,11 @@ class Index extends Onepage
     protected $_checkoutHelper;
 
     /**
-     * @return $this|\Magento\Framework\App\ResponseInterface|\Magento\Framework\Controller\ResultInterface|\Magento\Framework\View\Result\Page
+     * @return $this|\Magento\Framework\View\Result\Page
      */
     public function execute()
     {
-        $this->_checkoutHelper = $this->_objectManager->get(\Mageplaza\Osc\Helper\Data::class);
+        $this->_checkoutHelper = $this->_objectManager->get('Mageplaza\Osc\Helper\Data');
         if (!$this->_checkoutHelper->isEnabled()) {
             $this->messageManager->addError(__('One step checkout is turned off.'));
 
@@ -57,8 +55,8 @@ class Index extends Onepage
 
         $this->initDefaultMethods($quote);
 
-        $resultPage = $this->resultPageFactory->create();
-        $checkoutTitle = $this->_checkoutHelper->getCheckoutTitle();
+        $resultPage    = $this->resultPageFactory->create();
+        $checkoutTitle = $this->_checkoutHelper->getConfig()->getCheckoutTitle();
         $resultPage->getConfig()->getTitle()->set($checkoutTitle);
 
         return $resultPage;
@@ -74,13 +72,20 @@ class Index extends Onepage
     {
         $shippingAddress = $quote->getShippingAddress();
         if (!$shippingAddress->getCountryId()) {
-            if (!empty($this->_checkoutHelper->getDefaultCountryId())) {
-                $defaultCountryId = $this->_checkoutHelper->getDefaultCountryId();
+            if (!empty($this->_checkoutHelper->getConfig()->getDefaultCountryId())) {
+                $defaultCountryId = $this->_checkoutHelper->getConfig()->getDefaultCountryId();
             } else {
-                /** Get default country id from Geo Ip or Locale */
-                $geoIpData = $this->_checkoutHelper->getAddressHelper()->getGeoIpData();
-                if (empty($geoIpData)) {
-                    $defaultCountryId = $geoIpData['country_id'];
+                /**
+                 * Get default country id from Geo Ip or Locale
+                 */
+                if ($this->_checkoutHelper->checkHasLibrary()) {
+                    try {
+                        $ip               = $_SERVER['REMOTE_ADDR'] != '127.0.0.1' ? $_SERVER['REMOTE_ADDR'] : '123.16.189.71';
+                        $data             = $this->_checkoutHelper->getGeoIpData($this->_objectManager->get('Mageplaza\Osc\Model\Geoip\Database\Reader')->city($ip));
+                        $defaultCountryId = $data['country_id'];
+                    } catch (\Exception $e) {
+                        $defaultCountryId = $this->getDefaultCountryFromLocale();
+                    }
                 } else {
                     $defaultCountryId = $this->getDefaultCountryFromLocale();
                 }
@@ -91,7 +96,7 @@ class Index extends Onepage
         $method = null;
 
         try {
-            $availableMethods = $this->_objectManager->get(\Magento\Quote\Api\ShippingMethodManagementInterface::class)
+            $availableMethods = $this->_objectManager->get('Magento\Quote\Api\ShippingMethodManagementInterface')
                 ->getList($quote->getId());
             if (sizeof($availableMethods) == 1) {
                 $method = array_shift($availableMethods);
@@ -121,8 +126,8 @@ class Index extends Onepage
      */
     public function filterMethod($method)
     {
-        $defaultShippingMethod = $this->_checkoutHelper->getDefaultShippingMethod();
-        $methodCode = $method->getCarrierCode() . '_' . $method->getMethodCode();
+        $defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
+        $methodCode            = $method->getCarrierCode() . '_' . $method->getMethodCode();
         if ($methodCode == $defaultShippingMethod) {
             return true;
         }
@@ -136,8 +141,7 @@ class Index extends Onepage
      */
     public function getDefaultCountryFromLocale()
     {
-        $locale = $this->_objectManager->get(\Magento\Framework\Locale\Resolver::class)
-            ->getLocale();
+        $locale = $this->_objectManager->get('Magento\Framework\Locale\Resolver')->getLocale();
 
         return substr($locale, strrpos($locale, "_") + 1);
     }
diff --git a/Controller/Survey/Save.php b/Controller/Survey/Save.php
index c9d448f..68cea12 100644
--- a/Controller/Survey/Save.php
+++ b/Controller/Survey/Save.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -24,9 +24,9 @@ namespace Mageplaza\Osc\Controller\Survey;
 use Magento\Checkout\Model\Session;
 use Magento\Framework\App\Action\Action;
 use Magento\Framework\App\Action\Context;
-use Magento\Framework\Json\Helper\Data as JsonHelper;
+use Magento\Framework\Json\Helper\Data;
 use Magento\Sales\Model\Order;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as OscConfig;
 
 /**
  * Class Save
@@ -50,62 +50,59 @@ class Save extends Action
     protected $_order;
 
     /**
-     * @var OscHelper
+     * @var \Mageplaza\Osc\Helper\Config
      */
-    protected $oscHelper;
+    protected $oscConfig;
 
     /**
      * Save constructor.
-     * @param Context $context
-     * @param JsonHelper $jsonHelper
-     * @param Session $checkoutSession
-     * @param Order $order
-     * @param OscHelper $oscHelper
+     * @param \Magento\Framework\App\Action\Context $context
+     * @param \Magento\Framework\Json\Helper\Data $jsonHelper
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Magento\Sales\Model\Order $order
+     * @param \Mageplaza\Osc\Helper\Config $oscConfig
      */
     public function __construct(
         Context $context,
-        JsonHelper $jsonHelper,
+        Data $jsonHelper,
         Session $checkoutSession,
         Order $order,
-        OscHelper $oscHelper
+        OscConfig $oscConfig
     )
     {
-        $this->jsonHelper = $jsonHelper;
+        $this->jsonHelper       = $jsonHelper;
         $this->_checkoutSession = $checkoutSession;
-        $this->_order = $order;
-        $this->oscHelper = $oscHelper;
-
+        $this->_order           = $order;
+        $this->oscConfig        = $oscConfig;
         parent::__construct($context);
     }
 
     /**
-     * @return \Magento\Framework\App\ResponseInterface|\Magento\Framework\Controller\ResultInterface|null
+     * @return mixed
      */
     public function execute()
     {
         $response = array();
         if ($this->getRequest()->getParam('answerChecked') && isset($this->_checkoutSession->getOscData()['survey'])) {
             try {
-                $order = $this->_order->load($this->_checkoutSession->getOscData()['survey']['orderId']);
+                $order   = $this->_order->load($this->_checkoutSession->getOscData()['survey']['orderId']);
                 $answers = '';
                 foreach ($this->getRequest()->getParam('answerChecked') as $item) {
                     $answers .= $item . ' - ';
                 }
-                $order->setData('osc_survey_question', $this->oscHelper->getSurveyQuestion());
+                $order->setData('osc_survey_question', $this->oscConfig->getSurveyQuestion());
                 $order->setData('osc_survey_answers', substr($answers, 0, -2));
                 $order->save();
 
-                $response['status'] = 'success';
+                $response['status']  = 'success';
                 $response['message'] = 'Thank you for completing our survey!';
                 $this->_checkoutSession->unsOscData();
             } catch (\Exception $e) {
-                $response['status'] = 'error';
+                $response['status']  = 'error';
                 $response['message'] = "Can't save survey answer. Please try again! ";
             }
 
-            return $this->getResponse()->representJson(OscHelper::jsonEncode($response));
+            return $this->getResponse()->representJson($this->jsonHelper->jsonEncode($response));
         }
-
-        return null;
     }
 }
diff --git a/Helper/Address.php b/Helper/Address.php
deleted file mode 100644
index 4482bce..0000000
--- a/Helper/Address.php
+++ /dev/null
@@ -1,331 +0,0 @@
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
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Helper;
-
-use Magento\Customer\Helper\Address as CustomerAddressHelper;
-use Magento\Customer\Model\AttributeMetadataDataProvider;
-use Magento\Directory\Model\Region;
-use Magento\Framework\App\Filesystem\DirectoryList;
-use Magento\Framework\App\Helper\Context;
-use Magento\Framework\Locale\Resolver;
-use Magento\Framework\ObjectManagerInterface;
-use Magento\Store\Model\StoreManagerInterface;
-
-/**
- * Class Address
- * @package Mageplaza\Osc\Helper
- */
-class Address extends Data
-{
-    /** Field position */
-    const SORTED_FIELD_POSITION = 'osc/field/position';
-
-    /**
-     * @type \Magento\Framework\App\Filesystem\DirectoryList
-     */
-    protected $_directoryList;
-
-    /**
-     * @type \Magento\Framework\Locale\Resolver
-     */
-    protected $_localeResolver;
-
-    /**
-     * @type \Magento\Directory\Model\Region
-     */
-    protected $_regionModel;
-
-    /**
-     * @var CustomerAddressHelper
-     */
-    protected $addressHelper;
-
-    /**
-     * @var AttributeMetadataDataProvider
-     */
-    private $attributeMetadataDataProvider;
-
-    /**
-     * Address constructor.
-     * @param Context $context
-     * @param ObjectManagerInterface $objectManager
-     * @param StoreManagerInterface $storeManager
-     * @param DirectoryList $directoryList
-     * @param Resolver $localeResolver
-     * @param Region $regionModel
-     * @param CustomerAddressHelper $addressHelper
-     * @param AttributeMetadataDataProvider $attributeMetadataDataProvider
-     */
-    public function __construct(
-        Context $context,
-        ObjectManagerInterface $objectManager,
-        StoreManagerInterface $storeManager,
-        DirectoryList $directoryList,
-        Resolver $localeResolver,
-        Region $regionModel,
-        CustomerAddressHelper $addressHelper,
-        AttributeMetadataDataProvider $attributeMetadataDataProvider
-    )
-    {
-        $this->_directoryList = $directoryList;
-        $this->_localeResolver = $localeResolver;
-        $this->_regionModel = $regionModel;
-        $this->addressHelper = $addressHelper;
-        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-
-        parent::__construct($context, $objectManager, $storeManager);
-    }
-
-    /**
-     * Address Fields
-     *
-     * @return array
-     */
-    public function getAddressFields()
-    {
-        $fieldPosition = $this->getAddressFieldPosition();
-
-        $fields = array_keys($fieldPosition);
-        if (!in_array('country_id', $fields)) {
-            array_unshift($fields, 'country_id');
-        }
-
-        if (in_array('region_id', $fields)) {
-            $fields[] = 'region_id_input';
-        }
-
-        return $fields;
-    }
-
-    /**
-     * Get position to display on one step checkout
-     *
-     * @return array
-     */
-    public function getAddressFieldPosition()
-    {
-        $fieldPosition = [];
-        $sortedField = $this->getSortedField();
-        foreach ($sortedField as $field) {
-            $fieldPosition[$field->getAttributeCode()] = [
-                'sortOrder' => $field->getSortOrder(),
-                'colspan' => $field->getColspan(),
-                'isNewRow' => $field->getIsNewRow()
-            ];
-        }
-
-        return $fieldPosition;
-    }
-
-    /**
-     * Get attribute collection to show on osc and manage field
-     *
-     * @param bool|true $onlySorted
-     * @return array
-     */
-    public function getSortedField($onlySorted = true)
-    {
-        $availableFields = [];
-        $sortedFields = [];
-        $sortOrder = 1;
-
-        /** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
-        $collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
-            'customer_address',
-            'customer_register_address'
-        );
-        foreach ($collection as $key => $field) {
-            if (!$this->isAddressAttributeVisible($field)) {
-                continue;
-            }
-            $availableFields[] = $field;
-        }
-
-        /** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
-        $collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
-            'customer',
-            'customer_account_create'
-        );
-        foreach ($collection as $key => $field) {
-            if (!$this->isCustomerAttributeVisible($field)) {
-                continue;
-            }
-            $availableFields[] = $field;
-        }
-
-        $isNewRow = true;
-        $fieldConfig = $this->getFieldPosition();
-        foreach ($fieldConfig as $field) {
-            foreach ($availableFields as $key => $avField) {
-                if ($field['code'] == $avField->getAttributeCode()) {
-                    $avField->setColspan($field['colspan'])
-                        ->setSortOrder($sortOrder++)
-                        ->setIsNewRow($isNewRow);
-                    $sortedFields[] = $avField;
-                    unset($availableFields[$key]);
-
-                    $this->checkNewRow($field['colspan'], $isNewRow);
-                    break;
-                }
-            }
-        }
-
-        return $onlySorted ? $sortedFields : [$sortedFields, $availableFields];
-    }
-
-    /**
-     * Check if address attribute can be visible on frontend
-     *
-     * @param $attribute
-     * @return bool|null|string
-     */
-    public function isAddressAttributeVisible($attribute)
-    {
-        $code = $attribute->getAttributeCode();
-        $result = $attribute->getIsVisible();
-        switch ($code) {
-            case 'vat_id':
-                $result = $this->addressHelper->isVatAttributeVisible();
-                break;
-            case 'region':
-                $result = false;
-                break;
-        }
-
-        return $result;
-    }
-
-    /**
-     * Check if customer attribute can be visible on frontend
-     *
-     * @param \Magento\Eav\Api\Data\AttributeInterface $attribute
-     * @return bool|null|string
-     */
-    public function isCustomerAttributeVisible($attribute)
-    {
-        $code = $attribute->getAttributeCode();
-        if (in_array($code, ['gender', 'taxvat', 'dob'])) {
-            return $attribute->getIsVisible();
-        } else if (!$attribute->getIsUserDefined()) {
-            return false;
-        }
-
-        return true;
-    }
-
-    /**
-     * @return mixed
-     */
-    public function getFieldPosition()
-    {
-        $fields = $this->getConfigValue(self::SORTED_FIELD_POSITION);
-
-        return self::jsonDecode($fields);
-    }
-
-    /**
-     * @param $colSpan
-     * @param $isNewRow
-     * @return $this
-     */
-    private function checkNewRow($colSpan, &$isNewRow)
-    {
-        if ($colSpan == 6 && $isNewRow) {
-            $isNewRow = false;
-        } else if ($colSpan == 12 || ($colSpan == 6 && !$isNewRow)) {
-            $isNewRow = true;
-        }
-
-        return $this;
-    }
-
-    /***************************************** Maxmind Db GeoIp ******************************************************/
-    /**
-     * Check has library at path var/Mageplaza/Osc/GeoIp/
-     * @return bool|string
-     */
-    public function checkHasLibrary()
-    {
-        $path = $this->_directoryList->getPath('var') . '/Mageplaza/Osc/GeoIp';
-        if (!file_exists($path)) {
-            return false;
-        }
-
-        $folder = scandir($path, true);
-        $pathFile = $path . '/' . $folder[0] . '/GeoLite2-City.mmdb';
-        if (!file_exists($pathFile)) {
-            return false;
-        }
-
-        return $pathFile;
-    }
-
-    /**
-     * @return array
-     */
-    public function getGeoIpData()
-    {
-        $libPath = $this->checkHasLibrary();
-        if ($this->isEnableGeoIP() && $libPath && class_exists('GeoIp2\Database\Reader')) {
-            try {
-                $geoIp = new \GeoIp2\Database\Reader($libPath, $this->getLocales());
-                $record = $geoIp->city($this->_request->getParam('fakeIp', null) ?: $this->_remoteAddress->getRemoteAddress());
-
-                $geoIpData = [
-                    'city' => $record->city->name,
-                    'country_id' => $record->country->isoCode,
-                    'postcode' => $record->postal->code
-                ];
-                if ($record->mostSpecificSubdivision) {
-                    $code = $record->mostSpecificSubdivision->isoCode;
-                    if ($regionId = $this->_regionModel->loadByCode($code, $record->country->isoCode)->getId()) {
-                        $geoIpData['region_id'] = $regionId;
-                    } else {
-                        $geoIpData['region'] = $record->mostSpecificSubdivision->name;
-                    }
-                }
-            } catch (\Exception $e) {
-                $geoIpData = [];
-            }
-
-            return $geoIpData;
-        }
-
-        return [];
-    }
-
-    /**
-     * @return array
-     */
-    protected function getLocales()
-    {
-        $locale = $this->_localeResolver->getLocale();
-        $language = substr($locale, 0, 2) ? substr($locale, 0, 2) : 'en';
-
-        $locales = [$language];
-        if ($language != 'en') {
-            $locales[] = 'en';
-        }
-
-        return $locales;
-    }
-}
diff --git a/Helper/Config.php b/Helper/Config.php
new file mode 100644
index 0000000..2409110
--- /dev/null
+++ b/Helper/Config.php
@@ -0,0 +1,836 @@
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
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\Osc\Helper;
+
+use Magento\Customer\Helper\Address;
+use Magento\Customer\Model\AttributeMetadataDataProvider;
+use Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory as AddressFactory;
+use Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory as CustomerFactory;
+use Magento\Framework\App\Helper\Context;
+use Magento\Framework\ObjectManagerInterface;
+use Magento\Store\Model\StoreManagerInterface;
+use Mageplaza\Core\Helper\AbstractData;
+use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
+
+/**
+ * Class Config
+ * @package Mageplaza\Osc\Helper
+ */
+class Config extends AbstractData
+{
+    /** Is enable module path */
+    const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
+
+    /** Field position */
+    const SORTED_FIELD_POSITION = 'osc/field/position';
+
+    /** General configuration path */
+    const GENERAL_CONFIGUARATION = 'osc/general';
+
+    /** Display configuration path */
+    const DISPLAY_CONFIGUARATION = 'osc/display_configuration';
+
+    /** Design configuration path */
+    const DESIGN_CONFIGUARATION = 'osc/design_configuration';
+
+    /** Geo configuration path */
+    const GEO_IP_CONFIGUARATION = 'osc/geoip_configuration';
+
+    /** Is enable Geo Ip path */
+    const GEO_IP_IS_ENABLED = 'osc/geoip_configuration/is_enable_geoip';
+
+    /** @var \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory */
+    protected $_addressesFactory;
+
+    /** @var \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory */
+    protected $_customerFactory;
+
+    /** @var \Magento\Customer\Helper\Address */
+    protected $addressHelper;
+
+    /** @var \Magento\Customer\Model\AttributeMetadataDataProvider */
+    private $attributeMetadataDataProvider;
+
+    /**
+     * Config constructor.
+     * @param \Magento\Framework\App\Helper\Context $context
+     * @param \Magento\Framework\ObjectManagerInterface $objectManager
+     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+     * @param \Magento\Customer\Helper\Address $addressHelper
+     * @param \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory $addressesFactory
+     * @param \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory $customerFactory
+     * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+     */
+    public function __construct(
+        Context $context,
+        ObjectManagerInterface $objectManager,
+        StoreManagerInterface $storeManager,
+        Address $addressHelper,
+        AddressFactory $addressesFactory,
+        CustomerFactory $customerFactory,
+        AttributeMetadataDataProvider $attributeMetadataDataProvider
+    )
+    {
+        parent::__construct($context, $objectManager, $storeManager);
+
+        $this->addressHelper                 = $addressHelper;
+        $this->_addressesFactory             = $addressesFactory;
+        $this->_customerFactory              = $customerFactory;
+        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
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
+     * Get position to display on one step checkout
+     *
+     * @return array
+     */
+    public function getAddressFieldPosition()
+    {
+        $fieldPosition = [];
+        $sortedField   = $this->getSortedField();
+        foreach ($sortedField as $field) {
+            $fieldPosition[$field->getAttributeCode()] = [
+                'sortOrder' => $field->getSortOrder(),
+                'colspan'   => $field->getColspan(),
+                'isNewRow'  => $field->getIsNewRow()
+            ];
+        }
+
+        return $fieldPosition;
+    }
+
+    /**
+     * Get attribute collection to show on osc and manage field
+     *
+     * @param bool|true $onlySorted
+     * @return array
+     */
+    public function getSortedField($onlySorted = true)
+    {
+        $availableFields = [];
+        $sortedFields    = [];
+        $sortOrder       = 1;
+
+        /** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
+        $collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
+            'customer_address',
+            'customer_register_address'
+        );
+        foreach ($collection as $key => $field) {
+            if (!$this->isAddressAttributeVisible($field)) {
+                continue;
+            }
+            $availableFields[] = $field;
+        }
+
+        /** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
+        $collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
+            'customer',
+            'customer_account_create'
+        );
+        foreach ($collection as $key => $field) {
+            if (!$this->isCustomerAttributeVisible($field)) {
+                continue;
+            }
+            $availableFields[] = $field;
+        }
+
+        $isNewRow    = true;
+        $fieldConfig = $this->getFieldPosition();
+        foreach ($fieldConfig as $field) {
+            foreach ($availableFields as $key => $avField) {
+                if ($field['code'] == $avField->getAttributeCode()) {
+                    $avField->setColspan($field['colspan'])
+                        ->setSortOrder($sortOrder++)
+                        ->setIsNewRow($isNewRow);
+                    $sortedFields[] = $avField;
+                    unset($availableFields[$key]);
+
+                    $this->checkNewRow($field['colspan'], $isNewRow);
+                    break;
+                }
+            }
+        }
+
+        return $onlySorted ? $sortedFields : [$sortedFields, $availableFields];
+    }
+
+    /**
+     * Check if address attribute can be visible on frontend
+     *
+     * @param $attribute
+     * @return bool|null|string
+     */
+    public function isAddressAttributeVisible($attribute)
+    {
+        $code   = $attribute->getAttributeCode();
+        $result = $attribute->getIsVisible();
+        switch ($code) {
+            case 'vat_id':
+                $result = $this->addressHelper->isVatAttributeVisible();
+                break;
+            case 'region':
+                $result = false;
+                break;
+        }
+
+        return $result;
+    }
+
+    /**
+     * Check if customer attribute can be visible on frontend
+     *
+     * @param \Magento\Eav\Api\Data\AttributeInterface $attribute
+     * @return bool|null|string
+     */
+    public function isCustomerAttributeVisible($attribute)
+    {
+        $code = $attribute->getAttributeCode();
+        if (in_array($code, ['gender', 'taxvat', 'dob'])) {
+            return $attribute->getIsVisible();
+        } else if (!$attribute->getIsUserDefined()) {
+            return false;
+        }
+
+        return true;
+    }
+
+    /************************ Field Position *************************
+     * @return array|mixed
+     */
+    public function getFieldPosition()
+    {
+        $fields = $this->getConfigValue(self::SORTED_FIELD_POSITION);
+
+        try {
+            $result = \Zend_Json::decode($fields);
+        } catch (\Exception $e) {
+            $result = [];
+        }
+
+        return $result;
+    }
+
+    /**
+     * @param $colSpan
+     * @param $isNewRow
+     * @return $this
+     */
+    private function checkNewRow($colSpan, &$isNewRow)
+    {
+        if ($colSpan == 6 && $isNewRow) {
+            $isNewRow = false;
+        } else if ($colSpan == 12 || ($colSpan == 6 && !$isNewRow)) {
+            $isNewRow = true;
+        }
+
+        return $this;
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
+        return $this->getGeneralConfig('title', $store) ?: 'One Step Checkout';
+    }
+
+    /************************ General Configuration *************************
+     *
+     * @param      $code
+     * @param null $store
+     * @return mixed
+     */
+    public function getGeneralConfig($code = '', $store = null)
+    {
+        $code = $code ? self::GENERAL_CONFIGUARATION . '/' . $code : self::GENERAL_CONFIGUARATION;
+
+        return $this->getConfigValue($code, $store);
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
+     * Get magento default country
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getDefaultCountryId($store = null)
+    {
+        return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
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
+     * @param $quote
+     * @param null $store
+     * @return bool
+     */
+    public function getAllowGuestCheckout($quote, $store = null)
+    {
+        $allowGuestCheckout = boolval($this->getGeneralConfig('allow_guest_checkout', $store));
+
+        if ($this->scopeConfig->isSetFlag(
+            \Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver::XML_PATH_DISABLE_GUEST_CHECKOUT,
+            \Magento\Store\Model\ScopeInterface::SCOPE_STORE,
+            $store
+        )
+        ) {
+            foreach ($quote->getAllItems() as $item) {
+                if (($product = $item->getProduct())
+                    && $product->getTypeId() == \Magento\Downloadable\Model\Product\Type::TYPE_DOWNLOADABLE
+                ) {
+                    return false;
+                }
+            }
+        }
+
+        return $allowGuestCheckout;
+    }
+
+    /**
+     * Redirect To OneStepCheckout
+     * @param null $store
+     * @return bool
+     */
+    public function isRedirectToOneStepCheckout($store = null)
+    {
+        return boolval($this->getGeneralConfig('redirect_to_one_step_checkout', $store));
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
+    /**
+     * Check if the page is https
+     *
+     * @return bool
+     */
+    public function isGoogleHttps()
+    {
+        $isEnable = ($this->getAutoDetectedAddress() == 'google');
+
+        return $isEnable && $this->_request->isSecure();
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
+    /********************************** Display Configuration *********************
+     *
+     * @param $code
+     * @param null $store
+     * @return mixed
+     */
+    public function getDisplayConfig($code = '', $store = null)
+    {
+        $code = $code ? self::DISPLAY_CONFIGUARATION . '/' . $code : self::DISPLAY_CONFIGUARATION;
+
+        return $this->getConfigValue($code, $store);
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
+    public function disabledPaymentCoupon($store = null)
+    {
+        return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_PAYMENT;
+    }
+
+    /**
+     * Coupon will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function disabledReviewCoupon($store = null)
+    {
+        return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_REVIEW;
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
+     * @param null $store
+     * @return mixed
+     */
+    public function getShowTOC($store = null)
+    {
+        return $this->getDisplayConfig('show_toc', $store);
+    }
+
+    /**
+     * @param null $store
+     * @return mixed
+     */
+    public function isEnabledTOC($store = null)
+    {
+        return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::NOT_SHOW;
+    }
+
+	/**
+	 * Term and condition checkbox in payment block will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function disabledPaymentTOC($store = null)
+	{
+		return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_PAYMENT;
+	}
+
+    /**
+     * Term and condition checkbox in review will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function disabledReviewTOC($store = null)
+    {
+        return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_REVIEW;
+    }
+
+    /**
+     * GiftMessage will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isDisabledGiftMessage($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_gift_message', $store);
+    }
+
+    /**
+     * Gift message items
+     * @param null $store
+     * @return bool
+     */
+    public function isEnableGiftMessageItems($store = null)
+    {
+        return (bool)$this->getDisplayConfig('is_enabled_gift_message_items', $store);
+    }
+
+
+    /**
+     * Gift wrap block will be hided if this function return 'true'
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isDisabledGiftWrap($store = null)
+    {
+        $giftWrapEnabled = $this->getDisplayConfig('is_enabled_gift_wrap', $store);
+        $giftWrapAmount  = $this->getOrderGiftwrapAmount();
+
+        return !$giftWrapEnabled || ($giftWrapAmount < 0);
+    }
+
+    /**
+     * Gift wrap amount
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getOrderGiftWrapAmount($store = null)
+    {
+        return doubleval($this->getDisplayConfig('gift_wrap_amount', $store));
+    }
+
+    /**
+     * @return array
+     */
+    public function getGiftWrapConfiguration()
+    {
+        return [
+            'gift_wrap_type'   => $this->getGiftWrapType(),
+            'gift_wrap_amount' => $this->formatGiftWrapAmount()
+        ];
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
+        return $this->getDisplayConfig('gift_wrap_type', $store);
+    }
+
+    /**
+     * @return mixed
+     */
+    public function formatGiftWrapAmount()
+    {
+        $objectManager  = \Magento\Framework\App\ObjectManager::getInstance();
+        $giftWrapAmount = $objectManager->create('Magento\Checkout\Helper\Data')->formatPrice($this->getOrderGiftWrapAmount());
+
+        return $giftWrapAmount;
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
+        return (bool)$this->getDisplayConfig('is_checked_newsletter', $store);
+    }
+
+    /**
+     * Social Login On Checkout Page
+     * @param null $store
+     * @return bool
+     */
+    public function isDisabledSocialLoginOnCheckout($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_social_login', $store);
+    }
+
+    /**
+     * Delivery Time
+     * @param null $store
+     * @return bool
+     */
+    public function isDisabledDeliveryTime($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_delivery_time', $store);
+    }
+
+    /**
+     * House Security Code
+     * @param null $store
+     * @return bool
+     */
+    public function isDisabledHouseSecurityCode($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_house_security_code', $store);
+    }
+
+    /**
+     * Delivery Time Format
+     *
+     * @param null $store
+     *
+     * @return string 'dd/mm/yy'|'mm/dd/yy'|'yy/mm/dd'
+     */
+    public function getDeliveryTimeFormat($store = null)
+    {
+        $deliveryTimeFormat = $this->getDisplayConfig('delivery_time_format', $store);
+
+        return $deliveryTimeFormat ?: \Mageplaza\Osc\Model\System\Config\Source\DeliveryTime::DAY_MONTH_YEAR;
+    }
+
+    /**
+     * Delivery Time Off
+     * @param null $store
+     * @return bool|mixed
+     */
+    public function getDeliveryTimeOff($store = null)
+    {
+        return $this->getDisplayConfig('delivery_time_off', $store);
+    }
+
+    /**
+     * Survey
+     * @param null $store
+     * @return bool
+     */
+    public function isDisableSurvey($store = null)
+    {
+        return !$this->getDisplayConfig('is_enabled_survey', $store);
+    }
+
+    /**
+     * Survey Question
+     * @param null $store
+     * @return mixed
+     */
+    public function getSurveyQuestion($store = null)
+    {
+        return $this->getDisplayConfig('survey_question', $store);
+    }
+
+    /**
+     * Survey Answers
+     * @param null $stores
+     * @return mixed
+     */
+    public function getSurveyAnswers($stores = null)
+    {
+        return $this->unserialize($this->getDisplayConfig('survey_answers', $stores));
+    }
+
+    /**
+     * Allow Customer Add Other Option
+     * @param null $stores
+     * @return mixed
+     */
+    public function isAllowCustomerAddOtherOption($stores = null)
+    {
+        return $this->getDisplayConfig('allow_customer_add_other_option', $stores);
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
+
+    /***************************** Design Configuration *****************************
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function getDesignConfig($code = '', $store = null)
+    {
+        $code = $code ? self::DESIGN_CONFIGUARATION . '/' . $code : self::DESIGN_CONFIGUARATION;
+
+        return $this->getConfigValue($code, $store);
+    }
+
+    /**
+     * @return bool
+     */
+    public function isUsedMaterialDesign()
+    {
+        return $this->getDesignConfig('page_design') == 'material' ? true : false;
+    }
+
+    /***************************** GeoIP Configuration *****************************
+     *
+     * @param null $store
+     * @return mixed
+     */
+    public function isEnableGeoIP($store = null)
+    {
+        return boolval($this->getConfigValue(self::GEO_IP_CONFIGUARATION . '/is_enable_geoip', $store));
+    }
+
+    /**
+     * @param null $store
+     * @return mixed
+     */
+    public function getDownloadPath($store = null)
+    {
+        return $this->getConfigValue(self::GEO_IP_CONFIGUARATION . '/download_path', $store);
+    }
+
+    /***************************** Compatible Modules *****************************
+     *
+     * @return bool
+     */
+    public function isEnabledMultiSafepay()
+    {
+        return $this->_moduleManager->isOutputEnabled('MultiSafepay_Connect');
+    }
+
+    /**
+     * @return bool
+     */
+    public function isEnableModulePostNL()
+    {
+        return $this->isModuleOutputEnabled('TIG_PostNL');
+    }
+
+	/**
+	 * @return bool
+	 */
+	public function isEnableAmazonPay()
+	{
+		return $this->isModuleOutputEnabled('Amazon_Payment');
+	}
+
+    /**
+     * Get current theme id
+     * @return mixed
+     */
+    public function getCurrentThemeId()
+    {
+        return $this->getConfigValue(\Magento\Framework\View\DesignInterface::XML_PATH_THEME_ID);
+    }
+}
diff --git a/Helper/Data.php b/Helper/Data.php
index 921f35e..8f4dada 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -15,648 +15,260 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Helper;
 
-use Mageplaza\Core\Helper\AbstractData;
-use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
+use Magento\Checkout\Helper\Data as HelperData;
+use Magento\Directory\Model\Region;
+use Magento\Framework\App\Filesystem\DirectoryList;
+use Magento\Framework\App\Helper\Context;
+use Magento\Framework\Locale\Resolver;
+use Magento\Framework\ObjectManagerInterface;
+use Magento\Framework\Pricing\PriceCurrencyInterface;
+use Magento\Store\Model\StoreManagerInterface;
+use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
 
 /**
  * Class Data
  * @package Mageplaza\Osc\Helper
  */
-class Data extends AbstractData
+class Data extends AbstractHelper
 {
-    const CONFIG_MODULE_PATH = 'osc';
-
-    /** Display configuration path */
-    const CONFIG_PATH_DISPLAY = 'display_configuration';
-
-    /** Design configuration path */
-    const CONFIG_PATH_DESIGN = 'design_configuration';
-
-    /** Geo configuration path */
-    const CONFIG_PATH_GEOIP = 'geoip_configuration';
-
-    /** Field position */
-    const SORTED_FIELD_POSITION = 'osc/field/position';
-
-    /** Is enable Geo Ip path */
-    const GEO_IP_IS_ENABLED = 'osc/geoip_configuration/is_enable_geoip';
-
     /**
-     * @var bool Osc Method Register
+     * @type \Magento\Checkout\Helper\Data
      */
-    protected $_flagOscMethodRegister = false;
+    protected $_helperData;
 
     /**
-     * @var Address
+     * @type \Mageplaza\Osc\Helper\Config
      */
-    protected $_addressHelper;
+    protected $_helperConfig;
 
     /**
-     * @return Address
+     * @type \Magento\Framework\Pricing\PriceCurrencyInterface
      */
-    public function getAddressHelper()
-    {
-        if(!$this->_addressHelper){
-            $this->_addressHelper = $this->objectManager->get(Address::class);
-        }
-
-        return $this->_addressHelper;
-    }
+    protected $_priceCurrency;
 
     /**
-     * @param string $field
-     * @param null $storeId
-     * @return mixed
+     * @type \Magento\Framework\App\Filesystem\DirectoryList
      */
-    public function getModuleConfig($field = '', $storeId = null)
-    {
-        $field = ($field !== '') ? '/' . $field : '';
-
-        return $this->getConfigValue(static::CONFIG_MODULE_PATH . $field, $storeId);
-    }
+    protected $_directoryList;
 
     /**
-     * Check the current page is osc
-     *
-     * @param null $store
-     * @return bool
+     * @type \Magento\Framework\Locale\Resolver
      */
-    public function isOscPage($store = null)
-    {
-        $moduleEnable = $this->isEnabled($store);
-        $isOscModule = ($this->_request->getRouteName() == 'onestepcheckout');
-
-        return $moduleEnable && $isOscModule;
-    }
+    protected $_resolver;
 
     /**
-     * @return bool
+     * @type \Magento\Directory\Model\Region
      */
-    public function isFlagOscMethodRegister()
-    {
-        return $this->_flagOscMethodRegister;
-    }
+    protected $_region;
 
     /**
-     * @param bool $flag
+     * @var bool
      */
-    public function setFlagOscMethodRegister($flag)
-    {
-        $this->_flagOscMethodRegister = $flag;
-    }
+    protected $_flagOscMethodRegister = false;
 
     /**
-     * One step checkout page title
-     *
-     * @param null $store
-     * @return mixed
+     * @param Context $context
+     * @param HelperData $helperData
+     * @param StoreManagerInterface $storeManager
+     * @param Config $helperConfig
+     * @param ObjectManagerInterface $objectManager
+     * @param PriceCurrencyInterface $priceCurrency
+     * @param DirectoryList $directoryList
+     * @param Resolver $resolver
+     * @param Region $region
      */
-    public function getCheckoutTitle($store = null)
+    public function __construct(
+        Context $context,
+        HelperData $helperData,
+        StoreManagerInterface $storeManager,
+        Config $helperConfig,
+        ObjectManagerInterface $objectManager,
+        PriceCurrencyInterface $priceCurrency,
+        DirectoryList $directoryList,
+        Resolver $resolver,
+        Region $region
+    )
     {
-        return $this->getConfigGeneral('title', $store) ?: 'One Step Checkout';
-    }
+        $this->_helperData    = $helperData;
+        $this->_helperConfig  = $helperConfig;
+        $this->_priceCurrency = $priceCurrency;
+        $this->_directoryList = $directoryList;
+        $this->_resolver      = $resolver;
+        $this->_region        = $region;
 
-    /************************ General Configuration *************************/
-    /**
-     * One step checkout page description
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getCheckoutDescription($store = null)
-    {
-        return $this->getConfigGeneral('description', $store);
+        parent::__construct($context, $objectManager, $storeManager);
     }
 
     /**
-     * Get magento default country
-     *
-     * @param null $store
-     * @return mixed
+     * @return \Mageplaza\Osc\Helper\Config
      */
-    public function getDefaultCountryId($store = null)
+    public function getConfig()
     {
-        return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
+        return $this->_helperConfig;
     }
 
     /**
-     * Default shipping method
-     *
      * @param null $store
-     * @return mixed
+     * @return bool
      */
-    public function getDefaultShippingMethod($store = null)
+    public function isEnabled($store = null)
     {
-        return $this->getConfigGeneral('default_shipping_method', $store);
+        return $this->getConfig()->isEnabled($store);
     }
 
     /**
-     * Default payment method
-     *
+     * @param $amount
      * @param null $store
-     * @return mixed
+     * @return float
      */
-    public function getDefaultPaymentMethod($store = null)
+    public function convertPrice($amount, $store = null)
     {
-        return $this->getConfigGeneral('default_payment_method', $store);
+        return $this->_priceCurrency->convert($amount, $store);
     }
 
     /**
-     * Allow guest checkout
-     *
      * @param $quote
-     * @param null $store
-     * @return bool
+     * @return float|int
      */
-    public function getAllowGuestCheckout($quote, $store = null)
+    public function calculateGiftWrapAmount($quote)
     {
-        $allowGuestCheckout = boolval($this->getConfigGeneral('allow_guest_checkout', $store));
+        $baseOscGiftWrapAmount = $this->getConfig()->getOrderGiftwrapAmount();
+        if ($baseOscGiftWrapAmount < 0.0001) {
+            return 0;
+        }
 
-        if ($this->scopeConfig->isSetFlag(
-            \Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver::XML_PATH_DISABLE_GUEST_CHECKOUT,
-            \Magento\Store\Model\ScopeInterface::SCOPE_STORE,
-            $store
-        )
-        ) {
-            foreach ($quote->getAllItems() as $item) {
-                if (($product = $item->getProduct())
-                    && $product->getTypeId() == \Magento\Downloadable\Model\Product\Type::TYPE_DOWNLOADABLE
-                ) {
-                    return false;
+        $giftWrapType = $this->getConfig()->getGiftWrapType();
+        if ($giftWrapType == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
+            $giftWrapBaseAmount    = $baseOscGiftWrapAmount;
+            $baseOscGiftWrapAmount = 0;
+            foreach ($quote->getAllVisibleItems() as $item) {
+                if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
+                    continue;
                 }
+                $baseOscGiftWrapAmount += $giftWrapBaseAmount * $item->getQty();
             }
         }
 
-        return $allowGuestCheckout;
-    }
-
-    /**
-     * Redirect To OneStepCheckout
-     * @param null $store
-     * @return bool
-     */
-    public function isRedirectToOneStepCheckout($store = null)
-    {
-        return boolval($this->getConfigGeneral('redirect_to_one_step_checkout', $store));
-    }
-
-    /**
-     * Show billing address
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getShowBillingAddress($store = null)
-    {
-        return boolval($this->getConfigGeneral('show_billing_address', $store));
-    }
-
-    /**
-     * Google api key
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getGoogleApiKey($store = null)
-    {
-        return $this->getConfigGeneral('google_api_key', $store);
-    }
-
-    /**
-     * Google restric country
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getGoogleSpecificCountry($store = null)
-    {
-        return $this->getConfigGeneral('google_specific_country', $store);
-    }
-
-    /**
-     * Check if the page is https
-     *
-     * @return bool
-     */
-    public function isGoogleHttps()
-    {
-        $isEnable = ($this->getAutoDetectedAddress() == 'google');
-
-        return $isEnable && $this->_request->isSecure();
-    }
-
-    /**
-     * Get auto detected address
-     * @param null $store
-     * @return null|'google'|'pca'
-     */
-    public function getAutoDetectedAddress($store = null)
-    {
-        return $this->getConfigGeneral('auto_detect_address', $store);
-    }
-
-    /**
-     * Login link will be hide if this function return true
-     *
-     * @param null $store
-     * @return bool
-     */
-    public function isDisableAuthentication($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_login_link', $store);
-    }
-
-    /********************************** Display Configuration *********************
-     *
-     * @param $code
-     * @param null $store
-     * @return mixed
-     */
-    public function getDisplayConfig($code = '', $store = null)
-    {
-        $code = $code ? self::CONFIG_PATH_DISPLAY . '/' . $code : self::CONFIG_PATH_DISPLAY;
-
-        return $this->getModuleConfig($code, $store);
-    }
-
-    /**
-     * Item detail will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return bool
-     */
-    public function isDisabledReviewCartSection($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_review_cart_section', $store);
-    }
-
-    /**
-     * Product image will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return bool
-     */
-    public function isHideProductImage($store = null)
-    {
-        return !$this->getDisplayConfig('is_show_product_image', $store);
+        return $this->convertPrice($baseOscGiftWrapAmount, $quote->getStore());
     }
 
     /**
-     * Coupon will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
+     * Check has library at path var/Mageplaza/Osc/GeoIp/
+     * @return bool|string
      */
-    public function disabledPaymentCoupon($store = null)
+    public function checkHasLibrary()
     {
-        return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_PAYMENT;
-    }
+        $path = $this->_directoryList->getPath('var') . '/Mageplaza/Osc/GeoIp';
+        if (!file_exists($path)) return false;
+        $folder   = scandir($path, true);
+        $pathFile = $path . '/' . $folder[0] . '/GeoLite2-City.mmdb';
+        if (!file_exists($pathFile)) return false;
 
-    /**
-     * Coupon will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function disabledReviewCoupon($store = null)
-    {
-        return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_REVIEW;
+        return $pathFile;
     }
 
     /**
-     * Comment will be hided if this function return 'true'
-     *
-     * @param null $store
+     * @param $data
      * @return mixed
      */
-    public function isDisabledComment($store = null)
+    public function getGeoIpData($data)
     {
-        return !$this->getDisplayConfig('is_enabled_comments', $store);
-    }
+        $geoIpData['city']       = $this->filterData($data, 'city', 'names');
+        $geoIpData['country_id'] = $this->filterData($data, 'country', 'iso_code', false);
+        if (!empty($this->getRegionId($data, $geoIpData['country_id']))) {
+            $geoIpData['region_id'] = $this->getRegionId($data, $geoIpData['country_id']);
+        } else {
+            $geoIpData['region'] = $this->filterData($data, 'subdivisions', 'names');
+        }
+        if (isset($data['postal'])) {
+            $geoIpData['postcode'] = $this->filterData($data, 'postal', 'code', false);
+        }
 
-    /**
-     * @param null $store
-     * @return mixed
-     */
-    public function getShowTOC($store = null)
-    {
-        return $this->getDisplayConfig('show_toc', $store);
+        return $geoIpData;
     }
 
     /**
-     * @param null $store
-     * @return mixed
+     * Filter GeoIP data
+     * @param $data
+     * @param $field
+     * @param $child
+     * @param bool|true $convert
+     * @return string
      */
-    public function isEnabledTOC($store = null)
+    public function filterData($data, $field, $child, $convert = true)
     {
-        return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::NOT_SHOW;
-    }
+        $output = '';
+        if (isset($data[$field]) && is_array($data[$field])) {
+            if ($field == 'subdivisions') {
+                foreach ($data[$field][0] as $key => $value) {
+                    $data[$field][$key] = $value;
+                }
+            }
+            if (isset($data[$field][$child])) {
+                if ($convert) {
+                    if (is_array($data[$field][$child])) {
+                        $locale   = $this->_resolver->getLocale();
+                        $language = substr($locale, 0, 2) ? substr($locale, 0, 2) : 'en';
+                        $output   = isset($data[$field][$child][$language]) ? $data[$field][$child][$language] : '';
+                    }
+                } else {
+                    $output = $data[$field][$child];
+                }
+            }
+        }
 
-    /**
-     * Term and condition checkbox in payment block will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function disabledPaymentTOC($store = null)
-    {
-        return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_PAYMENT;
+        return $output;
     }
 
     /**
-     * Term and condition checkbox in review will be hided if this function return 'true'
-     *
-     * @param null $store
+     * Find region id by Country
+     * @param $data
+     * @param $country
      * @return mixed
      */
-    public function disabledReviewTOC($store = null)
+    public function getRegionId($data, $country)
     {
-        return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_REVIEW;
-    }
+        $regionId = $this->_region->loadByCode($this->filterData($data, 'subdivisions', 'iso_code', false), $country)->getId();
 
-    /**
-     * GiftMessage will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isDisabledGiftMessage($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_gift_message', $store);
+        return $regionId;
     }
 
     /**
-     * Gift message items
-     * @param null $store
      * @return bool
      */
-    public function isEnableGiftMessageItems($store = null)
+    public function isFlagOscMethodRegister()
     {
-        return (bool)$this->getDisplayConfig('is_enabled_gift_message_items', $store);
+        return $this->_flagOscMethodRegister;
     }
 
     /**
-     * Gift wrap block will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
+     * @param bool $flag
      */
-    public function isDisabledGiftWrap($store = null)
+    public function setFlagOscMethodRegister($flag)
     {
-        $giftWrapEnabled = $this->getDisplayConfig('is_enabled_gift_wrap', $store);
-        $giftWrapAmount = $this->getOrderGiftwrapAmount();
-
-        return !$giftWrapEnabled || ($giftWrapAmount < 0);
+        $this->_flagOscMethodRegister = $flag;
     }
 
     /**
-     * Gift wrap amount
+     * Address Fields
      *
-     * @param null $store
-     * @return mixed
-     */
-    public function getOrderGiftWrapAmount($store = null)
-    {
-        return doubleval($this->getDisplayConfig('gift_wrap_amount', $store));
-    }
-
-    /**
      * @return array
      */
-    public function getGiftWrapConfiguration()
-    {
-        return [
-            'gift_wrap_type' => $this->getGiftWrapType(),
-            'gift_wrap_amount' => $this->formatGiftWrapAmount()
-        ];
-    }
-
-    /**
-     * Gift wrap type
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getGiftWrapType($store = null)
-    {
-        return $this->getDisplayConfig('gift_wrap_type', $store);
-    }
-
-    /**
-     * @return mixed
-     */
-    public function formatGiftWrapAmount()
-    {
-        $giftWrapAmount = $this->objectManager->get('Magento\Checkout\Helper\Data')
-            ->formatPrice($this->getOrderGiftWrapAmount());
-
-        return $giftWrapAmount;
-    }
-
-    /**
-     * Newsleter block will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isDisabledNewsletter($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_newsletter', $store);
-    }
-
-    /**
-     * Is newsleter subcribed default
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isSubscribedByDefault($store = null)
-    {
-        return (bool)$this->getDisplayConfig('is_checked_newsletter', $store);
-    }
-
-    /**
-     * Social Login On Checkout Page
-     * @param null $store
-     * @return bool
-     */
-    public function isDisabledSocialLoginOnCheckout($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_social_login', $store);
-    }
-
-    /**
-     * Delivery Time
-     * @param null $store
-     * @return bool
-     */
-    public function isDisabledDeliveryTime($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_delivery_time', $store);
-    }
-
-    /**
-     * House Security Code
-     * @param null $store
-     * @return bool
-     */
-    public function isDisabledHouseSecurityCode($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_house_security_code', $store);
-    }
-
-    /**
-     * Delivery Time Format
-     *
-     * @param null $store
-     *
-     * @return string 'dd/mm/yy'|'mm/dd/yy'|'yy/mm/dd'
-     */
-    public function getDeliveryTimeFormat($store = null)
-    {
-        $deliveryTimeFormat = $this->getDisplayConfig('delivery_time_format', $store);
-
-        return $deliveryTimeFormat ?: \Mageplaza\Osc\Model\System\Config\Source\DeliveryTime::DAY_MONTH_YEAR;
-    }
-
-    /**
-     * Delivery Time Off
-     * @param null $store
-     * @return bool|mixed
-     */
-    public function getDeliveryTimeOff($store = null)
-    {
-        return $this->getDisplayConfig('delivery_time_off', $store);
-    }
-
-    /**
-     * Survey
-     * @param null $store
-     * @return bool
-     */
-    public function isDisableSurvey($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_survey', $store);
-    }
-
-    /**
-     * Survey Question
-     * @param null $store
-     * @return mixed
-     */
-    public function getSurveyQuestion($store = null)
-    {
-        return $this->getDisplayConfig('survey_question', $store);
-    }
-
-    /**
-     * @param null $stores
-     * @return mixed
-     * @throws \Zend_Serializer_Exception
-     */
-    public function getSurveyAnswers($stores = null)
-    {
-        return $this->unserialize($this->getDisplayConfig('survey_answers', $stores));
-    }
-
-    /**
-     * Allow Customer Add Other Option
-     * @param null $stores
-     * @return mixed
-     */
-    public function isAllowCustomerAddOtherOption($stores = null)
-    {
-        return $this->getDisplayConfig('allow_customer_add_other_option', $stores);
-    }
-
-    /**
-     * Get layout tempate: 1 or 2 or 3 columns
-     *
-     * @param null $store
-     * @return string
-     */
-    public function getLayoutTemplate($store = null)
-    {
-        return 'Mageplaza_Osc/' . $this->getDesignConfig('page_layout', $store);
-    }
-
-    /***************************** Design Configuration *****************************
-     *
-     * @param string $code
-     * @param null $store
-     * @return mixed
-     */
-    public function getDesignConfig($code = '', $store = null)
-    {
-        $code = $code ? self::CONFIG_PATH_DESIGN . '/' . $code : self::CONFIG_PATH_DESIGN;
-
-        return $this->getModuleConfig($code, $store);
-    }
-
-    /**
-     * @return bool
-     */
-    public function isUsedMaterialDesign()
-    {
-        return $this->getDesignConfig('page_design') == 'material' ? true : false;
-    }
-
-    /***************************** GeoIP Configuration *****************************
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isEnableGeoIP($store = null)
+    public function getAddressFields()
     {
-        return boolval($this->getModuleConfig(self::CONFIG_PATH_GEOIP . '/is_enable_geoip', $store));
-    }
+        $fieldPosition = $this->_helperConfig->getAddressFieldPosition();
 
-    /**
-     * @param null $store
-     * @return mixed
-     */
-    public function getDownloadPath($store = null)
-    {
-        return $this->getModuleConfig(self::CONFIG_PATH_GEOIP . '/download_path', $store);
-    }
-
-    /***************************** Compatible Modules *****************************
-     *
-     * @return bool
-     */
-    public function isEnabledMultiSafepay()
-    {
-        return $this->_moduleManager->isOutputEnabled('MultiSafepay_Connect');
-    }
-
-    /**
-     * @return bool
-     */
-    public function isEnableModulePostNL()
-    {
-        return $this->isModuleOutputEnabled('TIG_PostNL');
-    }
-
-    /**
-     * @return bool
-     */
-    public function isEnableAmazonPay()
-    {
-        return $this->isModuleOutputEnabled('Amazon_Payment');
-    }
+        $fields = array_keys($fieldPosition);
+        if (!in_array('country_id', $fields)) {
+            array_unshift($fields, 'country_id');
+        }
 
-    /**
-     * Get current theme id
-     * @return mixed
-     */
-    public function getCurrentThemeId()
-    {
-        return $this->getConfigValue(\Magento\Framework\View\DesignInterface::XML_PATH_THEME_ID);
+        return $fields;
     }
 }
diff --git a/LICENSE b/LICENSE
index dec3ab0..f9c459c 100644
--- a/LICENSE
+++ b/LICENSE
@@ -1,33 +1 @@
-Mageplaza Co. Ltd.
-
-This License is entered by Mageplaza to govern the usage or redistribution of Mageplaza software. This is a legal agreement between you (either an individual or a single entity) and Mageplaza for Mageplaza software product(s) which may include extensions, templates and services.
-
-By purchasing, installing, or otherwise using Mageplaza products, you acknowledge that you have read this License and agree to be bound by the terms of this Agreement. If you do not agree to the terms of this License, do not install or use Mageplaza products.
-
-The Agreement becomes effective at the moment when you acquire software from our site or receive it through email or on data medium or by any other means. Mageplaza reserves the right to make reasonable changes to the terms of this license agreement and impose its clauses at any given time.
-
-    1. GRANT OF LICENSE: By purchasing a product of Mageplaza:
-
-        1. Customer will receive source code open 100%.
-
-        2. Customer will obtain a License Certificate which will remain valid until the Customer stops using the Product or until Mageplaza terminates this License because of Customer’s failure to comply with any of its Terms and Conditions. Each License Certificate includes a license serial which is valid for one live Magento installation only and unlimited test Magento installations.
-
-        3. You are allowed to customize our products to fit with your using purpose.
-
-        4. DESCRIPTION OF OTHER RIGHTS AND LIMITATIONS
-
-        5. Installation and Use
-
-        6. For each new Software installation, you are obliged to purchase a separate License. You are not permitted to use any part of the code in whole or part in any other software or product or website. You are legally bound to preserve the copyright information intact including the text/link at bottom.
-
-    2. Distribution: You are not allowed to distribute Mageplaza software to third parties. Any distribution without our permission, including non commercial distribution is considered as violation of this Agreement and entails liability, according to the current law. You may not place the Software onto a server that allows access to the Software via a public network or the Internet for distribution purposes.
-
-    3. Rental: You may not give, sell, sub-license, rent, lease or lend any portion of the Software to anyone.
-
-    4. Compliance with Applicable Laws: You must comply with all applicable laws regarding use of software products. Mageplaza software and a portion of it are protected by copyright laws and international copyright treaties, as well as other intellectual property laws and treaties. Accordingly, customer is required to treat the software like any other copyrighted material. Any activity violating copyright law will be prosecuted according to the current law. We retain the right to revoke the license of any user holding an invalid license.
-
-    5. TERMINATION: Without prejudice to any other rights, Mageplaza may terminate this License at any time if you fail to comply with the terms and conditions of this License. In such event, it constitutes a breach of the agreement, and your license to use the program is revoked and you must destroy all copies of Mageplaza products in your possession. After being notified of termination of your license, if you continue to use Mageplaza software, you hereby agree to accept an injunction to prevent you from its further use and to pay all costs (including but not limited to reasonable attorney fees) to enforce our revocation of your license and any damages suffered by us because of your misuse of the Software. We are not bound to return you the amount spent for purchase of the Software for the termination of this License.
-
-    6. LIMITATION OF LIABILITY: In no event shall Mageplaza be liable for any damages (including, without limitation, lost profits, business interruption, or lost information) rising out of ‘Authorized Users’ use of or inability to use the Mageplaza products, even if Mageplaza has been advised of the possibility of such damages. In no event will Mageplaza be liable for prosecution arising from use of the Software against law or for any illegal use.
-
-The latest License : https://www.mageplaza.com/LICENSE.txt
\ No newline at end of file
+LICENSE: https://www.mageplaza.com/LICENSE.txt
\ No newline at end of file
diff --git a/Model/AgreementsValidator.php b/Model/AgreementsValidator.php
index 44294cf..9245eb5 100644
--- a/Model/AgreementsValidator.php
+++ b/Model/AgreementsValidator.php
@@ -15,14 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Model;
 
-use Mageplaza\Osc\Helper\Data as OscHelper;
-
 /**
  * Class AgreementsValidator
  * @package Mageplaza\Osc\Model
@@ -30,22 +28,19 @@ use Mageplaza\Osc\Helper\Data as OscHelper;
 class AgreementsValidator extends \Magento\CheckoutAgreements\Model\AgreementsValidator
 {
     /**
-     * @var OscHelper
+     * @var \Mageplaza\Osc\Helper\Data
      */
-    protected $_oscHelper;
+    protected $_oscHelperConfig;
 
     /**
      * AgreementsValidator constructor.
-     * @param OscHelper $oscHelper
+     * @param \Mageplaza\Osc\Helper\Config $oscHelperConfig
      * @param null $list
      */
-    public function __construct(
-        OscHelper $oscHelper,
-        $list = null
-    )
+    public function __construct(\Mageplaza\Osc\Helper\Config $oscHelperConfig, $list = null)
     {
         parent::__construct($list);
-        $this->_oscHelper = $oscHelper;
+        $this->_oscHelperConfig = $oscHelperConfig;
     }
 
     /**
@@ -54,10 +49,10 @@ class AgreementsValidator extends \Magento\CheckoutAgreements\Model\AgreementsVa
      */
     public function isValid($agreementIds = [])
     {
-        if (!$this->_oscHelper->isEnabledTOC()) {
+        if (!$this->_oscHelperConfig->isEnabledTOC()) {
             return true;
+        } else {
+            return parent::isValid($agreementIds);
         }
-
-        return parent::isValid($agreementIds);
     }
 }
\ No newline at end of file
diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index df70a5c..fb7d17c 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -40,7 +40,7 @@ use Magento\Quote\Model\Cart\ShippingMethodConverter;
 use Magento\Quote\Model\Quote;
 use Magento\Quote\Model\Quote\TotalsCollector;
 use Mageplaza\Osc\Api\CheckoutManagementInterface;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as OscConfig;
 
 /**
  * Class CheckoutManagement
@@ -93,9 +93,9 @@ class CheckoutManagement implements CheckoutManagementInterface
     protected $shippingInformationManagement;
 
     /**
-     * @var OscHelper
+     * @type \Mageplaza\Osc\Helper\Config
      */
-    protected $oscHelper;
+    protected $oscConfig;
 
     /**
      * @var Message
@@ -129,21 +129,21 @@ class CheckoutManagement implements CheckoutManagementInterface
 
     /**
      * CheckoutManagement constructor.
-     * @param CartRepositoryInterface $cartRepository
-     * @param OscDetailsFactory $oscDetailsFactory
-     * @param ShippingMethodManagementInterface $shippingMethodManagement
-     * @param PaymentMethodManagementInterface $paymentMethodManagement
-     * @param CartTotalRepositoryInterface $cartTotalsRepository
-     * @param UrlInterface $urlBuilder
-     * @param Session $checkoutSession
-     * @param ShippingInformationManagementInterface $shippingInformationManagement
-     * @param OscHelper $oscHelper
-     * @param Message $giftMessage
-     * @param GiftMessageManager $giftMessageManager
-     * @param CustomerSession $customerSession
-     * @param TotalsCollector $totalsCollector
-     * @param AddressInterface $addressInterface
-     * @param ShippingMethodConverter $shippingMethodConverter
+     * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
+     * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
+     * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+     * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+     * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
+     * @param \Magento\Framework\UrlInterface $urlBuilder
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
+     * @param \Mageplaza\Osc\Helper\Config $oscConfig
+     * @param \Magento\GiftMessage\Model\Message $giftMessage
+     * @param \Magento\GiftMessage\Model\GiftMessageManager $giftMessageManager
+     * @param \Magento\Customer\Model\Session $customerSession
+     * @param \Magento\Quote\Model\Quote\TotalsCollector $totalsCollector
+     * @param \Magento\Quote\Api\Data\AddressInterface $addressInterface
+     * @param \Magento\Quote\Model\Cart\ShippingMethodConverter $shippingMethodConverter
      */
     public function __construct(
         CartRepositoryInterface $cartRepository,
@@ -154,7 +154,7 @@ class CheckoutManagement implements CheckoutManagementInterface
         UrlInterface $urlBuilder,
         Session $checkoutSession,
         ShippingInformationManagementInterface $shippingInformationManagement,
-        OscHelper $oscHelper,
+        OscConfig $oscConfig,
         Message $giftMessage,
         GiftMessageManager $giftMessageManager,
         customerSession $customerSession,
@@ -163,21 +163,21 @@ class CheckoutManagement implements CheckoutManagementInterface
         ShippingMethodConverter $shippingMethodConverter
     )
     {
-        $this->cartRepository = $cartRepository;
-        $this->oscDetailsFactory = $oscDetailsFactory;
-        $this->shippingMethodManagement = $shippingMethodManagement;
-        $this->paymentMethodManagement = $paymentMethodManagement;
-        $this->cartTotalsRepository = $cartTotalsRepository;
-        $this->_urlBuilder = $urlBuilder;
-        $this->checkoutSession = $checkoutSession;
+        $this->cartRepository                = $cartRepository;
+        $this->oscDetailsFactory             = $oscDetailsFactory;
+        $this->shippingMethodManagement      = $shippingMethodManagement;
+        $this->paymentMethodManagement       = $paymentMethodManagement;
+        $this->cartTotalsRepository          = $cartTotalsRepository;
+        $this->_urlBuilder                   = $urlBuilder;
+        $this->checkoutSession               = $checkoutSession;
         $this->shippingInformationManagement = $shippingInformationManagement;
-        $this->oscHelper = $oscHelper;
-        $this->giftMessage = $giftMessage;
-        $this->giftMessageManagement = $giftMessageManager;
-        $this->_customerSession = $customerSession;
-        $this->_totalsCollector = $totalsCollector;
-        $this->_addressInterface = $addressInterface;
-        $this->_shippingMethodConverter = $shippingMethodConverter;
+        $this->oscConfig                     = $oscConfig;
+        $this->giftMessage                   = $giftMessage;
+        $this->giftMessageManagement         = $giftMessageManager;
+        $this->_customerSession              = $customerSession;
+        $this->_totalsCollector              = $totalsCollector;
+        $this->_addressInterface             = $addressInterface;
+        $this->_shippingMethodConverter      = $shippingMethodConverter;
     }
 
     /**
@@ -190,7 +190,7 @@ class CheckoutManagement implements CheckoutManagementInterface
         }
 
         /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->cartRepository->getActive($cartId);
+        $quote     = $this->cartRepository->getActive($cartId);
         $quoteItem = $quote->getItemById($itemId);
         if (!$quoteItem) {
             throw new NoSuchEntityException(
@@ -214,7 +214,7 @@ class CheckoutManagement implements CheckoutManagementInterface
     public function removeItemById($cartId, $itemId)
     {
         /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->cartRepository->getActive($cartId);
+        $quote     = $this->cartRepository->getActive($cartId);
         $quoteItem = $quote->getItemById($itemId);
         if (!$quoteItem) {
             throw new NoSuchEntityException(
@@ -263,9 +263,8 @@ class CheckoutManagement implements CheckoutManagementInterface
     /**
      * Response data to update osc block
      *
-     * @param Quote $quote
+     * @param \Magento\Quote\Model\Quote $quote
      * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
-     * @throws NoSuchEntityException
      */
     public function getResponseData(Quote $quote)
     {
@@ -319,7 +318,7 @@ class CheckoutManagement implements CheckoutManagementInterface
      */
     public function getShippingMethods(Quote $quote)
     {
-        $result = [];
+        $result          = [];
         $shippingAddress = $quote->getShippingAddress();
         $shippingAddress->addData($this->_addressInterface->getData());
         $shippingAddress->setCollectShippingRates(true);
@@ -337,16 +336,15 @@ class CheckoutManagement implements CheckoutManagementInterface
     /**
      * @param $cartId
      * @param $additionInformation
-     * @throws CouldNotSaveException
-     * @throws NoSuchEntityException
+     * @throws \Magento\Framework\Exception\CouldNotSaveException
      */
     public function addGiftMessage($cartId, $additionInformation)
     {
         /** @var \Magento\Quote\Model\Quote $quote */
         $quote = $this->cartRepository->getActive($cartId);
 
-        if (!$this->oscHelper->isDisabledGiftMessage() && isset($additionInformation['giftMessage'])) {
-            $giftMessage = OscHelper::jsonDecode($additionInformation['giftMessage']);
+        if (!$this->oscConfig->isDisabledGiftMessage() && isset($additionInformation['giftMessage'])) {
+            $giftMessage = json_decode($additionInformation['giftMessage'], true);
             $this->giftMessage->setSender(isset($giftMessage['sender']) ? $giftMessage['sender'] : '');
             $this->giftMessage->setRecipient(isset($giftMessage['recipient']) ? $giftMessage['recipient'] : '');
             $this->giftMessage->setMessage(isset($giftMessage['message']) ? $giftMessage['message'] : '');
diff --git a/Model/CheckoutRegister.php b/Model/CheckoutRegister.php
index f2330f7..6f61f40 100644
--- a/Model/CheckoutRegister.php
+++ b/Model/CheckoutRegister.php
@@ -15,19 +15,14 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Model;
 
-use Magento\Checkout\Model\Session;
-use Magento\Customer\Api\AccountManagementInterface;
-use Magento\Framework\Api\DataObjectHelper;
-use Magento\Framework\DataObject\Copy;
 use Magento\Quote\Model\CustomerManagement;
 use Magento\Quote\Model\Quote;
-use Mageplaza\Osc\Helper\Data;
 
 /**
  * Class CheckoutRegister
@@ -36,22 +31,22 @@ use Mageplaza\Osc\Helper\Data;
 class CheckoutRegister
 {
     /**
-     * @var Session
+     * @var \Magento\Checkout\Model\Session
      */
     protected $checkoutSession;
 
     /**
-     * @type Copy
+     * @type \Magento\Framework\DataObject\Copy
      */
     protected $_objectCopyService;
 
     /**
-     * @type DataObjectHelper
+     * @type \Magento\Framework\Api\DataObjectHelper
      */
     protected $dataObjectHelper;
 
     /**
-     * @type AccountManagementInterface
+     * @type \Magento\Customer\Api\AccountManagementInterface
      */
     protected $accountManagement;
 
@@ -66,34 +61,34 @@ class CheckoutRegister
     protected $_isCheckedRegister = false;
 
     /**
-     * @var Data
+     * @var \Mageplaza\Osc\Helper\Data
      */
-    protected $_oscHelper;
+    protected $_oscHelperData;
 
     /**
      * CheckoutRegister constructor.
-     * @param Session $checkoutSession
-     * @param Copy $objectCopyService
-     * @param DataObjectHelper $dataObjectHelper
-     * @param AccountManagementInterface $accountManagement
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Magento\Framework\DataObject\Copy $objectCopyService
+     * @param \Magento\Framework\Api\DataObjectHelper $dataObjectHelper
+     * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
      * @param \Magento\Quote\Model\CustomerManagement $customerManagement
-     * @param Data $oscHelper
+     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
      */
     public function __construct(
-        Session $checkoutSession,
-        Copy $objectCopyService,
-        DataObjectHelper $dataObjectHelper,
-        AccountManagementInterface $accountManagement,
+        \Magento\Checkout\Model\Session $checkoutSession,
+        \Magento\Framework\DataObject\Copy $objectCopyService,
+        \Magento\Framework\Api\DataObjectHelper $dataObjectHelper,
+        \Magento\Customer\Api\AccountManagementInterface $accountManagement,
         CustomerManagement $customerManagement,
-        Data $oscHelper
+        \Mageplaza\Osc\Helper\Data $oscHelperData
     )
     {
-        $this->checkoutSession = $checkoutSession;
+        $this->checkoutSession    = $checkoutSession;
         $this->_objectCopyService = $objectCopyService;
-        $this->dataObjectHelper = $dataObjectHelper;
-        $this->accountManagement = $accountManagement;
+        $this->dataObjectHelper   = $dataObjectHelper;
+        $this->accountManagement  = $accountManagement;
         $this->customerManagement = $customerManagement;
-        $this->_oscHelper = $oscHelper;
+        $this->_oscHelperData     = $oscHelperData;
     }
 
     /**
@@ -104,7 +99,6 @@ class CheckoutRegister
         if ($this->isCheckedRegister()) {
             return $this;
         }
-
         $this->setIsCheckedRegister(true);
 
         /** @type \Magento\Quote\Model\Quote $quote */
@@ -139,10 +133,10 @@ class CheckoutRegister
      */
     protected function _prepareNewCustomerQuote(Quote $quote, $oscData)
     {
-        $billing = $quote->getBillingAddress();
+        $billing  = $quote->getBillingAddress();
         $shipping = $quote->isVirtual() ? null : $quote->getShippingAddress();
 
-        $customer = $quote->getCustomer();
+        $customer  = $quote->getCustomer();
         $dataArray = $billing->getData();
         if (isset($oscData['customerAttributes']) && $oscData['customerAttributes']) {
             $dataArray = array_merge($dataArray, $oscData['customerAttributes']);
@@ -154,11 +148,7 @@ class CheckoutRegister
         );
 
         $quote->setCustomer($customer);
-
-        /** Create customer */
-        $this->customerManagement->populateCustomerInfo($quote);
-
-        $this->_oscHelper->setFlagOscMethodRegister(true);
+        $this->_oscHelperData->setFlagOscMethodRegister(true);
 
         /** Init customer address */
         $customerBillingData = $billing->exportCustomerAddress();
@@ -184,6 +174,9 @@ class CheckoutRegister
         // Add billing address to quote since customer Data Object does not hold address information
         $quote->addCustomerAddress($customerBillingData);
 
+        /** Create customer */
+        $this->customerManagement->populateCustomerInfo($quote);
+
         // If customer is created, set customerId for address to avoid create more address when checkout
         if ($customerId = $quote->getCustomerId()) {
             $quote->getBillingAddress()->setCustomerId($customerId);
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index 1325e77..a12342f 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -28,7 +28,8 @@ use Magento\Framework\Module\Manager as ModuleManager;
 use Magento\GiftMessage\Model\CompositeConfigProvider;
 use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as OscConfig;
+use Mageplaza\Osc\Helper\Data as HelperData;
 use Mageplaza\Osc\Model\Geoip\Database\Reader;
 
 /**
@@ -37,166 +38,194 @@ use Mageplaza\Osc\Model\Geoip\Database\Reader;
  */
 class DefaultConfigProvider implements ConfigProviderInterface
 {
-    /**
-     * @var CheckoutSession
-     */
-    private $checkoutSession;
-
-    /**
-     * @var \Magento\Quote\Api\PaymentMethodManagementInterface
-     */
-    protected $paymentMethodManagement;
-
-    /**
-     * @type \Magento\Quote\Api\ShippingMethodManagementInterface
-     */
-    protected $shippingMethodManagement;
-
-    /**
-     * @var \Magento\Checkout\Model\CompositeConfigProvider
-     */
-    protected $giftMessageConfigProvider;
-
-    /**
-     * @var ModuleManager
-     */
-    protected $moduleManager;
-
-    /**
-     * @var OscHelper
-     */
-    protected $_oscHelper;
-
-    /**
-     * DefaultConfigProvider constructor.
-     * @param CheckoutSession $checkoutSession
-     * @param PaymentMethodManagementInterface $paymentMethodManagement
-     * @param ShippingMethodManagementInterface $shippingMethodManagement
-     * @param CompositeConfigProvider $configProvider
-     * @param ModuleManager $moduleManager
-     * @param OscHelper $oscHelper
-     */
-    public function __construct(
-        CheckoutSession $checkoutSession,
-        PaymentMethodManagementInterface $paymentMethodManagement,
-        ShippingMethodManagementInterface $shippingMethodManagement,
-        CompositeConfigProvider $configProvider,
-        ModuleManager $moduleManager,
-        OscHelper $oscHelper
-    )
-    {
-        $this->checkoutSession = $checkoutSession;
-        $this->paymentMethodManagement = $paymentMethodManagement;
-        $this->shippingMethodManagement = $shippingMethodManagement;
-        $this->giftMessageConfigProvider = $configProvider;
-        $this->moduleManager = $moduleManager;
-        $this->_oscHelper = $oscHelper;
-    }
-
-    /**
-     * {@inheritdoc}
-     */
-    public function getConfig()
-    {
-        if (!$this->_oscHelper->isOscPage()) {
-            return [];
-        }
 
-        $output = [
-            'shippingMethods' => $this->getShippingMethods(),
-            'selectedShippingRate' => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod())
-                ? $existShippingMethod : $this->_oscHelper->getDefaultShippingMethod(),
-            'paymentMethods' => $this->getPaymentMethods(),
-            'selectedPaymentMethod' => $this->_oscHelper->getDefaultPaymentMethod(),
-            'oscConfig' => $this->getOscConfig()
-        ];
-
-        return $output;
-    }
-
-    /**
-     * @return array
-     */
-    private function getOscConfig()
-    {
-        return [
-            'addressFields' => $this->_oscHelper->getAddressHelper()->getAddressFields(),
-            'autocomplete' => [
-                'type' => $this->_oscHelper->getAutoDetectedAddress(),
-                'google_default_country' => $this->_oscHelper->getGoogleSpecificCountry(),
-            ],
-            'register' => [
-                'dataPasswordMinLength' => $this->_oscHelper->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
-                'dataPasswordMinCharacterSets' => $this->_oscHelper->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
-            ],
-            'allowGuestCheckout' => $this->_oscHelper->getAllowGuestCheckout($this->checkoutSession->getQuote()),
-            'showBillingAddress' => $this->_oscHelper->getShowBillingAddress(),
-            'newsletterDefault' => $this->_oscHelper->isSubscribedByDefault(),
-            'isUsedGiftWrap' => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
-            'giftMessageOptions' => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), [
-                'isEnableOscGiftMessageItems' => $this->_oscHelper->isEnableGiftMessageItems()
-            ]),
-            'isDisplaySocialLogin' => $this->isDisplaySocialLogin(),
-            'deliveryTimeOptions' => [
-                'deliveryTimeFormat' => $this->_oscHelper->getDeliveryTimeFormat(),
-                'deliveryTimeOff' => $this->_oscHelper->getDeliveryTimeOff(),
-                'houseSecurityCode' => $this->_oscHelper->isDisabledHouseSecurityCode()
-            ],
-            'isUsedMaterialDesign' => $this->_oscHelper->isUsedMaterialDesign(),
-            'isAmazonAccountLoggedIn' => false,
-            'geoIpOptions' => [
-                'isEnableGeoIp' => $this->_oscHelper->isEnableGeoIP(),
-                'geoIpData' => $this->_oscHelper->getAddressHelper()->getGeoIpData()
-            ],
-            'compatible' => [
-                'isEnableModulePostNL' => $this->_oscHelper->isEnableModulePostNL(),
-            ],
-            'show_toc' => $this->_oscHelper->getShowTOC()
-        ];
-    }
-
-    /**
-     * Returns array of payment methods
-     *
-     * @return array
-     * @throws \Magento\Framework\Exception\NoSuchEntityException
-     */
-    private function getPaymentMethods()
-    {
-        $paymentMethods = [];
-        $quote = $this->checkoutSession->getQuote();
+	/**
+	 * @var CheckoutSession
+	 */
+	private $checkoutSession;
+
+	/**
+	 * @var \Magento\Quote\Api\PaymentMethodManagementInterface
+	 */
+	protected $paymentMethodManagement;
+
+	/**
+	 * @type \Magento\Quote\Api\ShippingMethodManagementInterface
+	 */
+	protected $shippingMethodManagement;
+
+	/**
+	 * @type \Mageplaza\Osc\Helper\Config
+	 */
+	protected $oscConfig;
+
+	/**
+	 * @var \Magento\Checkout\Model\CompositeConfigProvider
+	 */
+	protected $giftMessageConfigProvider;
+
+	/**
+	 * @var ModuleManager
+	 */
+	protected $moduleManager;
+
+	/**
+	 * @type \Mageplaza\Osc\Helper\Data
+	 */
+	protected $_helperData;
+
+	/**
+	 * @type \Mageplaza\Osc\Model\Geoip\Database\Reader
+	 */
+	protected $_geoIpData;
+
+	/**
+	 * DefaultConfigProvider constructor.
+	 * @param CheckoutSession $checkoutSession
+	 * @param PaymentMethodManagementInterface $paymentMethodManagement
+	 * @param ShippingMethodManagementInterface $shippingMethodManagement
+	 * @param OscConfig $oscConfig
+	 * @param CompositeConfigProvider $configProvider
+	 * @param ModuleManager $moduleManager
+	 * @param HelperData $helperData
+	 * @param Reader $geoIpData
+	 */
+	public function __construct(
+		CheckoutSession $checkoutSession,
+		PaymentMethodManagementInterface $paymentMethodManagement,
+		ShippingMethodManagementInterface $shippingMethodManagement,
+		OscConfig $oscConfig,
+		CompositeConfigProvider $configProvider,
+		ModuleManager $moduleManager,
+		HelperData $helperData,
+		Reader $geoIpData
+	)
+	{
+		$this->checkoutSession           = $checkoutSession;
+		$this->paymentMethodManagement   = $paymentMethodManagement;
+		$this->shippingMethodManagement  = $shippingMethodManagement;
+		$this->oscConfig                 = $oscConfig;
+		$this->giftMessageConfigProvider = $configProvider;
+		$this->moduleManager             = $moduleManager;
+		$this->_helperData               = $helperData;
+		$this->_geoIpData                = $geoIpData;
+	}
+
+	/**
+	 * {@inheritdoc}
+	 */
+	public function getConfig()
+	{
+		if (!$this->oscConfig->isOscPage()) {
+			return [];
+		}
+
+		$output = [
+			'shippingMethods'       => $this->getShippingMethods(),
+			'selectedShippingRate'  => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod()) ? $existShippingMethod : $this->oscConfig->getDefaultShippingMethod(),
+			'paymentMethods'        => $this->getPaymentMethods(),
+			'selectedPaymentMethod' => $this->oscConfig->getDefaultPaymentMethod(),
+			'oscConfig'             => $this->getOscConfig()
+		];
+
+		return $output;
+	}
+
+	/**
+	 * @return array
+	 */
+	private function getOscConfig()
+	{
+		return [
+			'addressFields'           => $this->_helperData->getAddressFields(),
+			'autocomplete'            => [
+				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
+				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
+			],
+			'register'                => [
+				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
+				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
+			],
+			'allowGuestCheckout'      => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
+			'showBillingAddress'      => $this->oscConfig->getShowBillingAddress(),
+			'newsletterDefault'       => $this->oscConfig->isSubscribedByDefault(),
+			'isUsedGiftWrap'          => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
+			'giftMessageOptions'      => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), ['isEnableOscGiftMessageItems' => $this->oscConfig->isEnableGiftMessageItems()]),
+			'isDisplaySocialLogin'    => $this->isDisplaySocialLogin(),
+			'deliveryTimeOptions'     => [
+				'deliveryTimeFormat' => $this->oscConfig->getDeliveryTimeFormat(),
+				'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff(),
+				'houseSecurityCode'  => $this->oscConfig->isDisabledHouseSecurityCode()
+			],
+			'isUsedMaterialDesign'    => $this->oscConfig->isUsedMaterialDesign(),
+			'isAmazonAccountLoggedIn' => false,
+			'geoIpOptions'            => [
+				'isEnableGeoIp' => $this->oscConfig->isEnableGeoIP(),
+				'geoIpData'     => $this->getGeoIpData()
+			],
+			'compatible'              => [
+				'isEnableModulePostNL' => $this->oscConfig->isEnableModulePostNL(),
+			],
+			'show_toc'                => $this->oscConfig->getShowTOC()
+		];
+	}
+
+	/**
+	 * @return mixed
+	 */
+	public function getGeoIpData()
+	{
+		if ($this->oscConfig->isEnableGeoIP() && $this->_helperData->checkHasLibrary()) {
+			$ip = $_SERVER['REMOTE_ADDR'];
+			if (!filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE) || $ip == '127.0.0.1') {
+				$ip = '123.16.189.71';
+			}
+			$data = $this->_geoIpData->city($ip);
+
+			return $this->_helperData->getGeoIpData($data);
+		}
+	}
+
+	/**
+	 * Returns array of payment methods
+	 * @return array
+	 */
+	private function getPaymentMethods()
+	{
+		$paymentMethods = [];
+		$quote          = $this->checkoutSession->getQuote();
         if (!$quote->getIsVirtual()) {
             foreach ($this->paymentMethodManagement->getList($quote->getId()) as $paymentMethod) {
                 $paymentMethods[] = [
-                    'code' => $paymentMethod->getCode(),
+                    'code'  => $paymentMethod->getCode(),
                     'title' => $paymentMethod->getTitle()
                 ];
             }
         }
 
-        return $paymentMethods;
-    }
-
-    /**
-     * @return \Magento\Quote\Api\Data\ShippingMethodInterface[]
-     * @throws \Magento\Framework\Exception\NoSuchEntityException
-     * @throws \Magento\Framework\Exception\StateException
-     */
-    private function getShippingMethods()
-    {
-        $methodLists = $this->shippingMethodManagement->getList($this->checkoutSession->getQuote()->getId());
-        foreach ($methodLists as $key => $method) {
-            $methodLists[$key] = $method->__toArray();
-        }
-
-        return $methodLists;
-    }
-
-    /**
-     * @return bool
-     */
-    private function isDisplaySocialLogin()
-    {
-        return $this->moduleManager->isOutputEnabled('Mageplaza_SocialLogin') && !$this->_oscHelper->isDisabledSocialLoginOnCheckout();
-    }
+		return $paymentMethods;
+	}
+
+	/**
+	 * Returns array of payment methods
+	 * @return array
+	 */
+	private function getShippingMethods()
+	{
+		$methodLists = $this->shippingMethodManagement->getList($this->checkoutSession->getQuote()->getId());
+		foreach ($methodLists as $key => $method) {
+			$methodLists[$key] = $method->__toArray();
+		}
+
+		return $methodLists;
+	}
+
+	/**
+	 * @return bool
+	 */
+	private function isDisplaySocialLogin()
+	{
+
+		return $this->moduleManager->isOutputEnabled('Mageplaza_SocialLogin') && !$this->oscConfig->isDisabledSocialLoginOnCheckout();
+	}
 }
diff --git a/Model/Geoip/Database/Reader.php b/Model/Geoip/Database/Reader.php
new file mode 100644
index 0000000..68e2f6b
--- /dev/null
+++ b/Model/Geoip/Database/Reader.php
@@ -0,0 +1,169 @@
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
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\Osc\Model\Geoip\Database;
+
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader as DbReader;
+use Mageplaza\Osc\Model\Geoip\ProviderInterface;
+
+/**
+ * Instances of this class provide a reader for the GeoIP2 database format.
+ * IP addresses can be looked up using the database specific methods.
+ *
+ * ## Usage ##
+ *
+ * The basic API for this class is the same for every database. First, you
+ * create a reader object, specifying a file name. You then call the method
+ * corresponding to the specific database, passing it the IP address you want
+ * to look up.
+ *
+ * If the request succeeds, the method call will return a model class for
+ * the method you called. This model in turn contains multiple record classes,
+ * each of which represents part of the data returned by the database. If
+ * the database does not contain the requested information, the attributes
+ * on the record class will have a `null` value.
+ *
+ * If the address is not in the database, an
+ * {@link \GeoIp2\Exception\AddressNotFoundException} exception will be
+ * thrown. If an invalid IP address is passed to one of the methods, a
+ * SPL {@link \InvalidArgumentException} will be thrown. If the database is
+ * corrupt or invalid, a {@link \MaxMind\Db\Reader\InvalidDatabaseException}
+ * will be thrown.
+ *
+ */
+class Reader implements ProviderInterface
+{
+    /**
+     * @type \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader
+     */
+    private $_dbReader;
+
+    /**
+     * @type array
+     */
+    private $locales;
+
+
+    /**
+     * @param \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader $dbreader
+     */
+    public function __construct(
+        DbReader $dbreader
+    )
+    {
+        $this->_dbReader = $dbreader;
+        $this->locales   = array('en');
+    }
+
+    /**
+     * This method returns a GeoIP2 City model.
+     * @param string $ipAddress IPv4 or IPv6 address as a string.
+     * @return array
+     */
+    public function city($ipAddress)
+    {
+        return $this->modelFor('City', 'City', $ipAddress);
+    }
+
+    /**
+     * This method returns a GeoIP2 Country model.
+     * @param string $ipAddress IPv4 or IPv6 address as a string.
+     * @return array
+     */
+    public function country($ipAddress)
+    {
+        return $this->modelFor('Country', 'Country', $ipAddress);
+    }
+
+
+    /**
+     * @param $class
+     * @param $type
+     * @param $ipAddress
+     * @return array
+     */
+    private function modelFor($class, $type, $ipAddress)
+    {
+        $record = $this->getRecord($class, $type, $ipAddress);
+
+        $record['traits']['ip_address'] = $ipAddress;
+        $this->close();
+
+        return $record;
+    }
+
+    /**
+     * @param $class
+     * @param $type
+     * @param $ipAddress
+     * @return array
+     * @throws \Exception
+     */
+    private function getRecord($class, $type, $ipAddress)
+    {
+        if (strpos($this->metadata()->databaseType, $type) === false) {
+            $method = lcfirst($class);
+            throw new \Exception(
+                "The $method method cannot be used to open a "
+                . $this->metadata()->databaseType . " database"
+            );
+        }
+        $record = $this->_dbReader->get($ipAddress);
+        if ($record === null) {
+            throw new \Exception(
+                "The address $ipAddress is not in the database."
+            );
+        }
+        if (!is_array($record)) {
+            // This can happen on corrupt databases. Generally,
+            // MaxMind\Db\Reader will throw a
+            // MaxMind\Db\Reader\InvalidDatabaseException, but occasionally
+            // the lookup may result in a record that looks valid but is not
+            // an array. This mostly happens when the user is ignoring all
+            // exceptions and the more frequent InvalidDatabaseException
+            // exceptions go unnoticed.
+            throw new \Exception(
+                "Expected an array when looking up $ipAddress but received: "
+                . gettype($record)
+            );
+        }
+
+        return $record;
+    }
+
+    /**
+     * @throws \InvalidArgumentException if arguments are passed to the method.
+     * @throws \BadMethodCallException if the database has been closed.
+     * @return \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Metadata object for the database.
+     */
+    public function metadata()
+    {
+        return $this->_dbReader->metadata();
+    }
+
+    /**
+     * Closes the GeoIP2 database and returns the resources to the system.
+     */
+    public function close()
+    {
+        $this->_dbReader->close();
+    }
+}
diff --git a/Model/Geoip/Maxmind/Db/Reader.php b/Model/Geoip/Maxmind/Db/Reader.php
new file mode 100644
index 0000000..5129833
--- /dev/null
+++ b/Model/Geoip/Maxmind/Db/Reader.php
@@ -0,0 +1,387 @@
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
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db;
+
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Decoder;
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException;
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Metadata;
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util;
+
+/**
+ * Instances of this class provide a reader for the MaxMind DB format. IP
+ * addresses can be looked up using the <code>get</code> method.
+ */
+class Reader
+{
+	private static $DATA_SECTION_SEPARATOR_SIZE = 16;
+	private static $METADATA_START_MARKER = "\xAB\xCD\xEFMaxMind.com";
+	private static $METADATA_START_MARKER_LENGTH = 14;
+	private static $METADATA_MAX_SIZE = 131072; // 128 * 1024 = 128KB
+
+	/**
+	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Decoder
+	 */
+	private $decoder;
+
+	/**
+	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
+	 */
+	private $invalidDatabaseException;
+
+	/**
+	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Util
+	 */
+	private $util;
+
+	/**
+	 * @type
+	 */
+	private $fileHandle;
+
+	/**
+	 * @type
+	 */
+	private $fileSize;
+
+	/**
+	 * @type
+	 */
+	private $ipV4Start;
+
+	/**
+	 * @type \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Metadata
+	 */
+	private $metadata;
+
+	/**
+	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Decoder $decoder
+	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException $invalidDatabaseException
+	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Metadata $metadata
+	 * @param \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\Util $util
+	 */
+	public function __construct(
+		Decoder $decoder,
+		InvalidDatabaseException $invalidDatabaseException,
+		Metadata $metadata,
+		Util $util
+	)
+	{
+		$this->decoder                  = $decoder;
+		$this->invalidDatabaseException = $invalidDatabaseException;
+		$this->metadata                 = $metadata;
+		$this->util                     = $util;
+		$this->initReader();
+	}
+
+	public function initReader()
+	{
+		$objectManager = \Magento\Framework\App\ObjectManager::getInstance();
+		$database =  $objectManager->create('Mageplaza\Osc\Helper\Data')->checkHasLibrary();
+		if(!$database){
+			return $this;
+		}
+
+		if (!is_readable($database)) {
+			throw new \InvalidArgumentException(
+				"The file \"$database\" does not exist or is not readable."
+			);
+		}
+		$this->fileHandle = @fopen($database, 'rb');
+		if ($this->fileHandle === false) {
+			throw new \InvalidArgumentException(
+				"Error opening \"$database\"."
+			);
+		}
+		$this->fileSize = @filesize($database);
+		if ($this->fileSize === false) {
+			throw new \UnexpectedValueException(
+				"Error determining the size of \"$database\"."
+			);
+		}
+
+		$start           = $this->findMetadataStart($database);
+		$metadataDecoder = $this->decoder->init($this->fileHandle, $start);
+		// // $metadataDecoder = new Decoder($this->fileHandle, $start);
+		list($metadataArray) = $metadataDecoder->decode($start);
+		$this->metadata = $this->metadata->init($metadataArray);
+		$this->decoder  = $this->decoder->init(
+			$this->fileHandle,
+			$this->metadata->searchTreeSize + self::$DATA_SECTION_SEPARATOR_SIZE
+		);
+	}
+
+	/**
+	 * Looks up the <code>address</code> in the MaxMind DB.
+	 *
+	 * @param string $ipAddress
+	 *            the IP address to look up.
+	 * @return array the record for the IP address.
+	 * @throws \BadMethodCallException if this method is called on a closed database.
+	 * @throws \InvalidArgumentException if something other than a single IP address is passed to the method.
+	 * @throws InvalidDatabaseException
+	 *             if the database is invalid or there is an error reading
+	 *             from it.
+	 */
+	public function get($ipAddress)
+	{
+		if (func_num_args() != 1) {
+			throw new \InvalidArgumentException(
+				'Method takes exactly one argument.'
+			);
+		}
+
+		if (!is_resource($this->fileHandle)) {
+			throw new \BadMethodCallException(
+				'Attempt to read from a closed MaxMind DB.'
+			);
+		}
+
+		if (!filter_var($ipAddress, FILTER_VALIDATE_IP)) {
+			throw new \InvalidArgumentException(
+				"The value \"$ipAddress\" is not a valid IP address."
+			);
+		}
+
+		if ($this->metadata->ipVersion == 4 && strrpos($ipAddress, ':')) {
+			throw new \InvalidArgumentException(
+				"Error looking up $ipAddress. You attempted to look up an"
+				. " IPv6 address in an IPv4-only database."
+			);
+		}
+		$pointer = $this->findAddressInTree($ipAddress);
+		if ($pointer == 0) {
+			return null;
+		}
+
+		return $this->resolveDataPointer($pointer);
+	}
+
+	/**
+	 * @param $ipAddress
+	 * @return int
+	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
+	 */
+	private function findAddressInTree($ipAddress)
+	{
+		// XXX - could simplify. Done as a byte array to ease porting
+		$rawAddress = array_merge(unpack('C*', inet_pton($ipAddress)));
+
+		$bitCount = count($rawAddress) * 8;
+
+		// The first node of the tree is always node 0, at the beginning of the
+		// value
+		$node = $this->startNode($bitCount);
+
+		for ($i = 0; $i < $bitCount; $i++) {
+			if ($node >= $this->metadata->nodeCount) {
+				break;
+			}
+			$tempBit = 0xFF & $rawAddress[$i >> 3];
+			$bit     = 1 & ($tempBit >> 7 - ($i % 8));
+
+			$node = $this->readNode($node, $bit);
+		}
+		if ($node == $this->metadata->nodeCount) {
+			// Record is empty
+			return 0;
+		} elseif ($node > $this->metadata->nodeCount) {
+			// Record is a data pointer
+			return $node;
+		}
+		throw new InvalidDatabaseException("Something bad happened");
+	}
+
+	/**
+	 * @param $length
+	 * @return int
+	 */
+	private function startNode($length)
+	{
+		// Check if we are looking up an IPv4 address in an IPv6 tree. If this
+		// is the case, we can skip over the first 96 nodes.
+		if ($this->metadata->ipVersion == 6 && $length == 32) {
+			return $this->ipV4StartNode();
+		}
+		// The first node of the tree is always node 0, at the beginning of the
+		// value
+		return 0;
+	}
+
+	/**
+	 * @return int
+	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
+	 */
+	private function ipV4StartNode()
+	{
+		//This is a defensive check. There is no reason to call this when you
+		//have an IPv4 tree.
+		if ($this->metadata->ipVersion == 4) {
+			return 0;
+		}
+
+		if ($this->ipV4Start != 0) {
+			return $this->ipV4Start;
+		}
+		$node = 0;
+
+		for ($i = 0; $i < 96 && $node < $this->metadata->nodeCount; $i++) {
+			$node = $this->readNode($node, 0);
+		}
+		$this->ipV4Start = $node;
+
+		return $node;
+	}
+
+	/**
+	 * @param $nodeNumber
+	 * @param $index
+	 * @return mixed
+	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
+	 */
+	private function readNode($nodeNumber, $index)
+	{
+		$baseOffset = $nodeNumber * $this->metadata->nodeByteSize;
+
+		// XXX - probably could condense this.
+		switch ($this->metadata->recordSize) {
+			case 24:
+				$bytes = Util::read($this->fileHandle, $baseOffset + $index * 3, 3);
+				list(, $node) = unpack('N', "\x00" . $bytes);
+
+				return $node;
+			case 28:
+				$middleByte = Util::read($this->fileHandle, $baseOffset + 3, 1);
+				list(, $middle) = unpack('C', $middleByte);
+				if ($index == 0) {
+					$middle = (0xF0 & $middle) >> 4;
+				} else {
+					$middle = 0x0F & $middle;
+				}
+				$bytes = Util::read($this->fileHandle, $baseOffset + $index * 4, 3);
+				list(, $node) = unpack('N', chr($middle) . $bytes);
+
+				return $node;
+			case 32:
+				$bytes = Util::read($this->fileHandle, $baseOffset + $index * 4, 4);
+				list(, $node) = unpack('N', $bytes);
+
+				return $node;
+			default:
+				throw new InvalidDatabaseException(
+					'Unknown record size: '
+					. $this->metadata->recordSize
+				);
+		}
+	}
+
+	/**
+	 * @param $pointer
+	 * @return mixed
+	 * @throws \Mageplaza\Osc\Model\Geoip\MaxMind\Db\Reader\InvalidDatabaseException
+	 */
+	private function resolveDataPointer($pointer)
+	{
+		$resolved = $pointer - $this->metadata->nodeCount
+			+ $this->metadata->searchTreeSize;
+		if ($resolved > $this->fileSize) {
+			throw new InvalidDatabaseException(
+				"The MaxMind DB file's search tree is corrupt"
+			);
+		}
+
+		list($data) = $this->decoder->decode($resolved);
+
+		return $data;
+	}
+
+	/*
+	 * This is an extremely naive but reasonably readable implementation. There
+	 * are much faster algorithms (e.g., Boyer-Moore) for this if speed is ever
+	 * an issue, but I suspect it won't be.
+	 */
+	private function findMetadataStart($filename)
+	{
+		$handle       = $this->fileHandle;
+		$fstat        = fstat($handle);
+		$fileSize     = $fstat['size'];
+		$marker       = self::$METADATA_START_MARKER;
+		$markerLength = self::$METADATA_START_MARKER_LENGTH;
+		$metadataMaxLengthExcludingMarker
+			= min(self::$METADATA_MAX_SIZE, $fileSize) - $markerLength;
+
+		for ($i = 0; $i <= $metadataMaxLengthExcludingMarker; $i++) {
+			for ($j = 0; $j < $markerLength; $j++) {
+				fseek($handle, $fileSize - $i - $j - 1);
+				$matchBit = fgetc($handle);
+				if ($matchBit != $marker[$markerLength - $j - 1]) {
+					continue 2;
+				}
+			}
+
+			return $fileSize - $i;
+		}
+		throw new InvalidDatabaseException(
+			"Error opening database file ($filename). " .
+			'Is this a valid MaxMind DB file?'
+		);
+	}
+
+	/**
+	 * @throws \InvalidArgumentException if arguments are passed to the method.
+	 * @throws \BadMethodCallException if the database has been closed.
+	 * @return Metadata object for the database.
+	 */
+	public function metadata()
+	{
+		if (func_num_args()) {
+			throw new \InvalidArgumentException(
+				'Method takes no arguments.'
+			);
+		}
+
+		// Not technically required, but this makes it consistent with
+		// C extension and it allows us to change our implementation later.
+		if (!is_resource($this->fileHandle)) {
+			throw new \BadMethodCallException(
+				'Attempt to read from a closed MaxMind DB.'
+			);
+		}
+
+		return $this->metadata;
+	}
+
+	/**
+	 * Closes the MaxMind DB and returns resources to the system.
+	 *
+	 * @throws \Exception
+	 *             if an I/O error occurs.
+	 */
+	public function close()
+	{
+		if (!is_resource($this->fileHandle)) {
+			throw new \BadMethodCallException(
+				'Attempt to close a closed MaxMind DB.'
+			);
+		}
+		fclose($this->fileHandle);
+	}
+}
diff --git a/Model/Geoip/Maxmind/Db/Reader/Decoder.php b/Model/Geoip/Maxmind/Db/Reader/Decoder.php
new file mode 100644
index 0000000..1e8923f
--- /dev/null
+++ b/Model/Geoip/Maxmind/Db/Reader/Decoder.php
@@ -0,0 +1,453 @@
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
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
+
+/**
+ * Class Decoder
+ * @package Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader
+ */
+class Decoder
+{
+
+    /**
+     * @type
+     */
+    private $fileStream;
+
+    /**
+     * @type
+     */
+    private $pointerBase;
+
+    /**
+     * @var \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException
+     */
+    private $invalidDatabaseException;
+
+    /**
+     * @var \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util
+     */
+    private $util;
+
+    // This is only used for unit testing
+    private $pointerTestHack;
+
+    /**
+     * @type
+     */
+    private $switchByteOrder;
+
+    /**
+     * @type array
+     */
+    private $types = array(
+        0  => 'extended',
+        1  => 'pointer',
+        2  => 'utf8_string',
+        3  => 'double',
+        4  => 'bytes',
+        5  => 'uint16',
+        6  => 'uint32',
+        7  => 'map',
+        8  => 'int32',
+        9  => 'uint64',
+        10 => 'uint128',
+        11 => 'array',
+        12 => 'container',
+        13 => 'end_marker',
+        14 => 'boolean',
+        15 => 'float',
+    );
+
+    /**
+     * @param \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException $invalidDatabaseException
+     * @param \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util $until
+     */
+    public function __construct(
+        InvalidDatabaseException $invalidDatabaseException,
+        Util $until
+    )
+    {
+        $this->invalidDatabaseException = $invalidDatabaseException;
+        $this->util                     = $until;
+    }
+
+    /**
+     * @param $fileStream
+     * @param int $pointerBase
+     * @param bool|false $pointerTestHack
+     * @return $this
+     */
+    public function init($fileStream, $pointerBase = 0, $pointerTestHack = false)
+    {
+        $this->fileStream      = $fileStream;
+        $this->pointerBase     = $pointerBase;
+        $this->pointerTestHack = $pointerTestHack;
+        $this->switchByteOrder = $this->isPlatformLittleEndian();
+
+        return $this;
+    }
+
+    /**
+     * @param $offset
+     * @return array
+     */
+    public function decode($offset)
+    {
+        list(, $ctrlByte) = unpack(
+            'C',
+            Util::read($this->fileStream, $offset, 1)
+        );
+        $offset++;
+
+        $type = $this->types[$ctrlByte >> 5];
+
+        // Pointers are a special case, we don't read the next $size bytes, we
+        // use the size to determine the length of the pointer and then follow
+        // it.
+        if ($type == 'pointer') {
+            list($pointer, $offset) = $this->decodePointer($ctrlByte, $offset);
+
+            // for unit testing
+            if ($this->pointerTestHack) {
+                return array($pointer);
+            }
+
+            list($result) = $this->decode($pointer);
+
+            return array($result, $offset);
+        }
+
+        if ($type == 'extended') {
+            list(, $nextByte) = unpack(
+                'C',
+                Util::read($this->fileStream, $offset, 1)
+            );
+
+            $typeNum = $nextByte + 7;
+
+            if ($typeNum < 8) {
+                throw new InvalidDatabaseException(
+                    "Something went horribly wrong in the decoder. An extended type "
+                    . "resolved to a type number < 8 ("
+                    . $this->types[$typeNum]
+                    . ")"
+                );
+            }
+
+            $type = $this->types[$typeNum];
+            $offset++;
+        }
+
+        list($size, $offset) = $this->sizeFromCtrlByte($ctrlByte, $offset);
+
+        return $this->decodeByType($type, $offset, $size);
+    }
+
+    /**
+     * @param $type
+     * @param $offset
+     * @param $size
+     * @return array
+     */
+    private function decodeByType($type, $offset, $size)
+    {
+        switch ($type) {
+            case 'map':
+                return $this->decodeMap($size, $offset);
+            case 'array':
+                return $this->decodeArray($size, $offset);
+            case 'boolean':
+                return array($this->decodeBoolean($size), $offset);
+        }
+
+        $newOffset = $offset + $size;
+        $bytes     = Util::read($this->fileStream, $offset, $size);
+        switch ($type) {
+            case 'utf8_string':
+                return array($this->decodeString($bytes), $newOffset);
+            case 'double':
+                $this->verifySize(8, $size);
+
+                return array($this->decodeDouble($bytes), $newOffset);
+            case 'float':
+                $this->verifySize(4, $size);
+
+                return array($this->decodeFloat($bytes), $newOffset);
+            case 'bytes':
+                return array($bytes, $newOffset);
+            case 'uint16':
+            case 'uint32':
+                return array($this->decodeUint($bytes), $newOffset);
+            case 'int32':
+                return array($this->decodeInt32($bytes), $newOffset);
+            case 'uint64':
+            case 'uint128':
+                return array($this->decodeBigUint($bytes, $size), $newOffset);
+            default:
+                throw new InvalidDatabaseException(
+                    "Unknown or unexpected type: " . $type
+                );
+        }
+    }
+
+    /**
+     * @param $expected
+     * @param $actual
+     */
+    private function verifySize($expected, $actual)
+    {
+        if ($expected != $actual) {
+            throw new InvalidDatabaseException(
+                "The MaxMind DB file's data section contains bad data (unknown data type or corrupt data)"
+            );
+        }
+    }
+
+    /**
+     * @param $size
+     * @param $offset
+     * @return array
+     */
+    private function decodeArray($size, $offset)
+    {
+        $array = array();
+
+        for ($i = 0; $i < $size; $i++) {
+            list($value, $offset) = $this->decode($offset);
+            array_push($array, $value);
+        }
+
+        return array($array, $offset);
+    }
+
+    /**
+     * @param $size
+     * @return bool
+     */
+    private function decodeBoolean($size)
+    {
+        return $size == 0 ? false : true;
+    }
+
+    /**
+     * @param $bits
+     * @return mixed
+     */
+    private function decodeDouble($bits)
+    {
+        // XXX - Assumes IEEE 754 double on platform
+        list(, $double) = unpack('d', $this->maybeSwitchByteOrder($bits));
+
+        return $double;
+    }
+
+    /**
+     * @param $bits
+     * @return mixed
+     */
+    private function decodeFloat($bits)
+    {
+        // XXX - Assumes IEEE 754 floats on platform
+        list(, $float) = unpack('f', $this->maybeSwitchByteOrder($bits));
+
+        return $float;
+    }
+
+    /**
+     * @param $bytes
+     * @return mixed
+     */
+    private function decodeInt32($bytes)
+    {
+        $bytes = $this->zeroPadLeft($bytes, 4);
+        list(, $int) = unpack('l', $this->maybeSwitchByteOrder($bytes));
+
+        return $int;
+    }
+
+    /**
+     * @param $size
+     * @param $offset
+     * @return array
+     */
+    private function decodeMap($size, $offset)
+    {
+
+        $map = array();
+
+        for ($i = 0; $i < $size; $i++) {
+            list($key, $offset) = $this->decode($offset);
+            list($value, $offset) = $this->decode($offset);
+            $map[$key] = $value;
+        }
+
+        return array($map, $offset);
+    }
+
+    private $pointerValueOffset = array(
+        1 => 0,
+        2 => 2048,
+        3 => 526336,
+        4 => 0,
+    );
+
+    /**
+     * @param $ctrlByte
+     * @param $offset
+     * @return array
+     */
+    private function decodePointer($ctrlByte, $offset)
+    {
+        $pointerSize = (($ctrlByte >> 3) & 0x3) + 1;
+
+        $buffer = Util::read($this->fileStream, $offset, $pointerSize);
+        $offset = $offset + $pointerSize;
+
+        $packed = $pointerSize == 4
+            ? $buffer
+            : (pack('C', $ctrlByte & 0x7)) . $buffer;
+
+        $unpacked = $this->decodeUint($packed);
+        $pointer  = $unpacked + $this->pointerBase
+            + $this->pointerValueOffset[$pointerSize];
+
+        return array($pointer, $offset);
+    }
+
+    /**
+     * @param $bytes
+     * @return mixed
+     */
+    private function decodeUint($bytes)
+    {
+        list(, $int) = unpack('N', $this->zeroPadLeft($bytes, 4));
+
+        return $int;
+    }
+
+    /**
+     * @param $bytes
+     * @param $byteLength
+     * @return int|string
+     */
+    private function decodeBigUint($bytes, $byteLength)
+    {
+        $maxUintBytes = log(PHP_INT_MAX, 2) / 8;
+
+        if ($byteLength == 0) {
+            return 0;
+        }
+
+        $numberOfLongs = ceil($byteLength / 4);
+        $paddedLength  = $numberOfLongs * 4;
+        $paddedBytes   = $this->zeroPadLeft($bytes, $paddedLength);
+        $unpacked      = array_merge(unpack("N$numberOfLongs", $paddedBytes));
+
+        $integer = 0;
+
+        // 2^32
+        $twoTo32 = '4294967296';
+
+        foreach ($unpacked as $part) {
+            // We only use gmp or bcmath if the final value is too big
+            if ($byteLength <= $maxUintBytes) {
+                $integer = ($integer << 32) + $part;
+            } elseif (extension_loaded('gmp')) {
+                $integer = gmp_strval(gmp_add(gmp_mul($integer, $twoTo32), $part));
+            } elseif (extension_loaded('bcmath')) {
+                $integer = bcadd(bcmul($integer, $twoTo32), $part);
+            } else {
+                throw new \RuntimeException(
+                    'The gmp or bcmath extension must be installed to read this database.'
+                );
+            }
+        }
+
+        return $integer;
+    }
+
+    /**
+     * @param $bytes
+     * @return mixed
+     */
+    private function decodeString($bytes)
+    {
+        // XXX - NOOP. As far as I know, the end user has to explicitly set the
+        // encoding in PHP. Strings are just bytes.
+        return $bytes;
+    }
+
+    /**
+     * @param $ctrlByte
+     * @param $offset
+     * @return array
+     */
+    private function sizeFromCtrlByte($ctrlByte, $offset)
+    {
+        $size        = $ctrlByte & 0x1f;
+        $bytesToRead = $size < 29 ? 0 : $size - 28;
+        $bytes       = Util::read($this->fileStream, $offset, $bytesToRead);
+        $decoded     = $this->decodeUint($bytes);
+
+        if ($size == 29) {
+            $size = 29 + $decoded;
+        } elseif ($size == 30) {
+            $size = 285 + $decoded;
+        } elseif ($size > 30) {
+            $size = ($decoded & (0x0FFFFFFF >> (32 - (8 * $bytesToRead))))
+                + 65821;
+        }
+
+        return array($size, $offset + $bytesToRead);
+    }
+
+    /**
+     * @param $content
+     * @param $desiredLength
+     * @return string
+     */
+    private function zeroPadLeft($content, $desiredLength)
+    {
+        return str_pad($content, $desiredLength, "\x00", STR_PAD_LEFT);
+    }
+
+    /**
+     * @param $bytes
+     * @return string
+     */
+    private function maybeSwitchByteOrder($bytes)
+    {
+        return $this->switchByteOrder ? strrev($bytes) : $bytes;
+    }
+
+    /**
+     * @return bool
+     */
+    private function isPlatformLittleEndian()
+    {
+        $testint = 0x00FF;
+        $packed  = pack('S', $testint);
+
+        return $testint === current(unpack('v', $packed));
+    }
+}
diff --git a/view/adminhtml/web/css/source/_module.less b/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
similarity index 56%
rename from view/adminhtml/web/css/source/_module.less
rename to Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
index 1a047e0..d40e441 100644
--- a/view/adminhtml/web/css/source/_module.less
+++ b/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
@@ -1,3 +1,4 @@
+<?php
 /**
  * Mageplaza
  *
@@ -14,15 +15,15 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
-.admin__menu #menu-magento-backend-stores .item-osc.parent.level-1 > strong:before {
-  //content: @icon-mageplaza__content;
-  content: '\e900';
-  //font-family: @icons-mageplaza__font-name;
-  font-family: 'Mageplaza Icons';
-  font-size: 1.5rem;
-  margin-right: .8rem;
-}
\ No newline at end of file
+namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
+
+/**
+ * This class should be thrown when unexpected data is found in the database.
+ */
+class InvalidDatabaseException extends \Exception
+{
+}
diff --git a/Model/Geoip/Maxmind/Db/Reader/Metadata.php b/Model/Geoip/Maxmind/Db/Reader/Metadata.php
new file mode 100644
index 0000000..5dad2e2
--- /dev/null
+++ b/Model/Geoip/Maxmind/Db/Reader/Metadata.php
@@ -0,0 +1,96 @@
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
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
+
+/**
+ * This class provides the metadata for the MaxMind DB file.
+ *
+ * @property integer nodeCount This is an unsigned 32-bit integer indicating
+ * the number of nodes in the search tree.
+ *
+ * @property integer recordSize This is an unsigned 16-bit integer. It
+ * indicates the number of bits in a record in the search tree. Note that each
+ * node consists of two records.
+ *
+ * @property integer ipVersion This is an unsigned 16-bit integer which is
+ * always 4 or 6. It indicates whether the database contains IPv4 or IPv6
+ * address data.
+ *
+ * @property string databaseType This is a string that indicates the structure
+ * of each data record associated with an IP address. The actual definition of
+ * these structures is left up to the database creator.
+ *
+ * @property array languages An array of strings, each of which is a language
+ * code. A given record may contain data items that have been localized to
+ * some or all of these languages. This may be undefined.
+ *
+ * @property integer binaryFormatMajorVersion This is an unsigned 16-bit
+ * integer indicating the major version number for the database's binary
+ * format.
+ *
+ * @property integer binaryFormatMinorVersion This is an unsigned 16-bit
+ * integer indicating the minor version number for the database's binary format.
+ *
+ * @property integer buildEpoch This is an unsigned 64-bit integer that
+ * contains the database build timestamp as a Unix epoch value.
+ *
+ * @property array description This key will always point to a map
+ * (associative array). The keys of that map will be language codes, and the
+ * values will be a description in that language as a UTF-8 string. May be
+ * undefined for some databases.
+ */
+class Metadata
+{
+    private $binaryFormatMajorVersion;
+    private $binaryFormatMinorVersion;
+    private $buildEpoch;
+    private $databaseType;
+    private $description;
+    private $ipVersion;
+    private $languages;
+    private $nodeByteSize;
+    private $nodeCount;
+    private $recordSize;
+    private $searchTreeSize;
+
+    public function init($metadata){
+        $this->binaryFormatMajorVersion =
+            $metadata['binary_format_major_version'];
+        $this->binaryFormatMinorVersion =
+            $metadata['binary_format_minor_version'];
+        $this->buildEpoch = $metadata['build_epoch'];
+        $this->databaseType = $metadata['database_type'];
+        $this->languages = $metadata['languages'];
+        $this->description = $metadata['description'];
+        $this->ipVersion = $metadata['ip_version'];
+        $this->nodeCount = $metadata['node_count'];
+        $this->recordSize = $metadata['record_size'];
+        $this->nodeByteSize = $this->recordSize / 4;
+        $this->searchTreeSize = $this->nodeCount * $this->nodeByteSize;
+        return $this;
+    }
+
+    public function __get($var)
+    {
+        return $this->$var;
+    }
+}
diff --git a/Model/Geoip/Maxmind/Db/Reader/Util.php b/Model/Geoip/Maxmind/Db/Reader/Util.php
new file mode 100644
index 0000000..19b62a5
--- /dev/null
+++ b/Model/Geoip/Maxmind/Db/Reader/Util.php
@@ -0,0 +1,56 @@
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
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
+
+/**
+ * Class Util
+ * @package Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader
+ */
+class Util
+{
+    /**
+     * @param $stream
+     * @param $offset
+     * @param $numberOfBytes
+     * @return bool|string
+     * @throws \Exception
+     */
+    public static function read($stream, $offset, $numberOfBytes)
+    {
+        if ($numberOfBytes == 0) {
+            return '';
+        }
+        if (fseek($stream, $offset) == 0) {
+            $value = fread($stream, $numberOfBytes);
+
+            // We check that the number of bytes read is equal to the number
+            // asked for. We use ftell as getting the length of $value is
+            // much slower.
+            if (ftell($stream) - $offset === $numberOfBytes) {
+                return $value;
+            }
+        }
+        throw new \Exception(
+            "The MaxMind DB file contains bad data"
+        );
+    }
+}
diff --git a/Model/Geoip/ProviderInterface.php b/Model/Geoip/ProviderInterface.php
new file mode 100644
index 0000000..12e9968
--- /dev/null
+++ b/Model/Geoip/ProviderInterface.php
@@ -0,0 +1,43 @@
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
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\Osc\Model\Geoip;
+
+/**
+ * Interface ProviderInterface
+ * @package Mageplaza\Osc\Model\Geoip
+ */
+interface ProviderInterface
+{
+    /**
+     * @param ipAddress
+     *            IPv4 or IPv6 address to lookup.
+     * @return Country model for the requested IP address.
+     */
+    public function country($ipAddress);
+
+    /**
+     * @param ipAddress
+     *            IPv4 or IPv6 address to lookup.
+     * @return City model for the requested IP address.
+     */
+    public function city($ipAddress);
+}
diff --git a/Model/GuestCheckoutManagement.php b/Model/GuestCheckoutManagement.php
index aade427..ce99b5e 100644
--- a/Model/GuestCheckoutManagement.php
+++ b/Model/GuestCheckoutManagement.php
@@ -15,17 +15,15 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Model;
 
-use Magento\Customer\Api\AccountManagementInterface;
 use Magento\Quote\Api\CartRepositoryInterface;
-use Magento\Quote\Model\QuoteIdMaskFactory;
-use Mageplaza\Osc\Api\CheckoutManagementInterface;
 use Mageplaza\Osc\Api\GuestCheckoutManagementInterface;
+use Magento\Customer\Api\AccountManagementInterface;
 
 /**
  * Class GuestCheckoutManagement
@@ -34,12 +32,12 @@ use Mageplaza\Osc\Api\GuestCheckoutManagementInterface;
 class GuestCheckoutManagement implements GuestCheckoutManagementInterface
 {
     /**
-     * @var QuoteIdMaskFactory
+     * @var \Magento\Quote\Model\QuoteIdMaskFactory
      */
     protected $quoteIdMaskFactory;
 
     /**
-     * @type CheckoutManagementInterface
+     * @type \Mageplaza\Osc\Api\CheckoutManagementInterface
      */
     protected $checkoutManagement;
 
@@ -55,19 +53,19 @@ class GuestCheckoutManagement implements GuestCheckoutManagementInterface
 
     /**
      * GuestCheckoutManagement constructor.
-     * @param QuoteIdMaskFactory $quoteIdMaskFactory
-     * @param CheckoutManagementInterface $checkoutManagement
+     * @param \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory
+     * @param \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
      * @param CartRepositoryInterface $cartRepository
      * @param AccountManagementInterface $accountManagement
      */
     public function __construct(
-        QuoteIdMaskFactory $quoteIdMaskFactory,
-        CheckoutManagementInterface $checkoutManagement,
+        \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory,
+        \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement,
         CartRepositoryInterface $cartRepository,
         AccountManagementInterface $accountManagement
-    )
-    {
-        $this->quoteIdMaskFactory = $quoteIdMaskFactory;
+    ) {
+
+        $this->quoteIdMaskFactory   = $quoteIdMaskFactory;
         $this->checkoutManagement = $checkoutManagement;
         $this->cartRepository = $cartRepository;
         $this->accountManagement = $accountManagement;
diff --git a/Model/OscDetails.php b/Model/OscDetails.php
index 4becddb..d15a412 100644
--- a/Model/OscDetails.php
+++ b/Model/OscDetails.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Authorization/UserContext.php b/Model/Plugin/Authorization/UserContext.php
index 2d53a2c..003d860 100644
--- a/Model/Plugin/Authorization/UserContext.php
+++ b/Model/Plugin/Authorization/UserContext.php
@@ -15,43 +15,36 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Model\Plugin\Authorization;
 
 use Magento\Authorization\Model\UserContextInterface;
-use Magento\Checkout\Model\Session;
-use Mageplaza\Osc\Helper\Data as OscHelper;
 
-/**
- * Class UserContext
- * @package Mageplaza\Osc\Model\Plugin\Authorization
- */
 class UserContext
 {
     /**
-     * @var OscHelper
+     * @var \Mageplaza\Osc\Helper\Data
      */
-    protected $_oscHelper;
+    protected $_oscHelperData;
 
     /**
-     * @var Session
+     * @var \Magento\Checkout\Model\Session
      */
     protected $_checkoutSession;
 
     /**
      * UserContext constructor.
-     * @param OscHelper $oscHelper
-     * @param Session $checkoutSession
+     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
+     * @param \Magento\Checkout\Model\Session $checkoutSession
      */
     public function __construct(
-        OscHelper $oscHelper,
-        Session $checkoutSession
-    )
-    {
-        $this->_oscHelper = $oscHelper;
+        \Mageplaza\Osc\Helper\Data $oscHelperData,
+        \Magento\Checkout\Model\Session $checkoutSession
+    ) {
+        $this->_oscHelperData = $oscHelperData;
         $this->_checkoutSession = $checkoutSession;
     }
 
@@ -62,7 +55,7 @@ class UserContext
      */
     public function afterGetUserType(UserContextInterface $userContext, $result)
     {
-        if ($this->_oscHelper->isFlagOscMethodRegister()) {
+        if($this->_oscHelperData->isFlagOscMethodRegister()) {
             return UserContextInterface::USER_TYPE_CUSTOMER;
         }
 
@@ -76,7 +69,7 @@ class UserContext
      */
     public function afterGetUserId(UserContextInterface $userContext, $result)
     {
-        if ($this->_oscHelper->isFlagOscMethodRegister()) {
+        if($this->_oscHelperData->isFlagOscMethodRegister()) {
             return $this->_checkoutSession->getQuote()->getCustomerId();
         }
 
diff --git a/Model/Plugin/Checkout/ShippingMethodManagement.php b/Model/Plugin/Checkout/ShippingMethodManagement.php
index fd778df..1f20250 100644
--- a/Model/Plugin/Checkout/ShippingMethodManagement.php
+++ b/Model/Plugin/Checkout/ShippingMethodManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -55,7 +55,7 @@ class ShippingMethodManagement
         AddressRepositoryInterface $addressRepository
     )
     {
-        $this->quoteRepository = $quoteRepository;
+        $this->quoteRepository   = $quoteRepository;
         $this->addressRepository = $addressRepository;
     }
 
@@ -64,8 +64,7 @@ class ShippingMethodManagement
      * @param \Closure $proceed
      * @param $cartId
      * @param EstimateAddressInterface $address
-     * @return mixed
-     * @throws \Magento\Framework\Exception\NoSuchEntityException
+     * @return array
      */
     public function aroundEstimateByAddress(
         \Magento\Quote\Model\ShippingMethodManagement $subject,
@@ -83,9 +82,8 @@ class ShippingMethodManagement
      * @param \Magento\Quote\Model\ShippingMethodManagement $subject
      * @param \Closure $proceed
      * @param $cartId
-     * @param AddressInterface $address
+     * @param \Magento\Quote\Api\Data\AddressInterface $address
      * @return mixed
-     * @throws \Magento\Framework\Exception\NoSuchEntityException
      */
     public function aroundEstimateByExtendedAddress(
         \Magento\Quote\Model\ShippingMethodManagement $subject,
@@ -105,7 +103,6 @@ class ShippingMethodManagement
      * @param $cartId
      * @param $addressId
      * @return mixed
-     * @throws \Magento\Framework\Exception\LocalizedException
      */
     public function aroundEstimateByAddressId(
         \Magento\Quote\Model\ShippingMethodManagement $subject,
@@ -124,7 +121,6 @@ class ShippingMethodManagement
      * @param $cartId
      * @param $address
      * @return $this
-     * @throws \Magento\Framework\Exception\NoSuchEntityException
      */
     private function saveAddress($cartId, $address)
     {
@@ -134,9 +130,9 @@ class ShippingMethodManagement
         if (!$quote->isVirtual()) {
             $addressData = [
                 EstimateAddressInterface::KEY_COUNTRY_ID => $address->getCountryId(),
-                EstimateAddressInterface::KEY_POSTCODE => $address->getPostcode(),
-                EstimateAddressInterface::KEY_REGION_ID => $address->getRegionId(),
-                EstimateAddressInterface::KEY_REGION => $address->getRegion()
+                EstimateAddressInterface::KEY_POSTCODE   => $address->getPostcode(),
+                EstimateAddressInterface::KEY_REGION_ID  => $address->getRegionId(),
+                EstimateAddressInterface::KEY_REGION     => $address->getRegion()
             ];
 
             $shippingAddress = $quote->getShippingAddress();
diff --git a/Model/Plugin/Customer/Address.php b/Model/Plugin/Customer/Address.php
index 5f632ef..368598d 100644
--- a/Model/Plugin/Customer/Address.php
+++ b/Model/Plugin/Customer/Address.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Eav/Model/Validator/Attribute/Data.php b/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
index a637712..73720bc 100644
--- a/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
+++ b/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
@@ -15,34 +15,27 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Model\Plugin\Eav\Model\Validator\Attribute;
 
-use Magento\Eav\Model\AttributeDataFactory;
-use Mageplaza\Osc\Helper\Data as HelperData;
-
-/**
- * Class Data
- * @package Mageplaza\Osc\Model\Plugin\Eav\Model\Validator\Attribute
- */
 class Data extends \Magento\Eav\Model\Validator\Attribute\Data
 {
     /**
-     * @var HelperData
+     * @var \Mageplaza\Osc\Helper\Data
      */
     protected $_oscHelperData;
 
     /**
      * Data constructor.
-     * @param AttributeDataFactory $attrDataFactory
-     * @param HelperData $oscHelperData
+     * @param \Magento\Eav\Model\AttributeDataFactory $attrDataFactory
+     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
      */
     public function __construct(
-        AttributeDataFactory $attrDataFactory,
-        HelperData $oscHelperData
+        \Magento\Eav\Model\AttributeDataFactory $attrDataFactory,
+        \Mageplaza\Osc\Helper\Data $oscHelperData
     )
     {
         parent::__construct($attrDataFactory);
diff --git a/Model/Plugin/Paypal/Model/Express.php b/Model/Plugin/Paypal/Model/Express.php
index 3e5930e..8f80ca7 100644
--- a/Model/Plugin/Paypal/Model/Express.php
+++ b/Model/Plugin/Paypal/Model/Express.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Quote/GiftWrap.php b/Model/Plugin/Quote/GiftWrap.php
index 10fbeef..3561074 100644
--- a/Model/Plugin/Quote/GiftWrap.php
+++ b/Model/Plugin/Quote/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -39,7 +39,9 @@ class GiftWrap
     /**
      * @param \Magento\Quote\Api\Data\TotalSegmentExtensionFactory $totalSegmentExtensionFactory
      */
-    public function __construct(TotalSegmentExtensionFactory $totalSegmentExtensionFactory)
+    public function __construct(
+        TotalSegmentExtensionFactory $totalSegmentExtensionFactory
+    )
     {
         $this->totalSegmentExtensionFactory = $totalSegmentExtensionFactory;
     }
diff --git a/Model/Plugin/Quote/QuoteManagement.php b/Model/Plugin/Quote/QuoteManagement.php
index bd67556..5f68b46 100644
--- a/Model/Plugin/Quote/QuoteManagement.php
+++ b/Model/Plugin/Quote/QuoteManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -23,10 +23,6 @@ namespace Mageplaza\Osc\Model\Plugin\Quote;
 
 use Magento\Quote\Model\Quote as QuoteEntity;
 
-/**
- * Class QuoteManagement
- * @package Mageplaza\Osc\Model\Plugin\Quote
- */
 class QuoteManagement
 {
     /**
@@ -34,10 +30,6 @@ class QuoteManagement
      */
     protected $checkoutRegister;
 
-    /**
-     * QuoteManagement constructor.
-     * @param \Mageplaza\Osc\Model\CheckoutRegister $checkoutRegister
-     */
     public function __construct(\Mageplaza\Osc\Model\CheckoutRegister $checkoutRegister)
     {
         $this->checkoutRegister = $checkoutRegister;
diff --git a/Model/System/Config/Source/AddressSuggest.php b/Model/System/Config/Source/AddressSuggest.php
index 726cefe..5263421 100644
--- a/Model/System/Config/Source/AddressSuggest.php
+++ b/Model/System/Config/Source/AddressSuggest.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
@@ -33,7 +31,7 @@ class AddressSuggest
     public function getTriggerOption()
     {
         return [
-            '' => __('No'),
+            ''       => __('No'),
             'google' => __('Google'),
 //			'pca'    => __('Capture+ by PCA Predict'),
         ];
diff --git a/Model/System/Config/Source/CheckboxStyle.php b/Model/System/Config/Source/CheckboxStyle.php
index 77846a2..a4eb1aa 100644
--- a/Model/System/Config/Source/CheckboxStyle.php
+++ b/Model/System/Config/Source/CheckboxStyle.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
diff --git a/Model/System/Config/Source/ComponentPosition.php b/Model/System/Config/Source/ComponentPosition.php
index e0d5a29..ad8952e 100644
--- a/Model/System/Config/Source/ComponentPosition.php
+++ b/Model/System/Config/Source/ComponentPosition.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
@@ -39,9 +37,9 @@ class ComponentPosition extends AbstractModel
     public function toOptionArray()
     {
         return [
-            self::NOT_SHOW => __('No'),
+            self::NOT_SHOW        => __('No'),
             self::SHOW_IN_PAYMENT => __('In Payment Area'),
-            self::SHOW_IN_REVIEW => __('In Review Area')
+            self::SHOW_IN_REVIEW  => __('In Review Area')
         ];
     }
 }
\ No newline at end of file
diff --git a/Model/System/Config/Source/DeliveryTime.php b/Model/System/Config/Source/DeliveryTime.php
index a175f1a..441a5b1 100644
--- a/Model/System/Config/Source/DeliveryTime.php
+++ b/Model/System/Config/Source/DeliveryTime.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
diff --git a/Model/System/Config/Source/Design.php b/Model/System/Config/Source/Design.php
index df366a2..4a6c26a 100644
--- a/Model/System/Config/Source/Design.php
+++ b/Model/System/Config/Source/Design.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
diff --git a/Model/System/Config/Source/Giftwrap.php b/Model/System/Config/Source/Giftwrap.php
index 4d9d77d..6cfd732 100644
--- a/Model/System/Config/Source/Giftwrap.php
+++ b/Model/System/Config/Source/Giftwrap.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
@@ -39,7 +37,7 @@ class Giftwrap extends AbstractModel
     {
         return [
             self::PER_ORDER => __('Per Order'),
-            self::PER_ITEM => __('Per Item')
+            self::PER_ITEM  => __('Per Item')
         ];
     }
 }
\ No newline at end of file
diff --git a/Model/System/Config/Source/Layout.php b/Model/System/Config/Source/Layout.php
index 9b39843..75df87f 100644
--- a/Model/System/Config/Source/Layout.php
+++ b/Model/System/Config/Source/Layout.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
diff --git a/Model/System/Config/Source/PaymentMethods.php b/Model/System/Config/Source/PaymentMethods.php
index b855dca..358d00a 100644
--- a/Model/System/Config/Source/PaymentMethods.php
+++ b/Model/System/Config/Source/PaymentMethods.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -25,11 +25,11 @@ use Magento\Framework\App\Config\ScopeConfigInterface;
 use Magento\Framework\Option\ArrayInterface;
 use Magento\Payment\Model\Method\Factory;
 use Magento\Store\Model\ScopeInterface;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as OscConfig;
 
 /**
- * Class PaymentMethods
- * @package Mageplaza\Osc\Model\System\Config\Source
+ * Class Methods
+ * @package Mageplaza\Osc\Model\System\Config\Source\Payment
  */
 class PaymentMethods implements ArrayInterface
 {
@@ -44,25 +44,24 @@ class PaymentMethods implements ArrayInterface
     protected $_paymentMethodFactory;
 
     /**
-     * @var OscHelper
+     * @type \Mageplaza\Osc\Helper\Config
      */
-    protected $_oscHelper;
+    protected $_oscConfig;
 
     /**
-     * PaymentMethods constructor.
-     * @param ScopeConfigInterface $scopeConfig
-     * @param Factory $paymentMethodFactory
-     * @param OscHelper $oscHelper
+     * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
+     * @param \Magento\Payment\Model\Method\Factory $paymentMethodFactory
+     * @param \Mageplaza\Osc\Helper\Config $oscConfig
      */
     public function __construct(
         ScopeConfigInterface $scopeConfig,
         Factory $paymentMethodFactory,
-        OscHelper $oscHelper
+        OscConfig $oscConfig
     )
     {
-        $this->_scopeConfig = $scopeConfig;
+        $this->_scopeConfig          = $scopeConfig;
         $this->_paymentMethodFactory = $paymentMethodFactory;
-        $this->_oscHelper = $oscHelper;
+        $this->_oscConfig            = $oscConfig;
     }
 
     /**
@@ -90,20 +89,16 @@ class PaymentMethods implements ArrayInterface
      */
     public function getActiveMethods()
     {
-        $methods = [];
+        $methods       = [];
         $paymentConfig = $this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null);
-        if ($this->_oscHelper->isEnabledMultiSafepay()) {
-            $paymentConfig = array_merge(
-                $this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null),
-                $this->_scopeConfig->getValue('gateways', ScopeInterface::SCOPE_STORE, null)
-            );
+        if ($this->_oscConfig->isEnabledMultiSafepay()) {
+            $paymentConfig = array_merge($this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null), $this->_scopeConfig->getValue('gateways', ScopeInterface::SCOPE_STORE, null));
         }
-
         foreach ($paymentConfig as $code => $data) {
             if (isset($data['active'], $data['model']) && (bool)$data['active']) {
                 try {
-                    $methodModel = $this->_paymentMethodFactory->create($data['model']);
-                    if (is_object($methodModel)) {
+                    if (class_exists($data['model'])) {
+                        $methodModel = $this->_paymentMethodFactory->create($data['model']);
                         $methodModel->setStore(null);
                         if ($methodModel->getConfigData('active', null)) {
                             $methods[$code] = $methodModel;
diff --git a/Model/System/Config/Source/RadioStyle.php b/Model/System/Config/Source/RadioStyle.php
index 7a14e23..7435e22 100644
--- a/Model/System/Config/Source/RadioStyle.php
+++ b/Model/System/Config/Source/RadioStyle.php
@@ -13,10 +13,8 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
diff --git a/Model/System/Config/Source/ShippingMethods.php b/Model/System/Config/Source/ShippingMethods.php
index d562d69..51f31b2 100644
--- a/Model/System/Config/Source/ShippingMethods.php
+++ b/Model/System/Config/Source/ShippingMethods.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -51,7 +51,7 @@ class ShippingMethods
         array $data = []
     )
     {
-        $this->_scopeConfig = $scopeConfig;
+        $this->_scopeConfig   = $scopeConfig;
         $this->_carrierConfig = $carrierConfig;
     }
 
@@ -66,7 +66,7 @@ class ShippingMethods
                 'value' => '',
             ],
         ];
-        $carrierMethodsList = $this->_carrierConfig->getActiveCarriers();
+        $carrierMethodsList         = $this->_carrierConfig->getActiveCarriers();
         ksort($carrierMethodsList);
         foreach ($carrierMethodsList as $carrierMethodCode => $carrierModel) {
             foreach ($carrierModel->getAllowedMethods() as $shippingMethodCode => $shippingMethodTitle) {
diff --git a/Model/System/Config/Source/Survey.php b/Model/System/Config/Source/Survey.php
index b6606b6..5647cb3 100644
--- a/Model/System/Config/Source/Survey.php
+++ b/Model/System/Config/Source/Survey.php
@@ -15,15 +15,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
-use Magento\Backend\Block\Template\Context;
 use Magento\Config\Block\System\Config\Form\Field\FieldArray\AbstractFieldArray;
-use Magento\Framework\Data\Form\Element\Factory;
 
 /**
  * Class Survey
@@ -32,18 +30,18 @@ use Magento\Framework\Data\Form\Element\Factory;
 class Survey extends AbstractFieldArray
 {
     /**
-     * @var Factory
+     * @var \Magento\Framework\Data\Form\Element\Factory
      */
     protected $_elementFactory;
 
     /**
-     * @param Context $context
-     * @param Factory $elementFactory
+     * @param \Magento\Backend\Block\Template\Context $context
+     * @param \Magento\Framework\Data\Form\Element\Factory $elementFactory
      * @param array $data
      */
     public function __construct(
-        Context $context,
-        Factory $elementFactory,
+        \Magento\Backend\Block\Template\Context $context,
+        \Magento\Framework\Data\Form\Element\Factory $elementFactory,
         array $data = []
     )
     {
@@ -57,7 +55,7 @@ class Survey extends AbstractFieldArray
     protected function _construct()
     {
         $this->addColumn('value', ['label' => __('Options')]);
-        $this->_addAfter = false;
+        $this->_addAfter       = false;
         $this->_addButtonLabel = __('Add');
         parent::_construct();
     }
diff --git a/Model/Total/Creditmemo/GiftWrap.php b/Model/Total/Creditmemo/GiftWrap.php
index ed68d57..af17934 100644
--- a/Model/Total/Creditmemo/GiftWrap.php
+++ b/Model/Total/Creditmemo/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -31,8 +31,8 @@ use Magento\Sales\Model\Order\Creditmemo\Total\AbstractTotal;
 class GiftWrap extends AbstractTotal
 {
     /**
-     * @param Creditmemo $creditmemo
-     * @return $this
+     * @param \Magento\Sales\Model\Order\Creditmemo $creditmemo
+     * @return $this|void
      */
     public function collect(Creditmemo $creditmemo)
     {
@@ -40,8 +40,7 @@ class GiftWrap extends AbstractTotal
         if ($order->getOscGiftWrapAmount() < 0.0001) {
             return $this;
         }
-
-        $totalGiftWrapAmount = 0;
+        $totalGiftWrapAmount     = 0;
         $totalBaseGiftWrapAmount = 0;
         if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
             foreach ($creditmemo->getAllItems() as $item) {
@@ -52,10 +51,10 @@ class GiftWrap extends AbstractTotal
                 $rate = $item->getQty() / $orderItem->getQtyOrdered();
 
                 $totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
-                $totalGiftWrapAmount += $orderItem->getOscGiftWrapAmount() * $rate;
+                $totalGiftWrapAmount     += $orderItem->getOscGiftWrapAmount() * $rate;
             }
         } else if ($this->isLast($creditmemo)) {
-            $totalGiftWrapAmount = $order->getOscGiftWrapAmount();
+            $totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
             $totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
         }
 
diff --git a/Model/Total/Invoice/GiftWrap.php b/Model/Total/Invoice/GiftWrap.php
index b1394df..e667131 100644
--- a/Model/Total/Invoice/GiftWrap.php
+++ b/Model/Total/Invoice/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -40,8 +40,7 @@ class GiftWrap extends AbstractTotal
         if ($order->getOscGiftWrapAmount() < 0.0001) {
             return $this;
         }
-
-        $totalGiftWrapAmount = 0;
+        $totalGiftWrapAmount     = 0;
         $totalBaseGiftWrapAmount = 0;
 
         if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
@@ -53,12 +52,12 @@ class GiftWrap extends AbstractTotal
                 $rate = $item->getQty() / $orderItem->getQtyOrdered();
 
                 $totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
-                $totalGiftWrapAmount += $orderItem->getOscGiftWrapAmount() * $rate;
+                $totalGiftWrapAmount     += $orderItem->getOscGiftWrapAmount() * $rate;
             }
         } else {
             $invoiceCollections = $order->getInvoiceCollection();
             if ($invoiceCollections->getSize() == 0) {
-                $totalGiftWrapAmount = $order->getOscGiftWrapAmount();
+                $totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
                 $totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
             }
         }
@@ -70,4 +69,5 @@ class GiftWrap extends AbstractTotal
 
         return $this;
     }
+
 }
diff --git a/Model/Total/Quote/GiftWrap.php b/Model/Total/Quote/GiftWrap.php
index 54e9946..6cfa1d5 100644
--- a/Model/Total/Quote/GiftWrap.php
+++ b/Model/Total/Quote/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -28,7 +28,7 @@ use Magento\Quote\Model\Quote;
 use Magento\Quote\Model\Quote\Address;
 use Magento\Quote\Model\Quote\Address\Total;
 use Magento\Quote\Model\Quote\Address\Total\AbstractTotal;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as HelperConfig;
 use Mageplaza\Osc\Model\System\Config\Source\Giftwrap as SourceGiftwrap;
 
 /**
@@ -38,9 +38,9 @@ use Mageplaza\Osc\Model\System\Config\Source\Giftwrap as SourceGiftwrap;
 class GiftWrap extends AbstractTotal
 {
     /**
-     * @var OscHelper
+     * @type \Mageplaza\Osc\Helper\Config
      */
-    protected $_oscHelper;
+    protected $_helperConfig;
 
     /**
      * @type \Magento\Checkout\Model\Session
@@ -58,24 +58,24 @@ class GiftWrap extends AbstractTotal
     protected $_baseGiftWrapAmount;
 
     /**
-     * GiftWrap constructor.
-     * @param Session $checkoutSession
-     * @param OscHelper $oscHelper
-     * @param PriceCurrencyInterface $priceCurrency
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Mageplaza\Osc\Helper\Config $helperConfig
+     * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
      */
     public function __construct(
         Session $checkoutSession,
-        OscHelper $oscHelper,
+        HelperConfig $helperConfig,
         PriceCurrencyInterface $priceCurrency
     )
     {
         $this->_checkoutSession = $checkoutSession;
-        $this->_oscHelper = $oscHelper;
-        $this->priceCurrency = $priceCurrency;
+        $this->_helperConfig    = $helperConfig;
+        $this->priceCurrency    = $priceCurrency;
 
         $this->setCode('osc_gift_wrap');
     }
 
+
     /**
      * Collect gift wrap totals
      *
@@ -92,7 +92,7 @@ class GiftWrap extends AbstractTotal
     {
         parent::collect($quote, $shippingAssignment, $total);
 
-        if ($this->_oscHelper->isDisabledGiftWrap() ||
+        if ($this->_helperConfig->isDisabledGiftWrap() ||
             ($shippingAssignment->getShipping()->getAddress()->getAddressType() !== Address::TYPE_SHIPPING) ||
             !$quote->getShippingAddress()->getUsedGiftWrap()
         ) {
@@ -100,7 +100,7 @@ class GiftWrap extends AbstractTotal
         }
 
         $baseOscGiftWrapAmount = $this->calculateGiftWrapAmount($quote);
-        $oscGiftWrapAmount = $this->priceCurrency->convert($baseOscGiftWrapAmount, $quote->getStore());
+        $oscGiftWrapAmount     = $this->priceCurrency->convert($baseOscGiftWrapAmount, $quote->getStore());
 
         $this->_addAmount($oscGiftWrapAmount);
         $this->_addBaseAmount($baseOscGiftWrapAmount);
@@ -120,12 +120,12 @@ class GiftWrap extends AbstractTotal
         $amount = $total->getOscGiftWrapAmount();
 
         $baseInitAmount = $this->calculateGiftWrapAmount($quote);
-        $initAmount = $this->priceCurrency->convert($baseInitAmount, $quote->getStore());
+        $initAmount     = $this->priceCurrency->convert($baseInitAmount, $quote->getStore());
 
         return [
-            'code' => $this->getCode(),
-            'title' => __('Gift Wrap'),
-            'value' => $amount,
+            'code'             => $this->getCode(),
+            'title'            => __('Gift Wrap'),
+            'value'            => $amount,
             'gift_wrap_amount' => $initAmount
         ];
     }
@@ -137,14 +137,14 @@ class GiftWrap extends AbstractTotal
     public function calculateGiftWrapAmount($quote)
     {
         if ($this->_baseGiftWrapAmount == null) {
-            $baseOscGiftWrapAmount = $this->_oscHelper->getOrderGiftwrapAmount();
+            $baseOscGiftWrapAmount = $this->_helperConfig->getOrderGiftwrapAmount();
             if ($baseOscGiftWrapAmount == 0) {
                 return 0;
             }
 
-            $giftWrapType = $this->_oscHelper->getGiftWrapType();
+            $giftWrapType = $this->_helperConfig->getGiftWrapType();
             if ($giftWrapType == SourceGiftwrap::PER_ITEM) {
-                $giftWrapBaseAmount = $baseOscGiftWrapAmount;
+                $giftWrapBaseAmount    = $baseOscGiftWrapAmount;
                 $baseOscGiftWrapAmount = 0;
                 foreach ($quote->getAllVisibleItems() as $item) {
                     if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
diff --git a/Observer/IsAllowedGuestCheckoutObserver.php b/Observer/IsAllowedGuestCheckoutObserver.php
index 4de52d5..6c85412 100644
--- a/Observer/IsAllowedGuestCheckoutObserver.php
+++ b/Observer/IsAllowedGuestCheckoutObserver.php
@@ -15,15 +15,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Observer;
 
-use Magento\Framework\App\Config\ScopeConfigInterface;
 use Magento\Framework\Event\ObserverInterface;
-use Mageplaza\Osc\Helper\Data;
 
 /**
  * Class CheckoutSubmitBefore
@@ -32,18 +30,18 @@ use Mageplaza\Osc\Helper\Data;
 class IsAllowedGuestCheckoutObserver extends \Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver implements ObserverInterface
 {
     /**
-     * @var Data
+     * @var \Mageplaza\Osc\Helper\Data
      */
     protected $_helper;
 
     /**
      * IsAllowedGuestCheckoutObserver constructor.
-     * @param ScopeConfigInterface $scopeConfig
-     * @param Data $helper
+     * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
+     * @param \Mageplaza\Osc\Helper\Data $helper
      */
     public function __construct(
-        ScopeConfigInterface $scopeConfig,
-        Data $helper
+        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
+        \Mageplaza\Osc\Helper\Data $helper
     )
     {
         $this->_helper = $helper;
@@ -52,7 +50,8 @@ class IsAllowedGuestCheckoutObserver extends \Magento\Downloadable\Observer\IsAl
     }
 
     /**
-     * @inheritdoc
+     * @param \Magento\Framework\Event\Observer $observer
+     * @return $this
      */
     public function execute(\Magento\Framework\Event\Observer $observer)
     {
diff --git a/Observer/OscConfigObserver.php b/Observer/OscConfigObserver.php
index baaae66..cbd85c4 100644
--- a/Observer/OscConfigObserver.php
+++ b/Observer/OscConfigObserver.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -27,7 +27,8 @@ use Magento\Framework\Event\Observer;
 use Magento\Framework\Event\ObserverInterface;
 use Magento\Framework\Message\ManagerInterface as MessageManager;
 use Magento\GiftMessage\Helper\Message;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as HelperConfig;
+use Mageplaza\Osc\Helper\Data as HelperData;
 
 /**
  * Class OscConfigObserver
@@ -41,6 +42,11 @@ class OscConfigObserver implements ObserverInterface
     protected $_storeManager;
 
     /**
+     * @var HelperConfig
+     */
+    protected $_helperConfig;
+
+    /**
      * @var ModelConfig
      */
     protected $_modelConfig;
@@ -51,25 +57,28 @@ class OscConfigObserver implements ObserverInterface
     protected $_messageManager;
 
     /**
-     * @var OscHelper
+     * @var HelperData
      */
-    protected $_oscHelper;
+    protected $_helperData;
+
 
     /**
-     * OscConfigObserver constructor.
+     * @param HelperConfig $helperConfig
      * @param ModelConfig $modelConfig
      * @param MessageManager $messageManager
-     * @param OscHelper $oscHelper
+     * @param HelperData $HelperData
      */
     public function __construct(
+        HelperConfig $helperConfig,
         ModelConfig $modelConfig,
         MessageManager $messageManager,
-        OscHelper $oscHelper
+        HelperData $HelperData
     )
     {
-        $this->_modelConfig = $modelConfig;
+        $this->_helperConfig   = $helperConfig;
+        $this->_modelConfig    = $modelConfig;
         $this->_messageManager = $messageManager;
-        $this->_oscHelper = $oscHelper;
+        $this->_helperData     = $HelperData;
     }
 
     /**
@@ -77,10 +86,11 @@ class OscConfigObserver implements ObserverInterface
      */
     public function execute(Observer $observer)
     {
-        $scopeId = 0;
-        $isGiftMessage = !$this->_oscHelper->isDisabledGiftMessage();
-        $isGiftMessageItems = $this->_oscHelper->isEnableGiftMessageItems();
-        $isEnableTOC = ($this->_oscHelper->disabledPaymentTOC() || $this->_oscHelper->disabledReviewTOC());
+        $scopeId            = 0;
+        $isGiftMessage      = !$this->_helperConfig->isDisabledGiftMessage();
+        $isGiftMessageItems = $this->_helperConfig->isEnableGiftMessageItems();
+        $isEnableTOC        = ($this->_helperConfig->disabledPaymentTOC() || $this->_helperConfig->disabledReviewTOC());
+        $isEnableGeoIP      = $this->_helperConfig->isEnableGeoIP();
         $this->_modelConfig
             ->saveConfig(
                 Message::XPATH_CONFIG_GIFT_MESSAGE_ALLOW_ORDER,
@@ -100,16 +110,17 @@ class OscConfigObserver implements ObserverInterface
                 ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
                 $scopeId
             );
-
-        $isEnableGeoIP = $this->_oscHelper->isEnableGeoIP();
-        if ($isEnableGeoIP && !$this->_oscHelper->getAddressHelper()->checkHasLibrary()) {
-            $this->_modelConfig->saveConfig(
-                OscHelper::GEO_IP_IS_ENABLED,
-                false,
-                ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
-                $scopeId
-            );
-            $this->_messageManager->addNoticeMessage(__("Notice: Please download GeoIp library before enable."));
+        if ($isEnableGeoIP) {
+            if (!$this->_helperData->checkHasLibrary()) {
+                $this->_modelConfig->saveConfig(
+                    HelperConfig::GEO_IP_IS_ENABLED,
+                    false,
+                    ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
+                    $scopeId
+                );
+                $this->_messageManager->addNotice(__("Notice: Please download GeoIp library before enable."));
+            }
         }
+
     }
 }
diff --git a/Observer/PaypalExpressPlaceOrder.php b/Observer/PaypalExpressPlaceOrder.php
index be83cb5..c5fb04c 100644
--- a/Observer/PaypalExpressPlaceOrder.php
+++ b/Observer/PaypalExpressPlaceOrder.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index 18ac0fa..d0c828f 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -40,7 +40,9 @@ class QuoteSubmitBefore implements ObserverInterface
      * @param \Magento\Checkout\Model\Session $checkoutSession
      * @codeCoverageIgnore
      */
-    public function __construct(Session $checkoutSession)
+    public function __construct(
+        Session $checkoutSession
+    )
     {
         $this->checkoutSession = $checkoutSession;
     }
diff --git a/Observer/QuoteSubmitSuccess.php b/Observer/QuoteSubmitSuccess.php
index 82b7ad5..04f5be1 100644
--- a/Observer/QuoteSubmitSuccess.php
+++ b/Observer/QuoteSubmitSuccess.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -87,17 +87,18 @@ class QuoteSubmitSuccess implements ObserverInterface
         SubscriberFactory $subscriberFactory
     )
     {
-        $this->checkoutSession = $checkoutSession;
+        $this->checkoutSession   = $checkoutSession;
         $this->accountManagement = $accountManagement;
-        $this->_customerUrl = $customerUrl;
-        $this->messageManager = $messageManager;
-        $this->_customerSession = $customerSession;
+        $this->_customerUrl      = $customerUrl;
+        $this->messageManager    = $messageManager;
+        $this->_customerSession  = $customerSession;
         $this->subscriberFactory = $subscriberFactory;
     }
 
     /**
-     * @param Observer $observer
-     * @throws \Magento\Framework\Exception\LocalizedException
+     * @param \Magento\Framework\Event\Observer $observer
+     * @return void
+     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
      */
     public function execute(Observer $observer)
     {
@@ -113,6 +114,7 @@ class QuoteSubmitSuccess implements ObserverInterface
             /* Set customer Id for address */
             if ($customer->getId()) {
                 $quote->getBillingAddress()->setCustomerId($customer->getId());
+
                 if ($shippingAddress = $quote->getShippingAddress()) {
                     $shippingAddress->setCustomerId($customer->getId());
                 }
@@ -132,6 +134,12 @@ class QuoteSubmitSuccess implements ObserverInterface
                 );
             } else {
                 $this->_customerSession->loginById($customer->getId());
+//                $this->_customerSession->regenerateId();
+//                if ($this->getCookieManager()->getCookie('mage-cache-sessid')) {
+//                    $metadata = $this->getCookieMetadataFactory()->createCookieMetadata();
+//                    $metadata->setPath('/');
+//                    $this->getCookieManager()->deleteCookie('mage-cache-sessid', $metadata);
+//                }
             }
         }
 
@@ -139,7 +147,7 @@ class QuoteSubmitSuccess implements ObserverInterface
             if (!$this->_customerSession->isLoggedIn()) {
                 $subscribedEmail = $quote->getBillingAddress()->getEmail();
             } else {
-                $customer = $this->_customerSession->getCustomer();
+                $customer        = $this->_customerSession->getCustomer();
                 $subscribedEmail = $customer->getEmail();
             }
 
diff --git a/Observer/RedirectToOneStepCheckout.php b/Observer/RedirectToOneStepCheckout.php
index f514f04..8902661 100644
--- a/Observer/RedirectToOneStepCheckout.php
+++ b/Observer/RedirectToOneStepCheckout.php
@@ -15,16 +15,17 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Observer;
 
+use Magento\Checkout\Model\Session as CheckoutSession;
 use Magento\Framework\Event\Observer;
 use Magento\Framework\Event\ObserverInterface;
 use Magento\Framework\UrlInterface;
-use Mageplaza\Osc\Helper\Data as OscHelper;
+use Mageplaza\Osc\Helper\Config as HelperConfig;
 
 /**
  * Class RedirectToOneStepCheckout
@@ -32,28 +33,24 @@ use Mageplaza\Osc\Helper\Data as OscHelper;
  */
 class RedirectToOneStepCheckout implements ObserverInterface
 {
-    /**
-     * @var UrlInterface
-     */
+    /** @var UrlInterface */
     protected $_url;
 
-    /**
-     * @var OscHelper
-     */
-    protected $_oscHelper;
+    /** @var HelperConfig */
+    protected $_helperConfig;
 
     /**
      * RedirectToOneStepCheckout constructor.
-     * @param UrlInterface $url
-     * @param OscHelper $oscHelper
+     * @param \Magento\Framework\UrlInterface $url
+     * @param \Mageplaza\Osc\Helper\Config $helperConfig
      */
     public function __construct(
         UrlInterface $url,
-        OscHelper $oscHelper
+        HelperConfig $helperConfig
     )
     {
-        $this->_url = $url;
-        $this->_oscHelper = $oscHelper;
+        $this->_url            = $url;
+        $this->_helperConfig   = $helperConfig;
     }
 
     /**
@@ -63,7 +60,7 @@ class RedirectToOneStepCheckout implements ObserverInterface
      */
     public function execute(Observer $observer)
     {
-        if ($this->_oscHelper->isEnabled() && $this->_oscHelper->isRedirectToOneStepCheckout()) {
+        if ($this->_helperConfig->isEnabled() && $this->_helperConfig->isRedirectToOneStepCheckout()) {
             $observer->getRequest()->setParam('return_url', $this->_url->getUrl('onestepcheckout'));
         }
     }
diff --git a/Setup/InstallData.php b/Setup/InstallData.php
index cca4ee5..d4834fe 100644
--- a/Setup/InstallData.php
+++ b/Setup/InstallData.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Setup/UpgradeData.php b/Setup/UpgradeData.php
index 75d1b5e..f96d3e1 100644
--- a/Setup/UpgradeData.php
+++ b/Setup/UpgradeData.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -71,7 +71,7 @@ class UpgradeData implements UpgradeDataInterface
         $setup->startSetup();
         if (version_compare($context->getVersion(), '2.1.0') < 0) {
             $entityAttributesCodes = [
-                'osc_gift_wrap_amount' => Table::TYPE_DECIMAL,
+                'osc_gift_wrap_amount'      => Table::TYPE_DECIMAL,
                 'base_osc_gift_wrap_amount' => Table::TYPE_DECIMAL
             ];
             foreach ($entityAttributesCodes as $code => $type) {
diff --git a/UserGuide.pdf b/UserGuide.pdf
deleted file mode 100644
index c50786f..0000000
--- a/UserGuide.pdf
+++ /dev/null
@@ -1,92 +0,0 @@
-                            W: ​https://www.mageplaza.com 
-                            E: ​support@mageplaza.com  
-
-              
-
-                 
-
-ONE STEP CHECKOUT 
-USER GUIDE 
-
-              
-  
-              
-
-                                                             
- 
-
-            
-
-Documentation 
-
-    ● Installation guide 
-    ● User Guide: h​ ttps://docs.mageplaza.com/one-step-checkout-m2/  
-    ● Product page: ​https://www.mageplaza.com/magento-2-one-step-checkout-extension/  
-    ● FAQs: ​https://www.mageplaza.com/faqs/  
-    ● Get Support: h​ ttps://mageplaza.freshdesk.com/​ or s​ upport@mageplaza.com  
-    ● Changelog: h​ ttps://www.mageplaza.com/changelog/m2-one-step-checkout.txt  
-    ● License agreement: https://www.mageplaza.com/LICENSE.txt 
-
-How to install 
-
- 
-
-Install ready-to-paste package (Recommended) 
-
-Installation guide: 
-https://www.mageplaza.com/install-magento-2-extension/#solution-1-ready-to-paste  
-
-  
-
-How to upgrade 
-
-Backup 
-
-    ● Backup your Magento code, database before upgrading. 
-    ● Remove OSC folder  
-    ● In case of customization, you should backup the customized files and modify in newer 
-
-         version.  
-    ● Now you remove app/code/Mageplaza/Osc folder. In this step, you can copy override Osc 
-
-         folder but this may cause of compilation issue. That why you should remove it. 
-    ● Upload new version 
-    ● Upload this package to Magento root directory 
-    ● Run command line: 
-
-         php bin/magento setup:upgrade
-
-         php bin/magento setup:static-content:deploy
-
-                                                                                                                               1 
- 
-            
-
- 
-
-FAQs 
-
- 
-Q: I got error: Mageplaza_Core has been already defined 
-A: Read solution: h​ ttps://github.com/mageplaza/module-core/issues/3  
- 
-Q: I got compile error 
-Total Errors Count: 5 Errors during compilation: 
-A: There are 2 major Mageplaza Osc version: OSC v1.x and OSC v2.x . If you are upgrade from 
-OSC v1.x to V2.x, you should remove app/code/Mageplaza/Osc folder before upgrading. 
- 
- 
-Q: My site is down 
-A: Please follow this guide: ​https://www.mageplaza.com/blog/magento-site-down.html  
- 
- 
-
-Support 
-
-    ● FAQs: ​https://www.mageplaza.com/faqs/  
-    ● Help Desk: h​ ttps://mageplaza.freshdesk.com/  
-    ● Email: ​support@mageplaza.com  
- 
-
-                                                                                                                               2 
-
\ No newline at end of file
diff --git a/composer.json b/composer.json
index 75e85d4..31b03f5 100644
--- a/composer.json
+++ b/composer.json
@@ -1,27 +1,28 @@
 {
-  "name": "mageplaza/magento-2-one-step-checkout-extension",
-  "description": "Magento 2 One Step Checkout",
-  "require": {
-    "mageplaza/module-core": "^1.3.11",
-    "geoip2/geoip2": "~2.0"
-  },
-  "type": "magento2-module",
-  "version": "2.4.3",
-  "license": "proprietary",
-  "authors": [
-    {
-      "name": "Mageplaza",
-      "email": "support@mageplaza.com",
-      "homepage": "https://www.mageplaza.com",
-      "role": "Technical Support"
-    }
-  ],
-  "autoload": {
-    "files": [
-      "registration.php"
+    "name": "mageplaza/magento-2-one-step-checkout-extension",
+    "description": "",
+    "require": {
+        "mageplaza/module-core": "*"
+    },
+    "type": "magento2-module",
+    "version": "2.4.2",
+    "license": "Mageplaza License",
+    "authors": [
+        {
+          "name": "Hi",
+          "email": "hi@mageplaza.com",
+          "homepage": "https://www.mageplaza.com",
+          "role": "Leader"
+        }
     ],
-    "psr-4": {
-      "Mageplaza\\Osc\\": ""
+
+    "autoload": {
+        "files": [
+            "registration.php"
+        ],
+        "psr-4": {
+            "Mageplaza\\Osc\\": ""
+        }
     }
-  }
-}
+
+}
\ No newline at end of file
diff --git a/etc/acl.xml b/etc/acl.xml
index 46e2dca..08c58bc 100644
--- a/etc/acl.xml
+++ b/etc/acl.xml
@@ -16,21 +16,25 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Acl/etc/acl.xsd">
     <acl>
         <resources>
             <resource id="Magento_Backend::admin">
-                <resource id="Magento_Backend::stores">
-                    <resource id="Mageplaza_Osc::osc" title="One Step Checkout" sortOrder="45">
+                <resource id="Mageplaza_Core::menu">
+                    <resource id="Mageplaza_Osc::osc" title="One Step Checkout" sortOrder="71">
                         <resource id="Mageplaza_Osc::field_management" title="Manage Fields" sortOrder="10"/>
+                        <resource id="Mageplaza_Osc::configuration" title="Configuration" sortOrder="1000"/>
                     </resource>
+                </resource>
+                <resource id="Magento_Backend::stores">
                     <resource id="Magento_Backend::stores_settings">
                         <resource id="Magento_Config::config">
-                            <resource id="Mageplaza_Osc::configuration" title="Mageplaza One Step Checkout"/>
+                            <resource id="Mageplaza_Osc::config_osc" title="One Step Checkout"/>
                         </resource>
                     </resource>
                 </resource>
diff --git a/etc/adminhtml/di.xml b/etc/adminhtml/di.xml
index d2fab1b..a5e97e6 100644
--- a/etc/adminhtml/di.xml
+++ b/etc/adminhtml/di.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/events.xml b/etc/adminhtml/events.xml
index b7412b1..9a9b7c5 100644
--- a/etc/adminhtml/events.xml
+++ b/etc/adminhtml/events.xml
@@ -1,23 +1,23 @@
 <?xml version="1.0" encoding="UTF-8"?>
 <!--
 /**
- * Mageplaza
+ * Magestore
  *
  * NOTICE OF LICENSE
  *
- * This source file is subject to the Mageplaza.com license that is
+ * This source file is subject to the Magestore.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://www.magestore.com/license-agreement.html
  *
  * DISCLAIMER
  *
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * @category    Magestore
+ * @package     Magestore_OneStepCheckout
+ * @copyright   Copyright (c) 2012 Magestore (http://www.magestore.com/)
+ * @license     http://www.magestore.com/license-agreement.html
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index dc14b96..a0949fb 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -16,14 +16,14 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
     <menu>
-        <add id="Mageplaza_Osc::osc" resource="Mageplaza_Osc::osc" module="Mageplaza_Osc" title="One Step Checkout" sortOrder="45" parent="Magento_Backend::stores"/>
+        <add id="Mageplaza_Osc::osc" resource="Mageplaza_Osc::osc" module="Mageplaza_Osc" title="One Step Checkout" sortOrder="10" parent="Mageplaza_Core::menu"/>
         <add id="Mageplaza_Osc::field_management" title="Manage Fields" module="Mageplaza_Osc" sortOrder="50" action="onestepcheckout/field/position" resource="Mageplaza_Osc::field_management" parent="Mageplaza_Osc::osc"/>
-        <!--<add id="Mageplaza_Osc::configuration" title="Configuration" module="Mageplaza_Osc" sortOrder="1000" action="adminhtml/system_config/edit/section/osc" resource="Mageplaza_Osc::configuration" parent="Mageplaza_Osc::osc"/>-->
+        <add id="Mageplaza_Osc::configuration" title="Configuration" module="Mageplaza_Osc" sortOrder="1000" action="adminhtml/system_config/edit/section/osc" resource="Mageplaza_Osc::configuration" parent="Mageplaza_Osc::osc"/>
     </menu>
 </config>
\ No newline at end of file
diff --git a/etc/adminhtml/routes.xml b/etc/adminhtml/routes.xml
index 1d57e5e..f129db1 100644
--- a/etc/adminhtml/routes.xml
+++ b/etc/adminhtml/routes.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 1fb6cb7..978f9f4 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -16,62 +16,75 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
+<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+        xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
     <system>
-        <section id="osc" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
+        <section id="osc" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1"
+                 showInStore="1">
             <label>One Step Checkout</label>
             <tab>mageplaza</tab>
-            <resource>Mageplaza_Osc::configuration</resource>
-            <group id="general" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
+            <resource>Mageplaza_Osc::config_osc</resource>
+            <group id="general" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1"
+                   showInStore="1">
                 <label>General Configuration</label>
-                <field id="enabled" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled" translate="label comment" sortOrder="10" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable One Step Checkout</label>
                     <comment><![CDATA[Select <strong>Yes</strong> to enable the module.]]></comment>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
-                <field id="title" translate="label comment" sortOrder="20" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="title" translate="label comment" sortOrder="20" type="text" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>One Step Checkout Page Title</label>
                     <comment>Enter the title of the page.</comment>
                 </field>
-                <field id="description" translate="label comment" sortOrder="40" type="textarea" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="description" translate="label comment" sortOrder="40" type="textarea" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>One Step Checkout Description</label>
                     <comment>Enter description for the page. HTML allowed.</comment>
                 </field>
-                <field id="default_shipping_method" translate="label comment" sortOrder="70" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="default_shipping_method" translate="label comment" sortOrder="70" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Default Shipping Method</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ShippingMethods</source_model>
                     <comment>Set default shipping method in the checkout process.</comment>
                 </field>
-                <field id="default_payment_method" translate="label comment" sortOrder="80" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="default_payment_method" translate="label comment" sortOrder="80" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Default Payment Method</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\PaymentMethods</source_model>
                     <comment>Set default payment method in the checkout process.</comment>
                 </field>
-                <field id="allow_guest_checkout" translate="label comment" sortOrder="90" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="allow_guest_checkout" translate="label comment" sortOrder="90" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Allow Guest Checkout</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Select Yes to allow checking out as a guest. Guests can create an account in the Checkout Page.</comment>
                 </field>
-                <field id="redirect_to_one_step_checkout" translate="label comment" sortOrder="95" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="redirect_to_one_step_checkout" translate="label comment" sortOrder="95" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Auto-redirect to One Step Checkout Page</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>Select Yes to enable redirecting to the Checkout Page after a product's added to cart.</comment>
                 </field>
-                <field id="show_billing_address" translate="label comment" sortOrder="100" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="show_billing_address" translate="label comment" sortOrder="100" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Billing Address</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select Yes to allow the <strong>Billing Address</strong> block to appear in the Checkout Page, or No to imply that <strong>Billing Address</strong> and <strong>Shipping Address</strong> are the same.]]></comment>
                 </field>
-                <field id="auto_detect_address" sortOrder="101" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="auto_detect_address" sortOrder="101" type="select" showInDefault="1" showInWebsite="1"
+                       showInStore="1" canRestore="1">
                     <label>Use Auto Suggestion Technology</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\AddressSuggest</source_model>
                     <comment><![CDATA[Select <strong>Google</strong> to use it for automatic address suggestion, or <strong>No</strong> to disable this feature.]]></comment>
                 </field>
-                <field id="google_api_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="google_api_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1"
+                       showInStore="1" canRestore="1">
                     <label>Google Api Key</label>
                     <comment>
                         You should register a new key. Get Api key &lt;a
@@ -83,14 +96,16 @@
                         <field id="auto_detect_address">google</field>
                     </depends>
                 </field>
-                <field id="google_specific_country" sortOrder="102" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="google_specific_country" sortOrder="102" type="select" showInDefault="1" showInWebsite="1"
+                       showInStore="1">
                     <label>Restrict the auto suggestion for a specific country</label>
                     <source_model>Magento\Directory\Model\Config\Source\Country</source_model>
                     <depends>
                         <field id="auto_detect_address">google</field>
                     </depends>
                 </field>
-                <field id="pca_website_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="pca_website_key" sortOrder="102" type="text" showInDefault="1" showInWebsite="1"
+                       showInStore="1">
                     <label>Capture+ Key</label>
                     <comment>
                         To set up a Capture+ account or these keys, please visit &lt;a
@@ -101,7 +116,8 @@
                         <field id="auto_detect_address">pca</field>
                     </depends>
                 </field>
-                <field id="pca_country_lookup" sortOrder="103" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="pca_country_lookup" sortOrder="103" type="select" showInDefault="1" showInWebsite="1"
+                       showInStore="1">
                     <label>IP Country Lookup</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment>The default country will be set based on location of the customer.</comment>
@@ -110,19 +126,23 @@
                     </depends>
                 </field>
             </group>
-            <group id="display_configuration" translate="label comment" sortOrder="20" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
+            <group id="display_configuration" translate="label comment" sortOrder="20" type="text" showInDefault="1"
+                   showInWebsite="1" showInStore="1">
                 <label>Display Configuration</label>
-                <field id="is_enabled_login_link" translate="label comment" sortOrder="2" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_login_link" translate="label comment" sortOrder="2" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Login Link</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to show a link for visitors to login.]]></comment>
                 </field>
-                <field id="is_enabled_review_cart_section" translate="label comment" sortOrder="5" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_review_cart_section" translate="label comment" sortOrder="5" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Order Review Section</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>No</strong> to remove the Order Review section. The section is displayed by default.]]></comment>
                 </field>
-                <field id="is_show_product_image" translate="label comment" sortOrder="6" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_show_product_image" translate="label comment" sortOrder="6" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Product Thumbnail Image</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <depends>
@@ -130,17 +150,20 @@
                     </depends>
                     <comment><![CDATA[Select <strong>Yes</strong> to show product thumbnail image.]]></comment>
                 </field>
-                <field id="show_coupon" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="show_coupon" translate="label comment" sortOrder="10" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Discount Code Section</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to show Discount Code section.]]></comment>
                 </field>
-                <field id="is_enabled_gift_wrap" translate="label comment" sortOrder="20" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="is_enabled_gift_wrap" translate="label comment" sortOrder="20" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Enable Gift Wrap</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to enable Gift Wrap.]]></comment>
                 </field>
-                <field id="gift_wrap_type" translate="label comment" sortOrder="21" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="gift_wrap_type" translate="label comment" sortOrder="21" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1">
                     <label>Calculate Method</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Giftwrap</source_model>
                     <comment>To calculate gift wrap fee based on item or order.</comment>
@@ -148,7 +171,8 @@
                         <field id="is_enabled_gift_wrap">1</field>
                     </depends>
                 </field>
-                <field id="gift_wrap_amount" translate="label comment" sortOrder="22" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="gift_wrap_amount" translate="label comment" sortOrder="22" type="text" showInDefault="1"
+                       showInWebsite="1" showInStore="1">
                     <label>Amount</label>
                     <comment>Enter the amount of gift wrap fee.</comment>
                     <validate>validate-number</validate>
@@ -156,32 +180,38 @@
                         <field id="is_enabled_gift_wrap">1</field>
                     </depends>
                 </field>
-                <field id="is_enabled_comments" translate="label comment" sortOrder="30" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_comments" translate="label comment" sortOrder="30" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Order Comment</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to allow customers to comment on the order.]]></comment>
                 </field>
-                <field id="is_enabled_gift_message" translate="label comment" sortOrder="35" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_gift_message" translate="label comment" sortOrder="35" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Gift Messages on order.</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to allow leaving messages on the whole order.]]></comment>
                 </field>
-                <field id="is_enabled_gift_message_items" translate="label comment" sortOrder="38" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_gift_message_items" translate="label comment" sortOrder="38" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Gift Messages on item</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to allow leaving messages on each item.]]></comment>
                 </field>
-                <field id="show_toc" translate="label comment" sortOrder="40" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="show_toc" translate="label comment" sortOrder="40" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Terms and Conditions</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\ComponentPosition</source_model>
                     <comment><![CDATA[Select <strong>No</strong> to hide <strong>Terms and Conditions</strong>, or select an area to display it.]]></comment>
                 </field>
-                <field id="is_enabled_newsletter" translate="label comment" sortOrder="60" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_newsletter" translate="label comment" sortOrder="60" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Newsletter Checkbox</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to show the Newsletter checkbox.]]></comment>
                 </field>
-                <field id="is_checked_newsletter" translate="label comment" sortOrder="61" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_checked_newsletter" translate="label comment" sortOrder="61" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Checked Newsletter by default</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <depends>
@@ -189,18 +219,22 @@
                     </depends>
                     <comment><![CDATA[Select <strong>Yes</strong> to have the Newsletter checkbox ticked by default.]]></comment>
                 </field>
-                <field id="is_enabled_social_login" translate="label comment" sortOrder="70" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_social_login" translate="label comment" sortOrder="70" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Social Login On Checkout Page</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <if_module_enabled>Mageplaza_SocialLogin</if_module_enabled>
-                    <comment><![CDATA[Select <strong>Yes</strong> to allow customers to login via their social network accounts. Supports Mageplaza <a href="https://www.mageplaza.com/magento-2-social-login-extension" target="_blank">Social Login</a>]]></comment>
+                    <comment><![CDATA[Select <strong>Yes</strong> to allow customers to login via their social network accounts. Supports Mageplaza <a href="https://www.mageplaza.com/magento-2-social-login-extension"
+                        target="_blank">Social Login</a>]]></comment>
                 </field>
-                <field id="is_enabled_delivery_time" translate="label comment" sortOrder="80" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_delivery_time" translate="label comment" sortOrder="80" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Delivery Time</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to allow customers to choose delivery time.]]></comment>
                 </field>
-                <field id="is_enabled_house_security_code" translate="label comment" sortOrder="81" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_house_security_code" translate="label comment" sortOrder="81" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>House Security Code</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <depends>
@@ -208,7 +242,9 @@
                     </depends>
                     <comment><![CDATA[Select <strong>Yes</strong> to allow customers to fill their house security codes.]]></comment>
                 </field>
-                <field id="delivery_time_format" translate="label comment" sortOrder="82" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+
+                <field id="delivery_time_format" translate="label comment" sortOrder="82" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Date Format</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\DeliveryTime</source_model>
                     <depends>
@@ -216,7 +252,8 @@
                     </depends>
                     <comment>Select the date format used for delivery time.</comment>
                 </field>
-                <field id="delivery_time_off" translate="label" type="multiselect" sortOrder="83" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="delivery_time_off" translate="label" type="multiselect" sortOrder="83" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Days Off</label>
                     <source_model>Magento\Config\Model\Config\Source\Locale\Weekdays</source_model>
                     <can_be_empty>1</can_be_empty>
@@ -225,18 +262,21 @@
                     </depends>
                     <comment>Select days off</comment>
                 </field>
-                <field id="is_enabled_survey" translate="label comment" sortOrder="100" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_survey" translate="label comment" sortOrder="100" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable Survey</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to show a survey after successful checkout]]></comment>
                 </field>
-                <field id="survey_question" translate="label comment" sortOrder="104" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="survey_question" translate="label comment" sortOrder="104" type="text" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1" >
                     <label>Survey Question</label>
                     <depends>
                         <field id="is_enabled_survey">1</field>
                     </depends>
                 </field>
-                <field id="survey_answers" translate="label comment" sortOrder="106" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="survey_answers" translate="label comment" sortOrder="106"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Survey Answers</label>
                     <frontend_model>Mageplaza\Osc\Model\System\Config\Source\Survey</frontend_model>
                     <backend_model>Magento\Config\Model\Config\Backend\Serialized\ArraySerialized</backend_model>
@@ -244,7 +284,8 @@
                         <field id="is_enabled_survey">1</field>
                     </depends>
                 </field>
-                <field id="allow_customer_add_other_option" translate="label comment" sortOrder="108" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="allow_customer_add_other_option" translate="label comment" sortOrder="108" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Allow Customer Add Other Option</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <depends>
@@ -252,68 +293,80 @@
                     </depends>
                 </field>
             </group>
-            <group id="design_configuration" translate="label comment" sortOrder="30" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
+            <group id="design_configuration" translate="label comment" sortOrder="30" type="text" showInDefault="1"
+                   showInWebsite="1" showInStore="1">
                 <label>Design Configuration</label>
-                <field id="page_layout" translate="label comment" sortOrder="1" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="page_layout" translate="label comment" sortOrder="1" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Checkout Page Layout</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Layout</source_model>
                     <comment>Select the layout used for the Checkout Page.</comment>
                 </field>
-                <field id="page_design" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="page_design" translate="label comment" sortOrder="10" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Design Style</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\Design</source_model>
                     <comment>Select the design style for the Checkout Page.</comment>
                 </field>
-                <field id="heading_background" translate="label comment" sortOrder="20" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="heading_background" translate="label comment" sortOrder="20" type="text" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Heading Background Color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                     <depends>
                         <field id="page_design">flat</field>
                     </depends>
                 </field>
-                <field id="heading_text" translate="label comment" sortOrder="25" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="heading_text" translate="label comment" sortOrder="25" type="text" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Heading Text Color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                     <depends>
-                        <field id="page_design">flat</field>
+                        <field id="page_design" >flat</field>
                     </depends>
                 </field>
-                <field id="radio_button_style" translate="label comment" sortOrder="26" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="radio_button_style" translate="label comment" sortOrder="26" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Radio Button Style</label>
                     <depends>
-                        <field id="page_design">material</field>
+                        <field id="page_design" >material</field>
                     </depends>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\RadioStyle</source_model>
                     <comment>Select the radio button style.</comment>
                 </field>
-                <field id="checkbox_button_style" translate="label comment" sortOrder="27" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="checkbox_button_style" translate="label comment" sortOrder="27" type="select" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>CheckBox Button Style</label>
                     <source_model>Mageplaza\Osc\Model\System\Config\Source\CheckboxStyle</source_model>
                     <depends>
-                        <field id="page_design">material</field>
+                        <field id="page_design" >material</field>
                     </depends>
                     <comment>Select the checkbox button style.</comment>
                 </field>
-                <field id="material_color" translate="label comment" sortOrder="28" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="material_color" translate="label comment" sortOrder="28" type="text" showInDefault="1"
+                       showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Material Color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                     <comment>Change color icon heading, border input text, radio,checkbox buttons.</comment>
                     <depends>
-                        <field id="page_design">material</field>
+                        <field id="page_design" >material</field>
                     </depends>
                 </field>
-                <field id="place_order_button" sortOrder="30" type="text" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+
+                <field id="place_order_button" sortOrder="30" type="text" showInDefault="1" showInWebsite="1"
+                       showInStore="1" canRestore="1">
                     <label>Place Order button color</label>
                     <validate>jscolor {hash:true,refine:false}</validate>
                 </field>
-                <field id="custom_css" sortOrder="100" type="textarea" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="custom_css" sortOrder="100" type="textarea" showInDefault="1" showInWebsite="1"
+                       showInStore="1">
                     <label>Custom Css</label>
                     <comment><![CDATA[Example: .step-title{background-color: #1979c3;}]]></comment>
                 </field>
             </group>
             <group id="geoip_configuration" translate="label comment" sortOrder="40" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>GeoIP Configuration</label>
-                <field id="is_enable_geoip" translate="label comment" sortOrder="1" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
+                <field id="is_enable_geoip" translate="label comment" sortOrder="1" type="select"
+                       showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Enable GeoIP</label>
                     <comment>Please download library before enable.</comment>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
@@ -322,6 +375,7 @@
                     <frontend_model>Mageplaza\Osc\Block\Adminhtml\System\Config\Geoip</frontend_model>
                     <label></label>
                 </field>
+                <!--<field id="download_path" translate="label comment" sortOrder="20" type="hidden" showInDefault="1" showInWebsite="1" showInStore="1"></field>-->
             </group>
         </section>
     </system>
diff --git a/etc/config.xml b/etc/config.xml
index a4499e6..f1e4bfa 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -16,15 +16,16 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Store:etc/config.xsd">
     <default>
         <osc>
             <general>
-                <enabled>1</enabled>
+                <is_enabled>1</is_enabled>
                 <title>One Step Checkout</title>
                 <description>Please enter your details below to complete your purchase.</description>
                 <allow_guest_checkout>1</allow_guest_checkout>
diff --git a/etc/di.xml b/etc/di.xml
index ac66390..7d53a50 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <preference for="Mageplaza\Osc\Api\CheckoutManagementInterface" type="Mageplaza\Osc\Model\CheckoutManagement" />
     <preference for="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" type="Mageplaza\Osc\Model\GuestCheckoutManagement" />
diff --git a/etc/events.xml b/etc/events.xml
index fc836f6..b044e18 100644
--- a/etc/events.xml
+++ b/etc/events.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
     <event name="sales_model_service_quote_submit_before">
         <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\QuoteSubmitBefore" />
diff --git a/etc/extension_attributes.xml b/etc/extension_attributes.xml
index 94e0cf9..d2a0a39 100644
--- a/etc/extension_attributes.xml
+++ b/etc/extension_attributes.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Api/etc/extension_attributes.xsd">
+
+<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+        xsi:noNamespaceSchemaLocation="urn:magento:framework:Api/etc/extension_attributes.xsd">
     <extension_attributes for="Magento\Quote\Api\Data\TotalSegmentInterface">
         <attribute code="gift_wrap_amount" type="float"/>
     </extension_attributes>
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index af210d4..44b58dd 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <!-- Register onestepcheckout link as secure url -->
     <type name="Magento\Framework\Url\SecurityInfo">
diff --git a/etc/frontend/events.xml b/etc/frontend/events.xml
index aa41176..178b9aa 100644
--- a/etc/frontend/events.xml
+++ b/etc/frontend/events.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
     <event name="checkout_allow_guest">
         <observer name="checkout_allow_guest" instance="Mageplaza\Osc\Observer\IsAllowedGuestCheckoutObserver" />
diff --git a/etc/frontend/routes.xml b/etc/frontend/routes.xml
index d8c85b7..ff1d73d 100644
--- a/etc/frontend/routes.xml
+++ b/etc/frontend/routes.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:App/etc/routes.xsd">
     <router id="standard">
         <route id="onestepcheckout" frontName="onestepcheckout">
diff --git a/etc/frontend/sections.xml b/etc/frontend/sections.xml
index ed1c35f..e9d5146 100644
--- a/etc/frontend/sections.xml
+++ b/etc/frontend/sections.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Customer:etc/sections.xsd">
+
+<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+        xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Customer:etc/sections.xsd">
     <action name="rest/*/V1/carts/*/update-item">
         <section name="cart"/>
         <section name="checkout-data"/>
diff --git a/etc/module.xml b/etc/module.xml
index 150582e..70529a3 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
     <module name="Mageplaza_Osc" setup_version="2.1.3">
         <sequence>
diff --git a/etc/sales.xml b/etc/sales.xml
index ba84a69..cbb75fa 100644
--- a/etc/sales.xml
+++ b/etc/sales.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Sales:etc/sales.xsd">
     <section name="quote">
         <group name="totals">
diff --git a/etc/webapi.xml b/etc/webapi.xml
index 31289e7..10b488e 100644
--- a/etc/webapi.xml
+++ b/etc/webapi.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<routes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Webapi:etc/webapi.xsd">
+
+<routes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+        xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Webapi:etc/webapi.xsd">
     <route url="/V1/guest-carts/:cartId/update-item" method="POST">
         <service class="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" method="updateItemQty"/>
         <resources>
diff --git a/etc/webapi_rest/di.xml b/etc/webapi_rest/di.xml
index 2f17660..b06a397 100644
--- a/etc/webapi_rest/di.xml
+++ b/etc/webapi_rest/di.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <!-- Save address when estimate shipping method -->
     <type name="Magento\Quote\Model\ShippingMethodManagement">
diff --git a/registration.php b/registration.php
index 9eb2916..3e2d5d7 100644
--- a/registration.php
+++ b/registration.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/layout/onestepcheckout_field_position.xml b/view/adminhtml/layout/onestepcheckout_field_position.xml
index 0d7c71c..634e9c0 100644
--- a/view/adminhtml/layout/onestepcheckout_field_position.xml
+++ b/view/adminhtml/layout/onestepcheckout_field_position.xml
@@ -16,10 +16,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
+
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-1column" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <head>
         <css src="Mageplaza_Osc::css/style.css"/>
diff --git a/view/adminhtml/layout/sales_order_creditmemo_new.xml b/view/adminhtml/layout/sales_order_creditmemo_new.xml
index 1fb99fa..fefeba1 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_new.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_new.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="creditmemo_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml b/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
index 1fb99fa..fefeba1 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="creditmemo_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_creditmemo_view.xml b/view/adminhtml/layout/sales_order_creditmemo_view.xml
index 1fb99fa..fefeba1 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_view.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_view.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="creditmemo_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_invoice_email.xml b/view/adminhtml/layout/sales_order_invoice_email.xml
index 89e5644..852636d 100644
--- a/view/adminhtml/layout/sales_order_invoice_email.xml
+++ b/view/adminhtml/layout/sales_order_invoice_email.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="invoice_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_invoice_new.xml b/view/adminhtml/layout/sales_order_invoice_new.xml
index 89e5644..852636d 100644
--- a/view/adminhtml/layout/sales_order_invoice_new.xml
+++ b/view/adminhtml/layout/sales_order_invoice_new.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="invoice_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_invoice_print.xml b/view/adminhtml/layout/sales_order_invoice_print.xml
index 89e5644..852636d 100644
--- a/view/adminhtml/layout/sales_order_invoice_print.xml
+++ b/view/adminhtml/layout/sales_order_invoice_print.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="invoice_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_invoice_updateqty.xml b/view/adminhtml/layout/sales_order_invoice_updateqty.xml
index 89e5644..852636d 100644
--- a/view/adminhtml/layout/sales_order_invoice_updateqty.xml
+++ b/view/adminhtml/layout/sales_order_invoice_updateqty.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="invoice_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_invoice_view.xml b/view/adminhtml/layout/sales_order_invoice_view.xml
index 89e5644..852636d 100644
--- a/view/adminhtml/layout/sales_order_invoice_view.xml
+++ b/view/adminhtml/layout/sales_order_invoice_view.xml
@@ -16,11 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="invoice_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/adminhtml/layout/sales_order_view.xml b/view/adminhtml/layout/sales_order_view.xml
index eb8ea00..c5e8ac8 100644
--- a/view/adminhtml/layout/sales_order_view.xml
+++ b/view/adminhtml/layout/sales_order_view.xml
@@ -16,20 +16,26 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-2columns-left" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-2columns-left"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <head>
         <css src="Mageplaza_Osc::css/style.css"/>
     </head>
     <body>
         <referenceBlock name="order_tab_info">
-            <block class="Magento\Backend\Block\Template" name="osc_additional_content" template="Mageplaza_Osc::order/additional.phtml">
-                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="order_comment" template="order/view/comment.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time" template="order/view/delivery-time.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\Survey" name="survey" template="order/view/survey.phtml"/>
+            <block class="Magento\Backend\Block\Template" name="osc_additional_content"
+                   template="Mageplaza_Osc::order/additional.phtml">
+                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="order_comment"
+                       template="order/view/comment.phtml"/>
+                <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time"
+                       template="order/view/delivery-time.phtml"/>
+                <block class="Mageplaza\Osc\Block\Order\View\Survey" name="survey"
+                       template="order/view/survey.phtml"/>
             </block>
         </referenceBlock>
         <referenceBlock name="order_totals">
diff --git a/view/adminhtml/templates/field/position.phtml b/view/adminhtml/templates/field/position.phtml
index b5fc3f5..6001d01 100644
--- a/view/adminhtml/templates/field/position.phtml
+++ b/view/adminhtml/templates/field/position.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -164,7 +164,7 @@ $_helper          = $block->getHelperData();
 	});
 </script>
 
-<?php $design = $this->getHelperData()->getDesignConfig(); ?>
+<?php $design = $this->getHelperData()->getConfig()->getDesignConfig(); ?>
 <style type="text/css">
 	.field-title {
 		background-color: <?php echo (isset($design['heading_background']) && $design['heading_background']) ? $design['heading_background'] : '#FF7800' ?>;
diff --git a/view/adminhtml/templates/order/additional.phtml b/view/adminhtml/templates/order/additional.phtml
index 30924b9..f680199 100644
--- a/view/adminhtml/templates/order/additional.phtml
+++ b/view/adminhtml/templates/order/additional.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/comment.phtml b/view/adminhtml/templates/order/view/comment.phtml
index d698996..06fab19 100644
--- a/view/adminhtml/templates/order/view/comment.phtml
+++ b/view/adminhtml/templates/order/view/comment.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/delivery-time.phtml b/view/adminhtml/templates/order/view/delivery-time.phtml
index fb6212f..1c72f87 100644
--- a/view/adminhtml/templates/order/view/delivery-time.phtml
+++ b/view/adminhtml/templates/order/view/delivery-time.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -35,5 +35,6 @@
                 <br><strong><?php /* @escapeNotVerified */ echo __('House Security Code') ?>: </strong><span><?php echo $houseSecurityCodeHtml ?></span>
 			<?php endif; ?>
         </div>
+
     </div>
 <?php endif; ?>
\ No newline at end of file
diff --git a/view/adminhtml/templates/order/view/survey.phtml b/view/adminhtml/templates/order/view/survey.phtml
index 7703338..a954f37 100644
--- a/view/adminhtml/templates/order/view/survey.phtml
+++ b/view/adminhtml/templates/order/view/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/system/config/geoip.phtml b/view/adminhtml/templates/system/config/geoip.phtml
index 0ba0b48..cad9b1e 100644
--- a/view/adminhtml/templates/system/config/geoip.phtml
+++ b/view/adminhtml/templates/system/config/geoip.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -34,10 +34,12 @@
 				loaderArea:     false,
 				asynchronous:   true,
 				onCreate: function() {
+
 					collectSpan.find('.collected').hide();
 					collectSpan.find('.processing').show();
 					$('#collect_message_span').text('');
 					buttonDownload.prop( "disabled", true );
+
 				},
 				onSuccess: function(response) {
 					var response = JSON.parse(response.responseText);
diff --git a/view/adminhtml/web/css/style.css b/view/adminhtml/web/css/style.css
index 7bb484e..e0b0736 100644
--- a/view/adminhtml/web/css/style.css
+++ b/view/adminhtml/web/css/style.css
@@ -14,11 +14,22 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 /*
+	Stylesheet for examples by DevHeart.
+	http://devheart.org/
+
+	Article title:	jQuery: Customizable layout using drag n drop
+	Article URI:	http://devheart.org/articles/jquery-customizable-layout-using-drag-and-drop/
+
+	Example title:	1. Getting started with sortable lists
+	Example URI:	http://devheart.org/examples/jquery-customizable-layout-using-drag-and-drop/1-getting-started-with-sortable-lists/index.html
+*/
+
+/*
 	Alignment
 ------------------------------------------------------------------- */
 /* Floats */
diff --git a/view/frontend/layout/checkout_onepage_success.xml b/view/frontend/layout/checkout_onepage_success.xml
index f2a6b50..e54a8cf 100644
--- a/view/frontend/layout/checkout_onepage_success.xml
+++ b/view/frontend/layout/checkout_onepage_success.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index 57ec276..e9bd494 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -37,7 +37,7 @@
                     <item name="components" xsi:type="array">
                         <item name="checkout" xsi:type="array">
                             <item name="config" xsi:type="array">
-                                <item name="template" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::getLayoutTemplate" />
+                                <item name="template" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::getLayoutTemplate" />
                             </item>
                             <item name="children" xsi:type="array">
                                 <item name="authentication" xsi:type="array">
@@ -50,7 +50,7 @@
                                         </item>
                                     </item>
                                     <item name="config" xsi:type="array">
-                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisableAuthentication" />
+                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisableAuthentication" />
                                     </item>
                                 </item>
                                 <item name="geoip" xsi:type="array">
@@ -72,13 +72,13 @@
                                                             <item name="children" xsi:type="array">
                                                                 <item name="additional_block" xsi:type="array">
                                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/delivery-time</item>
-                                                                    <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisabledDeliveryTime" />
+                                                                    <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledDeliveryTime" />
                                                                 </item>
                                                                 <item name="place-order-comment" xsi:type="array">
                                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/comment</item>
                                                                     <item name="sortOrder" xsi:type="string">20</item>
                                                                     <item name="config" xsi:type="array">
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisabledComment" />
+                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledComment" />
                                                                     </item>
                                                                 </item>
                                                             </item>
@@ -209,7 +209,7 @@
                                                             <item name="children" xsi:type="array">
                                                                 <item name="agreements-validator" xsi:type="array">
                                                                     <item name="config" xsi:type="array">
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::disabledPaymentTOC" />
+                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledPaymentTOC" />
                                                                     </item>
                                                                 </item>
                                                             </item>
@@ -225,7 +225,7 @@
                                                                     <item name="children" xsi:type="array">
                                                                         <item name="agreements" xsi:type="array">
                                                                             <item name="config" xsi:type="array">
-                                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::disabledPaymentTOC" />
+                                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledPaymentTOC" />
                                                                             </item>
                                                                         </item>
                                                                     </item>
@@ -238,7 +238,7 @@
                                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/payment/discount</item>
                                                                     <item name="config" xsi:type="array">
                                                                         <item name="template" xsi:type="string">Mageplaza_Osc/container/payment/discount</item>
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::disabledPaymentCoupon" />
+                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledPaymentCoupon" />
                                                                     </item>
                                                                 </item>
                                                             </item>
@@ -266,7 +266,7 @@
                                                     <item name="sortOrder" xsi:type="string">10</item>
                                                     <item name="config" xsi:type="array">
                                                         <item name="template" xsi:type="string">Mageplaza_Osc/container/summary/cart-items</item>
-                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisabledReviewCartSection" />
+                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledReviewCartSection" />
                                                     </item>
                                                     <item name="children" xsi:type="array">
                                                         <item name="details" xsi:type="array">
@@ -274,7 +274,7 @@
                                                             <item name="children" xsi:type="array">
                                                                 <item name="thumbnail" xsi:type="array">
                                                                     <item name="config" xsi:type="array">
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isHideProductImage" />
+                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isHideProductImage" />
                                                                     </item>
                                                                 </item>
                                                             </item>
@@ -293,7 +293,7 @@
                                                                     <item name="component"  xsi:type="string">Mageplaza_Osc/js/view/summary/gift-wrap</item>
                                                                     <item name="config" xsi:type="array">
                                                                         <item name="title" xsi:type="string" translate="true">Gift Wrap</item>
-                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisabledGiftWrap" />
+                                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledGiftWrap" />
                                                                     </item>
                                                                 </item>
                                                             </item>
@@ -314,7 +314,7 @@
                                                 <item name="discount" xsi:type="array">
                                                     <item name="component" xsi:type="string">Mageplaza_Osc/js/view/payment/discount</item>
                                                     <item name="config" xsi:type="array">
-                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::disabledReviewCoupon" />
+                                                        <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledReviewCoupon" />
                                                     </item>
                                                     <item name="children" xsi:type="array">
                                                         <item name="errors" xsi:type="array">
@@ -333,21 +333,21 @@
                                                             <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/addition/newsletter</item>
                                                             <item name="sortOrder" xsi:type="string">20</item>
                                                             <item name="config" xsi:type="array">
-                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisabledNewsletter" />
+                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledNewsletter" />
                                                             </item>
                                                         </item>
                                                         <item name="gift_wrap" xsi:type="array">
                                                             <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/addition/gift-wrap</item>
                                                             <item name="sortOrder" xsi:type="string">30</item>
                                                             <item name="config" xsi:type="array">
-                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisabledGiftWrap" />
+                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledGiftWrap" />
                                                             </item>
                                                         </item>
                                                         <item name="gift-message" xsi:type="array">
                                                             <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/addition/gift-message</item>
                                                             <item name="sortOrder" xsi:type="string">40</item>
                                                             <item name="config" xsi:type="array">
-                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::isDisabledGiftMessage" />
+                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::isDisabledGiftMessage" />
                                                             </item>
                                                         </item>
                                                     </item>
@@ -365,7 +365,7 @@
                                                         <item name="agreements" xsi:type="array">
                                                             <item name="component" xsi:type="string">Mageplaza_Osc/js/view/review/checkout-agreements</item>
                                                             <item name="config" xsi:type="array">
-                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Data::disabledReviewTOC" />
+                                                                <item name="componentDisabled" xsi:type="helper" helper="Mageplaza\Osc\Helper\Config::disabledReviewTOC" />
                                                             </item>
                                                             <item name="displayArea" xsi:type="string">checkout-agreements</item>
                                                             <item name="dataScope" xsi:type="string">checkoutAgreements</item>
diff --git a/view/frontend/layout/sales_email_order_creditmemo_items.xml b/view/frontend/layout/sales_email_order_creditmemo_items.xml
index 441cd90..a0673b9 100644
--- a/view/frontend/layout/sales_email_order_creditmemo_items.xml
+++ b/view/frontend/layout/sales_email_order_creditmemo_items.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,11 +15,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
  -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="creditmemo_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/frontend/layout/sales_email_order_invoice_items.xml b/view/frontend/layout/sales_email_order_invoice_items.xml
index 67519fb..b61881d 100644
--- a/view/frontend/layout/sales_email_order_invoice_items.xml
+++ b/view/frontend/layout/sales_email_order_invoice_items.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,11 +15,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
  -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="invoice_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/frontend/layout/sales_email_order_items.xml b/view/frontend/layout/sales_email_order_items.xml
index 172c253..ccc4170 100644
--- a/view/frontend/layout/sales_email_order_items.xml
+++ b/view/frontend/layout/sales_email_order_items.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,9 +15,8 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
  -->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd" label="Email Order Items List" design_abstraction="custom">
     <body>
diff --git a/view/frontend/layout/sales_order_creditmemo.xml b/view/frontend/layout/sales_order_creditmemo.xml
index 441cd90..fccc013 100644
--- a/view/frontend/layout/sales_order_creditmemo.xml
+++ b/view/frontend/layout/sales_order_creditmemo.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,11 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
+
  -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="creditmemo_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/frontend/layout/sales_order_invoice.xml b/view/frontend/layout/sales_order_invoice.xml
index 67519fb..08dbe70 100644
--- a/view/frontend/layout/sales_order_invoice.xml
+++ b/view/frontend/layout/sales_order_invoice.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,9 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
+
  -->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/frontend/layout/sales_order_print.xml b/view/frontend/layout/sales_order_print.xml
index 6593d6c..bbd464e 100644
--- a/view/frontend/layout/sales_order_print.xml
+++ b/view/frontend/layout/sales_order_print.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,11 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
+
  -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="order_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/frontend/layout/sales_order_printcreditmemo.xml b/view/frontend/layout/sales_order_printcreditmemo.xml
index 441cd90..fccc013 100644
--- a/view/frontend/layout/sales_order_printcreditmemo.xml
+++ b/view/frontend/layout/sales_order_printcreditmemo.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,11 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
+
  -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="creditmemo_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/frontend/layout/sales_order_printinvoice.xml b/view/frontend/layout/sales_order_printinvoice.xml
index 67519fb..b0c1c3a 100644
--- a/view/frontend/layout/sales_order_printinvoice.xml
+++ b/view/frontend/layout/sales_order_printinvoice.xml
@@ -1,13 +1,12 @@
 <?xml version="1.0"?>
 <!--
-/**
  * Mageplaza
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Mageplaza.com license that is
  * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
+ * http://mageplaza.com/license-agreement/
  *
  * DISCLAIMER
  *
@@ -16,11 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+ * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
+
  -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="invoice_totals">
             <block class="Mageplaza\Osc\Block\Order\Totals" name="creditmemo.osc.totals"/>
diff --git a/view/frontend/layout/sales_order_view.xml b/view/frontend/layout/sales_order_view.xml
index cfc9762..ccfe961 100644
--- a/view/frontend/layout/sales_order_view.xml
+++ b/view/frontend/layout/sales_order_view.xml
@@ -16,17 +16,22 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
+<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceContainer name="content">
-            <block class="Magento\Framework\View\Element\Template" name="osc.additional.content" template="Mageplaza_Osc::order/additional.phtml" after="-">
-                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="comment" template="order/view/comment.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time" template="order/view/delivery-time.phtml"/>
-                <block class="Mageplaza\Osc\Block\Order\View\Survey" name="survey" template="order/view/survey.phtml"/>
+            <block class="Magento\Framework\View\Element\Template" name="osc.additional.content"
+                   template="Mageplaza_Osc::order/additional.phtml" after="-">
+                <block class="Mageplaza\Osc\Block\Order\View\Comment" name="comment"
+                       template="order/view/comment.phtml"/>
+                <block class="Mageplaza\Osc\Block\Order\View\DeliveryTime" name="delivery_time"
+                       template="order/view/delivery-time.phtml"/>
+                <block class="Mageplaza\Osc\Block\Order\View\Survey" name="survey"
+                       template="order/view/survey.phtml"/>
             </block>
         </referenceContainer>
         <referenceBlock name="order_totals">
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index bcf2dd3..25c4bc6 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/templates/description.phtml b/view/frontend/templates/description.phtml
index 63e2ea9..255a65f 100644
--- a/view/frontend/templates/description.phtml
+++ b/view/frontend/templates/description.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/design.phtml b/view/frontend/templates/design.phtml
index a634eb0..ce081bb 100644
--- a/view/frontend/templates/design.phtml
+++ b/view/frontend/templates/design.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -336,6 +336,7 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
 <?php if($design['page_design'] == 'material'){?>
     <script type="text/javascript">
         require(['jquery'], function($){
+
             // Add ripple affect for button
             $(document).on('click','button',function(e){
                 var circle = document.createElement('div');
diff --git a/view/frontend/templates/onepage/compatible-config.phtml b/view/frontend/templates/onepage/compatible-config.phtml
index d92707f..61898a3 100644
--- a/view/frontend/templates/onepage/compatible-config.phtml
+++ b/view/frontend/templates/onepage/compatible-config.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/templates/onepage/success/survey.phtml b/view/frontend/templates/onepage/success/survey.phtml
index 316ea89..b798773 100644
--- a/view/frontend/templates/onepage/success/survey.phtml
+++ b/view/frontend/templates/onepage/success/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -23,7 +23,7 @@
     <div id="survey">
         <div id="survey-message"></div>
         <div class="survey-content">
-           <strong><?php /* @escapeNotVerified */ echo __('Question') ?>: </strong><span> <?php echo $block->getSurveyQuestion(); ?></span>
+           <strong>Question: </strong><span> <?php echo $block->getSurveyQuestion(); ?></span>
            <div class="list-answer">
                <?php
                     foreach ($block->getAllSurveyAnswer() as $option){
@@ -36,7 +36,7 @@
            </div>
            <div class="actions-toolbar" id="submit-answers">
               <div class="primary">
-                 <a class="action primary continue" href="javascript:void(0)"><span><?php /* @escapeNotVerified */ echo __('Submit Answers') ?></span></a>
+                 <a class="action primary continue" href="javascript:void(0)"><span>Submit Answers</span></a>
               </div>
            </div>
         </div>
diff --git a/view/frontend/templates/order/additional.phtml b/view/frontend/templates/order/additional.phtml
index ddbab50..d9abd76 100644
--- a/view/frontend/templates/order/additional.phtml
+++ b/view/frontend/templates/order/additional.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/templates/order/view/comment.phtml b/view/frontend/templates/order/view/comment.phtml
index d364818..80f6faf 100644
--- a/view/frontend/templates/order/view/comment.phtml
+++ b/view/frontend/templates/order/view/comment.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/order/view/delivery-time.phtml b/view/frontend/templates/order/view/delivery-time.phtml
index ae3b255..9d9f2ac 100644
--- a/view/frontend/templates/order/view/delivery-time.phtml
+++ b/view/frontend/templates/order/view/delivery-time.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/order/view/survey.phtml b/view/frontend/templates/order/view/survey.phtml
index d79d49b..36f4193 100644
--- a/view/frontend/templates/order/view/survey.phtml
+++ b/view/frontend/templates/order/view/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -26,10 +26,10 @@
     </strong>
     <div class="box-content">
         <div class="question">
-             <strong><?php /* @escapeNotVerified */ echo __('Question') ?>: </strong><span><?php echo $surveyQuestion ?></span>
+             <strong>Question: </strong><span><?php echo $surveyQuestion ?></span>
         </div>
        <div class="answers">
-           <strong><?php /* @escapeNotVerified */ echo __('Answers') ?>: </strong><span><?php echo $surveyAnswers ?></span>
+           <strong>Answers: </strong><span><?php echo $surveyAnswers ?></span>
        </div>
     </div>
 </div>
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index d7eaf8b..056b38d 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/check-email-availability.js b/view/frontend/web/js/action/check-email-availability.js
index c55fc80..012c776 100644
--- a/view/frontend/web/js/action/check-email-availability.js
+++ b/view/frontend/web/js/action/check-email-availability.js
@@ -1,27 +1,12 @@
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
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © Magento, Inc. All rights reserved.
+ * See COPYING.txt for license details.
  */
 
 define([
     'mage/storage',
     'Mageplaza_Osc/js/model/resource-url-manager',
-    'Magento_Checkout/js/model/quote'
+    'Magento_Checkout/js/model/quote',
 ], function (storage, resourceUrlManager, quote) {
     'use strict';
 
diff --git a/view/frontend/web/js/action/gift-message-item.js b/view/frontend/web/js/action/gift-message-item.js
index 39ea521..be65f78 100644
--- a/view/frontend/web/js/action/gift-message-item.js
+++ b/view/frontend/web/js/action/gift-message-item.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -26,38 +26,40 @@ define(
         'Mageplaza_Osc/js/model/gift-message',
         'mage/storage'
     ],
-    function ($,
-              quote,
-              resourceUrlManager,
-              giftMessageModel,
-              storage) {
+    function (
+        $,
+        quote,
+        resourceUrlManager,
+        giftMessageModel,
+        storage
+    ) {
         'use strict';
 
-        var giftMessageItems = window.checkoutConfig.oscConfig.giftMessageOptions.giftMessage.itemLevel,
+        var giftMessageItems =  window.checkoutConfig.oscConfig.giftMessageOptions.giftMessage.itemLevel,
             giftMessageModel = new giftMessageModel();
 
-        return function (data, itemId, remove) {
+        return function (data,itemId,remove) {
             return storage.post(
-                resourceUrlManager.getUrlForGiftMessageItemInformation(quote, itemId),
+                resourceUrlManager.getUrlForGiftMessageItemInformation(quote,itemId),
                 JSON.stringify(data)
             ).done(
                 function (response) {
-                    if (response == true) {
-                        if (remove) {
+                    if(response == true ){
+                        if(remove){
                             delete giftMessageItems[itemId].message;
-                            giftMessageModel.showMessage('success', 'Delete gift message item success.');
+                            giftMessageModel.showMessage('success','Delete gift message item success.');
                             return this;
                         }
                         giftMessageItems[itemId]['message'] = data.gift_message;
-                        giftMessageModel.showMessage('success', 'Update gift message item success.');
+                        giftMessageModel.showMessage('success','Update gift message item success.');
                     }
                 }
             ).fail(
                 function () {
-                    if (remove) {
-                        giftMessageModel.showMessage('error', 'Can not delete gift message item. Please try again!');
+                    if(remove){
+                        giftMessageModel.showMessage('error','Can not delete gift message item. Please try again!');
                     }
-                    giftMessageModel.showMessage('error', 'Can not update gift message item. Please try again!');
+                    giftMessageModel.showMessage('error','Can not update gift message item. Please try again!');
                 }
             )
         };
diff --git a/view/frontend/web/js/action/gift-wrap.js b/view/frontend/web/js/action/gift-wrap.js
index 62408ca..eb6c205 100644
--- a/view/frontend/web/js/action/gift-wrap.js
+++ b/view/frontend/web/js/action/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/payment-total-information.js b/view/frontend/web/js/action/payment-total-information.js
index da2d5a0..1e5b92d 100644
--- a/view/frontend/web/js/action/payment-total-information.js
+++ b/view/frontend/web/js/action/payment-total-information.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -31,16 +31,18 @@ define(
         'Magento_Checkout/js/model/shipping-service',
         'Mageplaza_Osc/js/model/osc-loader'
     ],
-    function ($,
-              quote,
-              resourceUrlManager,
-              storage,
-              errorProcessor,
-              customer,
-              methodConverter,
-              paymentService,
-              shippingService,
-              oscLoader) {
+    function (
+        $,
+        quote,
+        resourceUrlManager,
+        storage,
+        errorProcessor,
+        customer,
+        methodConverter,
+        paymentService,
+        shippingService,
+        oscLoader
+    ) {
         'use strict';
 
         return function () {
diff --git a/view/frontend/web/js/action/place-order-mixins.js b/view/frontend/web/js/action/place-order-mixins.js
index 664da62..cbf064c 100644
--- a/view/frontend/web/js/action/place-order-mixins.js
+++ b/view/frontend/web/js/action/place-order-mixins.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -28,14 +28,14 @@ define([
     return function (placeOrderAction) {
         return wrapper.wrap(placeOrderAction, function (originalAction, paymentData, messageContainer) {
             var deferred = $.Deferred();
-            if (paymentData && paymentData.method === 'braintree_paypal') {
-                setCheckoutInformationAction().done(function () {
-                    originalAction(paymentData, messageContainer).done(function (response) {
+            if(paymentData && paymentData.method === 'braintree_paypal') {
+                setCheckoutInformationAction().done(function() {
+                    originalAction(paymentData, messageContainer).done(function(response) {
                         deferred.resolve(response);
-                    }).fail(function (response) {
+                    }).fail(function(response){
                         deferred.reject(response);
                     })
-                }).fail(function (response) {
+                }).fail(function(response){
                     deferred.reject(response);
                 })
             } else {
diff --git a/view/frontend/web/js/action/set-checkout-information.js b/view/frontend/web/js/action/set-checkout-information.js
index ab284e7..e5a6687 100644
--- a/view/frontend/web/js/action/set-checkout-information.js
+++ b/view/frontend/web/js/action/set-checkout-information.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/set-payment-method.js b/view/frontend/web/js/action/set-payment-method.js
index 51d3b25..08dd87b 100644
--- a/view/frontend/web/js/action/set-payment-method.js
+++ b/view/frontend/web/js/action/set-payment-method.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/update-item.js b/view/frontend/web/js/action/update-item.js
index 5834033..220a266 100644
--- a/view/frontend/web/js/action/update-item.js
+++ b/view/frontend/web/js/action/update-item.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -30,15 +30,17 @@ define(
         'Magento_Checkout/js/model/shipping-service',
         'Mageplaza_Osc/js/model/osc-loader'
     ],
-    function (quote,
-              resourceUrlManager,
-              storage,
-              errorProcessor,
-              customer,
-              methodConverter,
-              paymentService,
-              shippingService,
-              oscLoader) {
+    function (
+        quote,
+        resourceUrlManager,
+        storage,
+        errorProcessor,
+        customer,
+        methodConverter,
+        paymentService,
+        shippingService,
+        oscLoader
+    ) {
         'use strict';
 
         var itemUpdateLoader = ['shipping', 'payment', 'total'];
diff --git a/view/frontend/web/js/model/address/auto-complete.js b/view/frontend/web/js/model/address/auto-complete.js
index f495f60..37645be 100644
--- a/view/frontend/web/js/model/address/auto-complete.js
+++ b/view/frontend/web/js/model/address/auto-complete.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/address/type/google.js b/view/frontend/web/js/model/address/type/google.js
index 4deba02..6624c03 100644
--- a/view/frontend/web/js/model/address/type/google.js
+++ b/view/frontend/web/js/model/address/type/google.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -82,7 +82,7 @@ define([
                 }
 
                 this.autoComplete = new google.maps.places.Autocomplete(this.inputSelector, options);
-                if (isUsedMaterialDesign) {
+                if(isUsedMaterialDesign) {
                     $(this.inputSelector).attr('placeholder', '');
                 }
 
diff --git a/view/frontend/web/js/model/agreement-validator.js b/view/frontend/web/js/model/agreement-validator.js
index bc8c4ce..6bb4203 100644
--- a/view/frontend/web/js/model/agreement-validator.js
+++ b/view/frontend/web/js/model/agreement-validator.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/agreements-assigner.js b/view/frontend/web/js/model/agreements-assigner.js
index 51adb41..d73e3ee 100644
--- a/view/frontend/web/js/model/agreements-assigner.js
+++ b/view/frontend/web/js/model/agreements-assigner.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -39,7 +39,7 @@ define([
         if (!agreementsConfig.isEnabled) {
             return;
         }
-        agreementFormContainer = (show_toc == SHOW_IN_PAYMENT) ? $('.payment-method._active') : $('#co-place-order-agreement');
+        agreementFormContainer = (show_toc == SHOW_IN_PAYMENT) ? $('.payment-method._active') :$('#co-place-order-agreement');
         agreementForm = agreementFormContainer.find('div[data-role=checkout-agreements] input');
 
         agreementData = agreementForm.serializeArray();
diff --git a/view/frontend/web/js/model/braintree-paypal.js b/view/frontend/web/js/model/braintree-paypal.js
index 23b69d0..c772848 100644
--- a/view/frontend/web/js/model/braintree-paypal.js
+++ b/view/frontend/web/js/model/braintree-paypal.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/checkout-data-resolver.js b/view/frontend/web/js/model/checkout-data-resolver.js
index 92e4346..9704097 100644
--- a/view/frontend/web/js/model/checkout-data-resolver.js
+++ b/view/frontend/web/js/model/checkout-data-resolver.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/compatible/amazon-pay.js b/view/frontend/web/js/model/compatible/amazon-pay.js
index 4d6bcc9..be6edb2 100644
--- a/view/frontend/web/js/model/compatible/amazon-pay.js
+++ b/view/frontend/web/js/model/compatible/amazon-pay.js
@@ -14,16 +14,16 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
-define(['ko'], function (ko) {
+define(['ko'], function(ko) {
     'use strict';
     var hasLogin = window.checkoutConfig.oscConfig.isAmazonAccountLoggedIn;
     return {
         isAmazonAccountLoggedIn: ko.observable(hasLogin),
-        setLogin: function (value) {
+        setLogin: function(value){
             return this.isAmazonAccountLoggedIn(value);
         }
     };
diff --git a/view/frontend/web/js/model/gift-message.js b/view/frontend/web/js/model/gift-message.js
index 2eaaa93..781a678 100644
--- a/view/frontend/web/js/model/gift-message.js
+++ b/view/frontend/web/js/model/gift-message.js
@@ -14,12 +14,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
-define(['jquery', 'ko', 'uiElement', 'underscore', 'mage/translate'],
-    function ($, ko, uiElement, _, $t) {
+define(['jquery','ko', 'uiElement', 'underscore','mage/translate'],
+    function ($,ko, uiElement, _, $t) {
         'use strict';
 
         var provider = uiElement();
@@ -74,10 +74,10 @@ define(['jquery', 'ko', 'uiElement', 'underscore', 'mage/translate'],
                  * @param type
                  * @param message
                  */
-                showMessage: function (type, message) {
+                showMessage: function(type, message){
                     var classElement = 'message ' + type;
-                    $('#opc-sidebar .block.items-in-cart').before('<div class=" ' + classElement + '"> <span>' + $t(message) + '</span></div>');
-                    setTimeout(function () {
+                    $('#opc-sidebar .block.items-in-cart').before('<div class=" '+ classElement +'"> <span>'+ $t(message)+'</span></div>');
+                    setTimeout(function(){
                         $('#opc-sidebar .opc-block-summary .message.' + type).remove();
                     }, 3000);
                 }
diff --git a/view/frontend/web/js/model/gift-wrap.js b/view/frontend/web/js/model/gift-wrap.js
index 84719ea..fc0e03a 100644
--- a/view/frontend/web/js/model/gift-wrap.js
+++ b/view/frontend/web/js/model/gift-wrap.js
@@ -14,20 +14,20 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
-define(['ko'], function (ko) {
+define(['ko'], function(ko) {
     'use strict';
     var hasWrap = ko.observable(window.checkoutConfig.oscConfig.giftWrap.hasWrap);
     return {
         hasWrap: hasWrap,
-        getIsWrap: function () {
+        getIsWrap: function() {
             return this.hasWrap();
         },
-        setIsWrap: function (isWrap) {
-            return this.hasWrap(isWrap);
+        setIsWrap: function(isWrap) {
+            return this.hasWrap(isWrap); 
         }
     };
 });
\ No newline at end of file
diff --git a/view/frontend/web/js/model/osc-data.js b/view/frontend/web/js/model/osc-data.js
index edab1b6..86ec39c 100644
--- a/view/frontend/web/js/model/osc-data.js
+++ b/view/frontend/web/js/model/osc-data.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/osc-loader.js b/view/frontend/web/js/model/osc-loader.js
index d474dc4..f932acb 100644
--- a/view/frontend/web/js/model/osc-loader.js
+++ b/view/frontend/web/js/model/osc-loader.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/osc-loader/discount.js b/view/frontend/web/js/model/osc-loader/discount.js
index badffb6..ae87cf2 100644
--- a/view/frontend/web/js/model/osc-loader/discount.js
+++ b/view/frontend/web/js/model/osc-loader/discount.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/payment-service.js b/view/frontend/web/js/model/payment-service.js
index f8114bd..3cdec7f 100644
--- a/view/frontend/web/js/model/payment-service.js
+++ b/view/frontend/web/js/model/payment-service.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/paypal/set-payment-method-mixin.js b/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
index 23b2152..81c3e85 100644
--- a/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
+++ b/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index 7630629..267e34e 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -65,7 +65,7 @@ define(
                 };
                 return this.getUrl(urls, params);
             },
-            getUrlForGiftWrapInformation: function (quote) {
+            getUrlForGiftWrapInformation: function(quote){
                 var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
                 var urls = {
                     'guest': '/guest-carts/:cartId/update-gift-wrap',
@@ -82,11 +82,11 @@ define(
                 };
                 return this.getUrl(urls, params);
             },
-            getUrlForGiftMessageItemInformation: function (quote, itemId) {
+            getUrlForGiftMessageItemInformation: function(quote,itemId){
                 var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
                 var urls = {
-                    'guest': '/guest-carts/:cartId/gift-message/' + itemId,
-                    'customer': '/carts/mine/gift-message/' + itemId
+                    'guest': '/guest-carts/:cartId/gift-message/'+itemId,
+                    'customer': '/carts/mine/gift-message/'+itemId
                 };
                 return this.getUrl(urls, params);
             }
diff --git a/view/frontend/web/js/model/shipping-rate-service.js b/view/frontend/web/js/model/shipping-rate-service.js
index 5a730bd..d8af678 100644
--- a/view/frontend/web/js/model/shipping-rate-service.js
+++ b/view/frontend/web/js/model/shipping-rate-service.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 4c24c30..3e61959 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/shipping-save-processor/checkout.js b/view/frontend/web/js/model/shipping-save-processor/checkout.js
index 42836f8..8ca5125 100644
--- a/view/frontend/web/js/model/shipping-save-processor/checkout.js
+++ b/view/frontend/web/js/model/shipping-save-processor/checkout.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -44,7 +44,8 @@ define(
               methodConverter,
               errorProcessor,
               fullScreenLoader,
-              selectBillingAddressAction) {
+              selectBillingAddressAction
+    ) {
         'use strict';
 
         return {
@@ -52,7 +53,7 @@ define(
                 var payload,
                     addressInformation = {},
                     additionInformation = oscData.getData();
-                if (window.checkoutConfig.oscConfig.giftMessageOptions.isOrderLevelGiftOptionsEnabled) {
+                if(window.checkoutConfig.oscConfig.giftMessageOptions.isOrderLevelGiftOptionsEnabled) {
                     additionInformation.giftMessage = this.saveGiftMessage();
                 }
                 if (!quote.billingAddress()) {
@@ -71,11 +72,11 @@ define(
                 }
 
                 var customAttributes = {};
-                if (_.isObject(quote.billingAddress().customAttributes)) {
+                if(_.isObject(quote.billingAddress().customAttributes)) {
                     _.each(quote.billingAddress().customAttributes, function (attribute, key) {
-                        if (_.isObject(attribute)) {
+                        if(_.isObject(attribute)) {
                             customAttributes[attribute.attribute_code] = attribute.value
-                        } else if (_.isString(attribute)) {
+                        } else if(_.isString(attribute)) {
                             customAttributes[key] = attribute
                         }
                     });
@@ -102,12 +103,12 @@ define(
                     }
                 );
             },
-            saveGiftMessage: function () {
-                var giftMessage = {};
-                if (!$("#osc-gift-message").is(":checked")) $('.gift-options-content').find('input:text,textarea').val('');
-                giftMessage.sender = $("#gift-message-whole-from").val();
-                giftMessage.recipient = $("#gift-message-whole-to").val();
-                giftMessage.message = $("#gift-message-whole-message").val();
+            saveGiftMessage: function(){
+                var giftMessage={};
+                if(!$("#osc-gift-message").is(":checked"))$('.gift-options-content').find('input:text,textarea').val('');
+                giftMessage.sender      = $("#gift-message-whole-from").val();
+                giftMessage.recipient   = $("#gift-message-whole-to").val();
+                giftMessage.message     = $("#gift-message-whole-message").val();
                 return JSON.stringify(giftMessage);
             }
         };
diff --git a/view/frontend/web/js/view/amazon.js b/view/frontend/web/js/view/amazon.js
index d788504..f0751d2 100644
--- a/view/frontend/web/js/view/amazon.js
+++ b/view/frontend/web/js/view/amazon.js
@@ -1,23 +1,3 @@
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
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
 define([
     'uiComponent',
     'jquery',
@@ -27,9 +7,8 @@ define([
     'Mageplaza_Osc/js/action/payment-total-information',
     'Mageplaza_Osc/js/model/compatible/amazon-pay',
     'Magento_Checkout/js/model/quote'
-], function (Component, $, ko, amazonStorage, shippingService, getPaymentTotalInformation, amazonPay, quote) {
+], function (Component,$, ko, amazonStorage, shippingService, getPaymentTotalInformation, amazonPay, quote) {
     'use strict';
-
     return Component.extend({
         defaults: {
             template: 'Amazon_Payment/shipping-address/inline-form',
@@ -38,13 +17,13 @@ define([
         initObservable: function () {
             this._super();
             amazonStorage.isAmazonAccountLoggedIn.subscribe(function (value) {
-                if (value == false) {
+                if(value == false){
                     window.checkoutConfig.oscConfig.isAmazonAccountLoggedIn = value;
                     amazonPay.setLogin(value);
-                    if (!quote.isVirtual()) {
+                    if(!quote.isVirtual()){
                         shippingService.estimateShippingMethod();
                     }
-                    getPaymentTotalInformation();
+                    getPaymentTotalInformation();      
                 }
 
             }, this);
@@ -54,10 +33,8 @@ define([
         manipulateInlineForm: function () {
             if (amazonStorage.isAmazonAccountLoggedIn()) {
                 window.checkoutConfig.oscConfig.isAmazonAccountLoggedIn = true;
-                amazonPay.setLogin(true);
-                setTimeout(function () {
-                    getPaymentTotalInformation();
-                }, 1000);
+                  amazonPay.setLogin(true);
+                  setTimeout(function(){  getPaymentTotalInformation();}, 1000);
             }
         }
     });
diff --git a/view/frontend/web/js/view/authentication.js b/view/frontend/web/js/view/authentication.js
index 69e0530..2fcc0a6 100644
--- a/view/frontend/web/js/view/authentication.js
+++ b/view/frontend/web/js/view/authentication.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -35,8 +35,8 @@ define(
     function ($, ko, Component, loginAction, customer, $t, modal, messageContainer) {
         'use strict';
 
-        var checkoutConfig = window.checkoutConfig;
-        var emailElement = ('.popup-authentication #login-email'),
+        var checkoutConfig  = window.checkoutConfig;
+        var emailElement    = ('.popup-authentication #login-email'),
             passwordElement = ('.popup-authentication #login-password');
 
         return Component.extend({
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 4ac876e..35c20a4 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -204,7 +204,7 @@ define(
 
             saveBillingAddress: function (fieldName) {
                 if (!this.isAddressSameAsShipping()) {
-                    if (!canShowBillingAddress && !this.quoteIsVirtual) {
+                    if (!canShowBillingAddress) {
                         selectBillingAddress(quote.shippingAddress());
                     } else if (this.isAddressFormVisible()) {
                         var addressFlat = addressConverter.formDataProviderToFlatData(
@@ -219,7 +219,6 @@ define(
                         newBillingAddress = createBillingAddress(addressFlat);
 
                         // New address must be selected as a billing address
-                        //
                         selectBillingAddress(newBillingAddress);
                         checkoutData.setSelectedBillingAddress(newBillingAddress.getKey());
                         checkoutData.setNewCustomerBillingAddress(addressFlat);
diff --git a/view/frontend/web/js/view/delivery-time.js b/view/frontend/web/js/view/delivery-time.js
index 7d1fd1a..bfdfc71 100644
--- a/view/frontend/web/js/view/delivery-time.js
+++ b/view/frontend/web/js/view/delivery-time.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -83,7 +83,7 @@ define(
                 }
             },
             canUseHouseSecurityCode: function () {
-                if (!window.checkoutConfig.oscConfig.deliveryTimeOptions.houseSecurityCode) {
+                if(!window.checkoutConfig.oscConfig.deliveryTimeOptions.houseSecurityCode){
                     return true;
                 }
                 return false;
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index 13489f7..7501715 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -97,9 +97,9 @@ define([
         },
 
         triggerLogin: function () {
-            if ($('.osc-authentication-wrapper a.action-auth-toggle').hasClass('osc-authentication-toggle')) {
+            if($('.osc-authentication-wrapper a.action-auth-toggle').hasClass('osc-authentication-toggle')){
                 $('.osc-authentication-toggle').trigger('click');
-            } else {
+            }else{
                 window.location.href = urlBuilder.build("customer/account/login");
             }
         },
@@ -154,7 +154,7 @@ define([
         },
 
         /** Move label element when input has value */
-        hasValue: function () {
+        hasValue: function(){
             if (window.checkoutConfig.oscConfig.isUsedMaterialDesign) {
                 $(customerEmailElement).val() ? $(customerEmailElement).addClass('active') : $(customerEmailElement).removeClass('active');
             }
diff --git a/view/frontend/web/js/view/form/element/region.js b/view/frontend/web/js/view/form/element/region.js
index 366ab2f..6bd970d 100644
--- a/view/frontend/web/js/view/form/element/region.js
+++ b/view/frontend/web/js/view/form/element/region.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/form/element/street.js b/view/frontend/web/js/view/form/element/street.js
index 7218002..c867955 100644
--- a/view/frontend/web/js/view/form/element/street.js
+++ b/view/frontend/web/js/view/form/element/street.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/geoip.js b/view/frontend/web/js/view/geoip.js
index 97eb4aa..17fc975 100644
--- a/view/frontend/web/js/view/geoip.js
+++ b/view/frontend/web/js/view/geoip.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -35,32 +35,32 @@ define(
               checkoutData) {
         'use strict';
 
-        var isEnableGeoIp = window.checkoutConfig.oscConfig.geoIpOptions.isEnableGeoIp,
-            geoIpData = window.checkoutConfig.oscConfig.geoIpOptions.geoIpData;
+        var  isEnableGeoIp = window.checkoutConfig.oscConfig.geoIpOptions.isEnableGeoIp,
+             geoIpData     =  window.checkoutConfig.oscConfig.geoIpOptions.geoIpData;
         return Component.extend({
             initialize: function () {
                 this.initGeoIp();
                 this._super();
                 return this;
             },
-            initGeoIp: function () {
-                if (isEnableGeoIp) {
-                    if (!quote.isVirtual()) {
+            initGeoIp: function(){
+                if(isEnableGeoIp){
+                    if(!quote.isVirtual()){
 
                         /**
                          * Set Geo Ip data to shippingAddress
                          */
-                        if ((!customer.isLoggedIn() && checkoutData.getShippingAddressFromData() == null)
-                            || (customer.isLoggedIn() && checkoutData.getNewCustomerShippingAddress() == null)) {
-                            checkoutData.setShippingAddressFromData(geoIpData);
+                        if((!customer.isLoggedIn() && checkoutData.getShippingAddressFromData() == null)
+                            || (customer.isLoggedIn() && checkoutData.getNewCustomerShippingAddress()== null)){
+                                checkoutData.setShippingAddressFromData(geoIpData);
                         }
-                    } else {
+                    }else{
 
                         /**
                          * Set Geo Ip data to billingAddress
                          */
-                        if ((!customer.isLoggedIn() && checkoutData.getBillingAddressFromData() == null)
-                            || (customer.isLoggedIn() && checkoutData.setNewCustomerBillingAddress() == null)) {
+                        if((!customer.isLoggedIn() && checkoutData.getBillingAddressFromData() == null)
+                            || (customer.isLoggedIn() && checkoutData.setNewCustomerBillingAddress()== null)){
                             checkoutData.setBillingAddressFromData(geoIpData);
                         }
                     }
diff --git a/view/frontend/web/js/view/payment.js b/view/frontend/web/js/view/payment.js
index a264862..6c0148a 100644
--- a/view/frontend/web/js/view/payment.js
+++ b/view/frontend/web/js/view/payment.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -26,16 +26,17 @@ define(
         'Magento_Checkout/js/model/step-navigator',
         'Magento_Checkout/js/model/payment/additional-validators',
         'Mageplaza_Osc/js/model/checkout-data-resolver',
-        'Mageplaza_Osc/js/model/payment-service',
-        'mage/translate'
+        'Mageplaza_Osc/js/model/payment-service'
     ],
-    function (ko,
-              Component,
-              quote,
-              stepNavigator,
-              additionalValidators,
-              oscDataResolver,
-              oscPaymentService) {
+    function (
+        ko,
+        Component,
+        quote,
+        stepNavigator,
+        additionalValidators,
+        oscDataResolver,
+        oscPaymentService
+    ) {
         'use strict';
 
         oscDataResolver.resolveDefaultPaymentMethod();
@@ -65,7 +66,7 @@ define(
 
             validate: function () {
                 if (!quote.paymentMethod()) {
-                    this.errorValidationMessage($.mage.__('Please specify a payment method.'));
+                    this.errorValidationMessage('Please specify a payment method.');
 
                     return false;
                 }
diff --git a/view/frontend/web/js/view/payment/discount.js b/view/frontend/web/js/view/payment/discount.js
index 691ec04..0b81262 100644
--- a/view/frontend/web/js/view/payment/discount.js
+++ b/view/frontend/web/js/view/payment/discount.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js b/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
index 84e9b18..14db60f 100644
--- a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
+++ b/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -24,53 +24,53 @@ define([
     'Mageplaza_Osc/js/model/braintree-paypal',
     'Magento_Checkout/js/model/payment/additional-validators',
     'Magento_Checkout/js/model/quote',
-    'underscore'
+    'underscore',
 ], function ($, setCheckoutInformationAction, braintreePaypalModel, additionalValidators, quote, _) {
     'use strict';
-    return function (BraintreePaypalComponent) {
-        return BraintreePaypalComponent.extend({
-            /**
-             * Set list of observable attributes
-             * @returns {exports.initObservable}
-             */
-            initObservable: function () {
-                var self = this;
+        return function (BraintreePaypalComponent) {
+            return BraintreePaypalComponent.extend({
+                /**
+                 * Set list of observable attributes
+                 * @returns {exports.initObservable}
+                 */
+                initObservable: function () {
+                    var self = this;
 
-                this._super();
-                // for each component initialization need update property
-                this.isReviewRequired = braintreePaypalModel.isReviewRequired;
-                this.customerEmail = braintreePaypalModel.customerEmail;
-                this.active = braintreePaypalModel.active;
+                    this._super();
+                    // for each component initialization need update property
+                    this.isReviewRequired = braintreePaypalModel.isReviewRequired;
+                    this.customerEmail = braintreePaypalModel.customerEmail;
+                    this.active = braintreePaypalModel.active;
 
-                return this;
-            },
-            /**
-             * Get shipping address
-             * @returns {Object}
-             */
-            getShippingAddress: function () {
-                var address = quote.shippingAddress();
-                if (!address) {
-                    address = {};
-                }
-                if (!address.street) {
-                    address.street = ['', ''];
-                }
-                if (address.postcode === null) {
-                    return {};
-                }
+                    return this;
+                },
+                /**
+                 * Get shipping address
+                 * @returns {Object}
+                 */
+                getShippingAddress: function () {
+                    var address = quote.shippingAddress();
+                    if (!address) {
+                        address = {};
+                    }
+                    if (!address.street) {
+                        address.street = ['', ''];
+                    }
+                    if (address.postcode === null) {
+                        return {};
+                    }
 
-                return {
-                    recipientName: address.firstname + ' ' + address.lastname,
-                    streetAddress: address.street[0],
-                    locality: address.city,
-                    countryCodeAlpha2: address.countryId,
-                    postalCode: address.postcode,
-                    region: address.regionCode,
-                    phone: address.telephone,
-                    editable: this.isAllowOverrideShippingAddress()
-                };
-            }
-        })
-    }
+                    return {
+                        recipientName: address.firstname + ' ' + address.lastname,
+                        streetAddress: address.street[0],
+                        locality: address.city,
+                        countryCodeAlpha2: address.countryId,
+                        postalCode: address.postcode,
+                        region: address.regionCode,
+                        phone: address.telephone,
+                        editable: this.isAllowOverrideShippingAddress()
+                    };
+                }
+            })
+        }
 });
\ No newline at end of file
diff --git a/view/frontend/web/js/view/review/addition.js b/view/frontend/web/js/view/review/addition.js
index dbc3c39..a43c1bf 100644
--- a/view/frontend/web/js/view/review/addition.js
+++ b/view/frontend/web/js/view/review/addition.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/gift-message.js b/view/frontend/web/js/view/review/addition/gift-message.js
index 79219ad..ca87fb8 100644
--- a/view/frontend/web/js/view/review/addition/gift-message.js
+++ b/view/frontend/web/js/view/review/addition/gift-message.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/gift-wrap.js b/view/frontend/web/js/view/review/addition/gift-wrap.js
index 1393c1b..97c26a2 100644
--- a/view/frontend/web/js/view/review/addition/gift-wrap.js
+++ b/view/frontend/web/js/view/review/addition/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/newsletter.js b/view/frontend/web/js/view/review/addition/newsletter.js
index 496edcb..7f3703a 100644
--- a/view/frontend/web/js/view/review/addition/newsletter.js
+++ b/view/frontend/web/js/view/review/addition/newsletter.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/checkout-agreements.js b/view/frontend/web/js/view/review/checkout-agreements.js
index 7095d26..825d71d 100644
--- a/view/frontend/web/js/view/review/checkout-agreements.js
+++ b/view/frontend/web/js/view/review/checkout-agreements.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/comment.js b/view/frontend/web/js/view/review/comment.js
index 3311ad1..2a7be1d 100644
--- a/view/frontend/web/js/view/review/comment.js
+++ b/view/frontend/web/js/view/review/comment.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/placeOrder.js b/view/frontend/web/js/view/review/placeOrder.js
index 162b0bd..58ac972 100644
--- a/view/frontend/web/js/view/review/placeOrder.js
+++ b/view/frontend/web/js/view/review/placeOrder.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -27,20 +27,20 @@ define(
         'uiRegistry',
         'Magento_Checkout/js/model/quote',
         'Magento_Checkout/js/model/payment/additional-validators',
-        'Magento_Customer/js/customer-data',
         'Mageplaza_Osc/js/action/set-checkout-information',
         'Mageplaza_Osc/js/model/braintree-paypal'
     ],
-    function ($,
-              _,
-              ko,
-              Component,
-              registry,
-              quote,
-              additionalValidators,
-              customerData,
-              setCheckoutInformationAction,
-              braintreePaypalModel) {
+    function (
+        $,
+        _,
+        ko,
+        Component,
+        registry,
+        quote,
+        additionalValidators,
+        setCheckoutInformationAction,
+        braintreePaypalModel
+    ) {
         "use strict";
 
         return Component.extend({
@@ -76,19 +76,19 @@ define(
 
                 return this;
             },
-            asyncBraintreePaypal: function () {
+            asyncBraintreePaypal: function() {
                 this.processVisiblePlaceOrderButton();
             },
-            isBraintreeNewVersion: function () {
+            isBraintreeNewVersion: function() {
                 var component = this.getBraintreePaypalComponent();
                 return component
                     && typeof component.isReviewRequired == "function"
                     && typeof component.getButtonTitle == "function";
             },
-            processVisiblePlaceOrderButton: function () {
+            processVisiblePlaceOrderButton: function() {
                 this.visibleBraintreeButton(this.checkVisiblePlaceOrderButton());
             },
-            checkVisiblePlaceOrderButton: function () {
+            checkVisiblePlaceOrderButton: function() {
                 return this.getBraintreePaypalComponent()
                     && this.isPaymentBraintreePaypal();
             },
@@ -105,7 +105,7 @@ define(
 
             brainTreePaypalPlaceOrder: function () {
                 var component = this.getBraintreePaypalComponent();
-                if (component && additionalValidators.validate()) {
+                if(component && additionalValidators.validate()) {
                     component.placeOrder.apply(component, arguments);
                 }
 
@@ -114,7 +114,7 @@ define(
 
             brainTreePayWithPayPal: function () {
                 var component = this.getBraintreePaypalComponent();
-                if (component && additionalValidators.validate()) {
+                if(component && additionalValidators.validate()) {
                     component.payWithPayPal.apply(component, arguments);
                 }
 
@@ -125,11 +125,11 @@ define(
                 var deferer = $.when(setCheckoutInformationAction());
 
                 return scrollTop ? deferer.done(function () {
-                    $("body").animate({scrollTop: 0}, "slow");
-                }) : deferer;
+                    $("body").animate({ scrollTop: 0 }, "slow");
+                }): deferer;
             },
 
-            getPaymentPath: function (paymentMethodCode) {
+            getPaymentPath: function(paymentMethodCode) {
                 return 'checkout.steps.billing-step.payment.payments-list.' + paymentMethodCode;
             },
 
@@ -147,7 +147,6 @@ define(
 
             _placeOrder: function () {
                 $(this.selectors.default).trigger('click');
-                customerData.invalidate(['customer']);
             },
 
             isPlaceOrderActionAllowed: function () {
diff --git a/view/frontend/web/js/view/shipping-address/address-renderer/default.js b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
index 50922e9..003e1d4 100644
--- a/view/frontend/web/js/view/shipping-address/address-renderer/default.js
+++ b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/shipping-postnl.js b/view/frontend/web/js/view/shipping-postnl.js
index 02da739..5edd60b 100644
--- a/view/frontend/web/js/view/shipping-postnl.js
+++ b/view/frontend/web/js/view/shipping-postnl.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -24,11 +24,13 @@ define([
     'Magento_Checkout/js/model/quote',
     'Magento_Catalog/js/price-utils',
     'Mageplaza_Osc/js/action/payment-total-information'
-], function ($,
-             State,
-             quote,
-             priceUtils,
-             getPaymentTotalInformation) {
+], function (
+    $,
+    State,
+    quote,
+    priceUtils,
+    getPaymentTotalInformation
+) {
     return function (Shipping) {
         return Shipping.extend({
             initialize: function () {
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index c9a5d25..8d2a9c0 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -39,8 +39,7 @@ define(
         'Mageplaza_Osc/js/model/address/auto-complete',
         'Mageplaza_Osc/js/model/compatible/amazon-pay',
         'Magento_Customer/js/model/address-list',
-        'rjsResolver',
-        'mage/translate'
+        'rjsResolver'
     ],
     function ($,
               _,
@@ -122,7 +121,7 @@ define(
             },
 
             validate: function () {
-                if (this.isAmazonAccountLoggedIn()) {
+                if(this.isAmazonAccountLoggedIn()){
                     return true;
                 }
 
@@ -136,7 +135,7 @@ define(
                     emailValidationResult = customer.isLoggedIn();
 
                 if (!quote.shippingMethod()) {
-                    this.errorValidationMessage($.mage.__('Please specify a shipping method.'));
+                    this.errorValidationMessage('Please specify a shipping method.');
 
                     shippingMethodValidationResult = false;
                 }
diff --git a/view/frontend/web/js/view/summary/gift-wrap.js b/view/frontend/web/js/view/summary/gift-wrap.js
index db4162d..e4b9fe7 100644
--- a/view/frontend/web/js/view/summary/gift-wrap.js
+++ b/view/frontend/web/js/view/summary/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/summary/item/details.js b/view/frontend/web/js/view/summary/item/details.js
index d719bc1..00de90e 100644
--- a/view/frontend/web/js/view/summary/item/details.js
+++ b/view/frontend/web/js/view/summary/item/details.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -38,7 +38,8 @@ define(
               giftMessageItem,
               url,
               $t,
-              modal) {
+              modal
+    ) {
         "use strict";
 
         var products = window.checkoutConfig.quoteItemData,
@@ -49,7 +50,7 @@ define(
             defaults: {
                 template: 'Mageplaza_Osc/container/summary/item/details'
             },
-            giftMessageItemsTitleHover: $t('Gift message item'),
+            giftMessageItemsTitleHover : $t('Gift message item'),
 
             /**
              * Get product url
@@ -78,11 +79,11 @@ define(
                 this.modalWindow = element;
                 var options = {
                     'type': 'popup',
-                    'title': $t('Gift Message Item &#40' + element.title + '&#41'),
+                    'title': $t('Gift Message Item &#40'+ element.title +'&#41'),
                     'modalClass': 'popup-gift-message-item',
                     'responsive': true,
                     'innerScroll': true,
-                    'trigger': '#' + element.id,
+                    'trigger': '#' +element.id ,
                     'buttons': [],
                     'opened': function () {
                         self.loadGiftMessageItem(item_id);
@@ -95,19 +96,19 @@ define(
              * Load exist gift message item from
              * @param itemId
              */
-            loadGiftMessageItem: function (itemId) {
-                $('.popup-gift-message-item._show #item' + itemId).find('input:text,textarea').val('');
-                if (giftMessageOptions.giftMessage.itemLevel[itemId].hasOwnProperty('message')
-                    && typeof giftMessageOptions.giftMessage.itemLevel[itemId]['message'] == 'object') {
+            loadGiftMessageItem: function(itemId){
+                $('.popup-gift-message-item._show #item'+ itemId).find('input:text,textarea').val('');
+                if(giftMessageOptions.giftMessage.itemLevel[itemId].hasOwnProperty('message')
+                    && typeof giftMessageOptions.giftMessage.itemLevel[itemId]['message'] == 'object'){
                     var giftMessageItem = giftMessageOptions.giftMessage.itemLevel[itemId]['message'];
-                    $(this.createSelectorElement(itemId + ' #gift-message-whole-from')).val(giftMessageItem.sender);
-                    $(this.createSelectorElement(itemId + ' #gift-message-whole-to')).val(giftMessageItem.recipient);
-                    $(this.createSelectorElement(itemId + ' #gift-message-whole-message')).val(giftMessageItem.message);
-                    $(this.createSelectorElement(itemId + ' .action.delete')).show();
+                    $(this.createSelectorElement(itemId +' #gift-message-whole-from')).val(giftMessageItem.sender);
+                    $(this.createSelectorElement(itemId +' #gift-message-whole-to')).val(giftMessageItem.recipient);
+                    $(this.createSelectorElement(itemId +' #gift-message-whole-message')).val(giftMessageItem.message);
+                    $(this.createSelectorElement(itemId +' .action.delete')).show();
                     return this;
                 }
 
-                $(this.createSelectorElement(itemId + ' .action.delete')).hide();
+                $(this.createSelectorElement(itemId +' .action.delete')).hide();
             },
 
             /**
@@ -115,44 +116,44 @@ define(
              * @param selector
              * @returns {string}
              */
-            createSelectorElement: function (selector) {
-                return '.popup-gift-message-item._show #item' + selector;
+            createSelectorElement: function(selector){
+                return '.popup-gift-message-item._show #item'+ selector;
             },
 
             /**
              * Update gift message item
              * @param itemId
              */
-            updateGiftMessageItem: function (itemId) {
+            updateGiftMessageItem: function(itemId){
                 var data = {
                     gift_message: {
-                        sender: $(this.createSelectorElement(itemId + ' #gift-message-whole-from')).val(),
-                        recipient: $(this.createSelectorElement(itemId + ' #gift-message-whole-to')).val(),
-                        message: $(this.createSelectorElement(itemId + ' #gift-message-whole-message')).val()
+                        sender:     $(this.createSelectorElement(itemId +' #gift-message-whole-from')).val(),
+                        recipient:  $(this.createSelectorElement(itemId +' #gift-message-whole-to')).val(),
+                        message:    $(this.createSelectorElement(itemId +' #gift-message-whole-message')).val()
                     }
                 };
-                giftMessageItem(data, itemId, false);
+                giftMessageItem(data,itemId ,false);
                 this.closePopup();
             },
             /**
              * Delete gift message item
              * @param itemId
              */
-            deleteGiftMessageItem: function (itemId) {
+            deleteGiftMessageItem: function(itemId){
                 giftMessageItem({
                     gift_message: {
                         sender: '',
                         recipient: '',
-                        message: ''
+                        message:''
                     }
-                }, itemId, true);
+                },itemId,true);
                 this.closePopup();
             },
 
             /**
              * Close popup gift message item
              */
-            closePopup: function () {
+            closePopup: function(){
                 $('.action-close').trigger('click');
             },
 
@@ -161,23 +162,23 @@ define(
              * @param itemId
              * @returns {boolean}
              */
-            isItemAvailable: function (itemId) {
+            isItemAvailable: function(itemId){
                 var isGloballyAvailable,
                     itemConfig;
                 var item = _.find(products, function (product) {
                     return product.item_id == itemId;
                 });
-                if (item.is_virtual == true || !giftMessageOptions.isEnableOscGiftMessageItems) return false;
+                if(item.is_virtual == true || !giftMessageOptions.isEnableOscGiftMessageItems) return false;
 
                 // gift message product configuration must override system configuration
                 isGloballyAvailable = this.getConfigValue('isItemLevelGiftOptionsEnabled');
                 itemConfig = giftMessageOptions.giftMessage.hasOwnProperty('itemLevel')
-                && giftMessageOptions.giftMessage.itemLevel.hasOwnProperty(itemId) ?
+                &&  giftMessageOptions.giftMessage.itemLevel.hasOwnProperty(itemId) ?
                     giftMessageOptions.giftMessage.itemLevel[itemId] : {};
 
                 return itemConfig.hasOwnProperty('is_available') ? itemConfig['is_available'] : isGloballyAvailable;
             },
-            getConfigValue: function (key) {
+            getConfigValue: function(key) {
                 return giftMessageOptions.hasOwnProperty(key) ?
                     giftMessageOptions[key]
                     : false;
diff --git a/view/frontend/web/js/view/survey.js b/view/frontend/web/js/view/survey.js
index 3042efe..4f0f807 100644
--- a/view/frontend/web/js/view/survey.js
+++ b/view/frontend/web/js/view/survey.js
@@ -14,13 +14,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 define([
     'jquery'
-], function ($) {
+], function($) {
     "use strict";
 
     $.widget('mageplaza.survey', {
@@ -28,58 +28,58 @@ define([
             url: ''
         },
 
-        _create: function () {
+        _create: function() {
             this.initObserve();
         },
 
-        initObserve: function () {
+        initObserve: function(){
             var self = this;
 
-            $("#new-answer").blur(function () {
+            $("#new-answer").blur(function(){
                 self.addNewAnswer();
             });
 
-            $('#survey').on('click', '#remove-answer', function () {
+            $('#survey').on('click','#remove-answer',function(){
                 $(this).parent().remove();
                 $('#new-answer').show();
             });
 
-            $("#submit-answers").click(function () {
+            $("#submit-answers").click(function(){
                 self.submitAnswers();
             });
 
         },
 
-        submitAnswers: function () {
+        submitAnswers: function(){
             var self = this;
             var answerChecked = [];
-            $(".list-answer  input:checkbox:checked").each(function () {
+            $(".list-answer  input:checkbox:checked").each(function(){
                 answerChecked.push($(this).parent().next().children('span').text());
             });
-            if (answerChecked.length > 0) {
+            if(answerChecked.length > 0){
                 $.ajax({
-                    method: 'POST',
+                    method : 'POST',
                     url: this.options.url,
                     data: {answerChecked: answerChecked}
-                }).done(function (response) {
-                    if (response.status == 'success') $('.survey-content').hide();
-                    self.addSurveyMessage(response.status, response.message);
+                }).done(function(response) {
+                    if(response.status=='success') $('.survey-content').hide();
+                    self.addSurveyMessage(response.status ,response.message);
                 });
-            } else {
-                self.addSurveyMessage('notice', 'You need to choose answer.')
+            }else{
+                self.addSurveyMessage('notice','You need to choose answer.')
             }
         },
 
-        addNewAnswer: function () {
-            var newAnswer = $('#new-answer').val();
-            if (newAnswer.length > 0) {
-                var d = new Date();
-                $('<div class="survey-answer"><div class="checkbox-survey"><input type="checkbox" value="_' + d.getTime() + ' " checked/></div><div class="option-value"><span>' + newAnswer + '</span></div><span id="remove-answer">X</span></div>').insertBefore(".option-survey-new");
+        addNewAnswer: function(){
+            var newAnswer= $('#new-answer').val();
+            if(newAnswer.length > 0){
+                var d= new Date();
+                $('<div class="survey-answer"><div class="checkbox-survey"><input type="checkbox" value="_' + d.getTime() +' " checked/></div><div class="option-value"><span>' + newAnswer + '</span></div><span id="remove-answer">X</span></div>').insertBefore(".option-survey-new");
                 $('#new-answer').val('').hide();
             }
         },
-        addSurveyMessage: function (type, message) {
-            $("#survey-message").html('<div class="' + type + ' message"><span>' + message + '</span></div>');
+        addSurveyMessage: function(type,message){
+            $("#survey-message").html('<div class="'+ type +' message"><span>'+ message +'</span></div>');
         }
     });
 
diff --git a/view/frontend/web/template/1column.html b/view/frontend/web/template/1column.html
index 9aceb8b..5e21dc7 100644
--- a/view/frontend/web/template/1column.html
+++ b/view/frontend/web/template/1column.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/2columns.html b/view/frontend/web/template/2columns.html
index f779f80..2f7b3f6 100644
--- a/view/frontend/web/template/2columns.html
+++ b/view/frontend/web/template/2columns.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index 0a8e0d4..fb875db 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/3columns.html b/view/frontend/web/template/3columns.html
index 267d2ba..cbb8d62 100644
--- a/view/frontend/web/template/3columns.html
+++ b/view/frontend/web/template/3columns.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index 3af0c98..68a9ebf 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing/checkbox.html b/view/frontend/web/template/container/address/billing/checkbox.html
index 7284d69..056d9fa 100644
--- a/view/frontend/web/template/container/address/billing/checkbox.html
+++ b/view/frontend/web/template/container/address/billing/checkbox.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing/create.html b/view/frontend/web/template/container/address/billing/create.html
index dc33a7a..c6c89c3 100644
--- a/view/frontend/web/template/container/address/billing/create.html
+++ b/view/frontend/web/template/container/address/billing/create.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index 5d8f486..1d41ec0 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping/address-renderer/default.html b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
index 033dbf3..19c6cd6 100644
--- a/view/frontend/web/template/container/address/shipping/address-renderer/default.html
+++ b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping/form.html b/view/frontend/web/template/container/address/shipping/form.html
index b471ccd..be3e0a1 100644
--- a/view/frontend/web/template/container/address/shipping/form.html
+++ b/view/frontend/web/template/container/address/shipping/form.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/authentication.html b/view/frontend/web/template/container/authentication.html
index 95c0f74..1bcc60f 100644
--- a/view/frontend/web/template/container/authentication.html
+++ b/view/frontend/web/template/container/authentication.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -82,7 +82,7 @@
                 <div class="actions-toolbar">
                     <input name="context" type="hidden" value="checkout" />
                     <div class="primary">
-                        <button type="submit" class="action action-login secondary" name="send" id="osc-send2">
+                        <button type="submit" class="action action-login secondary" name="send" id="send2">
                             <span data-bind="i18n: 'Sign In'"></span>
                         </button>
                     </div>
diff --git a/view/frontend/web/template/container/delivery-time.html b/view/frontend/web/template/container/delivery-time.html
index 71ca601..b227586 100644
--- a/view/frontend/web/template/container/delivery-time.html
+++ b/view/frontend/web/template/container/delivery-time.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/email.html b/view/frontend/web/template/container/form/element/email.html
index 21671df..22b2fba 100644
--- a/view/frontend/web/template/container/form/element/email.html
+++ b/view/frontend/web/template/container/form/element/email.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/input.html b/view/frontend/web/template/container/form/element/input.html
index 798c71d..f02ddd9 100644
--- a/view/frontend/web/template/container/form/element/input.html
+++ b/view/frontend/web/template/container/form/element/input.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/street.html b/view/frontend/web/template/container/form/element/street.html
index d98501f..944c2c4 100644
--- a/view/frontend/web/template/container/form/element/street.html
+++ b/view/frontend/web/template/container/form/element/street.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/field.html b/view/frontend/web/template/container/form/field.html
index a785a77..35a4b9b 100644
--- a/view/frontend/web/template/container/form/field.html
+++ b/view/frontend/web/template/container/form/field.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/payment.html b/view/frontend/web/template/container/payment.html
index ec5077a..ef29885 100644
--- a/view/frontend/web/template/container/payment.html
+++ b/view/frontend/web/template/container/payment.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -62,7 +62,7 @@
                 </div>
                 <!-- ko if: errorValidationMessage().length > 0 -->
                 <div class="message notice">
-                    <span><!-- ko i18n: errorValidationMessage()--><!-- /ko --></span>
+                    <span><!-- ko text: errorValidationMessage()--><!-- /ko --></span>
                 </div>
                 <!-- /ko -->
             </fieldset>
diff --git a/view/frontend/web/template/container/payment/discount.html b/view/frontend/web/template/container/payment/discount.html
index 9801aa0..d5570fd 100644
--- a/view/frontend/web/template/container/payment/discount.html
+++ b/view/frontend/web/template/container/payment/discount.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition.html b/view/frontend/web/template/container/review/addition.html
index cc47a25..af3ecca 100644
--- a/view/frontend/web/template/container/review/addition.html
+++ b/view/frontend/web/template/container/review/addition.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/gift-message.html b/view/frontend/web/template/container/review/addition/gift-message.html
index 18efa8f..b540707 100644
--- a/view/frontend/web/template/container/review/addition/gift-message.html
+++ b/view/frontend/web/template/container/review/addition/gift-message.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/gift-wrap.html b/view/frontend/web/template/container/review/addition/gift-wrap.html
index a2f9749..cad553b 100644
--- a/view/frontend/web/template/container/review/addition/gift-wrap.html
+++ b/view/frontend/web/template/container/review/addition/gift-wrap.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/newsletter.html b/view/frontend/web/template/container/review/addition/newsletter.html
index 588a620..b6c1b96 100644
--- a/view/frontend/web/template/container/review/addition/newsletter.html
+++ b/view/frontend/web/template/container/review/addition/newsletter.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/comment.html b/view/frontend/web/template/container/review/comment.html
index f0ef4bb..414b7af 100644
--- a/view/frontend/web/template/container/review/comment.html
+++ b/view/frontend/web/template/container/review/comment.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/discount.html b/view/frontend/web/template/container/review/discount.html
index e60e047..c37cbb0 100644
--- a/view/frontend/web/template/container/review/discount.html
+++ b/view/frontend/web/template/container/review/discount.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/place-order.html b/view/frontend/web/template/container/review/place-order.html
index fe47cae..6170b7b 100644
--- a/view/frontend/web/template/container/review/place-order.html
+++ b/view/frontend/web/template/container/review/place-order.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/shipping.html b/view/frontend/web/template/container/shipping.html
index 0b36827..3e37d7d 100644
--- a/view/frontend/web/template/container/shipping.html
+++ b/view/frontend/web/template/container/shipping.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -144,7 +144,7 @@
                 </div>
                 <!-- ko if: errorValidationMessage().length > 0 -->
                 <div class="message notice">
-                    <span><!-- ko i18n: errorValidationMessage()--><!-- /ko --></span>
+                    <span><!-- ko text: errorValidationMessage()--><!-- /ko --></span>
                 </div>
                 <!-- /ko -->
             </form>
diff --git a/view/frontend/web/template/container/sidebar.html b/view/frontend/web/template/container/sidebar.html
index a3a5495..e673233 100644
--- a/view/frontend/web/template/container/sidebar.html
+++ b/view/frontend/web/template/container/sidebar.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary.html b/view/frontend/web/template/container/summary.html
index fbfcc83..c257aaf 100644
--- a/view/frontend/web/template/container/summary.html
+++ b/view/frontend/web/template/container/summary.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/cart-items.html b/view/frontend/web/template/container/summary/cart-items.html
index 2f34a1b..f958246 100644
--- a/view/frontend/web/template/container/summary/cart-items.html
+++ b/view/frontend/web/template/container/summary/cart-items.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/gift-wrap.html b/view/frontend/web/template/container/summary/gift-wrap.html
index b71933e..e5ae4cb 100644
--- a/view/frontend/web/template/container/summary/gift-wrap.html
+++ b/view/frontend/web/template/container/summary/gift-wrap.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/item/details.html b/view/frontend/web/template/container/summary/item/details.html
index dc2e3b4..ba81c3e 100644
--- a/view/frontend/web/template/container/summary/item/details.html
+++ b/view/frontend/web/template/container/summary/item/details.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
