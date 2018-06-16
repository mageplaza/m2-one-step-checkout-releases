# Magento 2 One Step Checkout Release Notes

## v2.5.0
Released on  2018-06-13
Release notes: 

- Added Static block to the top/bottom of the checkout page
- Added Static block to the checkout success page
- Added Seal static block under the Place Order button
- Added a new 2-columns layout
- Ability to show/hide the item list on the Review section
- Improved item qty update feature
- Fixed bugs:
     + Sort customer attribute fields
     + Update mini-cart qty when item qty is changed on checkout page



## v2.4.5
Released on  2018-05-08
Release notes: 

- Auto-scroll to the field left blank on the validation <improved>
- Fixed the error in changing item quantity when Product Qty Increment field is enabled



## v2.4.4
Released on  2018-04-02
Release notes: 

- Scroll page to the empty field on validation
- Fix bug
    + GeoIp on restricted country
    + Register account on Magento 2.2.x
    + Cannot translate customer attribute labels




## v2.4.3
Released on  2018-03-16
Release notes: 

- Separated GeoIP library
- Moved One Step Checkout Menu to Magento Stores menu
- Fix bugs:
    - The customer cannot login to his account when registering via OSC
    - Empty billing address when buying the virtual product with "Show billing address" config set to "disabled"



## v2.4.2
Released on  2017-12-14
Release notes: 

- Compatible with Amazon Pay
- Compatible with Magento 2.2.x
- Fix bugs:
    + Redirect to the OSC page on configurable products
    + Save the customer's address when they create an account in the checkout process
    + Cannot have payment method fields if customers check out a virtual order (customer logged in)
    + Cannot place a virtual order with saved addresses
    + Cannot load the OSC page if the customer has multiple addresses but none of them is default



## v2.4.1
Released on  2017-10-19
Release notes: 

- Compatible with Magento 2.2.x



## v2.4.0
Released on  2017-08-16
Release notes: 

- New Features
    - Material design
    - Geo IP
    - House security code
- Fix some bugs



## v2.3.6
Released on  2017-06-19
Release notes: 

- Add features Billing address before shipping address configuration
- Compatible MultiSafepay (included)
- Fix delivery time clean up issue
- Fix bug default payment from admin
- Fix bug validate shipping method and move order comment to shipping method




## v2.3.5
Released on  2017-04-14
Release notes: 

*Fix bugs:*
 - Coupon code area loading compatible with all versions of Magento 2.1.x
 - Check Term & condition with logged in customer
 - Some small minor bugs



## v2.3.4
Released on  2017-04-07
Release notes: 

- Fix minor bugs, compatible with mobile screen



## v2.3.3
Released on  2017-03-30
Release notes: 

*Fix bugs:*
 - Fix some css bugs
 - Create account when checking out virtual order
 - Load only active payment method in configuration



## v2.3.2
Released on  2017-03-22
Release notes: 

- Fix bugs css
- Customer not login can go through checkout page without Authenticate popup (downloadable). Customer has to register at checkout page
- Load payment method if country change on virtual quote



## v2.3.1
Released on  2017-02-17
Release notes: 

*Fix bugs:*
 - Total shipping amount not update when shipping method amount changed
 - Billing address auto open when add new shipping address (customer login + has address before)



## v2.3.0
Released on  2017-02-17
Release notes: 

*Fix bugs:*
 - Dont load blocks when changing shipping address (bug with some 3rd party shipping method)
 - Show only active payment methods when choose default from backend

*Features*
 - Delivery time



## v2.2.0
Released on  2016-12-26
Release notes: 

- Add feature: Order giftmessage
- Compatible with Social Login extension
- Fix bugs



## v2.1.0
Released on  2016-12-22
Release notes: 

- new features:
    + Address field position
    + Giftwrap
    + Popup login
- Some bugs fixed
- Compatible with Magento 2.1.3
- Compatible with IE



## v2.0.1
Released on  2016-12-06
Release notes: 

Fix bugs:
+ Create account when checkout on Magento 2.1.2
+ Correct Product Url in cart summary
+ Validate multiple TOC



## v2.0.0
Released on  2016-11-26
Release notes: 

Release v2.0.0
- Re-organize structure
- Resolved compatible issues for almost extensions tested with Magento 2 default checkout
- Better knockout js loading: address, shipping, payment methods



## v1.3.0
Released on  2016-11-18
Release notes: 

Fix bug:
- some time shipping address cannot be saved
- change the address element require to load block (country, region, postcode)



## v1.2.9
Released on  2016-10-31
Release notes: 

Improvement:
   + Google auto detect address key + specific country



## File Changes

### v2.5.0 to v2.4.5
~~~
 Api/CheckoutManagementInterface.php                |   2 +-
 Api/Data/OscDetailsInterface.php                   |   2 +-
 Api/GuestCheckoutManagementInterface.php           |   2 +-
 Block/Adminhtml/Config/Backend/StaticBlock.php     | 124 ---------------------
 Block/Adminhtml/Field/Position.php                 |   2 +-
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |   2 +-
 Block/Adminhtml/System/Config/Geoip.php            |   2 +-
 Block/Checkout/CompatibleConfig.php                |   2 +-
 Block/Checkout/LayoutProcessor.php                 |  28 ++---
 Block/Container.php                                |   2 +-
 Block/Design.php                                   |   2 +-
 Block/Order/Totals.php                             |   2 +-
 Block/Order/View/Comment.php                       |   2 +-
 Block/Order/View/DeliveryTime.php                  |   2 +-
 Block/Order/View/Survey.php                        |   2 +-
 Block/Plugin/Link.php                              |   2 +-
 Block/StaticBlock.php                              | 104 -----------------
 Block/Survey.php                                   |   2 +-
 Controller/Add/Index.php                           |   2 +-
 Controller/Adminhtml/Field/Position.php            |   2 +-
 Controller/Adminhtml/Field/Save.php                |   2 +-
 Controller/Adminhtml/System/Config/Geoip.php       |   2 +-
 Controller/Index/Index.php                         |   2 +-
 Controller/Survey/Save.php                         |   2 +-
 Helper/Address.php                                 |   2 +-
 Helper/Data.php                                    |  48 +-------
 LICENSE                                            |   4 +-
 Model/AgreementsValidator.php                      |   2 +-
 Model/CheckoutManagement.php                       |   2 +-
 Model/CheckoutRegister.php                         |   2 +-
 Model/DefaultConfigProvider.php                    |  49 +-------
 Model/GuestCheckoutManagement.php                  |   2 +-
 Model/OscDetails.php                               |   2 +-
 Model/Plugin/Authorization/UserContext.php         |   2 +-
 Model/Plugin/Checkout/ShippingMethodManagement.php |   2 +-
 Model/Plugin/Customer/AccountManagement.php        |   2 +-
 Model/Plugin/Customer/Address.php                  |   2 +-
 .../Plugin/Eav/Model/Validator/Attribute/Data.php  |   2 +-
 Model/Plugin/Paypal/Model/Express.php              |   2 +-
 Model/Plugin/Quote/GiftWrap.php                    |   2 +-
 Model/Plugin/Quote/Processor.php                   |  90 ---------------
 Model/Plugin/Quote/QuoteManagement.php             |   2 +-
 Model/System/Config/Source/AddressSuggest.php      |   2 +-
 Model/System/Config/Source/CheckboxStyle.php       |   2 +-
 Model/System/Config/Source/ComponentPosition.php   |   2 +-
 Model/System/Config/Source/DeliveryTime.php        |   2 +-
 Model/System/Config/Source/Design.php              |   2 +-
 Model/System/Config/Source/Giftwrap.php            |   2 +-
 Model/System/Config/Source/Layout.php              |   7 +-
 Model/System/Config/Source/PaymentMethods.php      |   2 +-
 Model/System/Config/Source/RadioStyle.php          |   2 +-
 Model/System/Config/Source/ShippingMethods.php     |   2 +-
 Model/System/Config/Source/StaticBlockPosition.php |  51 ---------
 Model/System/Config/Source/Survey.php              |   2 +-
 Model/Total/Creditmemo/GiftWrap.php                |   2 +-
 Model/Total/Invoice/GiftWrap.php                   |   2 +-
 Model/Total/Quote/GiftWrap.php                     |   2 +-
 Observer/IsAllowedGuestCheckoutObserver.php        |   2 +-
 Observer/OscConfigObserver.php                     |   2 +-
 Observer/PaypalExpressPlaceOrder.php               |   2 +-
 Observer/QuoteSubmitBefore.php                     |   2 +-
 Observer/QuoteSubmitSuccess.php                    |   6 +-
 Observer/RedirectToOneStepCheckout.php             |   2 +-
 Setup/InstallData.php                              |   2 +-
 Setup/UpgradeData.php                              |  61 +---------
 composer.json                                      |   4 +-
 etc/acl.xml                                        |   2 +-
 etc/adminhtml/di.xml                               |   2 +-
 etc/adminhtml/events.xml                           |   2 +-
 etc/adminhtml/menu.xml                             |   2 +-
 etc/adminhtml/routes.xml                           |   2 +-
 etc/adminhtml/system.xml                           |  33 +-----
 etc/config.xml                                     |   3 +-
 etc/di.xml                                         |   2 +-
 etc/events.xml                                     |   2 +-
 etc/extension_attributes.xml                       |   2 +-
 etc/frontend/di.xml                                |   6 +-
 etc/frontend/events.xml                            |   2 +-
 etc/frontend/routes.xml                            |   2 +-
 etc/frontend/sections.xml                          |   2 +-
 etc/module.xml                                     |   4 +-
 etc/sales.xml                                      |   2 +-
 etc/webapi.xml                                     |   2 +-
 etc/webapi_rest/di.xml                             |   2 +-
 registration.php                                   |   2 +-
 .../layout/onestepcheckout_field_position.xml      |   2 +-
 .../layout/sales_order_creditmemo_new.xml          |   2 +-
 .../layout/sales_order_creditmemo_updateqty.xml    |   2 +-
 .../layout/sales_order_creditmemo_view.xml         |   2 +-
 .../adminhtml/layout/sales_order_invoice_email.xml |   2 +-
 view/adminhtml/layout/sales_order_invoice_new.xml  |   2 +-
 .../adminhtml/layout/sales_order_invoice_print.xml |   2 +-
 .../layout/sales_order_invoice_updateqty.xml       |   2 +-
 view/adminhtml/layout/sales_order_invoice_view.xml |   2 +-
 view/adminhtml/layout/sales_order_view.xml         |   2 +-
 view/adminhtml/templates/field/position.phtml      |   2 +-
 view/adminhtml/templates/order/additional.phtml    |   2 +-
 view/adminhtml/templates/order/view/comment.phtml  |   2 +-
 .../templates/order/view/delivery-time.phtml       |   2 +-
 view/adminhtml/templates/order/view/survey.phtml   |   2 +-
 view/adminhtml/templates/system/config/geoip.phtml |   2 +-
 view/adminhtml/web/css/source/_module.less         |   2 +-
 view/adminhtml/web/css/style.css                   |   2 +-
 view/base/web/css/images/seal.png                  | Bin 61069 -> 0 bytes
 view/frontend/layout/checkout_onepage_success.xml  |   3 +-
 .../layout/onestepcheckout_index_index.xml         |   4 +-
 .../layout/sales_email_order_creditmemo_items.xml  |   2 +-
 .../layout/sales_email_order_invoice_items.xml     |   2 +-
 view/frontend/layout/sales_email_order_items.xml   |   2 +-
 view/frontend/layout/sales_order_creditmemo.xml    |   2 +-
 view/frontend/layout/sales_order_invoice.xml       |   2 +-
 view/frontend/layout/sales_order_print.xml         |   2 +-
 .../layout/sales_order_printcreditmemo.xml         |   2 +-
 view/frontend/layout/sales_order_printinvoice.xml  |   2 +-
 view/frontend/layout/sales_order_view.xml          |   2 +-
 view/frontend/requirejs-config.js                  |   2 +-
 view/frontend/templates/description.phtml          |   2 +-
 view/frontend/templates/design.phtml               |   6 +-
 .../templates/onepage/compatible-config.phtml      |   2 +-
 .../templates/onepage/success/survey.phtml         |   2 +-
 view/frontend/templates/order/additional.phtml     |   2 +-
 view/frontend/templates/order/view/comment.phtml   |   2 +-
 .../templates/order/view/delivery-time.phtml       |   2 +-
 view/frontend/templates/order/view/survey.phtml    |   2 +-
 view/frontend/templates/static-block.phtml         |  28 -----
 view/frontend/web/css/style.css                    |  22 +---
 .../web/js/action/check-email-availability.js      |   2 +-
 view/frontend/web/js/action/gift-message-item.js   |   2 +-
 view/frontend/web/js/action/gift-wrap.js           |   2 +-
 .../web/js/action/payment-total-information.js     |   2 +-
 view/frontend/web/js/action/place-order-mixins.js  |  10 +-
 .../web/js/action/set-checkout-information.js      |   2 +-
 view/frontend/web/js/action/set-payment-method.js  |   2 +-
 view/frontend/web/js/action/update-item.js         |   9 +-
 .../frontend/web/js/model/address/auto-complete.js |   2 +-
 view/frontend/web/js/model/address/type/google.js  |   2 +-
 view/frontend/web/js/model/agreement-validator.js  |   2 +-
 view/frontend/web/js/model/agreements-assigner.js  |   2 +-
 view/frontend/web/js/model/braintree-paypal.js     |   2 +-
 .../web/js/model/checkout-data-resolver.js         |   2 +-
 .../frontend/web/js/model/compatible/amazon-pay.js |   2 +-
 view/frontend/web/js/model/gift-message.js         |   2 +-
 view/frontend/web/js/model/gift-wrap.js            |   2 +-
 view/frontend/web/js/model/osc-data.js             |   2 +-
 view/frontend/web/js/model/osc-loader.js           |   2 +-
 view/frontend/web/js/model/osc-loader/discount.js  |   2 +-
 view/frontend/web/js/model/payment-service.js      |   2 +-
 .../js/model/paypal/set-payment-method-mixin.js    |   2 +-
 view/frontend/web/js/model/resource-url-manager.js |   2 +-
 .../frontend/web/js/model/shipping-rate-service.js |   2 +-
 .../web/js/model/shipping-rates-validator.js       |   2 +-
 .../js/model/shipping-save-processor/checkout.js   |   2 +-
 view/frontend/web/js/view/amazon.js                |   2 +-
 view/frontend/web/js/view/authentication.js        |   2 +-
 view/frontend/web/js/view/billing-address.js       |  21 +++-
 view/frontend/web/js/view/delivery-time.js         |   2 +-
 view/frontend/web/js/view/form/element/email.js    |   2 +-
 view/frontend/web/js/view/form/element/region.js   |   2 +-
 view/frontend/web/js/view/form/element/street.js   |   2 +-
 view/frontend/web/js/view/geoip.js                 |   2 +-
 view/frontend/web/js/view/payment.js               |   6 +-
 view/frontend/web/js/view/payment/discount.js      |   2 +-
 .../method-renderer/braintree-paypal-mixins.js     |   2 +-
 view/frontend/web/js/view/review/addition.js       |   2 +-
 .../web/js/view/review/addition/gift-message.js    |   2 +-
 .../web/js/view/review/addition/gift-wrap.js       |   2 +-
 .../web/js/view/review/addition/newsletter.js      |   2 +-
 .../web/js/view/review/checkout-agreements.js      |   2 +-
 view/frontend/web/js/view/review/comment.js        |   2 +-
 view/frontend/web/js/view/review/placeOrder.js     |  23 +---
 .../shipping-address/address-renderer/default.js   |   2 +-
 view/frontend/web/js/view/shipping-postnl.js       |   2 +-
 view/frontend/web/js/view/shipping.js              |  31 +++++-
 view/frontend/web/js/view/summary/gift-wrap.js     |   2 +-
 view/frontend/web/js/view/summary/item/details.js  |  57 ++--------
 view/frontend/web/js/view/survey.js                |   2 +-
 view/frontend/web/template/1column.html            |   2 +-
 view/frontend/web/template/2columns-floating.html  |  78 -------------
 view/frontend/web/template/2columns.html           |   2 +-
 view/frontend/web/template/3columns-colspan.html   |   2 +-
 view/frontend/web/template/3columns.html           |   2 +-
 .../container/address/billing-address.html         |   2 +-
 .../container/address/billing/checkbox.html        |   2 +-
 .../template/container/address/billing/create.html |   2 +-
 .../container/address/shipping-address.html        |   2 +-
 .../address/shipping/address-renderer/default.html |   2 +-
 .../template/container/address/shipping/form.html  |   2 +-
 .../web/template/container/authentication.html     |   2 +-
 .../web/template/container/delivery-time.html      |   2 +-
 .../web/template/container/form/element/email.html |   2 +-
 .../web/template/container/form/element/input.html |   2 +-
 .../template/container/form/element/street.html    |   2 +-
 .../web/template/container/form/field.html         |   2 +-
 view/frontend/web/template/container/payment.html  |   2 +-
 .../web/template/container/payment/discount.html   |   2 +-
 .../web/template/container/review/addition.html    |   2 +-
 .../container/review/addition/gift-message.html    |   2 +-
 .../container/review/addition/gift-wrap.html       |   2 +-
 .../container/review/addition/newsletter.html      |   2 +-
 .../web/template/container/review/comment.html     |   2 +-
 .../web/template/container/review/discount.html    |   2 +-
 .../web/template/container/review/place-order.html |   8 +-
 view/frontend/web/template/container/shipping.html |   2 +-
 view/frontend/web/template/container/sidebar.html  |   4 +-
 view/frontend/web/template/container/summary.html  |   2 +-
 .../web/template/container/summary/cart-items.html |  19 +---
 .../web/template/container/summary/gift-wrap.html  |   2 +-
 .../template/container/summary/item/details.html   |   4 +-
 208 files changed, 289 insertions(+), 1014 deletions(-)
~~~
### v2.4.5 to v2.4.4
~~~
 Model/DefaultConfigProvider.php                    | 111 ++++++---------------
 composer.json                                      |   2 +-
 etc/adminhtml/system.xml                           |   2 +-
 .../web/js/model/shipping-rates-validator.js       |   7 +-
 view/frontend/web/js/view/billing-address.js       |   6 +-
 view/frontend/web/js/view/shipping.js              |   1 -
 view/frontend/web/js/view/summary/item/details.js  |  57 ++++-------
 7 files changed, 58 insertions(+), 128 deletions(-)
~~~
### v2.4.4 to v2.4.3
~~~
 Block/Checkout/LayoutProcessor.php              |  6 ---
 Controller/Index/Index.php                      | 17 ++++---
 Helper/Address.php                              |  6 +--
 Model/Plugin/Customer/AccountManagement.php     | 63 -------------------------
 Observer/QuoteSubmitSuccess.php                 | 14 +-----
 composer.json                                   |  2 +-
 etc/di.xml                                      |  5 +-
 view/frontend/web/js/view/billing-address.js    | 19 --------
 view/frontend/web/js/view/form/element/email.js |  4 --
 view/frontend/web/js/view/payment.js            |  6 ---
 view/frontend/web/js/view/shipping.js           | 24 ----------
 11 files changed, 15 insertions(+), 151 deletions(-)
~~~
### v2.4.2 to v2.4.1
~~~
 Api/GuestCheckoutManagementInterface.php           |  11 -
 Block/Checkout/LayoutProcessor.php                 | 669 ++++++++++-----------
 Helper/Config.php                                  |   8 -
 Model/CheckoutRegister.php                         |  12 +-
 Model/DefaultConfigProvider.php                    | 369 ++++++------
 Model/GuestCheckoutManagement.php                  |  29 +-
 Model/Plugin/Authorization/UserContext.php         |  78 ---
 Model/Plugin/Quote/AccessChangeQuoteControl.php    |  99 +++
 Observer/QuoteSubmitSuccess.php                    |  17 +-
 Observer/RedirectToOneStepCheckout.php             |  11 +-
 composer.json                                      |   2 +-
 etc/webapi.xml                                     |   6 -
 etc/webapi_rest/di.xml                             |   4 +-
 .../layout/onestepcheckout_index_index.xml         |   1 -
 view/frontend/requirejs-config.js                  |   6 +-
 .../web/js/action/check-email-availability.js      |  22 -
 .../save-email-to-quote.js}                        |  30 +-
 view/frontend/web/js/model/resource-url-manager.js |  11 +-
 view/frontend/web/js/view/amazon.js                |  41 --
 view/frontend/web/js/view/billing-address.js       |  10 +-
 view/frontend/web/js/view/form/element/email.js    |  35 +-
 view/frontend/web/js/view/shipping.js              |  29 +-
 .../container/address/billing-address.html         |  42 +-
 .../container/address/shipping-address.html        |  26 +-
 .../web/template/container/form/element/email.html |   5 -
 25 files changed, 729 insertions(+), 844 deletions(-)
