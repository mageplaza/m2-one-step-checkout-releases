diff --git a/Api/CheckoutManagementInterface.php b/Api/CheckoutManagementInterface.php
index 9069054..70fd167 100644
--- a/Api/CheckoutManagementInterface.php
+++ b/Api/CheckoutManagementInterface.php
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 namespace Mageplaza\Osc\Api;
 
 /**
diff --git a/Api/Data/OscDetailsInterface.php b/Api/Data/OscDetailsInterface.php
index dd8c4a7..30343e1 100644
--- a/Api/Data/OscDetailsInterface.php
+++ b/Api/Data/OscDetailsInterface.php
@@ -1,22 +1,7 @@
 <?php
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
 namespace Mageplaza\Osc\Api\Data;
 
@@ -26,58 +11,60 @@ namespace Mageplaza\Osc\Api\Data;
  */
 interface OscDetailsInterface
 {
-    /**
+	/**#@+
 	 * Constants defined for keys of array, makes typos less likely
 	 */
-    const SHIPPING_METHODS = 'shipping_methods';
+	const SHIPPING_METHODS = 'shipping_methods';
 
-    const PAYMENT_METHODS = 'payment_methods';
+	const PAYMENT_METHODS = 'payment_methods';
 
-    const TOTALS = 'totals';
+	const TOTALS = 'totals';
 
-    const REDIRECT_URL = 'redirect_url';
+	const REDIRECT_URL = 'redirect_url';
 
-    /**
-     * @return \Magento\Quote\Api\Data\ShippingMethodInterface[]
-     */
-    public function getShippingMethods();
+	/**#@-*/
 
-    /**
-     * @param \Magento\Quote\Api\Data\ShippingMethodInterface[] $shippingMethods
-     * @return $this
-     */
-    public function setShippingMethods($shippingMethods);
+	/**
+	 * @return \Magento\Quote\Api\Data\ShippingMethodInterface[]
+	 */
+	public function getShippingMethods();
 
-    /**
-     * @return \Magento\Quote\Api\Data\PaymentMethodInterface[]
-     */
-    public function getPaymentMethods();
+	/**
+	 * @param \Magento\Quote\Api\Data\ShippingMethodInterface[] $shippingMethods
+	 * @return $this
+	 */
+	public function setShippingMethods($shippingMethods);
 
-    /**
-     * @param \Magento\Quote\Api\Data\PaymentMethodInterface[] $paymentMethods
-     * @return $this
-     */
-    public function setPaymentMethods($paymentMethods);
+	/**
+	 * @return \Magento\Quote\Api\Data\PaymentMethodInterface[]
+	 */
+	public function getPaymentMethods();
 
-    /**
-     * @return \Magento\Quote\Api\Data\TotalsInterface
-     */
-    public function getTotals();
+	/**
+	 * @param \Magento\Quote\Api\Data\PaymentMethodInterface[] $paymentMethods
+	 * @return $this
+	 */
+	public function setPaymentMethods($paymentMethods);
 
-    /**
-     * @param \Magento\Quote\Api\Data\TotalsInterface $totals
-     * @return $this
-     */
-    public function setTotals($totals);
+	/**
+	 * @return \Magento\Quote\Api\Data\TotalsInterface
+	 */
+	public function getTotals();
 
-    /**
-     * @return string
-     */
-    public function getRedirectUrl();
+	/**
+	 * @param \Magento\Quote\Api\Data\TotalsInterface $totals
+	 * @return $this
+	 */
+	public function setTotals($totals);
+
+	/**
+	 * @return string
+	 */
+	public function getRedirectUrl();
 
-    /**
-     * @param $url
-     * @return $this
-     */
-    public function setRedirectUrl($url);
+	/**
+	 * @param $url
+	 * @return $this
+	 */
+	public function setRedirectUrl($url);
 }
diff --git a/Api/GuestCheckoutManagementInterface.php b/Api/GuestCheckoutManagementInterface.php
index 1e400ac..a153c60 100644
--- a/Api/GuestCheckoutManagementInterface.php
+++ b/Api/GuestCheckoutManagementInterface.php
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 namespace Mageplaza\Osc\Api;
 
 /**
diff --git a/Block/Adminhtml/Plugin/OrderViewTabInfo.php b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
index 1445663..ed6e32d 100644
--- a/Block/Adminhtml/Plugin/OrderViewTabInfo.php
+++ b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
@@ -1,40 +1,16 @@
 <?php
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
 namespace Mageplaza\Osc\Block\Adminhtml\Plugin;
 
-/**
- * Class OrderViewTabInfo
- * @package Mageplaza\Osc\Block\Adminhtml\Plugin
- */
 class OrderViewTabInfo
 {
-    /**
-     * @param \Magento\Sales\Block\Adminhtml\Order\View\Tab\Info $subject
-     * @param $result
-     * @return string
-     */
-    public function afterGetGiftOptionsHtml(\Magento\Sales\Block\Adminhtml\Order\View\Tab\Info $subject, $result)
-    {
-        $result .= $subject->getChildHtml('osc_additional_content');
+	public function afterGetGiftOptionsHtml(\Magento\Sales\Block\Adminhtml\Order\View\Tab\Info $subject, $result)
+	{
+		$result .= $subject->getChildHtml('osc_additional_content');
 
-        return $result;
-    }
+		return $result;
+	}
 }
diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index a6c19b2..be1a8a0 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -1,22 +1,7 @@
 <?php
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
 namespace Mageplaza\Osc\Block\Checkout;
 
@@ -28,273 +13,258 @@ use Magento\Ui\Component\Form\AttributeMapper;
 use Magento\Checkout\Block\Checkout\AttributeMerger;
 use Magento\Framework\App\RequestInterface;
 
-/**
- * Class LayoutProcessor
- * @package Mageplaza\Osc\Block\Checkout
- */
 class LayoutProcessor implements \Magento\Checkout\Block\Checkout\LayoutProcessorInterface
 {
-    /**
-     * @type \Mageplaza\Osc\Helper\Data
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
-     * @type \Magento\Framework\App\RequestInterface
-     */
-    private $request;
-
-    /**
-     * @type \Magento\Checkout\Model\Session
-     */
-    private $checkoutSession;
-
-    /**
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Mageplaza\Osc\Helper\Data $oscHelper
-     * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
-     * @param \Magento\Ui\Component\Form\AttributeMapper $attributeMapper
-     * @param \Magento\Checkout\Block\Checkout\AttributeMerger $merger
-     * @param \Magento\Framework\App\RequestInterface $request
-     */
-    public function __construct(
-        CheckoutSession $checkoutSession,
-        OscHelper $oscHelper,
-        AttributeMetadataDataProvider $attributeMetadataDataProvider,
-        AttributeMapper $attributeMapper,
-        AttributeMerger $merger,
-        RequestInterface $request
-    ) {
-    
-        $this->checkoutSession               = $checkoutSession;
-        $this->_oscHelper                    = $oscHelper;
-        $this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
-        $this->attributeMapper               = $attributeMapper;
-        $this->merger                        = $merger;
-        $this->request                       = $request;
-    }
-
-    /**
-     * @deprecated
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
-        $elements = [];
-        foreach ($attributes as $attribute) {
-            $code = $attribute->getAttributeCode();
-            if ($attribute->getIsUserDefined()) {
-                continue;
-            }
-            $elements[$code] = $this->attributeMapper->map($attribute);
-            if (isset($elements[$code]['label'])) {
-                $label                    = $elements[$code]['label'];
-                $elements[$code]['label'] = __($label);
-            }
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
-
-    /**
-     * Process js Layout of block
-     *
-     * @param array $jsLayout
-     * @return array
-     */
-    public function process($jsLayout)
-    {
-        if (!$this->_oscHelper->getConfig()->isOscPage()) {
-            return $jsLayout;
-        }
-
-        /** Shipping address fields */
-        $this->sortAddressPosition($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
-        ['children']['shippingAddress']['children']['shipping-address-fieldset']['children']);
-
-        /** Billing address fields */
-        if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
-            ['children']['shippingAddress']['children']['billing-address-form']['children']['form-fields']['children'])) {
-            $fields                                                                     = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-            ['children']['billing-address-form']['children']['form-fields']['children'];
-            $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-            ['children']['billing-address-form']['children']['form-fields']['children'] = $this->getBillingAddressFieldset($fields);
-        }
-
-        /** Disable double load customer-email (don't know why) */
-        if (!$this->checkoutSession->getQuote()->isVirtual()) {
-            unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
-                ['children']['billing-address-form']['children']['customer-email']);
-        }
-
-        /** Remove billing address in payment method content */
-        $fields = $jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
-        ['payment']['children']['payments-list']['children'];
-        foreach ($fields as $code => $field) {
-            if ($field['component'] == 'Magento_Checkout/js/view/billing-address') {
-                unset($jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
-                    ['payment']['children']['payments-list']['children'][$code]);
-            }
-        }
-
-        return $jsLayout;
-    }
-
-    /**
-     * @param $fields
-     * @return array
-     */
-    public function getBillingAddressFieldset($fields)
-    {
-        $attributesToConvert = [
-            'prefix' => [$this->getOptions(), 'getNamePrefixOptions'],
-            'suffix' => [$this->getOptions(), 'getNameSuffixOptions'],
-        ];
-
-        $elements = $this->getAddressAttributes();
-        $elements = $this->convertElementsToSelect($elements, $attributesToConvert);
-
-        $fields = $this->merger->merge(
-            $elements,
-            'checkoutProvider',
-            'billingAddress',
-            $fields
-        );
-
-        $this->sortAddressPosition($fields, 'billing');
-
-        return $fields;
-    }
-
-    /**
-     * @param $fields
-     * @param string $type
-     * @return $this
-     */
-    private function sortAddressPosition(&$fields, $type = 'shipping')
-    {
-        $fieldPosition = $this->_oscHelper->getAddressFieldPosition();
-        foreach ($fields as $code => $field) {
-            if (!isset($fieldPosition[$code])) {
-                $fieldPosition[$code] = [
-                    'sortOrder' => 200,
-                    'colspan'   => 12
-                ];
-            }
-
-            $fields[$code]['sortOrder']                   = $fieldPosition[$code]['sortOrder'];
-            $fields[$code]['config']['additionalClasses'] = [
-                'col-mp'                                 => true,
-                'mp-' . $fieldPosition[$code]['colspan'] => true
-            ];
-
-            $this->rewriteTemplate($fields[$code]);
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
-                if ($key == 0 && in_array('street', explode('.', $field['dataScope'])) && $this->isGoogleHttps()) {
-                    $this->rewriteTemplate($child, 'Mageplaza_Osc/container/form/element/street');
-                    continue;
-                }
-                $this->rewriteTemplate($child);
-            }
-        } elseif (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
-            $field['config']['elementTmpl'] = $template;
-        }
-
-        return $this;
-    }
-
-    /**
-     * @return bool
-     */
-    private function isGoogleHttps()
-    {
-        $isEnable = ($this->_oscHelper->getConfig()->getAutoDetectedAddress() == 'google');
-
-        return $isEnable && $this->request->isSecure();
-    }
+	/**
+	 * @type \Mageplaza\Osc\Helper\Data
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
+	 * @type \Magento\Framework\App\RequestInterface
+	 */
+	private $request;
+
+	/**
+	 * @type \Magento\Checkout\Model\Session
+	 */
+	private $checkoutSession;
+
+	/**
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Mageplaza\Osc\Helper\Data $oscHelper
+	 * @param \Magento\Customer\Model\AttributeMetadataDataProvider $attributeMetadataDataProvider
+	 * @param \Magento\Ui\Component\Form\AttributeMapper $attributeMapper
+	 * @param \Magento\Checkout\Block\Checkout\AttributeMerger $merger
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 */
+	public function __construct(
+		CheckoutSession $checkoutSession,
+		OscHelper $oscHelper,
+		AttributeMetadataDataProvider $attributeMetadataDataProvider,
+		AttributeMapper $attributeMapper,
+		AttributeMerger $merger,
+		RequestInterface $request
+	)
+	{
+		$this->checkoutSession               = $checkoutSession;
+		$this->_oscHelper                    = $oscHelper;
+		$this->attributeMetadataDataProvider = $attributeMetadataDataProvider;
+		$this->attributeMapper               = $attributeMapper;
+		$this->merger                        = $merger;
+		$this->request                       = $request;
+	}
+
+	/**
+	 * @deprecated
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
+		$elements = [];
+		foreach ($attributes as $attribute) {
+			$code = $attribute->getAttributeCode();
+			if ($attribute->getIsUserDefined()) {
+				continue;
+			}
+			$elements[$code] = $this->attributeMapper->map($attribute);
+			if (isset($elements[$code]['label'])) {
+				$label                    = $elements[$code]['label'];
+				$elements[$code]['label'] = __($label);
+			}
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
+
+	/**
+	 * Process js Layout of block
+	 *
+	 * @param array $jsLayout
+	 * @return array
+	 */
+	public function process($jsLayout)
+	{
+		if (!$this->_oscHelper->getConfig()->isOscPage()) {
+			return $jsLayout;
+		}
+
+		/** Shipping address fields */
+		$this->sortAddressPosition($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+		['children']['shippingAddress']['children']['shipping-address-fieldset']['children']);
+
+		/** Billing address fields */
+		if (isset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']
+			['children']['shippingAddress']['children']['billing-address-form']['children']['form-fields']['children']
+		)) {
+			$fields                                                                     = $jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+			['children']['billing-address-form']['children']['form-fields']['children'];
+			$jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+			['children']['billing-address-form']['children']['form-fields']['children'] = $this->getBillingAddressFieldset($fields);
+		}
+
+		/** Disable double load customer-email (don't know why) */
+		if (!$this->checkoutSession->getQuote()->isVirtual()) {
+			unset($jsLayout['components']['checkout']['children']['steps']['children']['shipping-step']['children']['shippingAddress']
+				['children']['billing-address-form']['children']['customer-email']);
+		}
+
+		/** Remove billing address in payment method content */
+		$fields = $jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
+		['payment']['children']['payments-list']['children'];
+		foreach ($fields as $code => $field) {
+			if ($field['component'] == 'Magento_Checkout/js/view/billing-address') {
+				unset($jsLayout['components']['checkout']['children']['steps']['children']['billing-step']['children']
+					['payment']['children']['payments-list']['children'][$code]);
+			}
+		}
+
+		return $jsLayout;
+	}
+
+	public function getBillingAddressFieldset($fields)
+	{
+		$attributesToConvert = [
+			'prefix' => [$this->getOptions(), 'getNamePrefixOptions'],
+			'suffix' => [$this->getOptions(), 'getNameSuffixOptions'],
+		];
+
+		$elements = $this->getAddressAttributes();
+		$elements = $this->convertElementsToSelect($elements, $attributesToConvert);
+
+		$fields = $this->merger->merge(
+			$elements,
+			'checkoutProvider',
+			'billingAddress',
+			$fields
+		);
+
+		$this->sortAddressPosition($fields, 'billing');
+
+		return $fields;
+	}
+
+	private function sortAddressPosition(&$fields, $type = 'shipping')
+	{
+		$fieldPosition = $this->_oscHelper->getAddressFieldPosition();
+		foreach ($fields as $code => $field) {
+			if (!isset($fieldPosition[$code])) {
+				$fieldPosition[$code] = [
+					'sortOrder' => 200,
+					'colspan'   => 12
+				];
+			}
+
+			$fields[$code]['sortOrder']                   = $fieldPosition[$code]['sortOrder'];
+			$fields[$code]['config']['additionalClasses'] = [
+				'col-mp'                                 => true,
+				'mp-' . $fieldPosition[$code]['colspan'] => true
+			];
+
+			$this->rewriteTemplate($fields[$code]);
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
+				if ($key == 0 && in_array('street', explode('.', $field['dataScope'])) && $this->isGoogleHttps()) {
+					$this->rewriteTemplate($child, 'Mageplaza_Osc/container/form/element/street');
+					continue;
+				}
+				$this->rewriteTemplate($child);
+			}
+		} else if (isset($field['config']['elementTmpl']) && $field['config']['elementTmpl'] == "ui/form/element/input") {
+			$field['config']['elementTmpl'] = $template;
+		}
+
+		return $this;
+	}
+
+	private function isGoogleHttps()
+	{
+		$isEnable = ($this->_oscHelper->getConfig()->getAutoDetectedAddress() == 'google');
+
+		return $isEnable && $this->request->isSecure();
+	}
 }
diff --git a/Block/Container.php b/Block/Container.php
index 341eb58..a00f11c 100644
--- a/Block/Container.php
+++ b/Block/Container.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -24,36 +25,24 @@ namespace Mageplaza\Osc\Block;
 use Magento\Framework\View\Element\Template;
 use Mageplaza\Osc\Helper\Data as HelperData;
 
-/**
- * Class Container
- * @package Mageplaza\Osc\Block
- */
 class Container extends Template
 {
-    protected $_helperData;
-    protected $_helperConfig;
+	protected $_helperData;
+	protected $_helperConfig;
 
-    /**
-     * @param \Magento\Framework\View\Element\Template\Context $context
-     * @param \Mageplaza\Osc\Helper\Data $helperData
-     * @param array $data
-     */
-    public function __construct(
-        Template\Context $context,
-        HelperData $helperData,
-        array $data = []
-    ) {
-    
-        $this->_helperData = $helperData;
+	public function __construct(
+		Template\Context $context,
+		HelperData $helperData,
+		array $data = []
+	)
+	{
+		$this->_helperData = $helperData;
 
-        parent::__construct($context, $data);
-    }
+		parent::__construct($context, $data);
+	}
 
-    /**
-     * @return mixed
-     */
-    public function getCheckoutDescription()
-    {
-        return $this->_helperData->getConfig()->getGeneralConfig('description');
-    }
-}
+	public function getCheckoutDescription()
+	{
+		return $this->_helperData->getConfig()->getGeneralConfig('description');
+	}
+}
\ No newline at end of file
diff --git a/Block/Generator/Css.php b/Block/Generator/Css.php
index 0871e9b..f87a52b 100644
--- a/Block/Generator/Css.php
+++ b/Block/Generator/Css.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -13,8 +14,9 @@
  * Do not edit or add to this file if you wish to upgrade this extension to newer
  * version in the future.
  *
- * @category    Mageplaza
- * @package     Mageplaza_Osc
+ * @category   Mageplaza
+ * @package    Mageplaza_Osc
+ * @version    3.0.0
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
@@ -24,62 +26,46 @@ use Mageplaza\Osc\Helper\Config;
 use Magento\Framework\View\Element\Template;
 use Magento\Framework\View\Element\Template\Context;
 
