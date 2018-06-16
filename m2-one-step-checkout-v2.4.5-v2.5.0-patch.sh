diff --git a/Api/CheckoutManagementInterface.php b/Api/CheckoutManagementInterface.php
index 61bec82..55100a3 100644
--- a/Api/CheckoutManagementInterface.php
+++ b/Api/CheckoutManagementInterface.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Api/Data/OscDetailsInterface.php b/Api/Data/OscDetailsInterface.php
index 8f2d83d..fe45c9b 100644
--- a/Api/Data/OscDetailsInterface.php
+++ b/Api/Data/OscDetailsInterface.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Api/GuestCheckoutManagementInterface.php b/Api/GuestCheckoutManagementInterface.php
index 7e11059..1083b38 100644
--- a/Api/GuestCheckoutManagementInterface.php
+++ b/Api/GuestCheckoutManagementInterface.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Adminhtml/Config/Backend/StaticBlock.php b/Block/Adminhtml/Config/Backend/StaticBlock.php
deleted file mode 100644
index 7c7395e..0000000
--- a/Block/Adminhtml/Config/Backend/StaticBlock.php
+++ /dev/null
@@ -1,124 +0,0 @@
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
- * @package     Mageplaza_AbandonedCart
- * @copyright   Copyright (c) Mageplaza (https://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Block\Adminhtml\Config\Backend;
-
-use Magento\Backend\Block\Template\Context;
-use Magento\Config\Block\System\Config\Form\Field\FieldArray\AbstractFieldArray;
-use Magento\Framework\Data\Form\Element\Factory;
-
-/**
- * Class StaticBlock
- * @package Mageplaza\AbandonedCart\Block\Adminhtml\Config\Backend
- */
-class StaticBlock extends AbstractFieldArray
-{
-    /**
-     * @var \Magento\Framework\Data\Form\Element\Factory
-     */
-    protected $elementFactory;
-
-    /**
-     * @var \Mageplaza\Osc\Model\System\Config\Source\StaticBlockPosition
-     */
-    protected $blockPosition;
-
-    /**
-     * @var \Magento\Cms\Model\ResourceModel\Block\CollectionFactory
-     */
-    protected $blockFactory;
-
-    /**
-     * StaticBlock constructor.
-     * @param Context $context
-     * @param Factory $elementFactory
-     * @param \Mageplaza\Osc\Model\System\Config\Source\StaticBlockPosition $blockPosition
-     * @param \Magento\Cms\Model\ResourceModel\Block\CollectionFactory $blockFactory
-     * @param array $data
-     */
-    public function __construct(
-        Context $context,
-        Factory $elementFactory,
-        \Mageplaza\Osc\Model\System\Config\Source\StaticBlockPosition $blockPosition,
-        \Magento\Cms\Model\ResourceModel\Block\CollectionFactory $blockFactory,
-        array $data = []
-    )
-    {
-        $this->elementFactory   = $elementFactory;
-        $this->blockPosition    = $blockPosition;
-        $this->blockFactory     = $blockFactory;
-
-        parent::__construct($context, $data);
-    }
-
-    /**
-     * Initialise form fields
-     *
-     * @return void
-     */
-    public function _construct()
-    {
-        $this->addColumn('block', ['label' => __('Block')]);
-        $this->addColumn('position', ['label' => __('Position')]);
-        $this->addColumn('sort_order', ['label' => __('Sort Order'), 'style' => 'width: 100px']);
-
-        $this->_addAfter       = false;
-        $this->_addButtonLabel = __('More');
-
-        parent::_construct();
-    }
-
-    /**
-     * Render array cell for prototypeJS template
-     *
-     * @param string $columnName
-     * @return mixed|string
-     * @throws \Exception
-     */
-    public function renderCellTemplate($columnName)
-    {
-        if (!empty($this->_columns[$columnName])) {
-            switch ($columnName) {
-                case 'block':
-                    $options = $this->blockFactory->create()->toOptionArray();
-                    break;
-                case 'position':
-                    $options = $this->blockPosition->toOptionArray();
-                    break;
-                default:
-                    $options = '';
-                    break;
-            }
-            if ($options) {
-                $element = $this->elementFactory->create('select');
-                $element->setForm($this->getForm())
-                    ->setName($this->_getCellInputElementName($columnName))
-                    ->setHtmlId($this->_getCellInputElementId('<%- _id %>', $columnName))
-                    ->setValues($options)
-                    ->setStyle('width: 200px');
-
-                return str_replace("\n", '', $element->getElementHtml());
-            }
-        }
-
-        return parent::renderCellTemplate($columnName);
-    }
-}
diff --git a/Block/Adminhtml/Field/Position.php b/Block/Adminhtml/Field/Position.php
index 3ccd3bf..4dca4e1 100644
--- a/Block/Adminhtml/Field/Position.php
+++ b/Block/Adminhtml/Field/Position.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Adminhtml/Plugin/OrderViewTabInfo.php b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
index ce8e1ac..2953837 100644
--- a/Block/Adminhtml/Plugin/OrderViewTabInfo.php
+++ b/Block/Adminhtml/Plugin/OrderViewTabInfo.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Adminhtml/System/Config/Geoip.php b/Block/Adminhtml/System/Config/Geoip.php
index ada90e4..e2e8954 100644
--- a/Block/Adminhtml/System/Config/Geoip.php
+++ b/Block/Adminhtml/System/Config/Geoip.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Checkout/CompatibleConfig.php b/Block/Checkout/CompatibleConfig.php
index 64f3e94..b34fb6f 100644
--- a/Block/Checkout/CompatibleConfig.php
+++ b/Block/Checkout/CompatibleConfig.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Checkout/LayoutProcessor.php b/Block/Checkout/LayoutProcessor.php
index 0c96989..6aeaede 100644
--- a/Block/Checkout/LayoutProcessor.php
+++ b/Block/Checkout/LayoutProcessor.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -203,14 +203,12 @@ class LayoutProcessor implements LayoutProcessorInterface
             $addressElements[$attribute->getAttributeCode()] = $this->attributeMapper->map($attribute);
         }
 
