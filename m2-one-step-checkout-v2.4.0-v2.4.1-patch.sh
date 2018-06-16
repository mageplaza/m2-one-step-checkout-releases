diff --git a/Api/CheckoutManagementInterface.php b/Api/CheckoutManagementInterface.php
index 8095958..550db2f 100644
--- a/Api/CheckoutManagementInterface.php
+++ b/Api/CheckoutManagementInterface.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Api;
 
 /**
@@ -47,13 +46,13 @@ interface CheckoutManagementInterface
      * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
      */
     public function getPaymentTotalInformation($cartId);
-
+ 
     /**
      * @param int $cartId
      * @param bool $isUseGiftWrap
      * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
      */
-    public function updateGiftWrap($cartId, $isUseGiftWrap);
+    public function updateGiftWrap($cartId,$isUseGiftWrap);
 
     /**
      * @param int $cartId
diff --git a/Api/Data/OscDetailsInterface.php b/Api/Data/OscDetailsInterface.php
index 80d26db..dd8c4a7 100644
--- a/Api/Data/OscDetailsInterface.php
+++ b/Api/Data/OscDetailsInterface.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Api\Data;
 
 /**
@@ -28,8 +27,8 @@ namespace Mageplaza\Osc\Api\Data;
 interface OscDetailsInterface
 {
     /**
-     * Constants defined for keys of array, makes typos less likely
-     */
+	 * Constants defined for keys of array, makes typos less likely
+	 */
     const SHIPPING_METHODS = 'shipping_methods';
 
     const PAYMENT_METHODS = 'payment_methods';
diff --git a/Api/GuestCheckoutManagementInterface.php b/Api/GuestCheckoutManagementInterface.php
index 1119992..3e1e25d 100644
--- a/Api/GuestCheckoutManagementInterface.php
+++ b/Api/GuestCheckoutManagementInterface.php
@@ -15,16 +15,15 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Api;
 
 /**
  * Interface for update item information
  * @api
- */
+ */ 
 interface GuestCheckoutManagementInterface
 {
     /**
@@ -53,7 +52,7 @@ interface GuestCheckoutManagementInterface
      * @param bool $isUseGiftWrap
      * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
      */
-    public function updateGiftWrap($cartId, $isUseGiftWrap);
+    public function updateGiftWrap($cartId,$isUseGiftWrap);
 
     /**
      * @param string $cartId
@@ -68,11 +67,4 @@ interface GuestCheckoutManagementInterface
         $customerAttributes = [],
         $additionInformation = []
     );
-
-    /**
-     * @param string $cartId
-     * @param string $email
-     * @return bool
-     */
-    public function saveEmailToQuote($cartId, $email);
 }
diff --git a/Block/Adminhtml/Field/Position.php b/Block/Adminhtml/Field/Position.php
index 8d6826f..8bce1d0 100644
--- a/Block/Adminhtml/Field/Position.php
+++ b/Block/Adminhtml/Field/Position.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Adminhtml\Field;
 
 /**
@@ -27,104 +26,104 @@ namespace Mageplaza\Osc\Block\Adminhtml\Field;
  */
 class Position extends \Magento\Backend\Block\Widget\Container
 {
-    /**
-     * @type \Mageplaza\Osc\Helper\Data
-     */
-    protected $_helper;
+	/**
+	 * @type \Mageplaza\Osc\Helper\Data
+	 */
+	protected $_helper;
 
-    /**
-     * @type array
-     */
-    protected $sortedFields = [];
+	/**
+	 * @type array
+	 */
+	protected $sortedFields = [];
 
-    /**
-     * @type array
-     */
-    protected $availableFields = [];
+	/**
+	 * @type array
+	 */
+	protected $availableFields = [];
 
-    /**
-     * @param \Magento\Backend\Block\Widget\Context $context
-     * @param \Mageplaza\Osc\Helper\Data $helperData
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Backend\Block\Widget\Context $context,
-        \Mageplaza\Osc\Helper\Data $helperData,
-        array $data = []
-    )
-    {
-        $this->_helper = $helperData;
+	/**
+	 * @param \Magento\Backend\Block\Widget\Context $context
+	 * @param \Mageplaza\Osc\Helper\Data $helperData
+	 * @param array $data
+	 */
+	public function __construct(
+		\Magento\Backend\Block\Widget\Context $context,
+		\Mageplaza\Osc\Helper\Data $helperData,
+		array $data = []
+	)
+	{
+		$this->_helper = $helperData;
 
-        parent::__construct($context, $data);
-    }
+		parent::__construct($context, $data);
+	}
 
-    /**
-     * @inheritdoc
-     */
-    protected function _construct()
-    {
-        parent::_construct();
+	/**
+	 * @inheritdoc
+	 */
+	protected function _construct()
+	{
+		parent::_construct();
 
-        $this->addButton(
-            'save',
-            [
-                'label'   => __('Save Position'),
-                'class'   => 'save primary',
-                'onclick' => 'saveOscPosition()'
-            ],
-            1
-        );
+		$this->addButton(
+			'save',
+			[
+				'label'   => __('Save Position'),
+				'class'   => 'save primary',
+				'onclick' => 'saveOscPosition()'
+			],
+			1
+		);
 
-        $this->prepareCollection();
-    }
+		$this->prepareCollection();
+	}
 
-    /**
-     * @return array
-     */
-    public function prepareCollection()
-    {
-        list($this->sortedFields, $this->availableFields) = $this->getHelperData()->getConfig()->getSortedField(false);
-    }
+	/**
+	 * @return array
+	 */
+	public function prepareCollection()
+	{
+		list($this->sortedFields, $this->availableFields) = $this->getHelperData()->getConfig()->getSortedField(false);
+	}
 
-    /**
-     * Retrieve the header text
-     *
-     * @return \Magento\Framework\Phrase|string
-     */
-    public function getHeaderText()
-    {
-        return __('Manage Fields');
-    }
+	/**
+	 * Retrieve the header text
+	 *
+	 * @return \Magento\Framework\Phrase|string
+	 */
+	public function getHeaderText()
+	{
+		return __('Field Management');
+	}
 
-    /**
-     * @return array
-     */
-    public function getSortedFields()
-    {
-        return $this->sortedFields;
-    }
+	/**
+	 * @return array
+	 */
+	public function getSortedFields()
+	{
+		return $this->sortedFields;
+	}
 
-    /**
-     * @return mixed
-     */
-    public function getAvailableFields()
-    {
-        return $this->availableFields;
-    }
+	/**
+	 * @return mixed
+	 */
+	public function getAvailableFields()
+	{
+		return $this->availableFields;
+	}
 
-    /**
-     * @return \Mageplaza\Osc\Helper\Data
-     */
-    public function getHelperData()
-    {
-        return $this->_helper;
-    }
+	/**
+	 * @return \Mageplaza\Osc\Helper\Data
+	 */
+	public function getHelperData()
+	{
+		return $this->_helper;
+	}
 
-    /**
-     * @return string
-     */
-    public function getAjaxUrl()
-    {
-        return $this->getUrl('*/*/save');
-    }
+	/**
+	 * @return string
+	 */
+	public function getAjaxUrl()
+	{
+		return $this->getUrl('*/*/save');
+	}
 }
diff --git a/Block/Adminhtml/Plugin/OrderViewTabInfo.php b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
index 7b6e4fb..1445663 100644
--- a/Block/Adminhtml/Plugin/OrderViewTabInfo.php
+++ b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Adminhtml\Plugin;
 
 /**
diff --git a/Block/Adminhtml/System/Config/Geoip.php b/Block/Adminhtml/System/Config/Geoip.php
index 21be16b..a0f1b9a 100644
--- a/Block/Adminhtml/System/Config/Geoip.php
+++ b/Block/Adminhtml/System/Config/Geoip.php
@@ -16,10 +16,9 @@
  * @category   Mageplaza
  * @package    Mageplaza_Osc
  * @version    3.0.0
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Adminhtml\System\Config;
 
 use Magento\Backend\Block\Template\Context;
@@ -27,97 +26,90 @@ use Magento\Config\Block\System\Config\Form\Field;
 use Magento\Framework\Data\Form\Element\AbstractElement;
 use Mageplaza\Osc\Helper\Data as HelperData;
 
-/**
- * Class Geoip
- * @package Mageplaza\Osc\Block\Adminhtml\System\Config
- */
+
 class Geoip extends Field
 {
-    /**
-     * @var string
-     */
-    protected $_template = 'Mageplaza_Osc::system/config/geoip.phtml';
-
-    /**
-     * @type \Mageplaza\Osc\Helper\Data
-     */
-    protected $_helperData;
+	/**
+	 * @var string
+	 */
+	protected $_template = 'Mageplaza_Osc::system/config/geoip.phtml';
 
-    /**
-     * Geoip constructor.
-     * @param \Magento\Backend\Block\Template\Context $context
-     * @param \Mageplaza\Osc\Helper\Data $helperData
-     * @param array $data
-     */
-    public function __construct(
-        Context $context,
-        HelperData $helperData,
-        array $data = []
-    )
-    {
-        $this->_helperData = $helperData;
-        parent::__construct($context, $data);
-    }
+	/**
+	 * @type \Mageplaza\Osc\Helper\Data
+	 */
+	protected $_helperData;
 
-    /**
-     * Remove scope label
-     *
-     * @param  AbstractElement $element
-     * @return string
-     */
-    public function render(AbstractElement $element)
-    {
-        $element->unsScope()->unsCanUseWebsiteValue()->unsCanUseDefaultValue();
+	/**
+	 * @param Context $context
+	 * @param array $data
+	 */
+	public function __construct(
+		Context $context,
+		HelperData $helperData,
+		array $data = []
+	) {
+		$this->_helperData = $helperData;
+		parent::__construct($context, $data);
+	}
 
-        return parent::render($element);
-    }
+	/**
+	 * Remove scope label
+	 *
+	 * @param  AbstractElement $element
+	 * @return string
+	 */
+	public function render(AbstractElement $element)
+	{
+		$element->unsScope()->unsCanUseWebsiteValue()->unsCanUseDefaultValue();
+		return parent::render($element);
+	}
 
-    /**
-     * Return element html
-     *
-     * @param  AbstractElement $element
-     * @return string
-     */
-    protected function _getElementHtml(AbstractElement $element)
-    {
-        return $this->_toHtml();
-    }
+	/**
+	 * Return element html
+	 *
+	 * @param  AbstractElement $element
+	 * @return string
+	 */
+	protected function _getElementHtml(AbstractElement $element)
+	{
+		return $this->_toHtml();
+	}
 
-    /**
-     * Return ajax url for collect button
-     *
-     * @return string
-     */
-    public function getAjaxUrl()
-    {
-        return $this->getUrl('onestepcheckout/system_config/geoip');
-    }
+	/**
+	 * Return ajax url for collect button
+	 *
+	 * @return string
+	 */
+	public function getAjaxUrl()
+	{
+		return $this->getUrl('onestepcheckout/system_config/geoip');
+	}
 
-    /**
-     * Generate collect button html
-     *
-     * @return string
-     */
-    public function getButtonHtml()
-    {
-        $button = $this->getLayout()->createBlock(
-            'Magento\Backend\Block\Widget\Button'
-        )->setData(
-            [
-                'id'    => 'geoip_button',
-                'label' => __('Download Library'),
-            ]
-        );
+	/**
+	 * Generate collect button html
+	 *
+	 * @return string
+	 */
+	public function getButtonHtml()
+	{
+		$button = $this->getLayout()->createBlock(
+			'Magento\Backend\Block\Widget\Button'
+		)->setData(
+			[
+				'id' => 'geoip_button',
+				'label' => __('Download Library'),
+			]
+		);
 
-        return $button->toHtml();
-    }
+		return $button->toHtml();
+	}
 
-    /**
-     * @return string
-     */
-    public function isDisplayIcon()
-    {
-        return $this->_helperData->checkHasLibrary() ? '' : 'hidden="hidden';
-    }
+	/**
+	 * @return string
+	 */
+	public function isDisplayIcon(){
+		return $this->_helperData->checkHasLibrary() ? '' : 'hidden="hidden';
+	}
 
-}
\ No newline at end of file
+}
+?>
\ No newline at end of file
diff --git a/Block/Checkout/CompatibleConfig.php b/Block/Checkout/CompatibleConfig.php
index cdd1908..38ff574 100644
--- a/Block/Checkout/CompatibleConfig.php
+++ b/Block/Checkout/CompatibleConfig.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -23,10 +23,6 @@ namespace Mageplaza\Osc\Block\Checkout;
 
 use Magento\Framework\View\Element\Template;
 