-/**
- * Class Css
- * @package Mageplaza\Osc\Block\Generator
- */
 class Css extends Template
 {
-    /**
-     * @var Config
-     */
-    protected $_helperConfig;
+	/**
+	 * @var Config
+	 */
+	protected $_helperConfig;
+
+	public function __construct(
+		Context $context,
+		Config $helperConfig,
+		array $data = []
+	)
+	{
+		parent::__construct($context, $data);
 
-    /**
-     * @param \Magento\Framework\View\Element\Template\Context $context
-     * @param \Mageplaza\Osc\Helper\Config $helperConfig
-     * @param array $data
-     */
-    public function __construct(
-        Context $context,
-        Config $helperConfig,
-        array $data = []
-    ) {
-    
-        parent::__construct($context, $data);
+		$this->_helperConfig = $helperConfig;
+	}
 
-        $this->_helperConfig = $helperConfig;
-    }
+	public function getFieldColspan($attribute_code)
+	{
+		return 2;
+	}
 
-    /**
-     * @return \Mageplaza\Osc\Helper\Config
-     */
-    public function getHelperConfig()
-    {
-        return $this->_helperConfig;
-    }
+	public function getHelperConfig()
+	{
+		return $this->_helperConfig;
+	}
 
-    /**
-     * @return bool
-     */
-    public function isEnableGoogleApi()
-    {
-        return $this->getHelperConfig()->getAutoDetectedAddress() == 'google';
-    }
+	public function isEnableGoogleApi()
+	{
+		return $this->getHelperConfig()->getAutoDetectedAddress() == 'google';
+	}
 
-    /**
-     * @return mixed
-     */
-    public function getGoogleApiKey()
-    {
-        return $this->getHelperConfig()->getGoogleApiKey();
-    }
+	public function getGoogleApiKey()
+	{
+		return $this->getHelperConfig()->getGoogleApiKey();
+	}
 
-    /**
-     * @return array
-     */
-    public function getDesignConfiguration()
-    {
-        return $this->getHelperConfig()->getDesignConfiguration();
-    }
-}
+	public function getDesignConfiguration()
+	{
+		return $this->getHelperConfig()->getDesignConfiguration();
+	}
+}
\ No newline at end of file
diff --git a/Block/Order/View/Comment.php b/Block/Order/View/Comment.php
index 12ad9b3..40da359 100644
--- a/Block/Order/View/Comment.php
+++ b/Block/Order/View/Comment.php
@@ -18,56 +18,54 @@
  * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     http://mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\Osc\Block\Order\View;
 
-/**
- * Class Comment
- * @package Mageplaza\Osc\Block\Order\View
- */
 class Comment extends \Magento\Framework\View\Element\Template
 {
-    /**
-     * @type \Magento\Framework\Registry|null
-     */
-    protected $_coreRegistry = null;
+	/**
+	 * @type \Magento\Framework\Registry|null
+	 */
+	protected $_coreRegistry = null;
+
+	/**
+	 * @param \Magento\Framework\View\Element\Template\Context $context
+	 * @param \Magento\Framework\Registry $registry
+	 * @param array $data
+	 */
+	public function __construct(
+		\Magento\Framework\View\Element\Template\Context $context,
+		\Magento\Framework\Registry $registry,
+		array $data = []
+	)
+	{
+		$this->_coreRegistry = $registry;
 
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
+		parent::__construct($context, $data);
+	}
 
-        parent::__construct($context, $data);
-    }
+	/**
+	 * Get osc order comment
+	 *
+	 * @return string
+	 */
+	public function getOrderComment()
+	{
+		if ($order = $this->getOrder()) {
+			return $order->getOscOrderComment();
+		}
 
-    /**
-     * Get osc order comment
-     *
-     * @return string
-     */
-    public function getOrderComment()
-    {
-        if ($order = $this->getOrder()) {
-            return $order->getOscOrderComment();
-        }
+		return '';
+	}
 
-        return '';
-    }
+	/**
+	 * Get current order
+	 *
+	 * @return mixed
+	 */
+	public function getOrder()
+	{
+		return $this->_coreRegistry->registry('current_order');
+	}
 
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
+}
\ No newline at end of file
diff --git a/Block/Plugin/Link.php b/Block/Plugin/Link.php
index 07b9ecc..0d1c8d8 100644
--- a/Block/Plugin/Link.php
+++ b/Block/Plugin/Link.php
@@ -20,43 +20,30 @@
  */
 namespace Mageplaza\Osc\Block\Plugin;
 
-/**
- * Class Link
- * @package Mageplaza\Osc\Block\Plugin
- */
 class Link
 {
-    /**
-     * Request object
-     *
-     * @var \Magento\Framework\App\RequestInterface
-     */
-    protected $_request;
-
-    /**
-     * @param \Mageplaza\Osc\Helper\Config $systemConfig
-     */
-    public function __construct(
-        \Magento\Framework\App\RequestInterface $httpRequest,
-        \Mageplaza\Osc\Helper\Config $systemConfig
-    ) {
-    
-        $this->_request      = $httpRequest;
-        $this->_systemConfig = $systemConfig;
-    }
+	/**
+	 * @param \Mageplaza\Osc\Helper\Config $systemConfig
+	 */
+	public function __construct(
+		\Mageplaza\Osc\Helper\Config $systemConfig
+	)
+	{
+		$this->_systemConfig = $systemConfig;
+	}
 
-    /**
-     * @param \Magento\Framework\Url $subject
-     * @param $routePath
-     * @param $routeParams
-     * @return array|null
-     */
-    public function beforeGetUrl(\Magento\Framework\Url $subject, $routePath = null, $routeParams = null)
-    {
-        if ($this->_systemConfig->isEnabled() && $routePath == 'checkout' && $this->_request->getFullActionName() != 'checkout_index_index') {
-            return ['onestepcheckout', $routeParams];
-        }
+	/**
+	 * @param \Magento\Framework\Url $subject
+	 * @param $routePath
+	 * @param $routeParams
+	 * @return array|null
+	 */
+	public function beforeGetUrl(\Magento\Framework\Url $subject, $routePath = null, $routeParams = null)
+	{
+		if($this->_systemConfig->isEnabled() && $routePath == 'checkout'){
+			return ['onestepcheckout', $routeParams];
+		}
 
-        return null;
-    }
-}
+		return null;
+	}
+}
\ No newline at end of file
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index 0ffcc95..f29b99d 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -1,43 +1,24 @@
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+
 namespace Mageplaza\Osc\Controller\Add;
 
-/**
- * Class Index
- * @package Mageplaza\Osc\Controller\Add
- */
 class Index extends \Magento\Checkout\Controller\Cart\Add
 {
-    /**
-     * @return $this|\Magento\Framework\View\Result\Page
-     */
-    public function execute()
-    {
-        $productId = 36;
-        $storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
-        $product = $this->productRepository->getById($productId, false, $storeId);
+	protected $_checkoutHelper;
+
+	/**
+	 *
+	 * @return $this|\Magento\Framework\View\Result\Page
+	 */
+	public function execute()
+	{
+		$productId = 36;
+		$storeId = $this->_objectManager->get('Magento\Store\Model\StoreManagerInterface')->getStore()->getId();
+		$product = $this->productRepository->getById($productId, false, $storeId);
 
-        $this->cart->addProduct($product, []);
-        $this->cart->save();
+		$this->cart->addProduct($product, []);
+		$this->cart->save();
 
-        return $this->goBack($this->_url->getUrl('onestepcheckout'));
-    }
+		return $this->goBack($this->_url->getUrl('onestepcheckout'));
+	}
 }
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index a3cd3e0..095cb0c 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -1,93 +1,60 @@
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
+
 namespace Mageplaza\Osc\Controller\Index;
 
