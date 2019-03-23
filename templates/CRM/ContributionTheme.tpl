<div id="gift_type">{$form.gift_type.html}</div>
<div id="donation_type">{$form.donation_type.html}</div>
<div id="chapter_code_section" class="crm-section">
  <div class="label">{$form.chapter_code.label}</div>
  <div class="content">{$form.chapter_code.html}</div>
</div>


{literal}
<script type="text/javascript">
CRM.$(function($) {
  var onetimeprice = "price_172";
  var monthlyprice = "price_173";
  var otherprice = "price_174";
  var onetimenone = $('input[name=price_172][value=0]');
  var monthlynone = $('input[name=price_173][value=0]');
  var fgifttype = "custom_13";

  $('input[name="' + onetimeprice + '"]').css('display', 'none');
  $('input[name="' + monthlyprice + '"]').css('display', 'none');

  $('input[name="' + onetimeprice + '"]+label').addClass('button-block');
  $('input[name="' + monthlyprice + '"]+label').addClass('button-block');

  $('.amount_monthly-section').hide();
  $('.amount_one_time-section').hide();
  $('#' + otherprice).hide();

  var gifttype = $('input[name=gift_type]:checked').val();
  hideShow(gifttype);

  // Chapter Code
  $('#chapter_code_section').insertAfter($('#editrow-' + fgifttype));
  // Select based on financial gift type
  if ($('#' + fgifttype).val() == "Chapter") {
    $('#chapter_code_section').show();
  }
  else {
    $('#chapter_code').select2('val', 0);
    $('#chapter_code_section').hide();
  }
  $('#' + fgifttype).change(function() {
    if ($(this).val() == "Chapter") {
      $('#chapter_code_section').fadeIn();
    }
    else {
      $('#chapter_code').select2('val', 0);
      $('#chapter_code_section').fadeOut();
    }
  });

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

  // Other checkbox
  $("label[for='" + otherprice + "']").text('');
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
      $('.amount_monthly-section').show();
      $('#' + otherprice).show();
      $('.amount_one_time-section').hide();
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
      $('.amount_one_time-section').show();
      $('#' + otherprice).show();
      $('.amount_monthly-section').hide();
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
  
});
</script>
{/literal}