-        if (sizeof($addressElements)) {
-            $fields = $this->merger->merge(
-                $addressElements,
-                'checkoutProvider',
-                $type . '.custom_attributes',
-                $fields
-            );
-        }
+        $fields = $this->merger->merge(
+            $addressElements,
+            'checkoutProvider',
+            $type . '.custom_attributes',
+            $fields
+        );
 
         foreach ($fields as $code => &$field) {
             if(isset($field['label'])) {
@@ -229,14 +227,6 @@ class LayoutProcessor implements LayoutProcessorInterface
     {
         $fieldPosition = $this->_oscHelper->getAddressHelper()->getAddressFieldPosition();
 
-        $oscField = [];
-        $allFieldSection = $this->_oscHelper->getAddressHelper()->getSortedField(false);
-        foreach ($allFieldSection as $allfield) {
-            foreach ($allfield as $field) {
-                $oscField[] = $field->getAttributeCode();
-            }
-        }
-
         $this->rewriteFieldStreet($fields);
 
         foreach ($fields as $code => &$field) {
@@ -245,13 +235,13 @@ class LayoutProcessor implements LayoutProcessorInterface
                 if (in_array($code, ['country_id'])) {
                     $field['config']['additionalClasses'] = "mp-hidden";
                     continue;
-                } else if (in_array($code, $oscField)) {
+                } else {
                     unset($fields[$code]);
                 }
             } else {
                 $oriClasses = isset($field['config']['additionalClasses']) ? $field['config']['additionalClasses'] : '';
                 $field['config']['additionalClasses'] = "{$oriClasses} col-mp mp-{$fieldConfig['colspan']}" . ($fieldConfig['isNewRow'] ? ' mp-clear' : '');
-                $field['sortOrder'] = (isset($field['sortOrder']) && !in_array($code, $oscField)) ? $field['sortOrder'] : $fieldConfig['sortOrder'];
+                $field['sortOrder'] = $fieldConfig['sortOrder'];
                 if ($code == 'dob') {
                     $field['options'] = ['yearRange' => '-120y:c+nn', 'maxDate' => '-1d', 'changeMonth' => true, 'changeYear' => true];
                 }
diff --git a/Block/Container.php b/Block/Container.php
index fd74058..46719fd 100644
--- a/Block/Container.php
+++ b/Block/Container.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Design.php b/Block/Design.php
index 4def4fd..f873dd6 100644
--- a/Block/Design.php
+++ b/Block/Design.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Order/Totals.php b/Block/Order/Totals.php
index 518d21e..5e084e0 100644
--- a/Block/Order/Totals.php
+++ b/Block/Order/Totals.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Order/View/Comment.php b/Block/Order/View/Comment.php
index 80fa715..3bb302e 100644
--- a/Block/Order/View/Comment.php
+++ b/Block/Order/View/Comment.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Order/View/DeliveryTime.php b/Block/Order/View/DeliveryTime.php
index 847ffb5..677dbbb 100644
--- a/Block/Order/View/DeliveryTime.php
+++ b/Block/Order/View/DeliveryTime.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Order/View/Survey.php b/Block/Order/View/Survey.php
index adb29a9..ef86a94 100644
--- a/Block/Order/View/Survey.php
+++ b/Block/Order/View/Survey.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/Plugin/Link.php b/Block/Plugin/Link.php
index 483a71d..0556c3a 100644
--- a/Block/Plugin/Link.php
+++ b/Block/Plugin/Link.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Block/StaticBlock.php b/Block/StaticBlock.php
deleted file mode 100644
index 40647c3..0000000
--- a/Block/StaticBlock.php
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
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Block;
-
-use Magento\Checkout\Model\Session as CheckoutSession;
-use Magento\Framework\View\Element\Template;
-use Magento\Framework\View\Element\Template\Context;
-use Mageplaza\Osc\Helper\Data as OscHelper;
-use Mageplaza\Osc\Model\System\Config\Source\StaticBlockPosition;
-use Magento\Cms\Api\BlockRepositoryInterface;
-
-/**
- * Class StaticBlock
- * @package Mageplaza\Osc\Block
- */
-class StaticBlock extends Template
-{
-    /**
-     * @var OscHelper
-     */
-    protected $_oscHelper;
-
-    /**
-     * @type CheckoutSession
-     */
-    private $checkoutSession;
-
-    /**
-     * @var BlockRepositoryInterface
-     */
-    protected $blockRepository;
-
-    /**
-     * StaticBlock constructor.
-     * @param Context $context
-     * @param OscHelper $oscHelper
-     * @param CheckoutSession $checkoutSession
-     * @param BlockRepositoryInterface $blockRepository
-     * @param array $data
-     */
-    public function __construct(
-        Context $context,
-        OscHelper $oscHelper,
-        CheckoutSession $checkoutSession,
-        BlockRepositoryInterface $blockRepository,
-        array $data = []
-    )
-    {
-        parent::__construct($context, $data);
-
-        $this->_oscHelper = $oscHelper;
-        $this->checkoutSession = $checkoutSession;
-        $this->blockRepository = $blockRepository;
-    }
-
-    /**
-     * @return array
-     * @throws \Magento\Framework\Exception\LocalizedException
-     * @throws \Zend_Serializer_Exception
-     */
-    public function getStaticBlock()
-    {
-        $result = [];
-
-        $config = $this->_oscHelper->isEnableStaticBlock() ? $this->_oscHelper->getStaticBlockList() : [];
-        foreach ($config as $key => $row) {
-            /** @var \Magento\Cms\Block\Block $block */
-            $block = $this->getLayout()->createBlock('Magento\Cms\Block\Block')->setBlockId($row['block'])->toHtml();
-            if (($row['position'] == StaticBlockPosition::SHOW_IN_SUCCESS_PAGE && $this->getNameInLayout() == 'osc.static-block.success')
-                || ($row['position'] == StaticBlockPosition::SHOW_AT_TOP_CHECKOUT_PAGE && $this->getNameInLayout() == 'osc.static-block.top')
-                || ($row['position'] == StaticBlockPosition::SHOW_AT_BOTTOM_CHECKOUT_PAGE && $this->getNameInLayout() == 'osc.static-block.bottom')) {
-                $result[] = [
-                    'content' => $block,
-                    'sortOrder' => $row['sort_order']
-                ];
-            }
-        }
-
-        usort($result, function ($a, $b) {
-            return ($a['sortOrder'] <= $b['sortOrder']) ? -1 : 1;
-        });
-
-        return $result;
-    }
-}
diff --git a/Block/Survey.php b/Block/Survey.php
index d3b5f5a..36f6cdd 100644
--- a/Block/Survey.php
+++ b/Block/Survey.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Controller/Add/Index.php b/Controller/Add/Index.php
index fe7036b..ebf6622 100644
--- a/Controller/Add/Index.php
+++ b/Controller/Add/Index.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Controller/Adminhtml/Field/Position.php b/Controller/Adminhtml/Field/Position.php
index d87ad89..f733dba 100644
--- a/Controller/Adminhtml/Field/Position.php
+++ b/Controller/Adminhtml/Field/Position.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Controller/Adminhtml/Field/Save.php b/Controller/Adminhtml/Field/Save.php
index 0bba444..cebba66 100644
--- a/Controller/Adminhtml/Field/Save.php
+++ b/Controller/Adminhtml/Field/Save.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Controller/Adminhtml/System/Config/Geoip.php b/Controller/Adminhtml/System/Config/Geoip.php
index 24fb72c..4248886 100644
--- a/Controller/Adminhtml/System/Config/Geoip.php
+++ b/Controller/Adminhtml/System/Config/Geoip.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Controller/Index/Index.php b/Controller/Index/Index.php
index d5dcfb3..6bfb8cc 100644
--- a/Controller/Index/Index.php
+++ b/Controller/Index/Index.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Controller/Survey/Save.php b/Controller/Survey/Save.php
index bfb4e7d..c9d448f 100644
--- a/Controller/Survey/Save.php
+++ b/Controller/Survey/Save.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Helper/Address.php b/Helper/Address.php
index 76ae393..542c13f 100644
--- a/Helper/Address.php
+++ b/Helper/Address.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Helper/Data.php b/Helper/Data.php
index 5399196..921f35e 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -38,9 +38,6 @@ class Data extends AbstractData
     /** Design configuration path */
     const CONFIG_PATH_DESIGN = 'design_configuration';
 
-    /** CMS Static Block configuration path */
-    const CONFIG_PATH_BLOCK = 'block_configuration';
-
     /** Geo configuration path */
     const CONFIG_PATH_GEOIP = 'geoip_configuration';
 
@@ -300,17 +297,6 @@ class Data extends AbstractData
     }
 
     /**
-     * Item list toggle will be shown if this function return 'true'
-     *
-     * @param null $store
-     * @return bool
-     */
-    public function isShowItemListToggle($store = null)
-    {
-        return !!$this->getDisplayConfig('is_show_item_list_toggle', $store);
-    }
-
-    /**
      * Product image will be hided if this function return 'true'
      *
      * @param null $store
@@ -621,38 +607,6 @@ class Data extends AbstractData
         return $this->getDesignConfig('page_design') == 'material' ? true : false;
     }
 
-    /***************************** CMS Static Block Configuration *****************************
-     *
-     * @param string $code
-     * @param null $store
-     * @return mixed
-     */
-    public function getStaticBlockConfig($code = '', $store = null)
-    {
-        $code = $code ? self::CONFIG_PATH_BLOCK . '/' . $code : self::CONFIG_PATH_BLOCK;
-
-        return $this->getModuleConfig($code, $store);
-    }
-
-    /**
-     * @param null $store
-     * @return bool
-     */
-    public function isEnableStaticBlock($store = null)
-    {
-        return !!$this->getStaticBlockConfig('is_enabled_block', $store);
-    }
-
-    /**
-     * @param null $stores
-     * @return mixed
-     * @throws \Zend_Serializer_Exception
-     */
-    public function getStaticBlockList($stores = null)
-    {
-        return $this->unserialize($this->getStaticBlockConfig('list', $stores));
-    }
-
     /***************************** GeoIP Configuration *****************************
      *
      * @param null $store
diff --git a/LICENSE b/LICENSE
index 87b119f..dec3ab0 100644
--- a/LICENSE
+++ b/LICENSE
@@ -1,4 +1,4 @@
-Copyright © 2016-present Mageplaza Co. Ltd.
+Mageplaza Co. Ltd.
 
 This License is entered by Mageplaza to govern the usage or redistribution of Mageplaza software. This is a legal agreement between you (either an individual or a single entity) and Mageplaza for Mageplaza software product(s) which may include extensions, templates and services.
 
@@ -30,4 +30,4 @@ The Agreement becomes effective at the moment when you acquire software from our
 
     6. LIMITATION OF LIABILITY: In no event shall Mageplaza be liable for any damages (including, without limitation, lost profits, business interruption, or lost information) rising out of ‘Authorized Users’ use of or inability to use the Mageplaza products, even if Mageplaza has been advised of the possibility of such damages. In no event will Mageplaza be liable for prosecution arising from use of the Software against law or for any illegal use.
 
-The latest License: https://www.mageplaza.com/LICENSE.txt
\ No newline at end of file
+The latest License : https://www.mageplaza.com/LICENSE.txt
\ No newline at end of file
diff --git a/Model/AgreementsValidator.php b/Model/AgreementsValidator.php
index d58cb74..44294cf 100644
--- a/Model/AgreementsValidator.php
+++ b/Model/AgreementsValidator.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/CheckoutManagement.php b/Model/CheckoutManagement.php
index e9da7d1..df70a5c 100644
--- a/Model/CheckoutManagement.php
+++ b/Model/CheckoutManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/CheckoutRegister.php b/Model/CheckoutRegister.php
index a42bb1e..f2330f7 100644
--- a/Model/CheckoutRegister.php
+++ b/Model/CheckoutRegister.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/DefaultConfigProvider.php b/Model/DefaultConfigProvider.php
index f377bbd..b9345bd 100644
--- a/Model/DefaultConfigProvider.php
+++ b/Model/DefaultConfigProvider.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -32,7 +32,6 @@ use Magento\Quote\Api\PaymentMethodManagementInterface;
 use Magento\Quote\Api\ShippingMethodManagementInterface;
 use Magento\Quote\Model\Quote\Item;
 use Mageplaza\Osc\Helper\Data as OscHelper;
-use Magento\Cms\Block\Block;
 
 /**
  * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
@@ -81,11 +80,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
     protected $stockRegistry;
 
     /**
-     * @var Block
-     */
-    protected $cmsBlock;
-
-    /**
      * DefaultConfigProvider constructor.
      * @param CheckoutSession $checkoutSession
      * @param PaymentMethodManagementInterface $paymentMethodManagement
@@ -95,7 +89,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
      * @param StockRegistryInterface $stockRegistry
      * @param ModuleManager $moduleManager
      * @param OscHelper $oscHelper
-     * @param Block $cmsBlock
      */
     public function __construct(
         CheckoutSession $checkoutSession,
@@ -105,8 +98,7 @@ class DefaultConfigProvider implements ConfigProviderInterface
         QuoteItemRepository $quoteItemRepository,
         StockRegistryInterface $stockRegistry,
         ModuleManager $moduleManager,
-        OscHelper $oscHelper,
-        Block $cmsBlock
+        OscHelper $oscHelper
     )
     {
         $this->checkoutSession           = $checkoutSession;
@@ -117,7 +109,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
         $this->stockRegistry             = $stockRegistry;
         $this->moduleManager             = $moduleManager;
         $this->_oscHelper                = $oscHelper;
-        $this->cmsBlock                  = $cmsBlock;
     }
 
     /**
@@ -143,8 +134,6 @@ class DefaultConfigProvider implements ConfigProviderInterface
 
     /**
      * @return array
-     * @throws \Magento\Framework\Exception\LocalizedException
-     * @throws \Zend_Serializer_Exception
      */
     private function getOscConfig()
     {
@@ -181,43 +170,11 @@ class DefaultConfigProvider implements ConfigProviderInterface
                 'isEnableModulePostNL' => $this->_oscHelper->isEnableModulePostNL(),
             ],
             'show_toc'                => $this->_oscHelper->getShowTOC(),
-            'qtyIncrements'           => $this->getItemQtyIncrement(),
-            'staticBlock'             => $this->getStaticBlock(),
-            'isShowItemListToggle'    => $this->_oscHelper->isShowItemListToggle()
+            'qtyIncrements'           => $this->getItemQtyIncrement()
         ];
     }
 
     /**
-     * Return array of static blocks
-     *
-     * @return array
-     * @throws \Magento\Framework\Exception\LocalizedException
-     * @throws \Zend_Serializer_Exception
-     */
-    public function getStaticBlock()
-    {
-        $result = [];
-
-        $config = $this->_oscHelper->isEnableStaticBlock() ? $this->_oscHelper->getStaticBlockList() : [];
-        foreach ($config as $key => $row) {
-            /** @var \Magento\Cms\Block\Block $block */
-            $block = $this->cmsBlock->setBlockId($row['block'])->toHtml();
-            if ($row['position'] == \Mageplaza\Osc\Model\System\Config\Source\StaticBlockPosition::SHOW_UNDER_CHECKOUT_BUTTON) {
-                $result[] = [
-                    'content' => $block,
-                    'sortOrder' => $row['sort_order']
-                ];
-            }
-        }
-
-        usort($result, function ($a, $b) {
-            return ($a['sortOrder'] <= $b['sortOrder']) ? -1 : 1;
-        });
-
-        return $result;
-    }
-
-    /**
      * Returns array of payment methods
      *
      * @return array
diff --git a/Model/GuestCheckoutManagement.php b/Model/GuestCheckoutManagement.php
index 1fc0cbf..aade427 100644
--- a/Model/GuestCheckoutManagement.php
+++ b/Model/GuestCheckoutManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/OscDetails.php b/Model/OscDetails.php
index 4653c0f..4becddb 100644
--- a/Model/OscDetails.php
+++ b/Model/OscDetails.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Authorization/UserContext.php b/Model/Plugin/Authorization/UserContext.php
index c487c2a..2d53a2c 100644
--- a/Model/Plugin/Authorization/UserContext.php
+++ b/Model/Plugin/Authorization/UserContext.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Checkout/ShippingMethodManagement.php b/Model/Plugin/Checkout/ShippingMethodManagement.php
index 75d89d9..fd778df 100644
--- a/Model/Plugin/Checkout/ShippingMethodManagement.php
+++ b/Model/Plugin/Checkout/ShippingMethodManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Customer/AccountManagement.php b/Model/Plugin/Customer/AccountManagement.php
index 5775527..1656828 100644
--- a/Model/Plugin/Customer/AccountManagement.php
+++ b/Model/Plugin/Customer/AccountManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Customer/Address.php b/Model/Plugin/Customer/Address.php
index c894748..5f632ef 100644
--- a/Model/Plugin/Customer/Address.php
+++ b/Model/Plugin/Customer/Address.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Eav/Model/Validator/Attribute/Data.php b/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
index e6adc42..a637712 100644
--- a/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
+++ b/Model/Plugin/Eav/Model/Validator/Attribute/Data.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Paypal/Model/Express.php b/Model/Plugin/Paypal/Model/Express.php
index fd48443..3e5930e 100644
--- a/Model/Plugin/Paypal/Model/Express.php
+++ b/Model/Plugin/Paypal/Model/Express.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Quote/GiftWrap.php b/Model/Plugin/Quote/GiftWrap.php
index 72da5fd..10fbeef 100644
--- a/Model/Plugin/Quote/GiftWrap.php
+++ b/Model/Plugin/Quote/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Plugin/Quote/Processor.php b/Model/Plugin/Quote/Processor.php
deleted file mode 100644
index 96ec0d1..0000000
--- a/Model/Plugin/Quote/Processor.php
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
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model\Plugin\Quote;
-
-use \Magento\Catalog\Model\Product;
-use Magento\Quote\Model\Quote\ItemFactory;
-use Magento\Quote\Model\Quote\Item;
-use Magento\Framework\DataObject;
-use Magento\Quote\Api\Data\CartItemInterface;
-
-/**
- * Class Address
- * @package Mageplaza\Osc\Model\Plugin\Customer
- */
-class Processor
-{
-    /**
-     * @var \Magento\CatalogInventory\Api\StockStateInterface
-     */
-    protected $_stockState;
-
-    /**
-     * @param \Magento\CatalogInventory\Api\StockStateInterface $stockState
-     */
-    public function __construct(
-        \Magento\CatalogInventory\Api\StockStateInterface $stockState
-    )
-    {
-        $this->_stockState = $stockState;
-    }
-
-    /**
-     * Set qty and custom price for quote item
-     *
-     * @param \Magento\Quote\Model\Quote\Item\Processor $subject
-     * @param \Closure $proceed
-     * @param Item $item
-     * @param \Magento\Framework\DataObject $request
-     * @param Product $candidate
-     * @return void
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    public function aroundPrepare(
-        \Magento\Quote\Model\Quote\Item\Processor $subject,
-        \Closure $proceed,
-        Item $item,
-        DataObject $request,
-        Product $candidate
-    )
-    {
-        if ($this->_stockState->getStockQty($candidate->getId()) == 0 ||
-            $this->_stockState->getStockQty($candidate->getId()) == $candidate->getCartQty()) {
-
-            /**
-             * We specify qty after we know about parent (for stock)
-             */
-            if ($request->getResetCount() && !$candidate->getStickWithinParent() && $item->getId() == $request->getId()) {
-                $item->setData(CartItemInterface::KEY_QTY, 0);
-            }
-            $item->setQty($candidate->getCartQty());
-
-            $customPrice = $request->getCustomPrice();
-            if (!empty($customPrice)) {
-                $item->setCustomPrice($customPrice);
-                $item->setOriginalCustomPrice($customPrice);
-            }
-        } else {
-            $proceed($item, $request, $candidate);
-        }
-    }
-}
diff --git a/Model/Plugin/Quote/QuoteManagement.php b/Model/Plugin/Quote/QuoteManagement.php
index 9998144..bd67556 100644
--- a/Model/Plugin/Quote/QuoteManagement.php
+++ b/Model/Plugin/Quote/QuoteManagement.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/AddressSuggest.php b/Model/System/Config/Source/AddressSuggest.php
index de9fa1e..726cefe 100644
--- a/Model/System/Config/Source/AddressSuggest.php
+++ b/Model/System/Config/Source/AddressSuggest.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/CheckboxStyle.php b/Model/System/Config/Source/CheckboxStyle.php
index 777e773..77846a2 100644
--- a/Model/System/Config/Source/CheckboxStyle.php
+++ b/Model/System/Config/Source/CheckboxStyle.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/ComponentPosition.php b/Model/System/Config/Source/ComponentPosition.php
index f811702..e0d5a29 100644
--- a/Model/System/Config/Source/ComponentPosition.php
+++ b/Model/System/Config/Source/ComponentPosition.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/DeliveryTime.php b/Model/System/Config/Source/DeliveryTime.php
index 51aa972..a175f1a 100644
--- a/Model/System/Config/Source/DeliveryTime.php
+++ b/Model/System/Config/Source/DeliveryTime.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/Design.php b/Model/System/Config/Source/Design.php
index 3dfbb18..df366a2 100644
--- a/Model/System/Config/Source/Design.php
+++ b/Model/System/Config/Source/Design.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/Giftwrap.php b/Model/System/Config/Source/Giftwrap.php
index b7e7cfe..4d9d77d 100644
--- a/Model/System/Config/Source/Giftwrap.php
+++ b/Model/System/Config/Source/Giftwrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/Layout.php b/Model/System/Config/Source/Layout.php
index 6da9505..9b39843 100644
--- a/Model/System/Config/Source/Layout.php
+++ b/Model/System/Config/Source/Layout.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -29,7 +29,6 @@ class Layout
 {
     const ONE_COLUMN = '1column';
     const TWO_COLUMNS = '2columns';
-    const TWO_COLUMNS_FLOATING = '2columns-floating';
     const THREE_COLUMNS = '3columns';
     const THREE_COLUMNS_WITH_COLSPAN = '3columns-colspan';
 
@@ -48,10 +47,6 @@ class Layout
                 'value' => self::TWO_COLUMNS
             ],
             [
-                'label' => __('2 Columns With Floating Column'),
-                'value' => self::TWO_COLUMNS_FLOATING
-            ],
-            [
                 'label' => __('3 Columns'),
                 'value' => self::THREE_COLUMNS
             ],