~~~
### v2.4.1 to v2.4.0
~~~
 Api/CheckoutManagementInterface.php                |    7 +-
 Api/Data/OscDetailsInterface.php                   |    7 +-
 Api/GuestCheckoutManagementInterface.php           |   14 +-
 Block/Adminhtml/Field/Position.php                 |  177 ++-
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |    3 +-
 Block/Adminhtml/System/Config/Geoip.php            |  162 +--
 Block/Checkout/CompatibleConfig.php                |    7 +-
 Block/Checkout/LayoutProcessor.php                 |  668 +++++----
 Block/Container.php                                |   11 +-
 Block/Design.php                                   |   28 +-
 Block/Order/Totals.php                             |   34 +-
 Block/Order/View/Comment.php                       |    7 +-
 Block/Order/View/DeliveryTime.php                  |   29 +-
 Block/Order/View/Survey.php                        |   33 +-
 Block/Plugin/Link.php                              |   24 +-
 Block/Survey.php                                   |  133 +-
 Controller/Add/Index.php                           |    8 +-
 Controller/Adminhtml/Field/Position.php            |   71 +-
 Controller/Adminhtml/Field/Save.php                |  101 +-
 Controller/Adminhtml/System/Config/Geoip.php       |  135 +-
 Controller/Index/Index.php                         |  238 ++-
 Controller/Survey/Save.php                         |  138 +-
 Helper/Config.php                                  | 1528 ++++++++++----------
 Helper/Data.php                                    |  441 +++---
 Model/AgreementsValidator.php                      |   58 -
 Model/CheckoutManagement.php                       |  620 ++++----
 Model/CheckoutRegister.php                         |  221 ---
 Model/DefaultConfigProvider.php                    |  392 ++---
 Model/Geoip/Database/Reader.php                    |   43 +-
 Model/Geoip/Maxmind/Db/Reader.php                  |   20 +-
 Model/Geoip/Maxmind/Db/Reader/Decoder.php          |   87 +-
 .../Maxmind/Db/Reader/InvalidDatabaseException.php |   20 -
 Model/Geoip/Maxmind/Db/Reader/Metadata.php         |   19 -
 Model/Geoip/Maxmind/Db/Reader/Util.php             |   31 +-
 Model/Geoip/ProviderInterface.php                  |   47 +-
 Model/GuestCheckoutManagement.php                  |   50 +-
 Model/OscDetails.php                               |    9 +-
 Model/Plugin/Checkout/ShippingMethodManagement.php |  241 +--
 Model/Plugin/Customer/Address.php                  |   33 +-
 .../Plugin/Eav/Model/Validator/Attribute/Data.php  |   60 -
 Model/Plugin/Paypal/Model/Express.php              |   47 -
 Model/Plugin/Quote/AccessChangeQuoteControl.php    |   99 --
 Model/Plugin/Quote/GiftWrap.php                    |   87 +-
 Model/Plugin/Quote/QuoteManagement.php             |   50 -
 Model/System/Config/Source/AddressSuggest.php      |    3 +-
 Model/System/Config/Source/CheckboxStyle.php       |    5 +-
 Model/System/Config/Source/ComponentPosition.php   |   31 +-
 Model/System/Config/Source/DeliveryTime.php        |    3 +-
 Model/System/Config/Source/Design.php              |   17 +-
 Model/System/Config/Source/Giftwrap.php            |    5 +-
 Model/System/Config/Source/Layout.php              |    3 +-
 Model/System/Config/Source/PaymentMethods.php      |  147 +-
 Model/System/Config/Source/RadioStyle.php          |    7 +-
 Model/System/Config/Source/ShippingMethods.php     |    7 +-
 Model/System/Config/Source/Survey.php              |   64 +-
 Model/Total/Creditmemo/GiftWrap.php                |   96 +-
 Model/Total/Invoice/GiftWrap.php                   |   72 +-
 Model/Total/Quote/GiftWrap.php                     |  263 ++--
 Observer/CheckoutSubmitBefore.php                  |  186 +++
 Observer/IsAllowedGuestCheckoutObserver.php        |   51 +-
 Observer/OscConfigObserver.php                     |   26 +-
 Observer/PaypalExpressPlaceOrder.php               |   57 -
 Observer/QuoteSubmitBefore.php                     |   16 +-
 Observer/QuoteSubmitSuccess.php                    |   62 +-
 Observer/RedirectToOneStepCheckout.php             |   70 +-
 README.md                                          |   16 +-
 Setup/InstallData.php                              |   60 +-
 Setup/UpgradeData.php                              |  118 +-
 USER-GUIDE.md                                      |   45 +-
 composer.json                                      |    2 +-
 etc/acl.xml                                        |    5 +-
 etc/adminhtml/di.xml                               |    2 +-
 etc/adminhtml/events.xml                           |    1 +
 etc/adminhtml/menu.xml                             |    4 +-
 etc/adminhtml/routes.xml                           |    2 +-
 etc/adminhtml/system.xml                           |    2 +-
 etc/config.xml                                     |    3 +-
 etc/di.xml                                         |    6 +-
 etc/events.xml                                     |    7 +-
 etc/extension_attributes.xml                       |    2 +-
 etc/frontend/di.xml                                |    6 +-
 etc/frontend/events.xml                            |    3 +-
 etc/frontend/routes.xml                            |    3 +-
 etc/frontend/sections.xml                          |    3 +-
 etc/module.xml                                     |    3 +-
 etc/sales.xml                                      |    3 +-
 etc/webapi.xml                                     |    9 +-
 etc/webapi_rest/di.xml                             |   10 +-
 i18n/af_ZA.csv                                     |    2 +-
 i18n/ar_SA.csv                                     |    2 +-
 i18n/be_BY.csv                                     |    2 +-
 i18n/ca_ES.csv                                     |    2 +-
 i18n/cs_CZ.csv                                     |    2 +-
 i18n/da_DK.csv                                     |    2 +-
 i18n/de_DE.csv                                     |    2 +-
 i18n/el_GR.csv                                     |    2 +-
 i18n/en_US.csv                                     |    2 +-
 i18n/es_ES.csv                                     |    2 +-
 i18n/fi_FI.csv                                     |    2 +-
 i18n/fr_FR.csv                                     |    2 +-
 i18n/he_IL.csv                                     |    2 +-
 i18n/hu_HU.csv                                     |    2 +-
 i18n/it_IT.csv                                     |    2 +-
 i18n/ja_JP.csv                                     |    2 +-
 i18n/ko_KR.csv                                     |    2 +-
 i18n/nl_NL.csv                                     |    2 +-
 i18n/no_NO.csv                                     |    2 +-
 i18n/pl_PL.csv                                     |    2 +-
 i18n/pt_BR.csv                                     |    2 +-
 i18n/pt_PT.csv                                     |    2 +-
 i18n/ro_RO.csv                                     |    2 +-
 i18n/ru_RU.csv                                     |    2 +-
 i18n/sr_SP.csv                                     |    2 +-
 i18n/sv_SE.csv                                     |    2 +-
 i18n/tr_TR.csv                                     |    2 +-
 i18n/uk_UA.csv                                     |    2 +-
 i18n/vi_VN.csv                                     |    2 +-
 i18n/zh_CN.csv                                     |    2 +-
 i18n/zh_TW.csv                                     |    2 +-
 registration.php                                   |    2 +-
 .../layout/onestepcheckout_field_position.xml      |    5 +-
 .../layout/sales_order_creditmemo_new.xml          |    3 +-
 .../layout/sales_order_creditmemo_updateqty.xml    |    3 +-
 .../layout/sales_order_creditmemo_view.xml         |    3 +-
 .../adminhtml/layout/sales_order_invoice_email.xml |    3 +-
 view/adminhtml/layout/sales_order_invoice_new.xml  |    3 +-
 .../adminhtml/layout/sales_order_invoice_print.xml |    3 +-
 .../layout/sales_order_invoice_updateqty.xml       |    3 +-
 view/adminhtml/layout/sales_order_invoice_view.xml |    3 +-
 view/adminhtml/layout/sales_order_view.xml         |    3 +-
 view/adminhtml/templates/field/position.phtml      |    2 +-
 view/adminhtml/templates/order/additional.phtml    |    2 +-
 view/adminhtml/templates/order/view/comment.phtml  |    2 +-
 .../templates/order/view/delivery-time.phtml       |    2 +-
 view/adminhtml/templates/order/view/survey.phtml   |    2 +-
 view/adminhtml/templates/system/config/geoip.phtml |    8 +-
 view/adminhtml/web/css/style.css                   |    2 +-
 view/frontend/layout/checkout_onepage_success.xml  |    2 +-
 .../layout/onestepcheckout_index_index.xml         |    2 +-
 .../layout/sales_email_order_creditmemo_items.xml  |    2 +-
 .../layout/sales_email_order_invoice_items.xml     |    3 +-
 view/frontend/layout/sales_email_order_items.xml   |   23 +-
 view/frontend/layout/sales_order_creditmemo.xml    |    2 +-
 view/frontend/layout/sales_order_invoice.xml       |    2 +-
 view/frontend/layout/sales_order_print.xml         |    2 +-
 .../layout/sales_order_printcreditmemo.xml         |    2 +-
 view/frontend/layout/sales_order_printinvoice.xml  |    2 +-
 view/frontend/layout/sales_order_view.xml          |    2 +-
 view/frontend/requirejs-config.js                  |    8 +-
 view/frontend/templates/description.phtml          |    2 +-
 view/frontend/templates/design.phtml               |    4 +-
 .../templates/onepage/compatible-config.phtml      |    3 +-
 .../templates/onepage/success/survey.phtml         |    8 +-
 view/frontend/templates/order/additional.phtml     |    2 +-
 view/frontend/templates/order/view/comment.phtml   |    3 +-
 .../templates/order/view/delivery-time.phtml       |    2 +-
 view/frontend/templates/order/view/survey.phtml    |    2 +-
 view/frontend/web/css/style.css                    |    8 +-
 view/frontend/web/js/action/gift-message-item.js   |    2 +-
 view/frontend/web/js/action/gift-wrap.js           |   20 +-
 .../web/js/action/payment-total-information.js     |    2 +-
 view/frontend/web/js/action/place-order-mixins.js  |   48 -
 view/frontend/web/js/action/save-email-to-quote.js |   40 -
 .../web/js/action/set-checkout-information.js      |    2 +-
 view/frontend/web/js/action/set-payment-method.js  |   69 -
 view/frontend/web/js/action/update-item.js         |    2 +-
 .../frontend/web/js/model/address/auto-complete.js |    2 +-
 view/frontend/web/js/model/address/type/google.js  |    7 +-
 view/frontend/web/js/model/agreement-validator.js  |    2 +-
 view/frontend/web/js/model/agreements-assigner.js  |   25 +-
 view/frontend/web/js/model/braintree-paypal.js     |   20 -
 .../web/js/model/checkout-data-resolver.js         |    2 +-
 view/frontend/web/js/model/gift-message.js         |    2 +-
 view/frontend/web/js/model/gift-wrap.js            |   20 +-
 view/frontend/web/js/model/osc-data.js             |    2 +-
 view/frontend/web/js/model/osc-loader.js           |    2 +-
 view/frontend/web/js/model/osc-loader/discount.js  |    2 +-
 view/frontend/web/js/model/payment-service.js      |    2 +-
 .../js/model/paypal/set-payment-method-mixin.js    |   35 -
 view/frontend/web/js/model/resource-url-manager.js |   10 +-
 .../frontend/web/js/model/shipping-rate-service.js |    2 +-
 .../web/js/model/shipping-rates-validator.js       |    2 +-
 .../js/model/shipping-save-processor/checkout.js   |   17 +-
 view/frontend/web/js/view/authentication.js        |    2 +-
 view/frontend/web/js/view/billing-address.js       |   15 +-
 view/frontend/web/js/view/delivery-time.js         |    2 +-
 view/frontend/web/js/view/form/element/email.js    |   31 +-
 view/frontend/web/js/view/form/element/region.js   |    2 +-
 view/frontend/web/js/view/form/element/street.js   |    2 +-
 view/frontend/web/js/view/geoip.js                 |    2 +-
 view/frontend/web/js/view/payment.js               |    2 +-
 view/frontend/web/js/view/payment/discount.js      |    2 +-
 .../method-renderer/braintree-paypal-mixins.js     |   51 +-
 view/frontend/web/js/view/review/addition.js       |    2 +-
 .../web/js/view/review/addition/gift-message.js    |    2 +-
 .../web/js/view/review/addition/gift-wrap.js       |    2 +-
 .../web/js/view/review/addition/newsletter.js      |    4 +-
 .../web/js/view/review/checkout-agreements.js      |    2 +-
 view/frontend/web/js/view/review/comment.js        |    2 +-
 view/frontend/web/js/view/review/placeOrder.js     |   43 +-
 .../shipping-address/address-renderer/default.js   |    2 +-
 view/frontend/web/js/view/shipping-postnl.js       |   20 -
 view/frontend/web/js/view/shipping.js              |   13 +-
 view/frontend/web/js/view/summary/gift-wrap.js     |    2 +-
 view/frontend/web/js/view/summary/item/details.js  |   15 +-
 view/frontend/web/js/view/survey.js                |    3 +-
 view/frontend/web/template/1column.html            |    3 +-
 view/frontend/web/template/2columns.html           |    2 +-
 view/frontend/web/template/3columns-colspan.html   |    3 +-
 view/frontend/web/template/3columns.html           |    3 +-
 .../container/address/billing-address.html         |    2 +-
 .../container/address/billing/checkbox.html        |    2 +-
 .../template/container/address/billing/create.html |    2 +-
 .../container/address/shipping-address.html        |    2 +-
 .../address/shipping/address-renderer/default.html |    2 +-
 .../template/container/address/shipping/form.html  |    2 +-
 .../web/template/container/authentication.html     |    2 +-
 .../web/template/container/delivery-time.html      |    2 +-
 .../web/template/container/form/element/email.html |    2 +-
 .../web/template/container/form/element/input.html |    2 +-
 .../template/container/form/element/street.html    |    4 +-
 .../web/template/container/form/field.html         |    2 +-
 view/frontend/web/template/container/payment.html  |    2 +-
 .../web/template/container/payment/discount.html   |    2 +-
 .../web/template/container/review/addition.html    |    2 +-
 .../container/review/addition/gift-message.html    |    6 +-
 .../container/review/addition/gift-wrap.html       |    2 +-
 .../container/review/addition/newsletter.html      |    2 +-
 .../web/template/container/review/comment.html     |    2 +-
 .../web/template/container/review/discount.html    |    2 +-
 .../web/template/container/review/place-order.html |   15 +-
 view/frontend/web/template/container/shipping.html |    2 +-
 view/frontend/web/template/container/sidebar.html  |    2 +-
 view/frontend/web/template/container/summary.html  |    2 +-
 .../web/template/container/summary/cart-items.html |    2 +-
 .../web/template/container/summary/gift-wrap.html  |    2 +-
 .../template/container/summary/item/details.html   |    6 +-
 237 files changed, 3682 insertions(+), 4914 deletions(-)
~~~
### v2.4.0 to v2.3.6
~~~
 Block/Adminhtml/System/Config/Geoip.php            | 115 ------
 Block/Checkout/CompatibleConfig.php                |  60 ---
 Block/Checkout/LayoutProcessor.php                 |  35 +-
 Block/Design.php                                   |  38 +-
 Block/Order/View/DeliveryTime.php                  |  13 -
 Block/Survey.php                                   |   2 +-
 CHANGELOG                                          |   1 -
 Controller/Add/Index.php                           |   4 +-
 Controller/Adminhtml/System/Config/Geoip.php       | 107 ------
 Controller/Index/Index.php                         |  30 +-
 Helper/Config.php                                  | 104 ++---
 Helper/Data.php                                    | 123 +-----
 LICENSE                                            |   1 -
 Model/DefaultConfigProvider.php                    |  71 +---
 Model/Geoip/Database/Reader.php                    | 148 --------
 Model/Geoip/Maxmind/Db/Reader.php                  | 369 ------------------
 Model/Geoip/Maxmind/Db/Reader/Decoder.php          | 422 ---------------------
 .../Maxmind/Db/Reader/InvalidDatabaseException.php |   9 -
 Model/Geoip/Maxmind/Db/Reader/Metadata.php         |  77 ----
 Model/Geoip/Maxmind/Db/Reader/Util.php             |  35 --
 Model/Geoip/ProviderInterface.php                  |  20 -
 Model/System/Config/Source/CheckboxStyle.php       |  48 ---
 Model/System/Config/Source/Design.php              |  14 +-
 Model/System/Config/Source/RadioStyle.php          |  48 ---
 Observer/CheckoutSubmitBefore.php                  |  43 ++-
 Observer/OscConfigObserver.php                     |  54 +--
 Observer/QuoteSubmitBefore.php                     |   4 -
 Observer/RedirectToOneStepCheckout.php             |   6 +-
 README.md                                          |  52 +--
 Setup/UpgradeData.php                              |   3 -
 USER-GUIDE.md                                      |  80 ----
 composer.json                                      |  26 +-
 etc/adminhtml/system.xml                           | 117 ++----
 etc/config.xml                                     |   8 +-
 etc/module.xml                                     |   2 +-
 i18n/af_ZA.csv                                     |  95 -----
 i18n/ar_SA.csv                                     |  95 -----
 i18n/be_BY.csv                                     |  95 -----
 i18n/ca_ES.csv                                     |  95 -----
 i18n/cs_CZ.csv                                     |  95 -----
 i18n/da_DK.csv                                     |  95 -----
 i18n/de_DE.csv                                     |  95 -----
 i18n/el_GR.csv                                     |  95 -----
 i18n/en_US.csv                                     |  64 +---
 i18n/es_ES.csv                                     |  95 -----
 i18n/fi_FI.csv                                     |  95 -----
 i18n/fr_FR.csv                                     |  95 -----
 i18n/he_IL.csv                                     |  95 -----
 i18n/hu_HU.csv                                     |  95 -----
 i18n/it_IT.csv                                     |  95 -----
 i18n/ja_JP.csv                                     |  95 -----
 i18n/ko_KR.csv                                     |  95 -----
 i18n/nl_NL.csv                                     |  95 -----
 i18n/no_NO.csv                                     |  95 -----
 i18n/pl_PL.csv                                     |  95 -----
 i18n/pt_BR.csv                                     |  95 -----
 i18n/pt_PT.csv                                     |  95 -----
 i18n/ro_RO.csv                                     |  95 -----
 i18n/ru_RU.csv                                     |  95 -----
 i18n/sr_SP.csv                                     |  95 -----
 i18n/sv_SE.csv                                     |  95 -----
 i18n/tr_TR.csv                                     |  95 -----
 i18n/uk_UA.csv                                     |  95 -----
 i18n/vi_VN.csv                                     |  95 -----
 i18n/zh_CN.csv                                     |  95 -----
 i18n/zh_TW.csv                                     |  95 -----
 .../templates/order/view/delivery-time.phtml       |  12 +-
 view/adminhtml/templates/system/config/geoip.phtml |  73 ----
 view/adminhtml/web/css/source/_module.less         |   6 +
 .../layout/onestepcheckout_index_index.xml         |   8 +-
 view/frontend/requirejs-config.js                  |   9 +-
 view/frontend/templates/design.phtml               | 360 +++---------------
 .../templates/onepage/compatible-config.phtml      |  38 --
 .../templates/onepage/success/survey.phtml         |   2 +-
 .../templates/order/view/delivery-time.phtml       |  12 +-
 view/frontend/web/css/style.css                    |  87 +----
 view/frontend/web/js/action/gift-message-item.js   |  67 ----
 .../web/js/model/billing-before-shipping.js        |  33 ++
 view/frontend/web/js/model/braintree-paypal.js     |   8 -
 view/frontend/web/js/model/gift-message.js         |  16 +-
 view/frontend/web/js/model/resource-url-manager.js |   8 -
 .../web/js/model/shipping-rates-validator.js       |  60 ++-
 view/frontend/web/js/view/authentication.js        |  18 +-
 view/frontend/web/js/view/billing-address.js       | 264 ++++++++++++-
 view/frontend/web/js/view/delivery-time.js         |  13 -
 view/frontend/web/js/view/form/element/email.js    |  20 +-
 view/frontend/web/js/view/form/element/region.js   |   4 +-
 view/frontend/web/js/view/geoip.js                 |  71 ----
 .../method-renderer/braintree-paypal-mixins.js     |  27 --
 view/frontend/web/js/view/review/placeOrder.js     | 115 +-----
 view/frontend/web/js/view/shipping-postnl.js       |  55 ---
 view/frontend/web/js/view/shipping.js              |  78 +++-
 view/frontend/web/js/view/summary/item/details.js  | 132 +------
 view/frontend/web/template/1column.html            |  26 +-
 view/frontend/web/template/2columns.html           |  29 +-
 view/frontend/web/template/3columns-colspan.html   |  43 +--
 view/frontend/web/template/3columns.html           |  28 +-
 .../container/address/billing-address.html         |  18 +-
 .../template/container/address/billing/create.html |  22 +-
 .../container/address/shipping-address.html        |  27 +-
 .../web/template/container/authentication.html     |  26 +-
 .../web/template/container/delivery-time.html      |  10 -
 .../web/template/container/form/element/email.html |  23 +-
 .../web/template/container/form/element/input.html |   2 +-
 .../web/template/container/form/field.html         |  67 ----
 view/frontend/web/template/container/payment.html  |  11 -
 .../container/review/addition/gift-message.html    |  59 +--
 .../web/template/container/review/place-order.html |  36 +-
 view/frontend/web/template/container/shipping.html |  26 --
 view/frontend/web/template/container/summary.html  |  35 +-
 .../template/container/summary/item/details.html   |  71 ----
 111 files changed, 797 insertions(+), 6561 deletions(-)
