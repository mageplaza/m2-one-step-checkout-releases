# Mageplaza One Step Checkout is compatible with Themecafe_CashOnDelivery

Hi,

I'm Sam from Mageplaza. We have a shared customer which using [Mageplaza One Step Checkout](https://www.mageplaza.com/magento-2-one-step-checkout-extension/) and your module Themecafe_CashOnDelivery.

We would like to make it compatible with your module.

After investigating, we figure out the solution that:
Update file: `Themecafe\CashOnDelivery\view\frontend\web\js\view\payment\method-renderer\cashondelivery.js:59`
Add content:

~~~ js

this._super();

~~~

See this screenshot

![osc](https://i.imgur.com/ZWc3v9N.png)

After changing this, it will be compatible with Mageplaza One Step Checkout and other One Step Checkout also.


Regards,

Sam