diff --git a/Model/System/Config/Source/PaymentMethods.php b/Model/System/Config/Source/PaymentMethods.php
index 7f3d351..b855dca 100644
--- a/Model/System/Config/Source/PaymentMethods.php
+++ b/Model/System/Config/Source/PaymentMethods.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/RadioStyle.php b/Model/System/Config/Source/RadioStyle.php
index 67d4e82..7a14e23 100644
--- a/Model/System/Config/Source/RadioStyle.php
+++ b/Model/System/Config/Source/RadioStyle.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/ShippingMethods.php b/Model/System/Config/Source/ShippingMethods.php
index 768a84f..d562d69 100644
--- a/Model/System/Config/Source/ShippingMethods.php
+++ b/Model/System/Config/Source/ShippingMethods.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/System/Config/Source/StaticBlockPosition.php b/Model/System/Config/Source/StaticBlockPosition.php
deleted file mode 100644
index 6b6aa5c..0000000
--- a/Model/System/Config/Source/StaticBlockPosition.php
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
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\Osc\Model\System\Config\Source;
-
-use Magento\Framework\Model\AbstractModel;
-
-/**
- * Class StaticBlockPosition
- * @package Mageplaza\Osc\Model\System\Config\Source
- */
-class StaticBlockPosition extends AbstractModel
-{
-    const NOT_SHOW = 0;
-    const SHOW_IN_SUCCESS_PAGE = 1;
-    const SHOW_AT_TOP_CHECKOUT_PAGE = 2;
-    const SHOW_AT_BOTTOM_CHECKOUT_PAGE = 3;
-    const SHOW_UNDER_CHECKOUT_BUTTON = 4;
-
-    /**
-     * @return array
-     */
-    public function toOptionArray()
-    {
-        return [
-            self::NOT_SHOW => __('None'),
-            self::SHOW_IN_SUCCESS_PAGE => __('In Success Page'),
-            self::SHOW_AT_TOP_CHECKOUT_PAGE => __('At Top of Checkout Page'),
-            self::SHOW_AT_BOTTOM_CHECKOUT_PAGE => __('At Bottom of Checkout Page'),
-            self::SHOW_UNDER_CHECKOUT_BUTTON => __('Under Checkout Button')
-        ];
-    }
-}
\ No newline at end of file
diff --git a/Model/System/Config/Source/Survey.php b/Model/System/Config/Source/Survey.php
index 5e8cd11..b6606b6 100644
--- a/Model/System/Config/Source/Survey.php
+++ b/Model/System/Config/Source/Survey.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Total/Creditmemo/GiftWrap.php b/Model/Total/Creditmemo/GiftWrap.php
index 01c1dc9..ed68d57 100644
--- a/Model/Total/Creditmemo/GiftWrap.php
+++ b/Model/Total/Creditmemo/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Total/Invoice/GiftWrap.php b/Model/Total/Invoice/GiftWrap.php
index 803b16e..b1394df 100644
--- a/Model/Total/Invoice/GiftWrap.php
+++ b/Model/Total/Invoice/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Model/Total/Quote/GiftWrap.php b/Model/Total/Quote/GiftWrap.php
index f1b3aa3..54e9946 100644
--- a/Model/Total/Quote/GiftWrap.php
+++ b/Model/Total/Quote/GiftWrap.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Observer/IsAllowedGuestCheckoutObserver.php b/Observer/IsAllowedGuestCheckoutObserver.php
index 0d9df5d..4de52d5 100644
--- a/Observer/IsAllowedGuestCheckoutObserver.php
+++ b/Observer/IsAllowedGuestCheckoutObserver.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Observer/OscConfigObserver.php b/Observer/OscConfigObserver.php
index 5fec7af..baaae66 100644
--- a/Observer/OscConfigObserver.php
+++ b/Observer/OscConfigObserver.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Observer/PaypalExpressPlaceOrder.php b/Observer/PaypalExpressPlaceOrder.php
index 03dc725..be83cb5 100644
--- a/Observer/PaypalExpressPlaceOrder.php
+++ b/Observer/PaypalExpressPlaceOrder.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Observer/QuoteSubmitBefore.php b/Observer/QuoteSubmitBefore.php
index 5a41b6c..18ac0fa 100644
--- a/Observer/QuoteSubmitBefore.php
+++ b/Observer/QuoteSubmitBefore.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Observer/QuoteSubmitSuccess.php b/Observer/QuoteSubmitSuccess.php
index 02f9d75..bb832f5 100644
--- a/Observer/QuoteSubmitSuccess.php
+++ b/Observer/QuoteSubmitSuccess.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -83,7 +83,7 @@ class QuoteSubmitSuccess implements ObserverInterface
      * @param \Magento\Framework\Message\ManagerInterface $messageManager
      * @param \Magento\Customer\Model\Session $customerSession
      * @param \Magento\Newsletter\Model\SubscriberFactory $subscriberFactory