~~~
### v2.3.6 to v2.3.5
~~~
 Block/Checkout/LayoutProcessor.php                 |   8 +-
 Block/Order/Totals.php                             |   2 +-
 Block/Order/View/Survey.php                        |  83 -------
 Block/Survey.php                                   | 105 --------
 Controller/Add/Index.php                           |   3 +-
 Controller/Survey/Save.php                         | 104 --------
 Helper/Config.php                                  |  84 +------
 Model/CheckoutManagement.php                       |  81 +------
 Model/DefaultConfigProvider.php                    |  40 ++--
 Model/System/Config/Source/PaymentMethods.php      |  31 +--
 Model/System/Config/Source/Survey.php              |  50 ----
 Model/Total/Quote/GiftWrap.php                     |   2 +-
 Observer/CheckoutSubmitBefore.php                  |  43 +---
 Observer/QuoteSubmitBefore.php                     |   2 +-
 Observer/RedirectToOneStepCheckout.php             |  74 ------
 Setup/UpgradeData.php                              |   4 -
 composer.json                                      |  12 +-
 etc/adminhtml/system.xml                           |  50 +---
 etc/config.xml                                     |   2 -
 etc/frontend/events.xml                            |   3 -
 etc/module.xml                                     |  17 +-
 i18n/en_US.csv                                     |   3 -
 view/adminhtml/layout/sales_order_view.xml         |   2 -
 view/adminhtml/templates/order/view/survey.phtml   |  39 ---
 view/adminhtml/web/css/source/_module.less         |   6 -
 view/frontend/layout/checkout_onepage_success.xml  |  32 ---
 .../layout/onestepcheckout_index_index.xml         |  14 +-
 view/frontend/layout/sales_order_view.xml          |   2 -
 .../templates/onepage/success/survey.phtml         |  51 ----
 view/frontend/templates/order/view/survey.phtml    |  36 ---
 view/frontend/web/css/style.css                    |  20 +-
 view/frontend/web/js/action/gift-wrap.js           |   7 +-
 .../web/js/model/billing-before-shipping.js        |  33 ---
 .../web/js/model/shipping-rates-validator.js       |  74 +-----
 view/frontend/web/js/view/billing-address.js       | 264 ++-------------------
 view/frontend/web/js/view/delivery-time.js         |  13 +-
 view/frontend/web/js/view/form/element/email.js    |   5 -
 .../web/js/view/review/addition/gift-wrap.js       |   2 +-
 view/frontend/web/js/view/shipping.js              |  76 ++----
 view/frontend/web/js/view/summary/gift-wrap.js     |   7 +-
 view/frontend/web/js/view/survey.js                |  86 -------
 view/frontend/web/template/1column.html            |  10 -
 view/frontend/web/template/2columns.html           |  10 -
 view/frontend/web/template/3columns-colspan.html   |  24 +-
 view/frontend/web/template/3columns.html           |  22 +-
 .../container/address/billing-address.html         |  12 +-
 .../container/address/shipping-address.html        |  21 +-
 .../web/template/container/delivery-time.html      |   3 -
 .../web/template/container/form/element/email.html |   6 +-
 .../web/template/container/review/comment.html     |   2 +-
 50 files changed, 164 insertions(+), 1518 deletions(-)
~~~
### v2.3.5 to v2.3.4
~~~
 Controller/Index/Index.php                         |   3 +-
 Helper/Config.php                                  | 234 +++++++++++----------
 Observer/IsAllowedGuestCheckoutObserver.php        |  55 -----
 composer.json                                      |  12 +-
 etc/adminhtml/system.xml                           |   1 -
 etc/frontend/di.xml                                |   7 -
 etc/frontend/events.xml                            |   2 +-
 etc/frontend/sections.xml                          |  12 --
 .../layout/onestepcheckout_index_index.xml         |   2 -
 view/frontend/requirejs-config.js                  |   9 +-
 view/frontend/web/js/model/agreements-assigner.js  |  39 ----
 view/frontend/web/js/model/osc-loader/discount.js  |  46 ----
 view/frontend/web/js/view/delivery-time.js         |  42 ++--
 view/frontend/web/js/view/payment/discount.js      |   8 +-
 .../web/js/view/review/addition/newsletter.js      |   9 +-
 .../web/template/container/delivery-time.html      |   2 +-
 .../web/template/container/payment/discount.html   |  65 ------
 .../web/template/container/review/discount.html    |   3 +-
 view/frontend/web/template/container/shipping.html |   2 +-
 19 files changed, 167 insertions(+), 386 deletions(-)
~~~
### v2.3.4 to v2.3.3
~~~
 Block/Adminhtml/Field/Position.php                 |  7 -----
 Block/Order/Totals.php                             |  3 ---
 Controller/Index/Index.php                         |  4 ---
 Helper/Config.php                                  |  5 ----
 Helper/Data.php                                    | 24 ++++++-----------
 Model/DefaultConfigProvider.php                    |  5 ----
 Model/Plugin/Checkout/ShippingMethodManagement.php |  5 ----
 Model/System/Config/Source/ComponentPosition.php   |  7 -----
 Model/System/Config/Source/DeliveryTime.php        |  7 -----
 Model/System/Config/Source/Giftwrap.php            |  9 +------
 Model/Total/Quote/GiftWrap.php                     |  7 -----
 Observer/OscConfigObserver.php                     | 30 +++++-----------------
 view/frontend/web/css/style.css                    |  9 -------
 .../web/js/model/shipping-rates-validator.js       | 14 ++++------
 14 files changed, 21 insertions(+), 115 deletions(-)
~~~
### v2.3.3 to v2.3.2
~~~
 Model/CheckoutManagement.php                       |  8 +--
 Model/System/Config/Source/PaymentMethods.php      | 57 +++++++---------------
 Observer/CheckoutSubmitBefore.php                  |  4 +-
 view/adminhtml/templates/order/additional.phtml    |  6 +--
 .../templates/order/view/delivery-time.phtml       |  3 +-
 view/frontend/templates/design.phtml               | 21 +++-----
 .../frontend/web/js/model/shipping-rate-service.js |  9 +++-
 .../web/js/model/shipping-rates-validator.js       |  6 +--
 view/frontend/web/js/view/billing-address.js       |  1 -
 view/frontend/web/template/3columns-colspan.html   |  2 +-
 .../container/address/billing-address.html         |  2 +-
 .../container/address/shipping-address.html        |  2 +-
 12 files changed, 47 insertions(+), 74 deletions(-)
~~~
### v2.3.2 to v2.3.1
~~~
 Helper/Config.php                                  |  23 +--
 Model/DefaultConfigProvider.php                    |   2 +-
 Model/Plugin/Checkout/ShippingMethodManagement.php | 219 ++++++++++-----------
 etc/frontend/events.xml                            |  27 ---
 view/frontend/requirejs-config.js                  |   3 -
 view/frontend/web/css/style.css                    |   6 +-
 view/frontend/web/js/view/billing-address.js       |  35 ++--
 view/frontend/web/js/view/shipping.js              |   2 -
 8 files changed, 129 insertions(+), 188 deletions(-)
~~~
### v2.3.1 to v2.3.0
~~~
~~~
### v2.3.0 to v2.2.0
~~~
 Block/Order/View/DeliveryTime.php                  |  74 -----------
 Controller/Add/Index.php                           |   2 +-
 Helper/Config.php                                  |  50 +------
 Model/CheckoutManagement.php                       |  61 +--------
 Model/DefaultConfigProvider.php                    |  65 +++-------
 Model/System/Config/Source/DeliveryTime.php        |  48 -------
 Model/System/Config/Source/PaymentMethods.php      |  82 ++++++------
 Observer/CheckoutSubmitBefore.php                  |  14 +-
 Observer/OscConfigObserver.php                     |  66 ----------
 Observer/QuoteSubmitBefore.php                     |  86 ++++++------
 Setup/UpgradeData.php                              |   6 -
 etc/adminhtml/events.xml                           |  28 ----
 etc/adminhtml/system.xml                           | 144 ++++++---------------
 etc/module.xml                                     |   2 +-
 view/adminhtml/layout/sales_order_view.xml         |   5 -
 .../templates/order/view/delivery-time.phtml       |  35 -----
 view/adminhtml/web/css/style.css                   |   8 +-
 .../layout/onestepcheckout_index_index.xml         |  17 ---
 view/frontend/layout/sales_order_view.xml          |   2 -
 view/frontend/templates/design.phtml               |   2 +-
 .../templates/order/view/delivery-time.phtml       |  33 -----
 view/frontend/web/css/style.css                    |  31 ++---
 view/frontend/web/js/model/gift-message.js         |  77 -----------
 view/frontend/web/js/model/resource-url-manager.js |   1 +
 .../web/js/model/shipping-rates-validator.js       |   9 +-
 .../js/model/shipping-save-processor/checkout.js   |  15 +--
 view/frontend/web/js/view/authentication.js        |   4 -
 view/frontend/web/js/view/delivery-time.js         |  69 ----------
 .../web/js/view/review/addition/gift-message.js    | 105 ---------------
 .../web/template/container/delivery-time.html      |  30 -----
 .../container/review/addition/gift-message.html    |  52 --------
 31 files changed, 160 insertions(+), 1063 deletions(-)
~~~
### v2.2.0 to v2.1.0
~~~
~~~
### v2.1.0 to v2.0.1
~~~
 Api/CheckoutManagementInterface.php                |   9 -
 Api/GuestCheckoutManagementInterface.php           |  11 +-
 Block/Adminhtml/Field/Position.php                 | 122 ---
 Block/Checkout/LayoutProcessor.php                 | 568 ++++++-------
 Block/{Design.php => Generator/Css.php}            |   6 +-
 Block/Order/Totals.php                             |  46 --
 Controller/Add/Index.php                           |   1 -
 Controller/Adminhtml/Field/Position.php            |  67 --
 Controller/Adminhtml/Field/Save.php                |  89 --
 Controller/Index/Index.php                         | 150 ++--
 Helper/Config.php                                  | 905 ++++++++-------------
 Helper/Data.php                                    | 336 ++++++--
 Model/CheckoutManagement.php                       | 387 +++++----
 Model/DefaultConfigProvider.php                    | 257 +++---
 Model/GuestCheckoutManagement.php                  |  13 -
 Model/Plugin/Customer/Address.php                  |  48 --
 Model/Plugin/Quote/GiftWrap.php                    |  80 --
 .../{Checkout => }/ShippingMethodManagement.php    |   4 +-
 .../{AddressSuggest.php => Address/Suggest.php}    |   4 +-
 Model/System/Config/Source/ComponentPosition.php   |  37 -
 Model/System/Config/Source/Enableddisabled.php     |  65 ++
 Model/System/Config/Source/Giftwrap.php            |  35 -
 .../{PaymentMethods.php => Payment/Methods.php}    |  21 +-
 .../{ShippingMethods.php => Shipping/Methods.php}  |   4 +-
 Model/Total/Creditmemo/GiftWrap.php                |  86 --
 Model/Total/Invoice/GiftWrap.php                   |  73 --
 Model/Total/Quote/GiftWrap.php                     | 159 ----
 Observer/CheckoutSubmitBefore.php                  |  41 +-
 Observer/QuoteSubmitBefore.php                     |  77 +-
 Setup/InstallData.php                              |  63 --
 Setup/InstallSchema.php                            |  51 ++
 Setup/UpgradeData.php                              |  90 --
 etc/adminhtml/menu.xml                             |  24 +-
 etc/adminhtml/system.xml                           |  46 +-
 etc/config.xml                                     |   8 +-
 etc/di.xml                                         |   8 -
 etc/events.xml                                     |   6 +-
 etc/extension_attributes.xml                       |  29 -
 .../gift-wrap.html => etc/frontend/page_types.xml  |  14 +-
 etc/module.xml                                     |   3 +-
 etc/sales.xml                                      |  39 -
 etc/webapi.xml                                     |  18 +-
 etc/webapi_rest/di.xml                             |   2 +-
 .../layout/onestepcheckout_field_position.xml      |  33 -
 .../layout/sales_order_creditmemo_new.xml          |  30 -
 .../layout/sales_order_creditmemo_updateqty.xml    |  30 -
 .../layout/sales_order_creditmemo_view.xml         |  30 -
 .../adminhtml/layout/sales_order_invoice_email.xml |  30 -
 view/adminhtml/layout/sales_order_invoice_new.xml  |  30 -
 .../adminhtml/layout/sales_order_invoice_print.xml |  30 -
 .../layout/sales_order_invoice_updateqty.xml       |  30 -
 view/adminhtml/layout/sales_order_invoice_view.xml |  30 -
 view/adminhtml/layout/sales_order_view.xml         |  12 +-
 view/adminhtml/templates/field/position.phtml      | 172 ----
 view/adminhtml/web/css/images/billing_title.png    | Bin 3193 -> 0 bytes
 view/adminhtml/web/css/images/next.png             | Bin 327 -> 0 bytes
 .../web/css/images/ui-icons_222222_256x240.png     | Bin 6922 -> 0 bytes
 view/adminhtml/web/css/jquery-ui.min.css           |   7 -
 view/adminhtml/web/css/style.css                   | 145 ----
 .../layout/onestepcheckout_index_index.xml         | 227 +++---
 .../layout/sales_email_order_creditmemo_items.xml  |  28 -
 .../layout/sales_email_order_invoice_items.xml     |  29 -
 view/frontend/layout/sales_email_order_items.xml   |  14 -
 view/frontend/layout/sales_order_creditmemo.xml    |  29 -
 view/frontend/layout/sales_order_invoice.xml       |  28 -
 view/frontend/layout/sales_order_print.xml         |  29 -
 .../layout/sales_order_printcreditmemo.xml         |  29 -
 view/frontend/layout/sales_order_printinvoice.xml  |  29 -
 view/frontend/layout/sales_order_view.xml          |  12 +-
 .../templates/{ => generator/css}/design.phtml     |  14 +-
 view/frontend/web/css/style.css                    |  39 +-
 view/frontend/web/js/action/gift-wrap.js           |  63 --
 view/frontend/web/js/action/update-item.js         |   2 +
 .../frontend/web/js/model/address/auto-complete.js |   2 +-
 view/frontend/web/js/model/agreement-validator.js  |   2 +-
 view/frontend/web/js/model/gift-wrap.js            |  17 -
 view/frontend/web/js/model/resource-url-manager.js |   8 -
 .../web/js/model/shipping-rates-validator.js       |  90 +-
 .../js/model/shipping-save-processor/checkout.js   |  25 +-
 view/frontend/web/js/view/authentication.js        | 109 ---
 view/frontend/web/js/view/billing-address.js       | 106 +--
 view/frontend/web/js/view/payment/discount.js      |  37 -
 .../web/js/view/review/addition/gift-wrap.js       |  77 --
 view/frontend/web/js/view/review/placeOrder.js     |   1 -
 view/frontend/web/js/view/shipping.js              |  59 +-
 view/frontend/web/js/view/summary/gift-wrap.js     |  55 --
 view/frontend/web/js/view/summary/item/details.js  |  18 +-
 view/frontend/web/template/1column.html            |  49 +-
 view/frontend/web/template/2columns.html           |  39 +-
 view/frontend/web/template/3columns-colspan.html   |  44 +-
 view/frontend/web/template/3columns.html           |  43 +-
 .../container/address/billing-address.html         |  18 +-
 .../template/container/address/billing/create.html |  52 +-
 .../container/address/shipping-address.html        |  18 +-
 .../template/container/address/shipping/form.html  |   8 +
 .../web/template/container/authentication.html     | 124 +--
 view/frontend/web/template/container/payment.html  |   2 +-
 .../web/template/container/payment/discount.html   |  64 ++
 .../container/review/addition/gift-wrap.html       |  32 -
 .../web/template/container/review/comment.html     |   2 +-
 .../web/template/container/review/discount.html    |  60 --
 .../web/template/container/review/place-order.html |   8 +-
 view/frontend/web/template/container/sidebar.html  |   4 +-
 view/frontend/web/template/container/summary.html  |   7 -
 104 files changed, 1960 insertions(+), 4503 deletions(-)
~~~
### v2.0.1 to v2.0.0
~~~
 Api/CheckoutManagementInterface.php                |  19 -
 Api/Data/OscDetailsInterface.php                   | 103 ++--
 Api/GuestCheckoutManagementInterface.php           |  19 -
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |  38 +-
 Block/Checkout/LayoutProcessor.php                 | 538 ++++++++--------
 Block/Container.php                                |  45 +-
 Block/Generator/Css.php                            |  92 ++-
 Block/Order/View/Comment.php                       |  86 ++-
 Block/Plugin/Link.php                              |  59 +-
 Controller/Add/Index.php                           |  51 +-
 Controller/Index/Index.php                         | 141 ++---
 Helper/Config.php                                  | 675 ++++++++++-----------
 Helper/Data.php                                    | 467 +++++++-------
 Model/CheckoutManagement.php                       | 366 ++++++-----
 Model/DefaultConfigProvider.php                    | 278 ++++-----
 Model/GuestCheckoutManagement.php                  | 149 ++---
 Model/OscDetails.php                               | 135 ++---
 Model/Plugin/ShippingMethodManagement.php          | 191 +++---
 Model/System/Config/Source/Address/Suggest.php     |  49 +-
 .../Config/Source/Address/Suggest/Fields.php       |  48 ++
 Model/System/Config/Source/Address/Trigger.php     |  51 ++
 Model/System/Config/Source/Color.php               |  44 ++
 Model/System/Config/Source/Design.php              |  50 +-
 Model/System/Config/Source/Enableddisabled.php     |   8 +-
 Model/System/Config/Source/Heading.php             |  37 ++
 Model/System/Config/Source/Layout.php              |   8 +-
 Model/System/Config/Source/Payment/Methods.php     |  13 +-
 Model/System/Config/Source/Shipping/Methods.php    |  11 +-
 Observer/CheckoutSubmitBefore.php                  |  50 +-
 Observer/QuoteSubmitBefore.php                     |  77 +--
 Observer/QuoteSubmitSuccess.php                    | 287 ++++-----
 Setup/InstallSchema.php                            |  32 +-
 etc/acl.xml                                        |  22 -
 etc/adminhtml/di.xml                               |  21 -
 etc/adminhtml/routes.xml                           |  23 +-
 etc/adminhtml/system.xml                           |  21 -
 etc/config.xml                                     |  23 +-
 etc/di.xml                                         |  19 +-
 etc/events.xml                                     |  19 +-
 etc/frontend/di.xml                                |  21 -
 etc/frontend/page_types.xml                        |  19 +-
 etc/frontend/routes.xml                            |  21 -
 etc/frontend/sections.xml                          |  19 +-
 etc/module.xml                                     |  21 -
 etc/webapi.xml                                     |  21 -
 etc/webapi_rest/di.xml                             |  21 -
 registration.php                                   |  19 -
 view/adminhtml/layout/sales_order_view.xml         |  19 +-
 view/adminhtml/templates/order/additional.phtml    |  19 +-
 view/adminhtml/templates/order/view/comment.phtml  |  19 +-
 view/adminhtml/web/css/source/_module.less         |   6 +
 .../layout/onestepcheckout_index_index.xml         |  11 +-
 view/frontend/layout/sales_order_view.xml          |  19 +-
 view/frontend/requirejs-config.js                  |  19 +-
 view/frontend/templates/description.phtml          |  21 -
 view/frontend/templates/generator/css/design.phtml |   2 +-
 view/frontend/templates/order/additional.phtml     |  19 +-
 view/frontend/templates/order/view/comment.phtml   |  22 -
 view/frontend/web/css/style.css                    | 150 +++--
 .../web/js/action/payment-total-information.js     |  24 +-
 .../web/js/action/set-checkout-information.js      |  21 +-
 view/frontend/web/js/action/update-item.js         |  25 +-
 .../frontend/web/js/model/address/auto-complete.js |   1 -
 view/frontend/web/js/model/address/type/google.js  |  10 +-
 view/frontend/web/js/model/agreement-validator.js  |  26 +-
 .../web/js/model/checkout-data-resolver.js         |  25 +-
 view/frontend/web/js/model/osc-data.js             |  25 +-
 view/frontend/web/js/model/osc-loader.js           |  27 +-
 view/frontend/web/js/model/payment-service.js      |  20 +-
 view/frontend/web/js/model/resource-url-manager.js |  30 +-
 .../frontend/web/js/model/shipping-rate-service.js |  22 +-
 .../web/js/model/shipping-rates-validator.js       |  63 +-
 .../js/model/shipping-save-processor/checkout.js   |  48 +-
 view/frontend/web/js/view/billing-address.js       |  62 +-
 view/frontend/web/js/view/form/element/email.js    |  31 +-
 view/frontend/web/js/view/form/element/region.js   |  19 +-
 view/frontend/web/js/view/form/element/street.js   |  23 +-
 view/frontend/web/js/view/payment.js               |  38 +-
 view/frontend/web/js/view/review/addition.js       |  21 +-
 .../web/js/view/review/addition/newsletter.js      |  21 +-
 .../web/js/view/review/checkout-agreements.js      |  20 +-
 view/frontend/web/js/view/review/comment.js        |  21 +-
 view/frontend/web/js/view/review/placeOrder.js     |  41 +-
 .../shipping-address/address-renderer/default.js   |  27 +-
 view/frontend/web/js/view/shipping.js              |  85 +--
 view/frontend/web/js/view/summary/item/details.js  |  45 +-
 view/frontend/web/template/1column.html            |  22 -
 view/frontend/web/template/2columns.html           |  22 -
 view/frontend/web/template/3columns-colspan.html   |  22 -
 view/frontend/web/template/3columns.html           |  22 -
 .../container/address/billing-address.html         |  20 +-
 .../container/address/billing/checkbox.html        |  20 +-
 .../template/container/address/billing/create.html |  22 +-
 .../container/address/shipping-address.html        |  22 -
 .../address/shipping/address-renderer/default.html |  20 +-
 .../template/container/address/shipping/form.html  |  20 +-
 .../web/template/container/authentication.html     |  20 +-
 .../web/template/container/form/element/email.html |  20 +-
 .../web/template/container/form/element/input.html |  20 +-
 .../template/container/form/element/street.html    |  20 +-
 view/frontend/web/template/container/payment.html  |  30 +-
 .../web/template/container/payment/discount.html   |  20 +-
 .../web/template/container/review/addition.html    |  20 +-
 .../container/review/addition/newsletter.html      |  20 +-
 .../web/template/container/review/comment.html     |  20 +-
 .../web/template/container/review/place-order.html |  20 +-
 view/frontend/web/template/container/shipping.html |  20 +-
 view/frontend/web/template/container/sidebar.html  |  19 +-
 view/frontend/web/template/container/summary.html  |  21 +-
 .../web/template/container/summary/cart-items.html |  20 +-
 .../template/container/summary/item/details.html   |  25 +-
 111 files changed, 2350 insertions(+), 3851 deletions(-)