-/**
- * Class CompatibleConfig
- * @package Mageplaza\Osc\Block\Checkout
- */
 class CompatibleConfig extends Template
 {
     /**
@@ -51,7 +47,6 @@ class CompatibleConfig extends Template
     )
     {
         parent::__construct($context, $data);
-
         $this->_oscConfig = $oscConfig;
     }
 
diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index 089d8d9..fb45521 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -15,18 +15,17 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Checkout;
 
-use Magento\Checkout\Block\Checkout\AttributeMerger;
+use Magento\Framework\App\ObjectManager;
 use Magento\Checkout\Model\Session as CheckoutSession;
+use Mageplaza\Osc\Helper\Config as OscHelper;
 use Magento\Customer\Model\AttributeMetadataDataProvider;
-use Magento\Framework\App\ObjectManager;
 use Magento\Ui\Component\Form\AttributeMapper;
-use Mageplaza\Osc\Helper\Config as OscHelper;
+use Magento\Checkout\Block\Checkout\AttributeMerger;
 
 /**
  * Class LayoutProcessor
@@ -34,334 +33,333 @@ use Mageplaza\Osc\Helper\Config as OscHelper;
  */
 class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcessorInterface
 {
-    /**
-     * @type \Mageplaza\Osc\Helper\Config
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
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Mageplaza\Osc\Helper\Config $oscHelper
-     * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
-     * @param \Magento\Ui\Component\Form\AttributeMapper $attributeMapper
-     * @param \Magento\Checkout\Block\Checkout\AttributeMerger $merger
-     */
-    public function __construct(
-        CheckoutSession $checkoutSession,
-        OscHelper $oscHelper,
-        AttributeMetadataDataProvider $attributeMetadataDataProvider,
-        AttributeMapper $attributeMapper,
-        AttributeMerger $merger
-    )
-    {
-        $this->checkoutSession               = $checkoutSession;
-        $this->_oscHelper                    = $oscHelper;
-        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-        $this->attributeMapper               = $attributeMapper;
-        $this->merger                        = $merger;
-    }
-
-    /**
-     * Process js Layout of block
-     *
-     * @param array $jsLayout
-     * @return array
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
-            $fields                                               = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-            ['children']['shipping-address-fieldset']['children'];
-            $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-            ['children']['shipping-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'shippingAddress');
-        }
-
-        /** Billing address fields */
-        if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
-            ['children']['billingAddress']['children']['billing-address-fieldset']['children'])) {
-            $fields                                              = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
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
-     * @return array
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
-            $systemAttribute     = $this->convertElementsToSelect($systemAttribute, $attributesToConvert);
-            $fields              = $this->merger->merge(
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
-     */
-    private function addCustomerAttribute(&$fields, $type)
-    {
-        $attributes      = $this->attributeMetadataDataProvider->loadAttributesCollection(
-            'customer',
-            'customer_account_create'
-        );
-        $addressElements = [];
-        foreach ($attributes as $attribute) {
-            if (!$this->_oscHelper->isCustomerAttributeVisible($attribute)) {
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
-        $fieldPosition = $this->_oscHelper->getAddressFieldPosition();
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
-                $oriClasses                           = isset($field['config']['additionalClasses']) ? $field['config']['additionalClasses'] : '';
-                $field['config']['additionalClasses'] = "{$oriClasses} col-mp mp-{$fieldConfig['colspan']}" . ($fieldConfig['isNewRow'] ? ' mp-clear' : '');
-                $field['sortOrder']                   = $fieldConfig['sortOrder'];
-                if ($code == 'dob') {
-                    $field['options'] = ['yearRange' => '-120y:c+nn', 'maxDate' => '-1d', 'changeMonth' => true, 'changeYear' => true];
-                }
-
-                $this->rewriteTemplate($field);
-            }
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
-            $fields['region_id']['config']['template']  = 'Mageplaza_Osc/container/form/field';
-            foreach ($fields['street']['children'] as $key => $value) {
-                $fields['street']['children'][0]['label']                 = $fields['street']['label'];
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
-            'custom'  => [],
-            'default' => []
-        ];
-        foreach ($attributes as $attribute) {
-            $code    = $attribute->getAttributeCode();
-            $element = $this->attributeMapper->map($attribute);
-            if (isset($element['label'])) {
-                $label            = $element['label'];
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
-            $elements[$code]['dataType']    = 'select';
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
+			if($this->_oscHelper->isUsedMaterialDesign()){
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
+	public function rewriteFieldStreet(&$fields){
+
+		if($this->_oscHelper->isUsedMaterialDesign()){
+			$fields['country_id']['config']['template'] =  'Mageplaza_Osc/container/form/field';
+			$fields['region_id']['config']['template']  =  'Mageplaza_Osc/container/form/field';
+			foreach ($fields['street']['children'] as $key => $value){
+				$fields['street']['children'][0]['label']= $fields['street']['label'];
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
index 00d2d71..341eb58 100644
--- a/Block/Container.php
+++ b/Block/Container.php
@@ -16,10 +16,9 @@
  * @category   Mageplaza
  * @package    Mageplaza_Osc
  * @version    3.0.0
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block;
 
 use Magento\Framework\View\Element\Template;
@@ -31,10 +30,8 @@ use Mageplaza\Osc\Helper\Data as HelperData;
  */
 class Container extends Template
 {
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
     protected $_helperData;
+    protected $_helperConfig;
 
     /**
      * @param \Magento\Framework\View\Element\Template\Context $context
@@ -45,8 +42,8 @@ class Container extends Template
         Template\Context $context,
         HelperData $helperData,
         array $data = []
-    )
-    {
+    ) {
+    
         $this->_helperData = $helperData;
 
         parent::__construct($context, $data);
diff --git a/Block/Design.php b/Block/Design.php
index d4d461f..5a55277 100644
--- a/Block/Design.php
+++ b/Block/Design.php
@@ -15,17 +15,16 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block;
 
-use Magento\Checkout\Model\Session as CheckoutSession;
-use Magento\Framework\View\Design\Theme\ThemeProviderInterface;
+use Mageplaza\Osc\Helper\Config;
 use Magento\Framework\View\Element\Template;
 use Magento\Framework\View\Element\Template\Context;
-use Mageplaza\Osc\Helper\Config;
+use Magento\Framework\View\Design\Theme\ThemeProviderInterface;
+use Magento\Checkout\Model\Session as CheckoutSession;
 
 /**
  * Class Css
@@ -61,14 +60,13 @@ class Design extends Template
         ThemeProviderInterface $themeProviderInterface,
         CheckoutSession $checkoutSession,
         array $data = []
-    )
-    {
-
+    ) {
+    
         parent::__construct($context, $data);
 
-        $this->_helperConfig           = $helperConfig;
-        $this->_themeProviderInterface = $themeProviderInterface;
-        $this->checkoutSession         = $checkoutSession;
+        $this->_helperConfig            = $helperConfig;
+        $this->_themeProviderInterface  = $themeProviderInterface;
+        $this->checkoutSession          = $checkoutSession;
     }
 
     /**
@@ -106,16 +104,14 @@ class Design extends Template
     /**
      * @return string
      */
-    public function getCurrentTheme()
-    {
+    public function getCurrentTheme(){
         return $this->_themeProviderInterface->getThemeById($this->getHelperConfig()->getCurrentThemeId())->getCode();
     }
 
     /**
      * @return bool
      */
-    public function isVirtual()
-    {
-        return $this->checkoutSession->getQuote()->isVirtual();
+    public function isVirtual(){
+       return $this->checkoutSession->getQuote()->isVirtual();
     }
 }
diff --git a/Block/Order/Totals.php b/Block/Order/Totals.php
index 404e706..2fd37ae 100644
--- a/Block/Order/Totals.php
+++ b/Block/Order/Totals.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -30,20 +30,20 @@ use Magento\Framework\View\Element\Template;
  */
 class Totals extends Template
 {
-    /**
-     * Init Totals
-     */
-    public function initTotals()
-    {
-        $totalsBlock = $this->getParentBlock();
-        $source      = $totalsBlock->getSource();
-        if ($source && !empty($source->getOscGiftWrapAmount())) {
-            $totalsBlock->addTotal(new DataObject([
-                'code'  => 'gift_wrap',
-                'field' => 'osc_gift_wrap_amount',
-                'label' => __('Gift Wrap'),
-                'value' => $source->getOscGiftWrapAmount(),
-            ]));
-        }
-    }
+	/**
+	 * Init Totals
+	 */
+	public function initTotals()
+	{
+		$totalsBlock = $this->getParentBlock();
+		$source      = $totalsBlock->getSource();
+		if ($source && !empty($source->getOscGiftWrapAmount())) {
+			$totalsBlock->addTotal(new DataObject([
+				'code'  => 'gift_wrap',
+				'field' => 'osc_gift_wrap_amount',
+				'label' => __('Gift Wrap'),
+				'value' => $source->getOscGiftWrapAmount(),
+			]));
+		}
+	}
 }
diff --git a/Block/Order/View/Comment.php b/Block/Order/View/Comment.php
index 774325e..12ad9b3 100644
--- a/Block/Order/View/Comment.php
+++ b/Block/Order/View/Comment.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza
- * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     http://mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Order\View;
 
 /**
@@ -41,8 +40,8 @@ class Comment extends \Magento\Framework\View\Element\Template
         \Magento\Framework\View\Element\Template\Context $context,
         \Magento\Framework\Registry $registry,
         array $data = []
-    )
-    {
+    ) {
+    
         $this->_coreRegistry = $registry;
 
         parent::__construct($context, $data);
diff --git a/Block/Order/View/DeliveryTime.php b/Block/Order/View/DeliveryTime.php
index c09924a..3264fba 100644
--- a/Block/Order/View/DeliveryTime.php
+++ b/Block/Order/View/DeliveryTime.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza
- * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     http://mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Order\View;
 
 /**
@@ -43,6 +42,7 @@ class DeliveryTime extends \Magento\Framework\View\Element\Template
         array $data = []
     )
     {
+
         $this->_coreRegistry = $registry;
 
         parent::__construct($context, $data);
@@ -62,19 +62,18 @@ class DeliveryTime extends \Magento\Framework\View\Element\Template
         return '';
     }
 
-    /**
-     * Get osc house security code
-     *
-     * @return string
-     */
-    public function getHouseSecurityCode()
-    {
-        if ($order = $this->getOrder()) {
-            return $order->getOscOrderHouseSecurityCode();
-        }
-
-        return '';
-    }
+	/**
+	 * Get osc house security code
+	 *
+	 * @return string
+	 */
+	public function getHouseSecurityCode()
+	{
+		if ($order = $this->getOrder())	{
+			return $order->getOscOrderHouseSecurityCode();
+		}
+		return '';
+	}
 
     /**
      * Get current order
diff --git a/Block/Order/View/Survey.php b/Block/Order/View/Survey.php
index 2c1d732..a7183d9 100644
--- a/Block/Order/View/Survey.php
+++ b/Block/Order/View/Survey.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza
- * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     http://mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Order\View;
 
 /**
@@ -41,16 +40,16 @@ class Survey extends \Magento\Framework\View\Element\Template
         \Magento\Framework\View\Element\Template\Context $context,
         \Magento\Framework\Registry $registry,
         array $data = []
-    )
-    {
+    ) {
+    
         $this->_coreRegistry = $registry;
 
         parent::__construct($context, $data);
     }
 
-    /**
-     * @return string
-     */
+	/**
+	 * @return string
+	 */
     public function getSurveyQuestion()
     {
         if ($order = $this->getOrder()) {
@@ -60,17 +59,17 @@ class Survey extends \Magento\Framework\View\Element\Template
         return '';
     }
 
-    /**
-     * @return string
-     */
-    public function getSurveyAnswers()
-    {
-        if ($order = $this->getOrder()) {
-            return $order->getOscSurveyAnswers();
-        }
+	/**
+	 * @return string
+	 */
+	public function getSurveyAnswers()
+	{
+		if ($order = $this->getOrder()) {
+			return $order->getOscSurveyAnswers();
+		}
 
-        return '';
-    }
+		return '';
+	}
 
     /**
      * Get current order
diff --git a/Block/Plugin/Link.php b/Block/Plugin/Link.php
index 3c3d243..07b9ecc 100644
--- a/Block/Plugin/Link.php
+++ b/Block/Plugin/Link.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block\Plugin;
 
 /**
@@ -35,22 +34,15 @@ class Link
     protected $_request;
 
     /**
-     * @var \Mageplaza\Osc\Helper\Config
-     */
-    protected $configHelper;
-
-    /**
-     * Link constructor.
-     * @param \Magento\Framework\App\RequestInterface $httpRequest
-     * @param \Mageplaza\Osc\Helper\Config $configHelper
+     * @param \Mageplaza\Osc\Helper\Config $systemConfig
      */
     public function __construct(
         \Magento\Framework\App\RequestInterface $httpRequest,
-        \Mageplaza\Osc\Helper\Config $configHelper
-    )
-    {
-        $this->_request     = $httpRequest;
-        $this->configHelper = $configHelper;
+        \Mageplaza\Osc\Helper\Config $systemConfig
+    ) {
+    
+        $this->_request      = $httpRequest;
+        $this->_systemConfig = $systemConfig;
     }
 
     /**
@@ -61,7 +53,7 @@ class Link
      */
     public function beforeGetUrl(\Magento\Framework\Url $subject, $routePath = null, $routeParams = null)
     {
-        if ($this->configHelper->isEnabled() && $routePath == 'checkout' && $this->_request->getFullActionName() != 'checkout_index_index') {
+        if ($this->_systemConfig->isEnabled() && $routePath == 'checkout' && $this->_request->getFullActionName() != 'checkout_index_index') {
             return ['onestepcheckout', $routeParams];
         }
 
diff --git a/Block/Survey.php b/Block/Survey.php
index f862e7c..d68cc3b 100644
--- a/Block/Survey.php
+++ b/Block/Survey.php
@@ -16,15 +16,14 @@
  * @category   Mageplaza
  * @package    Mageplaza_Osc
  * @version    3.0.0
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Block;
 
-use Magento\Checkout\Model\Session;
 use Magento\Framework\View\Element\Template;
 use Mageplaza\Osc\Helper\Data as HelperData;
+use Magento\Checkout\Model\Session;
 
 /**
  * Class Survey
@@ -32,81 +31,75 @@ use Mageplaza\Osc\Helper\Data as HelperData;
  */
 class Survey extends Template
 {
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
-    protected $_helperData;
-
-    /**
-     * @var $_helperConfig
-     */
-    protected $_helperConfig;
+	/**
+	 * @var \Mageplaza\Osc\Helper\Data
+	 */
+	protected $_helperData;
 
-    /**
-     * @var \Magento\Checkout\Model\Session
-     */
-    protected $_checkoutSession;
+	/**
+	 * @var $_helperConfig
+	 */
+	protected $_helperConfig;
 
-    /**
-     * @param \Magento\Framework\View\Element\Template\Context $context
-     * @param \Mageplaza\Osc\Helper\Data $helperData
-     * @param array $data
-     */
-    public function __construct(
-        Template\Context $context,
-        HelperData $helperData,
-        Session $checkoutSession,
-        array $data = []
-    )
-    {
+	/**
+	 * @var \Magento\Checkout\Model\Session
+	 */
+	protected $_checkoutSession;
 
-        $this->_helperData      = $helperData;
-        $this->_checkoutSession = $checkoutSession;
+	/**
+	 * @param \Magento\Framework\View\Element\Template\Context $context
+	 * @param \Mageplaza\Osc\Helper\Data $helperData
+	 * @param array $data
+	 */
+	public function __construct(
+		Template\Context $context,
+		HelperData $helperData,
+		Session $checkoutSession,
+		array $data = []
+	) {
 
-        parent::__construct($context, $data);
-        $this->getLastOrderId();
-    }
+		$this->_helperData 		= $helperData;
+		$this->_checkoutSession = $checkoutSession;
 
-    /**
-     * @return bool
-     */
-    public function isEnableSurvey()
-    {
-        return $this->_helperData->getConfig()->isEnabled() && !$this->_helperData->getConfig()->isDisableSurvey();
-    }
+		parent::__construct($context, $data);
+		$this->getLastOrderId();
+	}
 
-    public function getLastOrderId()
-    {
-        $orderId = $this->_checkoutSession->getLastRealOrder()->getEntityId();
-        $this->_checkoutSession->setOscData(array('survey' => array('orderId' => $orderId)));
-    }
+	/**
+	 * @return bool
+	 */
+	public function isEnableSurvey()
+	{
+		return $this->_helperData->getConfig()->isEnabled() && !$this->_helperData->getConfig()->isDisableSurvey();
+	}
 
-    /**
-     * @return mixed
-     */
-    public function getSurveyQuestion()
-    {
-        return $this->_helperData->getConfig()->getSurveyQuestion();
-    }
+	public function getLastOrderId(){
+		$orderId = $this->_checkoutSession->getLastRealOrder()->getEntityId();
+		$this->_checkoutSession->setOscData(array('survey'=>array('orderId' => $orderId )));
+	}
 
-    /**
-     * @return array
-     */
-    public function getAllSurveyAnswer()
-    {
-        $answers = [];
-        foreach ($this->_helperData->getConfig()->getSurveyAnswers() as $key => $item) {
-            $answers[] = ['id' => $key, 'value' => $item['value']];
-        }
+	/**
+	 * @return mixed
+	 */
+	public function getSurveyQuestion(){
+		return $this->_helperData->getConfig()->getSurveyQuestion();
+	}
 
-        return $answers;
-    }
+	/**
+	 * @return array
+	 */
+	public function getAllSurveyAnswer(){
+		$answers=[];
+		foreach ($this->_helperData->getConfig()->getSurveyAnswers() as $key=>$item){
+			$answers[]=['id'=>$key,'value'=>$item['value']];
+		}
+		return $answers;
+	}
 
-    /**
-     * @return mixed
-     */
-    public function isAllowCustomerAddOtherOption()
-    {
-        return $this->_helperData->getConfig()->isAllowCustomerAddOtherOption();
-    }
+	/**
+	 * @return mixed
+	 */
+	public function isAllowCustomerAddOtherOption(){
+		return $this->_helperData->getConfig()->isAllowCustomerAddOtherOption();
+	}
 }
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index a1c2743..46f63ce 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Controller\Add;
 
 /**
@@ -33,12 +32,11 @@ class Index extends \Magento\Checkout\Controller\Cart\Add
     public function execute()
     {
         $productId = $this->getRequest()->getParam('id') ? $this->getRequest()->getParam('id') : 11;
-        $storeId   = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
-        $product   = $this->productRepository->getById($productId, false, $storeId);
+        $storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
+        $product = $this->productRepository->getById($productId, false, $storeId);
 
         $this->cart->addProduct($product, []);
         $this->cart->save();
-
         return $this->goBack($this->_url->getUrl('onestepcheckout'));
 
     }
diff --git a/Controller/Adminhtml/Field/Position.php b/Controller/Adminhtml/Field/Position.php
index 4429775..15cab58 100644
--- a/Controller/Adminhtml/Field/Position.php
+++ b/Controller/Adminhtml/Field/Position.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Controller\Adminhtml\Field;
 
 /**
@@ -27,42 +26,42 @@ namespace Mageplaza\Osc\Controller\Adminhtml\Field;
  */
 class Position extends \Magento\Backend\App\Action
 {
-    /**
-     * @var \Magento\Framework\View\Result\PageFactory
-     */
-    protected $resultPageFactory;
+	/**
+	 * @var \Magento\Framework\View\Result\PageFactory
+	 */
+	protected $resultPageFactory;
 
-    /**
-     * @param \Magento\Backend\App\Action\Context $context
-     * @param \Magento\Framework\View\Result\PageFactory $resultPageFactory
-     */
-    public function __construct(
-        \Magento\Backend\App\Action\Context $context,
-        \Magento\Framework\View\Result\PageFactory $resultPageFactory
-    )
-    {
-        parent::__construct($context);
-        $this->resultPageFactory = $resultPageFactory;
-    }
+	/**
+	 * @param \Magento\Backend\App\Action\Context $context
+	 * @param \Magento\Framework\View\Result\PageFactory $resultPageFactory
+	 */
+	public function __construct(
+		\Magento\Backend\App\Action\Context $context,
+		\Magento\Framework\View\Result\PageFactory $resultPageFactory
+	)
+	{
+		parent::__construct($context);
+		$this->resultPageFactory = $resultPageFactory;
+	}
 
-    /**
-     * @return \Magento\Framework\View\Result\Page
-     */
-    public function execute()
-    {
-        $resultPage = $this->resultPageFactory->create();
-        /**
-         * Set active menu item
-         */
-        $resultPage->setActiveMenu('Mageplaza_Osc::field_management');
-        $resultPage->getConfig()->getTitle()->prepend(__('Manage Fields'));
+	/**
+	 * @return \Magento\Framework\View\Result\Page
+	 */
+	public function execute()
+	{
+		$resultPage = $this->resultPageFactory->create();
+		/**
+		 * Set active menu item
+		 */
+		$resultPage->setActiveMenu('Mageplaza_Osc::field_management');
+		$resultPage->getConfig()->getTitle()->prepend(__('Field Management'));
 
-        /**
-         * Add breadcrumb item
-         */
-        $resultPage->addBreadcrumb(__('One Step Checkout'), __('One Step Checkout'));
-        $resultPage->addBreadcrumb(__('Manage Fields'), __('Manage Fields'));
+		/**
+		 * Add breadcrumb item
+		 */
+		$resultPage->addBreadcrumb(__('One Step Checkout'), __('One Step Checkout'));
+		$resultPage->addBreadcrumb(__('Field Management'), __('Field Management'));
 
-        return $resultPage;
-    }
+		return $resultPage;
+	}
 }
diff --git a/Controller/Adminhtml/Field/Save.php b/Controller/Adminhtml/Field/Save.php
index 3b0d9ce..3d0794f 100644
--- a/Controller/Adminhtml/Field/Save.php
+++ b/Controller/Adminhtml/Field/Save.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Controller\Adminhtml\Field;
 
 use Magento\Framework\App\Config\ScopeConfigInterface;
@@ -30,61 +29,61 @@ use Mageplaza\Osc\Helper\Config as HelperConfig;
  */
 class Save extends \Magento\Backend\App\Action
 {
-    /**
-     * @var \Magento\Config\Model\ResourceModel\Config
-     */
-    protected $resourceConfig;
+	/**
+	 * @var \Magento\Config\Model\ResourceModel\Config
+	 */
+	protected $resourceConfig;
 
-    /**
-     * Application config
-     *
-     * @var \Magento\Framework\App\Config\ScopeConfigInterface
-     */
-    protected $_appConfig;
+	/**
+	 * Application config
+	 *
+	 * @var \Magento\Framework\App\Config\ScopeConfigInterface
+	 */
+	protected $_appConfig;
 
-    /**
-     * @param \Magento\Backend\App\Action\Context $context
-     * @param \Magento\Config\Model\ResourceModel\Config $resourceConfig
-     * @param \Magento\Framework\App\Config\ReinitableConfigInterface $config
-     */
-    public function __construct(
-        \Magento\Backend\App\Action\Context $context,
-        \Magento\Config\Model\ResourceModel\Config $resourceConfig,
-        \Magento\Framework\App\Config\ReinitableConfigInterface $config
-    )
-    {
-        parent::__construct($context);
+	/**
+	 * @param \Magento\Backend\App\Action\Context $context
+	 * @param \Magento\Config\Model\ResourceModel\Config $resourceConfig
+	 * @param \Magento\Framework\App\Config\ReinitableConfigInterface $config
+	 */
+	public function __construct(
+		\Magento\Backend\App\Action\Context $context,
+		\Magento\Config\Model\ResourceModel\Config $resourceConfig,
+		\Magento\Framework\App\Config\ReinitableConfigInterface $config
+	)
+	{
+		parent::__construct($context);
 
-        $this->resourceConfig = $resourceConfig;
-        $this->_appConfig     = $config;
-    }
+		$this->resourceConfig = $resourceConfig;
+		$this->_appConfig = $config;
+	}
 
-    /**
-     * save position to config
-     */
-    public function execute()
-    {
-        $result = [
-            'success' => false,
-            'message' => __('Error during save field position.')
-        ];
+	/**
+	 * save position to config
+	 */
+	public function execute()
+	{
+		$result = [
+			'success' => false,
+			'message' => __('Error during save field position.')
+		];
 
-        $fields = $this->getRequest()->getParam('fields', false);
-        if ($fields) {
-            $this->resourceConfig->saveConfig(
-                HelperConfig::SORTED_FIELD_POSITION,
-                $fields,
-                ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
-                0
-            );
+		$fields = $this->getRequest()->getParam('fields', false);
+		if ($fields) {
+			$this->resourceConfig->saveConfig(
+				HelperConfig::SORTED_FIELD_POSITION,
+				$fields,
+				ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
+				0
+			);
 
-            // re-init configuration
-            $this->_appConfig->reinit();
+			// re-init configuration
+			$this->_appConfig->reinit();
 
-            $result['success'] = true;
-            $result['message'] = __('All fields have been saved.');
-        }
+			$result['success'] = true;
+			$result['message'] = __('All fields have been saved.');
+		}
 
-        $this->getResponse()->setBody(\Zend_Json::encode($result));
-    }
+		$this->getResponse()->setBody(\Zend_Json::encode($result));
+	}
 }
diff --git a/Controller/Adminhtml/System/Config/Geoip.php b/Controller/Adminhtml/System/Config/Geoip.php
index 6425f95..b2ff11c 100644
--- a/Controller/Adminhtml/System/Config/Geoip.php
+++ b/Controller/Adminhtml/System/Config/Geoip.php
@@ -16,7 +16,7 @@
  * @category   Mageplaza
  * @package    Mageplaza_Osc
  * @version    3.0.0
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -24,85 +24,84 @@ namespace Mageplaza\Osc\Controller\Adminhtml\System\Config;
 
 use Magento\Backend\App\Action;
 use Magento\Backend\App\Action\Context;
-use Magento\Framework\App\Filesystem\DirectoryList;
 use Magento\Framework\Controller\Result\JsonFactory;
-use Mageplaza\Osc\Helper\Config as OscConfig;
+use Magento\Framework\App\Filesystem\DirectoryList;
+use \Mageplaza\Osc\Helper\Config as OscConfig;
 
 class Geoip extends Action
 {
 
-    /**
-     * @type \Magento\Framework\Controller\Result\JsonFactory
-     */
-    protected $resultJsonFactory;
+	/**
+	 * @type \Magento\Framework\Controller\Result\JsonFactory
+	 */
+	protected $resultJsonFactory;
 
-    /**
-     * @type \Magento\Framework\App\Filesystem\DirectoryList
-     */
-    protected $_directoryList;
+	/**
+	 * @type \Magento\Framework\App\Filesystem\DirectoryList
+	 */
+	protected $_directoryList;
 
-    /**
-     * @var OscConfig
-     */
-    protected $_oscConfig;
+	/**
+	 * @var OscConfig
+	 */
+	protected $_oscConfig;
 
 
-    /**
-     * @param Context $context
-     * @param JsonFactory $resultJsonFactory
-     * @param DirectoryList $directoryList
-     * @param OscConfig $config
-     */
-    public function __construct(
-        Context $context,
-        JsonFactory $resultJsonFactory,
-        DirectoryList $directoryList,
-        OscConfig $config
-    )
-    {
-        $this->resultJsonFactory = $resultJsonFactory;
-        $this->_directoryList    = $directoryList;
-        $this->_oscConfig        = $config;
+	/**
+	 * @param Context $context
+	 * @param JsonFactory $resultJsonFactory
+	 * @param DirectoryList $directoryList
+	 * @param OscConfig $config
+	 */
+	public function __construct(
+		Context $context,
+		JsonFactory $resultJsonFactory,
+		DirectoryList $directoryList,
+		OscConfig $config
+	)
+	{
+		$this->resultJsonFactory = $resultJsonFactory;
+		$this->_directoryList = $directoryList;
+		$this->_oscConfig	=	$config;
+		parent::__construct($context);
+	}
 
-        parent::__construct($context);
-    }
 
-    /**
-     * @return $this
-     */
-    public function execute()
-    {
-        $status = false;
-        try {
-            $path = $this->_directoryList->getPath('var') . '/Mageplaza/Osc/GeoIp';
-            if (!file_exists($path)) {
-                mkdir($path, 0777, true);
-            }
-            $folder   = scandir($path, true);
-            $pathFile = $path . '/' . $folder[0] . '/GeoLite2-City.mmdb';
+	public function execute()
+	{
+		$status=false;
+		try {
+			$path = $this->_directoryList->getPath('var').'/Mageplaza/Osc/GeoIp';
+			if (!file_exists($path)) {
+				mkdir($path, 0777, true);
+			}
+			$folder=scandir($path,true);
+			$pathFile= $path.'/'.$folder[0].'/GeoLite2-City.mmdb';
 
-            if (file_exists($pathFile)) {
-                foreach (scandir($path . '/' . $folder[0], true) as $filename) {
-                    if ($filename == '..' || $filename == '.') {
-                        continue;
-                    }
-                    @unlink($path . '/' . $folder[0] . '/' . $filename);
-                }
-                @rmdir($path . '/' . $folder[0]);
-            }
+			if(file_exists($pathFile)){
+				foreach(scandir($path.'/'.$folder[0],true) as $filename){
+					if($filename== '..'|| $filename== '.' ){
+						continue;
+					}
+					@unlink($path.'/'.$folder[0].'/'. $filename);
+				}
+				@rmdir($path.'/'.$folder[0]);
+			}
 
-            file_put_contents($path . '/GeoLite2-City.tar.gz', fopen($this->_oscConfig->getDownloadPath(), 'r'));
-            $phar = new \PharData($path . '/GeoLite2-City.tar.gz');
-            $phar->extractTo($path);
-            $status  = true;
-            $message = __("Download library success!");
-        } catch (\Exception $e) {
-            $message = __("Can't download file. Please try again!");
-        }
+			file_put_contents($path.'/GeoLite2-City.tar.gz', fopen($this->_oscConfig->getDownloadPath(), 'r'));
+			$phar = new \PharData($path.'/GeoLite2-City.tar.gz');
+			$phar->extractTo($path);
+			$status = true;
+			$message = __("Download library success!");
+		} catch (\Exception $e) {
+			echo $e->getMessage();
+			$message = __("Can't download file. Please try again!");
+		}
 
-        /** @var \Magento\Framework\Controller\Result\Json $result */
-        $result = $this->resultJsonFactory->create();
-
-        return $result->setData(['success' => $status, 'message' => $message]);
-    }
+		/** @var \Magento\Framework\Controller\Result\Json $result */
+		$result = $this->resultJsonFactory->create();
+		return $result->setData(['success' => $status, 'message' => $message]);
+	}
 }
+
+?>
\ No newline at end of file
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index 64e5d28..6a5d52b 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Controller\Index;
 
 /**
@@ -27,122 +26,121 @@ namespace Mageplaza\Osc\Controller\Index;
  */
 class Index extends \Magento\Checkout\Controller\Onepage
 {
-    /**
-     * @type \Mageplaza\Osc\Helper\Data
-     */
-    protected $_checkoutHelper;
-
-    /**
-     * @return $this|\Magento\Framework\View\Result\Page
-     */
-    public function execute()
-    {
-        $this->_checkoutHelper = $this->_objectManager->get('Mageplaza\Osc\Helper\Data');
-        if (!$this->_checkoutHelper->isEnabled()) {
-            $this->messageManager->addError(__('One step checkout is turned off.'));
-
-            return $this->resultRedirectFactory->create()->setPath('checkout');
-        }
-
-        $quote = $this->getOnepage()->getQuote();
-        if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
-            return $this->resultRedirectFactory->create()->setPath('checkout/cart');
-        }
-
-        $this->_customerSession->regenerateId();
-        $this->_objectManager->get('Magento\Checkout\Model\Session')->setCartWasUpdated(false);
-        $this->getOnepage()->initCheckout();
-
-        $this->initDefaultMethods($quote);
-
-        $resultPage    = $this->resultPageFactory->create();
-        $checkoutTitle = $this->_checkoutHelper->getConfig()->getCheckoutTitle();
-        $resultPage->getConfig()->getTitle()->set($checkoutTitle);
-
-        return $resultPage;
-    }
-
-    /**
-     * Default shipping/payment method
-     *
-     * @param $quote
-     * @return bool
-     */
-    public function initDefaultMethods($quote)
-    {
-        $shippingAddress = $quote->getShippingAddress();
-        if (!$shippingAddress->getCountryId()) {
-            if (!empty($this->_checkoutHelper->getConfig()->getDefaultCountryId())) {
-                $defaultCountryId = $this->_checkoutHelper->getConfig()->getDefaultCountryId();
-            } else {
-                /**
-                 * Get default country id from Geo Ip or Locale
-                 */
-                if ($this->_checkoutHelper->checkHasLibrary()) {
-                    try {
-                        $ip               = $_SERVER['REMOTE_ADDR'] != '127.0.0.1' ? $_SERVER['REMOTE_ADDR'] : '123.16.189.71';
-                        $data             = $this->_checkoutHelper->getGeoIpData($this->_objectManager->get('Mageplaza\Osc\Model\Geoip\Database\Reader')->city($ip));
-                        $defaultCountryId = $data['country_id'];
-                    } catch (\Exception $e) {
-                        $defaultCountryId = $this->getDefaultCountryFromLocale();
-                    }
-                } else {
-                    $defaultCountryId = $this->getDefaultCountryFromLocale();
-                }
-            }
-            $shippingAddress->setCountryId($defaultCountryId)->setCollectShippingRates(true);
-        }
-
-        $method = null;
-
-        try {
-            $availableMethods = $this->_objectManager->get('Magento\Quote\Api\ShippingMethodManagementInterface')
-                ->getList($quote->getId());
-            if (sizeof($availableMethods) == 1) {
-                $method = array_shift($availableMethods);
-            } else if (!$shippingAddress->getShippingMethod() && sizeof($availableMethods)) {
-                $defaultMethod = array_filter($availableMethods, [$this, 'filterMethod']);
-                if (sizeof($defaultMethod)) {
-                    $method = array_shift($defaultMethod);
-                }
-            }
-
-            if ($method) {
-                $methodCode = $method->getCarrierCode() . '_' . $method->getMethodCode();
-                $this->getOnepage()->saveShippingMethod($methodCode);
-            }
-
-            $this->quoteRepository->save($quote);
-        } catch (\Exception $e) {
-            return false;
-        }
-
-        return true;
-    }
-
-    /**
-     * @param $method
-     * @return bool
-     */
-    public function filterMethod($method)
-    {
-        $defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
-        $methodCode            = $method->getCarrierCode() . '_' . $method->getMethodCode();
-        if ($methodCode == $defaultShippingMethod) {
-            return true;
-        }
-
-        return false;
-    }
-
-    /**
-     * Get  default country id from locale
-     * @return string
-     */
-    public function getDefaultCountryFromLocale()
-    {
-        $locale = $this->_objectManager->get('Magento\Framework\Locale\Resolver')->getLocale();
-
-        return substr($locale, strrpos($locale, "_") + 1);
-    }
+	/**
+	 * @type \Mageplaza\Osc\Helper\Data
+	 */
+	protected $_checkoutHelper;
+
+	/**
+	 *
+	 * @return $this|\Magento\Framework\View\Result\Page
+	 */
+	public function execute()
+	{
+		$this->_checkoutHelper = $this->_objectManager->get('Mageplaza\Osc\Helper\Data');
+		if (!$this->_checkoutHelper->isEnabled()) {
+			$this->messageManager->addError(__('One step checkout is turned off.'));
+
+			return $this->resultRedirectFactory->create()->setPath('checkout');
+		}
+
+		$quote = $this->getOnepage()->getQuote();
+		if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
+			return $this->resultRedirectFactory->create()->setPath('checkout/cart');
+		}
+
+		$this->_customerSession->regenerateId();
+		$this->_objectManager->get('Magento\Checkout\Model\Session')->setCartWasUpdated(false);
+		$this->getOnepage()->initCheckout();
+
+		$this->initDefaultMethods($quote);
+
+		$resultPage = $this->resultPageFactory->create();
+		$checkoutTitle = $this->_checkoutHelper->getConfig()->getCheckoutTitle();
+		$resultPage->getConfig()->getTitle()->set($checkoutTitle);
+
+		return $resultPage;
+	}
+
+	/**
+	 * Default shipping/payment method
+	 *
+	 * @param $quote
+	 * @return bool
+	 */
+	public function initDefaultMethods($quote)
+	{
+		$shippingAddress = $quote->getShippingAddress();
+		if (!$shippingAddress->getCountryId()) {
+			if(!empty($this->_checkoutHelper->getConfig()->getDefaultCountryId())){
+				$defaultCountryId = $this->_checkoutHelper->getConfig()->getDefaultCountryId();
+			}else{
+				/**
+				 * Get default country id from Geo Ip or Locale
+				 */
+				if($this->_checkoutHelper->checkHasLibrary()){
+					try {
+						$ip = $_SERVER['REMOTE_ADDR']!= '127.0.0.1' ? $_SERVER['REMOTE_ADDR'] : '123.16.189.71';
+						$data = $this->_checkoutHelper->getGeoIpData($this->_objectManager->get('Mageplaza\Osc\Model\Geoip\Database\Reader')->city($ip));
+						$defaultCountryId = $data['country_id'];
+					} catch (\Exception $e) {
+						$defaultCountryId = $this->getDefaultCountryFromLocale();
+					}
+				}else{
+					$defaultCountryId = $this->getDefaultCountryFromLocale();
+				}
+			}
+			$shippingAddress->setCountryId($defaultCountryId)->setCollectShippingRates(true);
+		}
+
+		$method = null;
+
+		try {
+			$availableMethods = $this->_objectManager->get('Magento\Quote\Api\ShippingMethodManagementInterface')
+				->getList($quote->getId());
+			if (sizeof($availableMethods) == 1) {
+				$method = array_shift($availableMethods);
+			} else if (!$shippingAddress->getShippingMethod() && sizeof($availableMethods)) {
+				$defaultMethod = array_filter($availableMethods, [$this, 'filterMethod']);
+				if (sizeof($defaultMethod)) {
+					$method = array_shift($defaultMethod);
+				}
+			}
+
+			if ($method) {
+				$methodCode = $method->getCarrierCode() . '_' . $method->getMethodCode();
+				$this->getOnepage()->saveShippingMethod($methodCode);
+			}
+
+			$this->quoteRepository->save($quote);
+		} catch (\Exception $e) {
+			return false;
+		}
+
+		return true;
+	}
+
+	/**
+	 * @param $method
+	 * @return bool
+	 */
+	public function filterMethod($method)
+	{
+		$defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
+		$methodCode            = $method->getCarrierCode() . '_' . $method->getMethodCode();
+		if ($methodCode == $defaultShippingMethod) {
+			return true;
+		}
+
+		return false;
+	}
+
+	/**
+	 * Get  default country id from locale
+	 * @return string
+	 */
+	public function getDefaultCountryFromLocale(){
+		$locale = $this->_objectManager->get('Magento\Framework\Locale\Resolver')->getLocale();
+		return substr($locale, strrpos($locale, "_") + 1);
+	}
 }
diff --git a/Controller/Survey/Save.php b/Controller/Survey/Save.php
index 68cea12..d035fc9 100644
--- a/Controller/Survey/Save.php
+++ b/Controller/Survey/Save.php
@@ -15,94 +15,90 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Controller\Survey;
 
-use Magento\Checkout\Model\Session;
 use Magento\Framework\App\Action\Action;
 use Magento\Framework\App\Action\Context;
 use Magento\Framework\Json\Helper\Data;
+use Magento\Checkout\Model\Session;
 use Magento\Sales\Model\Order;
 use Mageplaza\Osc\Helper\Config as OscConfig;
 
-/**
- * Class Save
- * @package Mageplaza\Osc\Controller\Survey
- */
 class Save extends Action
 {
-    /**
-     * @var \Magento\Framework\Json\Helper\Data
-     */
-    protected $jsonHelper;
 
-    /**
-     * @var \Magento\Checkout\Model\Session
-     */
-    protected $_checkoutSession;
+	/**
+	 * @var \Magento\Framework\Json\Helper\Data
+	 */
+	protected $jsonHelper;
+
+	/**
+	 * @var \Magento\Checkout\Model\Session
+	 */
+	protected $_checkoutSession;
+
+	/**
+	 * @var \Magento\Sales\Model\Order
+	 */
+	protected $_order;
 
-    /**
-     * @var \Magento\Sales\Model\Order
-     */
-    protected $_order;
+	/**
+	 * @var \Mageplaza\Osc\Helper\Config
+	 */
+	protected $oscConfig;
 
-    /**
-     * @var \Mageplaza\Osc\Helper\Config
-     */
-    protected $oscConfig;
+	/**
+	 * Save constructor.
+	 * @param \Magento\Framework\App\Action\Context $context
+	 * @param \Magento\Framework\Json\Helper\Data $jsonHelper
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Magento\Sales\Model\Order $order
+	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
+	 */
+	public function __construct(
+		Context $context,
+		Data $jsonHelper,
+		Session $checkoutSession,
+		Order $order,
+		OscConfig $oscConfig
+	) {
 
-    /**
-     * Save constructor.
-     * @param \Magento\Framework\App\Action\Context $context
-     * @param \Magento\Framework\Json\Helper\Data $jsonHelper
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Magento\Sales\Model\Order $order
-     * @param \Mageplaza\Osc\Helper\Config $oscConfig
-     */
-    public function __construct(
-        Context $context,
-        Data $jsonHelper,
-        Session $checkoutSession,
-        Order $order,
-        OscConfig $oscConfig
-    )
-    {
-        $this->jsonHelper       = $jsonHelper;
-        $this->_checkoutSession = $checkoutSession;
-        $this->_order           = $order;
-        $this->oscConfig        = $oscConfig;
-        parent::__construct($context);
-    }
+		$this->jsonHelper = $jsonHelper;
+		$this->_checkoutSession = $checkoutSession;
+		$this->_order			= $order;
+		$this->oscConfig		= $oscConfig;
+		parent::__construct($context);
+	}
 
-    /**
-     * @return mixed
-     */
-    public function execute()
-    {
-        $response = array();
-        if ($this->getRequest()->getParam('answerChecked') && isset($this->_checkoutSession->getOscData()['survey'])) {
-            try {
-                $order   = $this->_order->load($this->_checkoutSession->getOscData()['survey']['orderId']);
-                $answers = '';
-                foreach ($this->getRequest()->getParam('answerChecked') as $item) {
-                    $answers .= $item . ' - ';
-                }
-                $order->setData('osc_survey_question', $this->oscConfig->getSurveyQuestion());
-                $order->setData('osc_survey_answers', substr($answers, 0, -2));
-                $order->save();
+	/**
+	 * @return mixed
+	 */
+	public function execute()
+	{
+		$response= array();
+		if($this->getRequest()->getParam('answerChecked') && isset( $this->_checkoutSession->getOscData()['survey'])){
+			try{
+				$order= $this->_order->load($this->_checkoutSession->getOscData()['survey']['orderId']);
+				$answers = '';
+				foreach ($this->getRequest()->getParam('answerChecked') as $item){
+					$answers.= $item .' - ';
+				}
+				$order->setData('osc_survey_question', $this->oscConfig->getSurveyQuestion());
+				$order->setData('osc_survey_answers', substr($answers, 0, -2));
+				$order->save();
 
-                $response['status']  = 'success';
-                $response['message'] = 'Thank you for completing our survey!';
-                $this->_checkoutSession->unsOscData();
-            } catch (\Exception $e) {
-                $response['status']  = 'error';
-                $response['message'] = "Can't save survey answer. Please try again! ";
-            }
+				$response['status'] = 'success';
+				$response['message']='Thank you for completing our survey!';
+				$this->_checkoutSession->unsOscData();
+			}catch (\Exception $e){
+				$response['status'] = 'error';
+				$response['message'] = "Can't save survey answer. Please try again! ";
+			}
+		return $this->getResponse()->representJson($this->jsonHelper->jsonEncode($response));
+		}
+	}
 
-            return $this->getResponse()->representJson($this->jsonHelper->jsonEncode($response));
-        }
-    }
 }
diff --git a/Helper/Config.php b/Helper/Config.php
index ee2d06b..0f85d2f 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -37,500 +37,482 @@ use Mageplaza\Osc\Model\System\Config\Source\ComponentPosition;
  */
 class Config extends AbstractData
 {
-    /** Is enable module path */
-    const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
-
-    /** Field position */
-    const SORTED_FIELD_POSITION = 'osc/field/position';
-
-    /** General configuration path */
-    const GENERAL_CONFIGUARATION = 'osc/general';
-
-    /** Display configuration path */
-    const DISPLAY_CONFIGUARATION = 'osc/display_configuration';
-
-    /** Design configuration path */
-    const DESIGN_CONFIGUARATION = 'osc/design_configuration';
-
-    /** Geo configuration path */
-    const GEO_IP_CONFIGUARATION = 'osc/geoip_configuration';
-
-    /** Is enable Geo Ip path */
-    const GEO_IP_IS_ENABLED = 'osc/geoip_configuration/is_enable_geoip';
-
-    /** @var \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory */
-    protected $_addressesFactory;
-
-    /** @var \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory */
-    protected $_customerFactory;
-
-    /** @var \Magento\Customer\Helper\Address */
-    protected $addressHelper;
-
-    /** @var \Magento\Customer\Model\AttributeMetadataDataProvider */
-    private $attributeMetadataDataProvider;
-
-    /**
-     * Config constructor.
-     * @param \Magento\Framework\App\Helper\Context $context
-     * @param \Magento\Framework\ObjectManagerInterface $objectManager
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Customer\Helper\Address $addressHelper
-     * @param \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory $addressesFactory
-     * @param \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory $customerFactory
-     * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
-     */
-    public function __construct(
-        Context $context,
-        ObjectManagerInterface $objectManager,
-        StoreManagerInterface $storeManager,
-        Address $addressHelper,
-        AddressFactory $addressesFactory,
-        CustomerFactory $customerFactory,
-        AttributeMetadataDataProvider $attributeMetadataDataProvider
-    )
-    {
-        parent::__construct($context, $objectManager, $storeManager);
-
-        $this->addressHelper                 = $addressHelper;
-        $this->_addressesFactory             = $addressesFactory;
-        $this->_customerFactory              = $customerFactory;
-        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-    }
-
-    /**
-     * Check the current page is osc
-     *
-     * @param null $store
-     * @return bool
-     */
-    public function isOscPage($store = null)
-    {
-        $moduleEnable = $this->isEnabled($store);
-        $isOscModule  = ($this->_request->getRouteName() == 'onestepcheckout');
-
-        return $moduleEnable && $isOscModule;
-    }
-
-    /**
-     * Is enable module on frontend
-     *
-     * @param null $store
-     * @return bool
-     */
-    public function isEnabled($store = null)
-    {
-        $isModuleOutputEnabled = $this->isModuleOutputEnabled();
-
-        return $isModuleOutputEnabled && $this->getConfigValue(self::GENERAL_IS_ENABLED, $store);
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
-        $sortedField   = $this->getSortedField();
-        foreach ($sortedField as $field) {
-            $fieldPosition[$field->getAttributeCode()] = [
-                'sortOrder' => $field->getSortOrder(),
-                'colspan'   => $field->getColspan(),
-                'isNewRow'  => $field->getIsNewRow()
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
-        $sortedFields    = [];
-        $sortOrder       = 1;
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
-        $isNewRow    = true;
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
-        $code   = $attribute->getAttributeCode();
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
-    /************************ Field Position *************************
-     * @return array|mixed
-     */
-    public function getFieldPosition()
-    {
-        $fields = $this->getConfigValue(self::SORTED_FIELD_POSITION);
-
-        try {
-            $result = \Zend_Json::decode($fields);
-        } catch (\Exception $e) {
-            $result = [];
-        }
-
-        return $result;
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
-    /**
-     * One step checkout page title
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getCheckoutTitle($store = null)
-    {
-        return $this->getGeneralConfig('title', $store) ?: 'One Step Checkout';
-    }
-
-    /************************ General Configuration *************************
-     *
-     * @param      $code
-     * @param null $store
-     * @return mixed
-     */
-    public function getGeneralConfig($code = '', $store = null)
-    {
-        $code = $code ? self::GENERAL_CONFIGUARATION . '/' . $code : self::GENERAL_CONFIGUARATION;
-
-        return $this->getConfigValue($code, $store);
-    }
-
-    /**
-     * One step checkout page description
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getCheckoutDescription($store = null)
-    {
-        return $this->getGeneralConfig('description', $store);
-    }
-
-    /**
-     * Get magento default country
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getDefaultCountryId($store = null)
-    {
-        return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
-    }
-
-    /**
-     * Default shipping method
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getDefaultShippingMethod($store = null)
-    {
-        return $this->getGeneralConfig('default_shipping_method', $store);
-    }
-
-    /**
-     * Default payment method
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getDefaultPaymentMethod($store = null)
-    {
-        return $this->getGeneralConfig('default_payment_method', $store);
-    }
-
-    /**
-     * Allow guest checkout
-     *
-     * @param $quote
-     * @param null $store
-     * @return bool
-     */
-    public function getAllowGuestCheckout($quote, $store = null)
-    {
-        $allowGuestCheckout = boolval($this->getGeneralConfig('allow_guest_checkout', $store));
-
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
-                }
-            }
-        }
-
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
-        return boolval($this->getGeneralConfig('redirect_to_one_step_checkout', $store));
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
-        return boolval($this->getGeneralConfig('show_billing_address', $store));
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
-        return $this->getGeneralConfig('google_api_key', $store);
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
-        return $this->getGeneralConfig('google_specific_country', $store);
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
-        return $this->getGeneralConfig('auto_detect_address', $store);
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
-        $code = $code ? self::DISPLAY_CONFIGUARATION . '/' . $code : self::DISPLAY_CONFIGUARATION;
-
-        return $this->getConfigValue($code, $store);
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
-    }
-
-    /**
-     * Coupon will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function disabledPaymentCoupon($store = null)
-    {
-        return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_PAYMENT;
-    }
-
-    /**
-     * Coupon will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function disabledReviewCoupon($store = null)
-    {
-        return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_REVIEW;
-    }
-
-    /**
-     * Comment will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isDisabledComment($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_comments', $store);
-    }
-
-    /**
-     * @param null $store
-     * @return mixed
-     */
-    public function getShowTOC($store = null)
-    {
-        return $this->getDisplayConfig('show_toc', $store);
-    }
-
-    /**
-     * @param null $store
-     * @return mixed
-     */
-    public function isEnabledTOC($store = null)
-    {
-        return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::NOT_SHOW;
-    }
+	/** Is enable module path */
+	const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
+
+	/** Field position */
+	const SORTED_FIELD_POSITION = 'osc/field/position';
+
+	/** General configuration path */
+	const GENERAL_CONFIGUARATION = 'osc/general';
+
+	/** Display configuration path */
+	const DISPLAY_CONFIGUARATION = 'osc/display_configuration';
+
+	/** Design configuration path */
+	const DESIGN_CONFIGUARATION = 'osc/design_configuration';
+
+	/** Geo configuration path */
+	const GEO_IP_CONFIGUARATION = 'osc/geoip_configuration';
+
+	/** Is enable Geo Ip path */
+	const GEO_IP_IS_ENABLED    = 'osc/geoip_configuration/is_enable_geoip';
+
+	/** @var \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory */
+	protected $_addressesFactory;
+
+	/** @var \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory */
+	protected $_customerFactory;
+
+	/** @var \Magento\Customer\Helper\Address */
+	protected $addressHelper;
+
+	/** @var \Magento\Customer\Model\AttributeMetadataDataProvider */
+	private $attributeMetadataDataProvider;
+
+	/**
+	 * Config constructor.
+	 * @param \Magento\Framework\App\Helper\Context $context
+	 * @param \Magento\Framework\ObjectManagerInterface $objectManager
+	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+	 * @param \Magento\Customer\Helper\Address $addressHelper
+	 * @param \Magento\Customer\Model\ResourceModel\Address\Attribute\CollectionFactory $addressesFactory
+	 * @param \Magento\Customer\Model\ResourceModel\Attribute\CollectionFactory $customerFactory
+	 * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+	 */
+	public function __construct(
+		Context $context,
+		ObjectManagerInterface $objectManager,
+		StoreManagerInterface $storeManager,
+		Address $addressHelper,
+		AddressFactory $addressesFactory,
+		CustomerFactory $customerFactory,
+		AttributeMetadataDataProvider $attributeMetadataDataProvider
+	)
+	{
+		parent::__construct($context, $objectManager, $storeManager);
+
+		$this->addressHelper                 = $addressHelper;
+		$this->_addressesFactory             = $addressesFactory;
+		$this->_customerFactory              = $customerFactory;
+		$this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
+	}
+
+	/**
+	 * Check the current page is osc
+	 *
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isOscPage($store = null)
+	{
+		$moduleEnable = $this->isEnabled($store);
+		$isOscModule  = ($this->_request->getRouteName() == 'onestepcheckout');
+
+		return $moduleEnable && $isOscModule;
+	}
+
+	/**
+	 * Is enable module on frontend
+	 *
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isEnabled($store = null)
+	{
+		$isModuleOutputEnabled = $this->isModuleOutputEnabled();
+
+		return $isModuleOutputEnabled && $this->getConfigValue(self::GENERAL_IS_ENABLED, $store);
+	}
+
+	/**
+	 * Get position to display on one step checkout
+	 *
+	 * @return array
+	 */
+	public function getAddressFieldPosition()
+	{
+		$fieldPosition = [];
+		$sortedField   = $this->getSortedField();
+		foreach ($sortedField as $field) {
+			$fieldPosition[$field->getAttributeCode()] = [
+				'sortOrder' => $field->getSortOrder(),
+				'colspan'   => $field->getColspan(),
+				'isNewRow'  => $field->getIsNewRow()
+			];
+		}
+
+		return $fieldPosition;
+	}
+
+	/**
+	 * Get attribute collection to show on osc and manage field
+	 *
+	 * @param bool|true $onlySorted
+	 * @return array
+	 */
+	public function getSortedField($onlySorted = true)
+	{
+		$availableFields = [];
+		$sortedFields    = [];
+		$sortOrder       = 1;
+
+		/** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
+		$collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
+			'customer_address',
+			'customer_register_address'
+		);
+		foreach ($collection as $key => $field) {
+			if (!$this->isAddressAttributeVisible($field)) {
+				continue;
+			}
+			$availableFields[] = $field;
+		}
+
+		/** @var \Magento\Eav\Api\Data\AttributeInterface[] $collection */
+		$collection = $this->attributeMetadataDataProvider->loadAttributesCollection(
+			'customer',
+			'customer_account_create'
+		);
+		foreach ($collection as $key => $field) {
+			if (!$this->isCustomerAttributeVisible($field)) {
+				continue;
+			}
+			$availableFields[] = $field;
+		}
+
+		$isNewRow    = true;
+		$fieldConfig = $this->getFieldPosition();
+		foreach ($fieldConfig as $field) {
+			foreach ($availableFields as $key => $avField) {
+				if ($field['code'] == $avField->getAttributeCode()) {
+					$avField->setColspan($field['colspan'])
+						->setSortOrder($sortOrder++)
+						->setIsNewRow($isNewRow);
+					$sortedFields[] = $avField;
+					unset($availableFields[$key]);
+
+					$this->checkNewRow($field['colspan'], $isNewRow);
+					break;
+				}
+			}
+		}
+
+		return $onlySorted ? $sortedFields : [$sortedFields, $availableFields];
+	}
+
+	/**
+	 * Check if address attribute can be visible on frontend
+	 *
+	 * @param $attribute
+	 * @return bool|null|string
+	 */
+	public function isAddressAttributeVisible($attribute)
+	{
+		$code   = $attribute->getAttributeCode();
+		$result = $attribute->getIsVisible();
+		switch ($code) {
+			case 'vat_id':
+				$result = $this->addressHelper->isVatAttributeVisible();
+				break;
+			case 'region':
+				$result = false;
+				break;
+		}
+
+		return $result;
+	}
+
+	/**
+	 * Check if customer attribute can be visible on frontend
+	 *
+	 * @param \Magento\Eav\Api\Data\AttributeInterface $attribute
+	 * @return bool|null|string
+	 */
+	public function isCustomerAttributeVisible($attribute)
+	{
+		$code = $attribute->getAttributeCode();
+		if (in_array($code, ['gender', 'taxvat', 'dob'])) {
+			return $attribute->getIsVisible();
+		} else if (!$attribute->getIsUserDefined()) {
+			return false;
+		}
+
+		return true;
+	}
+
+	/************************ Field Position *************************
+	 * @return array|mixed
+	 */
+	public function getFieldPosition()
+	{
+		$fields = $this->getConfigValue(self::SORTED_FIELD_POSITION);
+
+		try {
+			$result = \Zend_Json::decode($fields);
+		} catch (\Exception $e) {
+			$result = [];
+		}
+
+		return $result;
+	}
+
+	/**
+	 * @param $colSpan
+	 * @param $isNewRow
+	 * @return $this
+	 */
+	private function checkNewRow($colSpan, &$isNewRow)
+	{
+		if ($colSpan == 6 && $isNewRow) {
+			$isNewRow = false;
+		} else if ($colSpan == 12 || ($colSpan == 6 && !$isNewRow)) {
+			$isNewRow = true;
+		}
+
+		return $this;
+	}
+
+	/**
+	 * One step checkout page title
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getCheckoutTitle($store = null)
+	{
+		return $this->getGeneralConfig('title', $store) ?: 'One Step Checkout';
+	}
+
+	/************************ General Configuration *************************
+	 *
+	 * @param      $code
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getGeneralConfig($code = '', $store = null)
+	{
+		$code = $code ? self::GENERAL_CONFIGUARATION . '/' . $code : self::GENERAL_CONFIGUARATION;
+
+		return $this->getConfigValue($code, $store);
+	}
+
+	/**
+	 * One step checkout page description
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getCheckoutDescription($store = null)
+	{
+		return $this->getGeneralConfig('description', $store);
+	}
+
+	/**
+	 * Get magento default country
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDefaultCountryId($store = null)
+	{
+		return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
+	}
+
+	/**
+	 * Default shipping method
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDefaultShippingMethod($store = null)
+	{
+		return $this->getGeneralConfig('default_shipping_method', $store);
+	}
+
+	/**
+	 * Default payment method
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDefaultPaymentMethod($store = null)
+	{
+		return $this->getGeneralConfig('default_payment_method', $store);
+	}
+
+	/**
+	 * Allow guest checkout
+	 *
+	 * @param $quote
+	 * @param null $store
+	 * @return bool
+	 */
+	public function getAllowGuestCheckout($quote, $store = null)
+	{
+		$allowGuestCheckout = boolval($this->getGeneralConfig('allow_guest_checkout', $store));
+
+		if ($this->scopeConfig->isSetFlag(
+			\Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver::XML_PATH_DISABLE_GUEST_CHECKOUT,
+			\Magento\Store\Model\ScopeInterface::SCOPE_STORE,
+			$store
+		)
+		) {
+			foreach ($quote->getAllItems() as $item) {
+				if (($product = $item->getProduct())
+					&& $product->getTypeId() == \Magento\Downloadable\Model\Product\Type::TYPE_DOWNLOADABLE
+				) {
+					return false;
+				}
+			}
+		}
+
+		return $allowGuestCheckout;
+	}
+
+	/**
+	 * Redirect To OneStepCheckout
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isRedirectToOneStepCheckout($store = null)
+	{
+		return boolval($this->getGeneralConfig('redirect_to_one_step_checkout', $store));
+	}
+
+	/**
+	 * Show billing address
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getShowBillingAddress($store = null)
+	{
+		return boolval($this->getGeneralConfig('show_billing_address', $store));
+	}
+
+	/**
+	 * Google api key
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getGoogleApiKey($store = null)
+	{
+		return $this->getGeneralConfig('google_api_key', $store);
+	}
+
+	/**
+	 * Google restric country
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getGoogleSpecificCountry($store = null)
+	{
+		return $this->getGeneralConfig('google_specific_country', $store);
+	}
+
+	/**
+	 * Check if the page is https
+	 *
+	 * @return bool
+	 */
+	public function isGoogleHttps()
+	{
+		$isEnable = ($this->getAutoDetectedAddress() == 'google');
+
+		return $isEnable && $this->_request->isSecure();
+	}
+
+	/**
+	 * Get auto detected address
+	 * @param null $store
+	 * @return null|'google'|'pca'
+	 */
+	public function getAutoDetectedAddress($store = null)
+	{
+		return $this->getGeneralConfig('auto_detect_address', $store);
+	}
+
+	/**
+	 * Login link will be hide if this function return true
+	 *
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isDisableAuthentication($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_login_link', $store);
+	}
+
+	/********************************** Display Configuration *********************
+	 *
+	 * @param $code
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDisplayConfig($code = '', $store = null)
+	{
+		$code = $code ? self::DISPLAY_CONFIGUARATION . '/' . $code : self::DISPLAY_CONFIGUARATION;
+
+		return $this->getConfigValue($code, $store);
+	}
+
+	/**
+	 * Item detail will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isDisabledReviewCartSection($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_review_cart_section', $store);
+	}
+
+	/**
+	 * Product image will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isHideProductImage($store = null)
+	{
+		return !$this->getDisplayConfig('is_show_product_image', $store);
+	}
+
+	/**
+	 * Coupon will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function disabledPaymentCoupon($store = null)
+	{
+		return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_PAYMENT;
+	}
+
+	/**
+	 * Coupon will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function disabledReviewCoupon($store = null)
+	{
+		return $this->getDisplayConfig('show_coupon', $store) != ComponentPosition::SHOW_IN_REVIEW;
+	}
+
+	/**
+	 * Comment will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isDisabledComment($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_comments', $store);
+	}
 
 	/**
 	 * Term and condition checkbox in payment block will be hided if this function return 'true'
@@ -543,286 +525,278 @@ class Config extends AbstractData
 		return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_PAYMENT;
 	}
 
-    /**
-     * Term and condition checkbox in review will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function disabledReviewTOC($store = null)
-    {
-        return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_REVIEW;
-    }
-
-    /**
-     * GiftMessage will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isDisabledGiftMessage($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_gift_message', $store);
-    }
-
-    /**
-     * Gift message items
-     * @param null $store
-     * @return bool
-     */
-    public function isEnableGiftMessageItems($store = null)
-    {
-        return (bool)$this->getDisplayConfig('is_enabled_gift_message_items', $store);
-    }
-
-
-    /**
-     * Gift wrap block will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isDisabledGiftWrap($store = null)
-    {
-        $giftWrapEnabled = $this->getDisplayConfig('is_enabled_gift_wrap', $store);
-        $giftWrapAmount  = $this->getOrderGiftwrapAmount();
-
-        return !$giftWrapEnabled || ($giftWrapAmount < 0);
-    }
-
-    /**
-     * Gift wrap amount
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getOrderGiftWrapAmount($store = null)
-    {
-        return doubleval($this->getDisplayConfig('gift_wrap_amount', $store));
-    }
-
-    /**
-     * @return array
-     */
-    public function getGiftWrapConfiguration()
-    {
-        return [
-            'gift_wrap_type'   => $this->getGiftWrapType(),
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
-        $objectManager  = \Magento\Framework\App\ObjectManager::getInstance();
-        $giftWrapAmount = $objectManager->create('Magento\Checkout\Helper\Data')->formatPrice($this->getOrderGiftWrapAmount());
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
-     * Survey Answers
-     * @param null $stores
-     * @return mixed
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
-     * @param null $store
-     * @return mixed
-     */
-    public function getDesignConfig($code = '', $store = null)
-    {
-        $code = $code ? self::DESIGN_CONFIGUARATION . '/' . $code : self::DESIGN_CONFIGUARATION;
-
-        return $this->getConfigValue($code, $store);
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
-    {
-        return boolval($this->getConfigValue(self::GEO_IP_CONFIGUARATION . '/is_enable_geoip', $store));
-    }
-
-    /**
-     * @param null $store
-     * @return mixed
-     */
-    public function getDownloadPath($store = null)
-    {
-        return $this->getConfigValue(self::GEO_IP_CONFIGUARATION . '/download_path', $store);
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
-     * Get current theme id
-     * @return mixed
-     */
-    public function getCurrentThemeId()
-    {
-        return $this->getConfigValue(\Magento\Framework\View\DesignInterface::XML_PATH_THEME_ID);
-    }
+	/**
+	 * Term and condition checkbox in review will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function disabledReviewTOC($store = null)
+	{
+		return $this->getDisplayConfig('show_toc', $store) != ComponentPosition::SHOW_IN_REVIEW;
+	}
+
+	/**
+	 * GiftMessage will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isDisabledGiftMessage($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_gift_message', $store);
+	}
+
+	/**
+	 * Gift message items
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isEnableGiftMessageItems($store = null)
+	{
+		return (bool)$this->getDisplayConfig('is_enabled_gift_message_items', $store);
+	}
+
+
+	/**
+	 * Gift wrap block will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isDisabledGiftWrap($store = null)
+	{
+		$giftWrapEnabled = $this->getDisplayConfig('is_enabled_gift_wrap', $store);
+		$giftWrapAmount  = $this->getOrderGiftwrapAmount();
+
+		return !$giftWrapEnabled || ($giftWrapAmount < 0);
+	}
+
+	/**
+	 * Gift wrap amount
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getOrderGiftWrapAmount($store = null)
+	{
+		return doubleval($this->getDisplayConfig('gift_wrap_amount', $store));
+	}
+
+	/**
+	 * @return array
+	 */
+	public function getGiftWrapConfiguration()
+	{
+		return [
+			'gift_wrap_type'   => $this->getGiftWrapType(),
+			'gift_wrap_amount' => $this->formatGiftWrapAmount()
+		];
+	}
+
+	/**
+	 * Gift wrap type
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getGiftWrapType($store = null)
+	{
+		return $this->getDisplayConfig('gift_wrap_type', $store);
+	}
+
+	/**
+	 * @return mixed
+	 */
+	public function formatGiftWrapAmount()
+	{
+		$objectManager  = \Magento\Framework\App\ObjectManager::getInstance();
+		$giftWrapAmount = $objectManager->create('Magento\Checkout\Helper\Data')->formatPrice($this->getOrderGiftWrapAmount());
+
+		return $giftWrapAmount;
+	}
+
+	/**
+	 * Newsleter block will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isDisabledNewsletter($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_newsletter', $store);
+	}
+
+	/**
+	 * Is newsleter subcribed default
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isSubscribedByDefault($store = null)
+	{
+		return (bool)$this->getDisplayConfig('is_checked_newsletter', $store);
+	}
+
+	/**
+	 * Social Login On Checkout Page
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isDisabledSocialLoginOnCheckout($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_social_login', $store);
+	}
+
+	/**
+	 * Delivery Time
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isDisabledDeliveryTime($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_delivery_time', $store);
+	}
+
+	/**
+	 * House Security Code
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isDisabledHouseSecurityCode($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_house_security_code', $store);
+	}
+
+	/**
+	 * Delivery Time Format
+	 *
+	 * @param null $store
+	 *
+	 * @return string 'dd/mm/yy'|'mm/dd/yy'|'yy/mm/dd'
+	 */
+	public function getDeliveryTimeFormat($store = null)
+	{
+		$deliveryTimeFormat = $this->getDisplayConfig('delivery_time_format', $store);
+
+		return $deliveryTimeFormat ?: \Mageplaza\Osc\Model\System\Config\Source\DeliveryTime::DAY_MONTH_YEAR;
+	}
+
+	/**
+	 * Delivery Time Off
+	 * @param null $store
+	 * @return bool|mixed
+	 */
+	public function getDeliveryTimeOff($store = null)
+	{
+		return $this->getDisplayConfig('delivery_time_off', $store);
+	}
+
+	/**
+	 * Survey
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isDisableSurvey($store = null){
+		return !$this->getDisplayConfig('is_enabled_survey', $store);
+	}
+
+	/**
+	 * Survey Question
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getSurveyQuestion($store = null){
+		return $this->getDisplayConfig('survey_question', $store);
+	}
+
+	/**
+	 * Survey Answers
+	 * @param null $stores
+	 * @return mixed
+	 */
+	public function getSurveyAnswers($stores = null){
+		return unserialize($this->getDisplayConfig('survey_answers',$stores));
+	}
+
+	/**
+	 * Allow Customer Add Other Option
+	 * @param null $stores
+	 * @return mixed
+	 */
+	public function isAllowCustomerAddOtherOption($stores = null){
+		return $this->getDisplayConfig('allow_customer_add_other_option',$stores);
+	}
+
+	/**
+	 * Get layout tempate: 1 or 2 or 3 columns
+	 *
+	 * @param null $store
+	 * @return string
+	 */
+	public function getLayoutTemplate($store = null)
+	{
+		return 'Mageplaza_Osc/' . $this->getDesignConfig('page_layout', $store);
+	}
+
+	/***************************** Design Configuration *****************************
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDesignConfig($code = '', $store = null)
+	{
+		$code = $code ? self::DESIGN_CONFIGUARATION . '/' . $code : self::DESIGN_CONFIGUARATION;
+
+		return $this->getConfigValue($code, $store);
+	}
+
+	/**
+	 * @return bool
+	 */
+	public function isUsedMaterialDesign(){
+		return $this->getDesignConfig('page_design') == 'material' ? true : false;
+	}
+
+	/***************************** GeoIP Configuration *****************************
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isEnableGeoIP($store = null)
+	{
+		return boolval($this->getConfigValue(self::GEO_IP_CONFIGUARATION.'/is_enable_geoip', $store));
+	}
+
+	/**
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDownloadPath($store = null){
+		return $this->getConfigValue(self::GEO_IP_CONFIGUARATION.'/download_path',$store);
+	}
+	/***************************** Compatible Modules *****************************
+	 *
+	 * @return bool
+	 */
+	public function isEnabledMultiSafepay()
+	{
+		return $this->_moduleManager->isOutputEnabled('MultiSafepay_Connect');
+	}
+
+	/**
+	 * @return bool
+	 */
+	public function isEnableModulePostNL()
+	{
+		return $this->isModuleOutputEnabled('TIG_PostNL');
+	}
+
+	/**
+	 * Get current theme id
+	 * @return mixed
+	 */
+	public function getCurrentThemeId(){
+		return $this->getConfigValue(\Magento\Framework\View\DesignInterface::XML_PATH_THEME_ID);
+	}
 }
diff --git a/Helper/Data.php b/Helper/Data.php
index 8f4dada..e12ec9f 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -15,21 +15,21 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Helper;
 
 use Magento\Checkout\Helper\Data as HelperData;
-use Magento\Directory\Model\Region;
-use Magento\Framework\App\Filesystem\DirectoryList;
 use Magento\Framework\App\Helper\Context;
-use Magento\Framework\Locale\Resolver;
+use Magento\Framework\App\ObjectManager;
 use Magento\Framework\ObjectManagerInterface;
 use Magento\Framework\Pricing\PriceCurrencyInterface;
 use Magento\Store\Model\StoreManagerInterface;
 use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
+use Magento\Framework\App\Filesystem\DirectoryList;
+use Magento\Framework\Locale\Resolver;
+use Magento\Directory\Model\Region;
 
 /**
  * Class Data
@@ -37,238 +37,201 @@ use Mageplaza\Core\Helper\AbstractData as AbstractHelper;
  */
 class Data extends AbstractHelper
 {
-    /**
-     * @type \Magento\Checkout\Helper\Data
-     */
-    protected $_helperData;
-
-    /**
-     * @type \Mageplaza\Osc\Helper\Config
-     */
-    protected $_helperConfig;
-
-    /**
-     * @type \Magento\Framework\Pricing\PriceCurrencyInterface
-     */
-    protected $_priceCurrency;
-
-    /**
-     * @type \Magento\Framework\App\Filesystem\DirectoryList
-     */
-    protected $_directoryList;
-
-    /**
-     * @type \Magento\Framework\Locale\Resolver
-     */
-    protected $_resolver;
-
-    /**
-     * @type \Magento\Directory\Model\Region
-     */
-    protected $_region;
-
-    /**
-     * @var bool
-     */
-    protected $_flagOscMethodRegister = false;
-
-    /**
-     * @param Context $context
-     * @param HelperData $helperData
-     * @param StoreManagerInterface $storeManager
-     * @param Config $helperConfig
-     * @param ObjectManagerInterface $objectManager
-     * @param PriceCurrencyInterface $priceCurrency
-     * @param DirectoryList $directoryList
-     * @param Resolver $resolver
-     * @param Region $region
-     */
-    public function __construct(
-        Context $context,
-        HelperData $helperData,
-        StoreManagerInterface $storeManager,
-        Config $helperConfig,
-        ObjectManagerInterface $objectManager,
-        PriceCurrencyInterface $priceCurrency,
-        DirectoryList $directoryList,
-        Resolver $resolver,
-        Region $region
-    )
-    {
-        $this->_helperData    = $helperData;
-        $this->_helperConfig  = $helperConfig;
-        $this->_priceCurrency = $priceCurrency;
-        $this->_directoryList = $directoryList;
-        $this->_resolver      = $resolver;
-        $this->_region        = $region;
-
-        parent::__construct($context, $objectManager, $storeManager);
-    }
-
-    /**
-     * @return \Mageplaza\Osc\Helper\Config
-     */
-    public function getConfig()
-    {
-        return $this->_helperConfig;
-    }
-
-    /**
-     * @param null $store
-     * @return bool
-     */
-    public function isEnabled($store = null)
-    {
-        return $this->getConfig()->isEnabled($store);
-    }
-
-    /**
-     * @param $amount
-     * @param null $store
-     * @return float
-     */
-    public function convertPrice($amount, $store = null)
-    {
-        return $this->_priceCurrency->convert($amount, $store);
-    }
-
-    /**
-     * @param $quote
-     * @return float|int
-     */
-    public function calculateGiftWrapAmount($quote)
-    {
-        $baseOscGiftWrapAmount = $this->getConfig()->getOrderGiftwrapAmount();
-        if ($baseOscGiftWrapAmount < 0.0001) {
-            return 0;
-        }
-
-        $giftWrapType = $this->getConfig()->getGiftWrapType();
-        if ($giftWrapType == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
-            $giftWrapBaseAmount    = $baseOscGiftWrapAmount;
-            $baseOscGiftWrapAmount = 0;
-            foreach ($quote->getAllVisibleItems() as $item) {
-                if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
-                    continue;
-                }
-                $baseOscGiftWrapAmount += $giftWrapBaseAmount * $item->getQty();
-            }
-        }
-
-        return $this->convertPrice($baseOscGiftWrapAmount, $quote->getStore());
-    }
-
-    /**
-     * Check has library at path var/Mageplaza/Osc/GeoIp/
-     * @return bool|string
-     */
-    public function checkHasLibrary()
-    {
-        $path = $this->_directoryList->getPath('var') . '/Mageplaza/Osc/GeoIp';
-        if (!file_exists($path)) return false;
-        $folder   = scandir($path, true);
-        $pathFile = $path . '/' . $folder[0] . '/GeoLite2-City.mmdb';
-        if (!file_exists($pathFile)) return false;
-
-        return $pathFile;
-    }
-
-    /**
-     * @param $data
-     * @return mixed
-     */
-    public function getGeoIpData($data)
-    {
-        $geoIpData['city']       = $this->filterData($data, 'city', 'names');
-        $geoIpData['country_id'] = $this->filterData($data, 'country', 'iso_code', false);
-        if (!empty($this->getRegionId($data, $geoIpData['country_id']))) {
-            $geoIpData['region_id'] = $this->getRegionId($data, $geoIpData['country_id']);
-        } else {
-            $geoIpData['region'] = $this->filterData($data, 'subdivisions', 'names');
-        }
-        if (isset($data['postal'])) {
-            $geoIpData['postcode'] = $this->filterData($data, 'postal', 'code', false);
-        }
-
-        return $geoIpData;
-    }
-
-    /**
-     * Filter GeoIP data
-     * @param $data
-     * @param $field
-     * @param $child
-     * @param bool|true $convert
-     * @return string
-     */
-    public function filterData($data, $field, $child, $convert = true)
-    {
-        $output = '';
-        if (isset($data[$field]) && is_array($data[$field])) {
-            if ($field == 'subdivisions') {
-                foreach ($data[$field][0] as $key => $value) {
-                    $data[$field][$key] = $value;
-                }
-            }
-            if (isset($data[$field][$child])) {
-                if ($convert) {
-                    if (is_array($data[$field][$child])) {
-                        $locale   = $this->_resolver->getLocale();
-                        $language = substr($locale, 0, 2) ? substr($locale, 0, 2) : 'en';
-                        $output   = isset($data[$field][$child][$language]) ? $data[$field][$child][$language] : '';
-                    }
-                } else {
-                    $output = $data[$field][$child];
-                }
-            }
-        }
-
-        return $output;
-    }
-
-    /**
-     * Find region id by Country
-     * @param $data
-     * @param $country
-     * @return mixed
-     */
-    public function getRegionId($data, $country)
-    {
-        $regionId = $this->_region->loadByCode($this->filterData($data, 'subdivisions', 'iso_code', false), $country)->getId();
-
-        return $regionId;
-    }
-
-    /**
-     * @return bool
-     */
-    public function isFlagOscMethodRegister()
-    {
-        return $this->_flagOscMethodRegister;
-    }
-
-    /**
-     * @param bool $flag
-     */
-    public function setFlagOscMethodRegister($flag)
-    {
-        $this->_flagOscMethodRegister = $flag;
-    }
-
-    /**
-     * Address Fields
-     *
-     * @return array
-     */
-    public function getAddressFields()
-    {
-        $fieldPosition = $this->_helperConfig->getAddressFieldPosition();
-
-        $fields = array_keys($fieldPosition);
-        if (!in_array('country_id', $fields)) {
-            array_unshift($fields, 'country_id');
-        }
-
-        return $fields;
-    }
+	/**
+	 * @type \Magento\Checkout\Helper\Data
+	 */
+	protected $_helperData;
+
+	/**
+	 * @type \Mageplaza\Osc\Helper\Config
+	 */
+	protected $_helperConfig;
+
+	/**
+	 * @type \Magento\Framework\Pricing\PriceCurrencyInterface
+	 */
+	protected $_priceCurrency;
+
+	/**
+	 * @type \Magento\Framework\App\Filesystem\DirectoryList
+	 */
+	protected $_directoryList;
+
+	/**
+	 * @type \Magento\Framework\Locale\Resolver
+	 */
+	protected $_resolver;
+
+	/**
+	 * @type \Magento\Directory\Model\Region
+	 */
+	protected $_region;
+
+	/**
+	 * @param Context $context
+	 * @param HelperData $helperData
+	 * @param StoreManagerInterface $storeManager
+	 * @param Config $helperConfig
+	 * @param ObjectManagerInterface $objectManager
+	 * @param PriceCurrencyInterface $priceCurrency
+	 * @param DirectoryList $directoryList
+	 * @param Resolver $resolver
+	 * @param Region $region
+	 */
+	public function __construct(
+		Context $context,
+		HelperData $helperData,
+		StoreManagerInterface $storeManager,
+		Config $helperConfig,
+		ObjectManagerInterface $objectManager,
+		PriceCurrencyInterface $priceCurrency,
+		DirectoryList $directoryList,
+		Resolver $resolver,
+		Region $region
+	)
+	{
+		$this->_helperData   = $helperData;
+		$this->_helperConfig = $helperConfig;
+		$this->_priceCurrency   = $priceCurrency;
+		$this->_directoryList = $directoryList;
+		$this->_resolver      = $resolver;
+		$this->_region        = $region;
+
+
+		parent::__construct($context, $objectManager, $storeManager);
+	}
+
+	/**
+	 * @return \Mageplaza\Osc\Helper\Config
+	 */
+	public function getConfig()
+	{
+		return $this->_helperConfig;
+	}
+
+	/**
+	 * @param null $store
+	 * @return bool
+	 */
+	public function isEnabled($store = null)
+	{
+		return $this->getConfig()->isEnabled($store);
+	}
+
+	/**
+	 * @param $amount
+	 * @param null $store
+	 * @return float
+	 */
+	public function convertPrice($amount, $store = null)
+	{
+		return $this->_priceCurrency->convert($amount, $store);
+	}
+
+	/**
+	 * @param $quote
+	 * @return float|int
+	 */
+	public function calculateGiftWrapAmount($quote)
+	{
+		$baseOscGiftWrapAmount = $this->getConfig()->getOrderGiftwrapAmount();
+		if ($baseOscGiftWrapAmount < 0.0001) {
+			return 0;
+		}
+
+		$giftWrapType = $this->getConfig()->getGiftWrapType();
+		if ($giftWrapType == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
+			$giftWrapBaseAmount    = $baseOscGiftWrapAmount;
+			$baseOscGiftWrapAmount = 0;
+			foreach ($quote->getAllVisibleItems() as $item) {
+				if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
+					continue;
+				}
+				$baseOscGiftWrapAmount += $giftWrapBaseAmount * $item->getQty();
+			}
+		}
+
+		return $this->convertPrice($baseOscGiftWrapAmount, $quote->getStore());
+	}
+
+	/**
+	 * Check has library at path var/Mageplaza/Osc/GeoIp/
+	 * @return bool|string
+	 */
+	public function checkHasLibrary()
+	{
+		$path = $this->_directoryList->getPath('var') . '/Mageplaza/Osc/GeoIp';
+		if (!file_exists($path)) return false;
+		$folder   = scandir($path, true);
+		$pathFile = $path . '/' . $folder[0] . '/GeoLite2-City.mmdb';
+		if (!file_exists($pathFile)) return false;
+
+		return $pathFile;
+	}
+
+	/**
+	 * @param $data
+	 * @return mixed
+	 */
+	public function getGeoIpData($data)
+	{
+		$geoIpData['city']       = $this->filterData($data, 'city', 'names');
+		$geoIpData['country_id'] = $this->filterData($data, 'country', 'iso_code', false);
+		if (!empty($this->getRegionId($data, $geoIpData['country_id']))) {
+			$geoIpData['region_id'] = $this->getRegionId($data, $geoIpData['country_id']);
+		} else {
+			$geoIpData['region'] = $this->filterData($data, 'subdivisions', 'names');
+		}
+		if (isset($data['postal'])) {
+			$geoIpData['postcode'] = $this->filterData($data, 'postal', 'code', false);
+		}
+
+		return $geoIpData;
+	}
+
+	/**
+	 * Filter GeoIP data
+	 * @param $data
+	 * @param $field
+	 * @param $child
+	 * @param bool|true $convert
+	 * @return string
+	 */
+	public function filterData($data, $field, $child, $convert = true)
+	{
+		$output = '';
+		if (isset($data[$field]) && is_array($data[$field])) {
+			if ($field == 'subdivisions') {
+				foreach ($data[$field][0] as $key => $value) {
+					$data[$field][$key] = $value;
+				}
+			}
+			if (isset($data[$field][$child])) {
+				if ($convert) {
+					if (is_array($data[$field][$child])) {
+						$locale   = $this->_resolver->getLocale();
+						$language = substr($locale, 0, 2) ? substr($locale, 0, 2) : 'en';
+						$output   = isset($data[$field][$child][$language]) ? $data[$field][$child][$language] : '';
+					}
+				} else {
+					$output = $data[$field][$child];
+				}
+			}
+		}
+
+		return $output;
+	}
+
+	/**
+	 * Find region id by Country
+	 * @param $data
+	 * @param $country
+	 * @return mixed
+	 */
+	public function getRegionId($data, $country)
+	{
+		$regionId = $this->_region->loadByCode($this->filterData($data, 'subdivisions', 'iso_code', false), $country)->getId();
+
+		return $regionId;
+	}
 }
diff --git a/Model/AgreementsValidator.php b/Model/AgreementsValidator.php
deleted file mode 100644
index 9245eb5..0000000
--- a/Model/AgreementsValidator.php
+++ /dev/null
@@ -1,58 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model;
-
-/**
- * Class AgreementsValidator
- * @package Mageplaza\Osc\Model
- */
-class AgreementsValidator extends \Magento\CheckoutAgreements\Model\AgreementsValidator
-{
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
-    protected $_oscHelperConfig;
-
-    /**
-     * AgreementsValidator constructor.
-     * @param \Mageplaza\Osc\Helper\Config $oscHelperConfig
-     * @param null $list
-     */
-    public function __construct(\Mageplaza\Osc\Helper\Config $oscHelperConfig, $list = null)
-    {
-        parent::__construct($list);
-        $this->_oscHelperConfig = $oscHelperConfig;
-    }
-
-    /**
-     * @param array $agreementIds
-     * @return bool
-     */
-    public function isValid($agreementIds = [])
-    {
-        if (!$this->_oscHelperConfig->isEnabledTOC()) {
-            return true;
-        } else {
-            return parent::isValid($agreementIds);
-        }
-    }
-}
\ No newline at end of file
diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index fb7d17c..bc9d96f 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -15,16 +15,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model;
 
-use Magento\Checkout\Api\Data\ShippingInformationInterface;
-use Magento\Checkout\Api\ShippingInformationManagementInterface;
-use Magento\Checkout\Model\Session;
-use Magento\Customer\Model\Session as CustomerSession;
 use Magento\Framework\Exception\CouldNotSaveException;
 use Magento\Framework\Exception\InputException;
 use Magento\Framework\Exception\NoSuchEntityException;
@@ -33,14 +28,15 @@ use Magento\GiftMessage\Model\GiftMessageManager;
 use Magento\GiftMessage\Model\Message;
 use Magento\Quote\Api\CartRepositoryInterface;
 use Magento\Quote\Api\CartTotalRepositoryInterface;
-use Magento\Quote\Api\Data\AddressInterface;
 use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
-use Magento\Quote\Model\Cart\ShippingMethodConverter;
-use Magento\Quote\Model\Quote;
-use Magento\Quote\Model\Quote\TotalsCollector;
 use Mageplaza\Osc\Api\CheckoutManagementInterface;
 use Mageplaza\Osc\Helper\Config as OscConfig;
+use Mageplaza\Osc\Model\OscDetailsFactory;
+use Magento\Customer\Model\Session as CustomerSession;
+use Magento\Quote\Model\Quote\TotalsCollector;
+use Magento\Quote\Api\Data\AddressInterface;
+use Magento\Quote\Model\Cart\ShippingMethodConverter;
 
 /**
  * Class CheckoutManagement
@@ -48,307 +44,305 @@ use Mageplaza\Osc\Helper\Config as OscConfig;
  */
 class CheckoutManagement implements CheckoutManagementInterface
 {
-    /**
-     * @var CartRepositoryInterface
-     */
-    protected $cartRepository;
-
-    /**
-     * @type \Mageplaza\Osc\Model\OscDetailFactory
-     */
-    protected $oscDetailsFactory;
-
-    /**
-     * @var \Magento\Quote\Api\ShippingMethodManagementInterface
-     */
-    protected $shippingMethodManagement;
-
-    /**
-     * @var \Magento\Quote\Api\PaymentMethodManagementInterface
-     */
-    protected $paymentMethodManagement;
-
-    /**
-     * @var \Magento\Quote\Api\CartTotalRepositoryInterface
-     */
-    protected $cartTotalsRepository;
-
-    /**
-     * Url Builder
-     *
-     * @var \Magento\Framework\UrlInterface
-     */
-    protected $_urlBuilder;
-
-    /**
-     * Checkout session
-     *
-     * @type \Magento\Checkout\Model\Session
-     */
-    protected $checkoutSession;
-
-    /**
-     * @var \Magento\Checkout\Api\ShippingInformationManagementInterface
-     */
-    protected $shippingInformationManagement;
-
-    /**
-     * @type \Mageplaza\Osc\Helper\Config
-     */
-    protected $oscConfig;
-
-    /**
-     * @var Message
-     */
-    protected $giftMessage;
-
-    /**
-     * @var GiftMessageManager
-     */
-    protected $giftMessageManagement;
-
-    /**
-     * @var \Magento\Customer\Model\Session
-     */
-    protected $_customerSession;
-
-    /**
-     * @var \Magento\Quote\Model\Quote\TotalsCollector
-     */
-    protected $_totalsCollector;
-
-    /**
-     * @var \Magento\Quote\Api\Data\AddressInterface
-     */
-    protected $_addressInterface;
-
-    /**
-     * @var \Magento\Quote\Model\Cart\ShippingMethodConverter
-     */
-    protected $_shippingMethodConverter;
-
-    /**
-     * CheckoutManagement constructor.
-     * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
-     * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
-     * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
-     * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
-     * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
-     * @param \Magento\Framework\UrlInterface $urlBuilder
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
-     * @param \Mageplaza\Osc\Helper\Config $oscConfig
-     * @param \Magento\GiftMessage\Model\Message $giftMessage
-     * @param \Magento\GiftMessage\Model\GiftMessageManager $giftMessageManager
-     * @param \Magento\Customer\Model\Session $customerSession
-     * @param \Magento\Quote\Model\Quote\TotalsCollector $totalsCollector
-     * @param \Magento\Quote\Api\Data\AddressInterface $addressInterface
-     * @param \Magento\Quote\Model\Cart\ShippingMethodConverter $shippingMethodConverter
-     */
-    public function __construct(
-        CartRepositoryInterface $cartRepository,
-        OscDetailsFactory $oscDetailsFactory,
-        ShippingMethodManagementInterface $shippingMethodManagement,
-        PaymentMethodManagementInterface $paymentMethodManagement,
-        CartTotalRepositoryInterface $cartTotalsRepository,
-        UrlInterface $urlBuilder,
-        Session $checkoutSession,
-        ShippingInformationManagementInterface $shippingInformationManagement,
-        OscConfig $oscConfig,
-        Message $giftMessage,
-        GiftMessageManager $giftMessageManager,
-        customerSession $customerSession,
-        TotalsCollector $totalsCollector,
-        AddressInterface $addressInterface,
-        ShippingMethodConverter $shippingMethodConverter
-    )
-    {
-        $this->cartRepository                = $cartRepository;
-        $this->oscDetailsFactory             = $oscDetailsFactory;
-        $this->shippingMethodManagement      = $shippingMethodManagement;
-        $this->paymentMethodManagement       = $paymentMethodManagement;
-        $this->cartTotalsRepository          = $cartTotalsRepository;
-        $this->_urlBuilder                   = $urlBuilder;
-        $this->checkoutSession               = $checkoutSession;
-        $this->shippingInformationManagement = $shippingInformationManagement;
-        $this->oscConfig                     = $oscConfig;
-        $this->giftMessage                   = $giftMessage;
-        $this->giftMessageManagement         = $giftMessageManager;
-        $this->_customerSession              = $customerSession;
-        $this->_totalsCollector              = $totalsCollector;
-        $this->_addressInterface             = $addressInterface;
-        $this->_shippingMethodConverter      = $shippingMethodConverter;
-    }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function updateItemQty($cartId, $itemId, $itemQty)
-    {
-        if ($itemQty == 0) {
-            return $this->removeItemById($cartId, $itemId);
-        }
-
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote     = $this->cartRepository->getActive($cartId);
-        $quoteItem = $quote->getItemById($itemId);
-        if (!$quoteItem) {
-            throw new NoSuchEntityException(
-                __('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
-            );
-        }
-
-        try {
-            $quoteItem->setQty($itemQty)->save();
-            $this->cartRepository->save($quote);
-        } catch (\Exception $e) {
-            throw new CouldNotSaveException(__('Could not update item from quote'));
-        }
-
-        return $this->getResponseData($quote);
-    }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function removeItemById($cartId, $itemId)
-    {
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote     = $this->cartRepository->getActive($cartId);
-        $quoteItem = $quote->getItemById($itemId);
-        if (!$quoteItem) {
-            throw new NoSuchEntityException(
-                __('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
-            );
-        }
-        try {
-            $quote->removeItem($itemId);
-            $this->cartRepository->save($quote);
-        } catch (\Exception $e) {
-            throw new CouldNotSaveException(__('Could not remove item from quote'));
-        }
-
-        return $this->getResponseData($quote);
-    }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function getPaymentTotalInformation($cartId)
-    {
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->cartRepository->getActive($cartId);
-
-        return $this->getResponseData($quote);
-    }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function updateGiftWrap($cartId, $isUseGiftWrap)
-    {
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->cartRepository->getActive($cartId);
-        $quote->getShippingAddress()->setUsedGiftWrap($isUseGiftWrap);
-
-        try {
-            $this->cartRepository->save($quote);
-        } catch (\Exception $e) {
-            throw new CouldNotSaveException(__('Could not add gift wrap for this quote'));
-        }
-
-        return $this->getResponseData($quote);
-    }
-
-    /**
-     * Response data to update osc block
-     *
-     * @param \Magento\Quote\Model\Quote $quote
-     * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
-     */
-    public function getResponseData(Quote $quote)
-    {
-        /** @var \Mageplaza\Osc\Api\Data\OscDetailsInterface $oscDetails */
-        $oscDetails = $this->oscDetailsFactory->create();
-
-        if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
-            $oscDetails->setRedirectUrl($this->_urlBuilder->getUrl('checkout/cart'));
-        } else {
-            if ($quote->getShippingAddress()->getCountryId()) {
-                $oscDetails->setShippingMethods($this->getShippingMethods($quote));
-            }
-            $oscDetails->setPaymentMethods($this->paymentMethodManagement->getList($quote->getId()));
-            $oscDetails->setTotals($this->cartTotalsRepository->get($quote->getId()));
-        }
-
-        return $oscDetails;
-    }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function saveCheckoutInformation(
-        $cartId,
-        ShippingInformationInterface $addressInformation,
-        $customerAttributes = [],
-        $additionInformation = []
-    )
-    {
-        try {
-            $additionInformation['customerAttributes'] = $customerAttributes;
-            $this->checkoutSession->setOscData($additionInformation);
-            $this->addGiftMessage($cartId, $additionInformation);
-
-            if ($addressInformation->getShippingAddress()) {
-                if ($this->_customerSession->isLoggedIn() && isset($additionInformation['billing-same-shipping']) && !$additionInformation['billing-same-shipping']) {
-                    $addressInformation->getShippingAddress()->setSaveInAddressBook(0);
-                }
-                $this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
-            }
-        } catch (\Exception $e) {
-            throw new InputException(__('Unable to save order information. Please check input data.'));
-        }
-
-        return true;
-    }
-
-    /**
-     * @param \Magento\Quote\Model\Quote $quote
-     * @return array
-     */
-    public function getShippingMethods(Quote $quote)
-    {
-        $result          = [];
-        $shippingAddress = $quote->getShippingAddress();
-        $shippingAddress->addData($this->_addressInterface->getData());
-        $shippingAddress->setCollectShippingRates(true);
-        $this->_totalsCollector->collectAddressTotals($quote, $shippingAddress);
-        $shippingRates = $shippingAddress->getGroupedAllShippingRates();
-        foreach ($shippingRates as $carrierRates) {
-            foreach ($carrierRates as $rate) {
-                $result[] = $this->_shippingMethodConverter->modelToDataObject($rate, $quote->getQuoteCurrencyCode());
-            }
-        }
-
-        return $result;
-    }
-
-    /**
-     * @param $cartId
-     * @param $additionInformation
-     * @throws \Magento\Framework\Exception\CouldNotSaveException
-     */
-    public function addGiftMessage($cartId, $additionInformation)
-    {
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->cartRepository->getActive($cartId);
-
-        if (!$this->oscConfig->isDisabledGiftMessage() && isset($additionInformation['giftMessage'])) {
-            $giftMessage = json_decode($additionInformation['giftMessage'], true);
-            $this->giftMessage->setSender(isset($giftMessage['sender']) ? $giftMessage['sender'] : '');
-            $this->giftMessage->setRecipient(isset($giftMessage['recipient']) ? $giftMessage['recipient'] : '');
-            $this->giftMessage->setMessage(isset($giftMessage['message']) ? $giftMessage['message'] : '');
-            $this->giftMessageManagement->setMessage($quote, 'quote', $this->giftMessage);
-        }
-    }
+	/**
+	 * @var CartRepositoryInterface
+	 */
+	protected $cartRepository;
+
+	/**
+	 * @type \Mageplaza\Osc\Model\OscDetailFactory
+	 */
+	protected $oscDetailsFactory;
+
+	/**
+	 * @var \Magento\Quote\Api\ShippingMethodManagementInterface
+	 */
+	protected $shippingMethodManagement;
+
+	/**
+	 * @var \Magento\Quote\Api\PaymentMethodManagementInterface
+	 */
+	protected $paymentMethodManagement;
+
+	/**
+	 * @var \Magento\Quote\Api\CartTotalRepositoryInterface
+	 */
+	protected $cartTotalsRepository;
+
+	/**
+	 * Url Builder
+	 *
+	 * @var \Magento\Framework\UrlInterface
+	 */
+	protected $_urlBuilder;
+
+	/**
+	 * Checkout session
+	 *
+	 * @type \Magento\Checkout\Model\Session
+	 */
+	protected $checkoutSession;
+
+	/**
+	 * @var \Magento\Checkout\Api\ShippingInformationManagementInterface
+	 */
+	protected $shippingInformationManagement;
+
+	/**
+	 * @type \Mageplaza\Osc\Helper\Config
+	 */
+	protected $oscConfig;
+
+	/**
+	 * @var Message
+	 */
+	protected $giftMessage;
+
+	/**
+	 * @var GiftMessageManager
+	 */
+	protected $giftMessageManagement;
+
+	/**
+	 * @var \Magento\Customer\Model\Session
+	 */
+	protected $_customerSession;
+
+	/**
+	 * @var \Magento\Quote\Model\Quote\TotalsCollector
+	 */
+	protected $_totalsCollector;
+
+	/**
+	 * @var \Magento\Quote\Api\Data\AddressInterface
+	 */
+	protected $_addressInterface;
+
+	/**
+	 * @var \Magento\Quote\Model\Cart\ShippingMethodConverter
+	 */
+	protected $_shippingMethodConverter;
+
+
+	/**
+	 * CheckoutManagement constructor.
+	 * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
+	 * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
+	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+	 * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
+	 * @param \Magento\Framework\UrlInterface $urlBuilder
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
+	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
+	 * @param \Magento\GiftMessage\Model\Message $giftMessage
+	 * @param \Magento\GiftMessage\Model\GiftMessageManager $giftMessageManager
+	 * @param \Magento\Customer\Model\Session $customerSession
+	 */
+	public function __construct(
+		CartRepositoryInterface $cartRepository,
+		OscDetailsFactory $oscDetailsFactory,
+		ShippingMethodManagementInterface $shippingMethodManagement,
+		PaymentMethodManagementInterface $paymentMethodManagement,
+		CartTotalRepositoryInterface $cartTotalsRepository,
+		UrlInterface $urlBuilder,
+		\Magento\Checkout\Model\Session $checkoutSession,
+		\Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement,
+		OscConfig $oscConfig,
+		Message $giftMessage,
+		GiftMessageManager $giftMessageManager,
+		customerSession $customerSession,
+		TotalsCollector $totalsCollector,
+		AddressInterface $addressInterface,
+		ShippingMethodConverter $shippingMethodConverter
+	)
+	{
+		$this->cartRepository                = $cartRepository;
+		$this->oscDetailsFactory             = $oscDetailsFactory;
+		$this->shippingMethodManagement      = $shippingMethodManagement;
+		$this->paymentMethodManagement       = $paymentMethodManagement;
+		$this->cartTotalsRepository          = $cartTotalsRepository;
+		$this->_urlBuilder                   = $urlBuilder;
+		$this->checkoutSession               = $checkoutSession;
+		$this->shippingInformationManagement = $shippingInformationManagement;
+		$this->oscConfig                     = $oscConfig;
+		$this->giftMessage                   = $giftMessage;
+		$this->giftMessageManagement         = $giftMessageManager;
+		$this->_customerSession              = $customerSession;
+		$this->_totalsCollector              = $totalsCollector;
+		$this->_addressInterface             = $addressInterface;
+		$this->_shippingMethodConverter      = $shippingMethodConverter;
+	}
+
+	/**
+	 * {@inheritDoc}
+	 */
+	public function updateItemQty($cartId, $itemId, $itemQty)
+	{
+		if ($itemQty == 0) {
+			return $this->removeItemById($cartId, $itemId);
+		}
+
+		/** @var \Magento\Quote\Model\Quote $quote */
+		$quote     = $this->cartRepository->getActive($cartId);
+		$quoteItem = $quote->getItemById($itemId);
+		if (!$quoteItem) {
+			throw new NoSuchEntityException(
+				__('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
+			);
+		}
+
+		try {
+			$quoteItem->setQty($itemQty)->save();
+			$this->cartRepository->save($quote);
+		} catch (\Exception $e) {
+			throw new CouldNotSaveException(__('Could not update item from quote'));
+		}
+
+		return $this->getResponseData($quote);
+	}
+
+	/**
+	 * {@inheritDoc}
+	 */
+	public function removeItemById($cartId, $itemId)
+	{
+		/** @var \Magento\Quote\Model\Quote $quote */
+		$quote     = $this->cartRepository->getActive($cartId);
+		$quoteItem = $quote->getItemById($itemId);
+		if (!$quoteItem) {
+			throw new NoSuchEntityException(
+				__('Cart %1 doesn\'t contain item  %2', $cartId, $itemId)
+			);
+		}
+		try {
+			$quote->removeItem($itemId);
+			$this->cartRepository->save($quote);
+		} catch (\Exception $e) {
+			throw new CouldNotSaveException(__('Could not remove item from quote'));
+		}
+
+		return $this->getResponseData($quote);
+	}
+
+	/**
+	 * {@inheritDoc}
+	 */
+	public function getPaymentTotalInformation($cartId)
+	{
+		/** @var \Magento\Quote\Model\Quote $quote */
+		$quote = $this->cartRepository->getActive($cartId);
+
+		return $this->getResponseData($quote);
+	}
+
+	/**
+	 * {@inheritDoc}
+	 */
+	public function updateGiftWrap($cartId, $isUseGiftWrap)
+	{
+		/** @var \Magento\Quote\Model\Quote $quote */
+		$quote = $this->cartRepository->getActive($cartId);
+		$quote->getShippingAddress()->setUsedGiftWrap($isUseGiftWrap);
+
+		try {
+			$this->cartRepository->save($quote);
+		} catch (\Exception $e) {
+			throw new CouldNotSaveException(__('Could not add gift wrap for this quote'));
+		}
+
+		return $this->getResponseData($quote);
+	}
+
+	/**
+	 * Response data to update osc block
+	 *
+	 * @param \Magento\Quote\Model\Quote $quote
+	 * @return \Mageplaza\Osc\Api\Data\OscDetailsInterface
+	 */
+	public function getResponseData(\Magento\Quote\Model\Quote $quote)
+	{
+		/** @var \Mageplaza\Osc\Api\Data\OscDetailsInterface $oscDetails */
+		$oscDetails = $this->oscDetailsFactory->create();
+
+		if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
+			$oscDetails->setRedirectUrl($this->_urlBuilder->getUrl('checkout/cart'));
+		} else {
+			if ($quote->getShippingAddress()->getCountryId()) {
+				$oscDetails->setShippingMethods($this->getShippingMethods($quote));
+			}
+			$oscDetails->setPaymentMethods($this->paymentMethodManagement->getList($quote->getId()));
+			$oscDetails->setTotals($this->cartTotalsRepository->get($quote->getId()));
+		}
+
+		return $oscDetails;
+	}
+
+	/**
+	 * {@inheritDoc}
+	 */
+	public function saveCheckoutInformation(
+		$cartId,
+		\Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
+		$customerAttributes = [],
+		$additionInformation = []
+	)
+	{
+		try {
+			$additionInformation['customerAttributes'] = $customerAttributes;
+			$this->checkoutSession->setOscData($additionInformation);
+			$this->addGiftMessage($cartId, $additionInformation);
+
+			if ($addressInformation->getShippingAddress()) {
+				if ($this->_customerSession->isLoggedIn() && isset($additionInformation['billing-same-shipping']) && !$additionInformation['billing-same-shipping']) {
+					$addressInformation->getShippingAddress()->setSaveInAddressBook(0);
+				}
+				$this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
+			}
+		} catch (\Exception $e) {
+			throw new InputException(__('Unable to save order information. Please check input data.'));
+		}
+
+		return true;
+	}
+
+	/**
+	 * @param \Magento\Quote\Model\Quote $quote
+	 * @return array
+	 */
+	public function getShippingMethods(\Magento\Quote\Model\Quote $quote)
+	{
+		$result          = [];
+		$shippingAddress = $quote->getShippingAddress();
+		$shippingAddress->addData($this->_addressInterface->getData());
+		$shippingAddress->setCollectShippingRates(true);
+		$this->_totalsCollector->collectAddressTotals($quote, $shippingAddress);
+		$shippingRates = $shippingAddress->getGroupedAllShippingRates();
+		foreach ($shippingRates as $carrierRates) {
+			foreach ($carrierRates as $rate) {
+				$result[] = $this->_shippingMethodConverter->modelToDataObject($rate, $quote->getQuoteCurrencyCode());
+			}
+		}
+
+		return $result;
+	}
+
+	/**
+	 * @param $cartId
+	 * @param $additionInformation
+	 * @throws \Magento\Framework\Exception\CouldNotSaveException
+	 */
+	public function addGiftMessage($cartId, $additionInformation)
+	{
+		/** @var \Magento\Quote\Model\Quote $quote */
+		$quote = $this->cartRepository->getActive($cartId);
+
+		if (!$this->oscConfig->isDisabledGiftMessage() && isset($additionInformation['giftMessage'])) {
+			$giftMessage = json_decode($additionInformation['giftMessage'], true);
+			$this->giftMessage->setSender(isset($giftMessage['sender']) ? $giftMessage['sender'] : '');
+			$this->giftMessage->setRecipient(isset($giftMessage['recipient']) ? $giftMessage['recipient'] : '');
+			$this->giftMessage->setMessage(isset($giftMessage['message']) ? $giftMessage['message'] : '');
+			$this->giftMessageManagement->setMessage($quote, 'quote', $this->giftMessage);
+		}
+	}
 }
diff --git a/Model/CheckoutRegister.php b/Model/CheckoutRegister.php
deleted file mode 100644
index 0fd6a9e..0000000
--- a/Model/CheckoutRegister.php
+++ /dev/null
@@ -1,221 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model;
-
-use Magento\Quote\Model\CustomerManagement;
-use Magento\Quote\Model\Quote;
-
-/**
- * Class CheckoutRegister
- * @package Mageplaza\Osc\Model
- */
-class CheckoutRegister
-{
-    /**
-     * @var \Magento\Checkout\Model\Session
-     */
-    protected $checkoutSession;
-
-    /**
-     * @type \Magento\Framework\DataObject\Copy
-     */
-    protected $_objectCopyService;
-
-    /**
-     * @type \Magento\Framework\Api\DataObjectHelper
-     */
-    protected $dataObjectHelper;
-
-    /**
-     * @type \Magento\Customer\Api\AccountManagementInterface
-     */
-    protected $accountManagement;
-
-    /**
-     * @var CustomerManagement
-     */
-    protected $customerManagement;
-
-    /**
-     * @var bool
-     */
-    protected $_isCheckedRegister = false;
-
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
-    protected $_oscHelperData;
-
-    /**
-     * CheckoutRegister constructor.
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Magento\Framework\DataObject\Copy $objectCopyService
-     * @param \Magento\Framework\Api\DataObjectHelper $dataObjectHelper
-     * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
-     * @param \Magento\Quote\Model\CustomerManagement $customerManagement
-     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
-     */
-    public function __construct(
-        \Magento\Checkout\Model\Session $checkoutSession,
-        \Magento\Framework\DataObject\Copy $objectCopyService,
-        \Magento\Framework\Api\DataObjectHelper $dataObjectHelper,
-        \Magento\Customer\Api\AccountManagementInterface $accountManagement,
-        CustomerManagement $customerManagement,
-        \Mageplaza\Osc\Helper\Data $oscHelperData
-    )
-    {
-        $this->checkoutSession    = $checkoutSession;
-        $this->_objectCopyService = $objectCopyService;
-        $this->dataObjectHelper   = $dataObjectHelper;
-        $this->accountManagement  = $accountManagement;
-        $this->customerManagement = $customerManagement;
-        $this->_oscHelperData     = $oscHelperData;
-    }
-
-    /**
-     * @return $this
-     */
-    public function checkRegisterNewCustomer()
-    {
-        if ($this->isCheckedRegister()) {
-            return $this;
-        }
-        $this->setIsCheckedRegister(true);
-
-        /** @type \Magento\Quote\Model\Quote $quote */
-        $quote = $this->checkoutSession->getQuote();
-
-        /** Validate address */
-        $this->validateAddressBeforeSubmit($quote);
-
-        /** One step check out additional data */
-        $oscData = $this->checkoutSession->getOscData();
-
-        /** Create account when checkout */
-        if (isset($oscData['register']) && $oscData['register']
-            && isset($oscData['password']) && $oscData['password']
-        ) {
-            $quote->setCheckoutMethod(\Magento\Checkout\Model\Type\Onepage::METHOD_REGISTER)
-                ->setCustomerIsGuest(false)
-                ->setCustomerGroupId(null)
-                ->setPasswordHash($this->accountManagement->getPasswordHash($oscData['password']));
-
-            $this->_prepareNewCustomerQuote($quote, $oscData);
-        }
-
-        return $this;
-    }
-
-    /**
-     * Prepare quote for customer registration and customer order submit
-     *
-     * @param \Magento\Quote\Model\Quote $quote
-     * @return void
-     */
-    protected function _prepareNewCustomerQuote(Quote $quote, $oscData)
-    {
-        $billing  = $quote->getBillingAddress();
-        $shipping = $quote->isVirtual() ? null : $quote->getShippingAddress();
-
-        $customer  = $quote->getCustomer();
-        $dataArray = $billing->getData();
-        if (isset($oscData['customerAttributes']) && $oscData['customerAttributes']) {
-            $dataArray = array_merge($dataArray, $oscData['customerAttributes']);
-        }
-        $this->dataObjectHelper->populateWithArray(
-            $customer,
-            $dataArray,
-            '\Magento\Customer\Api\Data\CustomerInterface'
-        );
-
-        $quote->setCustomer($customer);
-        $this->_oscHelperData->setFlagOscMethodRegister(true);
-
-        /** Create customer */
-        $this->customerManagement->populateCustomerInfo($quote);
-
-        /** Init customer address */
-        $customerBillingData = $billing->exportCustomerAddress();
-        $customerBillingData->setIsDefaultBilling(true)
-            ->setData('should_ignore_validation', true);
-
-        if ($shipping) {
-            if (isset($oscData['same_as_shipping']) && $oscData['same_as_shipping']) {
-                $shipping->setCustomerAddressData($customerBillingData);
-                $customerBillingData->setIsDefaultShipping(true);
-            } else {
-                $customerShippingData = $shipping->exportCustomerAddress();
-                $customerShippingData->setIsDefaultShipping(true)
-                    ->setData('should_ignore_validation', true);
-                $shipping->setCustomerAddressData($customerShippingData);
-                // Add shipping address to quote since customer Data Object does not hold address information
-                $quote->addCustomerAddress($customerShippingData);
-            }
-        } else {
-            $customerBillingData->setIsDefaultShipping(true);
-        }
-        $billing->setCustomerAddressData($customerBillingData);
-        // Add billing address to quote since customer Data Object does not hold address information
-        $quote->addCustomerAddress($customerBillingData);
-
-        // If customer is created, set customerId for address to avoid create more address when checkout
-        if ($customerId = $quote->getCustomerId()) {
-            $billing->setCustomerId($customerId);
-            if ($shipping) {
-                $shipping->setCustomerId($customerId);
-            }
-        }
-    }
-
-    /**
-     * @param \Magento\Quote\Model\Quote $quote
-     * @return $this
-     */
-    public function validateAddressBeforeSubmit(\Magento\Quote\Model\Quote $quote)
-    {
-        /** Remove address validation */
-        if (!$quote->isVirtual()) {
-            $quote->getShippingAddress()->setShouldIgnoreValidation(true);
-        }
-        $quote->getBillingAddress()->setShouldIgnoreValidation(true);
-
-        // TODO : Validate address (depend on field require, show on osc or not)
-
-        return $this;
-    }
-
-    /**
-     * @return bool
-     */
-    public function isCheckedRegister()
-    {
-        return $this->_isCheckedRegister;
-    }
-
-    /**
-     * @param bool $isCheckedRegister
-     */
-    public function setIsCheckedRegister($isCheckedRegister)
-    {
-        $this->_isCheckedRegister = $isCheckedRegister;
-    }
-}
\ No newline at end of file
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index 65cbdd9..c054f2c 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -24,11 +24,11 @@ namespace Mageplaza\Osc\Model;
 use Magento\Checkout\Model\ConfigProviderInterface;
 use Magento\Checkout\Model\Session as CheckoutSession;
 use Magento\Customer\Model\AccountManagement;
-use Magento\Framework\Module\Manager as ModuleManager;
 use Magento\GiftMessage\Model\CompositeConfigProvider;
 use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Mageplaza\Osc\Helper\Config as OscConfig;
+use Magento\Framework\Module\Manager as ModuleManager;
 use Mageplaza\Osc\Helper\Data as HelperData;
 use Mageplaza\Osc\Model\Geoip\Database\Reader;
 
@@ -39,190 +39,206 @@ use Mageplaza\Osc\Model\Geoip\Database\Reader;
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
-     * @type \Mageplaza\Osc\Helper\Config
-     */
-    protected $oscConfig;
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
-     * @type \Mageplaza\Osc\Helper\Data
-     */
-    protected $_helperData;
-
-    /**
-     * @type \Mageplaza\Osc\Model\Geoip\Database\Reader
-     */
-    protected $_geoIpData;
-
-    /**
-     * DefaultConfigProvider constructor.
-     * @param CheckoutSession $checkoutSession
-     * @param PaymentMethodManagementInterface $paymentMethodManagement
-     * @param ShippingMethodManagementInterface $shippingMethodManagement
-     * @param OscConfig $oscConfig
-     * @param CompositeConfigProvider $configProvider
-     * @param ModuleManager $moduleManager
-     * @param HelperData $helperData
-     * @param Reader $geoIpData
-     */
-    public function __construct(
-        CheckoutSession $checkoutSession,
-        PaymentMethodManagementInterface $paymentMethodManagement,
-        ShippingMethodManagementInterface $shippingMethodManagement,
-        OscConfig $oscConfig,
-        CompositeConfigProvider $configProvider,
-        ModuleManager $moduleManager,
-        HelperData $helperData,
-        Reader $geoIpData
-    )
-    {
-        $this->checkoutSession           = $checkoutSession;
-        $this->paymentMethodManagement   = $paymentMethodManagement;
-        $this->shippingMethodManagement  = $shippingMethodManagement;
-        $this->oscConfig                 = $oscConfig;
-        $this->giftMessageConfigProvider = $configProvider;
-        $this->moduleManager             = $moduleManager;
-        $this->_helperData               = $helperData;
-        $this->_geoIpData                = $geoIpData;
-    }
-
-    /**
-     * {@inheritdoc}
-     */
-    public function getConfig()
-    {
-        if (!$this->oscConfig->isOscPage()) {
-            return [];
-        }
-
-        $output = [
-            'shippingMethods'       => $this->getShippingMethods(),
-            'selectedShippingRate'  => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod()) ? $existShippingMethod : $this->oscConfig->getDefaultShippingMethod(),
-            'paymentMethods'        => $this->getPaymentMethods(),
-            'selectedPaymentMethod' => $this->oscConfig->getDefaultPaymentMethod(),
-            'oscConfig'             => $this->getOscConfig()
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
-            'addressFields'        => $this->_helperData->getAddressFields(),
-            'autocomplete'         => [
-                'type'                   => $this->oscConfig->getAutoDetectedAddress(),
-                'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
-            ],
-            'register'             => [
-                'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
-                'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
-            ],
-            'allowGuestCheckout'   => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
-            'showBillingAddress'   => $this->oscConfig->getShowBillingAddress(),
-            'newsletterDefault'    => $this->oscConfig->isSubscribedByDefault(),
-            'isUsedGiftWrap'       => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
-            'giftMessageOptions'   => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), ['isEnableOscGiftMessageItems' => $this->oscConfig->isEnableGiftMessageItems()]),
-            'isDisplaySocialLogin' => $this->isDisplaySocialLogin(),
-            'deliveryTimeOptions'  => [
-                'deliveryTimeFormat' => $this->oscConfig->getDeliveryTimeFormat(),
-                'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff(),
-                'houseSecurityCode'  => $this->oscConfig->isDisabledHouseSecurityCode()
-            ],
-            'isUsedMaterialDesign' => $this->oscConfig->isUsedMaterialDesign(),
-            'geoIpOptions'         => [
-                'isEnableGeoIp' => $this->oscConfig->isEnableGeoIP(),
-                'geoIpData'     => $this->getGeoIpData()
-            ],
-            'compatible'           => [
-                'isEnableModulePostNL' => $this->oscConfig->isEnableModulePostNL(),
-            ],
-            'show_toc'             => $this->oscConfig->getShowTOC()
-        ];
-    }
-
-    /**
-     * @return mixed
-     */
-    public function getGeoIpData()
-    {
-        if ($this->oscConfig->isEnableGeoIP() && $this->_helperData->checkHasLibrary()) {
-            $ip = $_SERVER['REMOTE_ADDR'];
-            if (!filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE) || $ip == '127.0.0.1') {
-                $ip = '123.16.189.71';
-            }
-            $data = $this->_geoIpData->city($ip);
-
-            return $this->_helperData->getGeoIpData($data);
-        }
-    }
-
-    /**
-     * Returns array of payment methods
-     * @return array
-     */
-    private function getPaymentMethods()
-    {
-        $paymentMethods = [];
-        $quote          = $this->checkoutSession->getQuote();
-        foreach ($this->paymentMethodManagement->getList($quote->getId()) as $paymentMethod) {
-            $paymentMethods[] = [
-                'code'  => $paymentMethod->getCode(),
-                'title' => $paymentMethod->getTitle()
-            ];
-        }
-
-        return $paymentMethods;
-    }
-
-    /**
-     * Returns array of payment methods
-     * @return array
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
-
-        return $this->moduleManager->isOutputEnabled('Mageplaza_SocialLogin') && !$this->oscConfig->isDisabledSocialLoginOnCheckout();
-    }
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
+			'addressFields'        => $this->getAddressFields(),
+			'autocomplete'         => [
+				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
+				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
+			],
+			'register'             => [
+				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
+				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
+			],
+			'allowGuestCheckout'   => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
+			'showBillingAddress'   => $this->oscConfig->getShowBillingAddress(),
+			'newsletterDefault'    => $this->oscConfig->isSubscribedByDefault(),
+			'isUsedGiftWrap'       => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
+			'giftMessageOptions'   => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), ['isEnableOscGiftMessageItems' => $this->oscConfig->isEnableGiftMessageItems()]),
+			'isDisplaySocialLogin' => $this->isDisplaySocialLogin(),
+			'deliveryTimeOptions'  => [
+				'deliveryTimeFormat' => $this->oscConfig->getDeliveryTimeFormat(),
+				'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff(),
+				'houseSecurityCode'  => $this->oscConfig->isDisabledHouseSecurityCode()
+			],
+			'isUsedMaterialDesign' => $this->oscConfig->isUsedMaterialDesign(),
+			'geoIpOptions'         => [
+				'isEnableGeoIp' => $this->oscConfig->isEnableGeoIP(),
+				'geoIpData'     => $this->getGeoIpData()
+			],
+			'compatible'           => [
+				'isEnableModulePostNL' => $this->oscConfig->isEnableModulePostNL(),
+			]
+		];
+	}
+
+	/**
+	 * Address Fields
+	 *
+	 * @return array
+	 */
+	private function getAddressFields()
+	{
+		$fieldPosition = $this->oscConfig->getAddressFieldPosition();
+
+		$fields = array_keys($fieldPosition);
+		if (!in_array('country_id', $fields)) {
+			array_unshift($fields, 'country_id');
+		}
+
+		return $fields;
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
+		foreach ($this->paymentMethodManagement->getList($quote->getId()) as $paymentMethod) {
+			$paymentMethods[] = [
+				'code'  => $paymentMethod->getCode(),
+				'title' => $paymentMethod->getTitle()
+			];
+		}
+
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
index 68e2f6b..f00b468 100644
--- a/Model/Geoip/Database/Reader.php
+++ b/Model/Geoip/Database/Reader.php
@@ -1,28 +1,7 @@
 <?php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
 namespace Mageplaza\Osc\Model\Geoip\Database;
-
-use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader as DbReader;
 use Mageplaza\Osc\Model\Geoip\ProviderInterface;
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader as DbReader;
 
 /**
  * Instances of this class provide a reader for the GeoIP2 database format.
@@ -67,10 +46,9 @@ class Reader implements ProviderInterface
      */
     public function __construct(
         DbReader $dbreader
-    )
-    {
+    ) {
         $this->_dbReader = $dbreader;
-        $this->locales   = array('en');
+        $this->locales = array('en');
     }
 
     /**
@@ -99,6 +77,8 @@ class Reader implements ProviderInterface
      * @param $type
      * @param $ipAddress
      * @return array
+     * @throws \Mageplaza\Osc\Model\Geoip\Database\AddressNotFoundException
+     * @throws \Mageplaza\Osc\Model\Geoip\Database\InvalidDatabaseException
      */
     private function modelFor($class, $type, $ipAddress)
     {
@@ -106,7 +86,6 @@ class Reader implements ProviderInterface
 
         $record['traits']['ip_address'] = $ipAddress;
         $this->close();
-
         return $record;
     }
 
@@ -115,20 +94,21 @@ class Reader implements ProviderInterface
      * @param $type
      * @param $ipAddress
      * @return array
-     * @throws \Exception
+     * @throws \Mageplaza\Osc\Model\Geoip\Database\AddressNotFoundException
+     * @throws \Mageplaza\Osc\Model\Geoip\Database\InvalidDatabaseException
      */
     private function getRecord($class, $type, $ipAddress)
     {
         if (strpos($this->metadata()->databaseType, $type) === false) {
             $method = lcfirst($class);
-            throw new \Exception(
+            throw new \BadMethodCallException(
                 "The $method method cannot be used to open a "
                 . $this->metadata()->databaseType . " database"
             );
         }
         $record = $this->_dbReader->get($ipAddress);
         if ($record === null) {
-            throw new \Exception(
+            throw new AddressNotFoundException(
                 "The address $ipAddress is not in the database."
             );
         }
@@ -140,19 +120,18 @@ class Reader implements ProviderInterface
             // an array. This mostly happens when the user is ignoring all
             // exceptions and the more frequent InvalidDatabaseException
             // exceptions go unnoticed.
-            throw new \Exception(
+            throw new InvalidDatabaseException(
                 "Expected an array when looking up $ipAddress but received: "
                 . gettype($record)
             );
         }
-
         return $record;
     }
 
     /**
      * @throws \InvalidArgumentException if arguments are passed to the method.
      * @throws \BadMethodCallException if the database has been closed.
-     * @return \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Metadata object for the database.
+     * @return Metadata object for the database.
      */
     public function metadata()
     {
diff --git a/Model/Geoip/Maxmind/Db/Reader.php b/Model/Geoip/Maxmind/Db/Reader.php
index 5129833..f22361c 100644
--- a/Model/Geoip/Maxmind/Db/Reader.php
+++ b/Model/Geoip/Maxmind/Db/Reader.php
@@ -1,23 +1,4 @@
 <?php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db;
 
@@ -32,6 +13,7 @@ use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util;
  */
 class Reader
 {
+
 	private static $DATA_SECTION_SEPARATOR_SIZE = 16;
 	private static $METADATA_START_MARKER = "\xAB\xCD\xEFMaxMind.com";
 	private static $METADATA_START_MARKER_LENGTH = 14;
diff --git a/Model/Geoip/Maxmind/Db/Reader/Decoder.php b/Model/Geoip/Maxmind/Db/Reader/Decoder.php
index 1e8923f..b304c07 100644
--- a/Model/Geoip/Maxmind/Db/Reader/Decoder.php
+++ b/Model/Geoip/Maxmind/Db/Reader/Decoder.php
@@ -1,30 +1,10 @@
 <?php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
 
-/**
- * Class Decoder
- * @package Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader
- */
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException;
+use Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\Util;
+
 class Decoder
 {
 
@@ -60,16 +40,16 @@ class Decoder
      * @type array
      */
     private $types = array(
-        0  => 'extended',
-        1  => 'pointer',
-        2  => 'utf8_string',
-        3  => 'double',
-        4  => 'bytes',
-        5  => 'uint16',
-        6  => 'uint32',
-        7  => 'map',
-        8  => 'int32',
-        9  => 'uint64',
+        0 => 'extended',
+        1 => 'pointer',
+        2 => 'utf8_string',
+        3 => 'double',
+        4 => 'bytes',
+        5 => 'uint16',
+        6 => 'uint32',
+        7 => 'map',
+        8 => 'int32',
+        9 => 'uint64',
         10 => 'uint128',
         11 => 'array',
         12 => 'container',
@@ -85,10 +65,9 @@ class Decoder
     public function __construct(
         InvalidDatabaseException $invalidDatabaseException,
         Util $until
-    )
-    {
-        $this->invalidDatabaseException = $invalidDatabaseException;
-        $this->util                     = $until;
+    ){
+        $this->invalidDatabaseException =$invalidDatabaseException;
+        $this->util=$until;
     }
 
     /**
@@ -97,13 +76,11 @@ class Decoder
      * @param bool|false $pointerTestHack
      * @return $this
      */
-    public function init($fileStream, $pointerBase = 0, $pointerTestHack = false)
-    {
-        $this->fileStream      = $fileStream;
-        $this->pointerBase     = $pointerBase;
+    public function init($fileStream,$pointerBase=0,$pointerTestHack=false){
+        $this->fileStream = $fileStream;
+        $this->pointerBase = $pointerBase;
         $this->pointerTestHack = $pointerTestHack;
         $this->switchByteOrder = $this->isPlatformLittleEndian();
-
         return $this;
     }
 
@@ -181,17 +158,15 @@ class Decoder
         }
 
         $newOffset = $offset + $size;
-        $bytes     = Util::read($this->fileStream, $offset, $size);
+        $bytes = Util::read($this->fileStream, $offset, $size);
         switch ($type) {
             case 'utf8_string':
                 return array($this->decodeString($bytes), $newOffset);
             case 'double':
                 $this->verifySize(8, $size);
-
                 return array($this->decodeDouble($bytes), $newOffset);
             case 'float':
                 $this->verifySize(4, $size);
-
                 return array($this->decodeFloat($bytes), $newOffset);
             case 'bytes':
                 return array($bytes, $newOffset);
@@ -257,7 +232,6 @@ class Decoder
     {
         // XXX - Assumes IEEE 754 double on platform
         list(, $double) = unpack('d', $this->maybeSwitchByteOrder($bits));
-
         return $double;
     }
 
@@ -269,7 +243,6 @@ class Decoder
     {
         // XXX - Assumes IEEE 754 floats on platform
         list(, $float) = unpack('f', $this->maybeSwitchByteOrder($bits));
-
         return $float;
     }
 
@@ -281,7 +254,6 @@ class Decoder
     {
         $bytes = $this->zeroPadLeft($bytes, 4);
         list(, $int) = unpack('l', $this->maybeSwitchByteOrder($bytes));
-
         return $int;
     }
 
@@ -328,7 +300,7 @@ class Decoder
             : (pack('C', $ctrlByte & 0x7)) . $buffer;
 
         $unpacked = $this->decodeUint($packed);
-        $pointer  = $unpacked + $this->pointerBase
+        $pointer = $unpacked + $this->pointerBase
             + $this->pointerValueOffset[$pointerSize];
 
         return array($pointer, $offset);
@@ -341,7 +313,6 @@ class Decoder
     private function decodeUint($bytes)
     {
         list(, $int) = unpack('N', $this->zeroPadLeft($bytes, 4));
-
         return $int;
     }
 
@@ -359,9 +330,9 @@ class Decoder
         }
 
         $numberOfLongs = ceil($byteLength / 4);
-        $paddedLength  = $numberOfLongs * 4;
-        $paddedBytes   = $this->zeroPadLeft($bytes, $paddedLength);
-        $unpacked      = array_merge(unpack("N$numberOfLongs", $paddedBytes));
+        $paddedLength = $numberOfLongs * 4;
+        $paddedBytes = $this->zeroPadLeft($bytes, $paddedLength);
+        $unpacked = array_merge(unpack("N$numberOfLongs", $paddedBytes));
 
         $integer = 0;
 
@@ -382,7 +353,6 @@ class Decoder
                 );
             }
         }
-
         return $integer;
     }
 
@@ -404,10 +374,10 @@ class Decoder
      */
     private function sizeFromCtrlByte($ctrlByte, $offset)
     {
-        $size        = $ctrlByte & 0x1f;
+        $size = $ctrlByte & 0x1f;
         $bytesToRead = $size < 29 ? 0 : $size - 28;
-        $bytes       = Util::read($this->fileStream, $offset, $bytesToRead);
-        $decoded     = $this->decodeUint($bytes);
+        $bytes = Util::read($this->fileStream, $offset, $bytesToRead);
+        $decoded = $this->decodeUint($bytes);
 
         if ($size == 29) {
             $size = 29 + $decoded;
@@ -446,8 +416,7 @@ class Decoder
     private function isPlatformLittleEndian()
     {
         $testint = 0x00FF;
-        $packed  = pack('S', $testint);
-
+        $packed = pack('S', $testint);
         return $testint === current(unpack('v', $packed));
     }
 }
diff --git a/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php b/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
index d40e441..8dc671f 100644
--- a/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
+++ b/Model/Geoip/Maxmind/Db/Reader/InvalidDatabaseException.php
@@ -1,26 +1,6 @@
 <?php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
-
 /**
  * This class should be thrown when unexpected data is found in the database.
  */
diff --git a/Model/Geoip/Maxmind/Db/Reader/Metadata.php b/Model/Geoip/Maxmind/Db/Reader/Metadata.php
index 5dad2e2..3a7775b 100644
--- a/Model/Geoip/Maxmind/Db/Reader/Metadata.php
+++ b/Model/Geoip/Maxmind/Db/Reader/Metadata.php
@@ -1,23 +1,4 @@
 <?php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
 
diff --git a/Model/Geoip/Maxmind/Db/Reader/Util.php b/Model/Geoip/Maxmind/Db/Reader/Util.php
index 19b62a5..0ecd474 100644
--- a/Model/Geoip/Maxmind/Db/Reader/Util.php
+++ b/Model/Geoip/Maxmind/Db/Reader/Util.php
@@ -1,38 +1,17 @@
 <?php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 namespace Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader;
 
-/**
- * Class Util
- * @package Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader
- */
+use  Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException;
+
 class Util
 {
     /**
      * @param $stream
      * @param $offset
      * @param $numberOfBytes
-     * @return bool|string
-     * @throws \Exception
+     * @return string
+     * @throws \Mageplaza\Osc\Model\Geoip\Maxmind\Db\Reader\InvalidDatabaseException
      */
     public static function read($stream, $offset, $numberOfBytes)
     {
@@ -49,7 +28,7 @@ class Util
                 return $value;
             }
         }
-        throw new \Exception(
+        throw new InvalidDatabaseException(
             "The MaxMind DB file contains bad data"
         );
     }
diff --git a/Model/Geoip/ProviderInterface.php b/Model/Geoip/ProviderInterface.php
index 12e9968..40b7d0a 100644
--- a/Model/Geoip/ProviderInterface.php
+++ b/Model/Geoip/ProviderInterface.php
@@ -1,43 +1,20 @@
 <?php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 namespace Mageplaza\Osc\Model\Geoip;
 
-/**
- * Interface ProviderInterface
- * @package Mageplaza\Osc\Model\Geoip
- */
 interface ProviderInterface
 {
-    /**
-     * @param ipAddress
-     *            IPv4 or IPv6 address to lookup.
-     * @return Country model for the requested IP address.
-     */
-    public function country($ipAddress);
+	/**
+	 * @param ipAddress
+	 *            IPv4 or IPv6 address to lookup.
+	 * @return Country model for the requested IP address.
+	 */
+	public function country($ipAddress);
 
-    /**
-     * @param ipAddress
-     *            IPv4 or IPv6 address to lookup.
-     * @return City model for the requested IP address.
-     */
-    public function city($ipAddress);
+	/**
+	 * @param ipAddress
+	 *            IPv4 or IPv6 address to lookup.
+	 * @return City model for the requested IP address.
+	 */
+	public function city($ipAddress);
 }
diff --git a/Model/GuestCheckoutManagement.php b/Model/GuestCheckoutManagement.php
index ae04027..93faf7e 100644
--- a/Model/GuestCheckoutManagement.php
+++ b/Model/GuestCheckoutManagement.php
@@ -15,20 +15,16 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model;
 
-use Magento\Quote\Api\CartRepositoryInterface;
-use Mageplaza\Osc\Api\GuestCheckoutManagementInterface;
-
 /**
  * Class GuestCheckoutManagement
  * @package Mageplaza\Osc\Model
  */
-class GuestCheckoutManagement implements GuestCheckoutManagementInterface
+class GuestCheckoutManagement implements \Mageplaza\Osc\Api\GuestCheckoutManagementInterface
 {
     /**
      * @var \Magento\Quote\Model\QuoteIdMaskFactory
@@ -41,25 +37,16 @@ class GuestCheckoutManagement implements GuestCheckoutManagementInterface
     protected $checkoutManagement;
 
     /**
-     * @var CartRepositoryInterface
-     */
-    protected $cartRepository;
-
-    /**
-     * GuestCheckoutManagement constructor.
      * @param \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory
      * @param \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
-     * @param CartRepositoryInterface $cartRepository
      */
     public function __construct(
         \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory,
-        \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement,
-        CartRepositoryInterface $cartRepository
-    )
-    {
-        $this->quoteIdMaskFactory = $quoteIdMaskFactory;
+        \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
+    ) {
+    
+        $this->quoteIdMaskFactory   = $quoteIdMaskFactory;
         $this->checkoutManagement = $checkoutManagement;
-        $this->cartRepository     = $cartRepository;
     }
 
     /**
@@ -94,7 +81,7 @@ class GuestCheckoutManagement implements GuestCheckoutManagementInterface
 
         return $this->checkoutManagement->getPaymentTotalInformation($quoteIdMask->getQuoteId());
     }
-
+    
     /**
      * {@inheritDoc}
      */
@@ -114,8 +101,7 @@ class GuestCheckoutManagement implements GuestCheckoutManagementInterface
         \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
         $customerAttributes = [],
         $additionInformation = []
-    )
-    {
+    ) {
         /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
         $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
 
@@ -126,24 +112,4 @@ class GuestCheckoutManagement implements GuestCheckoutManagementInterface
             $additionInformation
         );
     }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function saveEmailToQuote($cartId, $email)
-    {
-        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
-        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->cartRepository->getActive($quoteIdMask->getQuoteId());
-        $quote->setCustomerEmail($email);
-
-        try {
-            $this->cartRepository->save($quote);
-        } catch (\Exception $e) {
-            return false;
-        }
-
-        return true;
-    }
 }
diff --git a/Model/OscDetails.php b/Model/OscDetails.php
index d15a412..7d07c87 100644
--- a/Model/OscDetails.php
+++ b/Model/OscDetails.php
@@ -15,19 +15,16 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model;
 
-use Magento\Framework\Model\AbstractExtensibleModel;
-use Mageplaza\Osc\Api\Data\OscDetailsInterface;
-
 /**
  * @codeCoverageIgnoreStart
  */
-class OscDetails extends AbstractExtensibleModel implements OscDetailsInterface
+class OscDetails extends \Magento\Framework\Model\AbstractExtensibleModel implements
+    \Mageplaza\Osc\Api\Data\OscDetailsInterface
 {
     /**
      * @{inheritdoc}
diff --git a/Model/Plugin/Checkout/ShippingMethodManagement.php b/Model/Plugin/Checkout/ShippingMethodManagement.php
index 1f20250..378ad77 100644
--- a/Model/Plugin/Checkout/ShippingMethodManagement.php
+++ b/Model/Plugin/Checkout/ShippingMethodManagement.php
@@ -15,16 +15,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model\Plugin\Checkout;
 
-use Magento\Customer\Api\AddressRepositoryInterface;
-use Magento\Quote\Api\CartRepositoryInterface;
-use Magento\Quote\Api\Data\AddressInterface;
 use Magento\Quote\Api\Data\EstimateAddressInterface;
+use Magento\Quote\Api\Data\AddressInterface;
 
 /**
  * Class ShippingMethodManagement
@@ -32,119 +29,123 @@ use Magento\Quote\Api\Data\EstimateAddressInterface;
  */
 class ShippingMethodManagement
 {
-    /**
-     * Quote repository.
-     *
-     * @var \Magento\Quote\Api\CartRepositoryInterface
-     */
-    protected $quoteRepository;
-
-    /**
-     * Customer Address repository
-     *
-     * @var \Magento\Customer\Api\AddressRepositoryInterface
-     */
-    protected $addressRepository;
-
-    /**
-     * @param \Magento\Quote\Api\CartRepositoryInterface $quoteRepository
-     * @param \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
-     */
-    public function __construct(
-        CartRepositoryInterface $quoteRepository,
-        AddressRepositoryInterface $addressRepository
-    )
-    {
-        $this->quoteRepository   = $quoteRepository;
-        $this->addressRepository = $addressRepository;
-    }
-
-    /**
-     * @param \Magento\Quote\Model\ShippingMethodManagement $subject
-     * @param \Closure $proceed
-     * @param $cartId
-     * @param EstimateAddressInterface $address
-     * @return array
-     */
-    public function aroundEstimateByAddress(
-        \Magento\Quote\Model\ShippingMethodManagement $subject,
-        \Closure $proceed,
-        $cartId,
-        EstimateAddressInterface $address
-    )
-    {
-        $this->saveAddress($cartId, $address);
-
-        return $proceed($cartId, $address);
-    }
-
-    /**
-     * @param \Magento\Quote\Model\ShippingMethodManagement $subject
-     * @param \Closure $proceed
-     * @param $cartId
-     * @param \Magento\Quote\Api\Data\AddressInterface $address
-     * @return mixed
-     */
-    public function aroundEstimateByExtendedAddress(
-        \Magento\Quote\Model\ShippingMethodManagement $subject,
-        \Closure $proceed,
-        $cartId,
-        AddressInterface $address
-    )
-    {
-        $this->saveAddress($cartId, $address);
-
-        return $proceed($cartId, $address);
-    }
-
-    /**
-     * @param \Magento\Quote\Model\ShippingMethodManagement $subject
-     * @param \Closure $proceed
-     * @param $cartId
-     * @param $addressId
-     * @return mixed
-     */
-    public function aroundEstimateByAddressId(
-        \Magento\Quote\Model\ShippingMethodManagement $subject,
-        \Closure $proceed,
-        $cartId,
-        $addressId
-    )
-    {
-        $address = $this->addressRepository->getById($addressId);
-        $this->saveAddress($cartId, $address);
-
-        return $proceed($cartId, $addressId);
-    }
-
-    /**
-     * @param $cartId
-     * @param $address
-     * @return $this
-     */
-    private function saveAddress($cartId, $address)
-    {
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->quoteRepository->getActive($cartId);
-
-        if (!$quote->isVirtual()) {
-            $addressData = [
-                EstimateAddressInterface::KEY_COUNTRY_ID => $address->getCountryId(),
-                EstimateAddressInterface::KEY_POSTCODE   => $address->getPostcode(),
-                EstimateAddressInterface::KEY_REGION_ID  => $address->getRegionId(),
-                EstimateAddressInterface::KEY_REGION     => $address->getRegion()
-            ];
-
-            $shippingAddress = $quote->getShippingAddress();
-            try {
-                $shippingAddress->addData($addressData)
-                    ->save();
-                $this->quoteRepository->save($quote);
-            } catch (\Exception $e) {
-                return $this;
-            }
-        }
-
-        return $this;
-    }
+	/**
+	 * Quote repository.
+	 *
+	 * @var \Magento\Quote\Api\CartRepositoryInterface
+	 */
+	protected $quoteRepository;
+
+	/**
+	 * Customer Address repository
+	 *
+	 * @var \Magento\Customer\Api\AddressRepositoryInterface
+	 */
+	protected $addressRepository;
+
+	/**
+	 * @param \Magento\Quote\Api\CartRepositoryInterface $quoteRepository
+	 * @param \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
+	 */
+	public function __construct(
+		\Magento\Quote\Api\CartRepositoryInterface $quoteRepository,
+		\Magento\Customer\Api\AddressRepositoryInterface $addressRepository
+	)
+	{
+
+		$this->quoteRepository   = $quoteRepository;
+		$this->addressRepository = $addressRepository;
+	}
+
+	/**
+	 * @param \Magento\Quote\Model\ShippingMethodManagement $subject
+	 * @param \Closure $proceed
+	 * @param $cartId
+	 * @param EstimateAddressInterface $address
+	 * @return array
+	 */
+	public function aroundEstimateByAddress(
+		\Magento\Quote\Model\ShippingMethodManagement $subject,
+		\Closure $proceed,
+		$cartId,
+		EstimateAddressInterface $address
+	)
+	{
+
+		$this->saveAddress($cartId, $address);
+
+		return $proceed($cartId, $address);
+	}
+
+	/**
+	 * @param \Magento\Quote\Model\ShippingMethodManagement $subject
+	 * @param \Closure $proceed
+	 * @param $cartId
+	 * @param \Magento\Quote\Api\Data\AddressInterface $address
+	 * @return mixed
+	 */
+	public function aroundEstimateByExtendedAddress(
+		\Magento\Quote\Model\ShippingMethodManagement $subject,
+		\Closure $proceed,
+		$cartId,
+		AddressInterface $address
+	)
+	{
+
+		$this->saveAddress($cartId, $address);
+
+		return $proceed($cartId, $address);
+	}
+
+	/**
+	 * @param \Magento\Quote\Model\ShippingMethodManagement $subject
+	 * @param \Closure $proceed
+	 * @param $cartId
+	 * @param $addressId
+	 * @return mixed
+	 */
+	public function aroundEstimateByAddressId(
+		\Magento\Quote\Model\ShippingMethodManagement $subject,
+		\Closure $proceed,
+		$cartId,
+		$addressId
+	)
+	{
+
+		$address = $this->addressRepository->getById($addressId);
+		$this->saveAddress($cartId, $address);
+
+		return $proceed($cartId, $addressId);
+	}
+
+	/**
+	 * @param $cartId
+	 * @param $address
+	 * @return $this
+	 */
+	private function saveAddress($cartId, $address)
+	{
+		/** @var \Magento\Quote\Model\Quote $quote */
+		$quote = $this->quoteRepository->getActive($cartId);
+
+		if (!$quote->isVirtual()) {
+			$addressData = [
+				EstimateAddressInterface::KEY_COUNTRY_ID => $address->getCountryId(),
+				EstimateAddressInterface::KEY_POSTCODE   => $address->getPostcode(),
+				EstimateAddressInterface::KEY_REGION_ID  => $address->getRegionId(),
+				EstimateAddressInterface::KEY_REGION     => $address->getRegion()
+			];
+
+			$shippingAddress = $quote->getShippingAddress();
+			try {
+				$shippingAddress->addData($addressData)
+					->save();
+				$this->quoteRepository->save($quote);
+			} catch (\Exception $e) {
+				return $this;
+			}
+		}
+
+		return $this;
+	}
 }
diff --git a/Model/Plugin/Customer/Address.php b/Model/Plugin/Customer/Address.php
index 368598d..5a54fb4 100644
--- a/Model/Plugin/Customer/Address.php
+++ b/Model/Plugin/Customer/Address.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model\Plugin\Customer;
 
 use Magento\Customer\Api\Data\AddressInterface;
@@ -29,21 +28,21 @@ use Magento\Customer\Api\Data\AddressInterface;
  */
 class Address
 {
-    /**
-     * @param \Magento\Customer\Model\Address $subject
-     * @param \Closure $proceed
-     * @param \Magento\Customer\Api\Data\AddressInterface $address
-     * @return mixed
-     */
-    public function aroundUpdateData(\Magento\Customer\Model\Address $subject, \Closure $proceed, AddressInterface $address)
-    {
-        $object = $proceed($address);
+	/**
+	 * @param \Magento\Customer\Model\Address $subject
+	 * @param \Closure $proceed
+	 * @param \Magento\Customer\Api\Data\AddressInterface $address
+	 * @return mixed
+	 */
+	public function aroundUpdateData(\Magento\Customer\Model\Address $subject, \Closure $proceed, AddressInterface $address)
+	{
+		$object = $proceed($address);
 
-        $addressData = $address->__toArray();
-        if (isset($addressData['should_ignore_validation'])) {
-            $object->setShouldIgnoreValidation($addressData['should_ignore_validation']);
-        }
+		$addressData = $address->__toArray();
+		if (isset($addressData['should_ignore_validation'])) {
+			$object->setShouldIgnoreValidation($addressData['should_ignore_validation']);
+		}
 
-        return $object;
-    }
+		return $object;
+	}
 }
diff --git a/Model/Plugin/Eav/Model/Validator/Attribute/Data.php b/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
deleted file mode 100644
index 73720bc..0000000
--- a/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model\Plugin\Eav\Model\Validator\Attribute;
-
-class Data extends \Magento\Eav\Model\Validator\Attribute\Data
-{
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
-    protected $_oscHelperData;
-
-    /**
-     * Data constructor.
-     * @param \Magento\Eav\Model\AttributeDataFactory $attrDataFactory
-     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
-     */
-    public function __construct(
-        \Magento\Eav\Model\AttributeDataFactory $attrDataFactory,
-        \Mageplaza\Osc\Helper\Data $oscHelperData
-    )
-    {
-        parent::__construct($attrDataFactory);
-        $this->_oscHelperData = $oscHelperData;
-    }
-
-    /**
-     * @param \Magento\Eav\Model\Validator\Attribute\Data $subject
-     * @param bool $result
-     * @return bool
-     */
-    public function afterIsValid(\Magento\Eav\Model\Validator\Attribute\Data $subject, $result)
-    {
-        if ($this->_oscHelperData->isFlagOscMethodRegister()) {
-            $subject->_messages = [];
-
-            return count($subject->_messages) == 0;
-        }
-
-        return $result;
-    }
-}
\ No newline at end of file
diff --git a/Model/Plugin/Paypal/Model/Express.php b/Model/Plugin/Paypal/Model/Express.php
deleted file mode 100644
index 8f80ca7..0000000
--- a/Model/Plugin/Paypal/Model/Express.php
+++ /dev/null
@@ -1,47 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model\Plugin\Paypal\Model;
-
-use Magento\Quote\Api\Data\PaymentInterface;
-
-/**
- * Class Express
- * @package Mageplaza\Osc\Model\Plugin\Paypal\Model
- */
-class Express
-{
-    /**
-     * @param \Magento\Paypal\Model\Express $express
-     * @param \Magento\Framework\DataObject $data
-     * @return array
-     */
-    public function beforeAssignData(\Magento\Paypal\Model\Express $express, \Magento\Framework\DataObject $data)
-    {
-        $additionalData = $data->getData(PaymentInterface::KEY_ADDITIONAL_DATA);
-        if (is_array($additionalData) && isset($additionalData['extension_attributes'])) {
-            unset($additionalData['extension_attributes']);
-            $data->setData(PaymentInterface::KEY_ADDITIONAL_DATA, $additionalData);
-        }
-
-        return [$data];
-    }
-}
\ No newline at end of file
diff --git a/Model/Plugin/Quote/AccessChangeQuoteControl.php b/Model/Plugin/Quote/AccessChangeQuoteControl.php
deleted file mode 100644
index 9846844..0000000
--- a/Model/Plugin/Quote/AccessChangeQuoteControl.php
+++ /dev/null
@@ -1,99 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model\Plugin\Quote;
-
-use Magento\Authorization\Model\UserContextInterface;
-use Magento\Framework\Exception\StateException;
-use Magento\Quote\Api\CartRepositoryInterface;
-use Magento\Quote\Api\Data\CartInterface;
-use Magento\Quote\Model\Quote;
-
-/**
- * Class AccessChangeQuoteControl
- * @package Mageplaza\Osc\Model\Plugin\Quote
- */
-class AccessChangeQuoteControl
-{
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
-    protected $_oscHelperData;
-
-    /**
-     * @var UserContextInterface
-     */
-    protected $userContext;
-
-    /**
-     * AccessChangeQuoteControl constructor.
-     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
-     */
-    public function __construct(\Mageplaza\Osc\Helper\Data $oscHelperData, UserContextInterface $userContext)
-    {
-        $this->_oscHelperData = $oscHelperData;
-        $this->userContext    = $userContext;
-    }
-
-    /**
-     * Checks if change quote's customer id is allowed for current user.
-     *
-     * @param CartRepositoryInterface $subject
-     * @param Quote $quote
-     * @throws StateException if Guest has customer_id or Customer's customer_id not much with user_id
-     * or unknown user's type
-     * @return void
-     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
-     */
-    public function beforeSave(CartRepositoryInterface $subject, CartInterface $quote)
-    {
-        if (!$this->isAllowed($quote)) {
-            throw new StateException(__("Invalid state change requested"));
-        }
-    }
-
-    /**
-     * Checks if user is allowed to change the quote.
-     *
-     * @param Quote $quote
-     * @return bool
-     */
-    private function isAllowed(Quote $quote)
-    {
-        switch ($this->userContext->getUserType()) {
-            case UserContextInterface::USER_TYPE_CUSTOMER:
-                $isAllowed = ($quote->getCustomerId() == $this->userContext->getUserId());
-                break;
-            case UserContextInterface::USER_TYPE_GUEST:
-                $isAllowed = ($this->_oscHelperData->isFlagOscMethodRegister()
-                    || $quote->getCustomerId() === null);
-                break;
-            case UserContextInterface::USER_TYPE_ADMIN:
-            case UserContextInterface::USER_TYPE_INTEGRATION:
-                $isAllowed = true;
-                break;
-            default:
-                $isAllowed = false;
-        }
-
-        return $isAllowed;
-    }
-}
\ No newline at end of file
diff --git a/Model/Plugin/Quote/GiftWrap.php b/Model/Plugin/Quote/GiftWrap.php
index 3561074..8416931 100644
--- a/Model/Plugin/Quote/GiftWrap.php
+++ b/Model/Plugin/Quote/GiftWrap.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model\Plugin\Quote;
 
 use Magento\Quote\Api\Data\TotalSegmentExtensionFactory;
@@ -29,53 +28,53 @@ use Magento\Quote\Api\Data\TotalSegmentExtensionFactory;
  */
 class GiftWrap
 {
-    const GIFT_WRAP_CODE = 'osc_gift_wrap';
+	const GIFT_WRAP_CODE = 'osc_gift_wrap';
 
-    /**
-     * @var TotalSegmentExtensionFactory
-     */
-    protected $totalSegmentExtensionFactory;
+	/**
+	 * @var TotalSegmentExtensionFactory
+	 */
+	protected $totalSegmentExtensionFactory;
 
-    /**
-     * @param \Magento\Quote\Api\Data\TotalSegmentExtensionFactory $totalSegmentExtensionFactory
-     */
-    public function __construct(
-        TotalSegmentExtensionFactory $totalSegmentExtensionFactory
-    )
-    {
-        $this->totalSegmentExtensionFactory = $totalSegmentExtensionFactory;
-    }
+	/**
+	 * @param \Magento\Quote\Api\Data\TotalSegmentExtensionFactory $totalSegmentExtensionFactory
+	 */
+	public function __construct(
+		TotalSegmentExtensionFactory $totalSegmentExtensionFactory
+	)
+	{
+		$this->totalSegmentExtensionFactory = $totalSegmentExtensionFactory;
+	}
 
-    /**
-     * @param \Magento\Quote\Model\Cart\TotalsConverter $subject
-     * @param \Closure $proceed
-     * @param array $addressTotals
-     * @return mixed
-     */
-    public function aroundProcess(
-        \Magento\Quote\Model\Cart\TotalsConverter $subject,
-        \Closure $proceed,
-        array $addressTotals = []
-    )
-    {
-        $totalSegments = $proceed($addressTotals);
+	/**
+	 * @param \Magento\Quote\Model\Cart\TotalsConverter $subject
+	 * @param \Closure $proceed
+	 * @param array $addressTotals
+	 * @return mixed
+	 */
+	public function aroundProcess(
+		\Magento\Quote\Model\Cart\TotalsConverter $subject,
+		\Closure $proceed,
+		array $addressTotals = []
+	)
+	{
+		$totalSegments = $proceed($addressTotals);
 
-        if (!array_key_exists(self::GIFT_WRAP_CODE, $addressTotals)) {
-            return $totalSegments;
-        }
+		if (!array_key_exists(self::GIFT_WRAP_CODE, $addressTotals)) {
+			return $totalSegments;
+		}
 
-        $giftWrap = $addressTotals[self::GIFT_WRAP_CODE]->getData();
-        if (!array_key_exists('gift_wrap_amount', $giftWrap)) {
-            return $totalSegments;
-        }
+		$giftWrap = $addressTotals[self::GIFT_WRAP_CODE]->getData();
+		if (!array_key_exists('gift_wrap_amount', $giftWrap)) {
+			return $totalSegments;
+		}
 
-        $attributes = $totalSegments[self::GIFT_WRAP_CODE]->getExtensionAttributes();
-        if ($attributes === null) {
-            $attributes = $this->totalSegmentExtensionFactory->create();
-        }
-        $attributes->setGiftWrapAmount($giftWrap['gift_wrap_amount']);
-        $totalSegments[self::GIFT_WRAP_CODE]->setExtensionAttributes($attributes);
+		$attributes = $totalSegments[self::GIFT_WRAP_CODE]->getExtensionAttributes();
+		if ($attributes === null) {
+			$attributes = $this->totalSegmentExtensionFactory->create();
+		}
+		$attributes->setGiftWrapAmount($giftWrap['gift_wrap_amount']);
+		$totalSegments[self::GIFT_WRAP_CODE]->setExtensionAttributes($attributes);
 
-        return $totalSegments;
-    }
+		return $totalSegments;
+	}
 }
diff --git a/Model/Plugin/Quote/QuoteManagement.php b/Model/Plugin/Quote/QuoteManagement.php
deleted file mode 100644
index 5f68b46..0000000
--- a/Model/Plugin/Quote/QuoteManagement.php
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model\Plugin\Quote;
-
-use Magento\Quote\Model\Quote as QuoteEntity;
-
-class QuoteManagement
-{
-    /**
-     * @var \Mageplaza\Osc\Model\CheckoutRegister
-     */
-    protected $checkoutRegister;
-
-    public function __construct(\Mageplaza\Osc\Model\CheckoutRegister $checkoutRegister)
-    {
-        $this->checkoutRegister = $checkoutRegister;
-    }
-
-    /**
-     * @param \Magento\Quote\Model\QuoteManagement $subject
-     * @param QuoteEntity $quote
-     * @param array $orderData
-     * @return array
-     */
-    public function beforeSubmit(\Magento\Quote\Model\QuoteManagement $subject, QuoteEntity $quote, $orderData = [])
-    {
-        $this->checkoutRegister->checkRegisterNewCustomer();
-
-        return [$quote, $orderData];
-    }
-}
\ No newline at end of file
diff --git a/Model/System/Config/Source/AddressSuggest.php b/Model/System/Config/Source/AddressSuggest.php
index 5263421..a3aa97f 100644
--- a/Model/System/Config/Source/AddressSuggest.php
+++ b/Model/System/Config/Source/AddressSuggest.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 /**
diff --git a/Model/System/Config/Source/CheckboxStyle.php b/Model/System/Config/Source/CheckboxStyle.php
index a4eb1aa..938c663 100644
--- a/Model/System/Config/Source/CheckboxStyle.php
+++ b/Model/System/Config/Source/CheckboxStyle.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 /**
@@ -26,7 +25,7 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
 class CheckboxStyle
 {
     const STYLE_DEFAULT = 'default';
-    const FILLED_IN = 'filled_in';
+    const FILLED_IN     = 'filled_in';
 
     /**
      * @return array
diff --git a/Model/System/Config/Source/ComponentPosition.php b/Model/System/Config/Source/ComponentPosition.php
index ad8952e..659942c 100644
--- a/Model/System/Config/Source/ComponentPosition.php
+++ b/Model/System/Config/Source/ComponentPosition.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Model\AbstractModel;
@@ -27,19 +26,19 @@ use Magento\Framework\Model\AbstractModel;
  */
 class ComponentPosition extends AbstractModel
 {
-    const NOT_SHOW = 0;
-    const SHOW_IN_PAYMENT = 1;
-    const SHOW_IN_REVIEW = 2;
+	const NOT_SHOW = 0;
+	const SHOW_IN_PAYMENT = 1;
+	const SHOW_IN_REVIEW = 2;
 
-    /**
-     * @return array
-     */
-    public function toOptionArray()
-    {
-        return [
-            self::NOT_SHOW        => __('No'),
-            self::SHOW_IN_PAYMENT => __('In Payment Area'),
-            self::SHOW_IN_REVIEW  => __('In Review Area')
-        ];
-    }
+	/**
+	 * @return array
+	 */
+	public function toOptionArray()
+	{
+		return [
+			self::NOT_SHOW        => __('No'),
+			self::SHOW_IN_PAYMENT => __('In Payment Area'),
+			self::SHOW_IN_REVIEW  => __('In Review Area')
+		];
+	}
 }
\ No newline at end of file
diff --git a/Model/System/Config/Source/DeliveryTime.php b/Model/System/Config/Source/DeliveryTime.php
index 441a5b1..cf826aa 100644
--- a/Model/System/Config/Source/DeliveryTime.php
+++ b/Model/System/Config/Source/DeliveryTime.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Model\AbstractModel;
diff --git a/Model/System/Config/Source/Design.php b/Model/System/Config/Source/Design.php
index 4a6c26a..04d9e57 100644
--- a/Model/System/Config/Source/Design.php
+++ b/Model/System/Config/Source/Design.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 /**
@@ -25,9 +24,9 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
  */
 class Design
 {
-    const DESIGN_DEFAULT = 'default';
-    const DESIGN_FLAT = 'flat';
-    const DESIGN_MATERIAL = 'material';
+    const DESIGN_DEFAULT    = 'default';
+    const DESIGN_FLAT       = 'flat';
+    const DESIGN_MATERIAL   = 'material';
 
     /**
      * @return array
@@ -43,10 +42,10 @@ class Design
                 'label' => __('Flat'),
                 'value' => self::DESIGN_FLAT
             ],
-            [
-                'label' => __('Material'),
-                'value' => self::DESIGN_MATERIAL
-            ]
+			[
+				'label' => __('Material'),
+				'value' => self::DESIGN_MATERIAL
+			]
         ];
 
         return $options;
diff --git a/Model/System/Config/Source/Giftwrap.php b/Model/System/Config/Source/Giftwrap.php
index 6cfd732..ba7a86d 100644
--- a/Model/System/Config/Source/Giftwrap.php
+++ b/Model/System/Config/Source/Giftwrap.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 use Magento\Framework\Model\AbstractModel;
@@ -28,7 +27,7 @@ use Magento\Framework\Model\AbstractModel;
 class Giftwrap extends AbstractModel
 {
     const PER_ORDER = 0;
-    const PER_ITEM = 1;
+    const PER_ITEM  = 1;
 
     /**
      * @return array
diff --git a/Model/System/Config/Source/Layout.php b/Model/System/Config/Source/Layout.php
index 75df87f..7df97e8 100644
--- a/Model/System/Config/Source/Layout.php
+++ b/Model/System/Config/Source/Layout.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 /**
diff --git a/Model/System/Config/Source/PaymentMethods.php b/Model/System/Config/Source/PaymentMethods.php
index 358d00a..f61bf14 100644
--- a/Model/System/Config/Source/PaymentMethods.php
+++ b/Model/System/Config/Source/PaymentMethods.php
@@ -15,15 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
-use Magento\Framework\App\Config\ScopeConfigInterface;
 use Magento\Framework\Option\ArrayInterface;
-use Magento\Payment\Model\Method\Factory;
 use Magento\Store\Model\ScopeInterface;
 use Mageplaza\Osc\Helper\Config as OscConfig;
 
@@ -33,84 +30,84 @@ use Mageplaza\Osc\Helper\Config as OscConfig;
  */
 class PaymentMethods implements ArrayInterface
 {
-    /**
-     * @type \Magento\Framework\App\Config\ScopeConfigInterface
-     */
-    protected $_scopeConfig;
+	/**
+	 * @type \Magento\Framework\App\Config\ScopeConfigInterface
+	 */
+	protected $_scopeConfig;
 
-    /**
-     * @type \Magento\Payment\Model\Method\Factory
-     */
-    protected $_paymentMethodFactory;
+	/**
+	 * @type \Magento\Payment\Model\Method\Factory
+	 */
+	protected $_paymentMethodFactory;
 
-    /**
-     * @type \Mageplaza\Osc\Helper\Config
-     */
-    protected $_oscConfig;
+	/**
+	 * @type \Mageplaza\Osc\Helper\Config
+	 */
+	protected $_oscConfig;
 
-    /**
-     * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
-     * @param \Magento\Payment\Model\Method\Factory $paymentMethodFactory
-     * @param \Mageplaza\Osc\Helper\Config $oscConfig
-     */
-    public function __construct(
-        ScopeConfigInterface $scopeConfig,
-        Factory $paymentMethodFactory,
-        OscConfig $oscConfig
-    )
-    {
-        $this->_scopeConfig          = $scopeConfig;
-        $this->_paymentMethodFactory = $paymentMethodFactory;
-        $this->_oscConfig            = $oscConfig;
-    }
+	/**
+	 * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
+	 * @param \Magento\Payment\Model\Method\Factory $paymentMethodFactory
+	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
+	 */
+	public function __construct(
+		\Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
+		\Magento\Payment\Model\Method\Factory $paymentMethodFactory,
+		OscConfig $oscConfig
+	)
+	{
+		$this->_scopeConfig          = $scopeConfig;
+		$this->_paymentMethodFactory = $paymentMethodFactory;
+		$this->_oscConfig            = $oscConfig;
+	}
 
-    /**
-     * {@inheritdoc}
-     */
-    public function toOptionArray()
-    {
-        $options = [['label' => __('-- Please select --'), 'value' => '']];
+	/**
+	 * {@inheritdoc}
+	 */
+	public function toOptionArray()
+	{
+		$options = [['label' => __('-- Please select --'), 'value' => '']];
 
-        $payments = $this->getActiveMethods();
-        foreach ($payments as $paymentCode => $paymentModel) {
-            $options[$paymentCode] = array(
-                'label' => $paymentModel->getTitle(),
-                'value' => $paymentCode
-            );
-        }
+		$payments = $this->getActiveMethods();
+		foreach ($payments as $paymentCode => $paymentModel) {
+			$options[$paymentCode] = array(
+				'label' => $paymentModel->getTitle(),
+				'value' => $paymentCode
+			);
+		}
 
-        return $options;
-    }
+		return $options;
+	}
 
-    /**
-     * Get all active payment method
-     *
-     * @return array
-     */
-    public function getActiveMethods()
-    {
-        $methods       = [];
-        $paymentConfig = $this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null);
-        if ($this->_oscConfig->isEnabledMultiSafepay()) {
-            $paymentConfig = array_merge($this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null), $this->_scopeConfig->getValue('gateways', ScopeInterface::SCOPE_STORE, null));
-        }
-        foreach ($paymentConfig as $code => $data) {
-            if (isset($data['active'], $data['model']) && (bool)$data['active']) {
-                try {
-                    if (class_exists($data['model'])) {
-                        $methodModel = $this->_paymentMethodFactory->create($data['model']);
-                        $methodModel->setStore(null);
-                        if ($methodModel->getConfigData('active', null)) {
-                            $methods[$code] = $methodModel;
-                        }
-                    }
+	/**
+	 * Get all active payment method
+	 *
+	 * @return array
+	 */
+	public function getActiveMethods()
+	{
+		$methods       = [];
+		$paymentConfig = $this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null);
+		if ($this->_oscConfig->isEnabledMultiSafepay()) {
+			$paymentConfig = array_merge($this->_scopeConfig->getValue('payment', ScopeInterface::SCOPE_STORE, null), $this->_scopeConfig->getValue('gateways', ScopeInterface::SCOPE_STORE, null));
+		}
+		foreach ($paymentConfig as $code => $data) {
+			if (isset($data['active'], $data['model']) && (bool)$data['active']) {
+				try {
+					if (class_exists($data['model'])) {
+						$methodModel = $this->_paymentMethodFactory->create($data['model']);
+						$methodModel->setStore(null);
+						if ($methodModel->getConfigData('active', null)) {
+							$methods[$code] = $methodModel;
+						}
+					}
 
-                } catch (\Exception $e) {
-                    continue;
-                }
-            }
-        }
+				} catch (\Exception $e) {
+					continue;
+				}
+			}
+		}
 
-        return $methods;
-    }
+		return $methods;
+	}
 }
diff --git a/Model/System/Config/Source/RadioStyle.php b/Model/System/Config/Source/RadioStyle.php
index 7435e22..a830de0 100644
--- a/Model/System/Config/Source/RadioStyle.php
+++ b/Model/System/Config/Source/RadioStyle.php
@@ -13,10 +13,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement.html
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
 /**
@@ -25,8 +24,8 @@ namespace Mageplaza\Osc\Model\System\Config\Source;
  */
 class RadioStyle
 {
-    const STYLE_DEFAULT = 'default';
-    const WITH_GAP = 'with_gap';
+    const STYLE_DEFAULT   = 'default';
+    const WITH_GAP        = 'with_gap';
 
     /**
      * @return array
diff --git a/Model/System/Config/Source/ShippingMethods.php b/Model/System/Config/Source/ShippingMethods.php
index 51f31b2..34d28aa 100644
--- a/Model/System/Config/Source/ShippingMethods.php
+++ b/Model/System/Config/Source/ShippingMethods.php
@@ -15,12 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
+use Magento\Framework\App\ObjectManager;
 use Magento\Framework\App\Config\ScopeConfigInterface as StoreConfig;
 use Magento\Shipping\Model\Config as CarrierConfig;
 
@@ -49,8 +49,7 @@ class ShippingMethods
         StoreConfig $scopeConfig,
         CarrierConfig $carrierConfig,
         array $data = []
-    )
-    {
+    ) {
         $this->_scopeConfig   = $scopeConfig;
         $this->_carrierConfig = $carrierConfig;
     }
diff --git a/Model/System/Config/Source/Survey.php b/Model/System/Config/Source/Survey.php
index 5647cb3..a36a3ce 100644
--- a/Model/System/Config/Source/Survey.php
+++ b/Model/System/Config/Source/Survey.php
@@ -15,48 +15,36 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 namespace Mageplaza\Osc\Model\System\Config\Source;
+class Survey extends \Magento\Config\Block\System\Config\Form\Field\FieldArray\AbstractFieldArray{
+	/**
+	 * @var \Magento\Framework\Data\Form\Element\Factory
+	 */
+	protected $_elementFactory;
 
-use Magento\Config\Block\System\Config\Form\Field\FieldArray\AbstractFieldArray;
+	/**
+	 * @param \Magento\Backend\Block\Template\Context $context
+	 * @param \Magento\Framework\Data\Form\Element\Factory $elementFactory
+	 * @param array $data
+	 */
+	public function __construct(
+		\Magento\Backend\Block\Template\Context $context,
+		\Magento\Framework\Data\Form\Element\Factory $elementFactory,
+		array $data = []
+	) {
 
-/**
- * Class Survey
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
-class Survey extends AbstractFieldArray
-{
-    /**
-     * @var \Magento\Framework\Data\Form\Element\Factory
-     */
-    protected $_elementFactory;
-
-    /**
-     * @param \Magento\Backend\Block\Template\Context $context
-     * @param \Magento\Framework\Data\Form\Element\Factory $elementFactory
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Backend\Block\Template\Context $context,
-        \Magento\Framework\Data\Form\Element\Factory $elementFactory,
-        array $data = []
-    )
-    {
-        $this->_elementFactory = $elementFactory;
-        parent::__construct($context, $data);
-    }
-
-    /**
-     * @inheritdoc
-     */
-    protected function _construct()
-    {
-        $this->addColumn('value', ['label' => __('Options')]);
-        $this->_addAfter       = false;
-        $this->_addButtonLabel = __('Add');
-        parent::_construct();
-    }
+		$this->_elementFactory  = $elementFactory;
+		parent::__construct($context, $data);
+	}
+	protected function _construct()
+	{
+		$this->addColumn('value', ['label' => __('Options')]);
+		$this->_addAfter = false;
+		$this->_addButtonLabel = __('Add');
+		parent::_construct();
+	}
 }
\ No newline at end of file
diff --git a/Model/Total/Creditmemo/GiftWrap.php b/Model/Total/Creditmemo/GiftWrap.php
index af17934..c273ede 100644
--- a/Model/Total/Creditmemo/GiftWrap.php
+++ b/Model/Total/Creditmemo/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -30,57 +30,57 @@ use Magento\Sales\Model\Order\Creditmemo\Total\AbstractTotal;
  */
 class GiftWrap extends AbstractTotal
 {
-    /**
-     * @param \Magento\Sales\Model\Order\Creditmemo $creditmemo
-     * @return $this|void
-     */
-    public function collect(Creditmemo $creditmemo)
-    {
-        $order = $creditmemo->getOrder();
-        if ($order->getOscGiftWrapAmount() < 0.0001) {
-            return $this;
-        }
-        $totalGiftWrapAmount     = 0;
-        $totalBaseGiftWrapAmount = 0;
-        if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
-            foreach ($creditmemo->getAllItems() as $item) {
-                $orderItem = $item->getOrderItem();
-                if ($orderItem->isDummy() || ($orderItem->getOscGiftWrapAmount() < 0.001)) {
-                    continue;
-                }
-                $rate = $item->getQty() / $orderItem->getQtyOrdered();
+	/**
+	 * @param \Magento\Sales\Model\Order\Creditmemo $creditmemo
+	 * @return $this|void
+	 */
+	public function collect(Creditmemo $creditmemo)
+	{
+		$order = $creditmemo->getOrder();
+		if ($order->getOscGiftWrapAmount() < 0.0001) {
+			return $this;
+		}
+		$totalGiftWrapAmount     = 0;
+		$totalBaseGiftWrapAmount = 0;
+		if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
+			foreach ($creditmemo->getAllItems() as $item) {
+				$orderItem = $item->getOrderItem();
+				if ($orderItem->isDummy() || ($orderItem->getOscGiftWrapAmount() < 0.001)) {
+					continue;
+				}
+				$rate = $item->getQty() / $orderItem->getQtyOrdered();
 
-                $totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
-                $totalGiftWrapAmount     += $orderItem->getOscGiftWrapAmount() * $rate;
-            }
-        } else if ($this->isLast($creditmemo)) {
-            $totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
-            $totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
-        }
+				$totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
+				$totalGiftWrapAmount += $orderItem->getOscGiftWrapAmount() * $rate;
+			}
+		} else if ($this->isLast($creditmemo)) {
+			$totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
+			$totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
+		}
 
-        $creditmemo->setBaseOscGiftWrapAmount($totalBaseGiftWrapAmount);
-        $creditmemo->setOscGiftWrapAmount($totalGiftWrapAmount);
+		$creditmemo->setBaseOscGiftWrapAmount($totalBaseGiftWrapAmount);
+		$creditmemo->setOscGiftWrapAmount($totalGiftWrapAmount);
 
-        $creditmemo->setGrandTotal($creditmemo->getGrandTotal() + $totalGiftWrapAmount);
-        $creditmemo->setBaseGrandTotal($creditmemo->getBaseGrandTotal() + $totalBaseGiftWrapAmount);
+		$creditmemo->setGrandTotal($creditmemo->getGrandTotal() + $totalGiftWrapAmount);
+		$creditmemo->setBaseGrandTotal($creditmemo->getBaseGrandTotal() + $totalBaseGiftWrapAmount);
 
-        return $this;
-    }
+		return $this;
+	}
 
-    /**
-     * check credit memo is last or not
-     *
-     * @param Creditmemo $creditmemo
-     * @return boolean
-     */
-    public function isLast($creditmemo)
-    {
-        foreach ($creditmemo->getAllItems() as $item) {
-            if (!$item->isLast()) {
-                return false;
-            }
-        }
+	/**
+	 * check credit memo is last or not
+	 *
+	 * @param Creditmemo $creditmemo
+	 * @return boolean
+	 */
+	public function isLast($creditmemo)
+	{
+		foreach ($creditmemo->getAllItems() as $item) {
+			if (!$item->isLast()) {
+				return false;
+			}
+		}
 
-        return true;
-    }
+		return true;
+	}
 }
diff --git a/Model/Total/Invoice/GiftWrap.php b/Model/Total/Invoice/GiftWrap.php
index e667131..30a3c23 100644
--- a/Model/Total/Invoice/GiftWrap.php
+++ b/Model/Total/Invoice/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -30,44 +30,44 @@ use Magento\Sales\Model\Order\Invoice\Total\AbstractTotal;
  */
 class GiftWrap extends AbstractTotal
 {
-    /**
-     * @param \Magento\Sales\Model\Order\Invoice $invoice
-     * @return $this
-     */
-    public function collect(Invoice $invoice)
-    {
-        $order = $invoice->getOrder();
-        if ($order->getOscGiftWrapAmount() < 0.0001) {
-            return $this;
-        }
-        $totalGiftWrapAmount     = 0;
-        $totalBaseGiftWrapAmount = 0;
+	/**
+	 * @param \Magento\Sales\Model\Order\Invoice $invoice
+	 * @return $this
+	 */
+	public function collect(Invoice $invoice)
+	{
+		$order = $invoice->getOrder();
+		if ($order->getOscGiftWrapAmount() < 0.0001) {
+			return $this;
+		}
+		$totalGiftWrapAmount     = 0;
+		$totalBaseGiftWrapAmount = 0;
 
-        if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
-            foreach ($invoice->getAllItems() as $item) {
-                $orderItem = $item->getOrderItem();
-                if ($orderItem->isDummy() || ($orderItem->getOscGiftWrapAmount() < 0.001)) {
-                    continue;
-                }
-                $rate = $item->getQty() / $orderItem->getQtyOrdered();
+		if ($order->getGiftWrapType() == \Mageplaza\Osc\Model\System\Config\Source\Giftwrap::PER_ITEM) {
+			foreach ($invoice->getAllItems() as $item) {
+				$orderItem = $item->getOrderItem();
+				if ($orderItem->isDummy() || ($orderItem->getOscGiftWrapAmount() < 0.001)) {
+					continue;
+				}
+				$rate = $item->getQty() / $orderItem->getQtyOrdered();
 
-                $totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
-                $totalGiftWrapAmount     += $orderItem->getOscGiftWrapAmount() * $rate;
-            }
-        } else {
-            $invoiceCollections = $order->getInvoiceCollection();
-            if ($invoiceCollections->getSize() == 0) {
-                $totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
-                $totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
-            }
-        }
-        $invoice->setBaseOscGiftWrapAmount($totalBaseGiftWrapAmount);
-        $invoice->setOscGiftWrapAmount($totalGiftWrapAmount);
+				$totalBaseGiftWrapAmount += $orderItem->getBaseOscGiftWrapAmount() * $rate;
+				$totalGiftWrapAmount += $orderItem->getOscGiftWrapAmount() * $rate;
+			}
+		} else {
+			$invoiceCollections = $order->getInvoiceCollection();
+			if ($invoiceCollections->getSize() == 0) {
+				$totalGiftWrapAmount     = $order->getOscGiftWrapAmount();
+				$totalBaseGiftWrapAmount = $order->getBaseOscGiftWrapAmount();
+			}
+		}
+		$invoice->setBaseOscGiftWrapAmount($totalBaseGiftWrapAmount);
+		$invoice->setOscGiftWrapAmount($totalGiftWrapAmount);
 
-        $invoice->setGrandTotal($invoice->getGrandTotal() + $totalGiftWrapAmount);
-        $invoice->setBaseGrandTotal($invoice->getBaseGrandTotal() + $totalBaseGiftWrapAmount);
+		$invoice->setGrandTotal($invoice->getGrandTotal() + $totalGiftWrapAmount);
+		$invoice->setBaseGrandTotal($invoice->getBaseGrandTotal() + $totalBaseGiftWrapAmount);
 
-        return $this;
-    }
+		return $this;
+	}
 
 }
diff --git a/Model/Total/Quote/GiftWrap.php b/Model/Total/Quote/GiftWrap.php
index 6cfa1d5..8a76fdd 100644
--- a/Model/Total/Quote/GiftWrap.php
+++ b/Model/Total/Quote/GiftWrap.php
@@ -15,21 +15,20 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Model\Total\Quote;
 
 use Magento\Checkout\Model\Session;
-use Magento\Framework\Pricing\PriceCurrencyInterface;
-use Magento\Quote\Api\Data\ShippingAssignmentInterface;
 use Magento\Quote\Model\Quote;
 use Magento\Quote\Model\Quote\Address;
 use Magento\Quote\Model\Quote\Address\Total;
+use Magento\Quote\Api\Data\ShippingAssignmentInterface;
 use Magento\Quote\Model\Quote\Address\Total\AbstractTotal;
-use Mageplaza\Osc\Helper\Config as HelperConfig;
+use Magento\Framework\Pricing\PriceCurrencyInterface;
 use Mageplaza\Osc\Model\System\Config\Source\Giftwrap as SourceGiftwrap;
+use Mageplaza\Osc\Helper\Config as HelperConfig;
 
 /**
  * Class GiftWrap
@@ -37,131 +36,131 @@ use Mageplaza\Osc\Model\System\Config\Source\Giftwrap as SourceGiftwrap;
  */
 class GiftWrap extends AbstractTotal
 {
-    /**
-     * @type \Mageplaza\Osc\Helper\Config
-     */
-    protected $_helperConfig;
-
-    /**
-     * @type \Magento\Checkout\Model\Session
-     */
-    protected $_checkoutSession;
-
-    /**
-     * @type \Magento\Framework\Pricing\PriceCurrencyInterface
-     */
-    protected $priceCurrency;
-
-    /**
-     * @type
-     */
-    protected $_baseGiftWrapAmount;
-
-    /**
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Mageplaza\Osc\Helper\Config $helperConfig
-     * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
-     */
-    public function __construct(
-        Session $checkoutSession,
-        HelperConfig $helperConfig,
-        PriceCurrencyInterface $priceCurrency
-    )
-    {
-        $this->_checkoutSession = $checkoutSession;
-        $this->_helperConfig    = $helperConfig;
-        $this->priceCurrency    = $priceCurrency;
-
-        $this->setCode('osc_gift_wrap');
-    }
-
-
-    /**
-     * Collect gift wrap totals
-     *
-     * @param Quote $quote
-     * @param ShippingAssignmentInterface $shippingAssignment
-     * @param Total $total
-     * @return $this
-     */
-    public function collect(
-        Quote $quote,
-        ShippingAssignmentInterface $shippingAssignment,
-        Total $total
-    )
-    {
-        parent::collect($quote, $shippingAssignment, $total);
-
-        if ($this->_helperConfig->isDisabledGiftWrap() ||
-            ($shippingAssignment->getShipping()->getAddress()->getAddressType() !== Address::TYPE_SHIPPING) ||
-            !$quote->getShippingAddress()->getUsedGiftWrap()
-        ) {
-            return $this;
-        }
-
-        $baseOscGiftWrapAmount = $this->calculateGiftWrapAmount($quote);
-        $oscGiftWrapAmount     = $this->priceCurrency->convert($baseOscGiftWrapAmount, $quote->getStore());
-
-        $this->_addAmount($oscGiftWrapAmount);
-        $this->_addBaseAmount($baseOscGiftWrapAmount);
-
-        return $this;
-    }
-
-    /**
-     * Assign gift wrap amount and label to address object
-     *
-     * @param \Magento\Quote\Model\Quote $quote
-     * @param Address\Total $total
-     * @return array
-     */
-    public function fetch(Quote $quote, Total $total)
-    {
-        $amount = $total->getOscGiftWrapAmount();
-
-        $baseInitAmount = $this->calculateGiftWrapAmount($quote);
-        $initAmount     = $this->priceCurrency->convert($baseInitAmount, $quote->getStore());
-
-        return [
-            'code'             => $this->getCode(),
-            'title'            => __('Gift Wrap'),
-            'value'            => $amount,
-            'gift_wrap_amount' => $initAmount
-        ];
-    }
-
-    /**
-     * @param $quote
-     * @return int|mixed
-     */
-    public function calculateGiftWrapAmount($quote)
-    {
-        if ($this->_baseGiftWrapAmount == null) {
-            $baseOscGiftWrapAmount = $this->_helperConfig->getOrderGiftwrapAmount();
-            if ($baseOscGiftWrapAmount == 0) {
-                return 0;
-            }
-
-            $giftWrapType = $this->_helperConfig->getGiftWrapType();
-            if ($giftWrapType == SourceGiftwrap::PER_ITEM) {
-                $giftWrapBaseAmount    = $baseOscGiftWrapAmount;
-                $baseOscGiftWrapAmount = 0;
-                foreach ($quote->getAllVisibleItems() as $item) {
-                    if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
-                        continue;
-                    }
-                    $baseItemGiftWrapAmount = $giftWrapBaseAmount * $item->getQty();
-                    $item->setBaseOscGiftWrapAmount($baseItemGiftWrapAmount);
-                    $item->setOscGiftWrapAmount($this->priceCurrency->convert($baseItemGiftWrapAmount, $quote->getStore()));
-
-                    $baseOscGiftWrapAmount += $baseItemGiftWrapAmount;
-                }
-            }
-            $quote->getShippingAddress()->setGiftWrapType($giftWrapType);
-
-            $this->_baseGiftWrapAmount = $baseOscGiftWrapAmount;
-        }
-
-        return $this->_baseGiftWrapAmount;
-    }
+	/**
+	 * @type \Mageplaza\Osc\Helper\Config
+	 */
+	protected $_helperConfig;
+
+	/**
+	 * @type \Magento\Checkout\Model\Session
+	 */
+	protected $_checkoutSession;
+
+	/**
+	 * @type \Magento\Framework\Pricing\PriceCurrencyInterface
+	 */
+	protected $priceCurrency;
+
+	/**
+	 * @type
+	 */
+	protected $_baseGiftWrapAmount;
+
+	/**
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Mageplaza\Osc\Helper\Config $helperConfig
+	 * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
+	 */
+	public function __construct(
+		Session $checkoutSession,
+		HelperConfig $helperConfig,
+		PriceCurrencyInterface $priceCurrency
+	)
+	{
+		$this->_checkoutSession = $checkoutSession;
+		$this->_helperConfig    = $helperConfig;
+		$this->priceCurrency    = $priceCurrency;
+
+		$this->setCode('osc_gift_wrap');
+	}
+
+
+	/**
+	 * Collect gift wrap totals
+	 *
+	 * @param Quote $quote
+	 * @param ShippingAssignmentInterface $shippingAssignment
+	 * @param Total $total
+	 * @return $this
+	 */
+	public function collect(
+		Quote $quote,
+		ShippingAssignmentInterface $shippingAssignment,
+		Total $total
+	)
+	{
+		parent::collect($quote, $shippingAssignment, $total);
+
+		if ($this->_helperConfig->isDisabledGiftWrap() ||
+			($shippingAssignment->getShipping()->getAddress()->getAddressType() !== Address::TYPE_SHIPPING) ||
+			!$quote->getShippingAddress()->getUsedGiftWrap()
+		) {
+			return $this;
+		}
+
+		$baseOscGiftWrapAmount = $this->calculateGiftWrapAmount($quote);
+		$oscGiftWrapAmount     = $this->priceCurrency->convert($baseOscGiftWrapAmount, $quote->getStore());
+
+		$this->_addAmount($oscGiftWrapAmount);
+		$this->_addBaseAmount($baseOscGiftWrapAmount);
+
+		return $this;
+	}
+
+	/**
+	 * Assign gift wrap amount and label to address object
+	 *
+	 * @param \Magento\Quote\Model\Quote $quote
+	 * @param Address\Total $total
+	 * @return array
+	 */
+	public function fetch(Quote $quote, Total $total)
+	{
+		$amount = $total->getOscGiftWrapAmount();
+
+		$baseInitAmount = $this->calculateGiftWrapAmount($quote);
+		$initAmount     = $this->priceCurrency->convert($baseInitAmount, $quote->getStore());
+
+		return [
+			'code'             => $this->getCode(),
+			'title'            => __('Gift Wrap'),
+			'value'            => $amount,
+			'gift_wrap_amount' => $initAmount
+		];
+	}
+
+	/**
+	 * @param $quote
+	 * @return int|mixed
+	 */
+	public function calculateGiftWrapAmount($quote)
+	{
+		if ($this->_baseGiftWrapAmount == null) {
+			$baseOscGiftWrapAmount = $this->_helperConfig->getOrderGiftwrapAmount();
+			if ($baseOscGiftWrapAmount == 0) {
+				return 0;
+			}
+
+			$giftWrapType = $this->_helperConfig->getGiftWrapType();
+			if ($giftWrapType == SourceGiftwrap::PER_ITEM) {
+				$giftWrapBaseAmount    = $baseOscGiftWrapAmount;
+				$baseOscGiftWrapAmount = 0;
+				foreach ($quote->getAllVisibleItems() as $item) {
+					if ($item->getProduct()->isVirtual() || $item->getParentItem()) {
+						continue;
+					}
+					$baseItemGiftWrapAmount = $giftWrapBaseAmount * $item->getQty();
+					$item->setBaseOscGiftWrapAmount($baseItemGiftWrapAmount);
+					$item->setOscGiftWrapAmount($this->priceCurrency->convert($baseItemGiftWrapAmount, $quote->getStore()));
+
+					$baseOscGiftWrapAmount += $baseItemGiftWrapAmount;
+				}
+			}
+			$quote->getShippingAddress()->setGiftWrapType($giftWrapType);
+
+			$this->_baseGiftWrapAmount = $baseOscGiftWrapAmount;
+		}
+
+		return $this->_baseGiftWrapAmount;
+	}
 }
diff --git a/Observer/CheckoutSubmitBefore.php b/Observer/CheckoutSubmitBefore.php
new file mode 100644
index 0000000..96f70e4
--- /dev/null
+++ b/Observer/CheckoutSubmitBefore.php
@@ -0,0 +1,186 @@
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
+namespace Mageplaza\Osc\Observer;
+
+use Magento\Framework\Event\ObserverInterface;
+use Magento\Quote\Model\Quote;
+use Magento\Quote\Model\CustomerManagement;
+
+/**
+ * Class CheckoutSubmitBefore
+ * @package Mageplaza\Osc\Observer
+ */
+class CheckoutSubmitBefore implements ObserverInterface
+{
+	/**
+	 * @var \Magento\Checkout\Model\Session
+	 */
+	protected $checkoutSession;
+
+	/**
+	 * @type \Magento\Framework\DataObject\Copy
+	 */
+	protected $_objectCopyService;
+
+	/**
+	 * @type \Magento\Framework\Api\DataObjectHelper
+	 */
+	protected $dataObjectHelper;
+
+	/**
+	 * @type \Magento\Customer\Api\AccountManagementInterface
+	 */
+	protected $accountManagement;
+
+	/**
+	 * @var CustomerManagement
+	 */
+	protected $customerManagement;
+
+	/**
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Magento\Framework\DataObject\Copy $objectCopyService
+	 * @param \Magento\Framework\Api\DataObjectHelper $dataObjectHelper
+	 * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
+	 * @param \Magento\Quote\Model\CustomerManagement $customerManagement
+	 */
+	public function __construct(
+		\Magento\Checkout\Model\Session $checkoutSession,
+		\Magento\Framework\DataObject\Copy $objectCopyService,
+		\Magento\Framework\Api\DataObjectHelper $dataObjectHelper,
+		\Magento\Customer\Api\AccountManagementInterface $accountManagement,
+		CustomerManagement $customerManagement
+	)
+	{
+		$this->checkoutSession    = $checkoutSession;
+		$this->_objectCopyService = $objectCopyService;
+		$this->dataObjectHelper   = $dataObjectHelper;
+		$this->accountManagement  = $accountManagement;
+		$this->customerManagement = $customerManagement;
+	}
+
+	/**
+	 * @param \Magento\Framework\Event\Observer $observer
+	 * @return void
+	 * @SuppressWarnings(PHPMD.UnusedFormalParameter)
+	 */
+	public function execute(\Magento\Framework\Event\Observer $observer)
+	{
+		/** @type \Magento\Quote\Model\Quote $quote */
+		$quote = $observer->getEvent()->getQuote();
+
+		/** Validate address */
+		$this->validateAddressBeforeSubmit($quote);
+
+		/** One step check out additional data */
+		$oscData = $this->checkoutSession->getOscData();
+
+		/** Create account when checkout */
+		if (isset($oscData['register']) && $oscData['register']
+			&& isset($oscData['password']) && $oscData['password']
+		) {
+			$quote->setCheckoutMethod(\Magento\Checkout\Model\Type\Onepage::METHOD_REGISTER)
+				->setCustomerIsGuest(false)
+				->setCustomerGroupId(null)
+				->setPasswordHash($this->accountManagement->getPasswordHash($oscData['password']));
+
+			$this->_prepareNewCustomerQuote($quote, $oscData);
+		}
+	}
+
+	/**
+	 * Prepare quote for customer registration and customer order submit
+	 *
+	 * @param \Magento\Quote\Model\Quote $quote
+	 * @return void
+	 */
+	protected function _prepareNewCustomerQuote(Quote $quote, $oscData)
+	{
+		$billing  = $quote->getBillingAddress();
+		$shipping = $quote->isVirtual() ? null : $quote->getShippingAddress();
+
+		$customer  = $quote->getCustomer();
+		$dataArray = $billing->getData();
+		if (isset($oscData['customerAttributes']) && $oscData['customerAttributes']) {
+			$dataArray = array_merge($dataArray, $oscData['customerAttributes']);
+		}
+
+		$this->dataObjectHelper->populateWithArray(
+			$customer,
+			$dataArray,
+			'\Magento\Customer\Api\Data\CustomerInterface'
+		);
+
+		$quote->setCustomer($customer);
+
+		/** Create customer */
+		$this->customerManagement->populateCustomerInfo($quote);
+
+		/** Init customer address */
+		$customerBillingData = $billing->exportCustomerAddress();
+		$customerBillingData->setIsDefaultBilling(true)
+			->setData('should_ignore_validation', true);
+
+		if ($shipping) {
+			if (isset($oscData['same_as_shipping']) && $oscData['same_as_shipping']) {
+				$shipping->setCustomerAddressData($customerBillingData);
+				$customerBillingData->setIsDefaultShipping(true);
+			} else {
+				$customerShippingData = $shipping->exportCustomerAddress();
+				$customerShippingData->setIsDefaultShipping(true)
+					->setData('should_ignore_validation', true);
+				$shipping->setCustomerAddressData($customerShippingData);
+				// Add shipping address to quote since customer Data Object does not hold address information
+				$quote->addCustomerAddress($customerShippingData);
+			}
+		} else {
+			$customerBillingData->setIsDefaultShipping(true);
+		}
+		$billing->setCustomerAddressData($customerBillingData);
+		// Add billing address to quote since customer Data Object does not hold address information
+		$quote->addCustomerAddress($customerBillingData);
+
+		// If customer is created, set customerId for address to avoid create more address when checkout
+		if ($customerId = $quote->getCustomerId()) {
+			$billing->setCustomerId($customerId);
+			if($shipping) {
+				$shipping->setCustomerId($customerId);
+			}
+		}
+	}
+
+	/**
+	 * @param \Magento\Quote\Model\Quote $quote
+	 * @return $this
+	 */
+	public function validateAddressBeforeSubmit(\Magento\Quote\Model\Quote $quote)
+	{
+		/** Remove address validation */
+		if (!$quote->isVirtual()) {
+			$quote->getShippingAddress()->setShouldIgnoreValidation(true);
+		}
+		$quote->getBillingAddress()->setShouldIgnoreValidation(true);
+
+		// TODO : Validate address (depend on field require, show on osc or not)
+
+		return $this;
+	}
+}
diff --git a/Observer/IsAllowedGuestCheckoutObserver.php b/Observer/IsAllowedGuestCheckoutObserver.php
index 6c85412..4d93645 100644
--- a/Observer/IsAllowedGuestCheckoutObserver.php
+++ b/Observer/IsAllowedGuestCheckoutObserver.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Observer;
 
 use Magento\Framework\Event\ObserverInterface;
@@ -29,36 +28,28 @@ use Magento\Framework\Event\ObserverInterface;
  */
 class IsAllowedGuestCheckoutObserver extends \Magento\Downloadable\Observer\IsAllowedGuestCheckoutObserver implements ObserverInterface
 {
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
-    protected $_helper;
+	protected $_helper;
 
-    /**
-     * IsAllowedGuestCheckoutObserver constructor.
-     * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
-     * @param \Mageplaza\Osc\Helper\Data $helper
-     */
-    public function __construct(
-        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
-        \Mageplaza\Osc\Helper\Data $helper
-    )
-    {
-        $this->_helper = $helper;
+	public function __construct(
+		\Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
+		\Mageplaza\Osc\Helper\Data $helper
+	)
+	{
+		$this->_helper = $helper;
 
-        parent::__construct($scopeConfig);
-    }
+		parent::__construct($scopeConfig);
+	}
 
-    /**
-     * @param \Magento\Framework\Event\Observer $observer
-     * @return $this
-     */
-    public function execute(\Magento\Framework\Event\Observer $observer)
-    {
-        if ($this->_helper->isEnabled()) {
-            return $this;
-        }
+	/**
+	 * @param \Magento\Framework\Event\Observer $observer
+	 * @return $this
+	 */
+	public function execute(\Magento\Framework\Event\Observer $observer)
+	{
+		if ($this->_helper->isEnabled()) {
+			return $this;
+		}
 
-        return parent::execute($observer);
-    }
+		return parent::execute($observer);
+	}
 }
diff --git a/Observer/OscConfigObserver.php b/Observer/OscConfigObserver.php
index cbd85c4..e849a66 100644
--- a/Observer/OscConfigObserver.php
+++ b/Observer/OscConfigObserver.php
@@ -15,26 +15,23 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Observer;
 
 use Magento\Config\Model\ResourceModel\Config as ModelConfig;
 use Magento\Framework\App\Config\ScopeConfigInterface;
-use Magento\Framework\Event\Observer;
-use Magento\Framework\Event\ObserverInterface;
-use Magento\Framework\Message\ManagerInterface as MessageManager;
 use Magento\GiftMessage\Helper\Message;
 use Mageplaza\Osc\Helper\Config as HelperConfig;
 use Mageplaza\Osc\Helper\Data as HelperData;
+use Magento\Framework\Message\ManagerInterface as MessageManager;
 
 /**
  * Class OscConfigObserver
  * @package Mageplaza\Osc\Observer
  */
-class OscConfigObserver implements ObserverInterface
+class OscConfigObserver implements \Magento\Framework\Event\ObserverInterface
 {
     /**
      * @var \Magento\Store\Model\StoreManagerInterface
@@ -72,19 +69,18 @@ class OscConfigObserver implements ObserverInterface
         HelperConfig $helperConfig,
         ModelConfig $modelConfig,
         MessageManager $messageManager,
-        HelperData $HelperData
-    )
-    {
-        $this->_helperConfig   = $helperConfig;
-        $this->_modelConfig    = $modelConfig;
+        HelperData  $HelperData
+    ) {
+        $this->_helperConfig = $helperConfig;
+        $this->_modelConfig  = $modelConfig;
         $this->_messageManager = $messageManager;
-        $this->_helperData     = $HelperData;
+        $this->_helperData      = $HelperData;
     }
 
     /**
      * @param \Magento\Framework\Event\Observer $observer
      */
-    public function execute(Observer $observer)
+    public function execute(\Magento\Framework\Event\Observer $observer)
     {
         $scopeId            = 0;
         $isGiftMessage      = !$this->_helperConfig->isDisabledGiftMessage();
@@ -110,8 +106,8 @@ class OscConfigObserver implements ObserverInterface
                 ScopeConfigInterface::SCOPE_TYPE_DEFAULT,
                 $scopeId
             );
-        if ($isEnableGeoIP) {
-            if (!$this->_helperData->checkHasLibrary()) {
+        if($isEnableGeoIP){
+            if(!$this->_helperData->checkHasLibrary()){
                 $this->_modelConfig->saveConfig(
                     HelperConfig::GEO_IP_IS_ENABLED,
                     false,
diff --git a/Observer/PaypalExpressPlaceOrder.php b/Observer/PaypalExpressPlaceOrder.php
deleted file mode 100644
index c5fb04c..0000000
--- a/Observer/PaypalExpressPlaceOrder.php
+++ /dev/null
@@ -1,57 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Observer;
-
-use Magento\Framework\Event\Observer;
-use Magento\Framework\Event\ObserverInterface;
-use Mageplaza\Osc\Model\CheckoutRegister;
-
-/**
- * Class PaypalExpressPlaceOrder
- * @package Mageplaza\Osc\Observer
- */
-class PaypalExpressPlaceOrder implements ObserverInterface
-{
-    /**
-     * @var \Mageplaza\Osc\Model\CheckoutRegister
-     */
-    protected $checkoutRegister;
-
-    /**
-     * PaypalExpressPlaceOrder constructor.
-     * @param \Mageplaza\Osc\Model\CheckoutRegister $checkoutRegister
-     */
-    public function __construct(CheckoutRegister $checkoutRegister)
-    {
-        $this->checkoutRegister = $checkoutRegister;
-    }
-
-    /**
-     * @param \Magento\Framework\Event\Observer $observer
-     * @return void
-     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
-     */
-    public function execute(Observer $observer)
-    {
-        $this->checkoutRegister->checkRegisterNewCustomer();
-    }
-}
\ No newline at end of file
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index d0c828f..6842d47 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -15,14 +15,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Observer;
 
-use Magento\Checkout\Model\Session;
-use Magento\Framework\Event\Observer;
 use Magento\Framework\Event\ObserverInterface;
 
 /**
@@ -41,9 +38,10 @@ class QuoteSubmitBefore implements ObserverInterface
      * @codeCoverageIgnore
      */
     public function __construct(
-        Session $checkoutSession
+        \Magento\Checkout\Model\Session $checkoutSession
     )
     {
+
         $this->checkoutSession = $checkoutSession;
     }
 
@@ -52,7 +50,7 @@ class QuoteSubmitBefore implements ObserverInterface
      * @return void
      * @SuppressWarnings(PHPMD.UnusedFormalParameter)
      */
-    public function execute(Observer $observer)
+    public function execute(\Magento\Framework\Event\Observer $observer)
     {
         $order = $observer->getEvent()->getOrder();
         $quote = $observer->getEvent()->getQuote();
@@ -66,9 +64,9 @@ class QuoteSubmitBefore implements ObserverInterface
             $order->setData('osc_delivery_time', $oscData['deliveryTime']);
         }
 
-        if (isset($oscData['houseSecurityCode'])) {
-            $order->setData('osc_order_house_security_code', $oscData['houseSecurityCode']);
-        }
+		if (isset($oscData['houseSecurityCode'])) {
+			$order->setData('osc_order_house_security_code', $oscData['houseSecurityCode']);
+		}
 
         $address = $quote->getShippingAddress();
         if ($address->getUsedGiftWrap() && $address->hasData('osc_gift_wrap_amount') && $address->getUsedGiftWrap()) {
diff --git a/Observer/QuoteSubmitSuccess.php b/Observer/QuoteSubmitSuccess.php
index b4cf92c..775e025 100644
--- a/Observer/QuoteSubmitSuccess.php
+++ b/Observer/QuoteSubmitSuccess.php
@@ -15,24 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Observer;
 
-use Magento\Checkout\Model\Session;
-use Magento\Customer\Api\AccountManagementInterface;
-use Magento\Customer\Model\AccountManagement;
-use Magento\Customer\Model\Session as CustomerSession;
-use Magento\Customer\Model\Url;
-use Magento\Framework\App\ObjectManager;
-use Magento\Framework\Event\Observer;
 use Magento\Framework\Event\ObserverInterface;
-use Magento\Framework\Message\ManagerInterface;
-use Magento\Framework\Stdlib\Cookie\CookieMetadataFactory;
-use Magento\Framework\Stdlib\Cookie\PhpCookieManager;
-use Magento\Newsletter\Model\SubscriberFactory;
 
 /**
  * Class QuoteSubmitSuccess
@@ -79,14 +67,14 @@ class QuoteSubmitSuccess implements ObserverInterface
      * @param \Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
      */
     public function __construct(
-        Session $checkoutSession,
-        AccountManagementInterface $accountManagement,
-        Url $customerUrl,
-        ManagerInterface $messageManager,
-        CustomerSession $customerSession,
-        SubscriberFactory $subscriberFactory
-    )
-    {
+        \Magento\Checkout\Model\Session $checkoutSession,
+        \Magento\Customer\Api\AccountManagementInterface $accountManagement,
+        \Magento\Customer\Model\Url $customerUrl,
+        \Magento\Framework\Message\ManagerInterface $messageManager,
+        \Magento\Customer\Model\Session $customerSession,
+        \Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
+    ) {
+    
         $this->checkoutSession   = $checkoutSession;
         $this->accountManagement = $accountManagement;
         $this->_customerUrl      = $customerUrl;
@@ -100,7 +88,7 @@ class QuoteSubmitSuccess implements ObserverInterface
      * @return void
      * @SuppressWarnings(PHPMD.UnusedFormalParameter)
      */
-    public function execute(Observer $observer)
+    public function execute(\Magento\Framework\Event\Observer $observer)
     {
         /** @type \Magento\Quote\Model\Quote $quote $quote */
         $quote = $observer->getEvent()->getQuote();
@@ -109,25 +97,25 @@ class QuoteSubmitSuccess implements ObserverInterface
         if (isset($oscData['register']) && $oscData['register']
             && isset($oscData['password']) && $oscData['password']
         ) {
-            $customer = $quote->getCustomer();
+            $customer           = $quote->getCustomer();
 
             /* Set customer Id for address */
-            if ($customer->getId()) {
+            if($customer->getId()) {
                 $quote->getBillingAddress()->setCustomerId($customer->getId());
                 $quote->getBillingAddress()->setCustomerId($customer->getId());
             }
 
-            if ($customer->getId() &&
-                $this->accountManagement->getConfirmationStatus($customer->getId())
-                === AccountManagement::ACCOUNT_CONFIRMATION_REQUIRED) {
+            /* Check customer to be login or not */
+            $confirmationStatus = $this->accountManagement->getConfirmationStatus($customer->getId());
+            if ($confirmationStatus === \Magento\Customer\Model\AccountManagement::ACCOUNT_CONFIRMATION_REQUIRED) {
                 $url = $this->_customerUrl->getEmailConfirmationUrl($customer->getEmail());
                 $this->messageManager->addSuccessMessage(
-                // @codingStandardsIgnoreStart
-                    __(
-                        'You must confirm your account. Please check your email for the confirmation link or <a href="%1">click here</a> for a new link.',
-                        $url
-                    )
-                // @codingStandardsIgnoreEnd
+				// @codingStandardsIgnoreStart
+					__(
+						'You must confirm your account. Please check your email for the confirmation link or <a href="%1">click here</a> for a new link.',
+						$url
+					)
+				// @codingStandardsIgnoreEnd
                 );
             } else {
                 $this->_customerSession->loginById($customer->getId());
@@ -166,7 +154,9 @@ class QuoteSubmitSuccess implements ObserverInterface
      */
     private function getCookieManager()
     {
-        return ObjectManager::getInstance()->get(PhpCookieManager::class);
+        return \Magento\Framework\App\ObjectManager::getInstance()->get(
+            \Magento\Framework\Stdlib\Cookie\PhpCookieManager::class
+        );
     }
 
     /**
@@ -176,6 +166,8 @@ class QuoteSubmitSuccess implements ObserverInterface
      */
     private function getCookieMetadataFactory()
     {
-        return ObjectManager::getInstance()->get(CookieMetadataFactory::class);
+        return \Magento\Framework\App\ObjectManager::getInstance()->get(
+            \Magento\Framework\Stdlib\Cookie\CookieMetadataFactory::class
+        );
     }
 }
diff --git a/Observer/RedirectToOneStepCheckout.php b/Observer/RedirectToOneStepCheckout.php
index 08954df..075d714 100644
--- a/Observer/RedirectToOneStepCheckout.php
+++ b/Observer/RedirectToOneStepCheckout.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -33,42 +33,42 @@ use Mageplaza\Osc\Helper\Config as HelperConfig;
  */
 class RedirectToOneStepCheckout implements ObserverInterface
 {
-    /** @var UrlInterface */
-    protected $_url;
+	/** @var UrlInterface */
+	protected $_url;
 
-    /** @var HelperConfig */
-    protected $_helperConfig;
+	/** @var HelperConfig */
+	protected $_helperConfig;
 
-    /** @var CheckoutSession */
-    protected $checkoutSession;
+	/** @var CheckoutSession */
+	protected $checkoutSession;
 
-    /**
-     * RedirectToOneStepCheckout constructor.
-     * @param \Magento\Framework\UrlInterface $url
-     * @param \Mageplaza\Osc\Helper\Config $helperConfig
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     */
-    public function __construct(
-        UrlInterface $url,
-        HelperConfig $helperConfig,
-        CheckoutSession $checkoutSession
-    )
-    {
-        $this->_url            = $url;
-        $this->_helperConfig   = $helperConfig;
-        $this->checkoutSession = $checkoutSession;
-    }
+	/**
+	 * RedirectToOneStepCheckout constructor.
+	 * @param \Magento\Framework\UrlInterface $url
+	 * @param \Mageplaza\Osc\Helper\Config $helperConfig
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 */
+	public function __construct(
+		UrlInterface $url,
+		HelperConfig $helperConfig,
+		CheckoutSession $checkoutSession
+	)
+	{
+		$this->_url            = $url;
+		$this->_helperConfig   = $helperConfig;
+		$this->checkoutSession = $checkoutSession;
+	}
 
-    /**
-     * @param Observer $observer
-     * @return void
-     * @SuppressWarnings(PHPMD.CyclomaticComplexity)
-     */
-    public function execute(Observer $observer)
-    {
-        if ($this->_helperConfig->isEnabled() && $this->_helperConfig->isRedirectToOneStepCheckout()) {
-            $request = $observer->getRequest();
-            $request->setParam('return_url', $this->_url->getUrl('onestepcheckout/'));
-        }
-    }
+	/**
+	 * @param Observer $observer
+	 * @return void
+	 * @SuppressWarnings(PHPMD.CyclomaticComplexity)
+	 */
+	public function execute(Observer $observer)
+	{
+		if ($this->_helperConfig->isEnabled() && $this->_helperConfig->isRedirectToOneStepCheckout()) {
+			$request = $observer->getRequest();
+			$request->setParam('return_url',$this->_url->getUrl('onestepcheckout/'));
+		}
+	}
 }
\ No newline at end of file
diff --git a/README.md b/README.md
index cf8e1d5..7a9627e 100644
--- a/README.md
+++ b/README.md
@@ -1,9 +1,8 @@
 ## Documentation
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/#solution-1-ready-to-paste
+- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
 - User Guide: https://docs.mageplaza.com/one-step-checkout-m2/
 - Product page: https://www.mageplaza.com/magento-2-one-step-checkout-extension/
-- FAQs: https://www.mageplaza.com/faqs/
 - Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
 - Changelog: https://www.mageplaza.com/changelog/m2-one-step-checkout.txt
 - License agreement: https://www.mageplaza.com/LICENSE.txt
@@ -14,7 +13,10 @@
 
 Install ready-to-paste package (Recommended)
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/#solution-1-ready-to-paste
+- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
+- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
+
+
 
 
 ## How to upgrade
@@ -47,11 +49,3 @@ A: There are 2 major Mageplaza Osc version: OSC v1.x and OSC v2.x . If you are u
 
 #### Q: My site is down
 A: Please follow this guide: https://www.mageplaza.com/blog/magento-site-down.html
-
-
-
-## Support
-
-- FAQs: https://www.mageplaza.com/faqs/
-- https://mageplaza.freshdesk.com/
-- support@mageplaza.com
\ No newline at end of file
diff --git a/Setup/InstallData.php b/Setup/InstallData.php
index d4834fe..cd6e673 100644
--- a/Setup/InstallData.php
+++ b/Setup/InstallData.php
@@ -15,13 +15,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Setup;
 
-use Magento\Framework\DB\Ddl\Table;
 use Magento\Framework\Setup\InstallDataInterface;
 use Magento\Framework\Setup\ModuleContextInterface;
 use Magento\Framework\Setup\ModuleDataSetupInterface;
@@ -34,32 +32,32 @@ use Magento\Sales\Setup\SalesSetupFactory;
  */
 class InstallData implements InstallDataInterface
 {
-    /**
-     * @var SalesSetupFactory
-     */
-    protected $salesSetupFactory;
-
-    /**
-     * @param SalesSetupFactory $salesSetupFactory
-     */
-    public function __construct(SalesSetupFactory $salesSetupFactory)
-    {
-        $this->salesSetupFactory = $salesSetupFactory;
-    }
-
-    /**
-     * {@inheritdoc}
-     * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
-     */
-    public function install(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
-    {
-        /** @var \Magento\Sales\Setup\SalesSetup $salesInstaller */
-        $salesInstaller = $this->salesSetupFactory->create(['resourceName' => 'sales_setup', 'setup' => $setup]);
-
-        $setup->startSetup();
-
-        $salesInstaller->addAttribute('order', 'osc_order_comment', ['type' => Table::TYPE_TEXT]);
-
-        $setup->endSetup();
-    }
+	/**
+	 * @var SalesSetupFactory
+	 */
+	protected $salesSetupFactory;
+
+	/**
+	 * @param SalesSetupFactory $salesSetupFactory
+	 */
+	public function __construct(SalesSetupFactory $salesSetupFactory)
+	{
+		$this->salesSetupFactory = $salesSetupFactory;
+	}
+
+	/**
+	 * {@inheritdoc}
+	 * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
+	 */
+	public function install(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
+	{
+		/** @var \Magento\Sales\Setup\SalesSetup $salesInstaller */
+		$salesInstaller = $this->salesSetupFactory->create(['resourceName' => 'sales_setup', 'setup' => $setup]);
+
+		$setup->startSetup();
+
+		$salesInstaller->addAttribute('order', 'osc_order_comment', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT]);
+
+		$setup->endSetup();
+	}
 }
diff --git a/Setup/UpgradeData.php b/Setup/UpgradeData.php
index f96d3e1..17dd03c 100644
--- a/Setup/UpgradeData.php
+++ b/Setup/UpgradeData.php
@@ -15,13 +15,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\Osc\Setup;
 
-use Magento\Framework\DB\Ddl\Table;
 use Magento\Framework\Setup\ModuleContextInterface;
 use Magento\Framework\Setup\ModuleDataSetupInterface;
 use Magento\Framework\Setup\UpgradeDataInterface;
@@ -34,72 +32,72 @@ use Magento\Sales\Setup\SalesSetupFactory;
  */
 class UpgradeData implements UpgradeDataInterface
 {
-    /**
-     * @var QuoteSetupFactory
-     */
-    protected $quoteSetupFactory;
+	/**
+	 * @var QuoteSetupFactory
+	 */
+	protected $quoteSetupFactory;
 
-    /**
-     * @var SalesSetupFactory
-     */
-    protected $salesSetupFactory;
+	/**
+	 * @var SalesSetupFactory
+	 */
+	protected $salesSetupFactory;
 
-    /**
-     * @param QuoteSetupFactory $quoteSetupFactory
-     * @param SalesSetupFactory $salesSetupFactory
-     */
-    public function __construct(
-        QuoteSetupFactory $quoteSetupFactory,
-        SalesSetupFactory $salesSetupFactory
-    )
-    {
-        $this->quoteSetupFactory = $quoteSetupFactory;
-        $this->salesSetupFactory = $salesSetupFactory;
-    }
+	/**
+	 * @param QuoteSetupFactory $quoteSetupFactory
+	 * @param SalesSetupFactory $salesSetupFactory
+	 */
+	public function __construct(
+		QuoteSetupFactory $quoteSetupFactory,
+		SalesSetupFactory $salesSetupFactory
+	)
+	{
+		$this->quoteSetupFactory = $quoteSetupFactory;
+		$this->salesSetupFactory = $salesSetupFactory;
+	}
 
-    /**
-     * {@inheritdoc}
-     */
-    public function upgrade(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
-    {
-        /** @var \Magento\Quote\Setup\QuoteSetup $quoteInstaller */
-        $quoteInstaller = $this->quoteSetupFactory->create(['resourceName' => 'quote_setup', 'setup' => $setup]);
+	/**
+	 * {@inheritdoc}
+	 */
+	public function upgrade(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
+	{
+		/** @var \Magento\Quote\Setup\QuoteSetup $quoteInstaller */
+		$quoteInstaller = $this->quoteSetupFactory->create(['resourceName' => 'quote_setup', 'setup' => $setup]);
 
-        /** @var \Magento\Sales\Setup\SalesSetup $salesInstaller */
-        $salesInstaller = $this->salesSetupFactory->create(['resourceName' => 'sales_setup', 'setup' => $setup]);
+		/** @var \Magento\Sales\Setup\SalesSetup $salesInstaller */
+		$salesInstaller = $this->salesSetupFactory->create(['resourceName' => 'sales_setup', 'setup' => $setup]);
 
-        $setup->startSetup();
-        if (version_compare($context->getVersion(), '2.1.0') < 0) {
-            $entityAttributesCodes = [
-                'osc_gift_wrap_amount'      => Table::TYPE_DECIMAL,
-                'base_osc_gift_wrap_amount' => Table::TYPE_DECIMAL
-            ];
-            foreach ($entityAttributesCodes as $code => $type) {
-                $quoteInstaller->addAttribute('quote_address', $code, ['type' => $type, 'visible' => false]);
-                $quoteInstaller->addAttribute('quote_item', $code, ['type' => $type, 'visible' => false]);
-                $salesInstaller->addAttribute('order', $code, ['type' => $type, 'visible' => false]);
-                $salesInstaller->addAttribute('order_item', $code, ['type' => $type, 'visible' => false]);
-                $salesInstaller->addAttribute('invoice', $code, ['type' => $type, 'visible' => false]);
-                $salesInstaller->addAttribute('creditmemo', $code, ['type' => $type, 'visible' => false]);
-            }
+		$setup->startSetup();
+		if (version_compare($context->getVersion(), '2.1.0') < 0) {
+			$entityAttributesCodes = [
+				'osc_gift_wrap_amount'      => \Magento\Framework\DB\Ddl\Table::TYPE_DECIMAL,
+				'base_osc_gift_wrap_amount' => \Magento\Framework\DB\Ddl\Table::TYPE_DECIMAL
+			];
+			foreach ($entityAttributesCodes as $code => $type) {
+				$quoteInstaller->addAttribute('quote_address', $code, ['type' => $type, 'visible' => false]);
+				$quoteInstaller->addAttribute('quote_item', $code, ['type' => $type, 'visible' => false]);
+				$salesInstaller->addAttribute('order', $code, ['type' => $type, 'visible' => false]);
+				$salesInstaller->addAttribute('order_item', $code, ['type' => $type, 'visible' => false]);
+				$salesInstaller->addAttribute('invoice', $code, ['type' => $type, 'visible' => false]);
+				$salesInstaller->addAttribute('creditmemo', $code, ['type' => $type, 'visible' => false]);
+			}
 
-            $quoteInstaller->addAttribute('quote_address', 'used_gift_wrap', ['type' => Table::TYPE_BOOLEAN, 'visible' => false]);
-            $quoteInstaller->addAttribute('quote_address', 'gift_wrap_type', ['type' => Table::TYPE_SMALLINT, 'visible' => false]);
-            $salesInstaller->addAttribute('order', 'gift_wrap_type', ['type' => Table::TYPE_SMALLINT, 'visible' => false]);
+			$quoteInstaller->addAttribute('quote_address', 'used_gift_wrap', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_BOOLEAN, 'visible' => false]);
+			$quoteInstaller->addAttribute('quote_address', 'gift_wrap_type', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT, 'visible' => false]);
+			$salesInstaller->addAttribute('order', 'gift_wrap_type', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT, 'visible' => false]);
 
-        }
+		}
 
-        if (version_compare($context->getVersion(), '2.1.1') < 0) {
-            $salesInstaller->addAttribute('order', 'osc_delivery_time', ['type' => Table::TYPE_TEXT, 'visible' => false]);
-        }
-        if (version_compare($context->getVersion(), '2.1.2') < 0) {
-            $salesInstaller->addAttribute('order', 'osc_survey_question', ['type' => Table::TYPE_TEXT, 'visible' => false]);
-            $salesInstaller->addAttribute('order', 'osc_survey_answers', ['type' => Table::TYPE_TEXT, 'visible' => false]);
-        }
+		if (version_compare($context->getVersion(), '2.1.1') < 0) {
+			$salesInstaller->addAttribute('order', 'osc_delivery_time', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
+		}
+		if (version_compare($context->getVersion(), '2.1.2') < 0) {
+			$salesInstaller->addAttribute('order', 'osc_survey_question', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
+			$salesInstaller->addAttribute('order', 'osc_survey_answers', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
+		}
         if (version_compare($context->getVersion(), '2.1.3') < 0) {
-            $salesInstaller->addAttribute('order', 'osc_order_house_security_code', ['type' => Table::TYPE_TEXT, 'visible' => false]);
+            $salesInstaller->addAttribute('order', 'osc_order_house_security_code', ['type' => \Magento\Framework\DB\Ddl\Table::TYPE_TEXT, 'visible' => false]);
         }
 
-        $setup->endSetup();
-    }
+		$setup->endSetup();
+	}
 }
diff --git a/USER-GUIDE.md b/USER-GUIDE.md
index cf8e1d5..f2e2813 100644
--- a/USER-GUIDE.md
+++ b/USER-GUIDE.md
@@ -1,9 +1,8 @@
 ## Documentation
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/#solution-1-ready-to-paste
+- Installation guide: https://docs.mageplaza.com/kb/installation.html
 - User Guide: https://docs.mageplaza.com/one-step-checkout-m2/
 - Product page: https://www.mageplaza.com/magento-2-one-step-checkout-extension/
-- FAQs: https://www.mageplaza.com/faqs/
 - Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
 - Changelog: https://www.mageplaza.com/changelog/m2-one-step-checkout.txt
 - License agreement: https://www.mageplaza.com/LICENSE.txt
@@ -12,11 +11,42 @@
 
 ## How to install
 
-Install ready-to-paste package (Recommended)
+### Method 1: Install ready-to-paste package (Recommended)
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/#solution-1-ready-to-paste
+- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
+- Installation guide: https://docs.mageplaza.com/kb/installation.html
 
 
+
+### Method 2: Manually install via composer
+
+1. Access to your server via SSH
+2. Create a folder (Not Magento root directory) in called: `mageplaza`, 
+3. Download the zip package at https://store.mageplaza.com/my-downloadable-products.html
+4. Upload the zip package to `mageplaza` folder.
+
+
+3. Add the following snippet to `composer.json`
+
+```
+	{
+		"repositories": [
+		 {
+		 "type": "artifact",
+		 "url": "mageplaza/"
+		 }
+		]
+	}
+```
+
+4. Run composer command line
+
+```
+composer require mageplaza/magento-2-one-step-checkout-extension
+php bin/magento setup:upgrade
+php bin/magento setup:static-content:deploy
+```
+
 ## How to upgrade
 
 1. Backup
@@ -48,10 +78,3 @@ A: There are 2 major Mageplaza Osc version: OSC v1.x and OSC v2.x . If you are u
 #### Q: My site is down
 A: Please follow this guide: https://www.mageplaza.com/blog/magento-site-down.html
 
-
-
-## Support
-
-- FAQs: https://www.mageplaza.com/faqs/
-- https://mageplaza.freshdesk.com/
-- support@mageplaza.com
\ No newline at end of file
diff --git a/composer.json b/composer.json
index 07ef221..28972ab 100644
--- a/composer.json
+++ b/composer.json
@@ -5,7 +5,7 @@
         "mageplaza/module-core": "*"
     },
     "type": "magento2-module",
-    "version": "2.4.1",
+    "version": "2.4.0",
     "license": "Mageplaza License",
     "authors": [
         {
diff --git a/etc/acl.xml b/etc/acl.xml
index 08c58bc..7c61402 100644
--- a/etc/acl.xml
+++ b/etc/acl.xml
@@ -16,18 +16,17 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Acl/etc/acl.xsd">
     <acl>
         <resources>
             <resource id="Magento_Backend::admin">
                 <resource id="Mageplaza_Core::menu">
                     <resource id="Mageplaza_Osc::osc" title="One Step Checkout" sortOrder="71">
-                        <resource id="Mageplaza_Osc::field_management" title="Manage Fields" sortOrder="10"/>
+                        <resource id="Mageplaza_Osc::field_management" title="Field Management" sortOrder="10"/>
                         <resource id="Mageplaza_Osc::configuration" title="Configuration" sortOrder="1000"/>
                     </resource>
                 </resource>
diff --git a/etc/adminhtml/di.xml b/etc/adminhtml/di.xml
index a5e97e6..61c906e 100644
--- a/etc/adminhtml/di.xml
+++ b/etc/adminhtml/di.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/events.xml b/etc/adminhtml/events.xml
index 9a9b7c5..d42bf92 100644
--- a/etc/adminhtml/events.xml
+++ b/etc/adminhtml/events.xml
@@ -24,4 +24,5 @@
     <event name="admin_system_config_changed_section_osc">
         <observer name="osc_config_observer" instance="Mageplaza\Osc\Observer\OscConfigObserver" />
     </event>
+
 </config>
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index a0949fb..8fde81f 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -16,14 +16,14 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
     <menu>
         <add id="Mageplaza_Osc::osc" resource="Mageplaza_Osc::osc" module="Mageplaza_Osc" title="One Step Checkout" sortOrder="10" parent="Mageplaza_Core::menu"/>
-        <add id="Mageplaza_Osc::field_management" title="Manage Fields" module="Mageplaza_Osc" sortOrder="50" action="onestepcheckout/field/position" resource="Mageplaza_Osc::field_management" parent="Mageplaza_Osc::osc"/>
+        <add id="Mageplaza_Osc::field_management" title="Field Management" module="Mageplaza_Osc" sortOrder="50" action="onestepcheckout/field/position" resource="Mageplaza_Osc::field_management" parent="Mageplaza_Osc::osc"/>
         <add id="Mageplaza_Osc::configuration" title="Configuration" module="Mageplaza_Osc" sortOrder="1000" action="adminhtml/system_config/edit/section/osc" resource="Mageplaza_Osc::configuration" parent="Mageplaza_Osc::osc"/>
     </menu>
 </config>
\ No newline at end of file
diff --git a/etc/adminhtml/routes.xml b/etc/adminhtml/routes.xml
index f129db1..7ba2975 100644
--- a/etc/adminhtml/routes.xml
+++ b/etc/adminhtml/routes.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 978f9f4..5b1a0d0 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/config.xml b/etc/config.xml
index f1e4bfa..9337356 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Store:etc/config.xsd">
     <default>
         <osc>
diff --git a/etc/di.xml b/etc/di.xml
index 7d53a50..217d8df 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <preference for="Mageplaza\Osc\Api\CheckoutManagementInterface" type="Mageplaza\Osc\Model\CheckoutManagement" />
     <preference for="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" type="Mageplaza\Osc\Model\GuestCheckoutManagement" />
@@ -32,7 +31,4 @@
     <type name="Magento\Quote\Model\Cart\TotalsConverter">
         <plugin name="addGiftWrapInitialAmount" type="Mageplaza\Osc\Model\Plugin\Quote\GiftWrap"/>
     </type>
-    <type name="Magento\Quote\Model\QuoteManagement">
-        <plugin name="mz_osc_quotemanagement" type="Mageplaza\Osc\Model\Plugin\Quote\QuoteManagement"/>
-    </type>
 </config>
diff --git a/etc/events.xml b/etc/events.xml
index b044e18..09acf84 100644
--- a/etc/events.xml
+++ b/etc/events.xml
@@ -16,17 +16,16 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
     <event name="sales_model_service_quote_submit_before">
         <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\QuoteSubmitBefore" />
     </event>
-    <event name="controller_action_predispatch_paypal_express_placeOrder">
-        <observer name="osc_predispatch_paypal_express_placeOrder" instance="Mageplaza\Osc\Observer\PaypalExpressPlaceOrder" />
+    <event name="checkout_submit_before">
+        <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\CheckoutSubmitBefore" />
     </event>
     <event name="sales_model_service_quote_submit_success">
         <observer name="convertOscDataToOrder" instance="Mageplaza\Osc\Observer\QuoteSubmitSuccess" />
diff --git a/etc/extension_attributes.xml b/etc/extension_attributes.xml
index d2a0a39..f0c2ae9 100644
--- a/etc/extension_attributes.xml
+++ b/etc/extension_attributes.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index 44b58dd..7403880 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <!-- Register onestepcheckout link as secure url -->
     <type name="Magento\Framework\Url\SecurityInfo">
@@ -60,7 +59,4 @@
             </argument>
         </arguments>
     </type>
-    <type name="Magento\Eav\Model\Validator\Attribute\Data">
-        <plugin name="mz_osc_validator" type="Mageplaza\Osc\Model\Plugin\Eav\Model\Validator\Attribute\Data"/>
-    </type>
 </config>
\ No newline at end of file
diff --git a/etc/frontend/events.xml b/etc/frontend/events.xml
index 178b9aa..d852657 100644
--- a/etc/frontend/events.xml
+++ b/etc/frontend/events.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
     <event name="checkout_allow_guest">
         <observer name="checkout_allow_guest" instance="Mageplaza\Osc\Observer\IsAllowedGuestCheckoutObserver" />
diff --git a/etc/frontend/routes.xml b/etc/frontend/routes.xml
index ff1d73d..63064bf 100644
--- a/etc/frontend/routes.xml
+++ b/etc/frontend/routes.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:App/etc/routes.xsd">
     <router id="standard">
         <route id="onestepcheckout" frontName="onestepcheckout">
diff --git a/etc/frontend/sections.xml b/etc/frontend/sections.xml
index e9d5146..1d7c63c 100644
--- a/etc/frontend/sections.xml
+++ b/etc/frontend/sections.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Customer:etc/sections.xsd">
     <action name="rest/*/V1/carts/*/update-item">
diff --git a/etc/module.xml b/etc/module.xml
index 70529a3..f78dfd8 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
     <module name="Mageplaza_Osc" setup_version="2.1.3">
         <sequence>
diff --git a/etc/sales.xml b/etc/sales.xml
index cbb75fa..77c5ecb 100644
--- a/etc/sales.xml
+++ b/etc/sales.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Sales:etc/sales.xsd">
     <section name="quote">
         <group name="totals">
diff --git a/etc/webapi.xml b/etc/webapi.xml
index 2e89d54..e64bde0 100644
--- a/etc/webapi.xml
+++ b/etc/webapi.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <routes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Webapi:etc/webapi.xsd">
     <route url="/V1/guest-carts/:cartId/update-item" method="POST">
@@ -98,10 +97,4 @@
             <parameter name="cartId" force="true">%cart_id%</parameter>
         </data>
     </route>
-    <route url="/V1/guest-carts/:cartId/save-email-to-quote" method="POST">
-        <service class="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" method="saveEmailToQuote"/>
-        <resources>
-            <resource ref="anonymous"/>
-        </resources>
-    </route>
 </routes>
diff --git a/etc/webapi_rest/di.xml b/etc/webapi_rest/di.xml
index b6040dd..5afe245 100644
--- a/etc/webapi_rest/di.xml
+++ b/etc/webapi_rest/di.xml
@@ -16,21 +16,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <!-- Save address when estimate shipping method -->
     <type name="Magento\Quote\Model\ShippingMethodManagement">
         <plugin name="saveAddressWhenEstimate" type="Mageplaza\Osc\Model\Plugin\Checkout\ShippingMethodManagement"/>
     </type>
-    <type name="Magento\Quote\Model\QuoteRepository">
-        <plugin name="accessControl" type="Mageplaza\Osc\Model\Plugin\Quote\AccessChangeQuoteControl" />
-    </type>
-    <type name="Magento\Paypal\Model\Express">
-        <plugin name="mz_osc_PaypalExpress" type="Mageplaza\Osc\Model\Plugin\Paypal\Model\Express" />
-    </type>
-    <preference for="Magento\Checkout\Api\AgreementsValidatorInterface" type="Mageplaza\Osc\Model\AgreementsValidator" />
 </config>
\ No newline at end of file
diff --git a/i18n/af_ZA.csv b/i18n/af_ZA.csv
index f9e9250..934533a 100644
--- a/i18n/af_ZA.csv
+++ b/i18n/af_ZA.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Aktiveer opname"
 "Enter the amount of gift wrap fee.","Gee die bedrag van die geskenkafslagfooi in."
 "Error during save field position.","Fout tydens spaar veld posisie."
-"Manage Fields","Veldbestuur"
+"Field Management","Veldbestuur"
 "Flat","Plat"
 "General Configuration","Algemene konfigurasie"
 "Gift Wrap","Geskenkpapier"
diff --git a/i18n/ar_SA.csv b/i18n/ar_SA.csv
index 060d253..0be2bcc 100644
--- a/i18n/ar_SA.csv
+++ b/i18n/ar_SA.csv
@@ -44,7 +44,7 @@
 "Enable Survey","تمكين المسح"
 "Enter the amount of gift wrap fee.","أدخل مبلغ رسوم التفاف هدية."
 "Error during save field position.","حدث خطأ أثناء حفظ موضع الحقل."
-"Manage Fields","الإدارة الميدانية"
+"Field Management","الإدارة الميدانية"
 "Flat","مسطحة"
 "General Configuration","التكوين العام"
 "Gift Wrap","تغليف الهدية"
diff --git a/i18n/be_BY.csv b/i18n/be_BY.csv
index d70609a..457cb7b 100644
--- a/i18n/be_BY.csv
+++ b/i18n/be_BY.csv
@@ -44,7 +44,7 @@
 "Enable Survey","ўключыць апытанне"
 "Enter the amount of gift wrap fee.","Калі ласка, увядзіце суму ганарару падарункавым пакаванні."
 "Error during save field position.","Памылка пазіцыі эканоміі поля."
-"Manage Fields","Упраўленне палямі"
+"Field Management","Упраўленне палямі"
 "Flat","кватэра"
 "General Configuration","агульная канфігурацыя"
 "Gift Wrap","Падарункавая ўпакоўка"
diff --git a/i18n/ca_ES.csv b/i18n/ca_ES.csv
index 3e346c6..99af95e 100644
--- a/i18n/ca_ES.csv
+++ b/i18n/ca_ES.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Habilita l'enquesta"
 "Enter the amount of gift wrap fee.","Introduïu la quantitat de quota d'embolcall de regal."
 "Error during save field position.","Error durant la posició del camp guardar."
-"Manage Fields","Gestió del camp"
+"Field Management","Gestió del camp"
 "Flat","Pis"
 "General Configuration","Configuració general"
 "Gift Wrap","Paper de regal"
diff --git a/i18n/cs_CZ.csv b/i18n/cs_CZ.csv
index 7fc1e5f..cc35894 100644
--- a/i18n/cs_CZ.csv
+++ b/i18n/cs_CZ.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Povolit průzkum"
 "Enter the amount of gift wrap fee.","Zadejte částku poplatku za dárkové balení."
 "Error during save field position.","Chyba při uložení pozice pole."
-"Manage Fields","Správa polí"
+"Field Management","Správa polí"
 "Flat","Ploché"
 "General Configuration","Obecná konfigurace"
 "Gift Wrap","Dárek Wrap"
diff --git a/i18n/da_DK.csv b/i18n/da_DK.csv
index 888c737..684fa8c 100644
--- a/i18n/da_DK.csv
+++ b/i18n/da_DK.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Aktivér undersøgelse"
 "Enter the amount of gift wrap fee.","Indtast mængden af ​​gave wrap gebyr."
 "Error during save field position.","Fejl under gemt feltposition."
-"Manage Fields","Feltforvaltning"
+"Field Management","Feltforvaltning"
 "Flat","Flad"
 "General Configuration","Generel konfiguration"
 "Gift Wrap","Gavepapir"
diff --git a/i18n/de_DE.csv b/i18n/de_DE.csv
index 86b4148..8a40859 100644
--- a/i18n/de_DE.csv
+++ b/i18n/de_DE.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Ermöglichen Sie die Umfrage"
 "Enter the amount of gift wrap fee.","Geben Sie die Menge der Geschenkverpackung ein."
 "Error during save field position.","Fehler beim Speichern der Feldposition."
-"Manage Fields","Feldmanagement"
+"Field Management","Feldmanagement"
 "Flat","Wohnung"
 "General Configuration","Allgemeine Konfiguration"
 "Gift Wrap","Geschenkpapier"
diff --git a/i18n/el_GR.csv b/i18n/el_GR.csv
index 567d499..bdb23a0 100644
--- a/i18n/el_GR.csv
+++ b/i18n/el_GR.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Ενεργοποιήστε την Έρευνα"
 "Enter the amount of gift wrap fee.","Καταχωρίστε το ποσό της αμοιβής συσκευασίας δώρου."
 "Error during save field position.","Σφάλμα κατά την αποθήκευση θέσης πεδίου."
-"Manage Fields","Διαχείριση πεδίου"
+"Field Management","Διαχείριση πεδίου"
 "Flat","Διαμέρισμα"
 "General Configuration","Γενική διαμόρφωση"
 "Gift Wrap","Χαρτί περιτυλίγματος"
diff --git a/i18n/en_US.csv b/i18n/en_US.csv
index 0c7ff70..ffc8939 100644
--- a/i18n/en_US.csv
+++ b/i18n/en_US.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Enable Survey"
 "Enter the amount of gift wrap fee.","Enter the amount of gift wrap fee."
 "Error during save field position.","Error during save field position."
-"Manage Fields","Manage Fields"
+"Field Management","Field Management"
 "Flat","Flat"
 "General Configuration","General Configuration"
 "Gift Wrap","Gift Wrap"
diff --git a/i18n/es_ES.csv b/i18n/es_ES.csv
index e0c5364..70aa98f 100644
--- a/i18n/es_ES.csv
+++ b/i18n/es_ES.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Habilitar encuesta"
 "Enter the amount of gift wrap fee.","Ingrese la cantidad de la tasa de envoltura de regalo."
 "Error during save field position.","Error al guardar la posición del campo."
-"Manage Fields","Gestión del campo"
+"Field Management","Gestión del campo"
 "Flat","Plano"
 "General Configuration","Configuración general"
 "Gift Wrap","Papel de regalo"
diff --git a/i18n/fi_FI.csv b/i18n/fi_FI.csv
index f1154dd..c3125f8 100644
--- a/i18n/fi_FI.csv
+++ b/i18n/fi_FI.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Ota kysely käyttöön"
 "Enter the amount of gift wrap fee.","Anna lahjapaperimaksun määrä."
 "Error during save field position.","Virhe tallennuskenttän aikana."
-"Manage Fields","Kenttähallinta"
+"Field Management","Kenttähallinta"
 "Flat","tasainen"
 "General Configuration","Yleinen määritys"
 "Gift Wrap","Lahjapaperia"
diff --git a/i18n/fr_FR.csv b/i18n/fr_FR.csv
index 9b0214a..04afd4e 100644
--- a/i18n/fr_FR.csv
+++ b/i18n/fr_FR.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Enable Survey"
 "Enter the amount of gift wrap fee.","Entrez le montant des frais d'emballage de cadeaux."
 "Error during save field position.","Erreur lors de la sauvegarde du champ."
-"Manage Fields","Gestion de terrain"
+"Field Management","Gestion de terrain"
 "Flat","Appartement"
 "General Configuration","Configuration générale"
 "Gift Wrap","Papier cadeau"
diff --git a/i18n/he_IL.csv b/i18n/he_IL.csv
index cd4444e..eecdb88 100644
--- a/i18n/he_IL.csv
+++ b/i18n/he_IL.csv
@@ -44,7 +44,7 @@
 "Enable Survey","הפעל סקר"
 "Enter the amount of gift wrap fee.","הזן את כמות דמי מתנה לעטוף."
 "Error during save field position.","שגיאה במהלך מיקום השדה שמור."
-"Manage Fields","ניהול שדות"
+"Field Management","ניהול שדות"
 "Flat","שָׁטוּחַ"
 "General Configuration","תצורה כללית"
 "Gift Wrap","אריזות מתנה"
diff --git a/i18n/hu_HU.csv b/i18n/hu_HU.csv
index 2ea68d0..a5196fc 100644
--- a/i18n/hu_HU.csv
+++ b/i18n/hu_HU.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Felmérés engedélyezése"
 "Enter the amount of gift wrap fee.","Adja meg az ajándékkötési díj összegét."
 "Error during save field position.","Hiba a mentési mezőben."
-"Manage Fields","Manage Fields"
+"Field Management","Field Management"
 "Flat","Lakás"
 "General Configuration","Általános konfiguráció"
 "Gift Wrap","Ajándékcsomagolás"
diff --git a/i18n/it_IT.csv b/i18n/it_IT.csv
index 9204738..047265b 100644
--- a/i18n/it_IT.csv
+++ b/i18n/it_IT.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Abilita indagine"
 "Enter the amount of gift wrap fee.","Inserisci l'importo della tassa di avvio regalo."
 "Error during save field position.","Errore durante la posizione del campo di salvataggio."
-"Manage Fields","Gestione del campo"
+"Field Management","Gestione del campo"
 "Flat","Piatto"
 "General Configuration","Configurazione generale"
 "Gift Wrap","Confezione regalo"
diff --git a/i18n/ja_JP.csv b/i18n/ja_JP.csv
index 74007e3..9c522ec 100644
--- a/i18n/ja_JP.csv
+++ b/i18n/ja_JP.csv
@@ -44,7 +44,7 @@
 "Enable Survey","アンケートを有効にする"
 "Enter the amount of gift wrap fee.","ギフトラッピング料金の金額を入力してください。"
 "Error during save field position.","フィールドの位置を保存中にエラーが発生しました。"
-"Manage Fields","フィールド管理"
+"Field Management","フィールド管理"
 "Flat","平らな"
 "General Configuration","一般的な設定"
 "Gift Wrap","ギフトラップ"
diff --git a/i18n/ko_KR.csv b/i18n/ko_KR.csv
index eb9f090..30059ab 100644
--- a/i18n/ko_KR.csv
+++ b/i18n/ko_KR.csv
@@ -44,7 +44,7 @@
 "Enable Survey","설문 조사 사용"
 "Enter the amount of gift wrap fee.","선물 포장 금액을 입력하십시오."
 "Error during save field position.","필드 위치를 저장하는 중 오류가 발생했습니다."
-"Manage Fields","현장 관리"
+"Field Management","현장 관리"
 "Flat","플랫"
 "General Configuration","일반 구성"
 "Gift Wrap","선물 포장"
diff --git a/i18n/nl_NL.csv b/i18n/nl_NL.csv
index a45c9f5..f87c75b 100644
--- a/i18n/nl_NL.csv
+++ b/i18n/nl_NL.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Enquête inschakelen"
 "Enter the amount of gift wrap fee.","Voer het bedrag van de cadeauverpakking in."
 "Error during save field position.","Fout tijdens opslaan veld positie."
-"Manage Fields","Veldbeheer"
+"Field Management","Veldbeheer"
 "Flat","Vlak"
 "General Configuration","Algemene configuratie"
 "Gift Wrap","Cadeaupapier"
diff --git a/i18n/no_NO.csv b/i18n/no_NO.csv
index adaaeaa..c919e24 100644
--- a/i18n/no_NO.csv
+++ b/i18n/no_NO.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Aktiver undersøkelse"
 "Enter the amount of gift wrap fee.","Skriv inn mengden gavepakkeavgift."
 "Error during save field position.","Feil under lagringsfeltposisjon."
-"Manage Fields","Feltbehandling"
+"Field Management","Feltbehandling"
 "Flat","Flat"
 "General Configuration","Generell konfigurasjon"
 "Gift Wrap","Gavepapir"
diff --git a/i18n/pl_PL.csv b/i18n/pl_PL.csv
index d446578..90b50db 100644
--- a/i18n/pl_PL.csv
+++ b/i18n/pl_PL.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Włącz ankietę"
 "Enter the amount of gift wrap fee.","Wprowadź kwotę opłaty z upominkami."
 "Error during save field position.","Błąd podczas pola pola zapisu."
-"Manage Fields","Zarządzanie terenem"
+"Field Management","Zarządzanie terenem"
 "Flat","Mieszkanie"
 "General Configuration","Konfiguracja ogólna"
 "Gift Wrap","Opakowanie na prezent"
diff --git a/i18n/pt_BR.csv b/i18n/pt_BR.csv
index 4e7bfaf..3c6829d 100644
--- a/i18n/pt_BR.csv
+++ b/i18n/pt_BR.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Enable Survey"
 "Enter the amount of gift wrap fee.","Enter the amount of gift wrap fee."
 "Error during save field position.","Error during save field position."
-"Manage Fields","Manage Fields"
+"Field Management","Field Management"
 "Flat","Flat"
 "General Configuration","General Configuration"
 "Gift Wrap","Gift Wrap"
diff --git a/i18n/pt_PT.csv b/i18n/pt_PT.csv
index d8d6ca8..61a5134 100644
--- a/i18n/pt_PT.csv
+++ b/i18n/pt_PT.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Enable Survey"
 "Enter the amount of gift wrap fee.","Insira a quantidade de taxa de entrega de presente."
 "Error during save field position.","Erro durante a salvação da posição do campo."
-"Manage Fields","Gerenciamento de campo"
+"Field Management","Gerenciamento de campo"
 "Flat","Plano"
 "General Configuration","Configuração Geral"
 "Gift Wrap","Embrulho de presente"
diff --git a/i18n/ro_RO.csv b/i18n/ro_RO.csv
index 419051d..4131600 100644
--- a/i18n/ro_RO.csv
+++ b/i18n/ro_RO.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Activați Ancheta"
 "Enter the amount of gift wrap fee.","Introduceți suma taxei de împachetare cadou."
 "Error during save field position.","Eroare la salvarea poziției câmpului."
-"Manage Fields","Managementul terenurilor"
+"Field Management","Managementul terenurilor"
 "Flat","Apartament"
 "General Configuration","Configurație generală"
 "Gift Wrap","Ambalaj pentru cadouri"
diff --git a/i18n/ru_RU.csv b/i18n/ru_RU.csv
index e4877bf..6a4664c 100644
--- a/i18n/ru_RU.csv
+++ b/i18n/ru_RU.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Включить опрос"
 "Enter the amount of gift wrap fee.","Введите сумму платы за подачу подарка."
 "Error during save field position.","Ошибка во время сохранения позиции поля."
-"Manage Fields","Управление полем"
+"Field Management","Управление полем"
 "Flat","Квартира"
 "General Configuration","Общая конфигурация"
 "Gift Wrap","Подарочная упаковка"
diff --git a/i18n/sr_SP.csv b/i18n/sr_SP.csv
index 64bffb2..ef6ddf7 100644
--- a/i18n/sr_SP.csv
+++ b/i18n/sr_SP.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Омогућите Анкету"
 "Enter the amount of gift wrap fee.","Унесите износ накнаде за поклон поклона."
 "Error during save field position.","Грешка приликом уштеде поља."
-"Manage Fields","Фиелд Манагемент"
+"Field Management","Фиелд Манагемент"
 "Flat","Раван"
 "General Configuration","Општа конфигурација"
 "Gift Wrap","Украсни папир"
diff --git a/i18n/sv_SE.csv b/i18n/sv_SE.csv
index a8adaea..bf938ec 100644
--- a/i18n/sv_SE.csv
+++ b/i18n/sv_SE.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Aktivera undersökning"
 "Enter the amount of gift wrap fee.","Ange mängden presentavgift."
 "Error during save field position.","Fel vid spara fältposition."
-"Manage Fields","Fälthantering"
+"Field Management","Fälthantering"
 "Flat","Platt"
 "General Configuration","Allmän konfiguration"
 "Gift Wrap","Presentpapper"
diff --git a/i18n/tr_TR.csv b/i18n/tr_TR.csv
index ae38194..273ba0f 100644
--- a/i18n/tr_TR.csv
+++ b/i18n/tr_TR.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Anketi etkinleştir"
 "Enter the amount of gift wrap fee.","Hediye paketleme ücreti miktarını girin."
 "Error during save field position.","Kayıt yeri konumu sırasında hata oluştu."
-"Manage Fields","Alan Yönetimi"
+"Field Management","Alan Yönetimi"
 "Flat","Düz"
 "General Configuration","Genel Yapılandırma"
 "Gift Wrap","Hediye paketi"
diff --git a/i18n/uk_UA.csv b/i18n/uk_UA.csv
index db8ed57..5f003ad 100644
--- a/i18n/uk_UA.csv
+++ b/i18n/uk_UA.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Увімкнути опитування"
 "Enter the amount of gift wrap fee.","Введіть суму подарункової упаковки."
 "Error during save field position.","Помилка під час поля збереження поля."
-"Manage Fields","Управління на місцях"
+"Field Management","Управління на місцях"
 "Flat","Квартира"
 "General Configuration","Загальна конфігурація"
 "Gift Wrap","Подарункова упаковка"
diff --git a/i18n/vi_VN.csv b/i18n/vi_VN.csv
index 2f8c1f0..9c451e2 100644
--- a/i18n/vi_VN.csv
+++ b/i18n/vi_VN.csv
@@ -44,7 +44,7 @@
 "Enable Survey","Bật khảo sát"
 "Enter the amount of gift wrap fee.","Nhập số tiền gói quà."
 "Error during save field position.","Lỗi trong thời gian lưu trường."
-"Manage Fields","Quản lý thực địa"
+"Field Management","Quản lý thực địa"
 "Flat","Bằng phẳng"
 "General Configuration","Cấu hình chung"
 "Gift Wrap","Gói quà"
diff --git a/i18n/zh_CN.csv b/i18n/zh_CN.csv
index 4b90124..0b730d9 100644
--- a/i18n/zh_CN.csv
+++ b/i18n/zh_CN.csv
@@ -44,7 +44,7 @@
 "Enable Survey","启用调查"
 "Enter the amount of gift wrap fee.","输入礼品包裹金额。"
 "Error during save field position.","保存字段位置时出错。"
-"Manage Fields","现场管理"
+"Field Management","现场管理"
 "Flat","平面"
 "General Configuration","一般配置"
 "Gift Wrap","礼品包装"
diff --git a/i18n/zh_TW.csv b/i18n/zh_TW.csv
index c4ff55e..6eef6dc 100644
--- a/i18n/zh_TW.csv
+++ b/i18n/zh_TW.csv
@@ -44,7 +44,7 @@
 "Enable Survey","啟用調查"
 "Enter the amount of gift wrap fee.","輸入禮品包裹金額。"
 "Error during save field position.","保存字段位置時出錯。"
-"Manage Fields","現場管理"
+"Field Management","現場管理"
 "Flat","平面"
 "General Configuration","一般配置"
 "Gift Wrap","禮品包裝"
diff --git a/registration.php b/registration.php
index 3e2d5d7..889e4d1 100644
--- a/registration.php
+++ b/registration.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/layout/onestepcheckout_field_position.xml b/view/adminhtml/layout/onestepcheckout_field_position.xml
index 634e9c0..b8e8227 100644
--- a/view/adminhtml/layout/onestepcheckout_field_position.xml
+++ b/view/adminhtml/layout/onestepcheckout_field_position.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-1column" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <head>
         <css src="Mageplaza_Osc::css/style.css"/>
@@ -28,7 +27,7 @@
     </head>
     <body>
         <referenceContainer name="content">
-            <block class="Mageplaza\Osc\Block\Adminhtml\Field\Position" name="onestepcheckout.adminhtml.field.position" template="field/position.phtml" />
+            <block class="\Mageplaza\Osc\Block\Adminhtml\Field\Position" name="onestepcheckout.adminhtml.field.position" template="field/position.phtml" />
         </referenceContainer>
     </body>
 </page>
diff --git a/view/adminhtml/layout/sales_order_creditmemo_new.xml b/view/adminhtml/layout/sales_order_creditmemo_new.xml
index fefeba1..2b98016 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_new.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_new.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml b/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
index fefeba1..2b98016 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_creditmemo_view.xml b/view/adminhtml/layout/sales_order_creditmemo_view.xml
index fefeba1..2b98016 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_view.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_view.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_invoice_email.xml b/view/adminhtml/layout/sales_order_invoice_email.xml
index 852636d..20ba0df 100644
--- a/view/adminhtml/layout/sales_order_invoice_email.xml
+++ b/view/adminhtml/layout/sales_order_invoice_email.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_invoice_new.xml b/view/adminhtml/layout/sales_order_invoice_new.xml
index 852636d..20ba0df 100644
--- a/view/adminhtml/layout/sales_order_invoice_new.xml
+++ b/view/adminhtml/layout/sales_order_invoice_new.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_invoice_print.xml b/view/adminhtml/layout/sales_order_invoice_print.xml
index 852636d..20ba0df 100644
--- a/view/adminhtml/layout/sales_order_invoice_print.xml
+++ b/view/adminhtml/layout/sales_order_invoice_print.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_invoice_updateqty.xml b/view/adminhtml/layout/sales_order_invoice_updateqty.xml
index 852636d..20ba0df 100644
--- a/view/adminhtml/layout/sales_order_invoice_updateqty.xml
+++ b/view/adminhtml/layout/sales_order_invoice_updateqty.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_invoice_view.xml b/view/adminhtml/layout/sales_order_invoice_view.xml
index 852636d..20ba0df 100644
--- a/view/adminhtml/layout/sales_order_invoice_view.xml
+++ b/view/adminhtml/layout/sales_order_invoice_view.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
diff --git a/view/adminhtml/layout/sales_order_view.xml b/view/adminhtml/layout/sales_order_view.xml
index c5e8ac8..a02ebc9 100644
--- a/view/adminhtml/layout/sales_order_view.xml
+++ b/view/adminhtml/layout/sales_order_view.xml
@@ -16,11 +16,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-2columns-left"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <head>
diff --git a/view/adminhtml/templates/field/position.phtml b/view/adminhtml/templates/field/position.phtml
index 6001d01..1ae2cd8 100644
--- a/view/adminhtml/templates/field/position.phtml
+++ b/view/adminhtml/templates/field/position.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/adminhtml/templates/order/additional.phtml b/view/adminhtml/templates/order/additional.phtml
index f680199..55511de 100644
--- a/view/adminhtml/templates/order/additional.phtml
+++ b/view/adminhtml/templates/order/additional.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/comment.phtml b/view/adminhtml/templates/order/view/comment.phtml
index 06fab19..9d77081 100644
--- a/view/adminhtml/templates/order/view/comment.phtml
+++ b/view/adminhtml/templates/order/view/comment.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/delivery-time.phtml b/view/adminhtml/templates/order/view/delivery-time.phtml
index 1c72f87..72e9d4d 100644
--- a/view/adminhtml/templates/order/view/delivery-time.phtml
+++ b/view/adminhtml/templates/order/view/delivery-time.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/survey.phtml b/view/adminhtml/templates/order/view/survey.phtml
index a954f37..a939b47 100644
--- a/view/adminhtml/templates/order/view/survey.phtml
+++ b/view/adminhtml/templates/order/view/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/system/config/geoip.phtml b/view/adminhtml/templates/system/config/geoip.phtml
index cad9b1e..386aa83 100644
--- a/view/adminhtml/templates/system/config/geoip.phtml
+++ b/view/adminhtml/templates/system/config/geoip.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -25,9 +25,11 @@
 		'jquery',
 		'prototype'
 	], function($){
+
 		var collectSpan = $('#collect_span');
 		var buttonDownload = $('#geoip_button');
-        buttonDownload.click(function () {
+		$('#geoip_button').click(function () {
+
 			var params = {};
 			new Ajax.Request('<?php echo $block->getAjaxUrl() ?>', {
 				parameters:     params,
@@ -57,8 +59,10 @@
 				}
 			});
 		});
+
 	});
 </script>
+
 <?php echo $block->getButtonHtml() ?>
 <span class="collect-indicator" id="collect_span">
 	<span class="processing" hidden="hidden">
diff --git a/view/adminhtml/web/css/style.css b/view/adminhtml/web/css/style.css
index e0b0736..dea4d34 100644
--- a/view/adminhtml/web/css/style.css
+++ b/view/adminhtml/web/css/style.css
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/layout/checkout_onepage_success.xml b/view/frontend/layout/checkout_onepage_success.xml
index e54a8cf..689d5da 100644
--- a/view/frontend/layout/checkout_onepage_success.xml
+++ b/view/frontend/layout/checkout_onepage_success.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index 228ddae..e49c9f7 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/layout/sales_email_order_creditmemo_items.xml b/view/frontend/layout/sales_email_order_creditmemo_items.xml
index a0673b9..75e7d81 100644
--- a/view/frontend/layout/sales_email_order_creditmemo_items.xml
+++ b/view/frontend/layout/sales_email_order_creditmemo_items.xml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement/
  -->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
diff --git a/view/frontend/layout/sales_email_order_invoice_items.xml b/view/frontend/layout/sales_email_order_invoice_items.xml
index b61881d..b4a73d9 100644
--- a/view/frontend/layout/sales_email_order_invoice_items.xml
+++ b/view/frontend/layout/sales_email_order_invoice_items.xml
@@ -15,8 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement/
+
  -->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
diff --git a/view/frontend/layout/sales_email_order_items.xml b/view/frontend/layout/sales_email_order_items.xml
index ccc4170..59cce31 100644
--- a/view/frontend/layout/sales_email_order_items.xml
+++ b/view/frontend/layout/sales_email_order_items.xml
@@ -1,23 +1,10 @@
 <?xml version="1.0"?>
 <!--
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
- * @license     http://mageplaza.com/license-agreement/
- -->
+/**
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
+ */
+-->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd" label="Email Order Items List" design_abstraction="custom">
     <body>
         <referenceBlock name="order_totals">
diff --git a/view/frontend/layout/sales_order_creditmemo.xml b/view/frontend/layout/sales_order_creditmemo.xml
index fccc013..aa3f180 100644
--- a/view/frontend/layout/sales_order_creditmemo.xml
+++ b/view/frontend/layout/sales_order_creditmemo.xml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement/
 
  -->
diff --git a/view/frontend/layout/sales_order_invoice.xml b/view/frontend/layout/sales_order_invoice.xml
index 08dbe70..586e7d5 100644
--- a/view/frontend/layout/sales_order_invoice.xml
+++ b/view/frontend/layout/sales_order_invoice.xml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement/
 
  -->
diff --git a/view/frontend/layout/sales_order_print.xml b/view/frontend/layout/sales_order_print.xml
index bbd464e..5dff10e 100644
--- a/view/frontend/layout/sales_order_print.xml
+++ b/view/frontend/layout/sales_order_print.xml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement/
 
  -->
diff --git a/view/frontend/layout/sales_order_printcreditmemo.xml b/view/frontend/layout/sales_order_printcreditmemo.xml
index fccc013..aa3f180 100644
--- a/view/frontend/layout/sales_order_printcreditmemo.xml
+++ b/view/frontend/layout/sales_order_printcreditmemo.xml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement/
 
  -->
diff --git a/view/frontend/layout/sales_order_printinvoice.xml b/view/frontend/layout/sales_order_printinvoice.xml
index b0c1c3a..b4a73d9 100644
--- a/view/frontend/layout/sales_order_printinvoice.xml
+++ b/view/frontend/layout/sales_order_printinvoice.xml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
  * @license     http://mageplaza.com/license-agreement/
 
  -->
diff --git a/view/frontend/layout/sales_order_view.xml b/view/frontend/layout/sales_order_view.xml
index ccfe961..abe940d 100644
--- a/view/frontend/layout/sales_order_view.xml
+++ b/view/frontend/layout/sales_order_view.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index be7009a..e3224f5 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -50,12 +50,6 @@ if (window.location.href.indexOf('onestepcheckout') !== -1) {
             mixins: {
                 'Magento_Braintree/js/view/payment/method-renderer/paypal': {
                     'Mageplaza_Osc/js/view/payment/method-renderer/braintree-paypal-mixins': true
-                },
-                'Magento_Checkout/js/action/place-order': {
-                    'Mageplaza_Osc/js/action/place-order-mixins': true
-                },
-                'Magento_Paypal/js/action/set-payment-method': {
-                    'Mageplaza_Osc/js/model/paypal/set-payment-method-mixin': true
                 }
             }
         },
diff --git a/view/frontend/templates/description.phtml b/view/frontend/templates/description.phtml
index 255a65f..2e14c1b 100644
--- a/view/frontend/templates/description.phtml
+++ b/view/frontend/templates/description.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/design.phtml b/view/frontend/templates/design.phtml
index ce081bb..706c040 100644
--- a/view/frontend/templates/design.phtml
+++ b/view/frontend/templates/design.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -250,7 +250,7 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
             <?php } ?>
 
         /* checkbox button - default */
-            [type=checkbox]:checked, .one-step-checkout-wrapper [type=checkbox]:not(:checked), #opc-new-shipping-address [type=checkbox]:not(:checked){position:absolute;opacity:0;z-index: 999;}
+            [type=checkbox]:checked, .one-step-checkout-wrapper [type=checkbox]:not(:checked){position:absolute;opacity:0;z-index: 999;}
             .one-step-checkout-wrapper .payment-method-content input[type="checkbox"] {width:20px;height:20px;}
             <?php if($design['checkbox_button_style'] == 'default'){ ?>
             [type=checkbox]+label{position:relative;padding-left:35px;cursor:pointer;display:inline-block;height:25px;line-height:25px;/*font-size:1rem*/}
diff --git a/view/frontend/templates/onepage/compatible-config.phtml b/view/frontend/templates/onepage/compatible-config.phtml
index 61898a3..b5ec928 100644
--- a/view/frontend/templates/onepage/compatible-config.phtml
+++ b/view/frontend/templates/onepage/compatible-config.phtml
@@ -15,13 +15,14 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 /** @var \Mageplaza\Osc\Block\Checkout\CompatibleConfig $block */
 
 ?>
+
 <?php if($block->isEnableModulePostNL()) : ?>
     <script type="text/javascript">
         require.config({
diff --git a/view/frontend/templates/onepage/success/survey.phtml b/view/frontend/templates/onepage/success/survey.phtml
index b798773..8949792 100644
--- a/view/frontend/templates/onepage/success/survey.phtml
+++ b/view/frontend/templates/onepage/success/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -29,10 +29,8 @@
                     foreach ($block->getAllSurveyAnswer() as $option){
                         echo '<div class="survey-answer"> <div class="checkbox-survey"><input type="checkbox" value="'.$option['id'].'"></div><div class="option-value"><span>'.$option['value'].'</span></div></div>';
                     }
-                    if($block->isAllowCustomerAddOtherOption()){
-                        echo '<div class="option-survey-new"> <input type="text" id="new-answer" placeholder="Add an option..." maxlength="50"> </div>';
-                    }
-                ?>
+                    if($block->isAllowCustomerAddOtherOption()) echo '<div class="option-survey-new"> <input type="text" id="new-answer" placeholder="Add an option..." maxlength="50"> </div>';
+    ?>
            </div>
            <div class="actions-toolbar" id="submit-answers">
               <div class="primary">
diff --git a/view/frontend/templates/order/additional.phtml b/view/frontend/templates/order/additional.phtml
index d9abd76..2a2810d 100644
--- a/view/frontend/templates/order/additional.phtml
+++ b/view/frontend/templates/order/additional.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/templates/order/view/comment.phtml b/view/frontend/templates/order/view/comment.phtml
index 80f6faf..3303563 100644
--- a/view/frontend/templates/order/view/comment.phtml
+++ b/view/frontend/templates/order/view/comment.phtml
@@ -15,10 +15,11 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
+
 <?php if ($commentHtml = $block->getOrderComment()): ?>
 <div class="box box-order-comment">
     <strong class="box-title">
diff --git a/view/frontend/templates/order/view/delivery-time.phtml b/view/frontend/templates/order/view/delivery-time.phtml
index 9d9f2ac..6e3529a 100644
--- a/view/frontend/templates/order/view/delivery-time.phtml
+++ b/view/frontend/templates/order/view/delivery-time.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/order/view/survey.phtml b/view/frontend/templates/order/view/survey.phtml
index 36f4193..6b761a0 100644
--- a/view/frontend/templates/order/view/survey.phtml
+++ b/view/frontend/templates/order/view/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index 056b38d..5407a84 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -216,8 +216,4 @@ form#co-shipping-method-form div#shipping-method-buttons-container{display:none;
 .checkout-container .postnl-deliveryoptions .delivery_options button:not(.primary):not(.action-show):not(.action-close):not(.edit-address-link):not(.ui-datepicker-trigger):not(.button-active) {
     background-color: #eee !important;
     color: black !important;
-}
-
-.opc-payment .payment-method-content .checkout-agreements-block {
-    padding-top: 10px;
-}
+}
\ No newline at end of file
diff --git a/view/frontend/web/js/action/gift-message-item.js b/view/frontend/web/js/action/gift-message-item.js
index be65f78..b6de6a9 100644
--- a/view/frontend/web/js/action/gift-message-item.js
+++ b/view/frontend/web/js/action/gift-message-item.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/gift-wrap.js b/view/frontend/web/js/action/gift-wrap.js
index eb6c205..ea40834 100644
--- a/view/frontend/web/js/action/gift-wrap.js
+++ b/view/frontend/web/js/action/gift-wrap.js
@@ -1,23 +1,7 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
-
 define(
     [
         'Magento_Checkout/js/model/quote',
diff --git a/view/frontend/web/js/action/payment-total-information.js b/view/frontend/web/js/action/payment-total-information.js
index 1e5b92d..2991592 100644
--- a/view/frontend/web/js/action/payment-total-information.js
+++ b/view/frontend/web/js/action/payment-total-information.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/place-order-mixins.js b/view/frontend/web/js/action/place-order-mixins.js
deleted file mode 100644
index cbf064c..0000000
--- a/view/frontend/web/js/action/place-order-mixins.js
+++ /dev/null
@@ -1,48 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-define([
-    'jquery',
-    'mage/utils/wrapper',
-    'Mageplaza_Osc/js/action/set-checkout-information',
-], function ($, wrapper, setCheckoutInformationAction) {
-    'use strict';
-
-    return function (placeOrderAction) {
-        return wrapper.wrap(placeOrderAction, function (originalAction, paymentData, messageContainer) {
-            var deferred = $.Deferred();
-            if(paymentData && paymentData.method === 'braintree_paypal') {
-                setCheckoutInformationAction().done(function() {
-                    originalAction(paymentData, messageContainer).done(function(response) {
-                        deferred.resolve(response);
-                    }).fail(function(response){
-                        deferred.reject(response);
-                    })
-                }).fail(function(response){
-                    deferred.reject(response);
-                })
-            } else {
-                return originalAction(paymentData, messageContainer);
-            }
-
-            return deferred;
-        });
-    };
-});
\ No newline at end of file
diff --git a/view/frontend/web/js/action/save-email-to-quote.js b/view/frontend/web/js/action/save-email-to-quote.js
deleted file mode 100644
index 9fb9069..0000000
--- a/view/frontend/web/js/action/save-email-to-quote.js
+++ /dev/null
@@ -1,40 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-define(
-    [
-        'mage/storage',
-        'Mageplaza_Osc/js/model/resource-url-manager',
-        'Magento_Checkout/js/model/quote',
-    ],
-    function (storage, resourceUrlManager, quote) {
-        'use strict';
-
-        return function (email) {
-            return storage.post(
-                resourceUrlManager.getUrlForSaveEmailToQuote(quote),
-                JSON.stringify({
-                    email: email
-                }),
-                false
-            );
-        };
-    }
-);
diff --git a/view/frontend/web/js/action/set-checkout-information.js b/view/frontend/web/js/action/set-checkout-information.js
index e5a6687..f6afb05 100644
--- a/view/frontend/web/js/action/set-checkout-information.js
+++ b/view/frontend/web/js/action/set-checkout-information.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/set-payment-method.js b/view/frontend/web/js/action/set-payment-method.js
deleted file mode 100644
index 08dd87b..0000000
--- a/view/frontend/web/js/action/set-payment-method.js
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-define([
-    'underscore',
-    'jquery',
-    'Magento_Checkout/js/model/quote',
-    'Magento_Checkout/js/model/url-builder',
-    'mage/storage',
-    'Magento_Checkout/js/model/error-processor',
-    'Magento_Customer/js/model/customer',
-    'Magento_Checkout/js/model/full-screen-loader',
-    'Magento_CheckoutAgreements/js/model/agreements-assigner'
-], function ($, _, quote, urlBuilder, storage, errorProcessor, customer, fullScreenLoader, agreementsAssigner) {
-    'use strict';
-
-    return function (messageContainer) {
-        var serviceUrl,
-            payload,
-            paymentData = _.extend({}, quote.paymentMethod());
-
-        agreementsAssigner(paymentData);
-        /**
-         * Checkout for guest and registered customer.
-         */
-        if (!customer.isLoggedIn()) {
-            serviceUrl = urlBuilder.createUrl('/guest-carts/:cartId/set-payment-information', {
-                cartId: quote.getQuoteId()
-            });
-            payload = {
-                cartId: quote.getQuoteId(),
-                email: quote.guestEmail,
-                paymentMethod: paymentData
-            };
-        } else {
-            serviceUrl = urlBuilder.createUrl('/carts/mine/set-payment-information', {});
-            payload = {
-                cartId: quote.getQuoteId(),
-                paymentMethod: paymentData
-            };
-        }
-        fullScreenLoader.startLoader();
-
-        return storage.post(
-            serviceUrl, JSON.stringify(payload)
-        ).fail(function (response) {
-            errorProcessor.process(response, messageContainer);
-        }).always(function () {
-            fullScreenLoader.stopLoader();
-        });
-    };
-});
diff --git a/view/frontend/web/js/action/update-item.js b/view/frontend/web/js/action/update-item.js
index 220a266..e6675fb 100644
--- a/view/frontend/web/js/action/update-item.js
+++ b/view/frontend/web/js/action/update-item.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/address/auto-complete.js b/view/frontend/web/js/model/address/auto-complete.js
index 37645be..0b5360f 100644
--- a/view/frontend/web/js/model/address/auto-complete.js
+++ b/view/frontend/web/js/model/address/auto-complete.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/address/type/google.js b/view/frontend/web/js/model/address/type/google.js
index 6624c03..c316c2f 100644
--- a/view/frontend/web/js/model/address/type/google.js
+++ b/view/frontend/web/js/model/address/type/google.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -37,7 +37,6 @@ define([
         country: 'short_name',
         postal_code: 'short_name'
     };
-    var isUsedMaterialDesign = window.checkoutConfig.oscConfig.isUsedMaterialDesign;
 
     return Class.extend({
         initialize: function (fieldsetName) {
@@ -82,10 +81,6 @@ define([
                 }
 
                 this.autoComplete = new google.maps.places.Autocomplete(this.inputSelector, options);
-                if(isUsedMaterialDesign) {
-                    $(this.inputSelector).attr('placeholder', '');
-                }
-
                 this.autoComplete.addListener('place_changed', this.placeChangedListener.bind(this));
 
                 //if(!specificCountry) {
diff --git a/view/frontend/web/js/model/agreement-validator.js b/view/frontend/web/js/model/agreement-validator.js
index 6bb4203..cf78544 100644
--- a/view/frontend/web/js/model/agreement-validator.js
+++ b/view/frontend/web/js/model/agreement-validator.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/agreements-assigner.js b/view/frontend/web/js/model/agreements-assigner.js
index d73e3ee..08bad7d 100644
--- a/view/frontend/web/js/model/agreements-assigner.js
+++ b/view/frontend/web/js/model/agreements-assigner.js
@@ -1,21 +1,6 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2013-2017 Magento, Inc. All rights reserved.
+ * See COPYING.txt for license details.
  */
 
 /*jshint browser:true jquery:true*/
@@ -26,22 +11,18 @@ define([
     'use strict';
 
     var agreementsConfig = window.checkoutConfig.checkoutAgreements;
-    var show_toc = window.checkoutConfig.oscConfig.show_toc;
-    var SHOW_IN_PAYMENT = '1';
 
     /** Override default place order action and add agreement_ids to request */
     return function (paymentData) {
         var agreementForm,
-            agreementFormContainer,
             agreementData,
             agreementIds;
 
         if (!agreementsConfig.isEnabled) {
             return;
         }
-        agreementFormContainer = (show_toc == SHOW_IN_PAYMENT) ? $('.payment-method._active') :$('#co-place-order-agreement');
-        agreementForm = agreementFormContainer.find('div[data-role=checkout-agreements] input');
 
+        agreementForm = $('#co-place-order-agreement div[data-role=checkout-agreements] input');
         agreementData = agreementForm.serializeArray();
         agreementIds = [];
 
diff --git a/view/frontend/web/js/model/braintree-paypal.js b/view/frontend/web/js/model/braintree-paypal.js
index c772848..e8c7260 100644
--- a/view/frontend/web/js/model/braintree-paypal.js
+++ b/view/frontend/web/js/model/braintree-paypal.js
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
 define(['ko'], function (ko) {
     'use strict';
     return {
diff --git a/view/frontend/web/js/model/checkout-data-resolver.js b/view/frontend/web/js/model/checkout-data-resolver.js
index 9704097..ebe99fe 100644
--- a/view/frontend/web/js/model/checkout-data-resolver.js
+++ b/view/frontend/web/js/model/checkout-data-resolver.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/gift-message.js b/view/frontend/web/js/model/gift-message.js
index 781a678..6090e7c 100644
--- a/view/frontend/web/js/model/gift-message.js
+++ b/view/frontend/web/js/model/gift-message.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/gift-wrap.js b/view/frontend/web/js/model/gift-wrap.js
index fc0e03a..962330d 100644
--- a/view/frontend/web/js/model/gift-wrap.js
+++ b/view/frontend/web/js/model/gift-wrap.js
@@ -1,23 +1,7 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
-
 define(['ko'], function(ko) {
     'use strict';
     var hasWrap = ko.observable(window.checkoutConfig.oscConfig.giftWrap.hasWrap);
diff --git a/view/frontend/web/js/model/osc-data.js b/view/frontend/web/js/model/osc-data.js
index 86ec39c..d9431fb 100644
--- a/view/frontend/web/js/model/osc-data.js
+++ b/view/frontend/web/js/model/osc-data.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/osc-loader.js b/view/frontend/web/js/model/osc-loader.js
index f932acb..82ee576 100644
--- a/view/frontend/web/js/model/osc-loader.js
+++ b/view/frontend/web/js/model/osc-loader.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/osc-loader/discount.js b/view/frontend/web/js/model/osc-loader/discount.js
index ae87cf2..9e20337 100644
--- a/view/frontend/web/js/model/osc-loader/discount.js
+++ b/view/frontend/web/js/model/osc-loader/discount.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/payment-service.js b/view/frontend/web/js/model/payment-service.js
index 3cdec7f..72aa437 100644
--- a/view/frontend/web/js/model/payment-service.js
+++ b/view/frontend/web/js/model/payment-service.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/paypal/set-payment-method-mixin.js b/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
deleted file mode 100644
index 81c3e85..0000000
--- a/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
+++ /dev/null
@@ -1,35 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-/*global alert*/
-define([
-    'jquery',
-    'mage/utils/wrapper',
-    'Mageplaza_Osc/js/action/set-payment-method'
-], function ($, wrapper, setPaymentMethodAction) {
-    'use strict';
-
-    return function (originalSetPaymentMethodAction) {
-        /** Override place-order-mixin for set-payment-information action as they differs only by method signature */
-        return wrapper.wrap(originalSetPaymentMethodAction, function (originalAction, messageContainer) {
-            return setPaymentMethodAction(messageContainer);
-        });
-    };
-});
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index cfaf17f..6641502 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -27,14 +27,6 @@ define(
         "use strict";
 
         return $.extend({
-            /** Get url for saving checkout information */
-            getUrlForSaveEmailToQuote: function (quote) {
-                var params = {cartId: quote.getQuoteId()};
-                var urls = {
-                    'guest': '/guest-carts/:cartId/save-email-to-quote',
-                };
-                return this.getUrl(urls, params);
-            },
 
             /** Get url for update item qty and remove item */
             getUrlForUpdateItemInformation: function (quote, isRemove) {
diff --git a/view/frontend/web/js/model/shipping-rate-service.js b/view/frontend/web/js/model/shipping-rate-service.js
index d8af678..5e3d140 100644
--- a/view/frontend/web/js/model/shipping-rate-service.js
+++ b/view/frontend/web/js/model/shipping-rate-service.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index 3e61959..78db769 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/shipping-save-processor/checkout.js b/view/frontend/web/js/model/shipping-save-processor/checkout.js
index 8ca5125..5389aa8 100644
--- a/view/frontend/web/js/model/shipping-save-processor/checkout.js
+++ b/view/frontend/web/js/model/shipping-save-processor/checkout.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -22,7 +22,6 @@ define(
     [
         'ko',
         'jquery',
-        'underscore',
         'Magento_Checkout/js/model/quote',
         'Mageplaza_Osc/js/model/resource-url-manager',
         'mage/storage',
@@ -35,7 +34,6 @@ define(
     ],
     function (ko,
               $,
-              _,
               quote,
               resourceUrlManager,
               storage,
@@ -71,20 +69,9 @@ define(
                     return $.Deferred().resolve();
                 }
 
-                var customAttributes = {};
-                if(_.isObject(quote.billingAddress().customAttributes)) {
-                    _.each(quote.billingAddress().customAttributes, function (attribute, key) {
-                        if(_.isObject(attribute)) {
-                            customAttributes[attribute.attribute_code] = attribute.value
-                        } else if(_.isString(attribute)) {
-                            customAttributes[key] = attribute
-                        }
-                    });
-                }
-
                 payload = {
                     addressInformation: addressInformation,
-                    customerAttributes: customAttributes,
+                    customerAttributes: quote.billingAddress().customAttributes,
                     additionInformation: additionInformation
                 };
 
diff --git a/view/frontend/web/js/view/authentication.js b/view/frontend/web/js/view/authentication.js
index 2fcc0a6..071980d 100644
--- a/view/frontend/web/js/view/authentication.js
+++ b/view/frontend/web/js/view/authentication.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 7660176..50d6fe2 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -207,18 +207,9 @@ define(
                         var addressFlat = addressConverter.formDataProviderToFlatData(
                             this.collectObservedData(),
                             'billingAddress'
-                        ), newBillingAddress;
-
-                        if (customer.isLoggedIn() && !this.customerHasAddresses) {
-                            this.saveInAddressBook(1);
-                        }
-                        addressFlat.save_in_address_book = this.saveInAddressBook() ? 1 : 0;
-                        newBillingAddress = createBillingAddress(addressFlat);
+                        );
 
-                        // New address must be selected as a billing address
-                        selectBillingAddress(newBillingAddress);
-                        checkoutData.setSelectedBillingAddress(newBillingAddress.getKey());
-                        checkoutData.setNewCustomerBillingAddress(addressFlat);
+                        selectBillingAddress(addressConverter.formAddressDataToQuoteAddress(addressFlat));
 
                         if (window.checkoutConfig.reloadOnBillingAddress && (fieldName == 'country_id')) {
                             setBillingAddressAction(globalMessageList);
diff --git a/view/frontend/web/js/view/delivery-time.js b/view/frontend/web/js/view/delivery-time.js
index bfdfc71..817abeb 100644
--- a/view/frontend/web/js/view/delivery-time.js
+++ b/view/frontend/web/js/view/delivery-time.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index 8ac3579..4a8e686 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -26,13 +26,11 @@ define([
     'Mageplaza_Osc/js/model/osc-data',
     'Magento_Checkout/js/model/payment/additional-validators',
     'Magento_Customer/js/action/check-email-availability',
-    'Mageplaza_Osc/js/action/save-email-to-quote',
     'mage/url',
     'rjsResolver',
     'mage/validation'
-], function ($, ko, Component, customer, oscData, additionalValidators, checkEmailAvailability, saveEmailToQuote, urlBuilder, resolver) {
+], function ($, ko, Component, customer, oscData, additionalValidators, checkEmailAvailability,urlBuilder, resolver) {
     'use strict';
-    window.saveEmailToQuote = saveEmailToQuote;
 
     var cacheKey = 'form_register_chechbox',
         allowGuestCheckout = window.checkoutConfig.oscConfig.allowGuestCheckout,
@@ -53,7 +51,6 @@ define([
             }
         },
         checkDelay: 0,
-        savingEmailRequest: null,
         dataPasswordMinLength: passwordMinLength,
         dataPasswordMinCharacterSets: passwordMinCharacter,
 
@@ -81,30 +78,6 @@ define([
             return this;
         },
 
-        /**
-         * Check email existing.
-         */
-        checkEmailAvailability: function () {
-            this._super();
-            this.validateSaveEmailRequest();
-            this.savingEmailRequest = saveEmailToQuote(this.email());
-        },
-
-        /**
-         * If request has been sent -> abort it.
-         * ReadyStates for request aborting:
-         * 1 - The request has been set up
-         * 2 - The request has been sent
-         * 3 - The request is in process
-         */
-        validateSaveEmailRequest: function () {
-            var checkRequest = this.savingEmailRequest;
-            if (checkRequest != null && $.inArray(checkRequest.readyState, [1, 2, 3])) {
-                checkRequest.abort();
-                checkRequest = null;
-            }
-        },
-
         triggerLogin: function () {
             if($('.osc-authentication-wrapper a.action-auth-toggle').hasClass('osc-authentication-toggle')){
                 $('.osc-authentication-toggle').trigger('click');
diff --git a/view/frontend/web/js/view/form/element/region.js b/view/frontend/web/js/view/form/element/region.js
index 6bd970d..2c5fe9a 100644
--- a/view/frontend/web/js/view/form/element/region.js
+++ b/view/frontend/web/js/view/form/element/region.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/form/element/street.js b/view/frontend/web/js/view/form/element/street.js
index c867955..8e4f280 100644
--- a/view/frontend/web/js/view/form/element/street.js
+++ b/view/frontend/web/js/view/form/element/street.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/geoip.js b/view/frontend/web/js/view/geoip.js
index 17fc975..57b1aec 100644
--- a/view/frontend/web/js/view/geoip.js
+++ b/view/frontend/web/js/view/geoip.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/payment.js b/view/frontend/web/js/view/payment.js
index 6c0148a..4d9e926 100644
--- a/view/frontend/web/js/view/payment.js
+++ b/view/frontend/web/js/view/payment.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/payment/discount.js b/view/frontend/web/js/view/payment/discount.js
index 0b81262..7b095ba 100644
--- a/view/frontend/web/js/view/payment/discount.js
+++ b/view/frontend/web/js/view/payment/discount.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js b/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
index 14db60f..2141339 100644
--- a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
+++ b/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
@@ -1,31 +1,9 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
 define([
     'jquery',
     'Mageplaza_Osc/js/action/set-checkout-information',
     'Mageplaza_Osc/js/model/braintree-paypal',
     'Magento_Checkout/js/model/payment/additional-validators',
-    'Magento_Checkout/js/model/quote',
-    'underscore',
-], function ($, setCheckoutInformationAction, braintreePaypalModel, additionalValidators, quote, _) {
+], function ($, setCheckoutInformationAction, braintreePaypalModel, additionalValidators) {
     'use strict';
         return function (BraintreePaypalComponent) {
             return BraintreePaypalComponent.extend({
@@ -43,33 +21,6 @@ define([
                     this.active = braintreePaypalModel.active;
 
                     return this;
-                },
-                /**
-                 * Get shipping address
-                 * @returns {Object}
-                 */
-                getShippingAddress: function () {
-                    var address = quote.shippingAddress();
-                    if (!address) {
-                        address = {};
-                    }
-                    if (!address.street) {
-                        address.street = ['', ''];
-                    }
-                    if (address.postcode === null) {
-                        return {};
-                    }
-
-                    return {
-                        recipientName: address.firstname + ' ' + address.lastname,
-                        streetAddress: address.street[0],
-                        locality: address.city,
-                        countryCodeAlpha2: address.countryId,
-                        postalCode: address.postcode,
-                        region: address.regionCode,
-                        phone: address.telephone,
-                        editable: this.isAllowOverrideShippingAddress()
-                    };
                 }
             })
         }
diff --git a/view/frontend/web/js/view/review/addition.js b/view/frontend/web/js/view/review/addition.js
index a43c1bf..d492ae0 100644
--- a/view/frontend/web/js/view/review/addition.js
+++ b/view/frontend/web/js/view/review/addition.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/gift-message.js b/view/frontend/web/js/view/review/addition/gift-message.js
index ca87fb8..e3346f8 100644
--- a/view/frontend/web/js/view/review/addition/gift-message.js
+++ b/view/frontend/web/js/view/review/addition/gift-message.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/gift-wrap.js b/view/frontend/web/js/view/review/addition/gift-wrap.js
index 97c26a2..3004a76 100644
--- a/view/frontend/web/js/view/review/addition/gift-wrap.js
+++ b/view/frontend/web/js/view/review/addition/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/newsletter.js b/view/frontend/web/js/view/review/addition/newsletter.js
index 7f3703a..047c258 100644
--- a/view/frontend/web/js/view/review/addition/newsletter.js
+++ b/view/frontend/web/js/view/review/addition/newsletter.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -38,7 +38,7 @@ define(
                     .observe({
                         isRegisterNewsletter: (typeof oscData.getData(cacheKey) === 'undefined') ? window.checkoutConfig.oscConfig.newsletterDefault : oscData.getData(cacheKey)
                     });
-                oscData.setData(cacheKey, this.isRegisterNewsletter());
+
                 this.isRegisterNewsletter.subscribe(function (newValue) {
                     oscData.setData(cacheKey, newValue);
                 });
diff --git a/view/frontend/web/js/view/review/checkout-agreements.js b/view/frontend/web/js/view/review/checkout-agreements.js
index 825d71d..dc40441 100644
--- a/view/frontend/web/js/view/review/checkout-agreements.js
+++ b/view/frontend/web/js/view/review/checkout-agreements.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/comment.js b/view/frontend/web/js/view/review/comment.js
index 2a7be1d..af48906 100644
--- a/view/frontend/web/js/view/review/comment.js
+++ b/view/frontend/web/js/view/review/comment.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/placeOrder.js b/view/frontend/web/js/view/review/placeOrder.js
index 58ac972..16c27ff 100644
--- a/view/frontend/web/js/view/review/placeOrder.js
+++ b/view/frontend/web/js/view/review/placeOrder.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -46,7 +46,7 @@ define(
         return Component.extend({
             defaults: {
                 template: 'Mageplaza_Osc/container/review/place-order',
-                visibleBraintreeButton: false,
+                visibleBraintreeButton: false
             },
             braintreePaypalModel: braintreePaypalModel,
             selectors: {
@@ -56,7 +56,7 @@ define(
                 this._super();
                 var self = this;
                 quote.paymentMethod.subscribe(function (value) {
-                    self.processVisiblePlaceOrderButton();
+                    self.checkVisiblePlaceOrderButton();
                 });
 
                 registry.async(this.getPaymentPath('braintree_paypal'))
@@ -76,21 +76,11 @@ define(
 
                 return this;
             },
-            asyncBraintreePaypal: function() {
-                this.processVisiblePlaceOrderButton();
+            asyncBraintreePaypal: function () {
+                this.checkVisiblePlaceOrderButton();
             },
-            isBraintreeNewVersion: function() {
-                var component = this.getBraintreePaypalComponent();
-                return component
-                    && typeof component.isReviewRequired == "function"
-                    && typeof component.getButtonTitle == "function";
-            },
-            processVisiblePlaceOrderButton: function() {
-                this.visibleBraintreeButton(this.checkVisiblePlaceOrderButton());
-            },
-            checkVisiblePlaceOrderButton: function() {
-                return this.getBraintreePaypalComponent()
-                    && this.isPaymentBraintreePaypal();
+            checkVisiblePlaceOrderButton: function () {
+                this.visibleBraintreeButton(this.getBraintreePaypalComponent() && this.isPaymentBraintreePaypal());
             },
             placeOrder: function () {
                 var self = this;
@@ -105,8 +95,11 @@ define(
 
             brainTreePaypalPlaceOrder: function () {
                 var component = this.getBraintreePaypalComponent();
+                var _arguments = arguments;
                 if(component && additionalValidators.validate()) {
-                    component.placeOrder.apply(component, arguments);
+                    this.preparePlaceOrder().done(function () {
+                        component.placeOrder.apply(component, _arguments);
+                    });
                 }
 
                 return this;
@@ -114,11 +107,16 @@ define(
 
             brainTreePayWithPayPal: function () {
                 var component = this.getBraintreePaypalComponent();
+                var _arguments = arguments;
                 if(component && additionalValidators.validate()) {
-                    component.payWithPayPal.apply(component, arguments);
+                    if(component.isSkipOrderReview()) {
+                        this.preparePlaceOrder().done(function () {
+                            component.payWithPayPal.apply(component, _arguments);
+                        });
+                    } else {
+                        component.payWithPayPal.apply(component, _arguments);
+                    }
                 }
-
-                return this;
             },
             preparePlaceOrder: function (scrollTop) {
                 var scrollTop = scrollTop !== undefined ? scrollTop : true;
@@ -137,6 +135,7 @@ define(
                 return registry.get(this.getPaymentPath(paymentMethodCode));
             },
 
+
             isPaymentBraintreePaypal: function () {
                 return quote.paymentMethod() && quote.paymentMethod().method === 'braintree_paypal';
             },
@@ -154,4 +153,4 @@ define(
             }
         });
     }
-);
\ No newline at end of file
+);
diff --git a/view/frontend/web/js/view/shipping-address/address-renderer/default.js b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
index 003e1d4..1b630ac 100644
--- a/view/frontend/web/js/view/shipping-address/address-renderer/default.js
+++ b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/shipping-postnl.js b/view/frontend/web/js/view/shipping-postnl.js
index 5edd60b..3705ebd 100644
--- a/view/frontend/web/js/view/shipping-postnl.js
+++ b/view/frontend/web/js/view/shipping-postnl.js
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
 define([
     'jquery',
     'TIG_PostNL/js/Helper/State',
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index 5ca2855..36ff37f 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -63,17 +63,6 @@ define(
 
         /** Set shipping methods to collection */
         shippingService.setShippingRates(window.checkoutConfig.shippingMethods);
-        function prepareSubscribeStreet(address) {
-            address.subscribe(function (newAddress) {
-                if(_.isObject(newAddress)) {
-                    if(!newAddress.street || !newAddress.street.length) {
-                        newAddress.street = ['', ''];
-                    }
-                }
-            });
-        }
-        prepareSubscribeStreet(quote.shippingAddress);
-        prepareSubscribeStreet(quote.billingAddress);
 
         return Component.extend({
             defaults: {
diff --git a/view/frontend/web/js/view/summary/gift-wrap.js b/view/frontend/web/js/view/summary/gift-wrap.js
index e4b9fe7..d4de324 100644
--- a/view/frontend/web/js/view/summary/gift-wrap.js
+++ b/view/frontend/web/js/view/summary/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/summary/item/details.js b/view/frontend/web/js/view/summary/item/details.js
index 00de90e..de67052 100644
--- a/view/frontend/web/js/view/summary/item/details.js
+++ b/view/frontend/web/js/view/summary/item/details.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -74,8 +74,7 @@ define(
              * Init popup gift message item window
              * @param element
              */
-            setModalElement: function (element, item_id) {
-                var self = this;
+            setModalElement: function (element) {
                 this.modalWindow = element;
                 var options = {
                     'type': 'popup',
@@ -84,10 +83,7 @@ define(
                     'responsive': true,
                     'innerScroll': true,
                     'trigger': '#' +element.id ,
-                    'buttons': [],
-                    'opened': function () {
-                        self.loadGiftMessageItem(item_id);
-                    }
+                    'buttons': []
                 };
                 modal(options, $(this.modalWindow));
             },
@@ -97,7 +93,7 @@ define(
              * @param itemId
              */
             loadGiftMessageItem: function(itemId){
-                $('.popup-gift-message-item._show #item'+ itemId).find('input:text,textarea').val('');
+                $('.popup-gift-message-item #item'+ itemId).find('input:text,textarea').val('');
                 if(giftMessageOptions.giftMessage.itemLevel[itemId].hasOwnProperty('message')
                     && typeof giftMessageOptions.giftMessage.itemLevel[itemId]['message'] == 'object'){
                     var giftMessageItem = giftMessageOptions.giftMessage.itemLevel[itemId]['message'];
@@ -117,7 +113,7 @@ define(
              * @returns {string}
              */
             createSelectorElement: function(selector){
-                return '.popup-gift-message-item._show #item'+ selector;
+                return '.popup-gift-message-item #item'+ selector;
             },
 
             /**
@@ -125,6 +121,7 @@ define(
              * @param itemId
              */
             updateGiftMessageItem: function(itemId){
+
                 var data = {
                     gift_message: {
                         sender:     $(this.createSelectorElement(itemId +' #gift-message-whole-from')).val(),
diff --git a/view/frontend/web/js/view/survey.js b/view/frontend/web/js/view/survey.js
index 4f0f807..e92ca0c 100644
--- a/view/frontend/web/js/view/survey.js
+++ b/view/frontend/web/js/view/survey.js
@@ -14,10 +14,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 define([
     'jquery'
 ], function($) {
diff --git a/view/frontend/web/template/1column.html b/view/frontend/web/template/1column.html
index 5e21dc7..9127555 100644
--- a/view/frontend/web/template/1column.html
+++ b/view/frontend/web/template/1column.html
@@ -15,11 +15,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <!-- ko foreach: getRegion('estimation') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
diff --git a/view/frontend/web/template/2columns.html b/view/frontend/web/template/2columns.html
index 2f7b3f6..34221bf 100644
--- a/view/frontend/web/template/2columns.html
+++ b/view/frontend/web/template/2columns.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index fb875db..d22060d 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -15,11 +15,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <!-- ko foreach: getRegion('estimation') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
diff --git a/view/frontend/web/template/3columns.html b/view/frontend/web/template/3columns.html
index cbb8d62..f938692 100644
--- a/view/frontend/web/template/3columns.html
+++ b/view/frontend/web/template/3columns.html
@@ -15,11 +15,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <!-- ko foreach: getRegion('estimation') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index cbdb6c3..6067448 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing/checkbox.html b/view/frontend/web/template/container/address/billing/checkbox.html
index 056d9fa..98f921d 100644
--- a/view/frontend/web/template/container/address/billing/checkbox.html
+++ b/view/frontend/web/template/container/address/billing/checkbox.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing/create.html b/view/frontend/web/template/container/address/billing/create.html
index c6c89c3..8ccc7f3 100644
--- a/view/frontend/web/template/container/address/billing/create.html
+++ b/view/frontend/web/template/container/address/billing/create.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index bb36d2a..e6d95a4 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping/address-renderer/default.html b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
index 19c6cd6..389a126 100644
--- a/view/frontend/web/template/container/address/shipping/address-renderer/default.html
+++ b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping/form.html b/view/frontend/web/template/container/address/shipping/form.html
index be3e0a1..2e661be 100644
--- a/view/frontend/web/template/container/address/shipping/form.html
+++ b/view/frontend/web/template/container/address/shipping/form.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/authentication.html b/view/frontend/web/template/container/authentication.html
index 1bcc60f..5fbfe1e 100644
--- a/view/frontend/web/template/container/authentication.html
+++ b/view/frontend/web/template/container/authentication.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/delivery-time.html b/view/frontend/web/template/container/delivery-time.html
index b227586..501ab29 100644
--- a/view/frontend/web/template/container/delivery-time.html
+++ b/view/frontend/web/template/container/delivery-time.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/email.html b/view/frontend/web/template/container/form/element/email.html
index 7261094..f8433a5 100644
--- a/view/frontend/web/template/container/form/element/email.html
+++ b/view/frontend/web/template/container/form/element/email.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/input.html b/view/frontend/web/template/container/form/element/input.html
index f02ddd9..ad502d7 100644
--- a/view/frontend/web/template/container/form/element/input.html
+++ b/view/frontend/web/template/container/form/element/input.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/street.html b/view/frontend/web/template/container/form/element/street.html
index 944c2c4..cf9dc14 100644
--- a/view/frontend/web/template/container/form/element/street.html
+++ b/view/frontend/web/template/container/form/element/street.html
@@ -15,12 +15,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
 
-<input class="input-text" required type="text" data-bind="
+<input class="input-text" type="text" data-bind="
     value: value,
     hasFocus: focused,
     attr: {
diff --git a/view/frontend/web/template/container/form/field.html b/view/frontend/web/template/container/form/field.html
index 35a4b9b..3ada7bf 100644
--- a/view/frontend/web/template/container/form/field.html
+++ b/view/frontend/web/template/container/form/field.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/payment.html b/view/frontend/web/template/container/payment.html
index ef29885..8d6e208 100644
--- a/view/frontend/web/template/container/payment.html
+++ b/view/frontend/web/template/container/payment.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/payment/discount.html b/view/frontend/web/template/container/payment/discount.html
index d5570fd..bfb87dd 100644
--- a/view/frontend/web/template/container/payment/discount.html
+++ b/view/frontend/web/template/container/payment/discount.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition.html b/view/frontend/web/template/container/review/addition.html
index af3ecca..67dd084 100644
--- a/view/frontend/web/template/container/review/addition.html
+++ b/view/frontend/web/template/container/review/addition.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/gift-message.html b/view/frontend/web/template/container/review/addition/gift-message.html
index b540707..7272330 100644
--- a/view/frontend/web/template/container/review/addition/gift-message.html
+++ b/view/frontend/web/template/container/review/addition/gift-message.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -79,8 +79,8 @@
                 <!-- /ko -->
                 <!-- ko if: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
                 <div class="control">
-                    <textarea id="gift-message-whole-message"
-                              class="input-text material"
+                    <textarea id="gift-message-whole-message material"
+                              class="input-text"
                               rows="3" cols="10"
                               data-bind="value: getObservable('message'),attr:{placeholder: $t('Message')}"></textarea>
                 </div>
diff --git a/view/frontend/web/template/container/review/addition/gift-wrap.html b/view/frontend/web/template/container/review/addition/gift-wrap.html
index cad553b..fedda4e 100644
--- a/view/frontend/web/template/container/review/addition/gift-wrap.html
+++ b/view/frontend/web/template/container/review/addition/gift-wrap.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/newsletter.html b/view/frontend/web/template/container/review/addition/newsletter.html
index b6c1b96..dceb3e8 100644
--- a/view/frontend/web/template/container/review/addition/newsletter.html
+++ b/view/frontend/web/template/container/review/addition/newsletter.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/comment.html b/view/frontend/web/template/container/review/comment.html
index 414b7af..3b4eafc 100644
--- a/view/frontend/web/template/container/review/comment.html
+++ b/view/frontend/web/template/container/review/comment.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/discount.html b/view/frontend/web/template/container/review/discount.html
index c37cbb0..7dca378 100644
--- a/view/frontend/web/template/container/review/discount.html
+++ b/view/frontend/web/template/container/review/discount.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/place-order.html b/view/frontend/web/template/container/review/place-order.html
index 6170b7b..aea33b8 100644
--- a/view/frontend/web/template/container/review/place-order.html
+++ b/view/frontend/web/template/container/review/place-order.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -44,7 +44,6 @@
 <!-- /ko -->
 <!-- ko if: visibleBraintreeButton() -->
 <div class="actions-toolbar">
-    <!-- ko if: isBraintreeNewVersion() -->
     <div class="payment-method-item braintree-paypal-account" data-bind="visible: braintreePaypalModel.isReviewRequired()">
         <span class="payment-method-type">PayPal</span>
         <span class="payment-method-description" data-bind="text: braintreePaypalModel.customerEmail()"></span>
@@ -71,17 +70,5 @@
             <span data-bind="i18n: getBraintreePaypalComponent().getButtonTitle()"></span>
         </button>
     </div>
-    <!-- /ko -->
-    <!-- ko ifnot: isBraintreeNewVersion() -->
-    <div class="place-order-primary">
-        <button data-button="place" data-role="review-save"
-                type="submit"
-                data-bind="attr: {title: $t('Place Order')}, enable: (getBraintreePaypalComponent().isActive()), click: brainTreePayWithPayPal"
-                class="action primary checkout"
-                disabled>
-            <span data-bind="i18n: 'Place Order'"></span>
-        </button>
-    </div>
-    <!-- /ko -->
 </div>
 <!-- /ko -->
\ No newline at end of file
diff --git a/view/frontend/web/template/container/shipping.html b/view/frontend/web/template/container/shipping.html
index 3e37d7d..3b101a1 100644
--- a/view/frontend/web/template/container/shipping.html
+++ b/view/frontend/web/template/container/shipping.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/sidebar.html b/view/frontend/web/template/container/sidebar.html
index e673233..050bc05 100644
--- a/view/frontend/web/template/container/sidebar.html
+++ b/view/frontend/web/template/container/sidebar.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary.html b/view/frontend/web/template/container/summary.html
index c257aaf..a28796c 100644
--- a/view/frontend/web/template/container/summary.html
+++ b/view/frontend/web/template/container/summary.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/cart-items.html b/view/frontend/web/template/container/summary/cart-items.html
index f958246..7cb5718 100644
--- a/view/frontend/web/template/container/summary/cart-items.html
+++ b/view/frontend/web/template/container/summary/cart-items.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/gift-wrap.html b/view/frontend/web/template/container/summary/gift-wrap.html
index e5ae4cb..1dc2f4b 100644
--- a/view/frontend/web/template/container/summary/gift-wrap.html
+++ b/view/frontend/web/template/container/summary/gift-wrap.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/item/details.html b/view/frontend/web/template/container/summary/item/details.html
index ba81c3e..25674c5 100644
--- a/view/frontend/web/template/container/summary/item/details.html
+++ b/view/frontend/web/template/container/summary/item/details.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -61,10 +61,10 @@
 
     <!-- ko if: isItemAvailable($parent.item_id) -->
     <div class="gift-message-item-content">
-        <div class="gift-message-item" data-bind="attr: { id: 'item' +$parent.item_id, title: giftMessageItemsTitleHover}">
+        <div class="gift-message-item" data-bind="attr: { id: 'item' +$parent.item_id, title: giftMessageItemsTitleHover},click: loadGiftMessageItem.bind($data,$parent.item_id)">
             <i class="fa fa-gift fa-2x" aria-hidden="true"></i>
         </div>
-        <div style="display: none" data-bind="attr: { id: 'item' + $parent.item_id,title: $parent.name},afterRender: function(element){setModalElement(element, $parent.item_id)}">
+        <div style="display: none" data-bind="attr: { id: 'item' + $parent.item_id,title: $parent.name},afterRender: setModalElement">
             <div class="gift-options-content">
                 <div class="fieldset">
                     <div class="field field-from col-mp mp-6">
