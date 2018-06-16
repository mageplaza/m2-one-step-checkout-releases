diff --git a/Api/GuestCheckoutManagementInterface.php b/Api/GuestCheckoutManagementInterface.php
index 00a3cc7..1119992 100644
--- a/Api/GuestCheckoutManagementInterface.php
+++ b/Api/GuestCheckoutManagementInterface.php
@@ -75,15 +75,4 @@ interface GuestCheckoutManagementInterface
      * @return bool
      */
     public function saveEmailToQuote($cartId, $email);
-
-    /**
-     * Check if given email is associated with a customer account in given website.
-     *
-     * @param string $cartId
-     * @param string $customerEmail
-     * @param int $websiteId If not set, will use the current websiteId
-     * @return bool
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    public function isEmailAvailable($cartId, $customerEmail, $websiteId = null);
 }
diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index c1f8d80..089d8d9 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -34,343 +34,334 @@ use Mageplaza\Osc\Helper\Config as OscHelper;
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
-
-		$this->rewriteFieldStreet($fields);
-
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
-		/**
-		 * Compatible Amazon Pay
-		 */
-		if($this->_oscHelper->isEnableAmazonPay()){
-			$fields['inline-form-manipulator'] = array(
-				'component' => 'Mageplaza_Osc/js/view/amazon'
-			);
-
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
-			if ($this->_oscHelper->isUsedMaterialDesign()) {
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
-	public function rewriteFieldStreet(&$fields)
-	{
-
-		if ($this->_oscHelper->isUsedMaterialDesign()) {
-			$fields['country_id']['config']['template'] = 'Mageplaza_Osc/container/form/field';
-			$fields['region_id']['config']['template']  = 'Mageplaza_Osc/container/form/field';
-			foreach ($fields['street']['children'] as $key => $value) {
-				$fields['street']['children'][0]['label']                 = $fields['street']['label'];
-				$fields['street']['children'][$key]['config']['template'] = 'Mageplaza_Osc/container/form/field';
-			}
-			$fields['street']['config']['fieldTemplate'] = 'Mageplaza_Osc/container/form/field';
-			unset($fields['street']['label']);
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
+     * @type \Mageplaza\Osc\Helper\Config
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
+     * @type \Magento\Checkout\Model\Session
+     */
+    private $checkoutSession;
+
+    /**
+     * @param \Magento\Checkout\Model\Session $checkoutSession
+     * @param \Mageplaza\Osc\Helper\Config $oscHelper
+     * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+     * @param \Magento\Ui\Component\Form\AttributeMapper $attributeMapper
+     * @param \Magento\Checkout\Block\Checkout\AttributeMerger $merger
+     */
+    public function __construct(
+        CheckoutSession $checkoutSession,
+        OscHelper $oscHelper,
+        AttributeMetadataDataProvider $attributeMetadataDataProvider,
+        AttributeMapper $attributeMapper,
+        AttributeMerger $merger
+    )
+    {
+        $this->checkoutSession               = $checkoutSession;
+        $this->_oscHelper                    = $oscHelper;
+        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
+        $this->attributeMapper               = $attributeMapper;
+        $this->merger                        = $merger;
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
+        if (!$this->_oscHelper->isOscPage()) {
+            return $jsLayout;
+        }
+
+        /** Shipping address fields */
+        if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+            ['children']['shippingAddress']['children']['shipping-address-fieldset']['children'])) {
+            $fields                                               = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+            ['children']['shipping-address-fieldset']['children'];
+            $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+            ['children']['shipping-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'shippingAddress');
+        }
+
+        /** Billing address fields */
+        if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+            ['children']['billingAddress']['children']['billing-address-fieldset']['children'])) {
+            $fields                                              = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
+            ['children']['billing-address-fieldset']['children'];
+            $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
+            ['children']['billing-address-fieldset']['children'] = $this->getAddressFieldset($fields, 'billingAddress');
+        }
+
+        /** Remove billing customer email if quote is not virtual */
+        if (!$this->checkoutSession->getQuote()->isVirtual()) {
+            unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['billingAddress']
+                ['children']['customer-email']);
+        }
+
+        /** Remove billing address in payment method content */
+        $fields = &$jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
+        ['payment']['children']['payments-list']['children'];
+        foreach ($fields as $code => $field) {
+            if ($field['component'] == 'Magento_Checkout/js/view/billing-address') {
+                unset($fields[$code]);
+            }
+        }
+
+        return $jsLayout;
+    }
+
+    /**
+     * Get address fieldset for shipping/billing address
+     *
+     * @param $fields
+     * @return array
+     */
+    public function getAddressFieldset($fields, $type)
+    {
+        $elements = $this->getAddressAttributes();
+
+        $systemAttribute = $elements['default'];
+        if (sizeof($systemAttribute)) {
+            $attributesToConvert = [
+                'prefix' => [$this->getOptions(), 'getNamePrefixOptions'],
+                'suffix' => [$this->getOptions(), 'getNameSuffixOptions'],
+            ];
+            $systemAttribute     = $this->convertElementsToSelect($systemAttribute, $attributesToConvert);
+            $fields              = $this->merger->merge(
+                $systemAttribute,
+                'checkoutProvider',
+                $type,
+                $fields
+            );
+        }
+
+        $customAttribute = $elements['custom'];
+        if (sizeof($customAttribute)) {
+            $fields = $this->merger->merge(
+                $customAttribute,
+                'checkoutProvider',
+                $type . '.custom_attributes',
+                $fields
+            );
+        }
+
+        $this->addCustomerAttribute($fields, $type);
+        $this->addAddressOption($fields);
+
+
+        return $fields;
+    }
+
+    /**
+     * Add customer attribute like gender, dob, taxvat
+     *
+     * @param $fields
+     * @param $type
+     * @return $this
+     */
+    private function addCustomerAttribute(&$fields, $type)
+    {
+        $attributes      = $this->attributeMetadataDataProvider->loadAttributesCollection(
+            'customer',
+            'customer_account_create'
+        );
+        $addressElements = [];
+        foreach ($attributes as $attribute) {
+            if (!$this->_oscHelper->isCustomerAttributeVisible($attribute)) {
+                continue;
+            }
+            $addressElements[$attribute->getAttributeCode()] = $this->attributeMapper->map($attribute);
+        }
+
+        $fields = $this->merger->merge(
+            $addressElements,
+            'checkoutProvider',
+            $type . '.custom_attributes',
+            $fields
+        );
+
+        return $this;
+    }
+
+    /**
+     * @param $fields
+     * @return $this
+     */
+    private function addAddressOption(&$fields)
+    {
+        $fieldPosition = $this->_oscHelper->getAddressFieldPosition();
+
+        $this->rewriteFieldStreet($fields);
+
+        foreach ($fields as $code => &$field) {
+            $fieldConfig = isset($fieldPosition[$code]) ? $fieldPosition[$code] : [];
+            if (!sizeof($fieldConfig)) {
+                if (in_array($code, ['country_id'])) {
+                    $field['config']['additionalClasses'] = "mp-hidden";
+                    continue;
+                } else {
+                    unset($fields[$code]);
+                }
+            } else {
+                $oriClasses                           = isset($field['config']['additionalClasses']) ? $field['config']['additionalClasses'] : '';
+                $field['config']['additionalClasses'] = "{$oriClasses} col-mp mp-{$fieldConfig['colspan']}" . ($fieldConfig['isNewRow'] ? ' mp-clear' : '');
+                $field['sortOrder']                   = $fieldConfig['sortOrder'];
+                if ($code == 'dob') {
+                    $field['options'] = ['yearRange' => '-120y:c+nn', 'maxDate' => '-1d', 'changeMonth' => true, 'changeYear' => true];
+                }
+
+                $this->rewriteTemplate($field);
+            }
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
+                if ($key == 0 && in_array('street', explode('.', $field['dataScope'])) && $this->_oscHelper->isGoogleHttps()) {
+                    $this->rewriteTemplate($child, 'Mageplaza_Osc/container/form/element/street');
+                    continue;
+                }
+                $this->rewriteTemplate($child);
+            }
+        } elseif (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
+            $field['config']['elementTmpl'] = $template;
+            if ($this->_oscHelper->isUsedMaterialDesign()) {
+                $field['config']['template'] = 'Mageplaza_Osc/container/form/field';
+            }
+        }
+
+        return $this;
+    }
+
+    /**
+     * Change template street when enable material design
+     * @param $fields
+     * @return $this
+     */
+    public function rewriteFieldStreet(&$fields)
+    {
+
+        if ($this->_oscHelper->isUsedMaterialDesign()) {
+            $fields['country_id']['config']['template'] = 'Mageplaza_Osc/container/form/field';
+            $fields['region_id']['config']['template']  = 'Mageplaza_Osc/container/form/field';
+            foreach ($fields['street']['children'] as $key => $value) {
+                $fields['street']['children'][0]['label']                 = $fields['street']['label'];
+                $fields['street']['children'][$key]['config']['template'] = 'Mageplaza_Osc/container/form/field';
+            }
+            $fields['street']['config']['fieldTemplate'] = 'Mageplaza_Osc/container/form/field';
+            unset($fields['street']['label']);
+        }
+
+        return $this;
+    }
+
+    /**
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
+        $elements = [
+            'custom'  => [],
+            'default' => []
+        ];
+        foreach ($attributes as $attribute) {
+            $code    = $attribute->getAttributeCode();
+            $element = $this->attributeMapper->map($attribute);
+            if (isset($element['label'])) {
+                $label            = $element['label'];
+                $element['label'] = __($label);
+            }
+
+            ($attribute->getIsUserDefined()) ?
+                $elements['custom'][$code] = $element :
+                $elements['default'][$code] = $element;
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
 }
diff --git a/Helper/Config.php b/Helper/Config.php
index 2409110..ee2d06b 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -817,14 +817,6 @@ class Config extends AbstractData
         return $this->isModuleOutputEnabled('TIG_PostNL');
     }
 
-	/**
-	 * @return bool
-	 */
-	public function isEnableAmazonPay()
-	{
-		return $this->isModuleOutputEnabled('Amazon_Payment');
-	}
-
     /**
      * Get current theme id
      * @return mixed
diff --git a/Model/CheckoutRegister.php b/Model/CheckoutRegister.php
index 6f61f40..0fd6a9e 100644
--- a/Model/CheckoutRegister.php
+++ b/Model/CheckoutRegister.php
@@ -150,6 +150,9 @@ class CheckoutRegister
         $quote->setCustomer($customer);
         $this->_oscHelperData->setFlagOscMethodRegister(true);
 
+        /** Create customer */
+        $this->customerManagement->populateCustomerInfo($quote);
+
         /** Init customer address */
         $customerBillingData = $billing->exportCustomerAddress();
         $customerBillingData->setIsDefaultBilling(true)