~~~
### v2.0.0 to v1.3.0
~~~
 Api/CheckoutManagementInterface.php                |   42 -
 Api/Data/OscDetailsInterface.php                   |   70 -
 Api/GuestCheckoutManagementInterface.php           |   42 -
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |   16 -
 Block/Adminhtml/Sales/Invoice/View/Extra.php       |   38 +
 Block/Adminhtml/Sales/Order/View/Extra.php         |   41 +
 Block/Adminhtml/Sales/SalesAbstract.php            |   68 +
 .../System/Config/Form/Field/Notification.php      |   54 +
 .../System/Config/Form/Field/Term/Html.php         |  115 +
 Block/Adminhtml/Totals/Creditmemo/Giftwrap.php     |   49 +
 Block/Adminhtml/Totals/Invoice/Giftwrap.php        |   48 +
 Block/Adminhtml/Totals/Order/Giftwrap.php          |   48 +
 Block/Checkout/LayoutProcessor.php                 |  350 +-
 Block/Container.php                                |  212 +-
 Block/Container/Address.php                        |  332 ++
 Block/Container/Address/Billing.php                |   50 +
 Block/Container/Address/Billing/Attributes.php     |   28 +
 Block/Container/Address/Pca.php                    |   44 +
 Block/Container/Address/Shipping.php               |   36 +
 Block/Container/Address/Shipping/Attributes.php    |   28 +
 Block/Container/Auth/Form.php                      |   60 +
 Block/Container/Auth/Form/Popup.php                |   45 +
 Block/Container/Form.php                           |   83 +
 Block/Container/Payment/Method.php                 |   35 +
 Block/Container/Payment/Method/Available.php       |  170 +
 Block/Container/Review.php                         |   37 +
 Block/Container/Review/Comment.php                 |   55 +
 Block/Container/Review/Coupon.php                  |   59 +
 Block/Container/Review/Giftmessage.php             |   74 +
 Block/Container/Review/Giftwrap.php                |   57 +
 Block/Container/Review/Item.php                    |   95 +
 Block/Container/Review/Item/Price/Renderer.php     |   27 +
 Block/Container/Review/Newsletter.php              |   49 +
 Block/Container/Review/PlaceOrder.php              |   32 +
 Block/Container/Review/Term.php                    |  130 +
 Block/Container/Shipping/Method.php                |   66 +
 Block/Container/Shipping/Method/Available.php      |   65 +
 Block/Context.php                                  |  203 +
 Block/Generator/Css.php                            |   68 +-
 Block/Order/View/Comment.php                       |   71 -
 Block/Plugin/Checkout/AbstractCheckout.php         |   51 +
 Block/Plugin/Checkout/Cart/Sidebar.php             |   37 +
 Block/Plugin/Checkout/Onepage/Link.php             |   37 +
 Block/Plugin/Link.php                              |   49 -
 Block/Totals/Creditmemo/Giftwrap.php               |   49 +
 Block/Totals/Invoice/Giftwrap.php                  |   49 +
 Block/Totals/Order/Giftwrap.php                    |   50 +
 Controller/Add/Index.php                           |   24 -
 Controller/Ajax/AbstractCheckout.php               |  326 ++
 Controller/Ajax/AddGiftWrap.php                    |   24 +
 Controller/Ajax/AjaxCartItem.php                   |  131 +
 Controller/Ajax/ForgotPassword.php                 |   59 +
 Controller/Ajax/Login.php                          |   54 +
 Controller/Ajax/SaveAddressTrigger.php             |   78 +
 Controller/Ajax/SaveAddressTriggerShipping.php     |    7 +
 Controller/Ajax/SaveCoupon.php                     |   77 +
 Controller/Ajax/SaveForm.php                       |   23 +
 Controller/Ajax/SaveGiftMessage.php                |   29 +
 Controller/Ajax/SaveOrder.php                      |  231 +
 Controller/Ajax/SavePayment.php                    |   47 +
 Controller/Ajax/SaveShippingMethod.php             |   44 +
 Controller/Index/AbstractIndex.php                 |  105 +
 Controller/Index/AddProduct.php                    |   46 +
 Controller/Index/Index.php                         |  149 +-
 Helper/Block.php                                   |  231 +
 Helper/Checkout/Address.php                        |  125 +
 Helper/Checkout/Payment.php                        |  149 +
 Helper/Checkout/Review/Giftmessage.php             |   93 +
 Helper/Checkout/Review/Giftwrap.php                |  132 +
 Helper/Checkout/Shipping.php                       |  135 +
 Helper/Config.php                                  |  897 ++--
 Helper/Data.php                                    |  481 +-
 Model/Attribute.php                                |  142 +
 Model/CheckoutManagement.php                       |  189 -
 Model/DefaultConfigProvider.php                    |  150 -
 Model/GuestCheckoutManagement.php                  |   83 -
 Model/OscDetails.php                               |   78 -
 Model/Plugin/ShippingMethodManagement.php          |  132 -
 Model/Status.php                                   |   74 +
 Model/System/Config/Source/Address/Suggest.php     |   41 +-
 Model/System/Config/Source/Display/Block.php       |   58 +
 Model/System/Config/Source/Effect.php              |   40 +
 Model/System/Config/Source/Giftmessage.php         |   61 +
 .../Config/Source/{Design.php => Giftwrap.php}     |   38 +-
 Model/System/Config/Source/Heading/Icon.php        |   36 +
 Model/System/Config/Source/Layout.php              |   36 +-
 Model/System/Config/Source/Payment/Methods.php     |   18 +-
 Model/System/Config/Source/Shipping/Methods.php    |   11 +-
 Model/Total/Creditmemo/Giftwrap.php                |   91 +
 Model/Total/Invoice/Giftwrap.php                   |   70 +
 Model/Total/Pdf/Giftwrap.php                       |   74 +
 Model/Total/Quote/Giftwrap.php                     |  125 +
 Observer/CheckoutSubmitBefore.php                  |  117 -
 Observer/GiftMessage.php                           |   60 +
 Observer/OrderPlaceAfter.php                       |   91 +
 Observer/QuoteSubmitBefore.php                     |   42 -
 Observer/QuoteSubmitSuccess.php                    |  146 -
 Setup/InstallSchema.php                            |   71 +-
 etc/adminhtml/di.xml                               |    6 -
 etc/adminhtml/events.xml                           |    7 +
 etc/adminhtml/menu.xml                             |    8 +-
 etc/adminhtml/routes.xml                           |    2 +-
 etc/adminhtml/system.xml                           |  158 +-
 etc/config.xml                                     |   82 +-
 etc/di.xml                                         |   11 -
 etc/events.xml                                     |   18 -
 etc/fieldset.xml                                   |   21 +
 etc/frontend/di.xml                                |   29 +-
 etc/frontend/events.xml                            |    6 +
 etc/frontend/page_types.xml                        |   10 -
 etc/frontend/routes.xml                            |   10 +-
 etc/frontend/sections.xml                          |   26 -
 etc/module.xml                                     |    4 +-
 etc/pdf.xml                                        |   13 +
 etc/sales.xml                                      |   14 +
 etc/webapi.xml                                     |   67 -
 etc/webapi_rest/di.xml                             |    7 -
 etc/webapi_rest/events.xml                         |    6 +
 i18n/en_US.csv                                     |  291 +-
 view/adminhtml/layout/default.xml                  |    6 +
 .../layout/sales_order_creditmemo_new.xml          |    8 +
 .../layout/sales_order_creditmemo_updateqty.xml    |    8 +
 .../layout/sales_order_creditmemo_view.xml         |    8 +
 .../adminhtml/layout/sales_order_invoice_email.xml |    8 +
 view/adminhtml/layout/sales_order_invoice_new.xml  |    8 +
 .../adminhtml/layout/sales_order_invoice_print.xml |    8 +
 .../layout/sales_order_invoice_updateqty.xml       |    8 +
 view/adminhtml/layout/sales_order_invoice_view.xml |   13 +
 view/adminhtml/layout/sales_order_view.xml         |   20 +-
 view/adminhtml/templates/order/additional.phtml    |   19 -
 view/adminhtml/templates/order/view/comment.phtml  |   19 -
 .../templates/sales/invoice/view/extra.phtml       |    4 +
 .../templates/sales/order/view/extra.phtml         |    4 +
 view/adminhtml/web/js/jscolor.min.js               |   10 +
 .../layout/onestepcheckout_ajax_update.xml         |   93 +
 .../layout/onestepcheckout_index_index.xml         |  367 +-
 .../frontend/layout/onestepcheckout_one_column.xml |   41 +
 view/frontend/layout/onestepcheckout_payment.xml   |  184 +
 .../layout/sales_email_order_creditmemo_items.xml  |   28 +
 .../layout/sales_email_order_invoice_items.xml     |   28 +
 view/frontend/layout/sales_email_order_items.xml   |   33 +
 view/frontend/layout/sales_order_creditmemo.xml    |   28 +
 view/frontend/layout/sales_order_invoice.xml       |   28 +
 view/frontend/layout/sales_order_print.xml         |   28 +
 .../layout/sales_order_printcreditmemo.xml         |   28 +
 view/frontend/layout/sales_order_printinvoice.xml  |   28 +
 view/frontend/layout/sales_order_view.xml          |   34 +-
 view/frontend/requirejs-config.js                  |   47 +-
 view/frontend/templates/checkout-1column.phtml     |  119 +
 .../templates/checkout-1column/bottom.phtml        |   54 +
 .../templates/checkout-1column/middle.phtml        |   54 +
 view/frontend/templates/checkout-1column/top.phtml |   54 +
 view/frontend/templates/checkout-2columns.phtml    |  117 +
 view/frontend/templates/checkout-3columns.phtml    |  125 +
 .../frontend/templates/checkout-3columns.phtml_bak |  111 +
 view/frontend/templates/container/address.phtml    |  128 +
 .../templates/container/address/billing.phtml      |   71 +
 .../container/address/billing/attributes.phtml     |  429 ++
 .../address/customer/widget/firstname.phtml        |  113 +
 .../address/customer/widget/lastname.phtml         |  127 +
 .../container/address/customer/widget/name.phtml   |  170 +
 .../frontend/templates/container/address/pca.phtml |  126 +
 .../templates/container/address/shipping.phtml     |   55 +
 .../container/address/shipping/attributes.phtml    |  270 ++
 view/frontend/templates/container/auth/form.phtml  |   46 +
 .../templates/container/auth/form/popup.phtml      |  129 +
 view/frontend/templates/container/form.phtml       |   65 +
 .../templates/container/payment/method.phtml       |   66 +
 .../container/payment/method/available.phtml       |   83 +
 view/frontend/templates/container/review.phtml     |   90 +
 .../container/review/addition/giftmessage.phtml    |   47 +
 .../review/addition/giftmessage/inline.phtml       |   64 +
 .../container/review/addition/giftwrap.phtml       |   45 +
 .../container/review/addition/newsletter.phtml     |   40 +
 .../templates/container/review/comment.phtml       |   47 +
 .../templates/container/review/coupon.phtml        |   75 +
 .../frontend/templates/container/review/item.phtml |   70 +
 .../container/review/item/renderer/default.phtml   |  106 +
 .../review/item/renderer/downloadable.phtml        |  106 +
 .../review/item/renderer/price/row_excl_tax.phtml  |   29 +
 .../review/item/renderer/price/row_incl_tax.phtml  |   30 +
 .../review/item/renderer/price/unit_excl_tax.phtml |   32 +
 .../review/item/renderer/price/unit_incl_tax.phtml |   32 +
 .../templates/container/review/order.phtml         |   52 +
 .../templates/container/review/survey.phtml        |   46 +
 .../frontend/templates/container/review/term.phtml |  105 +
 .../templates/container/review/totals.phtml        |   50 +
 .../templates/container/shipping/method.phtml      |   44 +
 .../container/shipping/method/available.phtml      |   86 +
 view/frontend/templates/description.phtml          |    3 -
 view/frontend/templates/generator/css/design.phtml |  201 +-
 view/frontend/templates/order/additional.phtml     |   19 -
 view/frontend/templates/order/email.phtml          |   55 +
 view/frontend/templates/order/print.phtml          |  105 +
 view/frontend/templates/order/view.phtml           |   51 +
 view/frontend/templates/order/view/comment.phtml   |   10 -
 view/frontend/web/css/style.css                    |  147 -
 .../default/font-awesome/css/font-awesome.css      | 1672 +++++++
 .../default/font-awesome/css/font-awesome.min.css  |    4 +
 .../default/font-awesome/fonts/FontAwesome.otf     |  Bin 0 -> 85908 bytes
 .../font-awesome/fonts/fontawesome-webfont.eot     |  Bin 0 -> 56006 bytes
 .../font-awesome/fonts/fontawesome-webfont.svg     |  520 +++
 .../font-awesome/fonts/fontawesome-webfont.ttf     |  Bin 0 -> 112160 bytes
 .../font-awesome/fonts/fontawesome-webfont.woff    |  Bin 0 -> 65452 bytes
 .../web/css/themes/default/grid-mageplaza.css      |  278 ++
 .../web/css/themes/default/images/ajax-loader.gif  |  Bin 0 -> 723 bytes
 .../themes/default/images/authen-ajax-loader.gif   |  Bin 0 -> 7823 bytes
 .../css/themes/default/images/billing-title.png    |  Bin 0 -> 1462 bytes
 .../review => themes/default/images}/btn-minus.png |  Bin
 .../review => themes/default/images}/btn-plus.png  |  Bin
 .../default/images}/btn-remove.png                 |  Bin
 .../css/themes/default/images/btn_window_close.gif |  Bin 0 -> 226 bytes
 .../themes/default/images/button-background.png    |  Bin 0 -> 135 bytes
 .../web/css/themes/default/images/calendar.png     |  Bin 0 -> 2205 bytes
 .../css/themes/default/images/column-separator.png |  Bin 0 -> 3599 bytes
 .../themes/default/images/forgot-pass-title.png    |  Bin 0 -> 520 bytes
 .../themes/default/images/google-location-icon.png |  Bin 0 -> 1152 bytes
 .../css/themes/default/images/location-title.png   |  Bin 0 -> 436 bytes
 .../web/css/themes/default/images/login-title.png  |  Bin 0 -> 472 bytes
 .../web/css/themes/default/images/method-title.png |  Bin 0 -> 1369 bytes
 .../css/themes/default/images/notice-loader.gif    |  Bin 0 -> 673 bytes
 .../css/themes/default/images/payment-title.png    |  Bin 0 -> 1306 bytes
 .../web/css/themes/default/images/review-title.png |  Bin 0 -> 1712 bytes
 .../css/themes/default/images/shadow-onstep.png    |  Bin 0 -> 5696 bytes
 .../web/css/themes/default/images/term-title.png   |  Bin 0 -> 3309 bytes
 .../themes/default/images/validation_advice_bg.gif |  Bin 0 -> 134 bytes
 .../web/css/themes/default/magnific-popup.css      |  623 +++
 .../web/css/themes/default/owl.carousel.css        |  154 +
 .../web/css/themes/default/owl.transitions.css     |  163 +
 .../web/css/themes/default/pca/address-3.40.css    |  490 ++
 .../css/themes/default/pca/address-3.40.min.css    |   11 +
 view/frontend/web/css/themes/default/style.css     | 1111 +++++
 .../web/js/action/get-payment-information.js       |   54 +
 .../web/js/action/payment-total-information.js     |   57 -
 view/frontend/web/js/action/place-order.js         |   67 +
 .../web/js/action/set-checkout-information.js      |   20 -
 view/frontend/web/js/action/update-item.js         |   68 -
 .../web/js/jquery/carousel/owl.carousel.js         | 1517 +++++++
 view/frontend/web/js/jquery/pca/address-3.40.js    | 4656 ++++++++++++++++++++
 .../frontend/web/js/jquery/pca/address-3.40.min.js |  258 ++
 .../js/jquery/popup/jquery.magnific-popup.min.js   |    4 +
 view/frontend/web/js/modal/modal.js                |   29 +
 .../frontend/web/js/model/address/auto-complete.js |   47 -
 view/frontend/web/js/model/address/type/google.js  |  207 -
 view/frontend/web/js/model/agreement-validator.js  |   49 -
 .../web/js/model/checkout-data-resolver.js         |   38 -
 view/frontend/web/js/model/full-screen-loader.js   |   31 +
 view/frontend/web/js/model/osc-data.js             |   41 -
 view/frontend/web/js/model/osc-loader.js           |   75 -
 view/frontend/web/js/model/payment-service.js      |   16 -
 .../web/js/model/payment/button-checkout-list.js   |   42 +
 view/frontend/web/js/model/payment/loader.js       |   48 +
 view/frontend/web/js/model/resource-url-manager.js |   49 -
 .../frontend/web/js/model/shipping-rate-service.js |   42 -
 .../web/js/model/shipping-rates-validator.js       |  172 -
 .../js/model/shipping-save-processor/checkout.js   |   73 -
 view/frontend/web/js/osc.js                        |  369 ++
 view/frontend/web/js/osc/address.js                |  495 +++
 .../web/js/osc/address/google-auto-complete.js     |  171 +
 view/frontend/web/js/osc/address/region-updater.js |  213 +
 view/frontend/web/js/osc/auth.js                   |  152 +
 view/frontend/web/js/osc/form.js                   |  209 +
 view/frontend/web/js/osc/payment/method.js         |  253 ++
 view/frontend/web/js/osc/popup.js                  |   54 +
 view/frontend/web/js/osc/review/cart.js            |  115 +
 view/frontend/web/js/osc/review/comment.js         |  138 +
 view/frontend/web/js/osc/review/coupon.js          |  128 +
 view/frontend/web/js/osc/review/giftmessage.js     |  108 +
 view/frontend/web/js/osc/review/giftwrap.js        |   47 +
 view/frontend/web/js/osc/review/newsletter.js      |   44 +
 view/frontend/web/js/osc/review/term.js            |   99 +
 view/frontend/web/js/osc/shipping/method.js        |   60 +
 view/frontend/web/js/view/billing-address.js       |  213 -
 view/frontend/web/js/view/form/element/email.js    |  111 -
 view/frontend/web/js/view/form/element/region.js   |   36 -
 view/frontend/web/js/view/form/element/street.js   |   46 -
 view/frontend/web/js/view/payment.js               |   74 +-
 view/frontend/web/js/view/payment/authorizenet.js  |   26 +
 .../web/js/view/payment/braintree-methods.js       |   28 +
 view/frontend/web/js/view/payment/cc-form.js       |  191 +
 .../frontend/web/js/view/payment/connect-method.js |   68 +
 view/frontend/web/js/view/payment/default.js       |  197 +
 view/frontend/web/js/view/payment/iframe.js        |   45 +
 view/frontend/web/js/view/payment/list.js          |  126 +
 .../method-renderer/authorizenet-directpost.js     |   80 +
 .../payment/method-renderer/banktransfer-method.js |   26 +
 .../payment/method-renderer/braintree-paypal.js    |  109 +
 .../method-renderer/cashondelivery-method.js       |   24 +
 .../web/js/view/payment/method-renderer/cc-form.js |  486 ++
 .../view/payment/method-renderer/checkmo-method.js |   30 +
 .../js/view/payment/method-renderer/free-method.js |   23 +
 .../view/payment/method-renderer/iframe-methods.js |   83 +
 .../payment/method-renderer/payflow-express-bml.js |   20 +
 .../payment/method-renderer/payflow-express.js     |   20 +
 .../payment/method-renderer/payflowpro-method.js   |   71 +
 .../method-renderer/paypal-billing-agreement.js    |   46 +
 .../method-renderer/paypal-express-abstract.js     |   93 +
 .../payment/method-renderer/paypal-express-bml.js  |   20 +
 .../view/payment/method-renderer/paypal-express.js |   20 +
 .../method-renderer/purchaseorder-method.js        |   39 +
 .../web/js/view/payment/offline-payments.js        |   38 +
 view/frontend/web/js/view/payment/payments.js      |   26 +
 .../web/js/view/payment/paypal-payments.js         |   56 +
 view/frontend/web/js/view/review/addition.js       |   20 -
 .../web/js/view/review/addition/newsletter.js      |   40 -
 .../web/js/view/review/checkout-agreements.js      |   17 -
 view/frontend/web/js/view/review/comment.js        |   35 -
 view/frontend/web/js/view/review/placeOrder.js     |   47 -
 .../shipping-address/address-renderer/default.js   |   26 -
 view/frontend/web/js/view/shipping.js              |  134 -
 view/frontend/web/js/view/summary/item/details.js  |  114 -
 .../images/homepage-three-column-promo-01.png      |  Bin 0 -> 4623 bytes
 .../images/homepage-three-column-promo-01B.png     |  Bin 0 -> 4841 bytes
 .../images/homepage-three-column-promo-02.png      |  Bin 0 -> 4848 bytes
 .../images/homepage-three-column-promo-03.png      |  Bin 0 -> 4496 bytes
 view/frontend/web/template/1column.html            |   47 -
 view/frontend/web/template/2columns.html           |   54 -
 view/frontend/web/template/3columns-colspan.html   |   49 -
 view/frontend/web/template/3columns.html           |   50 -
 .../container/address/billing-address.html         |   23 -
 .../container/address/billing/checkbox.html        |   10 -
 .../template/container/address/billing/create.html |   42 -
 .../container/address/shipping-address.html        |   54 -
 .../address/shipping/address-renderer/default.html |   21 -
 .../template/container/address/shipping/form.html  |   35 -
 .../web/template/container/authentication.html     |   87 -
 .../web/template/container/form/element/email.html |   71 -
 .../web/template/container/form/element/input.html |   16 -
 .../template/container/form/element/street.html    |   18 -
 .../web/template/container/payment/discount.html   |   48 -
 .../web/template/container/review/addition.html    |   14 -
 .../container/review/addition/newsletter.html      |   10 -
 .../web/template/container/review/comment.html     |   14 -
 .../web/template/container/review/place-order.html |   24 -
 view/frontend/web/template/container/shipping.html |  113 -
 view/frontend/web/template/container/sidebar.html  |   33 -
 view/frontend/web/template/container/summary.html  |   15 -
 .../web/template/container/summary/cart-items.html |   37 -
 .../template/container/summary/item/details.html   |   59 -
 .../web/template/{container => }/payment.html      |   29 +-
 .../template/payment/authorizenet-directpost.html  |   73 +
 .../web/template/payment/banktransfer.html         |   49 +
 .../template/payment/braintree-paypal-form.html    |   52 +
 .../web/template/payment/braintree/cc-form.html    |  238 +
 .../web/template/payment/cashondelivery.html       |   50 +
 view/frontend/web/template/payment/cc-form.html    |  189 +
 view/frontend/web/template/payment/checkmo.html    |   62 +
 .../payment/express/billing-agreement.html         |   21 +
 view/frontend/web/template/payment/free.html       |   45 +
 .../web/template/payment/iframe-methods.html       |   57 +
 view/frontend/web/template/payment/iframe.html     |   47 +
 .../web/template/payment/payflow-express-bml.html  |   53 +
 .../web/template/payment/payflow-express.html      |   49 +
 .../web/template/payment/payflowpro-form.html      |   73 +
 .../web/template/payment/paypal-express-bml.html   |   53 +
 .../web/template/payment/paypal-express.html       |   50 +
 .../payment/paypal_billing_agreement-form.html     |   60 +
 .../web/template/payment/paypal_direct-form.html   |   10 +
 .../web/template/payment/purchaseorder-form.html   |   71 +
 359 files changed, 30094 insertions(+), 5952 deletions(-)