-     * @param CustomerManagement $customerManagement
+     * @param CustomerManagement $subscriberFactory
      */
     public function __construct(
         Session $checkoutSession,
@@ -118,7 +118,7 @@ class QuoteSubmitSuccess implements ObserverInterface
         if (isset($oscData['register']) && $oscData['register']
             && isset($oscData['password']) && $oscData['password']
         ) {
-            $customer = $this->customerManagement->create($order->getId());
+           $customer = $this->customerManagement->create($order->getId());
 
             /* Set customer Id for address */
             if ($customer->getId()) {
diff --git a/Observer/RedirectToOneStepCheckout.php b/Observer/RedirectToOneStepCheckout.php
index 13af532..f514f04 100644
--- a/Observer/RedirectToOneStepCheckout.php
+++ b/Observer/RedirectToOneStepCheckout.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Setup/InstallData.php b/Setup/InstallData.php
index d2a93f1..cca4ee5 100644
--- a/Setup/InstallData.php
+++ b/Setup/InstallData.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/Setup/UpgradeData.php b/Setup/UpgradeData.php
index 5ff35b7..75d1b5e 100644
--- a/Setup/UpgradeData.php
+++ b/Setup/UpgradeData.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -27,7 +27,6 @@ use Magento\Framework\Setup\ModuleDataSetupInterface;
 use Magento\Framework\Setup\UpgradeDataInterface;
 use Magento\Quote\Setup\QuoteSetupFactory;
 use Magento\Sales\Setup\SalesSetupFactory;
-use Magento\Cms\Model\BlockFactory;
 
 /**
  * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
@@ -46,25 +45,16 @@ class UpgradeData implements UpgradeDataInterface
     protected $salesSetupFactory;
 
     /**
-     * @var BlockFactory
-     */
-    protected $blockFactory;
-
-    /**
      * @param QuoteSetupFactory $quoteSetupFactory
      * @param SalesSetupFactory $salesSetupFactory
-     * @param BlockFactory $blockFactory
      */
     public function __construct(
         QuoteSetupFactory $quoteSetupFactory,
-        SalesSetupFactory $salesSetupFactory,
-        BlockFactory $blockFactory
+        SalesSetupFactory $salesSetupFactory
     )
     {
         $this->quoteSetupFactory = $quoteSetupFactory;
         $this->salesSetupFactory = $salesSetupFactory;
-        $this->blockFactory      = $blockFactory;
-
     }
 
     /**
@@ -109,54 +99,7 @@ class UpgradeData implements UpgradeDataInterface
         if (version_compare($context->getVersion(), '2.1.3') < 0) {
             $salesInstaller->addAttribute('order', 'osc_order_house_security_code', ['type' => Table::TYPE_TEXT, 'visible' => false]);
         }
-        if (version_compare($context->getVersion(), '2.1.4') < 0) {
-            $this->insertBlock($setup);
-        }
 
         $setup->endSetup();
     }
-
-    /**
-     * @param ModuleDataSetupInterface $setup
-     * @return $this
-     */
-    public function insertBlock($setup)
-    {
-        $blocks = $this->getDataBlock();
-        $blockFactory = $this->blockFactory->create();
-        foreach ($blocks as $block) {
-            $setup->getConnection()->delete($setup->getTable('cms_block'), ['identifier = ?' => $block['identifier']]);
-            $blockFactory->load($block['identifier'], 'identifier')->setData($block)->save();
-        }
-
-        return $this;
-    }
-
-    /**
-     * @return array
-     */
-    public function getDataBlock()
-    {
-        $sealContent  = '
-            <div class="osc-trust-seals" style="text-align: center;">
-                <div class="trust-seals-badges">
-                    <a href="https://en.wikipedia.org/wiki/Trust_seal" target="_blank">
-                        <img src="{{view url=Mageplaza_Osc/css/images/seal.png}}">
-                    </a>
-                </div>
-                <div class="trust-seals-text">
-                    <p>This is a demonstration of trust badge. Please contact your SSL or Security provider to have trust badges embed properly</p>
-                </div>
-            </div>';
-
-        return [
-            [
-                'title'      => __('One Step Checkout Seal Content'),
-                'identifier' => 'osc-seal-content',
-                'content'    => $sealContent,
-                'stores'     => [0],
-                'is_active'  => 1
-            ]
-        ];
-    }
 }
diff --git a/composer.json b/composer.json
index 33317ab..9c516dc 100644
--- a/composer.json
+++ b/composer.json
@@ -2,11 +2,11 @@
   "name": "mageplaza/magento-2-one-step-checkout-extension",
   "description": "Magento 2 One Step Checkout",
   "require": {
-    "mageplaza/module-core": "^1.3.12",
+    "mageplaza/module-core": "^1.3.11",
     "geoip2/geoip2": "~2.0"
   },
   "type": "magento2-module",
-  "version": "2.5.0",
+  "version": "2.4.5",
   "license": "proprietary",
   "authors": [
     {
diff --git a/etc/acl.xml b/etc/acl.xml
index 09b90cd..46e2dca 100644
--- a/etc/acl.xml
+++ b/etc/acl.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/di.xml b/etc/adminhtml/di.xml
index 0401f13..d2fab1b 100644
--- a/etc/adminhtml/di.xml
+++ b/etc/adminhtml/di.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/events.xml b/etc/adminhtml/events.xml
index d2ff0e1..b7412b1 100644
--- a/etc/adminhtml/events.xml
+++ b/etc/adminhtml/events.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index da3c578..dc14b96 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/routes.xml b/etc/adminhtml/routes.xml
index f3f9f6f..1d57e5e 100644
--- a/etc/adminhtml/routes.xml
+++ b/etc/adminhtml/routes.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index b360b21..72f727f 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -117,20 +117,12 @@
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>Yes</strong> to show a link for visitors to login.]]></comment>
                 </field>
-                <field id="is_enabled_review_cart_section" translate="label comment" sortOrder="4" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_enabled_review_cart_section" translate="label comment" sortOrder="5" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Order Review Section</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <comment><![CDATA[Select <strong>No</strong> to remove the Order Review section. The section is displayed by default.]]></comment>
                 </field>
-                <field id="is_show_item_list_toggle" translate="label comment" sortOrder="6" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
-                    <label>Show Product List Toggle</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                    <depends>
-                        <field id="is_enabled_review_cart_section">1</field>
-                    </depends>
-                    <comment><![CDATA[Select <strong>Yes</strong> to show product list toggle.]]></comment>
-                </field>
-                <field id="is_show_product_image" translate="label comment" sortOrder="8" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
+                <field id="is_show_product_image" translate="label comment" sortOrder="6" type="select" showInDefault="1" showInWebsite="1" showInStore="1" canRestore="1">
                     <label>Show Product Thumbnail Image</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                     <depends>
@@ -319,24 +311,7 @@
                     <comment><![CDATA[Example: .step-title{background-color: #1979c3;}]]></comment>
                 </field>
             </group>
-            <group id="block_configuration" translate="label comment" sortOrder="40" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
-                <label>Static CMS Block Configuration</label>
-                <field id="is_enabled_block" translate="label comment" sortOrder="10" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Enable Static CMS Block</label>
-                    <comment><![CDATA[Select <strong>Yes</strong> to enable Static CMS Block.]]></comment>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="list" translate="label comment" type="select" sortOrder="20" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Show Static Block</label>
-                    <frontend_model>Mageplaza\Osc\Block\Adminhtml\Config\Backend\StaticBlock</frontend_model>
-                    <backend_model>Magento\Config\Model\Config\Backend\Serialized\ArraySerialized</backend_model>
-                    <comment>Sort Order is optional. By default, blocks will be arranged sequentially</comment>
-                    <depends>
-                        <field id="is_enabled_block">1</field>
-                    </depends>
-                </field>
-            </group>
-            <group id="geoip_configuration" translate="label comment" sortOrder="50" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
+            <group id="geoip_configuration" translate="label comment" sortOrder="40" type="text" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>GeoIP Configuration</label>
                 <field id="is_enable_geoip" translate="label comment" sortOrder="1" type="select" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Enable GeoIP</label>
diff --git a/etc/config.xml b/etc/config.xml
index 0d87a58..a4499e6 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -36,7 +36,6 @@
             <display_configuration>
                 <is_enabled_login_link>1</is_enabled_login_link>
                 <is_enabled_review_cart_section>1</is_enabled_review_cart_section>
-                <is_show_item_list_toggle>1</is_show_item_list_toggle>
                 <is_show_product_image>1</is_show_product_image>
                 <show_coupon>1</show_coupon>
                 <is_enabled_comments>1</is_enabled_comments>
diff --git a/etc/di.xml b/etc/di.xml
index 91fcd3b..49e5f0e 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/events.xml b/etc/events.xml
index 0fd794e..fc836f6 100644
--- a/etc/events.xml
+++ b/etc/events.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/extension_attributes.xml b/etc/extension_attributes.xml
index a73ff3b..94e0cf9 100644
--- a/etc/extension_attributes.xml
+++ b/etc/extension_attributes.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index 9abd191..af210d4 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -62,8 +62,4 @@
     <type name="Magento\Eav\Model\Validator\Attribute\Data">
         <plugin name="mz_osc_validator" type="Mageplaza\Osc\Model\Plugin\Eav\Model\Validator\Attribute\Data"/>
     </type>
-
-    <type name="Magento\Quote\Model\Quote\Item\Processor">
-        <plugin name="oscCheckProductQty" type="Mageplaza\Osc\Model\Plugin\Quote\Processor"/>
-    </type>
 </config>
\ No newline at end of file
diff --git a/etc/frontend/events.xml b/etc/frontend/events.xml
index f1e28a1..aa41176 100644
--- a/etc/frontend/events.xml
+++ b/etc/frontend/events.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/frontend/routes.xml b/etc/frontend/routes.xml
index 7c32629..d8c85b7 100644
--- a/etc/frontend/routes.xml
+++ b/etc/frontend/routes.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/frontend/sections.xml b/etc/frontend/sections.xml
index e3ed6a9..ed1c35f 100644
--- a/etc/frontend/sections.xml
+++ b/etc/frontend/sections.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/module.xml b/etc/module.xml
index 7c1ed70..150582e 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -16,12 +16,12 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
-    <module name="Mageplaza_Osc" setup_version="2.1.4">
+    <module name="Mageplaza_Osc" setup_version="2.1.3">
         <sequence>
             <module name="Mageplaza_Core"/>
             <module name="Magento_Checkout"/>
diff --git a/etc/sales.xml b/etc/sales.xml
index 27b1d31..ba84a69 100644
--- a/etc/sales.xml
+++ b/etc/sales.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/webapi.xml b/etc/webapi.xml
index 11ba58d..31289e7 100644
--- a/etc/webapi.xml
+++ b/etc/webapi.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/webapi_rest/di.xml b/etc/webapi_rest/di.xml
index 9f47319..2f17660 100644
--- a/etc/webapi_rest/di.xml
+++ b/etc/webapi_rest/di.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/registration.php b/registration.php
index 309438b..9eb2916 100644
--- a/registration.php
+++ b/registration.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/layout/onestepcheckout_field_position.xml b/view/adminhtml/layout/onestepcheckout_field_position.xml
index 197ecb0..0d7c71c 100644
--- a/view/adminhtml/layout/onestepcheckout_field_position.xml
+++ b/view/adminhtml/layout/onestepcheckout_field_position.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_creditmemo_new.xml b/view/adminhtml/layout/sales_order_creditmemo_new.xml
index b54a4f9..1fb99fa 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_new.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_new.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml b/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
index b54a4f9..1fb99fa 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_updateqty.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_creditmemo_view.xml b/view/adminhtml/layout/sales_order_creditmemo_view.xml
index b54a4f9..1fb99fa 100644
--- a/view/adminhtml/layout/sales_order_creditmemo_view.xml
+++ b/view/adminhtml/layout/sales_order_creditmemo_view.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_invoice_email.xml b/view/adminhtml/layout/sales_order_invoice_email.xml
index a11d47d..89e5644 100644
--- a/view/adminhtml/layout/sales_order_invoice_email.xml
+++ b/view/adminhtml/layout/sales_order_invoice_email.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_invoice_new.xml b/view/adminhtml/layout/sales_order_invoice_new.xml
index a11d47d..89e5644 100644
--- a/view/adminhtml/layout/sales_order_invoice_new.xml
+++ b/view/adminhtml/layout/sales_order_invoice_new.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_invoice_print.xml b/view/adminhtml/layout/sales_order_invoice_print.xml
index a11d47d..89e5644 100644
--- a/view/adminhtml/layout/sales_order_invoice_print.xml
+++ b/view/adminhtml/layout/sales_order_invoice_print.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_invoice_updateqty.xml b/view/adminhtml/layout/sales_order_invoice_updateqty.xml
index a11d47d..89e5644 100644
--- a/view/adminhtml/layout/sales_order_invoice_updateqty.xml
+++ b/view/adminhtml/layout/sales_order_invoice_updateqty.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_invoice_view.xml b/view/adminhtml/layout/sales_order_invoice_view.xml
index a11d47d..89e5644 100644
--- a/view/adminhtml/layout/sales_order_invoice_view.xml
+++ b/view/adminhtml/layout/sales_order_invoice_view.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/layout/sales_order_view.xml b/view/adminhtml/layout/sales_order_view.xml
index 88340ff..eb8ea00 100644
--- a/view/adminhtml/layout/sales_order_view.xml
+++ b/view/adminhtml/layout/sales_order_view.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/adminhtml/templates/field/position.phtml b/view/adminhtml/templates/field/position.phtml
index 521e7fe..b5fc3f5 100644
--- a/view/adminhtml/templates/field/position.phtml
+++ b/view/adminhtml/templates/field/position.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/adminhtml/templates/order/additional.phtml b/view/adminhtml/templates/order/additional.phtml
index 25e7429..30924b9 100644
--- a/view/adminhtml/templates/order/additional.phtml
+++ b/view/adminhtml/templates/order/additional.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/comment.phtml b/view/adminhtml/templates/order/view/comment.phtml
index 7da9737..d698996 100644
--- a/view/adminhtml/templates/order/view/comment.phtml
+++ b/view/adminhtml/templates/order/view/comment.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/delivery-time.phtml b/view/adminhtml/templates/order/view/delivery-time.phtml
index c630bba..fb6212f 100644
--- a/view/adminhtml/templates/order/view/delivery-time.phtml
+++ b/view/adminhtml/templates/order/view/delivery-time.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/order/view/survey.phtml b/view/adminhtml/templates/order/view/survey.phtml
index 4d7d41e..7703338 100644
--- a/view/adminhtml/templates/order/view/survey.phtml
+++ b/view/adminhtml/templates/order/view/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/templates/system/config/geoip.phtml b/view/adminhtml/templates/system/config/geoip.phtml
index a547ace..0ba0b48 100644
--- a/view/adminhtml/templates/system/config/geoip.phtml
+++ b/view/adminhtml/templates/system/config/geoip.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/adminhtml/web/css/source/_module.less b/view/adminhtml/web/css/source/_module.less
index 5292163..1a047e0 100644
--- a/view/adminhtml/web/css/source/_module.less
+++ b/view/adminhtml/web/css/source/_module.less
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/web/css/style.css b/view/adminhtml/web/css/style.css
index 7466330..7bb484e 100644
--- a/view/adminhtml/web/css/style.css
+++ b/view/adminhtml/web/css/style.css
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/base/web/css/images/seal.png b/view/base/web/css/images/seal.png
deleted file mode 100644
index 4fb356b..0000000
Binary files a/view/base/web/css/images/seal.png and /dev/null differ
diff --git a/view/frontend/layout/checkout_onepage_success.xml b/view/frontend/layout/checkout_onepage_success.xml
index 0eb6157..f2a6b50 100644
--- a/view/frontend/layout/checkout_onepage_success.xml
+++ b/view/frontend/layout/checkout_onepage_success.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -27,7 +27,6 @@
     <body>
         <referenceContainer name="content">
             <block class="Mageplaza\Osc\Block\Survey" name="osc.survey" template="Mageplaza_Osc::onepage/success/survey.phtml"/>
-            <block class="Mageplaza\Osc\Block\StaticBlock" name="osc.static-block.success" template="static-block.phtml"/>
         </referenceContainer>
     </body>
 </page>
diff --git a/view/frontend/layout/onestepcheckout_index_index.xml b/view/frontend/layout/onestepcheckout_index_index.xml
index f14be20..57ec276 100644
--- a/view/frontend/layout/onestepcheckout_index_index.xml
+++ b/view/frontend/layout/onestepcheckout_index_index.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -30,8 +30,6 @@
     <body>
         <referenceBlock name="content">
             <block class="Mageplaza\Osc\Block\Checkout\CompatibleConfig" name="mageplaza.osc.compatible-config" before="checkout.root"/>
-            <block class="Mageplaza\Osc\Block\StaticBlock" name="osc.static-block.top" template="static-block.phtml" before="checkout.root"/>
-            <block class="Mageplaza\Osc\Block\StaticBlock" name="osc.static-block.bottom" template="static-block.phtml" after="checkout.root"/>
         </referenceBlock>
         <referenceBlock name="checkout.root">
             <arguments>
diff --git a/view/frontend/layout/sales_email_order_creditmemo_items.xml b/view/frontend/layout/sales_email_order_creditmemo_items.xml
index aac6167..441cd90 100644
--- a/view/frontend/layout/sales_email_order_creditmemo_items.xml
+++ b/view/frontend/layout/sales_email_order_creditmemo_items.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_email_order_invoice_items.xml b/view/frontend/layout/sales_email_order_invoice_items.xml
index 721ec75..67519fb 100644
--- a/view/frontend/layout/sales_email_order_invoice_items.xml
+++ b/view/frontend/layout/sales_email_order_invoice_items.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_email_order_items.xml b/view/frontend/layout/sales_email_order_items.xml
index 358a5e7..172c253 100644
--- a/view/frontend/layout/sales_email_order_items.xml
+++ b/view/frontend/layout/sales_email_order_items.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_order_creditmemo.xml b/view/frontend/layout/sales_order_creditmemo.xml
index aac6167..441cd90 100644
--- a/view/frontend/layout/sales_order_creditmemo.xml
+++ b/view/frontend/layout/sales_order_creditmemo.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_order_invoice.xml b/view/frontend/layout/sales_order_invoice.xml
index 721ec75..67519fb 100644
--- a/view/frontend/layout/sales_order_invoice.xml
+++ b/view/frontend/layout/sales_order_invoice.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_order_print.xml b/view/frontend/layout/sales_order_print.xml
index 71ea2cc..6593d6c 100644
--- a/view/frontend/layout/sales_order_print.xml
+++ b/view/frontend/layout/sales_order_print.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_order_printcreditmemo.xml b/view/frontend/layout/sales_order_printcreditmemo.xml
index aac6167..441cd90 100644
--- a/view/frontend/layout/sales_order_printcreditmemo.xml
+++ b/view/frontend/layout/sales_order_printcreditmemo.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_order_printinvoice.xml b/view/frontend/layout/sales_order_printinvoice.xml
index 721ec75..67519fb 100644
--- a/view/frontend/layout/sales_order_printinvoice.xml
+++ b/view/frontend/layout/sales_order_printinvoice.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
  -->
diff --git a/view/frontend/layout/sales_order_view.xml b/view/frontend/layout/sales_order_view.xml
index 20f98b7..cfc9762 100644
--- a/view/frontend/layout/sales_order_view.xml
+++ b/view/frontend/layout/sales_order_view.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index b35ceda..bcf2dd3 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/templates/description.phtml b/view/frontend/templates/description.phtml
index 7afab35..63e2ea9 100644
--- a/view/frontend/templates/description.phtml
+++ b/view/frontend/templates/description.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/design.phtml b/view/frontend/templates/design.phtml
index 722611a..a634eb0 100644
--- a/view/frontend/templates/design.phtml
+++ b/view/frontend/templates/design.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
@@ -35,9 +35,6 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
     /*===================================================================
     |                            CONFIGUARATION STYLE                    |
     ====================================================================*/
-    <?php if (in_array($design['page_layout'], ['2columns', '2columns-floating'])) { ?>
-    .col-mp.osc-addition-content-wrapper, .col-mp.osc-place-order-wrapper {margin-left: 0; width: 100%;}
-    <?php } ?>
     <?php switch ($design['page_design']): ?><?php case 'flat': ?>
     .checkout-container a.button-action,
     .popup-authentication button.action,
@@ -84,7 +81,6 @@ $placeOrder = '#' . trim ($design['place_order_button'], '#');
             <?php break; ?>
 
             <?php case '2columns': ?>
-            <?php case '2columns-floating': ?>
                 .opc-wrapper .form-login, .opc-wrapper .form-shipping-address {max-width: 100% !important;}.checkout-agreements-block {margin-bottom: 20px !important;  }  .osc-place-order-block .payment-option-inner .control {width:100% !important;}  @media (min-width: 768px), print {  div[data-bind="scope: 'checkout.steps.billing-step'"] {margin-top: 0 !important;  }  .one-step-checkout-container>.mp-6{width: 46% !important;margin: 0px 14px;}  div[data-bind="scope: 'checkout.sidebar'"],div[data-bind="scope: 'checkout.steps.shipping-step'"]{margin-top: 35px;  }  }
                 <?php if($block->isVirtual()){ ?>
                     @media only screen and (max-width:766px){  div[data-bind="scope: 'checkout.steps.shipping-step'"]{margin-top: 0px !important;}}
diff --git a/view/frontend/templates/onepage/compatible-config.phtml b/view/frontend/templates/onepage/compatible-config.phtml
index 9e0ed89..d92707f 100644
--- a/view/frontend/templates/onepage/compatible-config.phtml
+++ b/view/frontend/templates/onepage/compatible-config.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/templates/onepage/success/survey.phtml b/view/frontend/templates/onepage/success/survey.phtml
index 3343aa2..316ea89 100644
--- a/view/frontend/templates/onepage/success/survey.phtml
+++ b/view/frontend/templates/onepage/success/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/order/additional.phtml b/view/frontend/templates/order/additional.phtml
index e7837f1..ddbab50 100644
--- a/view/frontend/templates/order/additional.phtml
+++ b/view/frontend/templates/order/additional.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/templates/order/view/comment.phtml b/view/frontend/templates/order/view/comment.phtml
index 96899d5..d364818 100644
--- a/view/frontend/templates/order/view/comment.phtml
+++ b/view/frontend/templates/order/view/comment.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/order/view/delivery-time.phtml b/view/frontend/templates/order/view/delivery-time.phtml
index 359138b..ae3b255 100644
--- a/view/frontend/templates/order/view/delivery-time.phtml
+++ b/view/frontend/templates/order/view/delivery-time.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/order/view/survey.phtml b/view/frontend/templates/order/view/survey.phtml
index 4f2645e..d79d49b 100644
--- a/view/frontend/templates/order/view/survey.phtml
+++ b/view/frontend/templates/order/view/survey.phtml
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
diff --git a/view/frontend/templates/static-block.phtml b/view/frontend/templates/static-block.phtml
deleted file mode 100644
index d802ade..0000000
--- a/view/frontend/templates/static-block.phtml
+++ /dev/null
@@ -1,28 +0,0 @@
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
- * @copyright   Copyright (c) Mageplaza (https://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-?>
-
-<?php
-$blockArray = $block->getStaticBlock();
-foreach ($blockArray as $item) {
-    echo '<div class="osc-cms-block">' . $item['content'] . '</div>';
-}
-?>
diff --git a/view/frontend/web/css/style.css b/view/frontend/web/css/style.css
index 34ecb10..d7eaf8b 100644
--- a/view/frontend/web/css/style.css
+++ b/view/frontend/web/css/style.css
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -88,8 +88,7 @@ fieldset.field.col-mp{padding: 0 10px !important;}
 .checkout-payment-method .payment-group .step-title {display: none;}
 
 /**************************************************** Order summary area ****************************************************/
-.opc-block-summary .minicart-items-wrapper{max-height: none !important; margin: 0; padding: 0;}
-.opc-block-summary .items-in-cart > .title{margin-bottom: 15px;}
+.opc-block-summary .minicart-items-wrapper{max-height: none !important;}
 .opc-block-summary{background: none !important; border: none !important;}
 .one-step-checkout-wrapper .minicart-items-wrapper .product-item-detail{display: inline-block; padding-left: 10px;}
 .minicart-items .product-item-name{font-size: 16px !important;}
@@ -222,20 +221,3 @@ form#co-shipping-method-form div#shipping-method-buttons-container{display:none;
 .opc-payment .payment-method-content .checkout-agreements-block {
     padding-top: 10px;
 }
-
-.opc.opc-sticky {
-    display: inline-block;
-}
-
-.opc.opc-sticky .sticky {
-    position: sticky;
-    top: 30px;
-}
-
-.osc-cms-block {
-    margin: 30px 0;
-}
-
-#opc-sidebar ~ .osc-cms-block {
-    padding: 0 10px;
-}
\ No newline at end of file
diff --git a/view/frontend/web/js/action/check-email-availability.js b/view/frontend/web/js/action/check-email-availability.js
index 6190dcd..c55fc80 100644
--- a/view/frontend/web/js/action/check-email-availability.js
+++ b/view/frontend/web/js/action/check-email-availability.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/gift-message-item.js b/view/frontend/web/js/action/gift-message-item.js
index c69f88a..39ea521 100644
--- a/view/frontend/web/js/action/gift-message-item.js
+++ b/view/frontend/web/js/action/gift-message-item.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/gift-wrap.js b/view/frontend/web/js/action/gift-wrap.js
index bd116ab..62408ca 100644
--- a/view/frontend/web/js/action/gift-wrap.js
+++ b/view/frontend/web/js/action/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/payment-total-information.js b/view/frontend/web/js/action/payment-total-information.js
index 4eb99e7..da2d5a0 100644
--- a/view/frontend/web/js/action/payment-total-information.js
+++ b/view/frontend/web/js/action/payment-total-information.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/place-order-mixins.js b/view/frontend/web/js/action/place-order-mixins.js
index 0ef50a1..664da62 100644
--- a/view/frontend/web/js/action/place-order-mixins.js
+++ b/view/frontend/web/js/action/place-order-mixins.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -39,13 +39,7 @@ define([
                     deferred.reject(response);
                 })
             } else {
-                return originalAction(paymentData, messageContainer).fail(function (response) {
-                    if ($('.message-error').length) {
-                        $('html, body').scrollTop(
-                            $('.message-error:visible:first').closest('div').offset().top - $(window).height()/2
-                        );
-                    }
-                });
+                return originalAction(paymentData, messageContainer);
             }
 
             return deferred;
diff --git a/view/frontend/web/js/action/set-checkout-information.js b/view/frontend/web/js/action/set-checkout-information.js
index 9082700..ab284e7 100644
--- a/view/frontend/web/js/action/set-checkout-information.js
+++ b/view/frontend/web/js/action/set-checkout-information.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/set-payment-method.js b/view/frontend/web/js/action/set-payment-method.js
index 2a8514a..51d3b25 100644
--- a/view/frontend/web/js/action/set-payment-method.js
+++ b/view/frontend/web/js/action/set-payment-method.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/action/update-item.js b/view/frontend/web/js/action/update-item.js
index 7ecb8f4..5834033 100644
--- a/view/frontend/web/js/action/update-item.js
+++ b/view/frontend/web/js/action/update-item.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -28,8 +28,7 @@ define(
         'Magento_Checkout/js/model/payment/method-converter',
         'Magento_Checkout/js/model/payment-service',
         'Magento_Checkout/js/model/shipping-service',
-        'Mageplaza_Osc/js/model/osc-loader',
-        'Magento_Customer/js/customer-data'
+        'Mageplaza_Osc/js/model/osc-loader'
     ],
     function (quote,
               resourceUrlManager,
@@ -39,8 +38,7 @@ define(
               methodConverter,
               paymentService,
               shippingService,
-              oscLoader,
-              customerData) {
+              oscLoader) {
         'use strict';
 
         var itemUpdateLoader = ['shipping', 'payment', 'total'];
@@ -68,7 +66,6 @@ define(
                     if (response.shipping_methods && !quote.isVirtual()) {
                         shippingService.setShippingRates(response.shipping_methods);
                     }
-                    customerData.reload(['cart'], true);
                 }
             ).fail(
                 function (response) {
diff --git a/view/frontend/web/js/model/address/auto-complete.js b/view/frontend/web/js/model/address/auto-complete.js
index 02d53d7..f495f60 100644
--- a/view/frontend/web/js/model/address/auto-complete.js
+++ b/view/frontend/web/js/model/address/auto-complete.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/address/type/google.js b/view/frontend/web/js/model/address/type/google.js
index 082a7b6..4deba02 100644
--- a/view/frontend/web/js/model/address/type/google.js
+++ b/view/frontend/web/js/model/address/type/google.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (https://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (https://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/agreement-validator.js b/view/frontend/web/js/model/agreement-validator.js
index 2d73798..bc8c4ce 100644
--- a/view/frontend/web/js/model/agreement-validator.js
+++ b/view/frontend/web/js/model/agreement-validator.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/agreements-assigner.js b/view/frontend/web/js/model/agreements-assigner.js
index 3c82a42..51adb41 100644
--- a/view/frontend/web/js/model/agreements-assigner.js
+++ b/view/frontend/web/js/model/agreements-assigner.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/braintree-paypal.js b/view/frontend/web/js/model/braintree-paypal.js
index 966e979..23b69d0 100644
--- a/view/frontend/web/js/model/braintree-paypal.js
+++ b/view/frontend/web/js/model/braintree-paypal.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/checkout-data-resolver.js b/view/frontend/web/js/model/checkout-data-resolver.js
index e497c72..92e4346 100644
--- a/view/frontend/web/js/model/checkout-data-resolver.js
+++ b/view/frontend/web/js/model/checkout-data-resolver.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/compatible/amazon-pay.js b/view/frontend/web/js/model/compatible/amazon-pay.js
index 9aacb1e..4d6bcc9 100644
--- a/view/frontend/web/js/model/compatible/amazon-pay.js
+++ b/view/frontend/web/js/model/compatible/amazon-pay.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/gift-message.js b/view/frontend/web/js/model/gift-message.js
index 903d678..2eaaa93 100644
--- a/view/frontend/web/js/model/gift-message.js
+++ b/view/frontend/web/js/model/gift-message.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/gift-wrap.js b/view/frontend/web/js/model/gift-wrap.js
index c287657..84719ea 100644
--- a/view/frontend/web/js/model/gift-wrap.js
+++ b/view/frontend/web/js/model/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/osc-data.js b/view/frontend/web/js/model/osc-data.js
index 3d4cf86..edab1b6 100644
--- a/view/frontend/web/js/model/osc-data.js
+++ b/view/frontend/web/js/model/osc-data.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/osc-loader.js b/view/frontend/web/js/model/osc-loader.js
index 91cf13a..d474dc4 100644
--- a/view/frontend/web/js/model/osc-loader.js
+++ b/view/frontend/web/js/model/osc-loader.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/osc-loader/discount.js b/view/frontend/web/js/model/osc-loader/discount.js
index de0f8e2..badffb6 100644
--- a/view/frontend/web/js/model/osc-loader/discount.js
+++ b/view/frontend/web/js/model/osc-loader/discount.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/payment-service.js b/view/frontend/web/js/model/payment-service.js
index a8f4dfb..f8114bd 100644
--- a/view/frontend/web/js/model/payment-service.js
+++ b/view/frontend/web/js/model/payment-service.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/paypal/set-payment-method-mixin.js b/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
index 4ffbff8..23b2152 100644
--- a/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
+++ b/view/frontend/web/js/model/paypal/set-payment-method-mixin.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/resource-url-manager.js b/view/frontend/web/js/model/resource-url-manager.js
index a1ef609..7630629 100644
--- a/view/frontend/web/js/model/resource-url-manager.js
+++ b/view/frontend/web/js/model/resource-url-manager.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/shipping-rate-service.js b/view/frontend/web/js/model/shipping-rate-service.js
index 0580ba2..5a730bd 100644
--- a/view/frontend/web/js/model/shipping-rate-service.js
+++ b/view/frontend/web/js/model/shipping-rate-service.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/shipping-rates-validator.js b/view/frontend/web/js/model/shipping-rates-validator.js
index a9a936f..5837c0c 100644
--- a/view/frontend/web/js/model/shipping-rates-validator.js
+++ b/view/frontend/web/js/model/shipping-rates-validator.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/model/shipping-save-processor/checkout.js b/view/frontend/web/js/model/shipping-save-processor/checkout.js
index 5272ad9..42836f8 100644
--- a/view/frontend/web/js/model/shipping-save-processor/checkout.js
+++ b/view/frontend/web/js/model/shipping-save-processor/checkout.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/amazon.js b/view/frontend/web/js/view/amazon.js
index e78bb2f..d788504 100644
--- a/view/frontend/web/js/view/amazon.js
+++ b/view/frontend/web/js/view/amazon.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/authentication.js b/view/frontend/web/js/view/authentication.js
index e40c198..69e0530 100644
--- a/view/frontend/web/js/view/authentication.js
+++ b/view/frontend/web/js/view/authentication.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/billing-address.js b/view/frontend/web/js/view/billing-address.js
index 6dc4450..ce1e334 100644
--- a/view/frontend/web/js/view/billing-address.js
+++ b/view/frontend/web/js/view/billing-address.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -270,6 +270,25 @@ define(
                     this.source.trigger('billingAddress.custom_attributes.data.validate');
                 }
 
+                if (this.source.get('params.invalid')) {
+                    var offsetHeight = $(window).height()/2,
+                        errorMsgSelector = $('#billing-new-address-form .mage-error:first').closest('.field');
+                    errorMsgSelector = errorMsgSelector.length ? errorMsgSelector : $('#co-shipping-form .field-error:first').closest('.field');
+                    if (errorMsgSelector.length) {
+                        if (errorMsgSelector.find('select').length) {
+                            $('html, body').scrollTop(
+                                errorMsgSelector.find('select').offset().top - offsetHeight
+                            );
+                            errorMsgSelector.find('select').focus();
+                        } else if (errorMsgSelector.find('input').length) {
+                            $('html, body').scrollTop(
+                                errorMsgSelector.find('input').offset().top - offsetHeight
+                            );
+                            errorMsgSelector.find('input').focus();
+                        }
+                    }
+                }
+
                 oscData.setData('same_as_shipping', false);
                 return !this.source.get('params.invalid');
             },
diff --git a/view/frontend/web/js/view/delivery-time.js b/view/frontend/web/js/view/delivery-time.js
index 3d68271..7d1fd1a 100644
--- a/view/frontend/web/js/view/delivery-time.js
+++ b/view/frontend/web/js/view/delivery-time.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/form/element/email.js b/view/frontend/web/js/view/form/element/email.js
index 1e82a36..1c8dba3 100644
--- a/view/frontend/web/js/view/form/element/email.js
+++ b/view/frontend/web/js/view/form/element/email.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/form/element/region.js b/view/frontend/web/js/view/form/element/region.js
index d11cc02..366ab2f 100644
--- a/view/frontend/web/js/view/form/element/region.js
+++ b/view/frontend/web/js/view/form/element/region.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/form/element/street.js b/view/frontend/web/js/view/form/element/street.js
index e77f9fc..7218002 100644
--- a/view/frontend/web/js/view/form/element/street.js
+++ b/view/frontend/web/js/view/form/element/street.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/geoip.js b/view/frontend/web/js/view/geoip.js
index 2144e73..97eb4aa 100644
--- a/view/frontend/web/js/view/geoip.js
+++ b/view/frontend/web/js/view/geoip.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/payment.js b/view/frontend/web/js/view/payment.js
index 5cdb8fa..b6c1705 100644
--- a/view/frontend/web/js/view/payment.js
+++ b/view/frontend/web/js/view/payment.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -69,6 +69,10 @@ define(
                 if (!quote.paymentMethod()) {
                     this.errorValidationMessage($.mage.__('Please specify a payment method.'));
 
+                    $('html, body').scrollTop(
+                        $('#checkout-step-payment').offset().top - $(window).height()/2
+                    );
+
                     return false;
                 }
 
diff --git a/view/frontend/web/js/view/payment/discount.js b/view/frontend/web/js/view/payment/discount.js
index f3f346a..691ec04 100644
--- a/view/frontend/web/js/view/payment/discount.js
+++ b/view/frontend/web/js/view/payment/discount.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js b/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
index 94cf0a7..84e9b18 100644
--- a/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
+++ b/view/frontend/web/js/view/payment/method-renderer/braintree-paypal-mixins.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition.js b/view/frontend/web/js/view/review/addition.js
index 4b3c9b3..dbc3c39 100644
--- a/view/frontend/web/js/view/review/addition.js
+++ b/view/frontend/web/js/view/review/addition.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/gift-message.js b/view/frontend/web/js/view/review/addition/gift-message.js
index 41d5c0a..79219ad 100644
--- a/view/frontend/web/js/view/review/addition/gift-message.js
+++ b/view/frontend/web/js/view/review/addition/gift-message.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/gift-wrap.js b/view/frontend/web/js/view/review/addition/gift-wrap.js
index 40bcbd2..1393c1b 100644
--- a/view/frontend/web/js/view/review/addition/gift-wrap.js
+++ b/view/frontend/web/js/view/review/addition/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/addition/newsletter.js b/view/frontend/web/js/view/review/addition/newsletter.js
index 2b1ab9a..496edcb 100644
--- a/view/frontend/web/js/view/review/addition/newsletter.js
+++ b/view/frontend/web/js/view/review/addition/newsletter.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/checkout-agreements.js b/view/frontend/web/js/view/review/checkout-agreements.js
index fb04eea..7095d26 100644
--- a/view/frontend/web/js/view/review/checkout-agreements.js
+++ b/view/frontend/web/js/view/review/checkout-agreements.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/comment.js b/view/frontend/web/js/view/review/comment.js
index edb41d9..3311ad1 100644
--- a/view/frontend/web/js/view/review/comment.js
+++ b/view/frontend/web/js/view/review/comment.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/review/placeOrder.js b/view/frontend/web/js/view/review/placeOrder.js
index 6f718a9..162b0bd 100644
--- a/view/frontend/web/js/view/review/placeOrder.js
+++ b/view/frontend/web/js/view/review/placeOrder.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -98,27 +98,6 @@ define(
                     this.preparePlaceOrder().done(function () {
                         self._placeOrder();
                     });
-                } else {
-                    var offsetHeight = $(window).height()/2,
-                        errorMsgSelector = $('#maincontent .mage-error:visible:first').closest('.field');
-                    errorMsgSelector = errorMsgSelector.length ? errorMsgSelector : $('#maincontent .field-error:visible:first').closest('.field');
-                    if (errorMsgSelector.length) {
-                        if (errorMsgSelector.find('select').length) {
-                            $('html, body').scrollTop(
-                                errorMsgSelector.find('select').offset().top - offsetHeight
-                            );
-                            errorMsgSelector.find('select').focus();
-                        } else if (errorMsgSelector.find('input').length) {
-                            $('html, body').scrollTop(
-                                errorMsgSelector.find('input').offset().top - offsetHeight
-                            );
-                            errorMsgSelector.find('input').focus();
-                        }
-                    } else if ($('.message-error:visible').length) {
-                        $('html, body').scrollTop(
-                            $('.message-error:visible:first').closest('div').offset().top - offsetHeight
-                        );
-                    }
                 }
 
                 return this;
diff --git a/view/frontend/web/js/view/shipping-address/address-renderer/default.js b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
index d8207fc..50922e9 100644
--- a/view/frontend/web/js/view/shipping-address/address-renderer/default.js
+++ b/view/frontend/web/js/view/shipping-address/address-renderer/default.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/shipping-postnl.js b/view/frontend/web/js/view/shipping-postnl.js
index f598e3b..02da739 100644
--- a/view/frontend/web/js/view/shipping-postnl.js
+++ b/view/frontend/web/js/view/shipping-postnl.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/shipping.js b/view/frontend/web/js/view/shipping.js
index a40b9dd..60263ae 100644
--- a/view/frontend/web/js/view/shipping.js
+++ b/view/frontend/web/js/view/shipping.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -161,6 +161,35 @@ define(
                     this.saveShippingAddress();
                 }
 
+                var offsetHeight = $(window).height()/2;
+                if (!emailValidationResult) {
+                    $(loginFormSelector + ' input[name=username]').focus();
+                } else if (!shippingAddressValidationResult) {
+                    var errorMsgSelector = $('#co-shipping-form .mage-error:first').closest('.field');
+                    errorMsgSelector = errorMsgSelector.length ? errorMsgSelector : $('#co-shipping-form .field-error:first').closest('.field');
+                    if (errorMsgSelector.length) {
+                        if (errorMsgSelector.find('select').length) {
+                            $('html, body').scrollTop(
+                                errorMsgSelector.find('select').offset().top - offsetHeight
+                            );
+                            errorMsgSelector.find('select').focus();
+                        } else if (errorMsgSelector.find('input').length) {
+                            $('html, body').scrollTop(
+                                errorMsgSelector.find('input').offset().top - offsetHeight
+                            );
+                            errorMsgSelector.find('input').focus();
+                        }
+                    }
+                } else if (!shippingMethodValidationResult) {
+                    if ($('._warn[name="shippingAddress.postcode"]').length) {
+                        $('._warn[name="shippingAddress.postcode"]').find('input').focus();
+                    } else {
+                        $('html, body').scrollTop(
+                            $('#opc-shipping_method').offset().top - offsetHeight/3
+                        );
+                    }
+                }
+
                 return shippingMethodValidationResult && shippingAddressValidationResult && emailValidationResult;
             },
             saveShippingAddress: function () {
diff --git a/view/frontend/web/js/view/summary/gift-wrap.js b/view/frontend/web/js/view/summary/gift-wrap.js
index 1b5b088..db4162d 100644
--- a/view/frontend/web/js/view/summary/gift-wrap.js
+++ b/view/frontend/web/js/view/summary/gift-wrap.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/summary/item/details.js b/view/frontend/web/js/view/summary/item/details.js
index bcaa912..a77db93 100644
--- a/view/frontend/web/js/view/summary/item/details.js
+++ b/view/frontend/web/js/view/summary/item/details.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -43,8 +43,6 @@ define(
                 template: 'Mageplaza_Osc/container/summary/item/details'
             },
             giftMessageItemsTitleHover: $t('Gift message item'),
-            updateQtyDelay: 500,
-            updateQtyTimeout: 0,
 
             /**
              * Get product url
@@ -181,14 +179,10 @@ define(
             /**
              * Plus item qty
              *
-             * @param item
+             * @param id
              * @param event
              */
-            plusQty: function (item, event) {
-                var self = this;
-
-                clearTimeout(this.updateQtyTimeout);
-
+            plusQty: function (id, event) {
                 var target = $(event.target).prev().children(".item_qty"),
                     itemId = parseInt(target.attr("id")),
                     qty = parseInt(target.val());
@@ -201,11 +195,7 @@ define(
                     qty += 1;
                 }
 
-                target.val(qty);
-
-                this.updateQtyTimeout = setTimeout(function () {
-                    self.updateItem(itemId, qty, target)
-                }, this.updateQtyDelay);
+                this.updateItem(itemId, qty);
             },
 
             /**
@@ -215,10 +205,6 @@ define(
              * @param event
              */
             minusQty: function (item, event) {
-                var self = this;
-
-                clearTimeout(this.updateQtyTimeout);
-
                 var target = $(event.target).next().children(".item_qty"),
                     itemId = parseInt(target.attr("id")),
                     qty = parseInt(target.val());
@@ -231,11 +217,7 @@ define(
                     qty -= 1;
                 }
 
-                target.val(qty);
-
-                this.updateQtyTimeout = setTimeout(function () {
-                    self.updateItem(itemId, qty, target)
-                }, this.updateQtyDelay);
+                this.updateItem(itemId, qty);
             },
 
             /**
@@ -255,7 +237,7 @@ define(
                     qty = (Math.ceil(qty / qtyDelta) -1) * qtyDelta;
                 }
 
-                this.updateItem(itemId, qty, target);
+                this.updateItem(itemId, qty);
             },
 
             /**
@@ -272,12 +254,10 @@ define(
              *
              * @param itemId
              * @param itemQty
-             * @param target
              * @returns {*}
              */
-            updateItem: function (itemId, itemQty, target) {
-                var self = this,
-                    payload = {
+            updateItem: function (itemId, itemQty) {
+                var payload = {
                     item_id: itemId
                 };
 
@@ -285,28 +265,9 @@ define(
                     payload['item_qty'] = itemQty;
                 }
 
-                updateItemAction(payload).fail(function (response) {
-                    target.val(self.getProductQty(itemId));
-                });
+                updateItemAction(payload);
 
                 return this;
-            },
-
-            /**
-             * Get product quantity
-             * @param itemId
-             * @returns {*}
-             */
-            getProductQty: function (itemId) {
-                var item = _.find(quote.totals().items, function (product) {
-                    return product.item_id == itemId;
-                });
-
-                if (item && item.hasOwnProperty('qty')) {
-                    return item.qty;
-                }
-
-                return 0;
             }
         });
     }
diff --git a/view/frontend/web/js/view/survey.js b/view/frontend/web/js/view/survey.js
index 5201724..3042efe 100644
--- a/view/frontend/web/js/view/survey.js
+++ b/view/frontend/web/js/view/survey.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/template/1column.html b/view/frontend/web/template/1column.html
index 74e736f..9aceb8b 100644
--- a/view/frontend/web/template/1column.html
+++ b/view/frontend/web/template/1column.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/2columns-floating.html b/view/frontend/web/template/2columns-floating.html
deleted file mode 100644
index 01f937b..0000000
--- a/view/frontend/web/template/2columns-floating.html
+++ /dev/null
@@ -1,78 +0,0 @@
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
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
--->
-
-<!-- ko foreach: getRegion('estimation') -->
-<!-- ko template: getTemplate() --><!-- /ko -->
-<!--/ko-->
-
-<!-- ko foreach: getRegion('authentication') -->
-<!-- ko template: getTemplate() --><!-- /ko -->
-<!--/ko-->
-
-<!-- ko foreach: getRegion('messages') -->
-<!-- ko template: getTemplate() --><!-- /ko -->
-<!--/ko-->
-
-<div class="opc-wrapper one-step-checkout-wrapper">
-    <div class="opc one-step-checkout-container opc-sticky" id="checkoutSteps">
-        <div class="col-mp mp-6 mp-sm-5 mp-xs-12">
-            <div class="row-mp">
-                <!-- ko ifnot: window.checkoutConfig.oscConfig.isUsedMaterialDesign -->
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.shippingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.steps.shipping-step.billingAddress'">
-                    <!-- ko template: getAddressTemplate() --><!-- /ko -->
-                </div>
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
-                </div>
-                <!-- /ko -->
-
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.shipping-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
-                </div>
-                <div class="col-mp mp-12 hoverable" data-bind="scope: 'checkout.steps.billing-step'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
-                </div>
-                <div class="mp-clear"></div>
-            </div>
-        </div>
-        <div class="col-mp mp-6 mp-sm-7 mp-xs-12 sticky">
-            <div class="row-mp">
-                <div class="col-mp mp-12" data-bind="scope: 'checkout.sidebar'">
-                    <!-- ko template: getTemplate() --><!-- /ko -->
-                </div>
-                <div class="mp-clear"></div>
-            </div>
-        </div>
-    </div>
-</div>
\ No newline at end of file
diff --git a/view/frontend/web/template/2columns.html b/view/frontend/web/template/2columns.html
index 6162597..f779f80 100644
--- a/view/frontend/web/template/2columns.html
+++ b/view/frontend/web/template/2columns.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/3columns-colspan.html b/view/frontend/web/template/3columns-colspan.html
index 52f61c9..0a8e0d4 100644
--- a/view/frontend/web/template/3columns-colspan.html
+++ b/view/frontend/web/template/3columns-colspan.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/3columns.html b/view/frontend/web/template/3columns.html
index 177af01..267d2ba 100644
--- a/view/frontend/web/template/3columns.html
+++ b/view/frontend/web/template/3columns.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing-address.html b/view/frontend/web/template/container/address/billing-address.html
index b6ddfdc..3af0c98 100644
--- a/view/frontend/web/template/container/address/billing-address.html
+++ b/view/frontend/web/template/container/address/billing-address.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing/checkbox.html b/view/frontend/web/template/container/address/billing/checkbox.html
index 43ed51d..7284d69 100644
--- a/view/frontend/web/template/container/address/billing/checkbox.html
+++ b/view/frontend/web/template/container/address/billing/checkbox.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/billing/create.html b/view/frontend/web/template/container/address/billing/create.html
index 2a57c93..dc33a7a 100644
--- a/view/frontend/web/template/container/address/billing/create.html
+++ b/view/frontend/web/template/container/address/billing/create.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping-address.html b/view/frontend/web/template/container/address/shipping-address.html
index 0c0818e..5d8f486 100644
--- a/view/frontend/web/template/container/address/shipping-address.html
+++ b/view/frontend/web/template/container/address/shipping-address.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping/address-renderer/default.html b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
index 80e3d94..033dbf3 100644
--- a/view/frontend/web/template/container/address/shipping/address-renderer/default.html
+++ b/view/frontend/web/template/container/address/shipping/address-renderer/default.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/address/shipping/form.html b/view/frontend/web/template/container/address/shipping/form.html
index fd97d10..b471ccd 100644
--- a/view/frontend/web/template/container/address/shipping/form.html
+++ b/view/frontend/web/template/container/address/shipping/form.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/authentication.html b/view/frontend/web/template/container/authentication.html
index 8deeeb1..95c0f74 100644
--- a/view/frontend/web/template/container/authentication.html
+++ b/view/frontend/web/template/container/authentication.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/delivery-time.html b/view/frontend/web/template/container/delivery-time.html
index fe8aeed..71ca601 100644
--- a/view/frontend/web/template/container/delivery-time.html
+++ b/view/frontend/web/template/container/delivery-time.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/email.html b/view/frontend/web/template/container/form/element/email.html
index 928589a..21671df 100644
--- a/view/frontend/web/template/container/form/element/email.html
+++ b/view/frontend/web/template/container/form/element/email.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/input.html b/view/frontend/web/template/container/form/element/input.html
index f2da130..798c71d 100644
--- a/view/frontend/web/template/container/form/element/input.html
+++ b/view/frontend/web/template/container/form/element/input.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/element/street.html b/view/frontend/web/template/container/form/element/street.html
index 902965a..d98501f 100644
--- a/view/frontend/web/template/container/form/element/street.html
+++ b/view/frontend/web/template/container/form/element/street.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/form/field.html b/view/frontend/web/template/container/form/field.html
index c08117a..a785a77 100644
--- a/view/frontend/web/template/container/form/field.html
+++ b/view/frontend/web/template/container/form/field.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/payment.html b/view/frontend/web/template/container/payment.html
index 94e5b52..ec5077a 100644
--- a/view/frontend/web/template/container/payment.html
+++ b/view/frontend/web/template/container/payment.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/payment/discount.html b/view/frontend/web/template/container/payment/discount.html
index 2d73296..9801aa0 100644
--- a/view/frontend/web/template/container/payment/discount.html
+++ b/view/frontend/web/template/container/payment/discount.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition.html b/view/frontend/web/template/container/review/addition.html
index 728480d..cc47a25 100644
--- a/view/frontend/web/template/container/review/addition.html
+++ b/view/frontend/web/template/container/review/addition.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/gift-message.html b/view/frontend/web/template/container/review/addition/gift-message.html
index 497c4ff..18efa8f 100644
--- a/view/frontend/web/template/container/review/addition/gift-message.html
+++ b/view/frontend/web/template/container/review/addition/gift-message.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/gift-wrap.html b/view/frontend/web/template/container/review/addition/gift-wrap.html
index f034700..a2f9749 100644
--- a/view/frontend/web/template/container/review/addition/gift-wrap.html
+++ b/view/frontend/web/template/container/review/addition/gift-wrap.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/addition/newsletter.html b/view/frontend/web/template/container/review/addition/newsletter.html
index 1a482f1..588a620 100644
--- a/view/frontend/web/template/container/review/addition/newsletter.html
+++ b/view/frontend/web/template/container/review/addition/newsletter.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/comment.html b/view/frontend/web/template/container/review/comment.html
index 783d023..f0ef4bb 100644
--- a/view/frontend/web/template/container/review/comment.html
+++ b/view/frontend/web/template/container/review/comment.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/discount.html b/view/frontend/web/template/container/review/discount.html
index ed013a5..e60e047 100644
--- a/view/frontend/web/template/container/review/discount.html
+++ b/view/frontend/web/template/container/review/discount.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/review/place-order.html b/view/frontend/web/template/container/review/place-order.html
index 2e0e7bd..fe47cae 100644
--- a/view/frontend/web/template/container/review/place-order.html
+++ b/view/frontend/web/template/container/review/place-order.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -84,8 +84,4 @@
     </div>
     <!-- /ko -->
 </div>
-<!-- /ko -->
-
-<!-- ko foreach: {data: window.checkoutConfig.oscConfig.staticBlock, as: 'item'} -->
-<div class="osc-cms-block" data-bind="html: item.content"></div>
-<!--/ko-->
\ No newline at end of file
+<!-- /ko -->
\ No newline at end of file
diff --git a/view/frontend/web/template/container/shipping.html b/view/frontend/web/template/container/shipping.html
index ade7b78..0b36827 100644
--- a/view/frontend/web/template/container/shipping.html
+++ b/view/frontend/web/template/container/shipping.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/sidebar.html b/view/frontend/web/template/container/sidebar.html
index a3cc042..a3a5495 100644
--- a/view/frontend/web/template/container/sidebar.html
+++ b/view/frontend/web/template/container/sidebar.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -45,4 +45,4 @@
         </div>
         <div class="mp-clear"></div>
     </div>
-</div>
\ No newline at end of file
+</div>
diff --git a/view/frontend/web/template/container/summary.html b/view/frontend/web/template/container/summary.html
index 014c25e..fbfcc83 100644
--- a/view/frontend/web/template/container/summary.html
+++ b/view/frontend/web/template/container/summary.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/cart-items.html b/view/frontend/web/template/container/summary/cart-items.html
index 157be2f..2f34a1b 100644
--- a/view/frontend/web/template/container/summary/cart-items.html
+++ b/view/frontend/web/template/container/summary/cart-items.html
@@ -15,26 +15,13 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
 
-<div class="block items-in-cart" data-bind="mageInit: {'collapsible':{'openedState': 'active', 'active': true}}">
-    <!-- ko if: window.checkoutConfig.oscConfig.isShowItemListToggle -->
-    <div class="title" data-role="title">
-        <strong role="heading">
-            <span data-bind="text: getItems().length"></span>
-            <!-- ko if: getItems().length == 1 -->
-            <span data-bind="i18n: 'Item in Cart'"></span>
-            <!-- /ko -->
-            <!-- ko if: getItems().length > 1 -->
-            <span data-bind="i18n: 'Items in Cart'"></span>
-            <!-- /ko -->
-        </strong>
-    </div>
-    <!-- /ko -->
-    <div class="content minicart-items" data-role="content">
+<div class="block items-in-cart">
+    <div class="content minicart-items">
         <div class="minicart-items-wrapper overflowed">
             <table id="checkout-review-table" class="data-table">
                 <colgroup>
diff --git a/view/frontend/web/template/container/summary/gift-wrap.html b/view/frontend/web/template/container/summary/gift-wrap.html
index 8363fa3..b71933e 100644
--- a/view/frontend/web/template/container/summary/gift-wrap.html
+++ b/view/frontend/web/template/container/summary/gift-wrap.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/view/frontend/web/template/container/summary/item/details.html b/view/frontend/web/template/container/summary/item/details.html
index 721a97e..dc2e3b4 100644
--- a/view/frontend/web/template/container/summary/item/details.html
+++ b/view/frontend/web/template/container/summary/item/details.html
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_Osc
- * @copyright   Copyright (c) Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2017-2018 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -134,7 +134,7 @@
     <div class="qty-wrapper">
         <a href="javascript:void(0);" class="button-action minus" data-bind="click: minusQty" title="Minus"></a>
         <div class="qty-wrap">
-            <input class="item_qty input-text update value" name="item_qty"  data-bind="value: getProductQty($parent.item_id), attr: {id: $parent.item_id}, event: {change: changeQty}" />
+            <input class="item_qty input-text update value" name="item_qty"  data-bind="value: $parent.qty, attr: {id: $parent.item_id}, event: {change: changeQty}" />
         </div>
         <a href="javascript:void(0);" class="button-action plus" data-bind="click: plusQty" title="Plus"></a>
     </div>