@@ -174,14 +177,11 @@ class CheckoutRegister
         // Add billing address to quote since customer Data Object does not hold address information
         $quote->addCustomerAddress($customerBillingData);
 
-        /** Create customer */
-        $this->customerManagement->populateCustomerInfo($quote);
-
         // If customer is created, set customerId for address to avoid create more address when checkout
         if ($customerId = $quote->getCustomerId()) {
-            $quote->getBillingAddress()->setCustomerId($customerId);
-            if (!$quote->isVirtual()) {
-                $quote->getShippingAddress()->setCustomerId($customerId);
+            $billing->setCustomerId($customerId);
+            if ($shipping) {
+                $shipping->setCustomerId($customerId);
             }
         }
     }
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index a12342f..65cbdd9 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -39,193 +39,190 @@ use Mageplaza\Osc\Model\Geoip\Database\Reader;
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
-	 * DefaultConfigProvider constructor.
-	 * @param CheckoutSession $checkoutSession
-	 * @param PaymentMethodManagementInterface $paymentMethodManagement
-	 * @param ShippingMethodManagementInterface $shippingMethodManagement
-	 * @param OscConfig $oscConfig
-	 * @param CompositeConfigProvider $configProvider
-	 * @param ModuleManager $moduleManager
-	 * @param HelperData $helperData
-	 * @param Reader $geoIpData
-	 */
-	public function __construct(
-		CheckoutSession $checkoutSession,
-		PaymentMethodManagementInterface $paymentMethodManagement,
-		ShippingMethodManagementInterface $shippingMethodManagement,
-		OscConfig $oscConfig,
-		CompositeConfigProvider $configProvider,
-		ModuleManager $moduleManager,
-		HelperData $helperData,
-		Reader $geoIpData
-	)
-	{
-		$this->checkoutSession           = $checkoutSession;
-		$this->paymentMethodManagement   = $paymentMethodManagement;
-		$this->shippingMethodManagement  = $shippingMethodManagement;
-		$this->oscConfig                 = $oscConfig;
-		$this->giftMessageConfigProvider = $configProvider;
-		$this->moduleManager             = $moduleManager;
-		$this->_helperData               = $helperData;
-		$this->_geoIpData                = $geoIpData;
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
-			'selectedShippingRate'  => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod()) ? $existShippingMethod : $this->oscConfig->getDefaultShippingMethod(),
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
-			'addressFields'           => $this->_helperData->getAddressFields(),
-			'autocomplete'            => [
-				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
-				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
-			],
-			'register'                => [
-				'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
-				'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
-			],
-			'allowGuestCheckout'      => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
-			'showBillingAddress'      => $this->oscConfig->getShowBillingAddress(),
-			'newsletterDefault'       => $this->oscConfig->isSubscribedByDefault(),
-			'isUsedGiftWrap'          => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
-			'giftMessageOptions'      => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), ['isEnableOscGiftMessageItems' => $this->oscConfig->isEnableGiftMessageItems()]),
-			'isDisplaySocialLogin'    => $this->isDisplaySocialLogin(),
-			'deliveryTimeOptions'     => [
-				'deliveryTimeFormat' => $this->oscConfig->getDeliveryTimeFormat(),
-				'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff(),
-				'houseSecurityCode'  => $this->oscConfig->isDisabledHouseSecurityCode()
-			],
-			'isUsedMaterialDesign'    => $this->oscConfig->isUsedMaterialDesign(),
-			'isAmazonAccountLoggedIn' => false,
-			'geoIpOptions'            => [
-				'isEnableGeoIp' => $this->oscConfig->isEnableGeoIP(),
-				'geoIpData'     => $this->getGeoIpData()
-			],
-			'compatible'              => [
-				'isEnableModulePostNL' => $this->oscConfig->isEnableModulePostNL(),
-			],
-			'show_toc'                => $this->oscConfig->getShowTOC()
-		];
-	}
-
-	/**
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
-	 * Returns array of payment methods
-	 * @return array
-	 */
-	private function getPaymentMethods()
-	{
-		$paymentMethods = [];
-		$quote          = $this->checkoutSession->getQuote();
-        if (!$quote->getIsVirtual()) {
-            foreach ($this->paymentMethodManagement->getList($quote->getId()) as $paymentMethod) {
-                $paymentMethods[] = [
-                    'code'  => $paymentMethod->getCode(),
-                    'title' => $paymentMethod->getTitle()
-                ];
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
+     * @var \Magento\Checkout\Model\CompositeConfigProvider
+     */
+    protected $giftMessageConfigProvider;
+
+    /**
+     * @var ModuleManager
+     */
+    protected $moduleManager;
+
+    /**
+     * @type \Mageplaza\Osc\Helper\Data
+     */
+    protected $_helperData;
+
+    /**
+     * @type \Mageplaza\Osc\Model\Geoip\Database\Reader
+     */
+    protected $_geoIpData;
+
+    /**
+     * DefaultConfigProvider constructor.
+     * @param CheckoutSession $checkoutSession
+     * @param PaymentMethodManagementInterface $paymentMethodManagement
+     * @param ShippingMethodManagementInterface $shippingMethodManagement
+     * @param OscConfig $oscConfig
+     * @param CompositeConfigProvider $configProvider
+     * @param ModuleManager $moduleManager
+     * @param HelperData $helperData
+     * @param Reader $geoIpData
+     */
+    public function __construct(
+        CheckoutSession $checkoutSession,
+        PaymentMethodManagementInterface $paymentMethodManagement,
+        ShippingMethodManagementInterface $shippingMethodManagement,
+        OscConfig $oscConfig,
+        CompositeConfigProvider $configProvider,
+        ModuleManager $moduleManager,
+        HelperData $helperData,
+        Reader $geoIpData
+    )
+    {
+        $this->checkoutSession           = $checkoutSession;
+        $this->paymentMethodManagement   = $paymentMethodManagement;
+        $this->shippingMethodManagement  = $shippingMethodManagement;
+        $this->oscConfig                 = $oscConfig;
+        $this->giftMessageConfigProvider = $configProvider;
+        $this->moduleManager             = $moduleManager;
+        $this->_helperData               = $helperData;
+        $this->_geoIpData                = $geoIpData;
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
+            'selectedShippingRate'  => !empty($existShippingMethod = $this->checkoutSession->getQuote()->getShippingAddress()->getShippingMethod()) ? $existShippingMethod : $this->oscConfig->getDefaultShippingMethod(),
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
+            'addressFields'        => $this->_helperData->getAddressFields(),
+            'autocomplete'         => [
+                'type'                   => $this->oscConfig->getAutoDetectedAddress(),
+                'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
+            ],
+            'register'             => [
+                'dataPasswordMinLength'        => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH),
+                'dataPasswordMinCharacterSets' => $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER)
+            ],
+            'allowGuestCheckout'   => $this->oscConfig->getAllowGuestCheckout($this->checkoutSession->getQuote()),
+            'showBillingAddress'   => $this->oscConfig->getShowBillingAddress(),
+            'newsletterDefault'    => $this->oscConfig->isSubscribedByDefault(),
+            'isUsedGiftWrap'       => (bool)$this->checkoutSession->getQuote()->getShippingAddress()->getUsedGiftWrap(),
+            'giftMessageOptions'   => array_merge_recursive($this->giftMessageConfigProvider->getConfig(), ['isEnableOscGiftMessageItems' => $this->oscConfig->isEnableGiftMessageItems()]),
+            'isDisplaySocialLogin' => $this->isDisplaySocialLogin(),
+            'deliveryTimeOptions'  => [
+                'deliveryTimeFormat' => $this->oscConfig->getDeliveryTimeFormat(),
+                'deliveryTimeOff'    => $this->oscConfig->getDeliveryTimeOff(),
+                'houseSecurityCode'  => $this->oscConfig->isDisabledHouseSecurityCode()
+            ],
+            'isUsedMaterialDesign' => $this->oscConfig->isUsedMaterialDesign(),
+            'geoIpOptions'         => [
+                'isEnableGeoIp' => $this->oscConfig->isEnableGeoIP(),
+                'geoIpData'     => $this->getGeoIpData()
+            ],
+            'compatible'           => [
+                'isEnableModulePostNL' => $this->oscConfig->isEnableModulePostNL(),
+            ],
+            'show_toc'             => $this->oscConfig->getShowTOC()
+        ];
+    }
+
+    /**
+     * @return mixed
+     */
+    public function getGeoIpData()
+    {
+        if ($this->oscConfig->isEnableGeoIP() && $this->_helperData->checkHasLibrary()) {
+            $ip = $_SERVER['REMOTE_ADDR'];
+            if (!filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE) || $ip == '127.0.0.1') {
+                $ip = '123.16.189.71';
             }
+            $data = $this->_geoIpData->city($ip);
+
+            return $this->_helperData->getGeoIpData($data);
+        }
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
         }
 
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
-
-	/**
-	 * @return bool
-	 */
-	private function isDisplaySocialLogin()
-	{
-
-		return $this->moduleManager->isOutputEnabled('Mageplaza_SocialLogin') && !$this->oscConfig->isDisabledSocialLoginOnCheckout();
-	}
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
+     * @return bool
+     */
+    private function isDisplaySocialLogin()
+    {
+
+        return $this->moduleManager->isOutputEnabled('Mageplaza_SocialLogin') && !$this->oscConfig->isDisabledSocialLoginOnCheckout();
+    }
 }