~~~
### v1.3.0 to v1.2.9
~~~
 Block/Container/Address.php                        |  3 +--
 Block/Container/Form.php                           |  2 +-
 Controller/Ajax/AbstractCheckout.php               | 13 +++----------
 view/frontend/web/js/osc/address/region-updater.js |  4 ++--
 4 files changed, 7 insertions(+), 15 deletions(-)
~~~
### v2.5.0 to v2.4.5
~~~
 Api/CheckoutManagementInterface.php                |   2 +-
 Api/Data/OscDetailsInterface.php                   |   2 +-
 Api/GuestCheckoutManagementInterface.php           |   2 +-
 Block/Adminhtml/Config/Backend/StaticBlock.php     | 124 ---------------------
 Block/Adminhtml/Field/Position.php                 |   2 +-
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |   2 +-
 Block/Adminhtml/System/Config/Geoip.php            |   2 +-
 Block/Checkout/CompatibleConfig.php                |   2 +-
 Block/Checkout/LayoutProcessor.php                 |  28 ++---
 Block/Container.php                                |   2 +-
 Block/Design.php                                   |   2 +-
 Block/Order/Totals.php                             |   2 +-
 Block/Order/View/Comment.php                       |   2 +-
 Block/Order/View/DeliveryTime.php                  |   2 +-
 Block/Order/View/Survey.php                        |   2 +-
 Block/Plugin/Link.php                              |   2 +-
 Block/StaticBlock.php                              | 104 -----------------
 Block/Survey.php                                   |   2 +-
 Controller/Add/Index.php                           |   2 +-
 Controller/Adminhtml/Field/Position.php            |   2 +-
 Controller/Adminhtml/Field/Save.php                |   2 +-
 Controller/Adminhtml/System/Config/Geoip.php       |   2 +-
 Controller/Index/Index.php                         |   2 +-
 Controller/Survey/Save.php                         |   2 +-
 Helper/Address.php                                 |   2 +-
 Helper/Data.php                                    |  48 +-------
 LICENSE                                            |   4 +-
 Model/AgreementsValidator.php                      |   2 +-
 Model/CheckoutManagement.php                       |   2 +-
 Model/CheckoutRegister.php                         |   2 +-
 Model/DefaultConfigProvider.php                    |  49 +-------
 Model/GuestCheckoutManagement.php                  |   2 +-
 Model/OscDetails.php                               |   2 +-
 Model/Plugin/Authorization/UserContext.php         |   2 +-
 Model/Plugin/Checkout/ShippingMethodManagement.php |   2 +-
 Model/Plugin/Customer/AccountManagement.php        |   2 +-
 Model/Plugin/Customer/Address.php                  |   2 +-
 .../Plugin/Eav/Model/Validator/Attribute/Data.php  |   2 +-
 Model/Plugin/Paypal/Model/Express.php              |   2 +-
 Model/Plugin/Quote/GiftWrap.php                    |   2 +-
 Model/Plugin/Quote/Processor.php                   |  90 ---------------
 Model/Plugin/Quote/QuoteManagement.php             |   2 +-
 Model/System/Config/Source/AddressSuggest.php      |   2 +-
 Model/System/Config/Source/CheckboxStyle.php       |   2 +-
 Model/System/Config/Source/ComponentPosition.php   |   2 +-
 Model/System/Config/Source/DeliveryTime.php        |   2 +-
 Model/System/Config/Source/Design.php              |   2 +-
 Model/System/Config/Source/Giftwrap.php            |   2 +-
 Model/System/Config/Source/Layout.php              |   7 +-
 Model/System/Config/Source/PaymentMethods.php      |   2 +-
 Model/System/Config/Source/RadioStyle.php          |   2 +-
 Model/System/Config/Source/ShippingMethods.php     |   2 +-
 Model/System/Config/Source/StaticBlockPosition.php |  51 ---------
 Model/System/Config/Source/Survey.php              |   2 +-
 Model/Total/Creditmemo/GiftWrap.php                |   2 +-
 Model/Total/Invoice/GiftWrap.php                   |   2 +-
 Model/Total/Quote/GiftWrap.php                     |   2 +-
 Observer/IsAllowedGuestCheckoutObserver.php        |   2 +-
 Observer/OscConfigObserver.php                     |   2 +-
 Observer/PaypalExpressPlaceOrder.php               |   2 +-
 Observer/QuoteSubmitBefore.php                     |   2 +-
 Observer/QuoteSubmitSuccess.php                    |   6 +-
 Observer/RedirectToOneStepCheckout.php             |   2 +-
 Setup/InstallData.php                              |   2 +-
 Setup/UpgradeData.php                              |  61 +---------
 composer.json                                      |   4 +-
 etc/acl.xml                                        |   2 +-
 etc/adminhtml/di.xml                               |   2 +-
 etc/adminhtml/events.xml                           |   2 +-
 etc/adminhtml/menu.xml                             |   2 +-
 etc/adminhtml/routes.xml                           |   2 +-
 etc/adminhtml/system.xml                           |  33 +-----
 etc/config.xml                                     |   3 +-
 etc/di.xml                                         |   2 +-
 etc/events.xml                                     |   2 +-
 etc/extension_attributes.xml                       |   2 +-
 etc/frontend/di.xml                                |   6 +-
 etc/frontend/events.xml                            |   2 +-
 etc/frontend/routes.xml                            |   2 +-
 etc/frontend/sections.xml                          |   2 +-
 etc/module.xml                                     |   4 +-
 etc/sales.xml                                      |   2 +-
 etc/webapi.xml                                     |   2 +-
 etc/webapi_rest/di.xml                             |   2 +-
 registration.php                                   |   2 +-
 .../layout/onestepcheckout_field_position.xml      |   2 +-
 .../layout/sales_order_creditmemo_new.xml          |   2 +-
 .../layout/sales_order_creditmemo_updateqty.xml    |   2 +-
 .../layout/sales_order_creditmemo_view.xml         |   2 +-
 .../adminhtml/layout/sales_order_invoice_email.xml |   2 +-
 view/adminhtml/layout/sales_order_invoice_new.xml  |   2 +-
 .../adminhtml/layout/sales_order_invoice_print.xml |   2 +-
 .../layout/sales_order_invoice_updateqty.xml       |   2 +-
 view/adminhtml/layout/sales_order_invoice_view.xml |   2 +-
 view/adminhtml/layout/sales_order_view.xml         |   2 +-
 view/adminhtml/templates/field/position.phtml      |   2 +-
 view/adminhtml/templates/order/additional.phtml    |   2 +-
 view/adminhtml/templates/order/view/comment.phtml  |   2 +-
 .../templates/order/view/delivery-time.phtml       |   2 +-
 view/adminhtml/templates/order/view/survey.phtml   |   2 +-
 view/adminhtml/templates/system/config/geoip.phtml |   2 +-
 view/adminhtml/web/css/source/_module.less         |   2 +-
 view/adminhtml/web/css/style.css                   |   2 +-
 view/base/web/css/images/seal.png                  | Bin 61069 -> 0 bytes
 view/frontend/layout/checkout_onepage_success.xml  |   3 +-
 .../layout/onestepcheckout_index_index.xml         |   4 +-
 .../layout/sales_email_order_creditmemo_items.xml  |   2 +-
 .../layout/sales_email_order_invoice_items.xml     |   2 +-
 view/frontend/layout/sales_email_order_items.xml   |   2 +-
 view/frontend/layout/sales_order_creditmemo.xml    |   2 +-
 view/frontend/layout/sales_order_invoice.xml       |   2 +-
 view/frontend/layout/sales_order_print.xml         |   2 +-
 .../layout/sales_order_printcreditmemo.xml         |   2 +-
 view/frontend/layout/sales_order_printinvoice.xml  |   2 +-
 view/frontend/layout/sales_order_view.xml          |   2 +-
 view/frontend/requirejs-config.js                  |   2 +-
 view/frontend/templates/description.phtml          |   2 +-
 view/frontend/templates/design.phtml               |   6 +-
 .../templates/onepage/compatible-config.phtml      |   2 +-
 .../templates/onepage/success/survey.phtml         |   2 +-
 view/frontend/templates/order/additional.phtml     |   2 +-
 view/frontend/templates/order/view/comment.phtml   |   2 +-
 .../templates/order/view/delivery-time.phtml       |   2 +-
 view/frontend/templates/order/view/survey.phtml    |   2 +-
 view/frontend/templates/static-block.phtml         |  28 -----
 view/frontend/web/css/style.css                    |  22 +---
 .../web/js/action/check-email-availability.js      |   2 +-
 view/frontend/web/js/action/gift-message-item.js   |   2 +-
 view/frontend/web/js/action/gift-wrap.js           |   2 +-
 .../web/js/action/payment-total-information.js     |   2 +-
 view/frontend/web/js/action/place-order-mixins.js  |  10 +-
 .../web/js/action/set-checkout-information.js      |   2 +-
 view/frontend/web/js/action/set-payment-method.js  |   2 +-
 view/frontend/web/js/action/update-item.js         |   9 +-
 .../frontend/web/js/model/address/auto-complete.js |   2 +-
 view/frontend/web/js/model/address/type/google.js  |   2 +-
 view/frontend/web/js/model/agreement-validator.js  |   2 +-
 view/frontend/web/js/model/agreements-assigner.js  |   2 +-
 view/frontend/web/js/model/braintree-paypal.js     |   2 +-
 .../web/js/model/checkout-data-resolver.js         |   2 +-
 .../frontend/web/js/model/compatible/amazon-pay.js |   2 +-
 view/frontend/web/js/model/gift-message.js         |   2 +-
 view/frontend/web/js/model/gift-wrap.js            |   2 +-
 view/frontend/web/js/model/osc-data.js             |   2 +-
 view/frontend/web/js/model/osc-loader.js           |   2 +-
 view/frontend/web/js/model/osc-loader/discount.js  |   2 +-
 view/frontend/web/js/model/payment-service.js      |   2 +-
 .../js/model/paypal/set-payment-method-mixin.js    |   2 +-
 view/frontend/web/js/model/resource-url-manager.js |   2 +-
 .../frontend/web/js/model/shipping-rate-service.js |   2 +-
 .../web/js/model/shipping-rates-validator.js       |   2 +-
 .../js/model/shipping-save-processor/checkout.js   |   2 +-
 view/frontend/web/js/view/amazon.js                |   2 +-
 view/frontend/web/js/view/authentication.js        |   2 +-
 view/frontend/web/js/view/billing-address.js       |  21 +++-
 view/frontend/web/js/view/delivery-time.js         |   2 +-
 view/frontend/web/js/view/form/element/email.js    |   2 +-
 view/frontend/web/js/view/form/element/region.js   |   2 +-
 view/frontend/web/js/view/form/element/street.js   |   2 +-
 view/frontend/web/js/view/geoip.js                 |   2 +-
 view/frontend/web/js/view/payment.js               |   6 +-
 view/frontend/web/js/view/payment/discount.js      |   2 +-
 .../method-renderer/braintree-paypal-mixins.js     |   2 +-
 view/frontend/web/js/view/review/addition.js       |   2 +-
 .../web/js/view/review/addition/gift-message.js    |   2 +-
 .../web/js/view/review/addition/gift-wrap.js       |   2 +-
 .../web/js/view/review/addition/newsletter.js      |   2 +-
 .../web/js/view/review/checkout-agreements.js      |   2 +-
 view/frontend/web/js/view/review/comment.js        |   2 +-
 view/frontend/web/js/view/review/placeOrder.js     |  23 +---
 .../shipping-address/address-renderer/default.js   |   2 +-
 view/frontend/web/js/view/shipping-postnl.js       |   2 +-
 view/frontend/web/js/view/shipping.js              |  31 +++++-
 view/frontend/web/js/view/summary/gift-wrap.js     |   2 +-
 view/frontend/web/js/view/summary/item/details.js  |  57 ++--------
 view/frontend/web/js/view/survey.js                |   2 +-
 view/frontend/web/template/1column.html            |   2 +-
 view/frontend/web/template/2columns-floating.html  |  78 -------------
 view/frontend/web/template/2columns.html           |   2 +-
 view/frontend/web/template/3columns-colspan.html   |   2 +-
 view/frontend/web/template/3columns.html           |   2 +-
 .../container/address/billing-address.html         |   2 +-
 .../container/address/billing/checkbox.html        |   2 +-
 .../template/container/address/billing/create.html |   2 +-
 .../container/address/shipping-address.html        |   2 +-
 .../address/shipping/address-renderer/default.html |   2 +-
 .../template/container/address/shipping/form.html  |   2 +-
 .../web/template/container/authentication.html     |   2 +-
 .../web/template/container/delivery-time.html      |   2 +-
 .../web/template/container/form/element/email.html |   2 +-
 .../web/template/container/form/element/input.html |   2 +-
 .../template/container/form/element/street.html    |   2 +-
 .../web/template/container/form/field.html         |   2 +-
 view/frontend/web/template/container/payment.html  |   2 +-
 .../web/template/container/payment/discount.html   |   2 +-
 .../web/template/container/review/addition.html    |   2 +-
 .../container/review/addition/gift-message.html    |   2 +-
 .../container/review/addition/gift-wrap.html       |   2 +-
 .../container/review/addition/newsletter.html      |   2 +-
 .../web/template/container/review/comment.html     |   2 +-
 .../web/template/container/review/discount.html    |   2 +-
 .../web/template/container/review/place-order.html |   8 +-
 view/frontend/web/template/container/shipping.html |   2 +-
 view/frontend/web/template/container/sidebar.html  |   4 +-
 view/frontend/web/template/container/summary.html  |   2 +-
 .../web/template/container/summary/cart-items.html |  19 +---
 .../web/template/container/summary/gift-wrap.html  |   2 +-
 .../template/container/summary/item/details.html   |   4 +-
 208 files changed, 289 insertions(+), 1014 deletions(-)
~~~
### v2.4.5 to v2.4.4
~~~
 Model/DefaultConfigProvider.php                    | 111 ++++++---------------
 composer.json                                      |   2 +-
 etc/adminhtml/system.xml                           |   2 +-
 .../web/js/model/shipping-rates-validator.js       |   7 +-
 view/frontend/web/js/view/billing-address.js       |   6 +-
 view/frontend/web/js/view/shipping.js              |   1 -
 view/frontend/web/js/view/summary/item/details.js  |  57 ++++-------
 7 files changed, 58 insertions(+), 128 deletions(-)
~~~
### v2.4.4 to v2.4.3
~~~
 Block/Checkout/LayoutProcessor.php              |  6 ---
 Controller/Index/Index.php                      | 17 ++++---
 Helper/Address.php                              |  6 +--
 Model/Plugin/Customer/AccountManagement.php     | 63 -------------------------
 Observer/QuoteSubmitSuccess.php                 | 14 +-----
 composer.json                                   |  2 +-
 etc/di.xml                                      |  5 +-
 view/frontend/web/js/view/billing-address.js    | 19 --------
 view/frontend/web/js/view/form/element/email.js |  4 --
 view/frontend/web/js/view/payment.js            |  6 ---
 view/frontend/web/js/view/shipping.js           | 24 ----------
 11 files changed, 15 insertions(+), 151 deletions(-)
~~~
### v2.4.2 to v2.4.1
~~~
 Api/GuestCheckoutManagementInterface.php           |  11 -
 Block/Checkout/LayoutProcessor.php                 | 669 ++++++++++-----------
 Helper/Config.php                                  |   8 -
 Model/CheckoutRegister.php                         |  12 +-
 Model/DefaultConfigProvider.php                    | 369 ++++++------
 Model/GuestCheckoutManagement.php                  |  29 +-
 Model/Plugin/Authorization/UserContext.php         |  78 ---
 Model/Plugin/Quote/AccessChangeQuoteControl.php    |  99 +++
 Observer/QuoteSubmitSuccess.php                    |  17 +-
 Observer/RedirectToOneStepCheckout.php             |  11 +-
 composer.json                                      |   2 +-
 etc/webapi.xml                                     |   6 -
 etc/webapi_rest/di.xml                             |   4 +-
 .../layout/onestepcheckout_index_index.xml         |   1 -
 view/frontend/requirejs-config.js                  |   6 +-
 .../web/js/action/check-email-availability.js      |  22 -
 .../save-email-to-quote.js}                        |  30 +-
 view/frontend/web/js/model/resource-url-manager.js |  11 +-
 view/frontend/web/js/view/amazon.js                |  41 --
 view/frontend/web/js/view/billing-address.js       |  10 +-
 view/frontend/web/js/view/form/element/email.js    |  35 +-
 view/frontend/web/js/view/shipping.js              |  29 +-
 .../container/address/billing-address.html         |  42 +-
 .../container/address/shipping-address.html        |  26 +-
 .../web/template/container/form/element/email.html |   5 -
 25 files changed, 729 insertions(+), 844 deletions(-)
