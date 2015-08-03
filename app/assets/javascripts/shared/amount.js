(function($) {
  'use strict';

  $(function() {
    if ($.fn.autoNumeric == undefined) { return; }

    var amount = $('.total_amount > span');

    amount.autoNumeric('init', {
      aSign:  '¥ '
    , pSign:  'p'
    , vMin:   '-100000000'
    , vMax:   '100000000'
    , wEmpty: 'zero'
    , lZero:  'deny'
    });
  });
})(jQuery);