{literal}
<script type="text/javascript">
CRM.$(function($) {
  $('input[name="price_9"]').css('display', 'none');

  $('input[name="price_9"]+label').addClass('button-block');

  // Other checkbox
  $("label[for='price_10']").text('');
  // "None" price field.
  $("label[for='CIVICRM_QFID_0_12']").text('Other');
});
</script>
{/literal}