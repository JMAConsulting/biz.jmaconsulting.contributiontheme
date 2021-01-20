<div id="gift_type">{$form.gift_type.html}</div>
<div id="donation_type">{$form.donation_type.html}</div>

{literal}
<script type="text/javascript">
CRM.$(function($) {
  var onetimeprice = "price_436";
  var monthlyprice = "price_437";
  var otherprice = "price_438";
  var onetimenone = $('input[name=price_436][value=0]');
  var monthlynone = $('input[name=price_437][value=0]');

  $('input[name="' + onetimeprice + '"]').css('display', 'none');
  $('input[name="' + monthlyprice + '"]').css('display', 'none');

  $('input[name="' + onetimeprice + '"]+label').addClass('button-block');
  $('input[name="' + monthlyprice + '"]+label').addClass('button-block');

  $('.monthly-section').hide();
  $('.monthly-section > .label').hide();
  $('.one_time-section').hide();
  $('.one_time-section > .label').hide();
  $('#' + otherprice).hide();

  var gifttype = $('input[name=gift_type]:checked').val();
  hideShow(gifttype);

  // Gift Type
  $('input[name="gift_type"]').css('display', 'none');
  $('input[name="gift_type"]+label').addClass('button-block');
  $('#gift_type').insertBefore($('#priceset-div'));

  // Donation Type
  $('input[name="donation_type"]').css('display', 'none');
  $('input[name="donation_type"]+label').addClass('button-block');
  $('#donation_type').insertBefore($('#onBehalfOfOrg'));

  // In Honour of
  $('input[name="soft_credit_type_id"]').css('display', 'none');
  $('input[name="soft_credit_type_id"]+label').addClass('button-block');
  $('.soft_credit_type_id-section').find('div.description').hide();

  $('input[name="soft_credit_type_id"]').change(function() {
    hideShowGift(this.checked);
  });

  // Other checkbox
  $("label[for='" + otherprice + "']").text('');
  
  // Clear other textbox when radio is selected.
  $('#priceset input:radio').click(function() {
    $('#' + otherprice).val('');
    $('#' + otherprice).trigger('keyup');
  });

  // Clear radio if other text is entered.
  $('#' + otherprice).click(function () {
    if ($('input[name=gift_type]:checked').val() == 'monthly') {
      $(monthlynone).prop("selected", true).trigger("click");
    }
    else {
      $(onetimenone).prop("selected", true).trigger("click");
    }
  });

  // "None" price field.
  $(onetimenone).next('label').text('Other');
  $(monthlynone).next('label').text('Other');

  $('input[name="gift_type"]').change(function() {
    hideShow($(this).val());
  });

  $('input[name="donation_type"]').change(function() {
    hideShowOrg($(this).val());
  });
  
  $('#' + otherprice).click(function() {
    if (gifttype == "monthly") {
      $(monthlynone).parent().addClass('highlight');
      $(onetimenone).parent().removeClass('highlight');
    }
    else {
      $(onetimenone).parent().addClass('highlight');
      $(monthlynone).parent().removeClass('highlight');
    }
  });

  function hideShowOrg(type) {
    if (type == 'organization') {
      $("#is_for_organization").prop('checked', false);
      $("#is_for_organization").trigger('click');
    }
    else {
      $("#is_for_organization").prop('checked', true);
      $("#is_for_organization").trigger('click');
    }
  }

  function hideShow(type) {
    if (type == 'monthly') {
      $('.monthly-section').show();
      $('#' + otherprice).show();
      $('.one_time-section').hide();
      $('#is_recur').prop('checked', true);
      $('#' + otherprice).appendTo($(monthlynone).parent());

      // Check the none textbox
      $(onetimenone).prop('checked', true);
      $(onetimenone).trigger('click');
      $('input[name="' + onetimeprice + '"]').parent().removeClass('highlight');
      $(onetimenone).parent().removeClass('highlight');
      $('#' + otherprice).val('');
      $('#' + otherprice).trigger('keyup');
    }
    else {
      $('.one_time-section').show();
      $('#' + otherprice).show();
      $('.monthly-section').hide();
      $('#is_recur').prop('checked', false);
      $('#' + otherprice).appendTo($(onetimenone).parent());

      // Check the none textbox
      $(monthlynone).prop('checked', true);
      $(monthlynone).trigger('click');
      $('input[name="' + monthlyprice + '"]').parent().removeClass('highlight');
      $(monthlynone).parent().removeClass('highlight');
      $('#' + otherprice).val('');
      $('#' + otherprice).trigger('keyup');
    }
  }

  updateContainer();
  $(window).resize(function() {
    updateContainer();
  });

  function updateContainer() {
    var $containerWidth = $(window).width();
    if ($containerWidth <= 902) {
        if (!($(".price-set-option-content").parent().hasClass("price-set-rows"))) {
          $(".price-set-option-content").wrap( "<div class='price-set-rows'></div>" );

          // Add two column layout
          
          $("#donation_type label, #gift_type label, .soft_credit_type_id-section label").each(function (i) {
            $(this).wrap("<div class='price-set-rows'></div>");
          });

          
        }
    }
    if ($containerWidth > 902) {
      if ($(".price-set-option-content").parent().hasClass("price-set-rows")) {
        $('.price-set-option-content').unwrap();
        $("#donation_type label, #gift_type label, .soft_credit_type_id-section label").each(function (i) {
          $(this).unwrap();
        });
      }
    }
  }
  
});
</script>
{/literal}