diff --git a/Model/GuestCheckoutManagement.php b/Model/GuestCheckoutManagement.php
index ce99b5e..ae04027 100644
--- a/Model/GuestCheckoutManagement.php
+++ b/Model/GuestCheckoutManagement.php
@@ -23,7 +23,6 @@ namespace Mageplaza\Osc\Model;
 
 use Magento\Quote\Api\CartRepositoryInterface;
 use Mageplaza\Osc\Api\GuestCheckoutManagementInterface;
-use Magento\Customer\Api\AccountManagementInterface;
 
 /**
  * Class GuestCheckoutManagement
@@ -47,28 +46,20 @@ class GuestCheckoutManagement implements GuestCheckoutManagementInterface
     protected $cartRepository;
 
     /**
-     * @var AccountManagementInterface
-     */
-    protected $accountManagement;
-
-    /**
      * GuestCheckoutManagement constructor.
      * @param \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory
      * @param \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
      * @param CartRepositoryInterface $cartRepository
-     * @param AccountManagementInterface $accountManagement
      */
     public function __construct(
         \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory,
         \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement,
-        CartRepositoryInterface $cartRepository,
-        AccountManagementInterface $accountManagement
-    ) {
-
-        $this->quoteIdMaskFactory   = $quoteIdMaskFactory;
+        CartRepositoryInterface $cartRepository
+    )
+    {
+        $this->quoteIdMaskFactory = $quoteIdMaskFactory;
         $this->checkoutManagement = $checkoutManagement;
-        $this->cartRepository = $cartRepository;
-        $this->accountManagement = $accountManagement;
+        $this->cartRepository     = $cartRepository;
     }
 
     /**
@@ -155,14 +146,4 @@ class GuestCheckoutManagement implements GuestCheckoutManagementInterface
 
         return true;
     }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function isEmailAvailable($cartId, $customerEmail, $websiteId = null)
-    {
-        $this->saveEmailToQuote($cartId, $customerEmail);
-
-        return $this->accountManagement->isEmailAvailable($customerEmail, $websiteId = null);
-    }
 }
diff --git a/Model/Plugin/Authorization/UserContext.php b/Model/Plugin/Authorization/UserContext.php
deleted file mode 100644
index 003d860..0000000
--- a/Model/Plugin/Authorization/UserContext.php
+++ /dev/null
@@ -1,78 +0,0 @@
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
-namespace Mageplaza\Osc\Model\Plugin\Authorization;
-
-use Magento\Authorization\Model\UserContextInterface;
-
-class UserContext
-{
-    /**
-     * @var \Mageplaza\Osc\Helper\Data
-     */
-    protected $_oscHelperData;
-
-    /**
-     * @var \Magento\Checkout\Model\Session
-     */
-    protected $_checkoutSession;
-
-    /**
-     * UserContext constructor.
-     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     */
-    public function __construct(
-        \Mageplaza\Osc\Helper\Data $oscHelperData,
-        \Magento\Checkout\Model\Session $checkoutSession
-    ) {
-        $this->_oscHelperData = $oscHelperData;
-        $this->_checkoutSession = $checkoutSession;
-    }
-
-    /**
-     * @param UserContextInterface $userContext
-     * @param $result
-     * @return int
-     */
-    public function afterGetUserType(UserContextInterface $userContext, $result)
-    {
-        if($this->_oscHelperData->isFlagOscMethodRegister()) {
-            return UserContextInterface::USER_TYPE_CUSTOMER;
-        }
-
-        return $result;
-    }
-
-    /**
-     * @param UserContextInterface $userContext
-     * @param $result
-     * @return int
-     */
-    public function afterGetUserId(UserContextInterface $userContext, $result)
-    {
-        if($this->_oscHelperData->isFlagOscMethodRegister()) {
-            return $this->_checkoutSession->getQuote()->getCustomerId();
-        }
-
-        return $result;
-    }
-}
\ No newline at end of file
diff --git a/Model/Plugin/Quote/AccessChangeQuoteControl.php b/Model/Plugin/Quote/AccessChangeQuoteControl.php
new file mode 100644
index 0000000..9846844
--- /dev/null
+++ b/Model/Plugin/Quote/AccessChangeQuoteControl.php
@@ -0,0 +1,99 @@
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
+namespace Mageplaza\Osc\Model\Plugin\Quote;
+
+use Magento\Authorization\Model\UserContextInterface;
+use Magento\Framework\Exception\StateException;
+use Magento\Quote\Api\CartRepositoryInterface;
+use Magento\Quote\Api\Data\CartInterface;
+use Magento\Quote\Model\Quote;
+
+/**
+ * Class AccessChangeQuoteControl
+ * @package Mageplaza\Osc\Model\Plugin\Quote
+ */
+class AccessChangeQuoteControl
+{
+    /**
+     * @var \Mageplaza\Osc\Helper\Data
+     */
+    protected $_oscHelperData;
+
+    /**
+     * @var UserContextInterface
+     */
+    protected $userContext;
+
+    /**
+     * AccessChangeQuoteControl constructor.
+     * @param \Mageplaza\Osc\Helper\Data $oscHelperData
+     */
+    public function __construct(\Mageplaza\Osc\Helper\Data $oscHelperData, UserContextInterface $userContext)
+    {
+        $this->_oscHelperData = $oscHelperData;
+        $this->userContext    = $userContext;
+    }
+
+    /**
+     * Checks if change quote's customer id is allowed for current user.
+     *
+     * @param CartRepositoryInterface $subject
+     * @param Quote $quote
+     * @throws StateException if Guest has customer_id or Customer's customer_id not much with user_id
+     * or unknown user's type
+     * @return void
+     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
+     */
+    public function beforeSave(CartRepositoryInterface $subject, CartInterface $quote)
+    {
+        if (!$this->isAllowed($quote)) {
+            throw new StateException(__("Invalid state change requested"));
+        }
+    }
+
+    /**
+     * Checks if user is allowed to change the quote.
+     *
+     * @param Quote $quote
+     * @return bool
+     */
+    private function isAllowed(Quote $quote)
+    {
+        switch ($this->userContext->getUserType()) {
+            case UserContextInterface::USER_TYPE_CUSTOMER:
+                $isAllowed = ($quote->getCustomerId() == $this->userContext->getUserId());
+                break;
+            case UserContextInterface::USER_TYPE_GUEST:
+                $isAllowed = ($this->_oscHelperData->isFlagOscMethodRegister()
+                    || $quote->getCustomerId() === null);
+                break;
+            case UserContextInterface::USER_TYPE_ADMIN:
+            case UserContextInterface::USER_TYPE_INTEGRATION:
+                $isAllowed = true;
+                break;
+            default:
+                $isAllowed = false;
+        }
+
+        return $isAllowed;
+    }
+}
\ No newline at end of file
diff --git a/Observer/QuoteSubmitSuccess.php b/Observer/QuoteSubmitSuccess.php
index 04f5be1..b4cf92c 100644
--- a/Observer/QuoteSubmitSuccess.php
+++ b/Observer/QuoteSubmitSuccess.php
@@ -114,10 +114,7 @@ class QuoteSubmitSuccess implements ObserverInterface
             /* Set customer Id for address */
             if ($customer->getId()) {
                 $quote->getBillingAddress()->setCustomerId($customer->getId());
-
-                if ($shippingAddress = $quote->getShippingAddress()) {
-                    $shippingAddress->setCustomerId($customer->getId());
-                }
+                $quote->getBillingAddress()->setCustomerId($customer->getId());
             }
 
             if ($customer->getId() &&
@@ -134,12 +131,12 @@ class QuoteSubmitSuccess implements ObserverInterface
                 );
             } else {
                 $this->_customerSession->loginById($customer->getId());
-//                $this->_customerSession->regenerateId();
-//                if ($this->getCookieManager()->getCookie('mage-cache-sessid')) {
-//                    $metadata = $this->getCookieMetadataFactory()->createCookieMetadata();
-//                    $metadata->setPath('/');
-//                    $this->getCookieManager()->deleteCookie('mage-cache-sessid', $metadata);
-//                }
+                $this->_customerSession->regenerateId();
+                if ($this->getCookieManager()->getCookie('mage-cache-sessid')) {
+                    $metadata = $this->getCookieMetadataFactory()->createCookieMetadata();
+                    $metadata->setPath('/');
+                    $this->getCookieManager()->deleteCookie('mage-cache-sessid', $metadata);
+                }
             }
         }
 