~~~
### v2.4.1 to v2.4.0
~~~
 Api/CheckoutManagementInterface.php                |    7 +-
 Api/Data/OscDetailsInterface.php                   |    7 +-
 Api/GuestCheckoutManagementInterface.php           |   14 +-
 Block/Adminhtml/Field/Position.php                 |  177 ++-
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |    3 +-
 Block/Adminhtml/System/Config/Geoip.php            |  162 +--
 Block/Checkout/CompatibleConfig.php                |    7 +-
 Block/Checkout/LayoutProcessor.php                 |  668 +++++----
 Block/Container.php                                |   11 +-
 Block/Design.php                                   |   28 +-
 Block/Order/Totals.php                             |   34 +-
 Block/Order/View/Comment.php                       |    7 +-
 Block/Order/View/DeliveryTime.php                  |   29 +-
 Block/Order/View/Survey.php                        |   33 +-
 Block/Plugin/Link.php                              |   24 +-
 Block/Survey.php                                   |  133 +-
 Controller/Add/Index.php                           |    8 +-
 Controller/Adminhtml/Field/Position.php            |   71 +-
 Controller/Adminhtml/Field/Save.php                |  101 +-
 Controller/Adminhtml/System/Config/Geoip.php       |  135 +-
 Controller/Index/Index.php                         |  238 ++-
 Controller/Survey/Save.php                         |  138 +-
 Helper/Config.php                                  | 1528 ++++++++++----------
 Helper/Data.php                                    |  441 +++---
 Model/AgreementsValidator.php                      |   58 -
 Model/CheckoutManagement.php                       |  620 ++++----
 Model/CheckoutRegister.php                         |  221 ---
 Model/DefaultConfigProvider.php                    |  392 ++---
 Model/Geoip/Database/Reader.php                    |   43 +-
 Model/Geoip/Maxmind/Db/Reader.php                  |   20 +-
 Model/Geoip/Maxmind/Db/Reader/Decoder.php          |   87 +-
 .../Maxmind/Db/Reader/InvalidDatabaseException.php |   20 -
 Model/Geoip/Maxmind/Db/Reader/Metadata.php         |   19 -
 Model/Geoip/Maxmind/Db/Reader/Util.php             |   31 +-
 Model/Geoip/ProviderInterface.php                  |   47 +-
 Model/GuestCheckoutManagement.php                  |   50 +-
 Model/OscDetails.php                               |    9 +-
 Model/Plugin/Checkout/ShippingMethodManagement.php |  241 +--
 Model/Plugin/Customer/Address.php                  |   33 +-
 .../Plugin/Eav/Model/Validator/Attribute/Data.php  |   60 -
 Model/Plugin/Paypal/Model/Express.php              |   47 -
 Model/Plugin/Quote/AccessChangeQuoteControl.php    |   99 --
 Model/Plugin/Quote/GiftWrap.php                    |   87 +-
 Model/Plugin/Quote/QuoteManagement.php             |   50 -
 Model/System/Config/Source/AddressSuggest.php      |    3 +-
 Model/System/Config/Source/CheckboxStyle.php       |    5 +-
 Model/System/Config/Source/ComponentPosition.php   |   31 +-
 Model/System/Config/Source/DeliveryTime.php        |    3 +-
 Model/System/Config/Source/Design.php              |   17 +-
 Model/System/Config/Source/Giftwrap.php            |    5 +-
 Model/System/Config/Source/Layout.php              |    3 +-
 Model/System/Config/Source/PaymentMethods.php      |  147 +-
 Model/System/Config/Source/RadioStyle.php          |    7 +-
 Model/System/Config/Source/ShippingMethods.php     |    7 +-
 Model/System/Config/Source/Survey.php              |   64 +-
 Model/Total/Creditmemo/GiftWrap.php                |   96 +-
 Model/Total/Invoice/GiftWrap.php                   |   72 +-
 Model/Total/Quote/GiftWrap.php                     |  263 ++--
 Observer/CheckoutSubmitBefore.php                  |  186 +++
 Observer/IsAllowedGuestCheckoutObserver.php        |   51 +-
 Observer/OscConfigObserver.php                     |   26 +-
 Observer/PaypalExpressPlaceOrder.php               |   57 -
 Observer/QuoteSubmitBefore.php                     |   16 +-
 Observer/QuoteSubmitSuccess.php                    |   62 +-
 Observer/RedirectToOneStepCheckout.php             |   70 +-
 README.md                                          |   16 +-
 Setup/InstallData.php                              |   60 +-
 Setup/UpgradeData.php                              |  118 +-
 USER-GUIDE.md                                      |   45 +-
 composer.json                                      |    2 +-
 etc/acl.xml                                        |    5 +-
 etc/adminhtml/di.xml                               |    2 +-
 etc/adminhtml/events.xml                           |    1 +
 etc/adminhtml/menu.xml                             |    4 +-
 etc/adminhtml/routes.xml                           |    2 +-
 etc/adminhtml/system.xml                           |    2 +-
 etc/config.xml                                     |    3 +-
 etc/di.xml                                         |    6 +-
 etc/events.xml                                     |    7 +-
 etc/extension_attributes.xml                       |    2 +-
 etc/frontend/di.xml                                |    6 +-
 etc/frontend/events.xml                            |    3 +-
 etc/frontend/routes.xml                            |    3 +-
 etc/frontend/sections.xml                          |    3 +-
 etc/module.xml                                     |    3 +-
 etc/sales.xml                                      |    3 +-
 etc/webapi.xml                                     |    9 +-
 etc/webapi_rest/di.xml                             |   10 +-
 i18n/af_ZA.csv                                     |    2 +-
 i18n/ar_SA.csv                                     |    2 +-
 i18n/be_BY.csv                                     |    2 +-
 i18n/ca_ES.csv                                     |    2 +-
 i18n/cs_CZ.csv                                     |    2 +-
 i18n/da_DK.csv                                     |    2 +-
 i18n/de_DE.csv                                     |    2 +-
 i18n/el_GR.csv                                     |    2 +-
 i18n/en_US.csv                                     |    2 +-
 i18n/es_ES.csv                                     |    2 +-
 i18n/fi_FI.csv                                     |    2 +-
 i18n/fr_FR.csv                                     |    2 +-
 i18n/he_IL.csv                                     |    2 +-
 i18n/hu_HU.csv                                     |    2 +-
 i18n/it_IT.csv                                     |    2 +-
 i18n/ja_JP.csv                                     |    2 +-
 i18n/ko_KR.csv                                     |    2 +-
 i18n/nl_NL.csv                                     |    2 +-
 i18n/no_NO.csv                                     |    2 +-
 i18n/pl_PL.csv                                     |    2 +-
 i18n/pt_BR.csv                                     |    2 +-
 i18n/pt_PT.csv                                     |    2 +-
 i18n/ro_RO.csv                                     |    2 +-
 i18n/ru_RU.csv                                     |    2 +-
 i18n/sr_SP.csv                                     |    2 +-
 i18n/sv_SE.csv                                     |    2 +-
 i18n/tr_TR.csv                                     |    2 +-
 i18n/uk_UA.csv                                     |    2 +-
 i18n/vi_VN.csv                                     |    2 +-
 i18n/zh_CN.csv                                     |    2 +-
 i18n/zh_TW.csv                                     |    2 +-
 registration.php                                   |    2 +-
 .../layout/onestepcheckout_field_position.xml      |    5 +-
 .../layout/sales_order_creditmemo_new.xml          |    3 +-
 .../layout/sales_order_creditmemo_updateqty.xml    |    3 +-
 .../layout/sales_order_creditmemo_view.xml         |    3 +-
 .../adminhtml/layout/sales_order_invoice_email.xml |    3 +-
 view/adminhtml/layout/sales_order_invoice_new.xml  |    3 +-
 .../adminhtml/layout/sales_order_invoice_print.xml |    3 +-
 .../layout/sales_order_invoice_updateqty.xml       |    3 +-
 view/adminhtml/layout/sales_order_invoice_view.xml |    3 +-
 view/adminhtml/layout/sales_order_view.xml         |    3 +-
 view/adminhtml/templates/field/position.phtml      |    2 +-
 view/adminhtml/templates/order/additional.phtml    |    2 +-
 view/adminhtml/templates/order/view/comment.phtml  |    2 +-
 .../templates/order/view/delivery-time.phtml       |    2 +-
 view/adminhtml/templates/order/view/survey.phtml   |    2 +-
 view/adminhtml/templates/system/config/geoip.phtml |    8 +-
 view/adminhtml/web/css/style.css                   |    2 +-
 view/frontend/layout/checkout_onepage_success.xml  |    2 +-
 .../layout/onestepcheckout_index_index.xml         |    2 +-
 .../layout/sales_email_order_creditmemo_items.xml  |    2 +-
 .../layout/sales_email_order_invoice_items.xml     |    3 +-
 view/frontend/layout/sales_email_order_items.xml   |   23 +-
 view/frontend/layout/sales_order_creditmemo.xml    |    2 +-
 view/frontend/layout/sales_order_invoice.xml       |    2 +-
 view/frontend/layout/sales_order_print.xml         |    2 +-
 .../layout/sales_order_printcreditmemo.xml         |    2 +-
 view/frontend/layout/sales_order_printinvoice.xml  |    2 +-
 view/frontend/layout/sales_order_view.xml          |    2 +-
 view/frontend/requirejs-config.js                  |    8 +-
 view/frontend/templates/description.phtml          |    2 +-
 view/frontend/templates/design.phtml               |    4 +-
 .../templates/onepage/compatible-config.phtml      |    3 +-
 .../templates/onepage/success/survey.phtml         |    8 +-
 view/frontend/templates/order/additional.phtml     |    2 +-
 view/frontend/templates/order/view/comment.phtml   |    3 +-
 .../templates/order/view/delivery-time.phtml       |    2 +-
 view/frontend/templates/order/view/survey.phtml    |    2 +-
 view/frontend/web/css/style.css                    |    8 +-
 view/frontend/web/js/action/gift-message-item.js   |    2 +-
 view/frontend/web/js/action/gift-wrap.js           |   20 +-
 .../web/js/action/payment-total-information.js     |    2 +-
 view/frontend/web/js/action/place-order-mixins.js  |   48 -
 view/frontend/web/js/action/save-email-to-quote.js |   40 -
 .../web/js/action/set-checkout-information.js      |    2 +-
 view/frontend/web/js/action/set-payment-method.js  |   69 -
 view/frontend/web/js/action/update-item.js         |    2 +-
 .../frontend/web/js/model/address/auto-complete.js |    2 +-
 view/frontend/web/js/model/address/type/google.js  |    7 +-
 view/frontend/web/js/model/agreement-validator.js  |    2 +-
 view/frontend/web/js/model/agreements-assigner.js  |   25 +-
 view/frontend/web/js/model/braintree-paypal.js     |   20 -
 .../web/js/model/checkout-data-resolver.js         |    2 +-
 view/frontend/web/js/model/gift-message.js         |    2 +-
 view/frontend/web/js/model/gift-wrap.js            |   20 +-
 view/frontend/web/js/model/osc-data.js             |    2 +-
 view/frontend/web/js/model/osc-loader.js           |    2 +-
 view/frontend/web/js/model/osc-loader/discount.js  |    2 +-
 view/frontend/web/js/model/payment-service.js      |    2 +-
 .../js/model/paypal/set-payment-method-mixin.js    |   35 -
 view/frontend/web/js/model/resource-url-manager.js |   10 +-
 .../frontend/web/js/model/shipping-rate-service.js |    2 +-
 .../web/js/model/shipping-rates-validator.js       |    2 +-
 .../js/model/shipping-save-processor/checkout.js   |   17 +-
 view/frontend/web/js/view/authentication.js        |    2 +-
 view/frontend/web/js/view/billing-address.js       |   15 +-
 view/frontend/web/js/view/delivery-time.js         |    2 +-
 view/frontend/web/js/view/form/element/email.js    |   31 +-
 view/frontend/web/js/view/form/element/region.js   |    2 +-
 view/frontend/web/js/view/form/element/street.js   |    2 +-
 view/frontend/web/js/view/geoip.js                 |    2 +-
 view/frontend/web/js/view/payment.js               |    2 +-
 view/frontend/web/js/view/payment/discount.js      |    2 +-
 .../method-renderer/braintree-paypal-mixins.js     |   51 +-
 view/frontend/web/js/view/review/addition.js       |    2 +-
 .../web/js/view/review/addition/gift-message.js    |    2 +-
 .../web/js/view/review/addition/gift-wrap.js       |    2 +-
 .../web/js/view/review/addition/newsletter.js      |    4 +-
 .../web/js/view/review/checkout-agreements.js      |    2 +-
 view/frontend/web/js/view/review/comment.js        |    2 +-
 view/frontend/web/js/view/review/placeOrder.js     |   43 +-
 .../shipping-address/address-renderer/default.js   |    2 +-
 view/frontend/web/js/view/shipping-postnl.js       |   20 -
 view/frontend/web/js/view/shipping.js              |   13 +-
 view/frontend/web/js/view/summary/gift-wrap.js     |    2 +-
 view/frontend/web/js/view/summary/item/details.js  |   15 +-
 view/frontend/web/js/view/survey.js                |    3 +-
 view/frontend/web/template/1column.html            |    3 +-
 view/frontend/web/template/2columns.html           |    2 +-
 view/frontend/web/template/3columns-colspan.html   |    3 +-
 view/frontend/web/template/3columns.html           |    3 +-
 .../container/address/billing-address.html         |    2 +-
 .../container/address/billing/checkbox.html        |    2 +-
 .../template/container/address/billing/create.html |    2 +-
 .../container/address/shipping-address.html        |    2 +-
 .../address/shipping/address-renderer/default.html |    2 +-
 .../template/container/address/shipping/form.html  |    2 +-
 .../web/template/container/authentication.html     |    2 +-
 .../web/template/container/delivery-time.html      |    2 +-
 .../web/template/container/form/element/email.html |    2 +-
 .../web/template/container/form/element/input.html |    2 +-
 .../template/container/form/element/street.html    |    4 +-
 .../web/template/container/form/field.html         |    2 +-
 view/frontend/web/template/container/payment.html  |    2 +-
 .../web/template/container/payment/discount.html   |    2 +-
 .../web/template/container/review/addition.html    |    2 +-
 .../container/review/addition/gift-message.html    |    6 +-
 .../container/review/addition/gift-wrap.html       |    2 +-
 .../container/review/addition/newsletter.html      |    2 +-
 .../web/template/container/review/comment.html     |    2 +-
 .../web/template/container/review/discount.html    |    2 +-
 .../web/template/container/review/place-order.html |   15 +-
 view/frontend/web/template/container/shipping.html |    2 +-
 view/frontend/web/template/container/sidebar.html  |    2 +-
 view/frontend/web/template/container/summary.html  |    2 +-
 .../web/template/container/summary/cart-items.html |    2 +-
 .../web/template/container/summary/gift-wrap.html  |    2 +-
 .../template/container/summary/item/details.html   |    6 +-
 237 files changed, 3682 insertions(+), 4914 deletions(-)
~~~
### v2.4.0 to v2.3.6
~~~
 Block/Adminhtml/System/Config/Geoip.php            | 115 ------
 Block/Checkout/CompatibleConfig.php                |  60 ---
 Block/Checkout/LayoutProcessor.php                 |  35 +-
 Block/Design.php                                   |  38 +-
 Block/Order/View/DeliveryTime.php                  |  13 -
 Block/Survey.php                                   |   2 +-
 CHANGELOG                                          |   1 -
 Controller/Add/Index.php                           |   4 +-
 Controller/Adminhtml/System/Config/Geoip.php       | 107 ------
 Controller/Index/Index.php                         |  30 +-
 Helper/Config.php                                  | 104 ++---
 Helper/Data.php                                    | 123 +-----
 LICENSE                                            |   1 -
 Model/DefaultConfigProvider.php                    |  71 +---
 Model/Geoip/Database/Reader.php                    | 148 --------
 Model/Geoip/Maxmind/Db/Reader.php                  | 369 ------------------
 Model/Geoip/Maxmind/Db/Reader/Decoder.php          | 422 ---------------------
 .../Maxmind/Db/Reader/InvalidDatabaseException.php |   9 -
 Model/Geoip/Maxmind/Db/Reader/Metadata.php         |  77 ----
 Model/Geoip/Maxmind/Db/Reader/Util.php             |  35 --
 Model/Geoip/ProviderInterface.php                  |  20 -
 Model/System/Config/Source/CheckboxStyle.php       |  48 ---
 Model/System/Config/Source/Design.php              |  14 +-
 Model/System/Config/Source/RadioStyle.php          |  48 ---
 Observer/CheckoutSubmitBefore.php                  |  43 ++-
 Observer/OscConfigObserver.php                     |  54 +--
 Observer/QuoteSubmitBefore.php                     |   4 -
 Observer/RedirectToOneStepCheckout.php             |   6 +-
 README.md                                          |  52 +--
 Setup/UpgradeData.php                              |   3 -
 USER-GUIDE.md                                      |  80 ----
 composer.json                                      |  26 +-
 etc/adminhtml/system.xml                           | 117 ++----
 etc/config.xml                                     |   8 +-
 etc/module.xml                                     |   2 +-
 i18n/af_ZA.csv                                     |  95 -----
 i18n/ar_SA.csv                                     |  95 -----
 i18n/be_BY.csv                                     |  95 -----
 i18n/ca_ES.csv                                     |  95 -----
 i18n/cs_CZ.csv                                     |  95 -----
 i18n/da_DK.csv                                     |  95 -----
 i18n/de_DE.csv                                     |  95 -----
 i18n/el_GR.csv                                     |  95 -----
 i18n/en_US.csv                                     |  64 +---
 i18n/es_ES.csv                                     |  95 -----
 i18n/fi_FI.csv                                     |  95 -----
 i18n/fr_FR.csv                                     |  95 -----
 i18n/he_IL.csv                                     |  95 -----
 i18n/hu_HU.csv                                     |  95 -----
 i18n/it_IT.csv                                     |  95 -----
 i18n/ja_JP.csv                                     |  95 -----
 i18n/ko_KR.csv                                     |  95 -----
 i18n/nl_NL.csv                                     |  95 -----
 i18n/no_NO.csv                                     |  95 -----
 i18n/pl_PL.csv                                     |  95 -----
 i18n/pt_BR.csv                                     |  95 -----
 i18n/pt_PT.csv                                     |  95 -----
 i18n/ro_RO.csv                                     |  95 -----
 i18n/ru_RU.csv                                     |  95 -----
 i18n/sr_SP.csv                                     |  95 -----
 i18n/sv_SE.csv                                     |  95 -----
 i18n/tr_TR.csv                                     |  95 -----
 i18n/uk_UA.csv                                     |  95 -----
 i18n/vi_VN.csv                                     |  95 -----
 i18n/zh_CN.csv                                     |  95 -----
 i18n/zh_TW.csv                                     |  95 -----
 .../templates/order/view/delivery-time.phtml       |  12 +-
 view/adminhtml/templates/system/config/geoip.phtml |  73 ----
 view/adminhtml/web/css/source/_module.less         |   6 +
 .../layout/onestepcheckout_index_index.xml         |   8 +-
 view/frontend/requirejs-config.js                  |   9 +-
 view/frontend/templates/design.phtml               | 360 +++---------------
 .../templates/onepage/compatible-config.phtml      |  38 --
 .../templates/onepage/success/survey.phtml         |   2 +-
 .../templates/order/view/delivery-time.phtml       |  12 +-
 view/frontend/web/css/style.css                    |  87 +----
 view/frontend/web/js/action/gift-message-item.js   |  67 ----
 .../web/js/model/billing-before-shipping.js        |  33 ++
 view/frontend/web/js/model/braintree-paypal.js     |   8 -
 view/frontend/web/js/model/gift-message.js         |  16 +-
 view/frontend/web/js/model/resource-url-manager.js |   8 -
 .../web/js/model/shipping-rates-validator.js       |  60 ++-
 view/frontend/web/js/view/authentication.js        |  18 +-
 view/frontend/web/js/view/billing-address.js       | 264 ++++++++++++-
 view/frontend/web/js/view/delivery-time.js         |  13 -
 view/frontend/web/js/view/form/element/email.js    |  20 +-
 view/frontend/web/js/view/form/element/region.js   |   4 +-
 view/frontend/web/js/view/geoip.js                 |  71 ----
 .../method-renderer/braintree-paypal-mixins.js     |  27 --
 view/frontend/web/js/view/review/placeOrder.js     | 115 +-----
 view/frontend/web/js/view/shipping-postnl.js       |  55 ---
 view/frontend/web/js/view/shipping.js              |  78 +++-
 view/frontend/web/js/view/summary/item/details.js  | 132 +------
 view/frontend/web/template/1column.html            |  26 +-
 view/frontend/web/template/2columns.html           |  29 +-
 view/frontend/web/template/3columns-colspan.html   |  43 +--
 view/frontend/web/template/3columns.html           |  28 +-
 .../container/address/billing-address.html         |  18 +-
 .../template/container/address/billing/create.html |  22 +-
 .../container/address/shipping-address.html        |  27 +-
 .../web/template/container/authentication.html     |  26 +-
 .../web/template/container/delivery-time.html      |  10 -
 .../web/template/container/form/element/email.html |  23 +-
 .../web/template/container/form/element/input.html |   2 +-
 .../web/template/container/form/field.html         |  67 ----
 view/frontend/web/template/container/payment.html  |  11 -
 .../container/review/addition/gift-message.html    |  59 +--
 .../web/template/container/review/place-order.html |  36 +-
 view/frontend/web/template/container/shipping.html |  26 --
 view/frontend/web/template/container/summary.html  |  35 +-
 .../template/container/summary/item/details.html   |  71 ----
 111 files changed, 797 insertions(+), 6561 deletions(-)
~~~
### v2.3.6 to v2.3.5
~~~
 Block/Checkout/LayoutProcessor.php                 |   8 +-
 Block/Order/Totals.php                             |   2 +-
 Block/Order/View/Survey.php                        |  83 -------
 Block/Survey.php                                   | 105 --------
 Controller/Add/Index.php                           |   3 +-
 Controller/Survey/Save.php                         | 104 --------
 Helper/Config.php                                  |  84 +------
 Model/CheckoutManagement.php                       |  81 +------
 Model/DefaultConfigProvider.php                    |  40 ++--
 Model/System/Config/Source/PaymentMethods.php      |  31 +--
 Model/System/Config/Source/Survey.php              |  50 ----
 Model/Total/Quote/GiftWrap.php                     |   2 +-
 Observer/CheckoutSubmitBefore.php                  |  43 +---
 Observer/QuoteSubmitBefore.php                     |   2 +-
 Observer/RedirectToOneStepCheckout.php             |  74 ------
 Setup/UpgradeData.php                              |   4 -
 composer.json                                      |  12 +-
 etc/adminhtml/system.xml                           |  50 +---
 etc/config.xml                                     |   2 -
 etc/frontend/events.xml                            |   3 -
 etc/module.xml                                     |  17 +-
 i18n/en_US.csv                                     |   3 -
 view/adminhtml/layout/sales_order_view.xml         |   2 -
 view/adminhtml/templates/order/view/survey.phtml   |  39 ---
 view/adminhtml/web/css/source/_module.less         |   6 -
 view/frontend/layout/checkout_onepage_success.xml  |  32 ---
 .../layout/onestepcheckout_index_index.xml         |  14 +-
 view/frontend/layout/sales_order_view.xml          |   2 -
 .../templates/onepage/success/survey.phtml         |  51 ----
 view/frontend/templates/order/view/survey.phtml    |  36 ---
 view/frontend/web/css/style.css                    |  20 +-
 view/frontend/web/js/action/gift-wrap.js           |   7 +-
 .../web/js/model/billing-before-shipping.js        |  33 ---
 .../web/js/model/shipping-rates-validator.js       |  74 +-----
 view/frontend/web/js/view/billing-address.js       | 264 ++-------------------
 view/frontend/web/js/view/delivery-time.js         |  13 +-
 view/frontend/web/js/view/form/element/email.js    |   5 -
 .../web/js/view/review/addition/gift-wrap.js       |   2 +-
 view/frontend/web/js/view/shipping.js              |  76 ++----
 view/frontend/web/js/view/summary/gift-wrap.js     |   7 +-
 view/frontend/web/js/view/survey.js                |  86 -------
 view/frontend/web/template/1column.html            |  10 -
 view/frontend/web/template/2columns.html           |  10 -
 view/frontend/web/template/3columns-colspan.html   |  24 +-
 view/frontend/web/template/3columns.html           |  22 +-
 .../container/address/billing-address.html         |  12 +-
 .../container/address/shipping-address.html        |  21 +-
 .../web/template/container/delivery-time.html      |   3 -
 .../web/template/container/form/element/email.html |   6 +-
 .../web/template/container/review/comment.html     |   2 +-
 50 files changed, 164 insertions(+), 1518 deletions(-)