-/**
- * Class Index
- * @package Mageplaza\Osc\Controller\Index
- */
 class Index extends \Magento\Checkout\Controller\Onepage
 {
-    /**
-     * @type \Mageplaza\Osc\Helper\Data
-     */
-    protected $_checkoutHelper;
-
-    /**
-     *
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
-        $resultPage = $this->resultPageFactory->create();
-        $resultPage->getConfig()->getTitle()->set($this->_checkoutHelper->getConfig()->getCheckoutTitle());
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
-            $shippingAddress->setCountryId($this->_checkoutHelper->getConfig()->getDefaultCountryId())
-                ->setCollectShippingRates(true)
-                ->collectShippingRates()
-                ->save();
-        }
-
-        $defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
-        if (!$shippingAddress->getShippingMethod() && $defaultShippingMethod) {
-            $this->getOnepage()->saveShippingMethod($defaultShippingMethod);
-        }
-
-        try {
-            $this->quoteRepository->save($quote);
-        } catch (\Exception $e) {
-            return false;
-        }
-
-        return true;
-    }
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
+		$resultPage->getConfig()->getTitle()->set($this->_checkoutHelper->getConfig()->getCheckoutTitle());
+
+		return $resultPage;
+	}
+
+	public function initDefaultMethods($quote)
+	{
+		$shippingAddress = $quote->getShippingAddress();
+		if (!$shippingAddress->getCountryId()) {
+			$shippingAddress->setCountryId($this->_checkoutHelper->getConfig()->getDefaultCountryId())
+				->setCollectShippingRates(true)
+				->collectShippingRates()
+				->save();
+		}
+
+		$defaultShippingMethod = $this->_checkoutHelper->getConfig()->getDefaultShippingMethod();
+		if (!$shippingAddress->getShippingMethod() && $defaultShippingMethod) {
+			$this->getOnepage()->saveShippingMethod($defaultShippingMethod);
+		}
+
+		try{
+			$this->quoteRepository->save($quote);
+		} catch (\Exception $e){
+
+		}
+	}
 }
diff --git a/Helper/Config.php b/Helper/Config.php
index 6cc44da..0294380 100644
--- a/Helper/Config.php
+++ b/Helper/Config.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -22,360 +23,356 @@ namespace Mageplaza\Osc\Helper;
 
 use Mageplaza\Core\Helper\AbstractData;
 
-/**
- * Class Config
- * @package Mageplaza\Osc\Helper
- */
 class Config extends AbstractData
 {
-    /**
-     * Is enable module path
-     */
-    const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
-
-    /**
-     * General configuaration path
-     */
-    const GENERAL_CONFIGUARATION = 'osc/general/';
-
-    /**
-     * Display configuaration path
-     */
-    const DISPLAY_CONFIGUARATION = 'osc/display_configuration/';
-
-    /**
-     * Design configuaration path
-     */
-    const DESIGN_CONFIGUARATION = 'osc/design_configuration/';
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
-     * Get magento default country
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getDefaultCountryId($store = null)
-    {
-        return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
+	/**
+	 * Is enable module path
+	 */
+	const GENERAL_IS_ENABLED = 'osc/general/is_enabled';
+
+	/**
+	 * General configuaration path
+	 */
+	const GENERAL_CONFIGUARATION = 'osc/general/';
+
+	/**
+	 * Display configuaration path
+	 */
+	const DISPLAY_CONFIGUARATION = 'osc/display_configuration/';
+
+	/**
+	 * Design configuaration path
+	 */
+	const DESIGN_CONFIGUARATION = 'osc/design_configuration/';
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
+	 * Get magento default country
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDefaultCountryId($store = null)
+	{
+		return $this->objectManager->get('Magento\Directory\Helper\Data')->getDefaultCountry($store);
 //		return $this->getConfigValue('general/country/default', $store);
-    }
+	}
 
-    /************************ General Configuration *************************
+	/************************ General Configuration *************************
 	 *
 	 * @param      $code
 	 * @param null $store
 	 * @return mixed
 	 */
-    public function getGeneralConfig($code, $store = null)
-    {
-        return $this->getConfigValue(self::GENERAL_CONFIGUARATION . $code, $store);
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
-        return $this->getGeneralConfig('title', $store);
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
-     * @param null $store
-     * @return mixed
-     */
-    public function getAllowGuestCheckout($store = null)
-    {
-        return boolval($this->getGeneralConfig('allow_guest_checkout', $store));
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
-    /********************************** Display Configuration *********************
+	public function getGeneralConfig($code, $store = null)
+	{
+		return $this->getConfigValue(self::GENERAL_CONFIGUARATION . $code, $store);
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
+		return $this->getGeneralConfig('title', $store);
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
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getAllowGuestCheckout($store = null)
+	{
+		return boolval($this->getGeneralConfig('allow_guest_checkout', $store));
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
+	/********************************** Display Configuration *********************
 	 *
 	 * @param $code
 	 * @param null $store
 	 * @return mixed
 	 */
-    public function getDisplayConfig($code, $store = null)
-    {
-        return $this->getConfigValue(self::DISPLAY_CONFIGUARATION . $code, $store);
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
-    public function isDisabledCoupon($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_coupon', $store);
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
-     * Term and condition checkbox will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isDisabledTOC($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_toc', $store);
-    }
-
-    /**
-     * GiftMessage will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isEnabledGiftMessage($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_giftmessage', $store);
-    }
-
-    /**
-     * Gift wrap block will be hided if this function return 'true'
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function isEnabledGiftWrap($store = null)
-    {
-        return !$this->getDisplayConfig('is_enabled_giftwrap', $store);
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
-        return $this->getDisplayConfig('giftwrap_type', $store);
-    }
-
-    /**
-     * Gift wrap amount
-     *
-     * @param null $store
-     * @return mixed
-     */
-    public function getOrderGiftwrapAmount($store = null)
-    {
-        return $this->getDisplayConfig('giftwrap_amount', $store);
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
-        return $this->getDisplayConfig('is_checked_newsletter', $store);
-    }
-
-    /***************************** Design Configuration *****************************
+	public function getDisplayConfig($code, $store = null)
+	{
+		return $this->getConfigValue(self::DISPLAY_CONFIGUARATION . $code, $store);
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
+	public function isDisabledCoupon($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_coupon', $store);
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
+
+	/**
+	 * Term and condition checkbox will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isDisabledTOC($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_toc', $store);
+	}
+
+	/**
+	 * GiftMessage will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isEnabledGiftMessage($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_giftmessage', $store);
+	}
+
+	/**
+	 * Gift wrap block will be hided if this function return 'true'
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function isEnabledGiftWrap($store = null)
+	{
+		return !$this->getDisplayConfig('is_enabled_giftwrap', $store);
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
+		return $this->getDisplayConfig('giftwrap_type', $store);
+	}
+
+	/**
+	 * Gift wrap amount
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getOrderGiftwrapAmount($store = null)
+	{
+		return $this->getDisplayConfig('giftwrap_amount', $store);
+	}
+
+	/**
+	 * Newsleter block will be hided if this function return 'true'
 	 *
 	 * @param null $store
 	 * @return mixed
 	 */
-    public function getDesignConfig($code, $store = null)
-    {
-        return $this->getConfigValue(self::DESIGN_CONFIGUARATION . $code, $store);
-    }
-
-    /**
-     * Get design configuration
-     *
-     * @return array
-     */
-    public function getDesignConfiguration()
-    {
-        $design = [
-            'page_layout'        => $this->getDesignConfig('page_layout'),
-            'page_design'        => $this->getDesignConfig('page_design'),
-            'heading_background' => $this->getDesignConfig('heading_background'),
-            'heading_text'       => $this->getDesignConfig('heading_text'),
-            'place_order_button' => $this->getDesignConfig('place_order_button'),
-            'custom_css'         => $this->getDesignConfig('custom_css')
-        ];
-
-        return $design;
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
-}
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
+		return $this->getDisplayConfig('is_checked_newsletter', $store);
+	}
+
+	/***************************** Design Configuration *****************************
+	 *
+	 * @param null $store
+	 * @return mixed
+	 */
+	public function getDesignConfig($code, $store = null)
+	{
+		return $this->getConfigValue(self::DESIGN_CONFIGUARATION . $code, $store);
+	}
+
+	/**
+	 * Get design configuration
+	 *
+	 * @return array
+	 */
+	public function getDesignConfiguration()
+	{
+		$design = [
+			'page_layout'        => $this->getDesignConfig('page_layout'),
+			'page_design'        => $this->getDesignConfig('page_design'),
+			'heading_background' => $this->getDesignConfig('heading_background'),
+			'heading_text'       => $this->getDesignConfig('heading_text'),
+			'place_order_button' => $this->getDesignConfig('place_order_button'),
+			'custom_css'         => $this->getDesignConfig('custom_css')
+		];
+
+		return $design;
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
+}
\ No newline at end of file
diff --git a/Helper/Data.php b/Helper/Data.php
index dd4d72d..132d568 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -29,258 +30,218 @@ use Magento\Framework\Pricing\PriceCurrencyInterface;
 use Magento\Framework\ObjectManagerInterface;
 use Magento\Newsletter\Model\Subscriber;
 
-/**
- * Class Data
- * @package Mageplaza\Osc\Helper
- */
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
-     * @type \Magento\Newsletter\Model\Subscriber
-     */
-    protected $_subscriber;
-
-    /**
-     * @param \Magento\Framework\App\Helper\Context $context
-     * @param \Magento\Checkout\Helper\Data $helperData
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Mageplaza\Osc\Helper\Config $helperConfig
-     * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
-     * @param \Magento\Framework\ObjectManagerInterface $objectManager
-     * @param \Magento\Newsletter\Model\Subscriber $subscriber
-     */
-    public function __construct(
-        Context $context,
-        HelperData $helperData,
-        StoreManagerInterface $storeManager,
-        Config $helperConfig,
-        PriceCurrencyInterface $priceCurrency,
-        ObjectManagerInterface $objectManager,
-        Subscriber $subscriber
-    ) {
-    
-        $this->_helperData    = $helperData;
-        $this->_helperConfig  = $helperConfig;
-        $this->_priceCurrency = $priceCurrency;
-        $this->_subscriber    = $subscriber;
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
-     * Check if user must be logged during checkout process
-     *
-     * @return boolean
-     * @codeCoverageIgnore
-     */
-    public function isCustomerMustBeLogged()
-    {
-        return $this->_helperData->isCustomerMustBeLogged();
-    }
-
-    /**
-     * Get Customer by email
-     *
-     * @param string $email
-     * @return bool|\Magento\Customer\Model\Customer
-     */
-    public function getCustomerByEmail($email, $websiteId = null)
-    {
-        $websiteId = $websiteId ?: $this->storeManager->getWebsite()->getId();
-        /** @var \Magento\Customer\Model\Customer $customer */
-        $customer = $this->objectManager->get('Magento\Customer\Model\Customer');
-        $customer->setWebsiteId($websiteId)
-            ->loadByEmail($email);
-
-        if ($customer && $customer->getId()) {
-            return $customer;
-        }
-
-        return null;
-    }
-
-    /**
-     * Get formated grand total
-     *
-     * @param \Magento\Quote\Model\Quote $quote
-     * @return mixed
-     */
-    public function getGrandTotal($quote)
-    {
-        $grandTotal = $quote->getGrandTotal();
-
-        return $this->storeManager->getStore()->getCurrentCurrency()->format($grandTotal, [], false);
-    }
-
-    /**
-     * @return array
-     */
-    public function getAddressFieldPosition()
-    {
-        return [
-            'prefix'  => [
-                'sortOrder' => 5,
-                'colspan'   => 6
-            ],
-            'firstname'  => [
-                'sortOrder' => 10,
-                'colspan'   => 6
-            ],
-            'middlename'  => [
-                'sortOrder' => 15,
-                'colspan'   => 6
-            ],
-            'lastname'   => [
-                'sortOrder' => 20,
-                'colspan'   => 6
-            ],
-            'suffix'  => [
-                'sortOrder' => 25,
-                'colspan'   => 6
-            ],
-            'street'     => [
-                'sortOrder' => 30,
-                'colspan'   => 12
-            ],
-            'country_id' => [
-                'sortOrder' => 40,
-                'colspan'   => 6
-            ],
-            'city'       => [
-                'sortOrder' => 50,
-                'colspan'   => 6
-            ],
-            'postcode'   => [
-                'sortOrder' => 60,
-                'colspan'   => 6
-            ],
-            'region_id'  => [
-                'sortOrder' => 70,
-                'colspan'   => 6
-            ],
-            'region'  => [
-                'sortOrder' => 75,
-                'colspan'   => 6
-            ],
-            'company'    => [
-                'sortOrder' => 80,
-                'colspan'   => 12
-            ],
-            'vat_id'  => [
-                'sortOrder' => 90,
-                'colspan'   => 6
-            ],
-            'telephone'  => [
-                'sortOrder' => 100,
-                'colspan'   => 6
-            ],
-            'fax'        => [
-                'sortOrder' => 110,
-                'colspan'   => 6
-            ]
-        ];
-    }
-
-    /**
-     * Removes empty values from the array given
-     *
-     * @param mixed $data Array to inspect or data to be placed in new array as first value
-     * @return array Array processed
-     */
-    public static function noEmptyValues($data)
-    {
-        $result = [];
-        if (is_array($data)) {
-            foreach ($data as $a) {
-                if ($a) {
-                    $result[] = $a;
-                }
-            }
-        } else {
-            $result = $data ? [] : [$data];
-        }
-
-        return $result;
-    }
-
-    /**
-     * @param $value
-     * @return string
-     */
-    public function formatPrice($value)
-    {
-        return $this->_priceCurrency->convertAndFormat($value);
-    }
-
-    /**
-     * @param $value
-     * @return float
-     */
-    public function convertPrice($value)
-    {
-        return $this->_priceCurrency->convert($value);
-    }
-
-    /**
-     * @return string
-     */
-    public function getHowToCheckoutUrl()
-    {
-        return $this->_urlBuilder->getBaseUrl(true) . 'how-to-checkout-our-store';
-    }
-
-    /**
-     * Subscriber Newsletter
-     *
-     * @return Subscriber
-     */
-    public function getSubscriber()
-    {
-        return $this->_subscriber;
-    }
-
-    /**
-     * @param $email
-     * @return bool
-     */
-    public function isSubscribed($email)
-    {
-        $subscriber = $this->getSubscriber()->loadByEmail($email);
-        if ($subscriber && $subscriber->getId()) {
-            return true;
-        }
-
-        return false;
-    }
-}
+	/**
+	 * @var HelperData
+	 */
+	protected $_helperData;
+
+	/**
+	 * @var Config
+	 */
+	protected $_helperConfig;
+
+	protected $_priceCurrency;
+
+	protected $_subscriber;
+
+	public function __construct(
+		Context $context,
+		HelperData $helperData,
+		StoreManagerInterface $storeManager,
+		Config $helperConfig,
+		PriceCurrencyInterface $priceCurrency,
+		ObjectManagerInterface $objectManager,
+		Subscriber $subscriber
+	)
+	{
+		$this->_helperData    = $helperData;
+		$this->_helperConfig  = $helperConfig;
+		$this->_priceCurrency = $priceCurrency;
+		$this->_subscriber    = $subscriber;
+		parent::__construct($context, $objectManager, $storeManager);
+	}
+
+	public function getConfig()
+	{
+		return $this->_helperConfig;
+	}
+
+	public function isEnabled($store = null)
+	{
+		return $this->getConfig()->isEnabled($store);
+	}
+
+	/**
+	 * Check if user must be logged during checkout process
+	 *
+	 * @return boolean
+	 * @codeCoverageIgnore
+	 */
+	public function isCustomerMustBeLogged()
+	{
+		return $this->_helperData->isCustomerMustBeLogged();
+	}
+
+	/**
+	 * Get Customer by email
+	 *
+	 * @param string $email
+	 * @return bool|\Magento\Customer\Model\Customer
+	 */
+	public function getCustomerByEmail($email, $websiteId = null)
+	{
+		$websiteId = $websiteId ?: $this->storeManager->getWebsite()->getId();
+		/** @var \Magento\Customer\Model\Customer $customer */
+		$customer = $this->objectManager->get('Magento\Customer\Model\Customer');
+		$customer->setWebsiteId($websiteId)
+			->loadByEmail($email);
+
+		if ($customer && $customer->getId()) {
+			return $customer;
+		}
+
+		return null;
+	}
+
+	/**
+	 * Get formated grand total
+	 *
+	 * @param \Magento\Quote\Model\Quote $quote
+	 * @return mixed
+	 */
+	public function getGrandTotal($quote)
+	{
+		$grandTotal = $quote->getGrandTotal();
+
+		return $this->storeManager->getStore()->getCurrentCurrency()->format($grandTotal, [], false);
+	}
+
+	public function getAddressFieldPosition()
+	{
+		return [
+			'prefix'  => [
+				'sortOrder' => 5,
+				'colspan'   => 6
+			],
+			'firstname'  => [
+				'sortOrder' => 10,
+				'colspan'   => 6
+			],
+			'middlename'  => [
+				'sortOrder' => 15,
+				'colspan'   => 6
+			],
+			'lastname'   => [
+				'sortOrder' => 20,
+				'colspan'   => 6
+			],
+			'suffix'  => [
+				'sortOrder' => 25,
+				'colspan'   => 6
+			],
+			'street'     => [
+				'sortOrder' => 30,
+				'colspan'   => 12
+			],
+			'country_id' => [
+				'sortOrder' => 40,
+				'colspan'   => 6
+			],
+			'city'       => [
+				'sortOrder' => 50,
+				'colspan'   => 6
+			],
+			'postcode'   => [
+				'sortOrder' => 60,
+				'colspan'   => 6
+			],
+			'region_id'  => [
+				'sortOrder' => 70,
+				'colspan'   => 6
+			],
+			'region'  => [
+				'sortOrder' => 75,
+				'colspan'   => 6
+			],
+			'company'    => [
+				'sortOrder' => 80,
+				'colspan'   => 12
+			],
+			'vat_id'  => [
+				'sortOrder' => 90,
+				'colspan'   => 6
+			],
+			'telephone'  => [
+				'sortOrder' => 100,
+				'colspan'   => 6
+			],
+			'fax'        => [
+				'sortOrder' => 110,
+				'colspan'   => 6
+			]
+		];
+	}
+
+	/**
+	 * Removes empty values from the array given
+	 *
+	 * @param mixed $data Array to inspect or data to be placed in new array as first value
+	 * @return array Array processed
+	 */
+	public static function noEmptyValues($data)
+	{
+		$result = [];
+		if (is_array($data)) {
+			foreach ($data as $a) {
+				if ($a) {
+					$result[] = $a;
+				}
+			}
+		} else {
+			$result = $data ? [] : [$data];
+		}
+
+		return $result;
+	}
+
+	public function formatPrice($value)
+	{
+		return $this->_priceCurrency->convertAndFormat($value);
+	}
+
+	public function convertPrice($value)
+	{
+		return $this->_priceCurrency->convert($value);
+	}
+
+	public function getHowToCheckoutUrl()
+	{
+		return $this->_urlBuilder->getBaseUrl(true) . 'how-to-checkout-our-store';
+	}
+
+	/**
+	 * Subscriber Newsletter
+	 *
+	 * @return Subscriber
+	 */
+	public function getSubscriber()
+	{
+		return $this->_subscriber;
+	}
+
+	/**
+	 * @param $email
+	 * @return bool
+	 */
+	public function isSubscribed($email)
+	{
+		$subscriber = $this->getSubscriber()->loadByEmail($email);
+		if ($subscriber && $subscriber->getId()) {
+			return true;
+		}
+
+		return false;
+	}
+}
\ No newline at end of file
diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index bca5c2e..3298a34 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -1,23 +1,9 @@
 <?php
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
+
 namespace Mageplaza\Osc\Model;
 
 use Mageplaza\Osc\Api\CheckoutManagementInterface;
@@ -30,184 +16,174 @@ use Magento\Quote\Api\CartTotalRepositoryInterface;
 use Magento\Framework\Exception\CouldNotSaveException;
 use Magento\Framework\Exception\NoSuchEntityException;
 
-/**
- * Class CheckoutManagement
- * @package Mageplaza\Osc\Model
- */
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
-     * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
-     * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
-     * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
-     * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
-     * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
-     * @param \Magento\Framework\UrlInterface $urlBuilder
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
-     */
-    public function __construct(
-        CartRepositoryInterface $cartRepository,
-        OscDetailsFactory $oscDetailsFactory,
-        ShippingMethodManagementInterface $shippingMethodManagement,
-        PaymentMethodManagementInterface $paymentMethodManagement,
-        CartTotalRepositoryInterface $cartTotalsRepository,
-        UrlInterface $urlBuilder,
-        \Magento\Checkout\Model\Session $checkoutSession,
-        \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
-    ) {
-    
-        $this->cartRepository                = $cartRepository;
-        $this->oscDetailsFactory             = $oscDetailsFactory;
-        $this->shippingMethodManagement      = $shippingMethodManagement;
-        $this->paymentMethodManagement       = $paymentMethodManagement;
-        $this->cartTotalsRepository          = $cartTotalsRepository;
-        $this->_urlBuilder                   = $urlBuilder;
-        $this->checkoutSession               = $checkoutSession;
-        $this->shippingInformationManagement = $shippingInformationManagement;
-    }
-
-    /**
-     * {@inheritDoc}
-     */
-    public function updateItemQty($cartId, $itemId, $itemQty)
-    {
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
-        $quote     = $this->cartRepository->getActive($cartId);
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
-    public function getResponseData(\Magento\Quote\Model\Quote $quote)
-    {
-        /** @var \Mageplaza\Osc\Api\Data\OscDetailsInterface $oscDetails */
-        $oscDetails = $this->oscDetailsFactory->create();
-
-        if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
-            $oscDetails->setRedirectUrl($this->_urlBuilder->getUrl('checkout/cart'));
-        } else {
-            if ($quote->getShippingAddress()->getCountryId()) {
-                $oscDetails->setShippingMethods($this->shippingMethodManagement->getList($quote->getId()));
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
-        \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
-        $additionInformation = []
-    ) {
-    
-        if ($addressInformation->getShippingAddress()) {
-            $this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
-        }
-
-        $this->checkoutSession->setOscData($additionInformation);
-
-        return true;
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
+	 * @param \Magento\Quote\Api\CartRepositoryInterface $cartRepository
+	 * @param \Mageplaza\Osc\Model\OscDetailsFactory $oscDetailsFactory
+	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+	 * @param \Magento\Quote\Api\CartTotalRepositoryInterface $cartTotalsRepository
+	 * @param \Magento\Framework\UrlInterface $urlBuilder
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
+	 */
+	public function __construct(
+		CartRepositoryInterface $cartRepository,
+		OscDetailsFactory $oscDetailsFactory,
+		ShippingMethodManagementInterface $shippingMethodManagement,
+		PaymentMethodManagementInterface $paymentMethodManagement,
+		CartTotalRepositoryInterface $cartTotalsRepository,
+		UrlInterface $urlBuilder,
+		\Magento\Checkout\Model\Session $checkoutSession,
+		\Magento\Checkout\Api\ShippingInformationManagementInterface $shippingInformationManagement
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
+	}
+
+	/**
+	 * {@inheritDoc}
+	 */
+	public function updateItemQty($cartId, $itemId, $itemQty)
+	{
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
+		$quote     = $this->cartRepository->getActive($cartId);
+
+		return $this->getResponseData($quote);
+	}
+
+	public function getResponseData(\Magento\Quote\Model\Quote $quote)
+	{
+		/** @var \Mageplaza\Osc\Api\Data\OscDetailsInterface $oscDetails */
+		$oscDetails = $this->oscDetailsFactory->create();
+
+		if (!$quote->hasItems() || $quote->getHasError() || !$quote->validateMinimumAmount()) {
+			$oscDetails->setRedirectUrl($this->_urlBuilder->getUrl('checkout/cart'));
+		} else {
+			if ($quote->getShippingAddress()->getCountryId()) {
+				$oscDetails->setShippingMethods($this->shippingMethodManagement->getList($quote->getId()));
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
+		$additionInformation = []
+	)
+	{
+		if($addressInformation->getShippingAddress()) {
+			$this->shippingInformationManagement->saveAddressInformation($cartId, $addressInformation);
+		}
+
+		$this->checkoutSession->setOscData($additionInformation);
+
+		return true;
+	}
 }
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index 554ddf4..9790887 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -1,22 +1,7 @@
 <?php
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
 namespace Mageplaza\Osc\Model;
 
@@ -34,135 +19,132 @@ use Mageplaza\Osc\Helper\Config as OscConfig;
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
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
-     * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
-     * @param \Mageplaza\Osc\Helper\Config $oscConfig
-     */
-    public function __construct(
-        CheckoutSession $checkoutSession,
-        PaymentMethodManagementInterface $paymentMethodManagement,
-        ShippingMethodManagementInterface $shippingMethodManagement,
-        OscConfig $oscConfig
-    ) {
-    
-        $this->checkoutSession          = $checkoutSession;
-        $this->paymentMethodManagement  = $paymentMethodManagement;
-        $this->shippingMethodManagement = $shippingMethodManagement;
-        $this->oscConfig                = $oscConfig;
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
-            'selectedShippingRate'  => $this->oscConfig->getDefaultShippingMethod(),
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
-            'autocomplete'       => [
-                'type'                   => $this->oscConfig->getAutoDetectedAddress(),
-                'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
-            ],
-            'register'           => [
-                'dataPasswordMinLength'        => $this->getMinimumPasswordLength(),
-                'dataPasswordMinCharacterSets' => $this->getRequiredCharacterClassesNumber()
-            ],
-            'allowGuestCheckout' => $this->oscConfig->getAllowGuestCheckout(),
-            'showBillingAddress' => $this->oscConfig->getShowBillingAddress(),
-            'newsletterDefault'  => $this->oscConfig->isSubscribedByDefault(),
-            'design'             => $this->oscConfig->getDesignConfiguration()
-        ];
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
-     * Get minimum password length
-     *
-     * @return string
-     */
-    public function getMinimumPasswordLength()
-    {
-        return $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH);
-    }
-
-    /**
-     * Get number of password required character classes
-     *
-     * @return string
-     */
-    public function getRequiredCharacterClassesNumber()
-    {
-        return $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER);
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
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Magento\Quote\Api\PaymentMethodManagementInterface $paymentMethodManagement
+	 * @param \Magento\Quote\Api\ShippingMethodManagementInterface $shippingMethodManagement
+	 * @param \Mageplaza\Osc\Helper\Config $oscConfig
+	 */
+	public function __construct(
+		CheckoutSession $checkoutSession,
+		PaymentMethodManagementInterface $paymentMethodManagement,
+		ShippingMethodManagementInterface $shippingMethodManagement,
+		OscConfig $oscConfig
+	)
+	{
+		$this->checkoutSession          = $checkoutSession;
+		$this->paymentMethodManagement  = $paymentMethodManagement;
+		$this->shippingMethodManagement = $shippingMethodManagement;
+		$this->oscConfig                = $oscConfig;
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
+			'selectedShippingRate'  => $this->oscConfig->getDefaultShippingMethod(),
+			'paymentMethods'        => $this->getPaymentMethods(),
+			'selectedPaymentMethod' => $this->oscConfig->getDefaultPaymentMethod(),
+			'oscConfig'             => $this->getOscConfig()
+		];
+
+		return $output;
+	}
+
+	private function getOscConfig()
+	{
+		return [
+			'autocomplete'       => [
+				'type'                   => $this->oscConfig->getAutoDetectedAddress(),
+				'google_default_country' => $this->oscConfig->getGoogleSpecificCountry(),
+			],
+			'register'           => [
+				'dataPasswordMinLength'        => $this->getMinimumPasswordLength(),
+				'dataPasswordMinCharacterSets' => $this->getRequiredCharacterClassesNumber()
+			],
+			'allowGuestCheckout' => $this->oscConfig->getAllowGuestCheckout(),
+			'showBillingAddress' => $this->oscConfig->getShowBillingAddress(),
+			'newsletterDefault'  => $this->oscConfig->isSubscribedByDefault(),
+			'design'             => $this->oscConfig->getDesignConfiguration()
+		];
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
+	 * Get minimum password length
+	 *
+	 * @return string
+	 */
+	public function getMinimumPasswordLength()
+	{
+		return $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_MINIMUM_PASSWORD_LENGTH);
+	}
+
+	/**
+	 * Get number of password required character classes
+	 *
+	 * @return string
+	 */
+	public function getRequiredCharacterClassesNumber()
+	{
+		return $this->oscConfig->getConfigValue(AccountManagement::XML_PATH_REQUIRED_CHARACTER_CLASSES_NUMBER);
+	}
 }
diff --git a/Model/GuestCheckoutManagement.php b/Model/GuestCheckoutManagement.php
index d0dc0f3..adeff86 100644
--- a/Model/GuestCheckoutManagement.php
+++ b/Model/GuestCheckoutManagement.php
@@ -1,102 +1,83 @@
 <?php
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
 namespace Mageplaza\Osc\Model;
 
-/**
- * Class GuestCheckoutManagement
- * @package Mageplaza\Osc\Model
- */
 class GuestCheckoutManagement implements \Mageplaza\Osc\Api\GuestCheckoutManagementInterface
 {
-    /**
-     * @var \Magento\Quote\Model\QuoteIdMaskFactory
-     */
-    protected $quoteIdMaskFactory;
+	/**
+	 * @var \Magento\Quote\Model\QuoteIdMaskFactory
+	 */
+	protected $quoteIdMaskFactory;
 
-    /**
-     * @type \Mageplaza\Osc\Api\CheckoutManagementInterface
-     */
-    protected $checkoutManagement;
+	/**
+	 * @type \Mageplaza\Osc\Api\CheckoutManagementInterface
+	 */
+	protected $checkoutManagement;
 
-    /**
-     * @param \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory
-     * @param \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
-     */
-    public function __construct(
-        \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory,
-        \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
-    ) {
-    
-        $this->quoteIdMaskFactory   = $quoteIdMaskFactory;
-        $this->checkoutManagement = $checkoutManagement;
-    }
+	/**
+	 * @param \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory
+	 * @param \Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
+	 */
+	public function __construct(
+		\Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory,
+		\Mageplaza\Osc\Api\CheckoutManagementInterface $checkoutManagement
+	)
+	{
+		$this->quoteIdMaskFactory   = $quoteIdMaskFactory;
+		$this->checkoutManagement = $checkoutManagement;
+	}
 
-    /**
-     * {@inheritDoc}
-     */
-    public function updateItemQty($cartId, $itemId, $itemQty)
-    {
-        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
-        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
+	/**
+	 * {@inheritDoc}
+	 */
+	public function updateItemQty($cartId, $itemId, $itemQty)
+	{
+		/** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
+		$quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
 
-        return $this->checkoutManagement->updateItemQty($quoteIdMask->getQuoteId(), $itemId, $itemQty);
-    }
+		return $this->checkoutManagement->updateItemQty($quoteIdMask->getQuoteId(), $itemId, $itemQty);
+	}
 
-    /**
-     * {@inheritDoc}
-     */
-    public function removeItemById($cartId, $itemId)
-    {
-        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
-        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
+	/**
+	 * {@inheritDoc}
+	 */
+	public function removeItemById($cartId, $itemId)
+	{
+		/** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
+		$quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
 
-        return $this->checkoutManagement->removeItemById($quoteIdMask->getQuoteId(), $itemId);
-    }
+		return $this->checkoutManagement->removeItemById($quoteIdMask->getQuoteId(), $itemId);
+	}
 
-    /**
-     * {@inheritDoc}
-     */
-    public function getPaymentTotalInformation($cartId)
-    {
-        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
-        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
+	/**
+	 * {@inheritDoc}
+	 */
+	public function getPaymentTotalInformation($cartId)
+	{
+		/** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
+		$quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
 
-        return $this->checkoutManagement->getPaymentTotalInformation($quoteIdMask->getQuoteId());
-    }
+		return $this->checkoutManagement->getPaymentTotalInformation($quoteIdMask->getQuoteId());
+	}
 
-    /**
-     * {@inheritDoc}
-     */
-    public function saveCheckoutInformation(
-        $cartId,
-        \Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
-        $additionInformation = []
-    ) {
-        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
-        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
+	/**
+	 * {@inheritDoc}
+	 */
+	public function saveCheckoutInformation(
+		$cartId,
+		\Magento\Checkout\Api\Data\ShippingInformationInterface $addressInformation,
+		$additionInformation = []
+	){
+		/** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
+		$quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
 
-        return $this->checkoutManagement->saveCheckoutInformation(
-            $quoteIdMask->getQuoteId(),
-            $addressInformation,
-            $additionInformation
-        );
-    }
+		return $this->checkoutManagement->saveCheckoutInformation(
+			$quoteIdMask->getQuoteId(),
+			$addressInformation,
+			$additionInformation
+		);
+	}
 }
diff --git a/Model/OscDetails.php b/Model/OscDetails.php
index 7d07c87..26a40a6 100644
--- a/Model/OscDetails.php
+++ b/Model/OscDetails.php
@@ -1,22 +1,7 @@
 <?php
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
 namespace Mageplaza\Osc\Model;
 
@@ -24,70 +9,70 @@ namespace Mageplaza\Osc\Model;
  * @codeCoverageIgnoreStart
  */
 class OscDetails extends \Magento\Framework\Model\AbstractExtensibleModel implements
-    \Mageplaza\Osc\Api\Data\OscDetailsInterface
+	\Mageplaza\Osc\Api\Data\OscDetailsInterface
 {
-    /**
-     * @{inheritdoc}
-     */
-    public function getShippingMethods()
-    {
-        return $this->getData(self::SHIPPING_METHODS);
-    }
+	/**
+	 * @{inheritdoc}
+	 */
+	public function getShippingMethods()
+	{
+		return $this->getData(self::SHIPPING_METHODS);
+	}
 
-    /**
-     * @{inheritdoc}
-     */
-    public function setShippingMethods($shippingMethods)
-    {
-        return $this->setData(self::SHIPPING_METHODS, $shippingMethods);
-    }
+	/**
+	 * @{inheritdoc}
+	 */
+	public function setShippingMethods($shippingMethods)
+	{
+		return $this->setData(self::SHIPPING_METHODS, $shippingMethods);
+	}
 
-    /**
-     * @{inheritdoc}
-     */
-    public function getPaymentMethods()
-    {
-        return $this->getData(self::PAYMENT_METHODS);
-    }
+	/**
+	 * @{inheritdoc}
+	 */
+	public function getPaymentMethods()
+	{
+		return $this->getData(self::PAYMENT_METHODS);
+	}
 
-    /**
-     * @{inheritdoc}
-     */
-    public function setPaymentMethods($paymentMethods)
-    {
-        return $this->setData(self::PAYMENT_METHODS, $paymentMethods);
-    }
+	/**
+	 * @{inheritdoc}
+	 */
+	public function setPaymentMethods($paymentMethods)
+	{
+		return $this->setData(self::PAYMENT_METHODS, $paymentMethods);
+	}
 
-    /**
-     * @{inheritdoc}
-     */
-    public function getTotals()
-    {
-        return $this->getData(self::TOTALS);
-    }
+	/**
+	 * @{inheritdoc}
+	 */
+	public function getTotals()
+	{
+		return $this->getData(self::TOTALS);
+	}
 
-    /**
-     * @{inheritdoc}
-     */
-    public function setTotals($totals)
-    {
-        return $this->setData(self::TOTALS, $totals);
-    }
+	/**
+	 * @{inheritdoc}
+	 */
+	public function setTotals($totals)
+	{
+		return $this->setData(self::TOTALS, $totals);
+	}
 
-    /**
-     * @return string
-     */
-    public function getRedirectUrl()
-    {
-        return $this->getData(self::REDIRECT_URL);
-    }
+	/**
+	 * @return string
+	 */
+	public function getRedirectUrl()
+	{
+		return $this->getData(self::REDIRECT_URL);
+	}
 
-    /**
-     * @param $url
-     * @return $this
-     */
-    public function setRedirectUrl($url)
-    {
-        return $this->setData(self::REDIRECT_URL, $url);
-    }
+	/**
+	 * @param $url
+	 * @return $this
+	 */
+	public function setRedirectUrl($url)
+	{
+		return $this->setData(self::REDIRECT_URL, $url);
+	}
 }
diff --git a/Model/Plugin/ShippingMethodManagement.php b/Model/Plugin/ShippingMethodManagement.php
index aaca07a..5cf9311 100644
--- a/Model/Plugin/ShippingMethodManagement.php
+++ b/Model/Plugin/ShippingMethodManagement.php
@@ -23,115 +23,110 @@ namespace Mageplaza\Osc\Model\Plugin;
 use Magento\Quote\Api\Data\EstimateAddressInterface;
 use Magento\Quote\Api\Data\AddressInterface;
 
-/**
- * Class ShippingMethodManagement
- * @package Mageplaza\Osc\Model\Plugin
- */
 class ShippingMethodManagement
 {
-    /**
-     * Quote repository.
-     *
-     * @var \Magento\Quote\Api\CartRepositoryInterface
-     */
-    protected $quoteRepository;
+	/**
+	 * Quote repository.
+	 *
+	 * @var \Magento\Quote\Api\CartRepositoryInterface
+	 */
+	protected $quoteRepository;
 
-    /**
-     * Customer Address repository
-     *
-     * @var \Magento\Customer\Api\AddressRepositoryInterface
-     */
-    protected $addressRepository;
+	/**
+	 * Customer Address repository
+	 *
+	 * @var \Magento\Customer\Api\AddressRepositoryInterface
+	 */
+	protected $addressRepository;
 
-    /**
-     * @param \Magento\Quote\Api\CartRepositoryInterface $quoteRepository
-     * @param \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
-     */
-    public function __construct(
-        \Magento\Quote\Api\CartRepositoryInterface $quoteRepository,
-        \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
-    ) {
-    
-        $this->quoteRepository   = $quoteRepository;
-        $this->addressRepository = $addressRepository;
-    }
+	/**
+	 * @param \Magento\Quote\Api\CartRepositoryInterface $quoteRepository
+	 * @param \Magento\Customer\Api\AddressRepositoryInterface $addressRepository
+	 */
+	public function __construct(
+		\Magento\Quote\Api\CartRepositoryInterface $quoteRepository,
+		\Magento\Customer\Api\AddressRepositoryInterface $addressRepository
+	)
+	{
+		$this->quoteRepository   = $quoteRepository;
+		$this->addressRepository = $addressRepository;
+	}
 
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
-    ) {
-    
-        $this->saveAddress($cartId, $address);
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
+		$this->saveAddress($cartId, $address);
 
-        return $proceed($cartId, $address);
-    }
+		return $proceed($cartId, $address);
+	}
 
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
-    ) {
-    
-        $this->saveAddress($cartId, $address);
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
+		$this->saveAddress($cartId, $address);
 
-        return $proceed($cartId, $address);
-    }
+		return $proceed($cartId, $address);
+	}
 
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
-    ) {
-    
-        $address = $this->addressRepository->getById($addressId);
-        $this->saveAddress($cartId, $address);
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
+		$addressId)
+	{
+		$address = $this->addressRepository->getById($addressId);
+		$this->saveAddress($cartId, $address);
 
-        return $proceed($cartId, $addressId);
-    }
+		return $proceed($cartId, $addressId);
+	}
 
-    private function saveAddress($cartId, $address)
-    {
-        /** @var \Magento\Quote\Model\Quote $quote */
-        $quote = $this->quoteRepository->getActive($cartId);
+	private function saveAddress($cartId, $address)
+	{
+		/** @var \Magento\Quote\Model\Quote $quote */
+		$quote = $this->quoteRepository->getActive($cartId);
 
-        if (!$quote->isVirtual()) {
-            $addressData = [
-                EstimateAddressInterface::KEY_COUNTRY_ID => $address->getCountryId(),
-                EstimateAddressInterface::KEY_POSTCODE   => $address->getPostcode(),
-                EstimateAddressInterface::KEY_REGION_ID  => $address->getRegionId(),
-                EstimateAddressInterface::KEY_REGION     => $address->getRegion()
-            ];
+		if (!$quote->isVirtual()) {
+			$addressData = [
+				EstimateAddressInterface::KEY_COUNTRY_ID => $address->getCountryId(),
+				EstimateAddressInterface::KEY_POSTCODE   => $address->getPostcode(),
+				EstimateAddressInterface::KEY_REGION_ID  => $address->getRegionId(),
+				EstimateAddressInterface::KEY_REGION     => $address->getRegion()
+			];
 
-            $shippingAddress = $quote->getShippingAddress();
-            $shippingAddress->addData($addressData)
-                ->save();
-        }
+			$shippingAddress = $quote->getShippingAddress();
+			$shippingAddress->addData($addressData)
+				->save();
+		}
 
-        return $this;
-    }
-}
+		return $this;
+	}
+}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Address/Suggest.php b/Model/System/Config/Source/Address/Suggest.php
index 4f37d71..c64a6af 100644
--- a/Model/System/Config/Source/Address/Suggest.php
+++ b/Model/System/Config/Source/Address/Suggest.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -18,37 +19,27 @@
  */
 namespace Mageplaza\Osc\Model\System\Config\Source\Address;
 
-/**
- * Class Suggest
- * @package Mageplaza\Osc\Model\System\Config\Source\Address
- */
 class Suggest
 {
-    /**
-     * @return array
-     */
-    public function getTriggerOption()
-    {
-        return [
-            ''       => __('No'),
-            'google' => __('Google'),
+	public function getTriggerOption()
+	{
+		return [
+			''       => __('No'),
+			'google' => __('Google'),
 //			'pca'    => __('Capture+ by PCA Predict'),
-        ];
-    }
+		];
+	}
 
-    /**
-     * @return array
-     */
-    public function toOptionArray()
-    {
-        $options = [];
-        foreach ($this->getTriggerOption() as $code => $label) {
-            $options[] = [
-                'value' => $code,
-                'label' => $label
-            ];
-        }
+	public function toOptionArray()
+	{
+		$options = [];
+		foreach ($this->getTriggerOption() as $code => $label) {
+			$options[] = [
+				'value' => $code,
+				'label' => $label
+			];
+		}
 
-        return $options;
-    }
-}
+		return $options;
+	}
+}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Address/Suggest/Fields.php b/Model/System/Config/Source/Address/Suggest/Fields.php
new file mode 100644
index 0000000..a140832
--- /dev/null
+++ b/Model/System/Config/Source/Address/Suggest/Fields.php
@@ -0,0 +1,48 @@
+<?php
+
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
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
+ */
+namespace Mageplaza\Osc\Model\System\Config\Source\Address\Suggest;
+
+class Fields
+{
+
+
+    public function getFieldsOption()
+    {
+        return [
+            ''       => __('No'),
+            'google' => __('Google'),
+            'pca'    => __('Capture+'),
+        ];
+    }
+
+    public function toOptionArray()
+    {
+
+        $options = [];
+        foreach ($this->getFieldsOption() as $code => $label) {
+            $options[] = [
+                'value' => $code,
+                'label' => $label
+            ];
+        }
+
+        return $options;
+    }
+}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Address/Trigger.php b/Model/System/Config/Source/Address/Trigger.php
new file mode 100644
index 0000000..4439b05
--- /dev/null
+++ b/Model/System/Config/Source/Address/Trigger.php
@@ -0,0 +1,51 @@
+<?php
+
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
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
+ */
+namespace Mageplaza\Osc\Model\System\Config\Source\Address;
+
+class Trigger
+{
+
+
+    public function getTriggerOption()
+    {
+        return [
+            'street1'    => __('Street'),
+            'country_id' => __('Country Id'),
+            'region'     => __('Region '),
+            'region_id'  => __('Region Id'),
+            'city'       => __('City'),
+            'postcode'   => __('Postcode'),
+        ];
+    }
+
+    public function toOptionArray()
+    {
+
+        $options = [];
+        foreach ($this->getTriggerOption() as $code => $label) {
+            $options[] = [
+                'value' => $code,
+                'label' => $label
+            ];
+        }
+
+        return $options;
+    }
+}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Color.php b/Model/System/Config/Source/Color.php
new file mode 100644
index 0000000..844ad2e
--- /dev/null
+++ b/Model/System/Config/Source/Color.php
@@ -0,0 +1,44 @@
+<?php
+
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
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
+ */
+namespace Mageplaza\Osc\Model\System\Config\Source;
+
+class Color
+{
+    /**
+     * Options getter
+     *
+     * @return array
+     */
+    public function toOptionArray()
+    {
+        return [
+            ['value' => '#3399cc', 'label' => __('Default')],
+            ['value' => 'orange', 'label' => __('Orange')],
+            ['value' => 'green', 'label' => __('Green')],
+            ['value' => 'black', 'label' => __('Black')],
+            ['value' => 'blue', 'label' => __('Blue')],
+            ['value' => 'darkblue', 'label' => __('Dark Blue')],
+            ['value' => 'pink', 'label' => __('Pink')],
+            ['value' => 'red', 'label' => __('Red')],
+            ['value' => 'violet', 'label' => __('Violet')],
+            ['value' => 'custom', 'label' => __('Custom')],
+        ];
+    }
+}
diff --git a/Model/System/Config/Source/Design.php b/Model/System/Config/Source/Design.php
index 9973dfb..4ed4eb6 100644
--- a/Model/System/Config/Source/Design.php
+++ b/Model/System/Config/Source/Design.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -18,36 +19,29 @@
  */
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
-/**
- * Class Design
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
 class Design
 {
-    const DESIGN_DEFAULT = 'default';
-    const DESIGN_FLAT = 'flat';
-    const DESIGN_MATERIAL = 'material';
+	const DESIGN_DEFAULT = 'default';
+	const DESIGN_FLAT = 'flat';
+	const DESIGN_MATERIAL = 'material';
 
-    /**
-     * @return array
-     */
-    public function toOptionArray()
-    {
-        $options = [
-            [
-                'label' => __('Default'),
-                'value' => self::DESIGN_DEFAULT
-            ],
-            [
-                'label' => __('Flat'),
-                'value' => self::DESIGN_FLAT
-            ],
-//			[
-//				'label' => __('Material'),
-//				'value' => self::DESIGN_MATERIAL
-//			]
-        ];
+	public function toOptionArray()
+	{
+		$options = [
+			[
+				'label' => __('Default'),
+				'value' => self::DESIGN_DEFAULT
+			],
+			[
+				'label' => __('Flat'),
+				'value' => self::DESIGN_FLAT
+			],
+			[
+				'label' => __('Material'),
+				'value' => self::DESIGN_MATERIAL
+			]
+		];
 
-        return $options;
-    }
+		return $options;
+	}
 }
diff --git a/Model/System/Config/Source/Enableddisabled.php b/Model/System/Config/Source/Enableddisabled.php
index a1096ea..d3518d8 100644
--- a/Model/System/Config/Source/Enableddisabled.php
+++ b/Model/System/Config/Source/Enableddisabled.php
@@ -18,12 +18,10 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
+
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
-/**
- * Class Enableddisabled
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
 class Enableddisabled
 {
     const DISABLED_CODE = 0;
@@ -62,4 +60,4 @@ class Enableddisabled
             self::DISABLED_CODE => __(self::DISABLED_LABEL),
         ];
     }
-}
+}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Heading.php b/Model/System/Config/Source/Heading.php
new file mode 100644
index 0000000..74d8299
--- /dev/null
+++ b/Model/System/Config/Source/Heading.php
@@ -0,0 +1,37 @@
+<?php
+
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
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement.html
+ */
+namespace Mageplaza\Osc\Model\System\Config\Source;
+
+class Heading
+{
+    /**
+     * Options getter
+     *
+     * @return array
+     */
+    public function toOptionArray()
+    {
+        return [
+            ['value' => 'style_1', 'label' => __('Style 1')],
+            ['value' => 'style_2', 'label' => __('Style 2')],
+            ['value' => 'style_3', 'label' => __('Style 3')],
+        ];
+    }
+}
diff --git a/Model/System/Config/Source/Layout.php b/Model/System/Config/Source/Layout.php
index 7df97e8..f3e6bb7 100644
--- a/Model/System/Config/Source/Layout.php
+++ b/Model/System/Config/Source/Layout.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -18,10 +19,6 @@
  */
 namespace Mageplaza\Osc\Model\System\Config\Source;
 
-/**
- * Class Layout
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
 class Layout
 {
     const ONE_COLUMN = '1column';
@@ -29,9 +26,6 @@ class Layout
     const THREE_COLUMNS = '3columns';
     const THREE_COLUMNS_WITH_COLSPAN = '3columns-colspan';
 
-    /**
-     * @return array
-     */
     public function toOptionArray()
     {
         $options = [
diff --git a/Model/System/Config/Source/Payment/Methods.php b/Model/System/Config/Source/Payment/Methods.php
index 076a3c1..5f5fa34 100644
--- a/Model/System/Config/Source/Payment/Methods.php
+++ b/Model/System/Config/Source/Payment/Methods.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -22,10 +23,6 @@ namespace Mageplaza\Osc\Model\System\Config\Source\Payment;
 
 use Magento\Framework\Option\ArrayInterface;
 
-/**
- * Class Methods
- * @package Mageplaza\Osc\Model\System\Config\Source\Payment
- */
 class Methods implements ArrayInterface
 {
     /**
@@ -39,12 +36,16 @@ class Methods implements ArrayInterface
     protected $_paymentHelperData;
 
     /**
-     * @param \Magento\Payment\Helper\Data $paymentHelperData
+     * Payment constructor.
+     *
+     * @param \Magento\Checkout\Model\Type\Onepage $onePage
+     * @param \Magento\Payment\Helper\Data         $paymentHelperData
      */
     public function __construct(
         \Magento\Payment\Helper\Data $paymentHelperData
     ) {
         $this->_paymentHelperData = $paymentHelperData;
+
     }
 
     /**
@@ -69,4 +70,4 @@ class Methods implements ArrayInterface
 
         return $options;
     }
-}
+}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Shipping/Methods.php b/Model/System/Config/Source/Shipping/Methods.php
index 9b18562..ded76af 100644
--- a/Model/System/Config/Source/Shipping/Methods.php
+++ b/Model/System/Config/Source/Shipping/Methods.php
@@ -1,4 +1,5 @@
 <?php
+
 /**
  * Mageplaza
  *
@@ -24,10 +25,6 @@ use Magento\Framework\App\ObjectManager;
 use Magento\Framework\App\Config\ScopeConfigInterface as StoreConfig;
 use Magento\Shipping\Model\Config as CarrierConfig;
 
-/**
- * Class Methods
- * @package Mageplaza\Osc\Model\System\Config\Source\Shipping
- */
 class Methods
 {
     /**
@@ -69,10 +66,10 @@ class Methods
         ksort($carrierMethodsList);
         foreach ($carrierMethodsList as $carrierMethodCode => $carrierModel) {
             foreach ($carrierModel->getAllowedMethods() as $shippingMethodCode => $shippingMethodTitle) {
-                $shippingMethodsOptionArray[] = [
+                $shippingMethodsOptionArray[] = array(
                     'label' => $this->_getShippingMethodTitle($carrierMethodCode) . ' - ' . $shippingMethodTitle,
                     'value' => $carrierMethodCode . '_' . $shippingMethodCode,
-                ];
+                );
             }
         }
 
@@ -91,4 +88,4 @@ class Methods
 
         return $shippingMethodTitle;
     }
-}
+}
\ No newline at end of file
diff --git a/Observer/CheckoutSubmitBefore.php b/Observer/CheckoutSubmitBefore.php
index 6ba7d26..a4d5dcd 100644
--- a/Observer/CheckoutSubmitBefore.php
+++ b/Observer/CheckoutSubmitBefore.php
@@ -1,32 +1,13 @@
 <?php
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
 namespace Mageplaza\Osc\Observer;
 
 use Magento\Framework\Event\ObserverInterface;
 use Magento\Quote\Model\Quote;
 
-/**
- * Class CheckoutSubmitBefore
- * @package Mageplaza\Osc\Observer
- */
 class CheckoutSubmitBefore implements ObserverInterface
 {
 	/**
@@ -62,11 +43,10 @@ class CheckoutSubmitBefore implements ObserverInterface
 		\Magento\Customer\Api\AccountManagementInterface $accountManagement
 	)
 	{
-
 		$this->checkoutSession    = $checkoutSession;
 		$this->_objectCopyService = $objectCopyService;
 		$this->dataObjectHelper   = $dataObjectHelper;
-		$this->accountManagement  = $accountManagement;
+		$this->accountManagement   = $accountManagement;
 	}
 
 	/**
@@ -79,17 +59,9 @@ class CheckoutSubmitBefore implements ObserverInterface
 		/** @type \Magento\Quote\Model\Quote $quote */
 		$quote = $observer->getEvent()->getQuote();
 
-		/** Remove address validation */
-		if (!$quote->isVirtual()) {
-			$quote->getShippingAddress()->setShouldIgnoreValidation(true);
-		}
-		$quote->getBillingAddress()->setShouldIgnoreValidation(true);
-
-		/** Create account when checkout */
 		$oscData = $this->checkoutSession->getOscData();
 		if (isset($oscData['register']) && $oscData['register']
-			&& isset($oscData['password']) && $oscData['password']
-		) {
+			&& isset($oscData['password']) && $oscData['password']) {
 			$quote->setCheckoutMethod(\Magento\Checkout\Model\Type\Onepage::METHOD_REGISTER)
 				->setCustomerIsGuest(false)
 				->setCustomerGroupId(null)
@@ -111,6 +83,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 		$shipping = $quote->isVirtual() ? null : $quote->getShippingAddress();
 
 		$customer            = $quote->getCustomer();
+		$customerBillingData = $billing->exportCustomerAddress();
 		$dataArray           = $billing->getData();
 		$this->dataObjectHelper->populateWithArray(
 			$customer,
@@ -120,9 +93,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 
 		$quote->setCustomer($customer);
 
-		$customerBillingData = $billing->exportCustomerAddress();
-		$customerBillingData->setIsDefaultBilling(true)
-			->setData('should_ignore_validation', true);
+		$customerBillingData->setIsDefaultBilling(true);
 
 		if ($shipping) {
 			if (isset($oscData['same_as_shipping']) && $oscData['same_as_shipping']) {
@@ -130,8 +101,7 @@ class CheckoutSubmitBefore implements ObserverInterface
 				$customerBillingData->setIsDefaultShipping(true);
 			} else {
 				$customerShippingData = $shipping->exportCustomerAddress();
-				$customerShippingData->setIsDefaultShipping(true)
-					->setData('should_ignore_validation', true);
+				$customerShippingData->setIsDefaultShipping(true);
 				$shipping->setCustomerAddressData($customerShippingData);
 				// Add shipping address to quote since customer Data Object does not hold address information
 				$quote->addCustomerAddress($customerShippingData);
@@ -143,11 +113,5 @@ class CheckoutSubmitBefore implements ObserverInterface
 		// TODO : Eventually need to remove this legacy hack
 		// Add billing address to quote since customer Data Object does not hold address information
 		$quote->addCustomerAddress($customerBillingData);
-
-		// If customer is created, set customerId for address to avoid create more address when checkout
-		if($customerId = $quote->getCustomerId()){
-			$billing->setCustomerId($customerId);
-			$shipping->setCustomerId($customerId);
-		}
 	}
 }
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index 8a8edc6..1c369b5 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -1,61 +1,42 @@
 <?php
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
 namespace Mageplaza\Osc\Observer;
 
 use Magento\Framework\Event\ObserverInterface;
 
-/**
- * Class QuoteSubmitBefore
- * @package Mageplaza\Osc\Observer
- */
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
-    ) {
-    
-        $this->checkoutSession = $checkoutSession;
-    }
+	/**
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @codeCoverageIgnore
+	 */
+	public function __construct(
+		\Magento\Checkout\Model\Session $checkoutSession
+	)
+	{
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
+	/**
+	 * @param \Magento\Framework\Event\Observer $observer
+	 * @return void
+	 * @SuppressWarnings(PHPMD.UnusedFormalParameter)
+	 */
+	public function execute(\Magento\Framework\Event\Observer $observer)
+	{
+		$order = $observer->getEvent()->getOrder();
 
-        $oscData = $this->checkoutSession->getOscData();
-        if (isset($oscData['comment'])) {
-            $order->setData('osc_order_comment', $oscData['comment']);
-        }
-    }
+		$oscData = $this->checkoutSession->getOscData();
+		if (isset($oscData['comment'])) {
+			$order->setData('osc_order_comment', $oscData['comment']);
+		}
+	}
 }
diff --git a/Observer/QuoteSubmitSuccess.php b/Observer/QuoteSubmitSuccess.php
index 775e025..83eb93f 100644
--- a/Observer/QuoteSubmitSuccess.php
+++ b/Observer/QuoteSubmitSuccess.php
@@ -1,173 +1,146 @@
 <?php
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
 namespace Mageplaza\Osc\Observer;
 
 use Magento\Framework\Event\ObserverInterface;
 
-/**
- * Class QuoteSubmitSuccess
- * @package Mageplaza\Osc\Observer
- */
 class QuoteSubmitSuccess implements ObserverInterface
 {
-    /**
-     * @var \Magento\Checkout\Model\Session
-     */
-    protected $checkoutSession;
-
-    /**
-     * @type \Magento\Customer\Api\AccountManagementInterface
-     */
-    protected $accountManagement;
-
-    /**
-     * @type \Magento\Customer\Model\Url
-     */
-    protected $_customerUrl;
-
-    /**
-     * @type \Magento\Framework\Message\ManagerInterface
-     */
-    protected $messageManager;
-
-    /**
-     * @type \Magento\Customer\Model\Session
-     */
-    protected $_customerSession;
-
-    /**
-     * @type \Magento\Newsletter\Model\SubscriberFactory
-     */
-    protected $subscriberFactory;
-
-    /**
-     * @param \Magento\Checkout\Model\Session $checkoutSession
-     * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
-     * @param \Magento\Customer\Model\Url $customerUrl
-     * @param \Magento\Framework\Message\ManagerInterface $messageManager
-     * @param \Magento\Customer\Model\Session $customerSession
-     * @param \Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
-     */
-    public function __construct(
-        \Magento\Checkout\Model\Session $checkoutSession,
-        \Magento\Customer\Api\AccountManagementInterface $accountManagement,
-        \Magento\Customer\Model\Url $customerUrl,
-        \Magento\Framework\Message\ManagerInterface $messageManager,
-        \Magento\Customer\Model\Session $customerSession,
-        \Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
-    ) {
-    
-        $this->checkoutSession   = $checkoutSession;
-        $this->accountManagement = $accountManagement;
-        $this->_customerUrl      = $customerUrl;
-        $this->messageManager    = $messageManager;
-        $this->_customerSession  = $customerSession;
-        $this->subscriberFactory = $subscriberFactory;
-    }
-
-    /**
-     * @param \Magento\Framework\Event\Observer $observer
-     * @return void
-     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
-     */
-    public function execute(\Magento\Framework\Event\Observer $observer)
-    {
-        /** @type \Magento\Quote\Model\Quote $quote $quote */
-        $quote = $observer->getEvent()->getQuote();
-
-        $oscData = $this->checkoutSession->getOscData();
-        if (isset($oscData['register']) && $oscData['register']
-            && isset($oscData['password']) && $oscData['password']
-        ) {
-            $customer           = $quote->getCustomer();
-
-            /* Set customer Id for address */
-            if($customer->getId()) {
-                $quote->getBillingAddress()->setCustomerId($customer->getId());
-                $quote->getBillingAddress()->setCustomerId($customer->getId());
-            }
-
-            /* Check customer to be login or not */
-            $confirmationStatus = $this->accountManagement->getConfirmationStatus($customer->getId());
-            if ($confirmationStatus === \Magento\Customer\Model\AccountManagement::ACCOUNT_CONFIRMATION_REQUIRED) {
-                $url = $this->_customerUrl->getEmailConfirmationUrl($customer->getEmail());
-                $this->messageManager->addSuccessMessage(
+	/**
+	 * @var \Magento\Checkout\Model\Session
+	 */
+	protected $checkoutSession;
+
+	/**
+	 * @type \Magento\Customer\Api\AccountManagementInterface
+	 */
+	protected $accountManagement;
+
+	/**
+	 * @type \Magento\Customer\Model\Url
+	 */
+	protected $_customerUrl;
+
+	/**
+	 * @type \Magento\Framework\Message\ManagerInterface
+	 */
+	protected $messageManager;
+
+	/**
+	 * @type \Magento\Customer\Model\Session
+	 */
+	protected $_customerSession;
+
+	/**
+	 * @type \Magento\Newsletter\Model\SubscriberFactory
+	 */
+	protected $subscriberFactory;
+
+	/**
+	 * @param \Magento\Checkout\Model\Session $checkoutSession
+	 * @param \Magento\Customer\Api\AccountManagementInterface $accountManagement
+	 * @param \Magento\Customer\Model\Url $customerUrl
+	 * @param \Magento\Framework\Message\ManagerInterface $messageManager
+	 * @param \Magento\Customer\Model\Session $customerSession
+	 * @param \Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
+	 */
+	public function __construct(
+		\Magento\Checkout\Model\Session $checkoutSession,
+		\Magento\Customer\Api\AccountManagementInterface $accountManagement,
+		\Magento\Customer\Model\Url $customerUrl,
+		\Magento\Framework\Message\ManagerInterface $messageManager,
+		\Magento\Customer\Model\Session $customerSession,
+		\Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
+	)
+	{
+		$this->checkoutSession   = $checkoutSession;
+		$this->accountManagement = $accountManagement;
+		$this->_customerUrl      = $customerUrl;
+		$this->messageManager    = $messageManager;
+		$this->_customerSession  = $customerSession;
+		$this->subscriberFactory = $subscriberFactory;
+	}
+
+	/**
+	 * @param \Magento\Framework\Event\Observer $observer
+	 * @return void
+	 * @SuppressWarnings(PHPMD.UnusedFormalParameter)
+	 */
+	public function execute(\Magento\Framework\Event\Observer $observer)
+	{
+		/** @type \Magento\Quote\Model\Quote $quote $quote */
+		$quote = $observer->getEvent()->getQuote();
+
+		$oscData = $this->checkoutSession->getOscData();
+		if (isset($oscData['register']) && $oscData['register']
+			&& isset($oscData['password']) && $oscData['password']
+		) {
+			$customer           = $quote->getCustomer();
+			$confirmationStatus = $this->accountManagement->getConfirmationStatus($customer->getId());
+			if ($confirmationStatus === \Magento\Customer\Model\AccountManagement::ACCOUNT_CONFIRMATION_REQUIRED) {
+				$url = $this->_customerUrl->getEmailConfirmationUrl($customer->getEmail());
+				$this->messageManager->addSuccess(
 				// @codingStandardsIgnoreStart
 					__(
 						'You must confirm your account. Please check your email for the confirmation link or <a href="%1">click here</a> for a new link.',
 						$url
 					)
 				// @codingStandardsIgnoreEnd
-                );
-            } else {
-                $this->_customerSession->loginById($customer->getId());
-                $this->_customerSession->regenerateId();
-                if ($this->getCookieManager()->getCookie('mage-cache-sessid')) {
-                    $metadata = $this->getCookieMetadataFactory()->createCookieMetadata();
-                    $metadata->setPath('/');
-                    $this->getCookieManager()->deleteCookie('mage-cache-sessid', $metadata);
-                }
-            }
-        }
-
-        if (isset($oscData['is_subscribed']) && $oscData['is_subscribed']) {
-            if (!$this->_customerSession->isLoggedIn()) {
-                $subscribedEmail = $quote->getBillingAddress()->getEmail();
-            } else {
-                $customer        = $this->_customerSession->getCustomer();
-                $subscribedEmail = $customer->getEmail();
-            }
-
-            try {
-                $this->subscriberFactory->create()
-                    ->subscribe($subscribedEmail);
-            } catch (\Exception $e) {
-                $this->messageManager->addErrorMessage(__('There is an error while subscribing for newsletter.'));
-            }
-        }
-
-        $this->checkoutSession->unsOscData();
-    }
-
-    /**
-     * Retrieve cookie manager
-     *
-     * @return \Magento\Framework\Stdlib\Cookie\PhpCookieManager
-     */
-    private function getCookieManager()
-    {
-        return \Magento\Framework\App\ObjectManager::getInstance()->get(
-            \Magento\Framework\Stdlib\Cookie\PhpCookieManager::class
-        );
-    }
-
-    /**
-     * Retrieve cookie metadata factory
-     *
-     * @return \Magento\Framework\Stdlib\Cookie\CookieMetadataFactory
-     */
-    private function getCookieMetadataFactory()
-    {
-        return \Magento\Framework\App\ObjectManager::getInstance()->get(
-            \Magento\Framework\Stdlib\Cookie\CookieMetadataFactory::class
-        );
-    }
+				);
+			} else {
+				$this->_customerSession->loginById($customer->getId());
+				$this->_customerSession->regenerateId();
+				if ($this->getCookieManager()->getCookie('mage-cache-sessid')) {
+					$metadata = $this->getCookieMetadataFactory()->createCookieMetadata();
+					$metadata->setPath('/');
+					$this->getCookieManager()->deleteCookie('mage-cache-sessid', $metadata);
+				}
+			}
+		}
+
+		if (isset($oscData['is_subscribed']) && $oscData['is_subscribed']) {
+			if (!$this->_customerSession->isLoggedIn()) {
+				$subscribedEmail = $quote->getBillingAddress()->getEmail();
+			} else {
+				$customer        = $this->_customerSession->getCustomer();
+				$subscribedEmail = $customer->getEmail();
+			}
+
+			try {
+				$this->subscriberFactory->create()
+					->subscribe($subscribedEmail);
+			} catch (\Exception $e) {
+
+			}
+		}
+
+		$this->checkoutSession->unsOscData();
+	}
+
+	/**
+	 * Retrieve cookie manager
+	 *
+	 * @return \Magento\Framework\Stdlib\Cookie\PhpCookieManager
+	 */
+	private function getCookieManager()
+	{
+		return \Magento\Framework\App\ObjectManager::getInstance()->get(
+			\Magento\Framework\Stdlib\Cookie\PhpCookieManager::class
+		);
+	}
+
+	/**
+	 * Retrieve cookie metadata factory
+	 *
+	 * @return \Magento\Framework\Stdlib\Cookie\CookieMetadataFactory
+	 */
+	private function getCookieMetadataFactory()
+	{
+		return \Magento\Framework\App\ObjectManager::getInstance()->get(
+			\Magento\Framework\Stdlib\Cookie\CookieMetadataFactory::class
+		);
+	}
 }
diff --git a/Setup/InstallSchema.php b/Setup/InstallSchema.php
index 1c0456b..5523d76 100644
--- a/Setup/InstallSchema.php
+++ b/Setup/InstallSchema.php
@@ -1,44 +1,18 @@
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 namespace Mageplaza\Osc\Setup;
 
-/**
- * Class InstallSchema
- * @package Mageplaza\Osc\Setup
- */
 class InstallSchema implements \Magento\Framework\Setup\InstallSchemaInterface
 {
     /**
      * install tables
      *
-     * @param \Magento\Framework\Setup\SchemaSetupInterface $setup
+     * @param \Magento\Framework\Setup\SchemaSetupInterface   $setup
      * @param \Magento\Framework\Setup\ModuleContextInterface $context
      * @return void
      * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
      */
-    public function install(
-        \Magento\Framework\Setup\SchemaSetupInterface $setup,
-        \Magento\Framework\Setup\ModuleContextInterface $context
-    ) {
-    
+    public function install(\Magento\Framework\Setup\SchemaSetupInterface $setup, \Magento\Framework\Setup\ModuleContextInterface $context)
+    {
         $installer = $setup;
         $installer->startSetup();
         $setup->getConnection()->addColumn(
diff --git a/etc/acl.xml b/etc/acl.xml
index 7c61402..a4ac2ed 100644
--- a/etc/acl.xml
+++ b/etc/acl.xml
@@ -1,32 +1,10 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Acl/etc/acl.xsd">
     <acl>
         <resources>
             <resource id="Magento_Backend::admin">
                 <resource id="Mageplaza_Core::menu">
                     <resource id="Mageplaza_Osc::osc" title="One Step Checkout" sortOrder="71">
-                        <resource id="Mageplaza_Osc::field_management" title="Field Management" sortOrder="10"/>
                         <resource id="Mageplaza_Osc::configuration" title="Configuration" sortOrder="1000"/>
                     </resource>
                 </resource>
diff --git a/etc/adminhtml/di.xml b/etc/adminhtml/di.xml
index 61c906e..ea47f40 100644
--- a/etc/adminhtml/di.xml
+++ b/etc/adminhtml/di.xml
@@ -1,25 +1,4 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <type name="Magento\Sales\Block\Adminhtml\Order\View\Tab\Info">
         <plugin name="osc_additional_content" type="Mageplaza\Osc\Block\Adminhtml\Plugin\OrderViewTabInfo" />
diff --git a/etc/adminhtml/routes.xml b/etc/adminhtml/routes.xml
index 7ba2975..5f63200 100644
--- a/etc/adminhtml/routes.xml
+++ b/etc/adminhtml/routes.xml
@@ -1,28 +1,7 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:App/etc/routes.xsd">
     <router id="admin">
-        <route id="onestepcheckout" frontName="onestepcheckout">
+        <route id="mageplaza_osc" frontName="onestepcheckout">
             <module name="Mageplaza_Osc" before="Magento_Backend"/>
         </route>
     </router>
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 6d84bbe..b9e99f4 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -1,25 +1,4 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
     <system>
         <section id="osc" translate="label comment" sortOrder="10" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
diff --git a/etc/config.xml b/etc/config.xml
index 0c93d0c..212981c 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -1,25 +1,4 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Store:etc/config.xsd">
     <default>
         <osc>
@@ -43,7 +22,7 @@
             </display_configuration>
             <design_configuration>
                 <page_layout>3columns-colspan</page_layout>
-                <page_design>flat</page_design>
+                <page_design>default</page_design>
                 <heading_background>#1979c3</heading_background>
                 <heading_text>#FFFFFF</heading_text>
                 <place_order_button>#1979c3</place_order_button>
diff --git a/etc/di.xml b/etc/di.xml
index 2db66d6..74c54ce 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -1,23 +1,8 @@
 <?xml version="1.0"?>
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
diff --git a/etc/events.xml b/etc/events.xml
index fa7af09..625262e 100644
--- a/etc/events.xml
+++ b/etc/events.xml
@@ -1,23 +1,8 @@
 <?xml version="1.0"?>
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd">
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index bf0e577..b394259 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -1,25 +1,4 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <!-- Register onestepcheckout link as secure url -->
     <type name="Magento\Framework\Url\SecurityInfo">
diff --git a/etc/frontend/page_types.xml b/etc/frontend/page_types.xml
index dc0f906..89e72ed 100644
--- a/etc/frontend/page_types.xml
+++ b/etc/frontend/page_types.xml
@@ -1,23 +1,8 @@
 <?xml version="1.0"?>
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
 <page_types xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_types.xsd">
diff --git a/etc/frontend/routes.xml b/etc/frontend/routes.xml
index 63064bf..9fa5ec6 100644
--- a/etc/frontend/routes.xml
+++ b/etc/frontend/routes.xml
@@ -1,25 +1,4 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:App/etc/routes.xsd">
     <router id="standard">
         <route id="onestepcheckout" frontName="onestepcheckout">
diff --git a/etc/frontend/sections.xml b/etc/frontend/sections.xml
index a2f90f3..bcd2dcb 100644
--- a/etc/frontend/sections.xml
+++ b/etc/frontend/sections.xml
@@ -1,23 +1,8 @@
 <?xml version="1.0"?>
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
diff --git a/etc/module.xml b/etc/module.xml
index 252f0db..842a6d8 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -1,25 +1,4 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
     <module name="Mageplaza_Osc" setup_version="2.0.0"/>
     <sequence>
diff --git a/etc/webapi.xml b/etc/webapi.xml
index 7e737f2..28f845d 100644
--- a/etc/webapi.xml
+++ b/etc/webapi.xml
@@ -1,25 +1,4 @@
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
 <routes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Webapi:etc/webapi.xsd">
     <route url="/V1/guest-carts/:cartId/update-item" method="POST">
diff --git a/etc/webapi_rest/di.xml b/etc/webapi_rest/di.xml
index 9c28aee..4625ec6 100644
--- a/etc/webapi_rest/di.xml
+++ b/etc/webapi_rest/di.xml
@@ -1,25 +1,4 @@
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <!-- Save address when estimate shipping method -->
     <type name="Magento\Quote\Model\ShippingMethodManagement">
diff --git a/registration.php b/registration.php
index 889e4d1..c3f285d 100644
--- a/registration.php
+++ b/registration.php
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 \Magento\Framework\Component\ComponentRegistrar::register(
     \Magento\Framework\Component\ComponentRegistrar::MODULE,
diff --git a/view/adminhtml/layout/sales_order_view.xml b/view/adminhtml/layout/sales_order_view.xml
index 72ac5e8..e40ce1c 100644
--- a/view/adminhtml/layout/sales_order_view.xml
+++ b/view/adminhtml/layout/sales_order_view.xml
@@ -1,23 +1,8 @@
 <?xml version="1.0"?>
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
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="admin-2columns-left" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
diff --git a/view/adminhtml/templates/order/additional.phtml b/view/adminhtml/templates/order/additional.phtml
index 3198d40..f40e8a0 100644
--- a/view/adminhtml/templates/order/additional.phtml
+++ b/view/adminhtml/templates/order/additional.phtml
@@ -1,22 +1,7 @@
 <?php
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
 
 // @codingStandardsIgnoreFile
diff --git a/view/adminhtml/templates/order/view/comment.phtml b/view/adminhtml/templates/order/view/comment.phtml
index 9d77081..cf07c78 100644
--- a/view/adminhtml/templates/order/view/comment.phtml
+++ b/view/adminhtml/templates/order/view/comment.phtml
@@ -1,22 +1,7 @@
 <?php
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
+ * Copyright � 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 
 // @codingStandardsIgnoreFile
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
index 6a937af..70b4891 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
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
@@ -16,13 +15,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
--->
+ * @copyright   Copyright (c) 2016 Mageplaza (http://mageplaza.com/)
+ * @license     http://mageplaza.com/license-agreement/
+ -->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" layout="checkout" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <update handle="checkout_index_index" />
     <head>
+        <title>One Step Checkout</title>
         <css src="Mageplaza_Osc::css/style.css"/>
         <css src="Mageplaza_Core::css/grid-mageplaza.css"/>
         <css src="Mageplaza_Core::css/font-awesome.min.css"/>
diff --git a/view/frontend/layout/sales_order_view.xml b/view/frontend/layout/sales_order_view.xml
index ad40e23..d770f97 100644
--- a/view/frontend/layout/sales_order_view.xml
+++ b/view/frontend/layout/sales_order_view.xml
@@ -1,23 +1,8 @@
 <?xml version="1.0"?>
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
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index 1c88a83..36e2e8f 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 
 var config = {};
diff --git a/view/frontend/templates/description.phtml b/view/frontend/templates/description.phtml
index 2e14c1b..3217347 100644
--- a/view/frontend/templates/description.phtml
+++ b/view/frontend/templates/description.phtml
@@ -1,24 +1,3 @@
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
 <p class="checkout-description">
 	<?php echo $block->getCheckoutDescription(); ?>
 </p>
\ No newline at end of file
diff --git a/view/frontend/templates/generator/css/design.phtml b/view/frontend/templates/generator/css/design.phtml
index 5b04ec2..ddac334 100644
--- a/view/frontend/templates/generator/css/design.phtml
+++ b/view/frontend/templates/generator/css/design.phtml
@@ -33,7 +33,7 @@
 <?php switch ($design['page_design']): ?>
 <?php case 'flat': ?>
 	.checkout-container a.button-action,
-	.checkout-container button:not(.primary):not(.action-show):not(.action-close){
+	.checkout-container button:not(.primary):not(.action-show){
 		background-color: <?php echo $design['heading_background'] ?> !important;
 		border-color: <?php echo $design['heading_background'] ?> !important;
 		box-shadow: none !important;
diff --git a/view/frontend/templates/order/additional.phtml b/view/frontend/templates/order/additional.phtml
index 2a2810d..b5424a2 100644
--- a/view/frontend/templates/order/additional.phtml
+++ b/view/frontend/templates/order/additional.phtml
@@ -1,22 +1,7 @@
 <?php
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
 
 // @codingStandardsIgnoreFile
diff --git a/view/frontend/templates/order/view/comment.phtml b/view/frontend/templates/order/view/comment.phtml
index 3303563..3d14d48 100644
--- a/view/frontend/templates/order/view/comment.phtml
+++ b/view/frontend/templates/order/view/comment.phtml
@@ -1,25 +1,3 @@
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
 <?php if ($commentHtml = $block->getOrderComment()): ?>
 <div class="box box-order-comment">
     <strong class="box-title">
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index 039370f..b8bb237 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -1,24 +1,4 @@
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
-/**************************************************** Osc style ****************************************************/
+/** Osc style **/
 .one-step-checkout-wrapper{width: 100% !important; margin-top: 20px; padding: 0 !important;}
 .onestepcheckout-index-index input.google-auto-complete {margin-right: 10px; width: calc(100% - 36px);}
 .one-step-checkout-container .osc-geolocation {font-size: 20px;cursor: pointer;transition: all 0.3s ease 0s;}
@@ -26,12 +6,11 @@
 .onestepcheckout-index-index .field.choice{margin-bottom: 10px}
 .opc-wrapper .create-account-block .fieldset .field .label{font-weight: 400 !important;}
 .step-title .fa{display: none;}
-.step-content{border-radius: 0 !important;}
 
-/**************************************************** Authetication area ****************************************************/
+/** Authetication area **/
 .osc-authentication-wrapper{z-index: 999; position: relative; max-width: 50%}
 
-/**************************************************** Shipping address area ****************************************************/
+/** Shipping address area **/
 .one-step-checkout-wrapper .form.form-login{border-bottom: 0 !important; padding-bottom: 0 !important;}
 .one-step-checkout-wrapper #customer-email-fieldset.fieldset > .field{margin: 0 !important;}
 fieldset.field.col-mp{padding: 0 10px !important;}
@@ -41,67 +20,128 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .opc-wrapper .shipping-address-item button.edit-address-link{position: absolute; top: 14px; right: 40px; margin-top: 0;}
 .opc-wrapper .action-select-shipping-item{display: none !important;}
 .opc-wrapper .form-shipping-address{margin-bottom: 0 !important;}
-/** Theme **/
-.opc-wrapper .fieldset > .field > .label{float: none !important; width: auto !important; margin: 0 0 8px !important;}
-.fieldset > .field:not(.choice) > .control{float: none !important; width: 100% !important;}
-.fieldset > .field {margin: 0 0 20px !important;}
-#checkout-step-shipping .form-login {margin-top: 0 !important; padding-top: 28px !important;}
 
-/**************************************************** Billing address area ****************************************************/
-.checkout-billing-address .step-content .field.field-select-billing label{display: none}
+/** Billing address area **/
+.checkout-billing-address  .step-content .field.field-select-billing label{display: none}
 #checkout-step-billing {margin-top: 20px}
 .fieldset#billing-new-address-form > .field > .label{font-weight: normal}
 #checkout-step-billing .field.field-select-billing{margin-bottom: 20px; padding: 0 10px;}
 
-/**************************************************** Shipping method area ****************************************************/
+/** Shipping method area **/
 #checkout-shipping-method-load .table-checkout-shipping-method {width: 100% !important; min-width: 0;}
 #co-shipping-method-form{margin-top: 10px}
 .osc-shipping-method ul{padding:0;}
 .osc-shipping-method ul li{list-style: none;}
-.table-checkout-shipping-method thead th{display: none;}
 
-/**************************************************** Payment method area ****************************************************/
+/** Payment method area **/
 .osc-payment-after-methods .opc-payment-additional .field .control{float: left; margin-right: 3px}
 .payment-method-content .payment-method-billing-address,
 .payment-method-content .checkout-agreements-block,
 .payment-method-content .actions-toolbar {display: none}
 
-/**************************************************** Order summary area ****************************************************/
+/** Order summary area **/
 .opc-block-summary .minicart-items-wrapper{max-height: none !important;}
-.opc-block-summary{background: none !important; border: none !important;}
+.opc-block-summary{background: none !important;}
 .one-step-checkout-wrapper .minicart-items-wrapper .product-item-detail{display: inline-block; padding-left: 10px;}
 .minicart-items .product-item-name{font-size: 16px !important;}
 .remove-wrapper {padding: 5px;}
-.qty-wrapper {padding: 5px;min-width: 83px;height: 30px;}
-.qty-wrapper .qty-wrap {display: inline-block;width: 26px;height: 20px;line-height: 18px;vertical-align: top;position: relative;}
-.qty-wrapper .qty-wrap .input-text.update {width: 26px; box-sizing: border-box; text-align: center;position: absolute;left: 0;top: -5px;}
+.qty-wrapper {padding: 5px;min-width: 75px;height: 30px;}
+.qty-wrapper .qty-wrap {display: inline-block;width: 30px;height: 20px;line-height: 18px;vertical-align: top;position: relative;}
+.qty-wrapper .qty-wrap .input-text.update {width: 26px; text-align: center;position: absolute;left: 0;top: -5px;}
 .button-action.plus {background-image: url(images/review/btn-plus.png);}
 .button-action.minus {background-image: url(images/review/btn-minus.png);}
 .button-action.remove {background-image: url(images/review/btn-remove.png);}
-.button-action {display: inline-block;width: 18px;height: 18px;background-position: center center !important;background-repeat: no-repeat !important;padding: 0 !important;overflow: hidden;text-indent: -9999px;border-radius: 2px;-webkit-border-radius: 2px;-moz-border-radius: 2px;transition: all 0.3s ease 0s;-webkit-transition: all 0.3s ease 0s;-moz-transition: all 0.3s ease 0s;outline: none !important;text-decoration: none;margin-top: -3px;vertical-align: inherit !important;background-color: #AAAAAA;}
-
-#checkout-review-table{width: 100%; background-color: #fff; border: 1px solid #dcd8d8;border-collapse: inherit;border-bottom: 0;}
-#checkout-review-table thead th{text-transform: uppercase;font-weight: bold;}
-#checkout-review-table thead th,#checkout-review-table tbody tr td,#checkout-review-table tfoot tr td{padding: 15px 15px;border-bottom: 1px solid #dcd8d8;}
-.cart-totals, .opc-block-summary .table-totals{border: 1px solid #ccc;}
+.button-action {
+    display: inline-block;
+    width: 18px;
+    height: 18px;
+    background-position: center center !important;
+    background-repeat: no-repeat !important;
+    padding: 0 !important;
+    overflow: hidden;
+    text-indent: -9999px;
+    border-radius: 2px;
+    -webkit-border-radius: 2px;
+    -moz-border-radius: 2px;
+    transition: all 0.3s ease 0s;
+    -webkit-transition: all 0.3s ease 0s;
+    -moz-transition: all 0.3s ease 0s;
+    outline: none !important;
+    text-decoration: none;
+    margin-top: -3px;
+    vertical-align: inherit !important;
+    background-color: #bbb;
+}
+#checkout-review-table{
+    width: 100%;
+    background-color: #fff;
+    border: 1px solid #dcd8d8;
+    border-collapse: inherit;
+    border-bottom: 0;
+}
+#checkout-review-table thead th{
+    text-transform: uppercase;
+    font-weight: bold;
+}
+#checkout-review-table thead th,
+#checkout-review-table tbody tr td,
+#checkout-review-table tfoot tr td{
+    padding: 15px 15px;
+    border-bottom: 1px solid #dcd8d8;
+}
+.cart-totals, .opc-block-summary .table-totals{
+    border: 1px solid #ccc;
+    border-top: 0 !important;
+}
 .opc-block-summary .block.items-in-cart{margin-bottom: 0 !important;}
-.opc-block-summary .table-totals tbody .mark,.opc-block-summary .table-totals tfoot .mark{text-align: right;}
-.opc-block-summary .table-totals tbody .amount,.opc-block-summary .table-totals tfoot .amount{width: 150px;padding-right: 20px;}
-.opc-block-summary .table-totals .grand .mark{padding-right: 0 !important;}
+.opc-block-summary .table-totals tbody .mark,
+.opc-block-summary .table-totals tfoot .mark{
+    text-align: right;
+}
+.opc-block-summary .table-totals tbody .amount,
+.opc-block-summary .table-totals tfoot .amount{
+    width: 150px;
+    padding-right: 20px;
+}
+.opc-block-summary .table-totals .grand .mark{
+    padding-right: 0 !important;
+}
+
 .one-step-checkout-wrapper .mp-4 .minicart-items-wrapper .product-image-container{display: none;}
 .one-step-checkout-wrapper .mp-4 .opc-block-summary{padding: 0 10px !important;}
-.one-step-checkout-wrapper .mp-4 #checkout-review-table thead th,.one-step-checkout-wrapper .mp-4 #checkout-review-table tbody tr td,.one-step-checkout-wrapper .mp-4 #checkout-review-table tfoot tr td{padding-left: 5px !important;padding-right: 5px !important;}
+.one-step-checkout-wrapper .mp-4 #checkout-review-table thead th,
+.one-step-checkout-wrapper .mp-4 #checkout-review-table tbody tr td,
+.one-step-checkout-wrapper .mp-4 #checkout-review-table tfoot tr td{
+    padding-left: 5px !important;
+    padding-right: 5px !important;
+}
 
-/**************************************************** Place order area ****************************************************/
+/** Place order area **/
 #co-place-order-form{padding: 0 20px !important;}
 .one-step-checkout-wrapper .mp-4 #co-place-order-form{padding: 0 !important;}
 .one-step-checkout-wrapper .mp-4 #co-place-order-form .col-mp{width: 100% !important;}
-.osc-place-order-wrapper button.action.primary.checkout {padding: 10px 30px;margin: 0;border: none;font-size: 18px;font-weight: bold;width: 100%;height: 70px;}
-.osc-place-order-block{border: 1px solid #ccc;padding: 10px !important;margin-bottom: 20px;}
-.checkout-addition-block{padding-top: 20px !important;}
+.osc-place-order-wrapper button.action.primary.checkout {
+    padding: 10px 30px;
+    margin: 0;
+    border: none;
+    font-size: 18px;
+    font-weight: bold;
+    width: 100%;
+    height: 70px;
+}
+.osc-place-order-block{
+    border: 1px solid #ccc;
+    padding: 10px !important;
+    margin-bottom: 20px;
+}
+.checkout-addition-block{
+    padding-top: 20px !important;
+}
 .osc-place-order-wrapper button.action.primary.checkout span {color: #FFFFFF;background: none;border: none;}
 
-/**************************************************** Responsive ****************************************************/
+/** Responsive **/
 @media (min-width: 768px), print {
-    .osc-authentication-wrapper {width: 33.33333333%;}
+    .osc-authentication-wrapper {
+        width: 33.33333333%;
+    }
 }
diff --git a/view/frontend/web/js/action/payment-total-information.js b/view/frontend/web/js/action/payment-total-information.js
index 2991592..03d1d8f 100644
--- a/view/frontend/web/js/action/payment-total-information.js
+++ b/view/frontend/web/js/action/payment-total-information.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
-
 define(
     [
         'jquery',
@@ -41,11 +25,11 @@ define(
         methodConverter,
         paymentService,
         shippingService,
-        oscLoader
-    ) {
+        oscLoader) {
         'use strict';
 
         return function () {
+
             oscLoader.startLoader();
 
             return storage.post(
diff --git a/view/frontend/web/js/action/set-checkout-information.js b/view/frontend/web/js/action/set-checkout-information.js
index f6afb05..4697f8f 100644
--- a/view/frontend/web/js/action/set-checkout-information.js
+++ b/view/frontend/web/js/action/set-checkout-information.js
@@ -1,23 +1,8 @@
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
-
+/*global define,alert*/
 define(
     [
         'Magento_Checkout/js/model/shipping-save-processor',
diff --git a/view/frontend/web/js/action/update-item.js b/view/frontend/web/js/action/update-item.js
index e9dc11b..9fe5d30 100644
--- a/view/frontend/web/js/action/update-item.js
+++ b/view/frontend/web/js/action/update-item.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
-
 define(
     [
         'jquery',
@@ -41,8 +25,7 @@ define(
         methodConverter,
         paymentService,
         shippingService,
-        oscLoader
-    ) {
+        oscLoader) {
         'use strict';
 
         var itemUpdateLoader = ['shipping', 'payment', 'total'];
@@ -50,7 +33,7 @@ define(
         return function (payload) {
             var isRemove = !('item_qty' in payload);
 
-            if (!customer.isLoggedIn()) {
+            if(!customer.isLoggedIn()){
                 payload.cart_id = quote.getQuoteId();
             }
 
diff --git a/view/frontend/web/js/model/address/auto-complete.js b/view/frontend/web/js/model/address/auto-complete.js
index b4a4f30..a28a84a 100644
--- a/view/frontend/web/js/model/address/auto-complete.js
+++ b/view/frontend/web/js/model/address/auto-complete.js
@@ -17,7 +17,6 @@
  * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 define([
     'Mageplaza_Osc/js/model/address/type/google'
 ], function (googleAutoComplete) {
diff --git a/view/frontend/web/js/model/address/type/google.js b/view/frontend/web/js/model/address/type/google.js
index c316c2f..a32c656 100644
--- a/view/frontend/web/js/model/address/type/google.js
+++ b/view/frontend/web/js/model/address/type/google.js
@@ -17,7 +17,6 @@
  * @copyright   Copyright (c) 2016 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 define([
     'jquery',
     'uiClass',
@@ -114,20 +113,17 @@ define([
                         }
                         responseComponents.street += addressValue;
                     }
-                    if (addressType == 'locality') {
+                    if (addressType == 'locality')
                         responseComponents.city = addressValue;
-                    }
                     if (addressType == 'administrative_area_level_1') {
                         responseComponents.region = addressValue;
                         responseComponents.region_id = addressValue;
                         responseComponents.region_id_input = addressValue;
                     }
-                    if (addressType == 'country') {
+                    if (addressType == 'country')
                         responseComponents.country_id = addressValue;
-                    }
-                    if (addressType == 'postal_code') {
+                    if (addressType == 'postal_code')
                         responseComponents.postcode = addressValue;
-                    }
                 }
             }
             if (place.hasOwnProperty('name')) {
diff --git a/view/frontend/web/js/model/agreement-validator.js b/view/frontend/web/js/model/agreement-validator.js
index e197fed..0785b21 100644
--- a/view/frontend/web/js/model/agreement-validator.js
+++ b/view/frontend/web/js/model/agreement-validator.js
@@ -1,23 +1,9 @@
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
-
+/*jshint browser:true jquery:true*/
+/*global alert*/
 define(
     [
         'jquery',
@@ -36,7 +22,7 @@ define(
              *
              * @returns {boolean}
              */
-            validate: function () {
+            validate: function() {
                 if (!agreementsConfig.isEnabled) {
                     return true;
                 }
@@ -56,7 +42,7 @@ define(
                         }
                         errorPlacement.after(error);
                     }
-                }).form();
+                }).element(agreementsInputPath);
             }
         }
     }
diff --git a/view/frontend/web/js/model/checkout-data-resolver.js b/view/frontend/web/js/model/checkout-data-resolver.js
index ebe99fe..349a2da 100644
--- a/view/frontend/web/js/model/checkout-data-resolver.js
+++ b/view/frontend/web/js/model/checkout-data-resolver.js
@@ -1,23 +1,12 @@
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
+ */
+/*jshint browser:true*/
+/*global alert*/
+/**
+ * Checkout adapter for customer data storage
  */
-
 define(
     [
         'Magento_Checkout/js/checkout-data'
diff --git a/view/frontend/web/js/model/osc-data.js b/view/frontend/web/js/model/osc-data.js
index d9431fb..3cb5f30 100644
--- a/view/frontend/web/js/model/osc-data.js
+++ b/view/frontend/web/js/model/osc-data.js
@@ -1,23 +1,12 @@
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
+ */
+/*jshint browser:true*/
+/*global alert*/
+/**
+ * Checkout adapter for customer data storage
  */
-
 define([
     'jquery',
     'Magento_Customer/js/customer-data'
diff --git a/view/frontend/web/js/model/osc-loader.js b/view/frontend/web/js/model/osc-loader.js
index 82ee576..3fdf6f1 100644
--- a/view/frontend/web/js/model/osc-loader.js
+++ b/view/frontend/web/js/model/osc-loader.js
@@ -1,25 +1,10 @@
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
-
-define(
-    [
+/*jshint browser:true jquery:true*/
+/*global alert*/
+define([
         'jquery',
         'Magento_Checkout/js/model/shipping-service',
         'Magento_Checkout/js/model/totals',
@@ -80,7 +65,7 @@ define(
                 var services = this.getServices(blocks);
                 $.each(services, function (index, service) {
                     blockLoader[index].queue -= 1;
-                    if (blockLoader[index].queue == 0) {
+                    if(blockLoader[index].queue == 0) {
                         service.isLoading(false);
                     }
                 });
diff --git a/view/frontend/web/js/model/payment-service.js b/view/frontend/web/js/model/payment-service.js
index 72aa437..4fa46e5 100644
--- a/view/frontend/web/js/model/payment-service.js
+++ b/view/frontend/web/js/model/payment-service.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
-
 define(
     [
         'ko'
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index b548380..1e43ead 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -1,35 +1,21 @@
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
-
+/*jshint browser:true jquery:true*/
+/*global alert*/
 define(
     [
         'jquery',
         'Magento_Checkout/js/model/resource-url-manager'
     ],
-    function ($, resourceUrlManager) {
+    function($, resourceUrlManager) {
         "use strict";
 
         return $.extend({
 
             /** Get url for update item qty and remove item */
-            getUrlForUpdateItemInformation: function (quote, isRemove) {
+            getUrlForUpdateItemInformation: function(quote, isRemove) {
                 var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
                 var urlPath = (isRemove == true) ? 'remove-item' : 'update-item';
                 var urls = {
@@ -40,7 +26,7 @@ define(
             },
 
             /** Get url for saving checkout information */
-            getUrlForSetCheckoutInformation: function (quote) {
+            getUrlForSetCheckoutInformation: function(quote) {
                 var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
                 var urls = {
                     'guest': '/guest-carts/:cartId/checkout-information',
@@ -50,7 +36,7 @@ define(
             },
 
             /** Get url for update item qty and remove item */
-            getUrlForUpdatePaymentTotalInformation: function (quote) {
+            getUrlForUpdatePaymentTotalInformation: function(quote) {
                 var params = (this.getCheckoutMethod() == 'guest') ? {cartId: quote.getQuoteId()} : {};
                 var urls = {
                     'guest': '/guest-carts/:cartId/payment-total-information',
diff --git a/view/frontend/web/js/model/shipping-rate-service.js b/view/frontend/web/js/model/shipping-rate-service.js
index d537d58..0e94ddd 100644
--- a/view/frontend/web/js/model/shipping-rate-service.js
+++ b/view/frontend/web/js/model/shipping-rate-service.js
@@ -1,23 +1,9 @@
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
-
+/*jshint browser:true*/
+/*global define*/
 define(
     [
         'Magento_Checkout/js/model/quote',
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index b4a5a1e..71cf4da 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -1,23 +1,8 @@
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
-
+/*global define*/
 define(
     [
         'jquery',
@@ -32,19 +17,17 @@ define(
         'mage/translate',
         'uiRegistry'
     ],
-    function (
-        $,
-        utils,
-        Validator,
-        shippingRatesValidationRules,
-        addressConverter,
-        selectShippingAddress,
-        shippingRateService,
-        shippingService,
-        postcodeValidator,
-        $t,
-        uiRegistry
-    ) {
+    function ($,
+              utils,
+              Validator,
+              shippingRatesValidationRules,
+              addressConverter,
+              selectShippingAddress,
+              shippingRateService,
+              shippingService,
+              postcodeValidator,
+              $t,
+              uiRegistry) {
         'use strict';
 
         var countryElement = null,
@@ -54,13 +37,13 @@ define(
 
         return $.extend(Validator, {
 
-            oscValidateAddressData: function (field, address) {
+            oscValidateAddressData: function(field, address){
                 var canLoad = false;
 
                 $.each(shippingRatesValidationRules.getRules(), function (carrier, fields) {
-                    if (fields.hasOwnProperty(field)) {
+                    if(fields.hasOwnProperty(field)){
                         var missingValue = false;
-                        $.each(fields, function (key, rule) {
+                        $.each(fields, function(key, rule) {
                             if (address.hasOwnProperty(key) && rule.required && utils.isEmpty(address[key])) {
                                 var regionFields = ['region', 'region_id', 'region_id_input'];
                                 if ($.inArray(key, regionFields) === -1
@@ -72,7 +55,7 @@ define(
                                 }
                             }
                         });
-                        if (!missingValue) {
+                        if(!missingValue){
                             canLoad = true;
 
                             return false;
@@ -111,16 +94,16 @@ define(
                         self.oscBindHandler(elem);
                     });
                 } else {
-                    if (!element || !element.hasOwnProperty('value')) {
+                    if(!element || !element.hasOwnProperty('value')){
                         return this;
                     }
                     element.on('value', function () {
                         self.oscPostcodeValidation();
 
                         var addressFlat = addressConverter.formDataProviderToFlatData(
-                            self.oscCollectObservedData(),
-                            'shippingAddress'
-                        ),
+                                self.oscCollectObservedData(),
+                                'shippingAddress'
+                            ),
                             address;
 
                         address = addressConverter.formAddressDataToQuoteAddress(addressFlat);
@@ -151,7 +134,7 @@ define(
 
                 $.each(observedElements, function (index, field) {
                     var value = field.value();
-                    if ($.type(value) === 'undefined') {
+                    if($.type(value) === 'undefined'){
                         value = '';
                     }
                     observedValues[field.dataScope] = value;
diff --git a/view/frontend/web/js/model/shipping-save-processor/checkout.js b/view/frontend/web/js/model/shipping-save-processor/checkout.js
index 69a81b0..a4bdd4d 100644
--- a/view/frontend/web/js/model/shipping-save-processor/checkout.js
+++ b/view/frontend/web/js/model/shipping-save-processor/checkout.js
@@ -1,23 +1,8 @@
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
-
+/*global define,alert*/
 define(
     [
         'ko',
@@ -32,19 +17,17 @@ define(
         'Magento_Checkout/js/model/full-screen-loader',
         'Magento_Checkout/js/action/select-billing-address'
     ],
-    function (
-        ko,
-        $,
-        quote,
-        resourceUrlManager,
-        storage,
-        oscData,
-        paymentService,
-        methodConverter,
-        errorProcessor,
-        fullScreenLoader,
-        selectBillingAddressAction
-    ) {
+    function (ko,
+              $,
+              quote,
+              resourceUrlManager,
+              storage,
+              oscData,
+              paymentService,
+              methodConverter,
+              errorProcessor,
+              fullScreenLoader,
+              selectBillingAddressAction) {
         'use strict';
 
         return {
@@ -81,9 +64,6 @@ define(
                 ).fail(
                     function (response) {
                         errorProcessor.process(response);
-                    }
-                ).always(
-                    function () {
                         fullScreenLoader.stopLoader();
                     }
                 );
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index e3d1712..84756d8 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -1,23 +1,9 @@
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
-
+/*jshint browser:true*/
+/*global define*/
 define(
     [
         'jquery',
@@ -38,25 +24,23 @@ define(
         'uiRegistry',
         'rjsResolver'
     ],
-    function (
-        $,
-        ko,
-        Component,
-        quote,
-        checkoutData,
-        oscData,
-        createBillingAddress,
-        selectBillingAddress,
-        customer,
-        setBillingAddressAction,
-        addressConverter,
-        additionalValidators,
-        globalMessageList,
-        checkoutDataResolver,
-        addressAutoComplete,
-        registry,
-        resolver
-    ) {
+    function ($,
+              ko,
+              Component,
+              quote,
+              checkoutData,
+              oscData,
+              createBillingAddress,
+              selectBillingAddress,
+              customer,
+              setBillingAddressAction,
+              addressConverter,
+              additionalValidators,
+              globalMessageList,
+              checkoutDataResolver,
+              addressAutoComplete,
+              registry,
+              resolver) {
         'use strict';
 
         var observedElements = [];
@@ -109,7 +93,7 @@ define(
                 return this;
             },
 
-            afterResolveDocument: function () {
+            afterResolveDocument: function(){
                 this.saveBillingAddress();
 
                 addressAutoComplete.register('billing');
@@ -180,7 +164,7 @@ define(
 
             saveBillingAddress: function () {
                 if (!this.isAddressSameAsShipping()) {
-                    if (!window.checkoutConfig.oscConfig.showBillingAddress) {
+                    if(!window.checkoutConfig.oscConfig.showBillingAddress){
                         selectBillingAddress(quote.shippingAddress());
                     } else {
                         var addressFlat = addressConverter.formDataProviderToFlatData(
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index 920b7da..55f1585 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -1,34 +1,19 @@
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
-
+/*browser:true*/
+/*global define*/
 define([
     'jquery',
     'ko',
     'Magento_Checkout/js/view/form/element/email',
-    'Magento_Customer/js/model/customer',
     'Mageplaza_Osc/js/model/osc-data',
     'Magento_Checkout/js/model/payment/additional-validators',
     'Magento_Customer/js/action/check-email-availability',
     'rjsResolver',
     'mage/validation'
-], function ($, ko, Component, customer, oscData, additionalValidators, checkEmailAvailability, resolver) {
+], function ($, ko, Component, oscData, additionalValidators, checkEmailAvailability, resolver) {
     'use strict';
 
     var cacheKey = 'form_register_chechbox',
@@ -36,7 +21,7 @@ define([
         passwordMinLength = window.checkoutConfig.oscConfig.register.dataPasswordMinLength,
         passwordMinCharacter = window.checkoutConfig.oscConfig.register.dataPasswordMinCharacterSets;
 
-    if (!customer.isLoggedIn() && !allowGuestCheckout) {
+    if (!allowGuestCheckout) {
         oscData.setData(cacheKey, true);
     }
 
@@ -94,7 +79,7 @@ define([
         },
 
         validate: function (type) {
-            if (customer.isLoggedIn() || !this.isRegisterVisible() || this.isPasswordVisible()) {
+            if (!this.isRegisterVisible() || this.isPasswordVisible()) {
                 oscData.setData('register', false);
                 return true;
             }
@@ -114,7 +99,7 @@ define([
             var confirm = !!$('#osc-password-confirmation').valid();
 
             var result = password && confirm;
-            if (result) {
+            if(result){
                 oscData.setData('register', true);
                 oscData.setData('password', passwordSelector.val());
             }
diff --git a/view/frontend/web/js/view/form/element/region.js b/view/frontend/web/js/view/form/element/region.js
index 33c55fa..46e437b 100644
--- a/view/frontend/web/js/view/form/element/region.js
+++ b/view/frontend/web/js/view/form/element/region.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 
 define([
diff --git a/view/frontend/web/js/view/form/element/street.js b/view/frontend/web/js/view/form/element/street.js
index 8e4f280..c644467 100644
--- a/view/frontend/web/js/view/form/element/street.js
+++ b/view/frontend/web/js/view/form/element/street.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 
 define([
@@ -42,10 +27,10 @@ define([
         /**
          * Init google/pca autocomplete
          */
-        initAutocomplete: function () {
+        initAutocomplete: function(){
             var fieldsetName = this.parentName.split('.').slice(0, -1).join('.');
 
-            switch (window.checkoutConfig.oscConfig.autocomplete.type) {
+            switch (window.checkoutConfig.oscConfig.autocomplete.type){
                 case 'google':
                     this.googleAutocomplete = new googleAutoComplete(this.uid, fieldsetName);
                     break;
diff --git a/view/frontend/web/js/view/payment.js b/view/frontend/web/js/view/payment.js
index 4d9e926..74df48e 100644
--- a/view/frontend/web/js/view/payment.js
+++ b/view/frontend/web/js/view/payment.js
@@ -1,23 +1,9 @@
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
-
+/*jshint browser:true jquery:true*/
+/*global alert*/
 define(
     [
         'ko',
@@ -28,15 +14,13 @@ define(
         'Mageplaza_Osc/js/model/checkout-data-resolver',
         'Mageplaza_Osc/js/model/payment-service'
     ],
-    function (
-        ko,
-        Component,
-        quote,
-        stepNavigator,
-        additionalValidators,
-        oscDataResolver,
-        oscPaymentService
-    ) {
+    function (ko,
+              Component,
+              quote,
+              stepNavigator,
+              additionalValidators,
+              oscDataResolver,
+              oscPaymentService) {
         'use strict';
 
         oscDataResolver.resolveDefaultPaymentMethod();
diff --git a/view/frontend/web/js/view/review/addition.js b/view/frontend/web/js/view/review/addition.js
index d492ae0..cfa1eb3 100644
--- a/view/frontend/web/js/view/review/addition.js
+++ b/view/frontend/web/js/view/review/addition.js
@@ -1,23 +1,8 @@
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
-
+/*global define*/
 define(
     [
         'ko',
diff --git a/view/frontend/web/js/view/review/addition/newsletter.js b/view/frontend/web/js/view/review/addition/newsletter.js
index ef7bcd4..6f45db6 100644
--- a/view/frontend/web/js/view/review/addition/newsletter.js
+++ b/view/frontend/web/js/view/review/addition/newsletter.js
@@ -1,23 +1,8 @@
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
-
+/*global define*/
 define(
     [
         'ko',
diff --git a/view/frontend/web/js/view/review/checkout-agreements.js b/view/frontend/web/js/view/review/checkout-agreements.js
index dc40441..eaa340f 100644
--- a/view/frontend/web/js/view/review/checkout-agreements.js
+++ b/view/frontend/web/js/view/review/checkout-agreements.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
-
 define(
     [
         'Magento_CheckoutAgreements/js/view/checkout-agreements',
diff --git a/view/frontend/web/js/view/review/comment.js b/view/frontend/web/js/view/review/comment.js
index af48906..2c7c884 100644
--- a/view/frontend/web/js/view/review/comment.js
+++ b/view/frontend/web/js/view/review/comment.js
@@ -1,23 +1,8 @@
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
-
+/*global define*/
 define(
     [
         'ko',
diff --git a/view/frontend/web/js/view/review/placeOrder.js b/view/frontend/web/js/view/review/placeOrder.js
index dfd9b1f..e27f656 100644
--- a/view/frontend/web/js/view/review/placeOrder.js
+++ b/view/frontend/web/js/view/review/placeOrder.js
@@ -1,23 +1,8 @@
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
-
+/*global define*/
 define(
     [
         'jquery',
@@ -25,12 +10,10 @@ define(
         'Magento_Checkout/js/model/payment/additional-validators',
         'Mageplaza_Osc/js/action/set-checkout-information'
     ],
-    function (
-        $,
-        Component,
-        additionalValidators,
-        setCheckoutInformationAction
-    ) {
+    function ($,
+              Component,
+              additionalValidators,
+              setCheckoutInformationAction) {
         "use strict";
         return Component.extend({
             defaults: {
@@ -38,9 +21,9 @@ define(
             },
             paymentButton: '#co-payment-form .payment-method._active button.action.primary.checkout',
 
-            placeOrder: function () {
+            placeOrder: function(){
                 var self = this;
-                if (additionalValidators.validate()) {
+                if(additionalValidators.validate()){
                     $.when(setCheckoutInformationAction()).done(function () {
                         self._placeOrder();
                     });
@@ -49,14 +32,14 @@ define(
                 return this;
             },
 
-            _placeOrder: function () {
+            _placeOrder: function(){
                 var paymentButton = $(this.paymentButton);
-                if (paymentButton.length) {
+                if(paymentButton.length) {
                     paymentButton.first().trigger('click');
                 }
             },
 
-            isPlaceOrderActionAllowed: function () {
+            isPlaceOrderActionAllowed: function(){
                 return true;
             }
         });
diff --git a/view/frontend/web/js/view/shipping-address/address-renderer/default.js b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
index 1b630ac..a2eaa46 100644
--- a/view/frontend/web/js/view/shipping-address/address-renderer/default.js
+++ b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
-
+/*global define*/
 define([
     'Magento_Checkout/js/view/shipping-address/address-renderer/default',
     'Magento_Checkout/js/model/shipping-rate-service'
-], function (Component, shippingRateService) {
+], function(Component, shippingRateService) {
     'use strict';
 
     return Component.extend({
@@ -30,8 +15,8 @@ define([
         },
 
         /** Set selected customer shipping address  */
-        selectAddress: function () {
-            if (!this.isSelected()) {
+        selectAddress: function() {
+            if(!this.isSelected()) {
                 this._super();
 
                 shippingRateService.estimateShippingMethod();
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index c76bb09..1ee2e31 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -1,23 +1,8 @@
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
-
+/*global define*/
 define(
     [
         'jquery',
@@ -38,25 +23,23 @@ define(
         'Mageplaza_Osc/js/model/address/auto-complete',
         'rjsResolver'
     ],
-    function (
-        $,
-        Component,
-        quote,
-        customer,
-        setShippingInformationAction,
-        getPaymentTotalInformation,
-        stepNavigator,
-        additionalValidators,
-        checkoutData,
-        selectBillingAddress,
-        selectShippingAddress,
-        addressConverter,
-        shippingRateService,
-        shippingService,
-        oscDataResolver,
-        addressAutoComplete,
-        resolver
-    ) {
+    function ($,
+              Component,
+              quote,
+              customer,
+              setShippingInformationAction,
+              getPaymentTotalInformation,
+              stepNavigator,
+              additionalValidators,
+              checkoutData,
+              selectBillingAddress,
+              selectShippingAddress,
+              addressConverter,
+              shippingRateService,
+              shippingService,
+              oscDataResolver,
+              addressAutoComplete,
+              resolver) {
         'use strict';
 
         oscDataResolver.resolveDefaultShippingMethod();
@@ -138,8 +121,6 @@ define(
                     if (this.source.get('params.invalid')) {
                         shippingAddressValidationResult = false;
                     }
-
-                    this.saveShippingAddress();
                 }
 
                 if (!emailValidationResult) {
@@ -147,32 +128,6 @@ define(
                 }
 
                 return shippingMethodValidationResult && shippingAddressValidationResult && emailValidationResult;
-            },
-            saveShippingAddress: function () {
-                var shippingAddress = quote.shippingAddress(),
-                    addressData = addressConverter.formAddressDataToQuoteAddress(
-                        this.source.get('shippingAddress')
-                    );
-
-                //Copy form data to quote shipping address object
-                for (var field in addressData) {
-                    if (addressData.hasOwnProperty(field) &&
-                        shippingAddress.hasOwnProperty(field) &&
-                        typeof addressData[field] != 'function' &&
-                        _.isEqual(shippingAddress[field], addressData[field])
-                    ) {
-                        shippingAddress[field] = addressData[field];
-                    } else if (typeof addressData[field] != 'function' &&
-                        !_.isEqual(shippingAddress[field], addressData[field])) {
-                        shippingAddress = addressData;
-                        break;
-                    }
-                }
-
-                if (customer.isLoggedIn()) {
-                    shippingAddress.save_in_address_book = 1;
-                }
-                selectShippingAddress(shippingAddress);
             }
         });
     }
diff --git a/view/frontend/web/js/view/summary/item/details.js b/view/frontend/web/js/view/summary/item/details.js
index 57e1ca8..535c839 100644
--- a/view/frontend/web/js/view/summary/item/details.js
+++ b/view/frontend/web/js/view/summary/item/details.js
@@ -1,23 +1,9 @@
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
-
+/*jshint browser:true jquery:true*/
+/*global alert*/
 define(
     [
         'jquery',
@@ -26,13 +12,11 @@ define(
         'Mageplaza_Osc/js/action/update-item',
         'mage/url'
     ],
-    function (
-        $,
-        Component,
-        quote,
-        updateItemAction,
-        url
-    ) {
+    function ($,
+              Component,
+              quote,
+              updateItemAction,
+              url) {
         "use strict";
 
         var products = window.checkoutConfig.quoteItemData;
@@ -42,17 +26,16 @@ define(
                 template: 'Mageplaza_Osc/container/summary/item/details'
             },
 
-            getProductUrl: function (parent) {
-                var item = products.find(function (product) {
+            getProductUrl: function(parent){
+                var item = products.find(function(product){
                     return product.item_id == parent.item_id;
                 });
 
-                if (item && item.hasOwnProperty('product') &&
-                    item.product.hasOwnProperty('request_path') && item.product.request_path) {
+                if(item && item.hasOwnProperty('product') && item.product.hasOwnProperty('request_path')){
                     return url.build(item.product.request_path);
                 }
 
-                return false;
+                return '#';
             },
 
             /**
@@ -118,7 +101,7 @@ define(
                     item_id: itemId
                 };
 
-                if (typeof itemQty !== 'undefined') {
+                if(typeof itemQty !== 'undefined'){
                     payload['item_qty'] = itemQty;
                 }
 
diff --git a/view/frontend/web/template/1column.html b/view/frontend/web/template/1column.html
index 7ea5234..424150b 100644
--- a/view/frontend/web/template/1column.html
+++ b/view/frontend/web/template/1column.html
@@ -1,25 +1,3 @@
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
 <!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
diff --git a/view/frontend/web/template/2columns.html b/view/frontend/web/template/2columns.html
index 79bf88b..d777bb8 100644
--- a/view/frontend/web/template/2columns.html
+++ b/view/frontend/web/template/2columns.html
@@ -1,25 +1,3 @@
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
 <!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index af50f07..0815fc5 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -1,25 +1,3 @@
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
 <!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
diff --git a/view/frontend/web/template/3columns.html b/view/frontend/web/template/3columns.html
index 96866b4..a6dfe7f 100644
--- a/view/frontend/web/template/3columns.html
+++ b/view/frontend/web/template/3columns.html
@@ -1,25 +1,3 @@
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
 <!-- ko foreach: getRegion('authentication') -->
 <!-- ko template: getTemplate() --><!-- /ko -->
 <!--/ko-->
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index f19dd09..2f1eada 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -1,25 +1,9 @@
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
-
 <div id="billing" class="checkout-billing-address" data-bind="visible: !isAddressSameAsShipping()">
     <div class="step-title" data-role="title">
         <i class="fa fa-home"></i>
diff --git a/view/frontend/web/template/container/address/billing/checkbox.html b/view/frontend/web/template/container/address/billing/checkbox.html
index 98f921d..c68fe94 100644
--- a/view/frontend/web/template/container/address/billing/checkbox.html
+++ b/view/frontend/web/template/container/address/billing/checkbox.html
@@ -1,25 +1,9 @@
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
-
 <div class="billing-address-same-as-shipping-block field choice col-mp mp-12" data-bind="visible: canUseShippingAddress()">
     <input type="checkbox" name="billing-address-same-as-shipping" data-bind="checked: isAddressSameAsShipping, click: useShippingAddress, attr: {id: 'billing-address-same-as-shipping'}"/>
     <label data-bind="attr: {for: 'billing-address-same-as-shipping'}"><span data-bind="i18n: 'My billing and shipping address are the same'"></span></label>
diff --git a/view/frontend/web/template/container/address/billing/create.html b/view/frontend/web/template/container/address/billing/create.html
index a5b1a0b..e590d7a 100644
--- a/view/frontend/web/template/container/address/billing/create.html
+++ b/view/frontend/web/template/container/address/billing/create.html
@@ -1,25 +1,9 @@
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
-
 <div class="create-account-block"  data-bind="fadeVisible: isPasswordVisible() == false">
     <div class="create-account-checkbox field choice col-mp mp-12" data-bind="visible: isCheckboxRegisterVisible">
         <input type="checkbox" name="create-account-checkbox" data-bind="checked: isRegisterVisible, attr: {id: 'create-account-checkbox'}"/>
@@ -27,7 +11,7 @@
             <span data-bind="i18n: 'Create account'"></span>
         </label>
     </div>
-    <fieldset class="fieldset hidden-fields mp-clear" data-bind="fadeVisible: isRegisterVisible">
+    <fieldset class="fieldset hidden-fields" data-bind="fadeVisible: isRegisterVisible">
         <div class="field password required col-mp mp-6">
             <label for="osc-password" class="label"><span data-bind="i18n: 'Password'"></span></label>
             <div class="control">
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index b28d9a0..73be6fe 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -1,25 +1,3 @@
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
 <div id="shipping" class="checkout-shipping-address" data-bind="fadeVisible: visible()">
     <div class="step-title" data-role="title">
         <i class="fa fa-home"></i>
diff --git a/view/frontend/web/template/container/address/shipping/address-renderer/default.html b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
index 389a126..e5023e8 100644
--- a/view/frontend/web/template/container/address/shipping/address-renderer/default.html
+++ b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
@@ -1,25 +1,9 @@
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
-
 <div class="shipping-address-item" data-bind="css: isSelected() ? 'selected-item' : 'not-selected-item', click: selectAddress">
     <!-- ko text: address().prefix --><!-- /ko --> <!-- ko text: address().firstname --><!-- /ko -->
     <!-- ko text: address().lastname --><!-- /ko --> <!-- ko text: address().suffix --><!-- /ko --><br/>
diff --git a/view/frontend/web/template/container/address/shipping/form.html b/view/frontend/web/template/container/address/shipping/form.html
index 55a9eac..f68a322 100644
--- a/view/frontend/web/template/container/address/shipping/form.html
+++ b/view/frontend/web/template/container/address/shipping/form.html
@@ -1,25 +1,9 @@
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
-
 <form class="form form-shipping-address" id="co-shipping-form" data-bind="attr: {'data-hasrequired': $t('* Required Fields')}">
     <!-- ko foreach: getRegion('before-fields') -->
     <!-- ko template: getTemplate() --><!-- /ko -->
diff --git a/view/frontend/web/template/container/authentication.html b/view/frontend/web/template/container/authentication.html
index 1a4193a..8419a7f 100644
--- a/view/frontend/web/template/container/authentication.html
+++ b/view/frontend/web/template/container/authentication.html
@@ -1,25 +1,9 @@
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
-
 <div class="osc-authentication-wrapper" data-block="authentication" data-bind="visible: isActive()">
     <a href="javascript:void(0)" class="action action-auth-toggle" data-trigger="authentication">
         <span data-bind="i18n: 'Already have an account? Click here to login'"></span>
diff --git a/view/frontend/web/template/container/form/element/email.html b/view/frontend/web/template/container/form/element/email.html
index 4dcc012..d41c34f 100644
--- a/view/frontend/web/template/container/form/element/email.html
+++ b/view/frontend/web/template/container/form/element/email.html
@@ -1,25 +1,9 @@
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
-
 <!-- ko ifnot: isCustomerLoggedIn() -->
 
 <!-- ko foreach: getRegion('before-login-form') -->
diff --git a/view/frontend/web/template/container/form/element/input.html b/view/frontend/web/template/container/form/element/input.html
index 214707c..97d0590 100644
--- a/view/frontend/web/template/container/form/element/input.html
+++ b/view/frontend/web/template/container/form/element/input.html
@@ -1,25 +1,9 @@
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
-
 <input class="input-text" type="text" data-bind="
     value: value,
     hasFocus: focused,
diff --git a/view/frontend/web/template/container/form/element/street.html b/view/frontend/web/template/container/form/element/street.html
index cf9dc14..fcaa799 100644
--- a/view/frontend/web/template/container/form/element/street.html
+++ b/view/frontend/web/template/container/form/element/street.html
@@ -1,25 +1,9 @@
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
-
 <input class="input-text" type="text" data-bind="
     value: value,
     hasFocus: focused,
diff --git a/view/frontend/web/template/container/payment.html b/view/frontend/web/template/container/payment.html
index d207f4d..ee58264 100644
--- a/view/frontend/web/template/container/payment.html
+++ b/view/frontend/web/template/container/payment.html
@@ -1,25 +1,9 @@
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
-
 <div id="payment" role="presentation" class="checkout-payment-method">
     <div class="step-title" data-role="title">
         <i class="fa fa-credit-card"></i>
@@ -54,12 +38,12 @@
                     <span><!-- ko text: errorValidationMessage()--><!-- /ko --></span>
                 </div>
                 <!-- /ko -->
+                <div class="osc-payment-after-methods">
+                    <!-- ko foreach: getRegion('afterMethods') -->
+                        <!-- ko template: getTemplate() --><!-- /ko -->
+                    <!-- /ko -->
+                </div>
             </fieldset>
         </form>
-        <div class="osc-payment-after-methods">
-            <!-- ko foreach: getRegion('afterMethods') -->
-                <!-- ko template: getTemplate() --><!-- /ko -->
-            <!-- /ko -->
-        </div>
     </div>
 </div>
diff --git a/view/frontend/web/template/container/payment/discount.html b/view/frontend/web/template/container/payment/discount.html
index 9366731..5919b90 100644
--- a/view/frontend/web/template/container/payment/discount.html
+++ b/view/frontend/web/template/container/payment/discount.html
@@ -1,25 +1,9 @@
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
-
 <div class="payment-option opc-payment-additional discount-code">
     <div class="payment-option-title field choice" data-role="title">
         <span class="action" id="block-discount-heading" role="heading" aria-level="2">
diff --git a/view/frontend/web/template/container/review/addition.html b/view/frontend/web/template/container/review/addition.html
index 67dd084..04d3822 100644
--- a/view/frontend/web/template/container/review/addition.html
+++ b/view/frontend/web/template/container/review/addition.html
@@ -1,25 +1,9 @@
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
-
 <!-- ko if: elems().length > 0 -->
 <div class="osc-place-order-block checkout-addition-block col-mp mp-12">
     <!-- ko foreach: elems() -->
diff --git a/view/frontend/web/template/container/review/addition/newsletter.html b/view/frontend/web/template/container/review/addition/newsletter.html
index dceb3e8..3d2705e 100644
--- a/view/frontend/web/template/container/review/addition/newsletter.html
+++ b/view/frontend/web/template/container/review/addition/newsletter.html
@@ -1,25 +1,9 @@
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
-
 <div class="osc-newsletter field choice col-mp mp-12">
     <input type="checkbox" name="osc-newsletter" data-bind="checked: isRegisterNewsletter, attr: {id: 'osc-place-order-newsletter'}"/>
     <label data-bind="attr: {for: 'osc-place-order-newsletter'}"><span data-bind="i18n: 'Register for newsletter'"></span></label>
diff --git a/view/frontend/web/template/container/review/comment.html b/view/frontend/web/template/container/review/comment.html
index a9a6c08..c31ada6 100644
--- a/view/frontend/web/template/container/review/comment.html
+++ b/view/frontend/web/template/container/review/comment.html
@@ -1,25 +1,9 @@
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
-
 <div class="osc-place-order-block checkout-comment-block col-mp mp-12">
     <div class="field-row">
         <label for="comments" data-bind="i18n: 'Comments'"></label><br>
diff --git a/view/frontend/web/template/container/review/place-order.html b/view/frontend/web/template/container/review/place-order.html
index 8376de2..4651376 100644
--- a/view/frontend/web/template/container/review/place-order.html
+++ b/view/frontend/web/template/container/review/place-order.html
@@ -1,25 +1,9 @@
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
-
 <div class="checkout-agreements-block mp-12">
     <!-- ko foreach: getRegion('checkout-agreements') -->
         <!-- ko template: getTemplate() --><!-- /ko -->
diff --git a/view/frontend/web/template/container/shipping.html b/view/frontend/web/template/container/shipping.html
index 23dc2f9..dc3ff53 100644
--- a/view/frontend/web/template/container/shipping.html
+++ b/view/frontend/web/template/container/shipping.html
@@ -1,25 +1,9 @@
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
-
 <!--Shipping method template-->
 <div id="opc-shipping_method"
      class="checkout-shipping-method"
diff --git a/view/frontend/web/template/container/sidebar.html b/view/frontend/web/template/container/sidebar.html
index 4af0cef..e679e1a 100644
--- a/view/frontend/web/template/container/sidebar.html
+++ b/view/frontend/web/template/container/sidebar.html
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
 
diff --git a/view/frontend/web/template/container/summary.html b/view/frontend/web/template/container/summary.html
index ac804af..54ac058 100644
--- a/view/frontend/web/template/container/summary.html
+++ b/view/frontend/web/template/container/summary.html
@@ -1,29 +1,14 @@
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
 <div class="step-title" data-role="title">
     <i class="fa fa-check-square"></i>
     <span data-bind="i18n: 'Order Summary'"></span>
 </div>
-<div class="opc-block-summary step-content" data-bind="blockLoader: isLoading">
+<div class="opc-block-summary" data-bind="blockLoader: isLoading">
     <!-- ko foreach: elems() -->
         <!-- ko template: getTemplate() --><!-- /ko -->
     <!-- /ko -->
diff --git a/view/frontend/web/template/container/summary/cart-items.html b/view/frontend/web/template/container/summary/cart-items.html
index 7cb5718..ddf1099 100644
--- a/view/frontend/web/template/container/summary/cart-items.html
+++ b/view/frontend/web/template/container/summary/cart-items.html
@@ -1,25 +1,9 @@
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
-
 <div class="block items-in-cart">
     <div class="content minicart-items">
         <div class="minicart-items-wrapper overflowed">
diff --git a/view/frontend/web/template/container/summary/item/details.html b/view/frontend/web/template/container/summary/item/details.html
index 545b08a..97d58a3 100644
--- a/view/frontend/web/template/container/summary/item/details.html
+++ b/view/frontend/web/template/container/summary/item/details.html
@@ -1,25 +1,9 @@
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
-
 <td class="a-left product">
     <!-- ko foreach: getRegion('before_details') -->
     <!-- ko template: getTemplate() --><!-- /ko -->
@@ -28,14 +12,9 @@
     <div class="product-item-detail">
         <div class="product-item-inner">
             <div class="product-item-name-block">
-                <!-- ko if: getProductUrl($parent) -->
                 <a data-bind="attr:{href: getProductUrl($parent)}" target="_blank">
                     <strong class="product-item-name" data-bind="text: $parent.name"></strong>
                 </a>
-                <!-- /ko -->
-                <!-- ko ifnot: getProductUrl($parent)-->
-                <strong class="product-item-name" data-bind="text: $parent.name"></strong>
-                <!-- /ko -->
             </div>
         </div>
         <!-- ko if: (JSON.parse($parent.options).length > 0)-->