diff --git a/Observer/RedirectToOneStepCheckout.php b/Observer/RedirectToOneStepCheckout.php
index 8902661..08954df 100644
--- a/Observer/RedirectToOneStepCheckout.php
+++ b/Observer/RedirectToOneStepCheckout.php
@@ -39,18 +39,24 @@ class RedirectToOneStepCheckout implements ObserverInterface
     /** @var HelperConfig */
     protected $_helperConfig;
 
+    /** @var CheckoutSession */
+    protected $checkoutSession;
+
     /**
      * RedirectToOneStepCheckout constructor.
      * @param \Magento\Framework\UrlInterface $url
      * @param \Mageplaza\Osc\Helper\Config $helperConfig
+     * @param \Magento\Checkout\Model\Session $checkoutSession
      */
     public function __construct(
         UrlInterface $url,
-        HelperConfig $helperConfig
+        HelperConfig $helperConfig,
+        CheckoutSession $checkoutSession
     )
     {
         $this->_url            = $url;
         $this->_helperConfig   = $helperConfig;
+        $this->checkoutSession = $checkoutSession;
     }
 
     /**
@@ -61,7 +67,8 @@ class RedirectToOneStepCheckout implements ObserverInterface
     public function execute(Observer $observer)
     {
         if ($this->_helperConfig->isEnabled() && $this->_helperConfig->isRedirectToOneStepCheckout()) {
-            $observer->getRequest()->setParam('return_url', $this->_url->getUrl('onestepcheckout'));
+            $request = $observer->getRequest();
+            $request->setParam('return_url', $this->_url->getUrl('onestepcheckout/'));
         }
     }
 }
\ No newline at end of file
diff --git a/composer.json b/composer.json
index 31b03f5..07ef221 100644
--- a/composer.json
+++ b/composer.json
@@ -5,7 +5,7 @@
         "mageplaza/module-core": "*"
     },
     "type": "magento2-module",
-    "version": "2.4.2",
+    "version": "2.4.1",
     "license": "Mageplaza License",
     "authors": [
         {
diff --git a/etc/webapi.xml b/etc/webapi.xml
index 10b488e..2e89d54 100644
--- a/etc/webapi.xml
+++ b/etc/webapi.xml
@@ -104,10 +104,4 @@
             <resource ref="anonymous"/>
         </resources>
     </route>
-    <route url="/V1/guest-carts/:cartId/isEmailAvailable" method="POST">
-        <service class="Mageplaza\Osc\Api\GuestCheckoutManagementInterface" method="isEmailAvailable"/>
-        <resources>
-            <resource ref="anonymous"/>
-        </resources>
-    </route>
 </routes>
diff --git a/etc/webapi_rest/di.xml b/etc/webapi_rest/di.xml
index b06a397..b6040dd 100644
--- a/etc/webapi_rest/di.xml
+++ b/etc/webapi_rest/di.xml
@@ -26,8 +26,8 @@
     <type name="Magento\Quote\Model\ShippingMethodManagement">
         <plugin name="saveAddressWhenEstimate" type="Mageplaza\Osc\Model\Plugin\Checkout\ShippingMethodManagement"/>
     </type>
-    <type name="Magento\Authorization\Model\CompositeUserContext">
-        <plugin name="mz_osc_usercontext" type="Mageplaza\Osc\Model\Plugin\Authorization\UserContext" />
+    <type name="Magento\Quote\Model\QuoteRepository">
+        <plugin name="accessControl" type="Mageplaza\Osc\Model\Plugin\Quote\AccessChangeQuoteControl" />
     </type>
     <type name="Magento\Paypal\Model\Express">
         <plugin name="mz_osc_PaypalExpress" type="Mageplaza\Osc\Model\Plugin\Paypal\Model\Express" />
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index e9bd494..228ddae 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -109,7 +109,6 @@
                                                     <item name="config" xsi:type="array">
                                                         <item name="deps" xsi:type="array">
                                                             <item name="0" xsi:type="string">checkoutProvider</item>
-                                                            <item name="1" xsi:type="string">checkout.steps.shipping-step.shippingAddress</item>
                                                         </item>
                                                     </item>
                                                     <item name="provider" xsi:type="string">checkoutProvider</item>
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index 25c4bc6..be7009a 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -58,10 +58,6 @@ if (window.location.href.indexOf('onestepcheckout') !== -1) {
                     'Mageplaza_Osc/js/model/paypal/set-payment-method-mixin': true
                 }
             }
-        }
+        },
     };
-
-    if(window.location.href.indexOf('#') !== -1){
-        window.history.pushState("", document.title, window.location.pathname);
-    }
 }
\ No newline at end of file
diff --git a/view/frontend/web/js/action/check-email-availability.js b/view/frontend/web/js/action/check-email-availability.js
deleted file mode 100644
index 012c776..0000000
--- a/view/frontend/web/js/action/check-email-availability.js
+++ /dev/null
@@ -1,22 +0,0 @@
-/**
- * Copyright © Magento, Inc. All rights reserved.
- * See COPYING.txt for license details.
- */
-
-define([
-    'mage/storage',
-    'Mageplaza_Osc/js/model/resource-url-manager',
-    'Magento_Checkout/js/model/quote',
-], function (storage, resourceUrlManager, quote) {
-    'use strict';
-
-    return function (email) {
-        return storage.post(
-            resourceUrlManager.getUrlForCheckIsEmailAvailable(quote),
-            JSON.stringify({
-                customerEmail: email
-            }),
-            false
-        );
-    };
-});
diff --git a/view/frontend/web/js/model/compatible/amazon-pay.js b/view/frontend/web/js/action/save-email-to-quote.js
similarity index 51%
rename from view/frontend/web/js/model/compatible/amazon-pay.js
rename to view/frontend/web/js/action/save-email-to-quote.js
index be6edb2..9fb9069 100644
--- a/view/frontend/web/js/model/compatible/amazon-pay.js
+++ b/view/frontend/web/js/action/save-email-to-quote.js
@@ -18,13 +18,23 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
-define(['ko'], function(ko) {
-    'use strict';
-    var hasLogin = window.checkoutConfig.oscConfig.isAmazonAccountLoggedIn;
-    return {
-        isAmazonAccountLoggedIn: ko.observable(hasLogin),
-        setLogin: function(value){
-            return this.isAmazonAccountLoggedIn(value);
-        }
-    };
-});
\ No newline at end of file
+define(
+    [
+        'mage/storage',
+        'Mageplaza_Osc/js/model/resource-url-manager',
+        'Magento_Checkout/js/model/quote',
+    ],
+    function (storage, resourceUrlManager, quote) {
+        'use strict';
+
+        return function (email) {
+            return storage.post(
+                resourceUrlManager.getUrlForSaveEmailToQuote(quote),
+                JSON.stringify({
+                    email: email
+                }),
+                false
+            );
+        };
+    }
+);
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index 267e34e..cfaf17f 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -27,7 +27,7 @@ define(
         "use strict";
 
         return $.extend({
-            /** Get url for saving email to quote */
+            /** Get url for saving checkout information */
             getUrlForSaveEmailToQuote: function (quote) {
                 var params = {cartId: quote.getQuoteId()};
                 var urls = {
@@ -36,15 +36,6 @@ define(
                 return this.getUrl(urls, params);
             },
 
-            /** Get url for checking email */
-            getUrlForCheckIsEmailAvailable: function (quote) {
-                var params = {cartId: quote.getQuoteId()};
-                var urls = {
-                    'guest': '/guest-carts/:cartId/isEmailAvailable',
-                };
-                return this.getUrl(urls, params);
-            },
-
             /** Get url for update item qty and remove item */
             getUrlForUpdateItemInformation: function (quote, isRemove) {
                 var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
diff --git a/view/frontend/web/js/view/amazon.js b/view/frontend/web/js/view/amazon.js
deleted file mode 100644
index f0751d2..0000000
--- a/view/frontend/web/js/view/amazon.js
+++ /dev/null
@@ -1,41 +0,0 @@
-define([
-    'uiComponent',
-    'jquery',
-    'ko',
-    'Amazon_Payment/js/model/storage',
-    'Magento_Checkout/js/model/shipping-rate-service',
-    'Mageplaza_Osc/js/action/payment-total-information',
-    'Mageplaza_Osc/js/model/compatible/amazon-pay',
-    'Magento_Checkout/js/model/quote'
-], function (Component,$, ko, amazonStorage, shippingService, getPaymentTotalInformation, amazonPay, quote) {
-    'use strict';
-    return Component.extend({
-        defaults: {
-            template: 'Amazon_Payment/shipping-address/inline-form',
-            formSelector: 'co-shipping-form'
-        },
-        initObservable: function () {
-            this._super();
-            amazonStorage.isAmazonAccountLoggedIn.subscribe(function (value) {
-                if(value == false){
-                    window.checkoutConfig.oscConfig.isAmazonAccountLoggedIn = value;
-                    amazonPay.setLogin(value);
-                    if(!quote.isVirtual()){
-                        shippingService.estimateShippingMethod();
-                    }
-                    getPaymentTotalInformation();      
-                }
-
-            }, this);
-
-            return this;
-        },
-        manipulateInlineForm: function () {
-            if (amazonStorage.isAmazonAccountLoggedIn()) {
-                window.checkoutConfig.oscConfig.isAmazonAccountLoggedIn = true;
-                  amazonPay.setLogin(true);
-                  setTimeout(function(){  getPaymentTotalInformation();}, 1000);
-            }
-        }
-    });
-});
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 35c20a4..7660176 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -35,7 +35,6 @@ define(
         'Magento_Ui/js/model/messageList',
         'Magento_Checkout/js/model/checkout-data-resolver',
         'Mageplaza_Osc/js/model/address/auto-complete',
-        'Mageplaza_Osc/js/model/compatible/amazon-pay',
         'uiRegistry',
         'mage/translate',
         'rjsResolver'
@@ -55,7 +54,6 @@ define(
               globalMessageList,
               checkoutDataResolver,
               addressAutoComplete,
-              amazonPay,
               registry,
               $t,
               resolver) {
@@ -69,7 +67,6 @@ define(
                 template: ''
             },
             isCustomerLoggedIn: customer.isLoggedIn,
-            isAmazonAccountLoggedIn: amazonPay.isAmazonAccountLoggedIn,
             quoteIsVirtual: quote.isVirtual(),
 
             canUseShippingAddress: ko.computed(function () {
@@ -206,7 +203,7 @@ define(
                 if (!this.isAddressSameAsShipping()) {
                     if (!canShowBillingAddress) {
                         selectBillingAddress(quote.shippingAddress());
-                    } else if (this.isAddressFormVisible()) {
+                    } else {
                         var addressFlat = addressConverter.formDataProviderToFlatData(
                             this.collectObservedData(),
                             'billingAddress'
@@ -246,11 +243,6 @@ define(
             },
 
             validate: function () {
-
-                if (this.isAmazonAccountLoggedIn()) {
-                    return true;
-                }
-
                 if (this.isAddressSameAsShipping()) {
                     oscData.setData('same_as_shipping', true);
                     return true;
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index 7501715..8ac3579 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -25,12 +25,14 @@ define([
     'Magento_Customer/js/model/customer',
     'Mageplaza_Osc/js/model/osc-data',
     'Magento_Checkout/js/model/payment/additional-validators',
-    'Mageplaza_Osc/js/action/check-email-availability',
+    'Magento_Customer/js/action/check-email-availability',
+    'Mageplaza_Osc/js/action/save-email-to-quote',
     'mage/url',
     'rjsResolver',
     'mage/validation'
-], function ($, ko, Component, customer, oscData, additionalValidators, checkEmailAvailability, urlBuilder, resolver) {
+], function ($, ko, Component, customer, oscData, additionalValidators, checkEmailAvailability, saveEmailToQuote, urlBuilder, resolver) {
     'use strict';
+    window.saveEmailToQuote = saveEmailToQuote;
 
     var cacheKey = 'form_register_chechbox',
         allowGuestCheckout = window.checkoutConfig.oscConfig.allowGuestCheckout,
@@ -83,17 +85,24 @@ define([
          * Check email existing.
          */
         checkEmailAvailability: function () {
-            var self = this;
-            this.validateRequest();
-            this.isLoading(true);
-            this.checkRequest = checkEmailAvailability(this.email());
-            this.checkRequest.done(function (isEmailAvailable) {
-                self.isPasswordVisible(!isEmailAvailable);
-            }).fail(function () {
-                self.isPasswordVisible(false);
-            }).always(function () {
-                self.isLoading(false);
-            });
+            this._super();
+            this.validateSaveEmailRequest();
+            this.savingEmailRequest = saveEmailToQuote(this.email());
+        },
+
+        /**
+         * If request has been sent -> abort it.
+         * ReadyStates for request aborting:
+         * 1 - The request has been set up
+         * 2 - The request has been sent
+         * 3 - The request is in process
+         */
+        validateSaveEmailRequest: function () {
+            var checkRequest = this.savingEmailRequest;
+            if (checkRequest != null && $.inArray(checkRequest.readyState, [1, 2, 3])) {
+                checkRequest.abort();
+                checkRequest = null;
+            }
         },
 
         triggerLogin: function () {
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index 8d2a9c0..5ca2855 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -37,8 +37,6 @@ define(
         'Magento_Checkout/js/model/shipping-service',
         'Mageplaza_Osc/js/model/checkout-data-resolver',
         'Mageplaza_Osc/js/model/address/auto-complete',
-        'Mageplaza_Osc/js/model/compatible/amazon-pay',
-        'Magento_Customer/js/model/address-list',
         'rjsResolver'
     ],
     function ($,
@@ -58,8 +56,6 @@ define(
               shippingService,
               oscDataResolver,
               addressAutoComplete,
-              amazonPay,
-              addressList,
               resolver) {
         'use strict';
 
@@ -67,25 +63,26 @@ define(
 
         /** Set shipping methods to collection */
         shippingService.setShippingRates(window.checkoutConfig.shippingMethods);
+        function prepareSubscribeStreet(address) {
+            address.subscribe(function (newAddress) {
+                if(_.isObject(newAddress)) {
+                    if(!newAddress.street || !newAddress.street.length) {
+                        newAddress.street = ['', ''];
+                    }
+                }
+            });
+        }
+        prepareSubscribeStreet(quote.shippingAddress);
+        prepareSubscribeStreet(quote.billingAddress);
 
         return Component.extend({
             defaults: {
                 template: 'Mageplaza_Osc/container/shipping'
             },
             currentMethod: null,
-            isAmazonAccountLoggedIn: amazonPay.isAmazonAccountLoggedIn,
             initialize: function () {
                 this._super();
 
-                /**
-                 * Solve problem when customer has more than 1 addresses but no one is default shipping address
-                 * Shipping address will not auto select the first one, so billing address throw error when trying to
-                 * calculate isAddressSameAsShipping variable
-                 */
-                if (!quote.shippingAddress() && addressList().length >= 1) {
-                    selectShippingAddress(addressList()[0]);
-                }
-
                 stepNavigator.steps.removeAll();
 
                 //shippingRateService.estimateShippingMethod();
@@ -121,10 +118,6 @@ define(
             },
 
             validate: function () {
-                if(this.isAmazonAccountLoggedIn()){
-                    return true;
-                }
-
                 if (quote.isVirtual()) {
                     return true;
                 }
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index 68a9ebf..cbdb6c3 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -21,41 +21,37 @@
 -->
 
 <div id="billing" class="checkout-billing-address" data-bind="visible: !isAddressSameAsShipping()">
-       <!-- ko if: !isAmazonAccountLoggedIn() -->
-            <div class="step-title" data-role="title">
-                <i class="fa fa-home"></i>
-                <!-- ko if: (window.checkoutConfig.oscConfig.isUsedMaterialDesign && !!Number(window.checkoutConfig.quoteData.is_virtual)) -->
-                <span class="fa-stack fa-2x">
-                    <i class="fa fa-circle fa-stack-2x"></i>
-                    <strong class="fa-stack-1x fa-stack-text fa-inverse">1</strong>
-                </span>
-                <!-- /ko -->
-                <span data-bind="i18n: 'Billing Address'"></span>
-            </div>
-    <!--/ko-->
+    <div class="step-title" data-role="title">
+        <i class="fa fa-home"></i>
+        <!-- ko if: (window.checkoutConfig.oscConfig.isUsedMaterialDesign && !!Number(window.checkoutConfig.quoteData.is_virtual)) -->
+        <span class="fa-stack fa-2x">
+            <i class="fa fa-circle fa-stack-2x"></i>
+            <strong class="fa-stack-1x fa-stack-text fa-inverse">1</strong>
+        </span>
+        <!-- /ko -->
+        <span data-bind="i18n: 'Billing Address'"></span>
+    </div>
     <div id="checkout-step-billing" class="step-content" data-role="content">
         <!-- ko if: (quoteIsVirtual) -->
             <!-- ko foreach: getRegion('customer-email') -->
                 <!-- ko template: getTemplate() --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
-        <!-- ko if: !isAmazonAccountLoggedIn() -->
-            <!-- ko if: (addressOptions.length > 1) -->
-                <!-- ko template: 'Magento_Checkout/billing-address/list' --><!-- /ko -->
-            <!-- /ko -->
 
-            <!-- ko template: 'Magento_Checkout/billing-address/form' --><!-- /ko -->
+        <!-- ko if: (addressOptions.length > 1) -->
+            <!-- ko template: 'Magento_Checkout/billing-address/list' --><!-- /ko -->
+        <!-- /ko -->
+
+        <!-- ko template: 'Magento_Checkout/billing-address/form' --><!-- /ko -->
 
-            <div class="mp-clear"></div>
+        <div class="mp-clear"></div>
 
-            <!-- ko if: (!isCustomerLoggedIn() && quoteIsVirtual) -->
-                <!-- ko foreach: getRegion('customer-email') -->
-                    <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
-                <!--/ko-->
+        <!-- ko if: (!isCustomerLoggedIn() && quoteIsVirtual) -->
+            <!-- ko foreach: getRegion('customer-email') -->
+                <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
         <!--/ko-->
 
-
         <div class="mp-clear"></div>
     </div>
 </div>
\ No newline at end of file
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index 1d41ec0..bb36d2a 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -64,23 +64,21 @@
         <!-- ko template: getTemplate() --><!-- /ko -->
         <!--/ko-->
 
-        <!-- ko if: !isAmazonAccountLoggedIn() -->
-            <!-- Inline address form -->
-            <!-- ko if: (isFormInline) -->
-            <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
-            <!-- /ko -->
+        <!-- Inline address form -->
+        <!-- ko if: (isFormInline) -->
+        <!-- ko template: 'Mageplaza_Osc/container/address/shipping/form' --><!-- /ko -->
+        <!-- /ko -->
 
-            <!-- ko if: (!isCustomerLoggedIn() && !quoteIsVirtual) -->
-                <!-- ko foreach: getRegion('customer-email') -->
-                    <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
-                <!--/ko-->
+        <!-- ko if: (!isCustomerLoggedIn() && !quoteIsVirtual) -->
+            <!-- ko foreach: getRegion('customer-email') -->
+                <!-- ko template: 'Mageplaza_Osc/container/address/billing/create' --><!-- /ko -->
             <!--/ko-->
+        <!--/ko-->
 
-            <div class="mp-clear"></div>
-
-            <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
-                <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
-            <!--/ko-->
+        <div class="mp-clear"></div>
+        
+        <!-- ko scope: 'checkout.steps.shipping-step.billingAddress' -->
+            <!-- ko template: 'Mageplaza_Osc/container/address/billing/checkbox' --><!-- /ko -->
         <!--/ko-->
 
         <div class="mp-clear"></div>
diff --git a/view/frontend/web/template/container/form/element/email.html b/view/frontend/web/template/container/form/element/email.html
index 22b2fba..7261094 100644
--- a/view/frontend/web/template/container/form/element/email.html
+++ b/view/frontend/web/template/container/form/element/email.html
@@ -20,11 +20,6 @@
  */
 -->
 
-<!-- ko foreach: getRegion('amazon-button-region') -->
-<!-- ko template: getTemplate() --><!-- /ko -->
-<!-- /ko -->
-
-
 <!-- ko ifnot: isCustomerLoggedIn() -->
 
 <!-- ko foreach: getRegion('before-login-form') -->