~~~
### v2.3.5 to v2.3.4
~~~
 Controller/Index/Index.php                         |   3 +-
 Helper/Config.php                                  | 234 +++++++++++----------
 Observer/IsAllowedGuestCheckoutObserver.php        |  55 -----
 composer.json                                      |  12 +-
 etc/adminhtml/system.xml                           |   1 -
 etc/frontend/di.xml                                |   7 -
 etc/frontend/events.xml                            |   2 +-
 etc/frontend/sections.xml                          |  12 --
 .../layout/onestepcheckout_index_index.xml         |   2 -
 view/frontend/requirejs-config.js                  |   9 +-
 view/frontend/web/js/model/agreements-assigner.js  |  39 ----
 view/frontend/web/js/model/osc-loader/discount.js  |  46 ----
 view/frontend/web/js/view/delivery-time.js         |  42 ++--
 view/frontend/web/js/view/payment/discount.js      |   8 +-
 .../web/js/view/review/addition/newsletter.js      |   9 +-
 .../web/template/container/delivery-time.html      |   2 +-
 .../web/template/container/payment/discount.html   |  65 ------
 .../web/template/container/review/discount.html    |   3 +-
 view/frontend/web/template/container/shipping.html |   2 +-
 19 files changed, 167 insertions(+), 386 deletions(-)
~~~
### v2.3.4 to v2.3.3
~~~
 Block/Adminhtml/Field/Position.php                 |  7 -----
 Block/Order/Totals.php                             |  3 ---
 Controller/Index/Index.php                         |  4 ---
 Helper/Config.php                                  |  5 ----
 Helper/Data.php                                    | 24 ++++++-----------
 Model/DefaultConfigProvider.php                    |  5 ----
 Model/Plugin/Checkout/ShippingMethodManagement.php |  5 ----
 Model/System/Config/Source/ComponentPosition.php   |  7 -----
 Model/System/Config/Source/DeliveryTime.php        |  7 -----
 Model/System/Config/Source/Giftwrap.php            |  9 +------
 Model/Total/Quote/GiftWrap.php                     |  7 -----
 Observer/OscConfigObserver.php                     | 30 +++++-----------------
 view/frontend/web/css/style.css                    |  9 -------
 .../web/js/model/shipping-rates-validator.js       | 14 ++++------
 14 files changed, 21 insertions(+), 115 deletions(-)
~~~
### v2.3.3 to v2.3.2
~~~
 Model/CheckoutManagement.php                       |  8 +--
 Model/System/Config/Source/PaymentMethods.php      | 57 +++++++---------------
 Observer/CheckoutSubmitBefore.php                  |  4 +-
 view/adminhtml/templates/order/additional.phtml    |  6 +--
 .../templates/order/view/delivery-time.phtml       |  3 +-
 view/frontend/templates/design.phtml               | 21 +++-----
 .../frontend/web/js/model/shipping-rate-service.js |  9 +++-
 .../web/js/model/shipping-rates-validator.js       |  6 +--
 view/frontend/web/js/view/billing-address.js       |  1 -
 view/frontend/web/template/3columns-colspan.html   |  2 +-
 .../container/address/billing-address.html         |  2 +-
 .../container/address/shipping-address.html        |  2 +-
 12 files changed, 47 insertions(+), 74 deletions(-)
~~~
### v2.3.2 to v2.3.1
~~~
 Helper/Config.php                                  |  23 +--
 Model/DefaultConfigProvider.php                    |   2 +-
 Model/Plugin/Checkout/ShippingMethodManagement.php | 219 ++++++++++-----------
 etc/frontend/events.xml                            |  27 ---
 view/frontend/requirejs-config.js                  |   3 -
 view/frontend/web/css/style.css                    |   6 +-
 view/frontend/web/js/view/billing-address.js       |  35 ++--
 view/frontend/web/js/view/shipping.js              |   2 -
 8 files changed, 129 insertions(+), 188 deletions(-)
~~~
### v2.3.1 to v2.3.0
~~~
~~~
### v2.3.0 to v2.2.0
~~~
 Block/Order/View/DeliveryTime.php                  |  74 -----------
 Controller/Add/Index.php                           |   2 +-
 Helper/Config.php                                  |  50 +------
 Model/CheckoutManagement.php                       |  61 +--------
 Model/DefaultConfigProvider.php                    |  65 +++-------
 Model/System/Config/Source/DeliveryTime.php        |  48 -------
 Model/System/Config/Source/PaymentMethods.php      |  82 ++++++------
 Observer/CheckoutSubmitBefore.php                  |  14 +-
 Observer/OscConfigObserver.php                     |  66 ----------
 Observer/QuoteSubmitBefore.php                     |  86 ++++++------
 Setup/UpgradeData.php                              |   6 -
 etc/adminhtml/events.xml                           |  28 ----
 etc/adminhtml/system.xml                           | 144 ++++++---------------
 etc/module.xml                                     |   2 +-
 view/adminhtml/layout/sales_order_view.xml         |   5 -
 .../templates/order/view/delivery-time.phtml       |  35 -----
 view/adminhtml/web/css/style.css                   |   8 +-
 .../layout/onestepcheckout_index_index.xml         |  17 ---
 view/frontend/layout/sales_order_view.xml          |   2 -
 view/frontend/templates/design.phtml               |   2 +-
 .../templates/order/view/delivery-time.phtml       |  33 -----
 view/frontend/web/css/style.css                    |  31 ++---
 view/frontend/web/js/model/gift-message.js         |  77 -----------
 view/frontend/web/js/model/resource-url-manager.js |   1 +
 .../web/js/model/shipping-rates-validator.js       |   9 +-
 .../js/model/shipping-save-processor/checkout.js   |  15 +--
 view/frontend/web/js/view/authentication.js        |   4 -
 view/frontend/web/js/view/delivery-time.js         |  69 ----------
 .../web/js/view/review/addition/gift-message.js    | 105 ---------------
 .../web/template/container/delivery-time.html      |  30 -----
 .../container/review/addition/gift-message.html    |  52 --------
 31 files changed, 160 insertions(+), 1063 deletions(-)
~~~
### v2.2.0 to v2.1.0
~~~
~~~
### v2.1.0 to v2.0.1
~~~
 Api/CheckoutManagementInterface.php                |   9 -
 Api/GuestCheckoutManagementInterface.php           |  11 +-
 Block/Adminhtml/Field/Position.php                 | 122 ---
 Block/Checkout/LayoutProcessor.php                 | 568 ++++++-------
 Block/{Design.php => Generator/Css.php}            |   6 +-
 Block/Order/Totals.php                             |  46 --
 Controller/Add/Index.php                           |   1 -
 Controller/Adminhtml/Field/Position.php            |  67 --
 Controller/Adminhtml/Field/Save.php                |  89 --
 Controller/Index/Index.php                         | 150 ++--
 Helper/Config.php                                  | 905 ++++++++-------------
 Helper/Data.php                                    | 336 ++++++--
 Model/CheckoutManagement.php                       | 387 +++++----
 Model/DefaultConfigProvider.php                    | 257 +++---
 Model/GuestCheckoutManagement.php                  |  13 -
 Model/Plugin/Customer/Address.php                  |  48 --
 Model/Plugin/Quote/GiftWrap.php                    |  80 --
 .../{Checkout => }/ShippingMethodManagement.php    |   4 +-
 .../{AddressSuggest.php => Address/Suggest.php}    |   4 +-
 Model/System/Config/Source/ComponentPosition.php   |  37 -
 Model/System/Config/Source/Enableddisabled.php     |  65 ++
 Model/System/Config/Source/Giftwrap.php            |  35 -
 .../{PaymentMethods.php => Payment/Methods.php}    |  21 +-
 .../{ShippingMethods.php => Shipping/Methods.php}  |   4 +-
 Model/Total/Creditmemo/GiftWrap.php                |  86 --
 Model/Total/Invoice/GiftWrap.php                   |  73 --
 Model/Total/Quote/GiftWrap.php                     | 159 ----
 Observer/CheckoutSubmitBefore.php                  |  41 +-
 Observer/QuoteSubmitBefore.php                     |  77 +-
 Setup/InstallData.php                              |  63 --
 Setup/InstallSchema.php                            |  51 ++
 Setup/UpgradeData.php                              |  90 --
 etc/adminhtml/menu.xml                             |  24 +-
 etc/adminhtml/system.xml                           |  46 +-
 etc/config.xml                                     |   8 +-
 etc/di.xml                                         |   8 -
 etc/events.xml                                     |   6 +-
 etc/extension_attributes.xml                       |  29 -
 .../gift-wrap.html => etc/frontend/page_types.xml  |  14 +-
 etc/module.xml                                     |   3 +-
 etc/sales.xml                                      |  39 -
 etc/webapi.xml                                     |  18 +-
 etc/webapi_rest/di.xml                             |   2 +-
 .../layout/onestepcheckout_field_position.xml      |  33 -
 .../layout/sales_order_creditmemo_new.xml          |  30 -
 .../layout/sales_order_creditmemo_updateqty.xml    |  30 -
 .../layout/sales_order_creditmemo_view.xml         |  30 -
 .../adminhtml/layout/sales_order_invoice_email.xml |  30 -
 view/adminhtml/layout/sales_order_invoice_new.xml  |  30 -
 .../adminhtml/layout/sales_order_invoice_print.xml |  30 -
 .../layout/sales_order_invoice_updateqty.xml       |  30 -
 view/adminhtml/layout/sales_order_invoice_view.xml |  30 -
 view/adminhtml/layout/sales_order_view.xml         |  12 +-
 view/adminhtml/templates/field/position.phtml      | 172 ----
 view/adminhtml/web/css/images/billing_title.png    | Bin 3193 -> 0 bytes
 view/adminhtml/web/css/images/next.png             | Bin 327 -> 0 bytes
 .../web/css/images/ui-icons_222222_256x240.png     | Bin 6922 -> 0 bytes
 view/adminhtml/web/css/jquery-ui.min.css           |   7 -
 view/adminhtml/web/css/style.css                   | 145 ----
 .../layout/onestepcheckout_index_index.xml         | 227 +++---
 .../layout/sales_email_order_creditmemo_items.xml  |  28 -
 .../layout/sales_email_order_invoice_items.xml     |  29 -
 view/frontend/layout/sales_email_order_items.xml   |  14 -
 view/frontend/layout/sales_order_creditmemo.xml    |  29 -
 view/frontend/layout/sales_order_invoice.xml       |  28 -
 view/frontend/layout/sales_order_print.xml         |  29 -
 .../layout/sales_order_printcreditmemo.xml         |  29 -
 view/frontend/layout/sales_order_printinvoice.xml  |  29 -
 view/frontend/layout/sales_order_view.xml          |  12 +-
 .../templates/{ => generator/css}/design.phtml     |  14 +-
 view/frontend/web/css/style.css                    |  39 +-
 view/frontend/web/js/action/gift-wrap.js           |  63 --
 view/frontend/web/js/action/update-item.js         |   2 +
 .../frontend/web/js/model/address/auto-complete.js |   2 +-
 view/frontend/web/js/model/agreement-validator.js  |   2 +-
 view/frontend/web/js/model/gift-wrap.js            |  17 -
 view/frontend/web/js/model/resource-url-manager.js |   8 -
 .../web/js/model/shipping-rates-validator.js       |  90 +-
 .../js/model/shipping-save-processor/checkout.js   |  25 +-
 view/frontend/web/js/view/authentication.js        | 109 ---
 view/frontend/web/js/view/billing-address.js       | 106 +--
 view/frontend/web/js/view/payment/discount.js      |  37 -
 .../web/js/view/review/addition/gift-wrap.js       |  77 --
 view/frontend/web/js/view/review/placeOrder.js     |   1 -
 view/frontend/web/js/view/shipping.js              |  59 +-
 view/frontend/web/js/view/summary/gift-wrap.js     |  55 --
 view/frontend/web/js/view/summary/item/details.js  |  18 +-
 view/frontend/web/template/1column.html            |  49 +-
 view/frontend/web/template/2columns.html           |  39 +-
 view/frontend/web/template/3columns-colspan.html   |  44 +-
 view/frontend/web/template/3columns.html           |  43 +-
 .../container/address/billing-address.html         |  18 +-
 .../template/container/address/billing/create.html |  52 +-
 .../container/address/shipping-address.html        |  18 +-
 .../template/container/address/shipping/form.html  |   8 +
 .../web/template/container/authentication.html     | 124 +--
 view/frontend/web/template/container/payment.html  |   2 +-
 .../web/template/container/payment/discount.html   |  64 ++
 .../container/review/addition/gift-wrap.html       |  32 -
 .../web/template/container/review/comment.html     |   2 +-
 .../web/template/container/review/discount.html    |  60 --
 .../web/template/container/review/place-order.html |   8 +-
 view/frontend/web/template/container/sidebar.html  |   4 +-
 view/frontend/web/template/container/summary.html  |   7 -
 104 files changed, 1960 insertions(+), 4503 deletions(-)
~~~
### v2.0.1 to v2.0.0
~~~
 Api/CheckoutManagementInterface.php                |  19 -
 Api/Data/OscDetailsInterface.php                   | 103 ++--
 Api/GuestCheckoutManagementInterface.php           |  19 -
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |  38 +-
 Block/Checkout/LayoutProcessor.php                 | 538 ++++++++--------
 Block/Container.php                                |  45 +-
 Block/Generator/Css.php                            |  92 ++-
 Block/Order/View/Comment.php                       |  86 ++-
 Block/Plugin/Link.php                              |  59 +-
 Controller/Add/Index.php                           |  51 +-
 Controller/Index/Index.php                         | 141 ++---
 Helper/Config.php                                  | 675 ++++++++++-----------
 Helper/Data.php                                    | 467 +++++++-------
 Model/CheckoutManagement.php                       | 366 ++++++-----
 Model/DefaultConfigProvider.php                    | 278 ++++-----
 Model/GuestCheckoutManagement.php                  | 149 ++---
 Model/OscDetails.php                               | 135 ++---
 Model/Plugin/ShippingMethodManagement.php          | 191 +++---
 Model/System/Config/Source/Address/Suggest.php     |  49 +-
 .../Config/Source/Address/Suggest/Fields.php       |  48 ++
 Model/System/Config/Source/Address/Trigger.php     |  51 ++
 Model/System/Config/Source/Color.php               |  44 ++
 Model/System/Config/Source/Design.php              |  50 +-
 Model/System/Config/Source/Enableddisabled.php     |   8 +-
 Model/System/Config/Source/Heading.php             |  37 ++
 Model/System/Config/Source/Layout.php              |   8 +-
 Model/System/Config/Source/Payment/Methods.php     |  13 +-
 Model/System/Config/Source/Shipping/Methods.php    |  11 +-
 Observer/CheckoutSubmitBefore.php                  |  50 +-
 Observer/QuoteSubmitBefore.php                     |  77 +--
 Observer/QuoteSubmitSuccess.php                    | 287 ++++-----
 Setup/InstallSchema.php                            |  32 +-
 etc/acl.xml                                        |  22 -
 etc/adminhtml/di.xml                               |  21 -
 etc/adminhtml/routes.xml                           |  23 +-
 etc/adminhtml/system.xml                           |  21 -
 etc/config.xml                                     |  23 +-
 etc/di.xml                                         |  19 +-
 etc/events.xml                                     |  19 +-
 etc/frontend/di.xml                                |  21 -
 etc/frontend/page_types.xml                        |  19 +-
 etc/frontend/routes.xml                            |  21 -
 etc/frontend/sections.xml                          |  19 +-
 etc/module.xml                                     |  21 -
 etc/webapi.xml                                     |  21 -
 etc/webapi_rest/di.xml                             |  21 -
 registration.php                                   |  19 -
 view/adminhtml/layout/sales_order_view.xml         |  19 +-
 view/adminhtml/templates/order/additional.phtml    |  19 +-
 view/adminhtml/templates/order/view/comment.phtml  |  19 +-
 view/adminhtml/web/css/source/_module.less         |   6 +
 .../layout/onestepcheckout_index_index.xml         |  11 +-
 view/frontend/layout/sales_order_view.xml          |  19 +-
 view/frontend/requirejs-config.js                  |  19 +-
 view/frontend/templates/description.phtml          |  21 -
 view/frontend/templates/generator/css/design.phtml |   2 +-
 view/frontend/templates/order/additional.phtml     |  19 +-
 view/frontend/templates/order/view/comment.phtml   |  22 -
 view/frontend/web/css/style.css                    | 150 +++--
 .../web/js/action/payment-total-information.js     |  24 +-
 .../web/js/action/set-checkout-information.js      |  21 +-
 view/frontend/web/js/action/update-item.js         |  25 +-
 .../frontend/web/js/model/address/auto-complete.js |   1 -
 view/frontend/web/js/model/address/type/google.js  |  10 +-
 view/frontend/web/js/model/agreement-validator.js  |  26 +-
 .../web/js/model/checkout-data-resolver.js         |  25 +-
 view/frontend/web/js/model/osc-data.js             |  25 +-
 view/frontend/web/js/model/osc-loader.js           |  27 +-
 view/frontend/web/js/model/payment-service.js      |  20 +-
 view/frontend/web/js/model/resource-url-manager.js |  30 +-
 .../frontend/web/js/model/shipping-rate-service.js |  22 +-
 .../web/js/model/shipping-rates-validator.js       |  63 +-
 .../js/model/shipping-save-processor/checkout.js   |  48 +-
 view/frontend/web/js/view/billing-address.js       |  62 +-
 view/frontend/web/js/view/form/element/email.js    |  31 +-
 view/frontend/web/js/view/form/element/region.js   |  19 +-
 view/frontend/web/js/view/form/element/street.js   |  23 +-
 view/frontend/web/js/view/payment.js               |  38 +-
 view/frontend/web/js/view/review/addition.js       |  21 +-
 .../web/js/view/review/addition/newsletter.js      |  21 +-
 .../web/js/view/review/checkout-agreements.js      |  20 +-
 view/frontend/web/js/view/review/comment.js        |  21 +-
 view/frontend/web/js/view/review/placeOrder.js     |  41 +-
 .../shipping-address/address-renderer/default.js   |  27 +-
 view/frontend/web/js/view/shipping.js              |  85 +--
 view/frontend/web/js/view/summary/item/details.js  |  45 +-
 view/frontend/web/template/1column.html            |  22 -
 view/frontend/web/template/2columns.html           |  22 -
 view/frontend/web/template/3columns-colspan.html   |  22 -
 view/frontend/web/template/3columns.html           |  22 -
 .../container/address/billing-address.html         |  20 +-
 .../container/address/billing/checkbox.html        |  20 +-
 .../template/container/address/billing/create.html |  22 +-
 .../container/address/shipping-address.html        |  22 -
 .../address/shipping/address-renderer/default.html |  20 +-
 .../template/container/address/shipping/form.html  |  20 +-
 .../web/template/container/authentication.html     |  20 +-
 .../web/template/container/form/element/email.html |  20 +-
 .../web/template/container/form/element/input.html |  20 +-
 .../template/container/form/element/street.html    |  20 +-
 view/frontend/web/template/container/payment.html  |  30 +-
 .../web/template/container/payment/discount.html   |  20 +-
 .../web/template/container/review/addition.html    |  20 +-
 .../container/review/addition/newsletter.html      |  20 +-
 .../web/template/container/review/comment.html     |  20 +-
 .../web/template/container/review/place-order.html |  20 +-
 view/frontend/web/template/container/shipping.html |  20 +-
 view/frontend/web/template/container/sidebar.html  |  19 +-
 view/frontend/web/template/container/summary.html  |  21 +-
 .../web/template/container/summary/cart-items.html |  20 +-
 .../template/container/summary/item/details.html   |  25 +-
 111 files changed, 2350 insertions(+), 3851 deletions(-)
