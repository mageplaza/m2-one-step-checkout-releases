Hi The WeltPixel team,

I'm Jacker from Mageplaza. We have a shared customer which using Mageplaza One Step Checkout and your module WeltPixel_GoogleTagManager.

We would like to make it compatible with your module.

After investigating, we figure out the solution that:
Update file: `WeltPixel/GoogleTagManager/Helper/Data.php` at line 282 and 393

Add content:

With line 282

  `case 'checkout_index_index' || 'onestepcheckout_index_index' `

see 

![osc](https://i.imgur.com/NwvuUd0.png)

line 393

 `if ($requestPath == 'checkout/index/index' || $requestPath =='onestepcheckout/index/index') {`

see

![osc](https://i.imgur.com/Ahxl0VO.png)

After changing this, it will be compatible with Mageplaza One Step Checkout.