~~~
### v2.0.0 to v1.3.0
~~~
 Api/CheckoutManagementInterface.php                |   42 -
 Api/Data/OscDetailsInterface.php                   |   70 -
 Api/GuestCheckoutManagementInterface.php           |   42 -
 Block/Adminhtml/Plugin/OrderViewTabInfo.php        |   16 -
 Block/Adminhtml/Sales/Invoice/View/Extra.php       |   38 +
 Block/Adminhtml/Sales/Order/View/Extra.php         |   41 +
 Block/Adminhtml/Sales/SalesAbstract.php            |   68 +
 .../System/Config/Form/Field/Notification.php      |   54 +
 .../System/Config/Form/Field/Term/Html.php         |  115 +
 Block/Adminhtml/Totals/Creditmemo/Giftwrap.php     |   49 +
 Block/Adminhtml/Totals/Invoice/Giftwrap.php        |   48 +
 Block/Adminhtml/Totals/Order/Giftwrap.php          |   48 +
 Block/Checkout/LayoutProcessor.php                 |  350 +-
 Block/Container.php                                |  212 +-
 Block/Container/Address.php                        |  332 ++
 Block/Container/Address/Billing.php                |   50 +
 Block/Container/Address/Billing/Attributes.php     |   28 +
 Block/Container/Address/Pca.php                    |   44 +
 Block/Container/Address/Shipping.php               |   36 +
 Block/Container/Address/Shipping/Attributes.php    |   28 +
 Block/Container/Auth/Form.php                      |   60 +
 Block/Container/Auth/Form/Popup.php                |   45 +
 Block/Container/Form.php                           |   83 +
 Block/Container/Payment/Method.php                 |   35 +
 Block/Container/Payment/Method/Available.php       |  170 +
 Block/Container/Review.php                         |   37 +
 Block/Container/Review/Comment.php                 |   55 +
 Block/Container/Review/Coupon.php                  |   59 +
 Block/Container/Review/Giftmessage.php             |   74 +
 Block/Container/Review/Giftwrap.php                |   57 +
 Block/Container/Review/Item.php                    |   95 +
 Block/Container/Review/Item/Price/Renderer.php     |   27 +
 Block/Container/Review/Newsletter.php              |   49 +
 Block/Container/Review/PlaceOrder.php              |   32 +
 Block/Container/Review/Term.php                    |  130 +
 Block/Container/Shipping/Method.php                |   66 +
 Block/Container/Shipping/Method/Available.php      |   65 +
 Block/Context.php                                  |  203 +
 Block/Generator/Css.php                            |   68 +-
 Block/Order/View/Comment.php                       |   71 -
 Block/Plugin/Checkout/AbstractCheckout.php         |   51 +
 Block/Plugin/Checkout/Cart/Sidebar.php             |   37 +
 Block/Plugin/Checkout/Onepage/Link.php             |   37 +
 Block/Plugin/Link.php                              |   49 -
 Block/Totals/Creditmemo/Giftwrap.php               |   49 +
 Block/Totals/Invoice/Giftwrap.php                  |   49 +
 Block/Totals/Order/Giftwrap.php                    |   50 +
 Controller/Add/Index.php                           |   24 -
 Controller/Ajax/AbstractCheckout.php               |  326 ++
 Controller/Ajax/AddGiftWrap.php                    |   24 +
 Controller/Ajax/AjaxCartItem.php                   |  131 +
 Controller/Ajax/ForgotPassword.php                 |   59 +
 Controller/Ajax/Login.php                          |   54 +
 Controller/Ajax/SaveAddressTrigger.php             |   78 +
 Controller/Ajax/SaveAddressTriggerShipping.php     |    7 +
 Controller/Ajax/SaveCoupon.php                     |   77 +
 Controller/Ajax/SaveForm.php                       |   23 +
 Controller/Ajax/SaveGiftMessage.php                |   29 +
 Controller/Ajax/SaveOrder.php                      |  231 +
 Controller/Ajax/SavePayment.php                    |   47 +
 Controller/Ajax/SaveShippingMethod.php             |   44 +
 Controller/Index/AbstractIndex.php                 |  105 +
 Controller/Index/AddProduct.php                    |   46 +
 Controller/Index/Index.php                         |  149 +-
 Helper/Block.php                                   |  231 +
 Helper/Checkout/Address.php                        |  125 +
 Helper/Checkout/Payment.php                        |  149 +
 Helper/Checkout/Review/Giftmessage.php             |   93 +
 Helper/Checkout/Review/Giftwrap.php                |  132 +
 Helper/Checkout/Shipping.php                       |  135 +
 Helper/Config.php                                  |  897 ++--
 Helper/Data.php                                    |  481 +-
 Model/Attribute.php                                |  142 +
 Model/CheckoutManagement.php                       |  189 -
 Model/DefaultConfigProvider.php                    |  150 -
 Model/GuestCheckoutManagement.php                  |   83 -
 Model/OscDetails.php                               |   78 -
 Model/Plugin/ShippingMethodManagement.php          |  132 -
 Model/Status.php                                   |   74 +
 Model/System/Config/Source/Address/Suggest.php     |   41 +-
 Model/System/Config/Source/Display/Block.php       |   58 +
 Model/System/Config/Source/Effect.php              |   40 +
 Model/System/Config/Source/Giftmessage.php         |   61 +
 .../Config/Source/{Design.php => Giftwrap.php}     |   38 +-
 Model/System/Config/Source/Heading/Icon.php        |   36 +
 Model/System/Config/Source/Layout.php              |   36 +-
 Model/System/Config/Source/Payment/Methods.php     |   18 +-
 Model/System/Config/Source/Shipping/Methods.php    |   11 +-
 Model/Total/Creditmemo/Giftwrap.php                |   91 +
 Model/Total/Invoice/Giftwrap.php                   |   70 +
 Model/Total/Pdf/Giftwrap.php                       |   74 +
 Model/Total/Quote/Giftwrap.php                     |  125 +
 Observer/CheckoutSubmitBefore.php                  |  117 -
 Observer/GiftMessage.php                           |   60 +
 Observer/OrderPlaceAfter.php                       |   91 +
 Observer/QuoteSubmitBefore.php                     |   42 -
 Observer/QuoteSubmitSuccess.php                    |  146 -
 Setup/InstallSchema.php                            |   71 +-
 etc/adminhtml/di.xml                               |    6 -
 etc/adminhtml/events.xml                           |    7 +
 etc/adminhtml/menu.xml                             |    8 +-
 etc/adminhtml/routes.xml                           |    2 +-
 etc/adminhtml/system.xml                           |  158 +-
 etc/config.xml                                     |   82 +-
 etc/di.xml                                         |   11 -
 etc/events.xml                                     |   18 -
 etc/fieldset.xml                                   |   21 +
 etc/frontend/di.xml                                |   29 +-
 etc/frontend/events.xml                            |    6 +
 etc/frontend/page_types.xml                        |   10 -
 etc/frontend/routes.xml                            |   10 +-
 etc/frontend/sections.xml                          |   26 -
 etc/module.xml                                     |    4 +-
 etc/pdf.xml                                        |   13 +
 etc/sales.xml                                      |   14 +
 etc/webapi.xml                                     |   67 -
 etc/webapi_rest/di.xml                             |    7 -
 etc/webapi_rest/events.xml                         |    6 +
 i18n/en_US.csv                                     |  291 +-
 view/adminhtml/layout/default.xml                  |    6 +
 .../layout/sales_order_creditmemo_new.xml          |    8 +
 .../layout/sales_order_creditmemo_updateqty.xml    |    8 +
 .../layout/sales_order_creditmemo_view.xml         |    8 +
 .../adminhtml/layout/sales_order_invoice_email.xml |    8 +
 view/adminhtml/layout/sales_order_invoice_new.xml  |    8 +
 .../adminhtml/layout/sales_order_invoice_print.xml |    8 +
 .../layout/sales_order_invoice_updateqty.xml       |    8 +
 view/adminhtml/layout/sales_order_invoice_view.xml |   13 +
 view/adminhtml/layout/sales_order_view.xml         |   20 +-
 view/adminhtml/templates/order/additional.phtml    |   19 -
 view/adminhtml/templates/order/view/comment.phtml  |   19 -
 .../templates/sales/invoice/view/extra.phtml       |    4 +
 .../templates/sales/order/view/extra.phtml         |    4 +
 view/adminhtml/web/js/jscolor.min.js               |   10 +
 .../layout/onestepcheckout_ajax_update.xml         |   93 +
 .../layout/onestepcheckout_index_index.xml         |  367 +-
 .../frontend/layout/onestepcheckout_one_column.xml |   41 +
 view/frontend/layout/onestepcheckout_payment.xml   |  184 +
 .../layout/sales_email_order_creditmemo_items.xml  |   28 +
 .../layout/sales_email_order_invoice_items.xml     |   28 +
 view/frontend/layout/sales_email_order_items.xml   |   33 +
 view/frontend/layout/sales_order_creditmemo.xml    |   28 +
 view/frontend/layout/sales_order_invoice.xml       |   28 +
 view/frontend/layout/sales_order_print.xml         |   28 +
 .../layout/sales_order_printcreditmemo.xml         |   28 +
 view/frontend/layout/sales_order_printinvoice.xml  |   28 +
 view/frontend/layout/sales_order_view.xml          |   34 +-
 view/frontend/requirejs-config.js                  |   47 +-
 view/frontend/templates/checkout-1column.phtml     |  119 +
 .../templates/checkout-1column/bottom.phtml        |   54 +
 .../templates/checkout-1column/middle.phtml        |   54 +
 view/frontend/templates/checkout-1column/top.phtml |   54 +
 view/frontend/templates/checkout-2columns.phtml    |  117 +
 view/frontend/templates/checkout-3columns.phtml    |  125 +
 .../frontend/templates/checkout-3columns.phtml_bak |  111 +
 view/frontend/templates/container/address.phtml    |  128 +
 .../templates/container/address/billing.phtml      |   71 +
 .../container/address/billing/attributes.phtml     |  429 ++
 .../address/customer/widget/firstname.phtml        |  113 +
 .../address/customer/widget/lastname.phtml         |  127 +
 .../container/address/customer/widget/name.phtml   |  170 +
 .../frontend/templates/container/address/pca.phtml |  126 +
 .../templates/container/address/shipping.phtml     |   55 +
 .../container/address/shipping/attributes.phtml    |  270 ++
 view/frontend/templates/container/auth/form.phtml  |   46 +
 .../templates/container/auth/form/popup.phtml      |  129 +
 view/frontend/templates/container/form.phtml       |   65 +
 .../templates/container/payment/method.phtml       |   66 +
 .../container/payment/method/available.phtml       |   83 +
 view/frontend/templates/container/review.phtml     |   90 +
 .../container/review/addition/giftmessage.phtml    |   47 +
 .../review/addition/giftmessage/inline.phtml       |   64 +
 .../container/review/addition/giftwrap.phtml       |   45 +
 .../container/review/addition/newsletter.phtml     |   40 +
 .../templates/container/review/comment.phtml       |   47 +
 .../templates/container/review/coupon.phtml        |   75 +
 .../frontend/templates/container/review/item.phtml |   70 +
 .../container/review/item/renderer/default.phtml   |  106 +
 .../review/item/renderer/downloadable.phtml        |  106 +
 .../review/item/renderer/price/row_excl_tax.phtml  |   29 +
 .../review/item/renderer/price/row_incl_tax.phtml  |   30 +
 .../review/item/renderer/price/unit_excl_tax.phtml |   32 +
 .../review/item/renderer/price/unit_incl_tax.phtml |   32 +
 .../templates/container/review/order.phtml         |   52 +
 .../templates/container/review/survey.phtml        |   46 +
 .../frontend/templates/container/review/term.phtml |  105 +
 .../templates/container/review/totals.phtml        |   50 +
 .../templates/container/shipping/method.phtml      |   44 +
 .../container/shipping/method/available.phtml      |   86 +
 view/frontend/templates/description.phtml          |    3 -
 view/frontend/templates/generator/css/design.phtml |  201 +-
 view/frontend/templates/order/additional.phtml     |   19 -
 view/frontend/templates/order/email.phtml          |   55 +
 view/frontend/templates/order/print.phtml          |  105 +
 view/frontend/templates/order/view.phtml           |   51 +
 view/frontend/templates/order/view/comment.phtml   |   10 -
 view/frontend/web/css/style.css                    |  147 -
 .../default/font-awesome/css/font-awesome.css      | 1672 +++++++
 .../default/font-awesome/css/font-awesome.min.css  |    4 +
 .../default/font-awesome/fonts/FontAwesome.otf     |  Bin 0 -> 85908 bytes
 .../font-awesome/fonts/fontawesome-webfont.eot     |  Bin 0 -> 56006 bytes
 .../font-awesome/fonts/fontawesome-webfont.svg     |  520 +++
 .../font-awesome/fonts/fontawesome-webfont.ttf     |  Bin 0 -> 112160 bytes
 .../font-awesome/fonts/fontawesome-webfont.woff    |  Bin 0 -> 65452 bytes
 .../web/css/themes/default/grid-mageplaza.css      |  278 ++
 .../web/css/themes/default/images/ajax-loader.gif  |  Bin 0 -> 723 bytes
 .../themes/default/images/authen-ajax-loader.gif   |  Bin 0 -> 7823 bytes
 .../css/themes/default/images/billing-title.png    |  Bin 0 -> 1462 bytes
 .../review => themes/default/images}/btn-minus.png |  Bin
 .../review => themes/default/images}/btn-plus.png  |  Bin
 .../default/images}/btn-remove.png                 |  Bin
 .../css/themes/default/images/btn_window_close.gif |  Bin 0 -> 226 bytes
 .../themes/default/images/button-background.png    |  Bin 0 -> 135 bytes
 .../web/css/themes/default/images/calendar.png     |  Bin 0 -> 2205 bytes
 .../css/themes/default/images/column-separator.png |  Bin 0 -> 3599 bytes
 .../themes/default/images/forgot-pass-title.png    |  Bin 0 -> 520 bytes
 .../themes/default/images/google-location-icon.png |  Bin 0 -> 1152 bytes
 .../css/themes/default/images/location-title.png   |  Bin 0 -> 436 bytes
 .../web/css/themes/default/images/login-title.png  |  Bin 0 -> 472 bytes
 .../web/css/themes/default/images/method-title.png |  Bin 0 -> 1369 bytes
 .../css/themes/default/images/notice-loader.gif    |  Bin 0 -> 673 bytes
 .../css/themes/default/images/payment-title.png    |  Bin 0 -> 1306 bytes
 .../web/css/themes/default/images/review-title.png |  Bin 0 -> 1712 bytes
 .../css/themes/default/images/shadow-onstep.png    |  Bin 0 -> 5696 bytes
 .../web/css/themes/default/images/term-title.png   |  Bin 0 -> 3309 bytes
 .../themes/default/images/validation_advice_bg.gif |  Bin 0 -> 134 bytes
 .../web/css/themes/default/magnific-popup.css      |  623 +++
 .../web/css/themes/default/owl.carousel.css        |  154 +
 .../web/css/themes/default/owl.transitions.css     |  163 +
 .../web/css/themes/default/pca/address-3.40.css    |  490 ++
 .../css/themes/default/pca/address-3.40.min.css    |   11 +
 view/frontend/web/css/themes/default/style.css     | 1111 +++++
 .../web/js/action/get-payment-information.js       |   54 +
 .../web/js/action/payment-total-information.js     |   57 -
 view/frontend/web/js/action/place-order.js         |   67 +
 .../web/js/action/set-checkout-information.js      |   20 -
 view/frontend/web/js/action/update-item.js         |   68 -
 .../web/js/jquery/carousel/owl.carousel.js         | 1517 +++++++
 view/frontend/web/js/jquery/pca/address-3.40.js    | 4656 ++++++++++++++++++++
 .../frontend/web/js/jquery/pca/address-3.40.min.js |  258 ++
 .../js/jquery/popup/jquery.magnific-popup.min.js   |    4 +
 view/frontend/web/js/modal/modal.js                |   29 +
 .../frontend/web/js/model/address/auto-complete.js |   47 -
 view/frontend/web/js/model/address/type/google.js  |  207 -
 view/frontend/web/js/model/agreement-validator.js  |   49 -
 .../web/js/model/checkout-data-resolver.js         |   38 -
 view/frontend/web/js/model/full-screen-loader.js   |   31 +
 view/frontend/web/js/model/osc-data.js             |   41 -
 view/frontend/web/js/model/osc-loader.js           |   75 -
 view/frontend/web/js/model/payment-service.js      |   16 -
 .../web/js/model/payment/button-checkout-list.js   |   42 +
 view/frontend/web/js/model/payment/loader.js       |   48 +
 view/frontend/web/js/model/resource-url-manager.js |   49 -
 .../frontend/web/js/model/shipping-rate-service.js |   42 -
 .../web/js/model/shipping-rates-validator.js       |  172 -
 .../js/model/shipping-save-processor/checkout.js   |   73 -
 view/frontend/web/js/osc.js                        |  369 ++
 view/frontend/web/js/osc/address.js                |  495 +++
 .../web/js/osc/address/google-auto-complete.js     |  171 +
 view/frontend/web/js/osc/address/region-updater.js |  213 +
 view/frontend/web/js/osc/auth.js                   |  152 +
 view/frontend/web/js/osc/form.js                   |  209 +
 view/frontend/web/js/osc/payment/method.js         |  253 ++
 view/frontend/web/js/osc/popup.js                  |   54 +
 view/frontend/web/js/osc/review/cart.js            |  115 +
 view/frontend/web/js/osc/review/comment.js         |  138 +
 view/frontend/web/js/osc/review/coupon.js          |  128 +
 view/frontend/web/js/osc/review/giftmessage.js     |  108 +
 view/frontend/web/js/osc/review/giftwrap.js        |   47 +
 view/frontend/web/js/osc/review/newsletter.js      |   44 +
 view/frontend/web/js/osc/review/term.js            |   99 +
 view/frontend/web/js/osc/shipping/method.js        |   60 +
 view/frontend/web/js/view/billing-address.js       |  213 -
 view/frontend/web/js/view/form/element/email.js    |  111 -
 view/frontend/web/js/view/form/element/region.js   |   36 -
 view/frontend/web/js/view/form/element/street.js   |   46 -
 view/frontend/web/js/view/payment.js               |   74 +-
 view/frontend/web/js/view/payment/authorizenet.js  |   26 +
 .../web/js/view/payment/braintree-methods.js       |   28 +
 view/frontend/web/js/view/payment/cc-form.js       |  191 +
 .../frontend/web/js/view/payment/connect-method.js |   68 +
 view/frontend/web/js/view/payment/default.js       |  197 +
 view/frontend/web/js/view/payment/iframe.js        |   45 +
 view/frontend/web/js/view/payment/list.js          |  126 +
 .../method-renderer/authorizenet-directpost.js     |   80 +
 .../payment/method-renderer/banktransfer-method.js |   26 +
 .../payment/method-renderer/braintree-paypal.js    |  109 +
 .../method-renderer/cashondelivery-method.js       |   24 +
 .../web/js/view/payment/method-renderer/cc-form.js |  486 ++
 .../view/payment/method-renderer/checkmo-method.js |   30 +
 .../js/view/payment/method-renderer/free-method.js |   23 +
 .../view/payment/method-renderer/iframe-methods.js |   83 +
 .../payment/method-renderer/payflow-express-bml.js |   20 +
 .../payment/method-renderer/payflow-express.js     |   20 +
 .../payment/method-renderer/payflowpro-method.js   |   71 +
 .../method-renderer/paypal-billing-agreement.js    |   46 +
 .../method-renderer/paypal-express-abstract.js     |   93 +
 .../payment/method-renderer/paypal-express-bml.js  |   20 +
 .../view/payment/method-renderer/paypal-express.js |   20 +
 .../method-renderer/purchaseorder-method.js        |   39 +
 .../web/js/view/payment/offline-payments.js        |   38 +
 view/frontend/web/js/view/payment/payments.js      |   26 +
 .../web/js/view/payment/paypal-payments.js         |   56 +
 view/frontend/web/js/view/review/addition.js       |   20 -
 .../web/js/view/review/addition/newsletter.js      |   40 -
 .../web/js/view/review/checkout-agreements.js      |   17 -
 view/frontend/web/js/view/review/comment.js        |   35 -
 view/frontend/web/js/view/review/placeOrder.js     |   47 -
 .../shipping-address/address-renderer/default.js   |   26 -
 view/frontend/web/js/view/shipping.js              |  134 -
 view/frontend/web/js/view/summary/item/details.js  |  114 -
 .../images/homepage-three-column-promo-01.png      |  Bin 0 -> 4623 bytes
 .../images/homepage-three-column-promo-01B.png     |  Bin 0 -> 4841 bytes
 .../images/homepage-three-column-promo-02.png      |  Bin 0 -> 4848 bytes
 .../images/homepage-three-column-promo-03.png      |  Bin 0 -> 4496 bytes
 view/frontend/web/template/1column.html            |   47 -
 view/frontend/web/template/2columns.html           |   54 -
 view/frontend/web/template/3columns-colspan.html   |   49 -
 view/frontend/web/template/3columns.html           |   50 -
 .../container/address/billing-address.html         |   23 -
 .../container/address/billing/checkbox.html        |   10 -
 .../template/container/address/billing/create.html |   42 -
 .../container/address/shipping-address.html        |   54 -
 .../address/shipping/address-renderer/default.html |   21 -
 .../template/container/address/shipping/form.html  |   35 -
 .../web/template/container/authentication.html     |   87 -
 .../web/template/container/form/element/email.html |   71 -
 .../web/template/container/form/element/input.html |   16 -
 .../template/container/form/element/street.html    |   18 -
 .../web/template/container/payment/discount.html   |   48 -
 .../web/template/container/review/addition.html    |   14 -
 .../container/review/addition/newsletter.html      |   10 -
 .../web/template/container/review/comment.html     |   14 -
 .../web/template/container/review/place-order.html |   24 -
 view/frontend/web/template/container/shipping.html |  113 -
 view/frontend/web/template/container/sidebar.html  |   33 -
 view/frontend/web/template/container/summary.html  |   15 -
 .../web/template/container/summary/cart-items.html |   37 -
 .../template/container/summary/item/details.html   |   59 -
 .../web/template/{container => }/payment.html      |   29 +-
 .../template/payment/authorizenet-directpost.html  |   73 +
 .../web/template/payment/banktransfer.html         |   49 +
 .../template/payment/braintree-paypal-form.html    |   52 +
 .../web/template/payment/braintree/cc-form.html    |  238 +
 .../web/template/payment/cashondelivery.html       |   50 +
 view/frontend/web/template/payment/cc-form.html    |  189 +
 view/frontend/web/template/payment/checkmo.html    |   62 +
 .../payment/express/billing-agreement.html         |   21 +
 view/frontend/web/template/payment/free.html       |   45 +
 .../web/template/payment/iframe-methods.html       |   57 +
 view/frontend/web/template/payment/iframe.html     |   47 +
 .../web/template/payment/payflow-express-bml.html  |   53 +
 .../web/template/payment/payflow-express.html      |   49 +
 .../web/template/payment/payflowpro-form.html      |   73 +
 .../web/template/payment/paypal-express-bml.html   |   53 +
 .../web/template/payment/paypal-express.html       |   50 +
 .../payment/paypal_billing_agreement-form.html     |   60 +
 .../web/template/payment/paypal_direct-form.html   |   10 +
 .../web/template/payment/purchaseorder-form.html   |   71 +
 359 files changed, 30094 insertions(+), 5952 deletions(-)
~~~
### v1.3.0 to v1.2.9
~~~
 Block/Container/Address.php                        |  3 +--
 Block/Container/Form.php                           |  2 +-
 Controller/Ajax/AbstractCheckout.php               | 13 +++----------
 view/frontend/web/js/osc/address/region-updater.js |  4 ++--
 4 files changed, 7 insertions(+), 15 deletions(-)
~~~
